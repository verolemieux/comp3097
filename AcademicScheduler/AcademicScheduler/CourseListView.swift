//
//  CourseListView.swift
//  AcademicScheduler
//
//  Copyright © 2020 Veronyque Lemieux. All rights reserved.
//

import Foundation
import SwiftUI

struct CourseListView: View {
    var courses = ["COMP3097", "COMP3133", "COMP3132"];
    
    var body: some View {
        NavigationView {
            List {
                Text(courses[0])
                Text(courses[1])
                Text(courses[2])
            }.navigationBarTitle("Courses")
        }
    }
}
