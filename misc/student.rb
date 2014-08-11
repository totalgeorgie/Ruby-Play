class Student
  def initialize(firstname, lastname)
    @firstname = firstname
    @lastname = lastname
    @courses = []
  end
  
  def name
    "#{@firstname} #{@lastname}"
  end
  
  def courses
    @courses
  end
  
  def enroll(course)
    raise "#{course} conflicts with another course" if has_conflict?(course)
    @courses << course unless @courses.include?(course)
    course.students << self
  end
  
  def has_conflict?(course)
    @courses.any? { |course2| course2.conflicts_with?(course) }
  end
  
  def course_load
    load = {}
    @courses.each do |course|
      if load[course.department].nil?
        load[course.department] = course.credits
      else
        load[course.department] += course.credits
      end
    end
    load
  end
end

class Course
  attr_reader :department, :credits, :days, :time_block
  def initialize(name, department, credits, days, time_block)
    @name = name
    @department = department
    @credits = credits
    @students = []
    @days = days
    @time_block = time_block
  end
  
  def conflicts_with?(course)
    intersecting_days = self.days & course.days
    return false if intersecting_days.empty?
    self.time_block == course.time_block
  end
  
  def students
    @students
  end
  
  def add_student(student)
    student.enroll(self)
  end
end