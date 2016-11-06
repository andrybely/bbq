class SubscriptionsController < ApplicationController
  before_action :set_event, only: [:create, :destroy]
  before_action :set_subscription, only: [:destroy]
  #before_action :unreg_user_email_valid, only: [:create]

  # POST /subscriptions
  def create
    @new_subscription = @event.subscriptions.build(subscription_params)
    @new_subscription.user = current_user

    if  current_user != @event.user && @new_subscription.save
      EventMailer.subscription(@event, @new_subscription).deliver_now

      redirect_to @event, notice: I18n.t('controllers.subscription.created')
    else
      render 'events/show', alert: I18n.t('controllers.subscription.error')
    end
  end

  def destroy
    message = {notice: I18n.t('controllers.subscription.destroyed')}

    if current_user_can_edit?(@subscription)
    @subscription.destroy
    else
    message = {alert: I18n.t('controllers.subscription.error')}
    end

    redirect_to @event, message
  end


  private
  def unreg_user_email_valid
    #Не работает, разобраться
    if User.where(:email => @new_subscription.user_email).exists?

      redirect_to new_user_session_path, notice: I18n.t('controllers.subscription.sign_in')

    end
  end

  def set_subscription
    @subscription = @event.subscriptions.find(params[:id])
  end

  def set_event
    @event = Event.find(params[:event_id])
  end

    def subscription_params
      params.fetch(:subscription, {}).permit(:user_email, :user_name)
    end
end
