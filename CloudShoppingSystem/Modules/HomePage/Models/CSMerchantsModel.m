//
//  CSMerchantsModel.m
//  CloudShoppingSystem
//
//  Created by dengyuchi on 2017/7/14.
//  Copyright © 2017年 dengyuchi. All rights reserved.
//

#import "CSMerchantsModel.h"

@implementation CSMerchantsModel

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super initWithDictionary:dictionary];
    if (self) {
        self.customerStatus = [dictionary validValueForKey:@"customerStatus"];
        self.startRentDate = [dictionary validValueForKey:@"startRentDate"];
        self.merchatId = [dictionary validValueForKey:@"id"];
        self.weUsers = [dictionary validValueForKey:@"weUsers"];
        self.customerSource = [dictionary validValueForKey:@"customerSource"];
        self.floorId = [dictionary validValueForKey:@"floorId"];
        self.startRentMoney = [dictionary validValueForKey:@"startRentMoney"];
        self.futurePlan = [dictionary validValueForKey:@"futurePlan"];
        self.endRentMoney = [dictionary validValueForKey:@"endRentMoney"];
        self.address = [dictionary validValueForKey:@"address"];
        self.subject = [dictionary validValueForKey:@"subject"];
        self.merchantsBm = [dictionary validValueForKey:@"merchantsBm"];
        self.merchantsName = [dictionary validValueForKey:@"merchantsName"];
        self.createUserId = [dictionary validValueForKey:@"createUserId"];
        self.progresName = [dictionary validValueForKey:@"progresName"];
        self.rentDate = [dictionary validValueForKey:@"rentDate"];
        self.expectGoal = [dictionary validValueForKey:@"expectGoal"];
        self.flag = [dictionary validValueForKey:@"flag"];
        self.negotiationModel = [dictionary validValueForKey:@"negotiationModel"];
        self.customerStatusName = [dictionary validValueForKey:@"customerStatusName"];
        self.floorName = [dictionary validValueForKey:@"floorName"];
        self.updateTime = [dictionary validValueForKey:@"updateTime"];
        self.units = [dictionary validValueForKey:@"units"];
        self.negotiationDate = [dictionary validValueForKey:@"negotiationDate"];
        self.startRentArea = [dictionary validValueForKey:@"startRentArea"];
        self.code = [dictionary validValueForKey:@"code"];
        self.mallInfoId = [dictionary validValueForKey:@"mallInfoId"];
        self.negotiationProgress = [dictionary validValueForKey:@"negotiationProgress"];
        self.status = [dictionary validValueForKey:@"status"];
        self.otherUsers = [dictionary validValueForKey:@"otherUsers"];
        self.nextGoal = [dictionary validValueForKey:@"nextGoal"];
        self.flagName = [dictionary validValueForKey:@"flagName"];
        self.performancePrediction = [dictionary validValueForKey:@"performancePrediction"];
        self.content = [dictionary validValueForKey:@"content"];
        self.brands = [dictionary validValueForKey:@"brands"];
        self.mallInfoName = [dictionary validValueForKey:@"mallInfoName"];
        self.statusName = [dictionary validValueForKey:@"statusName"];
        self.goodsStructure = [dictionary validValueForKey:@"goodsStructure"];
        self.goalAttainment = [dictionary validValueForKey:@"goalAttainment"];
        self.createTime = [dictionary validValueForKey:@"createTime"];
        self.updateUserId = [dictionary validValueForKey:@"updateUserId"];
        self.updateUserName = [dictionary validValueForKey:@"updateUserName"];
        self.endRentArea = [dictionary validValueForKey:@"endRentArea"];
        self.negotiationModelName = [dictionary validValueForKey:@"negotiationModelName"];
        self.createUserName = [dictionary validValueForKey:@"createUserName"];
        
        
    }
    return self;
}

@end
