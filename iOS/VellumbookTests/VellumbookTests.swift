import XCTest
@testable import Vellumbook

@MainActor
final class VellumbookTests: XCTestCase {
    var store: Store!

    override func setUp() {
        super.setUp()
        store = Store()
    }

    func testSeedDataBelowFreeLimit() {
        XCTAssertLessThan(store.items.count, Store.freeLimit)
    }

    func testAddIncreasesCount() {
        let before = store.items.count
        store.add(Binding(title: "Test Entry"))
        XCTAssertEqual(store.items.count, before + 1)
    }

    func testDeleteDecreasesCount() {
        store.add(Binding(title: "To Delete"))
        let before = store.items.count
        store.delete(store.items[0])
        XCTAssertEqual(store.items.count, before - 1)
    }

    func testCanAddMoreWhenUnderLimit() {
        store.items = []
        XCTAssertTrue(store.canAddMore)
    }

    func testCannotAddMoreWhenAtLimitAndNotPro() {
        store.isPro = false
        store.items = (0..<Store.freeLimit).map { _ in Binding(title: "x") }
        XCTAssertFalse(store.canAddMore)
    }

    func testCanAddMoreWhenProEvenAtLimit() {
        store.isPro = true
        store.items = (0..<Store.freeLimit).map { _ in Binding(title: "x") }
        XCTAssertTrue(store.canAddMore)
    }

    func testUpdateModifiesItem() {
        store.add(Binding(title: "Original"))
        var item = store.items[0]
        item.title = "Updated"
        store.update(item)
        XCTAssertEqual(store.items[0].title, "Updated")
    }

    func testPersistenceRoundTrip() {
        store.add(Binding(title: "Persisted"))
        store.save()
        let reloaded = Store()
        XCTAssertTrue(reloaded.items.contains { $0.title == "Persisted" })
    }
}
