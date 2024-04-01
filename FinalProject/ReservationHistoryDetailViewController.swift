//
//  ReservationHistoryDetailViewController.swift
//  FinalProject
//
//  Created by Berry on 3/9/24.
//

import UIKit

class ReservationHistoryDetailViewController: UITableViewController {

    var reservationIdx: Int = 0
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var partyNum: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var cancelButton: UIButton!
    
    var initialTouchPoint: CGPoint = CGPoint.zero
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        let swipeGesture = UIPanGestureRecognizer(target: self, action: #selector(handleSwipeGesture(_:)))
        swipeGesture.minimumNumberOfTouches = 2
        swipeGesture.maximumNumberOfTouches = 2
        view.addGestureRecognizer(swipeGesture)
    }

    // MARK: - Table view data source
    
    override func viewWillAppear(_ animated: Bool) {
        let reservation = reservations[reservationIdx]
        let location = locations[reservation.locationId]
        titleLabel.text = location.city
        subtitleLabel.text = "\(location.name)  \(location.contact)"
        
        nameField.text = reservation.name
        partyNum.text = String(reservation.party)
        phoneField.text = reservation.phone
        emailField.text = reservation.email
        
        
        statusLabel.text = reservation.status.rawValue
        if reservation.status == .Active {
            statusLabel.textColor = .systemGreen
            cancelButton.isEnabled = true
        } else if reservation.status == .Completed {
            statusLabel.textColor = .gray
            cancelButton.isEnabled = false
        } else if reservation.status == .Cancelled {
            statusLabel.textColor = .red
            cancelButton.isEnabled = false
        }
        
        let combinedDateTimeFormatter = DateFormatter()
        combinedDateTimeFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        combinedDateTimeFormatter.timeZone = TimeZone(abbreviation: "CST")
        timeLabel?.text = combinedDateTimeFormatter.string(from: reservation.time)
    }

    @IBAction func cancelTapped(_ sender: Any) {
        reservations[reservationIdx].status = .Cancelled
        let alertController =
            UIAlertController(title: "Success",
                              message: "Reservation successfully cancelled!",
                              preferredStyle: .alert)
                          
        let okAction =
            UIAlertAction(title: "Ok",
                          style: .cancel,
                          handler: popViewController)
        alertController.addAction(okAction)
        present(alertController,
                animated: true,
                completion: nil)
    }
    
    func popViewController(_ action: UIAlertAction) -> Void {
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
    }
    
    func popViewController() {
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
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
                    popViewController()
                } else {
                    // Swiped left

                }
            }
        }
    }
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
