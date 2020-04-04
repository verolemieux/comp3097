//
//  HomeViewController.swift
//  AcademicScheduler
//
//  Copyright © 2020 Veronyque Lemieux, Jeremy Thibeau, Sergio Lombana. All rights reserved.
//

import Foundation
import SwiftUI
import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    struct Objects {
        var sectionName : String!
        var sectionObjects : [Task]!
    }
    
    // MARK: Properties
    var courses = DataManager().getCourses();
    var currentCourse = Course();
    var tasks: [Task] = [];
    var taskDict: [String: [Task]] = [:];
    var objectArr: [Objects] = [];
    
    @IBOutlet weak var HelloUserLabel: UILabel!
    @IBOutlet weak var DateLabel: UILabel!
    @IBOutlet weak var CoursesTableView: UITableView!
    @IBOutlet weak var TasksTableView: UITableView!
    
    // MARK: Actions
    @IBAction func ShowCoursesView(_ sender: Any) {
        CoursesTableView.isHidden = false;
        TasksTableView.isHidden = true;
    }
    
    @IBAction func ShowTasksView(_ sender: Any) {
        CoursesTableView.isHidden = true;
        TasksTableView.isHidden = false;
    }
    
    @IBAction func AddCourseButton(_ sender: UIButton) {
        currentCourse = Course();
        self.performSegue(withIdentifier: "CourseFormSegue", sender: self)
    }
    
    func getTasks() {
        for course in courses {
            for task in course.tasks {
                task.setCourse(parentCourse: course);
                tasks.append(task);
            }
        }
        tasks.sort { (Task1, Task2) -> Bool in
            Task1.date < Task2.date
        }
        for task in tasks {
            let date = getDate(date: task.date);
            if(taskDict[date] == nil) {
                taskDict[date] = [];
            }
            taskDict[date]?.append(task);
        }
        for (key, value) in taskDict {
            objectArr.append(Objects(sectionName: key, sectionObjects: value));
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        getTasks();
        
        CoursesTableView.isHidden = false;
        TasksTableView.isHidden = true;
                
        self.navigationItem.setHidesBackButton(true, animated: false)
        HelloUserLabel.text = "Hello, Vero";
        DateLabel.text = getDayOfWeek();
        
        CoursesTableView.delegate = self;
        CoursesTableView.dataSource = self;
        TasksTableView.delegate = self;
        TasksTableView.dataSource = self;
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "CourseFormSegue" {
            let vc = segue.destination as? CourseFormViewController
            vc?.courses = courses;
            if !currentCourse.title.isEmpty {
                vc?.currentCourse = currentCourse;
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == CoursesTableView { return 1 }
        else { return objectArr.count; }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == CoursesTableView { return courses.count; }
        else { return objectArr[section].sectionObjects.count }
    }
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var returnCell = UITableViewCell();
        if tableView == CoursesTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CourseCell", for: indexPath);
            let course = courses[indexPath.row]
            cell.textLabel?.text = course.title;
            cell.detailTextLabel?.text = String(Int(course.grade)) + "%";
            returnCell = cell;
        } else if tableView == TasksTableView {
            let cell:CustomTaskCell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! CustomTaskCell;
            let task = objectArr[indexPath.section].sectionObjects[indexPath.row];
            cell.TaskTitleLabel?.text = task.title;
            cell.TaskTimeLabel?.text = getTimeStamp(date: task.date);
            cell.TaskCourseLabel?.text = task.course.title;
            returnCell = cell;
        }
        return returnCell;
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if tableView == CoursesTableView { return nil }
        else { return objectArr[section].sectionName }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == CoursesTableView {
            currentCourse = courses[indexPath.row]
            self.performSegue(withIdentifier: "CourseFormSegue", sender: self)
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if tableView == CoursesTableView && editingStyle == .delete {
            courses.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func getDayOfWeek() -> String {
        let date = Date();
        let format = DateFormatter();
        format.dateFormat = "EEEE";
        let dayOfWeek = format.string(for: date);
        return dayOfWeek!;
    }
    
    func getTimeStamp(date: Date) -> String {
        let format = DateFormatter();
        format.dateFormat = "h:mma";
        return format.string(for: date)!;
    }
    
    func getDate(date: Date) -> String {
        let format = DateFormatter();
        format.dateFormat = "EEEE - MMMM d, yyyy";
        return format.string(for: date)!;
    }
}
