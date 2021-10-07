//
//  CoodinatorNavigationController.swift
//  InterChallenge
//
//  Created by Wilton Ramos on 07/10/21.
//

import UIKit

class CoordinatorNavigationController: UINavigationController {
    let challengeTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func loadView() {
        super.loadView()
        self.setupTableView()
    }
    
    func setupTableView() {
        view.addSubview(challengeTableView)
        challengeTableView.translatesAutoresizingMaskIntoConstraints = false
        challengeTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        challengeTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        challengeTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        challengeTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
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
