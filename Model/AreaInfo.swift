//
//  AreaInfo.swift
//  Cooler
//
//  Created by S Yi on 8/22/21.
//

import UIKit

class AreaInfo: NSObject {
    enum Status {
        case acceptable
        case unacceptable
        case notAvailable
        case none
    }
    
    var title:String?
    var comment:String?
    var commentUser:String?
    var commentDate:Date?
    var status: Status = .none
    var isCommenting:Bool
    
    override init() {
        self.title = nil
        self.comment = nil
        self.commentUser = "Eric"
        self.commentDate = nil
        self.status = .none
        self.isCommenting = false
        super.init()
    }
}
