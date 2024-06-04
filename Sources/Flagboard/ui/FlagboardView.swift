//
//  File.swift
//  
//
//  Created by Christopher Ruz on 24-05-22.
//

import UIKit

import UIKit

public class FlagboardViewController: UIViewController {
    
    // MARK: - Properties
    
    private var featureFlags: [FeatureFlagS] = []

    // MARK: - UI Elements
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        return tableView
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .close)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle Methods
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        featureFlags = FlagboardInternal.getFlags()
        tableView.reloadData()
    }
    
    // MARK: - Setup Methods
    
    private func setupView() {
        view.addSubview(tableView)
        view.addSubview(backButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16.0),
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16.0),
            backButton.heightAnchor.constraint(equalToConstant: 24.0),
            backButton.widthAnchor.constraint(equalToConstant: 24.0),
            
            tableView.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 16.0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    // MARK: - Actions
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func switchChanged(_ sender: UISwitch) {
        let featureFlag = featureFlags[sender.tag]
        switch featureFlag.featureFlag {
        case .intFlag(let param):
            sendNotification(key: param.key.value, isOn: sender.isOn)
        case .booleanFlag(let param):
            sendNotification(key: param.key.value, isOn: sender.isOn)
        default:
            break
        }
    }
    
    // MARK: - Helper Methods
    
    private func sendNotification(key: String, isOn: Bool) {
        FlagboardInternal.save(key: key, value: isOn)
    }
}

// MARK: - UITableViewDataSource

extension FlagboardViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return featureFlags.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let featureFlag = featureFlags[indexPath.row]
        
        let switchView = UISwitch()
        switchView.tag = indexPath.row
        switchView.addTarget(self, action: #selector(switchChanged(_:)), for: .valueChanged)
        cell.accessoryView = switchView
        cell.textLabel?.numberOfLines = 0
        
        switch featureFlag.featureFlag {
        case .booleanFlag(let param):
            cell.textLabel?.text = param.key.value
            switchView.isOn = param.value
        case .intFlag(let param):
            cell.textLabel?.text = param.key.value
            switchView.isOn = param.value == 1
        default:
            break
        }
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension FlagboardViewController: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
}
