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
  
  override func loadView() {
    let dashboardView = DashboardView(frame: UIScreen.mainScreen().bounds)
    dashboardView.timerView.start(requestLotStatus, updateInterval: 60)
    let secretSwipeRecognizer = UISwipeGestureRecognizer(target: self, action: "openDebugMode")
    secretSwipeRecognizer.numberOfTouchesRequired = 2
    secretSwipeRecognizer.direction = .Down
    dashboardView.addGestureRecognizer(secretSwipeRecognizer)
    view = dashboardView
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.title = "";
    requestLotStatus()
    configureNavBar(false)
    addLogoutButton()
  }
  
  func dashboardView() -> DashboardView {
    return self.view as! DashboardView
  }
    
  func requestLotStatus() {
    let hud = MBProgressHUD.showHUDAddedTo(view, animated: true)
    hud.labelText = NSLocalizedString("Requesting Lot Status", comment: "")
    ApiClient.requestLotStatus { lotStatus, statusCode in
      
      hud.hide(true)
      
      if let color = lotStatus?.color  {
        self.dashboardView().updateStatusUI(color)
        
      } else {
        var message = NSLocalizedString("An error occurred while fetching parking-lot data.", comment: "")
        
        if Util.debug {
          if let statusCode = statusCode where statusCode != Util.HttpStatusCodes.Ok.rawValue {
            message += NSLocalizedString("Status code: ", comment: "") + String(statusCode)
          } else {
            message += NSLocalizedString("The status object was nil.", comment:"")
          }
        }
      
        if self.navigationController?.visibleViewController == self {
          UiHelpers.displayErrorMessage(self, message: message)
        }
      }
    }
  }
  
  func openDebugMode() {
    navigationController?.pushViewController(DebugVC(), animated: true)
  }
}
