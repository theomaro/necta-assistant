# Customer Support System for National Exam Board (NECTA)

A CRM application designed for an National Examination Council of Tanzania (NECTA) to manage school support efficiently.

## Overview

### Purpose of the System

The National Exam Board requires a system to manage customer support requests from schools regarding candidate registration, student transfers, disqualification appeals, repeaters, and other exam-related issues. Issues will be handled region-wise by support agents assigned to that specific regions. The system ensures that issues are handled in a timely manner while maintaining customer satisfaction.

### Key Features

- **Regional Support:** Issues are handled by support agents assigned to specific regions.
- **Escalation Mechanism:** If no agent is assigned in a region, issues escalate to a neighboring region's agent. If no neighboring agent is available, issues escalate to an admin.
- **Special Handling:** In cases where a region has no assigned agent, a neighboring agent can handle issues outside their designated region.
- **Role-Based Access:**
  - **Schools:** Can submit support requests.
  - **Support Agents:** Handle support requests from assigned regions.
  - **Admins:** Manage support agents and handle escalated issues.
- **Timely Resolution:** Ensures quick response and resolution to maintain customer satisfaction.

### User Roles, Permissions and Responsibilities

#### Responsibilities By Role

| **User Role** | **Responsibilities** |
|--------------|----------------------|
| **School Users** | Report issues (tickets), track status, receive notifications. |
| **Support Agents** | Handle tickets within their region, escalate if needed, communicate with schools. |
| **Admins (Exam Board Staff)** | Maanage users, Oversee all tickets, assign agents, handle escalations, monitor performance. |

#### Permissions by Role

| Action | School User | Support Agent | Admin |
|--------|------------|---------------|-------|
| Create a ticket | ✅ | ❌ | ❌ |
| View own tickets | ✅ | ✅ (assigned only) | ✅ (all) |
| Update ticket status | ❌ | ✅ | ✅ |
| Assign/reassign tickets | ❌ | ❌ | ✅ |
| Escalate tickets | ❌ | ✅ (to admin) | ✅ |
| Manage support agents | ❌ | ❌ | ✅ |
| View reports & analytics | ❌ | ❌ | ✅ |

## Database Design

### Entities & Relationships

This section describes possible entities and how they relate to each other.

- Entities

  - **Schools**: Schools that report issues. Each school belongs to a specific region.
  - **Support Agents**: Agents assigned to specific region to handle school issues.
  - **Tickets (Issues)**: Problems reported by schools, assigned to agents, and tracked until resolution.
  - **Regions**: Geographic areas where schools and support agents are grouped.
  - **Users**: System users, including admin, support agents, and school users.
  - **Escalations**: Tracks escalated tickets when no agent is available.
  - **Ticket History**: Logs status updates and assignments for tracking.

- Relationships

  - **Schools → Issues**: A school can report multiple issues, but each issue belongs to only one school.
  - **Issues → Support Agents**: A ticket is assigned to one support agent at a time, but each support agent can handle multiple tickets.
  - **Support Agents → Regions**: Each support agent belongs to one region, but a region can have multiple agents.
  - **School → Regions**: Each school belongs to one region, but a region can have multiple schools.
  - **Admins → System**: Admins manage oversee the entire system, manage school users and assign agents, and oversee issue resolution.

### Relational Database Schema

### `Regions` Table

| Column     | Data Type   | Description                          |
|------------|-------------|--------------------------------------|
| `region_id`| INT (PK)    | Unique identifier                    |
| `name`     | VARCHAR     | Name of the region                   |

### `Roles` Table

| Column     | Data Type   | Description                  |
|------------|-------------|------------------------------|
| `role_id`  | INT (PK)    | Unique identifier            |
| `role_name`| VARCHAR     | Role (School, Agent, Admin)  |

### `Users` Table

| Column          | Data Type   | Description                        |
|-----------------|-------------|------------------------------------|
| `user_id`       | INT (PK)    | Unique user identifier             |
| `name`          | VARCHAR     | User's full name                   |
| `email`         | VARCHAR     | Login email                        |
| `password_hash` | VARCHAR     | Encrypted password                 |
| `role`          | VARCHAR     | Role (School, Agent, Admin)        |

