//
//  Course.swift
//  AcademicScheduler
//
//  Copyright © 2020 Veronyque Lemieux, Jeremy Thibeau, Sergio Lombana. All rights reserved.
//

import Foundation

class Course {
    var title: String = "";
    var description: String = "";
    var grade: Double = 0.0;
    var progress: Double = 0.0;
    var syllabus: String = "";
    var tasks: [Task] = [];
    
    init() {}
    
    init(title: String, description: String, syllabus: String, tasks: [Task]){
        self.title = title;
        self.description = description;
        self.syllabus = syllabus;
        self.tasks = tasks;
    }
    
    func addTask(task: Task) {
        tasks.append(task);
    }
    
    func updateGrade(grade: Double) {
        self.grade = grade;
    }
    
    func updateProgress(progress: Double) {
        self.progress = progress;
    }
    
    func calculateCourseGradeAndProgress() {
        var totalCompletedWeight = 0.0;
        var totalGradedWeight = 0.0;
        var totalGradedGrade = 0.0;
        for task in self.tasks {
            if (task.grade != -1) {
                totalGradedGrade += Double(task.grade/100 * task.weight);
                totalGradedWeight += Double(task.weight);
            }
            if (task.complete){
                totalCompletedWeight += Double(task.weight);
            }
        }
        self.grade = totalGradedWeight > 0 ? Double(totalGradedGrade / totalGradedWeight * 100) : 0;
        self.progress = Double(totalCompletedWeight / 100);
    }
}
