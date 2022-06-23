require 'rails_helper'

RSpec.describe 'Task Request', type: :request do
  let(:category) do
    Category.create(
      name: 'category'
    )
  end
  describe 'Get' do
    describe 'index' do
      before(:each) do
        get '/tasks'
      end
      it '1, should have a successful response' do
        expect(response).to have_http_status(200)
      end
      it '2, render template index' do
        expect(response).to render_template(:index)
      end
    end

    describe 'New' do
      before(:each) do
        get '/task/new'
      end
      it '1, should have a successful response' do
        expect(response).to have_http_status(200)
      end
      it '2, render template new' do
        expect(response).to render_template(:new)
      end
    end

    describe 'Show' do
      before(:each) do
        task = category
               .tasks
               .create(
                 name: 'task',
                 description: 'description',
                 deadline: DateTime.now + 24.hour
               )
        get "/task/#{task.id}"
      end
      it '1, should have a successful response' do
        expect(response).to have_http_status(200)
      end
      it '2, render template show' do
        expect(response).to render_template(:show)
      end
    end
  end

  describe 'Post' do
    describe 'create' do
      before(:each) do
        post '/task/create', params: {
          task: {
          }
        }
      end
      it '1, invalid params should be have redirect response' do
        expect(response).to have_http_status(302)
      end
    end
  end

  describe 'Patch' do
    describe 'create' do
      before(:each) do
        task = category
               .tasks
               .create(
                 name: 'task',
                 description: 'description',
                 deadline: DateTime.now + 24.hour
               )
        patch "/task/#{task.id}", params: {
          task: {

          }
        }
      end
      it '1, invalid params should be have redirect response' do
        expect(response).to have_http_status(302)
      end
    end
  end

  describe 'Delete' do
    describe 'destroy' do
      before(:each) do
        task = category
               .tasks
               .create(
                 name: 'task',
                 description: 'description',
                 deadline: DateTime.now + 24.hour
               )
        delete "/task/#{task.id}"
      end
      it '1, should have a redirect response' do
        expect(response).to have_http_status(302)
      end
    end
  end
end
