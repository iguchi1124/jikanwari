class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  # GET /tasks
  # GET /tasks.json
  def index
    @tasks = Task.all
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    authenticate_user!
    @task = Task.new(contributor_id: current_user.id)
  end

  # GET /tasks/1/edit
  def edit
    authenticate_user!
  end

  # POST /tasks
  # POST /tasks.json
  def create
    authenticate_user!
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to root_path, notice: 'Task was successfully created.' }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    unless @task.contributor_id==current_user.id
      redirect_to root_path
      flash[:alert]='権限がありません。'
    else
      respond_to do |format|
        if @task.update(task_params)
          format.html { redirect_to root_path, notice: '登録された課題はアップデートされました。' }
          format.json { render :show, status: :ok, location: @task }
        else
          format.html { render :edit }
          format.json { render json: @task.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    authenticate_user!
    unless @task.contributor_id==current_user.id
      redirect_to root_path
      flash[:alert]='権限がありません。'
    else
      @task.destroy
      respond_to do |format|
        format.html { redirect_to root_path, notice: '登録された課題は削除されました。' }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:title, :deadline, :content, :contributor_id)
    end
end
