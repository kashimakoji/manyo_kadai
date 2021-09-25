require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do

  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in 'Task名称', with: 'テストタスクネーム'
        fill_in '詳しい内容', with: 'テストコンテント'
        fill_in '終了期限', with: Time.current
        #select '2022', from: 'task_end_time_1i'
        click_on "登録する"
        expect(page).to have_content '登録しました'
      end
    end
  end

  describe '一覧表示機能' do
    before do
      FactoryBot.create(:task)
      FactoryBot.create(:task_2)
      FactoryBot.create(:task_3)
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
        # FactoryBot.create(:task)
        # FactoryBot.create(:task_2)
        # FactoryBot.create(:task_3)
        # visit tasks_path
        task_list = all('.task_body')
        expect(task_list[0]).to have_content 'テストタスクネーム_3'
        expect(task_list[1]).to have_content 'テストタスクネーム_2'
        expect(task_list[2]).to have_content 'テストタスクネーム_1'
      end
    end
    context 'タスクの終了期限が降順に並んでいる場合' do
      it '終了期限が後ろのタスクが一番上に表示される' do
        # FactoryBot.create(:task)
        # FactoryBot.create(:task_2)
        # FactoryBot.create(:task_3)
        # visit tasks_path
        # binding.pry
        click_on "終了期限"
        task_list = all('.task_body')
        # binding.pry
        expect(task_list[0]).to have_content '2021/10/03'
        expect(task_list[1]).to have_content '2021/10/02'
        expect(task_list[2]).to have_content '2021/10/01'
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
end
