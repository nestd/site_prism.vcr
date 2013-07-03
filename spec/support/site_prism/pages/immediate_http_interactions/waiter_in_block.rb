require_relative '../base'

module ImmediateHttpInteractions
  class WaiterInBlockPage < BasePage
    set_url '/immediate-http-interactions/two-requests'

    vcr_options_for_load do
      fixtures ['tom', 'zeus']
      waiter   { self.wait_for_tom_and_zeus }
    end
  end
end