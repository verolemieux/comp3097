//
//  User.swift
//  AcademicScheduler
//
//  Copyright © 2020 Veronyque Lemieux. All rights reserved.
//

import Foundation

class User {
    var firstName: String = "";
    var lastName: String = "";
    var school: String = "";
    var program: String = "";
    var currentTerm: String = "";
    var email: String = "";
    var password: String = "";
    
    init() {}
    
    init(firstName: String, lastName: String, email: String, password: String, school: String, program: String, currentTerm: String) {
        self.firstName = firstName;
        self.lastName = lastName;
        self.school = school;
        self.program = program;
        self.currentTerm = currentTerm;
        self.email = email;
        self.password = password;
    }
}
