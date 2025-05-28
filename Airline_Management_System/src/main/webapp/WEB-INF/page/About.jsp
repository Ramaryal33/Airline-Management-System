<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>

<html lang="en">

<head>

  <base href="${basePath}">

  <meta charset="UTF-8">

  <meta name="viewport" content="width=device-width, initial-scale=1.0">

  <title>${pageTitle}</title>

</head>

<body class="about" style="margin:0; padding:0; font-family:'Segoe UI', sans-serif; background-color:#0a0a0a; color:#fff; text-align:center;">



  <header class="navbar" style="background:#0a1c2c; padding:1.2rem 2rem; display:flex; justify-content:space-between; align-items:center; flex-wrap:wrap;">

    <div class="logo" style="color:#f6c90e; font-size:1.8rem; font-weight:bold;">Dawn Airlines</div>

    <nav>

      <ul style="list-style:none; display:flex; gap:1.5rem; flex-wrap:wrap; margin:0;">

        <li><a href="${pageContext.request.contextPath}/home" style="color:#fff; text-decoration:none; transition:color 0.3s;">Home</a></li>

        <li><a href="${pageContext.request.contextPath}/contact" style="color:#fff; text-decoration:none; transition:color 0.3s;">Contact Us</a></li>

        <li><a href="${pageContext.request.contextPath}/about" class="active" style="color:#f6c90e; text-decoration:none; transition:color 0.3s;">About Us</a></li>

        <li><a href="${pageContext.request.contextPath}/login" style="color:#fff; text-decoration:none; transition:color 0.3s;">Login</a></li>

      </ul>

    </nav>

  </header>



  <section class="about-section" style="padding:3rem 1rem; background-color:#0a0a0a; color:#fff; text-align:center;">

    <h1 style="margin-bottom:1rem; font-size:2.5rem; color:#f6c90e;">About Dawn Airlines</h1>

    <p style="max-width:700px; margin:0 auto 2rem; line-height:1.6; color:#ccc;">

      At Dawn Airlines, we're redefining air travel with innovation, care, and excellence. From domestic routes to global destinations, we aim to make your journey memorable.

    </p>



    <h2 style="margin-bottom:1rem; font-size:2rem; color:#f6c90e;">Meet the Team</h2>

    <div class="team-grid" style="display:grid; grid-template-columns:repeat(auto-fit, minmax(220px, 1fr)); gap:2rem; justify-items:center; max-width:1100px; margin:0 auto;">

      <div class="team-member" style="background:#111; padding:1.5rem; border-radius:12px; max-width:250px;">

        <img src="${pageContext.request.contextPath}/image/leader.jpg" alt="Member 1" style="width:100%; height:200px; object-fit:cover; border-radius:8px; margin-bottom:1rem;">

        <h4 style="color:#f6c90e; margin-bottom:0.5rem;">Ram Aryal</h4>

        <p style="color:#ccc;">Leader</p>

      </div>

      <div class="team-member" style="background:#111; padding:1.5rem; border-radius:12px; max-width:250px;">

        <img src="${pageContext.request.contextPath}/images/1.jpg" alt="Member 2" style="width:100%; height:200px; object-fit:cover; border-radius:8px; margin-bottom:1rem;">

        <h4 style="color:#f6c90e; margin-bottom:0.5rem;">Suyash Pokheral</h4>

        <p style="color:#ccc;">Member</p>

      </div>

      <div class="team-member" style="background:#111; padding:1.5rem; border-radius:12px; max-width:250px;">

        <img src="${pageContext.request.contextPath}/image/aayush.jpg" alt="Member 3" style="width:100%; height:200px; object-fit:cover; border-radius:8px; margin-bottom:1rem;">

        <h4 style="color:#f6c90e; margin-bottom:0.5rem;">Aauysh Kumar Gupta</h4>

        <p style="color:#ccc;">Member</p>

      </div>

      <div class="team-member" style="background:#111; padding:1.5rem; border-radius:12px; max-width:250px;">

        <img src="${pageContext.request.contextPath}/images/1ab.jpg" alt="Member 4" style="width:100%; height:200px; object-fit:cover; border-radius:8px; margin-bottom:1rem;">

        <h4 style="color:#f6c90e; margin-bottom:0.5rem;">Aabhinna Maharjan</h4>

        <p style="color:#ccc;">Member</p>

      </div>

    </div>

  </section>



</body>

</html>