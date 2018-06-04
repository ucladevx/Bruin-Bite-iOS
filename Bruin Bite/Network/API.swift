//
//  API.swift
//  Dont Eat Alone
//
//  Created by Samuel J. Lee on 5/20/18.
//  Copyright © 2018 Dont Eat Alone. All rights reserved.
//

import Foundation
import Moya

class API{
    static let provider = MoyaProvider<MainAPI>()
    public var matchDelegate: MatchDelegate? = nil // Desperate times, call for desperate measures - Hirday & Sam - 06/03, 10:45 PM
}
