import Foundation

protocol Binding {
    
    associatedtype T
    
    init(viewModel: T)
    
    func initBinding()
}
