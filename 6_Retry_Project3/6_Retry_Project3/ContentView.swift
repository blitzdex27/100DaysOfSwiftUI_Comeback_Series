//
//  ContentView.swift
//  6_Retry_Project3
//
//  Created by Dexter Ramos on 2/28/24.
//

import CoreML
import SwiftUI

struct ContentView: View {
    @State private var wakeUpTime = Date.now
    @State private var amountOfSleep = 8.0
    @State private var coffeeIntake = 1
    
    @State private var alertMessage = ""
    @State private var isShowAllert = false
    
    private var idealBedTime: String {
        return calculateSleepTime()
    }
    var body: some View {
        NavigationView {
            Form {
                Section {
                    DatePicker("Select wake up time:", selection: $wakeUpTime, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                } header: {
                    Text("When do you want to wake up?")
                        .font(.headline)
                }
                
                Section {
                    Stepper("\(amountOfSleep) hours", value: $amountOfSleep, in: 4...12, step: 0.25)
                } header: {
                    Text("Desired amount of sleep:")
                        .font(.headline)
                }
                Section {
//                    Stepper("^[\(coffeeIntake) cup](inflect: true)", value: $coffeeIntake, in: 1...4)
                    Picker("Coffee Intake", selection: $coffeeIntake) {
                        ForEach(1...4, id: \.self) { num in
                            Text("\(num)")
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Daily coffee intake")
                        .font(.headline)
                    
                }
                Section {
                    Text(idealBedTime)
                } header: {
                    Text("Your ideal bedtime is...")
                }
            }
//            .toolbar {
//                Button {
//                    calculateSleepTime()
//                } label: {
//                    Text("Calculate")
//                }
//            }
            .navigationTitle("Sleep Calculator")
            .alert("Your ideal bedtime is", isPresented: $isShowAllert) {
                Button("OK") { }
            } message: {
                Text(alertMessage)
            }
            
        }
    }
    
    func calculateSleepTime() -> String {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let wakeComponents = Calendar.current.dateComponents([.hour, .minute], from: wakeUpTime)
            let hour = (wakeComponents.hour ?? 0) * 60 * 60
            let minutes = (wakeComponents.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Int64(hour + minutes), estimatedSleep: amountOfSleep, coffee: 3)
            
            let timeToSleep = wakeUpTime - prediction.actualSleep
            
            let idealBedTime = timeToSleep.formatted(date: .omitted, time: .standard)
//            alertMessage =
//            isShowAllert = true
            return idealBedTime
        } catch {
            // some error occured
            return ""
        }
        
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}

//#Preview {
//    ContentView()
//}

//struct ContentView: View {
//    @State private var date = Date.now
//    var body: some View {
//        Text(Date.now.formatted(date: .numeric, time: .standard))
//    }
//}

//struct ContentView: View {
//    @State private var sleepAmount = 8.0
//    var body: some View {
//        Stepper("Sleep Amount: \(sleepAmount.formatted())", value: $sleepAmount, in: 4...12, step: 0.25)
//    }
//}

//struct ContentView: View {
//    @State private var date = Date.now
//    var body: some View {
//        DatePicker("Please select date:", selection: $date, in: date..., displayedComponents: .date)
//            .labelsHidden()
//    }
//}
