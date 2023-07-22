//
//  Observable.swift
//  Players
//
//  Created by Jameel Shehadeh on 22/07/2023.
//

import Foundation

class Observable<T> {
    
    var value : T? {
        didSet {
            listener?(value)
        }
    }
    
    private var listener: ((T?) -> Void)?
    
    init(value: T?){
        self.value = value
    }
    
    func bind(_ listener: @escaping ((T?)->())){
        listener(value)
        self.listener = listener
    }
    
}


