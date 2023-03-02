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
        return StepEntry
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

struct StepView: View {
    let entry: Provider.Entry
    
    var body: some View {
        Text("\(entry.steps)")
    }
}
