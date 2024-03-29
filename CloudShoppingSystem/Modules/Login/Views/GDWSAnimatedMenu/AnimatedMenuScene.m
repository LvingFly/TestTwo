//
//  AnimatedMenuScene.m
//  Party
//
//  Created by Adnan Aftab on 8/25/15.
//  Copyright (c) 2015 CX. All rights reserved.
//

#import "AnimatedMenuScene.h"
#import "MenuItemNode.h"

static NSString *SelectAnimation = @"SelectAction";
static NSString *DeselectAnimation = @"DeselectAnimation";

@interface AnimatedMenuScene()

@property (nonatomic, strong) SKFieldNode *magneticField;
@property (nonatomic, assign) CGPoint startPoint;
@property (nonatomic, assign) NSTimeInterval touchStartTime;
@property (nonatomic, assign) BOOL moving;
@property (nonatomic, strong) SKNode *selectedNode;
@property (nonatomic, strong) NSMutableArray *selectedNodes;

@end

@implementation AnimatedMenuScene
- (instancetype)initWithSize:(CGSize)size
{
    self = [super initWithSize:size];
    if (self)
    {
        
    }
    return self;
}
- (void)didMoveToView:(SKView *)view
{
    [super didMoveToView:view];
    _selectedNodes = [NSMutableArray new];
    [self configure];
}
- (void)configure
{
    self.magneticField = [SKFieldNode radialGravityField];
    self.scaleMode = SKSceneScaleModeAspectFill;
    CGRect frame = self.frame;
    frame.size.width = self.magneticField.minimumRadius;
    frame.origin.x -= frame.size.width/2;
    frame.size.height = frame.size.height;
    frame.origin.y = frame.size.height - frame.size.height;
    self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:frame];
    self.magneticField.position = CGPointMake(frame.size.width/2, frame.size.height / 2);
}
- (void)addChild:(SKNode *)node
{
    
    CGFloat x = (self.frame.size.width / 2 - node.frame.size.width);
    CGFloat y = (self.frame.size.height / 2 - node.frame.size.height);
    
    node.position = CGPointMake(x, y);
    
    if (node.physicsBody == nil)
    {
        node.physicsBody = [SKPhysicsBody bodyWithPolygonFromPath:((SKShapeNode*)node).path];
    }
    
    node.physicsBody.dynamic = YES;//判断物理体是否是运动的
    node.physicsBody.affectedByGravity = NO;
    node.physicsBody.allowsRotation = YES;
    node.physicsBody.mass = 0.3;// 物理质量
    node.physicsBody.friction = 0;
    node.physicsBody.linearDamping = 3;//物体的线性阻尼
    SKRange *xRange = [SKRange rangeWithLowerLimit:10 upperLimit:self.frame.size.width-node.frame.size.width];
    SKRange *yRange = [SKRange rangeWithLowerLimit:10 upperLimit:self.frame.size.height-node.frame.size.height];
    SKConstraint *constraint = [SKConstraint positionX:xRange Y:yRange];
    node.constraints = @[constraint];
    [super addChild:node];
}

- (void)setMenuNodes:(NSArray *)menuNodes withSelectNodes:(NSArray *)selectedNodes
{
    if (_menuNodes)
    {
        [self.children makeObjectsPerformSelector:@selector(removeFromParent)];
    }
    
    _selectedNode = nil;
   [_selectedNodes removeAllObjects];
    _menuNodes = menuNodes;
    [self updateSceneWithSelectedNodes:selectedNodes];
}

- (void)updateSceneWithSelectedNodes:(NSArray *)selectNodes;
{
    for (NSString *nodeTitle in _menuNodes)
    {
        MenuItemNode *menuItem = [MenuItemNode menuNodeWithTitle:nodeTitle];
        [self addChild:menuItem];
        if (selectNodes.count > 0) {
            if ([selectNodes containsObject:nodeTitle]) {
                SKAction *action = [SKAction scaleTo:1.3 duration:0.2];//放大
                [menuItem runAction:action withKey:SelectAnimation];
                [_selectedNodes addObject:menuItem];
            }
        }
    }
}
- (SKNode *)nodeAtPoint:(CGPoint)p
{
    SKNode *node = [super nodeAtPoint:p];
    if (![node.parent isKindOfClass:[SKScene class]] &&
        ![node isKindOfClass:[MenuItemNode class]] &&
        node.parent != nil &&
        !node.userInteractionEnabled)
    {
        node = node.parent;
    }
    return node;
}
- (void)deselectNode:(SKNode*)node
{
    if (!node)
    {
        return;
    }
    [node removeActionForKey:SelectAnimation];
    SKAction *action = [SKAction scaleTo:1 duration:0.2];
    [node runAction:action completion:^{
        //[node removeAllActions];
    }];
    NSInteger index = [self.children indexOfObject:node];
    if(index != NSNotFound)
    {
        [self.animatedSceneDelegate animatedMenuScene:self didDeSelectNodeAtIndex:index];
    }
}
- (void)selectNode:(SKNode*)node
{
    if (!_allowMultipleSelection)
    {
        [self deselectNode:_selectedNode];
        if (_selectedNode == node)
        {
            _selectedNode = nil;
            return;
        }
        _selectedNodes = nil;
    }
    else
    {
        if ([_selectedNodes containsObject:node])
        {
            [self deselectNode:node];
            [_selectedNodes removeObject:node];
            return;
        }
    }
    SKAction *action = [SKAction scaleTo:1.3 duration:0.2];//放大
    [node runAction:action withKey:SelectAnimation];
    if (_allowMultipleSelection)
    {
        [self.selectedNodes addObject:node];
    }
    else
    {
        _selectedNode = node;
    }
    NSInteger index = [self.children indexOfObject:node];
    if (index != NSNotFound)
    {
        [self.animatedSceneDelegate animatedMenuScene:self didSelectNodeAtIndex:index];
    }
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    self.startPoint = [touch locationInNode:self];
    self.touchStartTime = touch.timestamp;
    
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    _moving = YES;
    UITouch *touch = [touches anyObject];
    CGPoint prePoint = [touch previousLocationInNode:self];
    CGPoint point = [touch locationInNode:self];
    
    float dx = point.x - prePoint.x;
    float dy = point.y - prePoint.y;
    
    for (SKNode *node in self.children)
    {
        //二维重力向
        CGVector vector = CGVectorMake(80 * dx, 80 * dy);
        [node.physicsBody applyForce:vector];
    }
    
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchEnd");
   // if (!_moving)
  //  {
        UITouch *touch = [touches anyObject];
        CGPoint location = [touch locationInNode:self];
        SKNode *node = [self nodeAtPoint:location];
        if (node)
        {
            [self selectNode:node];
        }
  //  }
  //  _moving = NO;
}

@end
