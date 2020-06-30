//
//  TaskCellView.swift
//  iOS
//
//  Created by James Meli on 6/30/20.
//

import SwiftUI

struct TaskCellView: View {
    
    @EnvironmentObject var taskStore: TaskStore
    @State var isCompleted: Bool
    var task: Task
    
    var taskIndex: Int {
        taskStore.tasks.firstIndex(where: { $0.id == task.id })!
    }
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                HStack(spacing: 15) {
                    if task.priority == "High" {
                        Color(.systemGreen)
                            .frame(width: 2)
                            
                            
                    } else if task.priority == "Medium" {
                        Color(.systemYellow)
                            .frame(width: 2)
                            
                    } else {
                        Color(.systemRed)
                            .frame(width: 2)
                            
                    }
                    
                    VStack(alignment: .leading, spacing: 15.0) {
                        Text(task.name)
                            .font(.system(size: 16, weight: .regular, design: .default))
                        Text("Due in \(task.dueDate.timeAgoDisplay())")
                            .foregroundColor(.secondary)
                            .font(.system(size: 14, weight: .regular, design: .default))
                    }
                   

                        
                }
                Spacer()
                Image(systemName: isCompleted ? "checkmark.circle.fill": "circle")
                    .foregroundColor(Color("todosPurple"))
                    .font(.system(size: 20, weight: .regular, design: .default))
                    .padding(.trailing, 50)
                    .onTapGesture {
                        toggleTaskCompletedState()
                    }

            }
            .padding(.vertical, 20)
            
        }
        .frame(width: UIScreen.main.bounds.width - 25)
        
    }
    
    func toggleTaskCompletedState() {
        let selectorFeedbackGenerator = UISelectionFeedbackGenerator()
        selectorFeedbackGenerator.selectionChanged()
        isCompleted.toggle()
        taskStore.tasks[taskIndex].isCompleted.toggle()
        DatabaseServices.toggleTaskCompletedState(taskId: task.id)
    }
    
}

struct TaskCellView_Previews: PreviewProvider {
    static var previews: some View {
        TaskCellView(isCompleted: false, task: Task(id: "id", name: "Finish Swift UI", dueDate: Date(), priority: "High", isCompleted: false, userId: "id"))
    }
}
