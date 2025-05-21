const mongoose = require('mongoose');

const CryptoSchema = new mongoose.Schema({
  id: { type: String, required: true, unique: true },
  nome: { type: String, required: true },
  simbolo: { type: String, required: true },
  tipo: { type: String },
  preco: { type: Number },
  moeda: { type: String },
}, { timestamps: true });

module.exports = mongoose.model('Crypto', CryptoSchema); 