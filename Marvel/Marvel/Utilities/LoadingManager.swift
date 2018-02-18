//
//  LoadingManager.swift
//  Marvel
//
//  Created by thales.garcia on 17/02/18.
//  Copyright © 2018 thales.garcia. All rights reserved.
//

import UIKit

var alert: UIAlertController?

extension UIViewController {
    
    func showLoading() {
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        loadingIndicator.startAnimating();
        alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        
        if let loadingView = alert {
            loadingView.view.addSubview(loadingIndicator)
            present(loadingView, animated: true, completion: nil)
        }
        
    }

    func hideLoading() {
        alert?.dismiss(animated: false, completion: {
            alert = nil
        })
    }
}
