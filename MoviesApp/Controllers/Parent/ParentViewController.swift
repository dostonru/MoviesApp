//  ParentViewController.swift
//  MoviesApp
//  Created by Doston Rustamov on 05/03/22.

import UIKit

class ParentViewController: UIViewController, LoadingDelegate {
    
    var loadingIcon: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /** Setup general background color for all uiviewcontrollers
         that will be inhereted from this parent controller */
        view.backgroundColor = .white
        
        /** Setup loading activity indicator to controll donwloading
         data from api proccess*/
        loadingIcon = UIActivityIndicatorView()
        
        self.createInstances()
        self.setupViewComponents()
    
    }
    
    /** Initializing instances of ui elements and
     other components in the scene */
    open func createInstances() { }
    
    /** Setting up some small view components
     such as backgroud color, navigation title , etc. */
    open func setupViewComponents() { }
    
}
