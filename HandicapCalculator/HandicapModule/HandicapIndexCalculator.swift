//
//  HandicapIndexCalculator.swift
//  Handicap
//
//  Created by Артём on 23.09.2021.
//

import Foundation

class HandicapIndexCalculator {
    static func getIndex(from scores: [Score]) -> Double? {
    
        let firstTwentyScoresCount = scores.count < 20 ? scores.count : 20
        let firstTwentyScores = scores[..<firstTwentyScoresCount]
        
        let differencials = firstTwentyScores
            .map { score in
                score.handicapDifferential
            }
            .sorted(by: <)
        
        let usedCoursesCount = usedCoursesCount(from: firstTwentyScoresCount)
        let indexAdjustment = indexAdjustment(totalCoursesCount: firstTwentyScoresCount) ?? 0
        guard let usedCoursesCount = usedCoursesCount else {
            return nil
        }
        
        let usedScoresDiff = differencials[..<usedCoursesCount]
        let average = usedScoresDiff.reduce(0.0, +) / Double(usedScoresDiff.count)
        
        return average - Double(indexAdjustment)
    }
    
    private static func usedCoursesCount(from totalCoursesCount: Int) -> Int? {
        guard totalCoursesCount >= 3 else { return nil }
        if totalCoursesCount >= 20 { return 8 }
        
        switch totalCoursesCount {
        case 3...5:
            return 1
        case 6...8:
            return 2
        case 9...11:
            return 3
        case 12...14:
            return 4
        case 15...16:
            return 5
        case 17...18:
            return 6
        case 19:
            return 7
        default:
            return nil
        }
    }
    
    private static func indexAdjustment(totalCoursesCount: Int) -> Int? {
        guard totalCoursesCount > 0 else { return nil }
        
        switch totalCoursesCount {
        case 3:
            return 2
        case 4:
            return 1
        case 6:
            return 1
        default:
            return 0
        }
    }
}
