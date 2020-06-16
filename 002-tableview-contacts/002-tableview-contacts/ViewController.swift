//
//  ViewController.swift
//  002-tableview-contacts
//
//  Created by 沈翔 on 2020/6/16.
//  Copyright © 2020 沈翔. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    static let cellReuseIdentifier = "cellReuseIdentifier"
    
    let contacts = [
      "刘雨昕",
      "虞书欣",
      "许佳琪",
      "喻言",
      "谢可寅",
      "安崎",
      "赵小棠",
      "孔雪儿",
      "陆柯燃",
      "乃万",
      "金子涵",
      "王承渲",
      "曾可妮",
      "刘令姿",
      "戴萌",
      "上官喜爱",
      "孙芮",
      "徐紫茵",
      "宋昕冉",
      "戴燕妮",
      "林凡",
      "莫寒",
      "张语格",
      "段艺璇",
      "蔡卓宜",
      "葛鑫怡",
      "张楚寒",
      "许馨文",
      "左卓",
      "许杨玉琢",
      "陈珏",
      "张钰",
      "傅如乔",
      "朱林雨",
      "林小宅",
      "徐轸轸",
      "李依宸",
      "费沁源",
      "宋昭艺",
      "苏杉杉",
      "七穗",
      "秦牛正威",
      "夏研",
      "冯若航",
      "王清",
      "魏辰",
      "陈品瑄",
      "勾雪莹",
      "胡馨尹",
      "陈昕葳",
      "马蜀君",
      "王欣宇",
      "符雅凝",
      "段小薇",
      "孙美楠",
      "韩东",
      "靳阳阳",
      "黄欣苑",
      "王婉辰",
      "张梦露",
      "黄小芸",
      "文哲",
      "熊钰清",
      "阿依莎",
      "艾霖",
      "艾依依",
      "陈艺文",
      "程曼鑫",
      "杜紫怡",
      "符佳",
      "何美延",
      "黄一鸣",
      "金吉雅",
      "林慧博",
      "林韦希",
      "刘海涵",
      "刘亚楠",
      "米拉",
      "墨谣",
      "欧若拉",
      "权笑迎",
      "申清",
      "申玉",
      "申洁",
      "沈莹",
      "粟钦柔",
      "唐珂伊",
      "汪睿",
      "王姝慧",
      "王思予",
      "王心茗",
      "王雅乐",
      "王瑶瑶",
      "未书羽",
      "魏奇奇",
      "希娅",
      "徐百仪",
      "杨宇彤",
      "姚依凡",
      "张洛菲",
      "张天馨",
      "郑玉歆",
      "周琳聪",
      "周梓倩",
      "查祎琛",
      "卓依娜姆",
      "邹思扬",
      "申冰",
      "李熙凝"
    ]
    
    lazy var groupedData: [Dictionary<String, [String]>.Element] = {
        var data: [String: [String]] = [:]
        
        for name in self.contacts {
            let alphabet = getFirstLetterFromString(aString: name)
            if data[alphabet] == nil {
                data[alphabet] = [name]
            } else {
                data[alphabet]?.append(name)
            }
        }
        
        return data.sorted(by: {$0.0 < $1.0})
    }()

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
                
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Self.cellReuseIdentifier)
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return groupedData[section].key
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return groupedData.map { $0.key }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupedData[section].value.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return groupedData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Self.cellReuseIdentifier, for: indexPath)
        
        cell.textLabel?.text = groupedData[indexPath.section].value[indexPath.item]
        
        return cell
    }
}

extension ViewController {
    // MARK: - 将中文转拼音取首字母的方法
    func getFirstLetterFromString(aString: String) -> (String) {
        // 注意,这里一定要转换成可变字符串
        let mutableString = NSMutableString.init(string: aString)
        // 将中文转换成带声调的拼音
        CFStringTransform(mutableString as CFMutableString, nil, kCFStringTransformToLatin, false)
        // 去掉声调(用此方法大大提高遍历的速度)
        let pinyinString = mutableString.folding(options: String.CompareOptions.diacriticInsensitive, locale: NSLocale.current)
        // 将拼音首字母装换成大写
        let strPinYin = pinyinString.uppercased()
        return String(strPinYin.prefix(1))
    }
}
