class ProductsController < ApplicationController
  before_action :check_admin, except: [:index, :show]
  
  def new
     @product = Product.new
  end
  
  def index
    @products = Product.all
  end
  
  def show
    @product = Product.find(params[:id])
  end
  
  def edit
    @product = Product.find(params[:id])
  end

  def create
      # フォームから送られたデータを元に新しい商品を作成
    @product = Product.new(product_params)

    # データをデータベースに保存する
    if @product.save
      # 成功した場合、トップページへリダイレクト
      redirect_to products_path
    else
      # 失敗した場合、入力内容を保持したままフォームを再表示
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      redirect_to product_path # 商品詳細にリダイレクト
    else
      render :edit  # 失敗時に編集画面に戻る
    end
  end
  
  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    # 商品一覧にリダイレクト
    redirect_to products_path 
  end

  private

    # ストロングパラメータで、フォームから送信されたデータを許可する
    def product_params
      params.require(:product).permit(:name, :description, :price)
    end

    def check_admin
      unless current_user.admin_flg
        # 管理者でない場合、商品一覧ページにリダイレクト
        redirect_to products_path, alert: '管理者権限が必要です。'
      end
    end
end
