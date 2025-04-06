+++
date = '2025-04-04T21:56:30+09:00'
draft = false
title = 'How to Make Devblog With Hugo'

+++


지금까지 내가 만든 블로그 과정 정리!

## ✅ 사전 준비
- GitHub 계정
- Hugo 설치

## ✅ 1단계: GitHub에서 Repository생성
- 이름: `zomggang-devblog`
- Public repository로 생성


## ✅ 2단계: Hugo설치
왜 hugo인가? 일단 Hugo는 정적 페이지를 만드는 툴이다. 막 개발자 도전했을 때는 jekyll이 대세였던 것 같은데 요즘은 Hugo가 좀 더 빠른다거나 local에서 수정하고 바로 반영되는 점으로 Hugo를 많이 사용하는 것 같다. 

Jekyll(Ruby 언어기반)과 Hugo(Go언어)
## 🔍 Hugo vs Jekyll 비교

| 항목 | Jekyll | Hugo |
|------|--------|------|
| 언어 | Ruby 기반 | Go 기반 |
| 빌드 속도 | 느린 편 (특히 대규모 프로젝트) | 매우 빠름 ⚡ |
| 설치 난이도 | Ruby 환경 필요 → Windows에서 조금 번거로움 | Go 포함되어 있어 설치 간단 |
| 사용성 | GitHub와 연동 쉬움 (공식 지원) | GitHub도 사용 가능, 설정 필요 |
| 테마 수 | 많음 (오래된 것도 있음) | 많고, 최신 트렌디한 테마 많음 |
| 커스터마이징 | 다소 복잡 | 비교적 쉬운 편 |
| 문서화 | 풍부 | 풍부하고 최신 문서 많음 |

> 🎯 **결론**:  
> Windows 환경이고, 빠른 속도와 쉬운 셋업을 원했기 때문에 **Hugo**를 선택했다.



#### Hugo의 환경별 install 커맨드
https://gohugo.io/installation/
일단 저는 Windows로 나는 최근의 단말을 포맷해서 Package Manager 의 npm조차 없어서 choco는 사용하지 못했고 기본 winget을 이용해 설치 했다.
```powershell
winget install Hugo.Hugo.Extended
```

보통은 choco로 설치하는 듯하다.
```bash
choco install hugo-extended
```
---

## ✅ 3단계: 로컬에서 새 hugo사이트 생성 

***git submodule***을 사용할 수 있다는 건 정말 좋았다!  
다른 블로그들을 참고해서 설치해봤지만,, 잘 안 됐는데 공식문서를 따라하니 쉽게 됐다   
공식 문서 : https://gohugo.io/getting-started/quick-start/

나의 경우 

### 일단 repository명과 같은 사이트를 만들고
```
hugo new site zomggang-devblog
```
### 테마선택
https://themes.gohugo.io/
![poster](/resources\image\20250406\hugo_theme.png)

원래는 하고 싶었던 게 있었는데 무거워서 그런가,,, 도통 deploy가 안되길래 추천은
공식이 추천하는 papermode나 좀 가벼워보이는 테마부터 넣어보는 것을 추천한다. 
조금 헤맸지만 일단 re-terminal은 문제없이 반영이 됐다!




https://gohugo.io/host-and-deploy/host-on-github-pages/
...