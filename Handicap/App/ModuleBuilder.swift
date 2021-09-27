//
//  ModuleBuilder.swift
//  HandicapCalculator
//
//  Created by Артём on 22.09.2021.
//

import UIKit

class ModuleBuilder {
    
    static func getScoresRepository() -> ScoresRepositoryProtocol {
        let coreDataStack = CoreDataStack.shared
        let coreDataContext = coreDataStack.getViewContext()
        let coreDataRepository = CoreDataRepository<Score>(managedObjectContext: coreDataContext)
        return ScoresRepository(repository: coreDataRepository)
    }
    
    static func createScoreModule() -> UIViewController {
        let presenter = ScoresPresenter(repository: getScoresRepository())
        let viewController = ScoresTableViewController()
        viewController.presenter = presenter
        presenter.view = viewController
        
        return viewController
    }
    
    static func createHandicapModule() -> UIViewController {
        let presenter = HandicapPresenter(repository: getScoresRepository())
        let viewController = HandicapViewController()
        viewController.presenter = presenter
        
        return viewController
    }
    
}
