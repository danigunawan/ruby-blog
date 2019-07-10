class PostsController < ApplicationController
    before_action :authorize_request, except: [:getAllPost, :getPostById]
    before_action :set_post, only: [:createPost, :getPostByUser, :editPostByUser, :deletePost]
    before_action :findPost, only:[:getPostById]
    before_action :set_post_user, only:[:editPostByUser, :deletePost]

    def createPost
        if @current_user.posts.create(post_params)
            render :json=>{message:"post created successfully"}
        else
            render :json=>{message:"error creating post"}
        end
    end

    def getAllPost
        @posts = Post.all
        render :json=>{message: @posts}
    end

    def getPostById
        render :json=>{message:@post_id}
    end

    def editPostByUser
        if @post.update(post_params)
            render :json=>{message:"update successful"}, status: :ok 
         else
             render :json=>{message: 'unauthorised'}
         end
    end

    def getPostByUser
        render :json=>{message:@current_user.posts}
    end

    def deletePost
        @post.destroy
        render :json =>{message:"delete successful"}
    end

    private
    def post_params
        params.permit(:content, :title)
    end

    def findPost
        @post_id = Post.find(params[:id])
      end

        def set_post
            @current_user
        end

        def set_post_user
            @post = @current_user.posts.find_by!(id: params[:id]) if @current_user
          end
end
