//
//  ViewController.swift
//  Simple Progress Bar Example
//
//  Created by Adwin on 10/11/17.
//  Copyright © 2017 Adwin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var progressBar: ProgressBarView! {
        didSet {
            progressBar.maxValue = 100
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        progressBar.currentValue = 10
    }

    @IBAction func subAction(_ sender: Any) {
        if progressBar.currentValue != 0 {
            progressBar.currentValue = progressBar.currentValue - 10
        }
    }
    
    @IBAction func addAction(_ sender: Any) {
        if progressBar.currentValue != progressBar.maxValue {
            progressBar.currentValue = progressBar.currentValue + 10
        }
    }
    
    @IBAction func btnChangeGradientAction(_ sender: Any) {
        progressBar.isGradient = !progressBar.isGradient
    }
    
    @IBAction func btnChangeColor(sender: UIButton) {
        if progressBar.isGradient {
            if progressBar.insideColor == .gray {
                progressBar.gradientStartColor = .white
                progressBar.gradientEndColor = .red
                progressBar.insideColor = .red
            } else {
                progressBar.gradientStartColor = .white
                progressBar.gradientEndColor = .gray
                progressBar.insideColor = .gray
            }
        } else {
            if progressBar.insideColor == .gray {
                progressBar.insideColor = .red
            } else {
                progressBar.insideColor = .gray
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

