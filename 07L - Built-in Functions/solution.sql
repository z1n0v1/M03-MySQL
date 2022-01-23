USE book_library;

#---- 01. Find Book Titles

SELECT title FROM books WHERE substr(title, 1, 3) = 'The';

#---- 02. Replace Titles

SELECT replace(title, 'The', '***') FROM books WHERE substr(title, 1, 3) = 'The';

#---- 03. Sum Cost of All Books

SELECT format(SUM(cost), 2) FROM books;

#---- 04. Days Lived

SELECT  concat_ws(' ', first_name, last_name) as 'Full Name',
		timestampdiff(DAY, born, died) as 'Days Lived'
        FROM authors;
        
#---- 05. Harry Potter Books

SELECT title FROM books WHERE title LIKE 'Harry Potter%';
