//
//  ToDoWidget.swift
//  ToDoWidget
//
//  Created by Bekir Geriş on 4.10.2023.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> ToDoEntry {
        ToDoEntry(toDoDisplay: Array(SharedDatas.shared.toDos.prefix(3)))
    }

    func getSnapshot(in context: Context, completion: @escaping (ToDoEntry) -> ()) {
        let entry = ToDoEntry(toDoDisplay: Array(SharedDatas.shared.toDos.prefix(3)))
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let entry = ToDoEntry(toDoDisplay: Array(SharedDatas.shared.toDos.prefix(3)))

        let timeline = Timeline(entries: [entry], policy: .atEnd)
        completion(timeline)
    }
}

struct ToDoEntry: TimelineEntry {
    let date: Date = .now
    let toDoDisplay: [ToDo]
}

struct ToDoWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack(alignment: .leading) {
            Text("ToDo Items")
                .foregroundColor(.white)
                .fontWeight(.bold)
                .padding(.bottom, 5)
                .frame(maxWidth: .infinity, alignment: .center)
            
            if entry.toDoDisplay.isEmpty {
                Text("ToDos Completed")
                    .foregroundColor(.white)
            } else {
                ForEach(entry.toDoDisplay) { toDo in
                    HStack {
                        Button(intent: CompletedToDoIntent(id: toDo.id)) {
                            Image(systemName: toDo.isDone ? "checkmark.circle.fill" : "circle")
                                .foregroundStyle(.blue)
                        }.buttonStyle(.plain)
                        
                        Text(toDo.name)
                            .foregroundColor(.white)
                            .textScale(.secondary)
                            .lineLimit(1)
                            .strikethrough(toDo.isDone)
                        Divider()
                    }
                }
            }
        }.frame(maxWidth: .infinity)
    }
}

struct ToDoWidget: Widget {
    let kind: String = "ToDoWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            ZStack {
                if #available(iOS 17.0, *) {
                    ToDoWidgetEntryView(entry: entry)
                        .containerBackground(.foreground, for: .widget)
                } else {
                    ToDoWidgetEntryView(entry: entry)
                        .background()
                }
            }
        }
        .configurationDisplayName("ToDo Widget")
        .description("This is an example widget.")
    }
}

#Preview(as: .systemSmall) {
    ToDoWidget()
} timeline: {
    ToDoEntry(toDoDisplay: Array(SharedDatas.shared.toDos.prefix(3)))
    ToDoEntry(toDoDisplay: Array(SharedDatas.shared.toDos.prefix(3).reversed()))
}
