require 'rails_helper'

RSpec.describe 'Categories Request', type: :request do
  before(:each) do
    @user = FactoryBot.create :user

    sign_in @user
  end
  describe 'Get' do
    describe 'index' do
      before(:each) do
        get '/categories'
      end
      it '1, should have a successful response' do
        expect(response).to have_http_status(200)
      end
      it '2, render template index' do
        expect(response).to render_template(:index)
      end
    end

    describe 'new' do
      before(:each) do
        get '/category/new'
      end
      it '1, should have a successful response' do
        expect(response).to have_http_status(200)
      end
      it '2, render template index' do
        expect(response).to render_template(:new)
      end
    end

    describe 'edit' do
      before(:each) do
        category = @user.categories.create(name: 'category')

        get "/category/#{category.id}/edit"
      end
      it '1, should have a successful response' do
        expect(response).to have_http_status(200)
      end
      it '2, render template edit' do
        expect(response).to render_template(:edit)
      end
    end

    describe 'show' do
      before(:each) do
        category = @user.categories
                        .create(
                          name: 'task'
                        )
        get "/category/#{category.id}"
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
        post '/category/create', params: {
          category: {
            name: 'category'
          }
        }
      end
      it '1, should have a redirect response' do
        expect(response).to have_http_status(302)
      end
    end
  end

  describe 'Patch' do
    describe 'update' do
      before(:each) do
        category = @user.categories.create(name: 'category')
        patch "/category/#{category.id}", params: {
          category: {
            name: 'category'
          }
        }
      end
      it '1, should have a redirect response' do
        expect(response).to have_http_status(302)
      end
    end
  end

  describe 'Delete' do
    describe 'destroy' do
      before(:each) do
        category = @user.categories.create(name: 'category')
        delete "/category/#{category.id}"
      end
      it '1, should have a redirect response' do
        expect(response).to have_http_status(302)
      end
    end
  end
end
