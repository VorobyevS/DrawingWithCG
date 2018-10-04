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
    }
    

}

