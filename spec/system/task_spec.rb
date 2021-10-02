require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do

  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in 'Task名称', with: 'テストタスクネーム'
        fill_in '詳しい内容', with: 'テストコンテント'
        fill_in '終了期限', with: Time.current
        select '完了', from: 'ステータス'
        select '中', from: '優先順位'
        click_on "登録する"
        expect(page).to have_content '登録しました'
      end
    end
  end

  describe '一覧表示機能' do
    before do
      FactoryBot.create(:task)
      FactoryBot.create(:task_3)
      FactoryBot.create(:task_2)
      visit tasks_path
      #task_list = all('.task_body')
    end
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        task = FactoryBot.create(:task, task_name: 'task')
        visit tasks_path
        expect(page).to have_content 'task'
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しく作成されたタスクが一番上に表示される' do
        task_list = all('.task_body')
        expect(task_list[0]).to have_content 'テストタスクネーム_2'
      end
    end
    context 'タスクの終了期限が降順に並んでいる場合' do
      it '終了期限が後のタスクが一番上に表示される' do
        sleep 0.5
        click_on "終了期限"
        sleep 0.5
        task_list = all('.task_body')
        expect(task_list[0]).to have_content '2021/10/03'
        expect(task_list[1]).to have_content '2021/10/02'
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
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示される' do
         task = FactoryBot.create(:task)
         visit task_path(task.id)
         expect(page).to have_content 'テストタスクネーム_1'
       end
     end
  end

  describe '検索機能' do
    before do
      FactoryBot.create(:task_3)
      FactoryBot.create(:task_2)
      FactoryBot.create(:task)
      visit tasks_path
    end
    context 'タイトルで曖昧検索をした場合' do
      it "検索キーワードを含むタスクで絞り込まれる" do
        fill_in 'search', with: '2'
        click_on '検索'
        expect(page).to have_content '2'
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
        fill_in 'search', with: '2'
        select '完了', from: 'status'
        click_on '検索'
        expect(page).to have_content '完了'
        expect(page).to have_content '2'
      end
    end

  end

end
