require 'spec_helper'

describe SitePrism::Vcr::Waiter do
  let(:node)             { double }
  let(:options)          { double(waiter: :wait_for_me) }
  let(:fixtures_handler) { double(eject: true) }
  subject(:waiter)       { described_class.new(node, fixtures_handler, options) }

  describe '#wait' do
    context 'when a waiter is defined' do
      let(:node) { double(wait_for_me: true) }

      context 'when a waiter method is a symbol' do
        it 'calls the waiter to wait until all HTTP interactions are finished' do
          expect(node).to receive(:wait_for_me)

          waiter.wait
        end
      end

      context 'when a waiter method is a proc object' do
        let(:options) { double(waiter: proc{ self.wait_content_in_block }) }

        it 'calls the waiter to wait until all HTTP interactions are finished' do
          expect(node).to receive(:wait_content_in_block)

          waiter.wait
        end
      end

      it 'ejects fixtures' do
        expect(fixtures_handler).to receive(:eject)

        waiter.wait
      end
    end

    context 'when a waiter is not defined' do
      let(:options) { double(waiter: nil) }

      it 'the fixtures handler does not eject fixtures' do
        expect(fixtures_handler).to_not receive(:eject)

        waiter.wait
      end
    end
  end

  describe '#with_new_options' do
    let(:options_with_new_waiter) { double(waiter: :wait_for_tom) }

    before do
      @new_waiter = waiter.with_new_options(options_with_new_waiter)
    end

    it 'has a new waiter method' do
      expect(@new_waiter.waiter_method).to eq(:wait_for_tom)
    end

    it 'has the same node' do
      expect(@new_waiter.node).to eq(node)
    end
  end
end