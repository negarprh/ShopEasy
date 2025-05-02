# 🛒 ShopEasy – Java E-commerce Platform

ShopEasy is a full-stack e-commerce web application built with **JSP**, **Servlets**, and **JDBC** (Java EE stack). It enables users to browse products, view details, manage a cart, and complete a checkout process. Admins can manage the inventory through a separate dashboard.

---

## 📸 Screenshots

### 🏠 Homepage
![Homepage](screenshots/homepage.png)

### 🧾 Product Detail
![Product Detail](screenshots/productdetail.png)

### 🛍️ Cart Page
![Cart Page](screenshots/cart.png)

### 💳 Checkout Page
![Checkout Page](screenshots/checkout.png)

---

## ⚙️ Features

### ✅ User Features
- Sign up, log in, and manage sessions
- Browse products and view details
- Add to cart, update quantity, and remove items
- Checkout with form validation

### ✅ Admin Features
- Access `AdminPanel.jsp`
- View all products
- Add/edit/delete products (CRUD)
- Role-based access control

---

## 🧱 Technologies Used

- **Java EE, Jakarta** (Servlets + JSP)
- **H2** for database
- **HTML/CSS** for UI
- **Git & GitHub** for version control

---

## 🧠 Object-Oriented Principles

- ✅ **Encapsulation**: Private fields with public getters/setters
- ✅ **Inheritance**: `User` inherits from `Person`
- ✅ **Interface implementation**: `User implements IUser`, `Product implements IProduct`
- ✅ **Polymorphism**: Interfaces used for flexibility
- ✅ **Exception Handling**: Input validation and DB error handling

---

## 📁 Folder Structure

```
src/
├── controller/          // Servlets (e.g., LoginServlet, RegisterServlet)
├── dao/                // Database access logic
├── model/              // POJOs: User, Product, CartItem, + interfaces
├── views/              // JSP pages: index.jsp, product.jsp, cart.jsp
└── utils/              // DBConnection.java
```

---

## 📖 Setup Instructions

1. Clone the repository  
   `git clone https://github.com/yourusername/shopeasy.git`

2. Import the project in IntelliJ (Java + Maven/EE)

3. Configure your database connection in `DBConnection.java`

4. Run on a servlet container (e.g., Apache Tomcat)

5. Access the app on `http://localhost:8080/ShopEasy`

---

## 💬 Reflection & Learning

> "This project helped me understand how to design and build an end-to-end application using Java EE. I strengthened my understanding of Servlets, MVC architecture, JDBC integration, form validation, and Git workflows. It was a great opportunity to apply object-oriented programming concepts in a real-world context."

---

## 👨‍💻 Collabrators

**Negar Pirasteh**  
College: LaSalle College | Program: Computer Science Technology    
GitHub: [@negarprh](https://github.com/negarprh)

**Betty Dang**  
College: LaSalle College | Program: Computer Science Technology    
GitHub: [@BettyDang](https://github.com/BettyDang)

**Naomi Phamm**  
College: LaSalle College | Program: Computer Science Technology    
GitHub: [@NaomiPhamm](https://github.com/NaomiPhamm)

---

## 📝 License

This project is for educational purposes under the LaSalle College Winter 2025 Java OOP course.
