require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  let(:user) { create(:user) }
  let!(:task) { create(:task, user: user) }

  before do
    sign_in user
  end

  describe "GET #index" do
    it "returns a successful response" do
      get :index
      expect(response).to be_successful
    end

    it "assigns the user's tasks to @tasks" do
      get :index
      expect(assigns(:tasks)).to eq([task])
    end

    it "redirects to the login page if the user is not signed in" do
      sign_out user
      get :index
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe "GET #show" do
    it "returns a successful response" do
      get :show, params: { id: task.id }
      expect(response).to be_successful
    end

    it "assigns the requested task to @task" do
      get :show, params: { id: task.id }
      expect(assigns(:task)).to eq(task)
    end
  end

  describe "GET #new" do
    it "returns a successful response" do
      get :new
      expect(response).to be_successful
    end

    it "assigns a new task to @task" do
      get :new
      expect(assigns(:task)).to be_a_new(Task)
    end
  end

  describe "GET #edit" do
    it "returns a successful response" do
      get :edit, params: { id: task.id }
      expect(response).to be_successful
    end

    it "assigns the requested task to @task" do
      get :edit, params: { id: task.id }
      expect(assigns(:task)).to eq(task)
    end
  end

  describe "POST #create" do
    context "with valid parameters" do
      it "creates a new Task" do
        expect {
          post :create, params: { task: attributes_for(:task, user: user) }
        }.to change(Task, :count).by(1)
      end

      it "redirects to the created task" do
        post :create, params: { task: attributes_for(:task, user: user) }
        expect(response).to redirect_to(Task.last)
      end

      it "sets a flash message on successful create" do
        post :create, params: { task: attributes_for(:task, user: user) }
        expect(flash[:notice]).to eq("Task was successfully created.")
      end
    end

    context "with invalid parameters" do
      it "does not create a new Task" do
        expect {
          post :create, params: { task: attributes_for(:task, title: nil, user: user) }
        }.to_not change(Task, :count)
      end

      it "renders the new template" do
        post :create, params: { task: attributes_for(:task, title: nil, user: user) }
        expect(response).to render_template(:new)
      end

      it "displays the appropriate error messages" do
        post :create, params: { task: attributes_for(:task, title: nil, user: user) }
        expect(assigns(:task).errors.full_messages).to include("Title can't be blank")
      end
    end
  end

  describe "PATCH/PUT #update" do
    context "with valid parameters" do
      let(:new_attributes) do
        { title: "New Title" }
      end

      it "updates the requested task" do
        patch :update, params: { id: task.id, task: new_attributes }
        task.reload
        expect(task.title).to eq("New Title")
      end

      it "redirects to the task" do
        patch :update, params: { id: task.id, task: new_attributes }
        expect(response).to redirect_to(task)
      end

      it "sets a flash message on successful updated" do
        patch :update, params: { id: task.id, task: new_attributes }
        expect(flash[:notice]).to eq("Task '#{new_attributes[:title]}' was successfully updated.")
      end
    end

    context "with invalid parameters" do
      it "does not update the task" do
        patch :update, params: { id: task.id, task: { title: nil } }
        task.reload
        expect(task.title).to_not be_nil
      end

      it "renders the edit template" do
        patch :update, params: { id: task.id, task: { title: nil } }
        expect(response).to render_template(:edit)
      end

      it "displays the appropriate error messages" do
        patch :update, params: { id: task.id, task: { title: nil } }
        expect(assigns(:task).errors.full_messages).to include("Title can't be blank")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested task" do
      expect {
        delete :destroy, params: { id: task.id }
      }.to change(Task, :count).by(-1)
    end

    it "redirects to the tasks list" do
      delete :destroy, params: { id: task.id }
      expect(response).to redirect_to(tasks_url)
    end

    it "renders a 404 if the task no longer exists" do
      delete :destroy, params: { id: task.id }
      get :show, params: { id: task.id }
      expect(response).to redirect_to(tasks_url)
      expect(flash[:alert]).to eq("Task not found.")
    end
  end
end
