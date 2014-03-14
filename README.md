## Usage

#### Configuration
```ruby
# Initialize your Sendcloud object:
Sendcloud.configure do |config|
  config.api_user  = 'your-api-user'
  config.api_key = 'your-api-key'
end

@sendcloud = Sendcloud()

# or alternatively:
@sendcloud = Sendcloud(:api_user => 'your-api-user', :api_key => 'your-api-key')
```

#### Mail
```ruby
# send email
parameters = {
  :to => "to1@sendcloud.com;to2@sendcloud.com",
  :subject => "ruby 调用WebAPI测试主题",
  :html => '欢迎使用<a href="https://sendcloud.sohu.com">SendCloud</a>',
  :from => "from@sendcloud.com"
}
@sendcloud.mail.send_email(parameters)

# send_template
parameters = {
  :template_invoke_name => 'sendcloud_template',
  :subject => "邮件模板",
  :from => "post@sendcloud.org",
  :fromname => "Sender",
  :substitution_vars => '{"to": ["to1@sendcloud.org", "to2@sendcloud.org"], "sub" : { "%name%" : ["yoyo", "jim"], "%money%" : ["1000", "200"]} }'
}
@sendcloud.mail.send_template(parameters)
```

#### Stats
```ruby
# categories list 
@sendcloud.stats.get_categories

# get stats by params
# options: 
# :days, :start_date, :end_date, :category, :aggregate
@sendcloud.stats.get({:days => 2})
```

#### Unsubscribes
```ruby
# List last unsubscribes(100 limit)
# options:
# :days, :start_date, :end_date, :start, :limit, :email
@sendcloud.unsubscribes.list

# Add unsubscribe
@sendcloud.unsubscribes.add("user@mail.com")

# Remove unsubscribes
# options:
# :start_date, :end_date, :email
@sendcloud.unsubscribes.remove({:email => "user@mail.com"})

```

#### Bounces
```ruby
# List last bounces (100 limit)
@sendcloud.bounces.list

# bounces count
# options:
# :days, :start_date, :end_date
@sendcloud.bounces.count

# Add bounce
@sendcloud.bounces.add("user@mail.com")

# Remove bounces
# options:
# :email, :start_date, :end_date
@sendcloud.bounces.delete({
	:email => "user@mail.com"
})
```