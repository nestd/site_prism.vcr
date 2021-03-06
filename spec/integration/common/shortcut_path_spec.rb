require 'spec_integration_helper'

feature 'Common use cases > Shortcuts' do
  let(:cat_owner)     { test_app_page.cat_owner }
  let(:test_app_page) { HomePage.new }

  let(:applier) do
    SPV::Applier.new(test_app_page) do
      fixtures ['ned_stark']
      waiter   &:wait_for_cat_owner
    end
  end

  let(:applier_with_event) do
    applier.shift_event {
      test_app_page.link_with_one_request.click
    }
  end

  before do
    test_app_page.load

    applier_with_event.apply_vcr do
      shortcut_path 'c', 'custom'

      fixtures [':c/bran_stark']
    end
  end

  it 'applies a stored fixture in the directory defined in the shortcut path' do
    expect(cat_owner).to have_content('Bran Stark')
  end
end