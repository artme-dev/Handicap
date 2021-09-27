//
//  ScoreExtension.swift
//  HandicapCalculator
//
//  Created by Артём on 20.09.2021.
//

import Foundation

extension Score {
    
    func configure(name: String,
                   courseSlope: Int64,
                   courseRating: Double,
                   grossScore: Double,
                   date: Date? = nil,
                   PCC: Double = 0) {
        
        self.name = name
        self.courseSlope = courseSlope
        self.courseRating = courseRating
        self.date = date
        self.grossScore = grossScore
        self.pcc = PCC
    }
    
    func updateHandicapDifferential() {
        let differential = (113.0 / Double(courseSlope)) * (grossScore - courseRating - pcc)
        handicapDifferential = Double(round(10*differential)/10)
    }
}
