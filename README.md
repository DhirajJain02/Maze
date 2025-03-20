   # 🚀 Maze - Social Media Platform

Maze is a modern social media platform designed for professionals and individuals to connect, share insights, and engage in meaningful discussions. Unlike traditional social networks, Maze emphasizes privacy controls, seamless user interactions, and powerful administrative tools, making it a dynamic space for networking and content sharing.

---

## 🚀 Features

### 👤 User Features

- **📝 Account Creation & Profile Management:** Users can sign up with an avatar image, update personal details, and manage their profiles.
- **🔐 Secure Authentication:** Login and access personalized features securely using Devise authentication.
- **🏷️ Post Creation & Visibility:** Users can create posts with text content and choose whether they are public (visible to all) or private (visible only to themselves).
- **👍 Post Interactions:** Users can like posts, comment on them, and like comments to engage in meaningful discussions.
- **👀 Profile Viewing:** View other users' profiles and explore their posted content.


### 🔧 Admin Features

- **📜 User & Post Management:** Admins can view all posts, activate or deactivate users, and moderate content.
- **📂 Bulk User Upload:** Admins can upload multiple users at once using CSV/XLS files for easy onboarding.
- **📊 Reports & Analytics:** Generate and download reports for users and posts using Active Jobs for insights into platform activity.
- **📩 Email Notifications:** Notifications are sent to admins when a new user signs up, and newly registered users receive their credentials via email (handled by Sidekiq).
- **📱 Responsive Design:** Fully optimized for both mobile and desktop views.

---

## 🛠️ Tech Stack

- **Frontend:** Tailwind CSS 🎨, Alpine.js ⚡
- **Backend:** Ruby on Rails 🏗️
- **Database:** PostgreSQL 🗄️
- **Authentication:** Devise Gem 📦
- **Image Storage:** Cloudinary ☁️
- **Version Control**: Git ⚙️
- **Deployment**: Render 🌐

---

## 📦 Gems Used:

- `tailwindcss` - Styling framework 🎭
- `dotenv` - Environment variable management 🔑
- `devise` - Authentication system 🔐
- `rolify` - Role-based authorization 🏷️
- `cloudinary` - Cloud-based image storage 📸
- `solid_queue` - Background job processing ⚙️
- `sidekiq` - Job scheduling and execution 🕒
- `roo` - Spreadsheet handling for bulk user uploads 📊

---

<!--
## 🗺️ API Routes

### Public Routes

- **GET** `/api/courses` - View all available courses
- **GET** `/api/courses/:id` - View details of a specific course
- **POST** `/api/users/register` - Register a new user (Student or Instructor)
- **POST** `/api/users/login` - User login

### Student Routes

- **GET** `/api/users/me` - Get the logged-in user's profile (Student)
- **POST** `/api/courses/enroll/:courseId` - Enroll in a course
- **GET** `/api/courses/my-courses` - Get a list of all enrolled courses

### Instructor Routes

- **POST** `/api/courses/create` - Create a new course
- **PUT** `/api/courses/edit/:id` - Edit an existing course
- **DELETE** `/api/courses/delete/:id` - Delete a course

### Admin Routes

- **GET** `/api/admin/users` - Manage all users
- **GET** `/api/admin/courses` - Manage all courses
- **DELETE** `/api/admin/users/delete/:id` - Delete a user

---
-->

## 💻 Installation

To set up and run Coursify on your local machine:

1. **Clone the repository:**

   ```bash
   git clone <repo-link>
   cd Maze

2. **Install dependencies:**

    ```bash
    bundle install
    
3. **Set up environment variables:**
- Create a `.env` file and add the required variables (Cloudinary, Database, etc.).
    
4. **Set up the database:**

     ```bash
      rails db:create
      rails db:migrate
     ```
     
5. Start the server:

    ```bash
      rails server
    ```
    

6. **Run Sidekiq for background jobs:**

     ```bash
      bundle exec sidekiq
    ```

---


## 🖼️ Screenshots

- **Home Page**:
  ![image](https://github.com/user-attachments/assets/3b0769ff-527b-46cc-ad1e-4c825f228aa3)


- **Sign UP**:
  ![image](https://github.com/user-attachments/assets/ea95b329-3f65-4329-a382-c799ead7e0b3)

- **User View**
  ![image](https://github.com/user-attachments/assets/9148026c-3b56-4326-879d-b3db19348db9)

- **Admin View**
  ![image](https://github.com/user-attachments/assets/bff727c4-55b2-4a7a-9a06-f2d7ce0c8d91)

- **User Management**
  ![image](https://github.com/user-attachments/assets/4bc928ae-0f40-4041-9881-de6b8a155808)

- **Reports**
  ![image](https://github.com/user-attachments/assets/8cbb4a9a-d5f1-497f-b3a1-0e3f2b1b8cbe)



---

## 👥 Contributors
- Feel free to fork the repository, make feature improvements, and submit pull requests.

  **AK-shat JAIN** - [GitHub](https://github.com/AK-shat-JAIN)

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---
