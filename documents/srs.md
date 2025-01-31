# Software Requirements Specification (SRS)

## 1. Introduction

### 1.1 Purpose

The purpose of this document is to define the functional and non-functional requirements for the **Customer Support System** for the **National Exam Board**. This system will manage support requests from schools related to candidate registration, student transfers, disqualification appeals, repeaters, and other exam-related issues. It ensures timely resolution and customer satisfaction through a structured support mechanism.

### 1.2 Scope

The system will provide:

- **Ticketing system** to handle school support requests.
- **Role-based access control** for schools, agents, and admins.
- **Automated issue escalation** to neighboring agents or admins if needed.
- **Tracking and reporting tools** for monitoring issue resolution.
- **Secure authentication** and data management.

### 1.3 Stakeholders

The system will involve the stakeholders:

- **Schools** (Users submitting support requests)
- **Support Agents** (Regional staff handling issues)
- **Admins** (Supervisors managing agents and escalations)
- **National Exam Board** (Overseers ensuring policy compliance)

## 2. Functional Requirements

### 2.1 User Roles & Permissions

- **Schools:** Submit support requests, view ticket status.
- **Support Agents:** Manage tickets in their assigned region.
- **Admins:** Assign agents, oversee escalations, generate reports.

### 2.2 Support Request Management

- Schools can **submit tickets** via a web portal.
- Agents can **view, update, and resolve** tickets assigned to them.
- Issues **escalate automatically** if no agent is available.
- Schools receive **notifications** on ticket progress.

### 2.3 Ticket Escalation Mechanism

- If no agent is available in a school’s region, the system assigns it to a **neighboring region's agent**.
- If no neighboring agent is available, the issue escalates to an **admin**.
- Special cases allow agents to handle issues **outside their designated region**.

## 3. Non-Functional Requirements

### 3.1 Performance

- System should handle **high traffic** with response times <2 seconds.

### 3.2 Security

- **Role-based authentication** (e.g., JWT, OAuth).
- **Encrypted data storage** for sensitive information.

### 3.3 Scalability

- Must support **expanding school network** without performance degradation.

### 3.4 Usability

- **User-friendly UI** with accessible navigation.

## 4. System Models

### 4.1 Use Case Diagram

- **Actors:** Schools, Support Agents, Admins.
- **Processes:** Create ticket, Assign ticket, Escalate, Resolve, Notify.

### 4.2 Data Flow Diagram (DFD)

- Input: **School submits request** → Processing: **Agent resolves or escalates** → Output: **School receives status update**.

## 5. Constraints

- Compliance with **national exam board policies**.
- Deployment must support **web and mobile** platforms.

## 6. Assumptions & Dependencies

- Users have **internet access** to interact with the system.
- Support agents are **available within working hours**.

## 7. Appendix

- **Acronyms:**
  - SRS: Software Requirements Specification
  - JWT: JSON Web Token

## 8. References

- National Exam Board Policies on Candidate Support.

---

This SRS document outlines the foundation of the customer support system. Let me know if you need modifications or additional sections!