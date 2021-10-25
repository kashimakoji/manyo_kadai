|Label            |Labeling    |Task            |User                  |
|  ----           |  ----      |  ----          |  ----                |
|label_name:string|task_id(FK) |user_id(FK)     |admin:boolean         |
|                 |label_id(FK)|task_name:string|user:string           |
|                 |            |content:text    |email:string          |
|                 |            |end_time:datetime        |passwork_digest:string|
|			|			|	created_at:datetime	|			|
|  |  |status:integer  |  |
|  |  |priority:integer    |  |

# heroku 設定
#### 設定
```
$ heroku login
$ heroku create
```

#### アセットコンパイル -> Railsアプリの*app/assets/*以下の総称
	本番環境で実行できる形式に変換すること。
`$ rails assets:precompile RAILS_ENV=production`

#### Gemの`ruby '2.6.5'`をコメントアウト `bundle install`

#### Herokuアプリアドレス
https://アプリ名.herokuapp.com/
``` アプリ名確認 =><=の中
$ heroku config
=== dry-ravine-01039 Config Vars

https://dry-ravine-01039.herokuapp.com/
https://git.heroku.com/dry-ravine-01039.git
```


#### Gitと紐づいているか確認
```
$ git remote -v
heroku  https://git.heroku.com/<HerokuAppName>.git (fetch)
heroku  https://git.heroku.com/<HerokuAppName>.git (push)
```

#### Heroku buildpackの追加
	作成したアプリをHeroku上でコンパイルするためのもの
```
$ heroku buildpacks:set heroku/ruby
$ heroku buildpacks:add --index 1 heroku/nodejs
```

### Herokuにデプロイする
```
$ git push heroku master
```

### データベースの移行
```
$ heroku run rails db:migrate
```

アプリにアクセス
https://serene-atoll-43446.herokuapp.com/
