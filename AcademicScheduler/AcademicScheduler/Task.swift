//
//  Task.swift
//  AcademicScheduler
//
//  Copyright © 2020 Veronyque Lemieux. All rights reserved.
//

import Foundation

class Task {
    var title: String = "";
    var description: String = "";
    var date: Date = Date();
    var type: String = "";
    var course: Course = Course();
    var weight: Float = 0.0;
    var grade: Float = 0.0;
    var complete: Bool = false;
    
    init() {}
    
    init(title: String, description: String, date: Date, type: String, course: Course, weight: Float, grade: Float, complete: Bool){
        self.title = title;
        self.description = description;
        self.date = date;
        self.type = type;
        self.course = course;
        self.weight = weight;
        self.grade = grade;
        self.complete = complete;
    }
}
