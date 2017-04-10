//
//  ViewController.swift
//  RPComment
//
//  Created by Nehemiah Horace on 4/5/17.
//  Copyright © 2017 Nehemiah Horace. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //Outlets
    @IBOutlet weak var commentTableView: UITableView!
    @IBOutlet weak var commentTextView: UITextView!
    
    //Variable Declaration
    var rpCommentsArray = [cls_RPComment]()
    let operationsObj = cls_Operations()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        getCommentsFromDatabase()
    }

   // MARK: Get Comments
    
    func getCommentsFromDatabase() {
        FIRDatabase.database().reference().observe(FIRDataEventType.value, with: {
            (snapshot) in
            
            self.rpCommentsArray = []
            
            if let snapshotsArray = snapshot.children.allObjects as? [FIRDataSnapshot] {
                
                for snapObj in snapshotsArray {
                    
                    if let commentDictionary = snapObj.value as? Dictionary<String, AnyObject> {
                        
                        let key = snapObj.key
                        let comment = cls_RPComment(key: key, commentDic: commentDictionary)
                        self.rpCommentsArray.insert(comment, at: 0)
                    }
                }
            }
            self.commentTableView.reloadData()
        })
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: TableView Methods
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let commentCell = tableView.dequeueReusableCell(withIdentifier: "CommentCellIdentifier", for: indexPath) as! CommentTableViewCell
        let comment = rpCommentsArray[indexPath.row]
        
        commentCell.configureCommentCell(comment)
        return commentCell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rpCommentsArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
    @IBAction func PostCommentButton_Clicked(_ sender: Any) {
        
        operationsObj.storeCommentToDatabase(commentTextView)

    }

}

