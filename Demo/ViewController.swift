//
//  ViewController.swift
//  Demo
//
//  Created by kbs on 11/18/15.
//  CopyCenter © 2015 kbs. All Centers reserved.
//

import UIKit

class ViewController: UIViewController {
    
    struct Constants {
        static var LabelWidth:CGFloat = 200
        static var LabelHeight:CGFloat = 25
        static var ViewWidth:CGFloat = 1000
        static var ViewHeight:CGFloat = 1000
        static var LabelXaxis:CGFloat = 100
        static var LabelYaxis:CGFloat = 100
        static var labelAlpha:CGFloat = 0.00
        static var labelScaleX:CGFloat = 1.0
        static var labelScaleY:CGFloat = 1.0
        static var labelScaleXMain:CGFloat = 1.5
        static var labelScaleYMain:CGFloat = 1.5
        static var labelColorPartial:CGFloat = 0.3
        static var labelColorFull:CGFloat = 1.0
        static var ViewxAxis:CGFloat = 0
    }
    
    var LiricsList:Array<Lyrics> = []
    var LineLyricsList:Array<LyricsLine> = []
    
    @IBOutlet var lblTime: UILabel!
    
    let labelLine1:UILabel = UILabel(frame: CGRect(x: Constants.LabelXaxis, y:  Constants.LabelYaxis, width: Constants.LabelWidth, height: Constants.LabelHeight))
    let labelLine2:UILabel = UILabel(frame: CGRect(x: Constants.LabelXaxis, y: Constants.LabelYaxis + 50, width: Constants.LabelWidth, height: Constants.LabelHeight))
    let labelLine3:UILabel = UILabel(frame: CGRect(x: Constants.LabelXaxis, y: Constants.LabelYaxis + 100, width: Constants.LabelWidth, height: Constants.LabelHeight))
    let labelLine4:UILabel = UILabel(frame: CGRect(x: Constants.LabelXaxis, y: Constants.LabelYaxis + 150, width: Constants.LabelWidth, height: Constants.LabelHeight))
    let labelLine5:UILabel = UILabel(frame: CGRect(x: Constants.LabelXaxis, y: Constants.LabelYaxis + 200, width: Constants.LabelWidth, height: Constants.LabelHeight))
    let labelLine6:UILabel = UILabel(frame: CGRect(x: Constants.LabelXaxis, y: Constants.LabelYaxis + 250, width: Constants.LabelWidth, height: Constants.LabelHeight))
    
    let labelLine1A:UILabel = UILabel(frame: CGRect(x: Constants.LabelXaxis, y: Constants.LabelYaxis, width: Constants.LabelWidth, height: Constants.LabelHeight))
    let labelLine2A:UILabel = UILabel(frame: CGRect(x: Constants.LabelXaxis, y: Constants.LabelYaxis + 50, width: Constants.LabelWidth, height: Constants.LabelHeight))
    let labelLine3A:UILabel = UILabel(frame: CGRect(x: Constants.LabelXaxis, y: Constants.LabelYaxis + 100, width: Constants.LabelWidth, height: Constants.LabelHeight))
    let labelLine4A:UILabel = UILabel(frame: CGRect(x: Constants.LabelXaxis, y: Constants.LabelYaxis + 150, width: Constants.LabelWidth, height: Constants.LabelHeight))
    let labelLine5A:UILabel = UILabel(frame: CGRect(x: Constants.LabelXaxis, y: Constants.LabelYaxis + 200, width: Constants.LabelWidth, height: Constants.LabelHeight))
    let labelLine6A:UILabel = UILabel(frame: CGRect(x: Constants.LabelXaxis, y: Constants.LabelYaxis + 250, width: Constants.LabelWidth, height: Constants.LabelHeight))
    
