//
//  SWAMCModel.m
//  FeiGuangpu
//
//  Created by iBcker on 14-6-28.
//
//

#import "SAATCModel.h"
#import "SWATCModel+AutoCoding.h"

@implementation SAATCModel

-(id)initWithDictionary:(NSDictionary*)dictionary
{
    self = [super init];
    
    if (self && dictionary) {
        
    }
    
    return self;
}

-(id)initWithArray:(NSArray*)array
{
    self = [super init];
    
    if (self && array) {
        
    }
    
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@",[self dictionaryRepresentation]];
}
@end
