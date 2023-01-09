//
//  ExitInfoViewModel.swift
//  Kaohsiung MRT Navi
//
//  Created by Yang Tun-Kai on 2023/1/6.
//

import Foundation

struct ExitInfoViewModel: Hashable {
    let exitNum: Int
    let info: String
    let categories: [TransformationCategory]
    let hasElevator: Bool
    let hasToilet: Bool
    let escalator: [EscalatorCategory]
}
