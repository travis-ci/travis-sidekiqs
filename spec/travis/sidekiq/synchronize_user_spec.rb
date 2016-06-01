# require 'spec_helper'
#
# describe Travis::Sidekiq::SynchronizeUser do
#   class FakeUser
#     attr_reader :synchronized
#
#     def sync
#       @synchronized = true
#     end
#   end
#
#   class ErrorUser
#     attr_reader :updated_columns
#     def initialize
#       @updated_columns = {}
#     end
#
#     def sync
#       raise
#     end
#
#     def update_column(column, value)
#       updated_columns[column] = value
#     end
#   end
#
#   class SynchronizeUserRepository
#     attr_reader :find_id
#
#     def initialize(subject)
#       @subject = subject
#     end
#
#     def find(id)
#       @find_id = id
#       @subject
#     end
#   end
#
#   let(:user) {
#     FakeUser.new
#   }
#   let(:repository) {
#     SynchronizeUserRepository.new(user)
#   }
#   let(:synchronize) {
#     Travis::Sidekiq::SynchronizeUser.new.tap do |synchronize|
#       synchronize.instance_variable_set(:@user, user)
#       synchronize.instance_variable_set(:@repository, repository)
#     end
#   }
#   let(:error_user) {
#     ErrorUser.new
#   }
#
#   context "perform" do
#     it "should synchronize the user" do
#       synchronize.perform(1)
#       user.synchronized.should == true
#     end
#
#     it "should find the user based on the id" do
#       synchronize.instance_variable_set(:@user, nil)
#       expect {
#         synchronize.perform(10)
#       }.to change(repository, :find_id)
#     end
#
#     it "should update the syncing column in case of an error" do
#       synchronize.instance_variable_set(:@user, user)
#       begin
#         synchronize.perform(10)
#       rescue
#         error_user.updated_columns[:is_syncing].should == false
#       end
#     end
#   end
# end
