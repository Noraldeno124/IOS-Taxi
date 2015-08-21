//
//  FlightStatusVC.swift
//  ShortTrips
//
//  Created by Joshua Adams on 7/31/15.
//  Copyright (c) 2015 SFO. All rights reserved.
//

import Foundation
import UIKit

class FlightStatusVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
  enum TableSection: Int {
    case Header = 0
    case Content = 1
  }
  
  @IBOutlet var flightTable: UITableView!
  @IBOutlet var updateLabel: UILabel!
  @IBOutlet var updateProgress: UIProgressView!
  
  var selectedTerminalId: TerminalId!
  var currentTime: Float?
  var flights: [Flight]?
  var delayRatio: Double?
  var terminal: Int?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    flightTable.dataSource = self
    flightTable.delegate = self
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    switch selectedTerminalId! {
    case .One:
      terminal = 1
    case .Two:
      terminal = 2
    case .Three:
      terminal = 3
    case .International:
      terminal = 4
    }
    updateFlightTable()
    UpdateTimer.start(updateProgress, updateLabel: updateLabel, callback: updateFlightTable)
    navigationController!.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: UiConstants.navControllerFont, size: UiConstants.navControllerFontSizeSmall)!, NSForegroundColorAttributeName: UIColor.whiteColor()]
    setupTitle()
  }
  
  override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(animated)
    navigationController!.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: UiConstants.navControllerFont, size: UiConstants.navControllerFontSizeNormal)!, NSForegroundColorAttributeName: UIColor.whiteColor()]
    UpdateTimer.stop()
  }
  
  func setupTitle() {
    var title: String = ""
    if currentTime < 0.0 {
      currentTime = currentTime! * -1.0
      switch selectedTerminalId! {
      case .One:
        title = String(format: NSLocalizedString("Term. One %.1f Hours Ago", comment: ""), currentTime!)
      case .Two:
        title = String(format: NSLocalizedString("Term. Two %.1f Hours Ago", comment: ""), currentTime!)
      case .Three:
        title = String(format: NSLocalizedString("Term. Three %.1f Hours Ago", comment: ""), currentTime!)
      case .International:
        title = String(format: NSLocalizedString("Inter. Term. %.1f Hours Ago", comment: ""), currentTime!)
      }
    }
    else if currentTime > 0.0 {
      switch selectedTerminalId! {
      case .One:
        title = String(format: NSLocalizedString("Term. One in %.1f Hours", comment: ""), currentTime!)
      case .Two:
        title = String(format: NSLocalizedString("Term. Two in %.1f Hours", comment: ""), currentTime!)
      case .Three:
        title = String(format: NSLocalizedString("Term. Three in %.1f Hours", comment: ""), currentTime!)
      case .International:
        title = String(format: NSLocalizedString("Inter. Term. in %.1f Hours", comment: ""), currentTime!)
      }
    }
    else if currentTime == 0.0 {
      switch selectedTerminalId! {
      case .One:
        title = NSLocalizedString("Term. One Currently", comment: "")
      case .Two:
        title = NSLocalizedString("Term. Two Currently", comment: "")
      case .Three:
        title = NSLocalizedString("Term. Three Currently", comment: "")
      case .International:
        title = NSLocalizedString("Inter. Term. Currently", comment: "")
      }
    }
    navigationItem.title = title
  }
  
  func updateFlightTable() {
    SfoInfoRequester.requestFlights({ (flights, error) -> Void in
      if let flights = flights {
        self.flights = flights
        println("Successfully retrieved flights.")
      }
      else {
        println("error: \(error)")
        self.flights = FlightMock.mockFlights()
      }
      self.flightTable.reloadData()
      let path: NSIndexPath = NSIndexPath(forRow: 0, inSection: 1)
      self.flightTable.scrollToRowAtIndexPath(path, atScrollPosition: UITableViewScrollPosition.Top, animated: false)
      self.computeDelay()
      }, terminal: terminal!, time: currentTime!)
  }
  
  func computeDelay() {
    var totalFlights = 0
    var delayedFlights = 0
    if let flights = flights {
        for flight in flights {
            switch flight.flightStatus {
            case .Some(.Delayed):
                totalFlights++
                delayedFlights++
            case .Some(.Landing):
                totalFlights++
            case .Some(.OnTime):
                totalFlights++
            default:
                break
            }
        }
    }
    
    delayRatio = Double(delayedFlights) / Double(totalFlights)
  }
  
  // MARK: UITableView
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 3
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if let flights = flights {
      if section == 0 || section == 1 {
        return 1
      }
      else {
        return flights.count
      }
    }
    else {
      return 0
    }
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    if indexPath.section == 2 {
      let cell = tableView.dequeueReusableCellWithIdentifier("flightCell", forIndexPath: indexPath) as! FlightCell
      if let flights = flights {
        cell.displayFlight(flights[indexPath.row])
      }
      return cell
    }
    else if indexPath.section == 1 {
      let cell = tableView.dequeueReusableCellWithIdentifier("backgroundCell", forIndexPath: indexPath) as! BackgroundCell
      computeDelay()
      cell.displayFlightTableTitle(delayRatio!)
      return cell
    }
    else { // indexPath.section == 0
      return tableView.dequeueReusableCellWithIdentifier("blankCell", forIndexPath: indexPath) as! BlankCell
    }
  }
  
  
  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    if indexPath.section == 0 {
      return UiConstants.blankCellHeight
    }
    else if indexPath.section == 1 {
      return UiConstants.backgroundCellHeight
    }
    else { // indexPath.section == 2
      return UiConstants.flightCellHeight
    }
  }

}