//
//  Blog.swift
//  BlogHorizon
//
//  Created by IPH Technologies Pvt. Ltd. on 07/06/23.
//

import Foundation
// MARK: - Model
struct BlogModel: Codable {
    let statusCode: Int?
    let status: String?
    let blogs: [BlogDetailModel]?

    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case status, blogs
    }
}
// MARK: - Blog
struct BlogDetailModel: Codable {
    let id: Int?
    let blogFeaturedImgURL: BlogFeaturedImgURL
    let blogTitle, blogContent, blogDate: String?
    let blogStatus: BlogStatus
    let blogURL: String?

    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case blogFeaturedImgURL = "blog_featured_img_url"
        case blogTitle = "blog_title"
        case blogContent = "blog_content"
        case blogDate = "blog_date"
        case blogStatus = "blog_status"
        case blogURL = "blog_url"
    }
}
enum BlogFeaturedImgURL: Codable {
    case bool(Bool)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Bool.self) {
            self = .bool(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(BlogFeaturedImgURL.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for BlogFeaturedImgURL"))
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .bool(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}
enum BlogStatus: String, Codable {
    case publish = "publish"
}



