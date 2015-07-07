class App < Sinatra::Application
  get '/' do
    #VARNISH
    headers['Cache-Control'] = 'public, max-age=300'
    #MEMCACHE
    color = settings.cache.fetch('color') do
      'blue'
    end
    #REDIS
    REDIS.set("#{Time.now}", "#{Time.now}")
    #RESQUE
    Resque.enqueue(Eat, "hello")

    username = [*('A'..'Z')].sample(8).join
    lastname = [*('A'..'Z')].sample(8).join

    #MONGODB/MONGOID
    u = User.create(:first_name => username, :last_name => lastname)

    #POSTGRES/ACTIVERECORD
    a = Account.create(:name => username || "mice", :owner_id => rand(1000))

    "Successfully added #{u.first_name} to MongoDB<br><br>
    Successfully added id: #{a.id || a.errors} to PostgreSQL <br><br>
    Hello from #{color} Sinatra on Heroku! #{ENV['RACK_ENV']}<br><br>
    Rendered at #{Time.now}<br><br>
    #{REDIS.keys("throttle*").map{|key| [key, REDIS.get(key)]}}<br><br>
    #{REDIS.keys("*")}<br><br>
    <a href='/resque'>resque</a>"
  end
end
