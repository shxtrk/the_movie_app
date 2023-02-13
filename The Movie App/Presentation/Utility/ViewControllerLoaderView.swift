//
//  ViewControllerLoaderView.swift
//  The Movie App
//
//  Created by Serhii Striuk on 13.02.2023.
//

import UIKit

class ViewControllerLoaderView {

    static var activityIndicator: UIActivityIndicatorView?

    static func show() {
        DispatchQueue.main.async {
            NotificationCenter.default.addObserver(self,
                                                   selector: #selector(update),
                                                   name: UIDevice.orientationDidChangeNotification,
                                                   object: nil)
            if activityIndicator == nil,
               let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let window = scene.windows.first {
                
                let frame = UIScreen.main.bounds
                let spinner = UIActivityIndicatorView(frame: frame)
                spinner.backgroundColor = UIColor.black.withAlphaComponent(0.2)
                spinner.style = .large
                window.addSubview(spinner)

                spinner.startAnimating()
                self.activityIndicator = spinner
            }
        }
    }

    static func hide() {
        DispatchQueue.main.async {
            guard let spinner = activityIndicator else { return }
            spinner.stopAnimating()
            spinner.removeFromSuperview()
            self.activityIndicator = nil
        }
    }

    @objc static func update() {
        DispatchQueue.main.async {
            if activityIndicator != nil {
                hide()
                show()
            }
        }
    }
}
