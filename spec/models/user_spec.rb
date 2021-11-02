require 'rails_helper'

describe User, type: :model do
  it do
    should validate_presence_of(:first_name)
  end
  it do
    should validate_presence_of(:last_name)
  end

  subject(:user) do
    User.new(
      first_name: first_name, last_name: last_name, email: email, password: password,
      image_url: image_url
    )
  end

  let(:first_name)            { Faker::Name.first_name }
  let(:last_name)             { Faker::Name.last_name }
  let(:email)                 { Faker::Internet.email }
  let(:password)              { 'password' }
  let(:image_url)             { 'https://image.png.com' }

  it do
    is_expected.to be_valid
  end

  describe '#create' do
    %w[first_name last_name email password image_url].each do |field|
      context "When #{field} is nil" do
        let(field.to_sym) { nil }
        it { is_expected.to be_invalid }
      end
    end
  end
end
