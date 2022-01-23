SELECT  concat_ws(' ', first_name, last_name) as 'Full Name',
		timestampdiff(DAY, born, died) as 'Days Lived'
        FROM authors;