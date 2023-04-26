//
//  Data+Extension.swift
//  Marie
//
//  Created by Gabriel Olbrisch on 16/04/23.
//

import Foundation
import UIKit

extension Data {
    
    func getFormattedJsonText() -> NSMutableAttributedString? {
        do {
            let object = try JSONSerialization.jsonObject(with: self, options: .mutableLeaves)
            let formattedData = try JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted])
            
            if let formattedJson = String(data: formattedData, encoding: .utf8)?.replacingOccurrences(of: "\\/", with: "/") {
                
                let attributedString = NSMutableAttributedString(string: formattedJson)
                attributedString.addAttributes([.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: UIFont.requestResponseTextViewfontSize, weight: .semibold)], range: NSRange(location: 0, length: attributedString.length))
                let regex = try NSRegularExpression(pattern: "(\\\".+\\\") : (\\\".+\\\")?(\\d{1,})?([{\\[])?([}\\]])?(\\bfalse|true|null\\b)?", options: [])
                let matches = regex.matches(in: formattedJson, options: [], range: NSRange(location: 0, length: formattedJson.utf16.count))
                
                for match in matches {
                    let tagRange = match.range(at: 1)
                    let stringValueRange = match.range(at: 2)
                    let digitValueRange = match.range(at: 3)
                    let rightBracesRange = match.range(at: 4)
                    let leftBracesRange = match.range(at: 5)
                    let otherValuesRange = match.range(at: 6)
                    
                    attributedString.addAttributes([.foregroundColor: UIColor.JSONKeyColor, .font: UIFont.systemFont(ofSize: UIFont.requestResponseTextViewfontSize, weight: .bold)] , range: tagRange)
                    attributedString.addAttributes([.foregroundColor: UIColor.JSONStringValueColor, .font: UIFont.systemFont(ofSize: UIFont.requestResponseTextViewfontSize, weight: .semibold)], range: stringValueRange)
                    attributedString.addAttributes([.foregroundColor: UIColor.JSONNumbersValueColor, .font: UIFont.systemFont(ofSize: UIFont.requestResponseTextViewfontSize, weight: .semibold)], range: digitValueRange)
                    attributedString.addAttributes([.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: UIFont.requestResponseTextViewfontSize, weight: .semibold)], range: rightBracesRange)
                    attributedString.addAttributes([.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: UIFont.requestResponseTextViewfontSize, weight: .semibold)], range: leftBracesRange)
                    attributedString.addAttributes([.foregroundColor: UIColor.JSONOtherValuesColor, .font: UIFont.systemFont(ofSize: UIFont.requestResponseTextViewfontSize, weight: .semibold)], range: otherValuesRange)
                }
                
                return attributedString
            }
        } catch {
            print("Error formatting JSON: \(error.localizedDescription)")
            return nil
        }
        
        return nil
    }
    
    func getFormatedJSONData() -> Data? {
        if let json = try? JSONSerialization.jsonObject(with: self, options: .fragmentsAllowed),
           let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
            return jsonData
        } else { return nil }
    }
    
    private func getJSONDataString(_ data: Data) -> String {
        return String(decoding: data, as: UTF8.self)
    }
    
    init(reading input: InputStream) {
        self.init()
        input.open()
        
        let bufferSize = 1024
        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: bufferSize)
        while input.hasBytesAvailable {
            let read = input.read(buffer, maxLength: bufferSize)
            if (read == 0) {
                break  // added
            }
            self.append(buffer, count: read)
        }
        buffer.deallocate()
        
        input.close()
    }
}
