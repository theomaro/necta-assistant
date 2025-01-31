-- Table to store information about regions
CREATE TABLE regions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

-- Table to store user roles
CREATE TABLE roles (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name ENUM("admin", "support_agent", "school")
);

-- Table to store user information
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) NOT NULL UNIQUE,
    email VARCHAR(255) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    role_id INT NOT NULL,
    FOREIGN KEY (role_id) REFERENCES roles(id)
);

-- Table to store admin users (staff of the exam board)
CREATE TABLE admins (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
);

-- Table to store information about support agents
CREATE TABLE support_agents (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    region_id INT DEFAULT NULL,
    FOREIGN KEY (region_id) REFERENCES regions(id)
);

-- Table to store information about schools
CREATE TABLE schools (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    region_id INT NOT NULL,
    contact_person VARCHAR(255) NOT NULL,
    contact_email VARCHAR(255) NOT NULL,
    contact_phone VARCHAR(255) NOT NULL,
    FOREIGN KEY (region_id) REFERENCES regions(id)
);

-- Table to store support issues (tickets)
CREATE TABLE tickets (
    id INT AUTO_INCREMENT PRIMARY KEY,
    school_id INT NOT NULL,
    subject VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    priority ENUM('Low', 'Medium', 'High', 'Urgent') NOT NULL DEFAULT 'Low',
    status ENUM('Open', 'assigned', 'Pending', 'In Progress', 'Resolved', 'Escalated', 'Closed', 'Reopened') NOT NULL DEFAULT 'Pending',
    agent_assigned INT NULL,
    escalated_to INT DEFAULT NULL,
    resolved_by INT DEFAULT NULL,
    satisfaction_rating ENUM('Very Satisfied', 'Satisfied', 'Neutral', 'Dissatisfied', 'Very Dissatisfied') DEFAULT NULL,
    date_created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    date_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (school_id) REFERENCES schools(id),
    FOREIGN KEY (agent_assigned) REFERENCES support_agents(id),
    FOREIGN KEY (escalated_to) REFERENCES users(id),
    FOREIGN KEY (resolved_by) REFERENCES users(id)
);

--
CREATE TABLE attachments (
    id INT PRIMARY KEY AUTO_INCREMENT,
    ticket_id INT,
    file_name VARCHAR(255),
    file_path VARCHAR(255),
    file_type VARCHAR(50),
    date_uploaded TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ticket_id) REFERENCES tickets(ticket_id)
);

--
CREATE TABLE comments (
    id INT PRIMARY KEY AUTO_INCREMENT,
    ticket_id INT,
    user_id INT,
    comment_text TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ticket_id) REFERENCES tickets(ticket_id),
    FOREIGN KEY (user_id) REFERENCES user(id)
);

-- Table to store special cases (issues that need special handling)
CREATE TABLE special_cases (
    id INT AUTO_INCREMENT PRIMARY KEY,
    ticket_id INT NOT NULL,
    description TEXT NOT NULL,
    resolved BOOLEAN DEFAULT FALSE,
    date_created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    date_resolved TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ticket_id) REFERENCES tickets(id)
);

-- Table to store escalations (track when an issue is escalated to neighboring regions or admins)
CREATE TABLE escalations (
    id INT AUTO_INCREMENT PRIMARY KEY,
    ticket_id INT NOT NULL,
    previous_agent_id INT NULL,
    new_agent_id INT NULL,
    escalated_by INT,
    reason VARCHAR(255) NOT NULL,
    escalated_to_admin BOOLEAN DEFAULT FALSE,
    date_escalated TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ticket_id) REFERENCES tickets(id),
    FOREIGN KEY (previous_agent_id) REFERENCES support_agents(id),
    FOREIGN KEY (new_agent_id) REFERENCES support_agents(id),
    FOREIGN KEY (escalated_by) REFERENCES Users(id)
);

-- Table to store issue history (track changes in the status of issues)
CREATE TABLE ticket_History (
    id INT AUTO_INCREMENT PRIMARY KEY,
    ticket_id INT NOT NULL,
    previous_status ENUM('Pending', 'In Progress', 'Resolved', 'Escalated'),
    new_status ENUM('Pending', 'In Progress', 'Resolved', 'Escalated'),
    changed_by INT,
    date_changed TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ticket_id) REFERENCES tickets(id),
    FOREIGN KEY (changed_by) REFERENCES users(id)
);

--
CREATE TABLE Agent_Performance (
    record_id INT AUTO_INCREMENT PRIMARY KEY,
    agent_id INT,
    resolved_tickets INT,
    avg_resolution_time DECIMAL(10, 2),
    escalation_count INT,
    report_date DATE,
    FOREIGN KEY (agent_id) REFERENCES support_agents(id)
);


