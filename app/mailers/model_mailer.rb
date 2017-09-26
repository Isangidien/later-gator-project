class ModelMailer < ApplicationMailer
  default from: 'i.inessa.miller@gmail.com'

  def new_record(record)
    @record = record
    mail to: "i.inessa.miller@gmail.com", subject: "Success! You did it!"
  end
end
