//
//  DetalleViewController.swift
//  ecobici
//
//  Created by John A. Cristobal on 2/20/19.
//  Copyright © 2019 example. All rights reserved.
//

import UIKit
import MapKit

class DetalleViewController: UIViewController,MKMapViewDelegate {

    @IBOutlet var bikesLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var directionLabel: UILabel!
    @IBOutlet var closeStations: UILabel!
    var station: Station?
    @IBOutlet var mapview: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mapview.delegate = self
        let center = CLLocationCoordinate2D(latitude: (station?.lat)!, longitude: (station?.lon)!)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        self.mapview.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2DMake( (station?.lat)!,  (station?.lon)!)
        annotation.title = station?.name
        mapview.addAnnotation(annotation)
        
        nameLabel.text = station?.name
        bikesLabel.text = "# bicis: \(station!.bicis!)"
        directionLabel.text = station?.address
        closeStations.text = "Estaciones cercanas: \(station!.closeStations!)"
    }
}
