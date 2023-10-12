//
//  ScrubNotificationLogic.swift
//  Scrub iOS
//
//  Created by Kristóf Kékesi on 2023. 05. 15..
//

import Foundation
import NotificationCenter

/// Returns all `ScrubNotification`s saved.
func getAllScrubNotifications() -> Set<ScrubNotification> {
    return [ScrubNotification(UUID: UUID(), hour: 0, minute: 0)]
}

/// Saves the given set of `ScrubNotification`s.
func saveScrubNotifications(scrubNotifications: Set<ScrubNotification>) {}

/// Deletes a gives `ScrubNotification` from `getAllScrubNotifications` and saves the set. Deletes the corresponding scrub notification as well.
func deleteScrubNotification(scrubNotification: ScrubNotification) {}


/// Adds a `ScrubNotification` to the set  from `getAllScrubNotifications` and the set and saves the set. Adds the corresponding scrub notification as well.
func addScrubNotification(scrubNotification: ScrubNotification) {}
