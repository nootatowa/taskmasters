class Public::CustomersController < ApplicationController

    def show
    @customer = Customer.find(params[:id])
    @tasks = @customer.tasks
    end

    def edit
      @customer = current_customer
    end

    def update
      @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to tasks_path
    else
      render :edit
    end
    end

    def levelUp
      customer = Customer.find(params[:id])
      task = Task.find(params[:task_id])
      #この二行は適当なものに置き換えてください。

      totalExp = customer.experience_point
      #変数に現在のユーザーの経験値を入れる
      totalExp += monster.point
      # 得られた経験値をユーザーの経験値に加算

      customer.experience_point = totalExp
      #改めて、加算した経験値をuserの総経験値を示す変数に入れ直す
      customer.update(experience_point: totalExp)
      #更新の処理をさせる

      levelSetting = LevelSetting.find_by(level: customer.level + 1);
      #ここから重要です！レベルセッティングのモデルから、今の自分のレベルより1高いレコードを探させます。
      #そしてそれを変数に入れておきます

      if levelSetting.thresold <= user.experience_point
      #探してきたレコードの閾値よりもユーザーの総経験値が高かった場合
        customer.level = customer.level + 1
        customer.update(level: customer.level)
      #レベルを1増やして更新
      end
    end




   private
    def customer_params
    params.require(:customer).permit(:name)
    end
end
