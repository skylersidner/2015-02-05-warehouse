#save
#insert
#edit
#delete
#all (fetch/display) 

module Manage 
  
  def self.all                              # display / fetch
    # SELECT * FROM question;   Run in terminal Question.all
    # I want this to return all the items in a table
    # but I want them to be formatted nicely
    # and I don't know how to pull it from the correct table
    DATABASE.execute("SELECT * FROM ***** table_name *****")
  end


  # This used to be called sync
  def save (previously called sync - see below)
      # instance_variables # = [:@name, :@age, :@hometown]
      attributes = []

      instance_variable.each do |i|
        attributes << i.to_s.delete("@")
      end

      attributes.each do |a|
        value = self.send(a)
        if value.is_a?(Integer)
          query_components_array << "#{a} = #{self.send(a)}"
        else
          query_components_array << "#{a} = '#{self.send(a)}'"
        end

        q = query_components_array.join(", ")

      DATABASE.execute("UPDATE students SET #{q} WHERE id = #{@id}")
    
  end

  def edit
  end

  def delete
    DATABASE.execute("DELETE ***** FROM ***** students *****")
  end

  # Public: #insert
  # Adds the object to the table and assigns an ID
  #
  #Returns: Integer: The table assigned ID

  # Take object and insert it into the table
  def insert
    # INSERT INTO question (student_id, question) VALUES ((#{@student_id}, '#{question}'))
    # INSERT INTO question (student_id, question) VALUES (4, "What color is the rainbow?");
    # INSERT will add a new row and add a new id
    DATABASE.execute("INSERT INTO students (name, age, hometown) VALUES ('#{@name}',                     #{@age}, '#{@hometown}')")
    @id = DATABASE.last_insert_row
  end
  
end  
  #-----------------------------------
  # def sync
  #   # instance_variables # = [:@name, :@age, :@hometown]
  #   attributes = []
  #
  #   instance_variable.each do |i|
  #     attributes << i.to_s.delete("@")
  #   end
  #
  #   attributes.each do |a|
  #     value = self.send(a)
  #     if value.is_a?(Integer)
  #       query_components_array << "#{a} = #{self.send(a)}"
  #     else
  #       query_components_array << "#{a} = '#{self.send(a)}'"
  #     end
  #
  #     q = query_components_array.join(", ")
  #
  #   DATABASE.execute("UPDATE students SET #{q} WHERE id = #{@id}")
  # end
  #
  #
  #
  # def sync
  #   attributes = ["name", "age", "hometown"]
  #   query_components_array = []
  #
  #   attributes.each do |a|
  #     value = self.send(a)
  #
  #     if value.is_a?(Integer)
  #       query_components_array << "#{a} = #{self.send(a)}"
  #     else
  #       query_components_array << "#{a} = '#{self.send(a)}'"
  #     end
  #
  #     q = query_components_array.join(", ")
  #
  #     # AT the end, I want...
  #     # name = "Sumeet", age = 75, hometown = "San Diego"
  #     # to send it into this command ==>
  #   DATABASE.execute("UPDATE students SET #{q} WHERE id = #{@id}")
  # end
  #----------------------------------------------------


# DATABASE.execute("INSERT INTO students (name) VALUES ('#{@name}')")


# def
#   # SELECT * FROM question WHERE student_id = 2;
#   DATABASE.execute("SELECT * FROM question WHERE student_id = 2")
# end


  # This method takes all the attributes for this object and makes sure those are the values in this object's corresponding row in the student's table.
  # CODE: student.name="new_name"
  # def sync
  #   DATABASE.execute("UPDATE students SET name = '#{name}', age = #{age}, hometown = #{hometown} WHERE id = #{@id}")
  # end


  # 'save' is a method that you run on an instance of a Student class
#   def save
#     # If you were doing from the command line:
#     # INSERT INTO students (name) VALUES ('Andrew');
#     #Run in terminal Question.all
#
#     # YOU MUST USE SINGLE QUOTES AROUND THE STRING INTERPOLATION:
#     DATABASE.execute("INSERT INTO students (name) VALUES ('#{@name}')")
#     @id = DATABASE.last_insert_row_id     # will return the value of the row id
#   end
#
#   # Public: #questions
#   # Get the questions asked by aparticular student
#   # Returns: Array - of a hash Rows from 'questions' table for this student.
#   def questions
#     DATABASE.execute("SELECT * FROM question WHERE student_id = #{@id}")
#   end
#
#
#   # Public: #all
#   # Get all the students
#   # Returns: Array - Rows from 'students' with all students
#
#   # class method (set as class method by naming it self.____ to show that it is
#   # executed on the entire class, not just an INSTANCE of the class)
#   def self.all
#     # SELECT * FROM students;
#     DATABASE.execute("SELECT * FROM students")
#   end
#
# end


# class method is run on the class itself (not an instance of a class)
# like .new (run on the class itself) like Student.new

# you might want your own class methods if you want to run something on 
# every object of the student class (or the whole student table)

