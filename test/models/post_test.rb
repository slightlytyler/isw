# == Schema Information
#
# Table name: posts
#
#  id           :integer          not null, primary key
#  guide        :string(255)
#  name         :string(255)
#  url          :string(255)
#  published_at :datetime
#  image        :string(255)
#  content      :text
#  created_at   :datetime
#  updated_at   :datetime
#

require 'test_helper'

class PostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
