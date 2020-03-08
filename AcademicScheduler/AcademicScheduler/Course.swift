//
//  Course.swift
//  AcademicScheduler
//
//  Copyright © 2020 Veronyque Lemieux. All rights reserved.
//

import Foundation

class Course {
    var title: String = "";
    var description: String = "";
    var grade: Float = 0;
    var progress: Float = 0;
    var syllabus: String = "";
    
    init() {}
    
    init(title: String, description: String, syllabus: String){
        self.title = title;
        self.description = description;
        self.syllabus = syllabus;
    }
    
    func updateGrade(){
        
    }
    
    func updateProgress(){
        
    }
}
