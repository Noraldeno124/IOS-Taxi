//
//  WaitingInHoldingLot.swift
//  ShortTrips
//
//  Created by Joshua Adams on 10/27/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit

struct WaitingInHoldingLot {
  let stateName = "waitingInHoldingLot"
  static let sharedInstance = WaitingInHoldingLot()
  
  private var state: TKState
  
  private init() {
    state = TKState(name: stateName)
  }
  
  func getState() -> TKState {
    return state
  }
}