    let ViewMainLine1=UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MainAnimateLyrics()
    }
    
    // Calling all functions inside a single function
    
    func MainAnimateLyrics()
    {
        
        GetLyrics()
        GetLyricsText()
        AddStartEndToLyrics()
        CreateOnLoad()
        FillTextOnLabels()
        TimerMoveLine()
        
        Timer()
        
        //EndTimer()
        ClockTimer()
    }
    
    // Provide functionality to the clock
    func ClockTimer(){
        for( var i = 1; i <= 600; i++)
        {
            NSTimer.scheduledTimerWithTimeInterval(Double(i), target: self, selector: "ShowClock:", userInfo: i, repeats: false)
        }
    }
    
    // Shows clock on the top of the view
    func ShowClock(timer: NSTimer){
        let o: AnyObject = timer.userInfo!
        let n: Int = o as! Int
        lblTime.text = String(n)
        
    }
    
    // Provide first 6 lines of lyrics from text file of song
    func FillTextOnLabels()
    {
        var j = 1
        for line in LineLyricsList {
            SetText(j, Line: line.Line)
            if( j  > 6 )
            {
                break
            }
            j = j + 1
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        
    }
    
    // Get StartTime,EndTime and lyrics of song from JSON file word by word
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
            // print("Invalid filename/path.")
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
            
            // print("Invalid filename/path.")
        }
    }
    
    func AddStartEndToLyrics()
    {
        var c:Int = 0
        LiricsList[0].IsFirstWord = true
        for Lyrics in LineLyricsList
        {
            let lineArray = Lyrics.Line.componentsSeparatedByString(" ")
            c =  Int(c) + Int(lineArray.count)
            if( c < LiricsList.count - 1)
            {
                LiricsList[c].IsLastWord = true
                LiricsList[c + 1].IsFirstWord = true
            }
        }
    }
    
    // Provide time to selecter:"StartText" to animating the words
    func Timer(){
        
        var i :Int = 1
        for lines in LineLyricsList{
            let StartTime = LineLyricsList[i-1].StartTime
            let EndTime = LineLyricsList[i-1].EndTime
            let arr = [i,StartTime,EndTime]
            NSTimer.scheduledTimerWithTimeInterval(Double(StartTime)!, target: self, selector: "StartText:", userInfo: arr, repeats: false)
            i =  i + 1
        }
        
        
        
    }
    // Provide time to move line
    func TimerMoveLine(){
        var i :Int = 1
        for line in LineLyricsList {
            
            NSTimer.scheduledTimerWithTimeInterval(Double(line.EndTime)!, target: self, selector: "MoveLine:", userInfo: i, repeats: false)
            i = i + 1;
        }
    }
    
    // Move line labels and mainview upward using timer
    func MoveLine(timer: NSTimer){
        let o: AnyObject = timer.userInfo!
        let n: Int = o as! Int
        
        if(n == 1){
            
            Repeated1()
             self.ViewMainLine1.frame = CGRect(x: Constants.ViewxAxis, y: 50, width: Constants.ViewWidth, height: Constants.ViewHeight)
            
            
        }
        var LabelYAxix: CGFloat = 0
        var ViewYAxis: CGFloat = 0
        
        
        if( n == 2  || (n - 2)%6 == 0)
        {
            Repeated2()
            if(n == 2)
            {
                ViewYAxis = 0
                LabelYAxix = 400
                
            }
                
            else if((n - 2)%6 == 0)
            {
                ViewYAxis =  CGFloat(-300 - (((n-2)/6) - 1)*300)
                LabelYAxix = CGFloat(700 + (((n-2)/6) - 1)*300)
                
            }
            
             self.ViewMainLine1.frame = CGRect(x: Constants.ViewxAxis, y: ViewYAxis,width: Constants.ViewWidth, height: Constants.ViewHeight)
            self.labelLine1.frame=CGRect(x: Constants.LabelXaxis, y: LabelYAxix, width: Constants.LabelWidth, height: Constants.LabelHeight)
            self.labelLine1A.frame=CGRect(x: Constants.LabelXaxis, y: LabelYAxix, width: Constants.LabelWidth, height: Constants.LabelHeight)
            if(n > LineLyricsList.count || n > LineLyricsList.count - 1 || n > LineLyricsList.count - 2 || n > LineLyricsList.count - 3 || n > LineLyricsList.count - 4 || n > LineLyricsList.count - 5)
            {
                self.labelLine1.text =  ""
                self.labelLine1A.text =  ""
            }
            else{
                self.labelLine1.text =  LineLyricsList[n + 4].Line
                self.labelLine1A.text =  LineLyricsList[n + 4].Line
            }
            
            
        }
        if( n == 3  || (n - 3)%6 == 0)
        {
            Repeated3()
            if(n == 3)
            {
                ViewYAxis = -50
                LabelYAxix = 450
                
            }
                
            else if((n - 3)%6 == 0)
            {
                ViewYAxis =  CGFloat(-350 - (((n-3)/6) - 1)*300)
                LabelYAxix = CGFloat(750 + (((n-3)/6) - 1)*300)
                
            }
            
             self.ViewMainLine1.frame = CGRect(x: Constants.ViewxAxis, y: ViewYAxis,width: Constants.ViewWidth, height: Constants.ViewHeight)
            self.labelLine2.frame=CGRect(x: Constants.LabelXaxis, y: LabelYAxix, width: Constants.LabelWidth, height: Constants.LabelHeight)
            self.labelLine2A.frame=CGRect(x: Constants.LabelXaxis, y: LabelYAxix, width: Constants.LabelWidth, height: Constants.LabelHeight)
            if(n > LineLyricsList.count || n > LineLyricsList.count - 1 || n > LineLyricsList.count - 2 || n > LineLyricsList.count - 3 || n > LineLyricsList.count - 4 || n > LineLyricsList.count - 5)
            {
                self.labelLine2.text =  ""
                self.labelLine2A.text =  ""
            }
            else{
                self.labelLine2.text =  LineLyricsList[n + 4].Line
                self.labelLine2A.text =  LineLyricsList[n + 4].Line
            }
            
        }
        if( n == 4  || (n - 4)%6 == 0)
        {
            Repeated4()
            if(n == 4)
            {
                ViewYAxis = -100
                LabelYAxix = 500
                
            }
                
            else if((n - 4)%6 == 0)
            {
                ViewYAxis =  CGFloat(-400 - (((n-4)/6) - 1)*300)
                LabelYAxix = CGFloat(800 + (((n-4)/6) - 1)*300)
                
            }
            
             self.ViewMainLine1.frame = CGRect(x: Constants.ViewxAxis, y: ViewYAxis,width: Constants.ViewWidth, height: Constants.ViewHeight)
            self.labelLine3.frame=CGRect(x: Constants.LabelXaxis, y: LabelYAxix, width: Constants.LabelWidth, height: Constants.LabelHeight)
            self.labelLine3A.frame=CGRect(x: Constants.LabelXaxis, y: LabelYAxix, width: Constants.LabelWidth, height: Constants.LabelHeight)
            if(n > LineLyricsList.count || n > LineLyricsList.count - 1 || n > LineLyricsList.count - 2 || n > LineLyricsList.count - 3 || n > LineLyricsList.count - 4 || n > LineLyricsList.count - 5)
            {
                self.labelLine3.text =  ""
                self.labelLine3A.text =  ""
            }
            else{
                self.labelLine3.text =  LineLyricsList[n + 4].Line
                self.labelLine3A.text =  LineLyricsList[n + 4].Line
            }
            
        }
        if( n == 5  || (n - 5)%6 == 0)
        {
            Repeated5()
            if(n == 5)
            {
                ViewYAxis = -150
                LabelYAxix = 550
                
            }
                
            else if((n - 5)%6 == 0)
            {
                ViewYAxis =  CGFloat(-450 - (((n-5)/6) - 1)*300)
                LabelYAxix = CGFloat(850 + (((n-5)/6) - 1)*300)
                
            }
            
             self.ViewMainLine1.frame = CGRect(x: Constants.ViewxAxis, y: ViewYAxis,width: Constants.ViewWidth, height: Constants.ViewHeight)
            self.labelLine4.frame=CGRect(x: Constants.LabelXaxis, y: LabelYAxix, width: Constants.LabelWidth, height: Constants.LabelHeight)
            self.labelLine4A.frame=CGRect(x: Constants.LabelXaxis, y: LabelYAxix, width: Constants.LabelWidth, height: Constants.LabelHeight)
            if(n > LineLyricsList.count || n > LineLyricsList.count - 1 || n > LineLyricsList.count - 2 || n > LineLyricsList.count - 3 || n > LineLyricsList.count - 4 || n > LineLyricsList.count - 5)
            {
                self.labelLine4.text =  ""
                self.labelLine4A.text =  ""
            }
            else{
                self.labelLine4.text =  LineLyricsList[n + 4].Line
                self.labelLine4A.text =  LineLyricsList[n + 4].Line
            }
            
        }
        if( n == 6  || (n - 6)%6 == 0)
        {
            Repeated6()
            if(n == 6)
            {
                ViewYAxis = -200
                LabelYAxix = 600
            }
            else if((n - 6)%6 == 0)
            {
                ViewYAxis =  CGFloat(-500 - (((n-6)/6) - 1)*300)
                LabelYAxix = CGFloat(900 + (((n-6)/6) - 1)*300)
            }
            
             self.ViewMainLine1.frame = CGRect(x: Constants.ViewxAxis, y: ViewYAxis,width: Constants.ViewWidth, height: Constants.ViewHeight)
            self.labelLine5.frame=CGRect(x: Constants.LabelXaxis, y: LabelYAxix, width: Constants.LabelWidth, height: Constants.LabelHeight)
            self.labelLine5A.frame=CGRect(x: Constants.LabelXaxis, y: LabelYAxix, width: Constants.LabelWidth, height: Constants.LabelHeight)
            if(n > LineLyricsList.count || n > LineLyricsList.count - 1 || n > LineLyricsList.count - 2 || n > LineLyricsList.count - 3 || n > LineLyricsList.count - 4 || n > LineLyricsList.count - 5)
            {
                self.labelLine5.text =  ""
                self.labelLine5A.text =  ""
            }
            else{
                self.labelLine5.text =  LineLyricsList[n + 4].Line
                self.labelLine5A.text =  LineLyricsList[n + 4].Line
            }
        }
        if( n == 7  || (n - 7)%6 == 0)
        {
            Repeated1()
            if(n == 7)
            {
                ViewYAxis = -250
                LabelYAxix = 650
                
            }
                
            else if((n - 7)%6 == 0)
            {
                ViewYAxis =  CGFloat(-550 - (((n-7)/6) - 1)*300)
                LabelYAxix = CGFloat(950 + (((n-7)/6) - 1)*300)
                
            }
            
             self.ViewMainLine1.frame = CGRect(x: Constants.ViewxAxis, y: ViewYAxis,width: Constants.ViewWidth, height: Constants.ViewHeight)
            self.labelLine6.frame=CGRect(x: Constants.LabelXaxis, y: LabelYAxix, width: Constants.LabelWidth, height: Constants.LabelHeight)
            self.labelLine6A.frame=CGRect(x: Constants.LabelXaxis, y: LabelYAxix, width: Constants.LabelWidth, height: Constants.LabelHeight)
            if(n > LineLyricsList.count || n > LineLyricsList.count - 1 || n > LineLyricsList.count - 2 || n > LineLyricsList.count - 3 || n > LineLyricsList.count - 4 || n > LineLyricsList.count - 5)
            {
                self.labelLine6.text =  ""
                self.labelLine6A.text =  ""
            }
            else{
                self.labelLine6.text =  LineLyricsList[n + 4].Line
                self.labelLine6A.text =  LineLyricsList[n + 4].Line
            }
            
        }
        if(n == LineLyricsList.count){
            sleep(2)
            self.labelLine1.alpha = Constants.labelAlpha
            self.labelLine2.alpha = Constants.labelAlpha
            self.labelLine3.alpha = Constants.labelAlpha
            self.labelLine4.alpha = Constants.labelAlpha
            self.labelLine5.alpha = Constants.labelAlpha
            self.labelLine6.alpha = Constants.labelAlpha
            self.labelLine1A.alpha = Constants.labelAlpha
            self.labelLine2A.alpha = Constants.labelAlpha
            self.labelLine3A.alpha = Constants.labelAlpha
            self.labelLine4A.alpha = Constants.labelAlpha
            self.labelLine5A.alpha = Constants.labelAlpha
            self.labelLine6A.alpha = Constants.labelAlpha
        }
        
        
    }
    
    func StartText(timer:NSTimer){
        var NewArray = (timer.userInfo as? NSArray)! as Array
        let n = NewArray[0] as! NSNumber
        let Start = (NewArray[1] as! NSString).doubleValue
        let End = (NewArray[2] as! NSString).doubleValue
        let StartEndDifference = End - Start
        
        AnimateText(Int(n),Diff: StartEndDifference)
    }
    
    func AnimateText(var i: Int,Diff:Double)
    {
        var yAxis:CGFloat = 0
        let XAxis:CGFloat = 50
        
        if (i == 1){
            yAxis = 100
        }
        else if(i > 1){
            yAxis = (100 + ((CGFloat(i)-1)*50))
        }
        
        if(i > 6)
        {
            if(i%6 == 0){
                i = 6
            }
            else{
                i = i%6
            }
        }
        switch i {
        case 1:
            
            UILabel.animateWithDuration(Diff + 1, animations: {
                
                self.labelLine1A.frame = CGRect(x: XAxis, y: yAxis, width:0, height: Constants.LabelHeight)
                
            })
        case 2:
            UILabel.animateWithDuration(Diff + 1, animations: {
                
                self.labelLine2A.frame = CGRect(x: XAxis, y: yAxis, width: 0, height: Constants.LabelHeight)
            })
        case 3:
            UILabel.animateWithDuration(Diff + 1, animations: {
                
                self.labelLine3A.frame = CGRect(x: XAxis, y: yAxis, width: 0, height: Constants.LabelHeight)
            })
        case 4:
            UILabel.animateWithDuration(Diff + 1, animations: {
                
                self.labelLine4A.frame = CGRect(x: XAxis, y: yAxis, width: 0, height: Constants.LabelHeight)
            })
        case 5:
            UILabel.animateWithDuration(Diff + 1, animations: {
                
                self.labelLine5A.frame = CGRect(x: XAxis, y: yAxis, width: 0, height: Constants.LabelHeight)
            })
        case 6:
            UILabel.animateWithDuration(Diff + 1, animations: {
                
                self.labelLine6A.frame = CGRect(x: XAxis, y: yAxis, width: 0, height: Constants.LabelHeight)
            })
            
        default:
            false
        }
    }
    // Set initial 6 lines to all 6 labels (one by one)
    func SetText(i: Int, Line: String)
    {
        
        switch i {
        case 1:
            self.labelLine1.text = Line
            self.labelLine1A.text = Line
        case 2:
            self.labelLine2.text = Line
            self.labelLine2A.text = Line
        case 3:
            self.labelLine3.text = Line
            self.labelLine3A.text = Line
        case 4:
            self.labelLine4.text = Line
            self.labelLine4A.text = Line
        case 5:
            self.labelLine5.text = Line
            self.labelLine5A.text = Line
        case 6:
            self.labelLine6.text = Line
            self.labelLine6A.text = Line
        default:
            false
        }
    }
    // Functions Repeated1,Repeated2,Repeated3,Repeated4,Repeated5 & Repeated6 do scaling,coloring,fading to the labels
    
