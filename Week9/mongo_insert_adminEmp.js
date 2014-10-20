function insertAdminEmployee(name, title, salary, division, location, hireyear) {
	return db.employees.insert({name: name, title: title, salary: salary, division: division, location: location, hire_year: hireyear});
}