class UsersController < ApplicationController
  before_action :logged_in, except: %i(show new create)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_logged_in, only: :destroy
  before_action :load_user_or_redirect, only: %i(show edit update destroy)
  include SessionsHelper

  def index
    @users = User.order_by_name(:ASC).paginate(page: params[:page],
      per_page: Settings.will_pagination.per_page_10)
  end

  def edit; end

  def show; end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t "user_created_html", username: @user.name
      redirect_to login_url
    else
      render :new
    end
  end

  def update
    if @user.update(user_params)
      flash[:success] = t "user_updated_html", username: @user.name
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t "user_deleted_html", username: @user.name
    else
      flash[:warning] = t "user_deletion_failed_html", username: @user.name
    end
    redirect_to users_url
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end

  def logged_in
    return if logged_in?

    save_back_url
    flash[:danger] = t "login_first"
    redirect_to login_url
  end

  def correct_user
    load_user_or_redirect
    redirect_to(root_url) unless current_user?(@user)
  end

  def load_user_or_redirect
    @user = User.find_by id: params[:id]
    return if @user

    flash[:danger] = t "user_not_found"
    redirect_to users_url
  end

  def admin_logged_in
    return if current_user.admin

    flash[:danger] = t "must_be_admin"
    redirect_to users_url
  end
end
