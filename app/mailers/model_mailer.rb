class ModelMailer < ApplicationMailer
  default from: 'i.inessa.miller@gmail.com'

  def new_record_notification(record)
    @record = record
    mail to: "i.inessa.miller@gmail.com", subject: "Success! You did it!"
  end
