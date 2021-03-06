//
//  QuestionTests.m
//  BrowseOverflow
//
//  Created by bmob-LT on 16/4/7.
//  Copyright © 2016年 bmob-LT. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Question.h"
#import "Answer.h"

@interface QuestionTests : XCTestCase

@end

@implementation QuestionTests{
    Question *question;
    Answer *lowScore;
    Answer *highScore;
}

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    question = [[Question alloc] init];
    question.date = [NSDate distantPast];
    question.title = @"Do iPhones also dream of electric sheep?";
    question.score = 42;
    
    Answer *accepted = [[Answer alloc] init];
    accepted.score = 1;
    accepted.accepted = YES;
    [question addAnswer:accepted];
    
    lowScore = [[Answer alloc] init];
    lowScore.score = -4;
    [question addAnswer:lowScore];
    
    highScore = [[Answer alloc] init];
    highScore.score = 4;
    [question addAnswer:highScore];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    question = nil;
    lowScore = nil;
    highScore = nil;
}


//测试问题是否含有日期值
- (void)testQuestionHasADate{
    NSDate *testDate = [NSDate distantPast];
    question.date = testDate;
    XCTAssertEqualObjects(question.date, testDate,@"Question needs to provide its date");
}

//测试问题是否含score
- (void)testQuestionsKeepScore{
    XCTAssertEqual(question.score, 42,@"Question need a numeric score");
}

//测试问题是否含title
- (void)testQuestionHasATitle{
    XCTAssertEqualObjects(question.title, @"Do iPhones also dream of electric sheep?",@"Question should know its title");
}

//测试是否可以正确添加一个答案
- (void)testQuestionCanHaveAnswersAdded{
    Answer *myAnswer = [[Answer alloc] init];
    XCTAssertNoThrow([question addAnswer:myAnswer],@"Must be able to add answers");
}

//测试被接收的答案是否排在最前面
- (void)testAcceptedAnswerIsFirst{
    XCTAssertTrue([[question.answers objectAtIndex:0] isAccepted],@"Accepted answer comes first");
}

//测试分数高的答案是否排在分数低的前面
- (void)testHighScoreAnswerBeforeLow{
    NSArray *answers = question.answers;
    NSInteger highIndex = [answers indexOfObject:highScore];
    NSInteger lowIndex = [answers indexOfObject:lowScore];
    XCTAssertTrue(highIndex < lowIndex, @"Hight-scoring answer comes first");
}


@end
