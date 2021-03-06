class ApplicationController < ActionController::Base

  protect_from_forgery with: :null_session

  private

    def render_403   
    # Если не явл. админом - тогда высвечиваем эту стр. 
      render file: "public/403.html", status: 403
    end

    def render_404    
    # Если ошибка
      render file: "public/404.html", status: 404
    end

     def check_if_admin
      render_403 unless params[:admin]
      # render text: "Access denied", status: 403 unless current_user.admin == true
      # так бы прописали в настоящем приложеннии, а пока только так:
    end


end