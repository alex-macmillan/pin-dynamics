//
//  PinInputData+CoreDataProperties.swift
//  PIN-dynamics
//
//  Created by alex on 03/04/2025.
//
//

import Foundation
import CoreData


extension PinInputData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PinInputData> {
        return NSFetchRequest<PinInputData>(entityName: "PinInputData")
    }

    @NSManaged public var dateTime: Date?
    @NSManaged public var passcode: String?

}

extension PinInputData : Identifiable {

}