func Repeated1(){
    self.labelLine1.transform = CGAffineTransformMakeScale(Constants.labelScaleX, Constants.labelScaleY)
    self.labelLine1.textColor = UIColor.redColor().colorWithAlphaComponent(Constants.labelColorPartial)
    
    self.labelLine2.transform = CGAffineTransformMakeScale(Constants.labelScaleXMain, Constants.labelScaleYMain)
    self.labelLine2.textColor = UIColor.redColor().colorWithAlphaComponent(Constants.labelColorFull)
    
    self.labelLine3.transform = CGAffineTransformMakeScale(Constants.labelScaleX, Constants.labelScaleY)
    self.labelLine3.textColor = UIColor.redColor().colorWithAlphaComponent(Constants.labelColorFull)
    self.labelLine4.transform = CGAffineTransformMakeScale(Constants.labelScaleX, Constants.labelScaleY)
    self.labelLine4.textColor = UIColor.redColor().colorWithAlphaComponent(Constants.labelColorFull)
    self.labelLine5.transform = CGAffineTransformMakeScale(Constants.labelScaleX, Constants.labelScaleY)
    self.labelLine5.textColor = UIColor.redColor().colorWithAlphaComponent(Constants.labelColorFull)
    
    self.labelLine6.transform = CGAffineTransformMakeScale(Constants.labelScaleX, Constants.labelScaleY)
    self.labelLine6.textColor = UIColor.blackColor().colorWithAlphaComponent(Constants.labelColorPartial)
    
    self.labelLine1A.transform = CGAffineTransformMakeScale(Constants.labelScaleX, Constants.labelScaleY)
    self.labelLine1A.textColor = UIColor.redColor().colorWithAlphaComponent(Constants.labelColorPartial)
    
    self.labelLine2A.transform = CGAffineTransformMakeScale(Constants.labelScaleXMain, Constants.labelScaleYMain)
    self.labelLine2A.textColor = UIColor.blackColor().colorWithAlphaComponent(Constants.labelColorFull)
    
    self.labelLine3A.transform = CGAffineTransformMakeScale(Constants.labelScaleX, Constants.labelScaleY)
    self.labelLine3A.textColor = UIColor.blackColor().colorWithAlphaComponent(Constants.labelColorFull)
    self.labelLine4A.transform = CGAffineTransformMakeScale(Constants.labelScaleX, Constants.labelScaleY)
    self.labelLine4A.textColor = UIColor.blackColor().colorWithAlphaComponent(Constants.labelColorFull)
    self.labelLine5A.transform = CGAffineTransformMakeScale(Constants.labelScaleX, Constants.labelScaleY)
    self.labelLine5A.textColor = UIColor.blackColor().colorWithAlphaComponent(Constants.labelColorFull)
        
    self.labelLine6A.transform = CGAffineTransformMakeScale(Constants.labelScaleX, Constants.labelScaleY)
    self.labelLine6A.textColor = UIColor.blackColor().colorWithAlphaComponent(Constants.labelColorPartial)
    }
    
