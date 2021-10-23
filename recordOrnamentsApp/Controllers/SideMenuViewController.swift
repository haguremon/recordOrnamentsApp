//
//  SideMenuViewController.swift
//  recordOrnamentsApp
//
//  Created by IwasakIYuta on 2021/09/24.
//

import UIKit
protocol SideMenuViewControllerDelegate: AnyObject {
    func didSelectMeunItem(name: SideMenuItem)
}


enum SideMenuItem: String,CaseIterable{
    case useGuide = "使い方ガイド"
    case signOut = "最初の画面に戻る"
    case contact = "問い合わせ"
}


class SideMenuViewController: UIViewController {
    
    @IBOutlet private var tableView: UITableView!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    var authCredentials: AuthCredentials? {
        
        didSet { configure() }
        
        
    }
    
    weak var delegate: SideMenuViewControllerDelegate?
    
    let sideMenuItems: [SideMenuItem] = SideMenuItem.allCases
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        //imageView.layer.cornerRadius = 25
    
    }
    
    private func configure() {
        imageView.image = authCredentials?.profileImage
        usernameLabel.text = authCredentials?.name
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SideMenuViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sideMenuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = sideMenuItems[indexPath.row].rawValue
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //デリゲートを使ってやり取りする
        tableView.deselectRow(at: indexPath, animated: true)
        let selectItem = sideMenuItems[indexPath.row]
        print(selectItem)
        //ここでの通知をViewControllernに伝えてその内容をViewControllerでやる
        delegate?.didSelectMeunItem(name: selectItem)
        
        //performSegue(withIdentifier: "\(selectItem)", sender: nil)
        print("tap")
    }

}
