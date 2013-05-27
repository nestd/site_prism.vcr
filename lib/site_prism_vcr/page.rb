module SitePrism
  class Page
    def self.vcr_options_for_load(vcr_options = nil, &block)
      @vcr_options  = vcr_options
      @vcr_adjuster = block
    end

    def self.vcr_options
      @vcr_options
    end

    def self.vcr_adjuster
      @vcr_adjuster
    end

    def load_and_apply_vcr(custom_fixtures = nil, action = nil, &adjusting_block)
      applier = SitePrism::Vcr::Applier.new(
        self,
        self.class.vcr_options || {},
        &self.class.vcr_adjuster
      )

      applier.apply(
        custom_fixtures,
        action,
        adjusting_block
      ) do
        load
      end
    end
  end
end