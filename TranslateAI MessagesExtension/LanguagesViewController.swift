//
//  LanguagesViewController.swift
//  Translate
//
//  Created by Gabriel Theodoropoulos.
//  Copyright © 2019 Appcoda. All rights reserved.
//

import UIKit

class LanguagesViewController: UIViewController {

    // MARK: - IBOutlet Properties
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var languageSearch: UITextField!
    
    // MARK: - Properties
    
    var alertCollection: GTAlertCollection!
    
    
    
    // MARK: - Default Methods
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        alertCollection = GTAlertCollection(withHostViewController: self)
        configureTableView()
    }
    
    
    deinit {
        alertCollection = nil
    }
    
    
    
    
    // MARK: - Custom Methods
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = true
        tableView.showsHorizontalScrollIndicator = false
        tableView.backgroundColor = UIColor.clear
        tableView.isScrollEnabled = true
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.register(UINib(nibName: "LanguageCell", bundle: nil), forCellReuseIdentifier: "idLanguageCell")
    }
    
    func fetchSupportedLanguages() {
        // Show a "Please wait..." alert.
        alertCollection.presentActivityAlert(withTitle: "Supported Languages", message: "Please wait while translation supported languages are being fetched...") { (presented) in
     
            if presented {
                TranslationManager.shared.fetchSupportedLanguages(completion: { (success) in
                    // Dismiss the alert.
                    self.alertCollection.dismissAlert(completion: nil)
     
                    // Check if supported languages were fetched successfully or not.
                    if success {
                        // Display languages in the tableview.
                        DispatchQueue.main.async { [unowned self] in
                            self.tableView.reloadData()
                        }
                    } else {
                        // Show an alert saying that something went wrong.
                        self.alertCollection.presentSingleButtonAlert(withTitle: "Supported Languages", message: "Oops! It seems that something went wrong and supported languages cannot be fetched.", buttonTitle: "OK", actionHandler: {
     
                        })
                    }
     
                })
            }
     
        }
    }
 func checkForLanguagesExistence() {
     // Check if supported languages have been fetched by looking at the
     // number of items in the supported languages collection of the
     // TranslationManager shared instance.
     // If it's zero, no languages have been fetched, so ask user
     // if they want to fetch them now.
     if TranslationManager.shared.supportedLanguages.count == 0 {
//         alertCollection.presentAlert(withTitle: "Supported Languages", message: "It seems that supported languages for translation have not been fetched yet. Would you like to get them now?", buttonTitles: ["Yes, fetch supported languages", "Not now"], cancelButtonIndex: 1, destructiveButtonIndices: nil) { (actionIndex) in
//
             // Check if user wants to fetch supported languages.
////             if actionIndex == 0 {
                 self.fetchSupportedLanguages()
////             }
         }
     }
// }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
     
        checkForLanguagesExistence()
    }
    
    //allows for language search
    @IBAction func searchLanguage(_ sender: Any) {
     
        //holds the value of translationMangers number of elements
        
        //first finds the length of supportedLanguages (changes every time the code runs so need a pretermined value
        let temporaryNum: Int = TranslationManager.shared.supportedLanguages.count
        
        //for loop running through the entire array supportedLanguages, goes in reverse so removing elements is not a problem
        for n in (0..<temporaryNum).reversed(){
            
            //creates a temporary string with the translationManager's supported languages
            guard let temporaryString = TranslationManager.shared.supportedLanguages[n].name
                                     else{ print("this is bad")
                                         return}
//            print("temporary string is \(temporaryString)")
//            print("the languageSearch text is \(languageSearch.text)")
//            print("the languageSearch text is lowercase \(languageSearch.text?.lowercased())")

            //checks if the temporarystring has the search word in it, both lowercased so lowercasing does not impact the results of the check
            if  !( (temporaryString.lowercased().hasPrefix(languageSearch.text?.lowercased() ?? ""))){
           
            //creates an index path with item (row) and section, important for latter
            let indexPath = IndexPath(item: n, section: 0)
                
            //Removes first from the data base the table is based off of, the supportedLanguages
            TranslationManager.shared.supportedLanguages.remove(at: indexPath.row)
            
            //performs the actual row deletion
            tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
//        tableView.numberOfRows(inSection: TranslationManager.shared.supportedLanguages.count-1)

    }
    
}

  



// MARK: - UITableViewDelegate
extension LanguagesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          tableView.cellForRow(at: indexPath)?.setSelected(false, animated: true)
        
          let languageCode  = TranslationManager.shared.supportedLanguages[indexPath.row].code
        defaults.set(languageCode, forKey: "languageCodeKey")

        
        
        self.dismiss(animated: true, completion: nil)
        }
    }




// MARK: - UITableViewDataSource
extension LanguagesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TranslationManager.shared.supportedLanguages.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "idLanguageCell", for: indexPath) as? LanguageCell else { return UITableViewCell() }
        

           let language = TranslationManager.shared.supportedLanguages[indexPath.row]
        
           cell.languageLabel.text = language.name ?? ""
           cell.codeLabel.text = language.code ?? ""
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
}

