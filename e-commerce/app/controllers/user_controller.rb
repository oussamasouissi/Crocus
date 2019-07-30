class UserController < ApplicationController
  def home
    @produits = Produit.all

  end

  def homeAdmin
    authorize! :manage, :all
    @user = User.find(current_user.id)
    @visitor = Produit.sum(:countView)
    @activeUsers = User.count()
    @totalSales = Produit.where(Produit.arel_table[:remise].gt(0)).count()
    @newCommandes=Commande.this_month.count()
    @totalQteStock=Produit.sum(:qteStock)
    @commandeEnCours=Commande.where(etat: "enCours").count()
    @nbrFournisseur= User.where(roles: "fournisseur").count()
    @RecentAddProduct=Produit.order(created_at: :desc).limit(4)
    @lastestMembers=User.order(created_at: :desc).limit(8)
#---------------------------partie Stats---------------------------#
    @thisYear= Date.current.strftime("%Y")
    @YearBefore=Date.current.prev_year.strftime("%Y")

    puts(1.month.ago.strftime("%m"))
    chartData = {
        "chart": {
            "caption": "comparaison des commandes passées par mois dans les 2 dernières années ",

            "xAxisName": "Years",
            "yAxisName": "Nombre des commandes",
            "drawCrossLine": "1",
            "plotToolText": "<b>$dataValue</b> commandes on $seriesName in $label",
            "theme": "fusion"
        },

        "categories": [{
                           "category": [{
                                            "label": 5.month.ago.strftime("%B")
                                        }, {
                                            "label": 4.month.ago.strftime("%B")
                                        }, {
                                            "label": 3.month.ago.strftime("%B")
                                        }, {
                                            "label": 2.month.ago.strftime("%B")
                                        }, {
                                            "label": 1.month.ago.strftime("%B")
                                        }, {
                                            "label": Date.current.strftime("%B")
                                        }]
                       }],
        "dataset": [{
                        "seriesname":@thisYear ,
                        "data": [{
                                     "value": Commande.countOrderByMonthYear(5.month.ago.strftime("%m"),@thisYear)
                                 },{
                                     "value": Commande.countOrderByMonthYear(4.month.ago.strftime("%m"),@thisYear)
                                 }, {
                                     "value": Commande.countOrderByMonthYear(3.month.ago.strftime("%m"),@thisYear)
                                 }, {
                                     "value": Commande.countOrderByMonthYear(2.month.ago.strftime("%m"),@thisYear)
                                 }, {
                                     "value": Commande.countOrderByMonthYear(1.month.ago.strftime("%m"),@thisYear)
                                 }, {
                                     "value": Commande.countOrderByMonthYear(Date.current.strftime("%m"),@thisYear)
                                 }]
                    }, {
                        "seriesname": @YearBefore,
                        "data": [{
                                     "value": Commande.countOrderByMonthYear(5.month.ago.strftime("%m"),@YearBefore)
                                 }, {
                                     "value": Commande.countOrderByMonthYear(4.month.ago.strftime("%m"),@YearBefore)
                                 }, {
                                     "value": Commande.countOrderByMonthYear(3.month.ago.strftime("%m"),@YearBefore)
                                 }, {
                                     "value": Commande.countOrderByMonthYear(2.month.ago.strftime("%m"),@YearBefore)
                                 }, {
                                     "value": Commande.countOrderByMonthYear(1.month.ago.strftime("%m"),@YearBefore)
                                 }, {
                                     "value": Commande.countOrderByMonthYear(Date.current.strftime("%m"),@YearBefore)
                                 }]
                    }]
    }

    # Chart rendering
    @saleChart = Fusioncharts::Chart.new({
                                        width: "800",
                                        height: "600",
                                        type: "mscolumn2d",
                                        renderAt: "chart",
                                        dataSource: chartData
                                    })
#-------------fin partie Stats-------------------#

    @comparaisonPassageCommandeThisYearLastYear=Commande.calculPourcentagePassageCommande(Commande.countCommandeAnnee(@thisYear),Commande.countCommandeAnnee(@YearBefore))
    @comparaisonCreationComptesThisYearLastYear=User.calculPourcentageCreationComptes(User.countUserAnnee(@thisYear),User.countUserAnnee(@YearBefore))
  end
  def listUsers
    @clients = User.where(roles: "client")
    @fournisseurs = User.where(roles: "fournisseur",status: "accepté")
    @demandes = User.where.not("description= '' and nomSociete= '' and numFournisseur= '' or status= 'accepté'  " )



  end
  def edit
    @user = User.find(params[:id])
  end


  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to listUsers_user_index_path
    else
      render 'edit'
    end
  end
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    redirect_to listUsers_user_index_path
  end
  private
  def user_params
    params.require(:user).permit(:id,:email, :Name , :CIN , :téléphone , :adresse , :code_postal  , :roles, :UserName , :status , :description , :nomSociete , :numFournisseur)
  end

end


