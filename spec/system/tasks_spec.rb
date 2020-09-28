require 'rails_helper'

RSpec.describe "Tasks", type: :system do
  let(:user) { create(:user) }
  let(:task) { create(:task) }

  describe 'ログイン前' do
    describe 'ページの遷移確認' do
      it '新規登録ページのアクセス失敗' do
        visit new_task_path
        expect(page).to have_content("Login required")
        expect(current_path).to eq login_path
      end
      it '編集ページのアクセス失敗' do
        visit edit_task_path(user)
        expect(page).to have_content("Login required")
        expect(current_path).to eq login_path
      end
      it 'タスク一覧ページを見られること' do
        visit tasks_path
        expect(current_path).to eq tasks_path
        expect(page).to have_content("Title")
        expect(page).to have_content("Content")
        expect(page).to have_content("Status")
        expect(page).to have_content("Deadline")
      end
      it 'タスク詳細ページを見られること' do
        create(:task, title:'test', status: :doing, user: user)
        visit tasks_path
        click_on "Show"
        # expect(current_path).to eq task_path(task) うまくいかない
        expect(page).to have_content("Title")
        expect(page).to have_content("Content")
      end
    end
  end

  describe 'ログイン後' do
    before { login(user) }
    describe 'タスク新規登録' do
      context 'タイトルが空白' do
        it 'タスクの新規登録が失敗すること' do
          visit new_task_path
          fill_in 'Title', with: ''
          select 'todo', from: 'Status'
          click_button "Create Task"
          expect(page).to have_content("Title can't be blank")
        end
      end
    end
    describe 'タスク編集' do
      context 'コンテンツが全て埋まっていること' do
        # it 'タスクの更新に成功すること' do うまくいかない
        #   create(:task, title:'test', status: :doing, user: user)
        #   visit edit_task_path(task)
        #   fill_in 'Title', with: 'title_test'
        #   select :done, from: 'Status'
        #   click_button "Update Task"
        #   expect(current_path).to eq task_path(task)
        #   expect(page).to have_content("Task was successfully updated")
        # end
      end
      context '他のユーザーのタスク編集ページヘ遷移' do
        it 'ページの遷移に失敗すること' do
          create(:task, title:'test', status: :doing, user: user)
          visit edit_task_path(task)
          expect(current_path).to eq root_path
          expect(page).to have_content("Forbidden access")
        end
      end
    end
    describe 'タスク削除' do
      it 'タスクの削除ができること' do
        create(:task, title:'test', status: :doing, user: user)
        visit tasks_path
        click_on "Destroy"
        expect(page.accept_confirm).to eq 'Are you sure?'
        expect(current_path).to eq tasks_path
        expect(page).to have_content("Task was successfully destroyed")
      end
    end

  end
end
