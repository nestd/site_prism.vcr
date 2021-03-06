# TODO

## Things to think over

1. Should we add the integration tests for page load to make sure 2 HTTP requests will be handled properly?
2. Should we add own integration tests to test the path helper method?
3. Should we add a test for testing to HTTP requests on page load?
4. Should be Options class immutable?
5. Think about renaming current integration tests on acceptance tests and create new integration tests which will test integration between classes without involving a browser. It will solve a lot of issues with shared tests to check the same things for pages and elements. In acceptance tests we will test very basic stuffs.
6. May be SPV::Fixtures::TmpKeeper is redundant and SPV::Fixtures can be used as a tmp keeper of fixtures?
7. Elements should inherit fixtures defined for their parents
8. Create possibility to define fixtures without the click action (it can be done with `alter_fixtures` method from the applier, but it is not accessible outside of the applier):

    ```ruby
    self.confirm_btn.vcr do
      path 'products', ['tomato', 'fruit/apple']
      path 'goods', 'cars'

      replace
    end
    ```

  and then

    ```ruby
    self.confirm_btn.click_and_apply_vcr
    ```

  will use previously defined fixtures
  
9. Think about creating set of fixtures which can be exchanged by a name of set. It will be very helpful when you have to exchange a set of fixtures.
