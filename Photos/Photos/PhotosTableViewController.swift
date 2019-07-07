//
//  PhotosTableViewController.swift
//  Photos
//
//  Created by 刘洋 on 7/6/19.
//  Copyright © 2019 Yang Liu. All rights reserved.
//

import UIKit
import CoreData

class PhotosTableViewController: UITableViewController {
    var images = [ImageDetails]()
 
    
    @IBOutlet var photosTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true

    }

    override func viewWillAppear(_ animated: Bool) {
        fetchPhotos()
        photosTableView.reloadData()
 
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return images.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        let image = images[indexPath.row]
        cell.textLabel?.text = image.title

        return cell
    }
    
    func fetchPhotos() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            images = [ImageDetails]()
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<ImageDetails> = ImageDetails.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        do {
            images = try managedContext.fetch(fetchRequest)
        } catch {
            tixing(message: "Fetch for photos failed.")
        }
    }
    
    func tixing(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel) {
            (alertAction) -> Void in
            print("selected")
        })
        
        self.present(alert, animated: true, completion: nil)
    }


}
