#if swift(>=5.7) && (canImport(RegexBuilder) || !os(macOS) && !targetEnvironment(macCatalyst))
  //===----------------------------------------------------------------------===//
  //
  // This source file is part of the Swift Async Algorithms open source project
  //
  // Copyright (c) 2022 Apple Inc. and the Swift project authors
  // Licensed under Apache License v2.0 with Runtime Library Exception
  //
  // See https://swift.org/LICENSE.txt for license information
  //
  //===----------------------------------------------------------------------===//

  /// An `AsyncSequence` that produces elements at regular intervals.
  ///
  /// Internal use only. Not meant to be used outside the library.
  @available(macOS 13.0, iOS 16.0, watchOS 9.0, tvOS 16.0, *)
  public struct _AsyncTimerSequence<C: Clock>: AsyncSequence {
    public typealias Element = C.Instant

    /// The iterator for an `AsyncTimerSequence` instance.
    public struct Iterator: AsyncIteratorProtocol {
      var clock: C?
      let interval: C.Instant.Duration
      let tolerance: C.Instant.Duration?
      var last: C.Instant?

      init(interval: C.Instant.Duration, tolerance: C.Instant.Duration?, clock: C) {
        self.clock = clock
        self.interval = interval
        self.tolerance = tolerance
      }

      func nextDeadline(_ clock: C) -> C.Instant {
        let now = clock.now
        let last = self.last ?? now
        let next = last.advanced(by: interval)
        if next < now {
          return last.advanced(
            by: interval * Int(((next.duration(to: now)) / interval).rounded(.up)))
        } else {
          return next
        }
      }

      public mutating func next() async -> C.Instant? {
        guard let clock = clock else {
          return nil
        }
        let next = nextDeadline(clock)
        do {
          try await clock.sleep(until: next, tolerance: tolerance)
        } catch {
          self.clock = nil
          return nil
        }
        let now = clock.now
        last = next
        return now
      }
    }

    let clock: C
    let interval: C.Instant.Duration
    let tolerance: C.Instant.Duration?

    /// Create an `AsyncTimerSequence` with a given repeating interval.
    init(interval: C.Instant.Duration, tolerance: C.Instant.Duration? = nil, clock: C) {
      self.clock = clock
      self.interval = interval
      self.tolerance = tolerance
    }

    public func makeAsyncIterator() -> Iterator {
      Iterator(interval: interval, tolerance: tolerance, clock: clock)
    }
  }

  @available(macOS 13.0, iOS 16.0, watchOS 9.0, tvOS 16.0, *)
  extension _AsyncTimerSequence: Sendable {}

  @available(macOS 13.0, iOS 16.0, watchOS 9.0, tvOS 16.0, *)
  extension _AsyncTimerSequence.Iterator: Sendable {}
#endif
