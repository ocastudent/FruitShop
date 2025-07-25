class MypageController < ApplicationController
  before_action :authenticate_user!
  def show
    @user = User.find(params[:id])
  end

  private

  # 許可するユーザ情報のパラメータ
  def user_params
    params.require(:user).permit(:name, :email, :admin_flg)
  end
end
