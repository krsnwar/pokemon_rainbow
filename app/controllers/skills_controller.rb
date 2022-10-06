class SkillsController < ApplicationController
  
  def index
    if params[:search].present?
      @search_name = params[:search]
      @skills = Skill.where("skills.name LIKE ?", "%#{@search_name}%")
      @skills = @skills.page (params[:page])
    else
      @skills = Skill.order(:id).page params[:page]
    end
    @current_page = params[:page].present? ? params[:page].to_i : 1
  end
  
  def show
    @skill = Skill.find(params[:id])
  end

  def new
    @skill = Skill.new
  end

  def create
    @skill = Skill.new(skill_params)
    
    if @skill.valid? && @skill.save
      redirect_to @skill, flash: { message: "Successfully created skill: #{@skill.name.titleize}" }
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @skill = Skill.find(params[:id])
  end

  def update
    @skill = Skill.find(params[:id])

    if @skill.update(skill_params)
      redirect_to @skill, flash: { message: "Skill has successfully been edited" }
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @skill = Skill.find(params[:id])
    skill_name = @skill.name
    @skill.destroy

    redirect_to skills_path, flash: { message: "Skill #{skill_name.titleize} has successfully been deleted" }, status: :see_other
  end

  private
    def skill_params
      params.require(:skill).permit(:name, :power, :max_pp, :element_type)
    end

end
