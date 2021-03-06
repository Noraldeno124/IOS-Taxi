//
//  FlightStatusVC.swift
//  ShortTrips
//
//  Created by Josh Adams on 7/31/15.
//  Copyright (c) 2015 SFO. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD

class FlightStatusVC: UIViewController {
  
  private let minimumSpinnerDuration = TimeInterval(2) // seconds
  private var earliestTimeToDismiss: Date?
  private var timer: Timer?
  private var hud: MBProgressHUD?
  private var alertController: UIAlertController?
  
  var selectedTerminalId: TerminalId!
  var currentHour: Int!
  var flights: [Flight]?
  var flightType: FlightType!
  var errorShown = false
  
  override func loadView() {
    let flightStatusView = FlightStatusView(frame: UIScreen.main.bounds)
    flightStatusView.setReachabilityNoticeHidden(ReachabilityManager.sharedInstance.isReachable())
    flightStatusView.setupTableView(dataSource: self, delegate: self, cellClasses: [(FlightCell.self, FlightCell.identifier)])
    view = flightStatusView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureNavBar(back: true, title: NSLocalizedString("Flight Status", comment: "").uppercased())
    addSettingsAndSecurityButtons()
    
    let nc = NotificationCenter.default
    
    nc.addObserver(
      self,
      selector: #selector(stopTimer),
      name: NSNotification.Name.UIApplicationDidEnterBackground,
      object: nil)
    
    nc.addObserver(
      self,
      selector: #selector(startTimer),
      name: NSNotification.Name.UIApplicationWillEnterForeground,
      object: nil)
    
    nc.addObserver(forName: .reachabilityChanged, object: nil, queue: nil) { note in
      let reachable = note.userInfo![InfoKey.reachable] as! Bool
      self.flightStatusView().setReachabilityNoticeHidden(reachable)
    }
    
    nc.addObserver(forName: .pushReceived, object: nil, queue: nil) { note in
      if let active = note.userInfo![InfoKey.appActive] as? Bool,
        active,
        self.tabBarController?.selectedIndex != MainTabs.lot.rawValue  {
        
        if self.tabBarController?.selectedIndex == MainTabs.flights.rawValue {
          if let title = note.userInfo![InfoKey.pushText] as? String {
            self.hideAndShowAlert(title)
          } else if let message = note.userInfo![InfoKey.pushText] as? [String: String] {
            self.hideAndShowAlert(message["title"], message["body"])
          }
        }
      } else {
        self.tabBarController?.selectedIndex = MainTabs.lot.rawValue
      }
    }
  }
  
  func startTimer() {
    flightStatusView().startTimerView(60 * 5, callback: updateFlightTable)
  }
  
  func stopTimer() {
    flightStatusView().stopTimerView()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    flightStatusView().setHeaderText(selectedTerminalId.asLocalizedString() + " " + flightType.asLocalizedString())
    startTimer()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    stopTimer()
  }
  
  func flightStatusView() -> FlightStatusView {
    return view as! FlightStatusView
  }
  
  func attemptToHideSpinner() {
    if let timeInterval = earliestTimeToDismiss?.timeIntervalSinceNow,
      timeInterval < 0.0 {
      
      hud?.hide(animated: true)
      timer?.invalidate()
    }
  }
  
  func updateFlightTable() {
    hud = MBProgressHUD.showAdded(to: view, animated: true)
    hud?.label.text = NSLocalizedString("Requesting Flights...", comment: "")
    earliestTimeToDismiss = Date().addingTimeInterval(minimumSpinnerDuration)
    
    ApiClient.requestFlightsForTerminal(selectedTerminalId.rawValue, hour: currentHour, flightType: flightType) { flights, statusCode in

      self.timer = Timer.scheduledTimer(timeInterval: 0.1,
        target: self,
        selector: #selector(FlightStatusVC.attemptToHideSpinner),
        userInfo: nil,
        repeats: true)
      
      if let flights = flights , Flight.isValid(flights) {
        self.flights = flights
        self.flightStatusView().reloadTableData()
        
      } else if !self.errorShown {
        var message = NSLocalizedString("An error occurred while fetching flight data.", comment: "")
        
        if Util.debug {
          if let statusCode = statusCode , statusCode != Util.HttpStatusCodes.ok.rawValue {
            message += " " + NSLocalizedString("Status code: ", comment: "") + String(statusCode)
          } else {
            message += " " + NSLocalizedString("The flights object was nil.", comment:"")
          }
        }
        
        UiHelpers.displayErrorMessage(self, message: message)
        self.errorShown = true
      }
    }
  }
  
  func hideAndShowAlert(_ title: String? = nil, _ body: String? = nil) {
    if let alertController = self.alertController {
      alertController.dismiss(animated: true) {
        self.alertController = nil
        self.showNewAlert(title, body)
      }
    } else {
      showNewAlert(title, body)
    }
  }
  
  private func showNewAlert(_ title: String?, _ body: String?) {
    alertController = UIAlertController(title: title, message: body, preferredStyle: .alert)
    let OKAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""),
                                 style: .default) { _ in self.alertController = nil }
    alertController!.addAction(OKAction)
    present(alertController!, animated: true, completion: nil)
  }
}

extension FlightStatusVC: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if let flights = flights {
      return flights.count
    } else {
      return 0
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: FlightCell.identifier, for: indexPath) as! FlightCell
    if let flights = flights {
      cell.displayFlight(flights[(indexPath as NSIndexPath).row], darkBackground: (indexPath as NSIndexPath).row % 2 != 0)
    }
    return cell
  }
}

extension FlightStatusVC: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UiConstants.FlightCell.rowHeight
  }
}
