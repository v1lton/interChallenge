import Foundation

protocol Configurable {
    
    associatedtype T
    
    init(viewModel: T)
}
