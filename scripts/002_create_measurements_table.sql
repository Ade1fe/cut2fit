CREATE TABLE measurements (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  client_id UUID REFERENCES clients(id) ON DELETE CASCADE,
  type TEXT NOT NULL, -- e.g., 'neck_circumference', 'height', 'weight'
  value REAL NOT NULL,
  unit TEXT NOT NULL, -- e.g., 'in', 'cm', 'lbs', 'kg'
  measured_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Optional: Add RLS policies for security
ALTER TABLE clients ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Allow read access to all clients" ON clients FOR SELECT USING (TRUE);
CREATE POLICY "Allow insert access for authenticated users" ON clients FOR INSERT WITH CHECK (auth.uid() IS NOT NULL);

ALTER TABLE measurements ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Allow read access to all measurements" ON measurements FOR SELECT USING (TRUE);
CREATE POLICY "Allow insert access for authenticated users" ON measurements FOR INSERT WITH CHECK (auth.uid() IS NOT NULL);
