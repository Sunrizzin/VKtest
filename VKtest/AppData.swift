//
//  AppData.swift
//  VKtest
//
//  Created by Sunrizz on 07/03/2019.
//  Copyright © 2019 Алексей Усанов. All rights reserved.
//

import Foundation
import SwiftyJSON

class AppData {
    
    static let shared = AppData()
    
    init(){}
    
    var items = [JSON]()
    var groups = [JSON]()
    var profiles = [JSON]()
    var next_from = [JSON]()
    
    func getAuthor(path: Int) -> String {
        let item = self.items[path].dictionary!["source_id"]!.doubleValue
        if item < 0 {
            for group in self.groups {
                if group.dictionary!["id"]!.doubleValue + item == 0 {
                    return (group.dictionary!["name"]?.stringValue)!
                }
            }
        } else {
            for profile in self.profiles {
                if profile.dictionary!["id"]!.doubleValue + item == 0 {
                    return (profile.dictionary!["name"]?.stringValue)!
                }
            }
        }
        return ""
    }
    
    
    
    func getAuthorImage(path: Int) -> String {
        let item = self.items[path].dictionary!["source_id"]!.doubleValue
        if item < 0 {
            for group in self.groups {
                if group.dictionary!["id"]!.doubleValue + item == 0 {
                    return (group.dictionary!["photo_100"]?.stringValue)!
                }
            }
        }
        return ""
    }
    
    func getDate(time: Double) -> String {
        let date = Date(timeIntervalSince1970: time)
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .short
        return dateFormatter.string(from: date)
    }
    
}
