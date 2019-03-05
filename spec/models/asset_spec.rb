require 'rails_helper'

RSpec.describe Asset, type: :model do
  let(:asset) { build(:asset) }

  describe 'validations' do
    it { expect(asset).to validate_presence_of(:file_name) }
    it { expect(asset).to validate_presence_of(:file_body) }
    it { expect(asset).to validate_uniqueness_of(:file_name) }
  end
end
