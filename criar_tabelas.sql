-- Execute este SQL no Supabase > SQL Editor

-- Tabela de clientes
CREATE TABLE IF NOT EXISTS clientes (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  nome TEXT NOT NULL,
  tel TEXT NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Tabela de produtos
CREATE TABLE IF NOT EXISTS produtos (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  nome TEXT NOT NULL,
  preco NUMERIC(10,2) NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Tabela de fiados (compras a prazo)
CREATE TABLE IF NOT EXISTS fiados (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  cliente_id UUID REFERENCES clientes(id) ON DELETE CASCADE,
  data TEXT NOT NULL,
  itens JSONB NOT NULL DEFAULT '[]',
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Tabela de configurações (mensagem whatsapp etc)
CREATE TABLE IF NOT EXISTS config (
  chave TEXT PRIMARY KEY,
  valor TEXT NOT NULL
);

-- Habilitar acesso público (sem autenticação por enquanto)
ALTER TABLE clientes ENABLE ROW LEVEL SECURITY;
ALTER TABLE produtos ENABLE ROW LEVEL SECURITY;
ALTER TABLE fiados ENABLE ROW LEVEL SECURITY;
ALTER TABLE config ENABLE ROW LEVEL SECURITY;

CREATE POLICY "acesso_total_clientes" ON clientes FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "acesso_total_produtos" ON produtos FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "acesso_total_fiados" ON fiados FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "acesso_total_config" ON config FOR ALL USING (true) WITH CHECK (true);
