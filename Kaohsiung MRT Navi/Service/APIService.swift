//
//  APIService.swift
//  Kaohsiung MRT Navi
//
//  Created by Yang Tun-Kai on 2022/12/28.
//

import Foundation

class APIService{
    
    //url of kmrt web site
    static let MRTMapURL: String = (Bundle.main.object(forInfoDictionaryKey: "API Service") as! Dictionary<String, String>)["MRTMapURL"]!
}
