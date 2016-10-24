class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def vkontakte
    @user = User.find_for_vkontakte_oauth(request.env['omniauth.auth'])

    if @user.persisted?
      flash[:notice] = I18n.t(
        'devise.omniauth_callbacks.success', kind: 'Vkontakte'
      )
      sign_in_and_redirect @user, event: :authentication
    else
      # Если же что-то пошло не так, пишем об ошибке и шлем на главную
      flash[:error] = I18n.t(
        'devise.omniauth_callbacks.failure', kind: 'Vkontakte', reason: 'authentication error'
      )
      redirect_to root_path
    end
  end
end