require 'rails_helper'

RSpec.describe 'タスク管理機能', type: :system do
  before do
    FactoryBot.create(:task)
    FactoryBot.create(:second_task)
  end

  describe 'タスク一覧画面' do
    context 'タスクを作成した場合' do
      it '作成済みのタスクが表示されること' do
        visit tasks_path #タスク一覧へ移動
        expect(page).to have_content 'タイトル1' #タスクにタイトル１が含まれているか確認
      end
    end

    context '複数のタスクを作成した場合' do
      it 'タスクが作成日時の降順に並んでいること' do
        visit tasks_path
        task_list = all('.task_list')
        expect(task_list[0]).to have_content 'タイトル2' #タスクが作成日の降順で並んでいるか確認
        expect(task_list[1]).to have_content 'タイトル1'
      end
    end

    context '終了期限で並び替えるを押した場合' do
      it 'タスクの順番が終了期限の降順で表示されること' do
          visit tasks_path
          click_on '終了期限で並び替える', match: :first
          task_limit = all('.task_limit')
          expect(task_limit[0]).to have_content '2020-03-30'#タスクが終了期限の降順で並んでいるか確認
          expect(task_limit[1]).to have_content '2010-03-30'
      end
    end

    context '優先度で並び替えるを押した場合' do
      it 'タスクの順番が優先度の高い順で表示されること' do
        visit tasks_path
        click_on '優先度で並び替える', match: :first
        task_priority = all('.task_priority') #タスク一覧を配列で取得
        expect(task_priority[0]).to have_content '高' #タスクが作成日の降順で並んでいるか確認
        expect(task_priority[1]).to have_content '中'
      end
    end
  end

  describe 'タスク登録画面' do
    context '必要項目を入力して、createボタンを押した場合' do
      it 'データが保存されること' do
        visit new_task_path
        fill_in 'task_title', with: 'タイトル'
        fill_in 'task_content', with: '内容'
        click_on '登録する'
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
