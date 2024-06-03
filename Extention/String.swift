//
//  String.swift
//  CWK2Template
//
//  Created by khandakar hossin on 24/12/2023.
//  Knowledge gathered from Lecture, Google and Youtube contents

// User Credential:
//       userEmail = krhossin@yahoo.co.uk
//       userPassword = Ib1422895165@

import Foundation

extension String{
    // Function to validate if the string is a valid email address
    func isEmailAddressValid() -> Bool{
        
        // Define the regular expression (regex) for a valid email address
        // This regex checks for a general pattern of an email address:
        // - Begins with alphanumeric characters, including dots, underscores, and percentages
        // - Must contain an '@' symbol
        // - Followed by more alphanumeric characters, including dots for domain part
        // - Ends with a domain suffix of at least two characters (e.g., .com, .org)
        let emailRegex = try! NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}", options: .caseInsensitive)
        
        // Check if the email string matches the regex pattern
        // NSRange is used to search the whole string
        return emailRegex.firstMatch(in: self, range: NSRange(location: 0, length: count)) != nil
    }
    
   
}
