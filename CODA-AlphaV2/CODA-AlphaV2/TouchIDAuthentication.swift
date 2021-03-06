//
//  TouchIDAuthentication.swift
//  CODA-AlphaV2
//
//  Created by Samrety Nguon on 4/25/19.
//  Copyright © 2019 MrDJEnz. All rights reserved.
//

import Foundation
import LocalAuthentication

// Enum to store which type of biometrics are being used
enum BiometricType {
    case none
    case touchID
    case faceID
}

// Class that allows user to try and log in to app with biometrics
class BiometricIDAuth {
    let context = LAContext()
    var loginReason = "Logging in with Touch ID"
    
    func canEvaluatePolicy() -> Bool {
        return context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
    }
    
    func biometricType() -> BiometricType {
        let _ = context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
        switch context.biometryType {
        case .none:
            return .none
        case .touchID:
            return .touchID
        case .faceID:
            return .faceID
        }
    }
    
    func authenticateUser(completion: @escaping (String?) -> Void) {
        guard canEvaluatePolicy() else {
            return
        }
        
        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: loginReason) {
            (success, evaluateError) in
            if success {
                DispatchQueue.main.async {
                    completion(nil)
                }
            } else {
                
                let message: String
                
                switch evaluateError {
                case LAError.authenticationFailed?:
                    message = "There was a problem verifying your identity."
                case LAError.userCancel?:
                    message = "You pressed cancel."
                case LAError.userFallback?:
                    message = "You pressed password."
                case LAError.biometryNotAvailable?:
                    message = "Face ID/Touch ID is not available."
                case LAError.biometryNotEnrolled?:
                    message = "Face ID/Touch ID is not set up."
                case LAError.biometryLockout?:
                    message = "Face ID/Touch ID is locked."
                default:
                    message = "Face ID/Touch ID may not be configured"
                }
                
                completion(message)
            }
        }
    }
}
