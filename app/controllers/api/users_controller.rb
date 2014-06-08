module Api
  class UsersController < Api::ApplicationController

    def index
      # before: 
      # @users = User.paginate(page_params).order(order)
      # @users = @users.where(filter_params) if filter_params
      # @users = @users.where("(name ilike :q) or (email ilike :q)", q: "%#{ params[:q]}%" ) if params[:q].to_s != ''
      
      # filter and user search now:
      @users = User.paginate(page_params).order(order)
      @users = @users.filter(params[:filter]) unless params[:filter].blank?
      @users = @users.fulltext_search(params[:q]) unless params[:q].blank?
    end

    def show
    end

    def edit
    end

    def update
    end

    def destroy
    end

    def default_order
      'name ASC'
    end

    private
      def set_user
        @user = User.find_by_id(params[:id])
        if @user.nil?
          render :status => :not_found, :text => 'not_found' 
          return
        end
      end

      # this filter was remove into model. See User.rb scopes
      #
      # def filter_params
      #   return if !params[:filter]
      #   filter = {}
      #   filter[:gender] = params[:filter][:gender].to_i if (params[:filter].has_key?(:gender) and !params[:filter][:gender].blank?)
      #   filter[:age] = params[:filter][:age].to_i if (params[:filter].has_key?(:age) and !params[:filter][:age].blank?)
      #   return nil if filter.empty?
      #   filter
      # end

      def user_params
        params.require(:user).permit(:id,:name,:password,:password_confirmation, :age, :gender)
      end

  end
end