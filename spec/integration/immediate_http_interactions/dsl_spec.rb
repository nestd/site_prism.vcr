require 'spec_integration_helper'

feature 'Immediate Http interactions > DSL' do
  let(:cat_owner)  { test_app_page.cat_owner }
  let(:test_app_page) { ImmediateHttpInteractions::OneRequestPage.new }
  let(:action_method) { :load_and_apply_vcr }

  shared_examples 'when do one simple HTTP request' do
    it 'opens the page and applies default fixtures' do
      test_app_page.load_and_apply_vcr

      expect(cat_owner).to have_content('Ned Stark')
    end
  end

  context 'when default fixtures are defined' do
    it_behaves_like 'when do one simple HTTP request'
  end

  it_behaves_like 'when a custom cassette is applied' do
    let(:actor) { test_app_page }
  end

  context 'waiters' do
    it_behaves_like 'custom waiters' do
      let(:actor)         { ImmediateHttpInteractions::TwoRequestsPage.new }
      let(:test_app_page) { actor }
    end

    it_behaves_like 'when a default waiter does not eject fixtures' do
      let(:actor) { ImmediateHttpInteractions::WaiterWithoutFixturesEjectPage.new }
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

  it 'applies additional query to url' do
    test_app_page.load_and_apply_vcr(cat: 'ford')

    expect(page.current_url).to match(/\?cat=ford/)
  end
end