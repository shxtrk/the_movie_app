//
//  Observable.swift
//  The Movie App
//
//  Created by Serhii Striuk on 11.02.2023.
//

import Foundation

final class Observable<Value> {
    
    struct Observer<Value> {
        weak var observer: AnyObject?
        let block: (Value) -> Void
    }
    
    private var observers = [Observer<Value>]()
    
    private let queue = DispatchQueue(label: "com.observable.queue")
    
    var value: Value {
        didSet { notifyObservers() }
    }
    
    init(_ value: Value) {
        self.value = value
    }
    
    func observe(on observer: AnyObject, observerBlock: @escaping (Value) -> Void) {
        queue.async {
            self.observers.append(Observer(observer: observer, block: observerBlock))
            DispatchQueue.main.async { observerBlock(self.value) }
        }
    }
    
    func remove(observer: AnyObject) {
        queue.async {
            self.observers = self.observers.filter { $0.observer !== observer }
        }
    }
    
    private func notifyObservers() {
        queue.async {
            for observer in self.observers {
                DispatchQueue.main.async { observer.block(self.value) }
            }
        }
    }
}
