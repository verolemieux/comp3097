//
//  DataManager.swift
//  AcademicScheduler
//
//  Copyright © 2020 Veronyque Lemieux, Jeremy Thibeau, Sergio Lombana. All rights reserved.
//

import Foundation
import UIKit

class DataManager {
    let coursePath = Bundle.main.path(forResource: "Courses", ofType: "plist");

    func getCourses() -> Array<Course> {
        let rawCourses = NSArray(contentsOfFile: coursePath!)! as Array<AnyObject>;
        var courses: [Course] = [];
        for course in rawCourses {
            let title = course.object(forKey: "title") as! String;
            let description = course.object(forKey: "description") as! String;
            let syllabus = course.object(forKey: "syllabus") as! String;
            //tasks
            let rawTasks = course.object(forKey: "tasks") as! Array<AnyObject>;
            var tasks: [Task] = [];
            for task in rawTasks {
                let taskTitle = task.object(forKey: "title") as! String;
                let taskDescription = task.object(forKey: "description") as! String;
                let date = task.object(forKey: "date") as! Date;
                let type = task.object(forKey: "type") as! String;
                let weight = task.object(forKey: "weight") as! Double;
                let grade = task.object(forKey: "grade") as! Double;
                let complete = task.object(forKey: "complete") as! Bool;
                let newTask = Task(title: taskTitle, description: taskDescription, date: date, type: type, weight: weight, grade: grade, complete: complete);
                tasks.append(newTask);
            }
            let newCourse = Course(title: title, description: description, syllabus: syllabus, tasks: tasks);
            courses.append(newCourse);
        }
        return courses;
    }
    
    func saveCourses() {
        print("SAVE COURSES");
    }
}

