const K=function(){const n=document.createElement("link").relList;if(n&&n.supports&&n.supports("modulepreload"))return;for(const i of document.querySelectorAll('link[rel="modulepreload"]'))s(i);new MutationObserver(i=>{for(const l of i)if(l.type==="childList")for(const o of l.addedNodes)o.tagName==="LINK"&&o.rel==="modulepreload"&&s(o)}).observe(document,{childList:!0,subtree:!0});function t(i){const l={};return i.integrity&&(l.integrity=i.integrity),i.referrerpolicy&&(l.referrerPolicy=i.referrerpolicy),i.crossorigin==="use-credentials"?l.credentials="include":i.crossorigin==="anonymous"?l.credentials="omit":l.credentials="same-origin",l}function s(i){if(i.ep)return;i.ep=!0;const l=t(i);fetch(i.href,l)}};K();const d={},Q=(e,n)=>e===n,q={equals:Q};let W=G;const S={},b=1,C=2,U={owned:null,cleanups:null,context:null,owner:null};var c=null;let x=null,f=null,m=null,u=null,p=null,$=0;function X(e,n){const t=f,s=c,i=e.length===0?U:{owned:null,cleanups:null,context:null,owner:n||s};c=i,f=null;try{return P(()=>e(()=>B(i)),!0)}finally{f=t,c=s}}function J(e,n){n=n?Object.assign({},q,n):q;const t={value:e,observers:null,observerSlots:null,pending:S,comparator:n.equals||void 0},s=i=>(typeof i=="function"&&(i=i(t.pending!==S?t.pending:t.value)),L(t,i));return[Z.bind(t),s]}function T(e,n,t){const s=z(e,n,!1,b);O(s)}function Y(e){if(m)return e();let n;const t=m=[];try{n=e()}finally{m=null}return P(()=>{for(let s=0;s<t.length;s+=1){const i=t[s];if(i.pending!==S){const l=i.pending;i.pending=S,L(i,l)}}},!1),n}function j(e){let n,t=f;return f=null,n=e(),f=t,n}function Z(){const e=x;if(this.sources&&(this.state||e)){const n=u;u=null,this.state===b||e?O(this):E(this),u=n}if(f){const n=this.observers?this.observers.length:0;f.sources?(f.sources.push(this),f.sourceSlots.push(n)):(f.sources=[this],f.sourceSlots=[n]),this.observers?(this.observers.push(f),this.observerSlots.push(f.sources.length-1)):(this.observers=[f],this.observerSlots=[f.sources.length-1])}return this.value}function L(e,n,t){if(m)return e.pending===S&&m.push(e),e.pending=n,n;if(e.comparator&&e.comparator(e.value,n))return n;let s=!1;return e.value=n,e.observers&&e.observers.length&&P(()=>{for(let i=0;i<e.observers.length;i+=1){const l=e.observers[i];s&&x.disposed.has(l),(s&&!l.tState||!s&&!l.state)&&(l.pure?u.push(l):p.push(l),l.observers&&M(l)),s||(l.state=b)}if(u.length>1e6)throw u=[],new Error},!1),n}function O(e){if(!e.fn)return;B(e);const n=c,t=f,s=$;f=c=e,k(e,e.value,s),f=t,c=n}function k(e,n,t){let s;try{s=e.fn(n)}catch(i){R(i)}(!e.updatedAt||e.updatedAt<=t)&&(e.observers&&e.observers.length?L(e,s):e.value=s,e.updatedAt=t)}function z(e,n,t,s=b,i){const l={fn:e,state:s,updatedAt:null,owned:null,sources:null,sourceSlots:null,cleanups:null,value:n,owner:c,context:null,pure:t};return c===null||c!==U&&(c.owned?c.owned.push(l):c.owned=[l]),l}function F(e){const n=x;if(e.state===0||n)return;if(e.state===C||n)return E(e);if(e.suspense&&j(e.suspense.inFallback))return e.suspense.effects.push(e);const t=[e];for(;(e=e.owner)&&(!e.updatedAt||e.updatedAt<$);)(e.state||n)&&t.push(e);for(let s=t.length-1;s>=0;s--)if(e=t[s],e.state===b||n)O(e);else if(e.state===C||n){const i=u;u=null,E(e,t[0]),u=i}}function P(e,n){if(u)return e();let t=!1;n||(u=[]),p?t=!0:p=[],$++;try{return e()}catch(s){R(s)}finally{ee(t)}}function ee(e){u&&(G(u),u=null),!e&&(p.length?Y(()=>{W(p),p=null}):p=null)}function G(e){for(let n=0;n<e.length;n++)F(e[n])}function E(e,n){const t=x;e.state=0;for(let s=0;s<e.sources.length;s+=1){const i=e.sources[s];i.sources&&(i.state===b||t?i!==n&&F(i):(i.state===C||t)&&E(i,n))}}function M(e){const n=x;for(let t=0;t<e.observers.length;t+=1){const s=e.observers[t];(!s.state||n)&&(s.state=C,s.pure?u.push(s):p.push(s),s.observers&&M(s))}}function B(e){let n;if(e.sources)for(;e.sources.length;){const t=e.sources.pop(),s=e.sourceSlots.pop(),i=t.observers;if(i&&i.length){const l=i.pop(),o=t.observerSlots.pop();s<i.length&&(l.sourceSlots[o]=s,i[s]=l,t.observerSlots[s]=o)}}if(e.owned){for(n=0;n<e.owned.length;n++)B(e.owned[n]);e.owned=null}if(e.cleanups){for(n=0;n<e.cleanups.length;n++)e.cleanups[n]();e.cleanups=null}e.state=0,e.context=null}function R(e){throw e}function te(e,n){return j(()=>e(n))}function ne(e,n,t){let s=t.length,i=n.length,l=s,o=0,r=0,a=n[i-1].nextSibling,g=null;for(;o<i||r<l;){if(n[o]===t[r]){o++,r++;continue}for(;n[i-1]===t[l-1];)i--,l--;if(i===o){const h=l<s?r?t[r-1].nextSibling:t[l-r]:a;for(;r<l;)e.insertBefore(t[r++],h)}else if(l===r)for(;o<i;)(!g||!g.has(n[o]))&&n[o].remove(),o++;else if(n[o]===t[l-1]&&t[r]===n[i-1]){const h=n[--i].nextSibling;e.insertBefore(t[r++],n[o++].nextSibling),e.insertBefore(t[--l],h),n[i]=t[l]}else{if(!g){g=new Map;let y=r;for(;y<l;)g.set(t[y],y++)}const h=g.get(n[o]);if(h!=null)if(r<h&&h<l){let y=o,N=1,D;for(;++y<i&&y<l&&!((D=g.get(n[y]))==null||D!==h+N);)N++;if(N>h-r){const V=n[o];for(;r<h;)e.insertBefore(t[r++],V)}else e.replaceChild(t[r++],n[o++])}else o++;else n[o++].remove()}}}const _="_$DX_DELEGATE";function se(e,n,t){let s;return X(i=>{s=i,n===document?e():H(n,e(),n.firstChild?null:void 0,t)}),()=>{s(),n.textContent=""}}function ie(e,n,t){const s=document.createElement("template");s.innerHTML=e;let i=s.content.firstChild;return t&&(i=i.firstChild),i}function le(e,n=window.document){const t=n[_]||(n[_]=new Set);for(let s=0,i=e.length;s<i;s++){const l=e[s];t.has(l)||(t.add(l),n.addEventListener(l,oe))}}function H(e,n,t,s){if(t!==void 0&&!s&&(s=[]),typeof n!="function")return A(e,n,s,t);T(i=>A(e,n(),i,t),s)}function oe(e){const n=`$$${e.type}`;let t=e.composedPath&&e.composedPath()[0]||e.target;for(e.target!==t&&Object.defineProperty(e,"target",{configurable:!0,value:t}),Object.defineProperty(e,"currentTarget",{configurable:!0,get(){return t||document}}),d.registry&&!d.done&&(d.done=!0,document.querySelectorAll("[id^=pl-]").forEach(s=>s.remove()));t!==null;){const s=t[n];if(s&&!t.disabled){const i=t[`${n}Data`];if(i!==void 0?s(i,e):s(e),e.cancelBubble)return}t=t.host&&t.host!==t&&t.host instanceof Node?t.host:t.parentNode}}function A(e,n,t,s,i){for(d.context&&!t&&(t=[...e.childNodes]);typeof t=="function";)t=t();if(n===t)return t;const l=typeof n,o=s!==void 0;if(e=o&&t[0]&&t[0].parentNode||e,l==="string"||l==="number"){if(d.context)return t;if(l==="number"&&(n=n.toString()),o){let r=t[0];r&&r.nodeType===3?r.data=n:r=document.createTextNode(n),t=w(e,t,s,r)}else t!==""&&typeof t=="string"?t=e.firstChild.data=n:t=e.textContent=n}else if(n==null||l==="boolean"){if(d.context)return t;t=w(e,t,s)}else{if(l==="function")return T(()=>{let r=n();for(;typeof r=="function";)r=r();t=A(e,r,t,s)}),()=>t;if(Array.isArray(n)){const r=[];if(v(r,n,i))return T(()=>t=A(e,r,t,s,!0)),()=>t;if(d.context){for(let a=0;a<r.length;a++)if(r[a].parentNode)return t=r}if(r.length===0){if(t=w(e,t,s),o)return t}else Array.isArray(t)?t.length===0?I(e,r,s):ne(e,t,r):(t&&w(e),I(e,r));t=r}else if(n instanceof Node){if(d.context&&n.parentNode)return t=o?[n]:n;if(Array.isArray(t)){if(o)return t=w(e,t,s,n);w(e,t,null,n)}else t==null||t===""||!e.firstChild?e.appendChild(n):e.replaceChild(n,e.firstChild);t=n}}return t}function v(e,n,t){let s=!1;for(let i=0,l=n.length;i<l;i++){let o=n[i],r;if(o instanceof Node)e.push(o);else if(!(o==null||o===!0||o===!1))if(Array.isArray(o))s=v(e,o)||s;else if((r=typeof o)=="string")e.push(document.createTextNode(o));else if(r==="function")if(t){for(;typeof o=="function";)o=o();s=v(e,Array.isArray(o)?o:[o])||s}else e.push(o),s=!0;else e.push(document.createTextNode(o.toString()))}return s}function I(e,n,t){for(let s=0,i=n.length;s<i;s++)e.insertBefore(n[s],t)}function w(e,n,t,s){if(t===void 0)return e.textContent="";const i=s||document.createTextNode("");if(n.length){let l=!1;for(let o=n.length-1;o>=0;o--){const r=n[o];if(i!==r){const a=r.parentNode===e;!l&&!o?a?e.replaceChild(i,r):e.insertBefore(i,t):a&&r.remove()}else l=!0}}else e.insertBefore(i,t);return[i]}const re=ie("<div><div></div><button>Click me!</button></div>");function fe(){let[e,n]=J(0);return(()=>{const t=re.cloneNode(!0),s=t.firstChild,i=s.nextSibling;return H(s,e),i.$$click=()=>n(e()+1),t})()}le(["click"]);se(()=>te(fe,{}),document.getElementById("root"));
