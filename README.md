
# CodePurgeKit

![Swift](https://img.shields.io/badge/Swift-5.7-blue)
![Platform](https://img.shields.io/badge/Platform-macOS%2013.0-lightgrey)
![License](https://img.shields.io/badge/License-MIT-green)
<!-- ![Version](https://img.shields.io/github/v/release/CodePurge/CodePurgeKit?refresh=true) -->

**CodePurgeKit** is a shared module within the [CodePurge](https://github.com/CodePurge) project. It contains shared data models, utilities, and view components used throughout the CodePurge app. While the main CodePurge app is private, this package is open-source and provides the foundation for managing and organizing purgable items efficiently.

Although **CodePurgeKit** is primarily intended as part of the larger CodePurge app, its lack of dependencies makes it adaptable for use in other projects. A comprehensive documentation file is included to provide developers with detailed guidance and examples.

## Features

- **Shared Data Models**: Protocols and classes for managing purgable items with flexibility and type safety.
- **Observable State Management**: Combine-powered observable objects to track changes in item states and trigger UI updates.
- **Reusable SwiftUI Components**: Prebuilt views and modifiers for interactive interfaces.
- **Utilities**: Handy extensions for formatting, calculations, and size management.
- **Environment Keys**: Custom keys for additional functionality, such as `purgeIsLive`.
- **Comprehensive Documentation**: A detailed `.md` file explains components, usage, and customization options.

## Installation

### Swift Package Manager

To use **CodePurgeKit** in your project, add it to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/CodePurge/CodePurgeKit", branch: "main")
]
```

Then, import it wherever needed:

```swift
import CodePurgeKit
```

## Components

### Data Models
- **`PurgableItem`**: Protocol defining the structure of items that can be purged.
- **`PurgeCategoryDetailInfo`**: Provides detailed information about purgable categories, including tips and guidance.
- **`ScannableCategory`**: Protocol for categories that can be scanned, including their metadata and details.

### Observable Objects
- **`BasePurgeObservableObject`**: Tracks total size, selected size, and item counts with live updates using Combine.
- **`PurgableItemDataSource`**: Manages lists of items and their selection states, publishing changes in real-time.

### UI Components
- **SwiftUI Views**:
  - `ScanStartCategoryListView`: Displays a list of categories and allows selection for scanning.
  - `ScanResultView`: Displays the results of a scan, including scanned categories and their details.
  - `ListItemSectionView`: Represents a list section with its name, size, and selection status.
  - `ListItemSectionCheckbox`: Adds a checkbox reflecting the selection state of a section.
  - `ShortFormattedDateLabel`: Displays a formatted date label with optional metadata.

- **View Modifiers**:
  - `PurgeContentViewModifier`: Manages a button view to present `PurgeContentView`, which triggers purges.
  - `CheckBoxRowViewModifier`: Adds a checkbox for selecting or toggling items in a row, also dependent on the `purgeIsLive` key.
  - `SelectionDetailFooterViewModifer`: Shows detailed footers with selection counts and sizes.
  - `RoundedListViewModifier`: Adds rounded styling to list views.

### Utilities
- **Extensions**:
  - `Int64+Extensions`: Human-readable storage size formatting.
  - `Array+Extensions`: Summation utilities for arrays of sizes.
  - `LinearGradient+Extensions`: Custom gradients for UI elements.

### Environment Keys
- **`purgeIsLive`**: Determines whether the app is in "live" mode or "practice" mode. This key affects the appearance of various UI elements, such as colors and labels.

## Documentation

For more detailed information about the components, usage examples, and customization options, refer to the [comprehensive documentation file](docs/CodePurgeKit_Documentation.md) included in this package.

## Getting Started

1. **Add the Package**: Follow the installation instructions above to integrate `CodePurgeKit` into your project.
2. **Implement Your Models**: Conform your models to protocols like `PurgableItem` and `ScannableCategory`.
3. **Use the Components**: Utilize the views and modifiers to build your interface.

### Example
```swift
ScanStartCategoryListView(
    options: categories,
    selections: selectedCategories,
    toggleScanCategory: { category in
        // Handle toggle
    },
    startScan: {
        // Start scanning logic
    }
)
```

## Contributing
Any feedback or ideas to enhance CodePurgeKit would be well received. Please feel free to [open an issue](https://github.com/CodePurge/CodePurgeKit/issues/new) if you'd like to help improve this Swift package.

## About
This package is part of the [CodePurge](https://github.com/CodePurge) organization, providing tools to streamline project management and storage optimization for Xcode developers.
