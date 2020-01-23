require 'rails_helper'

RSpec.describe 'user', type: :system do
  # before do
  #   FactoryBot.create(:user)
  #   FactoryBot.create(:second_user)
  # end

describe 'ユーザー新規登録画面' do
  context 'ユーザー新規登録をした場合' do
    it 'ユーザーが新規登録されること' do
      visit new_user_path
      fill_in 'user_name', with: '1号'
      fill_in 'user_email', with: 'test100@gmail.com'
      fill_in 'user_password', with: '111111'
      fill_in 'user_password_confirmation', with: '111111'
      click_on 'アカウント作成'
      save_and_open_page
      expect(page).to have_content '1号'
      # expect(page).to have_content 'test10@gmail.com'
    end
  end
end

  describe 'ログアウト' do
    context 'ログアウト' do
      it 'ログアウト' do
        visit new_user_path
        fill_in 'user_name', with: '200号'
        fill_in 'user_email', with: 'test200@gmail.com'
        fill_in 'user_password', with: '111111'
        fill_in 'user_password_confirmation', with: '111111'
        click_on 'アカウント作成'
        save_and_open_page
        expect(page).to have_content '200号'
        visit tasks_path
        click_on 'ログアウト'
        expect(page).to have_content 'ログイン'
      end
    end
  end

  describe 'ログイン' do
    context 'ログイン' do
      before do
        FactoryBot.create(:second_user)
      end
      it 'ログイン' do
        visit new_session_path
        fill_in 'session_email', with: 'test2@gmail.com'
        fill_in 'session_password', with: '222222'
        click_on 'ログインする'
        expect(page).to have_content '2号のページ'
      end
    end
  end

    describe '管理者のユーザー新規登録' do
      before do
        FactoryBot.create(:second_user)
      end
      context '管理者のユーザー新規登録' do
        it '管理者のユーザー新規登録' do
          visit new_session_path
          fill_in 'session_email', with: 'test2@gmail.com'
          fill_in 'session_password', with: '222222'
          click_on 'ログインする'
          save_and_open_page
          expect(page).to have_content 'test2@gmail.com'
          visit new_admin_user_path
          fill_in 'user_name', with: 'sample1'
          fill_in 'user_email', with: 'sample1@gmail.com'
          fill_in 'user_password', with: 'sample1@gmail.com'
          fill_in 'user_password_confirmation', with: 'sample1@gmail.com'
          click_on '登録する'
          expect(page).to have_content 'sample1@gmail.com'
          # expect(page).to have_content '内容'
        end
      end
    end

    describe '非管理者のユーザー新規登録' do
      before do
        FactoryBot.create(:user)
      end
      context '非管理者のユーザー新規登録' do
        it '非管理者のユーザー新規登録' do
          visit new_session_path
          fill_in 'session_email', with: 'test10@gmail.com'
          fill_in 'session_password', with: '111111'
          click_on 'ログインする'
          save_and_open_page
          expect(page).to have_content 'test10@gmail.com'
          visit new_admin_user_path
          expect(page).to have_content '管理権限がありません。'
          # expect(page).to have_content '内容'
        end
      end
    end

  #
  #     describe 'タスク登録画面' do
  #       context '必要項目を入力して、createボタンを押した場合' do
  #         it 'データが保存されること' do
  #           visit new_task_path
  #           fill_in 'task_title', with: 'タイトル'
  #           fill_in 'task_content', with: '内容'
  #           click_on '登録する'
  #           expect(page).to have_content 'タイトル'
  #           expect(page).to have_content '内容'
  #         end
  #       end
  #     end
  end
