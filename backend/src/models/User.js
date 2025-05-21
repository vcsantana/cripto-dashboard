const mongoose = require('mongoose');

const UserSchema = new mongoose.Schema({
  nome: { type: String, required: true },
  email: { type: String, required: true, unique: true },
  senha: { type: String, required: true },
  descricao: { type: String },
  imagem: { type: String }, // base64
}, { timestamps: true });

module.exports = mongoose.model('User', UserSchema); 