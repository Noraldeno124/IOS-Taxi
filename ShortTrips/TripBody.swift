//
//  TripBody.swift
//  ShortTrips
//
//  Created by Matt Luedke on 11/13/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import ObjectMapper

struct TripBody: Mappable {
  var sessionId: Int!
  var medallion: Int?
  var vehicleId: Int!
  var smartCardId: String!
  var deviceUuid: String!
  var deviceTimestamp: NSDate!
  
  init(sessionId: Int, medallion: Int?, vehicleId: Int, smartCardId: String, deviceTimestamp: NSDate) {
    self.sessionId = sessionId
    self.medallion = medallion
    self.vehicleId = vehicleId
    self.smartCardId = smartCardId
    self.deviceUuid = UIDevice.currentDevice().identifierForVendor!.UUIDString
    self.deviceTimestamp = deviceTimestamp
  }
  
  init?(_ map: Map){}
  
  mutating func mapping(map: Map) {
    sessionId <- map["session_id"]
    medallion <- map["medallion"]
    vehicleId <- map["vehicle_id"]
    smartCardId <- map["driver_card_id"]
    deviceUuid <- map["device_uuid"]
    deviceTimestamp <- (map["device_timestamp"], TripDateTransform)
  }
}
