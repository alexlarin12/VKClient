//
//  DataTimeHelper.swift
//  VKClient
//
//  Created by Alex Larin on 14.03.2020.
//  Copyright © 2020 Alex Larin. All rights reserved.
//

import Foundation
class DateTimeHelper {
    var dateTextCache: [IndexPath: String] = [:]
    /// Просто форматированная дата
    public static func getDateTimeString(dateTime : Date?, format : String) -> String {
        let dateTime = dateTime ?? Date();
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: dateTime)
    }
    
    /// Хитро-форматированная дата
    func getFormattedDate(indexPath: IndexPath,from dateTime: Date) -> String {
            // если уже есть в кэше возвращаем дату из кэша:
        if let stringDate = self.dateTextCache[indexPath]{
                return stringDate
            // если нет в кэше, возвращаем вычисляемое значение:
            }else{
            let timeFormat = DateFormatter()
            let dateFormat = DateFormatter()
            timeFormat.dateFormat = "HH:mm"
            dateFormat.dateStyle = .full
            dateFormat.locale = Locale.init(identifier: "ru_RU")
            dateFormat.dateFormat = "dd MMM"
            // если сегодня:
            if Calendar.current.isDateInToday(dateTime) {
                let stringDate = "сегодня в \(timeFormat.string(from: dateTime))"
                self.dateTextCache[indexPath] = stringDate
                return stringDate
            // если вчера:
            } else if Calendar.current.isDateInYesterday(dateTime) {
                let stringDate = "вчера в \(timeFormat.string(from: dateTime))"
                self.dateTextCache[indexPath] = stringDate
                return stringDate
            // если в другой день(не сегодня и не вчера)
            } else {
                let stringDate = "\(dateFormat.string(from: dateTime)) в \(timeFormat.string(from: dateTime))"
                self.dateTextCache[indexPath] = stringDate
                return stringDate
            }
            }
    }
}
