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
