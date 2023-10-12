//
//  Prefs.swift
//  tooth
//
//  Created by Kristóf Kékesi on 2023. 01. 08..
//

import Foundation


class Prefs {
    private let defaults = UserDefaults.standard
  
    private let keyIntExample = "intExample"
  
    var intExample = {
        set {
            defaults.setValue(newValue, forKey: keyIntExample)
        }
        get {
            return defaults.integer(forKey: keyIntExample)
        }
    }
  
    class var shared: Prefs {
        struct Static {
            static let instance = Prefs()
        }
      
        return Static.instance
    }
}
