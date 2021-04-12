def home(request, slug):
    if request.method == 'POST':
        form_1_data_dict = {}
        form_2_data_dict = {}
 
        for key in request.POST.keys():
            v = request.POST.getlist(key)
            form_1_data_dict[key] = v[0]
            form_2_data_dict[key] = v[1]
 
        form_1 = MainGuestForm(form_1_data_dict)
        form_2 = SecondGuestForm(form_2_data_dict)
        if form_1.is_valid() and form_2.is_valid():
            .......
        else:
            .......
            if __name__ == '__main__':
    class Student:
        def __init__(self, name, score):
            self.name = name
            self.score = score
        
        def __str__(self):
            return f'{self.name} : {self.score}'
    
            
    def get_min_grade(students):
        min_grade = 100000
        for stud in students:
            if stud.score <= min_grade:
                min_grade = stud.score
        
        return min_grade
      
    students = []
    for _ in range(int(input())):
        name = input()
        score = float(input())
        students.append(Student(name=name, score=score))
    
    min_grade = get_min_grade(students)
    students  = [stud for stud in students if stud.score != min_grade]
   
    
    min_grade = get_min_grade(students)
    students  = [stud for stud in students if stud.score == min_grade]
    students.sort(key = lambda x: x.name)
    for stud in students:
        print(stud.name)
          if __name__ == '__main__':
    class Student:
        def __init__(self, name, score):
            self.name = name
            self.score = score
        
        def __str__(self):
            return f'{self.name}'
    
            
    def get_min_grade(students):
        min_grade = 100000
        for stud in students:
            if stud.score <= min_grade:
                min_grade = stud.score
        
        return min_grade
        
    students = []
    for _ in range(int(input())):
        name = input()
        score = float(input())
        students.append(Student(name=name, score=score))
    
    min_grade = get_min_grade(students)
    students  = [stud for stud in students if stud.score != min_grade]
   
    
    min_grade = get_min_grade(students)
    students  = [stud for stud in students if stud.score == min_grade]
    students.sort(key = lambda x: x.name)
    for stud in students:
        print(stud)
          if __name__ == '__main__':
          class Student:
        def __init__(self, name, score):
            self.name = name
            self.score = score
        
        def __str__(self):
            return f'{self.name}'
    
            
    def get_min_grade(students):
        min_grade = float('inf')
        for stud in students:
            if stud.score <= min_grade:
                min_grade = stud.score
        
        return min_grade
        
    students = []
    for _ in range(int(input())):
        name = input()
        score = float(input())
        students.append(Student(name=name, score=score))
    
    min_grade = get_min_grade(students)
    students  = [stud for stud in students if stud.score != min_grade]
   
    
    min_grade = get_min_grade(students)
    students  = [stud for stud in students if stud.score == min_grade]
    students.sort(key = lambda x: x.name)
    for stud in students:
        print(stud)
