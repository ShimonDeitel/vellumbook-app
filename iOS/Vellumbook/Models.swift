import Foundation

struct Binding: Identifiable, Codable, Equatable {
    let id: UUID
    var dateCreated: Date
    var title: String
    var signatureCount: Double
    var paperStock: String
    var coverMaterial: String
    var bindingStyle: String

    init(id: UUID = UUID(), dateCreated: Date = Date(), title: String = "", signatureCount: Double = 0, paperStock: String = "", coverMaterial: String = "", bindingStyle: String = "") {
        self.id = id
        self.dateCreated = dateCreated
        self.title = title
        self.signatureCount = signatureCount
        self.paperStock = paperStock
        self.coverMaterial = coverMaterial
        self.bindingStyle = bindingStyle
    }
}
