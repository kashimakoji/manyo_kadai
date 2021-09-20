require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in 'Task name', with: 'テストタスクネーム'
        fill_in 'Content', with: 'テストコンテント'
        click_on "登録する"
        expect(page).to have_content '登録しました'
      end
    end
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        task = FactoryBot.create(:task, task_name: 'task')
        visit tasks_path
        #visit(遷移)したpage(タスク一覧ページ)に「task」という文字列が
        #have_content(含まれている)されてるか、ということをexpct(確認・期待)する
        expect(page).to have_content 'task'
      end
    end
  end
  describe '詳細表示機能' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示される' do
         task = FactoryBot.create(:task)
         visit task_path(task.id)
         expect(page).to have_content 'test_task_name'
         binding.irb
       end
     end
  end
end