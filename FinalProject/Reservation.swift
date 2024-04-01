//
//  Reservation.swift
//  FinalProject
//
//  Created by Berry on 3/4/24.
//

import Foundation

var reservations = [
    Reservation(name: "Alice",
                email: "alice@gmail.com",
                phone: "(312)-123-1234",
                party: 4,
                time: Date.now.addingTimeInterval(86400),
                locationId: 0,
                status: Reservation.Status.Cancelled),
    Reservation(name: "Bob",
                email: "bob@gmail.com",
                phone: "(312)-123-1235",
                party: 2,
                time: Date.now.addingTimeInterval(86400 * 3),
                locationId: 1,
                status: Reservation.Status.Active),
    Reservation(name: "Calob",
                email: "calob@gmail.com",
                phone: "(312)-123-1236",
                party: 3,
                time: Date.now.addingTimeInterval(-86400),
                locationId: 2,
                status: Reservation.Status.Completed),
    Reservation(name: "Daniel",
                email: "Daniel@gmail.com",
                phone: "(312)-123-1237",
                party: 3,
                time: Date.now.addingTimeInterval(-86400 * 2),
                locationId: 2,
                status: Reservation.Status.Cancelled),
               
]

class Reservation {
    var name: String
    var email: String
    var phone: String
    var party: Int
    var time: Date
    var locationId: Int
    var status: Status
    
    enum Status: String {
        case Active = "Active"
        case Cancelled = "Cancelled"
        case Completed = "Completed"
    }
    
    init(name: String, email: String, phone: String, party: Int, time: Date, locationId: Int, status: Status) {
        self.name = name
        self.email = email
        self.phone = phone
        self.party = party
        self.time = time
        self.locationId = locationId
        self.status = status
    }
}
