//
//  ViewController.swift
//  Silly Song
//
//  Created by Lu Shi on 2017-05-24.
//  Copyright © 2017 lushidea. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var lyricsView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        nameField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func reset(_ sender: Any) {
        self.nameField.text = "";
        self.lyricsView.text = "";
    }
    
    @IBAction func displayLyrics(_ sender: Any) {
        if (self.nameField.text != nil){
            //capitalize first letter
            self.lyricsView.text = lyricsForName(lyricsTemplate: bananaFanaTemplate, fullName: self.nameField.text!)
        }
    }

}


extension ViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}


let vowels: CharacterSet = CharacterSet(charactersIn: "aeiou")
let bananaFanaTemplate = [
    "<FULL_NAME>, <FULL_NAME>, Bo B<SHORT_NAME>",
    "Banana Fana Fo F<SHORT_NAME>",
    "Me My Mo M<SHORT_NAME>",
    "<FULL_NAME>"].joined(separator: "\n")

func shortNameFromName(name: String) -> String{
    var name = name.lowercased()
    let range = name.rangeOfCharacter(from: vowels)
    if range != nil{
        name = name.substring(from: range!.lowerBound)
    }
    return name
}

func lyricsForName(lyricsTemplate: String, fullName: String) -> String{
    let shorName = shortNameFromName(name: fullName)
    var result = lyricsTemplate.replacingOccurrences(of: "<FULL_NAME>", with: fullName)
    result = result.replacingOccurrences(of: "<SHORT_NAME>", with: shorName)
    return result
}

