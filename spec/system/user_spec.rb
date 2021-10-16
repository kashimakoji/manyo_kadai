require 'rails_helper'
RSpec.describe 'ユーザー登録機能', type: :system do

  let(:user) { FactoryBot.create(:user) }
  let!(:user_b) { FactoryBot.create(:user_b) }
  # let(:task) { FactoryBot.create(:task, user: user) }
  # let(:task2) { FactoryBot.create(:task2, user: user_b)}

  describe '新規ユーザー登録' do
    context 'ユーザーを新規登録した場合' do
      it 'ユーザーが登録される' do
        visit new_user_path
        fill_in '名前', with: '新規ユーザー'
        fill_in 'メールアドレス', with: 'user@test.com'
        fill_in 'パスワード', with: 'password'
        fill_in '確認用パスワード', with: 'password'
        click_on '登録する'
        expect(page).to have_content 'ユーザーを登録しました'
      end
    end

    context 'ログインせずにタスク一覧画面へ飛ぼうとした時' do
      it 'ログイン画面に遷移する' do
        visit tasks_path
        expect(page).to have_content 'ログイン'
      end
    end
  end

  describe 'セッション機能のテスト' do
    # let(:user) { FactoryBot.create(:user) }
    # let(:user_b) { FactoryBot.create(:user_b) }
    before do
      visit new_session_path
      fill_in 'メールアドレス', with: login_user.email
      fill_in 'パスワード', with: login_user.password
      # fill_in 'メールアドレス', with: user.email
      # fill_in 'パスワード', with: user.password
      click_on 'ログインする'
    end

    context 'userでログインする' do
      let(:login_user){ user }

      it 'ログインできること' do
        expect(page).to have_content 'アドミニストレータ'
      end

      it '自分の詳細画面（マイページ）に飛べること' do
        visit user_path(user)
        # uri = URI.parse(current_url)
        # expect(uri.path).to eq(current_path) # eq('/users/' + user.id.to_s)
        expect(page).to have_content 'admin_1@test.com'
      end

      context 'ユーザーが他ユーザーの詳細画面に飛ぶと' do
        it 'タスク一覧画面に遷移する' do
          visit user_path(user)
          # binding.irb
          # visit user_path(user_b)
          # uri = URI.parse(current_url)
          # expect(uri.path).to eq(tasks_path)
          expect(page).to have_content 'タスク一覧'
        end
      end

      it 'ログアウトできること' do
        visit user_path(user)
        click_on 'ログアウト'
        expect(page).to have_content 'ログアウトしました'
      end
    end
  end

  describe '管理画面のテスト' do
    before do
      visit new_session_path
      fill_in 'メールアドレス', with: login_user.email
      fill_in 'パスワード', with: login_user.password
      click_on 'ログインする'
    end

    context 'user(admin)でログインする'
      let(:login_user){ user }

      it '管理ユーザーは管理画面にアクセスできること' do
        click_on 'ユーザー一覧'
        expect(page).to have_content 'ユーザー管理'
      end

      it '管理ユーザーは新規ユーザーが登録できること' do
        visit new_admin_user_path
        fill_in '名前', with: 'テストユーザー'
        fill_in 'メールアドレス', with: 'test_user@test.com'
        fill_in 'パスワード', with: 'aaa'
        fill_in '確認用パスワード', with: 'aaa'
        click_on '登録する'
        expect(page).to have_content '登録しました'
      end

      it '管理ユーザーの詳細画面にアクセスできること' do
        visit admin_user_path(user_b)
        expect(page).to have_content 'bbb2@test.com'
      end

      it '管理ユーザーの編集画面からユーザーを編集できること' do
        visit edit_admin_user_path(user_b)
        fill_in '名前', with: '一般Bの名前を変更'
        fill_in 'パスワード', with: 'a'
        fill_in '確認用パスワード', with: 'a'
        click_on '更新する'
        expect(page).to have_content '更新しました'
      end

      it '管理ユーザーはユーザーの削除をできること' do
        visit admin_users_path(user)
        # click_on '削除', match: :first
        # binding.irb
        all('tbody td')[7].click_on '削除'
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content '削除しました'
      end

    context '一般ユーザーでログインするとき' do
      let(:login_user){ user_b }

      it '一般ユーザーは管理画面にアクセスできないこと' do
        # click_on 'ログアウト'
        # visit new_session_path
        # fill_in 'メールアドレス', with: user_b.email
        # fill_in 'パスワード', with: user_b.password
        # click_on 'ログインする'
        visit user_path(user)
        visit admin_users_path
        # uri = URI.parse(current_url)
        # expect(uri.path).to eq(tasks_path)
        expect(page).to have_content '一般ユーザーは管理画面に入れません'
        # binding.irb
      end
    end

  end

end
