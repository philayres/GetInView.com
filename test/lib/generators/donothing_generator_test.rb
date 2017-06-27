require 'test_helper'
require 'generators/donothing/donothing_generator'

class DonothingGeneratorTest < Rails::Generators::TestCase
  tests DonothingGenerator
  destination Rails.root.join('tmp/generators')
  setup :prepare_destination

  # test "generator runs without errors" do
  #   assert_nothing_raised do
  #     run_generator ["arguments"]
  #   end
  # end
end
