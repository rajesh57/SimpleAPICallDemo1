//
//  ViewController.swift
//  SimpleAPICallDemo
//
//  Copyright © 2017 Rajesh. All rights reserved.
//

import UIKit

// Model class
class imageList {
    
    // Property declration 
    var name: String = ""
    var imageUrl: String = ""
    var imageData : UIImage? = nil
    
    // Init Method Assigning
    init(name: String, imageUrl: String) {
        self.name = name;
        self.imageUrl = imageUrl;
        
    }
    
    func downloadImage(_ completion: @escaping (_ photo: imageList) -> ()) {
        
    }
    // Download image from url and converted in to uiimange
    func downloadImageFromServer(_ completionHandler: @escaping (_ image: imageList) -> ()) {
        let url = URL(string: imageUrl)
        let request = URLRequest(url: url!)
        NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main) { (response, data, error) -> Void in
            if let data = data {
                self.imageData = UIImage(data: data)
                completionHandler(self)
            }
        }
    }
}
class ViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var tableViewList: UITableView!
    
    var imageListObj: [imageList]?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.refresh()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    func refresh() {
        let resource = "https://static.ashfurrow.com/course/dinges.json"
        let url = URL(string: resource)
        let request = URLRequest(url: url!)
        NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main) { (response, data, error) -> Void in
            if let data = data {
                let json: AnyObject! = try? JSONSerialization.jsonObject(with: data, options: []) as AnyObject!
                let photosRespone: AnyObject! = (json as! [String: AnyObject])["photos"]
                
                self.imageListObj = (photosRespone as? [[String: String]])?.map({ (photoDictionary: [String: String]) -> imageList in
                    return imageList(name: photoDictionary["name"]!, imageUrl: photoDictionary["url"]!)
                })
            } else {
                print("Something went wrong: \(error)")
            }
            self.tableViewList.reloadData()
        }
    }
    
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let photos = imageListObj {
            return photos.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tbleViewCell", for: indexPath) as! TableViewCellClass
        
       if let photoObj = imageListObj {
         let photolist  = photoObj[indexPath.row]
        cell.lblName?.text = photolist.name
        if let imageData1 = photolist.imageData {
            cell.imageViewLogo?.image = imageData1;
        } else {
            photolist.downloadImageFromServer({ (photolist) -> () in
                tableView.reloadRows(at: [indexPath], with: .automatic)
            })
        }
        return cell

       } else {
        return UITableViewCell()

        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

