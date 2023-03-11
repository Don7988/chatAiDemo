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
                
                print(String(describing: model.choices))
            
                let output = model.choices.first?.text ?? ""
                
                completion(.success(output))
            
            case.failure(let error):
            
                completion(.failure(error))
            }
        })
    }
}
