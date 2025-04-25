
-- Table Institutions
CREATE TABLE Institutions (
    institution_id SERIAL PRIMARY KEY,
    institution_name VARCHAR(255) NOT NULL,
    institution_type VARCHAR(20) CHECK (institution_type IN ('School', 'Kindergarten')),
    address TEXT
);

-- Table Classes
CREATE TABLE Classes (
    class_id SERIAL PRIMARY KEY,
    class_name VARCHAR(50) NOT NULL,
    institution_id INT REFERENCES Institutions(institution_id) ON DELETE CASCADE,  -- FOREIGN KEY
    direction VARCHAR(50) CHECK (direction IN ('Mathematics', 'Biology and Chemistry', 'Language Studies'))
);

-- Table Children
CREATE TABLE Children (
    child_id SERIAL PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    birth_date DATE NOT NULL,
    year_of_entry INT NOT NULL,
    age INT,
    institution_id INT REFERENCES Institutions(institution_id) ON DELETE CASCADE, -- FOREIGN KEY
    class_id INT REFERENCES Classes(class_id) ON DELETE SET NULL -- FOREIGN KEY
);

-- Table Parents
CREATE TABLE Parents (
    parent_id SERIAL PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    child_id INT REFERENCES Children(child_id) ON DELETE CASCADE,  -- FOREIGN KEY
    tuition_fee NUMERIC(10,2)
);
