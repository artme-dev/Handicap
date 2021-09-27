//
//  CourseViewData.swift
//  HandicapCalculator
//
//  Created by Артём on 22.09.2021.
//

import Foundation

struct ScoreViewData {
    let courseViewData: CourseViewData
    let formattedDate: String?
    let date: Date?
    let pcc: String?
    let grossScore: String?
    let handicapDiff: String?
}

struct CourseViewData {
    let name: String?
    let slope: String?
    let rating: String?
}
