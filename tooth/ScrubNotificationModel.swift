//
//  ScrubNotificationModel.swift
//  Scrub iOS
//
//  Created by Kristóf Kékesi on 2023. 05. 14..
//

import Foundation


struct ScrubNotification: Codable, Hashable {
    var UUID: UUID
    var hour: Int
    var minute: Int
}