### `Admins` Table

| Column      | Data Type   | Description                          |
|-------------|-------------|--------------------------------------|
| `admin_id`  | INT (PK)    | Unique identifier                    |
| `name`      | VARCHAR     | Admin’s name                         |
| `email`     | VARCHAR     | Contact email                        |

### `Support_Agents` Table

| Column     | Data Type   | Description                          |
|------------|-------------|--------------------------------------|
| `agent_id` | INT (PK)    | Unique identifier                    |
| `name`     | VARCHAR     | Agent’s name                         |
| `email`    | VARCHAR     | Contact email                        |
| `region_id`| INT (FK)    | Links to `Regions` table             |

### `Schools` Table

| Column          | Data Type   | Description                          |
|-----------------|-------------|--------------------------------------|
| `id`            | INT (PK)    | Unique identifier                    |
| `name`          | VARCHAR     | School name                          |
| `region_id`     | INT (FK)    | Links to `Regions` table             |
| `contact_person`| VARCHAR     | Name of school representative        |
| `contact_email` | VARCHAR     | Email of representative              |
| `contact_phone` | VARCHAR     | Phone number of representative       |

### `Tickets` Table

| Column Name   | Data Type   | Description                                                |
|---------------|-------------|------------------------------------------------------------|
| `ticket_id`   | INT (PK)    | Unique ticket identifier                                   |
| `school_id`   | INT (FK)    | School reporting the issue                                 |
| `region_id`   | INT (FK)    | Automatically linked based on school’s region              |
| `agent_id`    | INT (FK, Nullable) | Assigned support agent (can be null initially)            |
| `status`      | VARCHAR     | Current ticket status (Open, Assigned, In Progress, Escalated, Resolved, Closed) |
| `category`    | VARCHAR     | Type of issue (Registration, Transfers, etc.)              |
| `priority`    | VARCHAR     | Priority level (Low, Medium, High, Urgent)                 |
| `created_at`  | TIMESTAMP   | Timestamp of when the ticket was created                   |
| `updated_at`  | TIMESTAMP   | Last updated timestamp                                     |

### `Escalations` Table

| Column          | Data Type   | Description                                   |
|-----------------|-------------|-----------------------------------------------|
| `escalation_id` | INT (PK)    | Unique identifier                             |
| `ticket_id`     | INT (FK)    | The ticket being escalated                    |
| `from_agent_id` | INT (FK, Nullable) | Previous agent (if applicable)              |
| `to_agent_id`   | INT (FK, Nullable) | New agent assigned                          |
| `escalated_by`  | INT (FK)    | User (system/admin) who escalated             |
| `reason`        | VARCHAR     | Reason for escalation                         |
| `timestamp`     | TIMESTAMP   | When escalation happened                      |

### `Ticket_History` Table

| Column Name   | Data Type   | Description                                                |
|---------------|-------------|------------------------------------------------------------|
| `history_id`  | INT (PK)    | Unique identifier                                          |
| `ticket_id`   | INT (FK)    | Associated ticket                                          |
| `action`      | VARCHAR     | What happened (Assigned, Status Change, Escalated, etc.)   |
| `changed_by`  | INT (FK)    | User who made the change (agent/admin)                      |
| `timestamp`   | TIMESTAMP   | When the change occurred                                    |

### `Agent_Performance` Table

| Column              | Data Type   | Description                                      |
|---------------------|-------------|--------------------------------------------------|
| `record_id`         | INT (PK)    | Unique identifier                                |
| `agent_id`          | INT (FK)    | Support agent                                    |
| `resolved_tickets`  | INT         | Number of resolved tickets                       |
| `avg_resolution_time`| DECIMAL(10,2) | Average time to resolve                        |
| `escalation_count`  | INT         | Number of escalated tickets                      |
| `report_date`       | DATE        | Date of report                                   |
