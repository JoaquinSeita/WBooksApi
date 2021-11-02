module RentsControllerHelper
  def rent_params
    params.require(:rent).permit(:to, :from, :user_id, :book_id)
  end

  def valid_date?
    from_dt = rent_params[:from].to_date
    to_dt = rent_params[:to].to_date

    if from_dt < Time.zone.today || to_dt < from_dt
      unprocessable_entity('Errors in dates')
      false
    else
      true
    end
  end

  def book_available?(book)
    if book.available == false
      unprocessable_entity('The book is not available right now')
      false
    else
      true
    end
  end

  def book_set_available(book_id)
    book_ins = Book.find(book_id)
    book_ins.update!(available: true)
  end

  def rent_book(book_ins, user_ins)
    book_ins.update!(available: false)
    user_ins.rents_count += 1
    user_ins.save
    rent = Rent.new(rent_params)
    render json: rent, serializer: RentSerializer if rent.save
  end

  def rent_cancel(rent_ins)
    book_set_available(rent_ins.book_id)
    rent_ins.returned_at = Time.zone.today
    rent_ins.save
    render json: rent_ins, serializer: RentSerializer if rent_ins.save
  end
end
