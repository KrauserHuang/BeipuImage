//
//  MemberCenterTableViewController.swift
//  Beipu
//
//  Created by 陳Mike on 2022/7/1.
//

import UIKit
protocol MemberCenterTableViewControllerDelegate: AnyObject {
    func memberInfoAction(_ controller: MemberCenterTableViewController)
    func themeSetAction(_ controller: MemberCenterTableViewController)
    func couponAction(_ controller: MemberCenterTableViewController)
    func recordAction(_ controller: MemberCenterTableViewController)
    func userRuleAction(_ controller: MemberCenterTableViewController)
    func qnaAction(_ controller: MemberCenterTableViewController)
    func logoutAction(_ controller: MemberCenterTableViewController)
}

class MemberCenterTableViewController: UITableViewController {
    @IBOutlet weak var headImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    @IBAction func headAction(_ sender: Any) {}
    @IBAction func logoutAction(_ sender: Any) {
        UserService.shared.logout()
        delegate?.logoutAction(self)
    }
    
    var delegate: MemberCenterTableViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        setMemberView()
    }
    
    func setMemberView(){
        let user = UserService.shared.user
        nameLabel.text = user?.member_name
        phoneLabel.text = user?.member_id
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.cellForRow(at: indexPath)
        switch cell?.tag {
        case 1:
            delegate?.memberInfoAction(self)
        case 2:
            delegate?.themeSetAction(self)
        case 3:
            delegate?.couponAction(self)
        case 4:
            delegate?.recordAction(self)
        case 5:
            delegate?.userRuleAction(self)
        case 6:
            delegate?.qnaAction(self)
        default:
            break
        }
        
        
    }

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
