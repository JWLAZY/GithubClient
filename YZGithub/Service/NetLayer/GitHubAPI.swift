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
import Result

typealias SuccessClosure = (_ result: AnyObject) -> Void
typealias failClosure = (_ errorMsg:String?) -> Void

// (Endpoint<Target>, NSURLRequest -> Void) -> Void
func endpointResolver() -> MoyaProvider<GitHubAPI>.RequestClosure {
    return { (endpoint, closure) in
        var request = endpoint.urlRequest
        request?.httpShouldHandleCookies = false
        closure(Result.success(request!))
    }
}

class GitHupPorvider<Target>: MoyaProvider<Target> where Target: TargetType {
    
    override init(endpointClosure: @escaping (Target) -> Endpoint<Target>, requestClosure: @escaping (Endpoint<Target>, @escaping MoyaProvider<GitHubAPI>.RequestResultClosure) -> Void, stubClosure: @escaping (Target) -> StubBehavior, manager: Manager, plugins: [PluginType], trackInflights: Bool) {
        
        super.init(endpointClosure: endpointClosure, requestClosure: requestClosure, stubClosure: stubClosure, manager: manager, plugins: plugins)
    }
}


struct Provider {
    fileprivate static var endpointsClosure = { (target: GitHubAPI) -> Endpoint<GitHubAPI> in
        var endpoint: Endpoint<GitHubAPI> = Endpoint<GitHubAPI>(URL: url(route: target), sampleResponseClosure: {.networkResponse(200, target.sampleData)}, method: target.method, parameters: target.parameters)
        switch target {
        case GitHubAPI.repoReadme(let owner, let repo):
            endpoint = endpoint.adding(newHttpHeaderFields: ["Content-Type":"application/vnd.github.VERSION.raw"])
            fallthrough
        default:
            endpoint = endpoint.adding(newHttpHeaderFields:["User-Agent":"YZGithub"])
            
            return endpoint.adding(newHttpHeaderFields:["Authorization": AppToken.shareInstance.access_token ?? ""])
        }
    }
    static var sharedProvider:GitHupPorvider<GitHubAPI> =  GitHupPorvider(endpointClosure: endpointsClosure, requestClosure: endpointResolver(), stubClosure: {target in StubBehavior.never}, manager: Alamofire.SessionManager.default, plugins: [], trackInflights: true)
}

public enum GitHubAPI {
    //user
    case myInfo
    case userInfo(username:String)
    case updateUserInfo(name:String, email:String, blog:String, company:String, location:String,hireable:String,bio:String)
    case allUsers(page:Int,perpage:Int)
    
    // users/jianwen-zheng/followers
    case followers(username:String)
    
    //trending
    case trendingRepos(since:String,language:String)
    case trendingShowcases()
    case trendingShowcase(showcase:String)

    //repository
    case myRepos(type:String, sort:String ,direction:String)
    case userRepos( username:String ,page:Int,perpage:Int,type:String, sort:String ,direction:String)
    case orgRepos(type:String, organization:String)
    case pubRepos(page:Int,perpage:Int)
    case userSomeRepo(owner:String, repo:String)
    
    //repository info /repos/:owner/:repo/readme
    case repoReadme(owner:String,repo:String)
    case repoBranchs(owner:String,repo:String)
    case repoPullRequest(owner:String,repo:String)
    
    //message
    case message(page:Int)
    
    //news
    case userEvent(username:String,page:Int)
    
    //search
    case searchUsers(para:ParaSearchUser)
//    case SearchRepos(para:ParaSearchRepos)

}

extension GitHubAPI: TargetType {
    public var baseURL: URL{
        switch self {
        case .trendingRepos:
            return URL(string: "http://trending.codehub-app.com/v2")!
        case .trendingShowcases:
            return URL(string: "http://trending.codehub-app.com/v2")!
        case .trendingShowcase:
            return URL(string: "http://trending.codehub-app.com/v2")!
        default:
            return URL(string: "https://api.github.com")!
        }

    }
    public var path: String {
        switch self {
        //user
        case .myInfo:
            return "/user"
        case .userInfo(let username):
            return "/users/\(username)"
        case .updateUserInfo:
            return "/user"
        case .allUsers(_,_):
            return "/users"
        case .followers(let username):
            return "users/\(username)/followers"
            
        //trending
        case .trendingRepos:
            return "/trending"
        case .trendingShowcases:
            return "/showcases"
        case .trendingShowcase(let showcase):
            return "/showcases/\(showcase)"
        
        //repos
        case .myRepos:
            return "/user/repos"
        case .userRepos(let username,_,_,_,_,_):
            return "/users/\(username)/repos"
            
        case .orgRepos(_ ,let organization):
            return "/orgs/\(organization)/repos"
        case .pubRepos:
            return "/repositories"
        case .userSomeRepo(let owner,let repo):
            return "/repos/\(owner)/\(repo)"
        case .repoReadme(let owner, let repo):
            return "/repos/\(owner)/\(repo)/readme"
        case .repoBranchs(let owner,let repo):
            return "/repos/\(owner)/\(repo)/branches"
        case .repoPullRequest(let owner, let repo):
            return "/repos/\(owner)/\(repo)/pulls"
            
        case .message(_):
            return "/notifications"
        //search
        case .searchUsers:
            return "/search/users"
            
        //news
        case .userEvent(let username,_):
            return "/users/\(username)/received_events/public"
        }
    }
    public var method: Moya.Method{
        switch self {
        case .updateUserInfo:
            return .patch
        default:
            return .get
        }
    }
    public var parameters: [String : Any]?{
        switch self {
        
        case .searchUsers(let para):
            return [
                "q":para.q as AnyObject,
                "sort":para.sort as AnyObject,
                "order":para.order as AnyObject,
                "page":para.page as AnyObject,
                "per_page":para.perPage as AnyObject,
            ]
        case .myRepos(let type, let sort ,let direction):
            return [
                "type":type as AnyObject,
                "sort":sort as AnyObject,
                "direction":direction as AnyObject
            ]
        case .userRepos(_,let page, let perpage,let type, let sort ,let direction):
            return [
                "page":page as AnyObject,
                "per_page":perpage as AnyObject,
                "type":type as AnyObject,
                "sort":sort as AnyObject,
                "direction":direction as AnyObject
            ]
        case .orgRepos(let type, _):
            return [
                "type":type as AnyObject,
            ]
        case .pubRepos(let page, let perpage):
            return [
                "page":page as AnyObject,
                "per_page":perpage as AnyObject
            ]
        case .message(let page):
            return [
                    "all":false as AnyObject, //是否显示所有已读的消息
                    "participating":false as AnyObject,//是否只显示直接参与的消息
                    "page":page as AnyObject
            ]
        case .userEvent( _, let page):
            return [
                    "page":page as AnyObject
            ]
        default:
            return nil
        }
    }
    public var sampleData: Data{
        switch self {
        case .myInfo:
            return "get user info.".data(using: String.Encoding.utf8)!

        default :
            return "default".data(using: String.Encoding.utf8)!
        }

    }
    public var task: Task{
        return Task.request
    }
}
// MARK: - Provider support
private extension String {
    var URLEscapedString: String {
        return self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed)!
    }
}

public func url(route: TargetType) -> String {
    print("api:\(route.baseURL.appendingPathComponent(route.path).absoluteString)")
    return route.baseURL.appendingPathComponent(route.path).absoluteString
}
