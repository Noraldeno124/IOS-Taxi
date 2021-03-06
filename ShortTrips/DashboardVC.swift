//
//  DashboardVC.swift
//  ShortTrips
//
//  Created by Matt Luedke on 7/15/15.
//  Copyright (c) 2015 SFO. All rights reserved.
//

import UIKit
import MBProgressHUD

class DashboardVC: UIViewController {
  
  private var errorShown = false
  
  override func loadView() {
    let dashboardView = DashboardView(frame: UIScreen.main.bounds)
    dashboardView.setReachabilityNoticeHidden(ReachabilityManager.sharedInstance.isReachable())
#if DEBUG
    let secretSwipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(DashboardVC.openDebugMode))
    secretSwipeRecognizer.numberOfTouchesRequired = 2
    secretSwipeRecognizer.direction = .down
    dashboardView.addGestureRecognizer(secretSwipeRecognizer)
#endif
    view = dashboardView
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.title = ""
    configureNavBar(title: NSLocalizedString("Holding Lot", comment: "").uppercased())
    addSettingsAndSecurityButtons()
    
    let nc = NotificationCenter.default
    
    nc.addObserver(
      self,
      selector: #selector(stopTimer),
      name: .UIApplicationDidEnterBackground,
      object: nil)
    
    nc.addObserver(
      self,
      selector: #selector(startTimer),
      name: .UIApplicationWillEnterForeground,
      object: nil)
    
    nc.addObserver(forName: .reachabilityChanged, object: nil, queue: nil) { note in
      let reachable = note.userInfo![InfoKey.reachable] as! Bool
      self.dashboardView().setReachabilityNoticeHidden(reachable)
    }

    nc.addObserver(forName: .pushReceived, object: nil, queue: nil) { note in
      self.dashboardView().forceUpdateTimerView()
    }
  }

  func startTimer() {
    dashboardView().startTimerView(60, callback: requestLotStatus)
  }
  
  func stopTimer() {
    dashboardView().stopTimerView()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    startTimer()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    stopTimer()
  }
    
  func dashboardView() -> DashboardView {
    return self.view as! DashboardView
  }
    
  func requestLotStatus() {
    var requestsInProgress = 2
    let hud = MBProgressHUD.showAdded(to: view, animated: true)
    hud.label.text = NSLocalizedString("Requesting Lot Status", comment: "")
    
    ApiClient.requestQueueLength { length in
      
      requestsInProgress -= 1
      if requestsInProgress == 0 {
        hud.hide(animated: true)
      }
      
      if let length = length {
        self.dashboardView().updateSpots(length.longQueueLength)
        
      } else if !self.errorShown
        && self.tabBarController?.selectedIndex == MainTabs.lot.rawValue
        && self.navigationController?.visibleViewController == self {
          
          UiHelpers.displayErrorMessage(self, message: NSLocalizedString("An error occurred while fetching parking-lot data.", comment: ""))
          self.errorShown = true
      }
    }
    
    ApiClient.fetchCone { cone in
      requestsInProgress -= 1
      if requestsInProgress == 0 {
        hud.hide(animated: true)
      }
      
      if let cone = cone {
        if cone.isValid() {
          self.dashboardView().updateForCone(cone)
        }
      } else if !self.errorShown
        && self.tabBarController?.selectedIndex == MainTabs.lot.rawValue
        && self.navigationController?.visibleViewController == self {
        
        UiHelpers.displayErrorMessage(self, message: NSLocalizedString("An error occurred while fetching parking-lot data.", comment: ""))
        self.errorShown = true
      }
    }
  }
  
  func openDebugMode() {
    navigationController?.pushViewController(DebugVC(), animated: true)
  }
}
