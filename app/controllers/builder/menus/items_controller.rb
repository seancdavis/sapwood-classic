class Builder::Menus::ItemsController < BuilderController

  include MenusHelper

  def index
  end

  def new
    @current_menu_item = MenuItem.new
  end

  def create
    @current_menu_item = MenuItem.new(create_params)
    if current_menu_item.save
      redirect_to(
        builder_route([current_menu, current_menu_item], :index),
        :notice => 'Menu item created successfully!'
      )
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if current_menu_item.update(update_params)
      redirect_to(
        builder_route([current_menu, current_menu_item], :index),
        :notice => 'Menu item updated successfully!'
      )
    else
      render 'edit'
    end
  end

  def destroy
    current_menu_item.destroy
    redirect_to(
      builder_route([current_menu, current_menu_items], :index),
      :notice => 'Menu item deleted successfully!'
    )
  end

  private

    def create_params
      params.require(:menu_item).permit(:page_id, :title, :url, :in_list)
        .merge(:menu => current_menu)
    end

    def update_params
      params.require(:menu_item).permit(:page_id, :title, :url)
    end

end
