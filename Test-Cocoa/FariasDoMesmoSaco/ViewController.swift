//
//  ViewController.swift
//  Test-Cocoa
//
//  Created by Andre Sampaio on 16/10/18.
//  Copyright © 2018 Andre Sampaio. All rights reserved.
//

import UIKit
//import FBSDKCoreKit
//import FBSDKShareKit
//import FBSDKLoginKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, VideoModelDelegate {
    
    
    @IBOutlet var tableView: UITableView!
    //Table view object
    var videos:[Video] = [Video]()
    var  selectedVideo:Video?
    let model: VideoModel = VideoModel()
    //let imageView = UIImageView(image: UIImage(named: "Logo.png"))
    
    var refreshControl   = UIRefreshControl()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //self.videos = VideoModel().getVideos()
        
        loadVideos()
        
        
        //setupUI()
        
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        self.tableView.addSubview(refreshControl)
        
        //self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
}
    
    func loadVideos(){
        self.model.delegate = self
        //let model = VideoModel()
        //Fire of request to get videos
        model.getFeedVideos()
        
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    //VideoModel Delegate Method
    func dataReady(){
        //Access the video Objects that have been downloaded
        self.videos = self.model.videoArray
        
        //Tell the tableview to reload
        self.tableView.reloadData()
        
    }
    
    //TableView Delegate Methods

    
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
        let videoThumbnailUrlString = videos[indexPath.row].videoThumbnailUrl
        
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
        if  segue.identifier == "goToDetail" as String?{
        let detailViewController = segue.destination as! VideoDetailViewController
        // Set the selected video property of the destination view controller
        detailViewController.selectedVideo = self.selectedVideo
        }
    }
    
//    struct Const {
//        /// Image height/width for Large NavBar state
//        static let ImageSizeForLargeState: CGFloat = 40
//        /// Margin from right anchor of safe area to right anchor of Image
//        static let ImageRightMargin: CGFloat = 16
//        /// Margin from bottom anchor of NavBar to bottom anchor of Image for Large NavBar state
//        static let ImageBottomMarginForLargeState: CGFloat = 12
//        /// Margin from bottom anchor of NavBar to bottom anchor of Image for Small NavBar state
//        static let ImageBottomMarginForSmallState: CGFloat = 6
//        /// Image height/width for Small NavBar state
//        static let ImageSizeForSmallState: CGFloat = 30
//        /// Height of NavBar for Small state. Usually it's just 44
//        static let NavBarHeightSmallState: CGFloat = 44
//        /// Height of NavBar for Large state. Usually it's just 96.5 but if you have a custom font for the title, please make sure to edit this value since it changes the height for Large state of NavBar
//        static let NavBarHeightLargeState: CGFloat = 44
//    }
    
//    private func setupUI() {
//        navigationController?.navigationBar.prefersLargeTitles = true
//
//        title = "Farias do Mesmo Saco - Filmes e Series"
//
//        self.navigationController?.navigationBar.largeTitleTextAttributes = [
//            //NSAttributedString.Key.foregroundColor: UIColor.red,
//            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17)
//        ]
//
//
//
//
//        // Initial setup for image for Large NavBar state since the the screen always has Large NavBar once it gets opened
//        guard let navigationBar = self.navigationController?.navigationBar else { return }
//        navigationBar.addSubview(imageView)
//        imageView.layer.cornerRadius = Const.ImageSizeForLargeState / 2
//        imageView.clipsToBounds = true
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            imageView.rightAnchor.constraint(equalTo: navigationBar.rightAnchor, constant: -Const.ImageRightMargin),
//            imageView.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: -Const.ImageBottomMarginForLargeState),
//            imageView.heightAnchor.constraint(equalToConstant: Const.ImageSizeForLargeState),
//            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor)
//            ])
//
//
//    }
    
    @objc func refresh(_ sender: Any) {
        
        self.tableView.reloadData()
        loadVideos()
        refreshControl.endRefreshing()
        
        // Call webservice here after reload tableview.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

//Popup screen for login
    
    @IBOutlet var popOver: UIView!
    
    @IBAction func popBT(_ sender: Any)
    {
        self.view.addSubview(popOver)
        popOver.center = self.view.center
    }
    
    
    
}


