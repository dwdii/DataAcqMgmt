function insertProfessor(name, title, salary, departments, hireyear) {
	return db.employees.insert({name: name, title: title, salary: salary, department: departments, hire_year: hireyear});
}