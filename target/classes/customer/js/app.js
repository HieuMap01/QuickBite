
// app.js — drop-in enhancements: search, favorites (Yêu thích), simple auth validation
(function(){
  const ls = {
    get(key, def){ try { return JSON.parse(localStorage.getItem(key)) ?? def } catch(e){ return def } },
    set(key, val){ localStorage.setItem(key, JSON.stringify(val)) }
  };

  // --- SEARCH (filter product cards by name/desc) ---
  function initSearch(){
    const input = document.querySelector('input[type="search"], .search-container input, #search');
    if(!input) return;
    const container = document.querySelector('.product-list, .menu-list, .row'); // try common wrappers
    if(!container) return;
    const items = [...container.querySelectorAll('[data-item-id], .card')];

    function textOf(el){
      const name = el.getAttribute('data-item-name') || el.querySelector('.card-title, h5, h4, .name')?.textContent || '';
      const desc = el.getAttribute('data-item-desc') || el.querySelector('.card-text, p, .desc')?.textContent || '';
      return (name + ' ' + desc).toLowerCase();
    }

    input.addEventListener('input', () => {
      const q = input.value.trim().toLowerCase();
      items.forEach(it => {
        const t = textOf(it);
        it.style.display = (!q || t.includes(q)) ? '' : 'none';
      });
    });
  }

  // --- FAVORITES / YÊU THÍCH ---
  function getFavs(){ return new Set(ls.get('favorites', [])); }
  function saveFavs(set){ ls.set('favorites', [...set]); }

  function initFavButtons(){
    const favButtons = document.querySelectorAll('[data-fav-btn], .btn-fav, .add-fav');
    if(!favButtons.length) return;

    const favs = getFavs();
    favButtons.forEach(btn => {
      // infer item context
      const card = btn.closest('[data-item-id], .card');
      if(!card) return;

      const id   = card.getAttribute('data-item-id') || card.dataset.id || card.querySelector('[data-id]')?.dataset.id;
      const name = card.getAttribute('data-item-name') || card.querySelector('.card-title, h5, h4, .name')?.textContent?.trim() || '';
      const price= card.getAttribute('data-item-price') || card.querySelector('.price, .card-price')?.textContent?.trim() || '';
      const img  = card.getAttribute('data-item-image') || card.querySelector('img')?.getAttribute('src') || '';

      if(!id) return;

      // set initial state
      const isFav = favs.has(id);
      btn.setAttribute('aria-pressed', isFav ? 'true' : 'false');
      btn.classList.toggle('is-fav', isFav);
      btn.title = isFav ? 'Bỏ yêu thích' : 'Thêm vào yêu thích';

      btn.addEventListener('click', (e) => {
        e.preventDefault();
        const nowFav = !favs.has(id);
        if(nowFav) {
          favs.add(id);
          // store minimal item info
          const meta = ls.get('favorite_items', {});
          meta[id] = { id, name, price, img };
          ls.set('favorite_items', meta);
        } else {
          favs.delete(id);
          const meta = ls.get('favorite_items', {});
          delete meta[id];
          ls.set('favorite_items', meta);
        }
        saveFavs(favs);
        btn.setAttribute('aria-pressed', nowFav ? 'true' : 'false');
        btn.classList.toggle('is-fav', nowFav);
        btn.title = nowFav ? 'Bỏ yêu thích' : 'Thêm vào yêu thích';
      });
    });
  }

  // Render favorites list for pages_yeuthich.html
  function renderFavoritesPage(){
    const favContainer = document.querySelector('#fav-list, .favorite-list, .yeu-thich-list');
    if(!favContainer) return;
    const favs = getFavs();
    const meta = ls.get('favorite_items', {});
    favContainer.innerHTML = '';

    if(!favs.size){
      favContainer.innerHTML = '<p>Chưa có món nào trong danh sách yêu thích.</p>';
      return;
    }

    favs.forEach(id => {
      const item = meta[id] || {id, name: 'Món ăn', price:'', img:''};
      const card = document.createElement('div');
      card.className = 'card favorite-card';
      card.style.marginBottom = '12px';
      card.innerHTML = `
        <div class="row g-0 align-items-center">
          <div class="col-3">${item.img ? `<img src="${item.img}" class="img-fluid rounded-start" alt="${item.name}">` : ''}</div>
          <div class="col-6">
            <div class="card-body">
              <h5 class="card-title">${item.name || 'Món ăn'}</h5>
              ${item.price ? `<p class="card-text price">${item.price}</p>` : ''}
            </div>
          </div>
          <div class="col-3 text-end pe-3">
            <button class="btn btn-outline-danger btn-sm" data-remove-fav="${id}"><i class="far fa-trash-alt"></i> Xóa</button>
          </div>
        </div>
      `;
      favContainer.appendChild(card);
    });

    // hook remove
    favContainer.addEventListener('click', (e)=>{
      const btn = e.target.closest('[data-remove-fav]');
      if(!btn) return;
      const id = btn.getAttribute('data-remove-fav');
      const favs = getFavs();
      favs.delete(id);
      saveFavs(favs);
      const meta = ls.get('favorite_items', {});
      delete meta[id];
      ls.set('favorite_items', meta);
      btn.closest('.favorite-card').remove();
      if(!favs.size) favContainer.innerHTML = '<p>Chưa có món nào trong danh sách yêu thích.</p>';
    });
  }

  // --- SIMPLE FORM VALIDATION (login/register) ---
  function initAuthValidation(){
    const form = document.querySelector('form');
    if(!form) return;

    function showError(el, msg){
      let small = el.parentElement.querySelector('.form-error');
      if(!small){
        small = document.createElement('div');
        small.className = 'form-error';
        small.style.color = '#d32f2f';
        small.style.fontSize = '0.9rem';
        small.style.marginTop = '6px';
        el.parentElement.appendChild(small);
      }
      small.textContent = msg || '';
    }
    function clearError(el){ const s = el.parentElement.querySelector('.form-error'); if(s) s.textContent = ''; }

    form.addEventListener('submit', (e) => {
      const email = form.querySelector('input[type="email"]');
      const pass  = form.querySelector('input[type="password"]');
      const pass2 = form.querySelector('input[name="confirm"], input[name="password2"]');
      let ok = true;

      if(email){
        clearError(email);
        const v = email.value.trim();
        const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if(!re.test(v)){ showError(email, 'Email không hợp lệ'); ok = false; }
      }
      if(pass){
        clearError(pass);
        if(pass.value.length < 6){ showError(pass, 'Mật khẩu tối thiểu 6 ký tự'); ok = false; }
      }
      if(pass2){
        clearError(pass2);
        if(pass2.value !== pass.value){ showError(pass2, 'Mật khẩu nhập lại không khớp'); ok = false; }
      }

      if(!ok) e.preventDefault();
    });
  }

  document.addEventListener('DOMContentLoaded', function(){
    initSearch();
    initFavButtons();
    renderFavoritesPage();
    initAuthValidation();
  });
})();
