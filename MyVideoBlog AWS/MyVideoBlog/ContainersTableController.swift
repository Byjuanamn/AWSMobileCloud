

import UIKit

class ContainersTableController: UITableViewController {

   
    var model : [AnyObject]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        populateModel()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Azure Storage Containers Model
    func populateModel(){
        
        
    }
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        var rows = 0
        
        if let model = model {
            rows = model.count
        }

        return rows
    }

  
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCellWithIdentifier("celdaContainer", forIndexPath: indexPath)

        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("containerDetail", sender: indexPath)
    }

   
  
   
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == "containerDetail"){
            let vc = segue.destinationViewController as? DetailContainerTableController
            
        }
    }
   

}









