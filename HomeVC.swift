//
//  HomeVC.swift
//  AKSwiftSlideMenu
//
//  Created by MAC-186 on 4/8/16.
//  Copyright © 2016 Kode. All rights reserved.
//

import UIKit

 class HomeVC: BaseViewController {

    @IBOutlet weak var lblQuote: UILabel!
    var QuotesCollection = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        addSlideMenuButton()
        // Do any additional setup after loading the view.
        QuotesCollection.append("To be or not to be. - William Shakespeare")
        QuotesCollection.append("Everything is funny if observed carefully!- Shivi Gupta")
        QuotesCollection.append("How to kill a mocking bird. - Harper Lee")
        lblQuote.adjustsFontSizeToFitWidth=true
       // let res=updateIP()
        // Do any additional setup after loading the view, typically from a nib.
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeUp.direction = .up
        self.view.addGestureRecognizer(swipeUp)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeDown.direction = .down
        self.view.addGestureRecognizer(swipeDown)
    }
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        if gesture.direction == UISwipeGestureRecognizerDirection.right {
            //  print("Swipe Right")
            lblQuote.text=QuotesCollection[0]
        }
        else if gesture.direction == UISwipeGestureRecognizerDirection.left {
            lblQuote.text=QuotesCollection[1]
        }
        else if gesture.direction == UISwipeGestureRecognizerDirection.up {
            // print("Swipe Up")
            lblQuote.text=QuotesCollection[2]
            lblQuote.font=UIFont(name:"HelveticaNeue",size:24)
        }
        else if gesture.direction == UISwipeGestureRecognizerDirection.down {
            
           // lblQuote.text=QuotesCollection[3]
            
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getDetail(withRequest request: URLRequest, withCompletion completion: @escaping (String?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            if error != nil {
                completion(nil, error)
                return
            }
            else if let data = data {
                do {
                    guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] else {completion(nil, nil);return}
                    guard let details = json["detail"] as? String else {completion(nil, nil);return}
                    completion(details, nil)
                }
                catch {
                    completion(nil, error)
                }
            }
        }
        task.resume()
    }
    
    
    func updateIP() -> String{
       
        
        // Setup the session to make REST GET call.  Notice the URL is https NOT http!!
        let postEndpoint: String = "https://spreadsheets.google.com/feeds/list/1omT0mse1YMgIChm2rwsKEoP-_upuzZ0GGQ-25a-wG_E/od6/public/values?alt=json"
        let session = URLSession.shared
        let url = URL(string: postEndpoint)!
        
        // Make the POST call and handle it in a completion handler
        session.dataTask(with: url, completionHandler: { ( data: Data?, response: URLResponse?, error: Error?) -> Void in
            // Make sure we get an OK response
            guard let realResponse = response as? HTTPURLResponse,
                realResponse.statusCode == 200 else {
                    print("Not a 200 response ")
                    return
            }
            
            // Read the JSON
            do {
                if let ipString = NSString(data:data!, encoding: String.Encoding.utf8.rawValue) {
                    // Print what we got from the call
                    // print(ipString)
                    //self.JsonQueryResponse=ipString as String
                    if let dataFromString = ipString.data(using: String.Encoding.utf8.rawValue, allowLossyConversion: false) {
                        //  let json = JSON(data: dataFromString)
                        //                        if let status = json["status"].string {
                        //                            print("status: \(status)")
                        //                        }
                        print(dataFromString)
                       
                    }
                    self.QuotesCollection.append("String")
                    
                    //    let json: [String:Any?] = JsonQueryResponse.toJSON() as [String:Any?]
                    // Parse the JSON to get the IP
                    //  let jsonDictionary = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                    //  let origin = jsonDictionary["origin"] as! String
                    
                    // Update the label
                    
                }
            }
        } ).resume()
       
        return "JsonQueryResponse"
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
