module ForMash
  class FillsController < ApplicationController
    before_filter :authenticate_entity!
    before_filter :prepare_template, only: [:index, :create]
    before_filter :prepare_fill, only: :show
    before_filter :is_template_creator?, only: :create
    before_filter :is_authorized_to_access?, only: [:show, :index]

    def index
    end

    def show
    end

    def create
      @fill = @template.fills.build(params[:for_mash_fill].merge({creator: current_entity}))
      if @template.save
        redirect_to root_path, notice: 'Your form submission has been submitted successfully'
      else
        render template: 'for_mash/templates/show'
      end
    end

    protected

    def prepare_template
      @template = Template.find(params[:template_id])
    end

    def prepare_fill
      @fill = Fill.find(params[:id])
    end

    def is_template_creator?
      redirect_to root_path, notice: 'You cannot apply on your own templates' if current_entity == @template.creator
    end

    def is_authorized_to_access?
      template = @template || @fill.template
      redirect_to root_path, notice: 'You do not have access to view such data' unless current_entity == template.creator
    end
  end
end
