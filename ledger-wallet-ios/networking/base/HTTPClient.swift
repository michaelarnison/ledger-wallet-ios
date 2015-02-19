//
//  HTTPClient.swift
//  ledger-wallet-ios
//
//  Created by Nicolas Bigot on 12/02/2015.
//  Copyright (c) 2015 Ledger. All rights reserved.
//

import Foundation

class HTTPClient {
    
    var autoStartsRequest = true
    var timeoutInterval: NSTimeInterval = 30
    var additionalHeaders: [String: String]? = nil
    var session: NSURLSession {
        if _session == nil {
            _session = NSURLSession(configuration: preferredSessionConfiguration(), delegate: preferredSessionDelegate(), delegateQueue: preferredSessionDelegateQueue())
        }
        return _session
    }
    private var _session: NSURLSession! = nil
    
    // MARK: - Tasks management
    
    func get(URL: String, completionHandler: Task.CompletionHandler?, parameters: Task.Parameters? = nil, encoding: Task.Encoding = .URL) -> DataTask {
        return performDataRequest(.GET, URL: URL, completionHandler: completionHandler, parameters: parameters, encoding: encoding)
    }
    
    func post(URL: String, completionHandler: Task.CompletionHandler?, parameters: Task.Parameters? = nil, encoding: Task.Encoding = .URL) -> DataTask {
        return performDataRequest(.POST, URL: URL, completionHandler: completionHandler, parameters: parameters, encoding: encoding)
    }
    
    func delete(URL: String, completionHandler: Task.CompletionHandler?, parameters: Task.Parameters? = nil, encoding: Task.Encoding = .URL) -> DataTask {
        return performDataRequest(.DELETE, URL: URL, completionHandler: completionHandler, parameters: parameters, encoding: encoding)
    }
    
    func head(URL: String, completionHandler: Task.CompletionHandler?, parameters: Task.Parameters? = nil, encoding: Task.Encoding = .URL) -> DataTask {
        return performDataRequest(.HEAD, URL: URL, completionHandler: completionHandler, parameters: parameters, encoding: encoding)
    }
    
    func put(URL: String, completionHandler: Task.CompletionHandler?, parameters: Task.Parameters? = nil, encoding: Task.Encoding = .URL) -> DataTask {
        return performDataRequest(.PUT, URL: URL, completionHandler: completionHandler, parameters: parameters, encoding: encoding)
    }
    
    private func performDataRequest(method: Task.Method, URL: String, completionHandler: Task.CompletionHandler?, parameters: Task.Parameters? = nil, encoding: Task.Encoding = .URL) -> DataTask {
        // create request
        let request = defaultRequest(method, URL: URL)
        
        // encode parameters
        encoding.encode(request, parameters: parameters)
        
        // create data task
        let handler: ((NSData?, NSURLResponse?, NSError?) -> Void)? = (completionHandler == nil) ? nil : { data, response, error in
            let httpResponse = response as! NSHTTPURLResponse
            let statusCode = httpResponse.statusCode
            var finalError = error
            if finalError == nil && statusCode < 200 && statusCode > 299 {
                finalError = NSError(domain: "HTTPClientErrorDomain", code: statusCode, userInfo: nil)
            }
            completionHandler?(data, request, httpResponse, finalError)
        }
        let task = session.dataTaskWithRequest(request, completionHandler: handler)
        
        // launch it if necessary
        if autoStartsRequest {
            task.resume()
        }
        return task
    }
    
    // MARK: - Requests
    
    private func defaultRequest(method: Task.Method, URL: String) -> NSMutableURLRequest {
        let request = NSMutableURLRequest()
        request.URL = NSURL(string: URL)
        request.HTTPMethod = method.rawValue
        request.timeoutInterval = timeoutInterval
        if let additionalHeaders = additionalHeaders {
            for (key, value) in additionalHeaders {
                request.addValue(value, forHTTPHeaderField: key)
            }
        }
        return request
    }
    
    // MARK: - Configuration
    
    private func preferredSessionConfiguration() -> NSURLSessionConfiguration? {
        let configuration = NSURLSessionConfiguration.ephemeralSessionConfiguration()
        configuration.timeoutIntervalForRequest = timeoutInterval
        return configuration
    }
    
    private func preferredSessionDelegate() -> NSURLSessionDelegate? {
        return nil
    }
    
    private func preferredSessionDelegateQueue() -> NSOperationQueue? {
        return NSOperationQueue.mainQueue()
    }
    
    // MARK: - Initialization
    
    deinit {
        _session?.finishTasksAndInvalidate()
    }
    
}