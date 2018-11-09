//
//  VideoDetailViewController.swift
//  Test-Cocoa
//
//  Created by Andre Sampaio on 22/10/18.
//  Copyright © 2018 Andre Sampaio. All rights reserved.
//

import UIKit


class VideoDetailViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    //@IBOutlet weak var webViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var webViewHeight: NSLayoutConstraint!
    
    var selectedVideo:Video?
    
    //var vid:Video?


    
    override func viewDidLoad() {
        super.viewDidLoad()
        //webView.scalesPageToFit = true

        // Do any additional setup after loading the view.
    }
    
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation){
        let width = self.view.frame.size.width
        let height = width/320 * 180
        self.webViewHeight.constant = height
        
        
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if let vid = self.selectedVideo{
            self.titleLabel.text = vid.videoTitle
            self.descriptionLabel.text = vid.videoDescription
            
            
            let width = self.view.frame.size.width
            let height = width/320 * 180
            
            // Adjust the height of the webview constrain
            self.webViewHeight.constant = height
            
            
            
            let videoEmbedString = "<html><head><style type=\"text/css\">body {background-color: transparent;color: white;}</style></head><body style=\"margin:0\"><iframe frameBorder=\"0\" height=\"" + String(Int(Float(height))) + "\" width=\"" + String(Int(Float(width))) + "\" src=\"http://www.youtube.com/embed/" + vid.videoID + "?showinfo=0&modestbranding=1&frameborder=0&rel=0\"></iframe></body></html>"
            
            self.webView.loadHTMLString(videoEmbedString, baseURL: nil)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
