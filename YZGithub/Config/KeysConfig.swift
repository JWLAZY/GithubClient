//
//  KeysConfig.swift
//  YZGithub
//
//  Created by 郑建文 on 16/7/13.
//  Copyright © 2016年 Zheng. All rights reserved.
//

import Foundation

public let GithubClientID = "8bea5da7a3e34cd621a6"

public let GithubClientSecret = "df4312673d6b57fd1e6290dcbccea3e7ff227959"

public let GithubRedirectUrl = "https://www.baidu.com"

public let GithubAuthUrl = String(format: "https://github.com/login/oauth/authorize/?client_id=%@&redirect_uri=%@&scope=%@", GithubClientID,GithubRedirectUrl,"user,user:email,user:follow,public_repo,repo,repo_deployment,repo:status,delete_repo,notifications,gist,read:repo_hook,write:repo_hook,admin:repo_hook,admin:org_hook,read:org,write:org,admin:org,read:public_key,write:public_key,admin:public_key")
