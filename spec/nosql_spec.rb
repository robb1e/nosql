require 'active_record'
require 'nosql'

ActiveRecord::Base.establish_connection adapter: 'sqlite3', database: ':memory:'
connection = ActiveRecord::Base.connection
connection.create_table(:posts) do |t|
  t.string :title
  t.timestamps
end

class Post < ActiveRecord::Base; end

describe "With ActiveRecord::Base" do
  context "with a real db connection" do
    it "can create a record" do
      expect {
        Post.create
      }.to change { Post.count }.by(1)
    end
  end

  context "with a null db connection" do
    before do
      ActiveRecord::Base.connection.stub(:exec).and_raise(Nosql::Error)
      ActiveRecord::Base.connection.stub(:exec_query).and_raise(Nosql::Error)
    end

    it "cannot create a record" do
      expect {
        Post.create
      }.to raise_error(Nosql::Error)
    end

    it "cannot use a scope" do
      expect {
        Post.where(id: 1).first
      }.to raise_error(Nosql::Error)
    end

    it "cannot count" do
      expect {
        Post.count
      }.to raise_error(Nosql::Error)
    end

    it "cannot update_all" do
      expect {
        Post.update_all "title = 'title'"
      }.to raise_error(Nosql::Error)
    end

    it "can new an instance up" do
      expect {
        Post.new
      }.to_not raise_error(Nosql::Error)
    end

    xit "can create stub models" do
      expect {
        stub_model(:post)
      }.to_not raise_error(Nosql::Error)
    end

  end

  context "with a nosql adapter connection" do
    before do
      Nosql::Connection.enable!
    end

    after do
      Nosql::Connection.disable!
    end

    it "cannot create a record" do
      expect {
        Post.create
      }.to raise_error(Nosql::Error)
    end

    it "cannot use a scope" do
      expect {
        Post.where(id: 1).first
      }.to raise_error(Nosql::Error)
    end

    it "cannot count" do
      expect {
        Post.count
      }.to raise_error(Nosql::Error)
    end

    it "cannot update_all" do
      expect {
        Post.update_all "title = 'title'"
      }.to raise_error(Nosql::Error)
    end

    it "can new an instance up" do
      expect {
        Post.new
      }.to_not raise_error(Nosql::Error)
    end

    xit "can create stub models" do
      expect {
        stub_model(:post)
      }.to_not raise_error(Nosql::Error)
    end

  end
end
