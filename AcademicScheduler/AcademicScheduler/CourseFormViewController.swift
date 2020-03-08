//
//  CourseFormViewController.swift
//  AcademicScheduler
//
//  Copyright © 2020 Veronyque Lemieux. All rights reserved.
//

import Foundation
import UIKit

class CourseFormViewController: UIViewController {
    
    // MARK: Properties
    @IBOutlet weak var TitleTextField: UITextField!
    @IBOutlet weak var DescriptionTextField: UITextField!
    @IBOutlet weak var SyllabusTextField: UITextField!
    
    // MARK: Actions
    @IBAction func AddSyllabusButton(_ sender: Any) {
    }
   
    @IBAction func SaveCourseButton(_ sender: Any) {
        let title = TitleTextField.text!;
        let description = DescriptionTextField.text!;
        let syllabus = SyllabusTextField.text!;
        
        let course = Course(title: title, description: description, syllabus: syllabus);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
