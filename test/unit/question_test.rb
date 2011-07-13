require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
	#	http://timcowlishaw.co.uk/post/3179661158/testing-sunspot-with-test-unit
	include TestSunspot

	assert_should_belong_to(:study)
end
