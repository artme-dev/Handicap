//
//  CourseRepository.swift
//  HandicapCalculator
//
//  Created by Артём on 22.09.2021.
//

import Foundation

struct CourseInfo {
    let name: String
    let slope: Int64
    let rating: Double
}

struct ScoreInfo {
    let course: CourseInfo
    let date: Date
    let pcc: Double
    let grossScore: Double
}

protocol ScoresRepositoryProtocol {
    
    func createScore(scoreViewData: ScoreInfo)
    
    func editScore(_ score: Score, using: ScoreInfo)
    
    func getScores() -> [Score]?
    
    func deleteScore(_: Score)
}

class ScoresRepository: ScoresRepositoryProtocol {
    private let repository: CoreDataRepository<Score>
    
    init(repository: CoreDataRepository<Score>) {
        self.repository = repository
    }
    
    func createScore(scoreViewData scoreInfo: ScoreInfo) {
        do {
            let score = try repository.create()
            editScore(score, using: scoreInfo)
        } catch {
            print("Error: \(error)")
        }
    }
    
    func editScore(_ score: Score, using scoreInfo: ScoreInfo) {
        let courseInfo = scoreInfo.course
        score.name = courseInfo.name
        score.courseSlope = courseInfo.slope
        score.courseRating = courseInfo.rating
        score.date = scoreInfo.date
        score.pcc = scoreInfo.pcc
        score.grossScore = scoreInfo.grossScore
        
        do {
            score.updateHandicapDifferential()
            try repository.applyChanges()
        } catch {
            print("Error: \(error)")
        }
    }
    
    func getScores() -> [Score]? {
        do {
            let sortDescripotor = NSSortDescriptor(keyPath: \Score.date, ascending: false)
            let scores = try repository.get(using: nil,
                                            sortDescriptors: [sortDescripotor])
            return scores
        } catch {
            print("Error: \(error)")
            return nil
        }
    }
    
    func deleteScore(_ score: Score) {
        do {
            try repository.delete(entity: score)
            try repository.applyChanges()
        } catch {
            print("Error: \(error)")
        }
    }
}
