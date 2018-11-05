//
//  VideoModel.swift
//  Test-Cocoa
//
//  Created by Andre Sampaio on 18/10/18.
//  Copyright © 2018 Andre Sampaio. All rights reserved.
//

import UIKit
import Alamofire
protocol VideoModelDelegate {
    func dataReady()
}

class VideoModel: NSObject {
    
    let API_KEY = "AIzaSyAlo2-408PmIdoH6GqNp1iKhZkR00vO_GM"
    let UPLOADS_PLAYLIST_ID = "PLjEkvB9j5CIlE7gviSRRMCzY_b4S5cNEV"
    let URL_YOUTUBE = "https://www.googleapis.com/youtube/v3/playlistItems"
    var videoArray = [Video]()
    var delegate:VideoModelDelegate?
    
    
    func getFeedVideos() {
        

        //Fetch the videos dynamically through the YouTube API
        
        Alamofire.request(URL_YOUTUBE, method: .get, parameters: ["maxResults": "25", "part":"snippet","playlistId": UPLOADS_PLAYLIST_ID,"key": API_KEY], encoding: URLEncoding.default, headers: nil).responseJSON { (response) -> Void in
            
            if let JSON = response.result.value as? [String: Any] {
                //let JSON_RESULTS = JSON["entry"] as Any
                var arrayOfVideos = [Video]()
                //print(arrayOfVideos)
                if let playlist = JSON["items"] as? [Any] {
                    
                    let video = JSON["items"] as! NSArray
                    print(video)
                    
                    for i in 0..<playlist.count {
                
                    
                    
                    let videoObj = Video()
                        if let video = playlist[i] as? [String: Any]{
                            if let snippet = video["snippet"] as? [String: Any]{
                                if let resourceId = snippet["resourceId"] as? [String: Any] {
                                    if let videoId = resourceId["videoId"] as? String {
                                        videoObj.videoID = videoId
                            }
                                if let videoTitle = snippet["title"] as? String {
                                    videoObj.videoTitle = videoTitle
                                }
                                
                                if let videoDescription = snippet["description"] as? String {
                                    videoObj.videoDescription = videoDescription
                                }
                            
                            if let thumbnails = snippet["thumbnails"] as? [String: Any]{
                                if let maxres = thumbnails["medium"] as? [String: Any] {
                                    if let url = maxres["url"] as? String {
                                        videoObj.videoThumbnailUrl = url
                                        
                                    }else{
                                        if let maxres = thumbnails["maxres"] as? [String: Any] {
                                            if let url = maxres["url"] as? String {
                                                videoObj.videoThumbnailUrl = url
                                            }
                                            
                                        }
                                    }
                                }
                                }}
                            }
                    //videoObj.videoTitle = Video.value(forKeyPath: "snipper.tittle") as! String
                    //videoObj.videoDescription = Video.value(forKeyPath: "snippet.description") as! String
                    //videoObj.videoThumbnailURL = Video.value(forKeyPath: "snippet.thumbnails.maxres.url") as! String
                    arrayOfVideos.append(videoObj)
                        }
                        
                    }
                    self.videoArray = arrayOfVideos
                    //Notify the Delegate that the data is ready
                    if self.delegate != nil {
                        self.delegate!.dataReady()
                    }
                    
                }
                
                //}
            }
        }
        
        
        //Alamofire.request(URL_YOUTUBE, parameters:["part":"snippet","playlistId": UPLOADS_PLAYLIST_ID,"key": API_KEY,"channelId":"12312"], encoding: ParameterEncoding.URL, headers: nil)
        
        
    }
    
    
    func getVideos() -> [Video] {
        //Create an empty array of videos objects
        var videos = [Video]()
        
        //Create a video object
        let video1 = Video()
        
        // Assign properties
        video1.videoID = "GW7Dl-fUM10"
        video1.videoTitle = "Estreia da Semana: O Primeiro Homem"
        video1.videoDescription = "Novo filme do diretor Damien Chazelle (Whiplash, La la Land), conta a história do astronauta Neil Armstrong e a missão de viagem à lua em Julho de 1969."
        // Append it into the videos array
        videos.append(video1)
        //Return array to the caller
        
        
        
        
        
        
        
        return videos
    }

}
