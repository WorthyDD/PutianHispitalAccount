//
//  ViewController.m
//  莆田医院名单
//
//  Created by 武淅 段 on 16/5/20.
//  Copyright © 2016年 武淅 段. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>

@property (nonatomic) NSArray *hispitalArray;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) UISearchBar *searchBar;
@property (nonatomic) NSArray *searchArr;
@property (nonatomic, assign) BOOL isInSearching;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 36)];
    self.navigationItem.titleView = _searchBar;
    _searchBar.delegate  = self;
    [_searchBar setPlaceholder:@"请输入需要检索的医院"];
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    [self readTxt];
    [self.tableView reloadData];
}


- (void) readTxt
{
    NSMutableArray *arr = [NSMutableArray new];
    NSMutableDictionary *dic;
    NSMutableArray *subArr;
   
    NSString *path = [[NSBundle mainBundle] pathForResource:@"f" ofType:@"txt"];
    NSError *error;
    NSString *contents = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    
    NSArray *lines = [contents componentsSeparatedByString:@"\n"];
    
    NSLog(@"Number of lines in the file:%ld", [lines count] );
    
    for(NSString *str in lines){
//        NSLog(@"%@\n", str);
        if(str.length>0 && [str hasPrefix:@"#"]){
            dic = [NSMutableDictionary new];
            [dic setObject:[str substringFromIndex:1] forKey:@"name"];
            subArr = [NSMutableArray new];
            [dic setObject:subArr forKey:@"hispitals"];
            [arr addObject:dic];
        }
        else if(str.length>0){
            [subArr addObject:str];
        }
    }
    
    for(NSDictionary *dic in arr){
        NSString *name = [dic objectForKey:@"name"];
        
        NSLog(@"\n\n%@\n", name);
        NSArray *hispitals = [dic objectForKey:@"hispitals"];
        for (NSString *his in hispitals){
            NSLog(@"%@\n", his);
        }
    }
    
    _hispitalArray = arr;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(_isInSearching){
        return 1;
    }
    return _hispitalArray.count;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(_isInSearching){
        return _searchArr.count;
    }
    NSDictionary *dic = _hispitalArray[section];
    NSArray *arr = [dic objectForKey:@"hispitals"];
    return arr.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    if(_isInSearching){
        NSString *str = _searchArr[indexPath.row];
        [cell.textLabel setText:str];
    }
    else{
        NSDictionary *dic = _hispitalArray[indexPath.section];
        NSArray *arr = [dic objectForKey:@"hispitals"];
        NSString *name = arr[indexPath.row];
        [cell.textLabel setText:name];
    }
    return cell;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(!_isInSearching){
        NSDictionary *dic = _hispitalArray[section];
        NSString *name = [dic objectForKey:@"name"];
        return name;
    }
    else{
        return @"搜索结果";
    }
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if(searchText.length>0){
        
        _isInSearching = YES;
        NSMutableArray *result = [NSMutableArray new];
        for(NSDictionary *dic in _hispitalArray){
            NSArray *arr = [dic objectForKey:@"hispitals"];
            for(NSString *str in arr){
                if([str containsString:searchText]){
                    [result addObject:str];
                }
            }
            
        }
        
        _searchArr = result;
    }
    else{
        _isInSearching = NO;
    }
    
    [_tableView reloadData];
}

@end
