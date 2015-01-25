class SuggestController < ApplicationController
  autocomplete :convention, :libelle
end
