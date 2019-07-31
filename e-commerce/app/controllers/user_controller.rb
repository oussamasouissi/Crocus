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
    @CommandeEnCours=Commande.where(etat: "enCours").count()
    @nbrFournisseur= User.where(roles: "fournisseur").count()
    @RecentAddProduct=Produit.order(created_at: :desc).limit(4)
    @lastestMembers=User.order(created_at: :desc).limit(8)
#---------------------------partie Stats---------------------------#
    @thisYear= Date.current.strftime("%Y")
    @YearBefore=Date.current.prev_year.strftime("%Y")

    puts(1.month.ago.strftime("%m"))
    chartData = {
        "chart": {
            "caption": "comparaison des Commandes passées par mois dans les 2 dernières années ",

            "xAxisName": "Years",
            "yAxisName": "Nombre des Commandes",
            "drawCrossLine": "1",
            "plotToolText": "<b>$dataValue</b> Commandes on $seriesName in $label",
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
                                        renderAt: "chartCon",
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
  def statistiqueUser
    #---------------------Statistique 2--------------------------------#





    @chart =
        Fusioncharts::Chart.new(
            {
                width: '1200',
                height: '400',
                type: 'scrollline2d',
                renderAt: 'chartContainer',
                dataSource: {
                    :"chart" => {
                        :"caption" =>
                            'Comptes créés ce mois',

                        :"showvalues" => '0',
                        :"numvisibleplot" => '12',
                        :"plottooltext" =>
                            '<b>$dataValue</b> comptes créés le $label',
                        :"theme" => 'fusion'
                    },
                    :"categories" => [
                        {
                            :"category" => [
                                { :"label" => '01' },
                                { :"label" => '02' },
                                { :"label" => '03' },
                                { :"label" => '04' },
                                { :"label" => '05' },
                                { :"label" => '06' },
                                { :"label" => '07' },
                                { :"label" => '08' },
                                { :"label" => '09' },
                                { :"label" => '10' },
                                { :"label" => '11' },
                                { :"label" => '12' },
                                { :"label" => '13' },
                                { :"label" => '14' },
                                { :"label" => '15' },
                                { :"label" => '16' },
                                { :"label" => '17' },
                                { :"label" => '18' },
                                { :"label" => '19' },
                                { :"label" => '20' },
                                { :"label" => '21' },
                                { :"label" => '22' },
                                { :"label" => '23' },
                                { :"label" => '24' },
                                { :"label" => '25' },
                                { :"label" => '26' },
                                { :"label" => '27' },
                                { :"label" => '28' },
                                { :"label" => '29' },
                                { :"label" => '30' },
                                { :"label" => '31' }
                            ]
                        }
                    ],
                    :"dataset" => [
                        {
                            :"data" => [
                                { :"value" => User.this_month().countByDay(01) },
                                { :"value" => User.this_month().countByDay(02) },
                                { :"value" => User.this_month().countByDay(03) },
                                { :"value" => User.this_month().countByDay(04) },
                                { :"value" => User.this_month().countByDay(05) },
                                { :"value" => User.this_month().countByDay(06) },
                                { :"value" => User.this_month().countByDay(7) },
                                { :"value" => User.this_month().countByDay(8) },
                                { :"value" => User.this_month().countByDay(9) },
                                { :"value" => User.this_month().countByDay(10) },
                                { :"value" => User.this_month().countByDay(11) },
                                { :"value" => User.this_month().countByDay(12) },
                                { :"value" => User.this_month().countByDay(13) },
                                { :"value" => User.this_month().countByDay(14) },
                                { :"value" => User.this_month().countByDay(15) },
                                { :"value" => User.this_month().countByDay(16) },
                                { :"value" => User.this_month().countByDay(17) },
                                { :"value" => User.this_month().countByDay(18) },
                                { :"value" => User.this_month().countByDay(19) },
                                { :"value" => User.this_month().countByDay(20) },
                                { :"value" => User.this_month().countByDay(21) },
                                { :"value" => User.this_month().countByDay(22) },
                                { :"value" => User.this_month().countByDay(23) },
                                { :"value" => User.this_month().countByDay(24) },
                                { :"value" => User.this_month().countByDay(25) },
                                { :"value" => User.this_month().countByDay(26) },
                                { :"value" => User.this_month().countByDay(27) },
                                { :"value" => User.this_month().countByDay(28) },
                                { :"value" => User.this_month().countByDay(29) },
                                { :"value" => User.this_month().countByDay(30) },
                                { :"value" => User.this_month().countByDay(31) }
                            ]
                        }
                    ]

                }
            }
        )
    
    #-------------------------Statistique 2-----------------------------------
    @thisYear= Date.current.strftime("%Y")
    @YearBefore=Date.current.prev_year.strftime("%Y")

    puts(1.month.ago.strftime("%m"))
    chartData = {
        "chart": {
            "caption": "comparaison des comptes utilisateur créés par mois dans les 2 dernières années ",

            "xAxisName": "Years",
            "yAxisName": "Nombre des utilisateurs",
            "drawCrossLine": "1",
            "plotToolText": "<b>$dataValue</b> comptes on $seriesName in $label",
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
                                     "value": User.countUserByMonthYear(5.month.ago.strftime("%m"),@thisYear)
                                 },{
                                     "value": User.countUserByMonthYear(4.month.ago.strftime("%m"),@thisYear)
                                 }, {
                                     "value": User.countUserByMonthYear(3.month.ago.strftime("%m"),@thisYear)
                                 }, {
                                     "value": User.countUserByMonthYear(2.month.ago.strftime("%m"),@thisYear)
                                 }, {
                                     "value": User.countUserByMonthYear(1.month.ago.strftime("%m"),@thisYear)
                                 }, {
                                     "value": User.countUserByMonthYear(Date.current.strftime("%m"),@thisYear)
                                 }]
                    }, {
                        "seriesname": @YearBefore,
                        "data": [{
                                     "value": User.countUserByMonthYear(5.month.ago.strftime("%m"),@YearBefore)
                                 }, {
                                     "value": User.countUserByMonthYear(4.month.ago.strftime("%m"),@YearBefore)
                                 }, {
                                     "value": User.countUserByMonthYear(3.month.ago.strftime("%m"),@YearBefore)
                                 }, {
                                     "value": User.countUserByMonthYear(2.month.ago.strftime("%m"),@YearBefore)
                                 }, {
                                     "value": User.countUserByMonthYear(1.month.ago.strftime("%m"),@YearBefore)
                                 }, {
                                     "value": User.countUserByMonthYear(Date.current.strftime("%m"),@YearBefore)
                                 }]
                    }]
    }

    # Chart rendering
    @Chart2 = Fusioncharts::Chart.new({
                                             width: "800",
                                             height: "600",
                                             type: "mscolumn2d",
                                             renderAt: "chart",
                                             dataSource: chartData
                                         })
  end


  private
  def user_params
    params.require(:user).permit(:id,:email, :Name , :CIN , :téléphone , :adresse , :code_postal  , :roles, :UserName , :status , :description , :nomSociete , :numFournisseur)
  end

end


