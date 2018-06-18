# sample-encrypt-properties

プロパティファイル内のパスワードを平文で持ちたくない場合に、プロパティファイルの値を暗号化する方法が存在しないか調べた。

## jasypt

jasyptは暗号化の仕組みを提供するライブラリ。  
APIを使うことで、暗号化・複合化が可能となる。

また、スクリプト（sh/bat）が用意されており、コマンドラインで暗号化することもできる。

## jasypt-spring-boot

jasyptを容易にspring bootへ組み込むことをできるようにしたライブラリ。

容易に設定ファイルを透過的に複合化することができる。

最も簡単な使い方としては、Application.java に @EnableEncryptableProperties を追加し、 `application.propeties` へ、`jasypt.encryptor.password` プロパティでパスワードフレーズを設定する。

このパスワードフレーズを使って暗号化された値を `ENC(XXXX)` のように通常のプロパティとして設定すればOK

パスワードフレーズは、 `${JASYPT_ENCRYPTOR_PASSWORD:}` のように環境変数から注入することができる。

また、同じくSpring bootの機能で、起動時に引数で設定することも可能。

1. javaコマンドへの引数の場合  
    `java -jar -Djasypt.encryptor.passowrd=XXX XXX.jar`
2. spring boot jar への引数の場合  
    `java -jar XXX.jar --jasypt.encryptor.password=XXX`

## 手順

1. build.gradle の dependencies に以下を加える  
```
dependencies {
  compile('org.springframework.boot:spring-boot-starter')
  compile('com.github.ulisesbocchio:jasypt-spring-boot:1.17') // これ
     
  compileOnly 'org.projectlombok:lombok'
 
  testCompile('org.springframework.boot:spring-boot-starter-test')
}
```
2. 起動ポイント(Application.java)のクラスに `@EnableEncryptableProperties` をつける。  
```
@SpringBootApplication
@Slf4j
@EnableEncryptableProperties
public class Application {
 
    @Value("${test.password}")
    private String password;
```
3. jasypt公式から本体をダウンロードする。
4. zipファイルを解凍した中にあるbinフォルダ内の encrypt.sh (または、 encrypt.bat )で対象文字列を暗号化する。  
    `> encrypt input={{暗号化対象文字列}} password={{パスフレーズ}}`
5. 4.で出力された暗号化された文字とパスフレーズを application.proprties に設定する。  
```
jasypt.encryptor.password={{パスフレーズ}}
test.password=ENC({{暗号化済み文字列}})
```

## 簡易化

3.ダウンロード～暗号化までを一発で行うため、スクリプト化した。

プロジェクトルートにて、以下のコマンドで暗号化可能。

`script/encryptw input={暗号化対象文字列} password={パスフレーズ}`

同様に、複合も以下の通り。

`script/decryptw input={暗号文} password={パスフレーズ}`

## gradle

Gradleで `bootRun` する際に、複合させるための手段は以下の通り。

1. 環境変数に設定する。  
`JASYPT_ENCRIPTOR_PASSWORD=xxxx; ./gradlew bootRun`
2. 起動時にパラメータとして渡す。  
` ./gradlew bootRun -Djasypt.encriptor.password=xxxx`

## 参考資料

* jasypt
* ulisesbocchio/jasypt-spring-boot