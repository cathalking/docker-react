# Multi-step build file

# 1. Build phase - requires npm
FROM node:alpine as builder
# AWS-specific step
# FROM node:alpine
WORKDIR /app
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# 2. Run phase - requires only nginx
FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html
# AWS-specific step
# COPY --from=0 /app/build /usr/share/nginx/html 

# No command needed. The default command of the nginx image takes care of this
# CMD ["nginx", "start"]
