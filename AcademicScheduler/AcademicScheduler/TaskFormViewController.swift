//
//  TaskFormViewController.swift
//  AcademicScheduler
//
//  Copyright © 2020 Veronyque Lemieux. All rights reserved.
//

import Foundation
import UIKit

class TaskFormViewController: UIViewController {
    
    // MARK: Properties
    @IBOutlet weak var TitleTextField: UITextField!
    @IBOutlet weak var DescriptionTextField: UITextField!
    @IBOutlet weak var TypeTextField: UITextField!
    @IBOutlet weak var WeightTextField: UITextField!
    @IBOutlet weak var GradeTextField: UITextField!
    @IBOutlet weak var DatePicker: UIDatePicker!
    @IBOutlet weak var CompletedSwitch: UISwitch!
    
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
        let course = Course(); // find a way to pass the course from course form
        let weight = Float(WeightTextField.text!)!;
        let grade = Float(GradeTextField.text!)!;
        let date = DatePicker.date;
        let complete = CompletedSwitch.isOn;
        
        let task = Task(title: title, description: description, date: date, type: type, course: course, weight: weight, grade: grade, complete: complete);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GradeTextField.isUserInteractionEnabled = false;
        GradeTextField.backgroundColor = UIColor.lightGray;
    }
}
