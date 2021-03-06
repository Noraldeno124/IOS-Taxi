//
//  DashboardVCSpec.swift
//  ShortTrips
//
//  Created by Matt Luedke on 9/11/15.
//  Copyright (c) 2015 SFO. All rights reserved.
//

@testable import ShortTrips
import Quick
import Nimble
import PivotalCoreKit

class DashboardVCSpec: QuickSpec {

  override func spec() {
    
    var viewController: DashboardVC!
    
    describe("the dashboard view controller") {
      
      beforeEach {
        
        if !Url.isDevUrl() {
          fatalError("can't call this when not logged in")
        }
        
        viewController = DashboardVC()
        let navigationController = UINavigationController(rootViewController: viewController)
        
        UIApplication.shared.keyWindow!.rootViewController = navigationController
        let _ = navigationController.view
        let _ = viewController.view
      }
    
      it("is instantiated") {
        expect(viewController).toNot(beNil())
      }
    }
  }
}
