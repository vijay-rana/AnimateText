//
//  test.swift
//  Demo
//
//  Created by KBS on 26/11/15.
//  Copyright © 2015 kbs. All rights reserved.
//

import Foundation
import UIKit


class test: UIViewController
{
    
    @IBOutlet var lblWork: UILabel!
    @IBOutlet var txtTest: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let main_string = "Hello World vijay here"
        let string_to_color = "World"
        let range = (main_string as NSString).rangeOfString(string_to_color)
        //var r : NSRange? = NSMakeRange(2, 2)
        let attributedString = NSMutableAttributedString(string:main_string)
        attributedString.addAttribute(NSForegroundColorAttributeName, value: UIColor.redColor() , range: range)
        
        txtTest.attributedText = attributedString
        lblWork.attributedText = attributedString
        
        
    }
    
    
}