import Fluent

struct CreateReport: AsyncMigration {
    
    func prepare(on database: Database) async throws {
        try await database
            .schema(Report.schema)
            .id()
            .field("reason", .string)
            .field("user_id", .uuid)
            .field("post_id", .uuid)
            .field("created_at", .datetime)
            .foreignKey("user_id", references: User.schema, "id", onDelete: .cascade, onUpdate: .cascade)
            .foreignKey("post_id", references: Voucher.schema, "id", onDelete: .cascade, onUpdate: .cascade)
            .create()
    }
    
    func revert(on database: Database) async throws {
        try await database.schema(Report.schema).delete()
    }
    
}
