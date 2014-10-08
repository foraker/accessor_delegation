# Accessor Delegation

Accessor delegation facilitates composition by proxying getters and setters to other objects.

## Installation

Add this line to your application's Gemfile:

    gem 'accessor_delegation'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install accessor_delegation

## Usage

An example use case for accessor delegation is a SignUp object which simultaneously creates a user and an organization.

```Ruby
class SignUp
  extend AccessorDelegation

  attr_reader :user, :organization

  delegate_accessor :first_name, :last_name, :email, to: :user
  delegate_accessor :name, to: :user, prefix: :organization

  def initialize
    @user = User.new
    @organization = Organization.new
  end
end

signup = SignUp.new

# first_name assignment delegated to the user
signup.first_name = "Draco"
signup.user.first_name
# => "Draco"

# last_name assignment delegated to the user
signup.last_name = "Malfoy"
signup.user.last_name
# => "Malfoy"

# organization name assignment delegated to the organization name method
signup.organization_name = "Slytherin"
signup.organization.name
# => "Slytherin "
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
