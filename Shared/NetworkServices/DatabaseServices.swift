//
//  DatabaseServices.swift
//  iOS
//
//  Created by James Meli on 6/30/20.
//

import Foundation
import Firebase

struct DatabaseServices {
    
    static let taskRef = Firestore.firestore().collection("Tasks")
    
    static func saveTask(task: Task) {
        taskRef.document(task.id).setData(task.toDictionary())
    }
    
    static func getTasks(completion: @escaping(_ tasks: [Task]) -> Void) {
        
        var tasks = [Task]()
        
        guard let currentUserId = Auth.auth().currentUser?.uid else {
            completion([])
            return
        }
        taskRef.whereField("userId", isEqualTo: currentUserId).getDocuments { (snapshot, error) in
            if error != nil {
                print("Error: \(error?.localizedDescription)")
                completion([])
            } else {
                guard let snapshot = snapshot else {
                    completion([])
                    return
                }
                
                for document in snapshot.documents {
                    let taskToAdd = Task(data: document.data())
                    tasks.append(taskToAdd)
                }
                
                completion(tasks)
            }
        }
    }
    
    static func toggleTaskCompletedState(taskId: String) {
        var value: Bool!
        taskRef.document(taskId).getDocument { (snapshot, error) in
            if let data = snapshot?.data() {
                let task = Task(data: data)
                if task.isCompleted {
                    value = false
                } else {
                    value = true
                }
                
                taskRef.document(taskId).setData(["isCompleted": value], mergeFields: ["isCompleted"]) { (error) in
                    if error != nil {
                        print("Error: \(error?.localizedDescription)")
                    }
                }
            }
        }
    }
}
