//
//  Observable.swift
//  MovieApp
//
//  Created by APPLE on 08/09/21.
//

import Foundation

final class Observable<T> {
    var listener: ((T) -> Void)?

    var value: T {
        didSet {listener?(value) }
    }

    init(_ value: T) {
        self.value = value
    }

    func bind(listener: ((T) -> Void)?) {
        self.listener = listener
        listener?(value)
    }
}
