
import UIKit




class MyTimelineController: UITableViewController {


    var model : [AnyObject]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Mis videos blog"
        let plusButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "addNewVideoPost:")
        self.navigationItem.rightBarButtonItem = plusButton
        
        // modelo publicar

        populateModel()
        
        
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
        // #warning Incomplete implementation, return the number of rows
        var rows = 0
        if model != nil {
            rows = (model?.count)!
        }
        return rows
        
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("videos", forIndexPath: indexPath)

        cell.textLabel?.text = model![indexPath.row]["titulo"] as? String
        
        return cell
    }
    // MARK: - Popular el modelo
    
    func populateModel(){
        
        
    }
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.beginUpdates()
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            model!.removeAtIndex(indexPath.row)

            
            tableView.endUpdates()
        }
    }
    

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        performSegueWithIdentifier("detailPost", sender:indexPath)
    }
    
    
    // MARK: - Añadir un nuevo post
    
    func addNewVideoPost(sender : AnyObject){
        performSegueWithIdentifier("addNewItem", sender: sender)
        
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        
        guard let identifier = segue.identifier else{
            print("no tenemos identifier")
            return
        }
        
        switch identifier{
        case "addNewItem":
            let vc = segue.destinationViewController as! ViewPostController
            break
        case "detailPost":
            let index = sender as? NSIndexPath
            let vc = segue.destinationViewController as! DetailPostController
            break
        default: break
            
        }

        
    }
    

}
