require 'rails_helper'

RSpec.describe 'タスク管理機能', type: :system do

  describe 'タスク一覧画面' do
    context 'タスクを作成した場合' do
      it '作成済みのタスクが表示されること' do
        task = FactoryBot.create(:task, title: 'task')
        visit tasks_path
        expect(page).to have_content 'task'
      end
    end
  end

  describe 'タスク登録画面' do
    context '必要項目を入力して、createボタンを押した場合' do
      it 'データが保存されること' do
        visit new_task_path
        fill_in 'task_title', with: 'タイトル'
        fill_in 'task_content', with: '内容'
        click_on 'Create Task'
        expect(page).to have_content 'タイトル'
        expect(page).to have_content '内容'
      end
    end
  end

  describe 'タスク詳細画面' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示されたページに遷移すること' do
         task = FactoryBot.create(:task,
                                   id: 777,
                                   title: 'タイトル',
                                   content: '内容')
        visit task_path(777)
        expect(page).to have_content 'タイトル'
        expect(page).to have_content '内容'
       end
     end
  end
end
