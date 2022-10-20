//
//  ViewController.swift
//  AlamofireVersusURLSession
//
//  Created by Cüneyt Erçel on 20.10.2022.
// WEBSERVICE KISMINDA AF VE URLSESSION, Completion handler kullanarak çekme.

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        forAlamofire() // Başarılı
        
    }
    
    func forURLSession() {
        APICaller.shared.getDatasWithURLSession { results in
            switch results {
            case .success(let datas):
                print(datas)
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func forAlamofire() {
        
        APICaller.shared.getDatasWithURLSession { results in
            switch results {
            case.success(let datas):
                print(datas)
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }


}

