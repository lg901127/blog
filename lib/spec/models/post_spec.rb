require 'rails_helper'

RSpec.describe Post, type: :model do
  it "requires a title" do
    result = Post.new ({body: "aaaaa"})
    result.valid?
    expect(result.errors).to have_key(:title)
  end

  it "requires more than 7 chars for Post's title" do
    result = Post.new ({title: "title", body: "aaa"})
    result.valid?
    expect(result.errors).to have_key(:title)
  end

  it "requires a body" do
    result = Post.new ({title: "aaaaa"})
    result.valid?
    expect(result.errors).to have_key(:body)
  end

  describe ".body_snippet" do
    it "returns expected result of 100 characters followed by..." do
      p = Post.new body: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
      expect(p.body_snippet.length).to eq(103)
    end
  end

end
