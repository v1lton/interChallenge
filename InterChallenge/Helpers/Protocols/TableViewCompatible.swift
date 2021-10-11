import Foundation

protocol TableViewCompatible {
    
    var reuseIdentifier: String { get }
    
    var error: Observable<Bool> {  get set }
}
