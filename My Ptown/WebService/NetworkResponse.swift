//
//  NetworkResponse.swift
//  My Ptown
//
//  Created by Burak Donat on 5.10.2020.
//  Copyright © 2020 Burak Donat. All rights reserved.
//

import Foundation

enum NetworkResponse<T, U: Error> {
    case success(T)
    case failure(U)
}
