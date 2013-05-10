module SitePrism
  module Vcr
    class InitialAdjuster
      def initialize(options)
        @options = options
      end

      def fixtures(val)
        @options.add_fixtures(val)
      end

      def home_path(val)
        @options.home_path = val
      end

      def path(path, fixture_names)
        fixtures = []

        fixture_names.map do |name|
          fixtures << "#{path}/#{name}"
        end

        @options.add_fixtures(fixtures)
      end

      # TODO: this method is almost the same with the previous one
      # think about refactoring it
      def waiter(val)
        @options.waiter = val
      end
    end
  end
end