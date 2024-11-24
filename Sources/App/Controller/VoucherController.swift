//
//  VoucherController.swift
//  rexcycleAPI
//
//  Created by Pedro Catunda on 23/11/24.
//

import Vapor
import Fluent
import SQLiteKit

struct VoucherController: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        routes.group("posts") {
            $0.get(use: index)
            $0.group(":id") {
                $0.get(use: show)
//                $0.get("comments", use: showComment)
//                $0.group(Token.authenticator()) {
//                    $0.post(use: createComment)
//                    $0.patch(":id", use: update)
//                    $0.delete(":id", use: delete)
//                }
            }
            $0.group(Token.authenticator()) {
                $0.post(use: create)
                $0.patch(":id", use: update)
                $0.delete(":id", use: delete)
            }
            $0.get("paginated", use: indexPaginated)
//            $0.post("mock", use: mock_create)
        }
    }
    
    func index(req: Request) async throws -> [Voucher.Public] {
        var query = Voucher.query(on: req.db).sort(\.$createdAt, .descending)
        if req.query[String.self, at: "expand"] == "user_id" {
            query = query.with(\.$user)
        }
        if let userID = req.query[User.IDValue.self, at: "user_id"] {
            query = query.filter(\.$user.$id == userID)
        }
        return try await query.all().map(\.public)
    }
    
    func show(req: Request) async throws -> Voucher.Public {
        let id = try req.parameters.require("id", as: Voucher.IDValue.self)
        if let voucher = try await Voucher.find(id, on: req.db) {
            return voucher.public
        } else {
            throw Abort(.notFound)
        }
    }
    
//    func showComment(req: Request) async throws -> [Comment] {
//        var query = Comment.query(on: req.db)
//        return try await query.all()
//    }
    
    func create(req: Request) async throws -> Voucher {
        let user = try req.auth.require(User.self)
        let content = try req.content.decode(Voucher.Form.self)
        let voucher = try Voucher(title: content.title, description: content.description, purchasedCredit: content.purchasedCredit, userID: user.requireID())
//        let post = try Post(text: content.text, expiresAt: content.expiresAt, userID: user.requireID())
//        if !isWithinCharacterLimit(content.text, limit: 200) {
//            throw Abort(.notAcceptable)
//        }
        try await voucher.save(on: req.db)
        return voucher
//        switch req.headers.contentType {
//            case .plainText?:
//                let content = try req.content.decode(String.self)
//            let post = try Post(text: content, tags: [], userID: user.requireID())
//                try await post.save(on: req.db)
//                return post.public
//            case .formData?:
//                let form = try req.content.decode(Post.Form.self)
//            guard let contentType = form.media?.contentType, [.any].contains(contentType) else {
//                    throw Abort(.unsupportedMediaType)
//                }
//                let post = try Post(form: form, userID: user.requireID())
//                try await post.save(on: req.db)
//                return post.public
//            default:
//                throw Abort(.badRequest)
//        }
    }
    
//    func createComment(req: Request) async throws -> Comment {
//        let user = try req.auth.require(User.self)
//        let userID = try user.requireID()
//        let postID = try req.content.decode(UUID.self)
//        let content = try req.content.decode(Comment.self)
//        let comment = Comment(text: content.text, userID: userID, postID: postID)
//        try await comment.save(on: req.db)
//        return comment
//    }
    
//    func mock_create(req: Request) async throws -> Response {
//        
//        let inputs = try req.content.decode([Post.Mock.Input].self)
//        
//        let users = try await User.query(on: req.db).all()
//        
//        guard !users.isEmpty else {
//            throw Abort(.internalServerError)
//        }
//        
//        for input in inputs {
//            let post = try Post.Mock(text: input.text, tags:[], userID: users.randomElement()!.requireID(), createdAt: input.createdAt)
//            try await post.save(on: req.db)
//        }
//        
//        return Response(status: .created)
//        
//    }
    
    func update(req: Request) async throws -> Voucher {
        let id = try req.parameters.require("id", as: Voucher.IDValue.self)
        if let voucher = try await Voucher.find(id, on: req.db) {
            voucher.description = try req.content.decode(String.self)
            try await voucher.update(on: req.db)
            return voucher
        } else {
            throw Abort(.notFound)
        }
    }
    
    func delete(req: Request) async throws -> Voucher {
        let id = try req.parameters.require("id", as: Voucher.IDValue.self)
        if let voucher = try await Voucher.find(id, on: req.db) {
            try await voucher.delete(on: req.db)
            return voucher
        } else {
            throw Abort(.notFound)
        }
    }
    
    func indexPaginated(req: Request) async throws -> Page<Voucher.Public> {
        let query: QueryBuilder<Voucher>
        if let userID = req.query[User.IDValue.self, at: "user_id"] {
            query = Voucher.query(on: req.db).with(\.$user).sort(\.$createdAt, .descending).filter(\.$user.$id == userID)
        } else {
            query = Voucher.query(on: req.db).with(\.$user).sort(\.$createdAt, .descending)
        }
        return try await query.paginate(for: req).map(\.public)
    }
    
}
