//
//  OutsideShortTripGeofence.swift
//  ShortTrips
//
//  Created by Joshua Adams on 11/2/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit

struct OutsideShortTripGeofence {
  let eventNames = ["outsideShortTripGeofence"]
  static let sharedInstance = OutsideShortTripGeofence()
  
  fileprivate var events: [TKEvent]
  
  fileprivate init() {
    events = [TKEvent(name: eventNames[0],
      transitioningFromStates: StateManager.allStates,
      to: NotReady.sharedInstance.getState())]
  }
}

extension OutsideShortTripGeofence: Event {
  func getEvents() -> [TKEvent] {
    return events
  }
}

extension OutsideShortTripGeofence: Observable {
  func eventIsFiring(_ info: Any?) {
    
    NotificationCenter.default.post(name: .outsideShortTrip, object:nil)

    if let tripId = TripManager.sharedInstance.getTripId(),
      let sessionId = DriverManager.sharedInstance.getCurrentDriver()?.sessionId {

      DriverManager.sharedInstance.callWithValidSession {
        ApiClient.invalidate(tripId, invalidation: .geofence, sessionId: sessionId)
      }
      TripManager.sharedInstance.reset(false)
    }
  }
}
