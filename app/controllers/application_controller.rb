class ApplicationController < ActionController::Base
    def hello
        render html: "This is the Reporting App"
    end
end
