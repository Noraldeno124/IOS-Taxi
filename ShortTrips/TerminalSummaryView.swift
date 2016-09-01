//
//  TerminalSummaryView.swift
//  ShortTrips
//
//  Created by Matt Luedke on 9/14/15.
//  Copyright (c) 2015 SFO. All rights reserved.
//

import UIKit
import SnapKit

class TerminalSummaryView: UIView {
  
  private let grayView = UIView()
  private let hourPickerView = HourPickerView()
  private let internationalTerminalView = TerminalView()
  private let terminalView1 = TerminalView()
  private let terminalView2 = TerminalView()
  private let terminalView3 = TerminalView()
  private var terminalViews: [TerminalView] = []
  private let timerView = TimerView()
  private let titleTerminalView = TerminalView()
  private let totalTerminalView = TerminalView()
  private let picker = UIPickerView()
  private let pickerShower = UIButton()
  private let pickerTitle = UILabel()
  private let pickerDismissToolbar = UIToolbar()
  private let reachabilityNotice = ReachabilityNotice()

  required init(coder aDecoder: NSCoder) {
    fatalError("This class does not support NSCoding")
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    
    backgroundColor = UIColor.whiteColor()
    
    terminalViews.append(terminalView1)
    terminalViews.append(terminalView2)
    terminalViews.append(terminalView3)
    terminalViews.append(internationalTerminalView)
    for terminalView in terminalViews {
      addSubview(terminalView)
    }
    addSubview(hourPickerView)
    addSubview(timerView)
    addSubview(titleTerminalView)
    addSubview(totalTerminalView)
    addSubview(pickerShower)
    addSubview(picker)
    addSubview(grayView)
    addSubview(pickerDismissToolbar)
    
    let divider = UIView()
    divider.backgroundColor = Color.Sfo.blue
    addSubview(divider)
    divider.snp_makeConstraints { (make) -> Void in
      make.height.equalTo(1)
      make.leading.equalTo(self)
      make.trailing.equalTo(self)
      make.top.equalTo(self)
    }
    
    titleTerminalView.configureAsTitle()
    titleTerminalView.setBackgroundDark(true)
    titleTerminalView.snp_makeConstraints { (make) -> Void in
      make.leading.equalTo(self)
      make.trailing.equalTo(self)
      make.top.equalTo(pickerShower.snp_bottom)
      make.height.equalTo(self).multipliedBy(0.104)
    }
    
    internationalTerminalView.snp_makeConstraints { (make) -> Void in
      make.top.equalTo(titleTerminalView.snp_bottom)
      make.leading.equalTo(self)
      make.trailing.equalTo(self)
      make.height.equalTo(self).multipliedBy(0.096)
    }

    terminalView1.setBackgroundDark(true)
    terminalView1.snp_makeConstraints { (make) -> Void in
      make.top.equalTo(internationalTerminalView.snp_bottom)
      make.leading.equalTo(self)
      make.height.equalTo(internationalTerminalView)
      make.trailing.equalTo(self)
    }

    terminalView2.snp_makeConstraints { (make) -> Void in
      make.top.equalTo(terminalView1.snp_bottom)
      make.trailing.equalTo(self)
      make.height.equalTo(terminalView1)
      make.leading.equalTo(self)
    }

    terminalView3.setBackgroundDark(true)
    terminalView3.snp_makeConstraints { (make) -> Void in
      make.top.equalTo(terminalView2.snp_bottom)
      make.leading.equalTo(self)
      make.height.equalTo(terminalView2)
      make.trailing.equalTo(self)
    }
    
    totalTerminalView.snp_makeConstraints { (make) -> Void in
      make.top.equalTo(terminalView3.snp_bottom)
      make.leading.equalTo(self)
      make.trailing.equalTo(self)
      make.height.equalTo(terminalView3)
    }
    
    pickerShower.setBackgroundImage(Image.from(Color.NavBar.subtitleBlue), forState: .Normal)
    pickerShower.setBackgroundImage(Image.from(Color.NavBar.subtitleBluePressed), forState: .Highlighted)
    pickerShower.snp_makeConstraints { (make) -> Void in
      make.top.equalTo(divider.snp_bottom)
      make.height.equalTo(44)
      make.centerX.equalTo(self)
      make.width.equalTo(self)
    }
    
    pickerTitle.font = UiConstants.TerminalSummary.toggleFont
    pickerTitle.text = FlightType.Arrivals.asLocalizedString()
    pickerTitle.textAlignment = .Center
    pickerTitle.textColor = UIColor.whiteColor()
    pickerShower.addSubview(pickerTitle)
    pickerTitle.snp_makeConstraints { (make) -> Void in
      make.width.equalTo(150)
      make.height.equalTo(30)
      make.center.equalTo(pickerShower)
    }
    
    let downArrowImageView = UIImageView()
    downArrowImageView.image = Image.downArrow.image()
    downArrowImageView.contentMode = .ScaleAspectFit
    pickerShower.addSubview(downArrowImageView)
    downArrowImageView.snp_makeConstraints { (make) -> Void in
      make.width.equalTo(15)
      make.height.equalTo(15)
      make.centerY.equalTo(pickerShower)
      make.leading.equalTo(pickerTitle.snp_trailing).offset(10)
    }
    

    hourPickerView.setMinMaxHours(minHour: -2, maxHour: 12)
    hourPickerView.snp_makeConstraints { (make) -> Void in
      make.leading.equalTo(self)
      make.top.equalTo(totalTerminalView.snp_bottom)
      make.bottom.equalTo(timerView.snp_top)
      make.trailing.equalTo(self)
    }
    
    timerView.snp_makeConstraints { (make) -> Void in
      make.bottom.equalTo(self)
      make.height.equalTo(UiConstants.Dashboard.progressHeight)
      make.leading.equalTo(self)
      make.trailing.equalTo(self)
    }
    
    picker.alpha = 0.0
    picker.backgroundColor = UIColor.whiteColor()
    picker.hidden = true
    picker.snp_makeConstraints { (make) -> Void in
      make.bottom.equalTo(self)
      make.leading.equalTo(self)
      make.trailing.equalTo(self)
    }
    
    pickerDismissToolbar.alpha = 0.0
    pickerDismissToolbar.hidden = true
    pickerDismissToolbar.snp_makeConstraints { (make) -> Void in
      make.width.equalTo(self)
      make.bottom.equalTo(picker.snp_top)
      make.centerX.equalTo(self)
    }
    
    grayView.alpha = UiConstants.TerminalSummary.grayViewAlpha
    grayView.backgroundColor = UIColor.blackColor()
    grayView.hidden = true
    grayView.snp_makeConstraints { (make) -> Void in
      make.top.equalTo(self)
      make.bottom.equalTo(picker.snp_top)
      make.leading.equalTo(self)
      make.trailing.equalTo(self)
    }
    
    reachabilityNotice.hidden = ReachabilityManager.sharedInstance.isReachable()
    addSubview(reachabilityNotice)
    reachabilityNotice.snp_makeConstraints { make in
      make.top.equalTo(self)
      make.leading.equalTo(self)
      make.trailing.equalTo(self)
      make.height.equalTo(UiConstants.ReachabilityNotice.height)
    }
  }
  
