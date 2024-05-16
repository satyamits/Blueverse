



import Foundation
import FoxAPIKit

public enum WalletHistoryRouter: BaseRouter {
    case fetchMachineBalances(params: [String: Any])
    
    public var method: HTTPMethod {
        switch self {
        case .fetchMachineBalances:
            return .post
        }
    }
    public var path: String {
        switch self {
        case .fetchMachineBalances:
            return "/machineWallet/dealer/machineAllbalance"
        }
    }
    public var params: [String: Any] {
        switch self {
        case .fetchMachineBalances(let params):
            return params
        }
    }
    
    public var keypathToMap: String? {
        switch self {
        default:
            return "data"
        }
    }
}
