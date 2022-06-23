RSpec.describe 'User Request', type: :request do
  before(:each) do
    @user = FactoryBot.create :user
    sign_in @user
  end

  describe 'Get' do
    describe 'view_task_today' do
      before(:each) do
        get '/task/today'
      end
      it '1, should have a successful response' do
        expect(response).to have_http_status(200)
      end
      it '2, render template view_task_today' do
        expect(response).to render_template(:view_task_today)
      end
    end
  end
end
