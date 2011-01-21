class SubscribedCoursesController < ApplicationController
  # GET /subscribed_courses
  # GET /subscribed_courses.xml
  def index
    @subscribed_courses = SubscribedCourse.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @subscribed_courses }
    end
  end

  # GET /subscribed_courses/1
  # GET /subscribed_courses/1.xml
  def show
    @subscribed_course = SubscribedCourse.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @subscribed_course }
    end
  end

  # GET /subscribed_courses/new
  # GET /subscribed_courses/new.xml
  def new
    @subscribed_course = SubscribedCourse.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @subscribed_course }
    end
  end

  # GET /subscribed_courses/1/edit
  def edit
    @subscribed_course = SubscribedCourse.find(params[:id])
  end

  # POST /subscribed_courses
  # POST /subscribed_courses.xml
  def create
    @subscribed_course = SubscribedCourse.new(params[:subscribed_course])

    respond_to do |format|
      if @subscribed_course.save
        format.html { redirect_to(@subscribed_course, :notice => 'Subscribed course was successfully created.') }
        format.xml  { render :xml => @subscribed_course, :status => :created, :location => @subscribed_course }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @subscribed_course.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /subscribed_courses/1
  # PUT /subscribed_courses/1.xml
  def update
    @subscribed_course = SubscribedCourse.find(params[:id])

    respond_to do |format|
      if @subscribed_course.update_attributes(params[:subscribed_course])
        format.html { redirect_to(@subscribed_course, :notice => 'Subscribed course was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @subscribed_course.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /subscribed_courses/1
  # DELETE /subscribed_courses/1.xml
  def destroy
    @subscribed_course = SubscribedCourse.find(params[:id])
    @subscribed_course.destroy

    respond_to do |format|
      format.html { redirect_to(subscribed_courses_url) }
      format.xml  { head :ok }
    end
  end
end
