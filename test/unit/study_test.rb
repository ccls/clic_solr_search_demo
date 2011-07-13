require 'test_helper'

class StudyTest < ActiveSupport::TestCase
	#	http://timcowlishaw.co.uk/post/3179661158/testing-sunspot-with-test-unit
	include TestSunspot

	assert_should_have_many(:exposures)
	assert_should_have_many(:questions)
end
