//
//  ViewController.swift
//  GenericExample
//
//  Created by Ngo Dang tan on 07/01/2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        APICaller.shared.performAPICall(url: "https://api.service.com/getCars", expectingReturnType: Car.self) { result in
            switch result{
            case .success(let car):
                print(car.carmodel)
            case .failure(let error):
                print(error)
            }
        }
        
        APICaller.shared.performAPICall(url: "https://api.service.com/getFruit", expectingReturnType: Fruit.self) { result in
            switch result{
            case .success(let fruit):
                print(fruit.identifier)
            case .failure(let error):
                print(error)
            }
        }
        
    }


}

class APICaller {
    static let shared = APICaller()
    
    public func performAPICall<T: Codable>(url: String, expectingReturnType: T.Type,completion: @escaping((Result<T, Error>) -> Void)){
        URLSession.shared.dataTask(with: URL(string: "foo")!) { data, _, error in
            guard let data = data, error == nil else {return}
            var decodedResult: T?
            do {
                decodedResult = try JSONDecoder().decode(T.self, from: data)
             
            }catch {
        
                print(error)
            }
            guard let result = decodedResult else {
                //call failse case
                return
            }
            completion(.success(result))
        }
    }
    
}

struct Fruit:Codable {
    let name: String
    let identifier: String
    let imageName: String
    
}
struct Car:Codable {
    let carmodel:String
    let name: String
    let identifier: String
    let imageName: String
    
}
struct Recipes:Codable {
    let name: String
    let recipesType: String
    let identifier: String
    let imageName: String
    
}
