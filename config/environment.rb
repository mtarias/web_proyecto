# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Eventmaker::Application.initialize!

# Fechas en humano
Time::DATE_FORMATS[:human] = "%A %d de %B, %Y"