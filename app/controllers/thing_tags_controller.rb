class ThingTagsController < ApplicationController
  before_action :set_thing_tag, only: [:show, :update, :destroy]
  before_action :set_tag, only: [:associated_things, :linkable_things]
  wrap_parameters :thing_tag, include: ["tag_id", "thing_id"]
  # GET /thing_tags
  # GET /thing_tags.json
  def index
    @thing_tags = ThingTag.all
    @thing_tags = ThingTag.where(thing_id: params["thing_id"]).with_name
  end

  # GET /thing_tags/1
  # GET /thing_tags/1.json
  def show
    render json: @thing_tag
  end

  # POST /thing_tags
  # POST /thing_tags.json
  def create

    @thing_tag = ThingTag.new(thing_tag_params.merge({thing_id: params[:thing_id], tag_id: params[:tag_id]}))
    # Check tag and thing exist
    if ! Tag.where(id: @thing_tag.tag_id).first
      render json: {errors: "Cannot find tag #{@thing_tag.tag_id}"}, status: :bad_request
    elsif ! Thing.where(id: @thing_tag.thing_id).first
      render json: {errors: "Cannot find thing #{@thing_tag.thing_id}"}, status: :bad_request
    elsif @thing_tag.save
      head :no_content
    else
      pp @thing_tag.errors.messages
      render json: {errors:@thing_tag.errors.messages}, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /thing_tags/1
  # PATCH/PUT /thing_tags/1.json
  def update
    @thing_tag = ThingTag.find(params[:id])

    if @thing_tag.update(thing_tag_params)
      head :no_content
    else
      render json: @thing_tag.errors, status: :unprocessable_entity
    end
  end

  # DELETE /thing_tags/1
  # DELETE /thing_tags/1.json
  def destroy
    @thing_tag.destroy

    head :no_content
  end

  def associated_things
    render json: Thing.with_tag(@tag).just_the_name
  end

  def linkable_things
    render json: Thing.without_tag(@tag).just_the_name
  end

  private

    def set_thing_tag
      @thing_tag = ThingTag.find(params[:id])
    end

    def set_tag
      @tag = Tag.find(params[:tag_id])
    end

    def thing_tag_params
      params.require(:thing_tag).tap {|p|
        #_ids only required in payload when not part of URI
        p.require(:tag_id)    if !params[:tag_id]
        p.require(:thing_id)    if !params[:thing_id]
      }.permit(:tag_id, :thing_id)
    end
end
