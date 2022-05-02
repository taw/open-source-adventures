const fe=function(){const t=document.createElement("link").relList;if(t&&t.supports&&t.supports("modulepreload"))return;for(const i of document.querySelectorAll('link[rel="modulepreload"]'))s(i);new MutationObserver(i=>{for(const l of i)if(l.type==="childList")for(const o of l.addedNodes)o.tagName==="LINK"&&o.rel==="modulepreload"&&s(o)}).observe(document,{childList:!0,subtree:!0});function n(i){const l={};return i.integrity&&(l.integrity=i.integrity),i.referrerpolicy&&(l.referrerPolicy=i.referrerpolicy),i.crossorigin==="use-credentials"?l.credentials="include":i.crossorigin==="anonymous"?l.credentials="omit":l.credentials="same-origin",l}function s(i){if(i.ep)return;i.ep=!0;const l=n(i);fetch(i.href,l)}};fe();const x={};function ce(e){x.context=e}const ue=(e,t)=>e===t,R={equals:ue};let z=ne;const _={},M=1,U=2,ee={owned:null,cleanups:null,context:null,owner:null};var y=null;let O=null,g=null,L=null,m=null,v=null,G=0;function D(e,t){const n=g,s=y,i=e.length===0?ee:{owned:null,cleanups:null,context:null,owner:t||s};y=i,g=null;try{return X(()=>e(()=>Q(i)),!0)}finally{g=n,y=s}}function B(e,t){t=t?Object.assign({},R,t):R;const n={value:e,observers:null,observerSlots:null,pending:_,comparator:t.equals||void 0},s=i=>(typeof i=="function"&&(i=i(n.pending!==_?n.pending:n.value)),K(n,i));return[te.bind(n),s]}function j(e,t,n){const s=V(e,t,!1,M);I(s)}function ae(e,t,n){z=me;const s=V(e,t,!1,M);s.user=!0,v?v.push(s):queueMicrotask(()=>I(s))}function de(e,t,n){n=n?Object.assign({},R,n):R;const s=V(e,t,!0,0);return s.pending=_,s.observers=null,s.observerSlots=null,s.comparator=n.equals||void 0,I(s),te.bind(s)}function he(e){if(L)return e();let t;const n=L=[];try{t=e()}finally{L=null}return X(()=>{for(let s=0;s<n.length;s+=1){const i=n[s];if(i.pending!==_){const l=i.pending;i.pending=_,K(i,l)}}},!1),t}function W(e){let t,n=g;return g=null,t=e(),g=n,t}function ge(e){return y===null||(y.cleanups===null?y.cleanups=[e]:y.cleanups.push(e)),e}function te(){const e=O;if(this.sources&&(this.state||e)){const t=m;m=null,this.state===M||e?I(this):H(this),m=t}if(g){const t=this.observers?this.observers.length:0;g.sources?(g.sources.push(this),g.sourceSlots.push(t)):(g.sources=[this],g.sourceSlots=[t]),this.observers?(this.observers.push(g),this.observerSlots.push(g.sources.length-1)):(this.observers=[g],this.observerSlots=[g.sources.length-1])}return this.value}function K(e,t,n){if(L)return e.pending===_&&L.push(e),e.pending=t,t;if(e.comparator&&e.comparator(e.value,t))return t;let s=!1;return e.value=t,e.observers&&e.observers.length&&X(()=>{for(let i=0;i<e.observers.length;i+=1){const l=e.observers[i];s&&O.disposed.has(l),(s&&!l.tState||!s&&!l.state)&&(l.pure?m.push(l):v.push(l),l.observers&&se(l)),s||(l.state=M)}if(m.length>1e6)throw m=[],new Error},!1),t}function I(e){if(!e.fn)return;Q(e);const t=y,n=g,s=G;g=y=e,pe(e,e.value,s),g=n,y=t}function pe(e,t,n){let s;try{s=e.fn(t)}catch(i){ie(i)}(!e.updatedAt||e.updatedAt<=n)&&(e.observers&&e.observers.length?K(e,s):e.value=s,e.updatedAt=n)}function V(e,t,n,s=M,i){const l={fn:e,state:s,updatedAt:null,owned:null,sources:null,sourceSlots:null,cleanups:null,value:t,owner:y,context:null,pure:n};return y===null||y!==ee&&(y.owned?y.owned.push(l):y.owned=[l]),l}function P(e){const t=O;if(e.state===0||t)return;if(e.state===U||t)return H(e);if(e.suspense&&W(e.suspense.inFallback))return e.suspense.effects.push(e);const n=[e];for(;(e=e.owner)&&(!e.updatedAt||e.updatedAt<G);)(e.state||t)&&n.push(e);for(let s=n.length-1;s>=0;s--)if(e=n[s],e.state===M||t)I(e);else if(e.state===U||t){const i=m;m=null,H(e,n[0]),m=i}}function X(e,t){if(m)return e();let n=!1;t||(m=[]),v?n=!0:v=[],G++;try{return e()}catch(s){ie(s)}finally{ye(n)}}function ye(e){m&&(ne(m),m=null),!e&&(v.length?he(()=>{z(v),v=null}):v=null)}function ne(e){for(let t=0;t<e.length;t++)P(e[t])}function me(e){let t,n=0;for(t=0;t<e.length;t++){const i=e[t];i.user?e[n++]=i:P(i)}x.context&&ce();const s=e.length;for(t=0;t<n;t++)P(e[t]);for(t=s;t<e.length;t++)P(e[t])}function H(e,t){const n=O;e.state=0;for(let s=0;s<e.sources.length;s+=1){const i=e.sources[s];i.sources&&(i.state===M||n?i!==t&&P(i):(i.state===U||n)&&H(i,t))}}function se(e){const t=O;for(let n=0;n<e.observers.length;n+=1){const s=e.observers[n];(!s.state||t)&&(s.state=U,s.pure?m.push(s):v.push(s),s.observers&&se(s))}}function Q(e){let t;if(e.sources)for(;e.sources.length;){const n=e.sources.pop(),s=e.sourceSlots.pop(),i=n.observers;if(i&&i.length){const l=i.pop(),o=n.observerSlots.pop();s<i.length&&(l.sourceSlots[o]=s,i[s]=l,n.observerSlots[s]=o)}}if(e.owned){for(t=0;t<e.owned.length;t++)Q(e.owned[t]);e.owned=null}if(e.cleanups){for(t=0;t<e.cleanups.length;t++)e.cleanups[t]();e.cleanups=null}e.state=0,e.context=null}function ie(e){throw e}const we=Symbol("fallback");function Y(e){for(let t=0;t<e.length;t++)e[t]()}function be(e,t,n={}){let s=[],i=[],l=[],o=0,r=t.length>1?[]:null;return ge(()=>Y(l)),()=>{let u=e()||[],a,f;return W(()=>{let c=u.length,p,h,E,$,C,w,b,A,N;if(c===0)o!==0&&(Y(l),l=[],s=[],i=[],o=0,r&&(r=[])),n.fallback&&(s=[we],i[0]=D(re=>(l[0]=re,n.fallback())),o=1);else if(o===0){for(i=new Array(c),f=0;f<c;f++)s[f]=u[f],i[f]=D(d);o=c}else{for(E=new Array(c),$=new Array(c),r&&(C=new Array(c)),w=0,b=Math.min(o,c);w<b&&s[w]===u[w];w++);for(b=o-1,A=c-1;b>=w&&A>=w&&s[b]===u[A];b--,A--)E[A]=i[b],$[A]=l[b],r&&(C[A]=r[b]);for(p=new Map,h=new Array(A+1),f=A;f>=w;f--)N=u[f],a=p.get(N),h[f]=a===void 0?-1:a,p.set(N,f);for(a=w;a<=b;a++)N=s[a],f=p.get(N),f!==void 0&&f!==-1?(E[f]=i[a],$[f]=l[a],r&&(C[f]=r[a]),f=h[f],p.set(N,f)):l[a]();for(f=w;f<c;f++)f in E?(i[f]=E[f],l[f]=$[f],r&&(r[f]=C[f],r[f](f))):i[f]=D(d);i=i.slice(0,o=c),s=u.slice(0)}return i});function d(c){if(l[f]=c,r){const[p,h]=B(f);return r[f]=h,t(u[f],p)}return t(u[f])}}}function q(e,t){return W(()=>e(t))}function xe(e){const t="fallback"in e&&{fallback:()=>e.fallback};return de(be(()=>e.each,e.children,t||void 0))}function ve(e,t,n){let s=n.length,i=t.length,l=s,o=0,r=0,u=t[i-1].nextSibling,a=null;for(;o<i||r<l;){if(t[o]===n[r]){o++,r++;continue}for(;t[i-1]===n[l-1];)i--,l--;if(i===o){const f=l<s?r?n[r-1].nextSibling:n[l-r]:u;for(;r<l;)e.insertBefore(n[r++],f)}else if(l===r)for(;o<i;)(!a||!a.has(t[o]))&&t[o].remove(),o++;else if(t[o]===n[l-1]&&n[r]===t[i-1]){const f=t[--i].nextSibling;e.insertBefore(n[r++],t[o++].nextSibling),e.insertBefore(n[--l],f),t[i]=n[l]}else{if(!a){a=new Map;let d=r;for(;d<l;)a.set(n[d],d++)}const f=a.get(t[o]);if(f!=null)if(r<f&&f<l){let d=o,c=1,p;for(;++d<i&&d<l&&!((p=a.get(t[d]))==null||p!==f+c);)c++;if(c>f-r){const h=t[o];for(;r<f;)e.insertBefore(n[r++],h)}else e.replaceChild(n[r++],t[o++])}else o++;else t[o++].remove()}}}const J="_$DX_DELEGATE";function Ae(e,t,n){let s;return D(i=>{s=i,t===document?e():oe(t,e(),t.firstChild?null:void 0,n)}),()=>{s(),t.textContent=""}}function le(e,t,n){const s=document.createElement("template");s.innerHTML=e;let i=s.content.firstChild;return n&&(i=i.firstChild),i}function Se(e,t=window.document){const n=t[J]||(t[J]=new Set);for(let s=0,i=e.length;s<i;s++){const l=e[s];n.has(l)||(n.add(l),t.addEventListener(l,$e))}}function S(e,t,n){n==null?e.removeAttribute(t):e.setAttribute(t,n)}function Ee(e,t,n={}){const s=e.style,i=typeof n=="string";if(t==null&&i||typeof t=="string")return s.cssText=t;i&&(s.cssText=void 0,n={}),t||(t={});let l,o;for(o in n)t[o]==null&&s.removeProperty(o),delete n[o];for(o in t)l=t[o],l!==n[o]&&(s.setProperty(o,l),n[o]=l);return n}function oe(e,t,n,s){if(n!==void 0&&!s&&(s=[]),typeof t!="function")return k(e,t,s,n);j(i=>k(e,t(),i,n),s)}function $e(e){const t=`$$${e.type}`;let n=e.composedPath&&e.composedPath()[0]||e.target;for(e.target!==n&&Object.defineProperty(e,"target",{configurable:!0,value:n}),Object.defineProperty(e,"currentTarget",{configurable:!0,get(){return n||document}}),x.registry&&!x.done&&(x.done=!0,document.querySelectorAll("[id^=pl-]").forEach(s=>s.remove()));n!==null;){const s=n[t];if(s&&!n.disabled){const i=n[`${t}Data`];if(i!==void 0?s(i,e):s(e),e.cancelBubble)return}n=n.host&&n.host!==n&&n.host instanceof Node?n.host:n.parentNode}}function k(e,t,n,s,i){for(x.context&&!n&&(n=[...e.childNodes]);typeof n=="function";)n=n();if(t===n)return n;const l=typeof t,o=s!==void 0;if(e=o&&n[0]&&n[0].parentNode||e,l==="string"||l==="number"){if(x.context)return n;if(l==="number"&&(t=t.toString()),o){let r=n[0];r&&r.nodeType===3?r.data=t:r=document.createTextNode(t),n=T(e,n,s,r)}else n!==""&&typeof n=="string"?n=e.firstChild.data=t:n=e.textContent=t}else if(t==null||l==="boolean"){if(x.context)return n;n=T(e,n,s)}else{if(l==="function")return j(()=>{let r=t();for(;typeof r=="function";)r=r();n=k(e,r,n,s)}),()=>n;if(Array.isArray(t)){const r=[];if(F(r,t,i))return j(()=>n=k(e,r,n,s,!0)),()=>n;if(x.context){for(let u=0;u<r.length;u++)if(r[u].parentNode)return n=r}if(r.length===0){if(n=T(e,n,s),o)return n}else Array.isArray(n)?n.length===0?Z(e,r,s):ve(e,n,r):(n&&T(e),Z(e,r));n=r}else if(t instanceof Node){if(x.context&&t.parentNode)return n=o?[t]:t;if(Array.isArray(n)){if(o)return n=T(e,n,s,t);T(e,n,null,t)}else n==null||n===""||!e.firstChild?e.appendChild(t):e.replaceChild(t,e.firstChild);n=t}}return n}function F(e,t,n){let s=!1;for(let i=0,l=t.length;i<l;i++){let o=t[i],r;if(o instanceof Node)e.push(o);else if(!(o==null||o===!0||o===!1))if(Array.isArray(o))s=F(e,o)||s;else if((r=typeof o)=="string")e.push(document.createTextNode(o));else if(r==="function")if(n){for(;typeof o=="function";)o=o();s=F(e,Array.isArray(o)?o:[o])||s}else e.push(o),s=!0;else e.push(document.createTextNode(o.toString()))}return s}function Z(e,t,n){for(let s=0,i=t.length;s<i;s++)e.insertBefore(t[s],n)}function T(e,t,n,s){if(n===void 0)return e.textContent="";const i=s||document.createTextNode("");if(t.length){let l=!1;for(let o=t.length-1;o>=0;o--){const r=t[o];if(i!==r){const u=r.parentNode===e;!l&&!o?u?e.replaceChild(i,r):e.insertBefore(i,n):u&&r.remove()}else l=!0}}else e.insertBefore(i,n);return[i]}const Ce=le('<svg><g><circle class="eye1"></circle><circle class="eye2"></circle><circle class="eye3"></circle></g></svg>',10,!0);function Me({x:e,y:t,sz:n,color:s,mx:i,my:l}){let[o,r]=B(e),[u,a]=B(t);return ae(()=>{let f=.3*n,d=i()!==null?i()-e:0,c=l()!==null?l()-t:0,p=Math.max(1e-6,Math.sqrt(d*d+c*c)),h=Math.min(f,p);r(e+d/p*h),a(t+c/p*h)}),(()=>{const f=Ce.cloneNode(!0),d=f.firstChild,c=d.nextSibling,p=c.nextSibling;return S(d,"cx",e),S(d,"cy",t),S(d,"r",n),S(c,"r",n*.5),Ee(c,`fill: ${s}`),S(p,"r",n*.2),j(h=>{const E=o(),$=u(),C=o(),w=u();return E!==h._v$&&S(c,"cx",h._v$=E),$!==h._v$2&&S(c,"cy",h._v$2=$),C!==h._v$3&&S(p,"cx",h._v$3=C),w!==h._v$4&&S(p,"cy",h._v$4=w),h},{_v$:void 0,_v$2:void 0,_v$3:void 0,_v$4:void 0}),f})()}const Ne=le('<svg id="eyes"></svg>');function Te(){let e=Math.random()*360,t=Math.round(50+Math.random()*50),n=Math.round(30+Math.random()*40);return`hsl(${e}, ${t}%, ${n}%)`}function _e(e,t){let n=e.x-t.x,s=e.y-t.y;return Math.sqrt(n*n+s*s)}function Le(e,t){return e.every(n=>_e(n,t)>=n.sz+t.sz+5)}function Pe(){let e=[],t=window.innerHeight,n=window.innerWidth;for(let s=0;s<1e3;s++){let i=20+Math.random()*60,l=i+Math.random()*(n-2*i),o=i+Math.random()*(t-2*i),r=Te(),u={x:l,y:o,sz:i,color:r};Le(e,u)&&e.push(u)}return e}function Be(){let e=Pe(),t=window.innerHeight,n=window.innerWidth,[s,i]=B(Math.random()*n),[l,o]=B(Math.random()*t);function r(){let a=document.getElementById("eyes").getBoundingClientRect();i(event.pageX-a.x),o(event.pageY-a.y)}return(()=>{const u=Ne.cloneNode(!0);return u.$$mousemove=r,oe(u,q(xe,{each:e,children:({x:a,y:f,sz:d,color:c})=>q(Me,{x:a,y:f,sz:d,color:c,mx:s,my:l})})),u})()}Se(["mousemove"]);Ae(()=>q(Be,{}),document.getElementById("root"));