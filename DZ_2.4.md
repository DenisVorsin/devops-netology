ДЗ 2.4 Инструменты GIT Ворсин Денис


1. Найдите полный хеш и комментарий коммита, хеш которого начинается на aefea.


	    $ git log aefea
	
	    commit aefead2207ef7e2aa5dc81a34aedf0cad4c32545
	    Author: Alisdair McDiarmid <alisdair@users.noreply.github.com>
	    Date:   Thu Jun 18 10:29:58 2020 -0400
	    Update CHANGELOG.md


2. Какому тегу соответствует коммит 85024d3?
   

    $ git log 85024d3 --oneline

    85024d310 (tag: v0.12.23) v0.12.23



3. Сколько родителей у коммита b8d720? Напишите их хеши.
    2 родителя
      

    $ git log --pretty=%P -n 1 b8d720

    56cd7859e05c36c06b56d013b55a252d0bb7e158 9ea88f22fc6269854151c571162c5bcf958bee2b


4. Перечислите хеши и комментарии всех коммитов которые были сделаны между тегами v0.12.23 и v0.12.24.


    $ git log v0.12.23...v0.12.24 --oneline

    33ff1c03b (tag: v0.12.24) v0.12.24
    b14b74c49 [Website] vmc provider links
    3f235065b Update CHANGELOG.md
    6ae64e247 registry: Fix panic when server is unreachable
    5c619ca1b website: Remove links to the getting started guide's old location
    06275647e Update CHANGELOG.md
    d5f9411f5 command: Fix bug when using terraform login on Windows
    4b6d06cc5 Update CHANGELOG.md
    dd01a3507 Update CHANGELOG.md
    225466bc3 Cleanup after v0.12.23 release


5. Найдите коммит в котором была создана функция func providerSource, ее определение в коде выглядит так func providerSource(...) (вместо троеточего перечислены аргументы).


    $ git grep "func providerSource"
 
    provider_source.go:func providerSource(configs []*cliconfig.ProviderInstallation, services *disco.Disco) (getproviders.Source, tfdiags.Diagnostics) {

    $ git log --reverse provider_source.go 

    commit 8c928e83589d90a031f811fae52a81be7153e82f
    Author: Martin Atkins <mart@degeneration.co.uk>
    Date:   Thu Apr 2 18:04:39 2020 -0700



6. Найдите все коммиты в которых была изменена функция globalPluginDirs.


    $ git grep "func globalPluginDirs"

    plugins.go:func globalPluginDirs() []string {


    $ git log -L :globalPluginDirs:plugins.go --no-patch --oneline

    78b122055 Remove config.go and update things using its aliases
    52dbf9483 keep .terraform.d/plugins for discovery
    41ab0aef7 Add missing OS_ARCH dir to global plugin paths
    66ebff90c move some more plugin search path logic to command
    8364383c3 Push plugin discovery down into command package



7. Кто автор функции synchronizedWriters?
    Функция с таким именем не найдена. 


    $ git grep -r "synchronizedWriters"
    $ grep -Rl synchronizedWriters *
    $ 
