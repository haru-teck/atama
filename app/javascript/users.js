document.addEventListener('DOMContentLoaded', function () {
  const nextUserButton = document.getElementById('next-user');

  if (nextUserButton) {
    nextUserButton.addEventListener('click', function () {
      const currentUserId = nextUserButton.dataset.currentUserId;
      const nextUserId = parseInt(currentUserId) + 1; // 例: 次のユーザーIDを取得

      fetch(`/users/${nextUserId}`)
        .then(response => {
          if (response.ok) {
            return response.text();
          } else {
            throw new Error('ユーザーが見つかりません');
          }
        })
        .then(html => {
          document.getElementById('user-details').innerHTML = html; // ユーザー情報を更新
        })
        .catch(error => {
          console.error(error);
        });
    });
  }
});