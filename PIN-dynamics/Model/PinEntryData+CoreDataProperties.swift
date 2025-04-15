//
//  PinEntryData+CoreDataProperties.swift
//  PIN-dynamics
//
//  Created by alex on 03/04/2025.
//
//

import Foundation
import CoreData


extension PinEntryData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PinEntryData> {
        return NSFetchRequest<PinEntryData>(entityName: "PinEntryData")
    }

    @NSManaged public var passcode: String?
    @NSManaged public var dateTime: Date?

}

extension PinEntryData : Identifiable {

}
