//
//  ViewController.swift
//  ecobici
//
//  Created by John A. Cristobal on 2/20/19.
//  Copyright © 2019 example. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableview: UITableView!
    var stations : [Station] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loading = UIAlertController(title: nil, message: "Sincronizando...", preferredStyle: .alert)
        
        loading.view.tintColor = UIColor.black
        let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect(x:10, y:5, width:50, height:50)) as UIActivityIndicatorView
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating();
        
        loading.view.addSubview(loadingIndicator)
        present(loading, animated: true, completion: nil)
        
        let manager = DataManager.shared
        manager.getToken(){ (token) in
            manager.getData(token: token) { (stations) in
                manager.getBicis(stations: stations, completion: { (stations) in
                    DispatchQueue.main.async {
                        loading.dismiss(animated: true, completion: {
                            self.stations = stations
                            self.tableview.reloadData()
                        })
                    }
                })
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if stations.count >= 25{
            return 25
        }else{
            return stations.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! StationTableViewCell
        
        cell.addressLabel.text = stations[indexPath.row].address
        cell.nameLabel.text = stations[indexPath.row].name
        cell.bicisLabel.text = "# Bicis: \(stations[indexPath.row].bicis!)"

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let station = stations[indexPath.row]
        performSegue(withIdentifier: "details", sender: station)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "details"{
            let detalles = segue.destination as! DetalleViewController
            detalles.station = (sender as! Station)
        }
    }
}
