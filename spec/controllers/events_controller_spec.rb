require 'rails_helper'

RSpec.describe EventsController, type: :controller do

  login_user

  let(:event) { create :event }

  describe '#register' do

    context "when current_user is valid user" do
      before { post :register, { id: event.id, user_id: @current_user.id } }

      it 'redirect to index of events' do
        expect(response).to redirect_to(events_path)
      end

      it 'received a success' do
        expect(flash[:success]).not_to be_nil
      end
    end

    context "when user is already registred" do
      before(:each) do
        create :registration, user: @current_user, event: event
        post :register, { id: event.id, user_id: @current_user.id }
      end

      it 'redirect to index of events' do
        expect(response).to redirect_to(events_path)
      end

      it 'received a alert' do
        expect(flash[:error]).not_to be_nil
      end
    end

    context "when exceeded number of participants" do
      before(:each) do
        create_list :registration, 10, event: event
        post :register, { id: event.id, user_id: @current_user.id }
      end

      it 'result of exceeded limit be true' do
        expect(JSON.parse(response.body)['exceeded_limit']).to be_truthy
      end
    end

    context "when user hasn't cpf registred" do
      let(:user) { create :user_without_cpf }

      context "when cpf isn't informed" do
        before { post :register, { id: event.id, user_id: user.id, register: { cpf: '' } } }

        it 'return a alert' do
          expect(flash[:error]).not_to be_nil
        end
      end

      context "when cpf is informed" do

        context "invalid cpf" do
          before { post :register, { id: event.id, user_id: user.id, register: { cpf: '111.111.111-11' } } }

          it 'return a alert' do
            expect(flash[:error]).not_to be_nil
          end
        end

        context "valid cpf" do
          before { post :register, { id: event.id, user_id: user.id, register: { cpf: '961.275.832-84' } } }

          it 'redirect to index of events' do
            expect(response).to redirect_to(events_path)
          end

          it 'return a alert' do
            expect(flash[:success]).not_to be_nil
          end
        end
      end
    end
  end
end
