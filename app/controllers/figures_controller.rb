class FiguresController < ApplicationController

  get '/figures' do
    @figures = Figure.all
    erb :'/figures/index'
  end

  get '/figures/new' do
    erb :'/figures/new'
  end

  post '/figures' do
    @figure = Figure.find_or_create_by(name: params[:figure][:name])
    if !!params[:figure][:title_ids]
    params[:figure][:title_ids].each do |title|
      x = Title.find(title)
      @figure.titles << x
      end
    end
     if !!params[:figure][:landmark_ids]
    params[:figure][:landmark_ids].each do |l|
      y = Landmark.find(l)
      @figure.landmarks << y
      end
    end
    if !params[:title][:name].empty?
    @figure.titles << Title.create(name: params[:title][:name])
    end
    if !params[:landmark][:name].empty?
    @figure.landmarks << Landmark.create(name: params[:landmark][:name])
    end
    @figure.save
    redirect "figures/#{@figure.id}"
  end

  get '/figures/:id' do
    @figure = Figure.find(params[:id])
    erb :'/figures/show'
  end

  post '/figures/:id' do
    @figure = Figure.find(params[:id])
    @figure.name = params[:figure][:name]
    @figure.titles.delete_all
    @figure.landmarks.delete_all
    if !params[:title][:name].empty?
    @figure.titles << Title.create(name: params[:title][:name])
    end
    if !params[:landmark][:name].empty?
    @figure.landmarks << Landmark.create(name: params[:landmark][:name])
    end
    if !!params[:figure][:title_ids]
    params[:figure][:title_ids].each do |title|
      x = Title.find(title)
      @figure.titles << x
      end
    end
     if !!params[:figure][:landmark_ids]
    params[:figure][:landmark_ids].each do |l|
      y = Landmark.find(l)
      @figure.landmarks << y
      end
    end

    @figure.save
    redirect "figures/#{@figure.id}"
  end

  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    erb :'/figures/edit'
  end


end
