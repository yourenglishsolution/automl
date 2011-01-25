class InstantiatedCoursesController < ApplicationController
  # GET /instantiated_courses
  # GET /instantiated_courses.xml
  def index
    @instantiated_courses = InstantiatedCourse.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @instantiated_courses }
    end
  end

  # GET /instantiated_courses/1
  # GET /instantiated_courses/1.xml
  def show
    @instantiated_course = InstantiatedCourse.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @instantiated_course }
    end
  end

  # GET /instantiated_courses/new
  # GET /instantiated_courses/new.xml
  def new
    @instantiated_course = InstantiatedCourse.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @instantiated_course }
    end
  end

  # GET /instantiated_courses/1/edit
  def edit
    @instantiated_course = InstantiatedCourse.find(params[:id])
  end

  # POST /instantiated_courses
  # POST /instantiated_courses.xml
  def create
    @instantiated_course = InstantiatedCourse.new(params[:instantiated_course])

    respond_to do |format|
      if @instantiated_course.save
        format.html { redirect_to(@instantiated_course, :notice => 'Instantiated course was successfully created.') }
        format.xml  { render :xml => @instantiated_course, :status => :created, :location => @instantiated_course }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @instantiated_course.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /instantiated_courses/1
  # PUT /instantiated_courses/1.xml
  def update
    @instantiated_course = InstantiatedCourse.find(params[:id])

    respond_to do |format|
      if @instantiated_course.update_attributes(params[:instantiated_course])
        format.html { redirect_to(@instantiated_course, :notice => 'Instantiated course was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @instantiated_course.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /instantiated_courses/1
  # DELETE /instantiated_courses/1.xml
  def destroy
    @instantiated_course = InstantiatedCourse.find(params[:id])
    @instantiated_course.destroy

    respond_to do |format|
      format.html { redirect_to(instantiated_courses_url) }
      format.xml  { head :ok }
    end
  end
end
