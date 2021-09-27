//
//  File.swift
//  HandicapCalculator
//
//  Created by Артём on 23.09.2021.
//

import Foundation

protocol ScoresView: AnyObject {
    
    func showScores(_ scores: [ScoreViewData])
    
    func showScoreInfo(_ score: ScoreViewData)
    
    func hideScoreInfo()
    
    func showAlertMessage(_ message: String, titled title: String)
}

protocol ScoresPresenterProtocol {
    
    func updateScores()
    
    func createScores(_ score: ScoreViewData)
    
    func deleteScore(withIndex index: Int)
    
    func selectScore(withIndex index: Int)
    
    func editScore(scoreViewData: ScoreViewData)
}

class ScoresPresenter: ScoresPresenterProtocol {
    private let repository: ScoresRepositoryProtocol
    weak var view: ScoresView?
    
    private var showedScores: [Score]?
    private var selectedScoreIndex: Int?
    
    private let dateFormatter: DateFormatter  = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM"
        return dateFormatter
    }()
    
    init(repository: ScoresRepositoryProtocol) {
        self.repository = repository
    }
    
    private func preparedString(from value: Double) -> String {
        return String.init(format: "%.1f", value)
    }
    
    private func doubleFromString(_ string: String) -> Double? {
        if let number = Double(string) {
            return number
        }
        
        let formatter = NumberFormatter()
        formatter.decimalSeparator = ","
        return formatter.number(from: string)?.doubleValue
    }
    
    private func getScoreViewData(from score: Score) -> ScoreViewData {
        
        let courseViewData = CourseViewData(name: score.name ?? "",
                                            slope: "\(score.courseSlope)",
                                            rating: preparedString(from: score.courseRating))
        
        guard let date = score.date else {
            fatalError()
        }
    
        let formattedDate = dateFormatter.string(from: date)
        
        return ScoreViewData(courseViewData: courseViewData,
                             formattedDate: formattedDate,
                             date: date,
                             pcc: preparedString(from: score.pcc),
                             grossScore: preparedString(from: score.grossScore),
                             handicapDiff: preparedString(from: score.handicapDifferential))
    }
    
    private func showScores(_ scores: [Score]) {
        let scoresViewData = scores.map {
            getScoreViewData(from: $0)
        }
        view?.showScores(scoresViewData)
        showedScores = scores
    }
    
    // MARK: - CoursesPresenter
    
    func updateScores() {
        guard let scores = repository.getScores() else { return }
        showScores(scores)
    }
    
    private func scoreInfo(from scoreViewData: ScoreViewData) -> ScoreInfo? {
        let courseViewData = scoreViewData.courseViewData
        
        guard
            let courseName = courseViewData.name, !courseName.isEmpty,
            let courseSlope = courseViewData.slope, !courseSlope.isEmpty,
            let courseRating = courseViewData.rating, !courseRating.isEmpty,
            let date = scoreViewData.date,
            let PCC = scoreViewData.pcc, !PCC.isEmpty,
            let grossScore = scoreViewData.grossScore, !grossScore.isEmpty
        else {
            return nil
        }
        
        guard
            let convertedSlope = Int64(courseSlope),
            let convertedRating = doubleFromString(courseRating),
            let convertedPCC = doubleFromString(PCC),
            let convertedGrossScore = doubleFromString(grossScore)
        else {
            return nil
        }
        
        let courseInfo = CourseInfo(name: courseName,
                                    slope: convertedSlope,
                                    rating: convertedRating)
        
        return ScoreInfo(course: courseInfo,
                         date: date,
                         pcc: convertedPCC,
                         grossScore: convertedGrossScore)
    }
    
    func createScores(_ scoreViewData: ScoreViewData) {
        guard let scoreInfo = scoreInfo(from: scoreViewData) else {
            view?.showAlertMessage("Сheck the correctness of the input data!",
                                   titled: "Warning")
            return
        }
        repository.createScore(scoreViewData: scoreInfo)
        
        view?.hideScoreInfo()
        updateScores()
    }
    
    func deleteScore(withIndex index: Int) {
        guard let scores = showedScores else { return }
        let selectedScore = scores[index]
        repository.deleteScore(selectedScore)
        updateScores()
    }
    
    func selectScore(withIndex index: Int) {
        guard let scores = showedScores else { return }
        let selectedScore = scores[index]
        selectedScoreIndex = index
        
        let scoreViewData = getScoreViewData(from: selectedScore)
        view?.showScoreInfo(scoreViewData)
        return
    }
    
    func editScore(scoreViewData: ScoreViewData) {
        guard let index = selectedScoreIndex else {
            return
        }
        guard let scores = showedScores else { return }
        let selectedScore = scores[index]
        
        guard let scoreInputInfo = scoreInfo(from: scoreViewData) else {
            view?.showAlertMessage("Сheck the correctness of the input data!",
                                   titled: "Warning")
            return
        }
        repository.editScore(selectedScore, using: scoreInputInfo)
        view?.hideScoreInfo()
        updateScores()
    }
}
