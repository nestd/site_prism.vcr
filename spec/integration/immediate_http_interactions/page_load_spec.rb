require 'spec_integration_helper'

feature 'Immediate Http interactions > Page load' do
  let(:cat_owner)     { test_app_page.cat_owner }
  let(:test_app_page) { ImmediateHttpInteractions::OneRequestPage.new }
  let(:action_method) { :load_and_apply_vcr }

  context 'when one default fixture is defined' do
    it 'opens the page and applies a default fixture' do
      test_app_page.load_and_apply_vcr

      expect(cat_owner).to have_content('Ned Stark')
    end
  end

  it 'applies additional query to url' do
    test_app_page.load_and_apply_vcr(cat: 'ford')

    expect(page.current_url).to match(/\?cat=ford/)
  end

  context 'when a subpage inherits a page with a defined vcr options' do
    let(:test_app_page) { ImmediateHttpInteractions::SubPage.new }

    it 'subpage inherits the defined options for its parent page' do
      test_app_page.load_and_apply_vcr

      expect(cat_owner).to have_content('Ned Stark')
    end
  end

  it_behaves_like 'when a custom fixture is applied' do
    let(:actor) { test_app_page }
  end

  context 'waiters' do
    it_behaves_like 'when a default waiter does not eject fixtures' do
      let(:actor) { ImmediateHttpInteractions::WaiterWithoutFixturesEjectionPage.new }
    end

    it_behaves_like 'custom waiters' do
      let(:actor)         { ImmediateHttpInteractions::TwoRequestsPage.new }
      let(:test_app_page) { actor }
    end
  end

  it_behaves_like 'when a home path is define' do
    let(:actor_with_home_path)    { ImmediateHttpInteractions::HomePathPage.new }
    let(:actor_without_home_path) { ImmediateHttpInteractions::OneRequestPage.new }
  end

  it_behaves_like 'when a default fixture is exchanged' do
    let(:actor_without_home_path) { ImmediateHttpInteractions::TwoRequestsPage.new }
    let(:actor_with_home_path)    { ImmediateHttpInteractions::HomePathPage.new }
  end
end