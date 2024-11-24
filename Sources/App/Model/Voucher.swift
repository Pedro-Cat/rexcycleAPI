//
//  Voucher.swift
//  rexcycleAPI
//
//  Created by Pedro Catunda on 23/11/24.
//


import Vapor
import Fluent

final class Voucher: Model {
    
    static let schema = "voucher"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "title")
    var title: String
    
    @Field(key: "description")
    var description: String
    
    @Field(key: "purchasedCredit")
    var purchasedCredit: Double
    
    @Parent(key: "user_id")
    var user: User
    
    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?
    
    @Timestamp(key: "updated_at", on: .update)
    var updatedAt: Date?
    
    @Siblings(through: UserVoucher.self, from: \.$voucher, to: \.$user)
    var users: [User]
    
    init() {}
    
    init(title: String, description: String, purchasedCredit: Double, userID: User.IDValue) {
        self.title = title
        self.description = description
        self.purchasedCredit = purchasedCredit
        self.$user.id = userID
    }
    
//    init(form: Form, userID: User.IDValue) {
//        self.text = form.text
//        if let media = form.media {
//            self.media = try? media.data.write(to: URL(fileURLWithPath: DirectoryConfiguration.detect().publicDirectory), contentType: media.contentType)
//        }
//        self.likeCount = 0
//        self.$user.id = userID
//    }
    
    var `public`: Public {
        Public(id: id!, title: title, description: description, purchasedCredit: purchasedCredit, createdAt: createdAt, updatedAt: updatedAt, userID: $user.id, user: $user.value?.public)
    }
    
}

extension Voucher: Content { }

extension Voucher {
    
    struct Form: Content {
        var title: String
        var description: String
        var purchasedCredit: Double
    }
    
    struct Public: Content {
        var id: UUID
        var title: String
        var description: String
        var purchasedCredit: Double
        var createdAt: Date?
        var updatedAt: Date?
        var userID: UUID
        var user: User.Public?
    }

}

//extension ByteBuffer {
//    
//    func write(to directory: URL, contentType: HTTPMediaType?) throws -> String {
//        var buffer = self
//        guard let file = buffer.readData(length: buffer.readableBytes) else {
//            throw Abort(.internalServerError)
//        }
//        let filename = SHA256.hash(data: Data(UUID().uuidString.utf8)).hexEncodedString().prefix(30)
//        let fileExtension = contentType?.description.components(separatedBy: "/").last ?? ""
//        let path = "media/" + filename + "." + fileExtension
//        let url = directory.appendingPathComponent(path)
//        try file.write(to: url)
//        return path
//    }
//    
//}
