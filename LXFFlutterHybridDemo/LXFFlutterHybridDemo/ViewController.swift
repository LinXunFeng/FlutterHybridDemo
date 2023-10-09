//
//  ViewController.swift
//  LXFFlutterHybridDemo
//
//  Created by LinXunFeng on 2023/3/16.
//

import UIKit
import Flutter
import FlutterPluginRegistrant

class ViewController: FlutterViewController {

  override func viewDidLoad() {
      GeneratedPluginRegistrant.register(with: self.engine!);
    super.viewDidLoad()
    // Do any additional setup after loading the view.
      
      
    
    print("engine -- \(self.engine)")
  }


}

