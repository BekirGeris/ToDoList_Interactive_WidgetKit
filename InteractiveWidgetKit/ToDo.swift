//
//  ToDo.swift
//  InteractiveWidgetKit
//
//  Created by Bekir Geriş on 4.10.2023.
//

import Foundation

struct ToDo : Identifiable {
    let id: String = UUID().uuidString
    var name: String
    var isDone: Bool = false
}


class SharedDatas {
    static let shared = SharedDatas()
    
    var toDos: [ToDo] = [
        .init(name: "Test1"),
        .init(name: "Test2 test"),
        .init(name: "Test3 test test")
    ]
}
