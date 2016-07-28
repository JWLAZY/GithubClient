//
//  GitHubAPI.swift
//  YZGithub
//
//  Created by 郑建文 on 16/7/24.
//  Copyright © 2016年 Zheng. All rights reserved.
//

import UIKit
import Moya
import Alamofire


typealias SuccessClosure = (result: AnyObject) -> Void
typealias failClosure = (errorMsg:String?) -> Void


// (Endpoint<Target>, NSURLRequest -> Void) -> Void
func endpointResolver() -> MoyaProvider<GitHubAPI>.RequestClosure {
    return { (endpoint, closure) in
        let request: NSMutableURLRequest = endpoint.urlRequest.mutableCopy() as! NSMutableURLRequest
        request.HTTPShouldHandleCookies = false
        closure(request)
    }
}

class GitHupPorvider<Target where Target: TargetType>: MoyaProvider<Target> {
    
    override init(endpointClosure: EndpointClosure = MoyaProvider.DefaultEndpointMapping,
                  requestClosure: RequestClosure = MoyaProvider.DefaultRequestMapping,
                  stubClosure: StubClosure = MoyaProvider.NeverStub,
                  manager: Manager = Manager.sharedInstance,
                  plugins: [PluginType] = []) {
        super.init(endpointClosure: endpointClosure, requestClosure: requestClosure, stubClosure: stubClosure, manager: manager, plugins: plugins)
    }
}


struct Provider {
    
    private static var endpointsClosure = { (target: GitHubAPI) -> Endpoint<GitHubAPI> in
        
        var endpoint: Endpoint<GitHubAPI> = Endpoint<GitHubAPI>(URL: url(target), sampleResponseClosure: {.NetworkResponse(200, target.sampleData)}, method: target.method, parameters: target.parameters)
        // Sign all non-XApp token requests
        
        switch target {
            
        default:
            print("current token:\( AppToken.shareInstance.access_token!)")
            endpoint.endpointByAddingHTTPHeaderFields(["User-Agent":"YZGithub"])
            
            return endpoint.endpointByAddingHTTPHeaderFields(["Authorization": AppToken.shareInstance.access_token ?? ""])
        }
    }

    
    static func DefaultProvider() -> GitHupPorvider<GitHubAPI> {
        return GitHupPorvider(endpointClosure: endpointsClosure, requestClosure: endpointResolver(), stubClosure:MoyaProvider.NeverStub , manager: Alamofire.Manager.sharedInstance, plugins:[])
    }
    private struct SharedProvider {
        static var instance = Provider.DefaultProvider()
    }

    
    static var sharedProvider:GitHupPorvider<GitHubAPI> {
        
        get {
            return SharedProvider.instance
        }
        
        set (newSharedProvider) {
            SharedProvider.instance = newSharedProvider
        }
        
    }
}

public enum GitHubAPI {
    //user
    case MyInfo
    case UserInfo(username:String)
    case UpdateUserInfo(name:String, email:String, blog:String, company:String, location:String,hireable:String,bio:String)
    case AllUsers(page:Int,perpage:Int)
    
    //trending
    case TrendingRepos(since:String,language:String)
    case TrendingShowcases()
    case TrendingShowcase(showcase:String)

    //repository
    case MyRepos(type:String, sort:String ,direction:String)
    case UserRepos( username:String ,page:Int,perpage:Int,type:String, sort:String ,direction:String)
    case OrgRepos(type:String, organization:String)
    case PubRepos(page:Int,perpage:Int)
    case UserSomeRepo(owner:String, repo:String)
    
    //search
    case SearchUsers(para:ParaSearchUser)
//    case SearchRepos(para:ParaSearchRepos)

}

extension GitHubAPI: TargetType {
    
    public var baseURL: NSURL{
        switch self {
        case .TrendingRepos:
            return NSURL(string: "http://trending.codehub-app.com/v2")!
        case .TrendingShowcases:
            return NSURL(string: "http://trending.codehub-app.com/v2")!
        case .TrendingShowcase:
            return NSURL(string: "http://trending.codehub-app.com/v2")!
        default:
            return NSURL(string: "https://api.github.com")!
        }

    }
    public var path: String {
        switch self {
        //user
        case .MyInfo:
            return "/user"
        case .UserInfo(let username):
            return "/users/\(username)"
        case .UpdateUserInfo:
            return "/user"
        case AllUsers(_,_):
            return "/users"
            
        //trending
        case TrendingRepos:
            return "/trending"
        case TrendingShowcases:
            return "/showcases"
        case TrendingShowcase(let showcase):
            return "/showcases/\(showcase)"
        
        //repos
        case MyRepos:
            return "/user/repos"
        case UserRepos(let username,_,_,_,_,_):
            return "/users/\(username)/repos"
            
        case OrgRepos(_ ,let organization):
            return "/orgs/\(organization)/repos"
        case PubRepos:
            return "/repositories"
        case UserSomeRepo(let owner,let repo):
            return "/repos/\(owner)/\(repo)"
            
        //search
        case SearchUsers:
            return "/search/users"
//        case SearchRepos:
//            return "/search/repositories"
        }
    }
    public var method: Moya.Method{
        switch self {
        case .UpdateUserInfo:
            return .PATCH
            //user email
//        case .AddEmail:
//            return .POST
//        case .DelEmail:
//            return .DELETE
       

        default:
            return .GET
        }
    }
    public var parameters: [String : AnyObject]?{
        switch self {
        
        case SearchUsers(let para):
            return [
                "q":para.q,
                "sort":para.sort,
                "order":para.order,
                "page":para.page,
                "per_page":para.perPage,
            ]
        case MyRepos(let type, let sort ,let direction):
            return [
                "type":type,
                "sort":sort,
                "direction":direction
            ]
        case UserRepos(_,let page, let perpage,let type, let sort ,let direction):
            return [
                "page":page,
                "per_page":perpage,
                "type":type,
                "sort":sort,
                "direction":direction
            ]
        case OrgRepos(let type, _):
            return [
                "type":type,
            ]
        case PubRepos(let page, let perpage):
            return [
                "page":page,
                "per_page":perpage
            ]
        default:
            return nil
        }
    }
    public var sampleData: NSData{
        switch self {
        case .MyInfo:
            return "get user info.".dataUsingEncoding(NSUTF8StringEncoding)!
//        case .MyRepos:
//            return "get user repos.".dataUsingEncoding(NSUTF8StringEncoding)!
            
        default :
            return "default".dataUsingEncoding(NSUTF8StringEncoding)!
        }

    }
}
// MARK: - Provider support
private extension String {
    var URLEscapedString: String {
        return self.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLHostAllowedCharacterSet())!
    }
}

public func url(route: TargetType) -> String {
    print("api:\(route.baseURL.URLByAppendingPathComponent(route.path).absoluteString)")
    return route.baseURL.URLByAppendingPathComponent(route.path).absoluteString
}
