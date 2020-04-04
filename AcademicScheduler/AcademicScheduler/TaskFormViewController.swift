//
//  TaskFormViewController.swift
//  AcademicScheduler
//
//  Copyright © 2020 Veronyque Lemieux, Jeremy Thibeau, Sergio Lombana. All rights reserved.
//

import Foundation
import UIKit

class TaskFormViewController: UIViewController {
    var currentCourse: Course = Course();
    var courses: [Course] = [];
    var selectedTask: Task = Task();
    var inputError: Bool = false;
    
    // MARK: Properties
    @IBOutlet weak var TitleTextField: UITextField!
    @IBOutlet weak var DescriptionTextField: UITextField!
    @IBOutlet weak var TypeTextField: UITextField!
    @IBOutlet weak var WeightTextField: UITextField!
    @IBOutlet weak var GradeTextField: UITextField!
    @IBOutlet weak var DatePicker: UIDatePicker!
    @IBOutlet weak var CompletedSwitch: UISwitch!
    @IBOutlet weak var ErrorMessage: UILabel!
    
    // MARK: Actions
    @IBAction func CompletedSwitch(_ sender: UISwitch) {
        if (CompletedSwitch.isOn) {
            GradeTextField.isUserInteractionEnabled = true;
            GradeTextField.backgroundColor = UIColor.white;
        } else {
            GradeTextField.isUserInteractionEnabled = false;
            GradeTextField.backgroundColor = UIColor.lightGray;
        }
    }
    
    @IBAction func SaveTaskButton(_ sender: UIButton) {
        let title = TitleTextField.text!;
        let description = DescriptionTextField.text!;
        let type = TypeTextField.text!;
        let weight = WeightTextField.text!;
        let grade = Double(GradeTextField.text!) ?? -1.0;
        let date = DatePicker.date;
        let complete = CompletedSwitch.isOn;
        
        if title.isEmpty || weight.isEmpty || Double(weight)!.isNaN {
            inputError = true;
            ErrorMessage.isHidden = false;
        } else {
            inputError = false;
            ErrorMessage.isHidden = true;
            let task = Task(title: title, description: description, date: date, type: type, weight: Double(weight)!, grade: grade, complete: complete);
            let index = currentCourse.tasks.firstIndex{$0 === selectedTask}
            if index == nil {
                currentCourse.tasks.append(task);
            } else {
                currentCourse.tasks[index!] = task;
            }
            
            currentCourse.calculateCourseGradeAndProgress();
        }
        
        if shouldPerformSegue(withIdentifier: "CourseFormSegue", sender: self) {
            performSegue(withIdentifier: "CourseFormSegue", sender: self);
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is CourseFormViewController {
            let vc = segue.destination as? CourseFormViewController
            vc?.currentCourse = currentCourse;
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
        super.viewDidLoad();
        
        ErrorMessage.isHidden = true;
        GradeTextField.isUserInteractionEnabled = false;
        GradeTextField.backgroundColor = UIColor.lightGray;
        
        if !selectedTask.title.isEmpty {
            TitleTextField.text = selectedTask.title;
            DescriptionTextField.text = selectedTask.description;
            TypeTextField.text = selectedTask.type;
            WeightTextField.text = String(selectedTask.weight);
            GradeTextField.text = selectedTask.grade != -1 ? String(selectedTask.grade) : "";
            DatePicker.date = selectedTask.date as Date;
            CompletedSwitch.isOn = selectedTask.complete;
            
            if (selectedTask.complete){
                GradeTextField.isUserInteractionEnabled = true;
                GradeTextField.backgroundColor = UIColor.white;
            }
        }
    }
}
