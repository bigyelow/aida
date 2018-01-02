# 嗳嗒（aida）API 文档

## 索引
- [基本规范](https://github.com/bigyelow/aida/blob/master/doc/api.md#基本规范)
- [API](https://github.com/bigyelow/aida/blob/master/doc/api.md#api)
	- [1. 用户相关](https://github.com/bigyelow/aida/blob/master/doc/api.md#1-用户相关)
		- [注册](https://github.com/bigyelow/aida/blob/master/doc/api.md#注册)
		- [登录](https://github.com/bigyelow/aida/blob/master/doc/api.md#登录)
	- [2. 答题模块](https://github.com/bigyelow/aida/blob/master/doc/api.md#2-答题模块)
	- [3. 排行榜](https://github.com/bigyelow/aida/blob/master/doc/api.md#3-排行榜)
- [Model](https://github.com/bigyelow/aida/blob/master/doc/api.md#model)
	- [1. 用户相关](https://github.com/bigyelow/aida/blob/master/doc/api.md#1-用户相关-1)
	- [2. 题目相关](https://github.com/bigyelow/aida/blob/master/doc/api.md#2-题目相关)


## 基本规范

- base url: xxx.com/aida/
- 带登录信息的 api 请求示例：

```
{
    "Accept-Language" = "en;q=1";
    Authorization = "Bearer bd6f092a52787d5f384d1b7ef769781d";
    "User-Agent" = "api-client/0.1.3 com.douban.frodo/5.15.0 iOS/11.2 x86_64 network/wifi";
}
```
- `get` 请求，`parameters` 在 `request url` 的 `query` 中
	- 例如：`xxx.com/aida/get_verification_code?phone=yyy`
- `post` 请求， `parameters` 在 `body` 中

## API

### 1. 用户相关
#### 注册

- 0.1.0 只支持使用手机号注册、登录
- 注册分为两步
	1. 输入手机号，通过短信获取验证码
	2. 使用验证码获取 `OAuth`
	3. 使用 `token` 注册用户，带着 `password`

```
1. 获取验证码
get verification_code

parameter:
{
phone: String
}

response: nil

2. 使用验证码获取 OAuth
post auth2/verification_code

parameters:
{
phone: String,
verification_code: String,
}

response: OAuth

3. 使用上面的 OAuth
post auth2/registeration

@require_login
parameters:
{
password: String（必须）
}

```

#### 登录
- 登录分为两步
	1. 根据输入的手机号、密码获取 `OAuth`
	2. 根据得到的 `OAuth` 获取用户信息

```
1.获取 `OAuth`
post auth2/token

parameters:
{
phone: String,
password: String,
}

response: OAuth

2.根据 `OAuth` 获取用户信息
get user/:id

parameters: nil

response: User
```

### 2. 答题模块
#### 获取当前合集

```
服务器根据请求到达的时间，返回对应时间段的 QuestionSet

get question_set

parameters: nil

response: QuestionSet
```

#### 完成题目

```
post complete_question_set

parameters:
{
question_set_id: String,
right_questions: id1|id2|..., (答对的题目，使用 | 分隔)
got_point: Int, (获取的分数)
}

response: nil

```

### 3. 排行榜
#### 获取排行榜，支持分页
```
get user_rank_list

parameters:
{
start: Int
count: Int
}

response:
{
total: Int
count: Int
start: Int
user: [User]
}
```

## Model
### 1. 用户相关
#### `OAuth`

```
{
    "access_token": String = 9297c93746e40d09b7c75ba5d4ac271b;
    "user_id": String = 76904207;
    "user_name": String = DAO;(可为空)
    "expires_in": Int = 604799;
    "phone": String = 15201305642
    "refresh_token": String = b5ed1c044b43585721c7540ce1ca0905;
}
```

#### `User`

```
{
id: String,
name: String,
point: Int,（积分）
avatar: String, (头像链接)
phone: String,
}
```

### 2. 题目相关
#### 题目类型 `QuestionType`
- 目前支持单选、多选两种类型

```
0：单选
1：多选
```

#### 单个答案 `Answer`
```
{
id: String,
refer_id: String,（对应的 Question 的 id）
type: QuestionType
value: [String]，（答案数组，对于单选只有一个元素。值为对应 QuestionOption 的 id）
}
```
#### 题目选项 `QuestionOption`
```
{
id: String,
refer_id: String,(对应的 Question 的 id）
text: String,（问题选项的描述）
}
```

#### 单个题目 `Question`
- 暂时只支持文本题目

```
{
id: String,
title: String,
description: String,
time_limit: Int（限时，单位为秒）,
index: Int（是当前合集的第几题）,
type: QuestionType,
answer: Answer,
options: [QuestionOption],
point: Int, (一个题目对应的分数)
}

```

#### 题目合集 `QuestionSet`
```
{
id: String,
start_time: String, (`yyyy-MM-dd HH:mm:ss`)
end_time: String, (`yyyy-MM-dd HH:mm:ss`)
questions: [Question],
}
```
