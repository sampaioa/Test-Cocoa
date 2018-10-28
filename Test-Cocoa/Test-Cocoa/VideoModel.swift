//
//  VideoModel.swift
//  Test-Cocoa
//
//  Created by Andre Sampaio on 18/10/18.
//  Copyright © 2018 Andre Sampaio. All rights reserved.
//

import UIKit
import Alamofire


class VideoModel: NSObject {
    
    func getFeedVideos() {
        
        let API_KEY = "AIzaSyAlo2-408PmIdoH6GqNp1iKhZkR00vO_GM"
        let UPLOADS_PLAYLIST_ID = "PLjEkvB9j5CIlE7gviSRRMCzY_b4S5cNEV"
        let URL_YOUTUBE = "https://www.googleapis.com/youtube/v3/playlistItems"
        
        
        //Fetch the videos dynamically through the YouTube API
        
        Alamofire.request(URL_YOUTUBE, method: .get, parameters: ["part":"snippet","playlistId": UPLOADS_PLAYLIST_ID,"key": API_KEY], encoding: URLEncoding.default, headers: nil).responseJSON { (response) -> Void in
            
            if let JSON = response.result.value as? [String: Any] {
                //let JSON_RESULTS = JSON["entry"] as Any
                
                //if let JSON_VIDEOS = JSON_RESULTS as? NSArray {
                
                for video in JSON["items"] as! [[String: Any]]
                {
                    print(video)
                    
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
        
        //Create a video object
        let video2 = Video()
        
        // Assign properties
        video2.videoID = "GW7Dl-fUM10"
        video2.videoTitle = "Estreia da Semana: O Primeiro Homem"
        video2.videoDescription = "Novo filme do diretor Damien Chazelle (Whiplash, La la Land), conta a história do astronauta Neil Armstrong e a missão de viagem à lua em Julho de 1969."
        // Append it into the videos array
        videos.append(video2)
        //Return array to the caller
        
        //Create a video object
        let video3 = Video()
        
        // Assign properties
        video3.videoID = "GW7Dl-fUM10"
        video3.videoTitle = "Estreia da Semana: O Primeiro Homem"
        video3.videoDescription = "Novo filme do diretor Damien Chazelle (Whiplash, La la Land), conta a história do astronauta Neil Armstrong e a missão de viagem à lua em Julho de 1969."
        // Append it into the videos array
        videos.append(video3)
        //Return array to the caller
        
        //Create a video object
        let video4 = Video()
        
        // Assign properties
        video4.videoID = "GW7Dl-fUM10"
        video4.videoTitle = "Estreia da Semana: O Primeiro Homem"
        video4.videoDescription = "Novo filme do diretor Damien Chazelle (Whiplash, La la Land), conta a história do astronauta Neil Armstrong e a missão de viagem à lua em Julho de 1969."
        // Append it into the videos array
        videos.append(video4)
        //Return array to the caller
        
        
        
        
        
        return videos
    }

}
