//
//  LoggedOut.swift
//  ShortTrips
//
//  Created by Joshua Adams on 11/3/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit

struct LoggedOut {
  let eventNames = ["loggedOut"]
  static let sharedInstance = LoggedOut()
  
  fileprivate var events: [TKEvent]
  
  private init() {
    events = [TKEvent(name: eventNames[0],
      transitioningFromStates: StateManager.allStates,
      to: NotReady.sharedInstance.getState())]
  }
}

extension LoggedOut: Event {
  func getEvents() -> [TKEvent] {
    return events
  }
}

extension LoggedOut: Observable {
  func eventIsFiring(_ info: Any?) {
    
    NotificationCenter.default.post(name: .logout, object: nil)
    
    if let tripId = TripManager.sharedInstance.getTripId(),
      let sessionId = DriverManager.sharedInstance.getCurrentDriver()?.sessionId {

      ApiClient.invalidate(tripId, invalidation: .userLogout, sessionId: sessionId)
      TripManager.sharedInstance.reset(false)
      
      if let location = LocationManager.sharedInstance.getLastKnownLocation(),
        let sessionId = DriverManager.sharedInstance.getCurrentDriver()?.sessionId {
        
        ApiClient.updateMobileState(.loggedOut, mobileStateInfo: MobileStateInfo(longitude: location.coordinate.longitude,
                                                                                 latitude: location.coordinate.latitude,
                                                                                 sessionId: sessionId,
                                                                                 tripId: tripId))
      }
    }
  }
}
