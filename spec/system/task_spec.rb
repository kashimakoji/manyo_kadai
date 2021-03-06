require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  let!(:user) { FactoryBot.create(:user) } #, name: 'アドミンユーザーA', email: 'admin@a.com') }
  let!(:user_b) { FactoryBot.create(:user_b) }
  
  let!(:task) { FactoryBot.create(:task, user: user) }
  let!(:task_2) { FactoryBot.create(:task_2, user: user_b) }
  let!(:task_3) { FactoryBot.create(:task_3, user: user) }
  let!(:task_4) { FactoryBot.create(:task_4, user: user) }
  let!(:task_5) { FactoryBot.create(:task_5, user: user_b) }
  # @user_a = FactoryBot.create(:user, name: 'ユーザーA', email: 'user_a@test.com')
  before do
    visit new_session_path
    fill_in 'メールアドレス', with: login_user.email
    fill_in 'パスワード', with: login_user.password
    click_on 'ログインする'
  end

  describe '新規作成機能' do
    # before do
    #   visit new_session_path
    #   fill_in 'メールアドレス', with: login_user.email
    #   fill_in 'パスワード', with: login_user.password
    #   click_on 'ログインする'
    # end

    context '新規作成した場合' do
      let(:login_user) { user }

      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in 'タスク名称', with: 'タスクネーム1'
        fill_in '詳しい内容', with: 'コンテンツ1'
        fill_in '終了期限', with: Time.now
        select '完了', from: 'ステータス'
        select '中', from: '優先順位'
        click_on "登録する"
        expect(page).to have_content '登録しました'
      end
    end
  end

  describe '一覧表示機能' do
   let(:login_user) { user }

    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        visit tasks_path
        expect(page).to have_content 'タスクネーム1'
      end
    end

    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しく作成されたタスクが一番上に表示される' do
        task_list = all('.task_body')
        expect(task_list[0]).to have_content 'タスクネーム1'
      end
    end

    context 'タスクの終了期限が降順に並んでいる場合' do
      it '終了期限が後のタスクが一番上に表示される' do
        sleep 0.5
        click_on "終了期限"
        sleep 0.5
        task_list = all('.task_body')
        expect(task_list[0]).to have_content '2021/10/04'
        expect(task_list[1]).to have_content '2021/10/03'
        expect(task_list[2]).to have_content '2021/10/01'
      end
    end

    context 'タスクの優先順位が降順に並んでいる場合' do
      it '優先順位が高いタスクが一番上に表示される' do
        sleep 0.5
        click_on "優先順位"
        sleep 0.5
        task_list = all('.task_body')
        #binding.irb
        expect(task_list[0]).to have_content '高'
        expect(task_list[1]).to have_content '中'
        expect(task_list[2]).to have_content '低'
      end
    end
  end

  describe '詳細表示機能' do
    let(:login_user) { user }

      context '任意のタスク詳細画面に遷移した場合' do
        it '該当タスクの内容が表示される' do
          visit tasks_path(user)
          all('tbody td')[6].click_on '詳細'
          expect(page).to have_content 'テストタスクネーム4'
        end
      end
  end

  describe '検索機能' do
    let(:login_user) { user }
    before do
      visit tasks_path
    end

    context 'タイトルで曖昧検索をした場合' do
      it "検索キーワードを含むタスクで絞り込まれる" do
        fill_in 'search', with: 'タスクネーム1'
        click_on '検索'
        expect(page).to have_content 'タスクネーム1'
      end
    end
    context 'ステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        select '完了', from: 'status'
        click_on '検索'
        expect(page).to have_content '完了'
      end
    end
    context 'タイトル曖昧検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスクが絞り込まれる" do
        fill_in 'search', with: 'タスクネーム1'
        select '完了', from: 'status'
        click_on '検索'
        expect(page).to have_content '完了'
        expect(page).to have_content 'タスクネーム1'
      end
    end

  end

end
