# == Schema Information
#
# Table name: sites
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  created_at :datetime
#  updated_at :datetime
#  config     :json
#

require 'rails_helper'

describe Site, :type => :model do

  let(:site) { create(:site) }

  it 'generates a default config' do
    expect(site.config).to eq({ 'templates' => [] })
  end

  it 'can add values to the config file' do
    site.update_config(:dropbox_key => 'ABC123', :dropbox_secret => 'ABC456')
    site.reload
    expect(site.config['dropbox_secret']).to eq('ABC456')
  end

  it 'can update values in the config file' do
    site.update_config(:dropbox_key => 'ABC123')
    site.update_config(:dropbox_key => 'ABC456')
    site.reload
    expect(site.config['dropbox_key']).to eq('ABC456')
  end

  it 'will keep skipped config attrs' do
    site.update_config(:dropbox_key => 'ABC123', :dropbox_secret => 'ABC456')
    site.update_config(:dropbox_key => 'Hello World')
    site.reload
    expect(site.config['dropbox_secret']).to eq('ABC456')
  end

end
