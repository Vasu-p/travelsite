class CostsController < ApplicationController
  before_action :set_cost, only: [:show, :edit, :update, :destroy]

  # GET /costs
  # GET /costs.json
  def index
    @costs = Cost.where(["journey_id like ?",current_trip.journey.id])
    @rem_budget=-Cost.where(["journey_id like ?",current_trip.journey.id]).sum(:amount)+current_trip.journey.budget
    if @rem_budget<0
    @rem_budget="Over Budget"
  end

  
  end

  # GET /costs/1
  # GET /costs/1.json
  def show
  end

  # GET /costs/new
  def new
    @cost = current_trip.journey.costs.build
  end

  # GET /costs/1/edit
  def edit
  end

  # POST /costs
  # POST /costs.json
  def create
    @cost = current_trip.journey.costs.build(cost_params)

    respond_to do |format|
      if @cost.save
        format.html { redirect_to costs_url, notice: 'Cost was successfully created.' }
        format.json { render :show, status: :created, location: @cost }
      else
        format.html { render :new }
        format.json { render json: @cost.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /costs/1
  # PATCH/PUT /costs/1.json
  def update
    respond_to do |format|
      if @cost.update(cost_params)
        format.html { redirect_to @cost, notice: 'Cost was successfully updated.' }
        format.json { render :show, status: :ok, location: @cost }
      else
        format.html { render :edit }
        format.json { render json: @cost.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /costs/1
  # DELETE /costs/1.json
  def destroy
    @cost.destroy
    respond_to do |format|
      format.html { redirect_to costs_url, notice: 'Cost was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  def calculate_final
    #calculates how many rupees who have to give to whom after completion of trip

      total=Cost.where(["journey_id like ?",current_trip.journey.id]).sum(:amount)
      avg=total/current_trip.journey.peoples
      persons=Cost.where(["journey_id like ?",current_trip.journey.id]).select("person,sum(amount) as sum_exp").group("person")      
      
      exp=[];char ='a';name=[]
      persons.map{|p|  exp.push(p.sum_exp-avg); name.push(p.person)}
      for i in (0...(current_trip.journey.peoples-exp.length))
        exp.push(-avg);name.push(char);char=char.next
      end
      
      while !(exp.uniq.length==1 and exp[0]=0)
      for i in 0...exp.length
          if exp[i]<0
              for j in (i+1)...exp.length
                  if exp[j]>0
                      if -exp[i]>exp[j]
                          exp[j]=0;exp[i]=exp[i]+exp[j];
                          puts "#{name[i]} gives #{exp[j]} rupees to #{name[j]}"
                      else
                          exp[i]=0;exp[j]=exp[j]+exp[i];
                          puts "#{name[i]} gives #{exp[i]} rupees to #{name[j]}"
                      end
                  end
              end
          
          else
              for j in (i+1)...exp.length
                  if exp[j]<0
                      if exp[i]>-exp[j]
                          exp[j]=0;exp[i]=exp[i]+exp[j];
                          puts "#{name[j]} gives #{exp[j]} rupees to #{name[i]}"
                      else
                          exp[i]=0;exp[j]=exp[j]+exp[i];
                          puts "#{name[j]} gives #{exp[i]} rupees to #{name[i]}"
                      end
                  end
              end
            end
      end
    end
  #     for i in 0...exp.length

  #       if exp[i]>0
  #         for j in 1..exp.length
  #            if i+j<=exp.length and exp[i+j]<0 and -1*exp[i+j]<exp[i]
  #               exp[i+j]=exp[i+j]+(exp[i]+exp[i+j])
  #               exp[i]=exp[i]+exp[i+j]
  #            end

  #           if i+j<=exp.length and exp[i+j]<0 and -1*exp[i+j]>exp[i]
  #               exp[i+j]=exp[i+j]+exp[i]
  #               exp[i]=0
  #            end


  #           if exp[i]==0
  #             break end

  #            if i-j>0 and exp[i-j]<0 and -1*exp[i-j]<exp[i]
  #               exp[i-j]=exp[i-j]+(exp[i]+exp[i-j])
  #               exp[i]=exp[i]+exp[i-j]
  #            end

  #            if i-j>0 and exp[i-j]<0 and -1*exp[i-j]>exp[i]
  #               exp[i-j]=exp[i-j]+exp[i]
  #               exp[i]=0
  #            end

  #            if exp[i]==0
  #             break  end
  #         end


  #     end

  # end
end
  helper_method :calculate_final
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cost
      @cost = Cost.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cost_params
      params.require(:cost).permit(:person, :description, :amount)
    end
end