func Repeated2(){
    self.labelLine2.transform = CGAffineTransformMakeScale(Constants.labelScaleX, Constants.labelScaleY)
    self.labelLine2.textColor = UIColor.redColor().colorWithAlphaComponent(Constants.labelColorPartial)
    
    self.labelLine3.transform = CGAffineTransformMakeScale(Constants.labelScaleXMain, Constants.labelScaleYMain)
    self.labelLine3.textColor = UIColor.redColor().colorWithAlphaComponent(Constants.labelColorFull)
    
    self.labelLine4.transform = CGAffineTransformMakeScale(Constants.labelScaleX, Constants.labelScaleY)
    self.labelLine4.textColor = UIColor.redColor().colorWithAlphaComponent(Constants.labelColorFull)
    self.labelLine5.transform = CGAffineTransformMakeScale(Constants.labelScaleX, Constants.labelScaleY)
    self.labelLine5.textColor = UIColor.redColor().colorWithAlphaComponent(Constants.labelColorFull)
    self.labelLine6.transform = CGAffineTransformMakeScale(Constants.labelScaleX, Constants.labelScaleY)
    self.labelLine6.textColor = UIColor.redColor().colorWithAlphaComponent(Constants.labelColorFull)
    
    self.labelLine1.transform = CGAffineTransformMakeScale(Constants.labelScaleX, Constants.labelScaleY)
    self.labelLine1.textColor = UIColor.blackColor().colorWithAlphaComponent(Constants.labelColorPartial)
    
    self.labelLine2A.transform = CGAffineTransformMakeScale(Constants.labelScaleX, Constants.labelScaleY)
    self.labelLine2A.textColor = UIColor.redColor().colorWithAlphaComponent(Constants.labelColorPartial)
    
    self.labelLine3A.transform = CGAffineTransformMakeScale(Constants.labelScaleXMain, Constants.labelScaleYMain)
    self.labelLine3A.textColor = UIColor.blackColor().colorWithAlphaComponent(Constants.labelColorFull)
    
    self.labelLine4A.transform = CGAffineTransformMakeScale(Constants.labelScaleX, Constants.labelScaleY)
    self.labelLine4A.textColor = UIColor.blackColor().colorWithAlphaComponent(Constants.labelColorFull)
    self.labelLine5A.transform = CGAffineTransformMakeScale(Constants.labelScaleX, Constants.labelScaleY)
    self.labelLine5A.textColor = UIColor.blackColor().colorWithAlphaComponent(Constants.labelColorFull)
    self.labelLine6A.transform = CGAffineTransformMakeScale(Constants.labelScaleX, Constants.labelScaleY)
    self.labelLine6A.textColor = UIColor.blackColor().colorWithAlphaComponent(Constants.labelColorFull)
    
    self.labelLine1A.transform = CGAffineTransformMakeScale(Constants.labelScaleX, Constants.labelScaleY)
    self.labelLine1A.textColor = UIColor.blackColor().colorWithAlphaComponent(Constants.labelColorPartial)
    }
    
