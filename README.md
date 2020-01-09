Taskモデル


usersテーブル

| カラム名 | データ型 |
| --- | --- |
| id | integer |
| name | string |
| email | string |
| password_digest | string |

tasksテーブル

| カラム名 | データ型 |
| --- | --- |
| id | integer |
| user_id(FK) | integer |
| label_id(FK) | integer |
| content | text |
| limit | dete |
| priority | string |
| status | string |
| title | string |

labelsテーブル

| カラム名 | データ型 |
| --- | --- |
| id | integer |
| task_id(FK) | integer |
| type | string |

## Herokuへのデプロイ手順
### ①アセットプリコンパイルを行う。
Herokuへデプロイ出来る様に、ファイルを圧縮。

```
rails assets:precompile RAILS_ENV=production
```

### ②Gitへコミット
HerokuへpushするためにGitへcommit。

```
git add --all
```

```
git commit -m 'コメント入力'
```

### ③Herokuへデプロイ
Herokuへプッシュした後は、db:migrateを行う。

```
heroku create
```

```
git push heroku master
```

```
heroku run rails db:migrate
```
