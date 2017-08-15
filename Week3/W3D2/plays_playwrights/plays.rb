require 'sqlite3'
require 'singleton'

class PlayDBConnection < SQLite3::Database
  include Singleton

  def initialize
    super('plays.db')
    self.type_translation = true
    self.results_as_hash = true
  end
end

class Play
  attr_accessor :title, :year, :playwright_id

  def self.all
    data = PlayDBConnection.instance.execute("SELECT * FROM plays")
    data.map { |datum| Play.new(datum) }
  end

  def self.find_by_title(title)
    play = PlayDBConnection.instance.execute(<<-SQL, title)
      SELECT
        *
      FROM
        plays
      WHERE
        title = ?
    SQL

    return nil if play.empty?

    Play.new(play.first) #So we get the first element (and only element) in the play array
  end

  def self.find_by_playwright(name)
    playwright = Playwright.find_by_name(name)
    raise "#{name} not found in database" unless playwright #Aka unless it isn't nil

    plays = PlayDBConnection.instance.execute(<<-SQL, playwright.id)
      SELECT
        *
      FROM
        plays
      WHERE
        playwright_id = ?
    SQL
    #Returns all plays written by this person, as new instances

    plays.map { |play| Play.new(play) }
  end

  def initialize(options)
    @id = options['id']
    @title = options['title']
    @year = options['year']
    @playwright_id = options['playwright_id']
  end

  def create
    raise "#{self} already in database" if @id
    PlayDBConnection.instance.execute(<<-SQL, @title, @year, @playwright_id)
      INSERT INTO
        plays (title, year, playwright_id)
      VALUES
        (?, ?, ?)
    SQL
    @id = PlayDBConnection.instance.last_insert_row_id
  end

  def update
    raise "#{self} not in database" unless @id
    PlayDBConnection.instance.execute(<<-SQL, @title, @year, @playwright_id, @id)
      UPDATE
        plays
      SET
        title = ?, year = ?, playwright_id = ?
      WHERE
        id = ?
    SQL
  end
end

class Playwright
  attr_accessor :name, :birth_year
  attr_reader :id

  def self.all
    data = PlayDBConnection.instance.execute("SELECT * FROM playwrights")
    data.map { |datum| Playwright.new(datum) }
  end

  def self.find_by_name(name)
    person = PlayDBConnection.instance.execute(<<-SQL, name)
      SELECT
        *
      FROM
        playwrights
      WHERE
        name = ?
    SQL

    return nil if person.empty?

    Playwright.new(person.first)
  end

  def initialize(options)
    @id = options['id'] #Will become nil if the user doesn't provide it / it doesn't exist
    @name = options['name']
    @birth_year = options['birth_year']
  end

  def create
    #Can't create a new entry in the table if this id exists already
    raise "#{self} already in database" if @id
    PlayDBConnection.instance.execute(<<-SQL, @name, @birth_year)
      INSERT INTO
        playwrights (name, birth_year)
      VALUES
        (?, ?)
    SQL

    #We want to update the @id if we create it so that we cannot create
    #a new entry with this new @id later
    #Use our handy method:  last_insert_row_id

    @id = PlayDBConnection.instance.last_insert_row_id
  end

  def update
    #Can't update the row if it's not in the DB
    raise "#{self} not in database" unless @id
    PlayDBConnection.instance.execute(<<-SQL, @name, @birth_year, @id)
      UPDATE
        playwrights
      SET
        name = ?, birth_year = ?
      WHERE
        id = ?
    SQL
  end

  def get_plays
    raise "#{self} not in database" unless @id

    plays = PlayDBConnection.instance.execute(<<-SQL, @id)
      SELECT
        *
      FROM
        plays
      WHERE
        playwright_id = ?
    SQL
    #Returns all plays written by this person as new instances

    plays.map { |play| Play.new(play) }
  end
end
