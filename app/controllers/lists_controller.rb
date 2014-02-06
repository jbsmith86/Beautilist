class ListsController < ApplicationController
  before_action :set_list, only: [:show, :edit, :update, :destroy]

  def index
    @lists = List.all.where(parent_id: nil)
  end

  def new
    @list = List.new
    @list.children.build
  end

  def create
    @list = List.new(list_params)
    if @list.save
      redirect_to lists_path
    end
  end

  def show
    @list = List.find(params[:id])
  end

  def edit
  end

  def update
    if @list.update(list_params)
      redirect_to lists_path
    end
  end

  def destroy
    if @list.destroy
      redirect_to lists_path
    end
  end

  private

  def set_list
    @list = List.find(params[:id])
  end

  def list_params
    params.require(:list).permit(:name, :parent_id, children_attributes: [:name, :parent_id, :id, :_destroy])
  end
end
