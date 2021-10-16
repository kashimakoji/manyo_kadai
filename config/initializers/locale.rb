I18n.config.available_locales = :ja
I18n.default_locale = :ja

I18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]

Rails.application.config.i18n.default_locale = :ja ##Rail全体を日本語化する場合
Faker::Config.locale = :ja ##Faker単体のみ日本語化する場合
## どちらか片方のみでも設定すれば日本語化できます
