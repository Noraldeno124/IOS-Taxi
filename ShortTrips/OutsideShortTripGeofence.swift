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
  
  private var events: [TKEvent]
  
  private init() {
    events = [TKEvent(name: eventNames[0],
      transitioningFromStates: [InProgress.sharedInstance.getState()],
      toState: NotReady.sharedInstance.getState())]
  }
}

extension OutsideShortTripGeofence: Event {
  func getEvents() -> [TKEvent] {
    return events
  }
}