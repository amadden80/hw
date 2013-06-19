
class VideoObjsController < ApplicationController  
  def index
    @videos=VideoObj.all
  end

  def show
    @video = VideoObj.find(params[:id])
  end

  def new
    puts @video = VideoObj.new
  end

  def create
    @video = VideoObj.new(params[:video_obj])
    @video.save!
    redirect_to video_objs_path
  end

  def edit
    @video = VideoObj.find(params[:id])
  end

  def update
    VideoObj.find(params[:id]).update_attributes(params[:video_obj])
    redirect_to video_objs_path
  end

  def destroy
    VideoObj.find(params[:id]).destroy
    redirect_to video_objs_path
  end

end
