//
//  ReservationTableViewController.swift
//  FinalProject
//
//  Created by Berry on 2/28/24.
//

import UIKit

class ReservationTableViewController: UITableViewController {
    
    var locationIdx: Int?
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var partyStepper: UIStepper!
    
    @IBOutlet weak var partyNum: UILabel!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var timePicker: UIDatePicker!
    
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var submitBtn: UIButton!
    
    var initialTouchPoint: CGPoint = CGPoint.zero
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        let swipeGesture = UIPanGestureRecognizer(target: self, action: #selector(handleSwipeGesture(_:)))
        swipeGesture.minimumNumberOfTouches = 2
        swipeGesture.maximumNumberOfTouches = 2
        view.addGestureRecognizer(swipeGesture)
        
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let locationIndex = locationIdx {
            let location = locations[locationIndex]
            titleLabel.text = location.city
            subtitleLabel.text = "\(location.name)  \(location.contact)"
        }
    }
    
    @IBAction func stepperTapped(_ sender: Any) {
        partyNum.text  = String(Int(partyStepper.value))
    }
    @IBAction func handleDateChange(_ sender: UIDatePicker) {
        print(sender.date)
        print(type(of: sender.date))
    }
    
    @IBAction func handleTimeChange(_ sender: UIDatePicker) {
        print(sender.date)
        print(type(of: sender.date))
    }
    
    @IBAction func handleSubmitTapped(_ sender: Any) {
        
        let date = combineDateAndTime()
        
        let reservation = Reservation(name: nameField.text!, email: emailField.text!, phone: phoneField.text!, party: Int(partyStepper.value), time: date, locationId: locationIdx!, status: Reservation.Status.Active)
        reservations.insert(reservation, at: 0)
        
        let alertController =
            UIAlertController(title: "Success",
                              message: "Reservation created!",
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
    
    @IBAction func fillForm(_ sender: Any) {
        let alertController =
            UIAlertController(title: "Caution",
                              message: "Do you want to fill the form with your pre-filled info?",
                              preferredStyle: .actionSheet)
                          
        let okAction =
            UIAlertAction(title: "Confirm",
                          style: .default,
                          handler: fillFormWithUserInfo)
        let cancelAction =
            UIAlertAction(title: "Cancel",
                          style: .cancel,
                          handler: nil)
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        present(alertController,
                animated: true,
                completion: nil)
        
    }
    
    func fillFormWithUserInfo(_ action: UIAlertAction) -> Void {
        nameField.text = userInstance.name
        phoneField.text = userInstance.phone
        emailField.text = userInstance.email
    }
    
    
    func popViewController(_ action: UIAlertAction) -> Void {
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
    }
    
    func combineDateAndTime() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm:ss"
        
        // Get date and time from pickers
        let date = dateFormatter.string(from: datePicker.date)
        let time = timeFormatter.string(from: timePicker.date)
        // Combine date and time
        let combinedDateTimeString = "\(date) \(time)"
        
        let combinedDateTimeFormatter = DateFormatter()
        combinedDateTimeFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        combinedDateTimeFormatter.timeZone = TimeZone(abbreviation: "CST")
        // Convert combined date and time string to Date object
        if let combinedDateTime = combinedDateTimeFormatter.date(from: combinedDateTimeString) {
            return combinedDateTime
        } else {
            print("Error: Unable to combine date and time")
            return Date.now
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
                    // Implement navigation back action here
                    navigationController?.popViewController(animated: true)
                } else {
                    // Swiped left
                    // If you want to handle swipe left gesture
                }
            }
        }
    }
    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

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
