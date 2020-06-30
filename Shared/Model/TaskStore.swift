//
//  TaskStore.swift
//  iOS
//
//  Created by James Meli on 6/30/20.
//

import Foundation
import Combine
import SwiftUI

class TaskStore: ObservableObject {
    
    @Published var tasks = [Task]()
    @Published var showUnCompletedOnly = false
}
