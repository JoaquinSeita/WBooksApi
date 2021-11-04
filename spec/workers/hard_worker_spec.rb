require 'rails_helper'

RSpec.describe HardWorker, type: :worker do
  include_context 'User, Book and Rent'

  describe 'HardWorker jobs' do
    context 'When worker has a job' do
      let(:rent) { create(:rent, user_id: user.id, book_id: book.id) }

      it 'increments jobs number' do
        assert_equal 0, HardWorker.jobs.size
        HardWorker.perform_async(rent)
        assert_equal 1, HardWorker.jobs.size
      end
    end
  end

  describe 'When HardWorker is called' do
    let(:rent) { create(:rent, user_id: user.id, book_id: book.id) }

    it 'should respond to #perform' do
      expect(HardWorker.new).to respond_to(:perform)
    end

    before do
      Sidekiq::Extensions.enable_delay!
      Sidekiq::Worker.clear_all
    end

    it 'should enqueue a Email job' do
      assert_equal 0, Sidekiq::Extensions::DelayedMailer.jobs.size
      RentsMailer.delay.rent_confirmation(rent)
      assert_equal 1, Sidekiq::Extensions::DelayedMailer.jobs.size
    end
  end
end
