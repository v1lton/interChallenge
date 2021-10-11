import Foundation

public class UserCellViewModel {
    let id: Int
    let initialsLabel: String
    let nameLabel: String
    let userNameLabel: String
    let emailLabel: String
    let phoneLabel: String
    
    init(user: User) {
        self.id = user.id
        self.initialsLabel = String(user.name.prefix(2))
        self.nameLabel = user.name
        self.userNameLabel = user.username
        self.emailLabel = user.email
        self.phoneLabel = user.phone
    }
    
}

