//
//  Constants.swift
//  TinkoffNews
//
//  Created by jufina on 23.07.17.
//  Copyright © 2017 jufina. All rights reserved.
//

import Foundation

struct Constants {
    static let dateFormate = "hh:mm dd.MM.YYYY"
    static let milisecondsPerSecond: TimeInterval = 1000
    
    struct API {
        static let baseUrlPath = "https://api.tinkoff.ru/v1/"
        static let listPostsPath = "news"
        static let postDetailsPath = "news_content?id=%@"
    }
    
    struct Strings {
        static let emptyDetails = "Не удалось получить данные, попробуйте снова"
        static let emptyList = "Список пуст, произошла ошибка при загрузке данных"
    }
}
