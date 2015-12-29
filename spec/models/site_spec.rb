# == Schema Information
#
# Table name: sites
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  slug       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  config     :json
#

require 'rails_helper'

describe Site, :type => :model do

  let(:site) { create(:site) }

  context 'config' do
    it 'can add values to the config file' do
      site.update_config(:dropbox_key => 'ABC123', :dropbox_secret => 'ABC456')
      expect(site.config['dropbox_secret']).to eq('ABC456')
    end
    it 'can update values in the config file' do
      site.update_config(:dropbox_key => 'ABC123')
      site.update_config(:dropbox_key => 'ABC456')
      expect(site.config['dropbox_key']).to eq('ABC456')
    end
    it 'will keep skipped config attrs' do
      site.update_config(:dropbox_key => 'ABC123', :dropbox_secret => 'ABC456')
      site.update_config(:dropbox_key => 'Hello World')
      expect(site.config['dropbox_secret']).to eq('ABC456')
    end
    context 'protected attributes' do
      ['title','slug'].each do |col|
        it "adds #{col} to config on create" do
          expect(site.config[col]).to eq(site.send(col))
        end
        it "will change the #{col} when added to config change changes" do
          val = Faker::Lorem.words(8).join(' ')
          site.update_config(col.to_sym => val)
          expect(site.send(col)).to eq(val)
        end
        it "will update the #{col} in the config" do
          val = Faker::Lorem.words(8).join(' ')
          site.update_config(col.to_sym => 'Hello World 123')
          expect(site.config[col]).to eq('Hello World 123')
        end
      end
    end
  end

end
