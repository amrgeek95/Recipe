//
//  Observable.swift
//  Reciepe
//
//  Created by Mac on 14/11/2022.
//

import Foundation

class Box<T> {
    
    var value:T? {
        didSet {
            self.listener?(self.value)
        }
    }
    init(_ value : T? ) {
        self.value = value
    }
    private var listener: ((T?) -> Void)?

    func bind(_ listener: @escaping (T?) -> Void) {
        listener(value)
        self.listener = listener
    }
}
