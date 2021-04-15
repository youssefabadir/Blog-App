module PostsHelper
    
    def post_author(post)
        user_signed_in? && current_user.id == post.user_id
    end

    def comment_author(comment)
        user_signed_in? && current_user.id == comment.user_id
    end
end
