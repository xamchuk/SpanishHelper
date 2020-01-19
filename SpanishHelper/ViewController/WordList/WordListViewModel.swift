//
//  WordListViewModel.swift
//  SpanishHelper
//
//  Created by Ruslan Khamskyi on 18.01.2020.
//  Copyright © 2020 Ruslan Khamskyi. All rights reserved.
//

import Foundation

final class WordListViewModel {
    
    // MARK: - Public Properties
    var data: [Group]
    
    var didDeleteGroup: ((Int) -> Void)?
    var didAddNewGroup: ((Int) -> Void)?
    var didAddNewWord: ((IndexPath) -> Void)?
    
    // MARK: - Private Properties
    private var dataBaseManager: DataBaseManager
    
    // MARK: - Init
    init(dataBaseManager: DataBaseManager) {
        self.dataBaseManager = dataBaseManager
        data = dataBaseManager.getAllGroups()
    }
    
    // MARK: - Public Methods
    func addNewWord(word: String, translation: String, at index: Int) {
        let item = Word()
        item.id = UUID().uuidString
        item.title = word
        item.translation = translation
        dataBaseManager.addNewWordToGroup(word: item, group: self.data[index])
        didAddNewWord?(IndexPath(item: data[index].words.count - 1, section: index))
    }
    
    func addNewGroup(title: String) {
        let newGroup = Group()
        newGroup.title = title
        dataBaseManager.addGroup(group: newGroup)
        self.data.append(newGroup)
        didAddNewGroup?(data.count - 1)
    }
    
    func deleteGroup(at index: Int) {
        dataBaseManager.delete(group: data[index])
        data.remove(at: index)
        didDeleteGroup?(index)
    }
    
    func deleteWord(word: Word) {
        
    }
}
