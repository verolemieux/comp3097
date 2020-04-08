//
//  CustomCourseCell.swift
//  AcademicScheduler
//
//  Copyright © 2020 Veronyque Lemieux, Jeremy Thibeau, Sergio Lombana. All rights reserved.
//

import Foundation
import UIKit

class CustomCourseCell: UITableViewCell {
    
    @IBOutlet weak var CourseTitleLabel: UILabel!
    @IBOutlet weak var CourseDescriptionLabel: UILabel!
    @IBOutlet weak var CourseGradeLabel: UILabel!
    @IBOutlet weak var CourseProgressView: UIProgressView!
    
    func viewDidLoad() {
        CourseProgressView.transform = CourseProgressView.transform.scaledBy(x: 1, y: 5);
    }
}
