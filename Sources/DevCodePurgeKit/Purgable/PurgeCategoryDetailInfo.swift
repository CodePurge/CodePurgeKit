//
//  PurgeCategoryDetailInfo.swift
//
//
//  Created by Nikolai Nobadi on 1/18/25.
//

/// A struct representing detailed information about a purge category.
/// This includes descriptive text, guidance, and tips for managing the category.
public struct PurgeCategoryDetailInfo: Codable, Hashable {
    /// The title of the purge category.
    public let title: String

    /// A description of the purge category, providing an overview of its purpose.
    public let description: String

    /// A list of detailed points or facts about the purge category.
    public let details: [String]

    /// Guidance or recommendations related to the purge category.
    public let guidance: [String]

    /// Helpful tips for users interacting with the purge category.
    public let tips: [String]

    /// Initializes a new `PurgeCategoryDetailInfo` instance with all required properties.
    /// - Parameters:
    ///   - title: The title of the purge category.
    ///   - description: A description of the category.
    ///   - details: A list of detailed points about the category.
    ///   - guidance: Recommendations or guidance for the category.
    ///   - tips: Helpful tips for users.
    public init(title: String, description: String, details: [String], guidance: [String], tips: [String]) {
        self.title = title
        self.description = description
        self.details = details
        self.guidance = guidance
        self.tips = tips
    }
}
