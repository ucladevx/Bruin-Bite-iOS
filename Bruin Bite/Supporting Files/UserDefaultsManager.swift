//
//  UserDefaultsManager.swift
//  Bruin Bite
//
//  Created by Samuel J. Lee on 11/27/18.
//  Copyright © 2018 Dont Eat Alone. All rights reserved.
//

import Foundation

class UserDefaultsManager {
    static let shared: UserDefaultsManager = UserDefaultsManager()
    private var email_KEY = "Email"
    private var id_KEY = "U_ID"
    private var accessToken_KEY = "Access_Token"
    private var refreshToken_KEY = "Refresh_Token"
    private var firstName_KEY = "First_Name"
    private var lastName_KEY = "Last_Name"
    private var major_KEY = "Major"
    private var minor_KEY = "Minor"
    private var year_KEY = "Year"
    private var selfBio_KEY = "Self_Bio"
    private var password_KEY = "Password"

    //Setters
    func setUserEmail(to email: String) { UserDefaults.standard.set(email, forKey: email_KEY) }
    func setUserID(to id: Int) { UserDefaults.standard.set(id, forKey: id_KEY) }
    func setAccessToken(to accessToken: String) { UserDefaults.standard.set(accessToken, forKey: accessToken_KEY) }
    func setRefreshToken(to refreshToken: String) { UserDefaults.standard.set(refreshToken, forKey: refreshToken_KEY) }
    func setFirstName(to firstName: String) { UserDefaults.standard.set(firstName, forKey: firstName_KEY) }
    func setLastName(to lastName: String) { UserDefaults.standard.set(lastName, forKey: lastName_KEY) }
    func setMajor(to major: String) { UserDefaults.standard.set(major, forKey: major_KEY) }
    func setMinor(to minor: String) { UserDefaults.standard.set(minor, forKey: minor_KEY) }
    func setYear(to year: Int) { UserDefaults.standard.set(year, forKey: year_KEY) }
    func setSelfBio(to selfBio: String) { UserDefaults.standard.set(selfBio, forKey: selfBio_KEY) }
    func setPassword(to password: String) { UserDefaults.standard.set(password, forKey: password_KEY) }

    //Access
    func getUserID() -> Int { return UserDefaults.standard.object(forKey: id_KEY) as? Int ?? -1 }
    func getUserEmail() -> String { return UserDefaults.standard.object(forKey: email_KEY) as? String ?? "" }
    func getAccessToken() -> String { return UserDefaults.standard.object(forKey: accessToken_KEY) as? String ?? "" }
    func getRefreshToken() -> String { return UserDefaults.standard.object(forKey: refreshToken_KEY) as? String ?? "" }
    func getFirstName() -> String { return UserDefaults.standard.object(forKey: firstName_KEY) as? String ?? "" }
    func getLastName() -> String { return UserDefaults.standard.object(forKey: lastName_KEY) as? String ?? "" }
    func getMajor() -> String { return UserDefaults.standard.object(forKey: major_KEY) as? String ?? "" }
    func getMinor() -> String { return UserDefaults.standard.object(forKey: minor_KEY) as? String ?? "" }
    func getMajor() -> Int { return UserDefaults.standard.object(forKey: year_KEY) as? Int ?? 0 }
    func getSelfBio() -> String { return UserDefaults.standard.object(forKey: selfBio_KEY) as? String ?? "" }
    func getYear() -> Int { return UserDefaults.standard.object(forKey: year_KEY) as? Int ?? 0}
    func getPassword() -> String { return UserDefaults.standard.object(forKey: password_KEY) as? String ?? ""}

    //Remove
    func removeEmail() { UserDefaults.standard.removeObject(forKey: email_KEY) }
    func removeID() { UserDefaults.standard.removeObject(forKey: id_KEY) }
    func removeAccessToken() { UserDefaults.standard.removeObject(forKey: accessToken_KEY) }
    func removeRefreshToken() { UserDefaults.standard.removeObject(forKey: refreshToken_KEY) }
    func removeFirstName() { UserDefaults.standard.removeObject(forKey: firstName_KEY) }
    func removeLastName() { UserDefaults.standard.removeObject(forKey: lastName_KEY) }
    func removeMajor() { UserDefaults.standard.removeObject(forKey: major_KEY) }
    func removeMinor() { UserDefaults.standard.removeObject(forKey: minor_KEY) }
    func removeYear() { UserDefaults.standard.removeObject(forKey: year_KEY) }
    func removeBio() { UserDefaults.standard.removeObject(forKey: selfBio_KEY) }
    func removePassword() { UserDefaults.standard.removeObject(forKey: password_KEY) }
    func removeAll() {
        removeEmail();removeID();removeAccessToken();removeRefreshToken();removeFirstName()
        removeLastName();removeMajor();removeMinor();removeYear();removeBio();removePassword()
    }
}
