
bin/kernel：     文件格式 elf32-i386


Disassembly of section .text:

00100000 <kern_init>:
int kern_init(void) __attribute__((noreturn));
void grade_backtrace(void);
static void lab1_switch_test(void);

int
kern_init(void) {
  100000:	f3 0f 1e fb          	endbr32 
  100004:	55                   	push   %ebp
  100005:	89 e5                	mov    %esp,%ebp
  100007:	83 ec 18             	sub    $0x18,%esp
    extern char edata[], end[];
    memset(edata, 0, end - edata);
  10000a:	b8 20 0d 11 00       	mov    $0x110d20,%eax
  10000f:	2d 16 fa 10 00       	sub    $0x10fa16,%eax
  100014:	83 ec 04             	sub    $0x4,%esp
  100017:	50                   	push   %eax
  100018:	6a 00                	push   $0x0
  10001a:	68 16 fa 10 00       	push   $0x10fa16
  10001f:	e8 cf 2d 00 00       	call   102df3 <memset>
  100024:	83 c4 10             	add    $0x10,%esp

    cons_init();                // init the console
  100027:	e8 0e 16 00 00       	call   10163a <cons_init>

    const char *message = "(THU.CST) os is loading ...";
  10002c:	c7 45 f4 c0 35 10 00 	movl   $0x1035c0,-0xc(%ebp)
    	const char *message2 = "Rewrite by Groupmore";
  100033:	c7 45 f0 dc 35 10 00 	movl   $0x1035dc,-0x10(%ebp)
    	cprintf("%s\n%s\n\n", message, message2);
  10003a:	83 ec 04             	sub    $0x4,%esp
  10003d:	ff 75 f0             	pushl  -0x10(%ebp)
  100040:	ff 75 f4             	pushl  -0xc(%ebp)
  100043:	68 f1 35 10 00       	push   $0x1035f1
  100048:	e8 22 02 00 00       	call   10026f <cprintf>
  10004d:	83 c4 10             	add    $0x10,%esp
    
    print_kerninfo();
  100050:	e8 c1 08 00 00       	call   100916 <print_kerninfo>
    grade_backtrace();
  100055:	e8 80 00 00 00       	call   1000da <grade_backtrace>
    pmm_init();                 // init physical memory management
  10005a:	e8 32 2a 00 00       	call   102a91 <pmm_init>
    pic_init();                 // init interrupt controller
  10005f:	e8 2f 17 00 00       	call   101793 <pic_init>
    idt_init();                 // init interrupt descriptor table
  100064:	e8 b0 18 00 00       	call   101919 <idt_init>
    clock_init();               // init clock interrupt
  100069:	e8 51 0d 00 00       	call   100dbf <clock_init>
    intr_enable();              // enable irq interrupt
  10006e:	e8 6f 18 00 00       	call   1018e2 <intr_enable>
    //LAB1: CAHLLENGE 1 If you try to do it, uncomment lab1_switch_test()
    // user/kernel mode switch test
    //lab1_switch_test();

    /* do nothing */
    while (1);
  100073:	eb fe                	jmp    100073 <kern_init+0x73>

00100075 <grade_backtrace2>:
}

void __attribute__((noinline))
grade_backtrace2(int arg0, int arg1, int arg2, int arg3) {
  100075:	f3 0f 1e fb          	endbr32 
  100079:	55                   	push   %ebp
  10007a:	89 e5                	mov    %esp,%ebp
  10007c:	83 ec 08             	sub    $0x8,%esp
    mon_backtrace(0, NULL, NULL);
  10007f:	83 ec 04             	sub    $0x4,%esp
  100082:	6a 00                	push   $0x0
  100084:	6a 00                	push   $0x0
  100086:	6a 00                	push   $0x0
  100088:	e8 1c 0d 00 00       	call   100da9 <mon_backtrace>
  10008d:	83 c4 10             	add    $0x10,%esp
}
  100090:	90                   	nop
  100091:	c9                   	leave  
  100092:	c3                   	ret    

00100093 <grade_backtrace1>:

void __attribute__((noinline))
grade_backtrace1(int arg0, int arg1) {
  100093:	f3 0f 1e fb          	endbr32 
  100097:	55                   	push   %ebp
  100098:	89 e5                	mov    %esp,%ebp
  10009a:	53                   	push   %ebx
  10009b:	83 ec 04             	sub    $0x4,%esp
    grade_backtrace2(arg0, (int)&arg0, arg1, (int)&arg1);
  10009e:	8d 4d 0c             	lea    0xc(%ebp),%ecx
  1000a1:	8b 55 0c             	mov    0xc(%ebp),%edx
  1000a4:	8d 5d 08             	lea    0x8(%ebp),%ebx
  1000a7:	8b 45 08             	mov    0x8(%ebp),%eax
  1000aa:	51                   	push   %ecx
  1000ab:	52                   	push   %edx
  1000ac:	53                   	push   %ebx
  1000ad:	50                   	push   %eax
  1000ae:	e8 c2 ff ff ff       	call   100075 <grade_backtrace2>
  1000b3:	83 c4 10             	add    $0x10,%esp
}
  1000b6:	90                   	nop
  1000b7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  1000ba:	c9                   	leave  
  1000bb:	c3                   	ret    

001000bc <grade_backtrace0>:

void __attribute__((noinline))
grade_backtrace0(int arg0, int arg1, int arg2) {
  1000bc:	f3 0f 1e fb          	endbr32 
  1000c0:	55                   	push   %ebp
  1000c1:	89 e5                	mov    %esp,%ebp
  1000c3:	83 ec 08             	sub    $0x8,%esp
    grade_backtrace1(arg0, arg2);
  1000c6:	83 ec 08             	sub    $0x8,%esp
  1000c9:	ff 75 10             	pushl  0x10(%ebp)
  1000cc:	ff 75 08             	pushl  0x8(%ebp)
  1000cf:	e8 bf ff ff ff       	call   100093 <grade_backtrace1>
  1000d4:	83 c4 10             	add    $0x10,%esp
}
  1000d7:	90                   	nop
  1000d8:	c9                   	leave  
  1000d9:	c3                   	ret    

001000da <grade_backtrace>:

void
grade_backtrace(void) {
  1000da:	f3 0f 1e fb          	endbr32 
  1000de:	55                   	push   %ebp
  1000df:	89 e5                	mov    %esp,%ebp
  1000e1:	83 ec 08             	sub    $0x8,%esp
    grade_backtrace0(0, (int)kern_init, 0xffff0000);
  1000e4:	b8 00 00 10 00       	mov    $0x100000,%eax
  1000e9:	83 ec 04             	sub    $0x4,%esp
  1000ec:	68 00 00 ff ff       	push   $0xffff0000
  1000f1:	50                   	push   %eax
  1000f2:	6a 00                	push   $0x0
  1000f4:	e8 c3 ff ff ff       	call   1000bc <grade_backtrace0>
  1000f9:	83 c4 10             	add    $0x10,%esp
}
  1000fc:	90                   	nop
  1000fd:	c9                   	leave  
  1000fe:	c3                   	ret    

001000ff <lab1_print_cur_status>:

static void
lab1_print_cur_status(void) {
  1000ff:	f3 0f 1e fb          	endbr32 
  100103:	55                   	push   %ebp
  100104:	89 e5                	mov    %esp,%ebp
  100106:	83 ec 18             	sub    $0x18,%esp
    static int round = 0;
    uint16_t reg1, reg2, reg3, reg4;
    asm volatile (
  100109:	8c 4d f6             	mov    %cs,-0xa(%ebp)
  10010c:	8c 5d f4             	mov    %ds,-0xc(%ebp)
  10010f:	8c 45 f2             	mov    %es,-0xe(%ebp)
  100112:	8c 55 f0             	mov    %ss,-0x10(%ebp)
            "mov %%cs, %0;"
            "mov %%ds, %1;"
            "mov %%es, %2;"
            "mov %%ss, %3;"
            : "=m"(reg1), "=m"(reg2), "=m"(reg3), "=m"(reg4));
    cprintf("%d: @ring %d\n", round, reg1 & 3);
  100115:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  100119:	0f b7 c0             	movzwl %ax,%eax
  10011c:	83 e0 03             	and    $0x3,%eax
  10011f:	89 c2                	mov    %eax,%edx
  100121:	a1 20 fa 10 00       	mov    0x10fa20,%eax
  100126:	83 ec 04             	sub    $0x4,%esp
  100129:	52                   	push   %edx
  10012a:	50                   	push   %eax
  10012b:	68 f9 35 10 00       	push   $0x1035f9
  100130:	e8 3a 01 00 00       	call   10026f <cprintf>
  100135:	83 c4 10             	add    $0x10,%esp
    cprintf("%d:  cs = %x\n", round, reg1);
  100138:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  10013c:	0f b7 d0             	movzwl %ax,%edx
  10013f:	a1 20 fa 10 00       	mov    0x10fa20,%eax
  100144:	83 ec 04             	sub    $0x4,%esp
  100147:	52                   	push   %edx
  100148:	50                   	push   %eax
  100149:	68 07 36 10 00       	push   $0x103607
  10014e:	e8 1c 01 00 00       	call   10026f <cprintf>
  100153:	83 c4 10             	add    $0x10,%esp
    cprintf("%d:  ds = %x\n", round, reg2);
  100156:	0f b7 45 f4          	movzwl -0xc(%ebp),%eax
  10015a:	0f b7 d0             	movzwl %ax,%edx
  10015d:	a1 20 fa 10 00       	mov    0x10fa20,%eax
  100162:	83 ec 04             	sub    $0x4,%esp
  100165:	52                   	push   %edx
  100166:	50                   	push   %eax
  100167:	68 15 36 10 00       	push   $0x103615
  10016c:	e8 fe 00 00 00       	call   10026f <cprintf>
  100171:	83 c4 10             	add    $0x10,%esp
    cprintf("%d:  es = %x\n", round, reg3);
  100174:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
  100178:	0f b7 d0             	movzwl %ax,%edx
  10017b:	a1 20 fa 10 00       	mov    0x10fa20,%eax
  100180:	83 ec 04             	sub    $0x4,%esp
  100183:	52                   	push   %edx
  100184:	50                   	push   %eax
  100185:	68 23 36 10 00       	push   $0x103623
  10018a:	e8 e0 00 00 00       	call   10026f <cprintf>
  10018f:	83 c4 10             	add    $0x10,%esp
    cprintf("%d:  ss = %x\n", round, reg4);
  100192:	0f b7 45 f0          	movzwl -0x10(%ebp),%eax
  100196:	0f b7 d0             	movzwl %ax,%edx
  100199:	a1 20 fa 10 00       	mov    0x10fa20,%eax
  10019e:	83 ec 04             	sub    $0x4,%esp
  1001a1:	52                   	push   %edx
  1001a2:	50                   	push   %eax
  1001a3:	68 31 36 10 00       	push   $0x103631
  1001a8:	e8 c2 00 00 00       	call   10026f <cprintf>
  1001ad:	83 c4 10             	add    $0x10,%esp
    round ++;
  1001b0:	a1 20 fa 10 00       	mov    0x10fa20,%eax
  1001b5:	83 c0 01             	add    $0x1,%eax
  1001b8:	a3 20 fa 10 00       	mov    %eax,0x10fa20
}
  1001bd:	90                   	nop
  1001be:	c9                   	leave  
  1001bf:	c3                   	ret    

001001c0 <lab1_switch_to_user>:

static void
lab1_switch_to_user(void) {
  1001c0:	f3 0f 1e fb          	endbr32 
  1001c4:	55                   	push   %ebp
  1001c5:	89 e5                	mov    %esp,%ebp
    //LAB1 CHALLENGE 1 : TODO
}
  1001c7:	90                   	nop
  1001c8:	5d                   	pop    %ebp
  1001c9:	c3                   	ret    

001001ca <lab1_switch_to_kernel>:

static void
lab1_switch_to_kernel(void) {
  1001ca:	f3 0f 1e fb          	endbr32 
  1001ce:	55                   	push   %ebp
  1001cf:	89 e5                	mov    %esp,%ebp
    //LAB1 CHALLENGE 1 :  TODO
}
  1001d1:	90                   	nop
  1001d2:	5d                   	pop    %ebp
  1001d3:	c3                   	ret    

001001d4 <lab1_switch_test>:

static void
lab1_switch_test(void) {
  1001d4:	f3 0f 1e fb          	endbr32 
  1001d8:	55                   	push   %ebp
  1001d9:	89 e5                	mov    %esp,%ebp
  1001db:	83 ec 08             	sub    $0x8,%esp
    lab1_print_cur_status();
  1001de:	e8 1c ff ff ff       	call   1000ff <lab1_print_cur_status>
    cprintf("+++ switch to  user  mode +++\n");
  1001e3:	83 ec 0c             	sub    $0xc,%esp
  1001e6:	68 40 36 10 00       	push   $0x103640
  1001eb:	e8 7f 00 00 00       	call   10026f <cprintf>
  1001f0:	83 c4 10             	add    $0x10,%esp
    lab1_switch_to_user();
  1001f3:	e8 c8 ff ff ff       	call   1001c0 <lab1_switch_to_user>
    lab1_print_cur_status();
  1001f8:	e8 02 ff ff ff       	call   1000ff <lab1_print_cur_status>
    cprintf("+++ switch to kernel mode +++\n");
  1001fd:	83 ec 0c             	sub    $0xc,%esp
  100200:	68 60 36 10 00       	push   $0x103660
  100205:	e8 65 00 00 00       	call   10026f <cprintf>
  10020a:	83 c4 10             	add    $0x10,%esp
    lab1_switch_to_kernel();
  10020d:	e8 b8 ff ff ff       	call   1001ca <lab1_switch_to_kernel>
    lab1_print_cur_status();
  100212:	e8 e8 fe ff ff       	call   1000ff <lab1_print_cur_status>
}
  100217:	90                   	nop
  100218:	c9                   	leave  
  100219:	c3                   	ret    

0010021a <cputch>:
/* *
 * cputch - writes a single character @c to stdout, and it will
 * increace the value of counter pointed by @cnt.
 * */
static void
cputch(int c, int *cnt) {
  10021a:	f3 0f 1e fb          	endbr32 
  10021e:	55                   	push   %ebp
  10021f:	89 e5                	mov    %esp,%ebp
  100221:	83 ec 08             	sub    $0x8,%esp
    cons_putc(c);
  100224:	83 ec 0c             	sub    $0xc,%esp
  100227:	ff 75 08             	pushl  0x8(%ebp)
  10022a:	e8 40 14 00 00       	call   10166f <cons_putc>
  10022f:	83 c4 10             	add    $0x10,%esp
    (*cnt) ++;
  100232:	8b 45 0c             	mov    0xc(%ebp),%eax
  100235:	8b 00                	mov    (%eax),%eax
  100237:	8d 50 01             	lea    0x1(%eax),%edx
  10023a:	8b 45 0c             	mov    0xc(%ebp),%eax
  10023d:	89 10                	mov    %edx,(%eax)
}
  10023f:	90                   	nop
  100240:	c9                   	leave  
  100241:	c3                   	ret    

00100242 <vcprintf>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want cprintf() instead.
 * */
int
vcprintf(const char *fmt, va_list ap) {
  100242:	f3 0f 1e fb          	endbr32 
  100246:	55                   	push   %ebp
  100247:	89 e5                	mov    %esp,%ebp
  100249:	83 ec 18             	sub    $0x18,%esp
    int cnt = 0;
  10024c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    vprintfmt((void*)cputch, &cnt, fmt, ap);
  100253:	ff 75 0c             	pushl  0xc(%ebp)
  100256:	ff 75 08             	pushl  0x8(%ebp)
  100259:	8d 45 f4             	lea    -0xc(%ebp),%eax
  10025c:	50                   	push   %eax
  10025d:	68 1a 02 10 00       	push   $0x10021a
  100262:	e8 db 2e 00 00       	call   103142 <vprintfmt>
  100267:	83 c4 10             	add    $0x10,%esp
    return cnt;
  10026a:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  10026d:	c9                   	leave  
  10026e:	c3                   	ret    

0010026f <cprintf>:
 *
 * The return value is the number of characters which would be
 * written to stdout.
 * */
int
cprintf(const char *fmt, ...) {
  10026f:	f3 0f 1e fb          	endbr32 
  100273:	55                   	push   %ebp
  100274:	89 e5                	mov    %esp,%ebp
  100276:	83 ec 18             	sub    $0x18,%esp
    va_list ap;
    int cnt;
    va_start(ap, fmt);
  100279:	8d 45 0c             	lea    0xc(%ebp),%eax
  10027c:	89 45 f0             	mov    %eax,-0x10(%ebp)
    cnt = vcprintf(fmt, ap);
  10027f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100282:	83 ec 08             	sub    $0x8,%esp
  100285:	50                   	push   %eax
  100286:	ff 75 08             	pushl  0x8(%ebp)
  100289:	e8 b4 ff ff ff       	call   100242 <vcprintf>
  10028e:	83 c4 10             	add    $0x10,%esp
  100291:	89 45 f4             	mov    %eax,-0xc(%ebp)
    va_end(ap);
    return cnt;
  100294:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  100297:	c9                   	leave  
  100298:	c3                   	ret    

00100299 <cputchar>:

/* cputchar - writes a single character to stdout */
void
cputchar(int c) {
  100299:	f3 0f 1e fb          	endbr32 
  10029d:	55                   	push   %ebp
  10029e:	89 e5                	mov    %esp,%ebp
  1002a0:	83 ec 08             	sub    $0x8,%esp
    cons_putc(c);
  1002a3:	83 ec 0c             	sub    $0xc,%esp
  1002a6:	ff 75 08             	pushl  0x8(%ebp)
  1002a9:	e8 c1 13 00 00       	call   10166f <cons_putc>
  1002ae:	83 c4 10             	add    $0x10,%esp
}
  1002b1:	90                   	nop
  1002b2:	c9                   	leave  
  1002b3:	c3                   	ret    

001002b4 <cputs>:
/* *
 * cputs- writes the string pointed by @str to stdout and
 * appends a newline character.
 * */
int
cputs(const char *str) {
  1002b4:	f3 0f 1e fb          	endbr32 
  1002b8:	55                   	push   %ebp
  1002b9:	89 e5                	mov    %esp,%ebp
  1002bb:	83 ec 18             	sub    $0x18,%esp
    int cnt = 0;
  1002be:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    char c;
    while ((c = *str ++) != '\0') {
  1002c5:	eb 14                	jmp    1002db <cputs+0x27>
        cputch(c, &cnt);
  1002c7:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  1002cb:	83 ec 08             	sub    $0x8,%esp
  1002ce:	8d 55 f0             	lea    -0x10(%ebp),%edx
  1002d1:	52                   	push   %edx
  1002d2:	50                   	push   %eax
  1002d3:	e8 42 ff ff ff       	call   10021a <cputch>
  1002d8:	83 c4 10             	add    $0x10,%esp
    while ((c = *str ++) != '\0') {
  1002db:	8b 45 08             	mov    0x8(%ebp),%eax
  1002de:	8d 50 01             	lea    0x1(%eax),%edx
  1002e1:	89 55 08             	mov    %edx,0x8(%ebp)
  1002e4:	0f b6 00             	movzbl (%eax),%eax
  1002e7:	88 45 f7             	mov    %al,-0x9(%ebp)
  1002ea:	80 7d f7 00          	cmpb   $0x0,-0x9(%ebp)
  1002ee:	75 d7                	jne    1002c7 <cputs+0x13>
    }
    cputch('\n', &cnt);
  1002f0:	83 ec 08             	sub    $0x8,%esp
  1002f3:	8d 45 f0             	lea    -0x10(%ebp),%eax
  1002f6:	50                   	push   %eax
  1002f7:	6a 0a                	push   $0xa
  1002f9:	e8 1c ff ff ff       	call   10021a <cputch>
  1002fe:	83 c4 10             	add    $0x10,%esp
    return cnt;
  100301:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  100304:	c9                   	leave  
  100305:	c3                   	ret    

00100306 <getchar>:

/* getchar - reads a single non-zero character from stdin */
int
getchar(void) {
  100306:	f3 0f 1e fb          	endbr32 
  10030a:	55                   	push   %ebp
  10030b:	89 e5                	mov    %esp,%ebp
  10030d:	83 ec 18             	sub    $0x18,%esp
    int c;
    while ((c = cons_getc()) == 0)
  100310:	90                   	nop
  100311:	e8 8d 13 00 00       	call   1016a3 <cons_getc>
  100316:	89 45 f4             	mov    %eax,-0xc(%ebp)
  100319:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  10031d:	74 f2                	je     100311 <getchar+0xb>
        /* do nothing */;
    return c;
  10031f:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  100322:	c9                   	leave  
  100323:	c3                   	ret    

00100324 <readline>:
 * The readline() function returns the text of the line read. If some errors
 * are happened, NULL is returned. The return value is a global variable,
 * thus it should be copied before it is used.
 * */
char *
readline(const char *prompt) {
  100324:	f3 0f 1e fb          	endbr32 
  100328:	55                   	push   %ebp
  100329:	89 e5                	mov    %esp,%ebp
  10032b:	83 ec 18             	sub    $0x18,%esp
    if (prompt != NULL) {
  10032e:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  100332:	74 13                	je     100347 <readline+0x23>
        cprintf("%s", prompt);
  100334:	83 ec 08             	sub    $0x8,%esp
  100337:	ff 75 08             	pushl  0x8(%ebp)
  10033a:	68 7f 36 10 00       	push   $0x10367f
  10033f:	e8 2b ff ff ff       	call   10026f <cprintf>
  100344:	83 c4 10             	add    $0x10,%esp
    }
    int i = 0, c;
  100347:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while (1) {
        c = getchar();
  10034e:	e8 b3 ff ff ff       	call   100306 <getchar>
  100353:	89 45 f0             	mov    %eax,-0x10(%ebp)
        if (c < 0) {
  100356:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  10035a:	79 0a                	jns    100366 <readline+0x42>
            return NULL;
  10035c:	b8 00 00 00 00       	mov    $0x0,%eax
  100361:	e9 82 00 00 00       	jmp    1003e8 <readline+0xc4>
        }
        else if (c >= ' ' && i < BUFSIZE - 1) {
  100366:	83 7d f0 1f          	cmpl   $0x1f,-0x10(%ebp)
  10036a:	7e 2b                	jle    100397 <readline+0x73>
  10036c:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  100373:	7f 22                	jg     100397 <readline+0x73>
            cputchar(c);
  100375:	83 ec 0c             	sub    $0xc,%esp
  100378:	ff 75 f0             	pushl  -0x10(%ebp)
  10037b:	e8 19 ff ff ff       	call   100299 <cputchar>
  100380:	83 c4 10             	add    $0x10,%esp
            buf[i ++] = c;
  100383:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100386:	8d 50 01             	lea    0x1(%eax),%edx
  100389:	89 55 f4             	mov    %edx,-0xc(%ebp)
  10038c:	8b 55 f0             	mov    -0x10(%ebp),%edx
  10038f:	88 90 40 fa 10 00    	mov    %dl,0x10fa40(%eax)
  100395:	eb 4c                	jmp    1003e3 <readline+0xbf>
        }
        else if (c == '\b' && i > 0) {
  100397:	83 7d f0 08          	cmpl   $0x8,-0x10(%ebp)
  10039b:	75 1a                	jne    1003b7 <readline+0x93>
  10039d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  1003a1:	7e 14                	jle    1003b7 <readline+0x93>
            cputchar(c);
  1003a3:	83 ec 0c             	sub    $0xc,%esp
  1003a6:	ff 75 f0             	pushl  -0x10(%ebp)
  1003a9:	e8 eb fe ff ff       	call   100299 <cputchar>
  1003ae:	83 c4 10             	add    $0x10,%esp
            i --;
  1003b1:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
  1003b5:	eb 2c                	jmp    1003e3 <readline+0xbf>
        }
        else if (c == '\n' || c == '\r') {
  1003b7:	83 7d f0 0a          	cmpl   $0xa,-0x10(%ebp)
  1003bb:	74 06                	je     1003c3 <readline+0x9f>
  1003bd:	83 7d f0 0d          	cmpl   $0xd,-0x10(%ebp)
  1003c1:	75 8b                	jne    10034e <readline+0x2a>
            cputchar(c);
  1003c3:	83 ec 0c             	sub    $0xc,%esp
  1003c6:	ff 75 f0             	pushl  -0x10(%ebp)
  1003c9:	e8 cb fe ff ff       	call   100299 <cputchar>
  1003ce:	83 c4 10             	add    $0x10,%esp
            buf[i] = '\0';
  1003d1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1003d4:	05 40 fa 10 00       	add    $0x10fa40,%eax
  1003d9:	c6 00 00             	movb   $0x0,(%eax)
            return buf;
  1003dc:	b8 40 fa 10 00       	mov    $0x10fa40,%eax
  1003e1:	eb 05                	jmp    1003e8 <readline+0xc4>
        c = getchar();
  1003e3:	e9 66 ff ff ff       	jmp    10034e <readline+0x2a>
        }
    }
}
  1003e8:	c9                   	leave  
  1003e9:	c3                   	ret    

001003ea <__panic>:
/* *
 * __panic - __panic is called on unresolvable fatal errors. it prints
 * "panic: 'message'", and then enters the kernel monitor.
 * */
void
__panic(const char *file, int line, const char *fmt, ...) {
  1003ea:	f3 0f 1e fb          	endbr32 
  1003ee:	55                   	push   %ebp
  1003ef:	89 e5                	mov    %esp,%ebp
  1003f1:	83 ec 18             	sub    $0x18,%esp
    if (is_panic) {
  1003f4:	a1 40 fe 10 00       	mov    0x10fe40,%eax
  1003f9:	85 c0                	test   %eax,%eax
  1003fb:	75 4a                	jne    100447 <__panic+0x5d>
        goto panic_dead;
    }
    is_panic = 1;
  1003fd:	c7 05 40 fe 10 00 01 	movl   $0x1,0x10fe40
  100404:	00 00 00 

    // print the 'message'
    va_list ap;
    va_start(ap, fmt);
  100407:	8d 45 14             	lea    0x14(%ebp),%eax
  10040a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    cprintf("kernel panic at %s:%d:\n    ", file, line);
  10040d:	83 ec 04             	sub    $0x4,%esp
  100410:	ff 75 0c             	pushl  0xc(%ebp)
  100413:	ff 75 08             	pushl  0x8(%ebp)
  100416:	68 82 36 10 00       	push   $0x103682
  10041b:	e8 4f fe ff ff       	call   10026f <cprintf>
  100420:	83 c4 10             	add    $0x10,%esp
    vcprintf(fmt, ap);
  100423:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100426:	83 ec 08             	sub    $0x8,%esp
  100429:	50                   	push   %eax
  10042a:	ff 75 10             	pushl  0x10(%ebp)
  10042d:	e8 10 fe ff ff       	call   100242 <vcprintf>
  100432:	83 c4 10             	add    $0x10,%esp
    cprintf("\n");
  100435:	83 ec 0c             	sub    $0xc,%esp
  100438:	68 9e 36 10 00       	push   $0x10369e
  10043d:	e8 2d fe ff ff       	call   10026f <cprintf>
  100442:	83 c4 10             	add    $0x10,%esp
  100445:	eb 01                	jmp    100448 <__panic+0x5e>
        goto panic_dead;
  100447:	90                   	nop
    va_end(ap);

panic_dead:
    intr_disable();
  100448:	e8 a1 14 00 00       	call   1018ee <intr_disable>
    while (1) {
        kmonitor(NULL);
  10044d:	83 ec 0c             	sub    $0xc,%esp
  100450:	6a 00                	push   $0x0
  100452:	e8 6c 08 00 00       	call   100cc3 <kmonitor>
  100457:	83 c4 10             	add    $0x10,%esp
  10045a:	eb f1                	jmp    10044d <__panic+0x63>

0010045c <__warn>:
    }
}

/* __warn - like panic, but don't */
void
__warn(const char *file, int line, const char *fmt, ...) {
  10045c:	f3 0f 1e fb          	endbr32 
  100460:	55                   	push   %ebp
  100461:	89 e5                	mov    %esp,%ebp
  100463:	83 ec 18             	sub    $0x18,%esp
    va_list ap;
    va_start(ap, fmt);
  100466:	8d 45 14             	lea    0x14(%ebp),%eax
  100469:	89 45 f4             	mov    %eax,-0xc(%ebp)
    cprintf("kernel warning at %s:%d:\n    ", file, line);
  10046c:	83 ec 04             	sub    $0x4,%esp
  10046f:	ff 75 0c             	pushl  0xc(%ebp)
  100472:	ff 75 08             	pushl  0x8(%ebp)
  100475:	68 a0 36 10 00       	push   $0x1036a0
  10047a:	e8 f0 fd ff ff       	call   10026f <cprintf>
  10047f:	83 c4 10             	add    $0x10,%esp
    vcprintf(fmt, ap);
  100482:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100485:	83 ec 08             	sub    $0x8,%esp
  100488:	50                   	push   %eax
  100489:	ff 75 10             	pushl  0x10(%ebp)
  10048c:	e8 b1 fd ff ff       	call   100242 <vcprintf>
  100491:	83 c4 10             	add    $0x10,%esp
    cprintf("\n");
  100494:	83 ec 0c             	sub    $0xc,%esp
  100497:	68 9e 36 10 00       	push   $0x10369e
  10049c:	e8 ce fd ff ff       	call   10026f <cprintf>
  1004a1:	83 c4 10             	add    $0x10,%esp
    va_end(ap);
}
  1004a4:	90                   	nop
  1004a5:	c9                   	leave  
  1004a6:	c3                   	ret    

001004a7 <is_kernel_panic>:

bool
is_kernel_panic(void) {
  1004a7:	f3 0f 1e fb          	endbr32 
  1004ab:	55                   	push   %ebp
  1004ac:	89 e5                	mov    %esp,%ebp
    return is_panic;
  1004ae:	a1 40 fe 10 00       	mov    0x10fe40,%eax
}
  1004b3:	5d                   	pop    %ebp
  1004b4:	c3                   	ret    

001004b5 <stab_binsearch>:
 *      stab_binsearch(stabs, &left, &right, N_SO, 0xf0100184);
 * will exit setting left = 118, right = 554.
 * */
static void
stab_binsearch(const struct stab *stabs, int *region_left, int *region_right,
           int type, uintptr_t addr) {
  1004b5:	f3 0f 1e fb          	endbr32 
  1004b9:	55                   	push   %ebp
  1004ba:	89 e5                	mov    %esp,%ebp
  1004bc:	83 ec 20             	sub    $0x20,%esp
    int l = *region_left, r = *region_right, any_matches = 0;
  1004bf:	8b 45 0c             	mov    0xc(%ebp),%eax
  1004c2:	8b 00                	mov    (%eax),%eax
  1004c4:	89 45 fc             	mov    %eax,-0x4(%ebp)
  1004c7:	8b 45 10             	mov    0x10(%ebp),%eax
  1004ca:	8b 00                	mov    (%eax),%eax
  1004cc:	89 45 f8             	mov    %eax,-0x8(%ebp)
  1004cf:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

    while (l <= r) {
  1004d6:	e9 d2 00 00 00       	jmp    1005ad <stab_binsearch+0xf8>
        int true_m = (l + r) / 2, m = true_m;
  1004db:	8b 55 fc             	mov    -0x4(%ebp),%edx
  1004de:	8b 45 f8             	mov    -0x8(%ebp),%eax
  1004e1:	01 d0                	add    %edx,%eax
  1004e3:	89 c2                	mov    %eax,%edx
  1004e5:	c1 ea 1f             	shr    $0x1f,%edx
  1004e8:	01 d0                	add    %edx,%eax
  1004ea:	d1 f8                	sar    %eax
  1004ec:	89 45 ec             	mov    %eax,-0x14(%ebp)
  1004ef:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1004f2:	89 45 f0             	mov    %eax,-0x10(%ebp)

        // search for earliest stab with right type
        while (m >= l && stabs[m].n_type != type) {
  1004f5:	eb 04                	jmp    1004fb <stab_binsearch+0x46>
            m --;
  1004f7:	83 6d f0 01          	subl   $0x1,-0x10(%ebp)
        while (m >= l && stabs[m].n_type != type) {
  1004fb:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1004fe:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  100501:	7c 1f                	jl     100522 <stab_binsearch+0x6d>
  100503:	8b 55 f0             	mov    -0x10(%ebp),%edx
  100506:	89 d0                	mov    %edx,%eax
  100508:	01 c0                	add    %eax,%eax
  10050a:	01 d0                	add    %edx,%eax
  10050c:	c1 e0 02             	shl    $0x2,%eax
  10050f:	89 c2                	mov    %eax,%edx
  100511:	8b 45 08             	mov    0x8(%ebp),%eax
  100514:	01 d0                	add    %edx,%eax
  100516:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  10051a:	0f b6 c0             	movzbl %al,%eax
  10051d:	39 45 14             	cmp    %eax,0x14(%ebp)
  100520:	75 d5                	jne    1004f7 <stab_binsearch+0x42>
        }
        if (m < l) {    // no match in [l, m]
  100522:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100525:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  100528:	7d 0b                	jge    100535 <stab_binsearch+0x80>
            l = true_m + 1;
  10052a:	8b 45 ec             	mov    -0x14(%ebp),%eax
  10052d:	83 c0 01             	add    $0x1,%eax
  100530:	89 45 fc             	mov    %eax,-0x4(%ebp)
            continue;
  100533:	eb 78                	jmp    1005ad <stab_binsearch+0xf8>
        }

        // actual binary search
        any_matches = 1;
  100535:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        if (stabs[m].n_value < addr) {
  10053c:	8b 55 f0             	mov    -0x10(%ebp),%edx
  10053f:	89 d0                	mov    %edx,%eax
  100541:	01 c0                	add    %eax,%eax
  100543:	01 d0                	add    %edx,%eax
  100545:	c1 e0 02             	shl    $0x2,%eax
  100548:	89 c2                	mov    %eax,%edx
  10054a:	8b 45 08             	mov    0x8(%ebp),%eax
  10054d:	01 d0                	add    %edx,%eax
  10054f:	8b 40 08             	mov    0x8(%eax),%eax
  100552:	39 45 18             	cmp    %eax,0x18(%ebp)
  100555:	76 13                	jbe    10056a <stab_binsearch+0xb5>
            *region_left = m;
  100557:	8b 45 0c             	mov    0xc(%ebp),%eax
  10055a:	8b 55 f0             	mov    -0x10(%ebp),%edx
  10055d:	89 10                	mov    %edx,(%eax)
            l = true_m + 1;
  10055f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  100562:	83 c0 01             	add    $0x1,%eax
  100565:	89 45 fc             	mov    %eax,-0x4(%ebp)
  100568:	eb 43                	jmp    1005ad <stab_binsearch+0xf8>
        } else if (stabs[m].n_value > addr) {
  10056a:	8b 55 f0             	mov    -0x10(%ebp),%edx
  10056d:	89 d0                	mov    %edx,%eax
  10056f:	01 c0                	add    %eax,%eax
  100571:	01 d0                	add    %edx,%eax
  100573:	c1 e0 02             	shl    $0x2,%eax
  100576:	89 c2                	mov    %eax,%edx
  100578:	8b 45 08             	mov    0x8(%ebp),%eax
  10057b:	01 d0                	add    %edx,%eax
  10057d:	8b 40 08             	mov    0x8(%eax),%eax
  100580:	39 45 18             	cmp    %eax,0x18(%ebp)
  100583:	73 16                	jae    10059b <stab_binsearch+0xe6>
            *region_right = m - 1;
  100585:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100588:	8d 50 ff             	lea    -0x1(%eax),%edx
  10058b:	8b 45 10             	mov    0x10(%ebp),%eax
  10058e:	89 10                	mov    %edx,(%eax)
            r = m - 1;
  100590:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100593:	83 e8 01             	sub    $0x1,%eax
  100596:	89 45 f8             	mov    %eax,-0x8(%ebp)
  100599:	eb 12                	jmp    1005ad <stab_binsearch+0xf8>
        } else {
            // exact match for 'addr', but continue loop to find
            // *region_right
            *region_left = m;
  10059b:	8b 45 0c             	mov    0xc(%ebp),%eax
  10059e:	8b 55 f0             	mov    -0x10(%ebp),%edx
  1005a1:	89 10                	mov    %edx,(%eax)
            l = m;
  1005a3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1005a6:	89 45 fc             	mov    %eax,-0x4(%ebp)
            addr ++;
  1005a9:	83 45 18 01          	addl   $0x1,0x18(%ebp)
    while (l <= r) {
  1005ad:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1005b0:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  1005b3:	0f 8e 22 ff ff ff    	jle    1004db <stab_binsearch+0x26>
        }
    }

    if (!any_matches) {
  1005b9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  1005bd:	75 0f                	jne    1005ce <stab_binsearch+0x119>
        *region_right = *region_left - 1;
  1005bf:	8b 45 0c             	mov    0xc(%ebp),%eax
  1005c2:	8b 00                	mov    (%eax),%eax
  1005c4:	8d 50 ff             	lea    -0x1(%eax),%edx
  1005c7:	8b 45 10             	mov    0x10(%ebp),%eax
  1005ca:	89 10                	mov    %edx,(%eax)
        l = *region_right;
        for (; l > *region_left && stabs[l].n_type != type; l --)
            /* do nothing */;
        *region_left = l;
    }
}
  1005cc:	eb 3f                	jmp    10060d <stab_binsearch+0x158>
        l = *region_right;
  1005ce:	8b 45 10             	mov    0x10(%ebp),%eax
  1005d1:	8b 00                	mov    (%eax),%eax
  1005d3:	89 45 fc             	mov    %eax,-0x4(%ebp)
        for (; l > *region_left && stabs[l].n_type != type; l --)
  1005d6:	eb 04                	jmp    1005dc <stab_binsearch+0x127>
  1005d8:	83 6d fc 01          	subl   $0x1,-0x4(%ebp)
  1005dc:	8b 45 0c             	mov    0xc(%ebp),%eax
  1005df:	8b 00                	mov    (%eax),%eax
  1005e1:	39 45 fc             	cmp    %eax,-0x4(%ebp)
  1005e4:	7e 1f                	jle    100605 <stab_binsearch+0x150>
  1005e6:	8b 55 fc             	mov    -0x4(%ebp),%edx
  1005e9:	89 d0                	mov    %edx,%eax
  1005eb:	01 c0                	add    %eax,%eax
  1005ed:	01 d0                	add    %edx,%eax
  1005ef:	c1 e0 02             	shl    $0x2,%eax
  1005f2:	89 c2                	mov    %eax,%edx
  1005f4:	8b 45 08             	mov    0x8(%ebp),%eax
  1005f7:	01 d0                	add    %edx,%eax
  1005f9:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  1005fd:	0f b6 c0             	movzbl %al,%eax
  100600:	39 45 14             	cmp    %eax,0x14(%ebp)
  100603:	75 d3                	jne    1005d8 <stab_binsearch+0x123>
        *region_left = l;
  100605:	8b 45 0c             	mov    0xc(%ebp),%eax
  100608:	8b 55 fc             	mov    -0x4(%ebp),%edx
  10060b:	89 10                	mov    %edx,(%eax)
}
  10060d:	90                   	nop
  10060e:	c9                   	leave  
  10060f:	c3                   	ret    

00100610 <debuginfo_eip>:
 * the specified instruction address, @addr.  Returns 0 if information
 * was found, and negative if not.  But even if it returns negative it
 * has stored some information into '*info'.
 * */
int
debuginfo_eip(uintptr_t addr, struct eipdebuginfo *info) {
  100610:	f3 0f 1e fb          	endbr32 
  100614:	55                   	push   %ebp
  100615:	89 e5                	mov    %esp,%ebp
  100617:	83 ec 38             	sub    $0x38,%esp
    const struct stab *stabs, *stab_end;
    const char *stabstr, *stabstr_end;

    info->eip_file = "<unknown>";
  10061a:	8b 45 0c             	mov    0xc(%ebp),%eax
  10061d:	c7 00 c0 36 10 00    	movl   $0x1036c0,(%eax)
    info->eip_line = 0;
  100623:	8b 45 0c             	mov    0xc(%ebp),%eax
  100626:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    info->eip_fn_name = "<unknown>";
  10062d:	8b 45 0c             	mov    0xc(%ebp),%eax
  100630:	c7 40 08 c0 36 10 00 	movl   $0x1036c0,0x8(%eax)
    info->eip_fn_namelen = 9;
  100637:	8b 45 0c             	mov    0xc(%ebp),%eax
  10063a:	c7 40 0c 09 00 00 00 	movl   $0x9,0xc(%eax)
    info->eip_fn_addr = addr;
  100641:	8b 45 0c             	mov    0xc(%ebp),%eax
  100644:	8b 55 08             	mov    0x8(%ebp),%edx
  100647:	89 50 10             	mov    %edx,0x10(%eax)
    info->eip_fn_narg = 0;
  10064a:	8b 45 0c             	mov    0xc(%ebp),%eax
  10064d:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)

    stabs = __STAB_BEGIN__;
  100654:	c7 45 f4 ec 3e 10 00 	movl   $0x103eec,-0xc(%ebp)
    stab_end = __STAB_END__;
  10065b:	c7 45 f0 f8 cb 10 00 	movl   $0x10cbf8,-0x10(%ebp)
    stabstr = __STABSTR_BEGIN__;
  100662:	c7 45 ec f9 cb 10 00 	movl   $0x10cbf9,-0x14(%ebp)
    stabstr_end = __STABSTR_END__;
  100669:	c7 45 e8 f3 ec 10 00 	movl   $0x10ecf3,-0x18(%ebp)

    // String table validity checks
    if (stabstr_end <= stabstr || stabstr_end[-1] != 0) {
  100670:	8b 45 e8             	mov    -0x18(%ebp),%eax
  100673:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  100676:	76 0d                	jbe    100685 <debuginfo_eip+0x75>
  100678:	8b 45 e8             	mov    -0x18(%ebp),%eax
  10067b:	83 e8 01             	sub    $0x1,%eax
  10067e:	0f b6 00             	movzbl (%eax),%eax
  100681:	84 c0                	test   %al,%al
  100683:	74 0a                	je     10068f <debuginfo_eip+0x7f>
        return -1;
  100685:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  10068a:	e9 85 02 00 00       	jmp    100914 <debuginfo_eip+0x304>
    // 'eip'.  First, we find the basic source file containing 'eip'.
    // Then, we look in that source file for the function.  Then we look
    // for the line number.

    // Search the entire set of stabs for the source file (type N_SO).
    int lfile = 0, rfile = (stab_end - stabs) - 1;
  10068f:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  100696:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100699:	2b 45 f4             	sub    -0xc(%ebp),%eax
  10069c:	c1 f8 02             	sar    $0x2,%eax
  10069f:	69 c0 ab aa aa aa    	imul   $0xaaaaaaab,%eax,%eax
  1006a5:	83 e8 01             	sub    $0x1,%eax
  1006a8:	89 45 e0             	mov    %eax,-0x20(%ebp)
    stab_binsearch(stabs, &lfile, &rfile, N_SO, addr);
  1006ab:	ff 75 08             	pushl  0x8(%ebp)
  1006ae:	6a 64                	push   $0x64
  1006b0:	8d 45 e0             	lea    -0x20(%ebp),%eax
  1006b3:	50                   	push   %eax
  1006b4:	8d 45 e4             	lea    -0x1c(%ebp),%eax
  1006b7:	50                   	push   %eax
  1006b8:	ff 75 f4             	pushl  -0xc(%ebp)
  1006bb:	e8 f5 fd ff ff       	call   1004b5 <stab_binsearch>
  1006c0:	83 c4 14             	add    $0x14,%esp
    if (lfile == 0)
  1006c3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1006c6:	85 c0                	test   %eax,%eax
  1006c8:	75 0a                	jne    1006d4 <debuginfo_eip+0xc4>
        return -1;
  1006ca:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  1006cf:	e9 40 02 00 00       	jmp    100914 <debuginfo_eip+0x304>

    // Search within that file's stabs for the function definition
    // (N_FUN).
    int lfun = lfile, rfun = rfile;
  1006d4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1006d7:	89 45 dc             	mov    %eax,-0x24(%ebp)
  1006da:	8b 45 e0             	mov    -0x20(%ebp),%eax
  1006dd:	89 45 d8             	mov    %eax,-0x28(%ebp)
    int lline, rline;
    stab_binsearch(stabs, &lfun, &rfun, N_FUN, addr);
  1006e0:	ff 75 08             	pushl  0x8(%ebp)
  1006e3:	6a 24                	push   $0x24
  1006e5:	8d 45 d8             	lea    -0x28(%ebp),%eax
  1006e8:	50                   	push   %eax
  1006e9:	8d 45 dc             	lea    -0x24(%ebp),%eax
  1006ec:	50                   	push   %eax
  1006ed:	ff 75 f4             	pushl  -0xc(%ebp)
  1006f0:	e8 c0 fd ff ff       	call   1004b5 <stab_binsearch>
  1006f5:	83 c4 14             	add    $0x14,%esp

    if (lfun <= rfun) {
  1006f8:	8b 55 dc             	mov    -0x24(%ebp),%edx
  1006fb:	8b 45 d8             	mov    -0x28(%ebp),%eax
  1006fe:	39 c2                	cmp    %eax,%edx
  100700:	7f 78                	jg     10077a <debuginfo_eip+0x16a>
        // stabs[lfun] points to the function name
        // in the string table, but check bounds just in case.
        if (stabs[lfun].n_strx < stabstr_end - stabstr) {
  100702:	8b 45 dc             	mov    -0x24(%ebp),%eax
  100705:	89 c2                	mov    %eax,%edx
  100707:	89 d0                	mov    %edx,%eax
  100709:	01 c0                	add    %eax,%eax
  10070b:	01 d0                	add    %edx,%eax
  10070d:	c1 e0 02             	shl    $0x2,%eax
  100710:	89 c2                	mov    %eax,%edx
  100712:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100715:	01 d0                	add    %edx,%eax
  100717:	8b 10                	mov    (%eax),%edx
  100719:	8b 45 e8             	mov    -0x18(%ebp),%eax
  10071c:	2b 45 ec             	sub    -0x14(%ebp),%eax
  10071f:	39 c2                	cmp    %eax,%edx
  100721:	73 22                	jae    100745 <debuginfo_eip+0x135>
            info->eip_fn_name = stabstr + stabs[lfun].n_strx;
  100723:	8b 45 dc             	mov    -0x24(%ebp),%eax
  100726:	89 c2                	mov    %eax,%edx
  100728:	89 d0                	mov    %edx,%eax
  10072a:	01 c0                	add    %eax,%eax
  10072c:	01 d0                	add    %edx,%eax
  10072e:	c1 e0 02             	shl    $0x2,%eax
  100731:	89 c2                	mov    %eax,%edx
  100733:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100736:	01 d0                	add    %edx,%eax
  100738:	8b 10                	mov    (%eax),%edx
  10073a:	8b 45 ec             	mov    -0x14(%ebp),%eax
  10073d:	01 c2                	add    %eax,%edx
  10073f:	8b 45 0c             	mov    0xc(%ebp),%eax
  100742:	89 50 08             	mov    %edx,0x8(%eax)
        }
        info->eip_fn_addr = stabs[lfun].n_value;
  100745:	8b 45 dc             	mov    -0x24(%ebp),%eax
  100748:	89 c2                	mov    %eax,%edx
  10074a:	89 d0                	mov    %edx,%eax
  10074c:	01 c0                	add    %eax,%eax
  10074e:	01 d0                	add    %edx,%eax
  100750:	c1 e0 02             	shl    $0x2,%eax
  100753:	89 c2                	mov    %eax,%edx
  100755:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100758:	01 d0                	add    %edx,%eax
  10075a:	8b 50 08             	mov    0x8(%eax),%edx
  10075d:	8b 45 0c             	mov    0xc(%ebp),%eax
  100760:	89 50 10             	mov    %edx,0x10(%eax)
        addr -= info->eip_fn_addr;
  100763:	8b 45 0c             	mov    0xc(%ebp),%eax
  100766:	8b 40 10             	mov    0x10(%eax),%eax
  100769:	29 45 08             	sub    %eax,0x8(%ebp)
        // Search within the function definition for the line number.
        lline = lfun;
  10076c:	8b 45 dc             	mov    -0x24(%ebp),%eax
  10076f:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        rline = rfun;
  100772:	8b 45 d8             	mov    -0x28(%ebp),%eax
  100775:	89 45 d0             	mov    %eax,-0x30(%ebp)
  100778:	eb 15                	jmp    10078f <debuginfo_eip+0x17f>
    } else {
        // Couldn't find function stab!  Maybe we're in an assembly
        // file.  Search the whole file for the line number.
        info->eip_fn_addr = addr;
  10077a:	8b 45 0c             	mov    0xc(%ebp),%eax
  10077d:	8b 55 08             	mov    0x8(%ebp),%edx
  100780:	89 50 10             	mov    %edx,0x10(%eax)
        lline = lfile;
  100783:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  100786:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        rline = rfile;
  100789:	8b 45 e0             	mov    -0x20(%ebp),%eax
  10078c:	89 45 d0             	mov    %eax,-0x30(%ebp)
    }
    info->eip_fn_namelen = strfind(info->eip_fn_name, ':') - info->eip_fn_name;
  10078f:	8b 45 0c             	mov    0xc(%ebp),%eax
  100792:	8b 40 08             	mov    0x8(%eax),%eax
  100795:	83 ec 08             	sub    $0x8,%esp
  100798:	6a 3a                	push   $0x3a
  10079a:	50                   	push   %eax
  10079b:	e8 bf 24 00 00       	call   102c5f <strfind>
  1007a0:	83 c4 10             	add    $0x10,%esp
  1007a3:	8b 55 0c             	mov    0xc(%ebp),%edx
  1007a6:	8b 52 08             	mov    0x8(%edx),%edx
  1007a9:	29 d0                	sub    %edx,%eax
  1007ab:	89 c2                	mov    %eax,%edx
  1007ad:	8b 45 0c             	mov    0xc(%ebp),%eax
  1007b0:	89 50 0c             	mov    %edx,0xc(%eax)

    // Search within [lline, rline] for the line number stab.
    // If found, set info->eip_line to the right line number.
    // If not found, return -1.
    stab_binsearch(stabs, &lline, &rline, N_SLINE, addr);
  1007b3:	83 ec 0c             	sub    $0xc,%esp
  1007b6:	ff 75 08             	pushl  0x8(%ebp)
  1007b9:	6a 44                	push   $0x44
  1007bb:	8d 45 d0             	lea    -0x30(%ebp),%eax
  1007be:	50                   	push   %eax
  1007bf:	8d 45 d4             	lea    -0x2c(%ebp),%eax
  1007c2:	50                   	push   %eax
  1007c3:	ff 75 f4             	pushl  -0xc(%ebp)
  1007c6:	e8 ea fc ff ff       	call   1004b5 <stab_binsearch>
  1007cb:	83 c4 20             	add    $0x20,%esp
    if (lline <= rline) {
  1007ce:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  1007d1:	8b 45 d0             	mov    -0x30(%ebp),%eax
  1007d4:	39 c2                	cmp    %eax,%edx
  1007d6:	7f 24                	jg     1007fc <debuginfo_eip+0x1ec>
        info->eip_line = stabs[rline].n_desc;
  1007d8:	8b 45 d0             	mov    -0x30(%ebp),%eax
  1007db:	89 c2                	mov    %eax,%edx
  1007dd:	89 d0                	mov    %edx,%eax
  1007df:	01 c0                	add    %eax,%eax
  1007e1:	01 d0                	add    %edx,%eax
  1007e3:	c1 e0 02             	shl    $0x2,%eax
  1007e6:	89 c2                	mov    %eax,%edx
  1007e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1007eb:	01 d0                	add    %edx,%eax
  1007ed:	0f b7 40 06          	movzwl 0x6(%eax),%eax
  1007f1:	0f b7 d0             	movzwl %ax,%edx
  1007f4:	8b 45 0c             	mov    0xc(%ebp),%eax
  1007f7:	89 50 04             	mov    %edx,0x4(%eax)

    // Search backwards from the line number for the relevant filename stab.
    // We can't just use the "lfile" stab because inlined functions
    // can interpolate code from a different file!
    // Such included source files use the N_SOL stab type.
    while (lline >= lfile
  1007fa:	eb 13                	jmp    10080f <debuginfo_eip+0x1ff>
        return -1;
  1007fc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  100801:	e9 0e 01 00 00       	jmp    100914 <debuginfo_eip+0x304>
           && stabs[lline].n_type != N_SOL
           && (stabs[lline].n_type != N_SO || !stabs[lline].n_value)) {
        lline --;
  100806:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100809:	83 e8 01             	sub    $0x1,%eax
  10080c:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    while (lline >= lfile
  10080f:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  100812:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  100815:	39 c2                	cmp    %eax,%edx
  100817:	7c 56                	jl     10086f <debuginfo_eip+0x25f>
           && stabs[lline].n_type != N_SOL
  100819:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  10081c:	89 c2                	mov    %eax,%edx
  10081e:	89 d0                	mov    %edx,%eax
  100820:	01 c0                	add    %eax,%eax
  100822:	01 d0                	add    %edx,%eax
  100824:	c1 e0 02             	shl    $0x2,%eax
  100827:	89 c2                	mov    %eax,%edx
  100829:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10082c:	01 d0                	add    %edx,%eax
  10082e:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  100832:	3c 84                	cmp    $0x84,%al
  100834:	74 39                	je     10086f <debuginfo_eip+0x25f>
           && (stabs[lline].n_type != N_SO || !stabs[lline].n_value)) {
  100836:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100839:	89 c2                	mov    %eax,%edx
  10083b:	89 d0                	mov    %edx,%eax
  10083d:	01 c0                	add    %eax,%eax
  10083f:	01 d0                	add    %edx,%eax
  100841:	c1 e0 02             	shl    $0x2,%eax
  100844:	89 c2                	mov    %eax,%edx
  100846:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100849:	01 d0                	add    %edx,%eax
  10084b:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  10084f:	3c 64                	cmp    $0x64,%al
  100851:	75 b3                	jne    100806 <debuginfo_eip+0x1f6>
  100853:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100856:	89 c2                	mov    %eax,%edx
  100858:	89 d0                	mov    %edx,%eax
  10085a:	01 c0                	add    %eax,%eax
  10085c:	01 d0                	add    %edx,%eax
  10085e:	c1 e0 02             	shl    $0x2,%eax
  100861:	89 c2                	mov    %eax,%edx
  100863:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100866:	01 d0                	add    %edx,%eax
  100868:	8b 40 08             	mov    0x8(%eax),%eax
  10086b:	85 c0                	test   %eax,%eax
  10086d:	74 97                	je     100806 <debuginfo_eip+0x1f6>
    }
    if (lline >= lfile && stabs[lline].n_strx < stabstr_end - stabstr) {
  10086f:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  100872:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  100875:	39 c2                	cmp    %eax,%edx
  100877:	7c 42                	jl     1008bb <debuginfo_eip+0x2ab>
  100879:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  10087c:	89 c2                	mov    %eax,%edx
  10087e:	89 d0                	mov    %edx,%eax
  100880:	01 c0                	add    %eax,%eax
  100882:	01 d0                	add    %edx,%eax
  100884:	c1 e0 02             	shl    $0x2,%eax
  100887:	89 c2                	mov    %eax,%edx
  100889:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10088c:	01 d0                	add    %edx,%eax
  10088e:	8b 10                	mov    (%eax),%edx
  100890:	8b 45 e8             	mov    -0x18(%ebp),%eax
  100893:	2b 45 ec             	sub    -0x14(%ebp),%eax
  100896:	39 c2                	cmp    %eax,%edx
  100898:	73 21                	jae    1008bb <debuginfo_eip+0x2ab>
        info->eip_file = stabstr + stabs[lline].n_strx;
  10089a:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  10089d:	89 c2                	mov    %eax,%edx
  10089f:	89 d0                	mov    %edx,%eax
  1008a1:	01 c0                	add    %eax,%eax
  1008a3:	01 d0                	add    %edx,%eax
  1008a5:	c1 e0 02             	shl    $0x2,%eax
  1008a8:	89 c2                	mov    %eax,%edx
  1008aa:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1008ad:	01 d0                	add    %edx,%eax
  1008af:	8b 10                	mov    (%eax),%edx
  1008b1:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1008b4:	01 c2                	add    %eax,%edx
  1008b6:	8b 45 0c             	mov    0xc(%ebp),%eax
  1008b9:	89 10                	mov    %edx,(%eax)
    }

    // Set eip_fn_narg to the number of arguments taken by the function,
    // or 0 if there was no containing function.
    if (lfun < rfun) {
  1008bb:	8b 55 dc             	mov    -0x24(%ebp),%edx
  1008be:	8b 45 d8             	mov    -0x28(%ebp),%eax
  1008c1:	39 c2                	cmp    %eax,%edx
  1008c3:	7d 4a                	jge    10090f <debuginfo_eip+0x2ff>
        for (lline = lfun + 1;
  1008c5:	8b 45 dc             	mov    -0x24(%ebp),%eax
  1008c8:	83 c0 01             	add    $0x1,%eax
  1008cb:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  1008ce:	eb 18                	jmp    1008e8 <debuginfo_eip+0x2d8>
             lline < rfun && stabs[lline].n_type == N_PSYM;
             lline ++) {
            info->eip_fn_narg ++;
  1008d0:	8b 45 0c             	mov    0xc(%ebp),%eax
  1008d3:	8b 40 14             	mov    0x14(%eax),%eax
  1008d6:	8d 50 01             	lea    0x1(%eax),%edx
  1008d9:	8b 45 0c             	mov    0xc(%ebp),%eax
  1008dc:	89 50 14             	mov    %edx,0x14(%eax)
             lline ++) {
  1008df:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  1008e2:	83 c0 01             	add    $0x1,%eax
  1008e5:	89 45 d4             	mov    %eax,-0x2c(%ebp)
             lline < rfun && stabs[lline].n_type == N_PSYM;
  1008e8:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  1008eb:	8b 45 d8             	mov    -0x28(%ebp),%eax
        for (lline = lfun + 1;
  1008ee:	39 c2                	cmp    %eax,%edx
  1008f0:	7d 1d                	jge    10090f <debuginfo_eip+0x2ff>
             lline < rfun && stabs[lline].n_type == N_PSYM;
  1008f2:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  1008f5:	89 c2                	mov    %eax,%edx
  1008f7:	89 d0                	mov    %edx,%eax
  1008f9:	01 c0                	add    %eax,%eax
  1008fb:	01 d0                	add    %edx,%eax
  1008fd:	c1 e0 02             	shl    $0x2,%eax
  100900:	89 c2                	mov    %eax,%edx
  100902:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100905:	01 d0                	add    %edx,%eax
  100907:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  10090b:	3c a0                	cmp    $0xa0,%al
  10090d:	74 c1                	je     1008d0 <debuginfo_eip+0x2c0>
        }
    }
    return 0;
  10090f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100914:	c9                   	leave  
  100915:	c3                   	ret    

00100916 <print_kerninfo>:
 * print_kerninfo - print the information about kernel, including the location
 * of kernel entry, the start addresses of data and text segements, the start
 * address of free memory and how many memory that kernel has used.
 * */
void
print_kerninfo(void) {
  100916:	f3 0f 1e fb          	endbr32 
  10091a:	55                   	push   %ebp
  10091b:	89 e5                	mov    %esp,%ebp
  10091d:	83 ec 08             	sub    $0x8,%esp
    extern char etext[], edata[], end[], kern_init[];
    cprintf("Special kernel symbols:\n");
  100920:	83 ec 0c             	sub    $0xc,%esp
  100923:	68 ca 36 10 00       	push   $0x1036ca
  100928:	e8 42 f9 ff ff       	call   10026f <cprintf>
  10092d:	83 c4 10             	add    $0x10,%esp
    cprintf("  entry  0x%08x (phys)\n", kern_init);
  100930:	83 ec 08             	sub    $0x8,%esp
  100933:	68 00 00 10 00       	push   $0x100000
  100938:	68 e3 36 10 00       	push   $0x1036e3
  10093d:	e8 2d f9 ff ff       	call   10026f <cprintf>
  100942:	83 c4 10             	add    $0x10,%esp
    cprintf("  etext  0x%08x (phys)\n", etext);
  100945:	83 ec 08             	sub    $0x8,%esp
  100948:	68 b4 35 10 00       	push   $0x1035b4
  10094d:	68 fb 36 10 00       	push   $0x1036fb
  100952:	e8 18 f9 ff ff       	call   10026f <cprintf>
  100957:	83 c4 10             	add    $0x10,%esp
    cprintf("  edata  0x%08x (phys)\n", edata);
  10095a:	83 ec 08             	sub    $0x8,%esp
  10095d:	68 16 fa 10 00       	push   $0x10fa16
  100962:	68 13 37 10 00       	push   $0x103713
  100967:	e8 03 f9 ff ff       	call   10026f <cprintf>
  10096c:	83 c4 10             	add    $0x10,%esp
    cprintf("  end    0x%08x (phys)\n", end);
  10096f:	83 ec 08             	sub    $0x8,%esp
  100972:	68 20 0d 11 00       	push   $0x110d20
  100977:	68 2b 37 10 00       	push   $0x10372b
  10097c:	e8 ee f8 ff ff       	call   10026f <cprintf>
  100981:	83 c4 10             	add    $0x10,%esp
    cprintf("Kernel executable memory footprint: %dKB\n", (end - kern_init + 1023)/1024);
  100984:	b8 20 0d 11 00       	mov    $0x110d20,%eax
  100989:	2d 00 00 10 00       	sub    $0x100000,%eax
  10098e:	05 ff 03 00 00       	add    $0x3ff,%eax
  100993:	8d 90 ff 03 00 00    	lea    0x3ff(%eax),%edx
  100999:	85 c0                	test   %eax,%eax
  10099b:	0f 48 c2             	cmovs  %edx,%eax
  10099e:	c1 f8 0a             	sar    $0xa,%eax
  1009a1:	83 ec 08             	sub    $0x8,%esp
  1009a4:	50                   	push   %eax
  1009a5:	68 44 37 10 00       	push   $0x103744
  1009aa:	e8 c0 f8 ff ff       	call   10026f <cprintf>
  1009af:	83 c4 10             	add    $0x10,%esp
}
  1009b2:	90                   	nop
  1009b3:	c9                   	leave  
  1009b4:	c3                   	ret    

001009b5 <print_debuginfo>:
/* *
 * print_debuginfo - read and print the stat information for the address @eip,
 * and info.eip_fn_addr should be the first address of the related function.
 * */
void
print_debuginfo(uintptr_t eip) {
  1009b5:	f3 0f 1e fb          	endbr32 
  1009b9:	55                   	push   %ebp
  1009ba:	89 e5                	mov    %esp,%ebp
  1009bc:	81 ec 28 01 00 00    	sub    $0x128,%esp
    struct eipdebuginfo info;
    if (debuginfo_eip(eip, &info) != 0) {
  1009c2:	83 ec 08             	sub    $0x8,%esp
  1009c5:	8d 45 dc             	lea    -0x24(%ebp),%eax
  1009c8:	50                   	push   %eax
  1009c9:	ff 75 08             	pushl  0x8(%ebp)
  1009cc:	e8 3f fc ff ff       	call   100610 <debuginfo_eip>
  1009d1:	83 c4 10             	add    $0x10,%esp
  1009d4:	85 c0                	test   %eax,%eax
  1009d6:	74 15                	je     1009ed <print_debuginfo+0x38>
        cprintf("    <unknow>: -- 0x%08x --\n", eip);
  1009d8:	83 ec 08             	sub    $0x8,%esp
  1009db:	ff 75 08             	pushl  0x8(%ebp)
  1009de:	68 6e 37 10 00       	push   $0x10376e
  1009e3:	e8 87 f8 ff ff       	call   10026f <cprintf>
  1009e8:	83 c4 10             	add    $0x10,%esp
        }
        fnname[j] = '\0';
        cprintf("    %s:%d: %s+%d\n", info.eip_file, info.eip_line,
                fnname, eip - info.eip_fn_addr);
    }
}
  1009eb:	eb 65                	jmp    100a52 <print_debuginfo+0x9d>
        for (j = 0; j < info.eip_fn_namelen; j ++) {
  1009ed:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  1009f4:	eb 1c                	jmp    100a12 <print_debuginfo+0x5d>
            fnname[j] = info.eip_fn_name[j];
  1009f6:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  1009f9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1009fc:	01 d0                	add    %edx,%eax
  1009fe:	0f b6 00             	movzbl (%eax),%eax
  100a01:	8d 8d dc fe ff ff    	lea    -0x124(%ebp),%ecx
  100a07:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100a0a:	01 ca                	add    %ecx,%edx
  100a0c:	88 02                	mov    %al,(%edx)
        for (j = 0; j < info.eip_fn_namelen; j ++) {
  100a0e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  100a12:	8b 45 e8             	mov    -0x18(%ebp),%eax
  100a15:	39 45 f4             	cmp    %eax,-0xc(%ebp)
  100a18:	7c dc                	jl     1009f6 <print_debuginfo+0x41>
        fnname[j] = '\0';
  100a1a:	8d 95 dc fe ff ff    	lea    -0x124(%ebp),%edx
  100a20:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100a23:	01 d0                	add    %edx,%eax
  100a25:	c6 00 00             	movb   $0x0,(%eax)
                fnname, eip - info.eip_fn_addr);
  100a28:	8b 45 ec             	mov    -0x14(%ebp),%eax
        cprintf("    %s:%d: %s+%d\n", info.eip_file, info.eip_line,
  100a2b:	8b 55 08             	mov    0x8(%ebp),%edx
  100a2e:	89 d1                	mov    %edx,%ecx
  100a30:	29 c1                	sub    %eax,%ecx
  100a32:	8b 55 e0             	mov    -0x20(%ebp),%edx
  100a35:	8b 45 dc             	mov    -0x24(%ebp),%eax
  100a38:	83 ec 0c             	sub    $0xc,%esp
  100a3b:	51                   	push   %ecx
  100a3c:	8d 8d dc fe ff ff    	lea    -0x124(%ebp),%ecx
  100a42:	51                   	push   %ecx
  100a43:	52                   	push   %edx
  100a44:	50                   	push   %eax
  100a45:	68 8a 37 10 00       	push   $0x10378a
  100a4a:	e8 20 f8 ff ff       	call   10026f <cprintf>
  100a4f:	83 c4 20             	add    $0x20,%esp
}
  100a52:	90                   	nop
  100a53:	c9                   	leave  
  100a54:	c3                   	ret    

00100a55 <read_eip>:

static __noinline uint32_t
read_eip(void) {
  100a55:	f3 0f 1e fb          	endbr32 
  100a59:	55                   	push   %ebp
  100a5a:	89 e5                	mov    %esp,%ebp
  100a5c:	83 ec 10             	sub    $0x10,%esp
    uint32_t eip;
    asm volatile("movl 4(%%ebp), %0" : "=r" (eip));
  100a5f:	8b 45 04             	mov    0x4(%ebp),%eax
  100a62:	89 45 fc             	mov    %eax,-0x4(%ebp)
    return eip;
  100a65:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  100a68:	c9                   	leave  
  100a69:	c3                   	ret    

00100a6a <print_stackframe>:
 *
 * Note that, the length of ebp-chain is limited. In boot/bootasm.S, before jumping
 * to the kernel entry, the value of ebp has been set to zero, that's the boundary.
 * */
void
print_stackframe(void) {
  100a6a:	f3 0f 1e fb          	endbr32 
  100a6e:	55                   	push   %ebp
  100a6f:	89 e5                	mov    %esp,%ebp
  100a71:	83 ec 28             	sub    $0x28,%esp
}

static inline uint32_t
read_ebp(void) {
    uint32_t ebp;
    asm volatile ("movl %%ebp, %0" : "=r" (ebp));
  100a74:	89 e8                	mov    %ebp,%eax
  100a76:	89 45 e0             	mov    %eax,-0x20(%ebp)
    return ebp;
  100a79:	8b 45 e0             	mov    -0x20(%ebp),%eax
      *    (3.4) call print_debuginfo(eip-1) to print the C calling function name and line number, etc.
      *    (3.5) popup a calling stackframe
      *           NOTICE: the calling funciton's return addr eip  = ss:[ebp+4]
      *                   the calling funciton's ebp = ss:[ebp]
      */
	uint32_t ebp = read_ebp();
  100a7c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	uint32_t eip = read_eip();
  100a7f:	e8 d1 ff ff ff       	call   100a55 <read_eip>
  100a84:	89 45 f0             	mov    %eax,-0x10(%ebp)
	for (int i = 0; i < STACKFRAME_DEPTH && ebp != 0; i++)
  100a87:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  100a8e:	e9 ad 00 00 00       	jmp    100b40 <print_stackframe+0xd6>
	{
		cprintf("ebp is 0x%08x ", ebp);
  100a93:	83 ec 08             	sub    $0x8,%esp
  100a96:	ff 75 f4             	pushl  -0xc(%ebp)
  100a99:	68 9c 37 10 00       	push   $0x10379c
  100a9e:	e8 cc f7 ff ff       	call   10026f <cprintf>
  100aa3:	83 c4 10             	add    $0x10,%esp
		cprintf("eip is 0x%08x ", eip);
  100aa6:	83 ec 08             	sub    $0x8,%esp
  100aa9:	ff 75 f0             	pushl  -0x10(%ebp)
  100aac:	68 ab 37 10 00       	push   $0x1037ab
  100ab1:	e8 b9 f7 ff ff       	call   10026f <cprintf>
  100ab6:	83 c4 10             	add    $0x10,%esp
		uint32_t* args = (uint32_t*) ebp + 2;
  100ab9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100abc:	83 c0 08             	add    $0x8,%eax
  100abf:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		cprintf("args is ");
  100ac2:	83 ec 0c             	sub    $0xc,%esp
  100ac5:	68 ba 37 10 00       	push   $0x1037ba
  100aca:	e8 a0 f7 ff ff       	call   10026f <cprintf>
  100acf:	83 c4 10             	add    $0x10,%esp
		for(int j = 0; j < 4; j++)
  100ad2:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  100ad9:	eb 26                	jmp    100b01 <print_stackframe+0x97>
		{
			cprintf("0x%08x ", args[j]);
  100adb:	8b 45 e8             	mov    -0x18(%ebp),%eax
  100ade:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  100ae5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  100ae8:	01 d0                	add    %edx,%eax
  100aea:	8b 00                	mov    (%eax),%eax
  100aec:	83 ec 08             	sub    $0x8,%esp
  100aef:	50                   	push   %eax
  100af0:	68 c3 37 10 00       	push   $0x1037c3
  100af5:	e8 75 f7 ff ff       	call   10026f <cprintf>
  100afa:	83 c4 10             	add    $0x10,%esp
		for(int j = 0; j < 4; j++)
  100afd:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
  100b01:	83 7d e8 03          	cmpl   $0x3,-0x18(%ebp)
  100b05:	7e d4                	jle    100adb <print_stackframe+0x71>
		}
		cprintf("\n");
  100b07:	83 ec 0c             	sub    $0xc,%esp
  100b0a:	68 cb 37 10 00       	push   $0x1037cb
  100b0f:	e8 5b f7 ff ff       	call   10026f <cprintf>
  100b14:	83 c4 10             	add    $0x10,%esp
		print_debuginfo(eip-1);
  100b17:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100b1a:	83 e8 01             	sub    $0x1,%eax
  100b1d:	83 ec 0c             	sub    $0xc,%esp
  100b20:	50                   	push   %eax
  100b21:	e8 8f fe ff ff       	call   1009b5 <print_debuginfo>
  100b26:	83 c4 10             	add    $0x10,%esp
		eip = ((uint32_t*) ebp) [1];
  100b29:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100b2c:	83 c0 04             	add    $0x4,%eax
  100b2f:	8b 00                	mov    (%eax),%eax
  100b31:	89 45 f0             	mov    %eax,-0x10(%ebp)
		ebp = ((uint32_t*) ebp) [0];
  100b34:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100b37:	8b 00                	mov    (%eax),%eax
  100b39:	89 45 f4             	mov    %eax,-0xc(%ebp)
	for (int i = 0; i < STACKFRAME_DEPTH && ebp != 0; i++)
  100b3c:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
  100b40:	83 7d ec 13          	cmpl   $0x13,-0x14(%ebp)
  100b44:	7f 0a                	jg     100b50 <print_stackframe+0xe6>
  100b46:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  100b4a:	0f 85 43 ff ff ff    	jne    100a93 <print_stackframe+0x29>

	}
}
  100b50:	90                   	nop
  100b51:	c9                   	leave  
  100b52:	c3                   	ret    

00100b53 <parse>:
#define MAXARGS         16
#define WHITESPACE      " \t\n\r"

/* parse - parse the command buffer into whitespace-separated arguments */
static int
parse(char *buf, char **argv) {
  100b53:	f3 0f 1e fb          	endbr32 
  100b57:	55                   	push   %ebp
  100b58:	89 e5                	mov    %esp,%ebp
  100b5a:	83 ec 18             	sub    $0x18,%esp
    int argc = 0;
  100b5d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while (1) {
        // find global whitespace
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
  100b64:	eb 0c                	jmp    100b72 <parse+0x1f>
            *buf ++ = '\0';
  100b66:	8b 45 08             	mov    0x8(%ebp),%eax
  100b69:	8d 50 01             	lea    0x1(%eax),%edx
  100b6c:	89 55 08             	mov    %edx,0x8(%ebp)
  100b6f:	c6 00 00             	movb   $0x0,(%eax)
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
  100b72:	8b 45 08             	mov    0x8(%ebp),%eax
  100b75:	0f b6 00             	movzbl (%eax),%eax
  100b78:	84 c0                	test   %al,%al
  100b7a:	74 1e                	je     100b9a <parse+0x47>
  100b7c:	8b 45 08             	mov    0x8(%ebp),%eax
  100b7f:	0f b6 00             	movzbl (%eax),%eax
  100b82:	0f be c0             	movsbl %al,%eax
  100b85:	83 ec 08             	sub    $0x8,%esp
  100b88:	50                   	push   %eax
  100b89:	68 50 38 10 00       	push   $0x103850
  100b8e:	e8 95 20 00 00       	call   102c28 <strchr>
  100b93:	83 c4 10             	add    $0x10,%esp
  100b96:	85 c0                	test   %eax,%eax
  100b98:	75 cc                	jne    100b66 <parse+0x13>
        }
        if (*buf == '\0') {
  100b9a:	8b 45 08             	mov    0x8(%ebp),%eax
  100b9d:	0f b6 00             	movzbl (%eax),%eax
  100ba0:	84 c0                	test   %al,%al
  100ba2:	74 65                	je     100c09 <parse+0xb6>
            break;
        }

        // save and scan past next arg
        if (argc == MAXARGS - 1) {
  100ba4:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
  100ba8:	75 12                	jne    100bbc <parse+0x69>
            cprintf("Too many arguments (max %d).\n", MAXARGS);
  100baa:	83 ec 08             	sub    $0x8,%esp
  100bad:	6a 10                	push   $0x10
  100baf:	68 55 38 10 00       	push   $0x103855
  100bb4:	e8 b6 f6 ff ff       	call   10026f <cprintf>
  100bb9:	83 c4 10             	add    $0x10,%esp
        }
        argv[argc ++] = buf;
  100bbc:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100bbf:	8d 50 01             	lea    0x1(%eax),%edx
  100bc2:	89 55 f4             	mov    %edx,-0xc(%ebp)
  100bc5:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  100bcc:	8b 45 0c             	mov    0xc(%ebp),%eax
  100bcf:	01 c2                	add    %eax,%edx
  100bd1:	8b 45 08             	mov    0x8(%ebp),%eax
  100bd4:	89 02                	mov    %eax,(%edx)
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
  100bd6:	eb 04                	jmp    100bdc <parse+0x89>
            buf ++;
  100bd8:	83 45 08 01          	addl   $0x1,0x8(%ebp)
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
  100bdc:	8b 45 08             	mov    0x8(%ebp),%eax
  100bdf:	0f b6 00             	movzbl (%eax),%eax
  100be2:	84 c0                	test   %al,%al
  100be4:	74 8c                	je     100b72 <parse+0x1f>
  100be6:	8b 45 08             	mov    0x8(%ebp),%eax
  100be9:	0f b6 00             	movzbl (%eax),%eax
  100bec:	0f be c0             	movsbl %al,%eax
  100bef:	83 ec 08             	sub    $0x8,%esp
  100bf2:	50                   	push   %eax
  100bf3:	68 50 38 10 00       	push   $0x103850
  100bf8:	e8 2b 20 00 00       	call   102c28 <strchr>
  100bfd:	83 c4 10             	add    $0x10,%esp
  100c00:	85 c0                	test   %eax,%eax
  100c02:	74 d4                	je     100bd8 <parse+0x85>
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
  100c04:	e9 69 ff ff ff       	jmp    100b72 <parse+0x1f>
            break;
  100c09:	90                   	nop
        }
    }
    return argc;
  100c0a:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  100c0d:	c9                   	leave  
  100c0e:	c3                   	ret    

00100c0f <runcmd>:
/* *
 * runcmd - parse the input string, split it into separated arguments
 * and then lookup and invoke some related commands/
 * */
static int
runcmd(char *buf, struct trapframe *tf) {
  100c0f:	f3 0f 1e fb          	endbr32 
  100c13:	55                   	push   %ebp
  100c14:	89 e5                	mov    %esp,%ebp
  100c16:	83 ec 58             	sub    $0x58,%esp
    char *argv[MAXARGS];
    int argc = parse(buf, argv);
  100c19:	83 ec 08             	sub    $0x8,%esp
  100c1c:	8d 45 b0             	lea    -0x50(%ebp),%eax
  100c1f:	50                   	push   %eax
  100c20:	ff 75 08             	pushl  0x8(%ebp)
  100c23:	e8 2b ff ff ff       	call   100b53 <parse>
  100c28:	83 c4 10             	add    $0x10,%esp
  100c2b:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if (argc == 0) {
  100c2e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  100c32:	75 0a                	jne    100c3e <runcmd+0x2f>
        return 0;
  100c34:	b8 00 00 00 00       	mov    $0x0,%eax
  100c39:	e9 83 00 00 00       	jmp    100cc1 <runcmd+0xb2>
    }
    int i;
    for (i = 0; i < NCOMMANDS; i ++) {
  100c3e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  100c45:	eb 59                	jmp    100ca0 <runcmd+0x91>
        if (strcmp(commands[i].name, argv[0]) == 0) {
  100c47:	8b 4d b0             	mov    -0x50(%ebp),%ecx
  100c4a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100c4d:	89 d0                	mov    %edx,%eax
  100c4f:	01 c0                	add    %eax,%eax
  100c51:	01 d0                	add    %edx,%eax
  100c53:	c1 e0 02             	shl    $0x2,%eax
  100c56:	05 00 f0 10 00       	add    $0x10f000,%eax
  100c5b:	8b 00                	mov    (%eax),%eax
  100c5d:	83 ec 08             	sub    $0x8,%esp
  100c60:	51                   	push   %ecx
  100c61:	50                   	push   %eax
  100c62:	e8 1a 1f 00 00       	call   102b81 <strcmp>
  100c67:	83 c4 10             	add    $0x10,%esp
  100c6a:	85 c0                	test   %eax,%eax
  100c6c:	75 2e                	jne    100c9c <runcmd+0x8d>
            return commands[i].func(argc - 1, argv + 1, tf);
  100c6e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100c71:	89 d0                	mov    %edx,%eax
  100c73:	01 c0                	add    %eax,%eax
  100c75:	01 d0                	add    %edx,%eax
  100c77:	c1 e0 02             	shl    $0x2,%eax
  100c7a:	05 08 f0 10 00       	add    $0x10f008,%eax
  100c7f:	8b 10                	mov    (%eax),%edx
  100c81:	8d 45 b0             	lea    -0x50(%ebp),%eax
  100c84:	83 c0 04             	add    $0x4,%eax
  100c87:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  100c8a:	83 e9 01             	sub    $0x1,%ecx
  100c8d:	83 ec 04             	sub    $0x4,%esp
  100c90:	ff 75 0c             	pushl  0xc(%ebp)
  100c93:	50                   	push   %eax
  100c94:	51                   	push   %ecx
  100c95:	ff d2                	call   *%edx
  100c97:	83 c4 10             	add    $0x10,%esp
  100c9a:	eb 25                	jmp    100cc1 <runcmd+0xb2>
    for (i = 0; i < NCOMMANDS; i ++) {
  100c9c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  100ca0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100ca3:	83 f8 02             	cmp    $0x2,%eax
  100ca6:	76 9f                	jbe    100c47 <runcmd+0x38>
        }
    }
    cprintf("Unknown command '%s'\n", argv[0]);
  100ca8:	8b 45 b0             	mov    -0x50(%ebp),%eax
  100cab:	83 ec 08             	sub    $0x8,%esp
  100cae:	50                   	push   %eax
  100caf:	68 73 38 10 00       	push   $0x103873
  100cb4:	e8 b6 f5 ff ff       	call   10026f <cprintf>
  100cb9:	83 c4 10             	add    $0x10,%esp
    return 0;
  100cbc:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100cc1:	c9                   	leave  
  100cc2:	c3                   	ret    

00100cc3 <kmonitor>:

/***** Implementations of basic kernel monitor commands *****/

void
kmonitor(struct trapframe *tf) {
  100cc3:	f3 0f 1e fb          	endbr32 
  100cc7:	55                   	push   %ebp
  100cc8:	89 e5                	mov    %esp,%ebp
  100cca:	83 ec 18             	sub    $0x18,%esp
    cprintf("Welcome to the kernel debug monitor!!\n");
  100ccd:	83 ec 0c             	sub    $0xc,%esp
  100cd0:	68 8c 38 10 00       	push   $0x10388c
  100cd5:	e8 95 f5 ff ff       	call   10026f <cprintf>
  100cda:	83 c4 10             	add    $0x10,%esp
    cprintf("Type 'help' for a list of commands.\n");
  100cdd:	83 ec 0c             	sub    $0xc,%esp
  100ce0:	68 b4 38 10 00       	push   $0x1038b4
  100ce5:	e8 85 f5 ff ff       	call   10026f <cprintf>
  100cea:	83 c4 10             	add    $0x10,%esp

    if (tf != NULL) {
  100ced:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  100cf1:	74 0e                	je     100d01 <kmonitor+0x3e>
        print_trapframe(tf);
  100cf3:	83 ec 0c             	sub    $0xc,%esp
  100cf6:	ff 75 08             	pushl  0x8(%ebp)
  100cf9:	e8 e1 0d 00 00       	call   101adf <print_trapframe>
  100cfe:	83 c4 10             	add    $0x10,%esp
    }

    char *buf;
    while (1) {
        if ((buf = readline("K> ")) != NULL) {
  100d01:	83 ec 0c             	sub    $0xc,%esp
  100d04:	68 d9 38 10 00       	push   $0x1038d9
  100d09:	e8 16 f6 ff ff       	call   100324 <readline>
  100d0e:	83 c4 10             	add    $0x10,%esp
  100d11:	89 45 f4             	mov    %eax,-0xc(%ebp)
  100d14:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  100d18:	74 e7                	je     100d01 <kmonitor+0x3e>
            if (runcmd(buf, tf) < 0) {
  100d1a:	83 ec 08             	sub    $0x8,%esp
  100d1d:	ff 75 08             	pushl  0x8(%ebp)
  100d20:	ff 75 f4             	pushl  -0xc(%ebp)
  100d23:	e8 e7 fe ff ff       	call   100c0f <runcmd>
  100d28:	83 c4 10             	add    $0x10,%esp
  100d2b:	85 c0                	test   %eax,%eax
  100d2d:	78 02                	js     100d31 <kmonitor+0x6e>
        if ((buf = readline("K> ")) != NULL) {
  100d2f:	eb d0                	jmp    100d01 <kmonitor+0x3e>
                break;
  100d31:	90                   	nop
            }
        }
    }
}
  100d32:	90                   	nop
  100d33:	c9                   	leave  
  100d34:	c3                   	ret    

00100d35 <mon_help>:

/* mon_help - print the information about mon_* functions */
int
mon_help(int argc, char **argv, struct trapframe *tf) {
  100d35:	f3 0f 1e fb          	endbr32 
  100d39:	55                   	push   %ebp
  100d3a:	89 e5                	mov    %esp,%ebp
  100d3c:	83 ec 18             	sub    $0x18,%esp
    int i;
    for (i = 0; i < NCOMMANDS; i ++) {
  100d3f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  100d46:	eb 3c                	jmp    100d84 <mon_help+0x4f>
        cprintf("%s - %s\n", commands[i].name, commands[i].desc);
  100d48:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100d4b:	89 d0                	mov    %edx,%eax
  100d4d:	01 c0                	add    %eax,%eax
  100d4f:	01 d0                	add    %edx,%eax
  100d51:	c1 e0 02             	shl    $0x2,%eax
  100d54:	05 04 f0 10 00       	add    $0x10f004,%eax
  100d59:	8b 08                	mov    (%eax),%ecx
  100d5b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100d5e:	89 d0                	mov    %edx,%eax
  100d60:	01 c0                	add    %eax,%eax
  100d62:	01 d0                	add    %edx,%eax
  100d64:	c1 e0 02             	shl    $0x2,%eax
  100d67:	05 00 f0 10 00       	add    $0x10f000,%eax
  100d6c:	8b 00                	mov    (%eax),%eax
  100d6e:	83 ec 04             	sub    $0x4,%esp
  100d71:	51                   	push   %ecx
  100d72:	50                   	push   %eax
  100d73:	68 dd 38 10 00       	push   $0x1038dd
  100d78:	e8 f2 f4 ff ff       	call   10026f <cprintf>
  100d7d:	83 c4 10             	add    $0x10,%esp
    for (i = 0; i < NCOMMANDS; i ++) {
  100d80:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  100d84:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100d87:	83 f8 02             	cmp    $0x2,%eax
  100d8a:	76 bc                	jbe    100d48 <mon_help+0x13>
    }
    return 0;
  100d8c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100d91:	c9                   	leave  
  100d92:	c3                   	ret    

00100d93 <mon_kerninfo>:
/* *
 * mon_kerninfo - call print_kerninfo in kern/debug/kdebug.c to
 * print the memory occupancy in kernel.
 * */
int
mon_kerninfo(int argc, char **argv, struct trapframe *tf) {
  100d93:	f3 0f 1e fb          	endbr32 
  100d97:	55                   	push   %ebp
  100d98:	89 e5                	mov    %esp,%ebp
  100d9a:	83 ec 08             	sub    $0x8,%esp
    print_kerninfo();
  100d9d:	e8 74 fb ff ff       	call   100916 <print_kerninfo>
    return 0;
  100da2:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100da7:	c9                   	leave  
  100da8:	c3                   	ret    

00100da9 <mon_backtrace>:
/* *
 * mon_backtrace - call print_stackframe in kern/debug/kdebug.c to
 * print a backtrace of the stack.
 * */
int
mon_backtrace(int argc, char **argv, struct trapframe *tf) {
  100da9:	f3 0f 1e fb          	endbr32 
  100dad:	55                   	push   %ebp
  100dae:	89 e5                	mov    %esp,%ebp
  100db0:	83 ec 08             	sub    $0x8,%esp
    print_stackframe();
  100db3:	e8 b2 fc ff ff       	call   100a6a <print_stackframe>
    return 0;
  100db8:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100dbd:	c9                   	leave  
  100dbe:	c3                   	ret    

00100dbf <clock_init>:
/* *
 * clock_init - initialize 8253 clock to interrupt 100 times per second,
 * and then enable IRQ_TIMER.
 * */
void
clock_init(void) {
  100dbf:	f3 0f 1e fb          	endbr32 
  100dc3:	55                   	push   %ebp
  100dc4:	89 e5                	mov    %esp,%ebp
  100dc6:	83 ec 18             	sub    $0x18,%esp
  100dc9:	66 c7 45 ee 43 00    	movw   $0x43,-0x12(%ebp)
  100dcf:	c6 45 ed 34          	movb   $0x34,-0x13(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100dd3:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  100dd7:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  100ddb:	ee                   	out    %al,(%dx)
}
  100ddc:	90                   	nop
  100ddd:	66 c7 45 f2 40 00    	movw   $0x40,-0xe(%ebp)
  100de3:	c6 45 f1 9c          	movb   $0x9c,-0xf(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100de7:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  100deb:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  100def:	ee                   	out    %al,(%dx)
}
  100df0:	90                   	nop
  100df1:	66 c7 45 f6 40 00    	movw   $0x40,-0xa(%ebp)
  100df7:	c6 45 f5 2e          	movb   $0x2e,-0xb(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100dfb:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  100dff:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  100e03:	ee                   	out    %al,(%dx)
}
  100e04:	90                   	nop
    outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
    outb(IO_TIMER1, TIMER_DIV(100) % 256);
    outb(IO_TIMER1, TIMER_DIV(100) / 256);

    // initialize time counter 'ticks' to zero
    ticks = 0;
  100e05:	c7 05 08 09 11 00 00 	movl   $0x0,0x110908
  100e0c:	00 00 00 

    cprintf("++ setup timer interrupts\n");
  100e0f:	83 ec 0c             	sub    $0xc,%esp
  100e12:	68 e6 38 10 00       	push   $0x1038e6
  100e17:	e8 53 f4 ff ff       	call   10026f <cprintf>
  100e1c:	83 c4 10             	add    $0x10,%esp
    pic_enable(IRQ_TIMER);
  100e1f:	83 ec 0c             	sub    $0xc,%esp
  100e22:	6a 00                	push   $0x0
  100e24:	e8 39 09 00 00       	call   101762 <pic_enable>
  100e29:	83 c4 10             	add    $0x10,%esp
}
  100e2c:	90                   	nop
  100e2d:	c9                   	leave  
  100e2e:	c3                   	ret    

00100e2f <delay>:
#include <picirq.h>
#include <trap.h>

/* stupid I/O delay routine necessitated by historical PC design flaws */
static void
delay(void) {
  100e2f:	f3 0f 1e fb          	endbr32 
  100e33:	55                   	push   %ebp
  100e34:	89 e5                	mov    %esp,%ebp
  100e36:	83 ec 10             	sub    $0x10,%esp
  100e39:	66 c7 45 f2 84 00    	movw   $0x84,-0xe(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  100e3f:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
  100e43:	89 c2                	mov    %eax,%edx
  100e45:	ec                   	in     (%dx),%al
  100e46:	88 45 f1             	mov    %al,-0xf(%ebp)
  100e49:	66 c7 45 f6 84 00    	movw   $0x84,-0xa(%ebp)
  100e4f:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  100e53:	89 c2                	mov    %eax,%edx
  100e55:	ec                   	in     (%dx),%al
  100e56:	88 45 f5             	mov    %al,-0xb(%ebp)
  100e59:	66 c7 45 fa 84 00    	movw   $0x84,-0x6(%ebp)
  100e5f:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
  100e63:	89 c2                	mov    %eax,%edx
  100e65:	ec                   	in     (%dx),%al
  100e66:	88 45 f9             	mov    %al,-0x7(%ebp)
  100e69:	66 c7 45 fe 84 00    	movw   $0x84,-0x2(%ebp)
  100e6f:	0f b7 45 fe          	movzwl -0x2(%ebp),%eax
  100e73:	89 c2                	mov    %eax,%edx
  100e75:	ec                   	in     (%dx),%al
  100e76:	88 45 fd             	mov    %al,-0x3(%ebp)
    inb(0x84);
    inb(0x84);
    inb(0x84);
    inb(0x84);
}
  100e79:	90                   	nop
  100e7a:	c9                   	leave  
  100e7b:	c3                   	ret    

00100e7c <cga_init>:
//    -- 数据寄存器 映射 到 端口 0x3D5或0x3B5 
//    -- 索引寄存器 0x3D4或0x3B4,决定在数据寄存器中的数据表示什么。

/* TEXT-mode CGA/VGA display output */
static void
cga_init(void) {
  100e7c:	f3 0f 1e fb          	endbr32 
  100e80:	55                   	push   %ebp
  100e81:	89 e5                	mov    %esp,%ebp
  100e83:	83 ec 20             	sub    $0x20,%esp
    volatile uint16_t *cp = (uint16_t *)CGA_BUF;   //CGA_BUF: 0xB8000 (彩色显示的显存物理基址)
  100e86:	c7 45 fc 00 80 0b 00 	movl   $0xb8000,-0x4(%ebp)
    uint16_t was = *cp;                                            //保存当前显存0xB8000处的值
  100e8d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100e90:	0f b7 00             	movzwl (%eax),%eax
  100e93:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
    *cp = (uint16_t) 0xA55A;                                   // 给这个地址随便写个值，看看能否再读出同样的值
  100e97:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100e9a:	66 c7 00 5a a5       	movw   $0xa55a,(%eax)
    if (*cp != 0xA55A) {                                            // 如果读不出来，说明没有这块显存，即是单显配置
  100e9f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100ea2:	0f b7 00             	movzwl (%eax),%eax
  100ea5:	66 3d 5a a5          	cmp    $0xa55a,%ax
  100ea9:	74 12                	je     100ebd <cga_init+0x41>
        cp = (uint16_t*)MONO_BUF;                         //设置为单显的显存基址 MONO_BUF： 0xB0000
  100eab:	c7 45 fc 00 00 0b 00 	movl   $0xb0000,-0x4(%ebp)
        addr_6845 = MONO_BASE;                           //设置为单显控制的IO地址，MONO_BASE: 0x3B4
  100eb2:	66 c7 05 66 fe 10 00 	movw   $0x3b4,0x10fe66
  100eb9:	b4 03 
  100ebb:	eb 13                	jmp    100ed0 <cga_init+0x54>
    } else {                                                                // 如果读出来了，有这块显存，即是彩显配置
        *cp = was;                                                      //还原原来显存位置的值
  100ebd:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100ec0:	0f b7 55 fa          	movzwl -0x6(%ebp),%edx
  100ec4:	66 89 10             	mov    %dx,(%eax)
        addr_6845 = CGA_BASE;                               // 设置为彩显控制的IO地址，CGA_BASE: 0x3D4 
  100ec7:	66 c7 05 66 fe 10 00 	movw   $0x3d4,0x10fe66
  100ece:	d4 03 
    // Extract cursor location
    // 6845索引寄存器的index 0x0E（及十进制的14）== 光标位置(高位)
    // 6845索引寄存器的index 0x0F（及十进制的15）== 光标位置(低位)
    // 6845 reg 15 : Cursor Address (Low Byte)
    uint32_t pos;
    outb(addr_6845, 14);                                        
  100ed0:	0f b7 05 66 fe 10 00 	movzwl 0x10fe66,%eax
  100ed7:	0f b7 c0             	movzwl %ax,%eax
  100eda:	66 89 45 e6          	mov    %ax,-0x1a(%ebp)
  100ede:	c6 45 e5 0e          	movb   $0xe,-0x1b(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100ee2:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
  100ee6:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
  100eea:	ee                   	out    %al,(%dx)
}
  100eeb:	90                   	nop
    pos = inb(addr_6845 + 1) << 8;                       //读出了光标位置(高位)
  100eec:	0f b7 05 66 fe 10 00 	movzwl 0x10fe66,%eax
  100ef3:	83 c0 01             	add    $0x1,%eax
  100ef6:	0f b7 c0             	movzwl %ax,%eax
  100ef9:	66 89 45 ea          	mov    %ax,-0x16(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  100efd:	0f b7 45 ea          	movzwl -0x16(%ebp),%eax
  100f01:	89 c2                	mov    %eax,%edx
  100f03:	ec                   	in     (%dx),%al
  100f04:	88 45 e9             	mov    %al,-0x17(%ebp)
    return data;
  100f07:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
  100f0b:	0f b6 c0             	movzbl %al,%eax
  100f0e:	c1 e0 08             	shl    $0x8,%eax
  100f11:	89 45 f4             	mov    %eax,-0xc(%ebp)
    outb(addr_6845, 15);
  100f14:	0f b7 05 66 fe 10 00 	movzwl 0x10fe66,%eax
  100f1b:	0f b7 c0             	movzwl %ax,%eax
  100f1e:	66 89 45 ee          	mov    %ax,-0x12(%ebp)
  100f22:	c6 45 ed 0f          	movb   $0xf,-0x13(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100f26:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  100f2a:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  100f2e:	ee                   	out    %al,(%dx)
}
  100f2f:	90                   	nop
    pos |= inb(addr_6845 + 1);                             //读出了光标位置(低位)
  100f30:	0f b7 05 66 fe 10 00 	movzwl 0x10fe66,%eax
  100f37:	83 c0 01             	add    $0x1,%eax
  100f3a:	0f b7 c0             	movzwl %ax,%eax
  100f3d:	66 89 45 f2          	mov    %ax,-0xe(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  100f41:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
  100f45:	89 c2                	mov    %eax,%edx
  100f47:	ec                   	in     (%dx),%al
  100f48:	88 45 f1             	mov    %al,-0xf(%ebp)
    return data;
  100f4b:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  100f4f:	0f b6 c0             	movzbl %al,%eax
  100f52:	09 45 f4             	or     %eax,-0xc(%ebp)

    crt_buf = (uint16_t*) cp;                                  //crt_buf是CGA显存起始地址
  100f55:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100f58:	a3 60 fe 10 00       	mov    %eax,0x10fe60
    crt_pos = pos;                                                  //crt_pos是CGA当前光标位置
  100f5d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100f60:	66 a3 64 fe 10 00    	mov    %ax,0x10fe64
}
  100f66:	90                   	nop
  100f67:	c9                   	leave  
  100f68:	c3                   	ret    

00100f69 <serial_init>:

static bool serial_exists = 0;

static void
serial_init(void) {
  100f69:	f3 0f 1e fb          	endbr32 
  100f6d:	55                   	push   %ebp
  100f6e:	89 e5                	mov    %esp,%ebp
  100f70:	83 ec 38             	sub    $0x38,%esp
  100f73:	66 c7 45 d2 fa 03    	movw   $0x3fa,-0x2e(%ebp)
  100f79:	c6 45 d1 00          	movb   $0x0,-0x2f(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100f7d:	0f b6 45 d1          	movzbl -0x2f(%ebp),%eax
  100f81:	0f b7 55 d2          	movzwl -0x2e(%ebp),%edx
  100f85:	ee                   	out    %al,(%dx)
}
  100f86:	90                   	nop
  100f87:	66 c7 45 d6 fb 03    	movw   $0x3fb,-0x2a(%ebp)
  100f8d:	c6 45 d5 80          	movb   $0x80,-0x2b(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100f91:	0f b6 45 d5          	movzbl -0x2b(%ebp),%eax
  100f95:	0f b7 55 d6          	movzwl -0x2a(%ebp),%edx
  100f99:	ee                   	out    %al,(%dx)
}
  100f9a:	90                   	nop
  100f9b:	66 c7 45 da f8 03    	movw   $0x3f8,-0x26(%ebp)
  100fa1:	c6 45 d9 0c          	movb   $0xc,-0x27(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100fa5:	0f b6 45 d9          	movzbl -0x27(%ebp),%eax
  100fa9:	0f b7 55 da          	movzwl -0x26(%ebp),%edx
  100fad:	ee                   	out    %al,(%dx)
}
  100fae:	90                   	nop
  100faf:	66 c7 45 de f9 03    	movw   $0x3f9,-0x22(%ebp)
  100fb5:	c6 45 dd 00          	movb   $0x0,-0x23(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100fb9:	0f b6 45 dd          	movzbl -0x23(%ebp),%eax
  100fbd:	0f b7 55 de          	movzwl -0x22(%ebp),%edx
  100fc1:	ee                   	out    %al,(%dx)
}
  100fc2:	90                   	nop
  100fc3:	66 c7 45 e2 fb 03    	movw   $0x3fb,-0x1e(%ebp)
  100fc9:	c6 45 e1 03          	movb   $0x3,-0x1f(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100fcd:	0f b6 45 e1          	movzbl -0x1f(%ebp),%eax
  100fd1:	0f b7 55 e2          	movzwl -0x1e(%ebp),%edx
  100fd5:	ee                   	out    %al,(%dx)
}
  100fd6:	90                   	nop
  100fd7:	66 c7 45 e6 fc 03    	movw   $0x3fc,-0x1a(%ebp)
  100fdd:	c6 45 e5 00          	movb   $0x0,-0x1b(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100fe1:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
  100fe5:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
  100fe9:	ee                   	out    %al,(%dx)
}
  100fea:	90                   	nop
  100feb:	66 c7 45 ea f9 03    	movw   $0x3f9,-0x16(%ebp)
  100ff1:	c6 45 e9 01          	movb   $0x1,-0x17(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100ff5:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
  100ff9:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
  100ffd:	ee                   	out    %al,(%dx)
}
  100ffe:	90                   	nop
  100fff:	66 c7 45 ee fd 03    	movw   $0x3fd,-0x12(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  101005:	0f b7 45 ee          	movzwl -0x12(%ebp),%eax
  101009:	89 c2                	mov    %eax,%edx
  10100b:	ec                   	in     (%dx),%al
  10100c:	88 45 ed             	mov    %al,-0x13(%ebp)
    return data;
  10100f:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
    // Enable rcv interrupts
    outb(COM1 + COM_IER, COM_IER_RDI);

    // Clear any preexisting overrun indications and interrupts
    // Serial port doesn't exist if COM_LSR returns 0xFF
    serial_exists = (inb(COM1 + COM_LSR) != 0xFF);
  101013:	3c ff                	cmp    $0xff,%al
  101015:	0f 95 c0             	setne  %al
  101018:	0f b6 c0             	movzbl %al,%eax
  10101b:	a3 68 fe 10 00       	mov    %eax,0x10fe68
  101020:	66 c7 45 f2 fa 03    	movw   $0x3fa,-0xe(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  101026:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
  10102a:	89 c2                	mov    %eax,%edx
  10102c:	ec                   	in     (%dx),%al
  10102d:	88 45 f1             	mov    %al,-0xf(%ebp)
  101030:	66 c7 45 f6 f8 03    	movw   $0x3f8,-0xa(%ebp)
  101036:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  10103a:	89 c2                	mov    %eax,%edx
  10103c:	ec                   	in     (%dx),%al
  10103d:	88 45 f5             	mov    %al,-0xb(%ebp)
    (void) inb(COM1+COM_IIR);
    (void) inb(COM1+COM_RX);

    if (serial_exists) {
  101040:	a1 68 fe 10 00       	mov    0x10fe68,%eax
  101045:	85 c0                	test   %eax,%eax
  101047:	74 0d                	je     101056 <serial_init+0xed>
        pic_enable(IRQ_COM1);
  101049:	83 ec 0c             	sub    $0xc,%esp
  10104c:	6a 04                	push   $0x4
  10104e:	e8 0f 07 00 00       	call   101762 <pic_enable>
  101053:	83 c4 10             	add    $0x10,%esp
    }
}
  101056:	90                   	nop
  101057:	c9                   	leave  
  101058:	c3                   	ret    

00101059 <lpt_putc_sub>:

static void
lpt_putc_sub(int c) {
  101059:	f3 0f 1e fb          	endbr32 
  10105d:	55                   	push   %ebp
  10105e:	89 e5                	mov    %esp,%ebp
  101060:	83 ec 20             	sub    $0x20,%esp
    int i;
    for (i = 0; !(inb(LPTPORT + 1) & 0x80) && i < 12800; i ++) {
  101063:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  10106a:	eb 09                	jmp    101075 <lpt_putc_sub+0x1c>
        delay();
  10106c:	e8 be fd ff ff       	call   100e2f <delay>
    for (i = 0; !(inb(LPTPORT + 1) & 0x80) && i < 12800; i ++) {
  101071:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  101075:	66 c7 45 fa 79 03    	movw   $0x379,-0x6(%ebp)
  10107b:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
  10107f:	89 c2                	mov    %eax,%edx
  101081:	ec                   	in     (%dx),%al
  101082:	88 45 f9             	mov    %al,-0x7(%ebp)
    return data;
  101085:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
  101089:	84 c0                	test   %al,%al
  10108b:	78 09                	js     101096 <lpt_putc_sub+0x3d>
  10108d:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%ebp)
  101094:	7e d6                	jle    10106c <lpt_putc_sub+0x13>
    }
    outb(LPTPORT + 0, c);
  101096:	8b 45 08             	mov    0x8(%ebp),%eax
  101099:	0f b6 c0             	movzbl %al,%eax
  10109c:	66 c7 45 ee 78 03    	movw   $0x378,-0x12(%ebp)
  1010a2:	88 45 ed             	mov    %al,-0x13(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1010a5:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  1010a9:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  1010ad:	ee                   	out    %al,(%dx)
}
  1010ae:	90                   	nop
  1010af:	66 c7 45 f2 7a 03    	movw   $0x37a,-0xe(%ebp)
  1010b5:	c6 45 f1 0d          	movb   $0xd,-0xf(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1010b9:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  1010bd:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  1010c1:	ee                   	out    %al,(%dx)
}
  1010c2:	90                   	nop
  1010c3:	66 c7 45 f6 7a 03    	movw   $0x37a,-0xa(%ebp)
  1010c9:	c6 45 f5 08          	movb   $0x8,-0xb(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1010cd:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  1010d1:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  1010d5:	ee                   	out    %al,(%dx)
}
  1010d6:	90                   	nop
    outb(LPTPORT + 2, 0x08 | 0x04 | 0x01);
    outb(LPTPORT + 2, 0x08);
}
  1010d7:	90                   	nop
  1010d8:	c9                   	leave  
  1010d9:	c3                   	ret    

001010da <lpt_putc>:

/* lpt_putc - copy console output to parallel port */
static void
lpt_putc(int c) {
  1010da:	f3 0f 1e fb          	endbr32 
  1010de:	55                   	push   %ebp
  1010df:	89 e5                	mov    %esp,%ebp
    if (c != '\b') {
  1010e1:	83 7d 08 08          	cmpl   $0x8,0x8(%ebp)
  1010e5:	74 0d                	je     1010f4 <lpt_putc+0x1a>
        lpt_putc_sub(c);
  1010e7:	ff 75 08             	pushl  0x8(%ebp)
  1010ea:	e8 6a ff ff ff       	call   101059 <lpt_putc_sub>
  1010ef:	83 c4 04             	add    $0x4,%esp
    else {
        lpt_putc_sub('\b');
        lpt_putc_sub(' ');
        lpt_putc_sub('\b');
    }
}
  1010f2:	eb 1e                	jmp    101112 <lpt_putc+0x38>
        lpt_putc_sub('\b');
  1010f4:	6a 08                	push   $0x8
  1010f6:	e8 5e ff ff ff       	call   101059 <lpt_putc_sub>
  1010fb:	83 c4 04             	add    $0x4,%esp
        lpt_putc_sub(' ');
  1010fe:	6a 20                	push   $0x20
  101100:	e8 54 ff ff ff       	call   101059 <lpt_putc_sub>
  101105:	83 c4 04             	add    $0x4,%esp
        lpt_putc_sub('\b');
  101108:	6a 08                	push   $0x8
  10110a:	e8 4a ff ff ff       	call   101059 <lpt_putc_sub>
  10110f:	83 c4 04             	add    $0x4,%esp
}
  101112:	90                   	nop
  101113:	c9                   	leave  
  101114:	c3                   	ret    

00101115 <cga_putc>:

/* cga_putc - print character to console */
static void
cga_putc(int c) {
  101115:	f3 0f 1e fb          	endbr32 
  101119:	55                   	push   %ebp
  10111a:	89 e5                	mov    %esp,%ebp
  10111c:	53                   	push   %ebx
  10111d:	83 ec 24             	sub    $0x24,%esp
    // set black on white
    if (!(c & ~0xFF)) {
  101120:	8b 45 08             	mov    0x8(%ebp),%eax
  101123:	b0 00                	mov    $0x0,%al
  101125:	85 c0                	test   %eax,%eax
  101127:	75 07                	jne    101130 <cga_putc+0x1b>
        c |= 0x0700;
  101129:	81 4d 08 00 07 00 00 	orl    $0x700,0x8(%ebp)
    }

    switch (c & 0xff) {
  101130:	8b 45 08             	mov    0x8(%ebp),%eax
  101133:	0f b6 c0             	movzbl %al,%eax
  101136:	83 f8 0d             	cmp    $0xd,%eax
  101139:	74 6c                	je     1011a7 <cga_putc+0x92>
  10113b:	83 f8 0d             	cmp    $0xd,%eax
  10113e:	0f 8f 9d 00 00 00    	jg     1011e1 <cga_putc+0xcc>
  101144:	83 f8 08             	cmp    $0x8,%eax
  101147:	74 0a                	je     101153 <cga_putc+0x3e>
  101149:	83 f8 0a             	cmp    $0xa,%eax
  10114c:	74 49                	je     101197 <cga_putc+0x82>
  10114e:	e9 8e 00 00 00       	jmp    1011e1 <cga_putc+0xcc>
    case '\b':
        if (crt_pos > 0) {
  101153:	0f b7 05 64 fe 10 00 	movzwl 0x10fe64,%eax
  10115a:	66 85 c0             	test   %ax,%ax
  10115d:	0f 84 a4 00 00 00    	je     101207 <cga_putc+0xf2>
            crt_pos --;
  101163:	0f b7 05 64 fe 10 00 	movzwl 0x10fe64,%eax
  10116a:	83 e8 01             	sub    $0x1,%eax
  10116d:	66 a3 64 fe 10 00    	mov    %ax,0x10fe64
            crt_buf[crt_pos] = (c & ~0xff) | ' ';
  101173:	8b 45 08             	mov    0x8(%ebp),%eax
  101176:	b0 00                	mov    $0x0,%al
  101178:	83 c8 20             	or     $0x20,%eax
  10117b:	89 c1                	mov    %eax,%ecx
  10117d:	a1 60 fe 10 00       	mov    0x10fe60,%eax
  101182:	0f b7 15 64 fe 10 00 	movzwl 0x10fe64,%edx
  101189:	0f b7 d2             	movzwl %dx,%edx
  10118c:	01 d2                	add    %edx,%edx
  10118e:	01 d0                	add    %edx,%eax
  101190:	89 ca                	mov    %ecx,%edx
  101192:	66 89 10             	mov    %dx,(%eax)
        }
        break;
  101195:	eb 70                	jmp    101207 <cga_putc+0xf2>
    case '\n':
        crt_pos += CRT_COLS;
  101197:	0f b7 05 64 fe 10 00 	movzwl 0x10fe64,%eax
  10119e:	83 c0 50             	add    $0x50,%eax
  1011a1:	66 a3 64 fe 10 00    	mov    %ax,0x10fe64
    case '\r':
        crt_pos -= (crt_pos % CRT_COLS);
  1011a7:	0f b7 1d 64 fe 10 00 	movzwl 0x10fe64,%ebx
  1011ae:	0f b7 0d 64 fe 10 00 	movzwl 0x10fe64,%ecx
  1011b5:	0f b7 c1             	movzwl %cx,%eax
  1011b8:	69 c0 cd cc 00 00    	imul   $0xcccd,%eax,%eax
  1011be:	c1 e8 10             	shr    $0x10,%eax
  1011c1:	89 c2                	mov    %eax,%edx
  1011c3:	66 c1 ea 06          	shr    $0x6,%dx
  1011c7:	89 d0                	mov    %edx,%eax
  1011c9:	c1 e0 02             	shl    $0x2,%eax
  1011cc:	01 d0                	add    %edx,%eax
  1011ce:	c1 e0 04             	shl    $0x4,%eax
  1011d1:	29 c1                	sub    %eax,%ecx
  1011d3:	89 ca                	mov    %ecx,%edx
  1011d5:	89 d8                	mov    %ebx,%eax
  1011d7:	29 d0                	sub    %edx,%eax
  1011d9:	66 a3 64 fe 10 00    	mov    %ax,0x10fe64
        break;
  1011df:	eb 27                	jmp    101208 <cga_putc+0xf3>
    default:
        crt_buf[crt_pos ++] = c;     // write the character
  1011e1:	8b 0d 60 fe 10 00    	mov    0x10fe60,%ecx
  1011e7:	0f b7 05 64 fe 10 00 	movzwl 0x10fe64,%eax
  1011ee:	8d 50 01             	lea    0x1(%eax),%edx
  1011f1:	66 89 15 64 fe 10 00 	mov    %dx,0x10fe64
  1011f8:	0f b7 c0             	movzwl %ax,%eax
  1011fb:	01 c0                	add    %eax,%eax
  1011fd:	01 c8                	add    %ecx,%eax
  1011ff:	8b 55 08             	mov    0x8(%ebp),%edx
  101202:	66 89 10             	mov    %dx,(%eax)
        break;
  101205:	eb 01                	jmp    101208 <cga_putc+0xf3>
        break;
  101207:	90                   	nop
    }

    // What is the purpose of this?
    if (crt_pos >= CRT_SIZE) {
  101208:	0f b7 05 64 fe 10 00 	movzwl 0x10fe64,%eax
  10120f:	66 3d cf 07          	cmp    $0x7cf,%ax
  101213:	76 59                	jbe    10126e <cga_putc+0x159>
        int i;
        memmove(crt_buf, crt_buf + CRT_COLS, (CRT_SIZE - CRT_COLS) * sizeof(uint16_t));
  101215:	a1 60 fe 10 00       	mov    0x10fe60,%eax
  10121a:	8d 90 a0 00 00 00    	lea    0xa0(%eax),%edx
  101220:	a1 60 fe 10 00       	mov    0x10fe60,%eax
  101225:	83 ec 04             	sub    $0x4,%esp
  101228:	68 00 0f 00 00       	push   $0xf00
  10122d:	52                   	push   %edx
  10122e:	50                   	push   %eax
  10122f:	e8 02 1c 00 00       	call   102e36 <memmove>
  101234:	83 c4 10             	add    $0x10,%esp
        for (i = CRT_SIZE - CRT_COLS; i < CRT_SIZE; i ++) {
  101237:	c7 45 f4 80 07 00 00 	movl   $0x780,-0xc(%ebp)
  10123e:	eb 15                	jmp    101255 <cga_putc+0x140>
            crt_buf[i] = 0x0700 | ' ';
  101240:	a1 60 fe 10 00       	mov    0x10fe60,%eax
  101245:	8b 55 f4             	mov    -0xc(%ebp),%edx
  101248:	01 d2                	add    %edx,%edx
  10124a:	01 d0                	add    %edx,%eax
  10124c:	66 c7 00 20 07       	movw   $0x720,(%eax)
        for (i = CRT_SIZE - CRT_COLS; i < CRT_SIZE; i ++) {
  101251:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  101255:	81 7d f4 cf 07 00 00 	cmpl   $0x7cf,-0xc(%ebp)
  10125c:	7e e2                	jle    101240 <cga_putc+0x12b>
        }
        crt_pos -= CRT_COLS;
  10125e:	0f b7 05 64 fe 10 00 	movzwl 0x10fe64,%eax
  101265:	83 e8 50             	sub    $0x50,%eax
  101268:	66 a3 64 fe 10 00    	mov    %ax,0x10fe64
    }

    // move that little blinky thing
    outb(addr_6845, 14);
  10126e:	0f b7 05 66 fe 10 00 	movzwl 0x10fe66,%eax
  101275:	0f b7 c0             	movzwl %ax,%eax
  101278:	66 89 45 e6          	mov    %ax,-0x1a(%ebp)
  10127c:	c6 45 e5 0e          	movb   $0xe,-0x1b(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101280:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
  101284:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
  101288:	ee                   	out    %al,(%dx)
}
  101289:	90                   	nop
    outb(addr_6845 + 1, crt_pos >> 8);
  10128a:	0f b7 05 64 fe 10 00 	movzwl 0x10fe64,%eax
  101291:	66 c1 e8 08          	shr    $0x8,%ax
  101295:	0f b6 c0             	movzbl %al,%eax
  101298:	0f b7 15 66 fe 10 00 	movzwl 0x10fe66,%edx
  10129f:	83 c2 01             	add    $0x1,%edx
  1012a2:	0f b7 d2             	movzwl %dx,%edx
  1012a5:	66 89 55 ea          	mov    %dx,-0x16(%ebp)
  1012a9:	88 45 e9             	mov    %al,-0x17(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1012ac:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
  1012b0:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
  1012b4:	ee                   	out    %al,(%dx)
}
  1012b5:	90                   	nop
    outb(addr_6845, 15);
  1012b6:	0f b7 05 66 fe 10 00 	movzwl 0x10fe66,%eax
  1012bd:	0f b7 c0             	movzwl %ax,%eax
  1012c0:	66 89 45 ee          	mov    %ax,-0x12(%ebp)
  1012c4:	c6 45 ed 0f          	movb   $0xf,-0x13(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1012c8:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  1012cc:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  1012d0:	ee                   	out    %al,(%dx)
}
  1012d1:	90                   	nop
    outb(addr_6845 + 1, crt_pos);
  1012d2:	0f b7 05 64 fe 10 00 	movzwl 0x10fe64,%eax
  1012d9:	0f b6 c0             	movzbl %al,%eax
  1012dc:	0f b7 15 66 fe 10 00 	movzwl 0x10fe66,%edx
  1012e3:	83 c2 01             	add    $0x1,%edx
  1012e6:	0f b7 d2             	movzwl %dx,%edx
  1012e9:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  1012ed:	88 45 f1             	mov    %al,-0xf(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1012f0:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  1012f4:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  1012f8:	ee                   	out    %al,(%dx)
}
  1012f9:	90                   	nop
}
  1012fa:	90                   	nop
  1012fb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  1012fe:	c9                   	leave  
  1012ff:	c3                   	ret    

00101300 <serial_putc_sub>:

static void
serial_putc_sub(int c) {
  101300:	f3 0f 1e fb          	endbr32 
  101304:	55                   	push   %ebp
  101305:	89 e5                	mov    %esp,%ebp
  101307:	83 ec 10             	sub    $0x10,%esp
    int i;
    for (i = 0; !(inb(COM1 + COM_LSR) & COM_LSR_TXRDY) && i < 12800; i ++) {
  10130a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  101311:	eb 09                	jmp    10131c <serial_putc_sub+0x1c>
        delay();
  101313:	e8 17 fb ff ff       	call   100e2f <delay>
    for (i = 0; !(inb(COM1 + COM_LSR) & COM_LSR_TXRDY) && i < 12800; i ++) {
  101318:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  10131c:	66 c7 45 fa fd 03    	movw   $0x3fd,-0x6(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  101322:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
  101326:	89 c2                	mov    %eax,%edx
  101328:	ec                   	in     (%dx),%al
  101329:	88 45 f9             	mov    %al,-0x7(%ebp)
    return data;
  10132c:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
  101330:	0f b6 c0             	movzbl %al,%eax
  101333:	83 e0 20             	and    $0x20,%eax
  101336:	85 c0                	test   %eax,%eax
  101338:	75 09                	jne    101343 <serial_putc_sub+0x43>
  10133a:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%ebp)
  101341:	7e d0                	jle    101313 <serial_putc_sub+0x13>
    }
    outb(COM1 + COM_TX, c);
  101343:	8b 45 08             	mov    0x8(%ebp),%eax
  101346:	0f b6 c0             	movzbl %al,%eax
  101349:	66 c7 45 f6 f8 03    	movw   $0x3f8,-0xa(%ebp)
  10134f:	88 45 f5             	mov    %al,-0xb(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101352:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  101356:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  10135a:	ee                   	out    %al,(%dx)
}
  10135b:	90                   	nop
}
  10135c:	90                   	nop
  10135d:	c9                   	leave  
  10135e:	c3                   	ret    

0010135f <serial_putc>:

/* serial_putc - print character to serial port */
static void
serial_putc(int c) {
  10135f:	f3 0f 1e fb          	endbr32 
  101363:	55                   	push   %ebp
  101364:	89 e5                	mov    %esp,%ebp
    if (c != '\b') {
  101366:	83 7d 08 08          	cmpl   $0x8,0x8(%ebp)
  10136a:	74 0d                	je     101379 <serial_putc+0x1a>
        serial_putc_sub(c);
  10136c:	ff 75 08             	pushl  0x8(%ebp)
  10136f:	e8 8c ff ff ff       	call   101300 <serial_putc_sub>
  101374:	83 c4 04             	add    $0x4,%esp
    else {
        serial_putc_sub('\b');
        serial_putc_sub(' ');
        serial_putc_sub('\b');
    }
}
  101377:	eb 1e                	jmp    101397 <serial_putc+0x38>
        serial_putc_sub('\b');
  101379:	6a 08                	push   $0x8
  10137b:	e8 80 ff ff ff       	call   101300 <serial_putc_sub>
  101380:	83 c4 04             	add    $0x4,%esp
        serial_putc_sub(' ');
  101383:	6a 20                	push   $0x20
  101385:	e8 76 ff ff ff       	call   101300 <serial_putc_sub>
  10138a:	83 c4 04             	add    $0x4,%esp
        serial_putc_sub('\b');
  10138d:	6a 08                	push   $0x8
  10138f:	e8 6c ff ff ff       	call   101300 <serial_putc_sub>
  101394:	83 c4 04             	add    $0x4,%esp
}
  101397:	90                   	nop
  101398:	c9                   	leave  
  101399:	c3                   	ret    

0010139a <cons_intr>:
/* *
 * cons_intr - called by device interrupt routines to feed input
 * characters into the circular console input buffer.
 * */
static void
cons_intr(int (*proc)(void)) {
  10139a:	f3 0f 1e fb          	endbr32 
  10139e:	55                   	push   %ebp
  10139f:	89 e5                	mov    %esp,%ebp
  1013a1:	83 ec 18             	sub    $0x18,%esp
    int c;
    while ((c = (*proc)()) != -1) {
  1013a4:	eb 33                	jmp    1013d9 <cons_intr+0x3f>
        if (c != 0) {
  1013a6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  1013aa:	74 2d                	je     1013d9 <cons_intr+0x3f>
            cons.buf[cons.wpos ++] = c;
  1013ac:	a1 84 00 11 00       	mov    0x110084,%eax
  1013b1:	8d 50 01             	lea    0x1(%eax),%edx
  1013b4:	89 15 84 00 11 00    	mov    %edx,0x110084
  1013ba:	8b 55 f4             	mov    -0xc(%ebp),%edx
  1013bd:	88 90 80 fe 10 00    	mov    %dl,0x10fe80(%eax)
            if (cons.wpos == CONSBUFSIZE) {
  1013c3:	a1 84 00 11 00       	mov    0x110084,%eax
  1013c8:	3d 00 02 00 00       	cmp    $0x200,%eax
  1013cd:	75 0a                	jne    1013d9 <cons_intr+0x3f>
                cons.wpos = 0;
  1013cf:	c7 05 84 00 11 00 00 	movl   $0x0,0x110084
  1013d6:	00 00 00 
    while ((c = (*proc)()) != -1) {
  1013d9:	8b 45 08             	mov    0x8(%ebp),%eax
  1013dc:	ff d0                	call   *%eax
  1013de:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1013e1:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
  1013e5:	75 bf                	jne    1013a6 <cons_intr+0xc>
            }
        }
    }
}
  1013e7:	90                   	nop
  1013e8:	90                   	nop
  1013e9:	c9                   	leave  
  1013ea:	c3                   	ret    

001013eb <serial_proc_data>:

/* serial_proc_data - get data from serial port */
static int
serial_proc_data(void) {
  1013eb:	f3 0f 1e fb          	endbr32 
  1013ef:	55                   	push   %ebp
  1013f0:	89 e5                	mov    %esp,%ebp
  1013f2:	83 ec 10             	sub    $0x10,%esp
  1013f5:	66 c7 45 fa fd 03    	movw   $0x3fd,-0x6(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  1013fb:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
  1013ff:	89 c2                	mov    %eax,%edx
  101401:	ec                   	in     (%dx),%al
  101402:	88 45 f9             	mov    %al,-0x7(%ebp)
    return data;
  101405:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
    if (!(inb(COM1 + COM_LSR) & COM_LSR_DATA)) {
  101409:	0f b6 c0             	movzbl %al,%eax
  10140c:	83 e0 01             	and    $0x1,%eax
  10140f:	85 c0                	test   %eax,%eax
  101411:	75 07                	jne    10141a <serial_proc_data+0x2f>
        return -1;
  101413:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  101418:	eb 2a                	jmp    101444 <serial_proc_data+0x59>
  10141a:	66 c7 45 f6 f8 03    	movw   $0x3f8,-0xa(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  101420:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  101424:	89 c2                	mov    %eax,%edx
  101426:	ec                   	in     (%dx),%al
  101427:	88 45 f5             	mov    %al,-0xb(%ebp)
    return data;
  10142a:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
    }
    int c = inb(COM1 + COM_RX);
  10142e:	0f b6 c0             	movzbl %al,%eax
  101431:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (c == 127) {
  101434:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%ebp)
  101438:	75 07                	jne    101441 <serial_proc_data+0x56>
        c = '\b';
  10143a:	c7 45 fc 08 00 00 00 	movl   $0x8,-0x4(%ebp)
    }
    return c;
  101441:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  101444:	c9                   	leave  
  101445:	c3                   	ret    

00101446 <serial_intr>:

/* serial_intr - try to feed input characters from serial port */
void
serial_intr(void) {
  101446:	f3 0f 1e fb          	endbr32 
  10144a:	55                   	push   %ebp
  10144b:	89 e5                	mov    %esp,%ebp
  10144d:	83 ec 08             	sub    $0x8,%esp
    if (serial_exists) {
  101450:	a1 68 fe 10 00       	mov    0x10fe68,%eax
  101455:	85 c0                	test   %eax,%eax
  101457:	74 10                	je     101469 <serial_intr+0x23>
        cons_intr(serial_proc_data);
  101459:	83 ec 0c             	sub    $0xc,%esp
  10145c:	68 eb 13 10 00       	push   $0x1013eb
  101461:	e8 34 ff ff ff       	call   10139a <cons_intr>
  101466:	83 c4 10             	add    $0x10,%esp
    }
}
  101469:	90                   	nop
  10146a:	c9                   	leave  
  10146b:	c3                   	ret    

0010146c <kbd_proc_data>:
 *
 * The kbd_proc_data() function gets data from the keyboard.
 * If we finish a character, return it, else 0. And return -1 if no data.
 * */
static int
kbd_proc_data(void) {
  10146c:	f3 0f 1e fb          	endbr32 
  101470:	55                   	push   %ebp
  101471:	89 e5                	mov    %esp,%ebp
  101473:	83 ec 28             	sub    $0x28,%esp
  101476:	66 c7 45 f0 64 00    	movw   $0x64,-0x10(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  10147c:	0f b7 45 f0          	movzwl -0x10(%ebp),%eax
  101480:	89 c2                	mov    %eax,%edx
  101482:	ec                   	in     (%dx),%al
  101483:	88 45 ef             	mov    %al,-0x11(%ebp)
    return data;
  101486:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    int c;
    uint8_t data;
    static uint32_t shift;

    if ((inb(KBSTATP) & KBS_DIB) == 0) {
  10148a:	0f b6 c0             	movzbl %al,%eax
  10148d:	83 e0 01             	and    $0x1,%eax
  101490:	85 c0                	test   %eax,%eax
  101492:	75 0a                	jne    10149e <kbd_proc_data+0x32>
        return -1;
  101494:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  101499:	e9 5e 01 00 00       	jmp    1015fc <kbd_proc_data+0x190>
  10149e:	66 c7 45 ec 60 00    	movw   $0x60,-0x14(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  1014a4:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
  1014a8:	89 c2                	mov    %eax,%edx
  1014aa:	ec                   	in     (%dx),%al
  1014ab:	88 45 eb             	mov    %al,-0x15(%ebp)
    return data;
  1014ae:	0f b6 45 eb          	movzbl -0x15(%ebp),%eax
    }

    data = inb(KBDATAP);
  1014b2:	88 45 f3             	mov    %al,-0xd(%ebp)

    if (data == 0xE0) {
  1014b5:	80 7d f3 e0          	cmpb   $0xe0,-0xd(%ebp)
  1014b9:	75 17                	jne    1014d2 <kbd_proc_data+0x66>
        // E0 escape character
        shift |= E0ESC;
  1014bb:	a1 88 00 11 00       	mov    0x110088,%eax
  1014c0:	83 c8 40             	or     $0x40,%eax
  1014c3:	a3 88 00 11 00       	mov    %eax,0x110088
        return 0;
  1014c8:	b8 00 00 00 00       	mov    $0x0,%eax
  1014cd:	e9 2a 01 00 00       	jmp    1015fc <kbd_proc_data+0x190>
    } else if (data & 0x80) {
  1014d2:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  1014d6:	84 c0                	test   %al,%al
  1014d8:	79 47                	jns    101521 <kbd_proc_data+0xb5>
        // Key released
        data = (shift & E0ESC ? data : data & 0x7F);
  1014da:	a1 88 00 11 00       	mov    0x110088,%eax
  1014df:	83 e0 40             	and    $0x40,%eax
  1014e2:	85 c0                	test   %eax,%eax
  1014e4:	75 09                	jne    1014ef <kbd_proc_data+0x83>
  1014e6:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  1014ea:	83 e0 7f             	and    $0x7f,%eax
  1014ed:	eb 04                	jmp    1014f3 <kbd_proc_data+0x87>
  1014ef:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  1014f3:	88 45 f3             	mov    %al,-0xd(%ebp)
        shift &= ~(shiftcode[data] | E0ESC);
  1014f6:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  1014fa:	0f b6 80 40 f0 10 00 	movzbl 0x10f040(%eax),%eax
  101501:	83 c8 40             	or     $0x40,%eax
  101504:	0f b6 c0             	movzbl %al,%eax
  101507:	f7 d0                	not    %eax
  101509:	89 c2                	mov    %eax,%edx
  10150b:	a1 88 00 11 00       	mov    0x110088,%eax
  101510:	21 d0                	and    %edx,%eax
  101512:	a3 88 00 11 00       	mov    %eax,0x110088
        return 0;
  101517:	b8 00 00 00 00       	mov    $0x0,%eax
  10151c:	e9 db 00 00 00       	jmp    1015fc <kbd_proc_data+0x190>
    } else if (shift & E0ESC) {
  101521:	a1 88 00 11 00       	mov    0x110088,%eax
  101526:	83 e0 40             	and    $0x40,%eax
  101529:	85 c0                	test   %eax,%eax
  10152b:	74 11                	je     10153e <kbd_proc_data+0xd2>
        // Last character was an E0 escape; or with 0x80
        data |= 0x80;
  10152d:	80 4d f3 80          	orb    $0x80,-0xd(%ebp)
        shift &= ~E0ESC;
  101531:	a1 88 00 11 00       	mov    0x110088,%eax
  101536:	83 e0 bf             	and    $0xffffffbf,%eax
  101539:	a3 88 00 11 00       	mov    %eax,0x110088
    }

    shift |= shiftcode[data];
  10153e:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  101542:	0f b6 80 40 f0 10 00 	movzbl 0x10f040(%eax),%eax
  101549:	0f b6 d0             	movzbl %al,%edx
  10154c:	a1 88 00 11 00       	mov    0x110088,%eax
  101551:	09 d0                	or     %edx,%eax
  101553:	a3 88 00 11 00       	mov    %eax,0x110088
    shift ^= togglecode[data];
  101558:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  10155c:	0f b6 80 40 f1 10 00 	movzbl 0x10f140(%eax),%eax
  101563:	0f b6 d0             	movzbl %al,%edx
  101566:	a1 88 00 11 00       	mov    0x110088,%eax
  10156b:	31 d0                	xor    %edx,%eax
  10156d:	a3 88 00 11 00       	mov    %eax,0x110088

    c = charcode[shift & (CTL | SHIFT)][data];
  101572:	a1 88 00 11 00       	mov    0x110088,%eax
  101577:	83 e0 03             	and    $0x3,%eax
  10157a:	8b 14 85 40 f5 10 00 	mov    0x10f540(,%eax,4),%edx
  101581:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  101585:	01 d0                	add    %edx,%eax
  101587:	0f b6 00             	movzbl (%eax),%eax
  10158a:	0f b6 c0             	movzbl %al,%eax
  10158d:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (shift & CAPSLOCK) {
  101590:	a1 88 00 11 00       	mov    0x110088,%eax
  101595:	83 e0 08             	and    $0x8,%eax
  101598:	85 c0                	test   %eax,%eax
  10159a:	74 22                	je     1015be <kbd_proc_data+0x152>
        if ('a' <= c && c <= 'z')
  10159c:	83 7d f4 60          	cmpl   $0x60,-0xc(%ebp)
  1015a0:	7e 0c                	jle    1015ae <kbd_proc_data+0x142>
  1015a2:	83 7d f4 7a          	cmpl   $0x7a,-0xc(%ebp)
  1015a6:	7f 06                	jg     1015ae <kbd_proc_data+0x142>
            c += 'A' - 'a';
  1015a8:	83 6d f4 20          	subl   $0x20,-0xc(%ebp)
  1015ac:	eb 10                	jmp    1015be <kbd_proc_data+0x152>
        else if ('A' <= c && c <= 'Z')
  1015ae:	83 7d f4 40          	cmpl   $0x40,-0xc(%ebp)
  1015b2:	7e 0a                	jle    1015be <kbd_proc_data+0x152>
  1015b4:	83 7d f4 5a          	cmpl   $0x5a,-0xc(%ebp)
  1015b8:	7f 04                	jg     1015be <kbd_proc_data+0x152>
            c += 'a' - 'A';
  1015ba:	83 45 f4 20          	addl   $0x20,-0xc(%ebp)
    }

    // Process special keys
    // Ctrl-Alt-Del: reboot
    if (!(~shift & (CTL | ALT)) && c == KEY_DEL) {
  1015be:	a1 88 00 11 00       	mov    0x110088,%eax
  1015c3:	f7 d0                	not    %eax
  1015c5:	83 e0 06             	and    $0x6,%eax
  1015c8:	85 c0                	test   %eax,%eax
  1015ca:	75 2d                	jne    1015f9 <kbd_proc_data+0x18d>
  1015cc:	81 7d f4 e9 00 00 00 	cmpl   $0xe9,-0xc(%ebp)
  1015d3:	75 24                	jne    1015f9 <kbd_proc_data+0x18d>
        cprintf("Rebooting!\n");
  1015d5:	83 ec 0c             	sub    $0xc,%esp
  1015d8:	68 01 39 10 00       	push   $0x103901
  1015dd:	e8 8d ec ff ff       	call   10026f <cprintf>
  1015e2:	83 c4 10             	add    $0x10,%esp
  1015e5:	66 c7 45 e8 92 00    	movw   $0x92,-0x18(%ebp)
  1015eb:	c6 45 e7 03          	movb   $0x3,-0x19(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1015ef:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
  1015f3:	0f b7 55 e8          	movzwl -0x18(%ebp),%edx
  1015f7:	ee                   	out    %al,(%dx)
}
  1015f8:	90                   	nop
        outb(0x92, 0x3); // courtesy of Chris Frost
    }
    return c;
  1015f9:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  1015fc:	c9                   	leave  
  1015fd:	c3                   	ret    

001015fe <kbd_intr>:

/* kbd_intr - try to feed input characters from keyboard */
static void
kbd_intr(void) {
  1015fe:	f3 0f 1e fb          	endbr32 
  101602:	55                   	push   %ebp
  101603:	89 e5                	mov    %esp,%ebp
  101605:	83 ec 08             	sub    $0x8,%esp
    cons_intr(kbd_proc_data);
  101608:	83 ec 0c             	sub    $0xc,%esp
  10160b:	68 6c 14 10 00       	push   $0x10146c
  101610:	e8 85 fd ff ff       	call   10139a <cons_intr>
  101615:	83 c4 10             	add    $0x10,%esp
}
  101618:	90                   	nop
  101619:	c9                   	leave  
  10161a:	c3                   	ret    

0010161b <kbd_init>:

static void
kbd_init(void) {
  10161b:	f3 0f 1e fb          	endbr32 
  10161f:	55                   	push   %ebp
  101620:	89 e5                	mov    %esp,%ebp
  101622:	83 ec 08             	sub    $0x8,%esp
    // drain the kbd buffer
    kbd_intr();
  101625:	e8 d4 ff ff ff       	call   1015fe <kbd_intr>
    pic_enable(IRQ_KBD);
  10162a:	83 ec 0c             	sub    $0xc,%esp
  10162d:	6a 01                	push   $0x1
  10162f:	e8 2e 01 00 00       	call   101762 <pic_enable>
  101634:	83 c4 10             	add    $0x10,%esp
}
  101637:	90                   	nop
  101638:	c9                   	leave  
  101639:	c3                   	ret    

0010163a <cons_init>:

/* cons_init - initializes the console devices */
void
cons_init(void) {
  10163a:	f3 0f 1e fb          	endbr32 
  10163e:	55                   	push   %ebp
  10163f:	89 e5                	mov    %esp,%ebp
  101641:	83 ec 08             	sub    $0x8,%esp
    cga_init();
  101644:	e8 33 f8 ff ff       	call   100e7c <cga_init>
    serial_init();
  101649:	e8 1b f9 ff ff       	call   100f69 <serial_init>
    kbd_init();
  10164e:	e8 c8 ff ff ff       	call   10161b <kbd_init>
    if (!serial_exists) {
  101653:	a1 68 fe 10 00       	mov    0x10fe68,%eax
  101658:	85 c0                	test   %eax,%eax
  10165a:	75 10                	jne    10166c <cons_init+0x32>
        cprintf("serial port does not exist!!\n");
  10165c:	83 ec 0c             	sub    $0xc,%esp
  10165f:	68 0d 39 10 00       	push   $0x10390d
  101664:	e8 06 ec ff ff       	call   10026f <cprintf>
  101669:	83 c4 10             	add    $0x10,%esp
    }
}
  10166c:	90                   	nop
  10166d:	c9                   	leave  
  10166e:	c3                   	ret    

0010166f <cons_putc>:

/* cons_putc - print a single character @c to console devices */
void
cons_putc(int c) {
  10166f:	f3 0f 1e fb          	endbr32 
  101673:	55                   	push   %ebp
  101674:	89 e5                	mov    %esp,%ebp
  101676:	83 ec 08             	sub    $0x8,%esp
    lpt_putc(c);
  101679:	ff 75 08             	pushl  0x8(%ebp)
  10167c:	e8 59 fa ff ff       	call   1010da <lpt_putc>
  101681:	83 c4 04             	add    $0x4,%esp
    cga_putc(c);
  101684:	83 ec 0c             	sub    $0xc,%esp
  101687:	ff 75 08             	pushl  0x8(%ebp)
  10168a:	e8 86 fa ff ff       	call   101115 <cga_putc>
  10168f:	83 c4 10             	add    $0x10,%esp
    serial_putc(c);
  101692:	83 ec 0c             	sub    $0xc,%esp
  101695:	ff 75 08             	pushl  0x8(%ebp)
  101698:	e8 c2 fc ff ff       	call   10135f <serial_putc>
  10169d:	83 c4 10             	add    $0x10,%esp
}
  1016a0:	90                   	nop
  1016a1:	c9                   	leave  
  1016a2:	c3                   	ret    

001016a3 <cons_getc>:
/* *
 * cons_getc - return the next input character from console,
 * or 0 if none waiting.
 * */
int
cons_getc(void) {
  1016a3:	f3 0f 1e fb          	endbr32 
  1016a7:	55                   	push   %ebp
  1016a8:	89 e5                	mov    %esp,%ebp
  1016aa:	83 ec 18             	sub    $0x18,%esp
    int c;

    // poll for any pending input characters,
    // so that this function works even when interrupts are disabled
    // (e.g., when called from the kernel monitor).
    serial_intr();
  1016ad:	e8 94 fd ff ff       	call   101446 <serial_intr>
    kbd_intr();
  1016b2:	e8 47 ff ff ff       	call   1015fe <kbd_intr>

    // grab the next character from the input buffer.
    if (cons.rpos != cons.wpos) {
  1016b7:	8b 15 80 00 11 00    	mov    0x110080,%edx
  1016bd:	a1 84 00 11 00       	mov    0x110084,%eax
  1016c2:	39 c2                	cmp    %eax,%edx
  1016c4:	74 36                	je     1016fc <cons_getc+0x59>
        c = cons.buf[cons.rpos ++];
  1016c6:	a1 80 00 11 00       	mov    0x110080,%eax
  1016cb:	8d 50 01             	lea    0x1(%eax),%edx
  1016ce:	89 15 80 00 11 00    	mov    %edx,0x110080
  1016d4:	0f b6 80 80 fe 10 00 	movzbl 0x10fe80(%eax),%eax
  1016db:	0f b6 c0             	movzbl %al,%eax
  1016de:	89 45 f4             	mov    %eax,-0xc(%ebp)
        if (cons.rpos == CONSBUFSIZE) {
  1016e1:	a1 80 00 11 00       	mov    0x110080,%eax
  1016e6:	3d 00 02 00 00       	cmp    $0x200,%eax
  1016eb:	75 0a                	jne    1016f7 <cons_getc+0x54>
            cons.rpos = 0;
  1016ed:	c7 05 80 00 11 00 00 	movl   $0x0,0x110080
  1016f4:	00 00 00 
        }
        return c;
  1016f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1016fa:	eb 05                	jmp    101701 <cons_getc+0x5e>
    }
    return 0;
  1016fc:	b8 00 00 00 00       	mov    $0x0,%eax
}
  101701:	c9                   	leave  
  101702:	c3                   	ret    

00101703 <pic_setmask>:
// Initial IRQ mask has interrupt 2 enabled (for slave 8259A).
static uint16_t irq_mask = 0xFFFF & ~(1 << IRQ_SLAVE);
static bool did_init = 0;

static void
pic_setmask(uint16_t mask) {
  101703:	f3 0f 1e fb          	endbr32 
  101707:	55                   	push   %ebp
  101708:	89 e5                	mov    %esp,%ebp
  10170a:	83 ec 14             	sub    $0x14,%esp
  10170d:	8b 45 08             	mov    0x8(%ebp),%eax
  101710:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
    irq_mask = mask;
  101714:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
  101718:	66 a3 50 f5 10 00    	mov    %ax,0x10f550
    if (did_init) {
  10171e:	a1 8c 00 11 00       	mov    0x11008c,%eax
  101723:	85 c0                	test   %eax,%eax
  101725:	74 38                	je     10175f <pic_setmask+0x5c>
        outb(IO_PIC1 + 1, mask);
  101727:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
  10172b:	0f b6 c0             	movzbl %al,%eax
  10172e:	66 c7 45 fa 21 00    	movw   $0x21,-0x6(%ebp)
  101734:	88 45 f9             	mov    %al,-0x7(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101737:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
  10173b:	0f b7 55 fa          	movzwl -0x6(%ebp),%edx
  10173f:	ee                   	out    %al,(%dx)
}
  101740:	90                   	nop
        outb(IO_PIC2 + 1, mask >> 8);
  101741:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
  101745:	66 c1 e8 08          	shr    $0x8,%ax
  101749:	0f b6 c0             	movzbl %al,%eax
  10174c:	66 c7 45 fe a1 00    	movw   $0xa1,-0x2(%ebp)
  101752:	88 45 fd             	mov    %al,-0x3(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101755:	0f b6 45 fd          	movzbl -0x3(%ebp),%eax
  101759:	0f b7 55 fe          	movzwl -0x2(%ebp),%edx
  10175d:	ee                   	out    %al,(%dx)
}
  10175e:	90                   	nop
    }
}
  10175f:	90                   	nop
  101760:	c9                   	leave  
  101761:	c3                   	ret    

00101762 <pic_enable>:

void
pic_enable(unsigned int irq) {
  101762:	f3 0f 1e fb          	endbr32 
  101766:	55                   	push   %ebp
  101767:	89 e5                	mov    %esp,%ebp
    pic_setmask(irq_mask & ~(1 << irq));
  101769:	8b 45 08             	mov    0x8(%ebp),%eax
  10176c:	ba 01 00 00 00       	mov    $0x1,%edx
  101771:	89 c1                	mov    %eax,%ecx
  101773:	d3 e2                	shl    %cl,%edx
  101775:	89 d0                	mov    %edx,%eax
  101777:	f7 d0                	not    %eax
  101779:	89 c2                	mov    %eax,%edx
  10177b:	0f b7 05 50 f5 10 00 	movzwl 0x10f550,%eax
  101782:	21 d0                	and    %edx,%eax
  101784:	0f b7 c0             	movzwl %ax,%eax
  101787:	50                   	push   %eax
  101788:	e8 76 ff ff ff       	call   101703 <pic_setmask>
  10178d:	83 c4 04             	add    $0x4,%esp
}
  101790:	90                   	nop
  101791:	c9                   	leave  
  101792:	c3                   	ret    

00101793 <pic_init>:

/* pic_init - initialize the 8259A interrupt controllers */
void
pic_init(void) {
  101793:	f3 0f 1e fb          	endbr32 
  101797:	55                   	push   %ebp
  101798:	89 e5                	mov    %esp,%ebp
  10179a:	83 ec 40             	sub    $0x40,%esp
    did_init = 1;
  10179d:	c7 05 8c 00 11 00 01 	movl   $0x1,0x11008c
  1017a4:	00 00 00 
  1017a7:	66 c7 45 ca 21 00    	movw   $0x21,-0x36(%ebp)
  1017ad:	c6 45 c9 ff          	movb   $0xff,-0x37(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1017b1:	0f b6 45 c9          	movzbl -0x37(%ebp),%eax
  1017b5:	0f b7 55 ca          	movzwl -0x36(%ebp),%edx
  1017b9:	ee                   	out    %al,(%dx)
}
  1017ba:	90                   	nop
  1017bb:	66 c7 45 ce a1 00    	movw   $0xa1,-0x32(%ebp)
  1017c1:	c6 45 cd ff          	movb   $0xff,-0x33(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1017c5:	0f b6 45 cd          	movzbl -0x33(%ebp),%eax
  1017c9:	0f b7 55 ce          	movzwl -0x32(%ebp),%edx
  1017cd:	ee                   	out    %al,(%dx)
}
  1017ce:	90                   	nop
  1017cf:	66 c7 45 d2 20 00    	movw   $0x20,-0x2e(%ebp)
  1017d5:	c6 45 d1 11          	movb   $0x11,-0x2f(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1017d9:	0f b6 45 d1          	movzbl -0x2f(%ebp),%eax
  1017dd:	0f b7 55 d2          	movzwl -0x2e(%ebp),%edx
  1017e1:	ee                   	out    %al,(%dx)
}
  1017e2:	90                   	nop
  1017e3:	66 c7 45 d6 21 00    	movw   $0x21,-0x2a(%ebp)
  1017e9:	c6 45 d5 20          	movb   $0x20,-0x2b(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1017ed:	0f b6 45 d5          	movzbl -0x2b(%ebp),%eax
  1017f1:	0f b7 55 d6          	movzwl -0x2a(%ebp),%edx
  1017f5:	ee                   	out    %al,(%dx)
}
  1017f6:	90                   	nop
  1017f7:	66 c7 45 da 21 00    	movw   $0x21,-0x26(%ebp)
  1017fd:	c6 45 d9 04          	movb   $0x4,-0x27(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101801:	0f b6 45 d9          	movzbl -0x27(%ebp),%eax
  101805:	0f b7 55 da          	movzwl -0x26(%ebp),%edx
  101809:	ee                   	out    %al,(%dx)
}
  10180a:	90                   	nop
  10180b:	66 c7 45 de 21 00    	movw   $0x21,-0x22(%ebp)
  101811:	c6 45 dd 03          	movb   $0x3,-0x23(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101815:	0f b6 45 dd          	movzbl -0x23(%ebp),%eax
  101819:	0f b7 55 de          	movzwl -0x22(%ebp),%edx
  10181d:	ee                   	out    %al,(%dx)
}
  10181e:	90                   	nop
  10181f:	66 c7 45 e2 a0 00    	movw   $0xa0,-0x1e(%ebp)
  101825:	c6 45 e1 11          	movb   $0x11,-0x1f(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101829:	0f b6 45 e1          	movzbl -0x1f(%ebp),%eax
  10182d:	0f b7 55 e2          	movzwl -0x1e(%ebp),%edx
  101831:	ee                   	out    %al,(%dx)
}
  101832:	90                   	nop
  101833:	66 c7 45 e6 a1 00    	movw   $0xa1,-0x1a(%ebp)
  101839:	c6 45 e5 28          	movb   $0x28,-0x1b(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  10183d:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
  101841:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
  101845:	ee                   	out    %al,(%dx)
}
  101846:	90                   	nop
  101847:	66 c7 45 ea a1 00    	movw   $0xa1,-0x16(%ebp)
  10184d:	c6 45 e9 02          	movb   $0x2,-0x17(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101851:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
  101855:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
  101859:	ee                   	out    %al,(%dx)
}
  10185a:	90                   	nop
  10185b:	66 c7 45 ee a1 00    	movw   $0xa1,-0x12(%ebp)
  101861:	c6 45 ed 03          	movb   $0x3,-0x13(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101865:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  101869:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  10186d:	ee                   	out    %al,(%dx)
}
  10186e:	90                   	nop
  10186f:	66 c7 45 f2 20 00    	movw   $0x20,-0xe(%ebp)
  101875:	c6 45 f1 68          	movb   $0x68,-0xf(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101879:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  10187d:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  101881:	ee                   	out    %al,(%dx)
}
  101882:	90                   	nop
  101883:	66 c7 45 f6 20 00    	movw   $0x20,-0xa(%ebp)
  101889:	c6 45 f5 0a          	movb   $0xa,-0xb(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  10188d:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  101891:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  101895:	ee                   	out    %al,(%dx)
}
  101896:	90                   	nop
  101897:	66 c7 45 fa a0 00    	movw   $0xa0,-0x6(%ebp)
  10189d:	c6 45 f9 68          	movb   $0x68,-0x7(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1018a1:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
  1018a5:	0f b7 55 fa          	movzwl -0x6(%ebp),%edx
  1018a9:	ee                   	out    %al,(%dx)
}
  1018aa:	90                   	nop
  1018ab:	66 c7 45 fe a0 00    	movw   $0xa0,-0x2(%ebp)
  1018b1:	c6 45 fd 0a          	movb   $0xa,-0x3(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1018b5:	0f b6 45 fd          	movzbl -0x3(%ebp),%eax
  1018b9:	0f b7 55 fe          	movzwl -0x2(%ebp),%edx
  1018bd:	ee                   	out    %al,(%dx)
}
  1018be:	90                   	nop
    outb(IO_PIC1, 0x0a);    // read IRR by default

    outb(IO_PIC2, 0x68);    // OCW3
    outb(IO_PIC2, 0x0a);    // OCW3

    if (irq_mask != 0xFFFF) {
  1018bf:	0f b7 05 50 f5 10 00 	movzwl 0x10f550,%eax
  1018c6:	66 83 f8 ff          	cmp    $0xffff,%ax
  1018ca:	74 13                	je     1018df <pic_init+0x14c>
        pic_setmask(irq_mask);
  1018cc:	0f b7 05 50 f5 10 00 	movzwl 0x10f550,%eax
  1018d3:	0f b7 c0             	movzwl %ax,%eax
  1018d6:	50                   	push   %eax
  1018d7:	e8 27 fe ff ff       	call   101703 <pic_setmask>
  1018dc:	83 c4 04             	add    $0x4,%esp
    }
}
  1018df:	90                   	nop
  1018e0:	c9                   	leave  
  1018e1:	c3                   	ret    

001018e2 <intr_enable>:
#include <x86.h>
#include <intr.h>

/* intr_enable - enable irq interrupt */
void
intr_enable(void) {
  1018e2:	f3 0f 1e fb          	endbr32 
  1018e6:	55                   	push   %ebp
  1018e7:	89 e5                	mov    %esp,%ebp
    asm volatile ("lidt (%0)" :: "r" (pd));
}

static inline void
sti(void) {
    asm volatile ("sti");
  1018e9:	fb                   	sti    
}
  1018ea:	90                   	nop
    sti();
}
  1018eb:	90                   	nop
  1018ec:	5d                   	pop    %ebp
  1018ed:	c3                   	ret    

001018ee <intr_disable>:

/* intr_disable - disable irq interrupt */
void
intr_disable(void) {
  1018ee:	f3 0f 1e fb          	endbr32 
  1018f2:	55                   	push   %ebp
  1018f3:	89 e5                	mov    %esp,%ebp

static inline void
cli(void) {
    asm volatile ("cli");
  1018f5:	fa                   	cli    
}
  1018f6:	90                   	nop
    cli();
}
  1018f7:	90                   	nop
  1018f8:	5d                   	pop    %ebp
  1018f9:	c3                   	ret    

001018fa <print_ticks>:
#include <console.h>
#include <kdebug.h>

#define TICK_NUM 100

static void print_ticks() {
  1018fa:	f3 0f 1e fb          	endbr32 
  1018fe:	55                   	push   %ebp
  1018ff:	89 e5                	mov    %esp,%ebp
  101901:	83 ec 08             	sub    $0x8,%esp
    cprintf("%d ticks\n",TICK_NUM);
  101904:	83 ec 08             	sub    $0x8,%esp
  101907:	6a 64                	push   $0x64
  101909:	68 40 39 10 00       	push   $0x103940
  10190e:	e8 5c e9 ff ff       	call   10026f <cprintf>
  101913:	83 c4 10             	add    $0x10,%esp
#ifdef DEBUG_GRADE
    cprintf("End of Test.\n");
    panic("EOT: kernel seems ok.");
#endif
}
  101916:	90                   	nop
  101917:	c9                   	leave  
  101918:	c3                   	ret    

00101919 <idt_init>:
    sizeof(idt) - 1, (uintptr_t)idt
};

/* idt_init - initialize IDT to each of the entry points in kern/trap/vectors.S */
void
idt_init(void) {
  101919:	f3 0f 1e fb          	endbr32 
  10191d:	55                   	push   %ebp
  10191e:	89 e5                	mov    %esp,%ebp
  101920:	83 ec 10             	sub    $0x10,%esp
      *     You don't know the meaning of this instruction? just google it! and check the libs/x86.h to know more.
      *     Notice: the argument of lidt is idt_pd. try to find it!
      */
	
	extern uintptr_t __vectors[];
	for(int i=0; i < sizeof(idt)/sizeof(struct gatedesc); i++)
  101923:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  10192a:	e9 c3 00 00 00       	jmp    1019f2 <idt_init+0xd9>
	{
		SETGATE(idt[i], 0, GD_KTEXT, __vectors[i], DPL_KERNEL);
  10192f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101932:	8b 04 85 e0 f5 10 00 	mov    0x10f5e0(,%eax,4),%eax
  101939:	89 c2                	mov    %eax,%edx
  10193b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10193e:	66 89 14 c5 a0 00 11 	mov    %dx,0x1100a0(,%eax,8)
  101945:	00 
  101946:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101949:	66 c7 04 c5 a2 00 11 	movw   $0x8,0x1100a2(,%eax,8)
  101950:	00 08 00 
  101953:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101956:	0f b6 14 c5 a4 00 11 	movzbl 0x1100a4(,%eax,8),%edx
  10195d:	00 
  10195e:	83 e2 e0             	and    $0xffffffe0,%edx
  101961:	88 14 c5 a4 00 11 00 	mov    %dl,0x1100a4(,%eax,8)
  101968:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10196b:	0f b6 14 c5 a4 00 11 	movzbl 0x1100a4(,%eax,8),%edx
  101972:	00 
  101973:	83 e2 1f             	and    $0x1f,%edx
  101976:	88 14 c5 a4 00 11 00 	mov    %dl,0x1100a4(,%eax,8)
  10197d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101980:	0f b6 14 c5 a5 00 11 	movzbl 0x1100a5(,%eax,8),%edx
  101987:	00 
  101988:	83 e2 f0             	and    $0xfffffff0,%edx
  10198b:	83 ca 0e             	or     $0xe,%edx
  10198e:	88 14 c5 a5 00 11 00 	mov    %dl,0x1100a5(,%eax,8)
  101995:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101998:	0f b6 14 c5 a5 00 11 	movzbl 0x1100a5(,%eax,8),%edx
  10199f:	00 
  1019a0:	83 e2 ef             	and    $0xffffffef,%edx
  1019a3:	88 14 c5 a5 00 11 00 	mov    %dl,0x1100a5(,%eax,8)
  1019aa:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1019ad:	0f b6 14 c5 a5 00 11 	movzbl 0x1100a5(,%eax,8),%edx
  1019b4:	00 
  1019b5:	83 e2 9f             	and    $0xffffff9f,%edx
  1019b8:	88 14 c5 a5 00 11 00 	mov    %dl,0x1100a5(,%eax,8)
  1019bf:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1019c2:	0f b6 14 c5 a5 00 11 	movzbl 0x1100a5(,%eax,8),%edx
  1019c9:	00 
  1019ca:	83 ca 80             	or     $0xffffff80,%edx
  1019cd:	88 14 c5 a5 00 11 00 	mov    %dl,0x1100a5(,%eax,8)
  1019d4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1019d7:	8b 04 85 e0 f5 10 00 	mov    0x10f5e0(,%eax,4),%eax
  1019de:	c1 e8 10             	shr    $0x10,%eax
  1019e1:	89 c2                	mov    %eax,%edx
  1019e3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1019e6:	66 89 14 c5 a6 00 11 	mov    %dx,0x1100a6(,%eax,8)
  1019ed:	00 
	for(int i=0; i < sizeof(idt)/sizeof(struct gatedesc); i++)
  1019ee:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  1019f2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1019f5:	3d ff 00 00 00       	cmp    $0xff,%eax
  1019fa:	0f 86 2f ff ff ff    	jbe    10192f <idt_init+0x16>
	}
	SETGATE(idt[T_SWITCH_TOK], 0, GD_KTEXT, __vectors[T_SWITCH_TOK], DPL_USER);
  101a00:	a1 c4 f7 10 00       	mov    0x10f7c4,%eax
  101a05:	66 a3 68 04 11 00    	mov    %ax,0x110468
  101a0b:	66 c7 05 6a 04 11 00 	movw   $0x8,0x11046a
  101a12:	08 00 
  101a14:	0f b6 05 6c 04 11 00 	movzbl 0x11046c,%eax
  101a1b:	83 e0 e0             	and    $0xffffffe0,%eax
  101a1e:	a2 6c 04 11 00       	mov    %al,0x11046c
  101a23:	0f b6 05 6c 04 11 00 	movzbl 0x11046c,%eax
  101a2a:	83 e0 1f             	and    $0x1f,%eax
  101a2d:	a2 6c 04 11 00       	mov    %al,0x11046c
  101a32:	0f b6 05 6d 04 11 00 	movzbl 0x11046d,%eax
  101a39:	83 e0 f0             	and    $0xfffffff0,%eax
  101a3c:	83 c8 0e             	or     $0xe,%eax
  101a3f:	a2 6d 04 11 00       	mov    %al,0x11046d
  101a44:	0f b6 05 6d 04 11 00 	movzbl 0x11046d,%eax
  101a4b:	83 e0 ef             	and    $0xffffffef,%eax
  101a4e:	a2 6d 04 11 00       	mov    %al,0x11046d
  101a53:	0f b6 05 6d 04 11 00 	movzbl 0x11046d,%eax
  101a5a:	83 c8 60             	or     $0x60,%eax
  101a5d:	a2 6d 04 11 00       	mov    %al,0x11046d
  101a62:	0f b6 05 6d 04 11 00 	movzbl 0x11046d,%eax
  101a69:	83 c8 80             	or     $0xffffff80,%eax
  101a6c:	a2 6d 04 11 00       	mov    %al,0x11046d
  101a71:	a1 c4 f7 10 00       	mov    0x10f7c4,%eax
  101a76:	c1 e8 10             	shr    $0x10,%eax
  101a79:	66 a3 6e 04 11 00    	mov    %ax,0x11046e
  101a7f:	c7 45 f8 60 f5 10 00 	movl   $0x10f560,-0x8(%ebp)
    asm volatile ("lidt (%0)" :: "r" (pd));
  101a86:	8b 45 f8             	mov    -0x8(%ebp),%eax
  101a89:	0f 01 18             	lidtl  (%eax)
}
  101a8c:	90                   	nop
	lidt(&idt_pd);
}
  101a8d:	90                   	nop
  101a8e:	c9                   	leave  
  101a8f:	c3                   	ret    

00101a90 <trapname>:

static const char *
trapname(int trapno) {
  101a90:	f3 0f 1e fb          	endbr32 
  101a94:	55                   	push   %ebp
  101a95:	89 e5                	mov    %esp,%ebp
        "Alignment Check",
        "Machine-Check",
        "SIMD Floating-Point Exception"
    };

    if (trapno < sizeof(excnames)/sizeof(const char * const)) {
  101a97:	8b 45 08             	mov    0x8(%ebp),%eax
  101a9a:	83 f8 13             	cmp    $0x13,%eax
  101a9d:	77 0c                	ja     101aab <trapname+0x1b>
        return excnames[trapno];
  101a9f:	8b 45 08             	mov    0x8(%ebp),%eax
  101aa2:	8b 04 85 a0 3c 10 00 	mov    0x103ca0(,%eax,4),%eax
  101aa9:	eb 18                	jmp    101ac3 <trapname+0x33>
    }
    if (trapno >= IRQ_OFFSET && trapno < IRQ_OFFSET + 16) {
  101aab:	83 7d 08 1f          	cmpl   $0x1f,0x8(%ebp)
  101aaf:	7e 0d                	jle    101abe <trapname+0x2e>
  101ab1:	83 7d 08 2f          	cmpl   $0x2f,0x8(%ebp)
  101ab5:	7f 07                	jg     101abe <trapname+0x2e>
        return "Hardware Interrupt";
  101ab7:	b8 4a 39 10 00       	mov    $0x10394a,%eax
  101abc:	eb 05                	jmp    101ac3 <trapname+0x33>
    }
    return "(unknown trap)";
  101abe:	b8 5d 39 10 00       	mov    $0x10395d,%eax
}
  101ac3:	5d                   	pop    %ebp
  101ac4:	c3                   	ret    

00101ac5 <trap_in_kernel>:

/* trap_in_kernel - test if trap happened in kernel */
bool
trap_in_kernel(struct trapframe *tf) {
  101ac5:	f3 0f 1e fb          	endbr32 
  101ac9:	55                   	push   %ebp
  101aca:	89 e5                	mov    %esp,%ebp
    return (tf->tf_cs == (uint16_t)KERNEL_CS);
  101acc:	8b 45 08             	mov    0x8(%ebp),%eax
  101acf:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101ad3:	66 83 f8 08          	cmp    $0x8,%ax
  101ad7:	0f 94 c0             	sete   %al
  101ada:	0f b6 c0             	movzbl %al,%eax
}
  101add:	5d                   	pop    %ebp
  101ade:	c3                   	ret    

00101adf <print_trapframe>:
    "TF", "IF", "DF", "OF", NULL, NULL, "NT", NULL,
    "RF", "VM", "AC", "VIF", "VIP", "ID", NULL, NULL,
};

void
print_trapframe(struct trapframe *tf) {
  101adf:	f3 0f 1e fb          	endbr32 
  101ae3:	55                   	push   %ebp
  101ae4:	89 e5                	mov    %esp,%ebp
  101ae6:	83 ec 18             	sub    $0x18,%esp
    cprintf("trapframe at %p\n", tf);
  101ae9:	83 ec 08             	sub    $0x8,%esp
  101aec:	ff 75 08             	pushl  0x8(%ebp)
  101aef:	68 9e 39 10 00       	push   $0x10399e
  101af4:	e8 76 e7 ff ff       	call   10026f <cprintf>
  101af9:	83 c4 10             	add    $0x10,%esp
    print_regs(&tf->tf_regs);
  101afc:	8b 45 08             	mov    0x8(%ebp),%eax
  101aff:	83 ec 0c             	sub    $0xc,%esp
  101b02:	50                   	push   %eax
  101b03:	e8 b4 01 00 00       	call   101cbc <print_regs>
  101b08:	83 c4 10             	add    $0x10,%esp
    cprintf("  ds   0x----%04x\n", tf->tf_ds);
  101b0b:	8b 45 08             	mov    0x8(%ebp),%eax
  101b0e:	0f b7 40 2c          	movzwl 0x2c(%eax),%eax
  101b12:	0f b7 c0             	movzwl %ax,%eax
  101b15:	83 ec 08             	sub    $0x8,%esp
  101b18:	50                   	push   %eax
  101b19:	68 af 39 10 00       	push   $0x1039af
  101b1e:	e8 4c e7 ff ff       	call   10026f <cprintf>
  101b23:	83 c4 10             	add    $0x10,%esp
    cprintf("  es   0x----%04x\n", tf->tf_es);
  101b26:	8b 45 08             	mov    0x8(%ebp),%eax
  101b29:	0f b7 40 28          	movzwl 0x28(%eax),%eax
  101b2d:	0f b7 c0             	movzwl %ax,%eax
  101b30:	83 ec 08             	sub    $0x8,%esp
  101b33:	50                   	push   %eax
  101b34:	68 c2 39 10 00       	push   $0x1039c2
  101b39:	e8 31 e7 ff ff       	call   10026f <cprintf>
  101b3e:	83 c4 10             	add    $0x10,%esp
    cprintf("  fs   0x----%04x\n", tf->tf_fs);
  101b41:	8b 45 08             	mov    0x8(%ebp),%eax
  101b44:	0f b7 40 24          	movzwl 0x24(%eax),%eax
  101b48:	0f b7 c0             	movzwl %ax,%eax
  101b4b:	83 ec 08             	sub    $0x8,%esp
  101b4e:	50                   	push   %eax
  101b4f:	68 d5 39 10 00       	push   $0x1039d5
  101b54:	e8 16 e7 ff ff       	call   10026f <cprintf>
  101b59:	83 c4 10             	add    $0x10,%esp
    cprintf("  gs   0x----%04x\n", tf->tf_gs);
  101b5c:	8b 45 08             	mov    0x8(%ebp),%eax
  101b5f:	0f b7 40 20          	movzwl 0x20(%eax),%eax
  101b63:	0f b7 c0             	movzwl %ax,%eax
  101b66:	83 ec 08             	sub    $0x8,%esp
  101b69:	50                   	push   %eax
  101b6a:	68 e8 39 10 00       	push   $0x1039e8
  101b6f:	e8 fb e6 ff ff       	call   10026f <cprintf>
  101b74:	83 c4 10             	add    $0x10,%esp
    cprintf("  trap 0x%08x %s\n", tf->tf_trapno, trapname(tf->tf_trapno));
  101b77:	8b 45 08             	mov    0x8(%ebp),%eax
  101b7a:	8b 40 30             	mov    0x30(%eax),%eax
  101b7d:	83 ec 0c             	sub    $0xc,%esp
  101b80:	50                   	push   %eax
  101b81:	e8 0a ff ff ff       	call   101a90 <trapname>
  101b86:	83 c4 10             	add    $0x10,%esp
  101b89:	8b 55 08             	mov    0x8(%ebp),%edx
  101b8c:	8b 52 30             	mov    0x30(%edx),%edx
  101b8f:	83 ec 04             	sub    $0x4,%esp
  101b92:	50                   	push   %eax
  101b93:	52                   	push   %edx
  101b94:	68 fb 39 10 00       	push   $0x1039fb
  101b99:	e8 d1 e6 ff ff       	call   10026f <cprintf>
  101b9e:	83 c4 10             	add    $0x10,%esp
    cprintf("  err  0x%08x\n", tf->tf_err);
  101ba1:	8b 45 08             	mov    0x8(%ebp),%eax
  101ba4:	8b 40 34             	mov    0x34(%eax),%eax
  101ba7:	83 ec 08             	sub    $0x8,%esp
  101baa:	50                   	push   %eax
  101bab:	68 0d 3a 10 00       	push   $0x103a0d
  101bb0:	e8 ba e6 ff ff       	call   10026f <cprintf>
  101bb5:	83 c4 10             	add    $0x10,%esp
    cprintf("  eip  0x%08x\n", tf->tf_eip);
  101bb8:	8b 45 08             	mov    0x8(%ebp),%eax
  101bbb:	8b 40 38             	mov    0x38(%eax),%eax
  101bbe:	83 ec 08             	sub    $0x8,%esp
  101bc1:	50                   	push   %eax
  101bc2:	68 1c 3a 10 00       	push   $0x103a1c
  101bc7:	e8 a3 e6 ff ff       	call   10026f <cprintf>
  101bcc:	83 c4 10             	add    $0x10,%esp
    cprintf("  cs   0x----%04x\n", tf->tf_cs);
  101bcf:	8b 45 08             	mov    0x8(%ebp),%eax
  101bd2:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101bd6:	0f b7 c0             	movzwl %ax,%eax
  101bd9:	83 ec 08             	sub    $0x8,%esp
  101bdc:	50                   	push   %eax
  101bdd:	68 2b 3a 10 00       	push   $0x103a2b
  101be2:	e8 88 e6 ff ff       	call   10026f <cprintf>
  101be7:	83 c4 10             	add    $0x10,%esp
    cprintf("  flag 0x%08x ", tf->tf_eflags);
  101bea:	8b 45 08             	mov    0x8(%ebp),%eax
  101bed:	8b 40 40             	mov    0x40(%eax),%eax
  101bf0:	83 ec 08             	sub    $0x8,%esp
  101bf3:	50                   	push   %eax
  101bf4:	68 3e 3a 10 00       	push   $0x103a3e
  101bf9:	e8 71 e6 ff ff       	call   10026f <cprintf>
  101bfe:	83 c4 10             	add    $0x10,%esp

    int i, j;
    for (i = 0, j = 1; i < sizeof(IA32flags) / sizeof(IA32flags[0]); i ++, j <<= 1) {
  101c01:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  101c08:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
  101c0f:	eb 3f                	jmp    101c50 <print_trapframe+0x171>
        if ((tf->tf_eflags & j) && IA32flags[i] != NULL) {
  101c11:	8b 45 08             	mov    0x8(%ebp),%eax
  101c14:	8b 50 40             	mov    0x40(%eax),%edx
  101c17:	8b 45 f0             	mov    -0x10(%ebp),%eax
  101c1a:	21 d0                	and    %edx,%eax
  101c1c:	85 c0                	test   %eax,%eax
  101c1e:	74 29                	je     101c49 <print_trapframe+0x16a>
  101c20:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101c23:	8b 04 85 80 f5 10 00 	mov    0x10f580(,%eax,4),%eax
  101c2a:	85 c0                	test   %eax,%eax
  101c2c:	74 1b                	je     101c49 <print_trapframe+0x16a>
            cprintf("%s,", IA32flags[i]);
  101c2e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101c31:	8b 04 85 80 f5 10 00 	mov    0x10f580(,%eax,4),%eax
  101c38:	83 ec 08             	sub    $0x8,%esp
  101c3b:	50                   	push   %eax
  101c3c:	68 4d 3a 10 00       	push   $0x103a4d
  101c41:	e8 29 e6 ff ff       	call   10026f <cprintf>
  101c46:	83 c4 10             	add    $0x10,%esp
    for (i = 0, j = 1; i < sizeof(IA32flags) / sizeof(IA32flags[0]); i ++, j <<= 1) {
  101c49:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  101c4d:	d1 65 f0             	shll   -0x10(%ebp)
  101c50:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101c53:	83 f8 17             	cmp    $0x17,%eax
  101c56:	76 b9                	jbe    101c11 <print_trapframe+0x132>
        }
    }
    cprintf("IOPL=%d\n", (tf->tf_eflags & FL_IOPL_MASK) >> 12);
  101c58:	8b 45 08             	mov    0x8(%ebp),%eax
  101c5b:	8b 40 40             	mov    0x40(%eax),%eax
  101c5e:	c1 e8 0c             	shr    $0xc,%eax
  101c61:	83 e0 03             	and    $0x3,%eax
  101c64:	83 ec 08             	sub    $0x8,%esp
  101c67:	50                   	push   %eax
  101c68:	68 51 3a 10 00       	push   $0x103a51
  101c6d:	e8 fd e5 ff ff       	call   10026f <cprintf>
  101c72:	83 c4 10             	add    $0x10,%esp

    if (!trap_in_kernel(tf)) {
  101c75:	83 ec 0c             	sub    $0xc,%esp
  101c78:	ff 75 08             	pushl  0x8(%ebp)
  101c7b:	e8 45 fe ff ff       	call   101ac5 <trap_in_kernel>
  101c80:	83 c4 10             	add    $0x10,%esp
  101c83:	85 c0                	test   %eax,%eax
  101c85:	75 32                	jne    101cb9 <print_trapframe+0x1da>
        cprintf("  esp  0x%08x\n", tf->tf_esp);
  101c87:	8b 45 08             	mov    0x8(%ebp),%eax
  101c8a:	8b 40 44             	mov    0x44(%eax),%eax
  101c8d:	83 ec 08             	sub    $0x8,%esp
  101c90:	50                   	push   %eax
  101c91:	68 5a 3a 10 00       	push   $0x103a5a
  101c96:	e8 d4 e5 ff ff       	call   10026f <cprintf>
  101c9b:	83 c4 10             	add    $0x10,%esp
        cprintf("  ss   0x----%04x\n", tf->tf_ss);
  101c9e:	8b 45 08             	mov    0x8(%ebp),%eax
  101ca1:	0f b7 40 48          	movzwl 0x48(%eax),%eax
  101ca5:	0f b7 c0             	movzwl %ax,%eax
  101ca8:	83 ec 08             	sub    $0x8,%esp
  101cab:	50                   	push   %eax
  101cac:	68 69 3a 10 00       	push   $0x103a69
  101cb1:	e8 b9 e5 ff ff       	call   10026f <cprintf>
  101cb6:	83 c4 10             	add    $0x10,%esp
    }
}
  101cb9:	90                   	nop
  101cba:	c9                   	leave  
  101cbb:	c3                   	ret    

00101cbc <print_regs>:

void
print_regs(struct pushregs *regs) {
  101cbc:	f3 0f 1e fb          	endbr32 
  101cc0:	55                   	push   %ebp
  101cc1:	89 e5                	mov    %esp,%ebp
  101cc3:	83 ec 08             	sub    $0x8,%esp
    cprintf("  edi  0x%08x\n", regs->reg_edi);
  101cc6:	8b 45 08             	mov    0x8(%ebp),%eax
  101cc9:	8b 00                	mov    (%eax),%eax
  101ccb:	83 ec 08             	sub    $0x8,%esp
  101cce:	50                   	push   %eax
  101ccf:	68 7c 3a 10 00       	push   $0x103a7c
  101cd4:	e8 96 e5 ff ff       	call   10026f <cprintf>
  101cd9:	83 c4 10             	add    $0x10,%esp
    cprintf("  esi  0x%08x\n", regs->reg_esi);
  101cdc:	8b 45 08             	mov    0x8(%ebp),%eax
  101cdf:	8b 40 04             	mov    0x4(%eax),%eax
  101ce2:	83 ec 08             	sub    $0x8,%esp
  101ce5:	50                   	push   %eax
  101ce6:	68 8b 3a 10 00       	push   $0x103a8b
  101ceb:	e8 7f e5 ff ff       	call   10026f <cprintf>
  101cf0:	83 c4 10             	add    $0x10,%esp
    cprintf("  ebp  0x%08x\n", regs->reg_ebp);
  101cf3:	8b 45 08             	mov    0x8(%ebp),%eax
  101cf6:	8b 40 08             	mov    0x8(%eax),%eax
  101cf9:	83 ec 08             	sub    $0x8,%esp
  101cfc:	50                   	push   %eax
  101cfd:	68 9a 3a 10 00       	push   $0x103a9a
  101d02:	e8 68 e5 ff ff       	call   10026f <cprintf>
  101d07:	83 c4 10             	add    $0x10,%esp
    cprintf("  oesp 0x%08x\n", regs->reg_oesp);
  101d0a:	8b 45 08             	mov    0x8(%ebp),%eax
  101d0d:	8b 40 0c             	mov    0xc(%eax),%eax
  101d10:	83 ec 08             	sub    $0x8,%esp
  101d13:	50                   	push   %eax
  101d14:	68 a9 3a 10 00       	push   $0x103aa9
  101d19:	e8 51 e5 ff ff       	call   10026f <cprintf>
  101d1e:	83 c4 10             	add    $0x10,%esp
    cprintf("  ebx  0x%08x\n", regs->reg_ebx);
  101d21:	8b 45 08             	mov    0x8(%ebp),%eax
  101d24:	8b 40 10             	mov    0x10(%eax),%eax
  101d27:	83 ec 08             	sub    $0x8,%esp
  101d2a:	50                   	push   %eax
  101d2b:	68 b8 3a 10 00       	push   $0x103ab8
  101d30:	e8 3a e5 ff ff       	call   10026f <cprintf>
  101d35:	83 c4 10             	add    $0x10,%esp
    cprintf("  edx  0x%08x\n", regs->reg_edx);
  101d38:	8b 45 08             	mov    0x8(%ebp),%eax
  101d3b:	8b 40 14             	mov    0x14(%eax),%eax
  101d3e:	83 ec 08             	sub    $0x8,%esp
  101d41:	50                   	push   %eax
  101d42:	68 c7 3a 10 00       	push   $0x103ac7
  101d47:	e8 23 e5 ff ff       	call   10026f <cprintf>
  101d4c:	83 c4 10             	add    $0x10,%esp
    cprintf("  ecx  0x%08x\n", regs->reg_ecx);
  101d4f:	8b 45 08             	mov    0x8(%ebp),%eax
  101d52:	8b 40 18             	mov    0x18(%eax),%eax
  101d55:	83 ec 08             	sub    $0x8,%esp
  101d58:	50                   	push   %eax
  101d59:	68 d6 3a 10 00       	push   $0x103ad6
  101d5e:	e8 0c e5 ff ff       	call   10026f <cprintf>
  101d63:	83 c4 10             	add    $0x10,%esp
    cprintf("  eax  0x%08x\n", regs->reg_eax);
  101d66:	8b 45 08             	mov    0x8(%ebp),%eax
  101d69:	8b 40 1c             	mov    0x1c(%eax),%eax
  101d6c:	83 ec 08             	sub    $0x8,%esp
  101d6f:	50                   	push   %eax
  101d70:	68 e5 3a 10 00       	push   $0x103ae5
  101d75:	e8 f5 e4 ff ff       	call   10026f <cprintf>
  101d7a:	83 c4 10             	add    $0x10,%esp
}
  101d7d:	90                   	nop
  101d7e:	c9                   	leave  
  101d7f:	c3                   	ret    

00101d80 <trap_dispatch>:

/* trap_dispatch - dispatch based on what type of trap occurred */
static void
trap_dispatch(struct trapframe *tf) {
  101d80:	f3 0f 1e fb          	endbr32 
  101d84:	55                   	push   %ebp
  101d85:	89 e5                	mov    %esp,%ebp
  101d87:	83 ec 18             	sub    $0x18,%esp
    char c;

    switch (tf->tf_trapno) {
  101d8a:	8b 45 08             	mov    0x8(%ebp),%eax
  101d8d:	8b 40 30             	mov    0x30(%eax),%eax
  101d90:	83 f8 79             	cmp    $0x79,%eax
  101d93:	0f 87 d1 00 00 00    	ja     101e6a <trap_dispatch+0xea>
  101d99:	83 f8 78             	cmp    $0x78,%eax
  101d9c:	0f 83 b1 00 00 00    	jae    101e53 <trap_dispatch+0xd3>
  101da2:	83 f8 2f             	cmp    $0x2f,%eax
  101da5:	0f 87 bf 00 00 00    	ja     101e6a <trap_dispatch+0xea>
  101dab:	83 f8 2e             	cmp    $0x2e,%eax
  101dae:	0f 83 ec 00 00 00    	jae    101ea0 <trap_dispatch+0x120>
  101db4:	83 f8 24             	cmp    $0x24,%eax
  101db7:	74 52                	je     101e0b <trap_dispatch+0x8b>
  101db9:	83 f8 24             	cmp    $0x24,%eax
  101dbc:	0f 87 a8 00 00 00    	ja     101e6a <trap_dispatch+0xea>
  101dc2:	83 f8 20             	cmp    $0x20,%eax
  101dc5:	74 0a                	je     101dd1 <trap_dispatch+0x51>
  101dc7:	83 f8 21             	cmp    $0x21,%eax
  101dca:	74 63                	je     101e2f <trap_dispatch+0xaf>
  101dcc:	e9 99 00 00 00       	jmp    101e6a <trap_dispatch+0xea>
        /* handle the timer interrupt */
        /* (1) After a timer interrupt, you should record this event using a global variable (increase it), such as ticks in kern/driver/clock.c
         * (2) Every TICK_NUM cycle, you can print some info using a funciton, such as print_ticks().
         * (3) Too Simple? Yes, I think so!
         */
	ticks++;
  101dd1:	a1 08 09 11 00       	mov    0x110908,%eax
  101dd6:	83 c0 01             	add    $0x1,%eax
  101dd9:	a3 08 09 11 00       	mov    %eax,0x110908
	if(ticks%TICK_NUM==0){
  101dde:	8b 0d 08 09 11 00    	mov    0x110908,%ecx
  101de4:	ba 1f 85 eb 51       	mov    $0x51eb851f,%edx
  101de9:	89 c8                	mov    %ecx,%eax
  101deb:	f7 e2                	mul    %edx
  101ded:	89 d0                	mov    %edx,%eax
  101def:	c1 e8 05             	shr    $0x5,%eax
  101df2:	6b c0 64             	imul   $0x64,%eax,%eax
  101df5:	29 c1                	sub    %eax,%ecx
  101df7:	89 c8                	mov    %ecx,%eax
  101df9:	85 c0                	test   %eax,%eax
  101dfb:	0f 85 a2 00 00 00    	jne    101ea3 <trap_dispatch+0x123>
		print_ticks();
  101e01:	e8 f4 fa ff ff       	call   1018fa <print_ticks>
	}
        break;
  101e06:	e9 98 00 00 00       	jmp    101ea3 <trap_dispatch+0x123>
    case IRQ_OFFSET + IRQ_COM1:
        c = cons_getc();
  101e0b:	e8 93 f8 ff ff       	call   1016a3 <cons_getc>
  101e10:	88 45 f7             	mov    %al,-0x9(%ebp)
        cprintf("serial [%03d] %c\n", c, c);
  101e13:	0f be 55 f7          	movsbl -0x9(%ebp),%edx
  101e17:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  101e1b:	83 ec 04             	sub    $0x4,%esp
  101e1e:	52                   	push   %edx
  101e1f:	50                   	push   %eax
  101e20:	68 f4 3a 10 00       	push   $0x103af4
  101e25:	e8 45 e4 ff ff       	call   10026f <cprintf>
  101e2a:	83 c4 10             	add    $0x10,%esp
        break;
  101e2d:	eb 75                	jmp    101ea4 <trap_dispatch+0x124>
    case IRQ_OFFSET + IRQ_KBD:
        c = cons_getc();
  101e2f:	e8 6f f8 ff ff       	call   1016a3 <cons_getc>
  101e34:	88 45 f7             	mov    %al,-0x9(%ebp)
        cprintf("kbd [%03d] %c\n", c, c);
  101e37:	0f be 55 f7          	movsbl -0x9(%ebp),%edx
  101e3b:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  101e3f:	83 ec 04             	sub    $0x4,%esp
  101e42:	52                   	push   %edx
  101e43:	50                   	push   %eax
  101e44:	68 06 3b 10 00       	push   $0x103b06
  101e49:	e8 21 e4 ff ff       	call   10026f <cprintf>
  101e4e:	83 c4 10             	add    $0x10,%esp
        break;
  101e51:	eb 51                	jmp    101ea4 <trap_dispatch+0x124>
    //LAB1 CHALLENGE 1 : YOUR CODE you should modify below codes.
    case T_SWITCH_TOU:
    case T_SWITCH_TOK:
        panic("T_SWITCH_** ??\n");
  101e53:	83 ec 04             	sub    $0x4,%esp
  101e56:	68 15 3b 10 00       	push   $0x103b15
  101e5b:	68 ae 00 00 00       	push   $0xae
  101e60:	68 25 3b 10 00       	push   $0x103b25
  101e65:	e8 80 e5 ff ff       	call   1003ea <__panic>
    case IRQ_OFFSET + IRQ_IDE2:
        /* do nothing */
        break;
    default:
        // in kernel, it must be a mistake
        if ((tf->tf_cs & 3) == 0) {
  101e6a:	8b 45 08             	mov    0x8(%ebp),%eax
  101e6d:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101e71:	0f b7 c0             	movzwl %ax,%eax
  101e74:	83 e0 03             	and    $0x3,%eax
  101e77:	85 c0                	test   %eax,%eax
  101e79:	75 29                	jne    101ea4 <trap_dispatch+0x124>
            print_trapframe(tf);
  101e7b:	83 ec 0c             	sub    $0xc,%esp
  101e7e:	ff 75 08             	pushl  0x8(%ebp)
  101e81:	e8 59 fc ff ff       	call   101adf <print_trapframe>
  101e86:	83 c4 10             	add    $0x10,%esp
            panic("unexpected trap in kernel.\n");
  101e89:	83 ec 04             	sub    $0x4,%esp
  101e8c:	68 36 3b 10 00       	push   $0x103b36
  101e91:	68 b8 00 00 00       	push   $0xb8
  101e96:	68 25 3b 10 00       	push   $0x103b25
  101e9b:	e8 4a e5 ff ff       	call   1003ea <__panic>
        break;
  101ea0:	90                   	nop
  101ea1:	eb 01                	jmp    101ea4 <trap_dispatch+0x124>
        break;
  101ea3:	90                   	nop
        }
    }
}
  101ea4:	90                   	nop
  101ea5:	c9                   	leave  
  101ea6:	c3                   	ret    

00101ea7 <trap>:
 * trap - handles or dispatches an exception/interrupt. if and when trap() returns,
 * the code in kern/trap/trapentry.S restores the old CPU state saved in the
 * trapframe and then uses the iret instruction to return from the exception.
 * */
void
trap(struct trapframe *tf) {
  101ea7:	f3 0f 1e fb          	endbr32 
  101eab:	55                   	push   %ebp
  101eac:	89 e5                	mov    %esp,%ebp
  101eae:	83 ec 08             	sub    $0x8,%esp
    // dispatch based on what type of trap occurred
    trap_dispatch(tf);
  101eb1:	83 ec 0c             	sub    $0xc,%esp
  101eb4:	ff 75 08             	pushl  0x8(%ebp)
  101eb7:	e8 c4 fe ff ff       	call   101d80 <trap_dispatch>
  101ebc:	83 c4 10             	add    $0x10,%esp
}
  101ebf:	90                   	nop
  101ec0:	c9                   	leave  
  101ec1:	c3                   	ret    

00101ec2 <vector0>:
# handler
.text
.globl __alltraps
.globl vector0
vector0:
  pushl $0
  101ec2:	6a 00                	push   $0x0
  pushl $0
  101ec4:	6a 00                	push   $0x0
  jmp __alltraps
  101ec6:	e9 67 0a 00 00       	jmp    102932 <__alltraps>

00101ecb <vector1>:
.globl vector1
vector1:
  pushl $0
  101ecb:	6a 00                	push   $0x0
  pushl $1
  101ecd:	6a 01                	push   $0x1
  jmp __alltraps
  101ecf:	e9 5e 0a 00 00       	jmp    102932 <__alltraps>

00101ed4 <vector2>:
.globl vector2
vector2:
  pushl $0
  101ed4:	6a 00                	push   $0x0
  pushl $2
  101ed6:	6a 02                	push   $0x2
  jmp __alltraps
  101ed8:	e9 55 0a 00 00       	jmp    102932 <__alltraps>

00101edd <vector3>:
.globl vector3
vector3:
  pushl $0
  101edd:	6a 00                	push   $0x0
  pushl $3
  101edf:	6a 03                	push   $0x3
  jmp __alltraps
  101ee1:	e9 4c 0a 00 00       	jmp    102932 <__alltraps>

00101ee6 <vector4>:
.globl vector4
vector4:
  pushl $0
  101ee6:	6a 00                	push   $0x0
  pushl $4
  101ee8:	6a 04                	push   $0x4
  jmp __alltraps
  101eea:	e9 43 0a 00 00       	jmp    102932 <__alltraps>

00101eef <vector5>:
.globl vector5
vector5:
  pushl $0
  101eef:	6a 00                	push   $0x0
  pushl $5
  101ef1:	6a 05                	push   $0x5
  jmp __alltraps
  101ef3:	e9 3a 0a 00 00       	jmp    102932 <__alltraps>

00101ef8 <vector6>:
.globl vector6
vector6:
  pushl $0
  101ef8:	6a 00                	push   $0x0
  pushl $6
  101efa:	6a 06                	push   $0x6
  jmp __alltraps
  101efc:	e9 31 0a 00 00       	jmp    102932 <__alltraps>

00101f01 <vector7>:
.globl vector7
vector7:
  pushl $0
  101f01:	6a 00                	push   $0x0
  pushl $7
  101f03:	6a 07                	push   $0x7
  jmp __alltraps
  101f05:	e9 28 0a 00 00       	jmp    102932 <__alltraps>

00101f0a <vector8>:
.globl vector8
vector8:
  pushl $8
  101f0a:	6a 08                	push   $0x8
  jmp __alltraps
  101f0c:	e9 21 0a 00 00       	jmp    102932 <__alltraps>

00101f11 <vector9>:
.globl vector9
vector9:
  pushl $9
  101f11:	6a 09                	push   $0x9
  jmp __alltraps
  101f13:	e9 1a 0a 00 00       	jmp    102932 <__alltraps>

00101f18 <vector10>:
.globl vector10
vector10:
  pushl $10
  101f18:	6a 0a                	push   $0xa
  jmp __alltraps
  101f1a:	e9 13 0a 00 00       	jmp    102932 <__alltraps>

00101f1f <vector11>:
.globl vector11
vector11:
  pushl $11
  101f1f:	6a 0b                	push   $0xb
  jmp __alltraps
  101f21:	e9 0c 0a 00 00       	jmp    102932 <__alltraps>

00101f26 <vector12>:
.globl vector12
vector12:
  pushl $12
  101f26:	6a 0c                	push   $0xc
  jmp __alltraps
  101f28:	e9 05 0a 00 00       	jmp    102932 <__alltraps>

00101f2d <vector13>:
.globl vector13
vector13:
  pushl $13
  101f2d:	6a 0d                	push   $0xd
  jmp __alltraps
  101f2f:	e9 fe 09 00 00       	jmp    102932 <__alltraps>

00101f34 <vector14>:
.globl vector14
vector14:
  pushl $14
  101f34:	6a 0e                	push   $0xe
  jmp __alltraps
  101f36:	e9 f7 09 00 00       	jmp    102932 <__alltraps>

00101f3b <vector15>:
.globl vector15
vector15:
  pushl $0
  101f3b:	6a 00                	push   $0x0
  pushl $15
  101f3d:	6a 0f                	push   $0xf
  jmp __alltraps
  101f3f:	e9 ee 09 00 00       	jmp    102932 <__alltraps>

00101f44 <vector16>:
.globl vector16
vector16:
  pushl $0
  101f44:	6a 00                	push   $0x0
  pushl $16
  101f46:	6a 10                	push   $0x10
  jmp __alltraps
  101f48:	e9 e5 09 00 00       	jmp    102932 <__alltraps>

00101f4d <vector17>:
.globl vector17
vector17:
  pushl $17
  101f4d:	6a 11                	push   $0x11
  jmp __alltraps
  101f4f:	e9 de 09 00 00       	jmp    102932 <__alltraps>

00101f54 <vector18>:
.globl vector18
vector18:
  pushl $0
  101f54:	6a 00                	push   $0x0
  pushl $18
  101f56:	6a 12                	push   $0x12
  jmp __alltraps
  101f58:	e9 d5 09 00 00       	jmp    102932 <__alltraps>

00101f5d <vector19>:
.globl vector19
vector19:
  pushl $0
  101f5d:	6a 00                	push   $0x0
  pushl $19
  101f5f:	6a 13                	push   $0x13
  jmp __alltraps
  101f61:	e9 cc 09 00 00       	jmp    102932 <__alltraps>

00101f66 <vector20>:
.globl vector20
vector20:
  pushl $0
  101f66:	6a 00                	push   $0x0
  pushl $20
  101f68:	6a 14                	push   $0x14
  jmp __alltraps
  101f6a:	e9 c3 09 00 00       	jmp    102932 <__alltraps>

00101f6f <vector21>:
.globl vector21
vector21:
  pushl $0
  101f6f:	6a 00                	push   $0x0
  pushl $21
  101f71:	6a 15                	push   $0x15
  jmp __alltraps
  101f73:	e9 ba 09 00 00       	jmp    102932 <__alltraps>

00101f78 <vector22>:
.globl vector22
vector22:
  pushl $0
  101f78:	6a 00                	push   $0x0
  pushl $22
  101f7a:	6a 16                	push   $0x16
  jmp __alltraps
  101f7c:	e9 b1 09 00 00       	jmp    102932 <__alltraps>

00101f81 <vector23>:
.globl vector23
vector23:
  pushl $0
  101f81:	6a 00                	push   $0x0
  pushl $23
  101f83:	6a 17                	push   $0x17
  jmp __alltraps
  101f85:	e9 a8 09 00 00       	jmp    102932 <__alltraps>

00101f8a <vector24>:
.globl vector24
vector24:
  pushl $0
  101f8a:	6a 00                	push   $0x0
  pushl $24
  101f8c:	6a 18                	push   $0x18
  jmp __alltraps
  101f8e:	e9 9f 09 00 00       	jmp    102932 <__alltraps>

00101f93 <vector25>:
.globl vector25
vector25:
  pushl $0
  101f93:	6a 00                	push   $0x0
  pushl $25
  101f95:	6a 19                	push   $0x19
  jmp __alltraps
  101f97:	e9 96 09 00 00       	jmp    102932 <__alltraps>

00101f9c <vector26>:
.globl vector26
vector26:
  pushl $0
  101f9c:	6a 00                	push   $0x0
  pushl $26
  101f9e:	6a 1a                	push   $0x1a
  jmp __alltraps
  101fa0:	e9 8d 09 00 00       	jmp    102932 <__alltraps>

00101fa5 <vector27>:
.globl vector27
vector27:
  pushl $0
  101fa5:	6a 00                	push   $0x0
  pushl $27
  101fa7:	6a 1b                	push   $0x1b
  jmp __alltraps
  101fa9:	e9 84 09 00 00       	jmp    102932 <__alltraps>

00101fae <vector28>:
.globl vector28
vector28:
  pushl $0
  101fae:	6a 00                	push   $0x0
  pushl $28
  101fb0:	6a 1c                	push   $0x1c
  jmp __alltraps
  101fb2:	e9 7b 09 00 00       	jmp    102932 <__alltraps>

00101fb7 <vector29>:
.globl vector29
vector29:
  pushl $0
  101fb7:	6a 00                	push   $0x0
  pushl $29
  101fb9:	6a 1d                	push   $0x1d
  jmp __alltraps
  101fbb:	e9 72 09 00 00       	jmp    102932 <__alltraps>

00101fc0 <vector30>:
.globl vector30
vector30:
  pushl $0
  101fc0:	6a 00                	push   $0x0
  pushl $30
  101fc2:	6a 1e                	push   $0x1e
  jmp __alltraps
  101fc4:	e9 69 09 00 00       	jmp    102932 <__alltraps>

00101fc9 <vector31>:
.globl vector31
vector31:
  pushl $0
  101fc9:	6a 00                	push   $0x0
  pushl $31
  101fcb:	6a 1f                	push   $0x1f
  jmp __alltraps
  101fcd:	e9 60 09 00 00       	jmp    102932 <__alltraps>

00101fd2 <vector32>:
.globl vector32
vector32:
  pushl $0
  101fd2:	6a 00                	push   $0x0
  pushl $32
  101fd4:	6a 20                	push   $0x20
  jmp __alltraps
  101fd6:	e9 57 09 00 00       	jmp    102932 <__alltraps>

00101fdb <vector33>:
.globl vector33
vector33:
  pushl $0
  101fdb:	6a 00                	push   $0x0
  pushl $33
  101fdd:	6a 21                	push   $0x21
  jmp __alltraps
  101fdf:	e9 4e 09 00 00       	jmp    102932 <__alltraps>

00101fe4 <vector34>:
.globl vector34
vector34:
  pushl $0
  101fe4:	6a 00                	push   $0x0
  pushl $34
  101fe6:	6a 22                	push   $0x22
  jmp __alltraps
  101fe8:	e9 45 09 00 00       	jmp    102932 <__alltraps>

00101fed <vector35>:
.globl vector35
vector35:
  pushl $0
  101fed:	6a 00                	push   $0x0
  pushl $35
  101fef:	6a 23                	push   $0x23
  jmp __alltraps
  101ff1:	e9 3c 09 00 00       	jmp    102932 <__alltraps>

00101ff6 <vector36>:
.globl vector36
vector36:
  pushl $0
  101ff6:	6a 00                	push   $0x0
  pushl $36
  101ff8:	6a 24                	push   $0x24
  jmp __alltraps
  101ffa:	e9 33 09 00 00       	jmp    102932 <__alltraps>

00101fff <vector37>:
.globl vector37
vector37:
  pushl $0
  101fff:	6a 00                	push   $0x0
  pushl $37
  102001:	6a 25                	push   $0x25
  jmp __alltraps
  102003:	e9 2a 09 00 00       	jmp    102932 <__alltraps>

00102008 <vector38>:
.globl vector38
vector38:
  pushl $0
  102008:	6a 00                	push   $0x0
  pushl $38
  10200a:	6a 26                	push   $0x26
  jmp __alltraps
  10200c:	e9 21 09 00 00       	jmp    102932 <__alltraps>

00102011 <vector39>:
.globl vector39
vector39:
  pushl $0
  102011:	6a 00                	push   $0x0
  pushl $39
  102013:	6a 27                	push   $0x27
  jmp __alltraps
  102015:	e9 18 09 00 00       	jmp    102932 <__alltraps>

0010201a <vector40>:
.globl vector40
vector40:
  pushl $0
  10201a:	6a 00                	push   $0x0
  pushl $40
  10201c:	6a 28                	push   $0x28
  jmp __alltraps
  10201e:	e9 0f 09 00 00       	jmp    102932 <__alltraps>

00102023 <vector41>:
.globl vector41
vector41:
  pushl $0
  102023:	6a 00                	push   $0x0
  pushl $41
  102025:	6a 29                	push   $0x29
  jmp __alltraps
  102027:	e9 06 09 00 00       	jmp    102932 <__alltraps>

0010202c <vector42>:
.globl vector42
vector42:
  pushl $0
  10202c:	6a 00                	push   $0x0
  pushl $42
  10202e:	6a 2a                	push   $0x2a
  jmp __alltraps
  102030:	e9 fd 08 00 00       	jmp    102932 <__alltraps>

00102035 <vector43>:
.globl vector43
vector43:
  pushl $0
  102035:	6a 00                	push   $0x0
  pushl $43
  102037:	6a 2b                	push   $0x2b
  jmp __alltraps
  102039:	e9 f4 08 00 00       	jmp    102932 <__alltraps>

0010203e <vector44>:
.globl vector44
vector44:
  pushl $0
  10203e:	6a 00                	push   $0x0
  pushl $44
  102040:	6a 2c                	push   $0x2c
  jmp __alltraps
  102042:	e9 eb 08 00 00       	jmp    102932 <__alltraps>

00102047 <vector45>:
.globl vector45
vector45:
  pushl $0
  102047:	6a 00                	push   $0x0
  pushl $45
  102049:	6a 2d                	push   $0x2d
  jmp __alltraps
  10204b:	e9 e2 08 00 00       	jmp    102932 <__alltraps>

00102050 <vector46>:
.globl vector46
vector46:
  pushl $0
  102050:	6a 00                	push   $0x0
  pushl $46
  102052:	6a 2e                	push   $0x2e
  jmp __alltraps
  102054:	e9 d9 08 00 00       	jmp    102932 <__alltraps>

00102059 <vector47>:
.globl vector47
vector47:
  pushl $0
  102059:	6a 00                	push   $0x0
  pushl $47
  10205b:	6a 2f                	push   $0x2f
  jmp __alltraps
  10205d:	e9 d0 08 00 00       	jmp    102932 <__alltraps>

00102062 <vector48>:
.globl vector48
vector48:
  pushl $0
  102062:	6a 00                	push   $0x0
  pushl $48
  102064:	6a 30                	push   $0x30
  jmp __alltraps
  102066:	e9 c7 08 00 00       	jmp    102932 <__alltraps>

0010206b <vector49>:
.globl vector49
vector49:
  pushl $0
  10206b:	6a 00                	push   $0x0
  pushl $49
  10206d:	6a 31                	push   $0x31
  jmp __alltraps
  10206f:	e9 be 08 00 00       	jmp    102932 <__alltraps>

00102074 <vector50>:
.globl vector50
vector50:
  pushl $0
  102074:	6a 00                	push   $0x0
  pushl $50
  102076:	6a 32                	push   $0x32
  jmp __alltraps
  102078:	e9 b5 08 00 00       	jmp    102932 <__alltraps>

0010207d <vector51>:
.globl vector51
vector51:
  pushl $0
  10207d:	6a 00                	push   $0x0
  pushl $51
  10207f:	6a 33                	push   $0x33
  jmp __alltraps
  102081:	e9 ac 08 00 00       	jmp    102932 <__alltraps>

00102086 <vector52>:
.globl vector52
vector52:
  pushl $0
  102086:	6a 00                	push   $0x0
  pushl $52
  102088:	6a 34                	push   $0x34
  jmp __alltraps
  10208a:	e9 a3 08 00 00       	jmp    102932 <__alltraps>

0010208f <vector53>:
.globl vector53
vector53:
  pushl $0
  10208f:	6a 00                	push   $0x0
  pushl $53
  102091:	6a 35                	push   $0x35
  jmp __alltraps
  102093:	e9 9a 08 00 00       	jmp    102932 <__alltraps>

00102098 <vector54>:
.globl vector54
vector54:
  pushl $0
  102098:	6a 00                	push   $0x0
  pushl $54
  10209a:	6a 36                	push   $0x36
  jmp __alltraps
  10209c:	e9 91 08 00 00       	jmp    102932 <__alltraps>

001020a1 <vector55>:
.globl vector55
vector55:
  pushl $0
  1020a1:	6a 00                	push   $0x0
  pushl $55
  1020a3:	6a 37                	push   $0x37
  jmp __alltraps
  1020a5:	e9 88 08 00 00       	jmp    102932 <__alltraps>

001020aa <vector56>:
.globl vector56
vector56:
  pushl $0
  1020aa:	6a 00                	push   $0x0
  pushl $56
  1020ac:	6a 38                	push   $0x38
  jmp __alltraps
  1020ae:	e9 7f 08 00 00       	jmp    102932 <__alltraps>

001020b3 <vector57>:
.globl vector57
vector57:
  pushl $0
  1020b3:	6a 00                	push   $0x0
  pushl $57
  1020b5:	6a 39                	push   $0x39
  jmp __alltraps
  1020b7:	e9 76 08 00 00       	jmp    102932 <__alltraps>

001020bc <vector58>:
.globl vector58
vector58:
  pushl $0
  1020bc:	6a 00                	push   $0x0
  pushl $58
  1020be:	6a 3a                	push   $0x3a
  jmp __alltraps
  1020c0:	e9 6d 08 00 00       	jmp    102932 <__alltraps>

001020c5 <vector59>:
.globl vector59
vector59:
  pushl $0
  1020c5:	6a 00                	push   $0x0
  pushl $59
  1020c7:	6a 3b                	push   $0x3b
  jmp __alltraps
  1020c9:	e9 64 08 00 00       	jmp    102932 <__alltraps>

001020ce <vector60>:
.globl vector60
vector60:
  pushl $0
  1020ce:	6a 00                	push   $0x0
  pushl $60
  1020d0:	6a 3c                	push   $0x3c
  jmp __alltraps
  1020d2:	e9 5b 08 00 00       	jmp    102932 <__alltraps>

001020d7 <vector61>:
.globl vector61
vector61:
  pushl $0
  1020d7:	6a 00                	push   $0x0
  pushl $61
  1020d9:	6a 3d                	push   $0x3d
  jmp __alltraps
  1020db:	e9 52 08 00 00       	jmp    102932 <__alltraps>

001020e0 <vector62>:
.globl vector62
vector62:
  pushl $0
  1020e0:	6a 00                	push   $0x0
  pushl $62
  1020e2:	6a 3e                	push   $0x3e
  jmp __alltraps
  1020e4:	e9 49 08 00 00       	jmp    102932 <__alltraps>

001020e9 <vector63>:
.globl vector63
vector63:
  pushl $0
  1020e9:	6a 00                	push   $0x0
  pushl $63
  1020eb:	6a 3f                	push   $0x3f
  jmp __alltraps
  1020ed:	e9 40 08 00 00       	jmp    102932 <__alltraps>

001020f2 <vector64>:
.globl vector64
vector64:
  pushl $0
  1020f2:	6a 00                	push   $0x0
  pushl $64
  1020f4:	6a 40                	push   $0x40
  jmp __alltraps
  1020f6:	e9 37 08 00 00       	jmp    102932 <__alltraps>

001020fb <vector65>:
.globl vector65
vector65:
  pushl $0
  1020fb:	6a 00                	push   $0x0
  pushl $65
  1020fd:	6a 41                	push   $0x41
  jmp __alltraps
  1020ff:	e9 2e 08 00 00       	jmp    102932 <__alltraps>

00102104 <vector66>:
.globl vector66
vector66:
  pushl $0
  102104:	6a 00                	push   $0x0
  pushl $66
  102106:	6a 42                	push   $0x42
  jmp __alltraps
  102108:	e9 25 08 00 00       	jmp    102932 <__alltraps>

0010210d <vector67>:
.globl vector67
vector67:
  pushl $0
  10210d:	6a 00                	push   $0x0
  pushl $67
  10210f:	6a 43                	push   $0x43
  jmp __alltraps
  102111:	e9 1c 08 00 00       	jmp    102932 <__alltraps>

00102116 <vector68>:
.globl vector68
vector68:
  pushl $0
  102116:	6a 00                	push   $0x0
  pushl $68
  102118:	6a 44                	push   $0x44
  jmp __alltraps
  10211a:	e9 13 08 00 00       	jmp    102932 <__alltraps>

0010211f <vector69>:
.globl vector69
vector69:
  pushl $0
  10211f:	6a 00                	push   $0x0
  pushl $69
  102121:	6a 45                	push   $0x45
  jmp __alltraps
  102123:	e9 0a 08 00 00       	jmp    102932 <__alltraps>

00102128 <vector70>:
.globl vector70
vector70:
  pushl $0
  102128:	6a 00                	push   $0x0
  pushl $70
  10212a:	6a 46                	push   $0x46
  jmp __alltraps
  10212c:	e9 01 08 00 00       	jmp    102932 <__alltraps>

00102131 <vector71>:
.globl vector71
vector71:
  pushl $0
  102131:	6a 00                	push   $0x0
  pushl $71
  102133:	6a 47                	push   $0x47
  jmp __alltraps
  102135:	e9 f8 07 00 00       	jmp    102932 <__alltraps>

0010213a <vector72>:
.globl vector72
vector72:
  pushl $0
  10213a:	6a 00                	push   $0x0
  pushl $72
  10213c:	6a 48                	push   $0x48
  jmp __alltraps
  10213e:	e9 ef 07 00 00       	jmp    102932 <__alltraps>

00102143 <vector73>:
.globl vector73
vector73:
  pushl $0
  102143:	6a 00                	push   $0x0
  pushl $73
  102145:	6a 49                	push   $0x49
  jmp __alltraps
  102147:	e9 e6 07 00 00       	jmp    102932 <__alltraps>

0010214c <vector74>:
.globl vector74
vector74:
  pushl $0
  10214c:	6a 00                	push   $0x0
  pushl $74
  10214e:	6a 4a                	push   $0x4a
  jmp __alltraps
  102150:	e9 dd 07 00 00       	jmp    102932 <__alltraps>

00102155 <vector75>:
.globl vector75
vector75:
  pushl $0
  102155:	6a 00                	push   $0x0
  pushl $75
  102157:	6a 4b                	push   $0x4b
  jmp __alltraps
  102159:	e9 d4 07 00 00       	jmp    102932 <__alltraps>

0010215e <vector76>:
.globl vector76
vector76:
  pushl $0
  10215e:	6a 00                	push   $0x0
  pushl $76
  102160:	6a 4c                	push   $0x4c
  jmp __alltraps
  102162:	e9 cb 07 00 00       	jmp    102932 <__alltraps>

00102167 <vector77>:
.globl vector77
vector77:
  pushl $0
  102167:	6a 00                	push   $0x0
  pushl $77
  102169:	6a 4d                	push   $0x4d
  jmp __alltraps
  10216b:	e9 c2 07 00 00       	jmp    102932 <__alltraps>

00102170 <vector78>:
.globl vector78
vector78:
  pushl $0
  102170:	6a 00                	push   $0x0
  pushl $78
  102172:	6a 4e                	push   $0x4e
  jmp __alltraps
  102174:	e9 b9 07 00 00       	jmp    102932 <__alltraps>

00102179 <vector79>:
.globl vector79
vector79:
  pushl $0
  102179:	6a 00                	push   $0x0
  pushl $79
  10217b:	6a 4f                	push   $0x4f
  jmp __alltraps
  10217d:	e9 b0 07 00 00       	jmp    102932 <__alltraps>

00102182 <vector80>:
.globl vector80
vector80:
  pushl $0
  102182:	6a 00                	push   $0x0
  pushl $80
  102184:	6a 50                	push   $0x50
  jmp __alltraps
  102186:	e9 a7 07 00 00       	jmp    102932 <__alltraps>

0010218b <vector81>:
.globl vector81
vector81:
  pushl $0
  10218b:	6a 00                	push   $0x0
  pushl $81
  10218d:	6a 51                	push   $0x51
  jmp __alltraps
  10218f:	e9 9e 07 00 00       	jmp    102932 <__alltraps>

00102194 <vector82>:
.globl vector82
vector82:
  pushl $0
  102194:	6a 00                	push   $0x0
  pushl $82
  102196:	6a 52                	push   $0x52
  jmp __alltraps
  102198:	e9 95 07 00 00       	jmp    102932 <__alltraps>

0010219d <vector83>:
.globl vector83
vector83:
  pushl $0
  10219d:	6a 00                	push   $0x0
  pushl $83
  10219f:	6a 53                	push   $0x53
  jmp __alltraps
  1021a1:	e9 8c 07 00 00       	jmp    102932 <__alltraps>

001021a6 <vector84>:
.globl vector84
vector84:
  pushl $0
  1021a6:	6a 00                	push   $0x0
  pushl $84
  1021a8:	6a 54                	push   $0x54
  jmp __alltraps
  1021aa:	e9 83 07 00 00       	jmp    102932 <__alltraps>

001021af <vector85>:
.globl vector85
vector85:
  pushl $0
  1021af:	6a 00                	push   $0x0
  pushl $85
  1021b1:	6a 55                	push   $0x55
  jmp __alltraps
  1021b3:	e9 7a 07 00 00       	jmp    102932 <__alltraps>

001021b8 <vector86>:
.globl vector86
vector86:
  pushl $0
  1021b8:	6a 00                	push   $0x0
  pushl $86
  1021ba:	6a 56                	push   $0x56
  jmp __alltraps
  1021bc:	e9 71 07 00 00       	jmp    102932 <__alltraps>

001021c1 <vector87>:
.globl vector87
vector87:
  pushl $0
  1021c1:	6a 00                	push   $0x0
  pushl $87
  1021c3:	6a 57                	push   $0x57
  jmp __alltraps
  1021c5:	e9 68 07 00 00       	jmp    102932 <__alltraps>

001021ca <vector88>:
.globl vector88
vector88:
  pushl $0
  1021ca:	6a 00                	push   $0x0
  pushl $88
  1021cc:	6a 58                	push   $0x58
  jmp __alltraps
  1021ce:	e9 5f 07 00 00       	jmp    102932 <__alltraps>

001021d3 <vector89>:
.globl vector89
vector89:
  pushl $0
  1021d3:	6a 00                	push   $0x0
  pushl $89
  1021d5:	6a 59                	push   $0x59
  jmp __alltraps
  1021d7:	e9 56 07 00 00       	jmp    102932 <__alltraps>

001021dc <vector90>:
.globl vector90
vector90:
  pushl $0
  1021dc:	6a 00                	push   $0x0
  pushl $90
  1021de:	6a 5a                	push   $0x5a
  jmp __alltraps
  1021e0:	e9 4d 07 00 00       	jmp    102932 <__alltraps>

001021e5 <vector91>:
.globl vector91
vector91:
  pushl $0
  1021e5:	6a 00                	push   $0x0
  pushl $91
  1021e7:	6a 5b                	push   $0x5b
  jmp __alltraps
  1021e9:	e9 44 07 00 00       	jmp    102932 <__alltraps>

001021ee <vector92>:
.globl vector92
vector92:
  pushl $0
  1021ee:	6a 00                	push   $0x0
  pushl $92
  1021f0:	6a 5c                	push   $0x5c
  jmp __alltraps
  1021f2:	e9 3b 07 00 00       	jmp    102932 <__alltraps>

001021f7 <vector93>:
.globl vector93
vector93:
  pushl $0
  1021f7:	6a 00                	push   $0x0
  pushl $93
  1021f9:	6a 5d                	push   $0x5d
  jmp __alltraps
  1021fb:	e9 32 07 00 00       	jmp    102932 <__alltraps>

00102200 <vector94>:
.globl vector94
vector94:
  pushl $0
  102200:	6a 00                	push   $0x0
  pushl $94
  102202:	6a 5e                	push   $0x5e
  jmp __alltraps
  102204:	e9 29 07 00 00       	jmp    102932 <__alltraps>

00102209 <vector95>:
.globl vector95
vector95:
  pushl $0
  102209:	6a 00                	push   $0x0
  pushl $95
  10220b:	6a 5f                	push   $0x5f
  jmp __alltraps
  10220d:	e9 20 07 00 00       	jmp    102932 <__alltraps>

00102212 <vector96>:
.globl vector96
vector96:
  pushl $0
  102212:	6a 00                	push   $0x0
  pushl $96
  102214:	6a 60                	push   $0x60
  jmp __alltraps
  102216:	e9 17 07 00 00       	jmp    102932 <__alltraps>

0010221b <vector97>:
.globl vector97
vector97:
  pushl $0
  10221b:	6a 00                	push   $0x0
  pushl $97
  10221d:	6a 61                	push   $0x61
  jmp __alltraps
  10221f:	e9 0e 07 00 00       	jmp    102932 <__alltraps>

00102224 <vector98>:
.globl vector98
vector98:
  pushl $0
  102224:	6a 00                	push   $0x0
  pushl $98
  102226:	6a 62                	push   $0x62
  jmp __alltraps
  102228:	e9 05 07 00 00       	jmp    102932 <__alltraps>

0010222d <vector99>:
.globl vector99
vector99:
  pushl $0
  10222d:	6a 00                	push   $0x0
  pushl $99
  10222f:	6a 63                	push   $0x63
  jmp __alltraps
  102231:	e9 fc 06 00 00       	jmp    102932 <__alltraps>

00102236 <vector100>:
.globl vector100
vector100:
  pushl $0
  102236:	6a 00                	push   $0x0
  pushl $100
  102238:	6a 64                	push   $0x64
  jmp __alltraps
  10223a:	e9 f3 06 00 00       	jmp    102932 <__alltraps>

0010223f <vector101>:
.globl vector101
vector101:
  pushl $0
  10223f:	6a 00                	push   $0x0
  pushl $101
  102241:	6a 65                	push   $0x65
  jmp __alltraps
  102243:	e9 ea 06 00 00       	jmp    102932 <__alltraps>

00102248 <vector102>:
.globl vector102
vector102:
  pushl $0
  102248:	6a 00                	push   $0x0
  pushl $102
  10224a:	6a 66                	push   $0x66
  jmp __alltraps
  10224c:	e9 e1 06 00 00       	jmp    102932 <__alltraps>

00102251 <vector103>:
.globl vector103
vector103:
  pushl $0
  102251:	6a 00                	push   $0x0
  pushl $103
  102253:	6a 67                	push   $0x67
  jmp __alltraps
  102255:	e9 d8 06 00 00       	jmp    102932 <__alltraps>

0010225a <vector104>:
.globl vector104
vector104:
  pushl $0
  10225a:	6a 00                	push   $0x0
  pushl $104
  10225c:	6a 68                	push   $0x68
  jmp __alltraps
  10225e:	e9 cf 06 00 00       	jmp    102932 <__alltraps>

00102263 <vector105>:
.globl vector105
vector105:
  pushl $0
  102263:	6a 00                	push   $0x0
  pushl $105
  102265:	6a 69                	push   $0x69
  jmp __alltraps
  102267:	e9 c6 06 00 00       	jmp    102932 <__alltraps>

0010226c <vector106>:
.globl vector106
vector106:
  pushl $0
  10226c:	6a 00                	push   $0x0
  pushl $106
  10226e:	6a 6a                	push   $0x6a
  jmp __alltraps
  102270:	e9 bd 06 00 00       	jmp    102932 <__alltraps>

00102275 <vector107>:
.globl vector107
vector107:
  pushl $0
  102275:	6a 00                	push   $0x0
  pushl $107
  102277:	6a 6b                	push   $0x6b
  jmp __alltraps
  102279:	e9 b4 06 00 00       	jmp    102932 <__alltraps>

0010227e <vector108>:
.globl vector108
vector108:
  pushl $0
  10227e:	6a 00                	push   $0x0
  pushl $108
  102280:	6a 6c                	push   $0x6c
  jmp __alltraps
  102282:	e9 ab 06 00 00       	jmp    102932 <__alltraps>

00102287 <vector109>:
.globl vector109
vector109:
  pushl $0
  102287:	6a 00                	push   $0x0
  pushl $109
  102289:	6a 6d                	push   $0x6d
  jmp __alltraps
  10228b:	e9 a2 06 00 00       	jmp    102932 <__alltraps>

00102290 <vector110>:
.globl vector110
vector110:
  pushl $0
  102290:	6a 00                	push   $0x0
  pushl $110
  102292:	6a 6e                	push   $0x6e
  jmp __alltraps
  102294:	e9 99 06 00 00       	jmp    102932 <__alltraps>

00102299 <vector111>:
.globl vector111
vector111:
  pushl $0
  102299:	6a 00                	push   $0x0
  pushl $111
  10229b:	6a 6f                	push   $0x6f
  jmp __alltraps
  10229d:	e9 90 06 00 00       	jmp    102932 <__alltraps>

001022a2 <vector112>:
.globl vector112
vector112:
  pushl $0
  1022a2:	6a 00                	push   $0x0
  pushl $112
  1022a4:	6a 70                	push   $0x70
  jmp __alltraps
  1022a6:	e9 87 06 00 00       	jmp    102932 <__alltraps>

001022ab <vector113>:
.globl vector113
vector113:
  pushl $0
  1022ab:	6a 00                	push   $0x0
  pushl $113
  1022ad:	6a 71                	push   $0x71
  jmp __alltraps
  1022af:	e9 7e 06 00 00       	jmp    102932 <__alltraps>

001022b4 <vector114>:
.globl vector114
vector114:
  pushl $0
  1022b4:	6a 00                	push   $0x0
  pushl $114
  1022b6:	6a 72                	push   $0x72
  jmp __alltraps
  1022b8:	e9 75 06 00 00       	jmp    102932 <__alltraps>

001022bd <vector115>:
.globl vector115
vector115:
  pushl $0
  1022bd:	6a 00                	push   $0x0
  pushl $115
  1022bf:	6a 73                	push   $0x73
  jmp __alltraps
  1022c1:	e9 6c 06 00 00       	jmp    102932 <__alltraps>

001022c6 <vector116>:
.globl vector116
vector116:
  pushl $0
  1022c6:	6a 00                	push   $0x0
  pushl $116
  1022c8:	6a 74                	push   $0x74
  jmp __alltraps
  1022ca:	e9 63 06 00 00       	jmp    102932 <__alltraps>

001022cf <vector117>:
.globl vector117
vector117:
  pushl $0
  1022cf:	6a 00                	push   $0x0
  pushl $117
  1022d1:	6a 75                	push   $0x75
  jmp __alltraps
  1022d3:	e9 5a 06 00 00       	jmp    102932 <__alltraps>

001022d8 <vector118>:
.globl vector118
vector118:
  pushl $0
  1022d8:	6a 00                	push   $0x0
  pushl $118
  1022da:	6a 76                	push   $0x76
  jmp __alltraps
  1022dc:	e9 51 06 00 00       	jmp    102932 <__alltraps>

001022e1 <vector119>:
.globl vector119
vector119:
  pushl $0
  1022e1:	6a 00                	push   $0x0
  pushl $119
  1022e3:	6a 77                	push   $0x77
  jmp __alltraps
  1022e5:	e9 48 06 00 00       	jmp    102932 <__alltraps>

001022ea <vector120>:
.globl vector120
vector120:
  pushl $0
  1022ea:	6a 00                	push   $0x0
  pushl $120
  1022ec:	6a 78                	push   $0x78
  jmp __alltraps
  1022ee:	e9 3f 06 00 00       	jmp    102932 <__alltraps>

001022f3 <vector121>:
.globl vector121
vector121:
  pushl $0
  1022f3:	6a 00                	push   $0x0
  pushl $121
  1022f5:	6a 79                	push   $0x79
  jmp __alltraps
  1022f7:	e9 36 06 00 00       	jmp    102932 <__alltraps>

001022fc <vector122>:
.globl vector122
vector122:
  pushl $0
  1022fc:	6a 00                	push   $0x0
  pushl $122
  1022fe:	6a 7a                	push   $0x7a
  jmp __alltraps
  102300:	e9 2d 06 00 00       	jmp    102932 <__alltraps>

00102305 <vector123>:
.globl vector123
vector123:
  pushl $0
  102305:	6a 00                	push   $0x0
  pushl $123
  102307:	6a 7b                	push   $0x7b
  jmp __alltraps
  102309:	e9 24 06 00 00       	jmp    102932 <__alltraps>

0010230e <vector124>:
.globl vector124
vector124:
  pushl $0
  10230e:	6a 00                	push   $0x0
  pushl $124
  102310:	6a 7c                	push   $0x7c
  jmp __alltraps
  102312:	e9 1b 06 00 00       	jmp    102932 <__alltraps>

00102317 <vector125>:
.globl vector125
vector125:
  pushl $0
  102317:	6a 00                	push   $0x0
  pushl $125
  102319:	6a 7d                	push   $0x7d
  jmp __alltraps
  10231b:	e9 12 06 00 00       	jmp    102932 <__alltraps>

00102320 <vector126>:
.globl vector126
vector126:
  pushl $0
  102320:	6a 00                	push   $0x0
  pushl $126
  102322:	6a 7e                	push   $0x7e
  jmp __alltraps
  102324:	e9 09 06 00 00       	jmp    102932 <__alltraps>

00102329 <vector127>:
.globl vector127
vector127:
  pushl $0
  102329:	6a 00                	push   $0x0
  pushl $127
  10232b:	6a 7f                	push   $0x7f
  jmp __alltraps
  10232d:	e9 00 06 00 00       	jmp    102932 <__alltraps>

00102332 <vector128>:
.globl vector128
vector128:
  pushl $0
  102332:	6a 00                	push   $0x0
  pushl $128
  102334:	68 80 00 00 00       	push   $0x80
  jmp __alltraps
  102339:	e9 f4 05 00 00       	jmp    102932 <__alltraps>

0010233e <vector129>:
.globl vector129
vector129:
  pushl $0
  10233e:	6a 00                	push   $0x0
  pushl $129
  102340:	68 81 00 00 00       	push   $0x81
  jmp __alltraps
  102345:	e9 e8 05 00 00       	jmp    102932 <__alltraps>

0010234a <vector130>:
.globl vector130
vector130:
  pushl $0
  10234a:	6a 00                	push   $0x0
  pushl $130
  10234c:	68 82 00 00 00       	push   $0x82
  jmp __alltraps
  102351:	e9 dc 05 00 00       	jmp    102932 <__alltraps>

00102356 <vector131>:
.globl vector131
vector131:
  pushl $0
  102356:	6a 00                	push   $0x0
  pushl $131
  102358:	68 83 00 00 00       	push   $0x83
  jmp __alltraps
  10235d:	e9 d0 05 00 00       	jmp    102932 <__alltraps>

00102362 <vector132>:
.globl vector132
vector132:
  pushl $0
  102362:	6a 00                	push   $0x0
  pushl $132
  102364:	68 84 00 00 00       	push   $0x84
  jmp __alltraps
  102369:	e9 c4 05 00 00       	jmp    102932 <__alltraps>

0010236e <vector133>:
.globl vector133
vector133:
  pushl $0
  10236e:	6a 00                	push   $0x0
  pushl $133
  102370:	68 85 00 00 00       	push   $0x85
  jmp __alltraps
  102375:	e9 b8 05 00 00       	jmp    102932 <__alltraps>

0010237a <vector134>:
.globl vector134
vector134:
  pushl $0
  10237a:	6a 00                	push   $0x0
  pushl $134
  10237c:	68 86 00 00 00       	push   $0x86
  jmp __alltraps
  102381:	e9 ac 05 00 00       	jmp    102932 <__alltraps>

00102386 <vector135>:
.globl vector135
vector135:
  pushl $0
  102386:	6a 00                	push   $0x0
  pushl $135
  102388:	68 87 00 00 00       	push   $0x87
  jmp __alltraps
  10238d:	e9 a0 05 00 00       	jmp    102932 <__alltraps>

00102392 <vector136>:
.globl vector136
vector136:
  pushl $0
  102392:	6a 00                	push   $0x0
  pushl $136
  102394:	68 88 00 00 00       	push   $0x88
  jmp __alltraps
  102399:	e9 94 05 00 00       	jmp    102932 <__alltraps>

0010239e <vector137>:
.globl vector137
vector137:
  pushl $0
  10239e:	6a 00                	push   $0x0
  pushl $137
  1023a0:	68 89 00 00 00       	push   $0x89
  jmp __alltraps
  1023a5:	e9 88 05 00 00       	jmp    102932 <__alltraps>

001023aa <vector138>:
.globl vector138
vector138:
  pushl $0
  1023aa:	6a 00                	push   $0x0
  pushl $138
  1023ac:	68 8a 00 00 00       	push   $0x8a
  jmp __alltraps
  1023b1:	e9 7c 05 00 00       	jmp    102932 <__alltraps>

001023b6 <vector139>:
.globl vector139
vector139:
  pushl $0
  1023b6:	6a 00                	push   $0x0
  pushl $139
  1023b8:	68 8b 00 00 00       	push   $0x8b
  jmp __alltraps
  1023bd:	e9 70 05 00 00       	jmp    102932 <__alltraps>

001023c2 <vector140>:
.globl vector140
vector140:
  pushl $0
  1023c2:	6a 00                	push   $0x0
  pushl $140
  1023c4:	68 8c 00 00 00       	push   $0x8c
  jmp __alltraps
  1023c9:	e9 64 05 00 00       	jmp    102932 <__alltraps>

001023ce <vector141>:
.globl vector141
vector141:
  pushl $0
  1023ce:	6a 00                	push   $0x0
  pushl $141
  1023d0:	68 8d 00 00 00       	push   $0x8d
  jmp __alltraps
  1023d5:	e9 58 05 00 00       	jmp    102932 <__alltraps>

001023da <vector142>:
.globl vector142
vector142:
  pushl $0
  1023da:	6a 00                	push   $0x0
  pushl $142
  1023dc:	68 8e 00 00 00       	push   $0x8e
  jmp __alltraps
  1023e1:	e9 4c 05 00 00       	jmp    102932 <__alltraps>

001023e6 <vector143>:
.globl vector143
vector143:
  pushl $0
  1023e6:	6a 00                	push   $0x0
  pushl $143
  1023e8:	68 8f 00 00 00       	push   $0x8f
  jmp __alltraps
  1023ed:	e9 40 05 00 00       	jmp    102932 <__alltraps>

001023f2 <vector144>:
.globl vector144
vector144:
  pushl $0
  1023f2:	6a 00                	push   $0x0
  pushl $144
  1023f4:	68 90 00 00 00       	push   $0x90
  jmp __alltraps
  1023f9:	e9 34 05 00 00       	jmp    102932 <__alltraps>

001023fe <vector145>:
.globl vector145
vector145:
  pushl $0
  1023fe:	6a 00                	push   $0x0
  pushl $145
  102400:	68 91 00 00 00       	push   $0x91
  jmp __alltraps
  102405:	e9 28 05 00 00       	jmp    102932 <__alltraps>

0010240a <vector146>:
.globl vector146
vector146:
  pushl $0
  10240a:	6a 00                	push   $0x0
  pushl $146
  10240c:	68 92 00 00 00       	push   $0x92
  jmp __alltraps
  102411:	e9 1c 05 00 00       	jmp    102932 <__alltraps>

00102416 <vector147>:
.globl vector147
vector147:
  pushl $0
  102416:	6a 00                	push   $0x0
  pushl $147
  102418:	68 93 00 00 00       	push   $0x93
  jmp __alltraps
  10241d:	e9 10 05 00 00       	jmp    102932 <__alltraps>

00102422 <vector148>:
.globl vector148
vector148:
  pushl $0
  102422:	6a 00                	push   $0x0
  pushl $148
  102424:	68 94 00 00 00       	push   $0x94
  jmp __alltraps
  102429:	e9 04 05 00 00       	jmp    102932 <__alltraps>

0010242e <vector149>:
.globl vector149
vector149:
  pushl $0
  10242e:	6a 00                	push   $0x0
  pushl $149
  102430:	68 95 00 00 00       	push   $0x95
  jmp __alltraps
  102435:	e9 f8 04 00 00       	jmp    102932 <__alltraps>

0010243a <vector150>:
.globl vector150
vector150:
  pushl $0
  10243a:	6a 00                	push   $0x0
  pushl $150
  10243c:	68 96 00 00 00       	push   $0x96
  jmp __alltraps
  102441:	e9 ec 04 00 00       	jmp    102932 <__alltraps>

00102446 <vector151>:
.globl vector151
vector151:
  pushl $0
  102446:	6a 00                	push   $0x0
  pushl $151
  102448:	68 97 00 00 00       	push   $0x97
  jmp __alltraps
  10244d:	e9 e0 04 00 00       	jmp    102932 <__alltraps>

00102452 <vector152>:
.globl vector152
vector152:
  pushl $0
  102452:	6a 00                	push   $0x0
  pushl $152
  102454:	68 98 00 00 00       	push   $0x98
  jmp __alltraps
  102459:	e9 d4 04 00 00       	jmp    102932 <__alltraps>

0010245e <vector153>:
.globl vector153
vector153:
  pushl $0
  10245e:	6a 00                	push   $0x0
  pushl $153
  102460:	68 99 00 00 00       	push   $0x99
  jmp __alltraps
  102465:	e9 c8 04 00 00       	jmp    102932 <__alltraps>

0010246a <vector154>:
.globl vector154
vector154:
  pushl $0
  10246a:	6a 00                	push   $0x0
  pushl $154
  10246c:	68 9a 00 00 00       	push   $0x9a
  jmp __alltraps
  102471:	e9 bc 04 00 00       	jmp    102932 <__alltraps>

00102476 <vector155>:
.globl vector155
vector155:
  pushl $0
  102476:	6a 00                	push   $0x0
  pushl $155
  102478:	68 9b 00 00 00       	push   $0x9b
  jmp __alltraps
  10247d:	e9 b0 04 00 00       	jmp    102932 <__alltraps>

00102482 <vector156>:
.globl vector156
vector156:
  pushl $0
  102482:	6a 00                	push   $0x0
  pushl $156
  102484:	68 9c 00 00 00       	push   $0x9c
  jmp __alltraps
  102489:	e9 a4 04 00 00       	jmp    102932 <__alltraps>

0010248e <vector157>:
.globl vector157
vector157:
  pushl $0
  10248e:	6a 00                	push   $0x0
  pushl $157
  102490:	68 9d 00 00 00       	push   $0x9d
  jmp __alltraps
  102495:	e9 98 04 00 00       	jmp    102932 <__alltraps>

0010249a <vector158>:
.globl vector158
vector158:
  pushl $0
  10249a:	6a 00                	push   $0x0
  pushl $158
  10249c:	68 9e 00 00 00       	push   $0x9e
  jmp __alltraps
  1024a1:	e9 8c 04 00 00       	jmp    102932 <__alltraps>

001024a6 <vector159>:
.globl vector159
vector159:
  pushl $0
  1024a6:	6a 00                	push   $0x0
  pushl $159
  1024a8:	68 9f 00 00 00       	push   $0x9f
  jmp __alltraps
  1024ad:	e9 80 04 00 00       	jmp    102932 <__alltraps>

001024b2 <vector160>:
.globl vector160
vector160:
  pushl $0
  1024b2:	6a 00                	push   $0x0
  pushl $160
  1024b4:	68 a0 00 00 00       	push   $0xa0
  jmp __alltraps
  1024b9:	e9 74 04 00 00       	jmp    102932 <__alltraps>

001024be <vector161>:
.globl vector161
vector161:
  pushl $0
  1024be:	6a 00                	push   $0x0
  pushl $161
  1024c0:	68 a1 00 00 00       	push   $0xa1
  jmp __alltraps
  1024c5:	e9 68 04 00 00       	jmp    102932 <__alltraps>

001024ca <vector162>:
.globl vector162
vector162:
  pushl $0
  1024ca:	6a 00                	push   $0x0
  pushl $162
  1024cc:	68 a2 00 00 00       	push   $0xa2
  jmp __alltraps
  1024d1:	e9 5c 04 00 00       	jmp    102932 <__alltraps>

001024d6 <vector163>:
.globl vector163
vector163:
  pushl $0
  1024d6:	6a 00                	push   $0x0
  pushl $163
  1024d8:	68 a3 00 00 00       	push   $0xa3
  jmp __alltraps
  1024dd:	e9 50 04 00 00       	jmp    102932 <__alltraps>

001024e2 <vector164>:
.globl vector164
vector164:
  pushl $0
  1024e2:	6a 00                	push   $0x0
  pushl $164
  1024e4:	68 a4 00 00 00       	push   $0xa4
  jmp __alltraps
  1024e9:	e9 44 04 00 00       	jmp    102932 <__alltraps>

001024ee <vector165>:
.globl vector165
vector165:
  pushl $0
  1024ee:	6a 00                	push   $0x0
  pushl $165
  1024f0:	68 a5 00 00 00       	push   $0xa5
  jmp __alltraps
  1024f5:	e9 38 04 00 00       	jmp    102932 <__alltraps>

001024fa <vector166>:
.globl vector166
vector166:
  pushl $0
  1024fa:	6a 00                	push   $0x0
  pushl $166
  1024fc:	68 a6 00 00 00       	push   $0xa6
  jmp __alltraps
  102501:	e9 2c 04 00 00       	jmp    102932 <__alltraps>

00102506 <vector167>:
.globl vector167
vector167:
  pushl $0
  102506:	6a 00                	push   $0x0
  pushl $167
  102508:	68 a7 00 00 00       	push   $0xa7
  jmp __alltraps
  10250d:	e9 20 04 00 00       	jmp    102932 <__alltraps>

00102512 <vector168>:
.globl vector168
vector168:
  pushl $0
  102512:	6a 00                	push   $0x0
  pushl $168
  102514:	68 a8 00 00 00       	push   $0xa8
  jmp __alltraps
  102519:	e9 14 04 00 00       	jmp    102932 <__alltraps>

0010251e <vector169>:
.globl vector169
vector169:
  pushl $0
  10251e:	6a 00                	push   $0x0
  pushl $169
  102520:	68 a9 00 00 00       	push   $0xa9
  jmp __alltraps
  102525:	e9 08 04 00 00       	jmp    102932 <__alltraps>

0010252a <vector170>:
.globl vector170
vector170:
  pushl $0
  10252a:	6a 00                	push   $0x0
  pushl $170
  10252c:	68 aa 00 00 00       	push   $0xaa
  jmp __alltraps
  102531:	e9 fc 03 00 00       	jmp    102932 <__alltraps>

00102536 <vector171>:
.globl vector171
vector171:
  pushl $0
  102536:	6a 00                	push   $0x0
  pushl $171
  102538:	68 ab 00 00 00       	push   $0xab
  jmp __alltraps
  10253d:	e9 f0 03 00 00       	jmp    102932 <__alltraps>

00102542 <vector172>:
.globl vector172
vector172:
  pushl $0
  102542:	6a 00                	push   $0x0
  pushl $172
  102544:	68 ac 00 00 00       	push   $0xac
  jmp __alltraps
  102549:	e9 e4 03 00 00       	jmp    102932 <__alltraps>

0010254e <vector173>:
.globl vector173
vector173:
  pushl $0
  10254e:	6a 00                	push   $0x0
  pushl $173
  102550:	68 ad 00 00 00       	push   $0xad
  jmp __alltraps
  102555:	e9 d8 03 00 00       	jmp    102932 <__alltraps>

0010255a <vector174>:
.globl vector174
vector174:
  pushl $0
  10255a:	6a 00                	push   $0x0
  pushl $174
  10255c:	68 ae 00 00 00       	push   $0xae
  jmp __alltraps
  102561:	e9 cc 03 00 00       	jmp    102932 <__alltraps>

00102566 <vector175>:
.globl vector175
vector175:
  pushl $0
  102566:	6a 00                	push   $0x0
  pushl $175
  102568:	68 af 00 00 00       	push   $0xaf
  jmp __alltraps
  10256d:	e9 c0 03 00 00       	jmp    102932 <__alltraps>

00102572 <vector176>:
.globl vector176
vector176:
  pushl $0
  102572:	6a 00                	push   $0x0
  pushl $176
  102574:	68 b0 00 00 00       	push   $0xb0
  jmp __alltraps
  102579:	e9 b4 03 00 00       	jmp    102932 <__alltraps>

0010257e <vector177>:
.globl vector177
vector177:
  pushl $0
  10257e:	6a 00                	push   $0x0
  pushl $177
  102580:	68 b1 00 00 00       	push   $0xb1
  jmp __alltraps
  102585:	e9 a8 03 00 00       	jmp    102932 <__alltraps>

0010258a <vector178>:
.globl vector178
vector178:
  pushl $0
  10258a:	6a 00                	push   $0x0
  pushl $178
  10258c:	68 b2 00 00 00       	push   $0xb2
  jmp __alltraps
  102591:	e9 9c 03 00 00       	jmp    102932 <__alltraps>

00102596 <vector179>:
.globl vector179
vector179:
  pushl $0
  102596:	6a 00                	push   $0x0
  pushl $179
  102598:	68 b3 00 00 00       	push   $0xb3
  jmp __alltraps
  10259d:	e9 90 03 00 00       	jmp    102932 <__alltraps>

001025a2 <vector180>:
.globl vector180
vector180:
  pushl $0
  1025a2:	6a 00                	push   $0x0
  pushl $180
  1025a4:	68 b4 00 00 00       	push   $0xb4
  jmp __alltraps
  1025a9:	e9 84 03 00 00       	jmp    102932 <__alltraps>

001025ae <vector181>:
.globl vector181
vector181:
  pushl $0
  1025ae:	6a 00                	push   $0x0
  pushl $181
  1025b0:	68 b5 00 00 00       	push   $0xb5
  jmp __alltraps
  1025b5:	e9 78 03 00 00       	jmp    102932 <__alltraps>

001025ba <vector182>:
.globl vector182
vector182:
  pushl $0
  1025ba:	6a 00                	push   $0x0
  pushl $182
  1025bc:	68 b6 00 00 00       	push   $0xb6
  jmp __alltraps
  1025c1:	e9 6c 03 00 00       	jmp    102932 <__alltraps>

001025c6 <vector183>:
.globl vector183
vector183:
  pushl $0
  1025c6:	6a 00                	push   $0x0
  pushl $183
  1025c8:	68 b7 00 00 00       	push   $0xb7
  jmp __alltraps
  1025cd:	e9 60 03 00 00       	jmp    102932 <__alltraps>

001025d2 <vector184>:
.globl vector184
vector184:
  pushl $0
  1025d2:	6a 00                	push   $0x0
  pushl $184
  1025d4:	68 b8 00 00 00       	push   $0xb8
  jmp __alltraps
  1025d9:	e9 54 03 00 00       	jmp    102932 <__alltraps>

001025de <vector185>:
.globl vector185
vector185:
  pushl $0
  1025de:	6a 00                	push   $0x0
  pushl $185
  1025e0:	68 b9 00 00 00       	push   $0xb9
  jmp __alltraps
  1025e5:	e9 48 03 00 00       	jmp    102932 <__alltraps>

001025ea <vector186>:
.globl vector186
vector186:
  pushl $0
  1025ea:	6a 00                	push   $0x0
  pushl $186
  1025ec:	68 ba 00 00 00       	push   $0xba
  jmp __alltraps
  1025f1:	e9 3c 03 00 00       	jmp    102932 <__alltraps>

001025f6 <vector187>:
.globl vector187
vector187:
  pushl $0
  1025f6:	6a 00                	push   $0x0
  pushl $187
  1025f8:	68 bb 00 00 00       	push   $0xbb
  jmp __alltraps
  1025fd:	e9 30 03 00 00       	jmp    102932 <__alltraps>

00102602 <vector188>:
.globl vector188
vector188:
  pushl $0
  102602:	6a 00                	push   $0x0
  pushl $188
  102604:	68 bc 00 00 00       	push   $0xbc
  jmp __alltraps
  102609:	e9 24 03 00 00       	jmp    102932 <__alltraps>

0010260e <vector189>:
.globl vector189
vector189:
  pushl $0
  10260e:	6a 00                	push   $0x0
  pushl $189
  102610:	68 bd 00 00 00       	push   $0xbd
  jmp __alltraps
  102615:	e9 18 03 00 00       	jmp    102932 <__alltraps>

0010261a <vector190>:
.globl vector190
vector190:
  pushl $0
  10261a:	6a 00                	push   $0x0
  pushl $190
  10261c:	68 be 00 00 00       	push   $0xbe
  jmp __alltraps
  102621:	e9 0c 03 00 00       	jmp    102932 <__alltraps>

00102626 <vector191>:
.globl vector191
vector191:
  pushl $0
  102626:	6a 00                	push   $0x0
  pushl $191
  102628:	68 bf 00 00 00       	push   $0xbf
  jmp __alltraps
  10262d:	e9 00 03 00 00       	jmp    102932 <__alltraps>

00102632 <vector192>:
.globl vector192
vector192:
  pushl $0
  102632:	6a 00                	push   $0x0
  pushl $192
  102634:	68 c0 00 00 00       	push   $0xc0
  jmp __alltraps
  102639:	e9 f4 02 00 00       	jmp    102932 <__alltraps>

0010263e <vector193>:
.globl vector193
vector193:
  pushl $0
  10263e:	6a 00                	push   $0x0
  pushl $193
  102640:	68 c1 00 00 00       	push   $0xc1
  jmp __alltraps
  102645:	e9 e8 02 00 00       	jmp    102932 <__alltraps>

0010264a <vector194>:
.globl vector194
vector194:
  pushl $0
  10264a:	6a 00                	push   $0x0
  pushl $194
  10264c:	68 c2 00 00 00       	push   $0xc2
  jmp __alltraps
  102651:	e9 dc 02 00 00       	jmp    102932 <__alltraps>

00102656 <vector195>:
.globl vector195
vector195:
  pushl $0
  102656:	6a 00                	push   $0x0
  pushl $195
  102658:	68 c3 00 00 00       	push   $0xc3
  jmp __alltraps
  10265d:	e9 d0 02 00 00       	jmp    102932 <__alltraps>

00102662 <vector196>:
.globl vector196
vector196:
  pushl $0
  102662:	6a 00                	push   $0x0
  pushl $196
  102664:	68 c4 00 00 00       	push   $0xc4
  jmp __alltraps
  102669:	e9 c4 02 00 00       	jmp    102932 <__alltraps>

0010266e <vector197>:
.globl vector197
vector197:
  pushl $0
  10266e:	6a 00                	push   $0x0
  pushl $197
  102670:	68 c5 00 00 00       	push   $0xc5
  jmp __alltraps
  102675:	e9 b8 02 00 00       	jmp    102932 <__alltraps>

0010267a <vector198>:
.globl vector198
vector198:
  pushl $0
  10267a:	6a 00                	push   $0x0
  pushl $198
  10267c:	68 c6 00 00 00       	push   $0xc6
  jmp __alltraps
  102681:	e9 ac 02 00 00       	jmp    102932 <__alltraps>

00102686 <vector199>:
.globl vector199
vector199:
  pushl $0
  102686:	6a 00                	push   $0x0
  pushl $199
  102688:	68 c7 00 00 00       	push   $0xc7
  jmp __alltraps
  10268d:	e9 a0 02 00 00       	jmp    102932 <__alltraps>

00102692 <vector200>:
.globl vector200
vector200:
  pushl $0
  102692:	6a 00                	push   $0x0
  pushl $200
  102694:	68 c8 00 00 00       	push   $0xc8
  jmp __alltraps
  102699:	e9 94 02 00 00       	jmp    102932 <__alltraps>

0010269e <vector201>:
.globl vector201
vector201:
  pushl $0
  10269e:	6a 00                	push   $0x0
  pushl $201
  1026a0:	68 c9 00 00 00       	push   $0xc9
  jmp __alltraps
  1026a5:	e9 88 02 00 00       	jmp    102932 <__alltraps>

001026aa <vector202>:
.globl vector202
vector202:
  pushl $0
  1026aa:	6a 00                	push   $0x0
  pushl $202
  1026ac:	68 ca 00 00 00       	push   $0xca
  jmp __alltraps
  1026b1:	e9 7c 02 00 00       	jmp    102932 <__alltraps>

001026b6 <vector203>:
.globl vector203
vector203:
  pushl $0
  1026b6:	6a 00                	push   $0x0
  pushl $203
  1026b8:	68 cb 00 00 00       	push   $0xcb
  jmp __alltraps
  1026bd:	e9 70 02 00 00       	jmp    102932 <__alltraps>

001026c2 <vector204>:
.globl vector204
vector204:
  pushl $0
  1026c2:	6a 00                	push   $0x0
  pushl $204
  1026c4:	68 cc 00 00 00       	push   $0xcc
  jmp __alltraps
  1026c9:	e9 64 02 00 00       	jmp    102932 <__alltraps>

001026ce <vector205>:
.globl vector205
vector205:
  pushl $0
  1026ce:	6a 00                	push   $0x0
  pushl $205
  1026d0:	68 cd 00 00 00       	push   $0xcd
  jmp __alltraps
  1026d5:	e9 58 02 00 00       	jmp    102932 <__alltraps>

001026da <vector206>:
.globl vector206
vector206:
  pushl $0
  1026da:	6a 00                	push   $0x0
  pushl $206
  1026dc:	68 ce 00 00 00       	push   $0xce
  jmp __alltraps
  1026e1:	e9 4c 02 00 00       	jmp    102932 <__alltraps>

001026e6 <vector207>:
.globl vector207
vector207:
  pushl $0
  1026e6:	6a 00                	push   $0x0
  pushl $207
  1026e8:	68 cf 00 00 00       	push   $0xcf
  jmp __alltraps
  1026ed:	e9 40 02 00 00       	jmp    102932 <__alltraps>

001026f2 <vector208>:
.globl vector208
vector208:
  pushl $0
  1026f2:	6a 00                	push   $0x0
  pushl $208
  1026f4:	68 d0 00 00 00       	push   $0xd0
  jmp __alltraps
  1026f9:	e9 34 02 00 00       	jmp    102932 <__alltraps>

001026fe <vector209>:
.globl vector209
vector209:
  pushl $0
  1026fe:	6a 00                	push   $0x0
  pushl $209
  102700:	68 d1 00 00 00       	push   $0xd1
  jmp __alltraps
  102705:	e9 28 02 00 00       	jmp    102932 <__alltraps>

0010270a <vector210>:
.globl vector210
vector210:
  pushl $0
  10270a:	6a 00                	push   $0x0
  pushl $210
  10270c:	68 d2 00 00 00       	push   $0xd2
  jmp __alltraps
  102711:	e9 1c 02 00 00       	jmp    102932 <__alltraps>

00102716 <vector211>:
.globl vector211
vector211:
  pushl $0
  102716:	6a 00                	push   $0x0
  pushl $211
  102718:	68 d3 00 00 00       	push   $0xd3
  jmp __alltraps
  10271d:	e9 10 02 00 00       	jmp    102932 <__alltraps>

00102722 <vector212>:
.globl vector212
vector212:
  pushl $0
  102722:	6a 00                	push   $0x0
  pushl $212
  102724:	68 d4 00 00 00       	push   $0xd4
  jmp __alltraps
  102729:	e9 04 02 00 00       	jmp    102932 <__alltraps>

0010272e <vector213>:
.globl vector213
vector213:
  pushl $0
  10272e:	6a 00                	push   $0x0
  pushl $213
  102730:	68 d5 00 00 00       	push   $0xd5
  jmp __alltraps
  102735:	e9 f8 01 00 00       	jmp    102932 <__alltraps>

0010273a <vector214>:
.globl vector214
vector214:
  pushl $0
  10273a:	6a 00                	push   $0x0
  pushl $214
  10273c:	68 d6 00 00 00       	push   $0xd6
  jmp __alltraps
  102741:	e9 ec 01 00 00       	jmp    102932 <__alltraps>

00102746 <vector215>:
.globl vector215
vector215:
  pushl $0
  102746:	6a 00                	push   $0x0
  pushl $215
  102748:	68 d7 00 00 00       	push   $0xd7
  jmp __alltraps
  10274d:	e9 e0 01 00 00       	jmp    102932 <__alltraps>

00102752 <vector216>:
.globl vector216
vector216:
  pushl $0
  102752:	6a 00                	push   $0x0
  pushl $216
  102754:	68 d8 00 00 00       	push   $0xd8
  jmp __alltraps
  102759:	e9 d4 01 00 00       	jmp    102932 <__alltraps>

0010275e <vector217>:
.globl vector217
vector217:
  pushl $0
  10275e:	6a 00                	push   $0x0
  pushl $217
  102760:	68 d9 00 00 00       	push   $0xd9
  jmp __alltraps
  102765:	e9 c8 01 00 00       	jmp    102932 <__alltraps>

0010276a <vector218>:
.globl vector218
vector218:
  pushl $0
  10276a:	6a 00                	push   $0x0
  pushl $218
  10276c:	68 da 00 00 00       	push   $0xda
  jmp __alltraps
  102771:	e9 bc 01 00 00       	jmp    102932 <__alltraps>

00102776 <vector219>:
.globl vector219
vector219:
  pushl $0
  102776:	6a 00                	push   $0x0
  pushl $219
  102778:	68 db 00 00 00       	push   $0xdb
  jmp __alltraps
  10277d:	e9 b0 01 00 00       	jmp    102932 <__alltraps>

00102782 <vector220>:
.globl vector220
vector220:
  pushl $0
  102782:	6a 00                	push   $0x0
  pushl $220
  102784:	68 dc 00 00 00       	push   $0xdc
  jmp __alltraps
  102789:	e9 a4 01 00 00       	jmp    102932 <__alltraps>

0010278e <vector221>:
.globl vector221
vector221:
  pushl $0
  10278e:	6a 00                	push   $0x0
  pushl $221
  102790:	68 dd 00 00 00       	push   $0xdd
  jmp __alltraps
  102795:	e9 98 01 00 00       	jmp    102932 <__alltraps>

0010279a <vector222>:
.globl vector222
vector222:
  pushl $0
  10279a:	6a 00                	push   $0x0
  pushl $222
  10279c:	68 de 00 00 00       	push   $0xde
  jmp __alltraps
  1027a1:	e9 8c 01 00 00       	jmp    102932 <__alltraps>

001027a6 <vector223>:
.globl vector223
vector223:
  pushl $0
  1027a6:	6a 00                	push   $0x0
  pushl $223
  1027a8:	68 df 00 00 00       	push   $0xdf
  jmp __alltraps
  1027ad:	e9 80 01 00 00       	jmp    102932 <__alltraps>

001027b2 <vector224>:
.globl vector224
vector224:
  pushl $0
  1027b2:	6a 00                	push   $0x0
  pushl $224
  1027b4:	68 e0 00 00 00       	push   $0xe0
  jmp __alltraps
  1027b9:	e9 74 01 00 00       	jmp    102932 <__alltraps>

001027be <vector225>:
.globl vector225
vector225:
  pushl $0
  1027be:	6a 00                	push   $0x0
  pushl $225
  1027c0:	68 e1 00 00 00       	push   $0xe1
  jmp __alltraps
  1027c5:	e9 68 01 00 00       	jmp    102932 <__alltraps>

001027ca <vector226>:
.globl vector226
vector226:
  pushl $0
  1027ca:	6a 00                	push   $0x0
  pushl $226
  1027cc:	68 e2 00 00 00       	push   $0xe2
  jmp __alltraps
  1027d1:	e9 5c 01 00 00       	jmp    102932 <__alltraps>

001027d6 <vector227>:
.globl vector227
vector227:
  pushl $0
  1027d6:	6a 00                	push   $0x0
  pushl $227
  1027d8:	68 e3 00 00 00       	push   $0xe3
  jmp __alltraps
  1027dd:	e9 50 01 00 00       	jmp    102932 <__alltraps>

001027e2 <vector228>:
.globl vector228
vector228:
  pushl $0
  1027e2:	6a 00                	push   $0x0
  pushl $228
  1027e4:	68 e4 00 00 00       	push   $0xe4
  jmp __alltraps
  1027e9:	e9 44 01 00 00       	jmp    102932 <__alltraps>

001027ee <vector229>:
.globl vector229
vector229:
  pushl $0
  1027ee:	6a 00                	push   $0x0
  pushl $229
  1027f0:	68 e5 00 00 00       	push   $0xe5
  jmp __alltraps
  1027f5:	e9 38 01 00 00       	jmp    102932 <__alltraps>

001027fa <vector230>:
.globl vector230
vector230:
  pushl $0
  1027fa:	6a 00                	push   $0x0
  pushl $230
  1027fc:	68 e6 00 00 00       	push   $0xe6
  jmp __alltraps
  102801:	e9 2c 01 00 00       	jmp    102932 <__alltraps>

00102806 <vector231>:
.globl vector231
vector231:
  pushl $0
  102806:	6a 00                	push   $0x0
  pushl $231
  102808:	68 e7 00 00 00       	push   $0xe7
  jmp __alltraps
  10280d:	e9 20 01 00 00       	jmp    102932 <__alltraps>

00102812 <vector232>:
.globl vector232
vector232:
  pushl $0
  102812:	6a 00                	push   $0x0
  pushl $232
  102814:	68 e8 00 00 00       	push   $0xe8
  jmp __alltraps
  102819:	e9 14 01 00 00       	jmp    102932 <__alltraps>

0010281e <vector233>:
.globl vector233
vector233:
  pushl $0
  10281e:	6a 00                	push   $0x0
  pushl $233
  102820:	68 e9 00 00 00       	push   $0xe9
  jmp __alltraps
  102825:	e9 08 01 00 00       	jmp    102932 <__alltraps>

0010282a <vector234>:
.globl vector234
vector234:
  pushl $0
  10282a:	6a 00                	push   $0x0
  pushl $234
  10282c:	68 ea 00 00 00       	push   $0xea
  jmp __alltraps
  102831:	e9 fc 00 00 00       	jmp    102932 <__alltraps>

00102836 <vector235>:
.globl vector235
vector235:
  pushl $0
  102836:	6a 00                	push   $0x0
  pushl $235
  102838:	68 eb 00 00 00       	push   $0xeb
  jmp __alltraps
  10283d:	e9 f0 00 00 00       	jmp    102932 <__alltraps>

00102842 <vector236>:
.globl vector236
vector236:
  pushl $0
  102842:	6a 00                	push   $0x0
  pushl $236
  102844:	68 ec 00 00 00       	push   $0xec
  jmp __alltraps
  102849:	e9 e4 00 00 00       	jmp    102932 <__alltraps>

0010284e <vector237>:
.globl vector237
vector237:
  pushl $0
  10284e:	6a 00                	push   $0x0
  pushl $237
  102850:	68 ed 00 00 00       	push   $0xed
  jmp __alltraps
  102855:	e9 d8 00 00 00       	jmp    102932 <__alltraps>

0010285a <vector238>:
.globl vector238
vector238:
  pushl $0
  10285a:	6a 00                	push   $0x0
  pushl $238
  10285c:	68 ee 00 00 00       	push   $0xee
  jmp __alltraps
  102861:	e9 cc 00 00 00       	jmp    102932 <__alltraps>

00102866 <vector239>:
.globl vector239
vector239:
  pushl $0
  102866:	6a 00                	push   $0x0
  pushl $239
  102868:	68 ef 00 00 00       	push   $0xef
  jmp __alltraps
  10286d:	e9 c0 00 00 00       	jmp    102932 <__alltraps>

00102872 <vector240>:
.globl vector240
vector240:
  pushl $0
  102872:	6a 00                	push   $0x0
  pushl $240
  102874:	68 f0 00 00 00       	push   $0xf0
  jmp __alltraps
  102879:	e9 b4 00 00 00       	jmp    102932 <__alltraps>

0010287e <vector241>:
.globl vector241
vector241:
  pushl $0
  10287e:	6a 00                	push   $0x0
  pushl $241
  102880:	68 f1 00 00 00       	push   $0xf1
  jmp __alltraps
  102885:	e9 a8 00 00 00       	jmp    102932 <__alltraps>

0010288a <vector242>:
.globl vector242
vector242:
  pushl $0
  10288a:	6a 00                	push   $0x0
  pushl $242
  10288c:	68 f2 00 00 00       	push   $0xf2
  jmp __alltraps
  102891:	e9 9c 00 00 00       	jmp    102932 <__alltraps>

00102896 <vector243>:
.globl vector243
vector243:
  pushl $0
  102896:	6a 00                	push   $0x0
  pushl $243
  102898:	68 f3 00 00 00       	push   $0xf3
  jmp __alltraps
  10289d:	e9 90 00 00 00       	jmp    102932 <__alltraps>

001028a2 <vector244>:
.globl vector244
vector244:
  pushl $0
  1028a2:	6a 00                	push   $0x0
  pushl $244
  1028a4:	68 f4 00 00 00       	push   $0xf4
  jmp __alltraps
  1028a9:	e9 84 00 00 00       	jmp    102932 <__alltraps>

001028ae <vector245>:
.globl vector245
vector245:
  pushl $0
  1028ae:	6a 00                	push   $0x0
  pushl $245
  1028b0:	68 f5 00 00 00       	push   $0xf5
  jmp __alltraps
  1028b5:	e9 78 00 00 00       	jmp    102932 <__alltraps>

001028ba <vector246>:
.globl vector246
vector246:
  pushl $0
  1028ba:	6a 00                	push   $0x0
  pushl $246
  1028bc:	68 f6 00 00 00       	push   $0xf6
  jmp __alltraps
  1028c1:	e9 6c 00 00 00       	jmp    102932 <__alltraps>

001028c6 <vector247>:
.globl vector247
vector247:
  pushl $0
  1028c6:	6a 00                	push   $0x0
  pushl $247
  1028c8:	68 f7 00 00 00       	push   $0xf7
  jmp __alltraps
  1028cd:	e9 60 00 00 00       	jmp    102932 <__alltraps>

001028d2 <vector248>:
.globl vector248
vector248:
  pushl $0
  1028d2:	6a 00                	push   $0x0
  pushl $248
  1028d4:	68 f8 00 00 00       	push   $0xf8
  jmp __alltraps
  1028d9:	e9 54 00 00 00       	jmp    102932 <__alltraps>

001028de <vector249>:
.globl vector249
vector249:
  pushl $0
  1028de:	6a 00                	push   $0x0
  pushl $249
  1028e0:	68 f9 00 00 00       	push   $0xf9
  jmp __alltraps
  1028e5:	e9 48 00 00 00       	jmp    102932 <__alltraps>

001028ea <vector250>:
.globl vector250
vector250:
  pushl $0
  1028ea:	6a 00                	push   $0x0
  pushl $250
  1028ec:	68 fa 00 00 00       	push   $0xfa
  jmp __alltraps
  1028f1:	e9 3c 00 00 00       	jmp    102932 <__alltraps>

001028f6 <vector251>:
.globl vector251
vector251:
  pushl $0
  1028f6:	6a 00                	push   $0x0
  pushl $251
  1028f8:	68 fb 00 00 00       	push   $0xfb
  jmp __alltraps
  1028fd:	e9 30 00 00 00       	jmp    102932 <__alltraps>

00102902 <vector252>:
.globl vector252
vector252:
  pushl $0
  102902:	6a 00                	push   $0x0
  pushl $252
  102904:	68 fc 00 00 00       	push   $0xfc
  jmp __alltraps
  102909:	e9 24 00 00 00       	jmp    102932 <__alltraps>

0010290e <vector253>:
.globl vector253
vector253:
  pushl $0
  10290e:	6a 00                	push   $0x0
  pushl $253
  102910:	68 fd 00 00 00       	push   $0xfd
  jmp __alltraps
  102915:	e9 18 00 00 00       	jmp    102932 <__alltraps>

0010291a <vector254>:
.globl vector254
vector254:
  pushl $0
  10291a:	6a 00                	push   $0x0
  pushl $254
  10291c:	68 fe 00 00 00       	push   $0xfe
  jmp __alltraps
  102921:	e9 0c 00 00 00       	jmp    102932 <__alltraps>

00102926 <vector255>:
.globl vector255
vector255:
  pushl $0
  102926:	6a 00                	push   $0x0
  pushl $255
  102928:	68 ff 00 00 00       	push   $0xff
  jmp __alltraps
  10292d:	e9 00 00 00 00       	jmp    102932 <__alltraps>

00102932 <__alltraps>:
.text
.globl __alltraps
__alltraps:
    # push registers to build a trap frame
    # therefore make the stack look like a struct trapframe
    pushl %ds
  102932:	1e                   	push   %ds
    pushl %es
  102933:	06                   	push   %es
    pushl %fs
  102934:	0f a0                	push   %fs
    pushl %gs
  102936:	0f a8                	push   %gs
    pushal
  102938:	60                   	pusha  

    # load GD_KDATA into %ds and %es to set up data segments for kernel
    movl $GD_KDATA, %eax
  102939:	b8 10 00 00 00       	mov    $0x10,%eax
    movw %ax, %ds
  10293e:	8e d8                	mov    %eax,%ds
    movw %ax, %es
  102940:	8e c0                	mov    %eax,%es

    # push %esp to pass a pointer to the trapframe as an argument to trap()
    pushl %esp
  102942:	54                   	push   %esp

    # call trap(tf), where tf=%esp
    call trap
  102943:	e8 5f f5 ff ff       	call   101ea7 <trap>

    # pop the pushed stack pointer
    popl %esp
  102948:	5c                   	pop    %esp

00102949 <__trapret>:

    # return falls through to trapret...
.globl __trapret
__trapret:
    # restore registers from stack
    popal
  102949:	61                   	popa   

    # restore %ds, %es, %fs and %gs
    popl %gs
  10294a:	0f a9                	pop    %gs
    popl %fs
  10294c:	0f a1                	pop    %fs
    popl %es
  10294e:	07                   	pop    %es
    popl %ds
  10294f:	1f                   	pop    %ds

    # get rid of the trap number and error code
    addl $0x8, %esp
  102950:	83 c4 08             	add    $0x8,%esp
    iret
  102953:	cf                   	iret   

00102954 <lgdt>:
/* *
 * lgdt - load the global descriptor table register and reset the
 * data/code segement registers for kernel.
 * */
static inline void
lgdt(struct pseudodesc *pd) {
  102954:	55                   	push   %ebp
  102955:	89 e5                	mov    %esp,%ebp
    asm volatile ("lgdt (%0)" :: "r" (pd));
  102957:	8b 45 08             	mov    0x8(%ebp),%eax
  10295a:	0f 01 10             	lgdtl  (%eax)
    asm volatile ("movw %%ax, %%gs" :: "a" (USER_DS));
  10295d:	b8 23 00 00 00       	mov    $0x23,%eax
  102962:	8e e8                	mov    %eax,%gs
    asm volatile ("movw %%ax, %%fs" :: "a" (USER_DS));
  102964:	b8 23 00 00 00       	mov    $0x23,%eax
  102969:	8e e0                	mov    %eax,%fs
    asm volatile ("movw %%ax, %%es" :: "a" (KERNEL_DS));
  10296b:	b8 10 00 00 00       	mov    $0x10,%eax
  102970:	8e c0                	mov    %eax,%es
    asm volatile ("movw %%ax, %%ds" :: "a" (KERNEL_DS));
  102972:	b8 10 00 00 00       	mov    $0x10,%eax
  102977:	8e d8                	mov    %eax,%ds
    asm volatile ("movw %%ax, %%ss" :: "a" (KERNEL_DS));
  102979:	b8 10 00 00 00       	mov    $0x10,%eax
  10297e:	8e d0                	mov    %eax,%ss
    // reload cs
    asm volatile ("ljmp %0, $1f\n 1:\n" :: "i" (KERNEL_CS));
  102980:	ea 87 29 10 00 08 00 	ljmp   $0x8,$0x102987
}
  102987:	90                   	nop
  102988:	5d                   	pop    %ebp
  102989:	c3                   	ret    

0010298a <gdt_init>:
/* temporary kernel stack */
uint8_t stack0[1024];

/* gdt_init - initialize the default GDT and TSS */
static void
gdt_init(void) {
  10298a:	f3 0f 1e fb          	endbr32 
  10298e:	55                   	push   %ebp
  10298f:	89 e5                	mov    %esp,%ebp
  102991:	83 ec 10             	sub    $0x10,%esp
    // Setup a TSS so that we can get the right stack when we trap from
    // user to the kernel. But not safe here, it's only a temporary value,
    // it will be set to KSTACKTOP in lab2.
    ts.ts_esp0 = (uint32_t)&stack0 + sizeof(stack0);
  102994:	b8 20 09 11 00       	mov    $0x110920,%eax
  102999:	05 00 04 00 00       	add    $0x400,%eax
  10299e:	a3 a4 08 11 00       	mov    %eax,0x1108a4
    ts.ts_ss0 = KERNEL_DS;
  1029a3:	66 c7 05 a8 08 11 00 	movw   $0x10,0x1108a8
  1029aa:	10 00 

    // initialize the TSS filed of the gdt
    gdt[SEG_TSS] = SEG16(STS_T32A, (uint32_t)&ts, sizeof(ts), DPL_KERNEL);
  1029ac:	66 c7 05 08 fa 10 00 	movw   $0x68,0x10fa08
  1029b3:	68 00 
  1029b5:	b8 a0 08 11 00       	mov    $0x1108a0,%eax
  1029ba:	66 a3 0a fa 10 00    	mov    %ax,0x10fa0a
  1029c0:	b8 a0 08 11 00       	mov    $0x1108a0,%eax
  1029c5:	c1 e8 10             	shr    $0x10,%eax
  1029c8:	a2 0c fa 10 00       	mov    %al,0x10fa0c
  1029cd:	0f b6 05 0d fa 10 00 	movzbl 0x10fa0d,%eax
  1029d4:	83 e0 f0             	and    $0xfffffff0,%eax
  1029d7:	83 c8 09             	or     $0x9,%eax
  1029da:	a2 0d fa 10 00       	mov    %al,0x10fa0d
  1029df:	0f b6 05 0d fa 10 00 	movzbl 0x10fa0d,%eax
  1029e6:	83 c8 10             	or     $0x10,%eax
  1029e9:	a2 0d fa 10 00       	mov    %al,0x10fa0d
  1029ee:	0f b6 05 0d fa 10 00 	movzbl 0x10fa0d,%eax
  1029f5:	83 e0 9f             	and    $0xffffff9f,%eax
  1029f8:	a2 0d fa 10 00       	mov    %al,0x10fa0d
  1029fd:	0f b6 05 0d fa 10 00 	movzbl 0x10fa0d,%eax
  102a04:	83 c8 80             	or     $0xffffff80,%eax
  102a07:	a2 0d fa 10 00       	mov    %al,0x10fa0d
  102a0c:	0f b6 05 0e fa 10 00 	movzbl 0x10fa0e,%eax
  102a13:	83 e0 f0             	and    $0xfffffff0,%eax
  102a16:	a2 0e fa 10 00       	mov    %al,0x10fa0e
  102a1b:	0f b6 05 0e fa 10 00 	movzbl 0x10fa0e,%eax
  102a22:	83 e0 ef             	and    $0xffffffef,%eax
  102a25:	a2 0e fa 10 00       	mov    %al,0x10fa0e
  102a2a:	0f b6 05 0e fa 10 00 	movzbl 0x10fa0e,%eax
  102a31:	83 e0 df             	and    $0xffffffdf,%eax
  102a34:	a2 0e fa 10 00       	mov    %al,0x10fa0e
  102a39:	0f b6 05 0e fa 10 00 	movzbl 0x10fa0e,%eax
  102a40:	83 c8 40             	or     $0x40,%eax
  102a43:	a2 0e fa 10 00       	mov    %al,0x10fa0e
  102a48:	0f b6 05 0e fa 10 00 	movzbl 0x10fa0e,%eax
  102a4f:	83 e0 7f             	and    $0x7f,%eax
  102a52:	a2 0e fa 10 00       	mov    %al,0x10fa0e
  102a57:	b8 a0 08 11 00       	mov    $0x1108a0,%eax
  102a5c:	c1 e8 18             	shr    $0x18,%eax
  102a5f:	a2 0f fa 10 00       	mov    %al,0x10fa0f
    gdt[SEG_TSS].sd_s = 0;
  102a64:	0f b6 05 0d fa 10 00 	movzbl 0x10fa0d,%eax
  102a6b:	83 e0 ef             	and    $0xffffffef,%eax
  102a6e:	a2 0d fa 10 00       	mov    %al,0x10fa0d

    // reload all segment registers
    lgdt(&gdt_pd);
  102a73:	68 10 fa 10 00       	push   $0x10fa10
  102a78:	e8 d7 fe ff ff       	call   102954 <lgdt>
  102a7d:	83 c4 04             	add    $0x4,%esp
  102a80:	66 c7 45 fe 28 00    	movw   $0x28,-0x2(%ebp)

static inline void
ltr(uint16_t sel) {
    asm volatile ("ltr %0" :: "r" (sel));
  102a86:	0f b7 45 fe          	movzwl -0x2(%ebp),%eax
  102a8a:	0f 00 d8             	ltr    %ax
}
  102a8d:	90                   	nop

    // load the TSS
    ltr(GD_TSS);
}
  102a8e:	90                   	nop
  102a8f:	c9                   	leave  
  102a90:	c3                   	ret    

00102a91 <pmm_init>:

/* pmm_init - initialize the physical memory management */
void
pmm_init(void) {
  102a91:	f3 0f 1e fb          	endbr32 
  102a95:	55                   	push   %ebp
  102a96:	89 e5                	mov    %esp,%ebp
    gdt_init();
  102a98:	e8 ed fe ff ff       	call   10298a <gdt_init>
}
  102a9d:	90                   	nop
  102a9e:	5d                   	pop    %ebp
  102a9f:	c3                   	ret    

00102aa0 <strlen>:
 * @s:        the input string
 *
 * The strlen() function returns the length of string @s.
 * */
size_t
strlen(const char *s) {
  102aa0:	f3 0f 1e fb          	endbr32 
  102aa4:	55                   	push   %ebp
  102aa5:	89 e5                	mov    %esp,%ebp
  102aa7:	83 ec 10             	sub    $0x10,%esp
    size_t cnt = 0;
  102aaa:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    while (*s ++ != '\0') {
  102ab1:	eb 04                	jmp    102ab7 <strlen+0x17>
        cnt ++;
  102ab3:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    while (*s ++ != '\0') {
  102ab7:	8b 45 08             	mov    0x8(%ebp),%eax
  102aba:	8d 50 01             	lea    0x1(%eax),%edx
  102abd:	89 55 08             	mov    %edx,0x8(%ebp)
  102ac0:	0f b6 00             	movzbl (%eax),%eax
  102ac3:	84 c0                	test   %al,%al
  102ac5:	75 ec                	jne    102ab3 <strlen+0x13>
    }
    return cnt;
  102ac7:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  102aca:	c9                   	leave  
  102acb:	c3                   	ret    

00102acc <strnlen>:
 * The return value is strlen(s), if that is less than @len, or
 * @len if there is no '\0' character among the first @len characters
 * pointed by @s.
 * */
size_t
strnlen(const char *s, size_t len) {
  102acc:	f3 0f 1e fb          	endbr32 
  102ad0:	55                   	push   %ebp
  102ad1:	89 e5                	mov    %esp,%ebp
  102ad3:	83 ec 10             	sub    $0x10,%esp
    size_t cnt = 0;
  102ad6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    while (cnt < len && *s ++ != '\0') {
  102add:	eb 04                	jmp    102ae3 <strnlen+0x17>
        cnt ++;
  102adf:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    while (cnt < len && *s ++ != '\0') {
  102ae3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  102ae6:	3b 45 0c             	cmp    0xc(%ebp),%eax
  102ae9:	73 10                	jae    102afb <strnlen+0x2f>
  102aeb:	8b 45 08             	mov    0x8(%ebp),%eax
  102aee:	8d 50 01             	lea    0x1(%eax),%edx
  102af1:	89 55 08             	mov    %edx,0x8(%ebp)
  102af4:	0f b6 00             	movzbl (%eax),%eax
  102af7:	84 c0                	test   %al,%al
  102af9:	75 e4                	jne    102adf <strnlen+0x13>
    }
    return cnt;
  102afb:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  102afe:	c9                   	leave  
  102aff:	c3                   	ret    

00102b00 <strcpy>:
 * To avoid overflows, the size of array pointed by @dst should be long enough to
 * contain the same string as @src (including the terminating null character), and
 * should not overlap in memory with @src.
 * */
char *
strcpy(char *dst, const char *src) {
  102b00:	f3 0f 1e fb          	endbr32 
  102b04:	55                   	push   %ebp
  102b05:	89 e5                	mov    %esp,%ebp
  102b07:	57                   	push   %edi
  102b08:	56                   	push   %esi
  102b09:	83 ec 20             	sub    $0x20,%esp
  102b0c:	8b 45 08             	mov    0x8(%ebp),%eax
  102b0f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  102b12:	8b 45 0c             	mov    0xc(%ebp),%eax
  102b15:	89 45 f0             	mov    %eax,-0x10(%ebp)
#ifndef __HAVE_ARCH_STRCPY
#define __HAVE_ARCH_STRCPY
static inline char *
__strcpy(char *dst, const char *src) {
    int d0, d1, d2;
    asm volatile (
  102b18:	8b 55 f0             	mov    -0x10(%ebp),%edx
  102b1b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102b1e:	89 d1                	mov    %edx,%ecx
  102b20:	89 c2                	mov    %eax,%edx
  102b22:	89 ce                	mov    %ecx,%esi
  102b24:	89 d7                	mov    %edx,%edi
  102b26:	ac                   	lods   %ds:(%esi),%al
  102b27:	aa                   	stos   %al,%es:(%edi)
  102b28:	84 c0                	test   %al,%al
  102b2a:	75 fa                	jne    102b26 <strcpy+0x26>
  102b2c:	89 fa                	mov    %edi,%edx
  102b2e:	89 f1                	mov    %esi,%ecx
  102b30:	89 4d ec             	mov    %ecx,-0x14(%ebp)
  102b33:	89 55 e8             	mov    %edx,-0x18(%ebp)
  102b36:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "stosb;"
            "testb %%al, %%al;"
            "jne 1b;"
            : "=&S" (d0), "=&D" (d1), "=&a" (d2)
            : "0" (src), "1" (dst) : "memory");
    return dst;
  102b39:	8b 45 f4             	mov    -0xc(%ebp),%eax
    char *p = dst;
    while ((*p ++ = *src ++) != '\0')
        /* nothing */;
    return dst;
#endif /* __HAVE_ARCH_STRCPY */
}
  102b3c:	83 c4 20             	add    $0x20,%esp
  102b3f:	5e                   	pop    %esi
  102b40:	5f                   	pop    %edi
  102b41:	5d                   	pop    %ebp
  102b42:	c3                   	ret    

00102b43 <strncpy>:
 * @len:    maximum number of characters to be copied from @src
 *
 * The return value is @dst
 * */
char *
strncpy(char *dst, const char *src, size_t len) {
  102b43:	f3 0f 1e fb          	endbr32 
  102b47:	55                   	push   %ebp
  102b48:	89 e5                	mov    %esp,%ebp
  102b4a:	83 ec 10             	sub    $0x10,%esp
    char *p = dst;
  102b4d:	8b 45 08             	mov    0x8(%ebp),%eax
  102b50:	89 45 fc             	mov    %eax,-0x4(%ebp)
    while (len > 0) {
  102b53:	eb 21                	jmp    102b76 <strncpy+0x33>
        if ((*p = *src) != '\0') {
  102b55:	8b 45 0c             	mov    0xc(%ebp),%eax
  102b58:	0f b6 10             	movzbl (%eax),%edx
  102b5b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  102b5e:	88 10                	mov    %dl,(%eax)
  102b60:	8b 45 fc             	mov    -0x4(%ebp),%eax
  102b63:	0f b6 00             	movzbl (%eax),%eax
  102b66:	84 c0                	test   %al,%al
  102b68:	74 04                	je     102b6e <strncpy+0x2b>
            src ++;
  102b6a:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
        }
        p ++, len --;
  102b6e:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  102b72:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
    while (len > 0) {
  102b76:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  102b7a:	75 d9                	jne    102b55 <strncpy+0x12>
    }
    return dst;
  102b7c:	8b 45 08             	mov    0x8(%ebp),%eax
}
  102b7f:	c9                   	leave  
  102b80:	c3                   	ret    

00102b81 <strcmp>:
 * - A value greater than zero indicates that the first character that does
 *   not match has a greater value in @s1 than in @s2;
 * - And a value less than zero indicates the opposite.
 * */
int
strcmp(const char *s1, const char *s2) {
  102b81:	f3 0f 1e fb          	endbr32 
  102b85:	55                   	push   %ebp
  102b86:	89 e5                	mov    %esp,%ebp
  102b88:	57                   	push   %edi
  102b89:	56                   	push   %esi
  102b8a:	83 ec 20             	sub    $0x20,%esp
  102b8d:	8b 45 08             	mov    0x8(%ebp),%eax
  102b90:	89 45 f4             	mov    %eax,-0xc(%ebp)
  102b93:	8b 45 0c             	mov    0xc(%ebp),%eax
  102b96:	89 45 f0             	mov    %eax,-0x10(%ebp)
    asm volatile (
  102b99:	8b 55 f4             	mov    -0xc(%ebp),%edx
  102b9c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102b9f:	89 d1                	mov    %edx,%ecx
  102ba1:	89 c2                	mov    %eax,%edx
  102ba3:	89 ce                	mov    %ecx,%esi
  102ba5:	89 d7                	mov    %edx,%edi
  102ba7:	ac                   	lods   %ds:(%esi),%al
  102ba8:	ae                   	scas   %es:(%edi),%al
  102ba9:	75 08                	jne    102bb3 <strcmp+0x32>
  102bab:	84 c0                	test   %al,%al
  102bad:	75 f8                	jne    102ba7 <strcmp+0x26>
  102baf:	31 c0                	xor    %eax,%eax
  102bb1:	eb 04                	jmp    102bb7 <strcmp+0x36>
  102bb3:	19 c0                	sbb    %eax,%eax
  102bb5:	0c 01                	or     $0x1,%al
  102bb7:	89 fa                	mov    %edi,%edx
  102bb9:	89 f1                	mov    %esi,%ecx
  102bbb:	89 45 ec             	mov    %eax,-0x14(%ebp)
  102bbe:	89 4d e8             	mov    %ecx,-0x18(%ebp)
  102bc1:	89 55 e4             	mov    %edx,-0x1c(%ebp)
    return ret;
  102bc4:	8b 45 ec             	mov    -0x14(%ebp),%eax
    while (*s1 != '\0' && *s1 == *s2) {
        s1 ++, s2 ++;
    }
    return (int)((unsigned char)*s1 - (unsigned char)*s2);
#endif /* __HAVE_ARCH_STRCMP */
}
  102bc7:	83 c4 20             	add    $0x20,%esp
  102bca:	5e                   	pop    %esi
  102bcb:	5f                   	pop    %edi
  102bcc:	5d                   	pop    %ebp
  102bcd:	c3                   	ret    

00102bce <strncmp>:
 * they are equal to each other, it continues with the following pairs until
 * the characters differ, until a terminating null-character is reached, or
 * until @n characters match in both strings, whichever happens first.
 * */
int
strncmp(const char *s1, const char *s2, size_t n) {
  102bce:	f3 0f 1e fb          	endbr32 
  102bd2:	55                   	push   %ebp
  102bd3:	89 e5                	mov    %esp,%ebp
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
  102bd5:	eb 0c                	jmp    102be3 <strncmp+0x15>
        n --, s1 ++, s2 ++;
  102bd7:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
  102bdb:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  102bdf:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
  102be3:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  102be7:	74 1a                	je     102c03 <strncmp+0x35>
  102be9:	8b 45 08             	mov    0x8(%ebp),%eax
  102bec:	0f b6 00             	movzbl (%eax),%eax
  102bef:	84 c0                	test   %al,%al
  102bf1:	74 10                	je     102c03 <strncmp+0x35>
  102bf3:	8b 45 08             	mov    0x8(%ebp),%eax
  102bf6:	0f b6 10             	movzbl (%eax),%edx
  102bf9:	8b 45 0c             	mov    0xc(%ebp),%eax
  102bfc:	0f b6 00             	movzbl (%eax),%eax
  102bff:	38 c2                	cmp    %al,%dl
  102c01:	74 d4                	je     102bd7 <strncmp+0x9>
    }
    return (n == 0) ? 0 : (int)((unsigned char)*s1 - (unsigned char)*s2);
  102c03:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  102c07:	74 18                	je     102c21 <strncmp+0x53>
  102c09:	8b 45 08             	mov    0x8(%ebp),%eax
  102c0c:	0f b6 00             	movzbl (%eax),%eax
  102c0f:	0f b6 d0             	movzbl %al,%edx
  102c12:	8b 45 0c             	mov    0xc(%ebp),%eax
  102c15:	0f b6 00             	movzbl (%eax),%eax
  102c18:	0f b6 c0             	movzbl %al,%eax
  102c1b:	29 c2                	sub    %eax,%edx
  102c1d:	89 d0                	mov    %edx,%eax
  102c1f:	eb 05                	jmp    102c26 <strncmp+0x58>
  102c21:	b8 00 00 00 00       	mov    $0x0,%eax
}
  102c26:	5d                   	pop    %ebp
  102c27:	c3                   	ret    

00102c28 <strchr>:
 *
 * The strchr() function returns a pointer to the first occurrence of
 * character in @s. If the value is not found, the function returns 'NULL'.
 * */
char *
strchr(const char *s, char c) {
  102c28:	f3 0f 1e fb          	endbr32 
  102c2c:	55                   	push   %ebp
  102c2d:	89 e5                	mov    %esp,%ebp
  102c2f:	83 ec 04             	sub    $0x4,%esp
  102c32:	8b 45 0c             	mov    0xc(%ebp),%eax
  102c35:	88 45 fc             	mov    %al,-0x4(%ebp)
    while (*s != '\0') {
  102c38:	eb 14                	jmp    102c4e <strchr+0x26>
        if (*s == c) {
  102c3a:	8b 45 08             	mov    0x8(%ebp),%eax
  102c3d:	0f b6 00             	movzbl (%eax),%eax
  102c40:	38 45 fc             	cmp    %al,-0x4(%ebp)
  102c43:	75 05                	jne    102c4a <strchr+0x22>
            return (char *)s;
  102c45:	8b 45 08             	mov    0x8(%ebp),%eax
  102c48:	eb 13                	jmp    102c5d <strchr+0x35>
        }
        s ++;
  102c4a:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    while (*s != '\0') {
  102c4e:	8b 45 08             	mov    0x8(%ebp),%eax
  102c51:	0f b6 00             	movzbl (%eax),%eax
  102c54:	84 c0                	test   %al,%al
  102c56:	75 e2                	jne    102c3a <strchr+0x12>
    }
    return NULL;
  102c58:	b8 00 00 00 00       	mov    $0x0,%eax
}
  102c5d:	c9                   	leave  
  102c5e:	c3                   	ret    

00102c5f <strfind>:
 * The strfind() function is like strchr() except that if @c is
 * not found in @s, then it returns a pointer to the null byte at the
 * end of @s, rather than 'NULL'.
 * */
char *
strfind(const char *s, char c) {
  102c5f:	f3 0f 1e fb          	endbr32 
  102c63:	55                   	push   %ebp
  102c64:	89 e5                	mov    %esp,%ebp
  102c66:	83 ec 04             	sub    $0x4,%esp
  102c69:	8b 45 0c             	mov    0xc(%ebp),%eax
  102c6c:	88 45 fc             	mov    %al,-0x4(%ebp)
    while (*s != '\0') {
  102c6f:	eb 0f                	jmp    102c80 <strfind+0x21>
        if (*s == c) {
  102c71:	8b 45 08             	mov    0x8(%ebp),%eax
  102c74:	0f b6 00             	movzbl (%eax),%eax
  102c77:	38 45 fc             	cmp    %al,-0x4(%ebp)
  102c7a:	74 10                	je     102c8c <strfind+0x2d>
            break;
        }
        s ++;
  102c7c:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    while (*s != '\0') {
  102c80:	8b 45 08             	mov    0x8(%ebp),%eax
  102c83:	0f b6 00             	movzbl (%eax),%eax
  102c86:	84 c0                	test   %al,%al
  102c88:	75 e7                	jne    102c71 <strfind+0x12>
  102c8a:	eb 01                	jmp    102c8d <strfind+0x2e>
            break;
  102c8c:	90                   	nop
    }
    return (char *)s;
  102c8d:	8b 45 08             	mov    0x8(%ebp),%eax
}
  102c90:	c9                   	leave  
  102c91:	c3                   	ret    

00102c92 <strtol>:
 * an optional "0x" or "0X" prefix.
 *
 * The strtol() function returns the converted integral number as a long int value.
 * */
long
strtol(const char *s, char **endptr, int base) {
  102c92:	f3 0f 1e fb          	endbr32 
  102c96:	55                   	push   %ebp
  102c97:	89 e5                	mov    %esp,%ebp
  102c99:	83 ec 10             	sub    $0x10,%esp
    int neg = 0;
  102c9c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    long val = 0;
  102ca3:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

    // gobble initial whitespace
    while (*s == ' ' || *s == '\t') {
  102caa:	eb 04                	jmp    102cb0 <strtol+0x1e>
        s ++;
  102cac:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    while (*s == ' ' || *s == '\t') {
  102cb0:	8b 45 08             	mov    0x8(%ebp),%eax
  102cb3:	0f b6 00             	movzbl (%eax),%eax
  102cb6:	3c 20                	cmp    $0x20,%al
  102cb8:	74 f2                	je     102cac <strtol+0x1a>
  102cba:	8b 45 08             	mov    0x8(%ebp),%eax
  102cbd:	0f b6 00             	movzbl (%eax),%eax
  102cc0:	3c 09                	cmp    $0x9,%al
  102cc2:	74 e8                	je     102cac <strtol+0x1a>
    }

    // plus/minus sign
    if (*s == '+') {
  102cc4:	8b 45 08             	mov    0x8(%ebp),%eax
  102cc7:	0f b6 00             	movzbl (%eax),%eax
  102cca:	3c 2b                	cmp    $0x2b,%al
  102ccc:	75 06                	jne    102cd4 <strtol+0x42>
        s ++;
  102cce:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  102cd2:	eb 15                	jmp    102ce9 <strtol+0x57>
    }
    else if (*s == '-') {
  102cd4:	8b 45 08             	mov    0x8(%ebp),%eax
  102cd7:	0f b6 00             	movzbl (%eax),%eax
  102cda:	3c 2d                	cmp    $0x2d,%al
  102cdc:	75 0b                	jne    102ce9 <strtol+0x57>
        s ++, neg = 1;
  102cde:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  102ce2:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
    }

    // hex or octal base prefix
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x')) {
  102ce9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  102ced:	74 06                	je     102cf5 <strtol+0x63>
  102cef:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  102cf3:	75 24                	jne    102d19 <strtol+0x87>
  102cf5:	8b 45 08             	mov    0x8(%ebp),%eax
  102cf8:	0f b6 00             	movzbl (%eax),%eax
  102cfb:	3c 30                	cmp    $0x30,%al
  102cfd:	75 1a                	jne    102d19 <strtol+0x87>
  102cff:	8b 45 08             	mov    0x8(%ebp),%eax
  102d02:	83 c0 01             	add    $0x1,%eax
  102d05:	0f b6 00             	movzbl (%eax),%eax
  102d08:	3c 78                	cmp    $0x78,%al
  102d0a:	75 0d                	jne    102d19 <strtol+0x87>
        s += 2, base = 16;
  102d0c:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  102d10:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  102d17:	eb 2a                	jmp    102d43 <strtol+0xb1>
    }
    else if (base == 0 && s[0] == '0') {
  102d19:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  102d1d:	75 17                	jne    102d36 <strtol+0xa4>
  102d1f:	8b 45 08             	mov    0x8(%ebp),%eax
  102d22:	0f b6 00             	movzbl (%eax),%eax
  102d25:	3c 30                	cmp    $0x30,%al
  102d27:	75 0d                	jne    102d36 <strtol+0xa4>
        s ++, base = 8;
  102d29:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  102d2d:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  102d34:	eb 0d                	jmp    102d43 <strtol+0xb1>
    }
    else if (base == 0) {
  102d36:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  102d3a:	75 07                	jne    102d43 <strtol+0xb1>
        base = 10;
  102d3c:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

    // digits
    while (1) {
        int dig;

        if (*s >= '0' && *s <= '9') {
  102d43:	8b 45 08             	mov    0x8(%ebp),%eax
  102d46:	0f b6 00             	movzbl (%eax),%eax
  102d49:	3c 2f                	cmp    $0x2f,%al
  102d4b:	7e 1b                	jle    102d68 <strtol+0xd6>
  102d4d:	8b 45 08             	mov    0x8(%ebp),%eax
  102d50:	0f b6 00             	movzbl (%eax),%eax
  102d53:	3c 39                	cmp    $0x39,%al
  102d55:	7f 11                	jg     102d68 <strtol+0xd6>
            dig = *s - '0';
  102d57:	8b 45 08             	mov    0x8(%ebp),%eax
  102d5a:	0f b6 00             	movzbl (%eax),%eax
  102d5d:	0f be c0             	movsbl %al,%eax
  102d60:	83 e8 30             	sub    $0x30,%eax
  102d63:	89 45 f4             	mov    %eax,-0xc(%ebp)
  102d66:	eb 48                	jmp    102db0 <strtol+0x11e>
        }
        else if (*s >= 'a' && *s <= 'z') {
  102d68:	8b 45 08             	mov    0x8(%ebp),%eax
  102d6b:	0f b6 00             	movzbl (%eax),%eax
  102d6e:	3c 60                	cmp    $0x60,%al
  102d70:	7e 1b                	jle    102d8d <strtol+0xfb>
  102d72:	8b 45 08             	mov    0x8(%ebp),%eax
  102d75:	0f b6 00             	movzbl (%eax),%eax
  102d78:	3c 7a                	cmp    $0x7a,%al
  102d7a:	7f 11                	jg     102d8d <strtol+0xfb>
            dig = *s - 'a' + 10;
  102d7c:	8b 45 08             	mov    0x8(%ebp),%eax
  102d7f:	0f b6 00             	movzbl (%eax),%eax
  102d82:	0f be c0             	movsbl %al,%eax
  102d85:	83 e8 57             	sub    $0x57,%eax
  102d88:	89 45 f4             	mov    %eax,-0xc(%ebp)
  102d8b:	eb 23                	jmp    102db0 <strtol+0x11e>
        }
        else if (*s >= 'A' && *s <= 'Z') {
  102d8d:	8b 45 08             	mov    0x8(%ebp),%eax
  102d90:	0f b6 00             	movzbl (%eax),%eax
  102d93:	3c 40                	cmp    $0x40,%al
  102d95:	7e 3c                	jle    102dd3 <strtol+0x141>
  102d97:	8b 45 08             	mov    0x8(%ebp),%eax
  102d9a:	0f b6 00             	movzbl (%eax),%eax
  102d9d:	3c 5a                	cmp    $0x5a,%al
  102d9f:	7f 32                	jg     102dd3 <strtol+0x141>
            dig = *s - 'A' + 10;
  102da1:	8b 45 08             	mov    0x8(%ebp),%eax
  102da4:	0f b6 00             	movzbl (%eax),%eax
  102da7:	0f be c0             	movsbl %al,%eax
  102daa:	83 e8 37             	sub    $0x37,%eax
  102dad:	89 45 f4             	mov    %eax,-0xc(%ebp)
        }
        else {
            break;
        }
        if (dig >= base) {
  102db0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102db3:	3b 45 10             	cmp    0x10(%ebp),%eax
  102db6:	7d 1a                	jge    102dd2 <strtol+0x140>
            break;
        }
        s ++, val = (val * base) + dig;
  102db8:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  102dbc:	8b 45 f8             	mov    -0x8(%ebp),%eax
  102dbf:	0f af 45 10          	imul   0x10(%ebp),%eax
  102dc3:	89 c2                	mov    %eax,%edx
  102dc5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102dc8:	01 d0                	add    %edx,%eax
  102dca:	89 45 f8             	mov    %eax,-0x8(%ebp)
    while (1) {
  102dcd:	e9 71 ff ff ff       	jmp    102d43 <strtol+0xb1>
            break;
  102dd2:	90                   	nop
        // we don't properly detect overflow!
    }

    if (endptr) {
  102dd3:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  102dd7:	74 08                	je     102de1 <strtol+0x14f>
        *endptr = (char *) s;
  102dd9:	8b 45 0c             	mov    0xc(%ebp),%eax
  102ddc:	8b 55 08             	mov    0x8(%ebp),%edx
  102ddf:	89 10                	mov    %edx,(%eax)
    }
    return (neg ? -val : val);
  102de1:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  102de5:	74 07                	je     102dee <strtol+0x15c>
  102de7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  102dea:	f7 d8                	neg    %eax
  102dec:	eb 03                	jmp    102df1 <strtol+0x15f>
  102dee:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  102df1:	c9                   	leave  
  102df2:	c3                   	ret    

00102df3 <memset>:
 * @n:        number of bytes to be set to the value
 *
 * The memset() function returns @s.
 * */
void *
memset(void *s, char c, size_t n) {
  102df3:	f3 0f 1e fb          	endbr32 
  102df7:	55                   	push   %ebp
  102df8:	89 e5                	mov    %esp,%ebp
  102dfa:	57                   	push   %edi
  102dfb:	83 ec 24             	sub    $0x24,%esp
  102dfe:	8b 45 0c             	mov    0xc(%ebp),%eax
  102e01:	88 45 d8             	mov    %al,-0x28(%ebp)
#ifdef __HAVE_ARCH_MEMSET
    return __memset(s, c, n);
  102e04:	0f be 45 d8          	movsbl -0x28(%ebp),%eax
  102e08:	8b 55 08             	mov    0x8(%ebp),%edx
  102e0b:	89 55 f8             	mov    %edx,-0x8(%ebp)
  102e0e:	88 45 f7             	mov    %al,-0x9(%ebp)
  102e11:	8b 45 10             	mov    0x10(%ebp),%eax
  102e14:	89 45 f0             	mov    %eax,-0x10(%ebp)
#ifndef __HAVE_ARCH_MEMSET
#define __HAVE_ARCH_MEMSET
static inline void *
__memset(void *s, char c, size_t n) {
    int d0, d1;
    asm volatile (
  102e17:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  102e1a:	0f b6 45 f7          	movzbl -0x9(%ebp),%eax
  102e1e:	8b 55 f8             	mov    -0x8(%ebp),%edx
  102e21:	89 d7                	mov    %edx,%edi
  102e23:	f3 aa                	rep stos %al,%es:(%edi)
  102e25:	89 fa                	mov    %edi,%edx
  102e27:	89 4d ec             	mov    %ecx,-0x14(%ebp)
  102e2a:	89 55 e8             	mov    %edx,-0x18(%ebp)
            "rep; stosb;"
            : "=&c" (d0), "=&D" (d1)
            : "0" (n), "a" (c), "1" (s)
            : "memory");
    return s;
  102e2d:	8b 45 f8             	mov    -0x8(%ebp),%eax
    while (n -- > 0) {
        *p ++ = c;
    }
    return s;
#endif /* __HAVE_ARCH_MEMSET */
}
  102e30:	83 c4 24             	add    $0x24,%esp
  102e33:	5f                   	pop    %edi
  102e34:	5d                   	pop    %ebp
  102e35:	c3                   	ret    

00102e36 <memmove>:
 * @n:        number of bytes to copy
 *
 * The memmove() function returns @dst.
 * */
void *
memmove(void *dst, const void *src, size_t n) {
  102e36:	f3 0f 1e fb          	endbr32 
  102e3a:	55                   	push   %ebp
  102e3b:	89 e5                	mov    %esp,%ebp
  102e3d:	57                   	push   %edi
  102e3e:	56                   	push   %esi
  102e3f:	53                   	push   %ebx
  102e40:	83 ec 30             	sub    $0x30,%esp
  102e43:	8b 45 08             	mov    0x8(%ebp),%eax
  102e46:	89 45 f0             	mov    %eax,-0x10(%ebp)
  102e49:	8b 45 0c             	mov    0xc(%ebp),%eax
  102e4c:	89 45 ec             	mov    %eax,-0x14(%ebp)
  102e4f:	8b 45 10             	mov    0x10(%ebp),%eax
  102e52:	89 45 e8             	mov    %eax,-0x18(%ebp)

#ifndef __HAVE_ARCH_MEMMOVE
#define __HAVE_ARCH_MEMMOVE
static inline void *
__memmove(void *dst, const void *src, size_t n) {
    if (dst < src) {
  102e55:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102e58:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  102e5b:	73 42                	jae    102e9f <memmove+0x69>
  102e5d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102e60:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  102e63:	8b 45 ec             	mov    -0x14(%ebp),%eax
  102e66:	89 45 e0             	mov    %eax,-0x20(%ebp)
  102e69:	8b 45 e8             	mov    -0x18(%ebp),%eax
  102e6c:	89 45 dc             	mov    %eax,-0x24(%ebp)
            "andl $3, %%ecx;"
            "jz 1f;"
            "rep; movsb;"
            "1:"
            : "=&c" (d0), "=&D" (d1), "=&S" (d2)
            : "0" (n / 4), "g" (n), "1" (dst), "2" (src)
  102e6f:	8b 45 dc             	mov    -0x24(%ebp),%eax
  102e72:	c1 e8 02             	shr    $0x2,%eax
  102e75:	89 c1                	mov    %eax,%ecx
    asm volatile (
  102e77:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  102e7a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  102e7d:	89 d7                	mov    %edx,%edi
  102e7f:	89 c6                	mov    %eax,%esi
  102e81:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  102e83:	8b 4d dc             	mov    -0x24(%ebp),%ecx
  102e86:	83 e1 03             	and    $0x3,%ecx
  102e89:	74 02                	je     102e8d <memmove+0x57>
  102e8b:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  102e8d:	89 f0                	mov    %esi,%eax
  102e8f:	89 fa                	mov    %edi,%edx
  102e91:	89 4d d8             	mov    %ecx,-0x28(%ebp)
  102e94:	89 55 d4             	mov    %edx,-0x2c(%ebp)
  102e97:	89 45 d0             	mov    %eax,-0x30(%ebp)
            : "memory");
    return dst;
  102e9a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
        return __memcpy(dst, src, n);
  102e9d:	eb 36                	jmp    102ed5 <memmove+0x9f>
            : "0" (n), "1" (n - 1 + src), "2" (n - 1 + dst)
  102e9f:	8b 45 e8             	mov    -0x18(%ebp),%eax
  102ea2:	8d 50 ff             	lea    -0x1(%eax),%edx
  102ea5:	8b 45 ec             	mov    -0x14(%ebp),%eax
  102ea8:	01 c2                	add    %eax,%edx
  102eaa:	8b 45 e8             	mov    -0x18(%ebp),%eax
  102ead:	8d 48 ff             	lea    -0x1(%eax),%ecx
  102eb0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102eb3:	8d 1c 01             	lea    (%ecx,%eax,1),%ebx
    asm volatile (
  102eb6:	8b 45 e8             	mov    -0x18(%ebp),%eax
  102eb9:	89 c1                	mov    %eax,%ecx
  102ebb:	89 d8                	mov    %ebx,%eax
  102ebd:	89 d6                	mov    %edx,%esi
  102ebf:	89 c7                	mov    %eax,%edi
  102ec1:	fd                   	std    
  102ec2:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  102ec4:	fc                   	cld    
  102ec5:	89 f8                	mov    %edi,%eax
  102ec7:	89 f2                	mov    %esi,%edx
  102ec9:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  102ecc:	89 55 c8             	mov    %edx,-0x38(%ebp)
  102ecf:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    return dst;
  102ed2:	8b 45 f0             	mov    -0x10(%ebp),%eax
            *d ++ = *s ++;
        }
    }
    return dst;
#endif /* __HAVE_ARCH_MEMMOVE */
}
  102ed5:	83 c4 30             	add    $0x30,%esp
  102ed8:	5b                   	pop    %ebx
  102ed9:	5e                   	pop    %esi
  102eda:	5f                   	pop    %edi
  102edb:	5d                   	pop    %ebp
  102edc:	c3                   	ret    

00102edd <memcpy>:
 * it always copies exactly @n bytes. To avoid overflows, the size of arrays pointed
 * by both @src and @dst, should be at least @n bytes, and should not overlap
 * (for overlapping memory area, memmove is a safer approach).
 * */
void *
memcpy(void *dst, const void *src, size_t n) {
  102edd:	f3 0f 1e fb          	endbr32 
  102ee1:	55                   	push   %ebp
  102ee2:	89 e5                	mov    %esp,%ebp
  102ee4:	57                   	push   %edi
  102ee5:	56                   	push   %esi
  102ee6:	83 ec 20             	sub    $0x20,%esp
  102ee9:	8b 45 08             	mov    0x8(%ebp),%eax
  102eec:	89 45 f4             	mov    %eax,-0xc(%ebp)
  102eef:	8b 45 0c             	mov    0xc(%ebp),%eax
  102ef2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  102ef5:	8b 45 10             	mov    0x10(%ebp),%eax
  102ef8:	89 45 ec             	mov    %eax,-0x14(%ebp)
            : "0" (n / 4), "g" (n), "1" (dst), "2" (src)
  102efb:	8b 45 ec             	mov    -0x14(%ebp),%eax
  102efe:	c1 e8 02             	shr    $0x2,%eax
  102f01:	89 c1                	mov    %eax,%ecx
    asm volatile (
  102f03:	8b 55 f4             	mov    -0xc(%ebp),%edx
  102f06:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102f09:	89 d7                	mov    %edx,%edi
  102f0b:	89 c6                	mov    %eax,%esi
  102f0d:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  102f0f:	8b 4d ec             	mov    -0x14(%ebp),%ecx
  102f12:	83 e1 03             	and    $0x3,%ecx
  102f15:	74 02                	je     102f19 <memcpy+0x3c>
  102f17:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  102f19:	89 f0                	mov    %esi,%eax
  102f1b:	89 fa                	mov    %edi,%edx
  102f1d:	89 4d e8             	mov    %ecx,-0x18(%ebp)
  102f20:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  102f23:	89 45 e0             	mov    %eax,-0x20(%ebp)
    return dst;
  102f26:	8b 45 f4             	mov    -0xc(%ebp),%eax
    while (n -- > 0) {
        *d ++ = *s ++;
    }
    return dst;
#endif /* __HAVE_ARCH_MEMCPY */
}
  102f29:	83 c4 20             	add    $0x20,%esp
  102f2c:	5e                   	pop    %esi
  102f2d:	5f                   	pop    %edi
  102f2e:	5d                   	pop    %ebp
  102f2f:	c3                   	ret    

00102f30 <memcmp>:
 *   match in both memory blocks has a greater value in @v1 than in @v2
 *   as if evaluated as unsigned char values;
 * - And a value less than zero indicates the opposite.
 * */
int
memcmp(const void *v1, const void *v2, size_t n) {
  102f30:	f3 0f 1e fb          	endbr32 
  102f34:	55                   	push   %ebp
  102f35:	89 e5                	mov    %esp,%ebp
  102f37:	83 ec 10             	sub    $0x10,%esp
    const char *s1 = (const char *)v1;
  102f3a:	8b 45 08             	mov    0x8(%ebp),%eax
  102f3d:	89 45 fc             	mov    %eax,-0x4(%ebp)
    const char *s2 = (const char *)v2;
  102f40:	8b 45 0c             	mov    0xc(%ebp),%eax
  102f43:	89 45 f8             	mov    %eax,-0x8(%ebp)
    while (n -- > 0) {
  102f46:	eb 30                	jmp    102f78 <memcmp+0x48>
        if (*s1 != *s2) {
  102f48:	8b 45 fc             	mov    -0x4(%ebp),%eax
  102f4b:	0f b6 10             	movzbl (%eax),%edx
  102f4e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  102f51:	0f b6 00             	movzbl (%eax),%eax
  102f54:	38 c2                	cmp    %al,%dl
  102f56:	74 18                	je     102f70 <memcmp+0x40>
            return (int)((unsigned char)*s1 - (unsigned char)*s2);
  102f58:	8b 45 fc             	mov    -0x4(%ebp),%eax
  102f5b:	0f b6 00             	movzbl (%eax),%eax
  102f5e:	0f b6 d0             	movzbl %al,%edx
  102f61:	8b 45 f8             	mov    -0x8(%ebp),%eax
  102f64:	0f b6 00             	movzbl (%eax),%eax
  102f67:	0f b6 c0             	movzbl %al,%eax
  102f6a:	29 c2                	sub    %eax,%edx
  102f6c:	89 d0                	mov    %edx,%eax
  102f6e:	eb 1a                	jmp    102f8a <memcmp+0x5a>
        }
        s1 ++, s2 ++;
  102f70:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  102f74:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    while (n -- > 0) {
  102f78:	8b 45 10             	mov    0x10(%ebp),%eax
  102f7b:	8d 50 ff             	lea    -0x1(%eax),%edx
  102f7e:	89 55 10             	mov    %edx,0x10(%ebp)
  102f81:	85 c0                	test   %eax,%eax
  102f83:	75 c3                	jne    102f48 <memcmp+0x18>
    }
    return 0;
  102f85:	b8 00 00 00 00       	mov    $0x0,%eax
}
  102f8a:	c9                   	leave  
  102f8b:	c3                   	ret    

00102f8c <printnum>:
 * @width:         maximum number of digits, if the actual width is less than @width, use @padc instead
 * @padc:        character that padded on the left if the actual width is less than @width
 * */
static void
printnum(void (*putch)(int, void*), void *putdat,
        unsigned long long num, unsigned base, int width, int padc) {
  102f8c:	f3 0f 1e fb          	endbr32 
  102f90:	55                   	push   %ebp
  102f91:	89 e5                	mov    %esp,%ebp
  102f93:	83 ec 38             	sub    $0x38,%esp
  102f96:	8b 45 10             	mov    0x10(%ebp),%eax
  102f99:	89 45 d0             	mov    %eax,-0x30(%ebp)
  102f9c:	8b 45 14             	mov    0x14(%ebp),%eax
  102f9f:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    unsigned long long result = num;
  102fa2:	8b 45 d0             	mov    -0x30(%ebp),%eax
  102fa5:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  102fa8:	89 45 e8             	mov    %eax,-0x18(%ebp)
  102fab:	89 55 ec             	mov    %edx,-0x14(%ebp)
    unsigned mod = do_div(result, base);
  102fae:	8b 45 18             	mov    0x18(%ebp),%eax
  102fb1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  102fb4:	8b 45 e8             	mov    -0x18(%ebp),%eax
  102fb7:	8b 55 ec             	mov    -0x14(%ebp),%edx
  102fba:	89 45 e0             	mov    %eax,-0x20(%ebp)
  102fbd:	89 55 f0             	mov    %edx,-0x10(%ebp)
  102fc0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102fc3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  102fc6:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  102fca:	74 1c                	je     102fe8 <printnum+0x5c>
  102fcc:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102fcf:	ba 00 00 00 00       	mov    $0x0,%edx
  102fd4:	f7 75 e4             	divl   -0x1c(%ebp)
  102fd7:	89 55 f4             	mov    %edx,-0xc(%ebp)
  102fda:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102fdd:	ba 00 00 00 00       	mov    $0x0,%edx
  102fe2:	f7 75 e4             	divl   -0x1c(%ebp)
  102fe5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  102fe8:	8b 45 e0             	mov    -0x20(%ebp),%eax
  102feb:	8b 55 f4             	mov    -0xc(%ebp),%edx
  102fee:	f7 75 e4             	divl   -0x1c(%ebp)
  102ff1:	89 45 e0             	mov    %eax,-0x20(%ebp)
  102ff4:	89 55 dc             	mov    %edx,-0x24(%ebp)
  102ff7:	8b 45 e0             	mov    -0x20(%ebp),%eax
  102ffa:	8b 55 f0             	mov    -0x10(%ebp),%edx
  102ffd:	89 45 e8             	mov    %eax,-0x18(%ebp)
  103000:	89 55 ec             	mov    %edx,-0x14(%ebp)
  103003:	8b 45 dc             	mov    -0x24(%ebp),%eax
  103006:	89 45 d8             	mov    %eax,-0x28(%ebp)

    // first recursively print all preceding (more significant) digits
    if (num >= base) {
  103009:	8b 45 18             	mov    0x18(%ebp),%eax
  10300c:	ba 00 00 00 00       	mov    $0x0,%edx
  103011:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
  103014:	39 45 d0             	cmp    %eax,-0x30(%ebp)
  103017:	19 d1                	sbb    %edx,%ecx
  103019:	72 37                	jb     103052 <printnum+0xc6>
        printnum(putch, putdat, result, base, width - 1, padc);
  10301b:	8b 45 1c             	mov    0x1c(%ebp),%eax
  10301e:	83 e8 01             	sub    $0x1,%eax
  103021:	83 ec 04             	sub    $0x4,%esp
  103024:	ff 75 20             	pushl  0x20(%ebp)
  103027:	50                   	push   %eax
  103028:	ff 75 18             	pushl  0x18(%ebp)
  10302b:	ff 75 ec             	pushl  -0x14(%ebp)
  10302e:	ff 75 e8             	pushl  -0x18(%ebp)
  103031:	ff 75 0c             	pushl  0xc(%ebp)
  103034:	ff 75 08             	pushl  0x8(%ebp)
  103037:	e8 50 ff ff ff       	call   102f8c <printnum>
  10303c:	83 c4 20             	add    $0x20,%esp
  10303f:	eb 1b                	jmp    10305c <printnum+0xd0>
    } else {
        // print any needed pad characters before first digit
        while (-- width > 0)
            putch(padc, putdat);
  103041:	83 ec 08             	sub    $0x8,%esp
  103044:	ff 75 0c             	pushl  0xc(%ebp)
  103047:	ff 75 20             	pushl  0x20(%ebp)
  10304a:	8b 45 08             	mov    0x8(%ebp),%eax
  10304d:	ff d0                	call   *%eax
  10304f:	83 c4 10             	add    $0x10,%esp
        while (-- width > 0)
  103052:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
  103056:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  10305a:	7f e5                	jg     103041 <printnum+0xb5>
    }
    // then print this (the least significant) digit
    putch("0123456789abcdef"[mod], putdat);
  10305c:	8b 45 d8             	mov    -0x28(%ebp),%eax
  10305f:	05 70 3d 10 00       	add    $0x103d70,%eax
  103064:	0f b6 00             	movzbl (%eax),%eax
  103067:	0f be c0             	movsbl %al,%eax
  10306a:	83 ec 08             	sub    $0x8,%esp
  10306d:	ff 75 0c             	pushl  0xc(%ebp)
  103070:	50                   	push   %eax
  103071:	8b 45 08             	mov    0x8(%ebp),%eax
  103074:	ff d0                	call   *%eax
  103076:	83 c4 10             	add    $0x10,%esp
}
  103079:	90                   	nop
  10307a:	c9                   	leave  
  10307b:	c3                   	ret    

0010307c <getuint>:
 * getuint - get an unsigned int of various possible sizes from a varargs list
 * @ap:            a varargs list pointer
 * @lflag:        determines the size of the vararg that @ap points to
 * */
static unsigned long long
getuint(va_list *ap, int lflag) {
  10307c:	f3 0f 1e fb          	endbr32 
  103080:	55                   	push   %ebp
  103081:	89 e5                	mov    %esp,%ebp
    if (lflag >= 2) {
  103083:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  103087:	7e 14                	jle    10309d <getuint+0x21>
        return va_arg(*ap, unsigned long long);
  103089:	8b 45 08             	mov    0x8(%ebp),%eax
  10308c:	8b 00                	mov    (%eax),%eax
  10308e:	8d 48 08             	lea    0x8(%eax),%ecx
  103091:	8b 55 08             	mov    0x8(%ebp),%edx
  103094:	89 0a                	mov    %ecx,(%edx)
  103096:	8b 50 04             	mov    0x4(%eax),%edx
  103099:	8b 00                	mov    (%eax),%eax
  10309b:	eb 30                	jmp    1030cd <getuint+0x51>
    }
    else if (lflag) {
  10309d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  1030a1:	74 16                	je     1030b9 <getuint+0x3d>
        return va_arg(*ap, unsigned long);
  1030a3:	8b 45 08             	mov    0x8(%ebp),%eax
  1030a6:	8b 00                	mov    (%eax),%eax
  1030a8:	8d 48 04             	lea    0x4(%eax),%ecx
  1030ab:	8b 55 08             	mov    0x8(%ebp),%edx
  1030ae:	89 0a                	mov    %ecx,(%edx)
  1030b0:	8b 00                	mov    (%eax),%eax
  1030b2:	ba 00 00 00 00       	mov    $0x0,%edx
  1030b7:	eb 14                	jmp    1030cd <getuint+0x51>
    }
    else {
        return va_arg(*ap, unsigned int);
  1030b9:	8b 45 08             	mov    0x8(%ebp),%eax
  1030bc:	8b 00                	mov    (%eax),%eax
  1030be:	8d 48 04             	lea    0x4(%eax),%ecx
  1030c1:	8b 55 08             	mov    0x8(%ebp),%edx
  1030c4:	89 0a                	mov    %ecx,(%edx)
  1030c6:	8b 00                	mov    (%eax),%eax
  1030c8:	ba 00 00 00 00       	mov    $0x0,%edx
    }
}
  1030cd:	5d                   	pop    %ebp
  1030ce:	c3                   	ret    

001030cf <getint>:
 * getint - same as getuint but signed, we can't use getuint because of sign extension
 * @ap:            a varargs list pointer
 * @lflag:        determines the size of the vararg that @ap points to
 * */
static long long
getint(va_list *ap, int lflag) {
  1030cf:	f3 0f 1e fb          	endbr32 
  1030d3:	55                   	push   %ebp
  1030d4:	89 e5                	mov    %esp,%ebp
    if (lflag >= 2) {
  1030d6:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  1030da:	7e 14                	jle    1030f0 <getint+0x21>
        return va_arg(*ap, long long);
  1030dc:	8b 45 08             	mov    0x8(%ebp),%eax
  1030df:	8b 00                	mov    (%eax),%eax
  1030e1:	8d 48 08             	lea    0x8(%eax),%ecx
  1030e4:	8b 55 08             	mov    0x8(%ebp),%edx
  1030e7:	89 0a                	mov    %ecx,(%edx)
  1030e9:	8b 50 04             	mov    0x4(%eax),%edx
  1030ec:	8b 00                	mov    (%eax),%eax
  1030ee:	eb 28                	jmp    103118 <getint+0x49>
    }
    else if (lflag) {
  1030f0:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  1030f4:	74 12                	je     103108 <getint+0x39>
        return va_arg(*ap, long);
  1030f6:	8b 45 08             	mov    0x8(%ebp),%eax
  1030f9:	8b 00                	mov    (%eax),%eax
  1030fb:	8d 48 04             	lea    0x4(%eax),%ecx
  1030fe:	8b 55 08             	mov    0x8(%ebp),%edx
  103101:	89 0a                	mov    %ecx,(%edx)
  103103:	8b 00                	mov    (%eax),%eax
  103105:	99                   	cltd   
  103106:	eb 10                	jmp    103118 <getint+0x49>
    }
    else {
        return va_arg(*ap, int);
  103108:	8b 45 08             	mov    0x8(%ebp),%eax
  10310b:	8b 00                	mov    (%eax),%eax
  10310d:	8d 48 04             	lea    0x4(%eax),%ecx
  103110:	8b 55 08             	mov    0x8(%ebp),%edx
  103113:	89 0a                	mov    %ecx,(%edx)
  103115:	8b 00                	mov    (%eax),%eax
  103117:	99                   	cltd   
    }
}
  103118:	5d                   	pop    %ebp
  103119:	c3                   	ret    

0010311a <printfmt>:
 * @putch:        specified putch function, print a single character
 * @putdat:        used by @putch function
 * @fmt:        the format string to use
 * */
void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
  10311a:	f3 0f 1e fb          	endbr32 
  10311e:	55                   	push   %ebp
  10311f:	89 e5                	mov    %esp,%ebp
  103121:	83 ec 18             	sub    $0x18,%esp
    va_list ap;

    va_start(ap, fmt);
  103124:	8d 45 14             	lea    0x14(%ebp),%eax
  103127:	89 45 f4             	mov    %eax,-0xc(%ebp)
    vprintfmt(putch, putdat, fmt, ap);
  10312a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10312d:	50                   	push   %eax
  10312e:	ff 75 10             	pushl  0x10(%ebp)
  103131:	ff 75 0c             	pushl  0xc(%ebp)
  103134:	ff 75 08             	pushl  0x8(%ebp)
  103137:	e8 06 00 00 00       	call   103142 <vprintfmt>
  10313c:	83 c4 10             	add    $0x10,%esp
    va_end(ap);
}
  10313f:	90                   	nop
  103140:	c9                   	leave  
  103141:	c3                   	ret    

00103142 <vprintfmt>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want printfmt() instead.
 * */
void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap) {
  103142:	f3 0f 1e fb          	endbr32 
  103146:	55                   	push   %ebp
  103147:	89 e5                	mov    %esp,%ebp
  103149:	56                   	push   %esi
  10314a:	53                   	push   %ebx
  10314b:	83 ec 20             	sub    $0x20,%esp
    register int ch, err;
    unsigned long long num;
    int base, width, precision, lflag, altflag;

    while (1) {
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  10314e:	eb 17                	jmp    103167 <vprintfmt+0x25>
            if (ch == '\0') {
  103150:	85 db                	test   %ebx,%ebx
  103152:	0f 84 8f 03 00 00    	je     1034e7 <vprintfmt+0x3a5>
                return;
            }
            putch(ch, putdat);
  103158:	83 ec 08             	sub    $0x8,%esp
  10315b:	ff 75 0c             	pushl  0xc(%ebp)
  10315e:	53                   	push   %ebx
  10315f:	8b 45 08             	mov    0x8(%ebp),%eax
  103162:	ff d0                	call   *%eax
  103164:	83 c4 10             	add    $0x10,%esp
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  103167:	8b 45 10             	mov    0x10(%ebp),%eax
  10316a:	8d 50 01             	lea    0x1(%eax),%edx
  10316d:	89 55 10             	mov    %edx,0x10(%ebp)
  103170:	0f b6 00             	movzbl (%eax),%eax
  103173:	0f b6 d8             	movzbl %al,%ebx
  103176:	83 fb 25             	cmp    $0x25,%ebx
  103179:	75 d5                	jne    103150 <vprintfmt+0xe>
        }

        // Process a %-escape sequence
        char padc = ' ';
  10317b:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
        width = precision = -1;
  10317f:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
  103186:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  103189:	89 45 e8             	mov    %eax,-0x18(%ebp)
        lflag = altflag = 0;
  10318c:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  103193:	8b 45 dc             	mov    -0x24(%ebp),%eax
  103196:	89 45 e0             	mov    %eax,-0x20(%ebp)

    reswitch:
        switch (ch = *(unsigned char *)fmt ++) {
  103199:	8b 45 10             	mov    0x10(%ebp),%eax
  10319c:	8d 50 01             	lea    0x1(%eax),%edx
  10319f:	89 55 10             	mov    %edx,0x10(%ebp)
  1031a2:	0f b6 00             	movzbl (%eax),%eax
  1031a5:	0f b6 d8             	movzbl %al,%ebx
  1031a8:	8d 43 dd             	lea    -0x23(%ebx),%eax
  1031ab:	83 f8 55             	cmp    $0x55,%eax
  1031ae:	0f 87 06 03 00 00    	ja     1034ba <vprintfmt+0x378>
  1031b4:	8b 04 85 94 3d 10 00 	mov    0x103d94(,%eax,4),%eax
  1031bb:	3e ff e0             	notrack jmp *%eax

        // flag to pad on the right
        case '-':
            padc = '-';
  1031be:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
            goto reswitch;
  1031c2:	eb d5                	jmp    103199 <vprintfmt+0x57>

        // flag to pad with 0's instead of spaces
        case '0':
            padc = '0';
  1031c4:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
            goto reswitch;
  1031c8:	eb cf                	jmp    103199 <vprintfmt+0x57>

        // width field
        case '1' ... '9':
            for (precision = 0; ; ++ fmt) {
  1031ca:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
                precision = precision * 10 + ch - '0';
  1031d1:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  1031d4:	89 d0                	mov    %edx,%eax
  1031d6:	c1 e0 02             	shl    $0x2,%eax
  1031d9:	01 d0                	add    %edx,%eax
  1031db:	01 c0                	add    %eax,%eax
  1031dd:	01 d8                	add    %ebx,%eax
  1031df:	83 e8 30             	sub    $0x30,%eax
  1031e2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
                ch = *fmt;
  1031e5:	8b 45 10             	mov    0x10(%ebp),%eax
  1031e8:	0f b6 00             	movzbl (%eax),%eax
  1031eb:	0f be d8             	movsbl %al,%ebx
                if (ch < '0' || ch > '9') {
  1031ee:	83 fb 2f             	cmp    $0x2f,%ebx
  1031f1:	7e 39                	jle    10322c <vprintfmt+0xea>
  1031f3:	83 fb 39             	cmp    $0x39,%ebx
  1031f6:	7f 34                	jg     10322c <vprintfmt+0xea>
            for (precision = 0; ; ++ fmt) {
  1031f8:	83 45 10 01          	addl   $0x1,0x10(%ebp)
                precision = precision * 10 + ch - '0';
  1031fc:	eb d3                	jmp    1031d1 <vprintfmt+0x8f>
                }
            }
            goto process_precision;

        case '*':
            precision = va_arg(ap, int);
  1031fe:	8b 45 14             	mov    0x14(%ebp),%eax
  103201:	8d 50 04             	lea    0x4(%eax),%edx
  103204:	89 55 14             	mov    %edx,0x14(%ebp)
  103207:	8b 00                	mov    (%eax),%eax
  103209:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            goto process_precision;
  10320c:	eb 1f                	jmp    10322d <vprintfmt+0xeb>

        case '.':
            if (width < 0)
  10320e:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  103212:	79 85                	jns    103199 <vprintfmt+0x57>
                width = 0;
  103214:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
            goto reswitch;
  10321b:	e9 79 ff ff ff       	jmp    103199 <vprintfmt+0x57>

        case '#':
            altflag = 1;
  103220:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
            goto reswitch;
  103227:	e9 6d ff ff ff       	jmp    103199 <vprintfmt+0x57>
            goto process_precision;
  10322c:	90                   	nop

        process_precision:
            if (width < 0)
  10322d:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  103231:	0f 89 62 ff ff ff    	jns    103199 <vprintfmt+0x57>
                width = precision, precision = -1;
  103237:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  10323a:	89 45 e8             	mov    %eax,-0x18(%ebp)
  10323d:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
            goto reswitch;
  103244:	e9 50 ff ff ff       	jmp    103199 <vprintfmt+0x57>

        // long flag (doubled for long long)
        case 'l':
            lflag ++;
  103249:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
            goto reswitch;
  10324d:	e9 47 ff ff ff       	jmp    103199 <vprintfmt+0x57>

        // character
        case 'c':
            putch(va_arg(ap, int), putdat);
  103252:	8b 45 14             	mov    0x14(%ebp),%eax
  103255:	8d 50 04             	lea    0x4(%eax),%edx
  103258:	89 55 14             	mov    %edx,0x14(%ebp)
  10325b:	8b 00                	mov    (%eax),%eax
  10325d:	83 ec 08             	sub    $0x8,%esp
  103260:	ff 75 0c             	pushl  0xc(%ebp)
  103263:	50                   	push   %eax
  103264:	8b 45 08             	mov    0x8(%ebp),%eax
  103267:	ff d0                	call   *%eax
  103269:	83 c4 10             	add    $0x10,%esp
            break;
  10326c:	e9 71 02 00 00       	jmp    1034e2 <vprintfmt+0x3a0>

        // error message
        case 'e':
            err = va_arg(ap, int);
  103271:	8b 45 14             	mov    0x14(%ebp),%eax
  103274:	8d 50 04             	lea    0x4(%eax),%edx
  103277:	89 55 14             	mov    %edx,0x14(%ebp)
  10327a:	8b 18                	mov    (%eax),%ebx
            if (err < 0) {
  10327c:	85 db                	test   %ebx,%ebx
  10327e:	79 02                	jns    103282 <vprintfmt+0x140>
                err = -err;
  103280:	f7 db                	neg    %ebx
            }
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
  103282:	83 fb 06             	cmp    $0x6,%ebx
  103285:	7f 0b                	jg     103292 <vprintfmt+0x150>
  103287:	8b 34 9d 54 3d 10 00 	mov    0x103d54(,%ebx,4),%esi
  10328e:	85 f6                	test   %esi,%esi
  103290:	75 19                	jne    1032ab <vprintfmt+0x169>
                printfmt(putch, putdat, "error %d", err);
  103292:	53                   	push   %ebx
  103293:	68 81 3d 10 00       	push   $0x103d81
  103298:	ff 75 0c             	pushl  0xc(%ebp)
  10329b:	ff 75 08             	pushl  0x8(%ebp)
  10329e:	e8 77 fe ff ff       	call   10311a <printfmt>
  1032a3:	83 c4 10             	add    $0x10,%esp
            }
            else {
                printfmt(putch, putdat, "%s", p);
            }
            break;
  1032a6:	e9 37 02 00 00       	jmp    1034e2 <vprintfmt+0x3a0>
                printfmt(putch, putdat, "%s", p);
  1032ab:	56                   	push   %esi
  1032ac:	68 8a 3d 10 00       	push   $0x103d8a
  1032b1:	ff 75 0c             	pushl  0xc(%ebp)
  1032b4:	ff 75 08             	pushl  0x8(%ebp)
  1032b7:	e8 5e fe ff ff       	call   10311a <printfmt>
  1032bc:	83 c4 10             	add    $0x10,%esp
            break;
  1032bf:	e9 1e 02 00 00       	jmp    1034e2 <vprintfmt+0x3a0>

        // string
        case 's':
            if ((p = va_arg(ap, char *)) == NULL) {
  1032c4:	8b 45 14             	mov    0x14(%ebp),%eax
  1032c7:	8d 50 04             	lea    0x4(%eax),%edx
  1032ca:	89 55 14             	mov    %edx,0x14(%ebp)
  1032cd:	8b 30                	mov    (%eax),%esi
  1032cf:	85 f6                	test   %esi,%esi
  1032d1:	75 05                	jne    1032d8 <vprintfmt+0x196>
                p = "(null)";
  1032d3:	be 8d 3d 10 00       	mov    $0x103d8d,%esi
            }
            if (width > 0 && padc != '-') {
  1032d8:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  1032dc:	7e 76                	jle    103354 <vprintfmt+0x212>
  1032de:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  1032e2:	74 70                	je     103354 <vprintfmt+0x212>
                for (width -= strnlen(p, precision); width > 0; width --) {
  1032e4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1032e7:	83 ec 08             	sub    $0x8,%esp
  1032ea:	50                   	push   %eax
  1032eb:	56                   	push   %esi
  1032ec:	e8 db f7 ff ff       	call   102acc <strnlen>
  1032f1:	83 c4 10             	add    $0x10,%esp
  1032f4:	8b 55 e8             	mov    -0x18(%ebp),%edx
  1032f7:	29 c2                	sub    %eax,%edx
  1032f9:	89 d0                	mov    %edx,%eax
  1032fb:	89 45 e8             	mov    %eax,-0x18(%ebp)
  1032fe:	eb 17                	jmp    103317 <vprintfmt+0x1d5>
                    putch(padc, putdat);
  103300:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  103304:	83 ec 08             	sub    $0x8,%esp
  103307:	ff 75 0c             	pushl  0xc(%ebp)
  10330a:	50                   	push   %eax
  10330b:	8b 45 08             	mov    0x8(%ebp),%eax
  10330e:	ff d0                	call   *%eax
  103310:	83 c4 10             	add    $0x10,%esp
                for (width -= strnlen(p, precision); width > 0; width --) {
  103313:	83 6d e8 01          	subl   $0x1,-0x18(%ebp)
  103317:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  10331b:	7f e3                	jg     103300 <vprintfmt+0x1be>
                }
            }
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  10331d:	eb 35                	jmp    103354 <vprintfmt+0x212>
                if (altflag && (ch < ' ' || ch > '~')) {
  10331f:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  103323:	74 1c                	je     103341 <vprintfmt+0x1ff>
  103325:	83 fb 1f             	cmp    $0x1f,%ebx
  103328:	7e 05                	jle    10332f <vprintfmt+0x1ed>
  10332a:	83 fb 7e             	cmp    $0x7e,%ebx
  10332d:	7e 12                	jle    103341 <vprintfmt+0x1ff>
                    putch('?', putdat);
  10332f:	83 ec 08             	sub    $0x8,%esp
  103332:	ff 75 0c             	pushl  0xc(%ebp)
  103335:	6a 3f                	push   $0x3f
  103337:	8b 45 08             	mov    0x8(%ebp),%eax
  10333a:	ff d0                	call   *%eax
  10333c:	83 c4 10             	add    $0x10,%esp
  10333f:	eb 0f                	jmp    103350 <vprintfmt+0x20e>
                }
                else {
                    putch(ch, putdat);
  103341:	83 ec 08             	sub    $0x8,%esp
  103344:	ff 75 0c             	pushl  0xc(%ebp)
  103347:	53                   	push   %ebx
  103348:	8b 45 08             	mov    0x8(%ebp),%eax
  10334b:	ff d0                	call   *%eax
  10334d:	83 c4 10             	add    $0x10,%esp
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  103350:	83 6d e8 01          	subl   $0x1,-0x18(%ebp)
  103354:	89 f0                	mov    %esi,%eax
  103356:	8d 70 01             	lea    0x1(%eax),%esi
  103359:	0f b6 00             	movzbl (%eax),%eax
  10335c:	0f be d8             	movsbl %al,%ebx
  10335f:	85 db                	test   %ebx,%ebx
  103361:	74 26                	je     103389 <vprintfmt+0x247>
  103363:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  103367:	78 b6                	js     10331f <vprintfmt+0x1dd>
  103369:	83 6d e4 01          	subl   $0x1,-0x1c(%ebp)
  10336d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  103371:	79 ac                	jns    10331f <vprintfmt+0x1dd>
                }
            }
            for (; width > 0; width --) {
  103373:	eb 14                	jmp    103389 <vprintfmt+0x247>
                putch(' ', putdat);
  103375:	83 ec 08             	sub    $0x8,%esp
  103378:	ff 75 0c             	pushl  0xc(%ebp)
  10337b:	6a 20                	push   $0x20
  10337d:	8b 45 08             	mov    0x8(%ebp),%eax
  103380:	ff d0                	call   *%eax
  103382:	83 c4 10             	add    $0x10,%esp
            for (; width > 0; width --) {
  103385:	83 6d e8 01          	subl   $0x1,-0x18(%ebp)
  103389:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  10338d:	7f e6                	jg     103375 <vprintfmt+0x233>
            }
            break;
  10338f:	e9 4e 01 00 00       	jmp    1034e2 <vprintfmt+0x3a0>

        // (signed) decimal
        case 'd':
            num = getint(&ap, lflag);
  103394:	83 ec 08             	sub    $0x8,%esp
  103397:	ff 75 e0             	pushl  -0x20(%ebp)
  10339a:	8d 45 14             	lea    0x14(%ebp),%eax
  10339d:	50                   	push   %eax
  10339e:	e8 2c fd ff ff       	call   1030cf <getint>
  1033a3:	83 c4 10             	add    $0x10,%esp
  1033a6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  1033a9:	89 55 f4             	mov    %edx,-0xc(%ebp)
            if ((long long)num < 0) {
  1033ac:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1033af:	8b 55 f4             	mov    -0xc(%ebp),%edx
  1033b2:	85 d2                	test   %edx,%edx
  1033b4:	79 23                	jns    1033d9 <vprintfmt+0x297>
                putch('-', putdat);
  1033b6:	83 ec 08             	sub    $0x8,%esp
  1033b9:	ff 75 0c             	pushl  0xc(%ebp)
  1033bc:	6a 2d                	push   $0x2d
  1033be:	8b 45 08             	mov    0x8(%ebp),%eax
  1033c1:	ff d0                	call   *%eax
  1033c3:	83 c4 10             	add    $0x10,%esp
                num = -(long long)num;
  1033c6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1033c9:	8b 55 f4             	mov    -0xc(%ebp),%edx
  1033cc:	f7 d8                	neg    %eax
  1033ce:	83 d2 00             	adc    $0x0,%edx
  1033d1:	f7 da                	neg    %edx
  1033d3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  1033d6:	89 55 f4             	mov    %edx,-0xc(%ebp)
            }
            base = 10;
  1033d9:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
            goto number;
  1033e0:	e9 9f 00 00 00       	jmp    103484 <vprintfmt+0x342>

        // unsigned decimal
        case 'u':
            num = getuint(&ap, lflag);
  1033e5:	83 ec 08             	sub    $0x8,%esp
  1033e8:	ff 75 e0             	pushl  -0x20(%ebp)
  1033eb:	8d 45 14             	lea    0x14(%ebp),%eax
  1033ee:	50                   	push   %eax
  1033ef:	e8 88 fc ff ff       	call   10307c <getuint>
  1033f4:	83 c4 10             	add    $0x10,%esp
  1033f7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  1033fa:	89 55 f4             	mov    %edx,-0xc(%ebp)
            base = 10;
  1033fd:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
            goto number;
  103404:	eb 7e                	jmp    103484 <vprintfmt+0x342>

        // (unsigned) octal
        case 'o':
            num = getuint(&ap, lflag);
  103406:	83 ec 08             	sub    $0x8,%esp
  103409:	ff 75 e0             	pushl  -0x20(%ebp)
  10340c:	8d 45 14             	lea    0x14(%ebp),%eax
  10340f:	50                   	push   %eax
  103410:	e8 67 fc ff ff       	call   10307c <getuint>
  103415:	83 c4 10             	add    $0x10,%esp
  103418:	89 45 f0             	mov    %eax,-0x10(%ebp)
  10341b:	89 55 f4             	mov    %edx,-0xc(%ebp)
            base = 8;
  10341e:	c7 45 ec 08 00 00 00 	movl   $0x8,-0x14(%ebp)
            goto number;
  103425:	eb 5d                	jmp    103484 <vprintfmt+0x342>

        // pointer
        case 'p':
            putch('0', putdat);
  103427:	83 ec 08             	sub    $0x8,%esp
  10342a:	ff 75 0c             	pushl  0xc(%ebp)
  10342d:	6a 30                	push   $0x30
  10342f:	8b 45 08             	mov    0x8(%ebp),%eax
  103432:	ff d0                	call   *%eax
  103434:	83 c4 10             	add    $0x10,%esp
            putch('x', putdat);
  103437:	83 ec 08             	sub    $0x8,%esp
  10343a:	ff 75 0c             	pushl  0xc(%ebp)
  10343d:	6a 78                	push   $0x78
  10343f:	8b 45 08             	mov    0x8(%ebp),%eax
  103442:	ff d0                	call   *%eax
  103444:	83 c4 10             	add    $0x10,%esp
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
  103447:	8b 45 14             	mov    0x14(%ebp),%eax
  10344a:	8d 50 04             	lea    0x4(%eax),%edx
  10344d:	89 55 14             	mov    %edx,0x14(%ebp)
  103450:	8b 00                	mov    (%eax),%eax
  103452:	89 45 f0             	mov    %eax,-0x10(%ebp)
  103455:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
            base = 16;
  10345c:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
            goto number;
  103463:	eb 1f                	jmp    103484 <vprintfmt+0x342>

        // (unsigned) hexadecimal
        case 'x':
            num = getuint(&ap, lflag);
  103465:	83 ec 08             	sub    $0x8,%esp
  103468:	ff 75 e0             	pushl  -0x20(%ebp)
  10346b:	8d 45 14             	lea    0x14(%ebp),%eax
  10346e:	50                   	push   %eax
  10346f:	e8 08 fc ff ff       	call   10307c <getuint>
  103474:	83 c4 10             	add    $0x10,%esp
  103477:	89 45 f0             	mov    %eax,-0x10(%ebp)
  10347a:	89 55 f4             	mov    %edx,-0xc(%ebp)
            base = 16;
  10347d:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
        number:
            printnum(putch, putdat, num, base, width, padc);
  103484:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  103488:	8b 45 ec             	mov    -0x14(%ebp),%eax
  10348b:	83 ec 04             	sub    $0x4,%esp
  10348e:	52                   	push   %edx
  10348f:	ff 75 e8             	pushl  -0x18(%ebp)
  103492:	50                   	push   %eax
  103493:	ff 75 f4             	pushl  -0xc(%ebp)
  103496:	ff 75 f0             	pushl  -0x10(%ebp)
  103499:	ff 75 0c             	pushl  0xc(%ebp)
  10349c:	ff 75 08             	pushl  0x8(%ebp)
  10349f:	e8 e8 fa ff ff       	call   102f8c <printnum>
  1034a4:	83 c4 20             	add    $0x20,%esp
            break;
  1034a7:	eb 39                	jmp    1034e2 <vprintfmt+0x3a0>

        // escaped '%' character
        case '%':
            putch(ch, putdat);
  1034a9:	83 ec 08             	sub    $0x8,%esp
  1034ac:	ff 75 0c             	pushl  0xc(%ebp)
  1034af:	53                   	push   %ebx
  1034b0:	8b 45 08             	mov    0x8(%ebp),%eax
  1034b3:	ff d0                	call   *%eax
  1034b5:	83 c4 10             	add    $0x10,%esp
            break;
  1034b8:	eb 28                	jmp    1034e2 <vprintfmt+0x3a0>

        // unrecognized escape sequence - just print it literally
        default:
            putch('%', putdat);
  1034ba:	83 ec 08             	sub    $0x8,%esp
  1034bd:	ff 75 0c             	pushl  0xc(%ebp)
  1034c0:	6a 25                	push   $0x25
  1034c2:	8b 45 08             	mov    0x8(%ebp),%eax
  1034c5:	ff d0                	call   *%eax
  1034c7:	83 c4 10             	add    $0x10,%esp
            for (fmt --; fmt[-1] != '%'; fmt --)
  1034ca:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
  1034ce:	eb 04                	jmp    1034d4 <vprintfmt+0x392>
  1034d0:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
  1034d4:	8b 45 10             	mov    0x10(%ebp),%eax
  1034d7:	83 e8 01             	sub    $0x1,%eax
  1034da:	0f b6 00             	movzbl (%eax),%eax
  1034dd:	3c 25                	cmp    $0x25,%al
  1034df:	75 ef                	jne    1034d0 <vprintfmt+0x38e>
                /* do nothing */;
            break;
  1034e1:	90                   	nop
    while (1) {
  1034e2:	e9 67 fc ff ff       	jmp    10314e <vprintfmt+0xc>
                return;
  1034e7:	90                   	nop
        }
    }
}
  1034e8:	8d 65 f8             	lea    -0x8(%ebp),%esp
  1034eb:	5b                   	pop    %ebx
  1034ec:	5e                   	pop    %esi
  1034ed:	5d                   	pop    %ebp
  1034ee:	c3                   	ret    

001034ef <sprintputch>:
 * sprintputch - 'print' a single character in a buffer
 * @ch:            the character will be printed
 * @b:            the buffer to place the character @ch
 * */
static void
sprintputch(int ch, struct sprintbuf *b) {
  1034ef:	f3 0f 1e fb          	endbr32 
  1034f3:	55                   	push   %ebp
  1034f4:	89 e5                	mov    %esp,%ebp
    b->cnt ++;
  1034f6:	8b 45 0c             	mov    0xc(%ebp),%eax
  1034f9:	8b 40 08             	mov    0x8(%eax),%eax
  1034fc:	8d 50 01             	lea    0x1(%eax),%edx
  1034ff:	8b 45 0c             	mov    0xc(%ebp),%eax
  103502:	89 50 08             	mov    %edx,0x8(%eax)
    if (b->buf < b->ebuf) {
  103505:	8b 45 0c             	mov    0xc(%ebp),%eax
  103508:	8b 10                	mov    (%eax),%edx
  10350a:	8b 45 0c             	mov    0xc(%ebp),%eax
  10350d:	8b 40 04             	mov    0x4(%eax),%eax
  103510:	39 c2                	cmp    %eax,%edx
  103512:	73 12                	jae    103526 <sprintputch+0x37>
        *b->buf ++ = ch;
  103514:	8b 45 0c             	mov    0xc(%ebp),%eax
  103517:	8b 00                	mov    (%eax),%eax
  103519:	8d 48 01             	lea    0x1(%eax),%ecx
  10351c:	8b 55 0c             	mov    0xc(%ebp),%edx
  10351f:	89 0a                	mov    %ecx,(%edx)
  103521:	8b 55 08             	mov    0x8(%ebp),%edx
  103524:	88 10                	mov    %dl,(%eax)
    }
}
  103526:	90                   	nop
  103527:	5d                   	pop    %ebp
  103528:	c3                   	ret    

00103529 <snprintf>:
 * @str:        the buffer to place the result into
 * @size:        the size of buffer, including the trailing null space
 * @fmt:        the format string to use
 * */
int
snprintf(char *str, size_t size, const char *fmt, ...) {
  103529:	f3 0f 1e fb          	endbr32 
  10352d:	55                   	push   %ebp
  10352e:	89 e5                	mov    %esp,%ebp
  103530:	83 ec 18             	sub    $0x18,%esp
    va_list ap;
    int cnt;
    va_start(ap, fmt);
  103533:	8d 45 14             	lea    0x14(%ebp),%eax
  103536:	89 45 f0             	mov    %eax,-0x10(%ebp)
    cnt = vsnprintf(str, size, fmt, ap);
  103539:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10353c:	50                   	push   %eax
  10353d:	ff 75 10             	pushl  0x10(%ebp)
  103540:	ff 75 0c             	pushl  0xc(%ebp)
  103543:	ff 75 08             	pushl  0x8(%ebp)
  103546:	e8 0b 00 00 00       	call   103556 <vsnprintf>
  10354b:	83 c4 10             	add    $0x10,%esp
  10354e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    va_end(ap);
    return cnt;
  103551:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  103554:	c9                   	leave  
  103555:	c3                   	ret    

00103556 <vsnprintf>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want snprintf() instead.
 * */
int
vsnprintf(char *str, size_t size, const char *fmt, va_list ap) {
  103556:	f3 0f 1e fb          	endbr32 
  10355a:	55                   	push   %ebp
  10355b:	89 e5                	mov    %esp,%ebp
  10355d:	83 ec 18             	sub    $0x18,%esp
    struct sprintbuf b = {str, str + size - 1, 0};
  103560:	8b 45 08             	mov    0x8(%ebp),%eax
  103563:	89 45 ec             	mov    %eax,-0x14(%ebp)
  103566:	8b 45 0c             	mov    0xc(%ebp),%eax
  103569:	8d 50 ff             	lea    -0x1(%eax),%edx
  10356c:	8b 45 08             	mov    0x8(%ebp),%eax
  10356f:	01 d0                	add    %edx,%eax
  103571:	89 45 f0             	mov    %eax,-0x10(%ebp)
  103574:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if (str == NULL || b.buf > b.ebuf) {
  10357b:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  10357f:	74 0a                	je     10358b <vsnprintf+0x35>
  103581:	8b 55 ec             	mov    -0x14(%ebp),%edx
  103584:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103587:	39 c2                	cmp    %eax,%edx
  103589:	76 07                	jbe    103592 <vsnprintf+0x3c>
        return -E_INVAL;
  10358b:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  103590:	eb 20                	jmp    1035b2 <vsnprintf+0x5c>
    }
    // print the string to the buffer
    vprintfmt((void*)sprintputch, &b, fmt, ap);
  103592:	ff 75 14             	pushl  0x14(%ebp)
  103595:	ff 75 10             	pushl  0x10(%ebp)
  103598:	8d 45 ec             	lea    -0x14(%ebp),%eax
  10359b:	50                   	push   %eax
  10359c:	68 ef 34 10 00       	push   $0x1034ef
  1035a1:	e8 9c fb ff ff       	call   103142 <vprintfmt>
  1035a6:	83 c4 10             	add    $0x10,%esp
    // null terminate the buffer
    *b.buf = '\0';
  1035a9:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1035ac:	c6 00 00             	movb   $0x0,(%eax)
    return b.cnt;
  1035af:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  1035b2:	c9                   	leave  
  1035b3:	c3                   	ret    
