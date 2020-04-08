//
//  CourseFormViewController.swift
//  AcademicScheduler
//
//  Copyright © 2020 Veronyque Lemieux, Jeremy Thibeau, Sergio Lombana. All rights reserved.
//

import Foundation
import UIKit

class CourseFormViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var currentCourse = Course();
    var courses: [Course] = [];
    var selectedTask = Task();
    var inputError: Bool = false;
    
    // MARK: Properties
    @IBOutlet weak var TitleTextField: UITextField!
    @IBOutlet weak var DescriptionTextField: UITextField!
    @IBOutlet weak var SyllabusTextField: UITextField!
    @IBOutlet weak var TaskTableView: UITableView!
    @IBOutlet weak var ErrorMessage: UILabel!
    
    // MARK: Actions
    @IBAction func AddTaskButton(_ sender: UIButton) {
        currentCourse = saveCourse()!;
        selectedTask = Task();
        self.performSegue(withIdentifier: "TaskFormSegue", sender: self)
    }
    
    @IBAction func AddSyllabusButton(_ sender: Any) {
        
    }
    
    @IBAction func SaveCourseButton(_ sender: Any) {
        let course = saveCourse()!;
        
        let index = courses.firstIndex{$0.title == currentCourse.title}
        if index == nil {
            courses.append(course);
        } else {
            courses[index!] = course;
        }
        
        currentCourse = course;
        
        if shouldPerformSegue(withIdentifier: "HomeSegue", sender: self) {
            performSegue(withIdentifier: "HomeSegue", sender: self);
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "TaskFormSegue" {
            let vc = segue.destination as? TaskFormViewController;
            vc?.courses = courses;
            vc?.currentCourse = currentCourse;
            if !selectedTask.title.isEmpty {
                vc?.selectedTask = selectedTask;
            }
        }
        
        if segue.identifier == "HomeSegue" {
            let vc = segue.destination as? HomeViewController;
            vc?.courses = courses;
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if inputError  {
             return false
        }
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "New Course";
        
        ErrorMessage.isHidden = true;
        
        self.TaskTableView.delegate = self;
        self.TaskTableView.dataSource = self;
                
        if !currentCourse.title.isEmpty {
            navigationItem.title = "Edit Course";
            TitleTextField.text = currentCourse.title;
            DescriptionTextField.text = currentCourse.description;
            SyllabusTextField.text = currentCourse.syllabus;
        }
    }
    
    func saveCourse() -> Course? {
        let title = TitleTextField.text!;
        let description = DescriptionTextField.text!;
        let syllabus = SyllabusTextField.text!;
        let tasks = currentCourse.tasks;
        let grade = currentCourse.grade;
        let progress = currentCourse.progress;
        
        if title.isEmpty {
            inputError = true;
            ErrorMessage.isHidden = false;
        } else {
            inputError = false;
            ErrorMessage.isHidden = true;
            let course = Course(title: title, description: description, syllabus: syllabus, tasks: tasks);
            course.updateGrade(grade: grade);
            course.updateProgress(progress: progress);
            return course;
        }
        return nil;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentCourse.tasks.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath);
        let task = currentCourse.tasks[indexPath.row]
        cell.textLabel?.text = task.title;
        cell.detailTextLabel?.text = task.grade != -1 ? String(Int(task.grade)) + "%" : "Ungraded";
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedTask = currentCourse.tasks[indexPath.row]
        self.performSegue(withIdentifier: "TaskFormSegue", sender: self)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            currentCourse.tasks.remove(at: indexPath.row);
            currentCourse.calculateCourseGradeAndProgress();
            tableView.deleteRows(at: [indexPath], with: .fade);
        }
    }
}
