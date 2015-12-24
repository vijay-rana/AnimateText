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
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
        self.GetLyrics()
       GetLyricsText()
        first.textColor = UIColor.redColor()
        first.alpha = 0.5
        NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "timerLabel", userInfo: nil, repeats: true)
       
        third.text = LineLyricsList[1].Line
   
        forth.text = LineLyricsList[2].Line
     
        fifth.text = LineLyricsList[3].Line
        sixth.text = LineLyricsList[4].Line
        sixth.alpha = 0.5
       
        //setting another label
        print(LineLyricsList.count)
        let lblsizearr = sendWidth()
        var rlblx = CGFloat()
        
        for (var k = 0 ; k < lblsizearr.objectAtIndex(2).count ; k++)
        {
            
            let widthChang :NSNumber  = lblsizearr.objectAtIndex(0).objectAtIndex(lblsizearr.objectAtIndex(2).count - k - 1).floatValue
            let widthvalue = CGFloat(widthChang)
            redLabel = UILabel()
            blacklbl = UILabel()
            blacklbl.tag = k + 1
            redLabel.tag = k + 20
            
                 redLabel.frame = CGRectMake(0 + rlblx,0, widthvalue, second.frame.size.height)
            blacklbl.frame = CGRectMake(0 + rlblx,0, widthvalue, second.frame.size.height)
                 rlblx = rlblx + widthvalue - 6
           
            //print("pso x rlbl",rlblx,widthvalue)
            redLabel.text = lblsizearr.objectAtIndex(2).objectAtIndex(lblsizearr.objectAtIndex(2).count - k - 1) as! String
            blacklbl.text = lblsizearr.objectAtIndex(2).objectAtIndex(lblsizearr.objectAtIndex(2).count - k - 1) as! String
             redLabel.font = UIFont.boldSystemFontOfSize(20)
              blacklbl.font = UIFont.boldSystemFontOfSize(20)
            redLabel.textColor = UIColor.redColor()
            
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
                        subviewlbl.viewWithTag(checkblklbl)?.frame = CGRectMake(subviewlbl.frame.origin.x, subviewlbl.frame.origin.y, 0, subviewlbl.frame.size.height)
                        
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
            
            for (var k = 0 ; k < lblsizearr.objectAtIndex(2).count ; k++)
            {
                
                let widthChang :NSNumber  = lblsizearr.objectAtIndex(0).objectAtIndex(lblsizearr.objectAtIndex(2).count - k - 1).floatValue
                let widthvalue = CGFloat(widthChang)
                redLabel = UILabel()
                blacklbl = UILabel()
                redLabel.tag = k + 20
                blacklbl.tag = k + 1
                
                redLabel.frame = CGRectMake(0 + rlblx,0, widthvalue, second.frame.size.height)
                blacklbl.frame = CGRectMake(0 + rlblx,0, widthvalue, second.frame.size.height)
                rlblx = rlblx + widthvalue - 6
                
                //   print("pso x rlbl",rlblx,widthvalue)
                redLabel.text = lblsizearr.objectAtIndex(2).objectAtIndex(lblsizearr.objectAtIndex(2).count - k - 1) as! String
                blacklbl.text = lblsizearr.objectAtIndex(2).objectAtIndex(lblsizearr.objectAtIndex(2).count - k - 1) as! String
                redLabel.font = UIFont.boldSystemFontOfSize(20)
                blacklbl.font = UIFont.boldSystemFontOfSize(20)
                redLabel.textColor = UIColor.redColor()
                
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
            
            let sizelabel:CGSize = lyrstrs .sizeWithAttributes([NSFontAttributeName: UIFont.systemFontOfSize(30.0)])
            widthArray.addObject(sizelabel.width)
           
            wordCountNumb++
        }
        
        let widthTimarr = NSArray(array: [widthArray,timeArray,wordTextArray])
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
