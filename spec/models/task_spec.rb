require 'rails_helper'

RSpec.describe 'タスクモデル機能', type: :model do
  let(:user) { FactoryBot.create(:user) }
  # let(:user_b) { FactoryBot.create(:user_b) }

  # let(:task) { FactoryBot.create(:task, user: user) }
  # let(:task_2) { FactoryBot.create(:task_2, user: user_b) }
  # let(:task_3) { FactoryBot.create(:task_3, user: user) }
  # let(:task_4) { FactoryBot.create(:task_4, user: user) }
  # let(:task_5) { FactoryBot.create(:task_5, user: user_b) }

  # before do
  #   FactoryBot.create(:task, user: user)
  #   visit new_session_path
  #   fill_in 'メールアドレス', with: login_user.email
  #   fill_in 'パスワード', with: login_user.password
  #   click_on 'ログインする'
  # end

  describe 'バリデーションのテスト' do
    # before do
    #   FactoryBot.create(:task, user: user)
    #   visit new_session_path
    #   fill_in 'メールアドレス', with: login_user.email
    #   fill_in 'パスワード', with: login_user.password
    #   click_on 'ログインする'
    # end
    # let(:login_user) { user }

    context 'タスクのタイトルが空の場合' do
      # let(:login_user) { user }

      it 'バリデーションにひっかる' do
        task = Task.new(task_name: '', content: '失敗テスト')
        expect(task).not_to be_valid
      end
    end

    context 'タスクの詳細が空の場合' do
      it 'バリデーションにひっかかる' do
        task = Task.new(task_name: 'テスト', content: '')
        expect(task).not_to be_valid
      end
    end

    context 'タスクのタイトルと詳細に内容が記載されている場合' do
      it 'バリデーションが通る' do
        task = Task.new(task_name: 'テスト', content: 'テスト', user: user)
        expect(task).to be_valid
      end
    end
  end

  describe 'タスクモデル機能' do
    let!(:task) { FactoryBot.create(:task, task_name: 'task', status: 0, user: user) }
    let!(:task_2) { FactoryBot.create(:task_2, task_name: 'sample', status: 1, user: user) }
    let!(:task_3) { FactoryBot.create(:task_3, task_name: 'origin', status: 0, user: user) }
    context 'scopeメソッドでタイトルの曖昧検索をした場合' do
      it '検索キーワードを含むタスクが絞り込まれる' do
        expect(Task.word_search('task')).to include(task)
        expect(Task.word_search('task')).not_to include(task_2)
        expect(Task.word_search('task').count).to eq 1
      end
    end
    context 'scopeメソッドでステータス検索をした場合' do
      it 'ステータスに完全一致するタスクが絞り込まれる' do
        expect(Task.status_search(0)).to include(task)
        expect(Task.status_search(0)).not_to include(task_2)
        expect(Task.status_search(0).count).to eq 2
      end
    end
    context 'scopeメソッドでタイトルの曖昧検索とステータス検索をした場合' do
      it '検索キーワードをタイトルに含み、かつステータスに完全一致するタスクが絞り込まれる' do
        expect(Task.word_search('task').status_search(0)).to include(task)
        expect(Task.word_search('task').status_search(0)).not_to include(task_2)
        expect(Task.word_search('task').status_search(0).count).to eq 1
      end
    end
  end
end
