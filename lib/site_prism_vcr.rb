require 'vcr'
require 'capybara'
require 'site_prism'
require 'webmock'

require 'site_prism_vcr/version'
require 'site_prism_vcr/element'
require 'site_prism_vcr/applier'
require 'site_prism_vcr/fixture'
require 'site_prism_vcr/fixtures'
require 'site_prism_vcr/fixtures/tmp_keeper'
require 'site_prism_vcr/fixtures/converter'
require 'site_prism_vcr/fixtures_manager'
require 'site_prism_vcr/fixtures/modifiers/path'
require 'site_prism_vcr/fixtures/modifiers/home_path'
require 'site_prism_vcr/options'
require 'site_prism_vcr/options_with_path'
require 'site_prism_vcr/dsl/initial_adjuster'
require 'site_prism_vcr/dsl/adjuster'
require 'site_prism_vcr/waiter'
require 'site_prism_vcr/vcr_helpers'
require 'site_prism_vcr/patches/page'
require 'site_prism_vcr/patches/element_container'