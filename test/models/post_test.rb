# == Schema Information
#
# Table name: posts
#
#  id           :integer          not null, primary key
#  guide        :string(255)
#  name         :string(255)
#  url          :string(255)
#  published_at :datetime
#  week         :integer
#  month        :integer
#  year         :integer
#  image        :text
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
