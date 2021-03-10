//
//  ViewController.m
//  pageView
//
//  Created by Stan on 2021/3/10.
//

#import "ViewController.h"

#define w ([UIScreen mainScreen].bounds.size.width)
#define h ([UIScreen mainScreen].bounds.size.height)

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic)UICollectionView *collect;
@property (nonatomic)UIView *tmpVie;
@property (nonatomic)UIView *tmpVie2;
@end



@implementation ViewController
-(UIView *)tmpVie
{
    if (!_tmpVie) {
        _tmpVie = [[UIView alloc] init];
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(10, 0,w-60,400)];
        lab.backgroundColor = UIColor.redColor;
        [_tmpVie addSubview:lab];
    }
    return _tmpVie;
}
-(UIView *)tmpVie2
{
    if (!_tmpVie2) {
        _tmpVie2 = [[UIView alloc] initWithFrame:CGRectZero];
        
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(10, 0,w-60,400)];
        lab.font = [UIFont boldSystemFontOfSize:20];
        lab.backgroundColor = UIColor.redColor;
        [_tmpVie2 addSubview:lab];
        
    }
    return _tmpVie2;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(w-40, 500);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    
    UICollectionView *collect = [[UICollectionView alloc] initWithFrame:CGRectMake(20, 0,w-40, h) collectionViewLayout:layout];
    collect.backgroundColor = UIColor.whiteColor;
    [collect registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    collect.dataSource = self;
    collect.delegate = self;
    collect.pagingEnabled = YES;
    collect.clipsToBounds = NO;
    [self.view addSubview:collect];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *item = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(10, 0,w-60,400)];
    lab.font = [UIFont boldSystemFontOfSize:20];
    [item addSubview:lab];
//    lab.text = [NSString stringWithFormat:@"%lu",indexPath.item];
    lab.backgroundColor = UIColor.redColor;
    return item;
}
- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSArray *indexPaths = [collectionView indexPathsForVisibleItems];
    NSIndexPath *visibleCellIndex = indexPaths.firstObject;
    
    
    UICollectionViewCell *visibleCell = [collectionView visibleCells].firstObject;
    CGRect frame = visibleCell.frame;
    
    if (visibleCellIndex.item-1>=0) {
        CGRect rightItem = CGRectMake(frame.origin.x - frame.size.width, frame.origin.y, frame.size.width, frame.size.height);
        self.tmpVie.frame = rightItem;
        [collectionView addSubview:self.tmpVie];
    }
    
    if (visibleCellIndex.item+1<=10-1) {
        CGRect leftItem = CGRectMake(frame.origin.x + frame.size.width, frame.origin.y, frame.size.width, frame.size.height);
        self.tmpVie2.frame = leftItem;
        [collectionView addSubview:self.tmpVie2];
    }
    
}
@end
