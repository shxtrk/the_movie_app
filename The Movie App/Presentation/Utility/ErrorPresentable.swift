//
//  ErrorPresentable.swift
//  The Movie App
//
//  Created by Serhii Striuk on 13.02.2023.
//

import UIKit

protocol ErrorPresentable { }

extension ErrorPresentable where Self: UIViewController {
    func present(error: String, completion: (() -> Void)? = nil) {
        guard !error.isEmpty else { return }
        let alert = UIAlertController(title: NSLocalizedString("error", comment: ""),
                                      message: error,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { _ in
            DispatchQueue.main.async {
                completion?()
            }
        })
        self.present(alert, animated: true)
    }
}
