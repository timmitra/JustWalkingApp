//
//  ContentView.swift
//  JustWalkingApp
//
//  Created by Tim Mitra on 2023-03-01.
//

import SwiftUI
import CoreMotion

struct ContentView: View {
    
    @AppStorage("stepCount", store: UserDefaults(suiteName: "group.com.it-guy.justwalking"))
    var stepCount:Int = 0
    
    private let pedometer: CMPedometer = CMPedometer()
    
    @State private var steps: Int?
    @State private var distance: Double?
    
    private var isPedometerAvailable: Bool {
        return CMPedometer.isPedometerEventTrackingAvailable() &&
        CMPedometer.isDistanceAvailable() && CMPedometer.isStepCountingAvailable()
    }
    
    private func initializePedometer() {
        if isPedometerAvailable {
            guard let startDate = Calendar.current.date(byAdding: .day, value: -7, to: Date()) else {
                return
            }
            pedometer.queryPedometerData(from: startDate, to: Date()) { (data, error) in
                guard let data = data, error == nil else { return }
                
                // as soon as you set the value, the view will get refreshed
                //steps = data.numberOfSteps.intValue
                //distance = data.distance?.doubleValue
                updateUI(data: data)
            }
        }
    }
    
    private func updateUI(data: CMPedometerData) {
        
        stepCount = data.numberOfSteps.intValue
        steps = data.numberOfSteps.intValue
        
        guard let pedometerDistance = data.distance else { return }
        
        let distanceInMeters = Measurement(value: pedometerDistance.doubleValue, unit: UnitLength.meters)
        
        distance = distanceInMeters.converted(to: .miles).value
    }
    
    var body: some View {

        Text(steps != nil ? "\(steps!) steps." : "")
        Text(distance != nil ? String(format: "%.2f miles", distance!) : "")
        .padding()
        .onAppear {
            initializePedometer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
