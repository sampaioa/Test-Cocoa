//
//  ViewController.swift
//  Test-Cocoa
//
//  Created by Andre Sampaio on 16/10/18.
//  Copyright © 2018 Andre Sampaio. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    //Table view object
    var videos:[Video] = [Video]()
    var  selectedVideo:Video?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //self.videos = VideoModel().getVideos()
        
        let model = VideoModel()
        //Fire of request to get videos
        model.getFeedVideos()
        
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
    
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //Get the with of the screen to calculate the heigh of he row
       return (self.view.frame.size.width / 320) * 180
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BasicCell")!
        
        let videoTitle = videos[indexPath.row].videoTitle
        
        //Get the labe for the cell
        let label = cell.viewWithTag(2) as! UILabel
        label.text = videoTitle
            
            //Custumise cell to dislay video title
        //cell.textLabel?.text = videoTitle
        
        //Construct the Video Thumbnail
        let videoThumbnailUrlString = "https://i1.ytimg.com/vi/" + videos[indexPath.row].videoID + "/maxresdefault.jpg"
        
        // Create an NSURL Object
        let videoThumbnailUrl = URL(string: videoThumbnailUrlString)
        
        if videoThumbnailUrl != nil {
            
            //Create an NSURLRequest object
            let request = URLRequest(url: videoThumbnailUrl!)
            
            //Cretae an NSURLSession
            let session = URLSession.shared
            
            //Create a datatask and pass in the request
            let dataTask = session.dataTask(with: request) { (data:Data?, response:URLResponse?, error:Error?) -> Void in
                
                DispatchQueue.main.async {
                    //Get a reference to the imageview element of the cell
                    let imageView = cell.viewWithTag(1) as! UIImageView
                    
                    //Create an image objet from the data and assi    gn it into the image view
                    imageView.image = UIImage(data: data!)                }
                
                
                   
            }
            
            dataTask.resume()
            
        }
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Take note of wich view the user selected
        self.selectedVideo =  self.videos[indexPath.row]
        
        // Call the Segue
        self.performSegue(withIdentifier: "goToDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get a reference to the destination view controller
        let detailViewController = segue.destination as! VideoDetailViewController
        // Set the selected video property of the destination view controller
        detailViewController.selectedVideo = self.selectedVideo
    }
    
}


