# Braintree Rails Donate
This is a demo of [Braintree's Ruby Library](https://www.braintreepayments.com/docs/ruby/guide/overview) and developer Sandbox integrated with Rails 3 to make a donate button. It uses Braintree's Transparent Redirect feature.

## Notes

- Get your own Sandbox API keys and put them in app/config/initializers/braintree.rb. Refer to the [Sandbox reference](https://www.braintreepayments.com/docs/ruby/reference/sandbox) when testing.
- Integration tests use RSpec and Capybara 2. 
- I used the form builder from Braintree's example: https://github.com/braintree/braintree_ruby_examples/tree/master/rails3_tr_checkout . It's in the application_helper.rb.
- To test the transparent redirect, we need more than just Cabybara out of the box, because it can't do external redirects by itself. I set :js => true on some of the tests which use an external redirect to invoke Selenium (the default Capybara JS driver), which will launch Firefox and run the tests. Alternatively, use a different Capybara driver.
