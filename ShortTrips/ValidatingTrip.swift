//
//  Validating.swift
//  ShortTrips
//
//  Created by Joshua Adams on 10/6/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit

struct ValidatingTrip {
  let stateName = "validatingTrip"
  static let sharedInstance = ValidatingTrip()
  
  private var state: TKState
  
  private init() {
    state = TKState(name: stateName)
  }
  
  func getState() -> TKState {
    return state
  }
}
