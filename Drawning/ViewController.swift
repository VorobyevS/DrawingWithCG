//
//  ViewController.swift
//  Drawning
//
//  Created by Hela on 04/10/2018.
//  Copyright © 2018 Hela. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var counterView: CounterView!
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var graphView: GraphView!
    @IBOutlet weak var averageLabel: UILabel!
    @IBOutlet weak var maxLabel: UILabel!
    @IBOutlet weak var daysStack: UIStackView!
    
    var isGraphViewShowing = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        counterLabel.text = "1"
    }
    
    @IBAction func buttonsPressed(_ sender: PushButton) {
        if sender.isAddButton && counterView.counter < 8{
            counterView.counter += 1
        }
        else if !sender.isAddButton && counterView.counter > 0{
            counterView.counter -= 1
        }
        counterLabel.text = String(counterView.counter)
        
        if isGraphViewShowing {
            counterViewTap(nil)
        }
    }
    
    @IBAction func counterViewTap(_ sender: UITapGestureRecognizer?) {
        if isGraphViewShowing {
            UIView.transition(from: graphView,
                              to: counterView,
                              duration: 1.0,
                              options: [.transitionFlipFromLeft, .showHideTransitionViews],
                              completion:nil)
        }
        else {
            setupGraphDisplay()
            UIView.transition(from: counterView,
                              to: graphView,
                              duration: 1.0,
                              options: [.transitionFlipFromRight, .showHideTransitionViews],
                              completion: nil)
        }
        isGraphViewShowing = !isGraphViewShowing
    }
    
    func setupGraphDisplay() {
        
        let maxDayIndex = daysStack.arrangedSubviews.count - 1
        
        //  1 - replace last day with today's actual data
        graphView.graphPoints[graphView.graphPoints.count - 1] = counterView.counter
        //2 - indicate that the graph needs to be redrawn
        graphView.setNeedsDisplay()
        maxLabel.text = "\(graphView.graphPoints.max()!)"
        
        //  3 - calculate average from graphPoints
        let average = graphView.graphPoints.reduce(0, +) / graphView.graphPoints.count
        averageLabel.text = "\(average)"
        
        // 4 - setup date formatter and calendar
        let today = Date()
        let calendar = Calendar.current
        
        let formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate("EEEEEE")
        
        // 5 - set up the day name labels with correct days
        for i in 0...maxDayIndex {
            if let date = calendar.date(byAdding: .day, value: -i, to: today),
                let label = daysStack.arrangedSubviews[maxDayIndex - i] as? UILabel {
                label.text = formatter.string(from: date)
            }
        }
    }
}

