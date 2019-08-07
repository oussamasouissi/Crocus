class CommandesController < ApplicationController

    def index
      @user = current_user
      @commandes = Commande.where(user_id:@user.id)
      @commndesAdmin=Commande.all
    end

    def show
      authorize! :read, Commande
      @commande = Commande.find(params[:id])
      render 'show'
    end
    
    def new
      authorize! :new, Commande
      @commande = Commande.new
    end

    def edit
      @commande = Commande.find(params[:id])
    end

    def create
      @commande = Commande.new(commande_params)
      #@commande.user = User.first
      @commande.update(user_id:current_user.id)
        if @commande.save
          redirect_to @commande
        else
          render 'new'
        end
    end

    def destroy
      @commande = Commande.find(params[:id])
      @commande.destroy
      flash[:danger] ="commande was successfully deleted"
      redirect_to @commande
  end
  
    def update
      if @commande.update(commande_params)
          flash[:success] = "command was successfully updated"
          redirect_to @commande
      else
          render 'index'
      end
    end

    def statistiquesCommande
      @thisYear= Date.current.strftime("%Y")
      @YearBefore=Date.current.prev_year.strftime("%Y")
      @chart =
          Fusioncharts::Chart.new(
              {
                  width: '1000',
                  height: '600',
                  type: 'msline',
                  renderAt: 'chartContainer',
                  dataSource: {
                      :"chart" => {
                          :"caption" => 'Year to Date Nombre de passage des commandes',
                          :"yaxisname" => 'commandes passées',
                          :"showhovereffect" => '1',

                          :"drawcrossline" => '1',
                          :"plottooltext" =>
                              '<b>$dataValue</b> commandes passées',
                          :"theme" => 'fusion'
                      },
                      :"categories" => [
                          {
                              :"category" => [
                                  { :"label" => 'Janvier' },
                                  { :"label" => 'Février' },
                                  { :"label" => 'Mars' },
                                  { :"label" => 'Avril' },
                                  { :"label" => 'Mai' },
                                  { :"label" => 'Juin' },
                                  { :"label" => 'Juillet' },
                                  { :"label" => 'Aout' },
                                  { :"label" => 'Septembre' },
                                  { :"label" => 'Octobre' },
                                  { :"label" => 'Nouvembre' },
                                  { :"label" => 'Décembre' }
                              ]
                          }
                      ],
                      :"dataset" => [
                          {
                              :"seriesname" => @thisYear,
                              :"data" => [
                                  { :"value" => Commande.yearToDate(1,@thisYear) },
                                  { :"value" => Commande.yearToDate(2,@thisYear) },
                                  { :"value" => Commande.yearToDate(3,@thisYear) },
                                  { :"value" => Commande.yearToDate(4,@thisYear) },
                                  { :"value" => Commande.yearToDate(5,@thisYear) },
                                  { :"value" => Commande.yearToDate(6,@thisYear) },
                                  { :"value" => Commande.yearToDate(7,@thisYear) },
                                  { :"value" => Commande.yearToDate(8,@thisYear) },
                                  { :"value" => Commande.yearToDate(9,@thisYear) },
                                  { :"value" => Commande.yearToDate(10,@thisYear) },
                                  { :"value" => Commande.yearToDate(11,@thisYear) },
                                  { :"value" => Commande.yearToDate(12,@thisYear) }
                              ]
                          },
                          {
                              :"seriesname" => @YearBefore,
                              :"data" => [
                                  { :"value" => Commande.yearToDate(1,@YearBefore) },
                                  { :"value" => Commande.yearToDate(2,@YearBefore) },
                                  { :"value" => Commande.yearToDate(3,@YearBefore) },
                                  { :"value" => Commande.yearToDate(4,@YearBefore) },
                                  { :"value" => Commande.yearToDate(5,@YearBefore) },
                                  { :"value" => Commande.yearToDate(6,@YearBefore) },
                                  { :"value" => Commande.yearToDate(7,@YearBefore) },
                                  { :"value" => Commande.yearToDate(8,@YearBefore) },
                                  { :"value" => Commande.yearToDate(9,@YearBefore) },
                                  { :"value" => Commande.yearToDate(10,@YearBefore) },
                                  { :"value" => Commande.yearToDate(11,@YearBefore) },
                                  { :"value" => Commande.yearToDate(12,@YearBefore) }
                              ]
                          }
                      ]
                  }
              }
          )
    end
    
    private
      def commande_params
        params.require(:commande).permit(:etat, :quantite)
      end
  end