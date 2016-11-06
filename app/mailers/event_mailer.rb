class EventMailer < ApplicationMailer

  def subscription(event, subscription)
    @email = subscription.user_email
    @name = subscription.user_name
    @event = event


    mail to: event.user.email, subject: "Новая подписка на #{event.title}"
  end


  def comment(event, comment, email)
    @comment = comment
    @event = event

    mail to: email, subject: "Новый комментарий @ #{event.title}"
  end

  def photo(event, photo, email)
    attachments.inline["#{photo}"] = File.read("#{photo}")
    @event = event

    mail to: email, subject: "Новое фото добавлено @ #{event.title}"
  end
end
