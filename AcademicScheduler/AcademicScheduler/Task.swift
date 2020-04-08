//
//  Task.swift
//  AcademicScheduler
//
//  Copyright © 2020 Veronyque Lemieux, Jeremy Thibeau, Sergio Lombana. All rights reserved.
//

import Foundation

class Task {
    var title: String = "";
    var description: String = "";
    var date: Date = Date();
    var type: String = "";
    var weight: Double = 0.0;
    var grade: Double = -1.0;
    var complete: Bool = false;
    var course: Course = Course();
    
    init() {}
    
    init(title: String, description: String, date: Date, type: String, weight: Double, grade: Double, complete: Bool){
        self.title = title;
        self.description = description;
        self.date = date;
        self.type = type;
        self.weight = weight;
        self.grade = grade;
        self.complete = complete;
    }
    
    func setCourse(parentCourse: Course) {
        course = parentCourse;
    }
    
    func setComplete() {
        self.complete = true;
    }
}
