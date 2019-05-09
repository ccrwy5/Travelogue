//
//  EntryCollectionViewController.swift
//  Travelogue
//
//  Created by Chris Rehagen on 5/7/19.
//  Copyright © 2019 Chris Rehagen. All rights reserved.
//

import UIKit

class EntryCollectionViewController: UIViewController {
   
    @IBOutlet weak var entriesTableView: UITableView!
    
    let dateformatter = DateFormatter()
    
    
    var trip: Trip?
    var entry: Entry?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dateformatter.dateFormat = "MMM dd, yyyy, h:mm a"

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.entriesTableView.reloadData()
    }
   
    @IBAction func addEntry(_ sender: Any) {
        performSegue(withIdentifier: "showEntry", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? NewEntryViewController else{
            return
        }
        destination.trip = trip
        destination.entry = entry
        
    }
    
    func deleteEntry(at indexPath: IndexPath){
        guard let entry = trip?.entries?[indexPath.row],
            let managedContext = entry.managedObjectContext else {
                return
        }
        managedContext.delete(entry)
        
        do{
            try managedContext.save()
            entriesTableView.deleteRows(at: [indexPath], with: .automatic)
        }catch{
            print("Could not delete entry")
            entriesTableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    
}

extension EntryCollectionViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trip?.entries?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = entriesTableView.dequeueReusableCell(withIdentifier: "entryCell", for: indexPath)
       
        if let entry = trip?.entries?[indexPath.row]{
            
            
            let dateString = dateformatter.string(from: entry.date!)
            cell.textLabel?.text = entry.title
            cell.detailTextLabel?.text = dateString
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            deleteEntry(at: indexPath)
        }
    }
}

extension EntryCollectionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        entry = trip?.entries?[indexPath.row]
        performSegue(withIdentifier: "showEntry", sender: self)
        
        entry = nil
        
        
    }
}
