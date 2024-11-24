import Vapor
import Fluent

final class LikeVoucher: Model {
    
    static let schema = "likes_vouchers"
    
    @ID(key: .id)
    var id: UUID?
    
    @Parent(key: "user_id")
    var user: User
    
    @Parent(key: "voucher_id")
    var voucher: Voucher
    
    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?

    init() { }
    
    init(userID: User.IDValue, voucherID: Voucher.IDValue) {
        self.$user.id = userID
        self.$voucher.id = voucherID
    }

    var `public`: Public {
        Public(
            id: id!,
            voucherID: $voucher.id,
            userID: $user.id,
            user: $user.value?.public
        )
    }

}

extension LikeVoucher: Content { }

extension LikeVoucher {
    
    struct Input: Content {
        
        let voucherID: Voucher.IDValue
        
        enum CodingKeys: String, CodingKey {
            case voucherID = "voucher_id"
        }

    }

    struct Public: Content {
        var id: UUID
        var voucherID: UUID
        var userID: UUID
        var user: User.Public?
        var createdAt: Date?
    }

}
