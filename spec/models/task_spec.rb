require 'rails_helper'

RSpec.describe 'タスク管理機能', type: :model do

  it 'titleが空ならバリデーションが通らない' do
      task = Task.new(title: '', content: '失敗テスト')
      expect(task).not_to be_valid
  end

  it 'contentが空ならバリデーションが通らない' do
      task = Task.new(title: '失敗テスト', content: '')
      expect(task).not_to be_valid
  end

  it 'titleとcontentに内容が記載されていればバリデーションが通る' do
      task = Task.new(title: '失敗テスト', content: '失敗テスト')
      expect(task).to be_valid
  end

  before do
    @task = FactoryBot.create(:task)
  end

  it 'search_title実行時にtitleが一致した場合' do
    expect(Task.search_title("タイトル1")).to include(@task)
  end

  it 'search_title実行時にtitleのデータが存在しない場合' do
    expect(Task.search_title("失敗テスト")).not_to include(@task)
  end

  it 'search_status実行時にstatusに未着手を選択した場合' do
    expect(Task.search_status(1)).to include(@task)
  end

end
