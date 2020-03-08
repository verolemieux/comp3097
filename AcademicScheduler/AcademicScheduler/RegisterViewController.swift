//
//  RegisterViewController.swift
//  AcademicScheduler
//
//  Copyright © 2020 Veronyque Lemieux. All rights reserved.
//

import Foundation
import UIKit

class RegisterViewController: UIViewController {
    // MARK: Properties
    @IBOutlet weak var FirstNameTextField: UITextField!
    @IBOutlet weak var LastNameTextField: UITextField!
    @IBOutlet weak var SchoolTextField: UITextField!
    @IBOutlet weak var ProgramTextField: UITextField!
    @IBOutlet weak var CurrentTermTextField: UITextField!
    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    
    // MARK: Actions
    @IBAction func RegisterButton(_ sender: Any) {
        let firstName = FirstNameTextField.text!;
        let lastName = LastNameTextField.text!;
        let school = SchoolTextField.text!;
        let program = ProgramTextField.text!;
        let currentTerm = CurrentTermTextField.text!;
        let email = EmailTextField.text!;
        let password = PasswordTextField.text!;
        
        let user = User(firstName: firstName, lastName: lastName, email: school, password: program, school: currentTerm, program: email, currentTerm: password);
        // add user to database
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
