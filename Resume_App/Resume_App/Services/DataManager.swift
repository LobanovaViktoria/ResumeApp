import UIKit

class DataManager {
    
    static let shared = DataManager()
    
    var avatar: UIImage? = {
        let image = UIImage(named: "avatar")
        return image
    }()
    
    var userName: String {
        "Лобанова Виктория Александровна"
    }
    
    var level: String {
        "Intern IOS developer"
    }
    
    var location: String {
        "Воронеж"
    }
    
    var skills: [String] {
        // Load from user defaults
        return []
    }
    
    var aboutMe: String {
        "Intern, no work experience. Completed an online course on the iOS developer program on the Yandex Practicum platform in 2023"
    }
    
    func save(skills: [String]) {
        // Save to UD
    }
    
}
