#!/bin/bash -x

# Create the upstream directory
mkdir -p ./upstream

# Function to add git subtree for each dependency
add_git_subtree() {
    local url=$1
    local package_name=$2
    local version=$3

    echo "Adding $package_name from $url"
    git subtree add --prefix=upstream/$package_name $url $version --squash
}

# List of dependencies as URL, package name, and version
declare -a dependencies=(
    "https://github.com/apple/swift-collections swift-collections 1.0.2"
    "https://github.com/apple/swift-docc-plugin swift-docc-plugin 1.0.0"
    "https://github.com/apple/swift-docc-symbolkit swift-docc-symbolkit 1.0.0"
    "https://github.com/google/swift-benchmark swift-benchmark 0.1.0"
    "https://github.com/pointfreeco/combine-schedulers combine-schedulers 1.0.0"
    "https://github.com/pointfreeco/swift-case-paths swift-case-paths 1.1.0"
    "https://github.com/pointfreeco/swift-concurrency-extras swift-concurrency-extras 1.1.0"
    "https://github.com/pointfreeco/swift-custom-dump swift-custom-dump 1.0.0"
    "https://github.com/pointfreeco/swift-dependencies swift-dependencies 1.0.0"
    "https://github.com/pointfreeco/swift-identified-collections swift-identified-collections 1.0.0"
    "https://github.com/pointfreeco/swiftui-navigation swiftui-navigation 1.1.0"
    "https://github.com/pointfreeco/xctest-dynamic-overlay xctest-dynamic-overlay 1.0.0"
    "https://github.com/pointfreeco/swift-clocks swift-clocks 1.0.0"
)

# Process each dependency
for dep in "${dependencies[@]}"; do
    read -r url package_name version <<<"$dep"
    add_git_subtree "$url" "$package_name" "$version"
done

echo "All dependencies added successfully!"
