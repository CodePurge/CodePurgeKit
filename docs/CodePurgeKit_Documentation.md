
# CodePurgeKit Documentation

## Overview

`CodePurgeKit` is a shared module within the app, **CodePurge**, and resides in the **CodePurgeApp** organization on GitHub. It includes shared models, logic, views, and view modifiers to provide essential functionality for managing Xcode-related files. 

## Modules/Components

### 1. **Core Logic**
   - **`PurgableItem`**
     - Protocol defining the properties of an item that can be purged, including:
       ```swift
       var id: String { get }
       var name: String { get }
       var size: Int64 { get }
       var url: URL? { get }
       ```
   - **`PurgableItemDataSource`**
     - Manages the state of purgable items (e.g., selected items, total sizes).
     - Publishes updates via `@Published` properties for easy SwiftUI integration.
       ```swift
       let dataSource = PurgableItemDataSource<MyPurgableItem>()
       dataSource.selectedItems // Access selected items.
       ```

   - **`BasePurgeObservableObject`**
     - Provides an observable layer to bind the backend logic to SwiftUI views.

### 2. **UI Components**

#### **ScanStartCategoryListView**
A view that displays a list of categories and allows users to select items to scan.

```swift
ScanStartCategoryListView(
    options: categories,
    selections: selectedCategories,
    toggleScanCategory: { category in 
        // Handle toggle logic
    },
    startScan: {
        // Start the scan process
    }
)
```

#### **ScanResultView**
Displays the results of a scan, including the total size of files found and their details.

```swift
ScanResultView(
    selectedCategory: $selectedCategory,
    scannedCategories: scannedCategories,
    startOver: {
        // Restart logic
    }
) { category in
    // Custom content for each category
}
```

#### **Modifiers**
- **`withCheckboxSelection`**
  - Adds a checkbox to a row view for selection functionality, with styling dependent on `purgeIsLive`.
    ```swift
    Text("Item Name")
        .withCheckboxSelection(
            isSelected: true,
            toggle: {
                // Handle toggle logic
            }
        )
    ```

## Environment Keys

### `purgeIsLive`
- Indicates whether the app is in "live" mode or a "practice" mode.
- Affects colors and behavior in views like `ScanStartCategoryListView` and `ScanResultView`.

## Getting Started

### 1. **Installation**
Add the package to your Xcode project using Swift Package Manager.

1. Go to **File > Add Packages** in Xcode.
2. Enter the package repository URL.
3. Choose the desired version or branch and add the package to your project.

### 2. **Basic Usage**
#### Define Your Items
Conform your data models to the `PurgableItem` protocol:
```swift
struct MyPurgableItem: PurgableItem {
    let id: String
    let name: String
    let size: Int64
    let url: URL?
    let type: PurgableItemType
}
```

#### Initialize the Data Source
```swift
let dataSource = PurgableItemDataSource<MyPurgableItem>()
```

#### Create a View
```swift
ScanStartCategoryListView(
    options: categories,
    selections: selectedCategories,
    toggleScanCategory: { category in
        // Handle toggle
    },
    startScan: {
        // Start the scan
    }
)
```

## Customization

### Extend `PurgableItem`
Add custom properties or behavior to your purgable items:
```swift
extension MyPurgableItem {
    var customDetail: String {
        return "Details for \(name)"
    }
}
```

### Modify UI Components
Customize views by providing custom content in closures like `ScanResultView`:
```swift
ScanResultView(
    selectedCategory: $selectedCategory,
    scannedCategories: scannedCategories,
    startOver: { /* restart logic */ }
) { category in
    VStack {
        Text(category.name)
        Text("\(category.size.toStorageSize) purgable")
    }
}
```

## Utilities

### `Int64.toStorageSize`
Converts a size in bytes to a human-readable string:
```swift
let size: Int64 = 10240
print(size.toStorageSize) // Output: "10 KB"
```

### `Array.calculateTotalSize`
Calculates the total size of an array of `Int64` values:
```swift
let sizes: [Int64] = [1024, 2048, 4096]
print(sizes.calculateTotalSize()) // Output: 7168
```

---

This documentation provides a detailed explanation of the package, covering its components, usage, and customization options. Let me know if you’d like any additions or revisions!
