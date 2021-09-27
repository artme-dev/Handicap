//
//  HadicapPresenter.swift
//  Handicap
//
//  Created by Артём on 23.09.2021.
//

import Foundation

protocol HandicapPresenterProtocol: AnyObject {
    func getHandicapIndex() -> String?
}

class HandicapPresenter: HandicapPresenterProtocol {
    
    private let scoresRepository: ScoresRepositoryProtocol
    
    init(repository: ScoresRepositoryProtocol) {
        scoresRepository = repository
    }
    
    func getHandicapIndex() -> String? {
        guard let scores = scoresRepository.getScores() else {
            return nil
        }

        let index = HandicapIndexCalculator.getIndex(from: scores)
        guard let index = index else {
            return nil
        }
        return String.init(format: "%.1f", index)
    }
}
 
