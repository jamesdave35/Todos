//
//  TaskListView.swift
//  Todos
//
//  Created by James Meli on 6/29/20.
//

import SwiftUI

struct TaskListView: View {
    
    
    @EnvironmentObject var taskStore: TaskStore
    @State private var showNewTaskView = false
    @State private var showLogOutAlert = false
    @State private var showWelcomeView = false
    
    var body: some View {
        NavigationView {
            ZStack {
                List {
                    Toggle(isOn: $taskStore.showUnCompletedOnly, label: {
                        Text("Show uncompleted only")
                    })
                    Section {
                        ForEach(taskStore.tasks) { task in
                            if !taskStore.showUnCompletedOnly || !task.isCompleted {
                                TaskCellView(isCompleted: task.isCompleted, task: task).environmentObject(self.taskStore)
                                    
                            }
                        }
                    }
  
                }
                .listStyle(InsetGroupedListStyle())
        
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                            Button(action: {
                                self.showNewTaskView.toggle()
                            }, label: {
                                Image(systemName: "plus")
                                    .font(.system(size: 25, weight: .regular, design: .default))
                                    .foregroundColor(.white)
                                    .frame(width: 60, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    .background(Color("todosPurple"))
                                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                                    .shadow(color: Color.black.opacity(0.2), radius: 8, x: 3, y: 4)
                            })
                            .sheet(isPresented: $showNewTaskView) {
                                NewTaskView(showNewTaskView: $showNewTaskView).environmentObject(self.taskStore)
                            }
                        
                    }
                    .padding(.trailing, 15)
                }
                .padding(.bottom, 40)
            }
            .frame(maxWidth: .infinity)
            .background(Color("alternatePrimaryBackground"))
            .edgesIgnoringSafeArea(.all)
            .navigationBarTitle(Text("Tasks"))
            .navigationBarItems(trailing:
                    Button(action: {
                        showLogOutAlert.toggle()
                    }, label: {
                        Text("Log Out")
                            .foregroundColor(Color("todosPurple"))
                            .font(.system(size: 16, weight: .regular, design: .default))
                    })
                    .fullScreenCover(isPresented: $showWelcomeView) {
                        WelcomeView()
                    }
                                    
            )
            .alert(isPresented: $showLogOutAlert) {
                Alert(title: Text("Are you sure you want to log out ?"), message: Text(""), primaryButton: .destructive(Text("Log out"), action: {
                    logOutUser()
                }), secondaryButton: .default(Text("Cancel")))
            }


            .onAppear {
                getTasks()
            }
        }
    }
    
    func getTasks() {
        DatabaseServices.getTasks { (tasks) in
            taskStore.tasks = tasks.sorted(by: {$0.dueDate < $1.dueDate})
        }
    }
    
    func logOutUser() {
        AuthenticationServices.logOutUser()
        UserDefaults.standard.setValue(false, forKey: "isLoggedIn")
        showWelcomeView.toggle()
    }
}

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView()
    }
}