  func getCurrentFlightType() -> FlightType {
    return FlightType.all()[picker.selectedRowInComponent(0)]
  }
  
  func getCurrentHour() -> Int {
    return hourPickerView.getCurrentHour()
  }
  
  func incrementHour(hourChange: Int) {
    hourPickerView.incrementHour(hourChange)
  }
  
  func reloadTerminalViews(summaries: [TerminalSummary]) {
    terminalView1.configureForTerminalSummary(summaries.find(.One))
    terminalView2.configureForTerminalSummary(summaries.find(.Two))
    terminalView3.configureForTerminalSummary(summaries.find(.Three))
    internationalTerminalView.configureForTerminalSummary(summaries.find(.International))
    totalTerminalView.configureTotals(TerminalSummary.getTotals(summaries))
  }
  
  func updatePickerTitle() {
    pickerTitle.text = getCurrentFlightType().asLocalizedString()
  }
  
  func hidePicker() {
    UIView.animateWithDuration(UiConstants.TerminalSummary.fadeDuration, animations: {
      self.picker.alpha = 0.0
      self.pickerDismissToolbar.alpha = 0.0
      self.grayView.alpha = 0.0
    }, completion: { finished in
      self.picker.hidden = true
      self.pickerDismissToolbar.hidden = true
      self.grayView.hidden = true
    })
  }
  
  func showPicker() {
    picker.hidden = false
    pickerDismissToolbar.hidden = false
    grayView.hidden = false
    UIView.animateWithDuration(UiConstants.TerminalSummary.fadeDuration, animations: { () -> Void in
      self.picker.alpha = 1.0
      self.pickerDismissToolbar.alpha = 1.0
      self.grayView.alpha = UiConstants.TerminalSummary.grayViewAlpha
    })
  }
  
  func clearTerminalTable() {
    for terminalView in terminalViews {
      terminalView.clearTotals()
    }
    totalTerminalView.clearTotals()
  }
  
  func setReachabilityNoticeHidden(hidden: Bool) {
    reachabilityNotice.hidden = hidden
  }
  
  func setButtonSelectors(target: AnyObject, decreaseAction: Selector, increaseAction: Selector) {
    hourPickerView.setButtonSelectors(target, decreaseAction: decreaseAction, increaseAction: increaseAction)
  }
  
  func startTimerView(updateInterval: NSTimeInterval, callback: TimerCallback) {
    timerView.start(updateInterval, callback: callback)
  }
  
  func stopTimerView() {
    timerView.stop()
  }
  
  func resetTimerProgess() {
    timerView.resetProgress()
  }
  
  func setTerminalViewSelector(target: AnyObject, action: Selector) {
    terminalView1.addTarget(target, action: action, forControlEvents: .TouchUpInside)
    terminalView2.addTarget(target, action: action, forControlEvents: .TouchUpInside)
    terminalView3.addTarget(target, action: action, forControlEvents: .TouchUpInside)
    internationalTerminalView.addTarget(target, action: action, forControlEvents: .TouchUpInside)
  }
  
  func setPickerShowerTarget(target: AnyObject, action: Selector) {
    pickerShower.addTarget(target, action: action, forControlEvents: .TouchUpInside)
  }
  
  func setPickerDismisserItems(items: [UIBarButtonItem]) {
    pickerDismissToolbar.setItems(items, animated: true)
  }
  
  func setGrayAreaSelector(target: AnyObject, action: Selector) {
    grayView.addGestureRecognizer(UITapGestureRecognizer(target: target, action: action))
  }
  
  func setPickerDataSourceAndDelegate(dataSource dataSource: UIPickerViewDataSource, delegate: UIPickerViewDelegate) {
    picker.dataSource = dataSource
    picker.delegate = delegate
  }
}
