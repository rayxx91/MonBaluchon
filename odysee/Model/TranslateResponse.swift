//
//  TranslateResponse.swift
//  odysee
//
//  Created by chaleroux on 07/12/2021.
//

import Foundation

struct Translation: Decodable {
    let data: Data
}

struct Data : Decodable {
    let translations: [Translations]
}

struct Translations: Decodable {
    let translatedText: String
}
