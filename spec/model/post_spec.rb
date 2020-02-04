require 'rails_helper'

describe Post do
  describe '#create' do

    # urlが空では登録できないこと
    it "is invalid without a url" do
      post = build(:post, url: nil)
      post.valid?
      expect(post.errors[:url]).to include("を入力してください")
    end

  end
end