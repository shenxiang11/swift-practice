//
//  ViewController.swift
//  001-pure_code_hello_world
//
//  Created by 沈翔 on 2020/6/16.
//  Copyright © 2020 沈翔. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let label: UILabel = {
        let label = UILabel()
        
        label.text = "Hello world!"
        
        // 如果你想使用 Auto Layout 动态计算、改变视图尺寸的话，你必须将该属性值改为 false 。然后你只需提供无歧义、无冲突的约束即可。
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
    }


}

