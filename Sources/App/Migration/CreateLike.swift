import Fluent

struct CreateLikeVoucher: AsyncMigration {
    
    func prepare(on database: Database) async throws {
        try await database
            .schema(LikeVoucher.schema)
            .id()
            .field("user_id", .uuid)
            .field("voucher_id", .uuid)
            .field("created_at", .datetime)
            .foreignKey("user_id", references: User.schema, "id", onDelete: .cascade, onUpdate: .cascade)
            .foreignKey("voucher_id", references: Voucher.schema, "id", onDelete: .cascade, onUpdate: .cascade)
            .create()
    }
    
    func revert(on database: Database) async throws {
        try await database.schema(LikeVoucher.schema).delete()
    }
    
}

struct CreateLikeEnterprise: AsyncMigration {
    
    func prepare(on database: Database) async throws {
        try await database
            .schema(LikeEnterprise.schema)
            .id()
            .field("user_id", .uuid)
            .field("enterprise_id", .uuid)
            .field("created_at", .datetime)
            .foreignKey("user_id", references: User.schema, "id", onDelete: .cascade, onUpdate: .cascade)
            .foreignKey("enterprise_id", references: User.schema, "id", onDelete: .cascade, onUpdate: .cascade)
            .create()
    }
    
    func revert(on database: Database) async throws {
        try await database.schema(LikeEnterprise.schema).delete()
    }
    
}
