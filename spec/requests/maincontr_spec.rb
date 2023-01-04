# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Maincontrs', type: :request do
  describe 'GET /' do
    before { get root_path }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders input template' do
      expect(response).to render_template(:input)
    end

    it 'responds with html' do
      expect(response.content_type).to match(%r{text/html})
    end
  end

  describe 'GET /show' do
    let(:number) do
      10
    end
    let(:array) do
      mas = []
      i = 1
      number.times do
        mas << if i <= (number / 2)
                 (Faker::Number.number(digits: 1)**2)
               else
                 Faker::Number.within(range: 50..60)
               end
        i += 1
      end
      mas.join(' ')
    end

    context 'when params are ok (code = 0)' do
      # код 0 (см. контроллер Maincontr)
      before { get "/maincontr/show?#{URI.encode_www_form({ number:, query: array })}" }

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

      it 'renders show template' do
        expect(response).to render_template(:show)
      end

      it 'responds with html' do
        expect(response.content_type).to match(%r{text/html})
      end

      it 'assigns expected result' do
        expect(assigns(:sequences)[0]).to be assigns(:maxsequence)
        expect(assigns(:sequences).size).to be assigns(:sequences_number)
        expect(assigns(:code)).to be 0
      end
    end

    context 'when params are invalid (code -2)' do
      # ошибка с кодом -2
      before { get "/maincontr/show?#{URI.encode_www_form({ number: number + 1, query: array })}" }

      it 'returns http 302 error' do
        expect(response).to have_http_status(302)
      end

      it 'responds with html' do
        expect(response.content_type).to match(%r{text/html})
      end

      it 'assigns expected code error' do
        expect(assigns(:code)).to be(-2)
      end
    end

    context 'when params are invalid (code 1)' do
      # ошибка с кодом 1 (см. контроллер Maincontr)
      before { get "/maincontr/show?#{URI.encode_www_form({ number:, query: "#{array}i" })}" }

      it 'returns http 302 error' do
        expect(response).to have_http_status(302)
      end

      it 'responds with html' do
        expect(response.content_type).to match(%r{text/html})
      end

      it 'assigns expected code error' do
        expect(assigns(:code)).to be 1
      end
    end

    context 'when params are invalid (code 2)' do
      # ошибка с кодом 2 (см. контроллер Maincontr)
      before { get "/maincontr/show?#{URI.encode_www_form({ number:, query: "#{array}$" })}" }

      it 'returns http 302 error' do
        expect(response).to have_http_status(302)
      end

      it 'responds with html' do
        expect(response.content_type).to match(%r{text/html})
      end

      it 'assigns expected code error' do
        expect(assigns(:code)).to be 2
      end
    end
  end
end
