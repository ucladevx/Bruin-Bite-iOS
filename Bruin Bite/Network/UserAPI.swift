//
//  UserAPI.swift
//  Dont Eat Alone
//
//  Created by Samuel J. Lee on 5/8/18.
//  Copyright © 2018 Dont Eat Alone. All rights reserved.
//

import Foundation
import SwiftyJSON
import Result

protocol MatchDelegate {
    func didReceiveMatch(withID id: Int)
}
