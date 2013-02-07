source("MySQLConnection.R") # connection is on ch

# find top 50 contributors
topYelpUsers <- dbGetQuery(ch, "SELECT * FROM YelpUser ORDER BY reviewsCount desc limit 50;")
topTAUsers <- dbGetQuery(ch, "SELECT * FROM TripAdvisorUser ORDER BY num_reviews desc limit 50;")
topOTUsers <- dbGetQuery(ch, "SELECT * FROM OpenTableUser ORDER BY num_reviews desc limit 50;")

# find all reviews from those guys
topYelpReviews <- matrix()
for (i in 1:50) {
    topYelpReviews[i] <- dbGetQuery(ch, "SELECT rating FROM YelpReview WHERE author_id =" + topYelpUsers[i]$id + ";" )
    qplot(data=topYelpReviews[i])
}