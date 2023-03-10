//
//  ViewController.swift
//  chatAiDemo
//
//  Created by Don Dominic on 11/03/23.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let ccell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        ccell.textLabel?.text = model[indexPath.row]
        
        ccell.textLabel?.numberOfLines = 0
        
        return ccell
    }
    
    private let field: UITextField = {
        
        let textField = UITextField()
        
        textField.placeholder = "Enter text here..!"
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.layer.cornerRadius = 5
        
        textField.backgroundColor = .white
        
        textField.returnKeyType = .done
        
        return textField
    }()
    
    private var model = [String]()
    
    private let table: UITableView = {
        let table = UITableView()
        
        table.backgroundColor = .red
        
        table.translatesAutoresizingMaskIntoConstraints = false
        
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(table)
        
        view.addSubview(field)
        
        table.dataSource = self
        
        table.delegate = self
        
        field.delegate = self
        
        NSLayoutConstraint.activate([
            
            field.heightAnchor.constraint(equalToConstant: 50),
            
            field.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10),
            
            field.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10),
            field.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor),
                                    
            table.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            
            table.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            
            table.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
            table.bottomAnchor.constraint(equalTo: field.topAnchor),
                                     
                                    ])
        // Do any additional setup after loading the view.
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if let text = textField.text, !text.isEmpty{
            
            ApiCaller.shared.getResponse(input: text, completion: {result in
            
                switch result{
                
                case .success(let output):
                
                    self.model.append(output)
                    
                    DispatchQueue.main.async {
                    
                        self.table.reloadData()
                    }
                
                case.failure(let error):
                
                    print(error)
                }
            })
        }
        return true
    }


}