func Repeated3(){
    self.labelLine3.transform = CGAffineTransformMakeScale(Constants.labelScaleX, Constants.labelScaleY)
    self.labelLine3.textColor = UIColor.redColor().colorWithAlphaComponent(Constants.labelColorPartial)
    
    self.labelLine4.transform = CGAffineTransformMakeScale(Constants.labelScaleXMain, Constants.labelScaleYMain)
    self.labelLine4.textColor = UIColor.redColor().colorWithAlphaComponent(Constants.labelColorFull)
    self.labelLine5.transform = CGAffineTransformMakeScale(Constants.labelScaleX, Constants.labelScaleY)
    self.labelLine5.textColor = UIColor.redColor().colorWithAlphaComponent(Constants.labelColorFull)
    self.labelLine6.transform = CGAffineTransformMakeScale(Constants.labelScaleX, Constants.labelScaleY)
    self.labelLine6.textColor = UIColor.redColor().colorWithAlphaComponent(Constants.labelColorFull)
    
    self.labelLine1.transform = CGAffineTransformMakeScale(Constants.labelScaleX, Constants.labelScaleY)
    self.labelLine1.textColor = UIColor.redColor().colorWithAlphaComponent(Constants.labelColorFull)
    
    self.labelLine2.transform = CGAffineTransformMakeScale(Constants.labelScaleX, Constants.labelScaleY)
    self.labelLine2.textColor = UIColor.blackColor().colorWithAlphaComponent(Constants.labelColorPartial)
    
    self.labelLine3A.transform = CGAffineTransformMakeScale(Constants.labelScaleX, Constants.labelScaleY)
    self.labelLine3A.textColor = UIColor.redColor().colorWithAlphaComponent(Constants.labelColorPartial)
    
    self.labelLine4A.transform = CGAffineTransformMakeScale(Constants.labelScaleXMain, Constants.labelScaleYMain)
    self.labelLine4A.textColor = UIColor.blackColor().colorWithAlphaComponent(Constants.labelColorFull)
    self.labelLine5A.transform = CGAffineTransformMakeScale(Constants.labelScaleX, Constants.labelScaleY)
    self.labelLine5A.textColor = UIColor.blackColor().colorWithAlphaComponent(Constants.labelColorFull)
    self.labelLine6A.transform = CGAffineTransformMakeScale(Constants.labelScaleX, Constants.labelScaleY)
    self.labelLine6A.textColor = UIColor.blackColor().colorWithAlphaComponent(Constants.labelColorFull)
    
    self.labelLine1A.transform = CGAffineTransformMakeScale(Constants.labelScaleX, Constants.labelScaleY)
    self.labelLine1A.textColor = UIColor.blackColor().colorWithAlphaComponent(Constants.labelColorFull)
        
    self.labelLine2A.transform = CGAffineTransformMakeScale(Constants.labelScaleX, Constants.labelScaleY)
    self.labelLine2A.textColor = UIColor.blackColor().colorWithAlphaComponent(Constants.labelColorPartial)
    }
    
