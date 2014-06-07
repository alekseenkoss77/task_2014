module Api
  class MeetingsController < Api::ApplicationController
    
    before_action :set_meeting, only: [:show, :destroy, :update]

    def index
      @meetings = Meeting.paginate(page_params).order(order)
      @meetings = @meetings.where("name ilike :q", q: "%#{ params[:q]}%" ) if params[:q].to_s != ''
    end

    def show
      @users = @meeting.participants
    end

    def create
      @meeting = Meeting.new meeting_params
      unless @meeting.save
        render status: :forbidden, json: @meeting.errors.full_messages; return
      end
      create_participants
      render 'show'
    end

    def update
      unless @meeting.update_attributes meeting_params
        render status: :forbidden, json: @meeting.errors.full_messages; return
      end
      create_participants
      render 'show'
    end

    def destroy
      @meeting.destroy
      render 'show'
    end

    def default_order
      'started_at DESC'
    end

    private
      def create_participants
        return if not participants_params
        participants_params.each { |p| @meeting.add_user(p[:id],p[:role]) }
        @meeting.save
      end

      def participants_params
        params[:participants]
      end

      def set_meeting
        @meeting = Meeting.find_by_id(params[:id])
        if @meeting.nil?
          render :status => :not_found, :text => 'not_found' 
          return
        end
      end

      def meeting_params
        params.require(:meeting).permit(:id,:name,:started_at,:started_at_date,:started_at_time)
      end
  end
end