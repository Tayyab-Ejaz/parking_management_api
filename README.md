# Parking Management System

The Parking Management System is a comprehensive application designed to manage private parking facilities. The system has a dual-role functionality for administrators and customers. Administrators can manage parking slots, reservations, and customers. Customers can reserve parking slots, check in and out, and view their reservation history. The backend is built with Ruby on Rails, while the frontend is developed using React.js and Material-UI.

## Features

- **Admin Portal**:
  - Manage parking slots (CRUD operations, working hours, pricing, etc.).
  - Manage reservations (view, update, delete).
  - Manage customers (view, add, delete).
- **Customer Portal**:
  - Reserve parking slots based on time and other criteria.
  - View, check in, check out, and manage reservations.
- **Authentication & Authorization**:
  - Role-based access control for admin and customer roles.
- **API-based Backend with Rails**.
- **Modern Frontend with React.js and Material-UI**.
- **Deployed with Docker and Render.com**.

## Demo

You can try a live demo of the project [here](https://parking-management-frontend.onrender.com/).

## Getting Started

These instructions will guide you through setting up the project locally for development and testing purposes.

### Prerequisites

- Git
- Docker


### Installation

#### Backend Setup

1. Clone the backend repository:

```
mkdir parking_management_system
git clone https://github.com/Tayyab-Ejaz/parking_management_api
```

2. Clone the backend repository:

```
cd parking_management_api
```

3.Build the Docker container:
```
docker-compose build
docker-compose up
```

4. Setup database

```
docker-compose run rails rails db:migrate
docker-compose run rails rails db:seed
```

