library(lattice)
source("MySQLConnection.R") # connection is on ch

allReviews <- dbGetQuery(ch, "SELECT * FROM TripAdvisorReview")
freqReviews <- dbGetQuery(ch, "SELECT *
                          FROM TripAdvisorReview
                          JOIN TripAdvisorUser
                          ON TripAdvisorReview.author_id = TripAdvisorUser.id
                          WHERE num_reviews > 1")
noobReviews <- dbGetQuery(ch, "SELECT *
                          FROM TripAdvisorReview
                          JOIN TripAdvisorUser
                          ON TripAdvisorReview.author_id = TripAdvisorUser.id
                          WHERE num_reviews = 1")
veryFreqReviews <- dbGetQuery(ch, "SELECT *
                          FROM TripAdvisorReview
                          JOIN TripAdvisorUser
                          ON TripAdvisorReview.author_id = TripAdvisorUser.id
                          WHERE num_reviews > 10")
expertReviews <- dbGetQuery(ch, "SELECT *
                          FROM TripAdvisorReview
                          JOIN TripAdvisorUser
                          ON TripAdvisorReview.author_id = TripAdvisorUser.id
                          WHERE num_reviews > 50")
proReviews <- dbGetQuery(ch, "SELECT *
                          FROM TripAdvisorReview
                          JOIN TripAdvisorUser
                          ON TripAdvisorReview.author_id = TripAdvisorUser.id
                          WHERE num_reviews > 100")

expertReviews$stars <- factor(expertReviews$globalRating)
freqReviews$stars <- factor(freqReviews$globalRating)
noobReviews$stars <- factor(noobReviews$globalRating)
veryFreqReviews$stars <- factor(veryFreqReviews$globalRating)
proReviews$stars <- factor(proReviews$globalRating)

qplot(data=allReviews, x=stars, color=stars, main="All reviews")
qplot(data=noobReviews, x=stars, color=stars, main="One-time reviewers")
qplot(data=freqReviews, x=stars, color=stars, main="Reviewers who wrote more than 1 review")
qplot(data=veryFreqReviews, x=stars, color=stars, main="Reviewers who wrote more than 10 reviews")
qplot(data=expertReviews, x=stars, color=stars, main="Reviewers who wrote more than 50 reviews")
qplot(data=proReviews, x=stars, color=stars, main="Reviewers who wrote more than 100 reviews")