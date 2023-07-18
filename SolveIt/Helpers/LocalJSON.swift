//
//  LocalJSON.swift
//  SolveIt
//
//  Created by Daniel Feler on 3/29/23.
//

import Foundation

func loadJSONData<T: Decodable>(from filename: String) -> T? {
    guard let fileURL = Bundle.main.url(forResource: filename, withExtension: "json") else {
        print("JSON file '\(filename)' not found")
        return nil
    }

    do {
        let data = try Data(contentsOf: fileURL)
        let decoder = JSONDecoder()
        let decodedData = try decoder.decode(T.self, from: data)
        return decodedData
    } catch {
        print("Error decoding JSON: \(error)")
        return nil
    }
}

