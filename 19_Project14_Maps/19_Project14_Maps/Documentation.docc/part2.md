#  Using Touch ID and Face ID with SwiftUI

import SwiftUI
import LocalAuthentication


struct ContentView: View {
    @State var isLocked = true
    var body: some View {
        Group {
            if isLocked {
                Text("Locked")
            } else {
                Text("Unlocked")
            }
        }
        .padding()
        Button(isLocked ? "Unlock": "Lock") {
            if isLocked {
                authenticate()
            } else {
                isLocked = true
            }
        }
        
    }
    
    private func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "We need your permission") { authenticated, error in
                if let error = error {
                    print(error)
                    return
                }
                isLocked = !authenticated
            }
        } else {
            print("Device incapable to evaluate policy")
            if let error {
                print("error: \(error)")
            }
        }
    }
}

#Preview {
    ContentView()
}
