module ForMash
  class FillsController < ApplicationController
    before_filter :authenticate_entity!
    before_filter :prepare_template, only: [:index, :create]
    before_filter :prepare_fill, only: :show

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
  end
end
