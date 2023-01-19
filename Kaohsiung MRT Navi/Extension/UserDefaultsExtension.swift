//
//  UserdefaultExtension.swift
//  Kaohsiung MRT Navi
//
//  Created by Yang Tun-Kai on 2023/1/17.
//

import Foundation

extension UserDefaults {
    
    var token: String? {
        return getData(of: "token") as? String
    }
    
    var tokenTime: Double? {
        return getData(of: "tokenTime") as? Double
    }
    
    func save(data: Any?, key: String) {
        UserDefaults(suiteName: "group.navi.kmrt")?.setValue(data, forKey: key)
    }
    
    private func getData(of key: String) -> Any? {
        return UserDefaults(suiteName: "group.navi.kmrt")?.value(forKey: key)
    }
}
