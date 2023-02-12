//
//  RepositoryTask.swift
//  The Movie App
//
//  Created by Serhii Striuk on 12.02.2023.
//

import Foundation

class RepositoryTask: Cancellable {
    var remoteTask: Cancellable?
    var isCancelled: Bool = false
    
    func cancel() {
        remoteTask?.cancel()
        isCancelled = true
    }
}
