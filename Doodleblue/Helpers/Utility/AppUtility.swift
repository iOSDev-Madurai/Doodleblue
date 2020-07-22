//
//  AppUtility.swift
//  Doodleblue
//
//  Created by Jegadeeswaran on 21/07/20.
//  Copyright © 2020 Jegadeeswaran. All rights reserved.
//

import UIKit

class AppUtility {

    public static let shared = AppUtility()

    // MARK:- File System

    func getJSONValueFrom(File fileName: String) -> (jsonData: Data, json: [String: Any])? {

        guard
            let bundlePath = Bundle.main.path(forResource: fileName, ofType: Constants.json)
            else {
                return nil
        }
        let bundleURL = URL(fileURLWithPath: bundlePath)
        if FileManager.default.fileExists(atPath: bundleURL.path) {

            do {
                let jsonData = try Data(contentsOf: bundleURL)
                let json = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers)
                if let jsonDic = json as? [String: Any] {
                    return (jsonData, jsonDic)
                }
            } catch {
                debugPrint(error.localizedDescription)
            }
        }
        return nil
    }

}
