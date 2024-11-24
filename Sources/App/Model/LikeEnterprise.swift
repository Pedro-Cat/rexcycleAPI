//
//  LikeVoucher 2.swift
//  rexcycleAPI
//
//  Created by Pedro Catunda on 23/11/24.
//


import Vapor
import Fluent

final class LikeEnterprise: Model {
    
    static let schema = "likes_enterprises"
    
    @ID(key: .id)
    var id: UUID?
    
    @Parent(key: "user_id")
    var user: User
    
    @Parent(key: "enterprise_id")
    var enterprise: User
    
    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?

    init() { }
    
    init(userID: User.IDValue, enterpriseID: User.IDValue) {
        self.$user.id = userID
        self.$enterprise.id = enterpriseID
    }

    var `public`: Public {
        Public(
            id: id!,
            enterpriseID: $enterprise.id,
            userID: $user.id,
            user: $user.value?.public
        )
    }

}

extension LikeEnterprise: Content { }

extension LikeEnterprise {
    
    struct Input: Content {
        
        let enterpriseID: User.IDValue
        
        enum CodingKeys: String, CodingKey {
            case enterpriseID = "enterprise_id"
        }

    }

    struct Public: Content {
        var id: UUID
        var enterpriseID: UUID
        var userID: UUID
        var user: User.Public?
        var createdAt: Date?
    }

}
