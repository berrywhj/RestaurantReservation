//
//  ReservationHistoryTableTableViewController.swift
//  FinalProject
//
//  Created by Berry on 3/8/24.
//

import UIKit

class ReservationCell: UITableViewCell {
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationNameLabel: UILabel!
    @IBOutlet weak var locationNumberLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
}

class ReservationHistoryTableViewController: UITableViewController {

    var initialTouchPoint: CGPoint = CGPoint.zero
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let reservationCellNib = UINib(nibName: "ReservationCell", bundle: nil)
        tableView.register(reservationCellNib, forCellReuseIdentifier: "ReservationCell")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        let swipeGesture = UIPanGestureRecognizer(target: self, action: #selector(handleSwipeGesture(_:)))
        swipeGesture.minimumNumberOfTouches = 2
        swipeGesture.maximumNumberOfTouches = 2
        view.addGestureRecognizer(swipeGesture)
    }

    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return reservations.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reservation = reservations[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Reservation", for: indexPath) as! ReservationCell
        
        // Configure the cell...
        let location = locations[reservation.locationId]
        cell.cityLabel?.text = location.city
        cell.locationNameLabel?.text = location.name
        cell.locationNumberLabel?.text = location.contact
        
        let combinedDateTimeFormatter = DateFormatter()
        combinedDateTimeFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        combinedDateTimeFormatter.timeZone = TimeZone(abbreviation: "CST")
        cell.timeLabel?.text = combinedDateTimeFormatter.string(from: reservation.time)
        cell.statusLabel?.text = reservation.status.rawValue
        if reservation.status == .Active {
            cell.statusLabel?.textColor = .systemGreen
        } else if reservation.status == .Completed {
            cell.statusLabel?.textColor = .systemGray
        } else if reservation.status == .Cancelled {
            cell.statusLabel?.textColor = .systemRed
        }
        cell.nameLabel?.text = reservation.name
        cell.emailLabel?.text = reservation.email
        cell.numberLabel?.text = reservation.phone
//        cell.restaurantTitleLabel?.text = restaurant.name
//        cell.restaurantPriceLabel?.text = restaurant.price
//        cell.restaurantMealsLabel?.text = restaurant.meals
//        cell.restaurantImageView?.image = UIImage(named: restaurant.type.rawValue)

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180.0;//Choose your custom row height
    }
    
    @objc func handleSwipeGesture(_ gesture: UIPanGestureRecognizer) {
        if gesture.state == .began {
            initialTouchPoint = gesture.location(in: view)
        } else if gesture.state == .changed {
            // Calculate the distance of the pan
            let xDistance = gesture.location(in: view).x - initialTouchPoint.x
            let yDistance = gesture.location(in: view).y - initialTouchPoint.y

            // Check if the pan meets the minimum distance requirement
            if abs(xDistance) > 100 && abs(yDistance) < 100 {
                if xDistance > 0 {
                    // Swiped right
                    tabBarController?.selectedIndex = 2
                } else {
                    // Swiped left
                    tabBarController?.selectedIndex = 4

                }
            }
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let reservationHistoryDetailViewController = segue.destination as? ReservationHistoryDetailViewController {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                reservationHistoryDetailViewController.reservationIdx = indexPath.row
            }
        }
    }
    

}
