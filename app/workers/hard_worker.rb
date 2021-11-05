class HardWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(rent_id)
    rent = Rent.find(rent_id)
    RentsMailer.rent_confirmation(rent).deliver
  end
end