func Repeated4(){
    self.labelLine4.transform = CGAffineTransformMakeScale(Constants.labelScaleX, Constants.labelScaleY)
    self.labelLine4.textColor = UIColor.redColor().colorWithAlphaComponent(Constants.labelColorPartial)
    
    self.labelLine5.transform = CGAffineTransformMakeScale(Constants.labelScaleXMain, Constants.labelScaleYMain)
    self.labelLine5.textColor = UIColor.redColor().colorWithAlphaComponent(Constants.labelColorFull)
    self.labelLine6.transform = CGAffineTransformMakeScale(Constants.labelScaleX, Constants.labelScaleY)
    self.labelLine6.textColor = UIColor.redColor().colorWithAlphaComponent(Constants.labelColorFull)
    
    self.labelLine1.transform = CGAffineTransformMakeScale(Constants.labelScaleX, Constants.labelScaleY)
    self.labelLine1.textColor = UIColor.redColor().colorWithAlphaComponent(Constants.labelColorFull)
    self.labelLine2.transform = CGAffineTransformMakeScale(Constants.labelScaleX, Constants.labelScaleY)
    self.labelLine2.textColor = UIColor.redColor().colorWithAlphaComponent(Constants.labelColorFull)
    
    self.labelLine3.transform = CGAffineTransformMakeScale(Constants.labelScaleX, Constants.labelScaleY)
    self.labelLine3.textColor = UIColor.blackColor().colorWithAlphaComponent(Constants.labelColorPartial)
    
    self.labelLine4A.transform = CGAffineTransformMakeScale(Constants.labelScaleX, Constants.labelScaleY)
    self.labelLine4A.textColor = UIColor.redColor().colorWithAlphaComponent(Constants.labelColorPartial)
    
    self.labelLine5A.transform = CGAffineTransformMakeScale(Constants.labelScaleXMain, Constants.labelScaleYMain)
    self.labelLine5A.textColor = UIColor.blackColor().colorWithAlphaComponent(Constants.labelColorFull)
    self.labelLine6A.transform = CGAffineTransformMakeScale(Constants.labelScaleX, Constants.labelScaleY)
    self.labelLine6A.textColor = UIColor.blackColor().colorWithAlphaComponent(Constants.labelColorFull)
    
    self.labelLine1A.transform = CGAffineTransformMakeScale(Constants.labelScaleX, Constants.labelScaleY)
    self.labelLine1A.textColor = UIColor.blackColor().colorWithAlphaComponent(Constants.labelColorFull)
    self.labelLine2A.transform = CGAffineTransformMakeScale(Constants.labelScaleX, Constants.labelScaleY)
    self.labelLine2A.textColor = UIColor.blackColor().colorWithAlphaComponent(Constants.labelColorFull)
    
    self.labelLine3A.transform = CGAffineTransformMakeScale(Constants.labelScaleX, Constants.labelScaleY)
    self.labelLine3A.textColor = UIColor.blackColor().colorWithAlphaComponent(Constants.labelColorPartial)
        
            }
