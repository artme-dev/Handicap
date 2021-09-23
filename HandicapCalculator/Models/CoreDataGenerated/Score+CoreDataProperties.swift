//
//  Score+CoreDataProperties.swift
//  HandicapCalculator
//
//  Created by Артём on 23.09.2021.
//
//

import Foundation
import CoreData

extension Score {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Score> {
        return NSFetchRequest<Score>(entityName: "Score")
    }

    @NSManaged public var date: Date?
    @NSManaged public var grossScore: Double
    @NSManaged public var handicapDifferential: Double
    @NSManaged public var pcc: Double
    @NSManaged public var name: String?
    @NSManaged public var courseRating: Double
    @NSManaged public var courseSlope: Int64

}

extension Score: Identifiable {

}
