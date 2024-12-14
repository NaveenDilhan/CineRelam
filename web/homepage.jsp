<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<%@ page import="dao.MovieDAO, model.Movie, dao.DealDAO, model.Deal, java.util.List" %>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>CineRealm | Home</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />
  <link rel="stylesheet" href="css/homepage.css" />
</head>

<body>

  <!-- Main Content -->
  <div class="main-content">

    <!-- Now Showing Section -->
    <section class="hero-section">
      <h2 class="section-title">Now Showing</h2>
      <div class="swiper hero-carousel">
        <div class="swiper-wrapper">
          <% 
            List<Movie> nowShowing = (List<Movie>) request.getAttribute("nowShowing");
            for (Movie movie : nowShowing) {
          %>
            <div class="swiper-slide">
              <div class="hero-text">
                <h3><%= movie.getTitle() %></h3>
                <a href="bookMovie.jsp?id=<%= movie.getId() %>" class="btn book-now">Book Now</a>
                <a href="trailer.jsp?id=<%= movie.getId() %>" class="btn watch-trailer">Watch Trailer</a>
              </div>
              <img src="<%= movie.getPosterURL() %>" alt="<%= movie.getTitle() %>" class="hero-image" />
            </div>
          <% 
            }
          %>
        </div>
        <!-- Navigation Buttons -->
        <div class="swiper-button-next hero-next"></div>
        <div class="swiper-button-prev hero-prev"></div>
        <div class="swiper-pagination"></div>
      </div>
    </section>

    <!-- Coming Soon Section -->
    <section class="coming-soon">
      <h2 class="section-title">Coming Soon</h2>
      <div class="swiper coming-soon-carousel">
        <div class="swiper-wrapper">
          <% 
            List<Movie> comingSoon = (List<Movie>) request.getAttribute("comingSoon");
            for (Movie movie : comingSoon) {
          %>
            <div class="swiper-slide">
              <img src="<%= movie.getPosterURL() %>" alt="<%= movie.getTitle() %>" class="poster-image" />
              <h3 class="movie-title"><%= movie.getTitle() %></h3>
              <p><%= movie.getGenre() %> | <%= movie.getDurationMinutes() %> min</p>
              <p>Release Date: <%= movie.getReleaseDate() %></p>
              <a href="trailer.jsp?id=<%= movie.getId() %>" class="btn watch-trailer">Watch Trailer</a>
            </div>
          <% 
            }
          %>
        </div>
        <!-- Navigation Buttons -->
        <div class="swiper-button-next coming-soon-next"></div>
        <div class="swiper-button-prev coming-soon-prev"></div>
        <div class="swiper-pagination"></div>
      </div>
    </section>

    <!-- Deals Section -->
    <section class="deals-section">
      <h2 class="section-title">Deals & Exclusive</h2>
      <div class="deals-container">
        <% 
          List<Deal> deals = (List<Deal>) request.getAttribute("deals");
          for (Deal deal : deals) {
        %>
          <div class="deal-card">
            <img src="<%= deal.getImageUrl() %>" alt="<%= deal.getTitle() %>" />
            <div class="deal-info">
              <h3><%= deal.getTitle() %></h3>
              <p><%= deal.getDescription() %></p>
              <a href="dealDetails.jsp?id=<%= deal.getId() %>" class="btn more-info">More Info</a>
            </div>
          </div>
        <% 
          }
        %>
      </div>
    </section>

  </div>
<%@ include file="footer.jsp" %>
<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
<script src="js/homepage.js"></script>
</body>

</html>
