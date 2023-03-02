//
//  JustWalking.swift
//  JustWalking
//
//  Created by Tim Mitra on 2023-03-01.
//

import WidgetKit
import SwiftUI

struct StepEntry: TimelineEntry {
    var date: Date = Date()
    var steps: Int
}

struct Provider: TimelineProvider {
    
    typealias Entry = StepEntry
    
    func placeholder(in context: Context) -> StepEntry {
        return StepEntry(steps: stepCount)
    }
    
    @AppStorage("stepCount", store: UserDefaults(suiteName: "group.com.it-guy.justwalking"))
    var stepCount: Int = 0

    func getSnapshot(in context: Context, completion: @escaping (Entry) -> ()) {
        let entry = StepEntry(steps: stepCount)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let entry = StepEntry(steps: stepCount)
        completion(Timeline(entries: [entry], policy: .never))
    }
}

struct JustWalkingEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        Text("\(entry.steps)")
    }
}

struct JustWalking: Widget {
    let kind: String = "JustWalking"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            JustWalkingEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct JustWalking_Previews: PreviewProvider {
    static var previews: some View {
        JustWalkingEntryView(entry: StepEntry(steps: 237))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
