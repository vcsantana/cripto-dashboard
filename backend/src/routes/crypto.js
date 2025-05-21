const express = require('express');
const router = express.Router();
const cryptoController = require('../controllers/cryptoController');
const authMiddleware = require('../middlewares/authMiddleware');

/**
 * @swagger
 * tags:
 *   name: Crypto
 *   description: Endpoints de criptomoedas
 */

/**
 * @swagger
 * /api/crypto/:
 *   get:
 *     summary: Listar as 5 principais criptomoedas
 *     tags: [Crypto]
 *     security:
 *       - bearerAuth: []
 *     responses:
 *       200:
 *         description: Lista de criptomoedas
 *       401:
 *         description: Não autenticado
 */

router.get('/', authMiddleware, cryptoController.listCryptos);
router.get('/search', authMiddleware, cryptoController.searchCryptos);

/**
 * @swagger
 * /api/crypto/search:
 *   get:
 *     summary: Buscar/filtrar criptomoedas
 *     tags: [Crypto]
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: query
 *         name: nome
 *         schema:
 *           type: string
 *         description: Nome da criptomoeda
 *       - in: query
 *         name: simbolo
 *         schema:
 *           type: string
 *         description: Símbolo da criptomoeda
 *       - in: query
 *         name: tipo
 *         schema:
 *           type: string
 *         description: Tipo/slug da criptomoeda
 *     responses:
 *       200:
 *         description: Lista de criptomoedas filtradas
 *       401:
 *         description: Não autenticado
 */

module.exports = router; 