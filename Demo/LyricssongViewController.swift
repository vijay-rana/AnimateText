//
//  LyricssongViewController.swift
//  Demo
//
//  Created by kbs on 12/15/15.
//  Copyright © 2015 kbs. All rights reserved.
//

import UIKit

class LyricssongViewController: UIViewController {

    
    @IBOutlet weak var first: UILabel!
    
    @IBOutlet weak var second: UILabel!
    
    @IBOutlet weak var third: UILabel!
    
    @IBOutlet weak var forth: UILabel!
  
    @IBOutlet weak var fifth: UILabel!
   
    @IBOutlet weak var timer: UILabel!

    @IBOutlet weak var sixth: UILabel!
    var count = 0
    var timerLbl = 0
    var countTimer = NSTimer()
    var endTimer = NSTimer()
    var LiricsList:Array<Lyrics> = []
    var LineLyricsList:Array<LyricsLine> = []
     var redLabel = UILabel()
    var blacklbl = UILabel()
     var checkblklbl = 0
    
    var wordCountNumb = 0
  //variable for seting font size
    var fontSize = CGFloat()
    let fontName = "AlNile-Bold"
    var textColor = UIColor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
        
        //setting Background images-----------
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "blur.png")!)
        
        //setting font size-----------
        fontSize = 25.0
        
        //setting text color
        textColor = UIColor(red: 231/255, green: 180/255, blue: 53/255, alpha: 1.0)
        
        self.GetLyrics()
       GetLyricsText()
        first.textColor = textColor
        first.font =  UIFont(name: fontName, size: fontSize)
        first.alpha = 0.5
        NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "timerLabel", userInfo: nil, repeats: true)
       
        third.text = LineLyricsList[1].Line
        third.font = UIFont(name: fontName, size: fontSize)
        forth.text = LineLyricsList[2].Line
        forth.font =  UIFont(name: fontName, size: fontSize)
        fifth.text = LineLyricsList[3].Line
        fifth.font =  UIFont(name: fontName, size: fontSize)
        sixth.text = LineLyricsList[4].Line
        sixth.font =  UIFont(name: fontName, size: fontSize)
        sixth.alpha = 0.5
       
        //setting another label
        print(LineLyricsList.count)
        let lblsizearr = sendWidth()
        var rlblx = CGFloat()
        let toatalWidthFloat:NSNumber = lblsizearr.objectAtIndex(3).objectAtIndex(0).floatValue;
        
        let xRBlbl = second.frame.size.width/2 - CGFloat(toatalWidthFloat.integerValue/2)
        print(toatalWidthFloat)
        for (var k = 0 ; k < lblsizearr.objectAtIndex(2).count ; k++)
        {
            
            let widthChang :NSNumber  = lblsizearr.objectAtIndex(0).objectAtIndex(lblsizearr.objectAtIndex(2).count - k - 1).floatValue
            let widthvalue = CGFloat(widthChang)
            redLabel = UILabel()
            blacklbl = UILabel()
            blacklbl.tag = k + 1
            redLabel.tag = k + 20
            
                 redLabel.frame = CGRectMake(0 + rlblx + xRBlbl,0, widthvalue, second.frame.size.height)
            blacklbl.frame = CGRectMake(0 + rlblx + xRBlbl,0, widthvalue, second.frame.size.height)
                 rlblx = rlblx + widthvalue - 6
           
            //print("pso x rlbl",rlblx,widthvalue)
            redLabel.text = lblsizearr.objectAtIndex(2).objectAtIndex(lblsizearr.objectAtIndex(2).count - k - 1) as! String
            blacklbl.text = lblsizearr.objectAtIndex(2).objectAtIndex(lblsizearr.objectAtIndex(2).count - k - 1) as! String
            redLabel.textColor = textColor
            redLabel.font = UIFont(name: fontName, size: fontSize + 5.0)
            blacklbl.font =  UIFont(name: fontName, size: fontSize + 5.0)
            
            redLabel.textAlignment = NSTextAlignment.Left
            blacklbl.textAlignment = NSTextAlignment.Left
            //print(redLabel.text,blacklbl.text)
            self.second.addSubview(redLabel)
            self.second.addSubview(blacklbl)
            
            
        }
        
        