func Repeated5(){
    self.labelLine5.transform = CGAffineTransformMakeScale(Constants.labelScaleX, Constants.labelScaleY)
    self.labelLine5.textColor = UIColor.redColor().colorWithAlphaComponent(Constants.labelColorPartial)
    
    self.labelLine6.transform = CGAffineTransformMakeScale(Constants.labelScaleXMain, Constants.labelScaleYMain)
    self.labelLine6.textColor = UIColor.redColor().colorWithAlphaComponent(Constants.labelColorFull)
    
    self.labelLine1.transform = CGAffineTransformMakeScale(Constants.labelScaleX, Constants.labelScaleY)
    self.labelLine1.textColor = UIColor.redColor().colorWithAlphaComponent(Constants.labelColorFull)
    self.labelLine2.transform = CGAffineTransformMakeScale(Constants.labelScaleX, Constants.labelScaleY)
    self.labelLine2.textColor = UIColor.redColor().colorWithAlphaComponent(Constants.labelColorFull)
    self.labelLine3.transform = CGAffineTransformMakeScale(Constants.labelScaleX, Constants.labelScaleY)
    self.labelLine3.textColor = UIColor.redColor().colorWithAlphaComponent(Constants.labelColorFull)
    
    self.labelLine4.transform = CGAffineTransformMakeScale(Constants.labelScaleX, Constants.labelScaleY)
    self.labelLine4.textColor = UIColor.blackColor().colorWithAlphaComponent(Constants.labelColorPartial)
    
    self.labelLine5A.transform = CGAffineTransformMakeScale(Constants.labelScaleX, Constants.labelScaleY)
    self.labelLine5A.textColor = UIColor.redColor().colorWithAlphaComponent(Constants.labelColorPartial)
    
    self.labelLine6A.transform = CGAffineTransformMakeScale(Constants.labelScaleXMain, Constants.labelScaleYMain)
    self.labelLine6A.textColor = UIColor.blackColor().colorWithAlphaComponent(Constants.labelColorFull)
    
    self.labelLine1A.transform = CGAffineTransformMakeScale(Constants.labelScaleX, Constants.labelScaleY)
    self.labelLine1A.textColor = UIColor.blackColor().colorWithAlphaComponent(Constants.labelColorFull)
    self.labelLine2A.transform = CGAffineTransformMakeScale(Constants.labelScaleX, Constants.labelScaleY)
    self.labelLine2A.textColor = UIColor.blackColor().colorWithAlphaComponent(Constants.labelColorFull)
    self.labelLine3A.transform = CGAffineTransformMakeScale(Constants.labelScaleX, Constants.labelScaleY)
    self.labelLine3A.textColor = UIColor.blackColor().colorWithAlphaComponent(Constants.labelColorFull)
    
    self.labelLine4A.transform = CGAffineTransformMakeScale(Constants.labelScaleX, Constants.labelScaleY)
    self.labelLine4A.textColor = UIColor.blackColor().colorWithAlphaComponent(Constants.labelColorPartial)
            }
