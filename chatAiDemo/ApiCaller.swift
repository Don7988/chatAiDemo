//
//  ApiCaller.swift
//  chatAiDemo
//
//  Created by Don Dominic on 11/03/23.
//

import Foundation

import OpenAISwift

final class ApiCaller{
    
    static let shared = ApiCaller()
    
    @frozen enum constants{
        
        static let key = "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"
    }
    
    private init(){}
    
    private var client: OpenAISwift?
    
    public func setup(){
        self.client = OpenAISwift(authToken: constants.key)
    }
    
    public func getResponse(input: String, completion: @escaping(Result<String,Error>) -> Void){
        
        client?.sendCompletion(with: input, completionHandler: { result in
        
            switch result{
            
            case.success(let model):
            
                let output = model.choices.first?.text ?? ""
                
                completion(.success(output))
            
            case.failure(let error):
            
                completion(.failure(error))
            }
        })
    }
}
