//
//  File.swift
//  
//
//  Created by Christopher Ruz on 24-05-22.
//

import UIKit

public class FlagboardViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    private var tableView: UITableView!
    private var featureFlags: [FeatureFlagS] = FlagboardInternal.getFlags()

    public override func viewDidLoad() {
        super.viewDidLoad()

        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(tableView)
    }

    // MARK: - UITableViewDataSource

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
            switchView.isOn = param.value == 1 ? true : false
        default:
            return UITableViewCell(frame: .zero)
        }

        return cell
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
    
    private func sendNotification(key: String, isOn: Bool) {
        FlagboardInternal.save(key: key, value: isOn)
    }

    // MARK: - UITableViewDelegate

    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}

