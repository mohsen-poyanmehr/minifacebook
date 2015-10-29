class SearchesController < ApplicationController
    def search
        #i = 0
        find = params[:search]
        if User.where(name: find).length != 0
          redirect_to "/search/#{find}"
        else
          flash[:error]="there isn't user with this name"
          redirect_to '/homepage'
        end
        #User.each do |user|
         # array[i] = user.find_by_name(find)
          #i++
        #end
        #if array[i]
         # redirect_to "/search/#{find}"
        #else
         # flash[:error]="there isn't user with this name"
          #redirect_to request.referer
        #end
        #if User.find_by_email(find)
         #   redirect_to "/search/#{find}"
        #else
         #   flash[:error]="there isn't user with this name"
         #   redirect_to request.referer
        #end
    end


   def result_search
    @users=User.where(name: params[:find])
   end
end
