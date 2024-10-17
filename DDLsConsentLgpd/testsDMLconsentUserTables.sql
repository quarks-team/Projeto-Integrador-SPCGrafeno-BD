INSERT INTO users (username, password, email, cnpj, consent_status, consent_date) VALUES
('johndoe', 'password123', 'johndoe@example.com', '12345678901234', TRUE, NOW()),
('janedoe', 'securepass456', 'janedoe@example.com', NULL, FALSE, NULL);

INSERT INTO policies (name, description, version) VALUES
('Privacy Policy', 'This policy covers how we handle your personal data.', 1),
('Terms of Service', 'These terms govern the use of our services.', 2);

INSERT INTO user_policies (user_id, policy_id, is_active) 
SELECT u.id, p.id, TRUE 
FROM users u, policies p 
WHERE u.username = 'johndoe' AND p.name = 'Privacy Policy';

INSERT INTO user_policies (user_id, policy_id, is_active) 
SELECT u.id, p.id, TRUE 
FROM users u, policies p 
WHERE u.username = 'janedoe' AND p.name = 'Terms of Service';

INSERT INTO policy_logs (user_id, policy_id, previous_status, new_status, change_type, user_email) 
SELECT u.id, p.id, NULL, 'Accepted', 'Acceptance', u.email
FROM users u, policies p 
WHERE u.username = 'johndoe' AND p.name = 'Privacy Policy';

INSERT INTO policy_logs (user_id, policy_id, previous_status, new_status, change_type, user_email) 
SELECT u.id, p.id, 'Accepted', 'Revoked', 'Revocation', u.email
FROM users u, policies p 
WHERE u.username = 'janedoe' AND p.name = 'Terms of Service';



-- View all users
SELECT * FROM users;

-- View all policies
SELECT * FROM policies;

-- View all user-policy relationships
SELECT * FROM user_policies;

-- View the policy logs
SELECT * FROM policy_logs;