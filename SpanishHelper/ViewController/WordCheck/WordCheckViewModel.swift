//
//  WordCheckViewModel.swift
//  SpanishHelper
//
//  Created by Ruslan Khamskyi on 20.01.2020.
//  Copyright © 2020 Ruslan Khamskyi. All rights reserved.
//

import Foundation

final class WordCheckViewModel {
    
    var dataBaseManager: DataBaseManager
    var data: [Word]
    
    // MARK: - Init
    init(dataBaseManager: DataBaseManager) {
        self.dataBaseManager = dataBaseManager
        data = dataBaseManager.getAllGroups().flatMap({ $0.words })
    }
}
