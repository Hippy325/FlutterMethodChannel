//
//  CppWrapper.swift
//  Runner
//
//  Created by Тигран Гарибян on 22.11.2025.
//

import Foundation

class CppWrapper {
    
    private static func documentsPath() -> String {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0].appendingPathComponent("hello.txt").path
    }
    
    static func appendString(text: String) -> String {
        let path = documentsPath()
        let cResult = write_string(path, text)
        return String(cString: cResult!)
    }
    
    static func readFile() -> String {
        let path = documentsPath()
        let cResult = read_file(path)
        return String(cString: cResult!)
    }
}
