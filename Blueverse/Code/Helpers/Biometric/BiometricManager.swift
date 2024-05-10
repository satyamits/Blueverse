//
//  BiometricManager.swift
//  Blueverse
//
//  Created by Vaibhav Parmar on 01/04/23.
//  Copyright © 2023 Nickelfox. All rights reserved.
//

import Foundation
import LocalAuthentication

extension LAContext: LAContextProtocol {}

protocol LAContextProtocol {
    func canEvaluatePolicy(_: LAPolicy, error: NSErrorPointer) -> Bool
    func evaluatePolicy(_ policy: LAPolicy, localizedReason: String, reply: @escaping (Bool, Error?) -> Void)
}

enum BioError: Error {
    case general
    case noEvaluate
}

class BiometricsManager {
    let context: LAContextProtocol
    
    init(context: LAContextProtocol = LAContext() ) {
        self.context = context
    }
    
    func canEvaluatePolicy() -> Bool {
        return context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
    }
    
   
    func authenticateUser(completion: @escaping (Result<String, BioError>) -> Void) {
        guard canEvaluatePolicy() else {
            completion( .failure(BioError.noEvaluate) )
            return
        }
        
        let loginReason = "Confirm fingerprint to continue"
        
        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: loginReason) { (success, evaluateError) in
            if success {
                DispatchQueue.main.async {
                    // User authenticated successfully
                    completion(.success("Success"))
                }
            } else {
                switch evaluateError {
                default: completion(.failure(BioError.general))
                }

            }
        }
    }
    
    func faceIDAvailable() -> Bool {
        if #available(iOS 11.0, *) {
            let context = LAContext()
            return (context.canEvaluatePolicy(LAPolicy.deviceOwnerAuthentication, error: nil) && context.biometryType == .faceID)
        }
        return false
    }
}
