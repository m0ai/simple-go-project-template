# Simple Go Project Template

이 저장소는 간단한 GO 프로젝트 템플릿 입니다. Go 개발팀의 의해 정의된 공식적인 표준은 아니지만 빠르고 간단하게 Go 프로젝트를 빌드하고 실행하기 위해 생성되었습니다.  사용자의 디바이스에서 Go의 대한 종속성을 제거하고 빠른 테스트를 위해 Docker를 사용하여 환경을 설정하였습니다. 해당 프로젝트보다 복잡하고 다양한 사람과의 협업을 통해 프로젝트를 진행하고자 한다면 [표준 GO 프로젝트 레이아웃](https://github.com/golang-standards/project-layout/blob/master/README_ko.md) 을 참고하여 개발을 권장합니다.

누구나 해당 프로젝트에 기여할 수 있습니다. 좋은 아이디어가 있다면 언제든 PR 혹은 Issue를 생성해주세요 :smile:

## 어떻게 시작하나요?

### Requirements

- Make
- Docker, docker-compose

### 시작하기

아래의 명령어를 통해 현재 저장소에 `go.mod`, `go.sum` 파일을 생성합니다. `sample-app` 을 원하는 이름으로 수정하세요.

```bash
touch go.sum
cat <<EOF > go.mod
module sample-app

go 1.15
EOF
```

 makefile에 정의되어 있는 명령어를 실행하여 간편한게 앱을 실행할  수 있습니다.

```bash
make build up
make log

> Attaching to simple-go-project-tempalte_app_1
> app_1   | Hello, Go
> simple-go-project-tempalte_app_1 exited with code 0
```

아래의 명령어를 실행하면 실시간으로 코드에 변경사항이 적용되어 테스트 할 수 있는 (as hotreload)  서비스인 [reflex](https://github.com/cespare/reflex)  으로 `main.go`를 컨테이너 환경에서 실행할 수 있습니다. 

```bash
make watch

> docker-compose run app reflex -r '\.go' -s -- sh -c "go run /build/main.go"
> Creating simple-go-project-tempalte_app_run ... done
> [00] Starting service
> [00] Hello, Go
```

`make watch`으로 앱을 실행한 후 main.go를 수정할 경우 실시간으로 로그가 업데이트 되는 모습을 확인할 수 있습니다.

```go
// Terminal 1
import "fmt"

func main() {
	fmt.Println("Hello, Go. so Easy") // Edited 
}
```

```bash
# Terminal 2
> docker-compose run app reflex -r '\.go' -s -- sh -c "go run /build/main.go"
> Creating simple-go-project-tempalte_app_run ... done
> [00] Killing service
> [00] Starting service
> [00] Hello, Go. so Easy
```



----

아래의 명령어를 사용하여 프로젝트 구성 중 생성하였던 파일과 도커 불륨, 이미지, 컨테이너를 삭제할 수 있습니다.

```bash
make clean
> docker-compose rm --all
> WARNING: --all flag is obsolete. This is now the default behavior of `docker-compose rm`
 Going to remove simple-go-project-tempalte_app_run_70fc30e963c7, simple-go-project-tempalte_app_run_f78df5fd0e51, simple-go-project-tempalte_app_run_23fb859dba87, simple-go-project-tempalte_app_run_80252ad239d2, simple-go-project-tempalte_app_1
> Are you sure? [yN] y
> Removing simple-go-project-tempalte_app_run_70fc30e963c7 ... done
> Removing simple-go-project-tempalte_app_run_f78df5fd0e51 ... done
> Removing simple-go-project-tempalte_app_run_23fb859dba87 ... done
> Removing simple-go-project-tempalte_app_run_80252ad239d2 ... done
> Removing simple-go-project-tempalte_app_1                ... done
```

