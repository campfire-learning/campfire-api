class DeviseCreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      ## Database authenticatable
      t.string :email, null: false
      t.string :encrypted_password, null: false

      t.string :first_name
      t.string :last_name

      ## "type" is a Rails reserved word, so using "user_type" here;
      t.string :user_type, null: false

      ## url pointing to user's profile
      t.text :description

      ## url pointing to a file in storage such as S3;
      t.string :profile_picture_url

      ## this is university, company, etc
      t.references :institution, null: false, foreign_key: true

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      ## Confirmable
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      t.string   :unlock_token # Only if unlock strategy is :email or :both
      t.datetime :locked_at

      t.timestamps null: false
      ## Discard for soft delete
      t.datetime :discarded_at
    end

    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
    add_index :users, :confirmation_token,   unique: true
    add_index :users, :unlock_token,         unique: true
    add_index :users, :discarded_at
  end
end
