import UIKit

class DataManager {
    
    static let shared = DataManager()
    private let kSkills = "skills"
    
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
        return UserDefaults.standard.array(forKey: kSkills) as? [String] ?? []
    }
    
    var aboutMe: String {
        "Intern, no work experience. Completed an online courses of iOS developer program at Yandex Practicum platform in 2023 Intern, no work experience. Completed an online courses of iOS developer program at Yandex Practicum platform in 2023 Intern, no work experience. Completed an online courses of iOS developer program at Yandex Practicum platform in 2023 Intern, no work experience. Completed an online courses of iOS developer program at Yandex Practicum platform in 2023"
    }
    
    func save(skill: String) {
        let defaults = UserDefaults.standard
        var skills = defaults.array(forKey: kSkills) as? [String] ?? []
        skills.append(skill)
        defaults.set(skills, forKey: kSkills)
        defaults.synchronize()
    }
    
    func remove(skill: String?) {
        guard let skill else {
            return
        }
        let defaults = UserDefaults.standard
        var skills = defaults.array(forKey: kSkills) as? [String] ?? []
        if let index = skills.firstIndex(where: { $0 == skill }) {
            skills.remove(at: index)
        }
        if skills.isEmpty {
            defaults.removeObject(forKey: kSkills)
        } else {
            defaults.set(skills, forKey: kSkills)
        }
        
        defaults.synchronize()
    }
}
