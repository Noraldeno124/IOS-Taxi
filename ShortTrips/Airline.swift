//
//  Airline.swift
//  ShortTrips
//
//  Created by Matt Luedke on 9/24/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import ObjectMapper

struct Airline: Mappable {
  var airlineCode: String!
  var airlineName: String!
  
  init(airlineCode: String, airlineName: String) {
    self.airlineCode = airlineCode
    self.airlineName = airlineName
  }
  
  init?(_ map: Map){}
  
  mutating func mapping(map: Map) {
    airlineCode <- map["airlineCode"]
    airlineName <- map["airlineName"]
  }  
}