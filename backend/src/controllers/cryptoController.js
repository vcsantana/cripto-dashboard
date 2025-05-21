const axios = require('axios');

const COINMARKETCAP_API_KEY = process.env.COINMARKETCAP_API_KEY;
const BASE_URL = 'https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest';

exports.listCryptos = async (req, res) => {
  try {
    const response = await axios.get(BASE_URL, {
      params: { start: 1, limit: 10, convert: 'USD' },
      headers: { 'X-CMC_PRO_API_KEY': COINMARKETCAP_API_KEY },
    });
    // Retornar apenas os 5 primeiros
    const cryptos = response.data.data.slice(0, 5).map(coin => ({
      name: coin.name,
      symbol: coin.symbol,
      price: coin.quote.USD.price,
      percentChange: coin.quote.USD.percent_change_24h,
      iconUrl: coin.logo || '', // CoinMarketCap não retorna logo por padrão, pode ser vazio
    }));
    return res.json(cryptos);
  } catch (error) {
    return res.status(500).json({ message: 'Erro ao buscar criptomoedas.', error: error.message });
  }
};

exports.searchCryptos = async (req, res) => {
  try {
    const { nome, simbolo, tipo } = req.query;
    const response = await axios.get(BASE_URL, {
      params: { start: 1, limit: 50, convert: 'USD' },
      headers: { 'X-CMC_PRO_API_KEY': COINMARKETCAP_API_KEY },
    });
    let cryptos = response.data.data;
    if (nome) cryptos = cryptos.filter(coin => coin.name.toLowerCase().includes(nome.toLowerCase()));
    if (simbolo) cryptos = cryptos.filter(coin => coin.symbol.toLowerCase() === simbolo.toLowerCase());
    if (tipo) cryptos = cryptos.filter(coin => coin.slug.toLowerCase().includes(tipo.toLowerCase()));
    cryptos = cryptos.slice(0, 10).map(coin => ({
      name: coin.name,
      symbol: coin.symbol,
      price: coin.quote.USD.price,
      percentChange: coin.quote.USD.percent_change_24h,
      iconUrl: coin.logo || '',
    }));
    return res.json(cryptos);
  } catch (error) {
    return res.status(500).json({ message: 'Erro ao buscar criptomoedas.', error: error.message });
  }
}; 