//      NSTimer.scheduledTimerWithTimeInterval(Double(LineLyricsList[count].StartTime)! - 30, target: self, selector: "changeColor", userInfo: nil, repeats: false)
//       // count++
       
    }
    

    
    func changeColor (timer: NSTimer)
    {
       // let subViewsArr = NSMutableArray()
       
            for subviewlbl in self.second.subviews
          {
            if(subviewlbl is UILabel)
            {
             
                if (subviewlbl.tag == checkblklbl)
                {
                    // subViewsArr.addObject(subviewlbl)
                    let timeintrvl : AnyObject = timer.userInfo!
                    let timeintrvll: Double = timeintrvl.doubleValue
                    
                    
                    UIView.animateWithDuration(timeintrvll, animations: {
                        subviewlbl.viewWithTag(self.checkblklbl)?.frame = CGRectMake(subviewlbl.frame.origin.x, subviewlbl.frame.origin.y, 0, subviewlbl.frame.size.height)
                        
                        }, completion: {(Bool) in
                           
                    })
                    
                }
            }
        }
    
        checkblklbl--
       // print(checkblklbl)
    }
    
    
    func changeLine()
    {
        for subviewlbl in self.second.subviews
        {
            subviewlbl.removeFromSuperview()
        }
        
        
        // print("change line")
        var n = count
        
        
        if(n < LineLyricsList.count )
        {
            first.text = LineLyricsList[n - 1].Line

        }
        else
        {
            first.text = ""

        }
        
       //setting second label---------------------
        
        if(n < LineLyricsList.count )
        {
            let lblsizearr = sendWidth()
            var rlblx = CGFloat()
            let toatalWidthFloat:NSNumber = lblsizearr.objectAtIndex(3).objectAtIndex(0).floatValue;
            
            let xRBlbl = second.frame.size.width/2 - CGFloat(toatalWidthFloat.integerValue/2)
            print(toatalWidthFloat)

            for (var k = 0 ; k < lblsizearr.objectAtIndex(2).count ; k++)
            {
                
                let widthChang :NSNumber  = lblsizearr.objectAtIndex(0).objectAtIndex(lblsizearr.objectAtIndex(2).count - k - 1).floatValue
                let widthvalue = CGFloat(widthChang)
                redLabel = UILabel()
                blacklbl = UILabel()
                redLabel.tag = k + 20
                blacklbl.tag = k + 1
                
                redLabel.frame = CGRectMake(0 + rlblx + xRBlbl,0, widthvalue, second.frame.size.height)
                blacklbl.frame = CGRectMake(0 + rlblx + xRBlbl,0, widthvalue, second.frame.size.height)
                rlblx = rlblx + widthvalue - 6
                
                //   print("pso x rlbl",rlblx,widthvalue)
                redLabel.text = lblsizearr.objectAtIndex(2).objectAtIndex(lblsizearr.objectAtIndex(2).count - k - 1) as! String
                blacklbl.text = lblsizearr.objectAtIndex(2).objectAtIndex(lblsizearr.objectAtIndex(2).count - k - 1) as! String
                redLabel.font = UIFont(name: fontName, size: fontSize + 5.0)
                blacklbl.font =  UIFont(name: fontName, size: fontSize + 5.0)
                redLabel.textColor = textColor
                
                redLabel.textAlignment = NSTextAlignment.Left
                blacklbl.textAlignment = NSTextAlignment.Left
                // print(redLabel.text,blacklbl.text)
                self.second.addSubview(redLabel)
                self.second.addSubview(blacklbl)
                
            }

            
        }
        else
        {
            second.text = ""
        }
        
        
        
        n++
        
        if(n < LineLyricsList.count )
        {
            third.text = LineLyricsList[n].Line
            
        }
        else
        {
             third.text = ""
        }
        
        
        n++
        if(n < LineLyricsList.count )
        {
             forth.text = LineLyricsList[n].Line
           
        }
        else
        {
           forth.text = ""
        }
      
        n++
        if(n < LineLyricsList.count )
        {
            fifth.text = LineLyricsList[n].Line

            
        }
        else
        {
          fifth.text = ""
        }
        
        n++
        if(n < LineLyricsList.count)
        {
            sixth.text = LineLyricsList[n].Line
            
        }
        else
        {
            sixth.text = ""
        }
     
    }
    
    
    func GetLyrics() {
        if let path = NSBundle.mainBundle().pathForResource("Song1", ofType: "json") {
            do {
                let data = try NSData(contentsOfURL: NSURL(fileURLWithPath: path), options: NSDataReadingOptions.DataReadingMappedIfSafe)
                let anyObj: AnyObject? = try? NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(rawValue: 0))
                if(anyObj != nil && anyObj is Array<AnyObject>)
                    
                {
                    for items in anyObj as! Array<AnyObject>{
                        var Lyric:Lyrics = Lyrics()
                        Lyric.StartTime = (items["start"] as AnyObject? as? String)!
                        Lyric.EndTime = (items["ending"] as AnyObject? as? String)!
                        Lyric.Word = (items["note"] as AnyObject? as? String)!
                        LiricsList.append(Lyric)
                    }
                }
            }
            catch let error as NSError {
                print(error.localizedDescription)
            }
        } else {
             print("Invalid filename/path.")
        }
    }
    // Get StartTime,EndTime and lyrics of song from text file line by line
    func GetLyricsText() {
        if let path = NSBundle.mainBundle().pathForResource("lyrics", ofType: "txt") {
            do {
                
                let data = try NSData(contentsOfURL: NSURL(fileURLWithPath: path), options: NSDataReadingOptions.DataReadingMappedIfSafe)
                
                let resstr = NSString(data: data, encoding: NSUTF8StringEncoding)
                let LineLyricsTemp = resstr!.componentsSeparatedByString("\n")
                var j = 0;
                
                for line in LineLyricsTemp
                {
                    var objLyricsLine:LyricsLine = LyricsLine()
                    objLyricsLine.Line = line
                    objLyricsLine.StartTime = LiricsList[j].StartTime
                    let wordinline = line.componentsSeparatedByString(" ").count
                    objLyricsLine.EndTime = LiricsList[j + wordinline  - 1].EndTime
                    j = j + wordinline
                    LineLyricsList.append(objLyricsLine)
                    
                }
              
                
            } catch let error as NSError {
                
                print(error.localizedDescription)
                
            }
            
        } else {
            
             print("Invalid filename/path.")
        }
    }

    
   
    
