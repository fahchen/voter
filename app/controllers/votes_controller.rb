# coding: utf-8
class VotesController < ApplicationController
  before_filter :signed_in_user, only: [:create, :new, :show]
  before_filter :own_user,   only: [:edit, :destroy]
	def show
		@vote = Vote.find(params[:id])
	end
  def new
  	@vote = Vote.new
  	3.times { @vote.options.build }
  end
	def create
		@vote = current_user.votes.new(params[:vote])
    @vote = validates_vote(@vote)
    if @vote
      if @vote.save
        # flash[:success] = 'create a vote succeed'
        # redirect_to root_path
        respond_to do |format|
          format.js { render js: 'location.href="/"'}
        end
      else
        # render 'new'
        render_noty("发表失败，请重试。")
      end
    end
	end
	def edit
		@vote = Vote.find(params[:id])
	end
  def update
    @vote = Vote.find(params[:id])
    if @vote.update_attributes(params[:vote])
      # redirect_to @vote, notice: "Successfully updated vote."
      respond_to do |format|
        format.js { render js: 'location.href="/votes/' + "#{@vote.id}" + '"'}
      end
    else
      render_noty("更新失败，请修改。")
    end
  end
  def cast_signal_vote
    current_vote = Vote.find(params[:vote])
    if current_vote.expiration <= Time.now
      render_noty("投票已结束，谢谢关注。")
    else
      if params[:votes].nil?
        # flash[:errors] = 'can only one'
        render_noty("投票失败，请重试。")
      else
        if params[:votes].size == 1
          if current_user.cast_votes.include?(current_vote)
              render_noty("你已投过票了。")
          else
            current_user.user_voteships.create(vote_id: params[:vote]) unless current_user.cast_votes.include?(current_vote)
            option_ids = current_user.option_ids - current_vote.option_ids
            option_ids << params[:votes][:options]
            if current_user.attributes = {'option_ids' => option_ids}
              # flash[:success] = "cast succeed"
              @statistics = statistics(current_vote)
              respond_to do |format|
                format.js {render 'cast_vote', :formats => :js}
              end
            end
          end
        else
          # flash[:errors] = 'can only one'
          render_noty("投票失败，只能投一个，请重试。")
        end
      end
    end
    # redirect_to :back
  end
  def cast_multi_vote
    current_vote = Vote.find(params[:vote])
    if current_vote.expiration <= Time.now
      render_noty("投票已结束，谢谢关注。")
    else
      if current_user.cast_votes.include?(current_vote)
          render_noty("你已投过票了。")
      else
        if params[:votes].nil?
          # flash[:errors] = 'range min max'
          render_noty("投票失败，请重试。")
        else
          if params[:votes][:option_ids].size <= current_vote.maxoptions && params[:votes][:option_ids].size >= current_vote.minoptions
            current_user.user_voteships.create(vote_id: params[:vote]) unless current_user.cast_votes.include?(current_vote)
            option_ids = current_user.option_ids - current_vote.option_ids
            # if params[:votes].nil?
            #   if current_user.attributes = {'option_ids' => option_ids}
            #     flash[:success] = "cast succeed"
            #   end
            # else
            option_ids |= params[:votes][:option_ids]
            if current_user.attributes = {'option_ids' => option_ids}
              # flash[:success] = "cast succeed"
              @statistics = statistics(current_vote)
              respond_to do |format|
                format.js {render 'cast_vote', :formats => :js}
              end
            end
            # end
          else
            # flash[:errors] = 'range min max'
            render_noty('投票失败，该投票最少选' + "#{current_vote.minoptions}" + '项,最多选' + "#{current_vote.maxoptions}" + '项，请重试。')
          end
        end
      end
    end
    # redirect_to :back
  end

  private
  def own_user
    redirect_to :root unless Vote.find(params[:id]).owner?(current_user)
  end
  def statistics(vote)
    statistics = []
    total = UserOptionship.where("option_id in (?)", vote.option_ids).count
    vote.options.each do |option|
      option_total = UserOptionship.where("option_id = ?", option.id).count
      precent = option_total / total.to_f * 100
      statistics << [option_total.to_s + '票', precent]
    end
    statistics
  end
  def render_noty(noty)
    respond_to do |format|
      format.js { render :js => 'noty({"text":"' + "#{noty}" + '","theme":"noty_theme_twitter","layout":"topLeft","type":"success","animateOpen":{"height":"toggle"},"animateClose":{"height":"toggle"},"speed":500,"timeout":2500,"closeButton":true,"closeOnSelfClick":true,"closeOnSelfOver":false,"modal":false});' }
    end
  end

  def validates_vote(vote)
    validated_vote = false
    if vote.title.length <= 2
      render_noty("发表失败，主题太短了，请修改。")
    elsif vote.title.length > 15
      render_noty("发表失败，主题太长了，超过15字了，请修改。")
    elsif vote.description.length < 6
      render_noty("发表失败，描述太短了，为了别人能够理解你的意思，请修改。")
    elsif vote.expiration <= Time.now
      render_noty("发表失败，投票截止时间已经过期，请修改。")
    elsif vote.options.size < 2
      render_noty("发表失败，选项太少了，请添加,填写。")
    else
      if vote.multi
        minoptions = vote.minoptions = vote.minoptions.nil? ? 0 : vote.minoptions
        maxoptions = vote.maxoptions = vote.maxoptions.nil? ? 0 : vote.maxoptions
        if minoptions <= 0
          # flash[:errors] = 'minoptions can not be larger than maxoptions'
          # render 'new'
          render_noty("发表失败，最少项目不能为0，请修改。")
        elsif  minoptions > maxoptions
          render_noty("发表失败，最少项数目多余最多项数目，请修改。")
        elsif maxoptions > vote.options.size
          # flash[:errors] = 'maxoptions can not be larger than the number of vote\'s options'
          # render 'new'
          render_noty("发表失败，最多项数目多余有效选项数目" + "#{vote.options.size}" + "，请修改。")
        else
          validated_vote = vote
        end
      else
        vote.minoptions = 1
        vote.maxoptions = 1
        validated_vote = vote
      end
    end
    validated_vote
  end

end
