//
//  PurgableItemDataSourceTests.swift
//
//
//  Created by Nikolai Nobadi on 1/3/25.
//

import XCTest
import Combine
import NnTestHelpers
@testable import DevCodePurgeKit

final class PurgableItemDataSourceTests: XCTestCase {
    private var cancellables = Set<AnyCancellable>()
    
    override func tearDown() {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
        super.tearDown()
    }
}


// MARK: - Unit Tests
extension PurgableItemDataSourceTests {
    func test_starting_values_are_empty() {
        let sut = makeSUT()
        
        XCTAssert(sut.list.isEmpty)
        XCTAssert(sut.selectedItems.isEmpty)
        XCTAssertEqual(sut.totalSize, 0)
        XCTAssertEqual(sut.selectedSize, 0)
    }
    
    func test_size_of_list_is_updated_when_list_changes() {
        let firstItem = makeItem()
        let sut = makeSUT(list: [firstItem])
        
        waitForCondition(publisher: sut.$totalSize, cancellables: &cancellables, condition: { $0 == firstItem.size })
        
        let secondItem = makeItem(id: "1")
        let totalSize = firstItem.size + secondItem.size
        
        sut.list.append(secondItem)
        
        waitForCondition(publisher: sut.$totalSize, cancellables: &cancellables, condition: { $0 == totalSize })
        
        sut.list = []
        
        waitForCondition(publisher: sut.$totalSize, cancellables: &cancellables, condition: { $0 == 0 })
    }
    
    func test_size_of_selected_items_is_updated_when_selected_items_change() {
        let firstItem = makeItem()
        let sut = makeSUT(selectedItems: [firstItem])
        
        waitForCondition(publisher: sut.$selectedSize, cancellables: &cancellables, condition: { $0 == firstItem.size })
        
        let secondItem = makeItem(id: "1")
        let totalSize = firstItem.size + secondItem.size
        
        sut.selectedItems.insert(secondItem)
        
        waitForCondition(publisher: sut.$selectedSize, cancellables: &cancellables, condition: { $0 == totalSize })
        
        sut.selectedItems = []
        
        waitForCondition(publisher: sut.$selectedSize, cancellables: &cancellables, condition: { $0 == 0 })
    }
    
    func test_item_is_selected_when_it_is_in_selected_items() {
        let item = makeItem()
        let sut = makeSUT(selectedItems: [item])
        
        XCTAssertTrue(sut.isSelected(item))
    }

    func test_item_is_not_selected_when_missing_from_selected_items() {
        let item = makeItem()
        let sut = makeSUT()
        
        XCTAssertFalse(sut.isSelected(item))
    }

    func test_unselected_items_are_selected_after_selecting() {
        let item = makeItem()
        let sut = makeSUT()
        
        sut.selectItem(item)
        
        XCTAssertTrue(sut.isSelected(item))
    }

    func test_selected_items_remain_selected_after_selecting() {
        let item = makeItem()
        let sut = makeSUT(selectedItems: [item])
        
        sut.selectItem(item)
        
        XCTAssertTrue(sut.isSelected(item))
    }

    func test_selected_items_are_unselected_after_unselecting() {
        let item = makeItem()
        let sut = makeSUT(selectedItems: [item])
        
        sut.unselectItem(item)
        
        XCTAssertFalse(sut.isSelected(item))
    }

    func test_unselected_items_remain_unselected_after_unselecting() {
        let item = makeItem()
        let sut = makeSUT()
        
        sut.unselectItem(item)
        
        XCTAssertFalse(sut.isSelected(item))
    }

    func test_selected_items_are_unselected_after_toggling() {
        let item = makeItem()
        let sut = makeSUT(selectedItems: [item])
        
        sut.toggleItem(item)
        
        XCTAssertFalse(sut.isSelected(item))
    }

    func test_unselected_items_are_selected_after_toggling() {
        let item = makeItem()
        let sut = makeSUT()
        
        sut.toggleItem(item)
        
        XCTAssertTrue(sut.isSelected(item))
    }

    func test_item_is_removed_from_all_lists() {
        let itemId = "0"
        let item = makeItem(id: itemId)
        let sut = makeSUT(list: [item], selectedItems: [item])
        
        sut.removeSingleItemFromAllLists(itemId: itemId)
        
        XCTAssertFalse(sut.list.contains(item))
        XCTAssertFalse(sut.selectedItems.contains(item))
    }
    
    func test_all_unselected_items_become_selected_when_toggling_all_items() {
        let item1 = makeItem(id: "1")
        let item2 = makeItem(id: "2")
        let sut = makeSUT(list: [item1, item2])

        sut.toggleAllItems([item1, item2])

        XCTAssert(sut.isSelected(item1))
        XCTAssert(sut.isSelected(item2))
    }

    func test_all_selected_items_become_unselected_when_toggling_all_items() {
        let item1 = makeItem(id: "1")
        let item2 = makeItem(id: "2")
        let sut = makeSUT(list: [item1, item2], selectedItems: [item1, item2])

        sut.toggleAllItems([item1, item2])

        XCTAssertFalse(sut.isSelected(item1))
        XCTAssertFalse(sut.isSelected(item2))
    }
    
    func test_selected_items_remain_selected_if_still_in_list_after_update() {
        let item1 = makeItem(id: "1")
        let item2 = makeItem(id: "2")
        let item3 = makeItem(id: "3")
        let sut = makeSUT(list: [item1, item2, item3], selectedItems: [item2])

        sut.list = [item1, item2]

        XCTAssertTrue(sut.isSelected(item2))
    }
    
    func test_no_items_are_selected_or_unselected_when_toggling_empty_list() {
        let sut = makeSUT()

        sut.toggleAllItems([])

        XCTAssertTrue(sut.selectedItems.isEmpty)
    }
}


// MARK: - SUT
extension PurgableItemDataSourceTests {
    func makeSUT(list: [MockItem] = [], selectedItems: Set<MockItem> = []) -> PurgableItemDataSource<MockItem> {
        return .init(list: list, selectedItems: selectedItems)
    }
}
