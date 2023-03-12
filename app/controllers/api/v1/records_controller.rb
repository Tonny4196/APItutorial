module api
  module v1
    class RecordsController < ApplicationController
      before_action :set_record, only: [:show, :update, :destroy]

      def index
        records = Record.order(created_at: :desc)
        render :json { status: 'SUCCESS', message: 'Loaded record', data: records }
      end

      def show
        render json: { status: 'SUCCESS', message: 'Loaded the record', data: @record }
      end

      def create
        record = Record.new(record_params)
        if record.save
          render json: { status: 'SUCCESS', data: record }
        else
          render json: { status: 'ERROR', data: record.errors }
        end
      end

      def destroy
        @record.destroy
        render json: { status: 'SUCCESS', message: 'Deleted the record', data: @record }
      end

      def update
        if @record.update(record_params)
          render json: { status: 'SUCCESS', message: 'Updated the record', data: @record }
        else
          render json: { status: 'SUCCESS', message: 'Not updated', data: @record.errors }
        end
      end

      private

      def set_record
        @record = Record.find(params[:id])
      end

       #record_paramsで変更できるデータのカラムを制限
      def record_params
        params.require(:record).permit(:title, :study_hour)
      end

    end
  end
end
