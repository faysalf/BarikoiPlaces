//
//  AutocompleteViewController.swift
//
//
//  Created by Md. Faysal Ahmed on 5/12/23.
//

import UIKit
import Combine

public protocol BarikoiAutocompleteDelegate {
    func places(_ place: Place?)
}

public class BarikoiAutocompleteViewController: UIViewController {
    
    private lazy var searchBar: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = .clear
        tf.attributedPlaceholder = NSAttributedString(string: "Search Location...", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        tf.textColor = .black
        tf.borderStyle = .roundedRect
        tf.layer.cornerRadius = 8
        tf.layer.borderColor = UIColor(red: 229/255.0, green: 229/255.0, blue: 234/255.0, alpha: 1.0).cgColor
        tf.layer.borderWidth = 1.0
        tf.layer.masksToBounds = true
        tf.font = .systemFont(ofSize: 12)
        return tf
    }()
    
    private lazy var clearButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .white
        btn.setTitle(" Clear Location X ", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        btn.backgroundColor = .lightGray
        btn.layer.cornerRadius = 8
        btn.layer.masksToBounds = true
        return btn
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
        btn.titleLabel?.font = .systemFont(ofSize: 12, weight: .bold)
        return btn
    }()
    
    public var initialQuery: String = "Dhanmondi"
    public var delegate: BarikoiAutocompleteDelegate?
    private var vm = PlacesViewModel()
    private var cancellables: Set<AnyCancellable> = []
    
    // MARK: - Life Cycles
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        setupSearchBar()
        setupClearLocationButton()
        setupTableView()
        configureUI()
        vm.initialQuery = initialQuery
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        searchBar.text = ""
        tableView.reloadData()

    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        vm.setAddressQuery(initialQuery)

    }
    
    public override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        view.addSubview(searchBar)
        view.addSubview(clearButton)
        view.addSubview(tableView)
        view.addSubview(cancelButton)
    }
    
    // MARK: - Setup
    private func setupSearchBar() {
        searchBar.delegate = self
        searchBar.keyboardType = .default
        searchBar.frame = CGRect(x: 16, y: 66, width: view.bounds.width-80, height: 40)
        cancelButton.frame = CGRect(x: searchBar.frame.maxX+5, y: 66, width: 45, height: 40)
        cancelButton.addTarget(self, action: #selector(didTapCancel), for: .touchUpInside)
    }
    
    private func setupClearLocationButton() {
        clearButton.frame = CGRect(x: 16, y: searchBar.frame.maxY+10, width: 140, height: 30)
        clearButton.addTarget(self, action: #selector(didTapClearButton(_:)), for: .touchUpInside)
    }

    private func setupTableView() {
        tableView.backgroundColor = UIColor.white
        tableView.frame = CGRect(x: 0, y: clearButton.frame.maxY+15, width: view.bounds.width, height: view.bounds.height-searchBar.frame.maxY-20)
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.CELL_IDENTIFIER)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func configureUI() {
        vm.$places
            .sink { completion in
                debugPrint("Error")
            } receiveValue: { _ in
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            .store(in: &cancellables)

    }
    
    // MARK: - Button actions
    @objc
    func didTapCancel(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    func didTapClearButton(_ sender: UIButton) {
        delegate?.places(nil)
        self.dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
    }
    
    
}

// MARK: - Text field delegate
extension BarikoiAutocompleteViewController: UITextFieldDelegate {
    
    public func textFieldDidChangeSelection(_ textField: UITextField) {
        if let text = textField.text {
            vm.setAddressQuery(text)
        }
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

// MARK: - Table View delegate & datasource
extension BarikoiAutocompleteViewController: UITableViewDelegate, UITableViewDataSource {
    
    public func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return vm.places.count
    }
    
    public func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.CELL_IDENTIFIER, for: indexPath) as! CustomTableViewCell
        cell.textContent = vm.places[indexPath.row]
        return cell
    }
    
    public func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        return 60
    }
    
    public func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        debugPrint(vm.places[indexPath.row])
        delegate?.places(vm.places[indexPath.row])
        self.searchBar.text = ""
        self.dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)

    }
    
}

//struct BarikoiViewControllerWrapper: UIViewControllerRepresentable {
//    func makeUIViewController(context: Context) -> UIViewController {
//        return BarikoiViewController()
//    }
//
//    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
//        // Update
//    }
//}
//
//@available(iOS 15.0, *)
//struct BarikoiViewControllerWrapper_Previews: PreviewProvider {
//    static var previews: some View {
//        BarikoiViewControllerWrapper()
//    }
//}
