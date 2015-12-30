require 'rails_helper'

RSpec.describe Viewer::PagesController, :type => :request do
  describe '#error_404' do
    context 'with a valid site and pages' do
      it 'returns a 404 status' do
        site = create(:site)
        get "/preview/#{site.slug}/hatchmeatytickle"
        expect(response.status).to eq(404)
      end
    end
  end
end