function insertProfessor(name, title, salary, departments, hireyear) {
	db.employees.insert({name: name, title: title, salary: salary, department: departments, hire_year: hireyear});
}