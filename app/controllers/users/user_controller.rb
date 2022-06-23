# frozen_string_literal: true

module Users
  # UserController Template
  class UserController < ApplicationController
    def view_task_today
      @today_tasks = current_user.task_today
    end
  end
end
