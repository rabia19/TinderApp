//
//  InboxApi.swift
//  JChat
//
//  Created by DuyetTran on 2/16/19.
//  Copyright © 2019 zero2launch. All rights reserved.
//

import Foundation
import Firebase

typealias InboxCompletion = (Inbox) -> Void


class InboxApi {
    func lastMessages(uid: String, onSuccess: @escaping(InboxCompletion) ) {
        
        let ref = Database.database().reference().child(REF_INBOX).child(uid)
        ref.observe(DataEventType.childAdded) { (snapshot) in
            if let dict = snapshot.value as? Dictionary<String, Any> {
                let partnerId = dict["to"] as! String
                Api.User.getUserInfor(uid: partnerId, onSuccess: { (user) in
                    if let inbox = Inbox.transformInbox(dict: dict, user: user) {
                        onSuccess(inbox)
                    }
                })
            }
        }
  
    }
    
}
