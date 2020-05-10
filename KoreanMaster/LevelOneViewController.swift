//
//  LevelOneViewController.swift
//  KoreanMaster
//
//  Created by Kayla Williams on 5/10/20.
//  Copyright © 2020 Kayla Williams. All rights reserved.
//

import UIKit

class LevelOneViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    var gameModels = [Question]()
    
    var currentQuestion: Question?
    
    @IBOutlet var label: UILabel!
    @IBOutlet var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        setupQuestions()
        configureUI(question: gameModels.first!)
        
    }
    
    private func configureUI(question: Question) {
        label.text = question.text
        currentQuestion = question
    }
    
    private func checkAnswer(answer: Answer, question: Question) -> Bool {
        return question.answers.contains(where: {$0.text == answer.text}) && answer.correct
    }
    
    private func setupQuestions() {
        gameModels.append(Question(text: "안녕하세요", answers: [
            Answer(text: "hello", correct: true),
            Answer(text: "goodbye", correct: false),
            Answer(text: "yes", correct: false),
            Answer(text: "no", correct: false)
        ]))
        
        gameModels.append(Question(text: "아니요", answers: [
            Answer(text: "hello", correct: false),
            Answer(text: "goodbye", correct: false),
            Answer(text: "yes", correct: false),
            Answer(text: "no", correct: true)
        ]))
        
        gameModels.append(Question(text: "네", answers: [
            Answer(text: "hello", correct: false),
            Answer(text: "goodbye", correct: false),
            Answer(text: "yes", correct: true),
            Answer(text: "no", correct: false)
        ]))
        
        gameModels.append(Question(text: "저기요", answers: [
            Answer(text: "just a second", correct: false),
            Answer(text: "excuse me", correct: true),
            Answer(text: "goodbye", correct: false),
            Answer(text: "yeah", correct: false)
        ]))
    }
    
    // Table view functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentQuestion?.answers.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = currentQuestion?.answers[indexPath.row].text
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let question = currentQuestion else {
            return
        }
        
        let answer = question.answers[indexPath.row]
        
        if checkAnswer(answer: answer, question: question) {
            // next question
            if let index = gameModels.firstIndex(where: { $0.text == question.text } ) { // find index
                if index < (gameModels.count - 1) { // if the index is the last index in the array
                    let nextQuestion = gameModels[index+1]
                    currentQuestion = nil
                    configureUI(question: nextQuestion)
                    table.reloadData()
                } else {
                    // end game
                    let alert = UIAlertController(title: "Level 1 complete", message: "Continue to next level", preferredStyle: .alert)
                               alert.addAction(UIAlertAction(title: "dismiss", style: .cancel, handler: nil))
                               present(alert, animated: true)
                }
            }
        } else {
            // wrong answer
            let alert = UIAlertController(title: "incorrect", message: "Incorrect Answer", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "dismiss", style: .cancel, handler: nil))
            present(alert, animated: true)
        }
    }
}
struct Question {
    let text: String
    let answers: [Answer]
}

struct Answer {
    let text: String
    let correct: Bool //true or false
}
