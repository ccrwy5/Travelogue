//
//  TripsCollectionViewController.swift
//  Travelogue
//
//  Created by Chris Rehagen on 5/6/19.
//  Copyright © 2019 Chris Rehagen. All rights reserved.
//

import UIKit
import CoreData

class TripsCollectionViewController: UIViewController {

    @IBOutlet weak var newTripButton: UIBarButtonItem!
    @IBOutlet weak var tripsTableView: UITableView!
    
    var trips: [Trip] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
            else{
                return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Trip> = Trip.fetchRequest()
        
        do{
            trips = try managedContext.fetch(fetchRequest)
            
            tripsTableView.reloadData()
            print("Reached end of fetch")
            
        } catch{
            print("Could not fetch")
        }
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? EntryCollectionViewController,
           let selectedRow = self.tripsTableView.indexPathForSelectedRow?.row else {
                return
        }
        destination.trip = trips[selectedRow]
    }
    
    
    func deleteTrip(at indexPath: IndexPath){
        let trip = trips[indexPath.row]
        
        guard let managedContext = trip.managedObjectContext else{
            return
        }
        managedContext.delete(trip)
        
        do{
            try managedContext.save()
            
            trips.remove(at: indexPath.row)
            tripsTableView.deleteRows(at: [indexPath], with: .automatic)
        }catch{
            print("Could not delete trip")
            tripsTableView.reloadRows(at: [indexPath], with: .automatic)
        }
         
    }

}

    extension TripsCollectionViewController: UITableViewDataSource, UITableViewDelegate {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

            return trips.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tripsTableView.dequeueReusableCell(withIdentifier: "tripCell", for: indexPath)
            
            let trip = trips[indexPath.row]
            cell.textLabel?.text = trip.title

            return cell
        }
        
        func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete{
                deleteTrip(at: indexPath)
            }
        }
    
 
    

}
