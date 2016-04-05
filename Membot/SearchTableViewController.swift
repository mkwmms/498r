//
//  SearchTableViewController.swift
//  Membot
//
//  Created by Alex Andrews on 3/29/16.
//  Copyright © 2016 Sneakywolf. All rights reserved.
//

import UIKit
import CocoaLumberjackSwift

class SearchTableViewController: UITableViewController {

    var searchActive = false

    let reuseIdentifier = "SearchCell"
    var backgroundImage = UIImageView(image: UIImage(named: "peaches"))
    let searchController = UISearchController(searchResultsController: nil)

    var filteredMemorables = [Memorable]()

    override func viewDidLoad() {
        super.viewDidLoad()

//        self.tableView.backgroundColor = UIColor(white: 1, alpha: 0.5)
        self.tableView.backgroundColor = UIColor.clearColor()

        // Setup the Search Controller
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.definesPresentationContext = true
        searchController.dimsBackgroundDuringPresentation = false
//        searchController.active = true

        tableView.dataSource = self
//        self.tableView.tableHeaderView = searchController.searchBar
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
//        self.tableView.backgroundView = backgroundImage
    }

    func displayViewController(sender: UIBarButtonItem!) {
        DDLogDebug("searching")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(searchController.active)
        if searchController.active && searchController.searchBar.text != "" {
            DDLogVerbose("SEARCH! " + String(filteredMemorables.count))
            return filteredMemorables.count
        }
        DDLogVerbose("CACHE.... " + String(filteredMemorables.count))
        return MemorableMetadataCache.sharedInstance.allMemorables.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath)

        // Configure the cell...
        cell.backgroundColor = UIColor.clearColor()
//        cell.backgroundColor = UIColor(white: 1, alpha: 0.5)
        var mem: Memorable
        if searchController.active && searchController.searchBar.text != "" {
            print("WAHOOOOOOO!!!!!!!!!")
            mem = filteredMemorables[indexPath.row]
        } else {
            print(":(")
            mem = MemorableMetadataCache.sharedInstance.allMemorables[indexPath.row]
        }
        cell.textLabel!.text = mem.uniqueId
//        cell.detailTextLabel!.text = mem.category
        return cell
    }

    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        print("peas")
    }

    private func filterContentForSearchText(query: String) {
        DDLogVerbose(query)
        // func filterContentForSearchText(query: String, scope: String = "All") {
        filteredMemorables = MemorableMetadataCache.sharedInstance.allMemorables.filter({ (mem: Memorable) -> Bool in
            DDLogVerbose(mem.uniqueId)
            // let categoryMatch = (scope == "All") || (candy.category == scope)
            // return categoryMatch && candy.name.lowercaseString.containsString(searchText.lowercaseString)
            let query = query.lowercaseString
            return mem.creationDate.monthDescription().lowercaseString.containsString(query) ||
            mem.creationDate.dayDescription().lowercaseString.containsString(query) || mem.uniqueId != ""
        })
        self.tableView.reloadData()
    }

    /*
     // Override to support conditional editing of the table view.
     override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */

    /*
     // Override to support editing the table view.
     override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
     if editingStyle == .Delete {
     // Delete the row from the data source
     tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
     } else if editingStyle == .Insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */

    /*
     // Override to support rearranging the table view.
     override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

     }
     */

    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */

    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
}

// MARK: - UISearchBar Delegate
extension SearchTableViewController: UISearchBarDelegate {
    
    func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        // filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
        DDLogVerbose(searchBar.text!)
        filterContentForSearchText(searchBar.text!)
    }

    // called when text changes (including clear)
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        print("***********************************************")
        DDLogVerbose(searchBar.text!)
        filterContentForSearchText(searchBar.text!)
    }

    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
//        print("***********************************************")
        searchActive = true
    }

    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchActive = false
    }
}

// MARK: - UISearchResultsUpdating Delegate
extension SearchTableViewController: UISearchResultsUpdating {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        DDLogVerbose(searchController.description)
        // DDLogVerbose(searchController.searchBar.text!)
        // let searchBar = searchController.searchBar
        // let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        // filterContentForSearchText(searchController.searchBar.text!, scope: scope)
        filterContentForSearchText(searchController.searchBar.text!)
    }
}
