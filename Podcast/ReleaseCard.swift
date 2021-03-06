//
//  ReleaseCard.swift
//  Podcast
//
//  Created by Natasha Armbrust on 2/22/17.
//  Copyright © 2017 Cornell App Development. All rights reserved.
//

import UIKit
import SwiftyJSON

//when a series releases an episode 
class ReleaseCard: EpisodeCard {
    
    var seriesImageURL: URL?
    
    //init with all atributes
    init(episodeID: String, episodeTitle: String, dateCreated: Date, descriptionText: String, smallArtworkImageURL: URL?, episodeLength: String, audioURL: URL?, numberOfRecommendations: Int, tags: [Tag], seriesTitle: String, seriesID: String, isBookmarked: Bool, isRecommended: Bool, seriesImageURL: URL?, updatedAt: Date) {
    
        self.seriesImageURL = seriesImageURL
        super.init(episodeID: episodeID, episodeTitle: episodeTitle, dateCreated: dateCreated, descriptionText: descriptionText, smallArtworkImageURL: smallArtworkImageURL, episodeLength: episodeLength, audioURL: audioURL, numberOfRecommendations: numberOfRecommendations, tags: tags, seriesTitle: seriesTitle, seriesID: seriesID, isBookmarked: isBookmarked, isRecommended: isRecommended, updatedAt: updatedAt)
    }
    

    override init(json: JSON) {
        self.seriesImageURL =  URL(string: json["image_url"].stringValue)
        super.init(json: json)
    }
}
