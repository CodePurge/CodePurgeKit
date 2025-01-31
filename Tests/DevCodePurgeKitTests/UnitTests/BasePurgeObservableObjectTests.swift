//
//  BasePurgeObservableObjectTests.swift
//
//
//  Created by Nikolai Nobadi on 1/3/25.
//

import XCTest
import Combine
import NnTestHelpers
@testable import DevCodePurgeKit

final class BasePurgeObservableObjectTests: XCTestCase {
    private var cancellables = Set<AnyCancellable>()
    
    override func tearDown() {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
        super.tearDown()
    }
}


// MARK: - Starting Values Tests
extension BasePurgeObservableObjectTests {
    func test_starting_values_are_empty() {
        let (sut, _) = makeSUT()
        
        XCTAssertEqual(sut.totalSize, 0)
        XCTAssertEqual(sut.selectedSize, 0)
        XCTAssertEqual(sut.selectedItemCount, 0)
    }
}


// MARK: - Integration Tests
extension BasePurgeObservableObjectTests {
    func test_totalSize_updates_when_datasource_totalSize_changes() {
        let item = makeItem()
        let (sut, datasource) = makeSUT()
        
        datasource.list.append(item)
        waitForCondition(publisher: sut.$totalSize, cancellables: &cancellables, condition: { $0 == item.size })
    }
    
    func test_selectedSize_updates_when_datasource_selectedSize_changes() {
        let item = makeItem()
        let (sut, datasource) = makeSUT()
        
        datasource.selectItem(item)
        waitForCondition(publisher: sut.$selectedSize, cancellables: &cancellables, condition: { $0 == item.size })
    }
    
    func test_selectedItemCount_updates_when_selectedItems_change() {
        let firstItem = makeItem()
        let (sut, datasource) = makeSUT()
        
        datasource.selectItem(firstItem)
        waitForCondition(publisher: sut.$selectedItemCount, cancellables: &cancellables, condition: { $0 == 1 })
        
        let secondItem = makeItem(id: "2")
        
        datasource.selectItem(secondItem)
        waitForCondition(publisher: sut.$selectedItemCount, cancellables: &cancellables, condition: { $0 == 2 })
        
        datasource.unselectItem(firstItem)
        waitForCondition(publisher: sut.$selectedItemCount, cancellables: &cancellables, condition: { $0 == 1 })
    }
    
    func test_item_is_selected_when_in_datasource_selectedItems() {
        let item = makeItem()
        let (sut, datasource) = makeSUT()
        datasource.selectItem(item)
        
        XCTAssertTrue(sut.isSelected(item))
    }
    
    func test_item_is_not_selected_when_not_in_datasource_selectedItems() {
        let item = makeItem()
        let (sut, _) = makeSUT()
        
        XCTAssertFalse(sut.isSelected(item))
    }
    
    func test_item_is_selected_and_unselected_when_toggled() {
        let item = makeItem()
        let (sut, datasource) = makeSUT()
        
        sut.toggleItem(item)
        XCTAssertTrue(datasource.isSelected(item))
        
        sut.toggleItem(item)
        XCTAssertFalse(datasource.isSelected(item))
    }
    
    func test_all_items_are_selected_and_unselected_when_toggled() {
        let (sut, datasource) = makeSUT()
        let firstItem = makeItem(id: "1")
        let secondItem = makeItem(id: "2")
        let items = [firstItem, secondItem]
        
        sut.toggleAllItems(items)
        XCTAssertTrue(datasource.isSelected(firstItem))
        XCTAssertTrue(datasource.isSelected(secondItem))
        
        sut.toggleAllItems(items)
        XCTAssertFalse(datasource.isSelected(firstItem))
        XCTAssertFalse(datasource.isSelected(secondItem))
    }
}


// MARK: - SUT
extension BasePurgeObservableObjectTests {
    func makeSUT(file: StaticString = #filePath, line: UInt = #line) -> (sut: BasePurgeObservableObject<MockItem>, datasource: PurgableItemDataSource<MockItem>) {
        let datasource = makeDatasource()
        let sut = BasePurgeObservableObject(datasource: datasource)
        
        trackForMemoryLeaks(sut, file: file, line: line)
        trackForMemoryLeaks(datasource, file: file, line: line)
        
        return (sut, datasource)
    }
    
    func makeDatasource() -> PurgableItemDataSource<MockItem> {
        return .init()
    }
}
