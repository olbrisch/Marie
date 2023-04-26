//
//  CustomURLProtocol.swift
//  Marie
//
//  Created by Gabriel Olbrisch on 14/04/23.
//

import UIKit
import QuartzCore

open class MarieCustomURLProtocol: URLProtocol {
    
    open override class func canInit(with request: URLRequest) -> Bool {
        guard let scheme = request.url?.scheme else { return false }
        return scheme == "http" || scheme == "https"
    }
    
    open override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    open override func startLoading() {
        
        var logModel = URLLogModel(
            request: request,
            url: request.url,
            method: request.httpMethod,
            headers: request.allHTTPHeaderFields,
            status: .awaiting,
            responseBody: nil,
            requestBody: nil,
            responseTime: nil
        )
        
        if let body = request.httpBodyStream {
            logModel.requestBody = (String(data: Data(reading: body), encoding: .utf8) ?? "")
        } else {
            logModel.requestBody = "Empty body"
        }
        
        LogManager.shared.log(model: logModel)
        let startTime = CACurrentMediaTime()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
            let task = URLSession.shared.dataTask(with: self.request) { (data, response, error) in
                
                let endTime = CACurrentMediaTime()
                logModel.responseTime = (endTime - startTime) * 1000
                
                if let httpResponse = response as? HTTPURLResponse {
                    logModel.status = HTTPStatusCode(rawValue: httpResponse.statusCode)
                }
                
                if let data {
                    logModel.responseBody = String(data: data, encoding: .utf8) ?? ""
                } else if let error {
                    logModel.responseBody = error.localizedDescription
                }
                
                LogManager.shared.update(model: logModel)
            }
            
            task.resume()
        }
        
        client?.urlProtocolDidFinishLoading(self)
    }
    
    open override func stopLoading() { }
    
}
