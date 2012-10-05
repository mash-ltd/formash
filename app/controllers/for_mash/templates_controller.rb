module ForMash
  class TemplatesController < ApplicationController
    before_filter :authenticate_entity!
    before_filter :prepare_template, only: [:show, :edit, :update, :destroy]
    before_filter :is_template_creator?, only: [:edit, :update, :destroy]
    before_filter :can_create_templates?, only: [:new, :create]
    before_filter :prepare_statistics
    
    def index
      @templates = Template.all
    end

    def new
      @template = Template.new
    end

    def create
      @template = Template.new(params[:for_mash_template])
      @template.creator = current_entity
      
      respond_to do |format|
        if @template.save
          format.html { redirect_to @template, notice: 'Template has been added successfully.' }
        else
          format.html { render action: :new }
        end
      end
    end

    def show
    end
    
    def edit
    end

    def update
      respond_to do |format|
          format.html { redirect_to @template, notice: 'Template has been edited successfully.' }
        if @template.update_attributes(params[:for_mash_template])
        else
          format.html { render action: :edit }
        end
      end
    end

    def destroy
      @template.destroy
      
      respond_to do |format|
        format.html { redirect_to [:templates], notice: 'Template has been deleted successfully.' }
      end
    end

    
  private
    
    def prepare_template
      @template = Template.find(params[:id])
    end

    def prepare_statistics
      @count = Template.count
      @last_created = Template.desc(:created_at).first.try(:created_at)
    end

    def can_create_templates?
      redirect_to root_path, notice: "You don't have the privilige to create a form" if current_entity.try(:can_create_forms?)
    end

    def is_template_creator?
      redirect_to root_path, notice: 'You are not the creator of this form' if @template.creator != current_entity
    end
  end
end