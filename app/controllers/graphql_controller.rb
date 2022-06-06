class GraphqlController < ActionController::API
  def graphql
    render json: Schema.execute(params[:query], variables: params[:variables])
  end
end