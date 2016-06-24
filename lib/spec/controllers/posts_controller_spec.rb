require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:post1) {FactoryGirl.create(:post)}

  describe "#new" do
    it "renders the new template" do
      get :new
      expect(response).to render_template(:new)
    end

    it "fetches" do
      get :new
      expect(assigns(:post)).to be_a_new(Post)
    end
  end

  describe "#create" do
    context "with valid request" do
      def valid_request
        post :create, post: FactoryGirl.attributes_for(:post)
      end
      it "saves the record" do
        count_before = Post.count
        valid_request
        count_after = Post.count
        expect(count_after).to eq(count_before + 1)
      end
      it "redirects to the show page" do
        valid_request
        expect(response).to redirect_to(blog_path(Post.last))
      end
    end

    context "Invalid request" do
      def invalid_request
        post :create, post: {title: "aaa"}
      end
      it "doesn't save" do
        count_before = Post.count
        invalid_request
        count_after = Post.count
        expect(count_after).to eq(count_before)
      end
      it "renders the new template" do
        invalid_request
        expect(response).to render_template(:new)
      end
    end
  end

  describe "#show" do
    before do
      @post = FactoryGirl.create(:post)
      get :show, id: @post.id
    end
    it "renders the show template" do
      expect(response).to render_template(:show)
    end
    it "fetches" do
      expect(assigns(:post)).to eq(@post)
    end
  end

  describe "#posts" do
    it "renders the index template" do
      get :posts
      expect(response).to render_template(:posts)
    end
    it "sets posts instance variable to all posts in te DB" do
      post_1 = FactoryGirl.create(:post)
      post_2 = FactoryGirl.create(:post)
      get :posts
      expect(assigns(:posts)).to eq([post_1, post_2])
    end
  end

  describe "#edit" do
    before do
      get :edit, id: post1.id
    end
    it "renders the edit template" do
      expect(response).to render_template(:edit)
    end
      it "set an instance variable to the post with the id passed" do
        expect(assigns(:post)).to eq(post1)
      end
  end

  describe "#update" do
    context "With valid attributes" do
      def valid_request
        patch :update, id: post1.id, post: {title: "new valid title"}
      end
      it "updates the record in the database" do
        valid_request
        expect(post1.reload.title).to eq("new valid title")
      end
      it "redirects to the show page" do
        valid_request
        expect(response).to redirect_to(blog_path(post1))
      end
    end

    context "With invalid attributes" do
      def invalid_request
        patch :update, id: post1.id, post: {title: ""}
      end
      it "doesn't save the updated values" do
        invalid_request
        expect(post1.reload.title).not_to eq("")
      end
      it "renders the edit template" do
        invalid_request
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "#destory" do
    #using let! forces the block to be executed before every test example regardless whether you call the method or not.
    let!(:post) {FactoryGirl.create(:post)}
    it "removes the record from the database" do
      # post
      count_before = Post.count
      delete :destroy, id: post.id
      count_after = Post.count
      expect(count_before).to eq(count_after + 1)
    end
    it "redirects to posts_path (listings page)" do
      delete :destroy, id: post.id
      expect(response).to redirect_to(posts_path)
    end
  end
end
