module API::Entities
  class DummyDataEntity < Grape::Entity


    expose :fullname
    expose :dob
    expose :location

    # for more informations, check grape-entity documentation at github
    def fullname
      "#{object[:first]} #{object[:last]}"
    end

  end
end
