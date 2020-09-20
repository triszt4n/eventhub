class EventsController < ApplicationController
  # before_action :set_event, only: [:show, :edit, :update, :destroy]

  # GET /events
  def index
    # @events = Event.all
    @events = []
    @events << Event.new(id: 1, title: "Mozart Enthusiasts' Night", theme: "Talking night, Classical music", 
      short_desc: "Welcome, dear Sir! We invite you to a wonderous night at the Cafe Mozarteum to have a pleasant discussion about our lord and saviour Wolfgang Theophilius Amadeus Mozart.",
      published: true, start_date: DateTime.new(2020,1,1,10,30,0), end_date: DateTime.new(2020,1,1,11,30,0), place: "Cafe Mozarteum, Salzburg", user_id: 1)
    @events << Event.new(id: 2, title: "Live Aid 1985", theme: "Charity concert, Good cause",
      short_desc: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
      published: true, start_date: DateTime.new(1985,7,13,9,0,0), end_date: DateTime.new(1985,7,13,22,0,0), place: "Wembley Stadium, London, UK", user_id: 1) 
  end

  # GET /events/1
  def show
    @event = Event.new(id: 1, title: "Live Aid 1985", theme: "Charity concert, Good cause",
      full_desc: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
      published: true, start_date: DateTime.new(1985,7,13,9,0,0), end_date: DateTime.new(1985,7,13,22,0,0), place: "Wembley Stadium, London, UK", user_id: 1) 
    user1 = User.new(id: 1, email: "fgh@asd.com", name: "Ludwig van Beethoven", city: "Bonn, DE", profile: "Classical music", 
      about: "Lorem ipsum dolor sit amet", public: true)
    user1.followers = [User.new, User.new]
    user2 = User.new(id: 2, email: "asd@asd.com", name: "Wolfgang Amadeus Mozart", city: "Salzburg, AT", profile: "Classical music", 
      about: "Lorem ipsum dolor sit amet", public: true)
    user2.followers = [User.new, User.new, User.new, User.new, User.new]
    @event.users = [user1, user2]
    @event.posts = []
    @event.posts << Post.new(id: 1, title: 'Hello everybody', body: 'And welcome to the greatest festival of all.', created_at: DateTime.new(2020,9,11,9,9,0))
    @event.posts << Post.new(id: 2, title: 'Try1', body: 'Lorem ipsum dolor sit amet.', created_at: DateTime.new(2020,9,11,8,11,0))
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
    @event = Event.new(id: 1, title: "Live Aid 1985", theme: "Charity concert, Good cause",
      full_desc: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
      published: true, start_date: DateTime.new(1985,7,13,9,0,0), end_date: DateTime.new(1985,7,13,22,0,0), place: "Wembley Stadium, London, UK", user_id: 1) 
  end

  # POST /events
  def create
    @event = Event.new(event_params)

    if @event.save
      redirect_to @event
    else
      render :new
    end
  end

  # PUT /events/1
  def update
    if @event.update(event_params)
      redirect_to @event
    else
      render :edit
    end
  end

  # DELETE /events/1
  def destroy
    @event.destroy
    redirect_to events_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    # def set_event
    #   @event = Event.find(params[:id])
    # end

    # Only allow a list of trusted parameters through.
    def event_params
      params.require(:event).permit(:title, :theme, :short_desc, :full_desc, :published, :start_date, :end_date, :place)
    end
end
