require 'test_helper'

class StudyTest < ActiveSupport::TestCase
#	http://timcowlishaw.co.uk/post/3179661158/testing-sunspot-with-test-unit
#	studies are not yet searchable so not needed
#	include TestSunspot

	assert_should_create_default_object
	assert_should_have_many(:exposures)
	assert_should_have_many(:questions)
	assert_should_have_many(:subjects)

end
