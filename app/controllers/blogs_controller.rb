class BlogsController < ApplicationController
  before_action :authenticate_user!

  def index
      #@blogs = Blog.all
      @blogs=Blog.order("updated_at desc")
      #binding.pry
      #raise
  end

  def new
    if params[:back]
      @blog = Blog.new(blogs_params)
    else
    @blog = Blog.new #@blogとすることでインスタンス変数を定義し、インスタンス変数はViewファイルに渡されます。
    end
  end

  def create
      @blog = Blog.new(blogs_params)
      @blog.user_id = current_user.id
      if @blog.save
        # 一覧画面へ遷移して"ブログを作成しました！"とメッセージを表示します。
        redirect_to blogs_path, notice: "ブログを作成しました！"
        NoticeMailer.sendmail_blog(@blog).deliver
      else
        # 入力フォームを再描画します。
        render action: 'new'
      end
  end

  def confirm
    @blog = Blog.new(blogs_params)
    render :new if @blog.invalid?
  end

  def edit
    @blog = Blog.find(params[:id])
  end

  def update
    @blog = Blog.find(params[:id])

    if @blog.update(blogs_params)
      redirect_to blogs_path, notice: "ブログを更新しました！"
    else
      render action: 'edit'
    end
  end

  def destroy
    # edit, update, destroyで共通コード
    @blog = Blog.find(params[:id])
    @blog.destroy
    redirect_to blogs_path, notice: "ブログを削除しました！"
  end

  private
    def blogs_params
      params.require(:blog).permit(:title, :content)
    end

     # idをキーとして値を取得するメソッド
    def set_blog
      @blog = Blog.find(params[:id])
    end

  def view
  end



end
