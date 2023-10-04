//
//  CompletedToDoIntent.swift
//  InteractiveWidgetKit
//
//  Created by Bekir Geriş on 5.10.2023.
//

import Foundation
import SwiftUI
import AppIntents

struct CompletedToDoIntent : AppIntent {
    
    static var title: LocalizedStringResource = "Complete To Do"
    
    @Parameter(title: "toDoId")
    var id: String
    
    init() {
    }
    
    init(id: String) {
        self.id = id
    }
    
    func perform() async throws -> some IntentResult {
        if let index = SharedDatas.shared.toDos.firstIndex(where: { toDo in
            toDo.id == id
        }) {
            SharedDatas.shared.toDos[index].isDone.toggle()
        }
        return .result()
    }
    
}
