//
//  HealthStore.swift
//  tooth
//
//  Created by Kristóf Kékesi on 2023. 01. 04..
//

import Foundation
import HealthKit

class HealthStore {
    var healthStore: HKHealthStore?
    
    init() {
        if HKHealthStore.isHealthDataAvailable() {
            healthStore = HKHealthStore()
        }
    }
        
    func requestAuthorization(completion: @escaping (Bool) -> Void) {
        let brushingCategoryType = HKCategoryType(.toothbrushingEvent)
        
        guard let healthStore = self.healthStore else { return completion(false)}
        
        healthStore.requestAuthorization(toShare: [brushingCategoryType], read: [brushingCategoryType]) { (success, error) in
            completion(success)
        }
    }
}
