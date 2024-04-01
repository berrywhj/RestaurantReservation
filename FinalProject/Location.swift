//
//  Location.swift
//  FinalProject
//
//  Created by Berry on 2/28/24.
//

import Foundation

let locations = [
    Location(name: "Downtown",
             contact: "(312)-123-0000",
             city: "Chicago",
             latitude: "41.878522248606984",
             longtitude: "-87.6348093137827"
    ),
   
    Location(name: "River North",
             contact: "(312)-123-0001",
             city: "Chicago",
             latitude: "41.896647835985505",
             longtitude: "-87.62555894636593"
    ),
    
    Location(name: "Chinatown",
             contact: "(312)-123-0002",
             city: "Chicago",
             latitude: "41.85331531043463",
             longtitude: "-87.62415433087486"
    ),
    
    Location(name: "South Loop",
             contact: "(312)-123-0003",
             city: "Chicago",
             latitude: "41.86557998358457",
             longtitude: "-87.62438356991876"
    ),
    Location(name: "Navy Pier",
             contact: "(312)-123-0004",
             city: "Chicago",
             latitude: "41.89210697954105",
             longtitude: "-87.60963543614899"
    ),
    Location(name: "West Loop",
             contact: "(312)-123-0005",
             city: "Chicago",
             latitude: "41.87798509617523",
             longtitude: "-87.64819085889901"
    ),
    
]

class Location {
    
    var name: String
    var contact: String
    var city: String
    var latitude: String
    var longtitude: String
    
    init(name: String, contact: String, city: String, latitude: String, longtitude: String) {
        self.name = name
        self.contact = contact
        self.city = city
        self.latitude = latitude
        self.longtitude = longtitude
    }
}
