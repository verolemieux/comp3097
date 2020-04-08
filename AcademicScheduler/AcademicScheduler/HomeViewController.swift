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
    var taskDict: [Date : [Task]] = [:];
    var objectArr: [Objects] = [];
    
    @IBOutlet weak var HelloUserLabel: UILabel!
    @IBOutlet weak var DateLabel: UILabel!
    @IBOutlet weak var CoursesTableView: UITableView!
    @IBOutlet weak var TasksTableView: UITableView!
    @IBOutlet weak var AddCourseButton: UIButton!
    
    // MARK: Actions
    @IBAction func ShowCoursesView(_ sender: Any) {
        CoursesTableView.isHidden = false;
        TasksTableView.isHidden = true;
        AddCourseButton.isHidden = false;
    }
    
    @IBAction func ShowTasksView(_ sender: Any) {
        CoursesTableView.isHidden = true;
        TasksTableView.isHidden = false;
        AddCourseButton.isHidden = true;
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
        
        //tasks = tasks.sorted(by: {$0.date < $1.date});
        for task in tasks {
            if(taskDict[task.date] == nil) {
                taskDict[task.date] = [];
            }
            taskDict[task.date]?.append(task);
        }
        
        let sortedKeys = taskDict.keys.sorted(by: <);
        for key in sortedKeys {
            objectArr.append(Objects(sectionName: getDate(date: key), sectionObjects: taskDict[key]));
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
             let cell:CustomCourseCell = tableView.dequeueReusableCell(withIdentifier: "CourseCell", for: indexPath) as! CustomCourseCell;
            let course = courses[indexPath.row]
            cell.CourseTitleLabel?.text = course.title;
            cell.CourseDescriptionLabel?.text = course.description;
            cell.CourseGradeLabel?.text = String(Int(course.grade)) + "%";
            cell.CourseProgressView.progress = Float(course.progress);
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
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]?
    {
        if tableView == CoursesTableView {
            let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete" , handler: { (action:UITableViewRowAction, indexPath: IndexPath) -> Void in
                self.courses.remove(at: indexPath.row);
                tableView.deleteRows(at: [indexPath], with: .fade);
            });
            return [deleteAction];
        } else {
//            let completeAction = UITableViewRowAction(style: .default, title: "Complete" , handler: { (action:UITableViewRowAction, indexPath: IndexPath) -> Void in
//                self.objectArr[indexPath.section].sectionObjects[indexPath.row].complete = true;
//            });
//            completeAction.backgroundColor = .green;
//            return [completeAction];
            return nil;
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
