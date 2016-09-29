class ItemsController < ApplicationController

  before_filter :find_item, only: [:show, :edit, :update, :destroy, :upvote ]
  # есть ещё after_filter, но чаще используется этот
  # фильтру передаем название метода:  :find_item
  # и указываем, перед какими экшенами нужно выполнить метод:  only: [:show, :edit,...]
  before_filter :check_if_admin, only: [:edit, :update, :new, :destroy]
  # Ограничение доступа для простых пользователей. (Могут посетить только index и show)


  def index
    @items = Item.all
    #render "items/index"  -  так не прописываем, т.к. рельсы автоматически это делает.   
  end

  # Экшен для Read
  # /items/new GET
  def show
    # Находим наш товар в БД
    unless @item
      # Изменим так, потому что переменная @item - это инстансная переменнная и т.к. мы её
      # инициализировали в методе find_item она уже будет доступна.
      render text: "Page not found", status: 404
    end
  end

  # Также рэндит форму и отправляет в Create
  # /items/new GET
  def new    
    # Экшн new будет рэндерить шаблон new.html.erb,
    # ,после чего форма шаблона будет отправляться в экшн create
    @item = Item.new
    # Чтобы входные данные не менялись, если не проходит валидацию.
  end

  # Экшн для Create
  # /items POST
  # POST запросы отличаются тем, что в строке адреса их невидно.
  def create
    #render text: params.inspect   
    @item = Item.create(items_params)
    if @item.errors.empty?
      # Проверяем, сохранён ли наш объект без ошибок => отправляем на информацию об объекте
      redirect_to item_path(@item)
    else
      render "new"
      # иначе возвращаем заново на создание объекта
    end
  end

  # Метод Edit будет рэндорить в браузер форму, которая будет отправлять в Update
  # /items/1/edit GET
  def edit
  end

  # Экшн для Update
  # /items/1 PUT
  def update
    @item.update_attributes(items_params)
    # Обновляет данные @item
    if @item.errors.empty?
      # Проверяем, сохранён ли наш объект без ошибок => отправляем на информацию об объекте
      redirect_to item_path(@item)
    else
      render "edit"
      # иначе возвращаем заново на создание объекта
    end
  end

  # Экшн для Destroy
  # items/1 DELETE
  # обратите внимание: метод называется DELETE, a экшн - destroy
  def destroy
    @item.destroy
    # используя метод destroy на объекте класса item для удаления
    redirect_to action: "index"
    # После удаления, обновляем
  end


  def upvote    
    @item.increment!(:votes_count)
    # Обновит значение атрибутов :votes_count, увеличив его на 1 и сохранит в б.д.
    redirect_to action: :index 
    # Редирект на список всез товаров
  end


  def expensive
  # Экшн, который показывает только те товары, стоимость которых больше 1000 рублей.
    @items = Item.where("price > 1000")
    render "index"
    # Если бы не указали render, то был бы вызван шаблон expensive.html.erb, которого нет.
  end


  private
  # Все неприватные методы являются экшенами, а метод find_item - не является экшеном.
  # Метод find_item - является before фильтром.

    def find_item
      @item = Item.where(id: params[:id]).first
      # находим товар, с которым будем работать
      render_404 unless @item
    end

    def check_if_admin
      render_403 unless params[:admin]
      # render text: "Access denied", status: 403 unless current_user.admin == true
      # так бы прописали в настоящем приложеннии, а пока только так:
    end

    def items_params
     #params.require(:item).permit(:name, :price, :description, :real, :weight)
     params.require(:item).permit!
     #      требует       запрос атрибутов, которые можно редактировать
    end

end




#  def create    
#    @item = Item.create(items_params)
#    p params
#    render text: "#{@item.id}: #{@item.name}: #{@item.price}: (#{!@item.new_record?})"
#    #              id_товара  | имя_товара | выводит_true_если_сохранен_в_б.д.   
#  end


#  private
#  def items_params
#   params.require(:item).permit(:name, :price, :description, :real, :weight)
#   #      требует       запрос атрибутов, которые можно редактировать
#  end