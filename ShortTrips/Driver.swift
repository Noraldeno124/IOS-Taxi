//
//  Driver.swift
//  ShortTrips
//
//  Created by Joshua Adams on 9/14/15.
//  Copyright (c) 2015 SFO. All rights reserved.
//

import Foundation
import ObjectMapper

struct Driver: Mappable {
  var sessionId: Int!
  var driverId: Int!
  var cardId: Int!
  var firstName: String!
  var lastName: String!
  var driverLicense: String!

  init(sessionId: Int, driverId: Int, cardId: Int, firstName: String, lastName: String, driverLicense: String) {
    self.sessionId = sessionId
    self.driverId = driverId
    self.cardId = cardId
    self.firstName = firstName
    self.lastName = lastName
    self.driverLicense = driverLicense
  }

  init?(_ map: Map){}

  mutating func mapping(map: Map) {
    sessionId <- map["response.session_id"]
    driverId <- map["response.driver_id"]
    cardId <- map["response.card_id"]
    firstName <- map["response.first_name"]
    lastName <- map["response.last_name"]
    driverLicense <- map["response.driver_license"]
  }
}