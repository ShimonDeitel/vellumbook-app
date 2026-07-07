import Foundation
import Combine

@MainActor
final class Store: ObservableObject {
    @Published var items: [Binding] = []
    @Published var isPro: Bool = false

    static let freeLimit = 12

    private let fileURL: URL = {
        let dir = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)[0]
        try? FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true)
        return dir.appendingPathComponent("vellumbook_items.json")
    }()

    init() {
        load()
        if items.isEmpty {
            items = [
            Binding(title: "Book title 1", signatureCount: 10, paperStock: "Paper stock 1", coverMaterial: "Cover material 1", bindingStyle: "Binding style 1"),
            Binding(title: "Book title 2", signatureCount: 13, paperStock: "Paper stock 2", coverMaterial: "Cover material 2", bindingStyle: "Binding style 2"),
            Binding(title: "Book title 3", signatureCount: 16, paperStock: "Paper stock 3", coverMaterial: "Cover material 3", bindingStyle: "Binding style 3")
            ]
            save()
        }
    }

    var canAddMore: Bool {
        isPro || items.count < Store.freeLimit
    }

    func add(_ item: Binding) {
        items.insert(item, at: 0)
        save()
    }

    func update(_ item: Binding) {
        guard let idx = items.firstIndex(where: { $0.id == item.id }) else { return }
        items[idx] = item
        save()
    }

    func delete(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
        save()
    }

    func delete(_ item: Binding) {
        items.removeAll { $0.id == item.id }
        save()
    }

    func load() {
        guard let data = try? Data(contentsOf: fileURL) else { return }
        if let decoded = try? JSONDecoder().decode([Binding].self, from: data) {
            items = decoded
        }
    }

    func save() {
        guard let data = try? JSONEncoder().encode(items) else { return }
        try? data.write(to: fileURL, options: .atomic)
    }
}
