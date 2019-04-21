//
//  QuizVC.swift
//  Trivia
//
//  Created by admin on 19/04/19.
//  Copyright © 2019 AcknoTech. All rights reserved.
//

import UIKit

class QuizVC: UIViewController {
    
    // MARK: - Constants -
    private let reuseCell = "CellID"
    
    fileprivate let quizDataService = QuizService.service
    
    fileprivate let userName = Service.service
    
    // MARK: - Variables -
    fileprivate var currentIndex:IndexPath!
    
    // MARK: - View Methods -
    override func loadView() {
        super.loadView()
        addSubviews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let indexPath = IndexPath(item: 0, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    // MARK: - Defined Views -
    fileprivate lazy var headerView:UIView = {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        return headerView
    }()
    
    fileprivate lazy var quiznumLabel:UILabel = {
        let quiznumLabel = UILabel()
        quiznumLabel.textColor = .white
        quiznumLabel.textAlignment = .left
        quiznumLabel.text = "Quiz : 1"
        quiznumLabel.font = UIFont(name: "Avenirnext-Bold", size: 20)
        
        return quiznumLabel
    }()
    
    fileprivate lazy var quiztotalNumLabel:UILabel = {
        let quiztotalNumLabel = UILabel()
        quiztotalNumLabel.textColor = .white
        quiztotalNumLabel.textAlignment = .right
        quiztotalNumLabel.text = "1/2"
        quiztotalNumLabel.font = UIFont(name: "Avenirnext-Bold", size: 20)
        return quiztotalNumLabel
    }()
    
    fileprivate lazy var boarderView:UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    fileprivate lazy var collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        collectionView.isScrollEnabled = false
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.bounces = false
        return collectionView
    }()
    
    fileprivate lazy var submitButton:UIButton = {
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.borderWidth = 5
        button.layer.borderColor = UIColor.orange.cgColor
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont(name: "Avenir-Medium", size: 20)
        button.addTarget(self, action: #selector(nextButton), for: .touchUpInside)
        button.backgroundColor = .orange
        button.setAnchor(width: 0, height: 50)
        return button
    }()
    
    // MARK: - Subviews Function -
    private func addSubviews(){
        
        view.backgroundColor = UIColor(red: 36/255, green: 42/255, blue: 64/255, alpha: 1)
        navigationController?.navigationBar.barTintColor = UIColor(red: 44/255, green: 64/255, blue: 88/255, alpha: 1)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "Home"), style: .plain, target: self, action: #selector(quitQuiz))
        navigationItem.rightBarButtonItem?.tintColor = .white
        
        view.addSubview(headerView)
        headerView.setAnchor(top: view.safeTopAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 10)
        headerView.setAnchor(width: 0, height: 50)
        
        headerView.addSubview(quiznumLabel)
        quiznumLabel.setAnchor(top: headerView.topAnchor, left: headerView.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        quiznumLabel.setAnchor(width: 100, height: 40)
        
        headerView.addSubview(quiztotalNumLabel)
        quiztotalNumLabel.setAnchor(top: headerView.topAnchor, left: nil, bottom: nil, right: headerView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        quiztotalNumLabel.setAnchor(width: 100, height: 40)
        
        headerView.addSubview(boarderView)
        boarderView.setAnchor(top: nil, left: headerView.leftAnchor, bottom: headerView.bottomAnchor, right: headerView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        boarderView.setAnchor(width: 0, height: 3)
        
        view.addSubview(collectionView)
        collectionView.setAnchor(top: headerView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        collectionView.setAnchor(width: 0, height: view.frame.height/2 + 50)
        view.addSubview(submitButton)
        submitButton.setAnchor(top: nil, left: view.leftAnchor, bottom: view.safeBottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: -10, paddingRight: 10)
    }
    
    // MARK: - collectionView DataSource and Delegation -
    private func collectionViewData(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(QuestionCollectionViewCell.self, forCellWithReuseIdentifier: reuseCell)
    }
    
    // MARK: - Next View -
    private func presentedView(){
        let vc = CongratsVC()
        UIApplication.shared.keyWindow?.rootViewController = vc
    }
    
    // MARK: - Selectors -
    @objc func nextButton(){
        if currentIndex.item == 0{
            guard let _ = quizDataService.getanswer1() else {return}
            let nextIndex = min(currentIndex.item + 1, quizDataService.getQuestions().count - 1)
            let indexPath = IndexPath(item: nextIndex, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
        }
        
        if !quizDataService.getanswer2().isEmpty{
            guard let answer1 = quizDataService.getanswer1() else {return}
            save(name: userName.name().personName, answer1: answer1, answer2: quizDataService.getanswer2().joined(separator: ", "))
            presentedView()
        }
        
        
    }
    
    @objc func quitQuiz(){
        QuizService.service.answer1 = nil
        QuizService.service.answer2.removeAll()
        UIApplication.shared.keyWindow?.rootViewController = MainVC()
    }
}

// MARK: - Extensions -
extension QuizVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return quizDataService.getQuestions().count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseCell, for: indexPath) as? QuestionCollectionViewCell else{return UICollectionViewCell()}
        cell.updateCell(questionsData: quizDataService.getQuestions()[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        updateData(indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 20, height: collectionView.frame.height - 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    // MARK: - Next Question -
    private func updateData(indexPath:IndexPath){
        currentIndex = indexPath
        quiznumLabel.text = "Quiz : \(indexPath.item + 1)"
        quiztotalNumLabel.text = "\(indexPath.item + 1)/\(quizDataService.getQuestions().count)"
        
        quizDataService.getQuestions().count - 1 == indexPath.item ? submitButton.setTitle("Submit", for: .normal) : submitButton.setTitle("Next", for: .normal)
        
    }
    
    
    
}

