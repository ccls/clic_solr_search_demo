require 'test_helper'

class SubjectTest < ActiveSupport::TestCase
#	http://timcowlishaw.co.uk/post/3179661158/testing-sunspot-with-test-unit
#	include TestSunspot

	assert_should_create_default_object
	assert_should_belong_to(:study)
	assert_should_be_searchable

end
