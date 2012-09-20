module ForMash
  class TemplatesController < ApplicationController
    before_filter :prepare_statistics
    
    def index
      @templates = Template.all
    end

    def new
      @template = Template.new
    end

    def create
      @template = Template.new(params[:template])
      
      respond_to do |format|
        if @template.save
          format.html { redirect_to @template, notice: 'Template has been added successfully.' }
        else
          format.html { render action: :new }
        end
      end
    end

    def edit
      @template = Template.find(params[:id])
    end

    def update
      @template = Template.find(params[:id])

      respond_to do |format|
        if @template.update_attributes(params[:template])
          format.html { redirect_to @template, notice: 'Template has been edited successfully.' }
        else
          format.html { render action: :edit }
        end
      end
    end

    def destroy
      @template = Template.find(params[:id])
      @template.destroy
      
      respond_to do |format|
        format.html { redirect_to [:templates], notice: 'Template has been deleted successfully.' }
      end
    end
    
  private
    
    def prepare_statistics
      @count = Template.count
      @last_created = Template.desc(:created_at).first.try(:created_at)
    end
  end
end