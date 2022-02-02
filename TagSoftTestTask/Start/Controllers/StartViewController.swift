//
//  StartViewController.swift
//  TagSoftTestTask
//
//  Created by Raushan Ruslan kyzy on 20/1/22.
//

import UIKit

class StartViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func startButtonDidPress(_ sender: UIButton) {
        let vc = UIStoryboard.createViewController(storyboard: .characters, controllerType: CharactersTableViewController.self)
        navigationController?.pushViewController(vc, animated: true)
    }
}
