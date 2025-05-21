const User = require('../models/User');
const bcrypt = require('bcryptjs');

exports.getProfile = async (req, res) => {
  try {
    const user = await User.findById(req.userId).select('-senha');
    if (!user) {
      return res.status(404).json({ message: 'Usuário não encontrado.' });
    }
    return res.json(user);
  } catch (error) {
    return res.status(500).json({ message: 'Erro ao buscar perfil.', error: error.message });
  }
};

exports.updateProfile = async (req, res) => {
  try {
    const { nome, email, descricao, imagem, senha } = req.body;
    const update = { nome, email, descricao, imagem };
    if (senha) {
      update.senha = await bcrypt.hash(senha, 10);
    }
    const user = await User.findByIdAndUpdate(req.userId, update, { new: true, runValidators: true }).select('-senha');
    if (!user) {
      return res.status(404).json({ message: 'Usuário não encontrado.' });
    }
    return res.json(user);
  } catch (error) {
    return res.status(500).json({ message: 'Erro ao atualizar perfil.', error: error.message });
  }
}; 