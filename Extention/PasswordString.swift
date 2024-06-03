//
//  PasswordString.swift
//  CWK2Template
//
//  Created by khandakar hossin on 24/12/2023.
//  Knowledge gathered from Lecture, Google and Youtube contents

// User Credential:
//       userEmail = krhossin@yahoo.co.uk
//       userPassword = Ib1422895165@

import Foundation

extension String {
    func isPasswordValid() -> Bool {
        // Define the password requirements
        // Example: Minimum 8 characters, at least one uppercase, one lowercase, one number and one special character
        let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$"

        // Create a predicate from the regex and evaluate it with the password
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: self)
    }
}

