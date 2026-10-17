# A Tumba do Necromante — Escopo Inicial v1.0

## 1. Atributos

O personagem possui apenas dois atributos principais.

| Atributo | Descrição | Valor inicial sugerido |
|---|---|---:|
| Vida | Determina quanto dano o personagem suporta antes de morrer. | 50 |
| Magia (mana) | Recurso consumido ao utilizar magias. | 30 |

Os valores iniciais são provisórios e poderão ser ajustados durante os testes de combate.

## 2. Equipamentos

### 2.1. Armas

As armas determinam diretamente o dano causado pelos ataques físicos.

| Arma | Dano por ataque |
|---|---:|
| Espada | 10 |
| Espada longa | 20 |

### 2.2. Escudos

Os escudos reduzem o dano recebido enquanto o jogador estiver bloqueando.

| Escudo | Redução de dano |
|---|---:|
| Escudo de madeira | 20% |
| Escudo de ferro | 30% |

**Regra de cálculo:**

Dano recebido = dano original × (1 − percentual de redução).

Exemplo: um ataque de 20 pontos contra o escudo de madeira causa 16 pontos de dano.

O dano final será arredondado para o inteiro mais próximo, caso o cálculo produza um valor decimal.

## 3. Magias

As magias possuem efeitos fixos. O custo de mana de cada uma será definido durante o balanceamento.

| Magia | Efeito |
|---|---|
| Bola de fogo | Causa 10 pontos de dano. |
| Bola de fogo +1 | Causa 20 pontos de dano. |
| Cura | Recupera 20 pontos de vida. |

A versão aprimorada da bola de fogo poderá ser encontrada durante a exploração, por exemplo, em um livro de magia.

## 4. Consumíveis

O jogador poderá utilizar poções sem precisar carregá-las em quantidades limitadas.

| Item | Efeito |
|---|---|
| Poção de vida | Recupera 100% da vida máxima. |
| Poção de magia | Recupera 100% da mana máxima. |

### Regras de utilização

- Uso ilimitado, sem quantidade no inventário.
- Cada utilização inicia um tempo de recarga (*cooldown*).
- Durante a recarga, nenhuma das duas poções poderá ser utilizada.
- A recarga será compartilhada entre as poções de vida e magia.
- Não será possível utilizar uma poção se o atributo correspondente já estiver cheio.
- A duração da recarga será definida durante os testes de combate.

## 5. Progressão

A progressão será baseada principalmente na exploração e nas recompensas encontradas.

O jogador poderá encontrar:

- Novas armas que aumentam o dano físico.
- Escudos com maior redução de dano.
- Livros que desbloqueiam novas magias ou versões aprimoradas.
- Orbes que aumentam permanentemente a vida ou a mana máximas.

Não haverá sistema tradicional de experiência, níveis ou distribuição de pontos de atributos na versão inicial.

## 6. Princípios de escopo

Para manter o projeto viável e permitir sua conclusão, a primeira versão não incluirá:

- Árvores de habilidades.
- Atributos separados de ataque físico, ataque mágico e defesa.
- Durabilidade de equipamentos.
- Fabricação ou melhoria de equipamentos.
- Gerenciamento de quantidades de poções.
- Múltiplos níveis de poções.

## 7. Objetivo da primeira versão

Implementar um ciclo jogável de exploração e combate que permita ao jogador:

1. Explorar uma dungeon.
2. Combater inimigos utilizando armas e magias.
3. Bloquear ataques com escudos.
4. Recuperar vida e mana utilizando poções com recarga.
5. Encontrar equipamentos e melhorias.
6. Enfrentar um chefe final.

Os valores numéricos deste documento são uma base inicial de implementação e poderão ser ajustados conforme os testes de jogabilidade, sem ampliar o escopo dos sistemas.