func Repeated6(){
    self.labelLine6.transform = CGAffineTransformMakeScale(Constants.labelScaleX, Constants.labelScaleY)
    self.labelLine6.textColor = UIColor.redColor().colorWithAlphaComponent(Constants.labelColorPartial)
    
    self.labelLine1.transform = CGAffineTransformMakeScale(Constants.labelScaleXMain, Constants.labelScaleYMain)
    self.labelLine1.textColor = UIColor.redColor().colorWithAlphaComponent(Constants.labelColorFull)
    
    self.labelLine2.transform = CGAffineTransformMakeScale(Constants.labelScaleX, Constants.labelScaleY)
    self.labelLine2.textColor = UIColor.redColor().colorWithAlphaComponent(Constants.labelColorFull)
    self.labelLine3.transform = CGAffineTransformMakeScale(Constants.labelScaleX, Constants.labelScaleY)
    self.labelLine3.textColor = UIColor.redColor().colorWithAlphaComponent(Constants.labelColorFull)
    self.labelLine4.transform = CGAffineTransformMakeScale(Constants.labelScaleX, Constants.labelScaleY)
    self.labelLine4.textColor = UIColor.redColor().colorWithAlphaComponent(Constants.labelColorFull)
    
    self.labelLine5.transform = CGAffineTransformMakeScale(Constants.labelScaleX, Constants.labelScaleY)
    self.labelLine5.textColor = UIColor.blackColor().colorWithAlphaComponent(Constants.labelColorPartial)
    
    self.labelLine6A.transform = CGAffineTransformMakeScale(Constants.labelScaleX, Constants.labelScaleY)
    self.labelLine6A.textColor = UIColor.redColor().colorWithAlphaComponent(Constants.labelColorPartial)
    
    self.labelLine1A.transform = CGAffineTransformMakeScale(Constants.labelScaleXMain, Constants.labelScaleYMain)
    self.labelLine1A.textColor = UIColor.blackColor().colorWithAlphaComponent(Constants.labelColorFull)
    
    self.labelLine2A.transform = CGAffineTransformMakeScale(Constants.labelScaleX, Constants.labelScaleY)
    self.labelLine2A.textColor = UIColor.blackColor().colorWithAlphaComponent(Constants.labelColorFull)
    self.labelLine3A.transform = CGAffineTransformMakeScale(Constants.labelScaleX, Constants.labelScaleY)
    self.labelLine3A.textColor = UIColor.blackColor().colorWithAlphaComponent(Constants.labelColorFull)
    self.labelLine4A.transform = CGAffineTransformMakeScale(Constants.labelScaleX, Constants.labelScaleY)
    self.labelLine4A.textColor = UIColor.blackColor().colorWithAlphaComponent(Constants.labelColorFull)
    
    self.labelLine5A.transform = CGAffineTransformMakeScale(Constants.labelScaleX, Constants.labelScaleY)
    self.labelLine5A.textColor = UIColor.blackColor().colorWithAlphaComponent(Constants.labelColorPartial)
        
    }
    
    func CreateOnLoad()
    {
    self.labelLine1.textAlignment = NSTextAlignment.Center
    self.labelLine1.textColor=UIColor.redColor().colorWithAlphaComponent(Constants.labelColorFull)
    self.labelLine1.transform = CGAffineTransformMakeScale(Constants.labelScaleXMain, Constants.labelScaleYMain)
    self.view.addSubview(labelLine1)
    
    self.labelLine2.textAlignment = NSTextAlignment.Center
    self.labelLine2.textColor=UIColor.redColor().colorWithAlphaComponent(Constants.labelColorFull)
    self.view.addSubview(labelLine2)
    
    self.labelLine3.textAlignment = NSTextAlignment.Center
    self.labelLine3.textColor=UIColor.redColor().colorWithAlphaComponent(Constants.labelColorFull)
    self.view.addSubview(labelLine3)
    
    self.labelLine4.textAlignment = NSTextAlignment.Center
    self.labelLine4.textColor=UIColor.redColor().colorWithAlphaComponent(Constants.labelColorFull)
    self.view.addSubview(labelLine4)
    
    self.labelLine5.textAlignment = NSTextAlignment.Center
    self.labelLine5.textColor=UIColor.redColor().colorWithAlphaComponent(Constants.labelColorFull)
    self.view.addSubview(labelLine5)
    
    self.labelLine6.textAlignment = NSTextAlignment.Center
    self.labelLine6.textColor=UIColor.blackColor().colorWithAlphaComponent(0.0)
    self.view.addSubview(labelLine6)
    
    self.labelLine1A.textAlignment = NSTextAlignment.Center
    self.labelLine1A.textColor=UIColor.blackColor().colorWithAlphaComponent(Constants.labelColorFull)
    self.labelLine1A.transform = CGAffineTransformMakeScale(Constants.labelScaleXMain, Constants.labelScaleYMain)
    self.view.addSubview(labelLine1A)
    
    self.labelLine2A.textAlignment = NSTextAlignment.Center
    self.labelLine2A.textColor=UIColor.blackColor().colorWithAlphaComponent(Constants.labelColorFull)
    self.view.addSubview(labelLine2A)
    
    self.labelLine3A.textAlignment = NSTextAlignment.Center
    self.labelLine3A.textColor=UIColor.blackColor().colorWithAlphaComponent(Constants.labelColorFull)
    self.view.addSubview(labelLine3A)
    
    self.labelLine4A.textAlignment = NSTextAlignment.Center
    self.labelLine4A.textColor=UIColor.blackColor().colorWithAlphaComponent(Constants.labelColorFull)
    self.view.addSubview(labelLine4A)
    
    self.labelLine5A.textAlignment = NSTextAlignment.Center
    self.labelLine5A.textColor=UIColor.blackColor().colorWithAlphaComponent(Constants.labelColorFull)
    self.view.addSubview(labelLine5A)
    
    self.labelLine6A.textAlignment = NSTextAlignment.Center
    self.labelLine6A.textColor=UIColor.blackColor().colorWithAlphaComponent(0.0)
    self.view.addSubview(labelLine6A)
    
    self.ViewMainLine1.addSubview(labelLine1)
    self.ViewMainLine1.addSubview(labelLine2)
    self.ViewMainLine1.addSubview(labelLine3)
    self.ViewMainLine1.addSubview(labelLine4)
    self.ViewMainLine1.addSubview(labelLine5)
    self.ViewMainLine1.addSubview(labelLine6)
    self.ViewMainLine1.addSubview(labelLine1A)
    self.ViewMainLine1.addSubview(labelLine2A)
    self.ViewMainLine1.addSubview(labelLine3A)
    self.ViewMainLine1.addSubview(labelLine4A)
    self.ViewMainLine1.addSubview(labelLine5A)
    self.ViewMainLine1.addSubview(labelLine6A)
    
    self.ViewMainLine1.frame = CGRect(x: Constants.ViewxAxis, y: 100, width: Constants.ViewWidth, height: Constants.ViewHeight)
    self.view.addSubview(ViewMainLine1)
    }
}

