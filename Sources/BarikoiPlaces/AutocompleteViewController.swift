//
//  AutocompleteViewController.swift.swift
//  
//
//  Created by Md. Faysal Ahmed on 5/12/23.
//

import UIKit
import Foundation

public protocol BarikoiAutocompleteDelegate {
    func places(_ data: Place)
}

public class BarikoiViewController: UIViewController {
    
    private lazy var searchBar: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = .clear
        tf.placeholder = "Search Location..."
        tf.textColor = .black
        tf.borderStyle = .roundedRect
        tf.font = .systemFont(ofSize: 12)
        return tf
    }()
    
    private lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .white
        return tv
    }()
    
    private lazy var cancelButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .white
        btn.setTitle("Cancel", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 12)
        return btn
    }()
    
    var placesArr: [Place] = []
    public var delegate: BarikoiAutocompleteDelegate?
    var indicator = Indicator.shared
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setSearchBar()
        setTableView()

    }
    
    public override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        view.addSubview(searchBar)
        view.addSubview(tableView)
        view.addSubview(cancelButton)
        view.addSubview(indicator)
    }
    
    private func setSearchBar() {
        searchBar.delegate = self
        searchBar.keyboardType = .default
        searchBar.frame = CGRect(x: 16, y: 66, width: view.bounds.width-80, height: 40)
        cancelButton.frame = CGRect(x: searchBar.frame.maxX+5, y: 66, width: 45, height: 40)
        cancelButton.addTarget(self, action: #selector(didTapCancel), for: .touchUpInside)
    }

    private func setTableView() {
        tableView.frame = CGRect(x: 0, y: searchBar.frame.maxY+20, width: view.bounds.width, height: view.bounds.height-searchBar.frame.maxY-20)
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // MARK: - Button actions
    @objc func didTapCancel(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func getAutocompletePlaces(_ query: String) {
        let api_key = BarikoiPlacesClient.getApiKey()
        guard !api_key.isEmpty else { return }
        indicator.startAnimating()

        if let query = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            let url = URL(string: "https://barikoi.xyz/v2/api/search/autocomplete/place?api_key=\(api_key)&q=\(query)&bangla=true")!
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                
                DispatchQueue.main.async {
                    self.indicator.stopAnimating()
                }
                guard let data = data else { return }
                
                do {
                    let decoder = JSONDecoder()
                    let placesData = try decoder.decode(PlaceModel.self, from: data)
                    self.placesArr = []
                    
                    for place in placesData.places {
                        self.placesArr.append(place)
                    }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    
                }catch {
                    if let responseString = String(data: data, encoding: .utf8) {
                        print(responseString)
                    }
                    print(error)
                }
                
            }
            task.resume()
        }
    }
}



// MARK: - Text field delegate
extension BarikoiViewController: UITextFieldDelegate {
    
    public func textFieldDidChangeSelection(_ textField: UITextField) {
        if let text = textField.text, text.count >= 3 {
            getAutocompletePlaces(text)
        }
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


// MARK: - Table View delegate & datasource
extension BarikoiViewController: UITableViewDelegate, UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placesArr.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        cell.textContent = placesArr[indexPath.row]
        return cell
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(placesArr[indexPath.row])
        delegate?.places(placesArr[indexPath.row])
        self.searchBar.text = ""
        self.dismiss(animated: true, completion: nil)
    }
    
}
