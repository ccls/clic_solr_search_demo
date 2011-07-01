# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_book_search_demo_session',
  :secret      => '8288de907ca517ab50fc2fe6579949ec63b07b26177f9a66b583ee0132a5c395ead7eb32cb968a73d90113a03b0bfc2fb7a2298dacda42068d35e76cd18e1ee7'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