//    override func viewDidAppear(animated: Bool) {
//        print("did appear")
//        
//    }
//    override func viewWillAppear(animated: Bool) {
//        print("will apper")
//    }
//    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   func timerLabel ()
   {
    
    self.timer.text = NSString(format: "%d", timerLbl) as String
    timerLbl++
    }
    
    

    func sendWidth () ->NSArray
    {
      
        checkblklbl = 0
        let widthArray = NSMutableArray()
        let timeArray = NSMutableArray()
        let wordTextArray = NSMutableArray()
        let linetimeInterval : Double = Double(LineLyricsList[count].EndTime)! - Double(LineLyricsList[count].StartTime)!
        if(count == 0)
        {
          NSTimer.scheduledTimerWithTimeInterval(Double(LineLyricsList[count].EndTime)!, target: self, selector: "changeLine", userInfo: nil, repeats: false)
        }
        else
        {
            NSTimer.scheduledTimerWithTimeInterval(linetimeInterval, target: self, selector: "changeLine", userInfo: nil, repeats: false)
        }
     
        let countWords:NSArray = [LineLyricsList[count].Line .componentsSeparatedByCharactersInSet(NSCharacterSet .whitespaceAndNewlineCharacterSet())]
        
        checkblklbl = countWords.objectAtIndex(0).count
        var timeIntrvalWord = Double()
        var totalWidth = CGFloat()
        for(var k = 0 ; k < countWords.objectAtIndex(0).count ; k++ )
        {
            
            //calculating time --------------------------------
            let wordStarttime = (LiricsList[wordCountNumb].StartTime as NSString).doubleValue
            let wordEndtime = (LiricsList[wordCountNumb].EndTime as NSString).doubleValue
            let wordInterval : Double = wordEndtime - wordStarttime
           
            timeArray.addObject(wordInterval)
            if(count == 0)
            {
                 NSTimer.scheduledTimerWithTimeInterval(wordStarttime , target: self, selector: "changeColor:", userInfo: wordInterval, repeats: false)
            }
            else{
            
                 NSTimer.scheduledTimerWithTimeInterval(timeIntrvalWord , target: self, selector: "changeColor:", userInfo: wordInterval, repeats: false)
                timeIntrvalWord = wordInterval + timeIntrvalWord
            }
            
            // calculating width ---------------------------------
            
            let lyrstrs:NSString = LiricsList[wordCountNumb].Word
            wordTextArray.addObject(lyrstrs)
            
            let sizelabel:CGSize = lyrstrs .sizeWithAttributes([NSFontAttributeName: UIFont.systemFontOfSize(fontSize + 10.0)])
            widthArray.addObject(sizelabel.width)
           totalWidth = totalWidth + sizelabel.width
            wordCountNumb++
        }
       
        let totalWidthArray = NSMutableArray()
        totalWidthArray.addObject(totalWidth)
        
        let widthTimarr = NSArray(array: [widthArray,timeArray,wordTextArray,totalWidthArray])
          count++
        
        return widthTimarr
    }

    
  
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
