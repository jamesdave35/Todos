//
//  Task.swift
//  Todos
//
//  Created by James Meli on 6/29/20.
//

import Foundation
import Firebase

class Task: Identifiable {
    
    var id: String
    var name: String
    var dueDate: Date
    var priority: String
    var isCompleted: Bool
    var userId: String
    
    init(id: String, name: String, dueDate: Date, priority: String, isCompleted: Bool, userId: String) {
        self.id = id
        self.name = name
        self.dueDate = dueDate
        self.priority = priority
        self.isCompleted = isCompleted
        self.userId = userId
    }
    
    init(data: [String: Any]) {
        id = data["id"] as! String
        name = data["name"] as! String
        let timestamp = data["dueDate"] as! Timestamp
        dueDate = timestamp.dateValue()
        priority = data["priority"] as! String
        isCompleted = data["isCompleted"] as! Bool
        userId = data["userId"] as! String
    }
    
    func toDictionary() -> [String: Any] {
        return ["id": id, "name": name, "dueDate": dueDate, "priority": priority, "isCompleted": isCompleted, "userId": userId]
    }
}
