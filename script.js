// 間違ったIDを指定（バグ）
const button = document.getElementById('actionBtn'); 
const messageArea = document.getElementById('messageArea');

button.addEventListener('click', () => {
    messageArea.textContent = 'OpeHanくんより: こんにちは！一緒に頑張りましょう！';
});
