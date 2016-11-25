//
//  EventCell.swift
//  YZGithub
//
//  Created by 郑建文 on 16/8/24.
//  Copyright © 2016年 Zheng. All rights reserved.
//

import UIKit
import Kingfisher
import SwiftDate

class EventCell: BaseCell {

    @IBOutlet weak var eventOwnerAvator: UIImageView!
    @IBOutlet weak var eventLabel: UITextView!
    @IBOutlet weak var EventInfo: UILabel!
    @IBOutlet weak var createTime: UILabel!
    @IBOutlet weak var eventTypeImage: UIImageView!
    
    override func setModel<T>(_ model: T) {
        let event = model as? Event
        if let e = event {
            if let url = e.actor?.avatar_url {
                self.eventOwnerAvator.kf.setImage(with: URL(string: url)!, placeholder: UIImage(named: "empty_failed"))
            }
            if let date = e.created_at {
//                self.createTime.text = (date.date(format: DateFormat.iso8601)?.toRelativeString(abbreviated:false, maxUnits:1))! + " age"
            }
             self.EventInfo.text = ""
            if let type = e.type {
                switch type {
                case .IssueCommentEvent:
                    self.eventTypeImage.image = UIImage(named: "octicon_comment_15")
                    guard let dic = e.payload?["comment"] as? [String:Any] ,let body = dic["body"] else {
                        break;
                    }
                    var text = (body as? String)?.replacingOccurrences(of: " ", with: "")
                    text = text?.replacingOccurrences(of: "\n", with: "")
                    text = text?.replacingOccurrences(of: "\r", with: "")
                    self.EventInfo.text = text
                case .PullRequestEvent:
                    self.eventTypeImage.image = UIImage(named: "octicon_pull_request_25")
                case .WatchEvent:
                    self.eventTypeImage.image = UIImage(named: "octicon_star_20")
                case .CreateEvent:
                    self.eventTypeImage.image = UIImage(named: "octicon_repo_15")
                case .PushEvent:
                    self.eventTypeImage.image = UIImage(named: "octicon_push_25")
                    let commit =  (e.payload!["commits"] as! [AnyObject])[0] as? [String:AnyObject?]
                    if let commit = commit {
                            self.EventInfo.text = commit["message"]! as? String
                    }
                case .ForkEvent:
                    self.eventTypeImage.image = UIImage(named: "octicon_fork_20")
                }
            }
            generateEvent(e)
        }
    }
    func generateEvent(_ e:Event) {
        if let type = e.type {
            var eventinfo:NSMutableAttributedString?
            self.eventLabel.attributedText = NSMutableAttributedString (string: "")
            var info = ""
            if let name = e.actor?.login{
                var  linkArray = [String:String]()
                    switch type {
                    case .IssueCommentEvent:
                            info  =   name  + "  " + (e.payload?["action"] as! String) + " issue  " + (e.repo?.name)!
                    case .PullRequestEvent:
                            info  = name  + "  " + (e.payload?["action"] as! String) + " pull request  " + (e.repo?.name)!                        
                    case .WatchEvent:
                            info = name  + "  " + (e.payload?["action"] as! String) + "  " + (e.repo?.name)!                        
                    case .CreateEvent:
                            info = name  + "  created " + (e.payload?["ref_type"] as! String) + "  " + (e.repo?.name)!                        
                    case .PushEvent:
                            info = name  + "  pushed to  " + (e.payload?["ref"] as! String) + " at  " + (e.repo?.name)!
                    case .ForkEvent:
                        guard let forkRepo = e.payload?["forkee"] as? [String:Any], let fullName = forkRepo["full_name"] as? String else {
                            info = name  + " forked " + (e.repo?.name)!
                            break;
                        }
                        info = name  + " forked " + (e.repo?.name)! + " to  \(fullName)"
                        linkArray[fullName] =  "/repos/\(fullName)"
                    }
                eventinfo = NSMutableAttributedString(string:info, attributes: [:])
                eventinfo?.linkWithString(name,inString: info,url: "/user/\(name)")
                let urlstart = e.repo?.url?.range(of: "/repos")?.lowerBound
                let url = e.repo?.url?.substring(from: urlstart!)
                eventinfo?.linkWithString((e.repo?.name)!,inString: info,url: url!)
                
                for (string,url) in linkArray {
                        eventinfo?.linkWithString(string, inString: info, url: url)
                }
                
            }
            if   let temp = eventinfo {
                self.eventLabel.attributedText = temp
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        eventLabel.delegate = self
        eventLabel.isEditable = false
        eventLabel.isScrollEnabled = false
        eventLabel.textContainerInset = UIEdgeInsetsMake(0, -4, 0, 0)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
extension BaseCell:UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange) -> Bool {
//        let router = Router.sharedInstance
//        router.routeURL(URL.absoluteString) 
        return true
    }
}
