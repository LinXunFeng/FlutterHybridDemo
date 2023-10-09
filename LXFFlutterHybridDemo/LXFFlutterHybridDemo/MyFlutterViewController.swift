//
//  MyFlutterViewController.swift
//  LXFFlutterHybridDemo
//
//  Created by LinXunFeng on 2023/3/17.
//

import Foundation
import FlutterPluginRegistrant

class MyFlutterViewController: FlutterViewController {
    
    init(withEntrypoint entryPoint: String?) {
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let newEngine = appDelegate.engines.makeEngine(with: FlutterEngineGroupOptions())
        GeneratedPluginRegistrant.register(with: newEngine)
        super.init(engine: newEngine, nibName: nil, bundle: nil)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
