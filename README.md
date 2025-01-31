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
