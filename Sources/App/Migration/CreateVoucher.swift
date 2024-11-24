//
//  CreatePost 2.swift
//  rexcycleAPI
//
//  Created by Pedro Catunda on 23/11/24.
//


import Fluent

struct CreateVoucher: AsyncMigration {
    
    func prepare(on database: Database) async throws {
        try await database
            .schema(Voucher.schema)
            .id()
            .field("title", .string)
            .field("description", .string)
            .field("purchasedCredit", .double)
            .field("created_at", .datetime)
            .field("updated_at", .datetime)
            .field("user_id", .uuid)
            .foreignKey("user_id", references: User.schema, "id", onDelete: .cascade, onUpdate: .cascade)
            .create()
    }
    
    func revert(on database: Database) async throws {
        try await database.schema(Voucher.schema).delete()
    }
}

struct CreateUserVoucher: AsyncMigration {
    
    func prepare(on database: Database) async throws {
        try await database
            .schema(UserVoucher.schema)
            .id()
            .field("user_id", .uuid, .required, .references("users", "id", onDelete: .cascade))
            .field("voucher_id", .uuid, .required, .references("vouchers", "id", onDelete: .cascade))
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema(UserVoucher.schema).delete()
    }
}
