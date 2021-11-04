module RentsControllerHelper
  def valid_date?
    from_dt = rent_params[:from].to_date
    to_dt = rent_params[:to].to_date
    from_dt >= Time.zone.today && to_dt > from_dt
  end

  def book_set_available(book_id)
    book = Book.find(book_id)
    book.update!(available: true)
  end

  def rent_book(book)
    book.update!(available: false)

    current_user.rents_count += 1
    current_user.save

    rent = Rent.new(rent_params)
    rent.user_id = current_user.id
    send_email_and_json(rent) if rent.save
  end

  def send_email_and_json(rent)
    HardWorker.perform_async(rent.id)
    render json: rent, status: :ok, serializer: RentSerializer
  end

  def rent_cancel(rent)
    book_set_available(rent.book_id)
    rent.returned_at = Time.zone.today
    render json: rent, serializer: RentSerializer if rent.save
  end
end
