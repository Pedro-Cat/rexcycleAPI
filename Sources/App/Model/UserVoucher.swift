//
//  UserVoucher.swift
//  rexcycleAPI
//
//  Created by Pedro Catunda on 23/11/24.
//

import Vapor
import Fluent

final class UserVoucher: Model {
    
    static let schema = "user_vouchers"

    @ID(key: .id)
    var id: UUID?

    @Parent(key: "user_id")
    var user: User

    @Parent(key: "voucher_id")
    var voucher: Voucher

    init() { }

    init(userId: UUID, voucherId: UUID) {
        self.$user.id = userId
        self.$voucher.id = voucherId
    }
}
