//
//  HomeViewController.swift
//  AcademicScheduler
//
//  Copyright © 2020 Veronyque Lemieux. All rights reserved.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {
    
    func getDate() -> String {
        let date = Date();
        let format = DateFormatter();
        format.dateFormat = "EEEE";
        let dayOfWeek = format.string(for: date);
        return dayOfWeek!;
    }
    
    @IBOutlet weak var HelloUserLabel: UILabel!
    
    @IBOutlet weak var DateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        HelloUserLabel.text = "Hello, Vero";
        DateLabel.text = getDate();
    }
}
