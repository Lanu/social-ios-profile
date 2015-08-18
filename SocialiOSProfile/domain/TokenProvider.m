//
//  TokenProvider.m
//  SocialiOSProfile
//
//  Created by Banu on 18/08/15.
//  Copyright (c) 2015 AIM Productions. All rights reserved.
//

#import "TokenProvider.h"
#import "JSONConsts.h"
#import "SocialUtils.h"
#import "PJSONConsts.h"

@implementation TokenProvider

@synthesize provider, profileId, accessToken;


- (id)initWithProvider:(Provider)oProvider
          andProfileId:(NSString *)oProfileId
           andAccessToken:(NSString *)oAccessToken {
    
    if (self = [super init]) {
        provider = oProvider;
        self.profileId = oProfileId;
        self.accessToken = oAccessToken;    }
    
    return self;
}

- (id)initWithDictionary:(NSDictionary *)dict {
    if (self = [super init]) {
        provider = [UserProfileUtils providerStringToEnum:[dict objectForKey:UP_PROVIDER]];
        self.profileId = [dict objectForKey:UP_PROFILEID];
        self.accessToken = [dict objectForKey:UP_ACCESS_TOKEN];
    }
    
    return self;
}

- (NSDictionary*)toDictionary {
    return [[NSDictionary alloc] initWithObjectsAndKeys:
            [SocialUtils getClassName:self], SOCIAL_CLASSNAME,
            [UserProfileUtils providerEnumToString:self.provider], UP_PROVIDER,
            (self.profileId ?: [NSNull null]), UP_PROFILEID,
            (self.accessToken ?: [NSNull null]), UP_ACCESS_TOKEN,
            nil];
}

@end
