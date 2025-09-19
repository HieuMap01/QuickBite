<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/views/common/variables.jsp" %>

<nav class="bg-white">
  <div class="container">
    <ul class="nav nav-tabs justify-content-center py-2">

      <li class="nav-item">
        <a class="nav-link ${active=='home' ? 'active' : ''}" href="${env}/home">HOME</a>
      </li>

      <li class="nav-item">
        <a class="nav-link ${active=='about' ? 'active' : ''}" href="${env}/about">ABOUT US</a>
      </li>

      <li class="nav-item">
        <a class="nav-link ${active=='service' ? 'active' : ''}" href="${env}/service">SERVICE</a>
      </li>

      <li class="nav-item">
        <a class="nav-link ${active=='pricing' ? 'active' : ''}" href="${env}/pricing">PRICING</a>
      </li>

      <li class="nav-item">
        <a class="nav-link ${active=='blog' ? 'active' : ''}" href="${env}/blog">BLOG</a>
      </li>

      <li class="nav-item">
        <a class="nav-link ${active=='contact' ? 'active' : ''}" href="${env}/contact/view">CONTACT</a>
      </li>

    </ul>
  </div>
</nav>
