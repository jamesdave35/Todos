//
//  NewTaskView.swift
//  Todos
//
//  Created by James Meli on 6/29/20.
//

import SwiftUI
import Firebase

struct NewTaskView: View {
    
    @EnvironmentObject var taskStore: TaskStore
    
    @Binding var showNewTaskView: Bool
    @State private var taskName = ""
    @State private var priority = 0
    @State private var taskDueDate: Date = Date()
    var priorities = ["Low", "Medium", "High"]

    var body: some View {
        NavigationView {
           Form {
               TextField("Task Name", text: $taskName)
                   .frame(height: 50)
               Picker(selection: $priority, label: Text("Priority")) {
                   ForEach(0..<priorities.count) {
                       Text(priorities[$0])
                   }
               }
               .frame(height: 50)
               
               Section {
                   DatePicker("Due Date", selection: $taskDueDate)
                       
               }
               .frame(height: 50)
                   
           }
           .listStyle(InsetGroupedListStyle())
           .edgesIgnoringSafeArea(.all)
           .navigationBarTitle(Text("New Task"), displayMode: .inline)
           .navigationBarItems(leading:
                                   Button(action: {
                                      self.showNewTaskView.toggle()
                                   }, label: {
                                        Text("Cancel")
                                           .foregroundColor(Color("todosPurple"))
                                           .font(.system(size: 18, weight: .medium, design: .default))
                                }), trailing:
                                   Button(action: {
                                      self.addTask(name: taskName, dueDate: taskDueDate, priority: priorities[priority])
                                   showNewTaskView.toggle()
                                }, label: {
                                     Text("Save")
                                        .foregroundColor(Color("todosPurple"))
                                        .font(.system(size: 18, weight: .medium, design: .default))
       })
        
      )
   

     }
        
  }
    

    
    func addTask(name: String, dueDate: Date, priority: String) {
        guard let currentUserId = Auth.auth().currentUser?.uid else {return}
        let taskId = UUID().uuidString
        let taskToAdd = Task(id: taskId, name: name, dueDate: dueDate, priority: priority, isCompleted: false, userId: currentUserId)
        DatabaseServices.saveTask(task: taskToAdd)
        taskStore.tasks.append(taskToAdd)
    }
    
}

struct NewTaskView_Previews: PreviewProvider {
    static var previews: some View {
        NewTaskView(showNewTaskView: .constant(true))
    }
}
