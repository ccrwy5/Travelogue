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
    
    var trip: Trip?
    var entry: Entry?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    
}

extension EntryCollectionViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trip?.entries?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = entriesTableView.dequeueReusableCell(withIdentifier: "entryCell", for: indexPath)
       
        if let entry = trip?.entries?[indexPath.row]{
            cell.textLabel?.text = entry.title
        }
        
        return cell
    }
}

extension EntryCollectionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        entry = trip?.entries?[indexPath.row]
        performSegue(withIdentifier: "showEntry", sender: self)
        
        entry = nil
        
        
    }
}
