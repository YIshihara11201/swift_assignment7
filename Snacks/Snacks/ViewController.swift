//
//  ViewController.swift
//  Snacks
//
//  Created by Yusuke Ishihara on 2022-05-17.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var snacks = [String]()
    
    @IBOutlet var navBar: UIView!
    @IBOutlet var plusButton: UIButton!
    @IBOutlet var navBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet var tableView: UITableView!
    
//    lazy var titleLabel: UILabel = {
//        let label = UILabel()
//        label.tintColor = .black
//        label.text = "Snacks"
//        label.textAlignment = .center
//        label.font = UIFont.systemFont(ofSize: 50)
//
//        return label
//    }()
    
    lazy var oreoView: UIImageView = {
        let img = UIImageView(image:UIImage(named: "oreos"))
        img.contentMode = .scaleAspectFit
        img.translatesAutoresizingMaskIntoConstraints = false
        img.isUserInteractionEnabled = true
        img.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(oreoTapped(_:))))

        return img
    }()
    
    lazy var pizzapocketsView: UIImageView = {
        let img = UIImageView(image:UIImage(named: "pizza_pockets"))
        img.contentMode = .scaleAspectFit
        img.translatesAutoresizingMaskIntoConstraints = false
        img.isUserInteractionEnabled = true
        img.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(pizzapocketsTapped(_:))))
        
        return img
    }()
    
    lazy var poptartsView: UIImageView = {
        let img = UIImageView(image:UIImage(named: "pop_tarts"))
        img.contentMode = .scaleAspectFit
        img.translatesAutoresizingMaskIntoConstraints = false
        img.isUserInteractionEnabled = true
        img.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(poptartsTapped(_:))))
        
        return img
    }()
    
    lazy var popsliceView: UIImageView = {
        let img = UIImageView(image:UIImage(named: "popsicle"))
        img.contentMode = .scaleAspectFit
        img.translatesAutoresizingMaskIntoConstraints = false
        img.isUserInteractionEnabled = true
        img.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(popsliceTapped(_:))))
        
        return img
    }()
    
    lazy var ramenView: UIImageView = {
        let img = UIImageView(image:UIImage(named: "ramen"))
        img.contentMode = .scaleAspectFit
        img.translatesAutoresizingMaskIntoConstraints = false
        img.isUserInteractionEnabled = true
        img.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ramenTapped(_:))))
        
        return img
    }()
    
    lazy var snackStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [oreoView, pizzapocketsView, poptartsView, popsliceView, ramenView])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.isHidden = true
        
        return stack
    }()
    
    var isOpenNavBar = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        navBar.addSubview(titleLabel)
        navBar.addSubview(snackStack)
        
//        NSLayoutConstraint.activate([
//            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
//            titleLabel.centerXAnchor.constraint(equalTo: navBar.centerXAnchor),
//            titleLabel.widthAnchor.constraint(equalTo: navBar.widthAnchor, multiplier: 0.3)
//        ])
        
        NSLayoutConstraint.activate([
            snackStack.leadingAnchor.constraint(equalTo: navBar.leadingAnchor),
            snackStack.trailingAnchor.constraint(equalTo: navBar.trailingAnchor),
            snackStack.bottomAnchor.constraint(equalTo: navBar.bottomAnchor, constant: -8),
            snackStack.heightAnchor.constraint(equalToConstant: 100)
//            snackStack.bottomAnchor.constraint(equalTo: navBar.bottomAnchor, constant: 0),
//            snackStack.centerYAnchor.constraint(equalTo: navBar.centerYAnchor),
//            snackStack.centerXAnchor.constraint(equalTo: navBar.centerXAnchor),
        ])
    }
    
    @IBAction func plusButtonTapped(_ sender: UIButton) {
        if isOpenNavBar {
            expandNavbar(withHeight: 88)
            rotatePlusIcon(degree: .pi/2)
        } else {
            expandNavbar(withHeight: 200)
            rotatePlusIcon(degree: .pi/4)
        }
        isOpenNavBar.toggle()
    }
    
    @objc func oreoTapped(_ sender: UITapGestureRecognizer){
        snacks.append("oreo")
        print(snacks)
        tableView.insertRows(at: [IndexPath(row: snacks.count-1, section: 0)], with: .automatic)
        tableView.reloadData()
    }
    
    @objc func pizzapocketsTapped(_ sender: UITapGestureRecognizer){
        snacks.append("pizza pockets")
        tableView.insertRows(at: [IndexPath(row: snacks.count-1, section: 0)], with: .automatic)
        tableView.reloadData()
    }
    
    @objc func poptartsTapped(_ sender: UITapGestureRecognizer){
        snacks.append("poptarts")
        tableView.insertRows(at: [IndexPath(row: snacks.count-1, section: 0)], with: .automatic)
        tableView.reloadData()
    }
    
    @objc func popsliceTapped(_ sender: UITapGestureRecognizer){
        snacks.append("popslice")
        tableView.insertRows(at: [IndexPath(row: snacks.count-1, section: 0)], with: .automatic)
        tableView.reloadData()
    }
    
    @objc func ramenTapped(_ sender: UITapGestureRecognizer){
        snacks.append("ramen")
        tableView.insertRows(at: [IndexPath(row: snacks.count-1, section: 0)], with: .automatic)
        tableView.reloadData()
    }
    
    func expandNavbar(withHeight height: CGFloat){
        UIView.animate(
            withDuration: 1.5,
            delay: 0.0,
            usingSpringWithDamping: 0.6,
            initialSpringVelocity: 0.4,
            options: [],
            animations: {
                self.navBarHeightConstraint.constant = height
                UIView.animate(withDuration: 0.5) {
                    self.view.layoutIfNeeded()
                }
            },
            completion: nil
        )
        
        snackStack.isHidden.toggle()
    }
    
    func rotatePlusIcon(degree: CGFloat){
        let rotateTransfrom = CGAffineTransform(rotationAngle: degree)
        UIView.animate(withDuration: 0.5) {
            self.plusButton.transform = rotateTransfrom
        }
    }
    
}

extension ViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return snacks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "snackCell", for: indexPath)
        let snack = snacks[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = snack
        cell.contentConfiguration = content
        
        return cell
    }
}
