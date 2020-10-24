
bin/kernel:     file format elf32-i386


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
  100007:	53                   	push   %ebx
  100008:	83 ec 14             	sub    $0x14,%esp
  10000b:	e8 94 02 00 00       	call   1002a4 <__x86.get_pc_thunk.bx>
  100010:	81 c3 40 f9 00 00    	add    $0xf940,%ebx
    extern char edata[], end[];
    memset(edata, 0, end - edata);
  100016:	c7 c0 c0 0d 11 00    	mov    $0x110dc0,%eax
  10001c:	89 c2                	mov    %eax,%edx
  10001e:	c7 c0 50 f9 10 00    	mov    $0x10f950,%eax
  100024:	29 c2                	sub    %eax,%edx
  100026:	89 d0                	mov    %edx,%eax
  100028:	83 ec 04             	sub    $0x4,%esp
  10002b:	50                   	push   %eax
  10002c:	6a 00                	push   $0x0
  10002e:	c7 c0 50 f9 10 00    	mov    $0x10f950,%eax
  100034:	50                   	push   %eax
  100035:	e8 db 30 00 00       	call   103115 <memset>
  10003a:	83 c4 10             	add    $0x10,%esp

    cons_init();                // init the console
  10003d:	e8 0c 19 00 00       	call   10194e <cons_init>

    const char *message = "(THU.CST) os is loading ...";
  100042:	8d 83 1c 40 ff ff    	lea    -0xbfe4(%ebx),%eax
  100048:	89 45 f4             	mov    %eax,-0xc(%ebp)
    cprintf("%s\n\n", message);
  10004b:	83 ec 08             	sub    $0x8,%esp
  10004e:	ff 75 f4             	pushl  -0xc(%ebp)
  100051:	8d 83 38 40 ff ff    	lea    -0xbfc8(%ebx),%eax
  100057:	50                   	push   %eax
  100058:	e8 c2 02 00 00       	call   10031f <cprintf>
  10005d:	83 c4 10             	add    $0x10,%esp

    print_kerninfo();
  100060:	e8 ff 09 00 00       	call   100a64 <print_kerninfo>

    grade_backtrace();
  100065:	e8 a4 00 00 00       	call   10010e <grade_backtrace>

    pmm_init();                 // init physical memory management
  10006a:	e8 e0 2c 00 00       	call   102d4f <pmm_init>

    pic_init();                 // init interrupt controller
  10006f:	e8 7f 1a 00 00       	call   101af3 <pic_init>
    idt_init();                 // init interrupt descriptor table
  100074:	e8 54 1c 00 00       	call   101ccd <idt_init>

    clock_init();               // init clock interrupt
  100079:	e8 70 0f 00 00       	call   100fee <clock_init>
    intr_enable();              // enable irq interrupt
  10007e:	e8 ca 1b 00 00       	call   101c4d <intr_enable>
    //LAB1: CAHLLENGE 1 If you try to do it, uncomment lab1_switch_test()
    // user/kernel mode switch test
    //lab1_switch_test();

    /* do nothing */
    while (1);
  100083:	eb fe                	jmp    100083 <kern_init+0x83>

00100085 <grade_backtrace2>:
}

void __attribute__((noinline))
grade_backtrace2(int arg0, int arg1, int arg2, int arg3) {
  100085:	f3 0f 1e fb          	endbr32 
  100089:	55                   	push   %ebp
  10008a:	89 e5                	mov    %esp,%ebp
  10008c:	53                   	push   %ebx
  10008d:	83 ec 04             	sub    $0x4,%esp
  100090:	e8 0b 02 00 00       	call   1002a0 <__x86.get_pc_thunk.ax>
  100095:	05 bb f8 00 00       	add    $0xf8bb,%eax
    mon_backtrace(0, NULL, NULL);
  10009a:	83 ec 04             	sub    $0x4,%esp
  10009d:	6a 00                	push   $0x0
  10009f:	6a 00                	push   $0x0
  1000a1:	6a 00                	push   $0x0
  1000a3:	89 c3                	mov    %eax,%ebx
  1000a5:	e8 1d 0f 00 00       	call   100fc7 <mon_backtrace>
  1000aa:	83 c4 10             	add    $0x10,%esp
}
  1000ad:	90                   	nop
  1000ae:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  1000b1:	c9                   	leave  
  1000b2:	c3                   	ret    

001000b3 <grade_backtrace1>:

void __attribute__((noinline))
grade_backtrace1(int arg0, int arg1) {
  1000b3:	f3 0f 1e fb          	endbr32 
  1000b7:	55                   	push   %ebp
  1000b8:	89 e5                	mov    %esp,%ebp
  1000ba:	53                   	push   %ebx
  1000bb:	83 ec 04             	sub    $0x4,%esp
  1000be:	e8 dd 01 00 00       	call   1002a0 <__x86.get_pc_thunk.ax>
  1000c3:	05 8d f8 00 00       	add    $0xf88d,%eax
    grade_backtrace2(arg0, (int)&arg0, arg1, (int)&arg1);
  1000c8:	8d 4d 0c             	lea    0xc(%ebp),%ecx
  1000cb:	8b 55 0c             	mov    0xc(%ebp),%edx
  1000ce:	8d 5d 08             	lea    0x8(%ebp),%ebx
  1000d1:	8b 45 08             	mov    0x8(%ebp),%eax
  1000d4:	51                   	push   %ecx
  1000d5:	52                   	push   %edx
  1000d6:	53                   	push   %ebx
  1000d7:	50                   	push   %eax
  1000d8:	e8 a8 ff ff ff       	call   100085 <grade_backtrace2>
  1000dd:	83 c4 10             	add    $0x10,%esp
}
  1000e0:	90                   	nop
  1000e1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  1000e4:	c9                   	leave  
  1000e5:	c3                   	ret    

001000e6 <grade_backtrace0>:

void __attribute__((noinline))
grade_backtrace0(int arg0, int arg1, int arg2) {
  1000e6:	f3 0f 1e fb          	endbr32 
  1000ea:	55                   	push   %ebp
  1000eb:	89 e5                	mov    %esp,%ebp
  1000ed:	83 ec 08             	sub    $0x8,%esp
  1000f0:	e8 ab 01 00 00       	call   1002a0 <__x86.get_pc_thunk.ax>
  1000f5:	05 5b f8 00 00       	add    $0xf85b,%eax
    grade_backtrace1(arg0, arg2);
  1000fa:	83 ec 08             	sub    $0x8,%esp
  1000fd:	ff 75 10             	pushl  0x10(%ebp)
  100100:	ff 75 08             	pushl  0x8(%ebp)
  100103:	e8 ab ff ff ff       	call   1000b3 <grade_backtrace1>
  100108:	83 c4 10             	add    $0x10,%esp
}
  10010b:	90                   	nop
  10010c:	c9                   	leave  
  10010d:	c3                   	ret    

0010010e <grade_backtrace>:

void
grade_backtrace(void) {
  10010e:	f3 0f 1e fb          	endbr32 
  100112:	55                   	push   %ebp
  100113:	89 e5                	mov    %esp,%ebp
  100115:	83 ec 08             	sub    $0x8,%esp
  100118:	e8 83 01 00 00       	call   1002a0 <__x86.get_pc_thunk.ax>
  10011d:	05 33 f8 00 00       	add    $0xf833,%eax
    grade_backtrace0(0, (int)kern_init, 0xffff0000);
  100122:	8d 80 b0 06 ff ff    	lea    -0xf950(%eax),%eax
  100128:	83 ec 04             	sub    $0x4,%esp
  10012b:	68 00 00 ff ff       	push   $0xffff0000
  100130:	50                   	push   %eax
  100131:	6a 00                	push   $0x0
  100133:	e8 ae ff ff ff       	call   1000e6 <grade_backtrace0>
  100138:	83 c4 10             	add    $0x10,%esp
}
  10013b:	90                   	nop
  10013c:	c9                   	leave  
  10013d:	c3                   	ret    

0010013e <lab1_print_cur_status>:

static void
lab1_print_cur_status(void) {
  10013e:	f3 0f 1e fb          	endbr32 
  100142:	55                   	push   %ebp
  100143:	89 e5                	mov    %esp,%ebp
  100145:	53                   	push   %ebx
  100146:	83 ec 14             	sub    $0x14,%esp
  100149:	e8 56 01 00 00       	call   1002a4 <__x86.get_pc_thunk.bx>
  10014e:	81 c3 02 f8 00 00    	add    $0xf802,%ebx
    static int round = 0;
    uint16_t reg1, reg2, reg3, reg4;
    asm volatile (
  100154:	8c 4d f6             	mov    %cs,-0xa(%ebp)
  100157:	8c 5d f4             	mov    %ds,-0xc(%ebp)
  10015a:	8c 45 f2             	mov    %es,-0xe(%ebp)
  10015d:	8c 55 f0             	mov    %ss,-0x10(%ebp)
            "mov %%cs, %0;"
            "mov %%ds, %1;"
            "mov %%es, %2;"
            "mov %%ss, %3;"
            : "=m"(reg1), "=m"(reg2), "=m"(reg3), "=m"(reg4));
    cprintf("%d: @ring %d\n", round, reg1 & 3);
  100160:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  100164:	0f b7 c0             	movzwl %ax,%eax
  100167:	83 e0 03             	and    $0x3,%eax
  10016a:	89 c2                	mov    %eax,%edx
  10016c:	8b 83 70 01 00 00    	mov    0x170(%ebx),%eax
  100172:	83 ec 04             	sub    $0x4,%esp
  100175:	52                   	push   %edx
  100176:	50                   	push   %eax
  100177:	8d 83 3d 40 ff ff    	lea    -0xbfc3(%ebx),%eax
  10017d:	50                   	push   %eax
  10017e:	e8 9c 01 00 00       	call   10031f <cprintf>
  100183:	83 c4 10             	add    $0x10,%esp
    cprintf("%d:  cs = %x\n", round, reg1);
  100186:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  10018a:	0f b7 d0             	movzwl %ax,%edx
  10018d:	8b 83 70 01 00 00    	mov    0x170(%ebx),%eax
  100193:	83 ec 04             	sub    $0x4,%esp
  100196:	52                   	push   %edx
  100197:	50                   	push   %eax
  100198:	8d 83 4b 40 ff ff    	lea    -0xbfb5(%ebx),%eax
  10019e:	50                   	push   %eax
  10019f:	e8 7b 01 00 00       	call   10031f <cprintf>
  1001a4:	83 c4 10             	add    $0x10,%esp
    cprintf("%d:  ds = %x\n", round, reg2);
  1001a7:	0f b7 45 f4          	movzwl -0xc(%ebp),%eax
  1001ab:	0f b7 d0             	movzwl %ax,%edx
  1001ae:	8b 83 70 01 00 00    	mov    0x170(%ebx),%eax
  1001b4:	83 ec 04             	sub    $0x4,%esp
  1001b7:	52                   	push   %edx
  1001b8:	50                   	push   %eax
  1001b9:	8d 83 59 40 ff ff    	lea    -0xbfa7(%ebx),%eax
  1001bf:	50                   	push   %eax
  1001c0:	e8 5a 01 00 00       	call   10031f <cprintf>
  1001c5:	83 c4 10             	add    $0x10,%esp
    cprintf("%d:  es = %x\n", round, reg3);
  1001c8:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
  1001cc:	0f b7 d0             	movzwl %ax,%edx
  1001cf:	8b 83 70 01 00 00    	mov    0x170(%ebx),%eax
  1001d5:	83 ec 04             	sub    $0x4,%esp
  1001d8:	52                   	push   %edx
  1001d9:	50                   	push   %eax
  1001da:	8d 83 67 40 ff ff    	lea    -0xbf99(%ebx),%eax
  1001e0:	50                   	push   %eax
  1001e1:	e8 39 01 00 00       	call   10031f <cprintf>
  1001e6:	83 c4 10             	add    $0x10,%esp
    cprintf("%d:  ss = %x\n", round, reg4);
  1001e9:	0f b7 45 f0          	movzwl -0x10(%ebp),%eax
  1001ed:	0f b7 d0             	movzwl %ax,%edx
  1001f0:	8b 83 70 01 00 00    	mov    0x170(%ebx),%eax
  1001f6:	83 ec 04             	sub    $0x4,%esp
  1001f9:	52                   	push   %edx
  1001fa:	50                   	push   %eax
  1001fb:	8d 83 75 40 ff ff    	lea    -0xbf8b(%ebx),%eax
  100201:	50                   	push   %eax
  100202:	e8 18 01 00 00       	call   10031f <cprintf>
  100207:	83 c4 10             	add    $0x10,%esp
    round ++;
  10020a:	8b 83 70 01 00 00    	mov    0x170(%ebx),%eax
  100210:	83 c0 01             	add    $0x1,%eax
  100213:	89 83 70 01 00 00    	mov    %eax,0x170(%ebx)
}
  100219:	90                   	nop
  10021a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  10021d:	c9                   	leave  
  10021e:	c3                   	ret    

0010021f <lab1_switch_to_user>:

static void
lab1_switch_to_user(void) {
  10021f:	f3 0f 1e fb          	endbr32 
  100223:	55                   	push   %ebp
  100224:	89 e5                	mov    %esp,%ebp
  100226:	e8 75 00 00 00       	call   1002a0 <__x86.get_pc_thunk.ax>
  10022b:	05 25 f7 00 00       	add    $0xf725,%eax
    //LAB1 CHALLENGE 1 : TODO
}
  100230:	90                   	nop
  100231:	5d                   	pop    %ebp
  100232:	c3                   	ret    

00100233 <lab1_switch_to_kernel>:

static void
lab1_switch_to_kernel(void) {
  100233:	f3 0f 1e fb          	endbr32 
  100237:	55                   	push   %ebp
  100238:	89 e5                	mov    %esp,%ebp
  10023a:	e8 61 00 00 00       	call   1002a0 <__x86.get_pc_thunk.ax>
  10023f:	05 11 f7 00 00       	add    $0xf711,%eax
    //LAB1 CHALLENGE 1 :  TODO
}
  100244:	90                   	nop
  100245:	5d                   	pop    %ebp
  100246:	c3                   	ret    

00100247 <lab1_switch_test>:

static void
lab1_switch_test(void) {
  100247:	f3 0f 1e fb          	endbr32 
  10024b:	55                   	push   %ebp
  10024c:	89 e5                	mov    %esp,%ebp
  10024e:	53                   	push   %ebx
  10024f:	83 ec 04             	sub    $0x4,%esp
  100252:	e8 4d 00 00 00       	call   1002a4 <__x86.get_pc_thunk.bx>
  100257:	81 c3 f9 f6 00 00    	add    $0xf6f9,%ebx
    lab1_print_cur_status();
  10025d:	e8 dc fe ff ff       	call   10013e <lab1_print_cur_status>
    cprintf("+++ switch to  user  mode +++\n");
  100262:	83 ec 0c             	sub    $0xc,%esp
  100265:	8d 83 84 40 ff ff    	lea    -0xbf7c(%ebx),%eax
  10026b:	50                   	push   %eax
  10026c:	e8 ae 00 00 00       	call   10031f <cprintf>
  100271:	83 c4 10             	add    $0x10,%esp
    lab1_switch_to_user();
  100274:	e8 a6 ff ff ff       	call   10021f <lab1_switch_to_user>
    lab1_print_cur_status();
  100279:	e8 c0 fe ff ff       	call   10013e <lab1_print_cur_status>
    cprintf("+++ switch to kernel mode +++\n");
  10027e:	83 ec 0c             	sub    $0xc,%esp
  100281:	8d 83 a4 40 ff ff    	lea    -0xbf5c(%ebx),%eax
  100287:	50                   	push   %eax
  100288:	e8 92 00 00 00       	call   10031f <cprintf>
  10028d:	83 c4 10             	add    $0x10,%esp
    lab1_switch_to_kernel();
  100290:	e8 9e ff ff ff       	call   100233 <lab1_switch_to_kernel>
    lab1_print_cur_status();
  100295:	e8 a4 fe ff ff       	call   10013e <lab1_print_cur_status>
}
  10029a:	90                   	nop
  10029b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  10029e:	c9                   	leave  
  10029f:	c3                   	ret    

001002a0 <__x86.get_pc_thunk.ax>:
  1002a0:	8b 04 24             	mov    (%esp),%eax
  1002a3:	c3                   	ret    

001002a4 <__x86.get_pc_thunk.bx>:
  1002a4:	8b 1c 24             	mov    (%esp),%ebx
  1002a7:	c3                   	ret    

001002a8 <cputch>:
/* *
 * cputch - writes a single character @c to stdout, and it will
 * increace the value of counter pointed by @cnt.
 * */
static void
cputch(int c, int *cnt) {
  1002a8:	f3 0f 1e fb          	endbr32 
  1002ac:	55                   	push   %ebp
  1002ad:	89 e5                	mov    %esp,%ebp
  1002af:	53                   	push   %ebx
  1002b0:	83 ec 04             	sub    $0x4,%esp
  1002b3:	e8 e8 ff ff ff       	call   1002a0 <__x86.get_pc_thunk.ax>
  1002b8:	05 98 f6 00 00       	add    $0xf698,%eax
    cons_putc(c);
  1002bd:	83 ec 0c             	sub    $0xc,%esp
  1002c0:	ff 75 08             	pushl  0x8(%ebp)
  1002c3:	89 c3                	mov    %eax,%ebx
  1002c5:	e8 cb 16 00 00       	call   101995 <cons_putc>
  1002ca:	83 c4 10             	add    $0x10,%esp
    (*cnt) ++;
  1002cd:	8b 45 0c             	mov    0xc(%ebp),%eax
  1002d0:	8b 00                	mov    (%eax),%eax
  1002d2:	8d 50 01             	lea    0x1(%eax),%edx
  1002d5:	8b 45 0c             	mov    0xc(%ebp),%eax
  1002d8:	89 10                	mov    %edx,(%eax)
}
  1002da:	90                   	nop
  1002db:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  1002de:	c9                   	leave  
  1002df:	c3                   	ret    

001002e0 <vcprintf>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want cprintf() instead.
 * */
int
vcprintf(const char *fmt, va_list ap) {
  1002e0:	f3 0f 1e fb          	endbr32 
  1002e4:	55                   	push   %ebp
  1002e5:	89 e5                	mov    %esp,%ebp
  1002e7:	53                   	push   %ebx
  1002e8:	83 ec 14             	sub    $0x14,%esp
  1002eb:	e8 b0 ff ff ff       	call   1002a0 <__x86.get_pc_thunk.ax>
  1002f0:	05 60 f6 00 00       	add    $0xf660,%eax
    int cnt = 0;
  1002f5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    vprintfmt((void*)cputch, &cnt, fmt, ap);
  1002fc:	ff 75 0c             	pushl  0xc(%ebp)
  1002ff:	ff 75 08             	pushl  0x8(%ebp)
  100302:	8d 55 f4             	lea    -0xc(%ebp),%edx
  100305:	52                   	push   %edx
  100306:	8d 90 58 09 ff ff    	lea    -0xf6a8(%eax),%edx
  10030c:	52                   	push   %edx
  10030d:	89 c3                	mov    %eax,%ebx
  10030f:	e8 a8 31 00 00       	call   1034bc <vprintfmt>
  100314:	83 c4 10             	add    $0x10,%esp
    return cnt;
  100317:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  10031a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  10031d:	c9                   	leave  
  10031e:	c3                   	ret    

0010031f <cprintf>:
 *
 * The return value is the number of characters which would be
 * written to stdout.
 * */
int
cprintf(const char *fmt, ...) {
  10031f:	f3 0f 1e fb          	endbr32 
  100323:	55                   	push   %ebp
  100324:	89 e5                	mov    %esp,%ebp
  100326:	83 ec 18             	sub    $0x18,%esp
  100329:	e8 72 ff ff ff       	call   1002a0 <__x86.get_pc_thunk.ax>
  10032e:	05 22 f6 00 00       	add    $0xf622,%eax
    va_list ap;
    int cnt;
    va_start(ap, fmt);
  100333:	8d 45 0c             	lea    0xc(%ebp),%eax
  100336:	89 45 f0             	mov    %eax,-0x10(%ebp)
    cnt = vcprintf(fmt, ap);
  100339:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10033c:	83 ec 08             	sub    $0x8,%esp
  10033f:	50                   	push   %eax
  100340:	ff 75 08             	pushl  0x8(%ebp)
  100343:	e8 98 ff ff ff       	call   1002e0 <vcprintf>
  100348:	83 c4 10             	add    $0x10,%esp
  10034b:	89 45 f4             	mov    %eax,-0xc(%ebp)
    va_end(ap);
    return cnt;
  10034e:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  100351:	c9                   	leave  
  100352:	c3                   	ret    

00100353 <cputchar>:

/* cputchar - writes a single character to stdout */
void
cputchar(int c) {
  100353:	f3 0f 1e fb          	endbr32 
  100357:	55                   	push   %ebp
  100358:	89 e5                	mov    %esp,%ebp
  10035a:	53                   	push   %ebx
  10035b:	83 ec 04             	sub    $0x4,%esp
  10035e:	e8 3d ff ff ff       	call   1002a0 <__x86.get_pc_thunk.ax>
  100363:	05 ed f5 00 00       	add    $0xf5ed,%eax
    cons_putc(c);
  100368:	83 ec 0c             	sub    $0xc,%esp
  10036b:	ff 75 08             	pushl  0x8(%ebp)
  10036e:	89 c3                	mov    %eax,%ebx
  100370:	e8 20 16 00 00       	call   101995 <cons_putc>
  100375:	83 c4 10             	add    $0x10,%esp
}
  100378:	90                   	nop
  100379:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  10037c:	c9                   	leave  
  10037d:	c3                   	ret    

0010037e <cputs>:
/* *
 * cputs- writes the string pointed by @str to stdout and
 * appends a newline character.
 * */
int
cputs(const char *str) {
  10037e:	f3 0f 1e fb          	endbr32 
  100382:	55                   	push   %ebp
  100383:	89 e5                	mov    %esp,%ebp
  100385:	83 ec 18             	sub    $0x18,%esp
  100388:	e8 13 ff ff ff       	call   1002a0 <__x86.get_pc_thunk.ax>
  10038d:	05 c3 f5 00 00       	add    $0xf5c3,%eax
    int cnt = 0;
  100392:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    char c;
    while ((c = *str ++) != '\0') {
  100399:	eb 14                	jmp    1003af <cputs+0x31>
        cputch(c, &cnt);
  10039b:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  10039f:	83 ec 08             	sub    $0x8,%esp
  1003a2:	8d 55 f0             	lea    -0x10(%ebp),%edx
  1003a5:	52                   	push   %edx
  1003a6:	50                   	push   %eax
  1003a7:	e8 fc fe ff ff       	call   1002a8 <cputch>
  1003ac:	83 c4 10             	add    $0x10,%esp
    while ((c = *str ++) != '\0') {
  1003af:	8b 45 08             	mov    0x8(%ebp),%eax
  1003b2:	8d 50 01             	lea    0x1(%eax),%edx
  1003b5:	89 55 08             	mov    %edx,0x8(%ebp)
  1003b8:	0f b6 00             	movzbl (%eax),%eax
  1003bb:	88 45 f7             	mov    %al,-0x9(%ebp)
  1003be:	80 7d f7 00          	cmpb   $0x0,-0x9(%ebp)
  1003c2:	75 d7                	jne    10039b <cputs+0x1d>
    }
    cputch('\n', &cnt);
  1003c4:	83 ec 08             	sub    $0x8,%esp
  1003c7:	8d 45 f0             	lea    -0x10(%ebp),%eax
  1003ca:	50                   	push   %eax
  1003cb:	6a 0a                	push   $0xa
  1003cd:	e8 d6 fe ff ff       	call   1002a8 <cputch>
  1003d2:	83 c4 10             	add    $0x10,%esp
    return cnt;
  1003d5:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  1003d8:	c9                   	leave  
  1003d9:	c3                   	ret    

001003da <getchar>:

/* getchar - reads a single non-zero character from stdin */
int
getchar(void) {
  1003da:	f3 0f 1e fb          	endbr32 
  1003de:	55                   	push   %ebp
  1003df:	89 e5                	mov    %esp,%ebp
  1003e1:	53                   	push   %ebx
  1003e2:	83 ec 14             	sub    $0x14,%esp
  1003e5:	e8 ba fe ff ff       	call   1002a4 <__x86.get_pc_thunk.bx>
  1003ea:	81 c3 66 f5 00 00    	add    $0xf566,%ebx
    int c;
    while ((c = cons_getc()) == 0)
  1003f0:	90                   	nop
  1003f1:	e8 dd 15 00 00       	call   1019d3 <cons_getc>
  1003f6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1003f9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  1003fd:	74 f2                	je     1003f1 <getchar+0x17>
        /* do nothing */;
    return c;
  1003ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  100402:	83 c4 14             	add    $0x14,%esp
  100405:	5b                   	pop    %ebx
  100406:	5d                   	pop    %ebp
  100407:	c3                   	ret    

00100408 <readline>:
 * The readline() function returns the text of the line read. If some errors
 * are happened, NULL is returned. The return value is a global variable,
 * thus it should be copied before it is used.
 * */
char *
readline(const char *prompt) {
  100408:	f3 0f 1e fb          	endbr32 
  10040c:	55                   	push   %ebp
  10040d:	89 e5                	mov    %esp,%ebp
  10040f:	53                   	push   %ebx
  100410:	83 ec 14             	sub    $0x14,%esp
  100413:	e8 8c fe ff ff       	call   1002a4 <__x86.get_pc_thunk.bx>
  100418:	81 c3 38 f5 00 00    	add    $0xf538,%ebx
    if (prompt != NULL) {
  10041e:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  100422:	74 15                	je     100439 <readline+0x31>
        cprintf("%s", prompt);
  100424:	83 ec 08             	sub    $0x8,%esp
  100427:	ff 75 08             	pushl  0x8(%ebp)
  10042a:	8d 83 c3 40 ff ff    	lea    -0xbf3d(%ebx),%eax
  100430:	50                   	push   %eax
  100431:	e8 e9 fe ff ff       	call   10031f <cprintf>
  100436:	83 c4 10             	add    $0x10,%esp
    }
    int i = 0, c;
  100439:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while (1) {
        c = getchar();
  100440:	e8 95 ff ff ff       	call   1003da <getchar>
  100445:	89 45 f0             	mov    %eax,-0x10(%ebp)
        if (c < 0) {
  100448:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  10044c:	79 0a                	jns    100458 <readline+0x50>
            return NULL;
  10044e:	b8 00 00 00 00       	mov    $0x0,%eax
  100453:	e9 87 00 00 00       	jmp    1004df <readline+0xd7>
        }
        else if (c >= ' ' && i < BUFSIZE - 1) {
  100458:	83 7d f0 1f          	cmpl   $0x1f,-0x10(%ebp)
  10045c:	7e 2c                	jle    10048a <readline+0x82>
  10045e:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  100465:	7f 23                	jg     10048a <readline+0x82>
            cputchar(c);
  100467:	83 ec 0c             	sub    $0xc,%esp
  10046a:	ff 75 f0             	pushl  -0x10(%ebp)
  10046d:	e8 e1 fe ff ff       	call   100353 <cputchar>
  100472:	83 c4 10             	add    $0x10,%esp
            buf[i ++] = c;
  100475:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100478:	8d 50 01             	lea    0x1(%eax),%edx
  10047b:	89 55 f4             	mov    %edx,-0xc(%ebp)
  10047e:	8b 55 f0             	mov    -0x10(%ebp),%edx
  100481:	88 94 03 90 01 00 00 	mov    %dl,0x190(%ebx,%eax,1)
  100488:	eb 50                	jmp    1004da <readline+0xd2>
        }
        else if (c == '\b' && i > 0) {
  10048a:	83 7d f0 08          	cmpl   $0x8,-0x10(%ebp)
  10048e:	75 1a                	jne    1004aa <readline+0xa2>
  100490:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  100494:	7e 14                	jle    1004aa <readline+0xa2>
            cputchar(c);
  100496:	83 ec 0c             	sub    $0xc,%esp
  100499:	ff 75 f0             	pushl  -0x10(%ebp)
  10049c:	e8 b2 fe ff ff       	call   100353 <cputchar>
  1004a1:	83 c4 10             	add    $0x10,%esp
            i --;
  1004a4:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
  1004a8:	eb 30                	jmp    1004da <readline+0xd2>
        }
        else if (c == '\n' || c == '\r') {
  1004aa:	83 7d f0 0a          	cmpl   $0xa,-0x10(%ebp)
  1004ae:	74 06                	je     1004b6 <readline+0xae>
  1004b0:	83 7d f0 0d          	cmpl   $0xd,-0x10(%ebp)
  1004b4:	75 8a                	jne    100440 <readline+0x38>
            cputchar(c);
  1004b6:	83 ec 0c             	sub    $0xc,%esp
  1004b9:	ff 75 f0             	pushl  -0x10(%ebp)
  1004bc:	e8 92 fe ff ff       	call   100353 <cputchar>
  1004c1:	83 c4 10             	add    $0x10,%esp
            buf[i] = '\0';
  1004c4:	8d 93 90 01 00 00    	lea    0x190(%ebx),%edx
  1004ca:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1004cd:	01 d0                	add    %edx,%eax
  1004cf:	c6 00 00             	movb   $0x0,(%eax)
            return buf;
  1004d2:	8d 83 90 01 00 00    	lea    0x190(%ebx),%eax
  1004d8:	eb 05                	jmp    1004df <readline+0xd7>
        c = getchar();
  1004da:	e9 61 ff ff ff       	jmp    100440 <readline+0x38>
        }
    }
}
  1004df:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  1004e2:	c9                   	leave  
  1004e3:	c3                   	ret    

001004e4 <__panic>:
/* *
 * __panic - __panic is called on unresolvable fatal errors. it prints
 * "panic: 'message'", and then enters the kernel monitor.
 * */
void
__panic(const char *file, int line, const char *fmt, ...) {
  1004e4:	f3 0f 1e fb          	endbr32 
  1004e8:	55                   	push   %ebp
  1004e9:	89 e5                	mov    %esp,%ebp
  1004eb:	53                   	push   %ebx
  1004ec:	83 ec 14             	sub    $0x14,%esp
  1004ef:	e8 b0 fd ff ff       	call   1002a4 <__x86.get_pc_thunk.bx>
  1004f4:	81 c3 5c f4 00 00    	add    $0xf45c,%ebx
    if (is_panic) {
  1004fa:	8b 83 90 05 00 00    	mov    0x590(%ebx),%eax
  100500:	85 c0                	test   %eax,%eax
  100502:	75 4e                	jne    100552 <__panic+0x6e>
        goto panic_dead;
    }
    is_panic = 1;
  100504:	c7 83 90 05 00 00 01 	movl   $0x1,0x590(%ebx)
  10050b:	00 00 00 

    // print the 'message'
    va_list ap;
    va_start(ap, fmt);
  10050e:	8d 45 14             	lea    0x14(%ebp),%eax
  100511:	89 45 f4             	mov    %eax,-0xc(%ebp)
    cprintf("kernel panic at %s:%d:\n    ", file, line);
  100514:	83 ec 04             	sub    $0x4,%esp
  100517:	ff 75 0c             	pushl  0xc(%ebp)
  10051a:	ff 75 08             	pushl  0x8(%ebp)
  10051d:	8d 83 c6 40 ff ff    	lea    -0xbf3a(%ebx),%eax
  100523:	50                   	push   %eax
  100524:	e8 f6 fd ff ff       	call   10031f <cprintf>
  100529:	83 c4 10             	add    $0x10,%esp
    vcprintf(fmt, ap);
  10052c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10052f:	83 ec 08             	sub    $0x8,%esp
  100532:	50                   	push   %eax
  100533:	ff 75 10             	pushl  0x10(%ebp)
  100536:	e8 a5 fd ff ff       	call   1002e0 <vcprintf>
  10053b:	83 c4 10             	add    $0x10,%esp
    cprintf("\n");
  10053e:	83 ec 0c             	sub    $0xc,%esp
  100541:	8d 83 e2 40 ff ff    	lea    -0xbf1e(%ebx),%eax
  100547:	50                   	push   %eax
  100548:	e8 d2 fd ff ff       	call   10031f <cprintf>
  10054d:	83 c4 10             	add    $0x10,%esp
  100550:	eb 01                	jmp    100553 <__panic+0x6f>
        goto panic_dead;
  100552:	90                   	nop
    va_end(ap);

panic_dead:
    intr_disable();
  100553:	e8 0b 17 00 00       	call   101c63 <intr_disable>
    while (1) {
        kmonitor(NULL);
  100558:	83 ec 0c             	sub    $0xc,%esp
  10055b:	6a 00                	push   $0x0
  10055d:	e8 3f 09 00 00       	call   100ea1 <kmonitor>
  100562:	83 c4 10             	add    $0x10,%esp
  100565:	eb f1                	jmp    100558 <__panic+0x74>

00100567 <__warn>:
    }
}

/* __warn - like panic, but don't */
void
__warn(const char *file, int line, const char *fmt, ...) {
  100567:	f3 0f 1e fb          	endbr32 
  10056b:	55                   	push   %ebp
  10056c:	89 e5                	mov    %esp,%ebp
  10056e:	53                   	push   %ebx
  10056f:	83 ec 14             	sub    $0x14,%esp
  100572:	e8 2d fd ff ff       	call   1002a4 <__x86.get_pc_thunk.bx>
  100577:	81 c3 d9 f3 00 00    	add    $0xf3d9,%ebx
    va_list ap;
    va_start(ap, fmt);
  10057d:	8d 45 14             	lea    0x14(%ebp),%eax
  100580:	89 45 f4             	mov    %eax,-0xc(%ebp)
    cprintf("kernel warning at %s:%d:\n    ", file, line);
  100583:	83 ec 04             	sub    $0x4,%esp
  100586:	ff 75 0c             	pushl  0xc(%ebp)
  100589:	ff 75 08             	pushl  0x8(%ebp)
  10058c:	8d 83 e4 40 ff ff    	lea    -0xbf1c(%ebx),%eax
  100592:	50                   	push   %eax
  100593:	e8 87 fd ff ff       	call   10031f <cprintf>
  100598:	83 c4 10             	add    $0x10,%esp
    vcprintf(fmt, ap);
  10059b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10059e:	83 ec 08             	sub    $0x8,%esp
  1005a1:	50                   	push   %eax
  1005a2:	ff 75 10             	pushl  0x10(%ebp)
  1005a5:	e8 36 fd ff ff       	call   1002e0 <vcprintf>
  1005aa:	83 c4 10             	add    $0x10,%esp
    cprintf("\n");
  1005ad:	83 ec 0c             	sub    $0xc,%esp
  1005b0:	8d 83 e2 40 ff ff    	lea    -0xbf1e(%ebx),%eax
  1005b6:	50                   	push   %eax
  1005b7:	e8 63 fd ff ff       	call   10031f <cprintf>
  1005bc:	83 c4 10             	add    $0x10,%esp
    va_end(ap);
}
  1005bf:	90                   	nop
  1005c0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  1005c3:	c9                   	leave  
  1005c4:	c3                   	ret    

001005c5 <is_kernel_panic>:

bool
is_kernel_panic(void) {
  1005c5:	f3 0f 1e fb          	endbr32 
  1005c9:	55                   	push   %ebp
  1005ca:	89 e5                	mov    %esp,%ebp
  1005cc:	e8 cf fc ff ff       	call   1002a0 <__x86.get_pc_thunk.ax>
  1005d1:	05 7f f3 00 00       	add    $0xf37f,%eax
    return is_panic;
  1005d6:	8b 80 90 05 00 00    	mov    0x590(%eax),%eax
}
  1005dc:	5d                   	pop    %ebp
  1005dd:	c3                   	ret    

001005de <stab_binsearch>:
 *      stab_binsearch(stabs, &left, &right, N_SO, 0xf0100184);
 * will exit setting left = 118, right = 554.
 * */
static void
stab_binsearch(const struct stab *stabs, int *region_left, int *region_right,
           int type, uintptr_t addr) {
  1005de:	f3 0f 1e fb          	endbr32 
  1005e2:	55                   	push   %ebp
  1005e3:	89 e5                	mov    %esp,%ebp
  1005e5:	83 ec 20             	sub    $0x20,%esp
  1005e8:	e8 b3 fc ff ff       	call   1002a0 <__x86.get_pc_thunk.ax>
  1005ed:	05 63 f3 00 00       	add    $0xf363,%eax
    int l = *region_left, r = *region_right, any_matches = 0;
  1005f2:	8b 45 0c             	mov    0xc(%ebp),%eax
  1005f5:	8b 00                	mov    (%eax),%eax
  1005f7:	89 45 fc             	mov    %eax,-0x4(%ebp)
  1005fa:	8b 45 10             	mov    0x10(%ebp),%eax
  1005fd:	8b 00                	mov    (%eax),%eax
  1005ff:	89 45 f8             	mov    %eax,-0x8(%ebp)
  100602:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

    while (l <= r) {
  100609:	e9 d2 00 00 00       	jmp    1006e0 <stab_binsearch+0x102>
        int true_m = (l + r) / 2, m = true_m;
  10060e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  100611:	8b 45 f8             	mov    -0x8(%ebp),%eax
  100614:	01 d0                	add    %edx,%eax
  100616:	89 c2                	mov    %eax,%edx
  100618:	c1 ea 1f             	shr    $0x1f,%edx
  10061b:	01 d0                	add    %edx,%eax
  10061d:	d1 f8                	sar    %eax
  10061f:	89 45 ec             	mov    %eax,-0x14(%ebp)
  100622:	8b 45 ec             	mov    -0x14(%ebp),%eax
  100625:	89 45 f0             	mov    %eax,-0x10(%ebp)

        // search for earliest stab with right type
        while (m >= l && stabs[m].n_type != type) {
  100628:	eb 04                	jmp    10062e <stab_binsearch+0x50>
            m --;
  10062a:	83 6d f0 01          	subl   $0x1,-0x10(%ebp)
        while (m >= l && stabs[m].n_type != type) {
  10062e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100631:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  100634:	7c 1f                	jl     100655 <stab_binsearch+0x77>
  100636:	8b 55 f0             	mov    -0x10(%ebp),%edx
  100639:	89 d0                	mov    %edx,%eax
  10063b:	01 c0                	add    %eax,%eax
  10063d:	01 d0                	add    %edx,%eax
  10063f:	c1 e0 02             	shl    $0x2,%eax
  100642:	89 c2                	mov    %eax,%edx
  100644:	8b 45 08             	mov    0x8(%ebp),%eax
  100647:	01 d0                	add    %edx,%eax
  100649:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  10064d:	0f b6 c0             	movzbl %al,%eax
  100650:	39 45 14             	cmp    %eax,0x14(%ebp)
  100653:	75 d5                	jne    10062a <stab_binsearch+0x4c>
        }
        if (m < l) {    // no match in [l, m]
  100655:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100658:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  10065b:	7d 0b                	jge    100668 <stab_binsearch+0x8a>
            l = true_m + 1;
  10065d:	8b 45 ec             	mov    -0x14(%ebp),%eax
  100660:	83 c0 01             	add    $0x1,%eax
  100663:	89 45 fc             	mov    %eax,-0x4(%ebp)
            continue;
  100666:	eb 78                	jmp    1006e0 <stab_binsearch+0x102>
        }

        // actual binary search
        any_matches = 1;
  100668:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        if (stabs[m].n_value < addr) {
  10066f:	8b 55 f0             	mov    -0x10(%ebp),%edx
  100672:	89 d0                	mov    %edx,%eax
  100674:	01 c0                	add    %eax,%eax
  100676:	01 d0                	add    %edx,%eax
  100678:	c1 e0 02             	shl    $0x2,%eax
  10067b:	89 c2                	mov    %eax,%edx
  10067d:	8b 45 08             	mov    0x8(%ebp),%eax
  100680:	01 d0                	add    %edx,%eax
  100682:	8b 40 08             	mov    0x8(%eax),%eax
  100685:	39 45 18             	cmp    %eax,0x18(%ebp)
  100688:	76 13                	jbe    10069d <stab_binsearch+0xbf>
            *region_left = m;
  10068a:	8b 45 0c             	mov    0xc(%ebp),%eax
  10068d:	8b 55 f0             	mov    -0x10(%ebp),%edx
  100690:	89 10                	mov    %edx,(%eax)
            l = true_m + 1;
  100692:	8b 45 ec             	mov    -0x14(%ebp),%eax
  100695:	83 c0 01             	add    $0x1,%eax
  100698:	89 45 fc             	mov    %eax,-0x4(%ebp)
  10069b:	eb 43                	jmp    1006e0 <stab_binsearch+0x102>
        } else if (stabs[m].n_value > addr) {
  10069d:	8b 55 f0             	mov    -0x10(%ebp),%edx
  1006a0:	89 d0                	mov    %edx,%eax
  1006a2:	01 c0                	add    %eax,%eax
  1006a4:	01 d0                	add    %edx,%eax
  1006a6:	c1 e0 02             	shl    $0x2,%eax
  1006a9:	89 c2                	mov    %eax,%edx
  1006ab:	8b 45 08             	mov    0x8(%ebp),%eax
  1006ae:	01 d0                	add    %edx,%eax
  1006b0:	8b 40 08             	mov    0x8(%eax),%eax
  1006b3:	39 45 18             	cmp    %eax,0x18(%ebp)
  1006b6:	73 16                	jae    1006ce <stab_binsearch+0xf0>
            *region_right = m - 1;
  1006b8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1006bb:	8d 50 ff             	lea    -0x1(%eax),%edx
  1006be:	8b 45 10             	mov    0x10(%ebp),%eax
  1006c1:	89 10                	mov    %edx,(%eax)
            r = m - 1;
  1006c3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1006c6:	83 e8 01             	sub    $0x1,%eax
  1006c9:	89 45 f8             	mov    %eax,-0x8(%ebp)
  1006cc:	eb 12                	jmp    1006e0 <stab_binsearch+0x102>
        } else {
            // exact match for 'addr', but continue loop to find
            // *region_right
            *region_left = m;
  1006ce:	8b 45 0c             	mov    0xc(%ebp),%eax
  1006d1:	8b 55 f0             	mov    -0x10(%ebp),%edx
  1006d4:	89 10                	mov    %edx,(%eax)
            l = m;
  1006d6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1006d9:	89 45 fc             	mov    %eax,-0x4(%ebp)
            addr ++;
  1006dc:	83 45 18 01          	addl   $0x1,0x18(%ebp)
    while (l <= r) {
  1006e0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1006e3:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  1006e6:	0f 8e 22 ff ff ff    	jle    10060e <stab_binsearch+0x30>
        }
    }

    if (!any_matches) {
  1006ec:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  1006f0:	75 0f                	jne    100701 <stab_binsearch+0x123>
        *region_right = *region_left - 1;
  1006f2:	8b 45 0c             	mov    0xc(%ebp),%eax
  1006f5:	8b 00                	mov    (%eax),%eax
  1006f7:	8d 50 ff             	lea    -0x1(%eax),%edx
  1006fa:	8b 45 10             	mov    0x10(%ebp),%eax
  1006fd:	89 10                	mov    %edx,(%eax)
        l = *region_right;
        for (; l > *region_left && stabs[l].n_type != type; l --)
            /* do nothing */;
        *region_left = l;
    }
}
  1006ff:	eb 3f                	jmp    100740 <stab_binsearch+0x162>
        l = *region_right;
  100701:	8b 45 10             	mov    0x10(%ebp),%eax
  100704:	8b 00                	mov    (%eax),%eax
  100706:	89 45 fc             	mov    %eax,-0x4(%ebp)
        for (; l > *region_left && stabs[l].n_type != type; l --)
  100709:	eb 04                	jmp    10070f <stab_binsearch+0x131>
  10070b:	83 6d fc 01          	subl   $0x1,-0x4(%ebp)
  10070f:	8b 45 0c             	mov    0xc(%ebp),%eax
  100712:	8b 00                	mov    (%eax),%eax
  100714:	39 45 fc             	cmp    %eax,-0x4(%ebp)
  100717:	7e 1f                	jle    100738 <stab_binsearch+0x15a>
  100719:	8b 55 fc             	mov    -0x4(%ebp),%edx
  10071c:	89 d0                	mov    %edx,%eax
  10071e:	01 c0                	add    %eax,%eax
  100720:	01 d0                	add    %edx,%eax
  100722:	c1 e0 02             	shl    $0x2,%eax
  100725:	89 c2                	mov    %eax,%edx
  100727:	8b 45 08             	mov    0x8(%ebp),%eax
  10072a:	01 d0                	add    %edx,%eax
  10072c:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  100730:	0f b6 c0             	movzbl %al,%eax
  100733:	39 45 14             	cmp    %eax,0x14(%ebp)
  100736:	75 d3                	jne    10070b <stab_binsearch+0x12d>
        *region_left = l;
  100738:	8b 45 0c             	mov    0xc(%ebp),%eax
  10073b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  10073e:	89 10                	mov    %edx,(%eax)
}
  100740:	90                   	nop
  100741:	c9                   	leave  
  100742:	c3                   	ret    

00100743 <debuginfo_eip>:
 * the specified instruction address, @addr.  Returns 0 if information
 * was found, and negative if not.  But even if it returns negative it
 * has stored some information into '*info'.
 * */
int
debuginfo_eip(uintptr_t addr, struct eipdebuginfo *info) {
  100743:	f3 0f 1e fb          	endbr32 
  100747:	55                   	push   %ebp
  100748:	89 e5                	mov    %esp,%ebp
  10074a:	53                   	push   %ebx
  10074b:	83 ec 34             	sub    $0x34,%esp
  10074e:	e8 51 fb ff ff       	call   1002a4 <__x86.get_pc_thunk.bx>
  100753:	81 c3 fd f1 00 00    	add    $0xf1fd,%ebx
    const struct stab *stabs, *stab_end;
    const char *stabstr, *stabstr_end;

    info->eip_file = "<unknown>";
  100759:	8b 45 0c             	mov    0xc(%ebp),%eax
  10075c:	8d 93 04 41 ff ff    	lea    -0xbefc(%ebx),%edx
  100762:	89 10                	mov    %edx,(%eax)
    info->eip_line = 0;
  100764:	8b 45 0c             	mov    0xc(%ebp),%eax
  100767:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    info->eip_fn_name = "<unknown>";
  10076e:	8b 45 0c             	mov    0xc(%ebp),%eax
  100771:	8d 93 04 41 ff ff    	lea    -0xbefc(%ebx),%edx
  100777:	89 50 08             	mov    %edx,0x8(%eax)
    info->eip_fn_namelen = 9;
  10077a:	8b 45 0c             	mov    0xc(%ebp),%eax
  10077d:	c7 40 0c 09 00 00 00 	movl   $0x9,0xc(%eax)
    info->eip_fn_addr = addr;
  100784:	8b 45 0c             	mov    0xc(%ebp),%eax
  100787:	8b 55 08             	mov    0x8(%ebp),%edx
  10078a:	89 50 10             	mov    %edx,0x10(%eax)
    info->eip_fn_narg = 0;
  10078d:	8b 45 0c             	mov    0xc(%ebp),%eax
  100790:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)

    stabs = __STAB_BEGIN__;
  100797:	c7 c0 18 42 10 00    	mov    $0x104218,%eax
  10079d:	89 45 f4             	mov    %eax,-0xc(%ebp)
    stab_end = __STAB_END__;
  1007a0:	c7 c0 34 ce 10 00    	mov    $0x10ce34,%eax
  1007a6:	89 45 f0             	mov    %eax,-0x10(%ebp)
    stabstr = __STABSTR_BEGIN__;
  1007a9:	c7 c0 35 ce 10 00    	mov    $0x10ce35,%eax
  1007af:	89 45 ec             	mov    %eax,-0x14(%ebp)
    stabstr_end = __STABSTR_END__;
  1007b2:	c7 c0 1f ef 10 00    	mov    $0x10ef1f,%eax
  1007b8:	89 45 e8             	mov    %eax,-0x18(%ebp)

    // String table validity checks
    if (stabstr_end <= stabstr || stabstr_end[-1] != 0) {
  1007bb:	8b 45 e8             	mov    -0x18(%ebp),%eax
  1007be:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  1007c1:	76 0d                	jbe    1007d0 <debuginfo_eip+0x8d>
  1007c3:	8b 45 e8             	mov    -0x18(%ebp),%eax
  1007c6:	83 e8 01             	sub    $0x1,%eax
  1007c9:	0f b6 00             	movzbl (%eax),%eax
  1007cc:	84 c0                	test   %al,%al
  1007ce:	74 0a                	je     1007da <debuginfo_eip+0x97>
        return -1;
  1007d0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  1007d5:	e9 85 02 00 00       	jmp    100a5f <debuginfo_eip+0x31c>
    // 'eip'.  First, we find the basic source file containing 'eip'.
    // Then, we look in that source file for the function.  Then we look
    // for the line number.

    // Search the entire set of stabs for the source file (type N_SO).
    int lfile = 0, rfile = (stab_end - stabs) - 1;
  1007da:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  1007e1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1007e4:	2b 45 f4             	sub    -0xc(%ebp),%eax
  1007e7:	c1 f8 02             	sar    $0x2,%eax
  1007ea:	69 c0 ab aa aa aa    	imul   $0xaaaaaaab,%eax,%eax
  1007f0:	83 e8 01             	sub    $0x1,%eax
  1007f3:	89 45 e0             	mov    %eax,-0x20(%ebp)
    stab_binsearch(stabs, &lfile, &rfile, N_SO, addr);
  1007f6:	ff 75 08             	pushl  0x8(%ebp)
  1007f9:	6a 64                	push   $0x64
  1007fb:	8d 45 e0             	lea    -0x20(%ebp),%eax
  1007fe:	50                   	push   %eax
  1007ff:	8d 45 e4             	lea    -0x1c(%ebp),%eax
  100802:	50                   	push   %eax
  100803:	ff 75 f4             	pushl  -0xc(%ebp)
  100806:	e8 d3 fd ff ff       	call   1005de <stab_binsearch>
  10080b:	83 c4 14             	add    $0x14,%esp
    if (lfile == 0)
  10080e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  100811:	85 c0                	test   %eax,%eax
  100813:	75 0a                	jne    10081f <debuginfo_eip+0xdc>
        return -1;
  100815:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  10081a:	e9 40 02 00 00       	jmp    100a5f <debuginfo_eip+0x31c>

    // Search within that file's stabs for the function definition
    // (N_FUN).
    int lfun = lfile, rfun = rfile;
  10081f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  100822:	89 45 dc             	mov    %eax,-0x24(%ebp)
  100825:	8b 45 e0             	mov    -0x20(%ebp),%eax
  100828:	89 45 d8             	mov    %eax,-0x28(%ebp)
    int lline, rline;
    stab_binsearch(stabs, &lfun, &rfun, N_FUN, addr);
  10082b:	ff 75 08             	pushl  0x8(%ebp)
  10082e:	6a 24                	push   $0x24
  100830:	8d 45 d8             	lea    -0x28(%ebp),%eax
  100833:	50                   	push   %eax
  100834:	8d 45 dc             	lea    -0x24(%ebp),%eax
  100837:	50                   	push   %eax
  100838:	ff 75 f4             	pushl  -0xc(%ebp)
  10083b:	e8 9e fd ff ff       	call   1005de <stab_binsearch>
  100840:	83 c4 14             	add    $0x14,%esp

    if (lfun <= rfun) {
  100843:	8b 55 dc             	mov    -0x24(%ebp),%edx
  100846:	8b 45 d8             	mov    -0x28(%ebp),%eax
  100849:	39 c2                	cmp    %eax,%edx
  10084b:	7f 78                	jg     1008c5 <debuginfo_eip+0x182>
        // stabs[lfun] points to the function name
        // in the string table, but check bounds just in case.
        if (stabs[lfun].n_strx < stabstr_end - stabstr) {
  10084d:	8b 45 dc             	mov    -0x24(%ebp),%eax
  100850:	89 c2                	mov    %eax,%edx
  100852:	89 d0                	mov    %edx,%eax
  100854:	01 c0                	add    %eax,%eax
  100856:	01 d0                	add    %edx,%eax
  100858:	c1 e0 02             	shl    $0x2,%eax
  10085b:	89 c2                	mov    %eax,%edx
  10085d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100860:	01 d0                	add    %edx,%eax
  100862:	8b 10                	mov    (%eax),%edx
  100864:	8b 45 e8             	mov    -0x18(%ebp),%eax
  100867:	2b 45 ec             	sub    -0x14(%ebp),%eax
  10086a:	39 c2                	cmp    %eax,%edx
  10086c:	73 22                	jae    100890 <debuginfo_eip+0x14d>
            info->eip_fn_name = stabstr + stabs[lfun].n_strx;
  10086e:	8b 45 dc             	mov    -0x24(%ebp),%eax
  100871:	89 c2                	mov    %eax,%edx
  100873:	89 d0                	mov    %edx,%eax
  100875:	01 c0                	add    %eax,%eax
  100877:	01 d0                	add    %edx,%eax
  100879:	c1 e0 02             	shl    $0x2,%eax
  10087c:	89 c2                	mov    %eax,%edx
  10087e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100881:	01 d0                	add    %edx,%eax
  100883:	8b 10                	mov    (%eax),%edx
  100885:	8b 45 ec             	mov    -0x14(%ebp),%eax
  100888:	01 c2                	add    %eax,%edx
  10088a:	8b 45 0c             	mov    0xc(%ebp),%eax
  10088d:	89 50 08             	mov    %edx,0x8(%eax)
        }
        info->eip_fn_addr = stabs[lfun].n_value;
  100890:	8b 45 dc             	mov    -0x24(%ebp),%eax
  100893:	89 c2                	mov    %eax,%edx
  100895:	89 d0                	mov    %edx,%eax
  100897:	01 c0                	add    %eax,%eax
  100899:	01 d0                	add    %edx,%eax
  10089b:	c1 e0 02             	shl    $0x2,%eax
  10089e:	89 c2                	mov    %eax,%edx
  1008a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1008a3:	01 d0                	add    %edx,%eax
  1008a5:	8b 50 08             	mov    0x8(%eax),%edx
  1008a8:	8b 45 0c             	mov    0xc(%ebp),%eax
  1008ab:	89 50 10             	mov    %edx,0x10(%eax)
        addr -= info->eip_fn_addr;
  1008ae:	8b 45 0c             	mov    0xc(%ebp),%eax
  1008b1:	8b 40 10             	mov    0x10(%eax),%eax
  1008b4:	29 45 08             	sub    %eax,0x8(%ebp)
        // Search within the function definition for the line number.
        lline = lfun;
  1008b7:	8b 45 dc             	mov    -0x24(%ebp),%eax
  1008ba:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        rline = rfun;
  1008bd:	8b 45 d8             	mov    -0x28(%ebp),%eax
  1008c0:	89 45 d0             	mov    %eax,-0x30(%ebp)
  1008c3:	eb 15                	jmp    1008da <debuginfo_eip+0x197>
    } else {
        // Couldn't find function stab!  Maybe we're in an assembly
        // file.  Search the whole file for the line number.
        info->eip_fn_addr = addr;
  1008c5:	8b 45 0c             	mov    0xc(%ebp),%eax
  1008c8:	8b 55 08             	mov    0x8(%ebp),%edx
  1008cb:	89 50 10             	mov    %edx,0x10(%eax)
        lline = lfile;
  1008ce:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1008d1:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        rline = rfile;
  1008d4:	8b 45 e0             	mov    -0x20(%ebp),%eax
  1008d7:	89 45 d0             	mov    %eax,-0x30(%ebp)
    }
    info->eip_fn_namelen = strfind(info->eip_fn_name, ':') - info->eip_fn_name;
  1008da:	8b 45 0c             	mov    0xc(%ebp),%eax
  1008dd:	8b 40 08             	mov    0x8(%eax),%eax
  1008e0:	83 ec 08             	sub    $0x8,%esp
  1008e3:	6a 3a                	push   $0x3a
  1008e5:	50                   	push   %eax
  1008e6:	e8 82 26 00 00       	call   102f6d <strfind>
  1008eb:	83 c4 10             	add    $0x10,%esp
  1008ee:	8b 55 0c             	mov    0xc(%ebp),%edx
  1008f1:	8b 52 08             	mov    0x8(%edx),%edx
  1008f4:	29 d0                	sub    %edx,%eax
  1008f6:	89 c2                	mov    %eax,%edx
  1008f8:	8b 45 0c             	mov    0xc(%ebp),%eax
  1008fb:	89 50 0c             	mov    %edx,0xc(%eax)

    // Search within [lline, rline] for the line number stab.
    // If found, set info->eip_line to the right line number.
    // If not found, return -1.
    stab_binsearch(stabs, &lline, &rline, N_SLINE, addr);
  1008fe:	83 ec 0c             	sub    $0xc,%esp
  100901:	ff 75 08             	pushl  0x8(%ebp)
  100904:	6a 44                	push   $0x44
  100906:	8d 45 d0             	lea    -0x30(%ebp),%eax
  100909:	50                   	push   %eax
  10090a:	8d 45 d4             	lea    -0x2c(%ebp),%eax
  10090d:	50                   	push   %eax
  10090e:	ff 75 f4             	pushl  -0xc(%ebp)
  100911:	e8 c8 fc ff ff       	call   1005de <stab_binsearch>
  100916:	83 c4 20             	add    $0x20,%esp
    if (lline <= rline) {
  100919:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  10091c:	8b 45 d0             	mov    -0x30(%ebp),%eax
  10091f:	39 c2                	cmp    %eax,%edx
  100921:	7f 24                	jg     100947 <debuginfo_eip+0x204>
        info->eip_line = stabs[rline].n_desc;
  100923:	8b 45 d0             	mov    -0x30(%ebp),%eax
  100926:	89 c2                	mov    %eax,%edx
  100928:	89 d0                	mov    %edx,%eax
  10092a:	01 c0                	add    %eax,%eax
  10092c:	01 d0                	add    %edx,%eax
  10092e:	c1 e0 02             	shl    $0x2,%eax
  100931:	89 c2                	mov    %eax,%edx
  100933:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100936:	01 d0                	add    %edx,%eax
  100938:	0f b7 40 06          	movzwl 0x6(%eax),%eax
  10093c:	0f b7 d0             	movzwl %ax,%edx
  10093f:	8b 45 0c             	mov    0xc(%ebp),%eax
  100942:	89 50 04             	mov    %edx,0x4(%eax)

    // Search backwards from the line number for the relevant filename stab.
    // We can't just use the "lfile" stab because inlined functions
    // can interpolate code from a different file!
    // Such included source files use the N_SOL stab type.
    while (lline >= lfile
  100945:	eb 13                	jmp    10095a <debuginfo_eip+0x217>
        return -1;
  100947:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  10094c:	e9 0e 01 00 00       	jmp    100a5f <debuginfo_eip+0x31c>
           && stabs[lline].n_type != N_SOL
           && (stabs[lline].n_type != N_SO || !stabs[lline].n_value)) {
        lline --;
  100951:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100954:	83 e8 01             	sub    $0x1,%eax
  100957:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    while (lline >= lfile
  10095a:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  10095d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  100960:	39 c2                	cmp    %eax,%edx
  100962:	7c 56                	jl     1009ba <debuginfo_eip+0x277>
           && stabs[lline].n_type != N_SOL
  100964:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100967:	89 c2                	mov    %eax,%edx
  100969:	89 d0                	mov    %edx,%eax
  10096b:	01 c0                	add    %eax,%eax
  10096d:	01 d0                	add    %edx,%eax
  10096f:	c1 e0 02             	shl    $0x2,%eax
  100972:	89 c2                	mov    %eax,%edx
  100974:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100977:	01 d0                	add    %edx,%eax
  100979:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  10097d:	3c 84                	cmp    $0x84,%al
  10097f:	74 39                	je     1009ba <debuginfo_eip+0x277>
           && (stabs[lline].n_type != N_SO || !stabs[lline].n_value)) {
  100981:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100984:	89 c2                	mov    %eax,%edx
  100986:	89 d0                	mov    %edx,%eax
  100988:	01 c0                	add    %eax,%eax
  10098a:	01 d0                	add    %edx,%eax
  10098c:	c1 e0 02             	shl    $0x2,%eax
  10098f:	89 c2                	mov    %eax,%edx
  100991:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100994:	01 d0                	add    %edx,%eax
  100996:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  10099a:	3c 64                	cmp    $0x64,%al
  10099c:	75 b3                	jne    100951 <debuginfo_eip+0x20e>
  10099e:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  1009a1:	89 c2                	mov    %eax,%edx
  1009a3:	89 d0                	mov    %edx,%eax
  1009a5:	01 c0                	add    %eax,%eax
  1009a7:	01 d0                	add    %edx,%eax
  1009a9:	c1 e0 02             	shl    $0x2,%eax
  1009ac:	89 c2                	mov    %eax,%edx
  1009ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1009b1:	01 d0                	add    %edx,%eax
  1009b3:	8b 40 08             	mov    0x8(%eax),%eax
  1009b6:	85 c0                	test   %eax,%eax
  1009b8:	74 97                	je     100951 <debuginfo_eip+0x20e>
    }
    if (lline >= lfile && stabs[lline].n_strx < stabstr_end - stabstr) {
  1009ba:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  1009bd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1009c0:	39 c2                	cmp    %eax,%edx
  1009c2:	7c 42                	jl     100a06 <debuginfo_eip+0x2c3>
  1009c4:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  1009c7:	89 c2                	mov    %eax,%edx
  1009c9:	89 d0                	mov    %edx,%eax
  1009cb:	01 c0                	add    %eax,%eax
  1009cd:	01 d0                	add    %edx,%eax
  1009cf:	c1 e0 02             	shl    $0x2,%eax
  1009d2:	89 c2                	mov    %eax,%edx
  1009d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1009d7:	01 d0                	add    %edx,%eax
  1009d9:	8b 10                	mov    (%eax),%edx
  1009db:	8b 45 e8             	mov    -0x18(%ebp),%eax
  1009de:	2b 45 ec             	sub    -0x14(%ebp),%eax
  1009e1:	39 c2                	cmp    %eax,%edx
  1009e3:	73 21                	jae    100a06 <debuginfo_eip+0x2c3>
        info->eip_file = stabstr + stabs[lline].n_strx;
  1009e5:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  1009e8:	89 c2                	mov    %eax,%edx
  1009ea:	89 d0                	mov    %edx,%eax
  1009ec:	01 c0                	add    %eax,%eax
  1009ee:	01 d0                	add    %edx,%eax
  1009f0:	c1 e0 02             	shl    $0x2,%eax
  1009f3:	89 c2                	mov    %eax,%edx
  1009f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1009f8:	01 d0                	add    %edx,%eax
  1009fa:	8b 10                	mov    (%eax),%edx
  1009fc:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1009ff:	01 c2                	add    %eax,%edx
  100a01:	8b 45 0c             	mov    0xc(%ebp),%eax
  100a04:	89 10                	mov    %edx,(%eax)
    }

    // Set eip_fn_narg to the number of arguments taken by the function,
    // or 0 if there was no containing function.
    if (lfun < rfun) {
  100a06:	8b 55 dc             	mov    -0x24(%ebp),%edx
  100a09:	8b 45 d8             	mov    -0x28(%ebp),%eax
  100a0c:	39 c2                	cmp    %eax,%edx
  100a0e:	7d 4a                	jge    100a5a <debuginfo_eip+0x317>
        for (lline = lfun + 1;
  100a10:	8b 45 dc             	mov    -0x24(%ebp),%eax
  100a13:	83 c0 01             	add    $0x1,%eax
  100a16:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  100a19:	eb 18                	jmp    100a33 <debuginfo_eip+0x2f0>
             lline < rfun && stabs[lline].n_type == N_PSYM;
             lline ++) {
            info->eip_fn_narg ++;
  100a1b:	8b 45 0c             	mov    0xc(%ebp),%eax
  100a1e:	8b 40 14             	mov    0x14(%eax),%eax
  100a21:	8d 50 01             	lea    0x1(%eax),%edx
  100a24:	8b 45 0c             	mov    0xc(%ebp),%eax
  100a27:	89 50 14             	mov    %edx,0x14(%eax)
             lline ++) {
  100a2a:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100a2d:	83 c0 01             	add    $0x1,%eax
  100a30:	89 45 d4             	mov    %eax,-0x2c(%ebp)
             lline < rfun && stabs[lline].n_type == N_PSYM;
  100a33:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  100a36:	8b 45 d8             	mov    -0x28(%ebp),%eax
        for (lline = lfun + 1;
  100a39:	39 c2                	cmp    %eax,%edx
  100a3b:	7d 1d                	jge    100a5a <debuginfo_eip+0x317>
             lline < rfun && stabs[lline].n_type == N_PSYM;
  100a3d:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100a40:	89 c2                	mov    %eax,%edx
  100a42:	89 d0                	mov    %edx,%eax
  100a44:	01 c0                	add    %eax,%eax
  100a46:	01 d0                	add    %edx,%eax
  100a48:	c1 e0 02             	shl    $0x2,%eax
  100a4b:	89 c2                	mov    %eax,%edx
  100a4d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100a50:	01 d0                	add    %edx,%eax
  100a52:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  100a56:	3c a0                	cmp    $0xa0,%al
  100a58:	74 c1                	je     100a1b <debuginfo_eip+0x2d8>
        }
    }
    return 0;
  100a5a:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100a5f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  100a62:	c9                   	leave  
  100a63:	c3                   	ret    

00100a64 <print_kerninfo>:
 * print_kerninfo - print the information about kernel, including the location
 * of kernel entry, the start addresses of data and text segements, the start
 * address of free memory and how many memory that kernel has used.
 * */
void
print_kerninfo(void) {
  100a64:	f3 0f 1e fb          	endbr32 
  100a68:	55                   	push   %ebp
  100a69:	89 e5                	mov    %esp,%ebp
  100a6b:	53                   	push   %ebx
  100a6c:	83 ec 04             	sub    $0x4,%esp
  100a6f:	e8 30 f8 ff ff       	call   1002a4 <__x86.get_pc_thunk.bx>
  100a74:	81 c3 dc ee 00 00    	add    $0xeedc,%ebx
    extern char etext[], edata[], end[], kern_init[];
    cprintf("Special kernel symbols:\n");
  100a7a:	83 ec 0c             	sub    $0xc,%esp
  100a7d:	8d 83 0e 41 ff ff    	lea    -0xbef2(%ebx),%eax
  100a83:	50                   	push   %eax
  100a84:	e8 96 f8 ff ff       	call   10031f <cprintf>
  100a89:	83 c4 10             	add    $0x10,%esp
    cprintf("  entry  0x%08x (phys)\n", kern_init);
  100a8c:	83 ec 08             	sub    $0x8,%esp
  100a8f:	c7 c0 00 00 10 00    	mov    $0x100000,%eax
  100a95:	50                   	push   %eax
  100a96:	8d 83 27 41 ff ff    	lea    -0xbed9(%ebx),%eax
  100a9c:	50                   	push   %eax
  100a9d:	e8 7d f8 ff ff       	call   10031f <cprintf>
  100aa2:	83 c4 10             	add    $0x10,%esp
    cprintf("  etext  0x%08x (phys)\n", etext);
  100aa5:	83 ec 08             	sub    $0x8,%esp
  100aa8:	c7 c0 6b 39 10 00    	mov    $0x10396b,%eax
  100aae:	50                   	push   %eax
  100aaf:	8d 83 3f 41 ff ff    	lea    -0xbec1(%ebx),%eax
  100ab5:	50                   	push   %eax
  100ab6:	e8 64 f8 ff ff       	call   10031f <cprintf>
  100abb:	83 c4 10             	add    $0x10,%esp
    cprintf("  edata  0x%08x (phys)\n", edata);
  100abe:	83 ec 08             	sub    $0x8,%esp
  100ac1:	c7 c0 50 f9 10 00    	mov    $0x10f950,%eax
  100ac7:	50                   	push   %eax
  100ac8:	8d 83 57 41 ff ff    	lea    -0xbea9(%ebx),%eax
  100ace:	50                   	push   %eax
  100acf:	e8 4b f8 ff ff       	call   10031f <cprintf>
  100ad4:	83 c4 10             	add    $0x10,%esp
    cprintf("  end    0x%08x (phys)\n", end);
  100ad7:	83 ec 08             	sub    $0x8,%esp
  100ada:	c7 c0 c0 0d 11 00    	mov    $0x110dc0,%eax
  100ae0:	50                   	push   %eax
  100ae1:	8d 83 6f 41 ff ff    	lea    -0xbe91(%ebx),%eax
  100ae7:	50                   	push   %eax
  100ae8:	e8 32 f8 ff ff       	call   10031f <cprintf>
  100aed:	83 c4 10             	add    $0x10,%esp
    cprintf("Kernel executable memory footprint: %dKB\n", (end - kern_init + 1023)/1024);
  100af0:	c7 c0 c0 0d 11 00    	mov    $0x110dc0,%eax
  100af6:	89 c2                	mov    %eax,%edx
  100af8:	c7 c0 00 00 10 00    	mov    $0x100000,%eax
  100afe:	29 c2                	sub    %eax,%edx
  100b00:	89 d0                	mov    %edx,%eax
  100b02:	05 ff 03 00 00       	add    $0x3ff,%eax
  100b07:	8d 90 ff 03 00 00    	lea    0x3ff(%eax),%edx
  100b0d:	85 c0                	test   %eax,%eax
  100b0f:	0f 48 c2             	cmovs  %edx,%eax
  100b12:	c1 f8 0a             	sar    $0xa,%eax
  100b15:	83 ec 08             	sub    $0x8,%esp
  100b18:	50                   	push   %eax
  100b19:	8d 83 88 41 ff ff    	lea    -0xbe78(%ebx),%eax
  100b1f:	50                   	push   %eax
  100b20:	e8 fa f7 ff ff       	call   10031f <cprintf>
  100b25:	83 c4 10             	add    $0x10,%esp
}
  100b28:	90                   	nop
  100b29:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  100b2c:	c9                   	leave  
  100b2d:	c3                   	ret    

00100b2e <print_debuginfo>:
/* *
 * print_debuginfo - read and print the stat information for the address @eip,
 * and info.eip_fn_addr should be the first address of the related function.
 * */
void
print_debuginfo(uintptr_t eip) {
  100b2e:	f3 0f 1e fb          	endbr32 
  100b32:	55                   	push   %ebp
  100b33:	89 e5                	mov    %esp,%ebp
  100b35:	53                   	push   %ebx
  100b36:	81 ec 24 01 00 00    	sub    $0x124,%esp
  100b3c:	e8 63 f7 ff ff       	call   1002a4 <__x86.get_pc_thunk.bx>
  100b41:	81 c3 0f ee 00 00    	add    $0xee0f,%ebx
    struct eipdebuginfo info;
    if (debuginfo_eip(eip, &info) != 0) {
  100b47:	83 ec 08             	sub    $0x8,%esp
  100b4a:	8d 45 dc             	lea    -0x24(%ebp),%eax
  100b4d:	50                   	push   %eax
  100b4e:	ff 75 08             	pushl  0x8(%ebp)
  100b51:	e8 ed fb ff ff       	call   100743 <debuginfo_eip>
  100b56:	83 c4 10             	add    $0x10,%esp
  100b59:	85 c0                	test   %eax,%eax
  100b5b:	74 17                	je     100b74 <print_debuginfo+0x46>
        cprintf("    <unknow>: -- 0x%08x --\n", eip);
  100b5d:	83 ec 08             	sub    $0x8,%esp
  100b60:	ff 75 08             	pushl  0x8(%ebp)
  100b63:	8d 83 b2 41 ff ff    	lea    -0xbe4e(%ebx),%eax
  100b69:	50                   	push   %eax
  100b6a:	e8 b0 f7 ff ff       	call   10031f <cprintf>
  100b6f:	83 c4 10             	add    $0x10,%esp
        }
        fnname[j] = '\0';
        cprintf("    %s:%d: %s+%d\n", info.eip_file, info.eip_line,
                fnname, eip - info.eip_fn_addr);
    }
}
  100b72:	eb 67                	jmp    100bdb <print_debuginfo+0xad>
        for (j = 0; j < info.eip_fn_namelen; j ++) {
  100b74:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  100b7b:	eb 1c                	jmp    100b99 <print_debuginfo+0x6b>
            fnname[j] = info.eip_fn_name[j];
  100b7d:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  100b80:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100b83:	01 d0                	add    %edx,%eax
  100b85:	0f b6 00             	movzbl (%eax),%eax
  100b88:	8d 8d dc fe ff ff    	lea    -0x124(%ebp),%ecx
  100b8e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100b91:	01 ca                	add    %ecx,%edx
  100b93:	88 02                	mov    %al,(%edx)
        for (j = 0; j < info.eip_fn_namelen; j ++) {
  100b95:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  100b99:	8b 45 e8             	mov    -0x18(%ebp),%eax
  100b9c:	39 45 f4             	cmp    %eax,-0xc(%ebp)
  100b9f:	7c dc                	jl     100b7d <print_debuginfo+0x4f>
        fnname[j] = '\0';
  100ba1:	8d 95 dc fe ff ff    	lea    -0x124(%ebp),%edx
  100ba7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100baa:	01 d0                	add    %edx,%eax
  100bac:	c6 00 00             	movb   $0x0,(%eax)
                fnname, eip - info.eip_fn_addr);
  100baf:	8b 45 ec             	mov    -0x14(%ebp),%eax
        cprintf("    %s:%d: %s+%d\n", info.eip_file, info.eip_line,
  100bb2:	8b 55 08             	mov    0x8(%ebp),%edx
  100bb5:	89 d1                	mov    %edx,%ecx
  100bb7:	29 c1                	sub    %eax,%ecx
  100bb9:	8b 55 e0             	mov    -0x20(%ebp),%edx
  100bbc:	8b 45 dc             	mov    -0x24(%ebp),%eax
  100bbf:	83 ec 0c             	sub    $0xc,%esp
  100bc2:	51                   	push   %ecx
  100bc3:	8d 8d dc fe ff ff    	lea    -0x124(%ebp),%ecx
  100bc9:	51                   	push   %ecx
  100bca:	52                   	push   %edx
  100bcb:	50                   	push   %eax
  100bcc:	8d 83 ce 41 ff ff    	lea    -0xbe32(%ebx),%eax
  100bd2:	50                   	push   %eax
  100bd3:	e8 47 f7 ff ff       	call   10031f <cprintf>
  100bd8:	83 c4 20             	add    $0x20,%esp
}
  100bdb:	90                   	nop
  100bdc:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  100bdf:	c9                   	leave  
  100be0:	c3                   	ret    

00100be1 <read_eip>:

static __noinline uint32_t
read_eip(void) {
  100be1:	f3 0f 1e fb          	endbr32 
  100be5:	55                   	push   %ebp
  100be6:	89 e5                	mov    %esp,%ebp
  100be8:	83 ec 10             	sub    $0x10,%esp
  100beb:	e8 b0 f6 ff ff       	call   1002a0 <__x86.get_pc_thunk.ax>
  100bf0:	05 60 ed 00 00       	add    $0xed60,%eax
    uint32_t eip;
    asm volatile("movl 4(%%ebp), %0" : "=r" (eip));
  100bf5:	8b 45 04             	mov    0x4(%ebp),%eax
  100bf8:	89 45 fc             	mov    %eax,-0x4(%ebp)
    return eip;
  100bfb:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  100bfe:	c9                   	leave  
  100bff:	c3                   	ret    

00100c00 <print_stackframe>:
 *
 * Note that, the length of ebp-chain is limited. In boot/bootasm.S, before jumping
 * to the kernel entry, the value of ebp has been set to zero, that's the boundary.
 * */
void
print_stackframe(void) {
  100c00:	f3 0f 1e fb          	endbr32 
  100c04:	55                   	push   %ebp
  100c05:	89 e5                	mov    %esp,%ebp
  100c07:	53                   	push   %ebx
  100c08:	83 ec 24             	sub    $0x24,%esp
  100c0b:	e8 94 f6 ff ff       	call   1002a4 <__x86.get_pc_thunk.bx>
  100c10:	81 c3 40 ed 00 00    	add    $0xed40,%ebx
}

static inline uint32_t
read_ebp(void) {
    uint32_t ebp;
    asm volatile ("movl %%ebp, %0" : "=r" (ebp));
  100c16:	89 e8                	mov    %ebp,%eax
  100c18:	89 45 e0             	mov    %eax,-0x20(%ebp)
    return ebp;
  100c1b:	8b 45 e0             	mov    -0x20(%ebp),%eax
      *    (3.4) call print_debuginfo(eip-1) to print the C calling function name and line number, etc.
      *    (3.5) popup a calling stackframe
      *           NOTICE: the calling funciton's return addr eip  = ss:[ebp+4]
      *                   the calling funciton's ebp = ss:[ebp]
      */
	uint32_t ebp = read_ebp();
  100c1e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	uint32_t eip = read_eip();
  100c21:	e8 bb ff ff ff       	call   100be1 <read_eip>
  100c26:	89 45 f0             	mov    %eax,-0x10(%ebp)
	for (int i = 0; i < STACKFRAME_DEPTH && ebp != 0; i++)
  100c29:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  100c30:	e9 b7 00 00 00       	jmp    100cec <print_stackframe+0xec>
	{
		cprintf("ebp is 0x%08x ", ebp);
  100c35:	83 ec 08             	sub    $0x8,%esp
  100c38:	ff 75 f4             	pushl  -0xc(%ebp)
  100c3b:	8d 83 e0 41 ff ff    	lea    -0xbe20(%ebx),%eax
  100c41:	50                   	push   %eax
  100c42:	e8 d8 f6 ff ff       	call   10031f <cprintf>
  100c47:	83 c4 10             	add    $0x10,%esp
		cprintf("eip is 0x%08x ", eip);
  100c4a:	83 ec 08             	sub    $0x8,%esp
  100c4d:	ff 75 f0             	pushl  -0x10(%ebp)
  100c50:	8d 83 ef 41 ff ff    	lea    -0xbe11(%ebx),%eax
  100c56:	50                   	push   %eax
  100c57:	e8 c3 f6 ff ff       	call   10031f <cprintf>
  100c5c:	83 c4 10             	add    $0x10,%esp
		uint32_t* args = (uint32_t*) ebp + 2;
  100c5f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100c62:	83 c0 08             	add    $0x8,%eax
  100c65:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		cprintf("args is ");
  100c68:	83 ec 0c             	sub    $0xc,%esp
  100c6b:	8d 83 fe 41 ff ff    	lea    -0xbe02(%ebx),%eax
  100c71:	50                   	push   %eax
  100c72:	e8 a8 f6 ff ff       	call   10031f <cprintf>
  100c77:	83 c4 10             	add    $0x10,%esp
		for(int j = 0; j < 4; j++)
  100c7a:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  100c81:	eb 28                	jmp    100cab <print_stackframe+0xab>
		{
			cprintf("0x%08x ", args[j]);
  100c83:	8b 45 e8             	mov    -0x18(%ebp),%eax
  100c86:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  100c8d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  100c90:	01 d0                	add    %edx,%eax
  100c92:	8b 00                	mov    (%eax),%eax
  100c94:	83 ec 08             	sub    $0x8,%esp
  100c97:	50                   	push   %eax
  100c98:	8d 83 07 42 ff ff    	lea    -0xbdf9(%ebx),%eax
  100c9e:	50                   	push   %eax
  100c9f:	e8 7b f6 ff ff       	call   10031f <cprintf>
  100ca4:	83 c4 10             	add    $0x10,%esp
		for(int j = 0; j < 4; j++)
  100ca7:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
  100cab:	83 7d e8 03          	cmpl   $0x3,-0x18(%ebp)
  100caf:	7e d2                	jle    100c83 <print_stackframe+0x83>
		}
		cprintf("\n");
  100cb1:	83 ec 0c             	sub    $0xc,%esp
  100cb4:	8d 83 0f 42 ff ff    	lea    -0xbdf1(%ebx),%eax
  100cba:	50                   	push   %eax
  100cbb:	e8 5f f6 ff ff       	call   10031f <cprintf>
  100cc0:	83 c4 10             	add    $0x10,%esp
		print_debuginfo(eip-1);
  100cc3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100cc6:	83 e8 01             	sub    $0x1,%eax
  100cc9:	83 ec 0c             	sub    $0xc,%esp
  100ccc:	50                   	push   %eax
  100ccd:	e8 5c fe ff ff       	call   100b2e <print_debuginfo>
  100cd2:	83 c4 10             	add    $0x10,%esp
		eip = ((uint32_t*) ebp) [1];
  100cd5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100cd8:	83 c0 04             	add    $0x4,%eax
  100cdb:	8b 00                	mov    (%eax),%eax
  100cdd:	89 45 f0             	mov    %eax,-0x10(%ebp)
		ebp = ((uint32_t*) ebp) [0];
  100ce0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100ce3:	8b 00                	mov    (%eax),%eax
  100ce5:	89 45 f4             	mov    %eax,-0xc(%ebp)
	for (int i = 0; i < STACKFRAME_DEPTH && ebp != 0; i++)
  100ce8:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
  100cec:	83 7d ec 13          	cmpl   $0x13,-0x14(%ebp)
  100cf0:	7f 0a                	jg     100cfc <print_stackframe+0xfc>
  100cf2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  100cf6:	0f 85 39 ff ff ff    	jne    100c35 <print_stackframe+0x35>

	}
}
  100cfc:	90                   	nop
  100cfd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  100d00:	c9                   	leave  
  100d01:	c3                   	ret    

00100d02 <parse>:
#define MAXARGS         16
#define WHITESPACE      " \t\n\r"

/* parse - parse the command buffer into whitespace-separated arguments */
static int
parse(char *buf, char **argv) {
  100d02:	f3 0f 1e fb          	endbr32 
  100d06:	55                   	push   %ebp
  100d07:	89 e5                	mov    %esp,%ebp
  100d09:	53                   	push   %ebx
  100d0a:	83 ec 14             	sub    $0x14,%esp
  100d0d:	e8 92 f5 ff ff       	call   1002a4 <__x86.get_pc_thunk.bx>
  100d12:	81 c3 3e ec 00 00    	add    $0xec3e,%ebx
    int argc = 0;
  100d18:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while (1) {
        // find global whitespace
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
  100d1f:	eb 0c                	jmp    100d2d <parse+0x2b>
            *buf ++ = '\0';
  100d21:	8b 45 08             	mov    0x8(%ebp),%eax
  100d24:	8d 50 01             	lea    0x1(%eax),%edx
  100d27:	89 55 08             	mov    %edx,0x8(%ebp)
  100d2a:	c6 00 00             	movb   $0x0,(%eax)
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
  100d2d:	8b 45 08             	mov    0x8(%ebp),%eax
  100d30:	0f b6 00             	movzbl (%eax),%eax
  100d33:	84 c0                	test   %al,%al
  100d35:	74 20                	je     100d57 <parse+0x55>
  100d37:	8b 45 08             	mov    0x8(%ebp),%eax
  100d3a:	0f b6 00             	movzbl (%eax),%eax
  100d3d:	0f be c0             	movsbl %al,%eax
  100d40:	83 ec 08             	sub    $0x8,%esp
  100d43:	50                   	push   %eax
  100d44:	8d 83 94 42 ff ff    	lea    -0xbd6c(%ebx),%eax
  100d4a:	50                   	push   %eax
  100d4b:	e8 dc 21 00 00       	call   102f2c <strchr>
  100d50:	83 c4 10             	add    $0x10,%esp
  100d53:	85 c0                	test   %eax,%eax
  100d55:	75 ca                	jne    100d21 <parse+0x1f>
        }
        if (*buf == '\0') {
  100d57:	8b 45 08             	mov    0x8(%ebp),%eax
  100d5a:	0f b6 00             	movzbl (%eax),%eax
  100d5d:	84 c0                	test   %al,%al
  100d5f:	74 69                	je     100dca <parse+0xc8>
            break;
        }

        // save and scan past next arg
        if (argc == MAXARGS - 1) {
  100d61:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
  100d65:	75 14                	jne    100d7b <parse+0x79>
            cprintf("Too many arguments (max %d).\n", MAXARGS);
  100d67:	83 ec 08             	sub    $0x8,%esp
  100d6a:	6a 10                	push   $0x10
  100d6c:	8d 83 99 42 ff ff    	lea    -0xbd67(%ebx),%eax
  100d72:	50                   	push   %eax
  100d73:	e8 a7 f5 ff ff       	call   10031f <cprintf>
  100d78:	83 c4 10             	add    $0x10,%esp
        }
        argv[argc ++] = buf;
  100d7b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100d7e:	8d 50 01             	lea    0x1(%eax),%edx
  100d81:	89 55 f4             	mov    %edx,-0xc(%ebp)
  100d84:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  100d8b:	8b 45 0c             	mov    0xc(%ebp),%eax
  100d8e:	01 c2                	add    %eax,%edx
  100d90:	8b 45 08             	mov    0x8(%ebp),%eax
  100d93:	89 02                	mov    %eax,(%edx)
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
  100d95:	eb 04                	jmp    100d9b <parse+0x99>
            buf ++;
  100d97:	83 45 08 01          	addl   $0x1,0x8(%ebp)
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
  100d9b:	8b 45 08             	mov    0x8(%ebp),%eax
  100d9e:	0f b6 00             	movzbl (%eax),%eax
  100da1:	84 c0                	test   %al,%al
  100da3:	74 88                	je     100d2d <parse+0x2b>
  100da5:	8b 45 08             	mov    0x8(%ebp),%eax
  100da8:	0f b6 00             	movzbl (%eax),%eax
  100dab:	0f be c0             	movsbl %al,%eax
  100dae:	83 ec 08             	sub    $0x8,%esp
  100db1:	50                   	push   %eax
  100db2:	8d 83 94 42 ff ff    	lea    -0xbd6c(%ebx),%eax
  100db8:	50                   	push   %eax
  100db9:	e8 6e 21 00 00       	call   102f2c <strchr>
  100dbe:	83 c4 10             	add    $0x10,%esp
  100dc1:	85 c0                	test   %eax,%eax
  100dc3:	74 d2                	je     100d97 <parse+0x95>
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
  100dc5:	e9 63 ff ff ff       	jmp    100d2d <parse+0x2b>
            break;
  100dca:	90                   	nop
        }
    }
    return argc;
  100dcb:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  100dce:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  100dd1:	c9                   	leave  
  100dd2:	c3                   	ret    

00100dd3 <runcmd>:
/* *
 * runcmd - parse the input string, split it into separated arguments
 * and then lookup and invoke some related commands/
 * */
static int
runcmd(char *buf, struct trapframe *tf) {
  100dd3:	f3 0f 1e fb          	endbr32 
  100dd7:	55                   	push   %ebp
  100dd8:	89 e5                	mov    %esp,%ebp
  100dda:	56                   	push   %esi
  100ddb:	53                   	push   %ebx
  100ddc:	83 ec 50             	sub    $0x50,%esp
  100ddf:	e8 c0 f4 ff ff       	call   1002a4 <__x86.get_pc_thunk.bx>
  100de4:	81 c3 6c eb 00 00    	add    $0xeb6c,%ebx
    char *argv[MAXARGS];
    int argc = parse(buf, argv);
  100dea:	83 ec 08             	sub    $0x8,%esp
  100ded:	8d 45 b0             	lea    -0x50(%ebp),%eax
  100df0:	50                   	push   %eax
  100df1:	ff 75 08             	pushl  0x8(%ebp)
  100df4:	e8 09 ff ff ff       	call   100d02 <parse>
  100df9:	83 c4 10             	add    $0x10,%esp
  100dfc:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if (argc == 0) {
  100dff:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  100e03:	75 0a                	jne    100e0f <runcmd+0x3c>
        return 0;
  100e05:	b8 00 00 00 00       	mov    $0x0,%eax
  100e0a:	e9 8b 00 00 00       	jmp    100e9a <runcmd+0xc7>
    }
    int i;
    for (i = 0; i < NCOMMANDS; i ++) {
  100e0f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  100e16:	eb 5f                	jmp    100e77 <runcmd+0xa4>
        if (strcmp(commands[i].name, argv[0]) == 0) {
  100e18:	8b 4d b0             	mov    -0x50(%ebp),%ecx
  100e1b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100e1e:	8d b3 10 00 00 00    	lea    0x10(%ebx),%esi
  100e24:	89 d0                	mov    %edx,%eax
  100e26:	01 c0                	add    %eax,%eax
  100e28:	01 d0                	add    %edx,%eax
  100e2a:	c1 e0 02             	shl    $0x2,%eax
  100e2d:	01 f0                	add    %esi,%eax
  100e2f:	8b 00                	mov    (%eax),%eax
  100e31:	83 ec 08             	sub    $0x8,%esp
  100e34:	51                   	push   %ecx
  100e35:	50                   	push   %eax
  100e36:	e8 36 20 00 00       	call   102e71 <strcmp>
  100e3b:	83 c4 10             	add    $0x10,%esp
  100e3e:	85 c0                	test   %eax,%eax
  100e40:	75 31                	jne    100e73 <runcmd+0xa0>
            return commands[i].func(argc - 1, argv + 1, tf);
  100e42:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100e45:	8d 8b 18 00 00 00    	lea    0x18(%ebx),%ecx
  100e4b:	89 d0                	mov    %edx,%eax
  100e4d:	01 c0                	add    %eax,%eax
  100e4f:	01 d0                	add    %edx,%eax
  100e51:	c1 e0 02             	shl    $0x2,%eax
  100e54:	01 c8                	add    %ecx,%eax
  100e56:	8b 10                	mov    (%eax),%edx
  100e58:	8d 45 b0             	lea    -0x50(%ebp),%eax
  100e5b:	83 c0 04             	add    $0x4,%eax
  100e5e:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  100e61:	83 e9 01             	sub    $0x1,%ecx
  100e64:	83 ec 04             	sub    $0x4,%esp
  100e67:	ff 75 0c             	pushl  0xc(%ebp)
  100e6a:	50                   	push   %eax
  100e6b:	51                   	push   %ecx
  100e6c:	ff d2                	call   *%edx
  100e6e:	83 c4 10             	add    $0x10,%esp
  100e71:	eb 27                	jmp    100e9a <runcmd+0xc7>
    for (i = 0; i < NCOMMANDS; i ++) {
  100e73:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  100e77:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100e7a:	83 f8 02             	cmp    $0x2,%eax
  100e7d:	76 99                	jbe    100e18 <runcmd+0x45>
        }
    }
    cprintf("Unknown command '%s'\n", argv[0]);
  100e7f:	8b 45 b0             	mov    -0x50(%ebp),%eax
  100e82:	83 ec 08             	sub    $0x8,%esp
  100e85:	50                   	push   %eax
  100e86:	8d 83 b7 42 ff ff    	lea    -0xbd49(%ebx),%eax
  100e8c:	50                   	push   %eax
  100e8d:	e8 8d f4 ff ff       	call   10031f <cprintf>
  100e92:	83 c4 10             	add    $0x10,%esp
    return 0;
  100e95:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100e9a:	8d 65 f8             	lea    -0x8(%ebp),%esp
  100e9d:	5b                   	pop    %ebx
  100e9e:	5e                   	pop    %esi
  100e9f:	5d                   	pop    %ebp
  100ea0:	c3                   	ret    

00100ea1 <kmonitor>:

/***** Implementations of basic kernel monitor commands *****/

void
kmonitor(struct trapframe *tf) {
  100ea1:	f3 0f 1e fb          	endbr32 
  100ea5:	55                   	push   %ebp
  100ea6:	89 e5                	mov    %esp,%ebp
  100ea8:	53                   	push   %ebx
  100ea9:	83 ec 14             	sub    $0x14,%esp
  100eac:	e8 f3 f3 ff ff       	call   1002a4 <__x86.get_pc_thunk.bx>
  100eb1:	81 c3 9f ea 00 00    	add    $0xea9f,%ebx
    cprintf("Welcome to the kernel debug monitor!!\n");
  100eb7:	83 ec 0c             	sub    $0xc,%esp
  100eba:	8d 83 d0 42 ff ff    	lea    -0xbd30(%ebx),%eax
  100ec0:	50                   	push   %eax
  100ec1:	e8 59 f4 ff ff       	call   10031f <cprintf>
  100ec6:	83 c4 10             	add    $0x10,%esp
    cprintf("Type 'help' for a list of commands.\n");
  100ec9:	83 ec 0c             	sub    $0xc,%esp
  100ecc:	8d 83 f8 42 ff ff    	lea    -0xbd08(%ebx),%eax
  100ed2:	50                   	push   %eax
  100ed3:	e8 47 f4 ff ff       	call   10031f <cprintf>
  100ed8:	83 c4 10             	add    $0x10,%esp

    if (tf != NULL) {
  100edb:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  100edf:	74 0e                	je     100eef <kmonitor+0x4e>
        print_trapframe(tf);
  100ee1:	83 ec 0c             	sub    $0xc,%esp
  100ee4:	ff 75 08             	pushl  0x8(%ebp)
  100ee7:	e8 5a 0e 00 00       	call   101d46 <print_trapframe>
  100eec:	83 c4 10             	add    $0x10,%esp
    }

    char *buf;
    while (1) {
        if ((buf = readline("K> ")) != NULL) {
  100eef:	83 ec 0c             	sub    $0xc,%esp
  100ef2:	8d 83 1d 43 ff ff    	lea    -0xbce3(%ebx),%eax
  100ef8:	50                   	push   %eax
  100ef9:	e8 0a f5 ff ff       	call   100408 <readline>
  100efe:	83 c4 10             	add    $0x10,%esp
  100f01:	89 45 f4             	mov    %eax,-0xc(%ebp)
  100f04:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  100f08:	74 e5                	je     100eef <kmonitor+0x4e>
            if (runcmd(buf, tf) < 0) {
  100f0a:	83 ec 08             	sub    $0x8,%esp
  100f0d:	ff 75 08             	pushl  0x8(%ebp)
  100f10:	ff 75 f4             	pushl  -0xc(%ebp)
  100f13:	e8 bb fe ff ff       	call   100dd3 <runcmd>
  100f18:	83 c4 10             	add    $0x10,%esp
  100f1b:	85 c0                	test   %eax,%eax
  100f1d:	78 02                	js     100f21 <kmonitor+0x80>
        if ((buf = readline("K> ")) != NULL) {
  100f1f:	eb ce                	jmp    100eef <kmonitor+0x4e>
                break;
  100f21:	90                   	nop
            }
        }
    }
}
  100f22:	90                   	nop
  100f23:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  100f26:	c9                   	leave  
  100f27:	c3                   	ret    

00100f28 <mon_help>:

/* mon_help - print the information about mon_* functions */
int
mon_help(int argc, char **argv, struct trapframe *tf) {
  100f28:	f3 0f 1e fb          	endbr32 
  100f2c:	55                   	push   %ebp
  100f2d:	89 e5                	mov    %esp,%ebp
  100f2f:	56                   	push   %esi
  100f30:	53                   	push   %ebx
  100f31:	83 ec 10             	sub    $0x10,%esp
  100f34:	e8 6b f3 ff ff       	call   1002a4 <__x86.get_pc_thunk.bx>
  100f39:	81 c3 17 ea 00 00    	add    $0xea17,%ebx
    int i;
    for (i = 0; i < NCOMMANDS; i ++) {
  100f3f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  100f46:	eb 44                	jmp    100f8c <mon_help+0x64>
        cprintf("%s - %s\n", commands[i].name, commands[i].desc);
  100f48:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100f4b:	8d 8b 14 00 00 00    	lea    0x14(%ebx),%ecx
  100f51:	89 d0                	mov    %edx,%eax
  100f53:	01 c0                	add    %eax,%eax
  100f55:	01 d0                	add    %edx,%eax
  100f57:	c1 e0 02             	shl    $0x2,%eax
  100f5a:	01 c8                	add    %ecx,%eax
  100f5c:	8b 08                	mov    (%eax),%ecx
  100f5e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100f61:	8d b3 10 00 00 00    	lea    0x10(%ebx),%esi
  100f67:	89 d0                	mov    %edx,%eax
  100f69:	01 c0                	add    %eax,%eax
  100f6b:	01 d0                	add    %edx,%eax
  100f6d:	c1 e0 02             	shl    $0x2,%eax
  100f70:	01 f0                	add    %esi,%eax
  100f72:	8b 00                	mov    (%eax),%eax
  100f74:	83 ec 04             	sub    $0x4,%esp
  100f77:	51                   	push   %ecx
  100f78:	50                   	push   %eax
  100f79:	8d 83 21 43 ff ff    	lea    -0xbcdf(%ebx),%eax
  100f7f:	50                   	push   %eax
  100f80:	e8 9a f3 ff ff       	call   10031f <cprintf>
  100f85:	83 c4 10             	add    $0x10,%esp
    for (i = 0; i < NCOMMANDS; i ++) {
  100f88:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  100f8c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100f8f:	83 f8 02             	cmp    $0x2,%eax
  100f92:	76 b4                	jbe    100f48 <mon_help+0x20>
    }
    return 0;
  100f94:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100f99:	8d 65 f8             	lea    -0x8(%ebp),%esp
  100f9c:	5b                   	pop    %ebx
  100f9d:	5e                   	pop    %esi
  100f9e:	5d                   	pop    %ebp
  100f9f:	c3                   	ret    

00100fa0 <mon_kerninfo>:
/* *
 * mon_kerninfo - call print_kerninfo in kern/debug/kdebug.c to
 * print the memory occupancy in kernel.
 * */
int
mon_kerninfo(int argc, char **argv, struct trapframe *tf) {
  100fa0:	f3 0f 1e fb          	endbr32 
  100fa4:	55                   	push   %ebp
  100fa5:	89 e5                	mov    %esp,%ebp
  100fa7:	53                   	push   %ebx
  100fa8:	83 ec 04             	sub    $0x4,%esp
  100fab:	e8 f0 f2 ff ff       	call   1002a0 <__x86.get_pc_thunk.ax>
  100fb0:	05 a0 e9 00 00       	add    $0xe9a0,%eax
    print_kerninfo();
  100fb5:	89 c3                	mov    %eax,%ebx
  100fb7:	e8 a8 fa ff ff       	call   100a64 <print_kerninfo>
    return 0;
  100fbc:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100fc1:	83 c4 04             	add    $0x4,%esp
  100fc4:	5b                   	pop    %ebx
  100fc5:	5d                   	pop    %ebp
  100fc6:	c3                   	ret    

00100fc7 <mon_backtrace>:
/* *
 * mon_backtrace - call print_stackframe in kern/debug/kdebug.c to
 * print a backtrace of the stack.
 * */
int
mon_backtrace(int argc, char **argv, struct trapframe *tf) {
  100fc7:	f3 0f 1e fb          	endbr32 
  100fcb:	55                   	push   %ebp
  100fcc:	89 e5                	mov    %esp,%ebp
  100fce:	53                   	push   %ebx
  100fcf:	83 ec 04             	sub    $0x4,%esp
  100fd2:	e8 c9 f2 ff ff       	call   1002a0 <__x86.get_pc_thunk.ax>
  100fd7:	05 79 e9 00 00       	add    $0xe979,%eax
    print_stackframe();
  100fdc:	89 c3                	mov    %eax,%ebx
  100fde:	e8 1d fc ff ff       	call   100c00 <print_stackframe>
    return 0;
  100fe3:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100fe8:	83 c4 04             	add    $0x4,%esp
  100feb:	5b                   	pop    %ebx
  100fec:	5d                   	pop    %ebp
  100fed:	c3                   	ret    

00100fee <clock_init>:
/* *
 * clock_init - initialize 8253 clock to interrupt 100 times per second,
 * and then enable IRQ_TIMER.
 * */
void
clock_init(void) {
  100fee:	f3 0f 1e fb          	endbr32 
  100ff2:	55                   	push   %ebp
  100ff3:	89 e5                	mov    %esp,%ebp
  100ff5:	53                   	push   %ebx
  100ff6:	83 ec 14             	sub    $0x14,%esp
  100ff9:	e8 a6 f2 ff ff       	call   1002a4 <__x86.get_pc_thunk.bx>
  100ffe:	81 c3 52 e9 00 00    	add    $0xe952,%ebx
  101004:	66 c7 45 ee 43 00    	movw   $0x43,-0x12(%ebp)
  10100a:	c6 45 ed 34          	movb   $0x34,-0x13(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  10100e:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  101012:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  101016:	ee                   	out    %al,(%dx)
}
  101017:	90                   	nop
  101018:	66 c7 45 f2 40 00    	movw   $0x40,-0xe(%ebp)
  10101e:	c6 45 f1 9c          	movb   $0x9c,-0xf(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101022:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  101026:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  10102a:	ee                   	out    %al,(%dx)
}
  10102b:	90                   	nop
  10102c:	66 c7 45 f6 40 00    	movw   $0x40,-0xa(%ebp)
  101032:	c6 45 f5 2e          	movb   $0x2e,-0xb(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101036:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  10103a:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  10103e:	ee                   	out    %al,(%dx)
}
  10103f:	90                   	nop
    outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
    outb(IO_TIMER1, TIMER_DIV(100) % 256);
    outb(IO_TIMER1, TIMER_DIV(100) / 256);

    // initialize time counter 'ticks' to zero
    ticks = 0;
  101040:	c7 c0 a8 09 11 00    	mov    $0x1109a8,%eax
  101046:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

    cprintf("++ setup timer interrupts\n");
  10104c:	83 ec 0c             	sub    $0xc,%esp
  10104f:	8d 83 2a 43 ff ff    	lea    -0xbcd6(%ebx),%eax
  101055:	50                   	push   %eax
  101056:	e8 c4 f2 ff ff       	call   10031f <cprintf>
  10105b:	83 c4 10             	add    $0x10,%esp
    pic_enable(IRQ_TIMER);
  10105e:	83 ec 0c             	sub    $0xc,%esp
  101061:	6a 00                	push   $0x0
  101063:	e8 4e 0a 00 00       	call   101ab6 <pic_enable>
  101068:	83 c4 10             	add    $0x10,%esp
}
  10106b:	90                   	nop
  10106c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  10106f:	c9                   	leave  
  101070:	c3                   	ret    

00101071 <delay>:
#include <picirq.h>
#include <trap.h>

/* stupid I/O delay routine necessitated by historical PC design flaws */
static void
delay(void) {
  101071:	f3 0f 1e fb          	endbr32 
  101075:	55                   	push   %ebp
  101076:	89 e5                	mov    %esp,%ebp
  101078:	83 ec 10             	sub    $0x10,%esp
  10107b:	e8 20 f2 ff ff       	call   1002a0 <__x86.get_pc_thunk.ax>
  101080:	05 d0 e8 00 00       	add    $0xe8d0,%eax
  101085:	66 c7 45 f2 84 00    	movw   $0x84,-0xe(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  10108b:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
  10108f:	89 c2                	mov    %eax,%edx
  101091:	ec                   	in     (%dx),%al
  101092:	88 45 f1             	mov    %al,-0xf(%ebp)
  101095:	66 c7 45 f6 84 00    	movw   $0x84,-0xa(%ebp)
  10109b:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  10109f:	89 c2                	mov    %eax,%edx
  1010a1:	ec                   	in     (%dx),%al
  1010a2:	88 45 f5             	mov    %al,-0xb(%ebp)
  1010a5:	66 c7 45 fa 84 00    	movw   $0x84,-0x6(%ebp)
  1010ab:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
  1010af:	89 c2                	mov    %eax,%edx
  1010b1:	ec                   	in     (%dx),%al
  1010b2:	88 45 f9             	mov    %al,-0x7(%ebp)
  1010b5:	66 c7 45 fe 84 00    	movw   $0x84,-0x2(%ebp)
  1010bb:	0f b7 45 fe          	movzwl -0x2(%ebp),%eax
  1010bf:	89 c2                	mov    %eax,%edx
  1010c1:	ec                   	in     (%dx),%al
  1010c2:	88 45 fd             	mov    %al,-0x3(%ebp)
    inb(0x84);
    inb(0x84);
    inb(0x84);
    inb(0x84);
}
  1010c5:	90                   	nop
  1010c6:	c9                   	leave  
  1010c7:	c3                   	ret    

001010c8 <cga_init>:
//    -- 数据寄存器 映射 到 端口 0x3D5或0x3B5 
//    -- 索引寄存器 0x3D4或0x3B4,决定在数据寄存器中的数据表示什么。

/* TEXT-mode CGA/VGA display output */
static void
cga_init(void) {
  1010c8:	f3 0f 1e fb          	endbr32 
  1010cc:	55                   	push   %ebp
  1010cd:	89 e5                	mov    %esp,%ebp
  1010cf:	83 ec 20             	sub    $0x20,%esp
  1010d2:	e8 70 09 00 00       	call   101a47 <__x86.get_pc_thunk.cx>
  1010d7:	81 c1 79 e8 00 00    	add    $0xe879,%ecx
    volatile uint16_t *cp = (uint16_t *)CGA_BUF;   //CGA_BUF: 0xB8000 (彩色显示的显存物理基址)
  1010dd:	c7 45 fc 00 80 0b 00 	movl   $0xb8000,-0x4(%ebp)
    uint16_t was = *cp;                                            //保存当前显存0xB8000处的值
  1010e4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1010e7:	0f b7 00             	movzwl (%eax),%eax
  1010ea:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
    *cp = (uint16_t) 0xA55A;                                   // 给这个地址随便写个值，看看能否再读出同样的值
  1010ee:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1010f1:	66 c7 00 5a a5       	movw   $0xa55a,(%eax)
    if (*cp != 0xA55A) {                                            // 如果读不出来，说明没有这块显存，即是单显配置
  1010f6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1010f9:	0f b7 00             	movzwl (%eax),%eax
  1010fc:	66 3d 5a a5          	cmp    $0xa55a,%ax
  101100:	74 12                	je     101114 <cga_init+0x4c>
        cp = (uint16_t*)MONO_BUF;                         //设置为单显的显存基址 MONO_BUF： 0xB0000
  101102:	c7 45 fc 00 00 0b 00 	movl   $0xb0000,-0x4(%ebp)
        addr_6845 = MONO_BASE;                           //设置为单显控制的IO地址，MONO_BASE: 0x3B4
  101109:	66 c7 81 b6 05 00 00 	movw   $0x3b4,0x5b6(%ecx)
  101110:	b4 03 
  101112:	eb 13                	jmp    101127 <cga_init+0x5f>
    } else {                                                                // 如果读出来了，有这块显存，即是彩显配置
        *cp = was;                                                      //还原原来显存位置的值
  101114:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101117:	0f b7 55 fa          	movzwl -0x6(%ebp),%edx
  10111b:	66 89 10             	mov    %dx,(%eax)
        addr_6845 = CGA_BASE;                               // 设置为彩显控制的IO地址，CGA_BASE: 0x3D4 
  10111e:	66 c7 81 b6 05 00 00 	movw   $0x3d4,0x5b6(%ecx)
  101125:	d4 03 
    // Extract cursor location
    // 6845索引寄存器的index 0x0E（及十进制的14）== 光标位置(高位)
    // 6845索引寄存器的index 0x0F（及十进制的15）== 光标位置(低位)
    // 6845 reg 15 : Cursor Address (Low Byte)
    uint32_t pos;
    outb(addr_6845, 14);                                        
  101127:	0f b7 81 b6 05 00 00 	movzwl 0x5b6(%ecx),%eax
  10112e:	0f b7 c0             	movzwl %ax,%eax
  101131:	66 89 45 e6          	mov    %ax,-0x1a(%ebp)
  101135:	c6 45 e5 0e          	movb   $0xe,-0x1b(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101139:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
  10113d:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
  101141:	ee                   	out    %al,(%dx)
}
  101142:	90                   	nop
    pos = inb(addr_6845 + 1) << 8;                       //读出了光标位置(高位)
  101143:	0f b7 81 b6 05 00 00 	movzwl 0x5b6(%ecx),%eax
  10114a:	83 c0 01             	add    $0x1,%eax
  10114d:	0f b7 c0             	movzwl %ax,%eax
  101150:	66 89 45 ea          	mov    %ax,-0x16(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  101154:	0f b7 45 ea          	movzwl -0x16(%ebp),%eax
  101158:	89 c2                	mov    %eax,%edx
  10115a:	ec                   	in     (%dx),%al
  10115b:	88 45 e9             	mov    %al,-0x17(%ebp)
    return data;
  10115e:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
  101162:	0f b6 c0             	movzbl %al,%eax
  101165:	c1 e0 08             	shl    $0x8,%eax
  101168:	89 45 f4             	mov    %eax,-0xc(%ebp)
    outb(addr_6845, 15);
  10116b:	0f b7 81 b6 05 00 00 	movzwl 0x5b6(%ecx),%eax
  101172:	0f b7 c0             	movzwl %ax,%eax
  101175:	66 89 45 ee          	mov    %ax,-0x12(%ebp)
  101179:	c6 45 ed 0f          	movb   $0xf,-0x13(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  10117d:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  101181:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  101185:	ee                   	out    %al,(%dx)
}
  101186:	90                   	nop
    pos |= inb(addr_6845 + 1);                             //读出了光标位置(低位)
  101187:	0f b7 81 b6 05 00 00 	movzwl 0x5b6(%ecx),%eax
  10118e:	83 c0 01             	add    $0x1,%eax
  101191:	0f b7 c0             	movzwl %ax,%eax
  101194:	66 89 45 f2          	mov    %ax,-0xe(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  101198:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
  10119c:	89 c2                	mov    %eax,%edx
  10119e:	ec                   	in     (%dx),%al
  10119f:	88 45 f1             	mov    %al,-0xf(%ebp)
    return data;
  1011a2:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  1011a6:	0f b6 c0             	movzbl %al,%eax
  1011a9:	09 45 f4             	or     %eax,-0xc(%ebp)

    crt_buf = (uint16_t*) cp;                                  //crt_buf是CGA显存起始地址
  1011ac:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1011af:	89 81 b0 05 00 00    	mov    %eax,0x5b0(%ecx)
    crt_pos = pos;                                                  //crt_pos是CGA当前光标位置
  1011b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1011b8:	66 89 81 b4 05 00 00 	mov    %ax,0x5b4(%ecx)
}
  1011bf:	90                   	nop
  1011c0:	c9                   	leave  
  1011c1:	c3                   	ret    

001011c2 <serial_init>:

static bool serial_exists = 0;

static void
serial_init(void) {
  1011c2:	f3 0f 1e fb          	endbr32 
  1011c6:	55                   	push   %ebp
  1011c7:	89 e5                	mov    %esp,%ebp
  1011c9:	53                   	push   %ebx
  1011ca:	83 ec 34             	sub    $0x34,%esp
  1011cd:	e8 75 08 00 00       	call   101a47 <__x86.get_pc_thunk.cx>
  1011d2:	81 c1 7e e7 00 00    	add    $0xe77e,%ecx
  1011d8:	66 c7 45 d2 fa 03    	movw   $0x3fa,-0x2e(%ebp)
  1011de:	c6 45 d1 00          	movb   $0x0,-0x2f(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1011e2:	0f b6 45 d1          	movzbl -0x2f(%ebp),%eax
  1011e6:	0f b7 55 d2          	movzwl -0x2e(%ebp),%edx
  1011ea:	ee                   	out    %al,(%dx)
}
  1011eb:	90                   	nop
  1011ec:	66 c7 45 d6 fb 03    	movw   $0x3fb,-0x2a(%ebp)
  1011f2:	c6 45 d5 80          	movb   $0x80,-0x2b(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1011f6:	0f b6 45 d5          	movzbl -0x2b(%ebp),%eax
  1011fa:	0f b7 55 d6          	movzwl -0x2a(%ebp),%edx
  1011fe:	ee                   	out    %al,(%dx)
}
  1011ff:	90                   	nop
  101200:	66 c7 45 da f8 03    	movw   $0x3f8,-0x26(%ebp)
  101206:	c6 45 d9 0c          	movb   $0xc,-0x27(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  10120a:	0f b6 45 d9          	movzbl -0x27(%ebp),%eax
  10120e:	0f b7 55 da          	movzwl -0x26(%ebp),%edx
  101212:	ee                   	out    %al,(%dx)
}
  101213:	90                   	nop
  101214:	66 c7 45 de f9 03    	movw   $0x3f9,-0x22(%ebp)
  10121a:	c6 45 dd 00          	movb   $0x0,-0x23(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  10121e:	0f b6 45 dd          	movzbl -0x23(%ebp),%eax
  101222:	0f b7 55 de          	movzwl -0x22(%ebp),%edx
  101226:	ee                   	out    %al,(%dx)
}
  101227:	90                   	nop
  101228:	66 c7 45 e2 fb 03    	movw   $0x3fb,-0x1e(%ebp)
  10122e:	c6 45 e1 03          	movb   $0x3,-0x1f(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101232:	0f b6 45 e1          	movzbl -0x1f(%ebp),%eax
  101236:	0f b7 55 e2          	movzwl -0x1e(%ebp),%edx
  10123a:	ee                   	out    %al,(%dx)
}
  10123b:	90                   	nop
  10123c:	66 c7 45 e6 fc 03    	movw   $0x3fc,-0x1a(%ebp)
  101242:	c6 45 e5 00          	movb   $0x0,-0x1b(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101246:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
  10124a:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
  10124e:	ee                   	out    %al,(%dx)
}
  10124f:	90                   	nop
  101250:	66 c7 45 ea f9 03    	movw   $0x3f9,-0x16(%ebp)
  101256:	c6 45 e9 01          	movb   $0x1,-0x17(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  10125a:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
  10125e:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
  101262:	ee                   	out    %al,(%dx)
}
  101263:	90                   	nop
  101264:	66 c7 45 ee fd 03    	movw   $0x3fd,-0x12(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  10126a:	0f b7 45 ee          	movzwl -0x12(%ebp),%eax
  10126e:	89 c2                	mov    %eax,%edx
  101270:	ec                   	in     (%dx),%al
  101271:	88 45 ed             	mov    %al,-0x13(%ebp)
    return data;
  101274:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
    // Enable rcv interrupts
    outb(COM1 + COM_IER, COM_IER_RDI);

    // Clear any preexisting overrun indications and interrupts
    // Serial port doesn't exist if COM_LSR returns 0xFF
    serial_exists = (inb(COM1 + COM_LSR) != 0xFF);
  101278:	3c ff                	cmp    $0xff,%al
  10127a:	0f 95 c0             	setne  %al
  10127d:	0f b6 c0             	movzbl %al,%eax
  101280:	89 81 b8 05 00 00    	mov    %eax,0x5b8(%ecx)
  101286:	66 c7 45 f2 fa 03    	movw   $0x3fa,-0xe(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  10128c:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
  101290:	89 c2                	mov    %eax,%edx
  101292:	ec                   	in     (%dx),%al
  101293:	88 45 f1             	mov    %al,-0xf(%ebp)
  101296:	66 c7 45 f6 f8 03    	movw   $0x3f8,-0xa(%ebp)
  10129c:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  1012a0:	89 c2                	mov    %eax,%edx
  1012a2:	ec                   	in     (%dx),%al
  1012a3:	88 45 f5             	mov    %al,-0xb(%ebp)
    (void) inb(COM1+COM_IIR);
    (void) inb(COM1+COM_RX);

    if (serial_exists) {
  1012a6:	8b 81 b8 05 00 00    	mov    0x5b8(%ecx),%eax
  1012ac:	85 c0                	test   %eax,%eax
  1012ae:	74 0f                	je     1012bf <serial_init+0xfd>
        pic_enable(IRQ_COM1);
  1012b0:	83 ec 0c             	sub    $0xc,%esp
  1012b3:	6a 04                	push   $0x4
  1012b5:	89 cb                	mov    %ecx,%ebx
  1012b7:	e8 fa 07 00 00       	call   101ab6 <pic_enable>
  1012bc:	83 c4 10             	add    $0x10,%esp
    }
}
  1012bf:	90                   	nop
  1012c0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  1012c3:	c9                   	leave  
  1012c4:	c3                   	ret    

001012c5 <lpt_putc_sub>:

static void
lpt_putc_sub(int c) {
  1012c5:	f3 0f 1e fb          	endbr32 
  1012c9:	55                   	push   %ebp
  1012ca:	89 e5                	mov    %esp,%ebp
  1012cc:	83 ec 20             	sub    $0x20,%esp
  1012cf:	e8 cc ef ff ff       	call   1002a0 <__x86.get_pc_thunk.ax>
  1012d4:	05 7c e6 00 00       	add    $0xe67c,%eax
    int i;
    for (i = 0; !(inb(LPTPORT + 1) & 0x80) && i < 12800; i ++) {
  1012d9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  1012e0:	eb 09                	jmp    1012eb <lpt_putc_sub+0x26>
        delay();
  1012e2:	e8 8a fd ff ff       	call   101071 <delay>
    for (i = 0; !(inb(LPTPORT + 1) & 0x80) && i < 12800; i ++) {
  1012e7:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  1012eb:	66 c7 45 fa 79 03    	movw   $0x379,-0x6(%ebp)
  1012f1:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
  1012f5:	89 c2                	mov    %eax,%edx
  1012f7:	ec                   	in     (%dx),%al
  1012f8:	88 45 f9             	mov    %al,-0x7(%ebp)
    return data;
  1012fb:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
  1012ff:	84 c0                	test   %al,%al
  101301:	78 09                	js     10130c <lpt_putc_sub+0x47>
  101303:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%ebp)
  10130a:	7e d6                	jle    1012e2 <lpt_putc_sub+0x1d>
    }
    outb(LPTPORT + 0, c);
  10130c:	8b 45 08             	mov    0x8(%ebp),%eax
  10130f:	0f b6 c0             	movzbl %al,%eax
  101312:	66 c7 45 ee 78 03    	movw   $0x378,-0x12(%ebp)
  101318:	88 45 ed             	mov    %al,-0x13(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  10131b:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  10131f:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  101323:	ee                   	out    %al,(%dx)
}
  101324:	90                   	nop
  101325:	66 c7 45 f2 7a 03    	movw   $0x37a,-0xe(%ebp)
  10132b:	c6 45 f1 0d          	movb   $0xd,-0xf(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  10132f:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  101333:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  101337:	ee                   	out    %al,(%dx)
}
  101338:	90                   	nop
  101339:	66 c7 45 f6 7a 03    	movw   $0x37a,-0xa(%ebp)
  10133f:	c6 45 f5 08          	movb   $0x8,-0xb(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101343:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  101347:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  10134b:	ee                   	out    %al,(%dx)
}
  10134c:	90                   	nop
    outb(LPTPORT + 2, 0x08 | 0x04 | 0x01);
    outb(LPTPORT + 2, 0x08);
}
  10134d:	90                   	nop
  10134e:	c9                   	leave  
  10134f:	c3                   	ret    

00101350 <lpt_putc>:

/* lpt_putc - copy console output to parallel port */
static void
lpt_putc(int c) {
  101350:	f3 0f 1e fb          	endbr32 
  101354:	55                   	push   %ebp
  101355:	89 e5                	mov    %esp,%ebp
  101357:	e8 44 ef ff ff       	call   1002a0 <__x86.get_pc_thunk.ax>
  10135c:	05 f4 e5 00 00       	add    $0xe5f4,%eax
    if (c != '\b') {
  101361:	83 7d 08 08          	cmpl   $0x8,0x8(%ebp)
  101365:	74 0d                	je     101374 <lpt_putc+0x24>
        lpt_putc_sub(c);
  101367:	ff 75 08             	pushl  0x8(%ebp)
  10136a:	e8 56 ff ff ff       	call   1012c5 <lpt_putc_sub>
  10136f:	83 c4 04             	add    $0x4,%esp
    else {
        lpt_putc_sub('\b');
        lpt_putc_sub(' ');
        lpt_putc_sub('\b');
    }
}
  101372:	eb 1e                	jmp    101392 <lpt_putc+0x42>
        lpt_putc_sub('\b');
  101374:	6a 08                	push   $0x8
  101376:	e8 4a ff ff ff       	call   1012c5 <lpt_putc_sub>
  10137b:	83 c4 04             	add    $0x4,%esp
        lpt_putc_sub(' ');
  10137e:	6a 20                	push   $0x20
  101380:	e8 40 ff ff ff       	call   1012c5 <lpt_putc_sub>
  101385:	83 c4 04             	add    $0x4,%esp
        lpt_putc_sub('\b');
  101388:	6a 08                	push   $0x8
  10138a:	e8 36 ff ff ff       	call   1012c5 <lpt_putc_sub>
  10138f:	83 c4 04             	add    $0x4,%esp
}
  101392:	90                   	nop
  101393:	c9                   	leave  
  101394:	c3                   	ret    

00101395 <cga_putc>:

/* cga_putc - print character to console */
static void
cga_putc(int c) {
  101395:	f3 0f 1e fb          	endbr32 
  101399:	55                   	push   %ebp
  10139a:	89 e5                	mov    %esp,%ebp
  10139c:	56                   	push   %esi
  10139d:	53                   	push   %ebx
  10139e:	83 ec 20             	sub    $0x20,%esp
  1013a1:	e8 fe ee ff ff       	call   1002a4 <__x86.get_pc_thunk.bx>
  1013a6:	81 c3 aa e5 00 00    	add    $0xe5aa,%ebx
    // set black on white
    if (!(c & ~0xFF)) {
  1013ac:	8b 45 08             	mov    0x8(%ebp),%eax
  1013af:	b0 00                	mov    $0x0,%al
  1013b1:	85 c0                	test   %eax,%eax
  1013b3:	75 07                	jne    1013bc <cga_putc+0x27>
        c |= 0x0700;
  1013b5:	81 4d 08 00 07 00 00 	orl    $0x700,0x8(%ebp)
    }

    switch (c & 0xff) {
  1013bc:	8b 45 08             	mov    0x8(%ebp),%eax
  1013bf:	0f b6 c0             	movzbl %al,%eax
  1013c2:	83 f8 0d             	cmp    $0xd,%eax
  1013c5:	74 6f                	je     101436 <cga_putc+0xa1>
  1013c7:	83 f8 0d             	cmp    $0xd,%eax
  1013ca:	0f 8f a1 00 00 00    	jg     101471 <cga_putc+0xdc>
  1013d0:	83 f8 08             	cmp    $0x8,%eax
  1013d3:	74 0a                	je     1013df <cga_putc+0x4a>
  1013d5:	83 f8 0a             	cmp    $0xa,%eax
  1013d8:	74 4b                	je     101425 <cga_putc+0x90>
  1013da:	e9 92 00 00 00       	jmp    101471 <cga_putc+0xdc>
    case '\b':
        if (crt_pos > 0) {
  1013df:	0f b7 83 b4 05 00 00 	movzwl 0x5b4(%ebx),%eax
  1013e6:	66 85 c0             	test   %ax,%ax
  1013e9:	0f 84 a8 00 00 00    	je     101497 <cga_putc+0x102>
            crt_pos --;
  1013ef:	0f b7 83 b4 05 00 00 	movzwl 0x5b4(%ebx),%eax
  1013f6:	83 e8 01             	sub    $0x1,%eax
  1013f9:	66 89 83 b4 05 00 00 	mov    %ax,0x5b4(%ebx)
            crt_buf[crt_pos] = (c & ~0xff) | ' ';
  101400:	8b 45 08             	mov    0x8(%ebp),%eax
  101403:	b0 00                	mov    $0x0,%al
  101405:	83 c8 20             	or     $0x20,%eax
  101408:	89 c1                	mov    %eax,%ecx
  10140a:	8b 83 b0 05 00 00    	mov    0x5b0(%ebx),%eax
  101410:	0f b7 93 b4 05 00 00 	movzwl 0x5b4(%ebx),%edx
  101417:	0f b7 d2             	movzwl %dx,%edx
  10141a:	01 d2                	add    %edx,%edx
  10141c:	01 d0                	add    %edx,%eax
  10141e:	89 ca                	mov    %ecx,%edx
  101420:	66 89 10             	mov    %dx,(%eax)
        }
        break;
  101423:	eb 72                	jmp    101497 <cga_putc+0x102>
    case '\n':
        crt_pos += CRT_COLS;
  101425:	0f b7 83 b4 05 00 00 	movzwl 0x5b4(%ebx),%eax
  10142c:	83 c0 50             	add    $0x50,%eax
  10142f:	66 89 83 b4 05 00 00 	mov    %ax,0x5b4(%ebx)
    case '\r':
        crt_pos -= (crt_pos % CRT_COLS);
  101436:	0f b7 b3 b4 05 00 00 	movzwl 0x5b4(%ebx),%esi
  10143d:	0f b7 8b b4 05 00 00 	movzwl 0x5b4(%ebx),%ecx
  101444:	0f b7 c1             	movzwl %cx,%eax
  101447:	69 c0 cd cc 00 00    	imul   $0xcccd,%eax,%eax
  10144d:	c1 e8 10             	shr    $0x10,%eax
  101450:	89 c2                	mov    %eax,%edx
  101452:	66 c1 ea 06          	shr    $0x6,%dx
  101456:	89 d0                	mov    %edx,%eax
  101458:	c1 e0 02             	shl    $0x2,%eax
  10145b:	01 d0                	add    %edx,%eax
  10145d:	c1 e0 04             	shl    $0x4,%eax
  101460:	29 c1                	sub    %eax,%ecx
  101462:	89 ca                	mov    %ecx,%edx
  101464:	89 f0                	mov    %esi,%eax
  101466:	29 d0                	sub    %edx,%eax
  101468:	66 89 83 b4 05 00 00 	mov    %ax,0x5b4(%ebx)
        break;
  10146f:	eb 27                	jmp    101498 <cga_putc+0x103>
    default:
        crt_buf[crt_pos ++] = c;     // write the character
  101471:	8b 8b b0 05 00 00    	mov    0x5b0(%ebx),%ecx
  101477:	0f b7 83 b4 05 00 00 	movzwl 0x5b4(%ebx),%eax
  10147e:	8d 50 01             	lea    0x1(%eax),%edx
  101481:	66 89 93 b4 05 00 00 	mov    %dx,0x5b4(%ebx)
  101488:	0f b7 c0             	movzwl %ax,%eax
  10148b:	01 c0                	add    %eax,%eax
  10148d:	01 c8                	add    %ecx,%eax
  10148f:	8b 55 08             	mov    0x8(%ebp),%edx
  101492:	66 89 10             	mov    %dx,(%eax)
        break;
  101495:	eb 01                	jmp    101498 <cga_putc+0x103>
        break;
  101497:	90                   	nop
    }

    // What is the purpose of this?
    if (crt_pos >= CRT_SIZE) {
  101498:	0f b7 83 b4 05 00 00 	movzwl 0x5b4(%ebx),%eax
  10149f:	66 3d cf 07          	cmp    $0x7cf,%ax
  1014a3:	76 5d                	jbe    101502 <cga_putc+0x16d>
        int i;
        memmove(crt_buf, crt_buf + CRT_COLS, (CRT_SIZE - CRT_COLS) * sizeof(uint16_t));
  1014a5:	8b 83 b0 05 00 00    	mov    0x5b0(%ebx),%eax
  1014ab:	8d 90 a0 00 00 00    	lea    0xa0(%eax),%edx
  1014b1:	8b 83 b0 05 00 00    	mov    0x5b0(%ebx),%eax
  1014b7:	83 ec 04             	sub    $0x4,%esp
  1014ba:	68 00 0f 00 00       	push   $0xf00
  1014bf:	52                   	push   %edx
  1014c0:	50                   	push   %eax
  1014c1:	e8 9c 1c 00 00       	call   103162 <memmove>
  1014c6:	83 c4 10             	add    $0x10,%esp
        for (i = CRT_SIZE - CRT_COLS; i < CRT_SIZE; i ++) {
  1014c9:	c7 45 f4 80 07 00 00 	movl   $0x780,-0xc(%ebp)
  1014d0:	eb 16                	jmp    1014e8 <cga_putc+0x153>
            crt_buf[i] = 0x0700 | ' ';
  1014d2:	8b 83 b0 05 00 00    	mov    0x5b0(%ebx),%eax
  1014d8:	8b 55 f4             	mov    -0xc(%ebp),%edx
  1014db:	01 d2                	add    %edx,%edx
  1014dd:	01 d0                	add    %edx,%eax
  1014df:	66 c7 00 20 07       	movw   $0x720,(%eax)
        for (i = CRT_SIZE - CRT_COLS; i < CRT_SIZE; i ++) {
  1014e4:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  1014e8:	81 7d f4 cf 07 00 00 	cmpl   $0x7cf,-0xc(%ebp)
  1014ef:	7e e1                	jle    1014d2 <cga_putc+0x13d>
        }
        crt_pos -= CRT_COLS;
  1014f1:	0f b7 83 b4 05 00 00 	movzwl 0x5b4(%ebx),%eax
  1014f8:	83 e8 50             	sub    $0x50,%eax
  1014fb:	66 89 83 b4 05 00 00 	mov    %ax,0x5b4(%ebx)
    }

    // move that little blinky thing
    outb(addr_6845, 14);
  101502:	0f b7 83 b6 05 00 00 	movzwl 0x5b6(%ebx),%eax
  101509:	0f b7 c0             	movzwl %ax,%eax
  10150c:	66 89 45 e6          	mov    %ax,-0x1a(%ebp)
  101510:	c6 45 e5 0e          	movb   $0xe,-0x1b(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101514:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
  101518:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
  10151c:	ee                   	out    %al,(%dx)
}
  10151d:	90                   	nop
    outb(addr_6845 + 1, crt_pos >> 8);
  10151e:	0f b7 83 b4 05 00 00 	movzwl 0x5b4(%ebx),%eax
  101525:	66 c1 e8 08          	shr    $0x8,%ax
  101529:	0f b6 c0             	movzbl %al,%eax
  10152c:	0f b7 93 b6 05 00 00 	movzwl 0x5b6(%ebx),%edx
  101533:	83 c2 01             	add    $0x1,%edx
  101536:	0f b7 d2             	movzwl %dx,%edx
  101539:	66 89 55 ea          	mov    %dx,-0x16(%ebp)
  10153d:	88 45 e9             	mov    %al,-0x17(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101540:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
  101544:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
  101548:	ee                   	out    %al,(%dx)
}
  101549:	90                   	nop
    outb(addr_6845, 15);
  10154a:	0f b7 83 b6 05 00 00 	movzwl 0x5b6(%ebx),%eax
  101551:	0f b7 c0             	movzwl %ax,%eax
  101554:	66 89 45 ee          	mov    %ax,-0x12(%ebp)
  101558:	c6 45 ed 0f          	movb   $0xf,-0x13(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  10155c:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  101560:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  101564:	ee                   	out    %al,(%dx)
}
  101565:	90                   	nop
    outb(addr_6845 + 1, crt_pos);
  101566:	0f b7 83 b4 05 00 00 	movzwl 0x5b4(%ebx),%eax
  10156d:	0f b6 c0             	movzbl %al,%eax
  101570:	0f b7 93 b6 05 00 00 	movzwl 0x5b6(%ebx),%edx
  101577:	83 c2 01             	add    $0x1,%edx
  10157a:	0f b7 d2             	movzwl %dx,%edx
  10157d:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  101581:	88 45 f1             	mov    %al,-0xf(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101584:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  101588:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  10158c:	ee                   	out    %al,(%dx)
}
  10158d:	90                   	nop
}
  10158e:	90                   	nop
  10158f:	8d 65 f8             	lea    -0x8(%ebp),%esp
  101592:	5b                   	pop    %ebx
  101593:	5e                   	pop    %esi
  101594:	5d                   	pop    %ebp
  101595:	c3                   	ret    

00101596 <serial_putc_sub>:

static void
serial_putc_sub(int c) {
  101596:	f3 0f 1e fb          	endbr32 
  10159a:	55                   	push   %ebp
  10159b:	89 e5                	mov    %esp,%ebp
  10159d:	83 ec 10             	sub    $0x10,%esp
  1015a0:	e8 fb ec ff ff       	call   1002a0 <__x86.get_pc_thunk.ax>
  1015a5:	05 ab e3 00 00       	add    $0xe3ab,%eax
    int i;
    for (i = 0; !(inb(COM1 + COM_LSR) & COM_LSR_TXRDY) && i < 12800; i ++) {
  1015aa:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  1015b1:	eb 09                	jmp    1015bc <serial_putc_sub+0x26>
        delay();
  1015b3:	e8 b9 fa ff ff       	call   101071 <delay>
    for (i = 0; !(inb(COM1 + COM_LSR) & COM_LSR_TXRDY) && i < 12800; i ++) {
  1015b8:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  1015bc:	66 c7 45 fa fd 03    	movw   $0x3fd,-0x6(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  1015c2:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
  1015c6:	89 c2                	mov    %eax,%edx
  1015c8:	ec                   	in     (%dx),%al
  1015c9:	88 45 f9             	mov    %al,-0x7(%ebp)
    return data;
  1015cc:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
  1015d0:	0f b6 c0             	movzbl %al,%eax
  1015d3:	83 e0 20             	and    $0x20,%eax
  1015d6:	85 c0                	test   %eax,%eax
  1015d8:	75 09                	jne    1015e3 <serial_putc_sub+0x4d>
  1015da:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%ebp)
  1015e1:	7e d0                	jle    1015b3 <serial_putc_sub+0x1d>
    }
    outb(COM1 + COM_TX, c);
  1015e3:	8b 45 08             	mov    0x8(%ebp),%eax
  1015e6:	0f b6 c0             	movzbl %al,%eax
  1015e9:	66 c7 45 f6 f8 03    	movw   $0x3f8,-0xa(%ebp)
  1015ef:	88 45 f5             	mov    %al,-0xb(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1015f2:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  1015f6:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  1015fa:	ee                   	out    %al,(%dx)
}
  1015fb:	90                   	nop
}
  1015fc:	90                   	nop
  1015fd:	c9                   	leave  
  1015fe:	c3                   	ret    

001015ff <serial_putc>:

/* serial_putc - print character to serial port */
static void
serial_putc(int c) {
  1015ff:	f3 0f 1e fb          	endbr32 
  101603:	55                   	push   %ebp
  101604:	89 e5                	mov    %esp,%ebp
  101606:	e8 95 ec ff ff       	call   1002a0 <__x86.get_pc_thunk.ax>
  10160b:	05 45 e3 00 00       	add    $0xe345,%eax
    if (c != '\b') {
  101610:	83 7d 08 08          	cmpl   $0x8,0x8(%ebp)
  101614:	74 0d                	je     101623 <serial_putc+0x24>
        serial_putc_sub(c);
  101616:	ff 75 08             	pushl  0x8(%ebp)
  101619:	e8 78 ff ff ff       	call   101596 <serial_putc_sub>
  10161e:	83 c4 04             	add    $0x4,%esp
    else {
        serial_putc_sub('\b');
        serial_putc_sub(' ');
        serial_putc_sub('\b');
    }
}
  101621:	eb 1e                	jmp    101641 <serial_putc+0x42>
        serial_putc_sub('\b');
  101623:	6a 08                	push   $0x8
  101625:	e8 6c ff ff ff       	call   101596 <serial_putc_sub>
  10162a:	83 c4 04             	add    $0x4,%esp
        serial_putc_sub(' ');
  10162d:	6a 20                	push   $0x20
  10162f:	e8 62 ff ff ff       	call   101596 <serial_putc_sub>
  101634:	83 c4 04             	add    $0x4,%esp
        serial_putc_sub('\b');
  101637:	6a 08                	push   $0x8
  101639:	e8 58 ff ff ff       	call   101596 <serial_putc_sub>
  10163e:	83 c4 04             	add    $0x4,%esp
}
  101641:	90                   	nop
  101642:	c9                   	leave  
  101643:	c3                   	ret    

00101644 <cons_intr>:
/* *
 * cons_intr - called by device interrupt routines to feed input
 * characters into the circular console input buffer.
 * */
static void
cons_intr(int (*proc)(void)) {
  101644:	f3 0f 1e fb          	endbr32 
  101648:	55                   	push   %ebp
  101649:	89 e5                	mov    %esp,%ebp
  10164b:	53                   	push   %ebx
  10164c:	83 ec 14             	sub    $0x14,%esp
  10164f:	e8 50 ec ff ff       	call   1002a4 <__x86.get_pc_thunk.bx>
  101654:	81 c3 fc e2 00 00    	add    $0xe2fc,%ebx
    int c;
    while ((c = (*proc)()) != -1) {
  10165a:	eb 36                	jmp    101692 <cons_intr+0x4e>
        if (c != 0) {
  10165c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  101660:	74 30                	je     101692 <cons_intr+0x4e>
            cons.buf[cons.wpos ++] = c;
  101662:	8b 83 d4 07 00 00    	mov    0x7d4(%ebx),%eax
  101668:	8d 50 01             	lea    0x1(%eax),%edx
  10166b:	89 93 d4 07 00 00    	mov    %edx,0x7d4(%ebx)
  101671:	8b 55 f4             	mov    -0xc(%ebp),%edx
  101674:	88 94 03 d0 05 00 00 	mov    %dl,0x5d0(%ebx,%eax,1)
            if (cons.wpos == CONSBUFSIZE) {
  10167b:	8b 83 d4 07 00 00    	mov    0x7d4(%ebx),%eax
  101681:	3d 00 02 00 00       	cmp    $0x200,%eax
  101686:	75 0a                	jne    101692 <cons_intr+0x4e>
                cons.wpos = 0;
  101688:	c7 83 d4 07 00 00 00 	movl   $0x0,0x7d4(%ebx)
  10168f:	00 00 00 
    while ((c = (*proc)()) != -1) {
  101692:	8b 45 08             	mov    0x8(%ebp),%eax
  101695:	ff d0                	call   *%eax
  101697:	89 45 f4             	mov    %eax,-0xc(%ebp)
  10169a:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
  10169e:	75 bc                	jne    10165c <cons_intr+0x18>
            }
        }
    }
}
  1016a0:	90                   	nop
  1016a1:	90                   	nop
  1016a2:	83 c4 14             	add    $0x14,%esp
  1016a5:	5b                   	pop    %ebx
  1016a6:	5d                   	pop    %ebp
  1016a7:	c3                   	ret    

001016a8 <serial_proc_data>:

/* serial_proc_data - get data from serial port */
static int
serial_proc_data(void) {
  1016a8:	f3 0f 1e fb          	endbr32 
  1016ac:	55                   	push   %ebp
  1016ad:	89 e5                	mov    %esp,%ebp
  1016af:	83 ec 10             	sub    $0x10,%esp
  1016b2:	e8 e9 eb ff ff       	call   1002a0 <__x86.get_pc_thunk.ax>
  1016b7:	05 99 e2 00 00       	add    $0xe299,%eax
  1016bc:	66 c7 45 fa fd 03    	movw   $0x3fd,-0x6(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  1016c2:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
  1016c6:	89 c2                	mov    %eax,%edx
  1016c8:	ec                   	in     (%dx),%al
  1016c9:	88 45 f9             	mov    %al,-0x7(%ebp)
    return data;
  1016cc:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
    if (!(inb(COM1 + COM_LSR) & COM_LSR_DATA)) {
  1016d0:	0f b6 c0             	movzbl %al,%eax
  1016d3:	83 e0 01             	and    $0x1,%eax
  1016d6:	85 c0                	test   %eax,%eax
  1016d8:	75 07                	jne    1016e1 <serial_proc_data+0x39>
        return -1;
  1016da:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  1016df:	eb 2a                	jmp    10170b <serial_proc_data+0x63>
  1016e1:	66 c7 45 f6 f8 03    	movw   $0x3f8,-0xa(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  1016e7:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  1016eb:	89 c2                	mov    %eax,%edx
  1016ed:	ec                   	in     (%dx),%al
  1016ee:	88 45 f5             	mov    %al,-0xb(%ebp)
    return data;
  1016f1:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
    }
    int c = inb(COM1 + COM_RX);
  1016f5:	0f b6 c0             	movzbl %al,%eax
  1016f8:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (c == 127) {
  1016fb:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%ebp)
  1016ff:	75 07                	jne    101708 <serial_proc_data+0x60>
        c = '\b';
  101701:	c7 45 fc 08 00 00 00 	movl   $0x8,-0x4(%ebp)
    }
    return c;
  101708:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  10170b:	c9                   	leave  
  10170c:	c3                   	ret    

0010170d <serial_intr>:

/* serial_intr - try to feed input characters from serial port */
void
serial_intr(void) {
  10170d:	f3 0f 1e fb          	endbr32 
  101711:	55                   	push   %ebp
  101712:	89 e5                	mov    %esp,%ebp
  101714:	83 ec 08             	sub    $0x8,%esp
  101717:	e8 84 eb ff ff       	call   1002a0 <__x86.get_pc_thunk.ax>
  10171c:	05 34 e2 00 00       	add    $0xe234,%eax
    if (serial_exists) {
  101721:	8b 90 b8 05 00 00    	mov    0x5b8(%eax),%edx
  101727:	85 d2                	test   %edx,%edx
  101729:	74 12                	je     10173d <serial_intr+0x30>
        cons_intr(serial_proc_data);
  10172b:	83 ec 0c             	sub    $0xc,%esp
  10172e:	8d 80 58 1d ff ff    	lea    -0xe2a8(%eax),%eax
  101734:	50                   	push   %eax
  101735:	e8 0a ff ff ff       	call   101644 <cons_intr>
  10173a:	83 c4 10             	add    $0x10,%esp
    }
}
  10173d:	90                   	nop
  10173e:	c9                   	leave  
  10173f:	c3                   	ret    

00101740 <kbd_proc_data>:
 *
 * The kbd_proc_data() function gets data from the keyboard.
 * If we finish a character, return it, else 0. And return -1 if no data.
 * */
static int
kbd_proc_data(void) {
  101740:	f3 0f 1e fb          	endbr32 
  101744:	55                   	push   %ebp
  101745:	89 e5                	mov    %esp,%ebp
  101747:	53                   	push   %ebx
  101748:	83 ec 24             	sub    $0x24,%esp
  10174b:	e8 f7 02 00 00       	call   101a47 <__x86.get_pc_thunk.cx>
  101750:	81 c1 00 e2 00 00    	add    $0xe200,%ecx
  101756:	66 c7 45 f0 64 00    	movw   $0x64,-0x10(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  10175c:	0f b7 45 f0          	movzwl -0x10(%ebp),%eax
  101760:	89 c2                	mov    %eax,%edx
  101762:	ec                   	in     (%dx),%al
  101763:	88 45 ef             	mov    %al,-0x11(%ebp)
    return data;
  101766:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    int c;
    uint8_t data;
    static uint32_t shift;

    if ((inb(KBSTATP) & KBS_DIB) == 0) {
  10176a:	0f b6 c0             	movzbl %al,%eax
  10176d:	83 e0 01             	and    $0x1,%eax
  101770:	85 c0                	test   %eax,%eax
  101772:	75 0a                	jne    10177e <kbd_proc_data+0x3e>
        return -1;
  101774:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  101779:	e9 74 01 00 00       	jmp    1018f2 <kbd_proc_data+0x1b2>
  10177e:	66 c7 45 ec 60 00    	movw   $0x60,-0x14(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  101784:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
  101788:	89 c2                	mov    %eax,%edx
  10178a:	ec                   	in     (%dx),%al
  10178b:	88 45 eb             	mov    %al,-0x15(%ebp)
    return data;
  10178e:	0f b6 45 eb          	movzbl -0x15(%ebp),%eax
    }

    data = inb(KBDATAP);
  101792:	88 45 f3             	mov    %al,-0xd(%ebp)

    if (data == 0xE0) {
  101795:	80 7d f3 e0          	cmpb   $0xe0,-0xd(%ebp)
  101799:	75 19                	jne    1017b4 <kbd_proc_data+0x74>
        // E0 escape character
        shift |= E0ESC;
  10179b:	8b 81 d8 07 00 00    	mov    0x7d8(%ecx),%eax
  1017a1:	83 c8 40             	or     $0x40,%eax
  1017a4:	89 81 d8 07 00 00    	mov    %eax,0x7d8(%ecx)
        return 0;
  1017aa:	b8 00 00 00 00       	mov    $0x0,%eax
  1017af:	e9 3e 01 00 00       	jmp    1018f2 <kbd_proc_data+0x1b2>
    } else if (data & 0x80) {
  1017b4:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  1017b8:	84 c0                	test   %al,%al
  1017ba:	79 4b                	jns    101807 <kbd_proc_data+0xc7>
        // Key released
        data = (shift & E0ESC ? data : data & 0x7F);
  1017bc:	8b 81 d8 07 00 00    	mov    0x7d8(%ecx),%eax
  1017c2:	83 e0 40             	and    $0x40,%eax
  1017c5:	85 c0                	test   %eax,%eax
  1017c7:	75 09                	jne    1017d2 <kbd_proc_data+0x92>
  1017c9:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  1017cd:	83 e0 7f             	and    $0x7f,%eax
  1017d0:	eb 04                	jmp    1017d6 <kbd_proc_data+0x96>
  1017d2:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  1017d6:	88 45 f3             	mov    %al,-0xd(%ebp)
        shift &= ~(shiftcode[data] | E0ESC);
  1017d9:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  1017dd:	0f b6 84 01 b0 f6 ff 	movzbl -0x950(%ecx,%eax,1),%eax
  1017e4:	ff 
  1017e5:	83 c8 40             	or     $0x40,%eax
  1017e8:	0f b6 c0             	movzbl %al,%eax
  1017eb:	f7 d0                	not    %eax
  1017ed:	89 c2                	mov    %eax,%edx
  1017ef:	8b 81 d8 07 00 00    	mov    0x7d8(%ecx),%eax
  1017f5:	21 d0                	and    %edx,%eax
  1017f7:	89 81 d8 07 00 00    	mov    %eax,0x7d8(%ecx)
        return 0;
  1017fd:	b8 00 00 00 00       	mov    $0x0,%eax
  101802:	e9 eb 00 00 00       	jmp    1018f2 <kbd_proc_data+0x1b2>
    } else if (shift & E0ESC) {
  101807:	8b 81 d8 07 00 00    	mov    0x7d8(%ecx),%eax
  10180d:	83 e0 40             	and    $0x40,%eax
  101810:	85 c0                	test   %eax,%eax
  101812:	74 13                	je     101827 <kbd_proc_data+0xe7>
        // Last character was an E0 escape; or with 0x80
        data |= 0x80;
  101814:	80 4d f3 80          	orb    $0x80,-0xd(%ebp)
        shift &= ~E0ESC;
  101818:	8b 81 d8 07 00 00    	mov    0x7d8(%ecx),%eax
  10181e:	83 e0 bf             	and    $0xffffffbf,%eax
  101821:	89 81 d8 07 00 00    	mov    %eax,0x7d8(%ecx)
    }

    shift |= shiftcode[data];
  101827:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  10182b:	0f b6 84 01 b0 f6 ff 	movzbl -0x950(%ecx,%eax,1),%eax
  101832:	ff 
  101833:	0f b6 d0             	movzbl %al,%edx
  101836:	8b 81 d8 07 00 00    	mov    0x7d8(%ecx),%eax
  10183c:	09 d0                	or     %edx,%eax
  10183e:	89 81 d8 07 00 00    	mov    %eax,0x7d8(%ecx)
    shift ^= togglecode[data];
  101844:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  101848:	0f b6 84 01 b0 f7 ff 	movzbl -0x850(%ecx,%eax,1),%eax
  10184f:	ff 
  101850:	0f b6 d0             	movzbl %al,%edx
  101853:	8b 81 d8 07 00 00    	mov    0x7d8(%ecx),%eax
  101859:	31 d0                	xor    %edx,%eax
  10185b:	89 81 d8 07 00 00    	mov    %eax,0x7d8(%ecx)

    c = charcode[shift & (CTL | SHIFT)][data];
  101861:	8b 81 d8 07 00 00    	mov    0x7d8(%ecx),%eax
  101867:	83 e0 03             	and    $0x3,%eax
  10186a:	8b 94 81 34 00 00 00 	mov    0x34(%ecx,%eax,4),%edx
  101871:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  101875:	01 d0                	add    %edx,%eax
  101877:	0f b6 00             	movzbl (%eax),%eax
  10187a:	0f b6 c0             	movzbl %al,%eax
  10187d:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (shift & CAPSLOCK) {
  101880:	8b 81 d8 07 00 00    	mov    0x7d8(%ecx),%eax
  101886:	83 e0 08             	and    $0x8,%eax
  101889:	85 c0                	test   %eax,%eax
  10188b:	74 22                	je     1018af <kbd_proc_data+0x16f>
        if ('a' <= c && c <= 'z')
  10188d:	83 7d f4 60          	cmpl   $0x60,-0xc(%ebp)
  101891:	7e 0c                	jle    10189f <kbd_proc_data+0x15f>
  101893:	83 7d f4 7a          	cmpl   $0x7a,-0xc(%ebp)
  101897:	7f 06                	jg     10189f <kbd_proc_data+0x15f>
            c += 'A' - 'a';
  101899:	83 6d f4 20          	subl   $0x20,-0xc(%ebp)
  10189d:	eb 10                	jmp    1018af <kbd_proc_data+0x16f>
        else if ('A' <= c && c <= 'Z')
  10189f:	83 7d f4 40          	cmpl   $0x40,-0xc(%ebp)
  1018a3:	7e 0a                	jle    1018af <kbd_proc_data+0x16f>
  1018a5:	83 7d f4 5a          	cmpl   $0x5a,-0xc(%ebp)
  1018a9:	7f 04                	jg     1018af <kbd_proc_data+0x16f>
            c += 'a' - 'A';
  1018ab:	83 45 f4 20          	addl   $0x20,-0xc(%ebp)
    }

    // Process special keys
    // Ctrl-Alt-Del: reboot
    if (!(~shift & (CTL | ALT)) && c == KEY_DEL) {
  1018af:	8b 81 d8 07 00 00    	mov    0x7d8(%ecx),%eax
  1018b5:	f7 d0                	not    %eax
  1018b7:	83 e0 06             	and    $0x6,%eax
  1018ba:	85 c0                	test   %eax,%eax
  1018bc:	75 31                	jne    1018ef <kbd_proc_data+0x1af>
  1018be:	81 7d f4 e9 00 00 00 	cmpl   $0xe9,-0xc(%ebp)
  1018c5:	75 28                	jne    1018ef <kbd_proc_data+0x1af>
        cprintf("Rebooting!\n");
  1018c7:	83 ec 0c             	sub    $0xc,%esp
  1018ca:	8d 81 45 43 ff ff    	lea    -0xbcbb(%ecx),%eax
  1018d0:	50                   	push   %eax
  1018d1:	89 cb                	mov    %ecx,%ebx
  1018d3:	e8 47 ea ff ff       	call   10031f <cprintf>
  1018d8:	83 c4 10             	add    $0x10,%esp
  1018db:	66 c7 45 e8 92 00    	movw   $0x92,-0x18(%ebp)
  1018e1:	c6 45 e7 03          	movb   $0x3,-0x19(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1018e5:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
  1018e9:	0f b7 55 e8          	movzwl -0x18(%ebp),%edx
  1018ed:	ee                   	out    %al,(%dx)
}
  1018ee:	90                   	nop
        outb(0x92, 0x3); // courtesy of Chris Frost
    }
    return c;
  1018ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  1018f2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  1018f5:	c9                   	leave  
  1018f6:	c3                   	ret    

001018f7 <kbd_intr>:

/* kbd_intr - try to feed input characters from keyboard */
static void
kbd_intr(void) {
  1018f7:	f3 0f 1e fb          	endbr32 
  1018fb:	55                   	push   %ebp
  1018fc:	89 e5                	mov    %esp,%ebp
  1018fe:	83 ec 08             	sub    $0x8,%esp
  101901:	e8 9a e9 ff ff       	call   1002a0 <__x86.get_pc_thunk.ax>
  101906:	05 4a e0 00 00       	add    $0xe04a,%eax
    cons_intr(kbd_proc_data);
  10190b:	83 ec 0c             	sub    $0xc,%esp
  10190e:	8d 80 f0 1d ff ff    	lea    -0xe210(%eax),%eax
  101914:	50                   	push   %eax
  101915:	e8 2a fd ff ff       	call   101644 <cons_intr>
  10191a:	83 c4 10             	add    $0x10,%esp
}
  10191d:	90                   	nop
  10191e:	c9                   	leave  
  10191f:	c3                   	ret    

00101920 <kbd_init>:

static void
kbd_init(void) {
  101920:	f3 0f 1e fb          	endbr32 
  101924:	55                   	push   %ebp
  101925:	89 e5                	mov    %esp,%ebp
  101927:	53                   	push   %ebx
  101928:	83 ec 04             	sub    $0x4,%esp
  10192b:	e8 74 e9 ff ff       	call   1002a4 <__x86.get_pc_thunk.bx>
  101930:	81 c3 20 e0 00 00    	add    $0xe020,%ebx
    // drain the kbd buffer
    kbd_intr();
  101936:	e8 bc ff ff ff       	call   1018f7 <kbd_intr>
    pic_enable(IRQ_KBD);
  10193b:	83 ec 0c             	sub    $0xc,%esp
  10193e:	6a 01                	push   $0x1
  101940:	e8 71 01 00 00       	call   101ab6 <pic_enable>
  101945:	83 c4 10             	add    $0x10,%esp
}
  101948:	90                   	nop
  101949:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  10194c:	c9                   	leave  
  10194d:	c3                   	ret    

0010194e <cons_init>:

/* cons_init - initializes the console devices */
void
cons_init(void) {
  10194e:	f3 0f 1e fb          	endbr32 
  101952:	55                   	push   %ebp
  101953:	89 e5                	mov    %esp,%ebp
  101955:	53                   	push   %ebx
  101956:	83 ec 04             	sub    $0x4,%esp
  101959:	e8 46 e9 ff ff       	call   1002a4 <__x86.get_pc_thunk.bx>
  10195e:	81 c3 f2 df 00 00    	add    $0xdff2,%ebx
    cga_init();
  101964:	e8 5f f7 ff ff       	call   1010c8 <cga_init>
    serial_init();
  101969:	e8 54 f8 ff ff       	call   1011c2 <serial_init>
    kbd_init();
  10196e:	e8 ad ff ff ff       	call   101920 <kbd_init>
    if (!serial_exists) {
  101973:	8b 83 b8 05 00 00    	mov    0x5b8(%ebx),%eax
  101979:	85 c0                	test   %eax,%eax
  10197b:	75 12                	jne    10198f <cons_init+0x41>
        cprintf("serial port does not exist!!\n");
  10197d:	83 ec 0c             	sub    $0xc,%esp
  101980:	8d 83 51 43 ff ff    	lea    -0xbcaf(%ebx),%eax
  101986:	50                   	push   %eax
  101987:	e8 93 e9 ff ff       	call   10031f <cprintf>
  10198c:	83 c4 10             	add    $0x10,%esp
    }
}
  10198f:	90                   	nop
  101990:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  101993:	c9                   	leave  
  101994:	c3                   	ret    

00101995 <cons_putc>:

/* cons_putc - print a single character @c to console devices */
void
cons_putc(int c) {
  101995:	f3 0f 1e fb          	endbr32 
  101999:	55                   	push   %ebp
  10199a:	89 e5                	mov    %esp,%ebp
  10199c:	83 ec 08             	sub    $0x8,%esp
  10199f:	e8 fc e8 ff ff       	call   1002a0 <__x86.get_pc_thunk.ax>
  1019a4:	05 ac df 00 00       	add    $0xdfac,%eax
    lpt_putc(c);
  1019a9:	ff 75 08             	pushl  0x8(%ebp)
  1019ac:	e8 9f f9 ff ff       	call   101350 <lpt_putc>
  1019b1:	83 c4 04             	add    $0x4,%esp
    cga_putc(c);
  1019b4:	83 ec 0c             	sub    $0xc,%esp
  1019b7:	ff 75 08             	pushl  0x8(%ebp)
  1019ba:	e8 d6 f9 ff ff       	call   101395 <cga_putc>
  1019bf:	83 c4 10             	add    $0x10,%esp
    serial_putc(c);
  1019c2:	83 ec 0c             	sub    $0xc,%esp
  1019c5:	ff 75 08             	pushl  0x8(%ebp)
  1019c8:	e8 32 fc ff ff       	call   1015ff <serial_putc>
  1019cd:	83 c4 10             	add    $0x10,%esp
}
  1019d0:	90                   	nop
  1019d1:	c9                   	leave  
  1019d2:	c3                   	ret    

001019d3 <cons_getc>:
/* *
 * cons_getc - return the next input character from console,
 * or 0 if none waiting.
 * */
int
cons_getc(void) {
  1019d3:	f3 0f 1e fb          	endbr32 
  1019d7:	55                   	push   %ebp
  1019d8:	89 e5                	mov    %esp,%ebp
  1019da:	53                   	push   %ebx
  1019db:	83 ec 14             	sub    $0x14,%esp
  1019de:	e8 c1 e8 ff ff       	call   1002a4 <__x86.get_pc_thunk.bx>
  1019e3:	81 c3 6d df 00 00    	add    $0xdf6d,%ebx
    int c;

    // poll for any pending input characters,
    // so that this function works even when interrupts are disabled
    // (e.g., when called from the kernel monitor).
    serial_intr();
  1019e9:	e8 1f fd ff ff       	call   10170d <serial_intr>
    kbd_intr();
  1019ee:	e8 04 ff ff ff       	call   1018f7 <kbd_intr>

    // grab the next character from the input buffer.
    if (cons.rpos != cons.wpos) {
  1019f3:	8b 93 d0 07 00 00    	mov    0x7d0(%ebx),%edx
  1019f9:	8b 83 d4 07 00 00    	mov    0x7d4(%ebx),%eax
  1019ff:	39 c2                	cmp    %eax,%edx
  101a01:	74 39                	je     101a3c <cons_getc+0x69>
        c = cons.buf[cons.rpos ++];
  101a03:	8b 83 d0 07 00 00    	mov    0x7d0(%ebx),%eax
  101a09:	8d 50 01             	lea    0x1(%eax),%edx
  101a0c:	89 93 d0 07 00 00    	mov    %edx,0x7d0(%ebx)
  101a12:	0f b6 84 03 d0 05 00 	movzbl 0x5d0(%ebx,%eax,1),%eax
  101a19:	00 
  101a1a:	0f b6 c0             	movzbl %al,%eax
  101a1d:	89 45 f4             	mov    %eax,-0xc(%ebp)
        if (cons.rpos == CONSBUFSIZE) {
  101a20:	8b 83 d0 07 00 00    	mov    0x7d0(%ebx),%eax
  101a26:	3d 00 02 00 00       	cmp    $0x200,%eax
  101a2b:	75 0a                	jne    101a37 <cons_getc+0x64>
            cons.rpos = 0;
  101a2d:	c7 83 d0 07 00 00 00 	movl   $0x0,0x7d0(%ebx)
  101a34:	00 00 00 
        }
        return c;
  101a37:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101a3a:	eb 05                	jmp    101a41 <cons_getc+0x6e>
    }
    return 0;
  101a3c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  101a41:	83 c4 14             	add    $0x14,%esp
  101a44:	5b                   	pop    %ebx
  101a45:	5d                   	pop    %ebp
  101a46:	c3                   	ret    

00101a47 <__x86.get_pc_thunk.cx>:
  101a47:	8b 0c 24             	mov    (%esp),%ecx
  101a4a:	c3                   	ret    

00101a4b <pic_setmask>:
// Initial IRQ mask has interrupt 2 enabled (for slave 8259A).
static uint16_t irq_mask = 0xFFFF & ~(1 << IRQ_SLAVE);
static bool did_init = 0;

static void
pic_setmask(uint16_t mask) {
  101a4b:	f3 0f 1e fb          	endbr32 
  101a4f:	55                   	push   %ebp
  101a50:	89 e5                	mov    %esp,%ebp
  101a52:	83 ec 14             	sub    $0x14,%esp
  101a55:	e8 46 e8 ff ff       	call   1002a0 <__x86.get_pc_thunk.ax>
  101a5a:	05 f6 de 00 00       	add    $0xdef6,%eax
  101a5f:	8b 55 08             	mov    0x8(%ebp),%edx
  101a62:	66 89 55 ec          	mov    %dx,-0x14(%ebp)
    irq_mask = mask;
  101a66:	0f b7 55 ec          	movzwl -0x14(%ebp),%edx
  101a6a:	66 89 90 b0 fb ff ff 	mov    %dx,-0x450(%eax)
    if (did_init) {
  101a71:	8b 80 dc 07 00 00    	mov    0x7dc(%eax),%eax
  101a77:	85 c0                	test   %eax,%eax
  101a79:	74 38                	je     101ab3 <pic_setmask+0x68>
        outb(IO_PIC1 + 1, mask);
  101a7b:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
  101a7f:	0f b6 c0             	movzbl %al,%eax
  101a82:	66 c7 45 fa 21 00    	movw   $0x21,-0x6(%ebp)
  101a88:	88 45 f9             	mov    %al,-0x7(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101a8b:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
  101a8f:	0f b7 55 fa          	movzwl -0x6(%ebp),%edx
  101a93:	ee                   	out    %al,(%dx)
}
  101a94:	90                   	nop
        outb(IO_PIC2 + 1, mask >> 8);
  101a95:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
  101a99:	66 c1 e8 08          	shr    $0x8,%ax
  101a9d:	0f b6 c0             	movzbl %al,%eax
  101aa0:	66 c7 45 fe a1 00    	movw   $0xa1,-0x2(%ebp)
  101aa6:	88 45 fd             	mov    %al,-0x3(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101aa9:	0f b6 45 fd          	movzbl -0x3(%ebp),%eax
  101aad:	0f b7 55 fe          	movzwl -0x2(%ebp),%edx
  101ab1:	ee                   	out    %al,(%dx)
}
  101ab2:	90                   	nop
    }
}
  101ab3:	90                   	nop
  101ab4:	c9                   	leave  
  101ab5:	c3                   	ret    

00101ab6 <pic_enable>:

void
pic_enable(unsigned int irq) {
  101ab6:	f3 0f 1e fb          	endbr32 
  101aba:	55                   	push   %ebp
  101abb:	89 e5                	mov    %esp,%ebp
  101abd:	53                   	push   %ebx
  101abe:	e8 dd e7 ff ff       	call   1002a0 <__x86.get_pc_thunk.ax>
  101ac3:	05 8d de 00 00       	add    $0xde8d,%eax
    pic_setmask(irq_mask & ~(1 << irq));
  101ac8:	8b 55 08             	mov    0x8(%ebp),%edx
  101acb:	bb 01 00 00 00       	mov    $0x1,%ebx
  101ad0:	89 d1                	mov    %edx,%ecx
  101ad2:	d3 e3                	shl    %cl,%ebx
  101ad4:	89 da                	mov    %ebx,%edx
  101ad6:	f7 d2                	not    %edx
  101ad8:	0f b7 80 b0 fb ff ff 	movzwl -0x450(%eax),%eax
  101adf:	21 d0                	and    %edx,%eax
  101ae1:	0f b7 c0             	movzwl %ax,%eax
  101ae4:	50                   	push   %eax
  101ae5:	e8 61 ff ff ff       	call   101a4b <pic_setmask>
  101aea:	83 c4 04             	add    $0x4,%esp
}
  101aed:	90                   	nop
  101aee:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  101af1:	c9                   	leave  
  101af2:	c3                   	ret    

00101af3 <pic_init>:

/* pic_init - initialize the 8259A interrupt controllers */
void
pic_init(void) {
  101af3:	f3 0f 1e fb          	endbr32 
  101af7:	55                   	push   %ebp
  101af8:	89 e5                	mov    %esp,%ebp
  101afa:	83 ec 40             	sub    $0x40,%esp
  101afd:	e8 45 ff ff ff       	call   101a47 <__x86.get_pc_thunk.cx>
  101b02:	81 c1 4e de 00 00    	add    $0xde4e,%ecx
    did_init = 1;
  101b08:	c7 81 dc 07 00 00 01 	movl   $0x1,0x7dc(%ecx)
  101b0f:	00 00 00 
  101b12:	66 c7 45 ca 21 00    	movw   $0x21,-0x36(%ebp)
  101b18:	c6 45 c9 ff          	movb   $0xff,-0x37(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101b1c:	0f b6 45 c9          	movzbl -0x37(%ebp),%eax
  101b20:	0f b7 55 ca          	movzwl -0x36(%ebp),%edx
  101b24:	ee                   	out    %al,(%dx)
}
  101b25:	90                   	nop
  101b26:	66 c7 45 ce a1 00    	movw   $0xa1,-0x32(%ebp)
  101b2c:	c6 45 cd ff          	movb   $0xff,-0x33(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101b30:	0f b6 45 cd          	movzbl -0x33(%ebp),%eax
  101b34:	0f b7 55 ce          	movzwl -0x32(%ebp),%edx
  101b38:	ee                   	out    %al,(%dx)
}
  101b39:	90                   	nop
  101b3a:	66 c7 45 d2 20 00    	movw   $0x20,-0x2e(%ebp)
  101b40:	c6 45 d1 11          	movb   $0x11,-0x2f(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101b44:	0f b6 45 d1          	movzbl -0x2f(%ebp),%eax
  101b48:	0f b7 55 d2          	movzwl -0x2e(%ebp),%edx
  101b4c:	ee                   	out    %al,(%dx)
}
  101b4d:	90                   	nop
  101b4e:	66 c7 45 d6 21 00    	movw   $0x21,-0x2a(%ebp)
  101b54:	c6 45 d5 20          	movb   $0x20,-0x2b(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101b58:	0f b6 45 d5          	movzbl -0x2b(%ebp),%eax
  101b5c:	0f b7 55 d6          	movzwl -0x2a(%ebp),%edx
  101b60:	ee                   	out    %al,(%dx)
}
  101b61:	90                   	nop
  101b62:	66 c7 45 da 21 00    	movw   $0x21,-0x26(%ebp)
  101b68:	c6 45 d9 04          	movb   $0x4,-0x27(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101b6c:	0f b6 45 d9          	movzbl -0x27(%ebp),%eax
  101b70:	0f b7 55 da          	movzwl -0x26(%ebp),%edx
  101b74:	ee                   	out    %al,(%dx)
}
  101b75:	90                   	nop
  101b76:	66 c7 45 de 21 00    	movw   $0x21,-0x22(%ebp)
  101b7c:	c6 45 dd 03          	movb   $0x3,-0x23(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101b80:	0f b6 45 dd          	movzbl -0x23(%ebp),%eax
  101b84:	0f b7 55 de          	movzwl -0x22(%ebp),%edx
  101b88:	ee                   	out    %al,(%dx)
}
  101b89:	90                   	nop
  101b8a:	66 c7 45 e2 a0 00    	movw   $0xa0,-0x1e(%ebp)
  101b90:	c6 45 e1 11          	movb   $0x11,-0x1f(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101b94:	0f b6 45 e1          	movzbl -0x1f(%ebp),%eax
  101b98:	0f b7 55 e2          	movzwl -0x1e(%ebp),%edx
  101b9c:	ee                   	out    %al,(%dx)
}
  101b9d:	90                   	nop
  101b9e:	66 c7 45 e6 a1 00    	movw   $0xa1,-0x1a(%ebp)
  101ba4:	c6 45 e5 28          	movb   $0x28,-0x1b(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101ba8:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
  101bac:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
  101bb0:	ee                   	out    %al,(%dx)
}
  101bb1:	90                   	nop
  101bb2:	66 c7 45 ea a1 00    	movw   $0xa1,-0x16(%ebp)
  101bb8:	c6 45 e9 02          	movb   $0x2,-0x17(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101bbc:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
  101bc0:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
  101bc4:	ee                   	out    %al,(%dx)
}
  101bc5:	90                   	nop
  101bc6:	66 c7 45 ee a1 00    	movw   $0xa1,-0x12(%ebp)
  101bcc:	c6 45 ed 03          	movb   $0x3,-0x13(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101bd0:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  101bd4:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  101bd8:	ee                   	out    %al,(%dx)
}
  101bd9:	90                   	nop
  101bda:	66 c7 45 f2 20 00    	movw   $0x20,-0xe(%ebp)
  101be0:	c6 45 f1 68          	movb   $0x68,-0xf(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101be4:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  101be8:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  101bec:	ee                   	out    %al,(%dx)
}
  101bed:	90                   	nop
  101bee:	66 c7 45 f6 20 00    	movw   $0x20,-0xa(%ebp)
  101bf4:	c6 45 f5 0a          	movb   $0xa,-0xb(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101bf8:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  101bfc:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  101c00:	ee                   	out    %al,(%dx)
}
  101c01:	90                   	nop
  101c02:	66 c7 45 fa a0 00    	movw   $0xa0,-0x6(%ebp)
  101c08:	c6 45 f9 68          	movb   $0x68,-0x7(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101c0c:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
  101c10:	0f b7 55 fa          	movzwl -0x6(%ebp),%edx
  101c14:	ee                   	out    %al,(%dx)
}
  101c15:	90                   	nop
  101c16:	66 c7 45 fe a0 00    	movw   $0xa0,-0x2(%ebp)
  101c1c:	c6 45 fd 0a          	movb   $0xa,-0x3(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101c20:	0f b6 45 fd          	movzbl -0x3(%ebp),%eax
  101c24:	0f b7 55 fe          	movzwl -0x2(%ebp),%edx
  101c28:	ee                   	out    %al,(%dx)
}
  101c29:	90                   	nop
    outb(IO_PIC1, 0x0a);    // read IRR by default

    outb(IO_PIC2, 0x68);    // OCW3
    outb(IO_PIC2, 0x0a);    // OCW3

    if (irq_mask != 0xFFFF) {
  101c2a:	0f b7 81 b0 fb ff ff 	movzwl -0x450(%ecx),%eax
  101c31:	66 83 f8 ff          	cmp    $0xffff,%ax
  101c35:	74 13                	je     101c4a <pic_init+0x157>
        pic_setmask(irq_mask);
  101c37:	0f b7 81 b0 fb ff ff 	movzwl -0x450(%ecx),%eax
  101c3e:	0f b7 c0             	movzwl %ax,%eax
  101c41:	50                   	push   %eax
  101c42:	e8 04 fe ff ff       	call   101a4b <pic_setmask>
  101c47:	83 c4 04             	add    $0x4,%esp
    }
}
  101c4a:	90                   	nop
  101c4b:	c9                   	leave  
  101c4c:	c3                   	ret    

00101c4d <intr_enable>:
#include <x86.h>
#include <intr.h>

/* intr_enable - enable irq interrupt */
void
intr_enable(void) {
  101c4d:	f3 0f 1e fb          	endbr32 
  101c51:	55                   	push   %ebp
  101c52:	89 e5                	mov    %esp,%ebp
  101c54:	e8 47 e6 ff ff       	call   1002a0 <__x86.get_pc_thunk.ax>
  101c59:	05 f7 dc 00 00       	add    $0xdcf7,%eax
    asm volatile ("lidt (%0)" :: "r" (pd));
}

static inline void
sti(void) {
    asm volatile ("sti");
  101c5e:	fb                   	sti    
}
  101c5f:	90                   	nop
    sti();
}
  101c60:	90                   	nop
  101c61:	5d                   	pop    %ebp
  101c62:	c3                   	ret    

00101c63 <intr_disable>:

/* intr_disable - disable irq interrupt */
void
intr_disable(void) {
  101c63:	f3 0f 1e fb          	endbr32 
  101c67:	55                   	push   %ebp
  101c68:	89 e5                	mov    %esp,%ebp
  101c6a:	e8 31 e6 ff ff       	call   1002a0 <__x86.get_pc_thunk.ax>
  101c6f:	05 e1 dc 00 00       	add    $0xdce1,%eax

static inline void
cli(void) {
    asm volatile ("cli");
  101c74:	fa                   	cli    
}
  101c75:	90                   	nop
    cli();
}
  101c76:	90                   	nop
  101c77:	5d                   	pop    %ebp
  101c78:	c3                   	ret    

00101c79 <print_ticks>:
#include <console.h>
#include <kdebug.h>

#define TICK_NUM 100

static void print_ticks() {
  101c79:	f3 0f 1e fb          	endbr32 
  101c7d:	55                   	push   %ebp
  101c7e:	89 e5                	mov    %esp,%ebp
  101c80:	53                   	push   %ebx
  101c81:	83 ec 04             	sub    $0x4,%esp
  101c84:	e8 1b e6 ff ff       	call   1002a4 <__x86.get_pc_thunk.bx>
  101c89:	81 c3 c7 dc 00 00    	add    $0xdcc7,%ebx
    cprintf("%d ticks\n",TICK_NUM);
  101c8f:	83 ec 08             	sub    $0x8,%esp
  101c92:	6a 64                	push   $0x64
  101c94:	8d 83 6f 43 ff ff    	lea    -0xbc91(%ebx),%eax
  101c9a:	50                   	push   %eax
  101c9b:	e8 7f e6 ff ff       	call   10031f <cprintf>
  101ca0:	83 c4 10             	add    $0x10,%esp
#ifdef DEBUG_GRADE
    cprintf("End of Test.\n");
  101ca3:	83 ec 0c             	sub    $0xc,%esp
  101ca6:	8d 83 79 43 ff ff    	lea    -0xbc87(%ebx),%eax
  101cac:	50                   	push   %eax
  101cad:	e8 6d e6 ff ff       	call   10031f <cprintf>
  101cb2:	83 c4 10             	add    $0x10,%esp
    panic("EOT: kernel seems ok.");
  101cb5:	83 ec 04             	sub    $0x4,%esp
  101cb8:	8d 83 87 43 ff ff    	lea    -0xbc79(%ebx),%eax
  101cbe:	50                   	push   %eax
  101cbf:	6a 12                	push   $0x12
  101cc1:	8d 83 9d 43 ff ff    	lea    -0xbc63(%ebx),%eax
  101cc7:	50                   	push   %eax
  101cc8:	e8 17 e8 ff ff       	call   1004e4 <__panic>

00101ccd <idt_init>:
    sizeof(idt) - 1, (uintptr_t)idt
};

/* idt_init - initialize IDT to each of the entry points in kern/trap/vectors.S */
void
idt_init(void) {
  101ccd:	f3 0f 1e fb          	endbr32 
  101cd1:	55                   	push   %ebp
  101cd2:	89 e5                	mov    %esp,%ebp
  101cd4:	e8 c7 e5 ff ff       	call   1002a0 <__x86.get_pc_thunk.ax>
  101cd9:	05 77 dc 00 00       	add    $0xdc77,%eax
      *     Can you see idt[256] in this file? Yes, it's IDT! you can use SETGATE macro to setup each item of IDT
      * (3) After setup the contents of IDT, you will let CPU know where is the IDT by using 'lidt' instruction.
      *     You don't know the meaning of this instruction? just google it! and check the libs/x86.h to know more.
      *     Notice: the argument of lidt is idt_pd. try to find it!
      */
}
  101cde:	90                   	nop
  101cdf:	5d                   	pop    %ebp
  101ce0:	c3                   	ret    

00101ce1 <trapname>:

static const char *
trapname(int trapno) {
  101ce1:	f3 0f 1e fb          	endbr32 
  101ce5:	55                   	push   %ebp
  101ce6:	89 e5                	mov    %esp,%ebp
  101ce8:	e8 b3 e5 ff ff       	call   1002a0 <__x86.get_pc_thunk.ax>
  101ced:	05 63 dc 00 00       	add    $0xdc63,%eax
        "Alignment Check",
        "Machine-Check",
        "SIMD Floating-Point Exception"
    };

    if (trapno < sizeof(excnames)/sizeof(const char * const)) {
  101cf2:	8b 55 08             	mov    0x8(%ebp),%edx
  101cf5:	83 fa 13             	cmp    $0x13,%edx
  101cf8:	77 0c                	ja     101d06 <trapname+0x25>
        return excnames[trapno];
  101cfa:	8b 55 08             	mov    0x8(%ebp),%edx
  101cfd:	8b 84 90 f0 00 00 00 	mov    0xf0(%eax,%edx,4),%eax
  101d04:	eb 1a                	jmp    101d20 <trapname+0x3f>
    }
    if (trapno >= IRQ_OFFSET && trapno < IRQ_OFFSET + 16) {
  101d06:	83 7d 08 1f          	cmpl   $0x1f,0x8(%ebp)
  101d0a:	7e 0e                	jle    101d1a <trapname+0x39>
  101d0c:	83 7d 08 2f          	cmpl   $0x2f,0x8(%ebp)
  101d10:	7f 08                	jg     101d1a <trapname+0x39>
        return "Hardware Interrupt";
  101d12:	8d 80 ae 43 ff ff    	lea    -0xbc52(%eax),%eax
  101d18:	eb 06                	jmp    101d20 <trapname+0x3f>
    }
    return "(unknown trap)";
  101d1a:	8d 80 c1 43 ff ff    	lea    -0xbc3f(%eax),%eax
}
  101d20:	5d                   	pop    %ebp
  101d21:	c3                   	ret    

00101d22 <trap_in_kernel>:

/* trap_in_kernel - test if trap happened in kernel */
bool
trap_in_kernel(struct trapframe *tf) {
  101d22:	f3 0f 1e fb          	endbr32 
  101d26:	55                   	push   %ebp
  101d27:	89 e5                	mov    %esp,%ebp
  101d29:	e8 72 e5 ff ff       	call   1002a0 <__x86.get_pc_thunk.ax>
  101d2e:	05 22 dc 00 00       	add    $0xdc22,%eax
    return (tf->tf_cs == (uint16_t)KERNEL_CS);
  101d33:	8b 45 08             	mov    0x8(%ebp),%eax
  101d36:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101d3a:	66 83 f8 08          	cmp    $0x8,%ax
  101d3e:	0f 94 c0             	sete   %al
  101d41:	0f b6 c0             	movzbl %al,%eax
}
  101d44:	5d                   	pop    %ebp
  101d45:	c3                   	ret    

00101d46 <print_trapframe>:
    "TF", "IF", "DF", "OF", NULL, NULL, "NT", NULL,
    "RF", "VM", "AC", "VIF", "VIP", "ID", NULL, NULL,
};

void
print_trapframe(struct trapframe *tf) {
  101d46:	f3 0f 1e fb          	endbr32 
  101d4a:	55                   	push   %ebp
  101d4b:	89 e5                	mov    %esp,%ebp
  101d4d:	53                   	push   %ebx
  101d4e:	83 ec 14             	sub    $0x14,%esp
  101d51:	e8 4e e5 ff ff       	call   1002a4 <__x86.get_pc_thunk.bx>
  101d56:	81 c3 fa db 00 00    	add    $0xdbfa,%ebx
    cprintf("trapframe at %p\n", tf);
  101d5c:	83 ec 08             	sub    $0x8,%esp
  101d5f:	ff 75 08             	pushl  0x8(%ebp)
  101d62:	8d 83 02 44 ff ff    	lea    -0xbbfe(%ebx),%eax
  101d68:	50                   	push   %eax
  101d69:	e8 b1 e5 ff ff       	call   10031f <cprintf>
  101d6e:	83 c4 10             	add    $0x10,%esp
    print_regs(&tf->tf_regs);
  101d71:	8b 45 08             	mov    0x8(%ebp),%eax
  101d74:	83 ec 0c             	sub    $0xc,%esp
  101d77:	50                   	push   %eax
  101d78:	e8 d1 01 00 00       	call   101f4e <print_regs>
  101d7d:	83 c4 10             	add    $0x10,%esp
    cprintf("  ds   0x----%04x\n", tf->tf_ds);
  101d80:	8b 45 08             	mov    0x8(%ebp),%eax
  101d83:	0f b7 40 2c          	movzwl 0x2c(%eax),%eax
  101d87:	0f b7 c0             	movzwl %ax,%eax
  101d8a:	83 ec 08             	sub    $0x8,%esp
  101d8d:	50                   	push   %eax
  101d8e:	8d 83 13 44 ff ff    	lea    -0xbbed(%ebx),%eax
  101d94:	50                   	push   %eax
  101d95:	e8 85 e5 ff ff       	call   10031f <cprintf>
  101d9a:	83 c4 10             	add    $0x10,%esp
    cprintf("  es   0x----%04x\n", tf->tf_es);
  101d9d:	8b 45 08             	mov    0x8(%ebp),%eax
  101da0:	0f b7 40 28          	movzwl 0x28(%eax),%eax
  101da4:	0f b7 c0             	movzwl %ax,%eax
  101da7:	83 ec 08             	sub    $0x8,%esp
  101daa:	50                   	push   %eax
  101dab:	8d 83 26 44 ff ff    	lea    -0xbbda(%ebx),%eax
  101db1:	50                   	push   %eax
  101db2:	e8 68 e5 ff ff       	call   10031f <cprintf>
  101db7:	83 c4 10             	add    $0x10,%esp
    cprintf("  fs   0x----%04x\n", tf->tf_fs);
  101dba:	8b 45 08             	mov    0x8(%ebp),%eax
  101dbd:	0f b7 40 24          	movzwl 0x24(%eax),%eax
  101dc1:	0f b7 c0             	movzwl %ax,%eax
  101dc4:	83 ec 08             	sub    $0x8,%esp
  101dc7:	50                   	push   %eax
  101dc8:	8d 83 39 44 ff ff    	lea    -0xbbc7(%ebx),%eax
  101dce:	50                   	push   %eax
  101dcf:	e8 4b e5 ff ff       	call   10031f <cprintf>
  101dd4:	83 c4 10             	add    $0x10,%esp
    cprintf("  gs   0x----%04x\n", tf->tf_gs);
  101dd7:	8b 45 08             	mov    0x8(%ebp),%eax
  101dda:	0f b7 40 20          	movzwl 0x20(%eax),%eax
  101dde:	0f b7 c0             	movzwl %ax,%eax
  101de1:	83 ec 08             	sub    $0x8,%esp
  101de4:	50                   	push   %eax
  101de5:	8d 83 4c 44 ff ff    	lea    -0xbbb4(%ebx),%eax
  101deb:	50                   	push   %eax
  101dec:	e8 2e e5 ff ff       	call   10031f <cprintf>
  101df1:	83 c4 10             	add    $0x10,%esp
    cprintf("  trap 0x%08x %s\n", tf->tf_trapno, trapname(tf->tf_trapno));
  101df4:	8b 45 08             	mov    0x8(%ebp),%eax
  101df7:	8b 40 30             	mov    0x30(%eax),%eax
  101dfa:	83 ec 0c             	sub    $0xc,%esp
  101dfd:	50                   	push   %eax
  101dfe:	e8 de fe ff ff       	call   101ce1 <trapname>
  101e03:	83 c4 10             	add    $0x10,%esp
  101e06:	8b 55 08             	mov    0x8(%ebp),%edx
  101e09:	8b 52 30             	mov    0x30(%edx),%edx
  101e0c:	83 ec 04             	sub    $0x4,%esp
  101e0f:	50                   	push   %eax
  101e10:	52                   	push   %edx
  101e11:	8d 83 5f 44 ff ff    	lea    -0xbba1(%ebx),%eax
  101e17:	50                   	push   %eax
  101e18:	e8 02 e5 ff ff       	call   10031f <cprintf>
  101e1d:	83 c4 10             	add    $0x10,%esp
    cprintf("  err  0x%08x\n", tf->tf_err);
  101e20:	8b 45 08             	mov    0x8(%ebp),%eax
  101e23:	8b 40 34             	mov    0x34(%eax),%eax
  101e26:	83 ec 08             	sub    $0x8,%esp
  101e29:	50                   	push   %eax
  101e2a:	8d 83 71 44 ff ff    	lea    -0xbb8f(%ebx),%eax
  101e30:	50                   	push   %eax
  101e31:	e8 e9 e4 ff ff       	call   10031f <cprintf>
  101e36:	83 c4 10             	add    $0x10,%esp
    cprintf("  eip  0x%08x\n", tf->tf_eip);
  101e39:	8b 45 08             	mov    0x8(%ebp),%eax
  101e3c:	8b 40 38             	mov    0x38(%eax),%eax
  101e3f:	83 ec 08             	sub    $0x8,%esp
  101e42:	50                   	push   %eax
  101e43:	8d 83 80 44 ff ff    	lea    -0xbb80(%ebx),%eax
  101e49:	50                   	push   %eax
  101e4a:	e8 d0 e4 ff ff       	call   10031f <cprintf>
  101e4f:	83 c4 10             	add    $0x10,%esp
    cprintf("  cs   0x----%04x\n", tf->tf_cs);
  101e52:	8b 45 08             	mov    0x8(%ebp),%eax
  101e55:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101e59:	0f b7 c0             	movzwl %ax,%eax
  101e5c:	83 ec 08             	sub    $0x8,%esp
  101e5f:	50                   	push   %eax
  101e60:	8d 83 8f 44 ff ff    	lea    -0xbb71(%ebx),%eax
  101e66:	50                   	push   %eax
  101e67:	e8 b3 e4 ff ff       	call   10031f <cprintf>
  101e6c:	83 c4 10             	add    $0x10,%esp
    cprintf("  flag 0x%08x ", tf->tf_eflags);
  101e6f:	8b 45 08             	mov    0x8(%ebp),%eax
  101e72:	8b 40 40             	mov    0x40(%eax),%eax
  101e75:	83 ec 08             	sub    $0x8,%esp
  101e78:	50                   	push   %eax
  101e79:	8d 83 a2 44 ff ff    	lea    -0xbb5e(%ebx),%eax
  101e7f:	50                   	push   %eax
  101e80:	e8 9a e4 ff ff       	call   10031f <cprintf>
  101e85:	83 c4 10             	add    $0x10,%esp

    int i, j;
    for (i = 0, j = 1; i < sizeof(IA32flags) / sizeof(IA32flags[0]); i ++, j <<= 1) {
  101e88:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  101e8f:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
  101e96:	eb 41                	jmp    101ed9 <print_trapframe+0x193>
        if ((tf->tf_eflags & j) && IA32flags[i] != NULL) {
  101e98:	8b 45 08             	mov    0x8(%ebp),%eax
  101e9b:	8b 50 40             	mov    0x40(%eax),%edx
  101e9e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  101ea1:	21 d0                	and    %edx,%eax
  101ea3:	85 c0                	test   %eax,%eax
  101ea5:	74 2b                	je     101ed2 <print_trapframe+0x18c>
  101ea7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101eaa:	8b 84 83 70 00 00 00 	mov    0x70(%ebx,%eax,4),%eax
  101eb1:	85 c0                	test   %eax,%eax
  101eb3:	74 1d                	je     101ed2 <print_trapframe+0x18c>
            cprintf("%s,", IA32flags[i]);
  101eb5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101eb8:	8b 84 83 70 00 00 00 	mov    0x70(%ebx,%eax,4),%eax
  101ebf:	83 ec 08             	sub    $0x8,%esp
  101ec2:	50                   	push   %eax
  101ec3:	8d 83 b1 44 ff ff    	lea    -0xbb4f(%ebx),%eax
  101ec9:	50                   	push   %eax
  101eca:	e8 50 e4 ff ff       	call   10031f <cprintf>
  101ecf:	83 c4 10             	add    $0x10,%esp
    for (i = 0, j = 1; i < sizeof(IA32flags) / sizeof(IA32flags[0]); i ++, j <<= 1) {
  101ed2:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  101ed6:	d1 65 f0             	shll   -0x10(%ebp)
  101ed9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101edc:	83 f8 17             	cmp    $0x17,%eax
  101edf:	76 b7                	jbe    101e98 <print_trapframe+0x152>
        }
    }
    cprintf("IOPL=%d\n", (tf->tf_eflags & FL_IOPL_MASK) >> 12);
  101ee1:	8b 45 08             	mov    0x8(%ebp),%eax
  101ee4:	8b 40 40             	mov    0x40(%eax),%eax
  101ee7:	c1 e8 0c             	shr    $0xc,%eax
  101eea:	83 e0 03             	and    $0x3,%eax
  101eed:	83 ec 08             	sub    $0x8,%esp
  101ef0:	50                   	push   %eax
  101ef1:	8d 83 b5 44 ff ff    	lea    -0xbb4b(%ebx),%eax
  101ef7:	50                   	push   %eax
  101ef8:	e8 22 e4 ff ff       	call   10031f <cprintf>
  101efd:	83 c4 10             	add    $0x10,%esp

    if (!trap_in_kernel(tf)) {
  101f00:	83 ec 0c             	sub    $0xc,%esp
  101f03:	ff 75 08             	pushl  0x8(%ebp)
  101f06:	e8 17 fe ff ff       	call   101d22 <trap_in_kernel>
  101f0b:	83 c4 10             	add    $0x10,%esp
  101f0e:	85 c0                	test   %eax,%eax
  101f10:	75 36                	jne    101f48 <print_trapframe+0x202>
        cprintf("  esp  0x%08x\n", tf->tf_esp);
  101f12:	8b 45 08             	mov    0x8(%ebp),%eax
  101f15:	8b 40 44             	mov    0x44(%eax),%eax
  101f18:	83 ec 08             	sub    $0x8,%esp
  101f1b:	50                   	push   %eax
  101f1c:	8d 83 be 44 ff ff    	lea    -0xbb42(%ebx),%eax
  101f22:	50                   	push   %eax
  101f23:	e8 f7 e3 ff ff       	call   10031f <cprintf>
  101f28:	83 c4 10             	add    $0x10,%esp
        cprintf("  ss   0x----%04x\n", tf->tf_ss);
  101f2b:	8b 45 08             	mov    0x8(%ebp),%eax
  101f2e:	0f b7 40 48          	movzwl 0x48(%eax),%eax
  101f32:	0f b7 c0             	movzwl %ax,%eax
  101f35:	83 ec 08             	sub    $0x8,%esp
  101f38:	50                   	push   %eax
  101f39:	8d 83 cd 44 ff ff    	lea    -0xbb33(%ebx),%eax
  101f3f:	50                   	push   %eax
  101f40:	e8 da e3 ff ff       	call   10031f <cprintf>
  101f45:	83 c4 10             	add    $0x10,%esp
    }
}
  101f48:	90                   	nop
  101f49:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  101f4c:	c9                   	leave  
  101f4d:	c3                   	ret    

00101f4e <print_regs>:

void
print_regs(struct pushregs *regs) {
  101f4e:	f3 0f 1e fb          	endbr32 
  101f52:	55                   	push   %ebp
  101f53:	89 e5                	mov    %esp,%ebp
  101f55:	53                   	push   %ebx
  101f56:	83 ec 04             	sub    $0x4,%esp
  101f59:	e8 46 e3 ff ff       	call   1002a4 <__x86.get_pc_thunk.bx>
  101f5e:	81 c3 f2 d9 00 00    	add    $0xd9f2,%ebx
    cprintf("  edi  0x%08x\n", regs->reg_edi);
  101f64:	8b 45 08             	mov    0x8(%ebp),%eax
  101f67:	8b 00                	mov    (%eax),%eax
  101f69:	83 ec 08             	sub    $0x8,%esp
  101f6c:	50                   	push   %eax
  101f6d:	8d 83 e0 44 ff ff    	lea    -0xbb20(%ebx),%eax
  101f73:	50                   	push   %eax
  101f74:	e8 a6 e3 ff ff       	call   10031f <cprintf>
  101f79:	83 c4 10             	add    $0x10,%esp
    cprintf("  esi  0x%08x\n", regs->reg_esi);
  101f7c:	8b 45 08             	mov    0x8(%ebp),%eax
  101f7f:	8b 40 04             	mov    0x4(%eax),%eax
  101f82:	83 ec 08             	sub    $0x8,%esp
  101f85:	50                   	push   %eax
  101f86:	8d 83 ef 44 ff ff    	lea    -0xbb11(%ebx),%eax
  101f8c:	50                   	push   %eax
  101f8d:	e8 8d e3 ff ff       	call   10031f <cprintf>
  101f92:	83 c4 10             	add    $0x10,%esp
    cprintf("  ebp  0x%08x\n", regs->reg_ebp);
  101f95:	8b 45 08             	mov    0x8(%ebp),%eax
  101f98:	8b 40 08             	mov    0x8(%eax),%eax
  101f9b:	83 ec 08             	sub    $0x8,%esp
  101f9e:	50                   	push   %eax
  101f9f:	8d 83 fe 44 ff ff    	lea    -0xbb02(%ebx),%eax
  101fa5:	50                   	push   %eax
  101fa6:	e8 74 e3 ff ff       	call   10031f <cprintf>
  101fab:	83 c4 10             	add    $0x10,%esp
    cprintf("  oesp 0x%08x\n", regs->reg_oesp);
  101fae:	8b 45 08             	mov    0x8(%ebp),%eax
  101fb1:	8b 40 0c             	mov    0xc(%eax),%eax
  101fb4:	83 ec 08             	sub    $0x8,%esp
  101fb7:	50                   	push   %eax
  101fb8:	8d 83 0d 45 ff ff    	lea    -0xbaf3(%ebx),%eax
  101fbe:	50                   	push   %eax
  101fbf:	e8 5b e3 ff ff       	call   10031f <cprintf>
  101fc4:	83 c4 10             	add    $0x10,%esp
    cprintf("  ebx  0x%08x\n", regs->reg_ebx);
  101fc7:	8b 45 08             	mov    0x8(%ebp),%eax
  101fca:	8b 40 10             	mov    0x10(%eax),%eax
  101fcd:	83 ec 08             	sub    $0x8,%esp
  101fd0:	50                   	push   %eax
  101fd1:	8d 83 1c 45 ff ff    	lea    -0xbae4(%ebx),%eax
  101fd7:	50                   	push   %eax
  101fd8:	e8 42 e3 ff ff       	call   10031f <cprintf>
  101fdd:	83 c4 10             	add    $0x10,%esp
    cprintf("  edx  0x%08x\n", regs->reg_edx);
  101fe0:	8b 45 08             	mov    0x8(%ebp),%eax
  101fe3:	8b 40 14             	mov    0x14(%eax),%eax
  101fe6:	83 ec 08             	sub    $0x8,%esp
  101fe9:	50                   	push   %eax
  101fea:	8d 83 2b 45 ff ff    	lea    -0xbad5(%ebx),%eax
  101ff0:	50                   	push   %eax
  101ff1:	e8 29 e3 ff ff       	call   10031f <cprintf>
  101ff6:	83 c4 10             	add    $0x10,%esp
    cprintf("  ecx  0x%08x\n", regs->reg_ecx);
  101ff9:	8b 45 08             	mov    0x8(%ebp),%eax
  101ffc:	8b 40 18             	mov    0x18(%eax),%eax
  101fff:	83 ec 08             	sub    $0x8,%esp
  102002:	50                   	push   %eax
  102003:	8d 83 3a 45 ff ff    	lea    -0xbac6(%ebx),%eax
  102009:	50                   	push   %eax
  10200a:	e8 10 e3 ff ff       	call   10031f <cprintf>
  10200f:	83 c4 10             	add    $0x10,%esp
    cprintf("  eax  0x%08x\n", regs->reg_eax);
  102012:	8b 45 08             	mov    0x8(%ebp),%eax
  102015:	8b 40 1c             	mov    0x1c(%eax),%eax
  102018:	83 ec 08             	sub    $0x8,%esp
  10201b:	50                   	push   %eax
  10201c:	8d 83 49 45 ff ff    	lea    -0xbab7(%ebx),%eax
  102022:	50                   	push   %eax
  102023:	e8 f7 e2 ff ff       	call   10031f <cprintf>
  102028:	83 c4 10             	add    $0x10,%esp
}
  10202b:	90                   	nop
  10202c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  10202f:	c9                   	leave  
  102030:	c3                   	ret    

00102031 <trap_dispatch>:

/* trap_dispatch - dispatch based on what type of trap occurred */
static void
trap_dispatch(struct trapframe *tf) {
  102031:	f3 0f 1e fb          	endbr32 
  102035:	55                   	push   %ebp
  102036:	89 e5                	mov    %esp,%ebp
  102038:	53                   	push   %ebx
  102039:	83 ec 14             	sub    $0x14,%esp
  10203c:	e8 63 e2 ff ff       	call   1002a4 <__x86.get_pc_thunk.bx>
  102041:	81 c3 0f d9 00 00    	add    $0xd90f,%ebx
    char c;

    switch (tf->tf_trapno) {
  102047:	8b 45 08             	mov    0x8(%ebp),%eax
  10204a:	8b 40 30             	mov    0x30(%eax),%eax
  10204d:	83 f8 79             	cmp    $0x79,%eax
  102050:	0f 87 98 00 00 00    	ja     1020ee <trap_dispatch+0xbd>
  102056:	83 f8 78             	cmp    $0x78,%eax
  102059:	73 78                	jae    1020d3 <trap_dispatch+0xa2>
  10205b:	83 f8 2f             	cmp    $0x2f,%eax
  10205e:	0f 87 8a 00 00 00    	ja     1020ee <trap_dispatch+0xbd>
  102064:	83 f8 2e             	cmp    $0x2e,%eax
  102067:	0f 83 bb 00 00 00    	jae    102128 <trap_dispatch+0xf7>
  10206d:	83 f8 24             	cmp    $0x24,%eax
  102070:	74 15                	je     102087 <trap_dispatch+0x56>
  102072:	83 f8 24             	cmp    $0x24,%eax
  102075:	77 77                	ja     1020ee <trap_dispatch+0xbd>
  102077:	83 f8 20             	cmp    $0x20,%eax
  10207a:	0f 84 ab 00 00 00    	je     10212b <trap_dispatch+0xfa>
  102080:	83 f8 21             	cmp    $0x21,%eax
  102083:	74 28                	je     1020ad <trap_dispatch+0x7c>
  102085:	eb 67                	jmp    1020ee <trap_dispatch+0xbd>
         * (2) Every TICK_NUM cycle, you can print some info using a funciton, such as print_ticks().
         * (3) Too Simple? Yes, I think so!
         */
        break;
    case IRQ_OFFSET + IRQ_COM1:
        c = cons_getc();
  102087:	e8 47 f9 ff ff       	call   1019d3 <cons_getc>
  10208c:	88 45 f7             	mov    %al,-0x9(%ebp)
        cprintf("serial [%03d] %c\n", c, c);
  10208f:	0f be 55 f7          	movsbl -0x9(%ebp),%edx
  102093:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  102097:	83 ec 04             	sub    $0x4,%esp
  10209a:	52                   	push   %edx
  10209b:	50                   	push   %eax
  10209c:	8d 83 58 45 ff ff    	lea    -0xbaa8(%ebx),%eax
  1020a2:	50                   	push   %eax
  1020a3:	e8 77 e2 ff ff       	call   10031f <cprintf>
  1020a8:	83 c4 10             	add    $0x10,%esp
        break;
  1020ab:	eb 7f                	jmp    10212c <trap_dispatch+0xfb>
    case IRQ_OFFSET + IRQ_KBD:
        c = cons_getc();
  1020ad:	e8 21 f9 ff ff       	call   1019d3 <cons_getc>
  1020b2:	88 45 f7             	mov    %al,-0x9(%ebp)
        cprintf("kbd [%03d] %c\n", c, c);
  1020b5:	0f be 55 f7          	movsbl -0x9(%ebp),%edx
  1020b9:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  1020bd:	83 ec 04             	sub    $0x4,%esp
  1020c0:	52                   	push   %edx
  1020c1:	50                   	push   %eax
  1020c2:	8d 83 6a 45 ff ff    	lea    -0xba96(%ebx),%eax
  1020c8:	50                   	push   %eax
  1020c9:	e8 51 e2 ff ff       	call   10031f <cprintf>
  1020ce:	83 c4 10             	add    $0x10,%esp
        break;
  1020d1:	eb 59                	jmp    10212c <trap_dispatch+0xfb>
    //LAB1 CHALLENGE 1 : YOUR CODE you should modify below codes.
    case T_SWITCH_TOU:
    case T_SWITCH_TOK:
        panic("T_SWITCH_** ??\n");
  1020d3:	83 ec 04             	sub    $0x4,%esp
  1020d6:	8d 83 79 45 ff ff    	lea    -0xba87(%ebx),%eax
  1020dc:	50                   	push   %eax
  1020dd:	68 a2 00 00 00       	push   $0xa2
  1020e2:	8d 83 9d 43 ff ff    	lea    -0xbc63(%ebx),%eax
  1020e8:	50                   	push   %eax
  1020e9:	e8 f6 e3 ff ff       	call   1004e4 <__panic>
    case IRQ_OFFSET + IRQ_IDE2:
        /* do nothing */
        break;
    default:
        // in kernel, it must be a mistake
        if ((tf->tf_cs & 3) == 0) {
  1020ee:	8b 45 08             	mov    0x8(%ebp),%eax
  1020f1:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  1020f5:	0f b7 c0             	movzwl %ax,%eax
  1020f8:	83 e0 03             	and    $0x3,%eax
  1020fb:	85 c0                	test   %eax,%eax
  1020fd:	75 2d                	jne    10212c <trap_dispatch+0xfb>
            print_trapframe(tf);
  1020ff:	83 ec 0c             	sub    $0xc,%esp
  102102:	ff 75 08             	pushl  0x8(%ebp)
  102105:	e8 3c fc ff ff       	call   101d46 <print_trapframe>
  10210a:	83 c4 10             	add    $0x10,%esp
            panic("unexpected trap in kernel.\n");
  10210d:	83 ec 04             	sub    $0x4,%esp
  102110:	8d 83 89 45 ff ff    	lea    -0xba77(%ebx),%eax
  102116:	50                   	push   %eax
  102117:	68 ac 00 00 00       	push   $0xac
  10211c:	8d 83 9d 43 ff ff    	lea    -0xbc63(%ebx),%eax
  102122:	50                   	push   %eax
  102123:	e8 bc e3 ff ff       	call   1004e4 <__panic>
        break;
  102128:	90                   	nop
  102129:	eb 01                	jmp    10212c <trap_dispatch+0xfb>
        break;
  10212b:	90                   	nop
        }
    }
}
  10212c:	90                   	nop
  10212d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  102130:	c9                   	leave  
  102131:	c3                   	ret    

00102132 <trap>:
 * trap - handles or dispatches an exception/interrupt. if and when trap() returns,
 * the code in kern/trap/trapentry.S restores the old CPU state saved in the
 * trapframe and then uses the iret instruction to return from the exception.
 * */
void
trap(struct trapframe *tf) {
  102132:	f3 0f 1e fb          	endbr32 
  102136:	55                   	push   %ebp
  102137:	89 e5                	mov    %esp,%ebp
  102139:	83 ec 08             	sub    $0x8,%esp
  10213c:	e8 5f e1 ff ff       	call   1002a0 <__x86.get_pc_thunk.ax>
  102141:	05 0f d8 00 00       	add    $0xd80f,%eax
    // dispatch based on what type of trap occurred
    trap_dispatch(tf);
  102146:	83 ec 0c             	sub    $0xc,%esp
  102149:	ff 75 08             	pushl  0x8(%ebp)
  10214c:	e8 e0 fe ff ff       	call   102031 <trap_dispatch>
  102151:	83 c4 10             	add    $0x10,%esp
}
  102154:	90                   	nop
  102155:	c9                   	leave  
  102156:	c3                   	ret    

00102157 <vector0>:
# handler
.text
.globl __alltraps
.globl vector0
vector0:
  pushl $0
  102157:	6a 00                	push   $0x0
  pushl $0
  102159:	6a 00                	push   $0x0
  jmp __alltraps
  10215b:	e9 67 0a 00 00       	jmp    102bc7 <__alltraps>

00102160 <vector1>:
.globl vector1
vector1:
  pushl $0
  102160:	6a 00                	push   $0x0
  pushl $1
  102162:	6a 01                	push   $0x1
  jmp __alltraps
  102164:	e9 5e 0a 00 00       	jmp    102bc7 <__alltraps>

00102169 <vector2>:
.globl vector2
vector2:
  pushl $0
  102169:	6a 00                	push   $0x0
  pushl $2
  10216b:	6a 02                	push   $0x2
  jmp __alltraps
  10216d:	e9 55 0a 00 00       	jmp    102bc7 <__alltraps>

00102172 <vector3>:
.globl vector3
vector3:
  pushl $0
  102172:	6a 00                	push   $0x0
  pushl $3
  102174:	6a 03                	push   $0x3
  jmp __alltraps
  102176:	e9 4c 0a 00 00       	jmp    102bc7 <__alltraps>

0010217b <vector4>:
.globl vector4
vector4:
  pushl $0
  10217b:	6a 00                	push   $0x0
  pushl $4
  10217d:	6a 04                	push   $0x4
  jmp __alltraps
  10217f:	e9 43 0a 00 00       	jmp    102bc7 <__alltraps>

00102184 <vector5>:
.globl vector5
vector5:
  pushl $0
  102184:	6a 00                	push   $0x0
  pushl $5
  102186:	6a 05                	push   $0x5
  jmp __alltraps
  102188:	e9 3a 0a 00 00       	jmp    102bc7 <__alltraps>

0010218d <vector6>:
.globl vector6
vector6:
  pushl $0
  10218d:	6a 00                	push   $0x0
  pushl $6
  10218f:	6a 06                	push   $0x6
  jmp __alltraps
  102191:	e9 31 0a 00 00       	jmp    102bc7 <__alltraps>

00102196 <vector7>:
.globl vector7
vector7:
  pushl $0
  102196:	6a 00                	push   $0x0
  pushl $7
  102198:	6a 07                	push   $0x7
  jmp __alltraps
  10219a:	e9 28 0a 00 00       	jmp    102bc7 <__alltraps>

0010219f <vector8>:
.globl vector8
vector8:
  pushl $8
  10219f:	6a 08                	push   $0x8
  jmp __alltraps
  1021a1:	e9 21 0a 00 00       	jmp    102bc7 <__alltraps>

001021a6 <vector9>:
.globl vector9
vector9:
  pushl $9
  1021a6:	6a 09                	push   $0x9
  jmp __alltraps
  1021a8:	e9 1a 0a 00 00       	jmp    102bc7 <__alltraps>

001021ad <vector10>:
.globl vector10
vector10:
  pushl $10
  1021ad:	6a 0a                	push   $0xa
  jmp __alltraps
  1021af:	e9 13 0a 00 00       	jmp    102bc7 <__alltraps>

001021b4 <vector11>:
.globl vector11
vector11:
  pushl $11
  1021b4:	6a 0b                	push   $0xb
  jmp __alltraps
  1021b6:	e9 0c 0a 00 00       	jmp    102bc7 <__alltraps>

001021bb <vector12>:
.globl vector12
vector12:
  pushl $12
  1021bb:	6a 0c                	push   $0xc
  jmp __alltraps
  1021bd:	e9 05 0a 00 00       	jmp    102bc7 <__alltraps>

001021c2 <vector13>:
.globl vector13
vector13:
  pushl $13
  1021c2:	6a 0d                	push   $0xd
  jmp __alltraps
  1021c4:	e9 fe 09 00 00       	jmp    102bc7 <__alltraps>

001021c9 <vector14>:
.globl vector14
vector14:
  pushl $14
  1021c9:	6a 0e                	push   $0xe
  jmp __alltraps
  1021cb:	e9 f7 09 00 00       	jmp    102bc7 <__alltraps>

001021d0 <vector15>:
.globl vector15
vector15:
  pushl $0
  1021d0:	6a 00                	push   $0x0
  pushl $15
  1021d2:	6a 0f                	push   $0xf
  jmp __alltraps
  1021d4:	e9 ee 09 00 00       	jmp    102bc7 <__alltraps>

001021d9 <vector16>:
.globl vector16
vector16:
  pushl $0
  1021d9:	6a 00                	push   $0x0
  pushl $16
  1021db:	6a 10                	push   $0x10
  jmp __alltraps
  1021dd:	e9 e5 09 00 00       	jmp    102bc7 <__alltraps>

001021e2 <vector17>:
.globl vector17
vector17:
  pushl $17
  1021e2:	6a 11                	push   $0x11
  jmp __alltraps
  1021e4:	e9 de 09 00 00       	jmp    102bc7 <__alltraps>

001021e9 <vector18>:
.globl vector18
vector18:
  pushl $0
  1021e9:	6a 00                	push   $0x0
  pushl $18
  1021eb:	6a 12                	push   $0x12
  jmp __alltraps
  1021ed:	e9 d5 09 00 00       	jmp    102bc7 <__alltraps>

001021f2 <vector19>:
.globl vector19
vector19:
  pushl $0
  1021f2:	6a 00                	push   $0x0
  pushl $19
  1021f4:	6a 13                	push   $0x13
  jmp __alltraps
  1021f6:	e9 cc 09 00 00       	jmp    102bc7 <__alltraps>

001021fb <vector20>:
.globl vector20
vector20:
  pushl $0
  1021fb:	6a 00                	push   $0x0
  pushl $20
  1021fd:	6a 14                	push   $0x14
  jmp __alltraps
  1021ff:	e9 c3 09 00 00       	jmp    102bc7 <__alltraps>

00102204 <vector21>:
.globl vector21
vector21:
  pushl $0
  102204:	6a 00                	push   $0x0
  pushl $21
  102206:	6a 15                	push   $0x15
  jmp __alltraps
  102208:	e9 ba 09 00 00       	jmp    102bc7 <__alltraps>

0010220d <vector22>:
.globl vector22
vector22:
  pushl $0
  10220d:	6a 00                	push   $0x0
  pushl $22
  10220f:	6a 16                	push   $0x16
  jmp __alltraps
  102211:	e9 b1 09 00 00       	jmp    102bc7 <__alltraps>

00102216 <vector23>:
.globl vector23
vector23:
  pushl $0
  102216:	6a 00                	push   $0x0
  pushl $23
  102218:	6a 17                	push   $0x17
  jmp __alltraps
  10221a:	e9 a8 09 00 00       	jmp    102bc7 <__alltraps>

0010221f <vector24>:
.globl vector24
vector24:
  pushl $0
  10221f:	6a 00                	push   $0x0
  pushl $24
  102221:	6a 18                	push   $0x18
  jmp __alltraps
  102223:	e9 9f 09 00 00       	jmp    102bc7 <__alltraps>

00102228 <vector25>:
.globl vector25
vector25:
  pushl $0
  102228:	6a 00                	push   $0x0
  pushl $25
  10222a:	6a 19                	push   $0x19
  jmp __alltraps
  10222c:	e9 96 09 00 00       	jmp    102bc7 <__alltraps>

00102231 <vector26>:
.globl vector26
vector26:
  pushl $0
  102231:	6a 00                	push   $0x0
  pushl $26
  102233:	6a 1a                	push   $0x1a
  jmp __alltraps
  102235:	e9 8d 09 00 00       	jmp    102bc7 <__alltraps>

0010223a <vector27>:
.globl vector27
vector27:
  pushl $0
  10223a:	6a 00                	push   $0x0
  pushl $27
  10223c:	6a 1b                	push   $0x1b
  jmp __alltraps
  10223e:	e9 84 09 00 00       	jmp    102bc7 <__alltraps>

00102243 <vector28>:
.globl vector28
vector28:
  pushl $0
  102243:	6a 00                	push   $0x0
  pushl $28
  102245:	6a 1c                	push   $0x1c
  jmp __alltraps
  102247:	e9 7b 09 00 00       	jmp    102bc7 <__alltraps>

0010224c <vector29>:
.globl vector29
vector29:
  pushl $0
  10224c:	6a 00                	push   $0x0
  pushl $29
  10224e:	6a 1d                	push   $0x1d
  jmp __alltraps
  102250:	e9 72 09 00 00       	jmp    102bc7 <__alltraps>

00102255 <vector30>:
.globl vector30
vector30:
  pushl $0
  102255:	6a 00                	push   $0x0
  pushl $30
  102257:	6a 1e                	push   $0x1e
  jmp __alltraps
  102259:	e9 69 09 00 00       	jmp    102bc7 <__alltraps>

0010225e <vector31>:
.globl vector31
vector31:
  pushl $0
  10225e:	6a 00                	push   $0x0
  pushl $31
  102260:	6a 1f                	push   $0x1f
  jmp __alltraps
  102262:	e9 60 09 00 00       	jmp    102bc7 <__alltraps>

00102267 <vector32>:
.globl vector32
vector32:
  pushl $0
  102267:	6a 00                	push   $0x0
  pushl $32
  102269:	6a 20                	push   $0x20
  jmp __alltraps
  10226b:	e9 57 09 00 00       	jmp    102bc7 <__alltraps>

00102270 <vector33>:
.globl vector33
vector33:
  pushl $0
  102270:	6a 00                	push   $0x0
  pushl $33
  102272:	6a 21                	push   $0x21
  jmp __alltraps
  102274:	e9 4e 09 00 00       	jmp    102bc7 <__alltraps>

00102279 <vector34>:
.globl vector34
vector34:
  pushl $0
  102279:	6a 00                	push   $0x0
  pushl $34
  10227b:	6a 22                	push   $0x22
  jmp __alltraps
  10227d:	e9 45 09 00 00       	jmp    102bc7 <__alltraps>

00102282 <vector35>:
.globl vector35
vector35:
  pushl $0
  102282:	6a 00                	push   $0x0
  pushl $35
  102284:	6a 23                	push   $0x23
  jmp __alltraps
  102286:	e9 3c 09 00 00       	jmp    102bc7 <__alltraps>

0010228b <vector36>:
.globl vector36
vector36:
  pushl $0
  10228b:	6a 00                	push   $0x0
  pushl $36
  10228d:	6a 24                	push   $0x24
  jmp __alltraps
  10228f:	e9 33 09 00 00       	jmp    102bc7 <__alltraps>

00102294 <vector37>:
.globl vector37
vector37:
  pushl $0
  102294:	6a 00                	push   $0x0
  pushl $37
  102296:	6a 25                	push   $0x25
  jmp __alltraps
  102298:	e9 2a 09 00 00       	jmp    102bc7 <__alltraps>

0010229d <vector38>:
.globl vector38
vector38:
  pushl $0
  10229d:	6a 00                	push   $0x0
  pushl $38
  10229f:	6a 26                	push   $0x26
  jmp __alltraps
  1022a1:	e9 21 09 00 00       	jmp    102bc7 <__alltraps>

001022a6 <vector39>:
.globl vector39
vector39:
  pushl $0
  1022a6:	6a 00                	push   $0x0
  pushl $39
  1022a8:	6a 27                	push   $0x27
  jmp __alltraps
  1022aa:	e9 18 09 00 00       	jmp    102bc7 <__alltraps>

001022af <vector40>:
.globl vector40
vector40:
  pushl $0
  1022af:	6a 00                	push   $0x0
  pushl $40
  1022b1:	6a 28                	push   $0x28
  jmp __alltraps
  1022b3:	e9 0f 09 00 00       	jmp    102bc7 <__alltraps>

001022b8 <vector41>:
.globl vector41
vector41:
  pushl $0
  1022b8:	6a 00                	push   $0x0
  pushl $41
  1022ba:	6a 29                	push   $0x29
  jmp __alltraps
  1022bc:	e9 06 09 00 00       	jmp    102bc7 <__alltraps>

001022c1 <vector42>:
.globl vector42
vector42:
  pushl $0
  1022c1:	6a 00                	push   $0x0
  pushl $42
  1022c3:	6a 2a                	push   $0x2a
  jmp __alltraps
  1022c5:	e9 fd 08 00 00       	jmp    102bc7 <__alltraps>

001022ca <vector43>:
.globl vector43
vector43:
  pushl $0
  1022ca:	6a 00                	push   $0x0
  pushl $43
  1022cc:	6a 2b                	push   $0x2b
  jmp __alltraps
  1022ce:	e9 f4 08 00 00       	jmp    102bc7 <__alltraps>

001022d3 <vector44>:
.globl vector44
vector44:
  pushl $0
  1022d3:	6a 00                	push   $0x0
  pushl $44
  1022d5:	6a 2c                	push   $0x2c
  jmp __alltraps
  1022d7:	e9 eb 08 00 00       	jmp    102bc7 <__alltraps>

001022dc <vector45>:
.globl vector45
vector45:
  pushl $0
  1022dc:	6a 00                	push   $0x0
  pushl $45
  1022de:	6a 2d                	push   $0x2d
  jmp __alltraps
  1022e0:	e9 e2 08 00 00       	jmp    102bc7 <__alltraps>

001022e5 <vector46>:
.globl vector46
vector46:
  pushl $0
  1022e5:	6a 00                	push   $0x0
  pushl $46
  1022e7:	6a 2e                	push   $0x2e
  jmp __alltraps
  1022e9:	e9 d9 08 00 00       	jmp    102bc7 <__alltraps>

001022ee <vector47>:
.globl vector47
vector47:
  pushl $0
  1022ee:	6a 00                	push   $0x0
  pushl $47
  1022f0:	6a 2f                	push   $0x2f
  jmp __alltraps
  1022f2:	e9 d0 08 00 00       	jmp    102bc7 <__alltraps>

001022f7 <vector48>:
.globl vector48
vector48:
  pushl $0
  1022f7:	6a 00                	push   $0x0
  pushl $48
  1022f9:	6a 30                	push   $0x30
  jmp __alltraps
  1022fb:	e9 c7 08 00 00       	jmp    102bc7 <__alltraps>

00102300 <vector49>:
.globl vector49
vector49:
  pushl $0
  102300:	6a 00                	push   $0x0
  pushl $49
  102302:	6a 31                	push   $0x31
  jmp __alltraps
  102304:	e9 be 08 00 00       	jmp    102bc7 <__alltraps>

00102309 <vector50>:
.globl vector50
vector50:
  pushl $0
  102309:	6a 00                	push   $0x0
  pushl $50
  10230b:	6a 32                	push   $0x32
  jmp __alltraps
  10230d:	e9 b5 08 00 00       	jmp    102bc7 <__alltraps>

00102312 <vector51>:
.globl vector51
vector51:
  pushl $0
  102312:	6a 00                	push   $0x0
  pushl $51
  102314:	6a 33                	push   $0x33
  jmp __alltraps
  102316:	e9 ac 08 00 00       	jmp    102bc7 <__alltraps>

0010231b <vector52>:
.globl vector52
vector52:
  pushl $0
  10231b:	6a 00                	push   $0x0
  pushl $52
  10231d:	6a 34                	push   $0x34
  jmp __alltraps
  10231f:	e9 a3 08 00 00       	jmp    102bc7 <__alltraps>

00102324 <vector53>:
.globl vector53
vector53:
  pushl $0
  102324:	6a 00                	push   $0x0
  pushl $53
  102326:	6a 35                	push   $0x35
  jmp __alltraps
  102328:	e9 9a 08 00 00       	jmp    102bc7 <__alltraps>

0010232d <vector54>:
.globl vector54
vector54:
  pushl $0
  10232d:	6a 00                	push   $0x0
  pushl $54
  10232f:	6a 36                	push   $0x36
  jmp __alltraps
  102331:	e9 91 08 00 00       	jmp    102bc7 <__alltraps>

00102336 <vector55>:
.globl vector55
vector55:
  pushl $0
  102336:	6a 00                	push   $0x0
  pushl $55
  102338:	6a 37                	push   $0x37
  jmp __alltraps
  10233a:	e9 88 08 00 00       	jmp    102bc7 <__alltraps>

0010233f <vector56>:
.globl vector56
vector56:
  pushl $0
  10233f:	6a 00                	push   $0x0
  pushl $56
  102341:	6a 38                	push   $0x38
  jmp __alltraps
  102343:	e9 7f 08 00 00       	jmp    102bc7 <__alltraps>

00102348 <vector57>:
.globl vector57
vector57:
  pushl $0
  102348:	6a 00                	push   $0x0
  pushl $57
  10234a:	6a 39                	push   $0x39
  jmp __alltraps
  10234c:	e9 76 08 00 00       	jmp    102bc7 <__alltraps>

00102351 <vector58>:
.globl vector58
vector58:
  pushl $0
  102351:	6a 00                	push   $0x0
  pushl $58
  102353:	6a 3a                	push   $0x3a
  jmp __alltraps
  102355:	e9 6d 08 00 00       	jmp    102bc7 <__alltraps>

0010235a <vector59>:
.globl vector59
vector59:
  pushl $0
  10235a:	6a 00                	push   $0x0
  pushl $59
  10235c:	6a 3b                	push   $0x3b
  jmp __alltraps
  10235e:	e9 64 08 00 00       	jmp    102bc7 <__alltraps>

00102363 <vector60>:
.globl vector60
vector60:
  pushl $0
  102363:	6a 00                	push   $0x0
  pushl $60
  102365:	6a 3c                	push   $0x3c
  jmp __alltraps
  102367:	e9 5b 08 00 00       	jmp    102bc7 <__alltraps>

0010236c <vector61>:
.globl vector61
vector61:
  pushl $0
  10236c:	6a 00                	push   $0x0
  pushl $61
  10236e:	6a 3d                	push   $0x3d
  jmp __alltraps
  102370:	e9 52 08 00 00       	jmp    102bc7 <__alltraps>

00102375 <vector62>:
.globl vector62
vector62:
  pushl $0
  102375:	6a 00                	push   $0x0
  pushl $62
  102377:	6a 3e                	push   $0x3e
  jmp __alltraps
  102379:	e9 49 08 00 00       	jmp    102bc7 <__alltraps>

0010237e <vector63>:
.globl vector63
vector63:
  pushl $0
  10237e:	6a 00                	push   $0x0
  pushl $63
  102380:	6a 3f                	push   $0x3f
  jmp __alltraps
  102382:	e9 40 08 00 00       	jmp    102bc7 <__alltraps>

00102387 <vector64>:
.globl vector64
vector64:
  pushl $0
  102387:	6a 00                	push   $0x0
  pushl $64
  102389:	6a 40                	push   $0x40
  jmp __alltraps
  10238b:	e9 37 08 00 00       	jmp    102bc7 <__alltraps>

00102390 <vector65>:
.globl vector65
vector65:
  pushl $0
  102390:	6a 00                	push   $0x0
  pushl $65
  102392:	6a 41                	push   $0x41
  jmp __alltraps
  102394:	e9 2e 08 00 00       	jmp    102bc7 <__alltraps>

00102399 <vector66>:
.globl vector66
vector66:
  pushl $0
  102399:	6a 00                	push   $0x0
  pushl $66
  10239b:	6a 42                	push   $0x42
  jmp __alltraps
  10239d:	e9 25 08 00 00       	jmp    102bc7 <__alltraps>

001023a2 <vector67>:
.globl vector67
vector67:
  pushl $0
  1023a2:	6a 00                	push   $0x0
  pushl $67
  1023a4:	6a 43                	push   $0x43
  jmp __alltraps
  1023a6:	e9 1c 08 00 00       	jmp    102bc7 <__alltraps>

001023ab <vector68>:
.globl vector68
vector68:
  pushl $0
  1023ab:	6a 00                	push   $0x0
  pushl $68
  1023ad:	6a 44                	push   $0x44
  jmp __alltraps
  1023af:	e9 13 08 00 00       	jmp    102bc7 <__alltraps>

001023b4 <vector69>:
.globl vector69
vector69:
  pushl $0
  1023b4:	6a 00                	push   $0x0
  pushl $69
  1023b6:	6a 45                	push   $0x45
  jmp __alltraps
  1023b8:	e9 0a 08 00 00       	jmp    102bc7 <__alltraps>

001023bd <vector70>:
.globl vector70
vector70:
  pushl $0
  1023bd:	6a 00                	push   $0x0
  pushl $70
  1023bf:	6a 46                	push   $0x46
  jmp __alltraps
  1023c1:	e9 01 08 00 00       	jmp    102bc7 <__alltraps>

001023c6 <vector71>:
.globl vector71
vector71:
  pushl $0
  1023c6:	6a 00                	push   $0x0
  pushl $71
  1023c8:	6a 47                	push   $0x47
  jmp __alltraps
  1023ca:	e9 f8 07 00 00       	jmp    102bc7 <__alltraps>

001023cf <vector72>:
.globl vector72
vector72:
  pushl $0
  1023cf:	6a 00                	push   $0x0
  pushl $72
  1023d1:	6a 48                	push   $0x48
  jmp __alltraps
  1023d3:	e9 ef 07 00 00       	jmp    102bc7 <__alltraps>

001023d8 <vector73>:
.globl vector73
vector73:
  pushl $0
  1023d8:	6a 00                	push   $0x0
  pushl $73
  1023da:	6a 49                	push   $0x49
  jmp __alltraps
  1023dc:	e9 e6 07 00 00       	jmp    102bc7 <__alltraps>

001023e1 <vector74>:
.globl vector74
vector74:
  pushl $0
  1023e1:	6a 00                	push   $0x0
  pushl $74
  1023e3:	6a 4a                	push   $0x4a
  jmp __alltraps
  1023e5:	e9 dd 07 00 00       	jmp    102bc7 <__alltraps>

001023ea <vector75>:
.globl vector75
vector75:
  pushl $0
  1023ea:	6a 00                	push   $0x0
  pushl $75
  1023ec:	6a 4b                	push   $0x4b
  jmp __alltraps
  1023ee:	e9 d4 07 00 00       	jmp    102bc7 <__alltraps>

001023f3 <vector76>:
.globl vector76
vector76:
  pushl $0
  1023f3:	6a 00                	push   $0x0
  pushl $76
  1023f5:	6a 4c                	push   $0x4c
  jmp __alltraps
  1023f7:	e9 cb 07 00 00       	jmp    102bc7 <__alltraps>

001023fc <vector77>:
.globl vector77
vector77:
  pushl $0
  1023fc:	6a 00                	push   $0x0
  pushl $77
  1023fe:	6a 4d                	push   $0x4d
  jmp __alltraps
  102400:	e9 c2 07 00 00       	jmp    102bc7 <__alltraps>

00102405 <vector78>:
.globl vector78
vector78:
  pushl $0
  102405:	6a 00                	push   $0x0
  pushl $78
  102407:	6a 4e                	push   $0x4e
  jmp __alltraps
  102409:	e9 b9 07 00 00       	jmp    102bc7 <__alltraps>

0010240e <vector79>:
.globl vector79
vector79:
  pushl $0
  10240e:	6a 00                	push   $0x0
  pushl $79
  102410:	6a 4f                	push   $0x4f
  jmp __alltraps
  102412:	e9 b0 07 00 00       	jmp    102bc7 <__alltraps>

00102417 <vector80>:
.globl vector80
vector80:
  pushl $0
  102417:	6a 00                	push   $0x0
  pushl $80
  102419:	6a 50                	push   $0x50
  jmp __alltraps
  10241b:	e9 a7 07 00 00       	jmp    102bc7 <__alltraps>

00102420 <vector81>:
.globl vector81
vector81:
  pushl $0
  102420:	6a 00                	push   $0x0
  pushl $81
  102422:	6a 51                	push   $0x51
  jmp __alltraps
  102424:	e9 9e 07 00 00       	jmp    102bc7 <__alltraps>

00102429 <vector82>:
.globl vector82
vector82:
  pushl $0
  102429:	6a 00                	push   $0x0
  pushl $82
  10242b:	6a 52                	push   $0x52
  jmp __alltraps
  10242d:	e9 95 07 00 00       	jmp    102bc7 <__alltraps>

00102432 <vector83>:
.globl vector83
vector83:
  pushl $0
  102432:	6a 00                	push   $0x0
  pushl $83
  102434:	6a 53                	push   $0x53
  jmp __alltraps
  102436:	e9 8c 07 00 00       	jmp    102bc7 <__alltraps>

0010243b <vector84>:
.globl vector84
vector84:
  pushl $0
  10243b:	6a 00                	push   $0x0
  pushl $84
  10243d:	6a 54                	push   $0x54
  jmp __alltraps
  10243f:	e9 83 07 00 00       	jmp    102bc7 <__alltraps>

00102444 <vector85>:
.globl vector85
vector85:
  pushl $0
  102444:	6a 00                	push   $0x0
  pushl $85
  102446:	6a 55                	push   $0x55
  jmp __alltraps
  102448:	e9 7a 07 00 00       	jmp    102bc7 <__alltraps>

0010244d <vector86>:
.globl vector86
vector86:
  pushl $0
  10244d:	6a 00                	push   $0x0
  pushl $86
  10244f:	6a 56                	push   $0x56
  jmp __alltraps
  102451:	e9 71 07 00 00       	jmp    102bc7 <__alltraps>

00102456 <vector87>:
.globl vector87
vector87:
  pushl $0
  102456:	6a 00                	push   $0x0
  pushl $87
  102458:	6a 57                	push   $0x57
  jmp __alltraps
  10245a:	e9 68 07 00 00       	jmp    102bc7 <__alltraps>

0010245f <vector88>:
.globl vector88
vector88:
  pushl $0
  10245f:	6a 00                	push   $0x0
  pushl $88
  102461:	6a 58                	push   $0x58
  jmp __alltraps
  102463:	e9 5f 07 00 00       	jmp    102bc7 <__alltraps>

00102468 <vector89>:
.globl vector89
vector89:
  pushl $0
  102468:	6a 00                	push   $0x0
  pushl $89
  10246a:	6a 59                	push   $0x59
  jmp __alltraps
  10246c:	e9 56 07 00 00       	jmp    102bc7 <__alltraps>

00102471 <vector90>:
.globl vector90
vector90:
  pushl $0
  102471:	6a 00                	push   $0x0
  pushl $90
  102473:	6a 5a                	push   $0x5a
  jmp __alltraps
  102475:	e9 4d 07 00 00       	jmp    102bc7 <__alltraps>

0010247a <vector91>:
.globl vector91
vector91:
  pushl $0
  10247a:	6a 00                	push   $0x0
  pushl $91
  10247c:	6a 5b                	push   $0x5b
  jmp __alltraps
  10247e:	e9 44 07 00 00       	jmp    102bc7 <__alltraps>

00102483 <vector92>:
.globl vector92
vector92:
  pushl $0
  102483:	6a 00                	push   $0x0
  pushl $92
  102485:	6a 5c                	push   $0x5c
  jmp __alltraps
  102487:	e9 3b 07 00 00       	jmp    102bc7 <__alltraps>

0010248c <vector93>:
.globl vector93
vector93:
  pushl $0
  10248c:	6a 00                	push   $0x0
  pushl $93
  10248e:	6a 5d                	push   $0x5d
  jmp __alltraps
  102490:	e9 32 07 00 00       	jmp    102bc7 <__alltraps>

00102495 <vector94>:
.globl vector94
vector94:
  pushl $0
  102495:	6a 00                	push   $0x0
  pushl $94
  102497:	6a 5e                	push   $0x5e
  jmp __alltraps
  102499:	e9 29 07 00 00       	jmp    102bc7 <__alltraps>

0010249e <vector95>:
.globl vector95
vector95:
  pushl $0
  10249e:	6a 00                	push   $0x0
  pushl $95
  1024a0:	6a 5f                	push   $0x5f
  jmp __alltraps
  1024a2:	e9 20 07 00 00       	jmp    102bc7 <__alltraps>

001024a7 <vector96>:
.globl vector96
vector96:
  pushl $0
  1024a7:	6a 00                	push   $0x0
  pushl $96
  1024a9:	6a 60                	push   $0x60
  jmp __alltraps
  1024ab:	e9 17 07 00 00       	jmp    102bc7 <__alltraps>

001024b0 <vector97>:
.globl vector97
vector97:
  pushl $0
  1024b0:	6a 00                	push   $0x0
  pushl $97
  1024b2:	6a 61                	push   $0x61
  jmp __alltraps
  1024b4:	e9 0e 07 00 00       	jmp    102bc7 <__alltraps>

001024b9 <vector98>:
.globl vector98
vector98:
  pushl $0
  1024b9:	6a 00                	push   $0x0
  pushl $98
  1024bb:	6a 62                	push   $0x62
  jmp __alltraps
  1024bd:	e9 05 07 00 00       	jmp    102bc7 <__alltraps>

001024c2 <vector99>:
.globl vector99
vector99:
  pushl $0
  1024c2:	6a 00                	push   $0x0
  pushl $99
  1024c4:	6a 63                	push   $0x63
  jmp __alltraps
  1024c6:	e9 fc 06 00 00       	jmp    102bc7 <__alltraps>

001024cb <vector100>:
.globl vector100
vector100:
  pushl $0
  1024cb:	6a 00                	push   $0x0
  pushl $100
  1024cd:	6a 64                	push   $0x64
  jmp __alltraps
  1024cf:	e9 f3 06 00 00       	jmp    102bc7 <__alltraps>

001024d4 <vector101>:
.globl vector101
vector101:
  pushl $0
  1024d4:	6a 00                	push   $0x0
  pushl $101
  1024d6:	6a 65                	push   $0x65
  jmp __alltraps
  1024d8:	e9 ea 06 00 00       	jmp    102bc7 <__alltraps>

001024dd <vector102>:
.globl vector102
vector102:
  pushl $0
  1024dd:	6a 00                	push   $0x0
  pushl $102
  1024df:	6a 66                	push   $0x66
  jmp __alltraps
  1024e1:	e9 e1 06 00 00       	jmp    102bc7 <__alltraps>

001024e6 <vector103>:
.globl vector103
vector103:
  pushl $0
  1024e6:	6a 00                	push   $0x0
  pushl $103
  1024e8:	6a 67                	push   $0x67
  jmp __alltraps
  1024ea:	e9 d8 06 00 00       	jmp    102bc7 <__alltraps>

001024ef <vector104>:
.globl vector104
vector104:
  pushl $0
  1024ef:	6a 00                	push   $0x0
  pushl $104
  1024f1:	6a 68                	push   $0x68
  jmp __alltraps
  1024f3:	e9 cf 06 00 00       	jmp    102bc7 <__alltraps>

001024f8 <vector105>:
.globl vector105
vector105:
  pushl $0
  1024f8:	6a 00                	push   $0x0
  pushl $105
  1024fa:	6a 69                	push   $0x69
  jmp __alltraps
  1024fc:	e9 c6 06 00 00       	jmp    102bc7 <__alltraps>

00102501 <vector106>:
.globl vector106
vector106:
  pushl $0
  102501:	6a 00                	push   $0x0
  pushl $106
  102503:	6a 6a                	push   $0x6a
  jmp __alltraps
  102505:	e9 bd 06 00 00       	jmp    102bc7 <__alltraps>

0010250a <vector107>:
.globl vector107
vector107:
  pushl $0
  10250a:	6a 00                	push   $0x0
  pushl $107
  10250c:	6a 6b                	push   $0x6b
  jmp __alltraps
  10250e:	e9 b4 06 00 00       	jmp    102bc7 <__alltraps>

00102513 <vector108>:
.globl vector108
vector108:
  pushl $0
  102513:	6a 00                	push   $0x0
  pushl $108
  102515:	6a 6c                	push   $0x6c
  jmp __alltraps
  102517:	e9 ab 06 00 00       	jmp    102bc7 <__alltraps>

0010251c <vector109>:
.globl vector109
vector109:
  pushl $0
  10251c:	6a 00                	push   $0x0
  pushl $109
  10251e:	6a 6d                	push   $0x6d
  jmp __alltraps
  102520:	e9 a2 06 00 00       	jmp    102bc7 <__alltraps>

00102525 <vector110>:
.globl vector110
vector110:
  pushl $0
  102525:	6a 00                	push   $0x0
  pushl $110
  102527:	6a 6e                	push   $0x6e
  jmp __alltraps
  102529:	e9 99 06 00 00       	jmp    102bc7 <__alltraps>

0010252e <vector111>:
.globl vector111
vector111:
  pushl $0
  10252e:	6a 00                	push   $0x0
  pushl $111
  102530:	6a 6f                	push   $0x6f
  jmp __alltraps
  102532:	e9 90 06 00 00       	jmp    102bc7 <__alltraps>

00102537 <vector112>:
.globl vector112
vector112:
  pushl $0
  102537:	6a 00                	push   $0x0
  pushl $112
  102539:	6a 70                	push   $0x70
  jmp __alltraps
  10253b:	e9 87 06 00 00       	jmp    102bc7 <__alltraps>

00102540 <vector113>:
.globl vector113
vector113:
  pushl $0
  102540:	6a 00                	push   $0x0
  pushl $113
  102542:	6a 71                	push   $0x71
  jmp __alltraps
  102544:	e9 7e 06 00 00       	jmp    102bc7 <__alltraps>

00102549 <vector114>:
.globl vector114
vector114:
  pushl $0
  102549:	6a 00                	push   $0x0
  pushl $114
  10254b:	6a 72                	push   $0x72
  jmp __alltraps
  10254d:	e9 75 06 00 00       	jmp    102bc7 <__alltraps>

00102552 <vector115>:
.globl vector115
vector115:
  pushl $0
  102552:	6a 00                	push   $0x0
  pushl $115
  102554:	6a 73                	push   $0x73
  jmp __alltraps
  102556:	e9 6c 06 00 00       	jmp    102bc7 <__alltraps>

0010255b <vector116>:
.globl vector116
vector116:
  pushl $0
  10255b:	6a 00                	push   $0x0
  pushl $116
  10255d:	6a 74                	push   $0x74
  jmp __alltraps
  10255f:	e9 63 06 00 00       	jmp    102bc7 <__alltraps>

00102564 <vector117>:
.globl vector117
vector117:
  pushl $0
  102564:	6a 00                	push   $0x0
  pushl $117
  102566:	6a 75                	push   $0x75
  jmp __alltraps
  102568:	e9 5a 06 00 00       	jmp    102bc7 <__alltraps>

0010256d <vector118>:
.globl vector118
vector118:
  pushl $0
  10256d:	6a 00                	push   $0x0
  pushl $118
  10256f:	6a 76                	push   $0x76
  jmp __alltraps
  102571:	e9 51 06 00 00       	jmp    102bc7 <__alltraps>

00102576 <vector119>:
.globl vector119
vector119:
  pushl $0
  102576:	6a 00                	push   $0x0
  pushl $119
  102578:	6a 77                	push   $0x77
  jmp __alltraps
  10257a:	e9 48 06 00 00       	jmp    102bc7 <__alltraps>

0010257f <vector120>:
.globl vector120
vector120:
  pushl $0
  10257f:	6a 00                	push   $0x0
  pushl $120
  102581:	6a 78                	push   $0x78
  jmp __alltraps
  102583:	e9 3f 06 00 00       	jmp    102bc7 <__alltraps>

00102588 <vector121>:
.globl vector121
vector121:
  pushl $0
  102588:	6a 00                	push   $0x0
  pushl $121
  10258a:	6a 79                	push   $0x79
  jmp __alltraps
  10258c:	e9 36 06 00 00       	jmp    102bc7 <__alltraps>

00102591 <vector122>:
.globl vector122
vector122:
  pushl $0
  102591:	6a 00                	push   $0x0
  pushl $122
  102593:	6a 7a                	push   $0x7a
  jmp __alltraps
  102595:	e9 2d 06 00 00       	jmp    102bc7 <__alltraps>

0010259a <vector123>:
.globl vector123
vector123:
  pushl $0
  10259a:	6a 00                	push   $0x0
  pushl $123
  10259c:	6a 7b                	push   $0x7b
  jmp __alltraps
  10259e:	e9 24 06 00 00       	jmp    102bc7 <__alltraps>

001025a3 <vector124>:
.globl vector124
vector124:
  pushl $0
  1025a3:	6a 00                	push   $0x0
  pushl $124
  1025a5:	6a 7c                	push   $0x7c
  jmp __alltraps
  1025a7:	e9 1b 06 00 00       	jmp    102bc7 <__alltraps>

001025ac <vector125>:
.globl vector125
vector125:
  pushl $0
  1025ac:	6a 00                	push   $0x0
  pushl $125
  1025ae:	6a 7d                	push   $0x7d
  jmp __alltraps
  1025b0:	e9 12 06 00 00       	jmp    102bc7 <__alltraps>

001025b5 <vector126>:
.globl vector126
vector126:
  pushl $0
  1025b5:	6a 00                	push   $0x0
  pushl $126
  1025b7:	6a 7e                	push   $0x7e
  jmp __alltraps
  1025b9:	e9 09 06 00 00       	jmp    102bc7 <__alltraps>

001025be <vector127>:
.globl vector127
vector127:
  pushl $0
  1025be:	6a 00                	push   $0x0
  pushl $127
  1025c0:	6a 7f                	push   $0x7f
  jmp __alltraps
  1025c2:	e9 00 06 00 00       	jmp    102bc7 <__alltraps>

001025c7 <vector128>:
.globl vector128
vector128:
  pushl $0
  1025c7:	6a 00                	push   $0x0
  pushl $128
  1025c9:	68 80 00 00 00       	push   $0x80
  jmp __alltraps
  1025ce:	e9 f4 05 00 00       	jmp    102bc7 <__alltraps>

001025d3 <vector129>:
.globl vector129
vector129:
  pushl $0
  1025d3:	6a 00                	push   $0x0
  pushl $129
  1025d5:	68 81 00 00 00       	push   $0x81
  jmp __alltraps
  1025da:	e9 e8 05 00 00       	jmp    102bc7 <__alltraps>

001025df <vector130>:
.globl vector130
vector130:
  pushl $0
  1025df:	6a 00                	push   $0x0
  pushl $130
  1025e1:	68 82 00 00 00       	push   $0x82
  jmp __alltraps
  1025e6:	e9 dc 05 00 00       	jmp    102bc7 <__alltraps>

001025eb <vector131>:
.globl vector131
vector131:
  pushl $0
  1025eb:	6a 00                	push   $0x0
  pushl $131
  1025ed:	68 83 00 00 00       	push   $0x83
  jmp __alltraps
  1025f2:	e9 d0 05 00 00       	jmp    102bc7 <__alltraps>

001025f7 <vector132>:
.globl vector132
vector132:
  pushl $0
  1025f7:	6a 00                	push   $0x0
  pushl $132
  1025f9:	68 84 00 00 00       	push   $0x84
  jmp __alltraps
  1025fe:	e9 c4 05 00 00       	jmp    102bc7 <__alltraps>

00102603 <vector133>:
.globl vector133
vector133:
  pushl $0
  102603:	6a 00                	push   $0x0
  pushl $133
  102605:	68 85 00 00 00       	push   $0x85
  jmp __alltraps
  10260a:	e9 b8 05 00 00       	jmp    102bc7 <__alltraps>

0010260f <vector134>:
.globl vector134
vector134:
  pushl $0
  10260f:	6a 00                	push   $0x0
  pushl $134
  102611:	68 86 00 00 00       	push   $0x86
  jmp __alltraps
  102616:	e9 ac 05 00 00       	jmp    102bc7 <__alltraps>

0010261b <vector135>:
.globl vector135
vector135:
  pushl $0
  10261b:	6a 00                	push   $0x0
  pushl $135
  10261d:	68 87 00 00 00       	push   $0x87
  jmp __alltraps
  102622:	e9 a0 05 00 00       	jmp    102bc7 <__alltraps>

00102627 <vector136>:
.globl vector136
vector136:
  pushl $0
  102627:	6a 00                	push   $0x0
  pushl $136
  102629:	68 88 00 00 00       	push   $0x88
  jmp __alltraps
  10262e:	e9 94 05 00 00       	jmp    102bc7 <__alltraps>

00102633 <vector137>:
.globl vector137
vector137:
  pushl $0
  102633:	6a 00                	push   $0x0
  pushl $137
  102635:	68 89 00 00 00       	push   $0x89
  jmp __alltraps
  10263a:	e9 88 05 00 00       	jmp    102bc7 <__alltraps>

0010263f <vector138>:
.globl vector138
vector138:
  pushl $0
  10263f:	6a 00                	push   $0x0
  pushl $138
  102641:	68 8a 00 00 00       	push   $0x8a
  jmp __alltraps
  102646:	e9 7c 05 00 00       	jmp    102bc7 <__alltraps>

0010264b <vector139>:
.globl vector139
vector139:
  pushl $0
  10264b:	6a 00                	push   $0x0
  pushl $139
  10264d:	68 8b 00 00 00       	push   $0x8b
  jmp __alltraps
  102652:	e9 70 05 00 00       	jmp    102bc7 <__alltraps>

00102657 <vector140>:
.globl vector140
vector140:
  pushl $0
  102657:	6a 00                	push   $0x0
  pushl $140
  102659:	68 8c 00 00 00       	push   $0x8c
  jmp __alltraps
  10265e:	e9 64 05 00 00       	jmp    102bc7 <__alltraps>

00102663 <vector141>:
.globl vector141
vector141:
  pushl $0
  102663:	6a 00                	push   $0x0
  pushl $141
  102665:	68 8d 00 00 00       	push   $0x8d
  jmp __alltraps
  10266a:	e9 58 05 00 00       	jmp    102bc7 <__alltraps>

0010266f <vector142>:
.globl vector142
vector142:
  pushl $0
  10266f:	6a 00                	push   $0x0
  pushl $142
  102671:	68 8e 00 00 00       	push   $0x8e
  jmp __alltraps
  102676:	e9 4c 05 00 00       	jmp    102bc7 <__alltraps>

0010267b <vector143>:
.globl vector143
vector143:
  pushl $0
  10267b:	6a 00                	push   $0x0
  pushl $143
  10267d:	68 8f 00 00 00       	push   $0x8f
  jmp __alltraps
  102682:	e9 40 05 00 00       	jmp    102bc7 <__alltraps>

00102687 <vector144>:
.globl vector144
vector144:
  pushl $0
  102687:	6a 00                	push   $0x0
  pushl $144
  102689:	68 90 00 00 00       	push   $0x90
  jmp __alltraps
  10268e:	e9 34 05 00 00       	jmp    102bc7 <__alltraps>

00102693 <vector145>:
.globl vector145
vector145:
  pushl $0
  102693:	6a 00                	push   $0x0
  pushl $145
  102695:	68 91 00 00 00       	push   $0x91
  jmp __alltraps
  10269a:	e9 28 05 00 00       	jmp    102bc7 <__alltraps>

0010269f <vector146>:
.globl vector146
vector146:
  pushl $0
  10269f:	6a 00                	push   $0x0
  pushl $146
  1026a1:	68 92 00 00 00       	push   $0x92
  jmp __alltraps
  1026a6:	e9 1c 05 00 00       	jmp    102bc7 <__alltraps>

001026ab <vector147>:
.globl vector147
vector147:
  pushl $0
  1026ab:	6a 00                	push   $0x0
  pushl $147
  1026ad:	68 93 00 00 00       	push   $0x93
  jmp __alltraps
  1026b2:	e9 10 05 00 00       	jmp    102bc7 <__alltraps>

001026b7 <vector148>:
.globl vector148
vector148:
  pushl $0
  1026b7:	6a 00                	push   $0x0
  pushl $148
  1026b9:	68 94 00 00 00       	push   $0x94
  jmp __alltraps
  1026be:	e9 04 05 00 00       	jmp    102bc7 <__alltraps>

001026c3 <vector149>:
.globl vector149
vector149:
  pushl $0
  1026c3:	6a 00                	push   $0x0
  pushl $149
  1026c5:	68 95 00 00 00       	push   $0x95
  jmp __alltraps
  1026ca:	e9 f8 04 00 00       	jmp    102bc7 <__alltraps>

001026cf <vector150>:
.globl vector150
vector150:
  pushl $0
  1026cf:	6a 00                	push   $0x0
  pushl $150
  1026d1:	68 96 00 00 00       	push   $0x96
  jmp __alltraps
  1026d6:	e9 ec 04 00 00       	jmp    102bc7 <__alltraps>

001026db <vector151>:
.globl vector151
vector151:
  pushl $0
  1026db:	6a 00                	push   $0x0
  pushl $151
  1026dd:	68 97 00 00 00       	push   $0x97
  jmp __alltraps
  1026e2:	e9 e0 04 00 00       	jmp    102bc7 <__alltraps>

001026e7 <vector152>:
.globl vector152
vector152:
  pushl $0
  1026e7:	6a 00                	push   $0x0
  pushl $152
  1026e9:	68 98 00 00 00       	push   $0x98
  jmp __alltraps
  1026ee:	e9 d4 04 00 00       	jmp    102bc7 <__alltraps>

001026f3 <vector153>:
.globl vector153
vector153:
  pushl $0
  1026f3:	6a 00                	push   $0x0
  pushl $153
  1026f5:	68 99 00 00 00       	push   $0x99
  jmp __alltraps
  1026fa:	e9 c8 04 00 00       	jmp    102bc7 <__alltraps>

001026ff <vector154>:
.globl vector154
vector154:
  pushl $0
  1026ff:	6a 00                	push   $0x0
  pushl $154
  102701:	68 9a 00 00 00       	push   $0x9a
  jmp __alltraps
  102706:	e9 bc 04 00 00       	jmp    102bc7 <__alltraps>

0010270b <vector155>:
.globl vector155
vector155:
  pushl $0
  10270b:	6a 00                	push   $0x0
  pushl $155
  10270d:	68 9b 00 00 00       	push   $0x9b
  jmp __alltraps
  102712:	e9 b0 04 00 00       	jmp    102bc7 <__alltraps>

00102717 <vector156>:
.globl vector156
vector156:
  pushl $0
  102717:	6a 00                	push   $0x0
  pushl $156
  102719:	68 9c 00 00 00       	push   $0x9c
  jmp __alltraps
  10271e:	e9 a4 04 00 00       	jmp    102bc7 <__alltraps>

00102723 <vector157>:
.globl vector157
vector157:
  pushl $0
  102723:	6a 00                	push   $0x0
  pushl $157
  102725:	68 9d 00 00 00       	push   $0x9d
  jmp __alltraps
  10272a:	e9 98 04 00 00       	jmp    102bc7 <__alltraps>

0010272f <vector158>:
.globl vector158
vector158:
  pushl $0
  10272f:	6a 00                	push   $0x0
  pushl $158
  102731:	68 9e 00 00 00       	push   $0x9e
  jmp __alltraps
  102736:	e9 8c 04 00 00       	jmp    102bc7 <__alltraps>

0010273b <vector159>:
.globl vector159
vector159:
  pushl $0
  10273b:	6a 00                	push   $0x0
  pushl $159
  10273d:	68 9f 00 00 00       	push   $0x9f
  jmp __alltraps
  102742:	e9 80 04 00 00       	jmp    102bc7 <__alltraps>

00102747 <vector160>:
.globl vector160
vector160:
  pushl $0
  102747:	6a 00                	push   $0x0
  pushl $160
  102749:	68 a0 00 00 00       	push   $0xa0
  jmp __alltraps
  10274e:	e9 74 04 00 00       	jmp    102bc7 <__alltraps>

00102753 <vector161>:
.globl vector161
vector161:
  pushl $0
  102753:	6a 00                	push   $0x0
  pushl $161
  102755:	68 a1 00 00 00       	push   $0xa1
  jmp __alltraps
  10275a:	e9 68 04 00 00       	jmp    102bc7 <__alltraps>

0010275f <vector162>:
.globl vector162
vector162:
  pushl $0
  10275f:	6a 00                	push   $0x0
  pushl $162
  102761:	68 a2 00 00 00       	push   $0xa2
  jmp __alltraps
  102766:	e9 5c 04 00 00       	jmp    102bc7 <__alltraps>

0010276b <vector163>:
.globl vector163
vector163:
  pushl $0
  10276b:	6a 00                	push   $0x0
  pushl $163
  10276d:	68 a3 00 00 00       	push   $0xa3
  jmp __alltraps
  102772:	e9 50 04 00 00       	jmp    102bc7 <__alltraps>

00102777 <vector164>:
.globl vector164
vector164:
  pushl $0
  102777:	6a 00                	push   $0x0
  pushl $164
  102779:	68 a4 00 00 00       	push   $0xa4
  jmp __alltraps
  10277e:	e9 44 04 00 00       	jmp    102bc7 <__alltraps>

00102783 <vector165>:
.globl vector165
vector165:
  pushl $0
  102783:	6a 00                	push   $0x0
  pushl $165
  102785:	68 a5 00 00 00       	push   $0xa5
  jmp __alltraps
  10278a:	e9 38 04 00 00       	jmp    102bc7 <__alltraps>

0010278f <vector166>:
.globl vector166
vector166:
  pushl $0
  10278f:	6a 00                	push   $0x0
  pushl $166
  102791:	68 a6 00 00 00       	push   $0xa6
  jmp __alltraps
  102796:	e9 2c 04 00 00       	jmp    102bc7 <__alltraps>

0010279b <vector167>:
.globl vector167
vector167:
  pushl $0
  10279b:	6a 00                	push   $0x0
  pushl $167
  10279d:	68 a7 00 00 00       	push   $0xa7
  jmp __alltraps
  1027a2:	e9 20 04 00 00       	jmp    102bc7 <__alltraps>

001027a7 <vector168>:
.globl vector168
vector168:
  pushl $0
  1027a7:	6a 00                	push   $0x0
  pushl $168
  1027a9:	68 a8 00 00 00       	push   $0xa8
  jmp __alltraps
  1027ae:	e9 14 04 00 00       	jmp    102bc7 <__alltraps>

001027b3 <vector169>:
.globl vector169
vector169:
  pushl $0
  1027b3:	6a 00                	push   $0x0
  pushl $169
  1027b5:	68 a9 00 00 00       	push   $0xa9
  jmp __alltraps
  1027ba:	e9 08 04 00 00       	jmp    102bc7 <__alltraps>

001027bf <vector170>:
.globl vector170
vector170:
  pushl $0
  1027bf:	6a 00                	push   $0x0
  pushl $170
  1027c1:	68 aa 00 00 00       	push   $0xaa
  jmp __alltraps
  1027c6:	e9 fc 03 00 00       	jmp    102bc7 <__alltraps>

001027cb <vector171>:
.globl vector171
vector171:
  pushl $0
  1027cb:	6a 00                	push   $0x0
  pushl $171
  1027cd:	68 ab 00 00 00       	push   $0xab
  jmp __alltraps
  1027d2:	e9 f0 03 00 00       	jmp    102bc7 <__alltraps>

001027d7 <vector172>:
.globl vector172
vector172:
  pushl $0
  1027d7:	6a 00                	push   $0x0
  pushl $172
  1027d9:	68 ac 00 00 00       	push   $0xac
  jmp __alltraps
  1027de:	e9 e4 03 00 00       	jmp    102bc7 <__alltraps>

001027e3 <vector173>:
.globl vector173
vector173:
  pushl $0
  1027e3:	6a 00                	push   $0x0
  pushl $173
  1027e5:	68 ad 00 00 00       	push   $0xad
  jmp __alltraps
  1027ea:	e9 d8 03 00 00       	jmp    102bc7 <__alltraps>

001027ef <vector174>:
.globl vector174
vector174:
  pushl $0
  1027ef:	6a 00                	push   $0x0
  pushl $174
  1027f1:	68 ae 00 00 00       	push   $0xae
  jmp __alltraps
  1027f6:	e9 cc 03 00 00       	jmp    102bc7 <__alltraps>

001027fb <vector175>:
.globl vector175
vector175:
  pushl $0
  1027fb:	6a 00                	push   $0x0
  pushl $175
  1027fd:	68 af 00 00 00       	push   $0xaf
  jmp __alltraps
  102802:	e9 c0 03 00 00       	jmp    102bc7 <__alltraps>

00102807 <vector176>:
.globl vector176
vector176:
  pushl $0
  102807:	6a 00                	push   $0x0
  pushl $176
  102809:	68 b0 00 00 00       	push   $0xb0
  jmp __alltraps
  10280e:	e9 b4 03 00 00       	jmp    102bc7 <__alltraps>

00102813 <vector177>:
.globl vector177
vector177:
  pushl $0
  102813:	6a 00                	push   $0x0
  pushl $177
  102815:	68 b1 00 00 00       	push   $0xb1
  jmp __alltraps
  10281a:	e9 a8 03 00 00       	jmp    102bc7 <__alltraps>

0010281f <vector178>:
.globl vector178
vector178:
  pushl $0
  10281f:	6a 00                	push   $0x0
  pushl $178
  102821:	68 b2 00 00 00       	push   $0xb2
  jmp __alltraps
  102826:	e9 9c 03 00 00       	jmp    102bc7 <__alltraps>

0010282b <vector179>:
.globl vector179
vector179:
  pushl $0
  10282b:	6a 00                	push   $0x0
  pushl $179
  10282d:	68 b3 00 00 00       	push   $0xb3
  jmp __alltraps
  102832:	e9 90 03 00 00       	jmp    102bc7 <__alltraps>

00102837 <vector180>:
.globl vector180
vector180:
  pushl $0
  102837:	6a 00                	push   $0x0
  pushl $180
  102839:	68 b4 00 00 00       	push   $0xb4
  jmp __alltraps
  10283e:	e9 84 03 00 00       	jmp    102bc7 <__alltraps>

00102843 <vector181>:
.globl vector181
vector181:
  pushl $0
  102843:	6a 00                	push   $0x0
  pushl $181
  102845:	68 b5 00 00 00       	push   $0xb5
  jmp __alltraps
  10284a:	e9 78 03 00 00       	jmp    102bc7 <__alltraps>

0010284f <vector182>:
.globl vector182
vector182:
  pushl $0
  10284f:	6a 00                	push   $0x0
  pushl $182
  102851:	68 b6 00 00 00       	push   $0xb6
  jmp __alltraps
  102856:	e9 6c 03 00 00       	jmp    102bc7 <__alltraps>

0010285b <vector183>:
.globl vector183
vector183:
  pushl $0
  10285b:	6a 00                	push   $0x0
  pushl $183
  10285d:	68 b7 00 00 00       	push   $0xb7
  jmp __alltraps
  102862:	e9 60 03 00 00       	jmp    102bc7 <__alltraps>

00102867 <vector184>:
.globl vector184
vector184:
  pushl $0
  102867:	6a 00                	push   $0x0
  pushl $184
  102869:	68 b8 00 00 00       	push   $0xb8
  jmp __alltraps
  10286e:	e9 54 03 00 00       	jmp    102bc7 <__alltraps>

00102873 <vector185>:
.globl vector185
vector185:
  pushl $0
  102873:	6a 00                	push   $0x0
  pushl $185
  102875:	68 b9 00 00 00       	push   $0xb9
  jmp __alltraps
  10287a:	e9 48 03 00 00       	jmp    102bc7 <__alltraps>

0010287f <vector186>:
.globl vector186
vector186:
  pushl $0
  10287f:	6a 00                	push   $0x0
  pushl $186
  102881:	68 ba 00 00 00       	push   $0xba
  jmp __alltraps
  102886:	e9 3c 03 00 00       	jmp    102bc7 <__alltraps>

0010288b <vector187>:
.globl vector187
vector187:
  pushl $0
  10288b:	6a 00                	push   $0x0
  pushl $187
  10288d:	68 bb 00 00 00       	push   $0xbb
  jmp __alltraps
  102892:	e9 30 03 00 00       	jmp    102bc7 <__alltraps>

00102897 <vector188>:
.globl vector188
vector188:
  pushl $0
  102897:	6a 00                	push   $0x0
  pushl $188
  102899:	68 bc 00 00 00       	push   $0xbc
  jmp __alltraps
  10289e:	e9 24 03 00 00       	jmp    102bc7 <__alltraps>

001028a3 <vector189>:
.globl vector189
vector189:
  pushl $0
  1028a3:	6a 00                	push   $0x0
  pushl $189
  1028a5:	68 bd 00 00 00       	push   $0xbd
  jmp __alltraps
  1028aa:	e9 18 03 00 00       	jmp    102bc7 <__alltraps>

001028af <vector190>:
.globl vector190
vector190:
  pushl $0
  1028af:	6a 00                	push   $0x0
  pushl $190
  1028b1:	68 be 00 00 00       	push   $0xbe
  jmp __alltraps
  1028b6:	e9 0c 03 00 00       	jmp    102bc7 <__alltraps>

001028bb <vector191>:
.globl vector191
vector191:
  pushl $0
  1028bb:	6a 00                	push   $0x0
  pushl $191
  1028bd:	68 bf 00 00 00       	push   $0xbf
  jmp __alltraps
  1028c2:	e9 00 03 00 00       	jmp    102bc7 <__alltraps>

001028c7 <vector192>:
.globl vector192
vector192:
  pushl $0
  1028c7:	6a 00                	push   $0x0
  pushl $192
  1028c9:	68 c0 00 00 00       	push   $0xc0
  jmp __alltraps
  1028ce:	e9 f4 02 00 00       	jmp    102bc7 <__alltraps>

001028d3 <vector193>:
.globl vector193
vector193:
  pushl $0
  1028d3:	6a 00                	push   $0x0
  pushl $193
  1028d5:	68 c1 00 00 00       	push   $0xc1
  jmp __alltraps
  1028da:	e9 e8 02 00 00       	jmp    102bc7 <__alltraps>

001028df <vector194>:
.globl vector194
vector194:
  pushl $0
  1028df:	6a 00                	push   $0x0
  pushl $194
  1028e1:	68 c2 00 00 00       	push   $0xc2
  jmp __alltraps
  1028e6:	e9 dc 02 00 00       	jmp    102bc7 <__alltraps>

001028eb <vector195>:
.globl vector195
vector195:
  pushl $0
  1028eb:	6a 00                	push   $0x0
  pushl $195
  1028ed:	68 c3 00 00 00       	push   $0xc3
  jmp __alltraps
  1028f2:	e9 d0 02 00 00       	jmp    102bc7 <__alltraps>

001028f7 <vector196>:
.globl vector196
vector196:
  pushl $0
  1028f7:	6a 00                	push   $0x0
  pushl $196
  1028f9:	68 c4 00 00 00       	push   $0xc4
  jmp __alltraps
  1028fe:	e9 c4 02 00 00       	jmp    102bc7 <__alltraps>

00102903 <vector197>:
.globl vector197
vector197:
  pushl $0
  102903:	6a 00                	push   $0x0
  pushl $197
  102905:	68 c5 00 00 00       	push   $0xc5
  jmp __alltraps
  10290a:	e9 b8 02 00 00       	jmp    102bc7 <__alltraps>

0010290f <vector198>:
.globl vector198
vector198:
  pushl $0
  10290f:	6a 00                	push   $0x0
  pushl $198
  102911:	68 c6 00 00 00       	push   $0xc6
  jmp __alltraps
  102916:	e9 ac 02 00 00       	jmp    102bc7 <__alltraps>

0010291b <vector199>:
.globl vector199
vector199:
  pushl $0
  10291b:	6a 00                	push   $0x0
  pushl $199
  10291d:	68 c7 00 00 00       	push   $0xc7
  jmp __alltraps
  102922:	e9 a0 02 00 00       	jmp    102bc7 <__alltraps>

00102927 <vector200>:
.globl vector200
vector200:
  pushl $0
  102927:	6a 00                	push   $0x0
  pushl $200
  102929:	68 c8 00 00 00       	push   $0xc8
  jmp __alltraps
  10292e:	e9 94 02 00 00       	jmp    102bc7 <__alltraps>

00102933 <vector201>:
.globl vector201
vector201:
  pushl $0
  102933:	6a 00                	push   $0x0
  pushl $201
  102935:	68 c9 00 00 00       	push   $0xc9
  jmp __alltraps
  10293a:	e9 88 02 00 00       	jmp    102bc7 <__alltraps>

0010293f <vector202>:
.globl vector202
vector202:
  pushl $0
  10293f:	6a 00                	push   $0x0
  pushl $202
  102941:	68 ca 00 00 00       	push   $0xca
  jmp __alltraps
  102946:	e9 7c 02 00 00       	jmp    102bc7 <__alltraps>

0010294b <vector203>:
.globl vector203
vector203:
  pushl $0
  10294b:	6a 00                	push   $0x0
  pushl $203
  10294d:	68 cb 00 00 00       	push   $0xcb
  jmp __alltraps
  102952:	e9 70 02 00 00       	jmp    102bc7 <__alltraps>

00102957 <vector204>:
.globl vector204
vector204:
  pushl $0
  102957:	6a 00                	push   $0x0
  pushl $204
  102959:	68 cc 00 00 00       	push   $0xcc
  jmp __alltraps
  10295e:	e9 64 02 00 00       	jmp    102bc7 <__alltraps>

00102963 <vector205>:
.globl vector205
vector205:
  pushl $0
  102963:	6a 00                	push   $0x0
  pushl $205
  102965:	68 cd 00 00 00       	push   $0xcd
  jmp __alltraps
  10296a:	e9 58 02 00 00       	jmp    102bc7 <__alltraps>

0010296f <vector206>:
.globl vector206
vector206:
  pushl $0
  10296f:	6a 00                	push   $0x0
  pushl $206
  102971:	68 ce 00 00 00       	push   $0xce
  jmp __alltraps
  102976:	e9 4c 02 00 00       	jmp    102bc7 <__alltraps>

0010297b <vector207>:
.globl vector207
vector207:
  pushl $0
  10297b:	6a 00                	push   $0x0
  pushl $207
  10297d:	68 cf 00 00 00       	push   $0xcf
  jmp __alltraps
  102982:	e9 40 02 00 00       	jmp    102bc7 <__alltraps>

00102987 <vector208>:
.globl vector208
vector208:
  pushl $0
  102987:	6a 00                	push   $0x0
  pushl $208
  102989:	68 d0 00 00 00       	push   $0xd0
  jmp __alltraps
  10298e:	e9 34 02 00 00       	jmp    102bc7 <__alltraps>

00102993 <vector209>:
.globl vector209
vector209:
  pushl $0
  102993:	6a 00                	push   $0x0
  pushl $209
  102995:	68 d1 00 00 00       	push   $0xd1
  jmp __alltraps
  10299a:	e9 28 02 00 00       	jmp    102bc7 <__alltraps>

0010299f <vector210>:
.globl vector210
vector210:
  pushl $0
  10299f:	6a 00                	push   $0x0
  pushl $210
  1029a1:	68 d2 00 00 00       	push   $0xd2
  jmp __alltraps
  1029a6:	e9 1c 02 00 00       	jmp    102bc7 <__alltraps>

001029ab <vector211>:
.globl vector211
vector211:
  pushl $0
  1029ab:	6a 00                	push   $0x0
  pushl $211
  1029ad:	68 d3 00 00 00       	push   $0xd3
  jmp __alltraps
  1029b2:	e9 10 02 00 00       	jmp    102bc7 <__alltraps>

001029b7 <vector212>:
.globl vector212
vector212:
  pushl $0
  1029b7:	6a 00                	push   $0x0
  pushl $212
  1029b9:	68 d4 00 00 00       	push   $0xd4
  jmp __alltraps
  1029be:	e9 04 02 00 00       	jmp    102bc7 <__alltraps>

001029c3 <vector213>:
.globl vector213
vector213:
  pushl $0
  1029c3:	6a 00                	push   $0x0
  pushl $213
  1029c5:	68 d5 00 00 00       	push   $0xd5
  jmp __alltraps
  1029ca:	e9 f8 01 00 00       	jmp    102bc7 <__alltraps>

001029cf <vector214>:
.globl vector214
vector214:
  pushl $0
  1029cf:	6a 00                	push   $0x0
  pushl $214
  1029d1:	68 d6 00 00 00       	push   $0xd6
  jmp __alltraps
  1029d6:	e9 ec 01 00 00       	jmp    102bc7 <__alltraps>

001029db <vector215>:
.globl vector215
vector215:
  pushl $0
  1029db:	6a 00                	push   $0x0
  pushl $215
  1029dd:	68 d7 00 00 00       	push   $0xd7
  jmp __alltraps
  1029e2:	e9 e0 01 00 00       	jmp    102bc7 <__alltraps>

001029e7 <vector216>:
.globl vector216
vector216:
  pushl $0
  1029e7:	6a 00                	push   $0x0
  pushl $216
  1029e9:	68 d8 00 00 00       	push   $0xd8
  jmp __alltraps
  1029ee:	e9 d4 01 00 00       	jmp    102bc7 <__alltraps>

001029f3 <vector217>:
.globl vector217
vector217:
  pushl $0
  1029f3:	6a 00                	push   $0x0
  pushl $217
  1029f5:	68 d9 00 00 00       	push   $0xd9
  jmp __alltraps
  1029fa:	e9 c8 01 00 00       	jmp    102bc7 <__alltraps>

001029ff <vector218>:
.globl vector218
vector218:
  pushl $0
  1029ff:	6a 00                	push   $0x0
  pushl $218
  102a01:	68 da 00 00 00       	push   $0xda
  jmp __alltraps
  102a06:	e9 bc 01 00 00       	jmp    102bc7 <__alltraps>

00102a0b <vector219>:
.globl vector219
vector219:
  pushl $0
  102a0b:	6a 00                	push   $0x0
  pushl $219
  102a0d:	68 db 00 00 00       	push   $0xdb
  jmp __alltraps
  102a12:	e9 b0 01 00 00       	jmp    102bc7 <__alltraps>

00102a17 <vector220>:
.globl vector220
vector220:
  pushl $0
  102a17:	6a 00                	push   $0x0
  pushl $220
  102a19:	68 dc 00 00 00       	push   $0xdc
  jmp __alltraps
  102a1e:	e9 a4 01 00 00       	jmp    102bc7 <__alltraps>

00102a23 <vector221>:
.globl vector221
vector221:
  pushl $0
  102a23:	6a 00                	push   $0x0
  pushl $221
  102a25:	68 dd 00 00 00       	push   $0xdd
  jmp __alltraps
  102a2a:	e9 98 01 00 00       	jmp    102bc7 <__alltraps>

00102a2f <vector222>:
.globl vector222
vector222:
  pushl $0
  102a2f:	6a 00                	push   $0x0
  pushl $222
  102a31:	68 de 00 00 00       	push   $0xde
  jmp __alltraps
  102a36:	e9 8c 01 00 00       	jmp    102bc7 <__alltraps>

00102a3b <vector223>:
.globl vector223
vector223:
  pushl $0
  102a3b:	6a 00                	push   $0x0
  pushl $223
  102a3d:	68 df 00 00 00       	push   $0xdf
  jmp __alltraps
  102a42:	e9 80 01 00 00       	jmp    102bc7 <__alltraps>

00102a47 <vector224>:
.globl vector224
vector224:
  pushl $0
  102a47:	6a 00                	push   $0x0
  pushl $224
  102a49:	68 e0 00 00 00       	push   $0xe0
  jmp __alltraps
  102a4e:	e9 74 01 00 00       	jmp    102bc7 <__alltraps>

00102a53 <vector225>:
.globl vector225
vector225:
  pushl $0
  102a53:	6a 00                	push   $0x0
  pushl $225
  102a55:	68 e1 00 00 00       	push   $0xe1
  jmp __alltraps
  102a5a:	e9 68 01 00 00       	jmp    102bc7 <__alltraps>

00102a5f <vector226>:
.globl vector226
vector226:
  pushl $0
  102a5f:	6a 00                	push   $0x0
  pushl $226
  102a61:	68 e2 00 00 00       	push   $0xe2
  jmp __alltraps
  102a66:	e9 5c 01 00 00       	jmp    102bc7 <__alltraps>

00102a6b <vector227>:
.globl vector227
vector227:
  pushl $0
  102a6b:	6a 00                	push   $0x0
  pushl $227
  102a6d:	68 e3 00 00 00       	push   $0xe3
  jmp __alltraps
  102a72:	e9 50 01 00 00       	jmp    102bc7 <__alltraps>

00102a77 <vector228>:
.globl vector228
vector228:
  pushl $0
  102a77:	6a 00                	push   $0x0
  pushl $228
  102a79:	68 e4 00 00 00       	push   $0xe4
  jmp __alltraps
  102a7e:	e9 44 01 00 00       	jmp    102bc7 <__alltraps>

00102a83 <vector229>:
.globl vector229
vector229:
  pushl $0
  102a83:	6a 00                	push   $0x0
  pushl $229
  102a85:	68 e5 00 00 00       	push   $0xe5
  jmp __alltraps
  102a8a:	e9 38 01 00 00       	jmp    102bc7 <__alltraps>

00102a8f <vector230>:
.globl vector230
vector230:
  pushl $0
  102a8f:	6a 00                	push   $0x0
  pushl $230
  102a91:	68 e6 00 00 00       	push   $0xe6
  jmp __alltraps
  102a96:	e9 2c 01 00 00       	jmp    102bc7 <__alltraps>

00102a9b <vector231>:
.globl vector231
vector231:
  pushl $0
  102a9b:	6a 00                	push   $0x0
  pushl $231
  102a9d:	68 e7 00 00 00       	push   $0xe7
  jmp __alltraps
  102aa2:	e9 20 01 00 00       	jmp    102bc7 <__alltraps>

00102aa7 <vector232>:
.globl vector232
vector232:
  pushl $0
  102aa7:	6a 00                	push   $0x0
  pushl $232
  102aa9:	68 e8 00 00 00       	push   $0xe8
  jmp __alltraps
  102aae:	e9 14 01 00 00       	jmp    102bc7 <__alltraps>

00102ab3 <vector233>:
.globl vector233
vector233:
  pushl $0
  102ab3:	6a 00                	push   $0x0
  pushl $233
  102ab5:	68 e9 00 00 00       	push   $0xe9
  jmp __alltraps
  102aba:	e9 08 01 00 00       	jmp    102bc7 <__alltraps>

00102abf <vector234>:
.globl vector234
vector234:
  pushl $0
  102abf:	6a 00                	push   $0x0
  pushl $234
  102ac1:	68 ea 00 00 00       	push   $0xea
  jmp __alltraps
  102ac6:	e9 fc 00 00 00       	jmp    102bc7 <__alltraps>

00102acb <vector235>:
.globl vector235
vector235:
  pushl $0
  102acb:	6a 00                	push   $0x0
  pushl $235
  102acd:	68 eb 00 00 00       	push   $0xeb
  jmp __alltraps
  102ad2:	e9 f0 00 00 00       	jmp    102bc7 <__alltraps>

00102ad7 <vector236>:
.globl vector236
vector236:
  pushl $0
  102ad7:	6a 00                	push   $0x0
  pushl $236
  102ad9:	68 ec 00 00 00       	push   $0xec
  jmp __alltraps
  102ade:	e9 e4 00 00 00       	jmp    102bc7 <__alltraps>

00102ae3 <vector237>:
.globl vector237
vector237:
  pushl $0
  102ae3:	6a 00                	push   $0x0
  pushl $237
  102ae5:	68 ed 00 00 00       	push   $0xed
  jmp __alltraps
  102aea:	e9 d8 00 00 00       	jmp    102bc7 <__alltraps>

00102aef <vector238>:
.globl vector238
vector238:
  pushl $0
  102aef:	6a 00                	push   $0x0
  pushl $238
  102af1:	68 ee 00 00 00       	push   $0xee
  jmp __alltraps
  102af6:	e9 cc 00 00 00       	jmp    102bc7 <__alltraps>

00102afb <vector239>:
.globl vector239
vector239:
  pushl $0
  102afb:	6a 00                	push   $0x0
  pushl $239
  102afd:	68 ef 00 00 00       	push   $0xef
  jmp __alltraps
  102b02:	e9 c0 00 00 00       	jmp    102bc7 <__alltraps>

00102b07 <vector240>:
.globl vector240
vector240:
  pushl $0
  102b07:	6a 00                	push   $0x0
  pushl $240
  102b09:	68 f0 00 00 00       	push   $0xf0
  jmp __alltraps
  102b0e:	e9 b4 00 00 00       	jmp    102bc7 <__alltraps>

00102b13 <vector241>:
.globl vector241
vector241:
  pushl $0
  102b13:	6a 00                	push   $0x0
  pushl $241
  102b15:	68 f1 00 00 00       	push   $0xf1
  jmp __alltraps
  102b1a:	e9 a8 00 00 00       	jmp    102bc7 <__alltraps>

00102b1f <vector242>:
.globl vector242
vector242:
  pushl $0
  102b1f:	6a 00                	push   $0x0
  pushl $242
  102b21:	68 f2 00 00 00       	push   $0xf2
  jmp __alltraps
  102b26:	e9 9c 00 00 00       	jmp    102bc7 <__alltraps>

00102b2b <vector243>:
.globl vector243
vector243:
  pushl $0
  102b2b:	6a 00                	push   $0x0
  pushl $243
  102b2d:	68 f3 00 00 00       	push   $0xf3
  jmp __alltraps
  102b32:	e9 90 00 00 00       	jmp    102bc7 <__alltraps>

00102b37 <vector244>:
.globl vector244
vector244:
  pushl $0
  102b37:	6a 00                	push   $0x0
  pushl $244
  102b39:	68 f4 00 00 00       	push   $0xf4
  jmp __alltraps
  102b3e:	e9 84 00 00 00       	jmp    102bc7 <__alltraps>

00102b43 <vector245>:
.globl vector245
vector245:
  pushl $0
  102b43:	6a 00                	push   $0x0
  pushl $245
  102b45:	68 f5 00 00 00       	push   $0xf5
  jmp __alltraps
  102b4a:	e9 78 00 00 00       	jmp    102bc7 <__alltraps>

00102b4f <vector246>:
.globl vector246
vector246:
  pushl $0
  102b4f:	6a 00                	push   $0x0
  pushl $246
  102b51:	68 f6 00 00 00       	push   $0xf6
  jmp __alltraps
  102b56:	e9 6c 00 00 00       	jmp    102bc7 <__alltraps>

00102b5b <vector247>:
.globl vector247
vector247:
  pushl $0
  102b5b:	6a 00                	push   $0x0
  pushl $247
  102b5d:	68 f7 00 00 00       	push   $0xf7
  jmp __alltraps
  102b62:	e9 60 00 00 00       	jmp    102bc7 <__alltraps>

00102b67 <vector248>:
.globl vector248
vector248:
  pushl $0
  102b67:	6a 00                	push   $0x0
  pushl $248
  102b69:	68 f8 00 00 00       	push   $0xf8
  jmp __alltraps
  102b6e:	e9 54 00 00 00       	jmp    102bc7 <__alltraps>

00102b73 <vector249>:
.globl vector249
vector249:
  pushl $0
  102b73:	6a 00                	push   $0x0
  pushl $249
  102b75:	68 f9 00 00 00       	push   $0xf9
  jmp __alltraps
  102b7a:	e9 48 00 00 00       	jmp    102bc7 <__alltraps>

00102b7f <vector250>:
.globl vector250
vector250:
  pushl $0
  102b7f:	6a 00                	push   $0x0
  pushl $250
  102b81:	68 fa 00 00 00       	push   $0xfa
  jmp __alltraps
  102b86:	e9 3c 00 00 00       	jmp    102bc7 <__alltraps>

00102b8b <vector251>:
.globl vector251
vector251:
  pushl $0
  102b8b:	6a 00                	push   $0x0
  pushl $251
  102b8d:	68 fb 00 00 00       	push   $0xfb
  jmp __alltraps
  102b92:	e9 30 00 00 00       	jmp    102bc7 <__alltraps>

00102b97 <vector252>:
.globl vector252
vector252:
  pushl $0
  102b97:	6a 00                	push   $0x0
  pushl $252
  102b99:	68 fc 00 00 00       	push   $0xfc
  jmp __alltraps
  102b9e:	e9 24 00 00 00       	jmp    102bc7 <__alltraps>

00102ba3 <vector253>:
.globl vector253
vector253:
  pushl $0
  102ba3:	6a 00                	push   $0x0
  pushl $253
  102ba5:	68 fd 00 00 00       	push   $0xfd
  jmp __alltraps
  102baa:	e9 18 00 00 00       	jmp    102bc7 <__alltraps>

00102baf <vector254>:
.globl vector254
vector254:
  pushl $0
  102baf:	6a 00                	push   $0x0
  pushl $254
  102bb1:	68 fe 00 00 00       	push   $0xfe
  jmp __alltraps
  102bb6:	e9 0c 00 00 00       	jmp    102bc7 <__alltraps>

00102bbb <vector255>:
.globl vector255
vector255:
  pushl $0
  102bbb:	6a 00                	push   $0x0
  pushl $255
  102bbd:	68 ff 00 00 00       	push   $0xff
  jmp __alltraps
  102bc2:	e9 00 00 00 00       	jmp    102bc7 <__alltraps>

00102bc7 <__alltraps>:
.text
.globl __alltraps
__alltraps:
    # push registers to build a trap frame
    # therefore make the stack look like a struct trapframe
    pushl %ds
  102bc7:	1e                   	push   %ds
    pushl %es
  102bc8:	06                   	push   %es
    pushl %fs
  102bc9:	0f a0                	push   %fs
    pushl %gs
  102bcb:	0f a8                	push   %gs
    pushal
  102bcd:	60                   	pusha  

    # load GD_KDATA into %ds and %es to set up data segments for kernel
    movl $GD_KDATA, %eax
  102bce:	b8 10 00 00 00       	mov    $0x10,%eax
    movw %ax, %ds
  102bd3:	8e d8                	mov    %eax,%ds
    movw %ax, %es
  102bd5:	8e c0                	mov    %eax,%es

    # push %esp to pass a pointer to the trapframe as an argument to trap()
    pushl %esp
  102bd7:	54                   	push   %esp

    # call trap(tf), where tf=%esp
    call trap
  102bd8:	e8 55 f5 ff ff       	call   102132 <trap>

    # pop the pushed stack pointer
    popl %esp
  102bdd:	5c                   	pop    %esp

00102bde <__trapret>:

    # return falls through to trapret...
.globl __trapret
__trapret:
    # restore registers from stack
    popal
  102bde:	61                   	popa   

    # restore %ds, %es, %fs and %gs
    popl %gs
  102bdf:	0f a9                	pop    %gs
    popl %fs
  102be1:	0f a1                	pop    %fs
    popl %es
  102be3:	07                   	pop    %es
    popl %ds
  102be4:	1f                   	pop    %ds

    # get rid of the trap number and error code
    addl $0x8, %esp
  102be5:	83 c4 08             	add    $0x8,%esp
    iret
  102be8:	cf                   	iret   

00102be9 <lgdt>:
/* *
 * lgdt - load the global descriptor table register and reset the
 * data/code segement registers for kernel.
 * */
static inline void
lgdt(struct pseudodesc *pd) {
  102be9:	55                   	push   %ebp
  102bea:	89 e5                	mov    %esp,%ebp
  102bec:	e8 af d6 ff ff       	call   1002a0 <__x86.get_pc_thunk.ax>
  102bf1:	05 5f cd 00 00       	add    $0xcd5f,%eax
    asm volatile ("lgdt (%0)" :: "r" (pd));
  102bf6:	8b 45 08             	mov    0x8(%ebp),%eax
  102bf9:	0f 01 10             	lgdtl  (%eax)
    asm volatile ("movw %%ax, %%gs" :: "a" (USER_DS));
  102bfc:	b8 23 00 00 00       	mov    $0x23,%eax
  102c01:	8e e8                	mov    %eax,%gs
    asm volatile ("movw %%ax, %%fs" :: "a" (USER_DS));
  102c03:	b8 23 00 00 00       	mov    $0x23,%eax
  102c08:	8e e0                	mov    %eax,%fs
    asm volatile ("movw %%ax, %%es" :: "a" (KERNEL_DS));
  102c0a:	b8 10 00 00 00       	mov    $0x10,%eax
  102c0f:	8e c0                	mov    %eax,%es
    asm volatile ("movw %%ax, %%ds" :: "a" (KERNEL_DS));
  102c11:	b8 10 00 00 00       	mov    $0x10,%eax
  102c16:	8e d8                	mov    %eax,%ds
    asm volatile ("movw %%ax, %%ss" :: "a" (KERNEL_DS));
  102c18:	b8 10 00 00 00       	mov    $0x10,%eax
  102c1d:	8e d0                	mov    %eax,%ss
    // reload cs
    asm volatile ("ljmp %0, $1f\n 1:\n" :: "i" (KERNEL_CS));
  102c1f:	ea 26 2c 10 00 08 00 	ljmp   $0x8,$0x102c26
}
  102c26:	90                   	nop
  102c27:	5d                   	pop    %ebp
  102c28:	c3                   	ret    

00102c29 <gdt_init>:
/* temporary kernel stack */
uint8_t stack0[1024];

/* gdt_init - initialize the default GDT and TSS */
static void
gdt_init(void) {
  102c29:	f3 0f 1e fb          	endbr32 
  102c2d:	55                   	push   %ebp
  102c2e:	89 e5                	mov    %esp,%ebp
  102c30:	83 ec 10             	sub    $0x10,%esp
  102c33:	e8 68 d6 ff ff       	call   1002a0 <__x86.get_pc_thunk.ax>
  102c38:	05 18 cd 00 00       	add    $0xcd18,%eax
    // Setup a TSS so that we can get the right stack when we trap from
    // user to the kernel. But not safe here, it's only a temporary value,
    // it will be set to KSTACKTOP in lab2.
    ts.ts_esp0 = (uint32_t)&stack0 + sizeof(stack0);
  102c3d:	c7 c2 c0 09 11 00    	mov    $0x1109c0,%edx
  102c43:	81 c2 00 04 00 00    	add    $0x400,%edx
  102c49:	89 90 f4 0f 00 00    	mov    %edx,0xff4(%eax)
    ts.ts_ss0 = KERNEL_DS;
  102c4f:	66 c7 80 f8 0f 00 00 	movw   $0x10,0xff8(%eax)
  102c56:	10 00 

    // initialize the TSS filed of the gdt
    gdt[SEG_TSS] = SEG16(STS_T32A, (uint32_t)&ts, sizeof(ts), DPL_KERNEL);
  102c58:	66 c7 80 f8 ff ff ff 	movw   $0x68,-0x8(%eax)
  102c5f:	68 00 
  102c61:	8d 90 f0 0f 00 00    	lea    0xff0(%eax),%edx
  102c67:	66 89 90 fa ff ff ff 	mov    %dx,-0x6(%eax)
  102c6e:	8d 90 f0 0f 00 00    	lea    0xff0(%eax),%edx
  102c74:	c1 ea 10             	shr    $0x10,%edx
  102c77:	88 90 fc ff ff ff    	mov    %dl,-0x4(%eax)
  102c7d:	0f b6 90 fd ff ff ff 	movzbl -0x3(%eax),%edx
  102c84:	83 e2 f0             	and    $0xfffffff0,%edx
  102c87:	83 ca 09             	or     $0x9,%edx
  102c8a:	88 90 fd ff ff ff    	mov    %dl,-0x3(%eax)
  102c90:	0f b6 90 fd ff ff ff 	movzbl -0x3(%eax),%edx
  102c97:	83 ca 10             	or     $0x10,%edx
  102c9a:	88 90 fd ff ff ff    	mov    %dl,-0x3(%eax)
  102ca0:	0f b6 90 fd ff ff ff 	movzbl -0x3(%eax),%edx
  102ca7:	83 e2 9f             	and    $0xffffff9f,%edx
  102caa:	88 90 fd ff ff ff    	mov    %dl,-0x3(%eax)
  102cb0:	0f b6 90 fd ff ff ff 	movzbl -0x3(%eax),%edx
  102cb7:	83 ca 80             	or     $0xffffff80,%edx
  102cba:	88 90 fd ff ff ff    	mov    %dl,-0x3(%eax)
  102cc0:	0f b6 90 fe ff ff ff 	movzbl -0x2(%eax),%edx
  102cc7:	83 e2 f0             	and    $0xfffffff0,%edx
  102cca:	88 90 fe ff ff ff    	mov    %dl,-0x2(%eax)
  102cd0:	0f b6 90 fe ff ff ff 	movzbl -0x2(%eax),%edx
  102cd7:	83 e2 ef             	and    $0xffffffef,%edx
  102cda:	88 90 fe ff ff ff    	mov    %dl,-0x2(%eax)
  102ce0:	0f b6 90 fe ff ff ff 	movzbl -0x2(%eax),%edx
  102ce7:	83 e2 df             	and    $0xffffffdf,%edx
  102cea:	88 90 fe ff ff ff    	mov    %dl,-0x2(%eax)
  102cf0:	0f b6 90 fe ff ff ff 	movzbl -0x2(%eax),%edx
  102cf7:	83 ca 40             	or     $0x40,%edx
  102cfa:	88 90 fe ff ff ff    	mov    %dl,-0x2(%eax)
  102d00:	0f b6 90 fe ff ff ff 	movzbl -0x2(%eax),%edx
  102d07:	83 e2 7f             	and    $0x7f,%edx
  102d0a:	88 90 fe ff ff ff    	mov    %dl,-0x2(%eax)
  102d10:	8d 90 f0 0f 00 00    	lea    0xff0(%eax),%edx
  102d16:	c1 ea 18             	shr    $0x18,%edx
  102d19:	88 90 ff ff ff ff    	mov    %dl,-0x1(%eax)
    gdt[SEG_TSS].sd_s = 0;
  102d1f:	0f b6 90 fd ff ff ff 	movzbl -0x3(%eax),%edx
  102d26:	83 e2 ef             	and    $0xffffffef,%edx
  102d29:	88 90 fd ff ff ff    	mov    %dl,-0x3(%eax)

    // reload all segment registers
    lgdt(&gdt_pd);
  102d2f:	8d 80 d0 00 00 00    	lea    0xd0(%eax),%eax
  102d35:	50                   	push   %eax
  102d36:	e8 ae fe ff ff       	call   102be9 <lgdt>
  102d3b:	83 c4 04             	add    $0x4,%esp
  102d3e:	66 c7 45 fe 28 00    	movw   $0x28,-0x2(%ebp)

static inline void
ltr(uint16_t sel) {
    asm volatile ("ltr %0" :: "r" (sel));
  102d44:	0f b7 45 fe          	movzwl -0x2(%ebp),%eax
  102d48:	0f 00 d8             	ltr    %ax
}
  102d4b:	90                   	nop

    // load the TSS
    ltr(GD_TSS);
}
  102d4c:	90                   	nop
  102d4d:	c9                   	leave  
  102d4e:	c3                   	ret    

00102d4f <pmm_init>:

/* pmm_init - initialize the physical memory management */
void
pmm_init(void) {
  102d4f:	f3 0f 1e fb          	endbr32 
  102d53:	55                   	push   %ebp
  102d54:	89 e5                	mov    %esp,%ebp
  102d56:	e8 45 d5 ff ff       	call   1002a0 <__x86.get_pc_thunk.ax>
  102d5b:	05 f5 cb 00 00       	add    $0xcbf5,%eax
    gdt_init();
  102d60:	e8 c4 fe ff ff       	call   102c29 <gdt_init>
}
  102d65:	90                   	nop
  102d66:	5d                   	pop    %ebp
  102d67:	c3                   	ret    

00102d68 <strlen>:
 * @s:        the input string
 *
 * The strlen() function returns the length of string @s.
 * */
size_t
strlen(const char *s) {
  102d68:	f3 0f 1e fb          	endbr32 
  102d6c:	55                   	push   %ebp
  102d6d:	89 e5                	mov    %esp,%ebp
  102d6f:	83 ec 10             	sub    $0x10,%esp
  102d72:	e8 29 d5 ff ff       	call   1002a0 <__x86.get_pc_thunk.ax>
  102d77:	05 d9 cb 00 00       	add    $0xcbd9,%eax
    size_t cnt = 0;
  102d7c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    while (*s ++ != '\0') {
  102d83:	eb 04                	jmp    102d89 <strlen+0x21>
        cnt ++;
  102d85:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    while (*s ++ != '\0') {
  102d89:	8b 45 08             	mov    0x8(%ebp),%eax
  102d8c:	8d 50 01             	lea    0x1(%eax),%edx
  102d8f:	89 55 08             	mov    %edx,0x8(%ebp)
  102d92:	0f b6 00             	movzbl (%eax),%eax
  102d95:	84 c0                	test   %al,%al
  102d97:	75 ec                	jne    102d85 <strlen+0x1d>
    }
    return cnt;
  102d99:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  102d9c:	c9                   	leave  
  102d9d:	c3                   	ret    

00102d9e <strnlen>:
 * The return value is strlen(s), if that is less than @len, or
 * @len if there is no '\0' character among the first @len characters
 * pointed by @s.
 * */
size_t
strnlen(const char *s, size_t len) {
  102d9e:	f3 0f 1e fb          	endbr32 
  102da2:	55                   	push   %ebp
  102da3:	89 e5                	mov    %esp,%ebp
  102da5:	83 ec 10             	sub    $0x10,%esp
  102da8:	e8 f3 d4 ff ff       	call   1002a0 <__x86.get_pc_thunk.ax>
  102dad:	05 a3 cb 00 00       	add    $0xcba3,%eax
    size_t cnt = 0;
  102db2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    while (cnt < len && *s ++ != '\0') {
  102db9:	eb 04                	jmp    102dbf <strnlen+0x21>
        cnt ++;
  102dbb:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    while (cnt < len && *s ++ != '\0') {
  102dbf:	8b 45 fc             	mov    -0x4(%ebp),%eax
  102dc2:	3b 45 0c             	cmp    0xc(%ebp),%eax
  102dc5:	73 10                	jae    102dd7 <strnlen+0x39>
  102dc7:	8b 45 08             	mov    0x8(%ebp),%eax
  102dca:	8d 50 01             	lea    0x1(%eax),%edx
  102dcd:	89 55 08             	mov    %edx,0x8(%ebp)
  102dd0:	0f b6 00             	movzbl (%eax),%eax
  102dd3:	84 c0                	test   %al,%al
  102dd5:	75 e4                	jne    102dbb <strnlen+0x1d>
    }
    return cnt;
  102dd7:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  102dda:	c9                   	leave  
  102ddb:	c3                   	ret    

00102ddc <strcpy>:
 * To avoid overflows, the size of array pointed by @dst should be long enough to
 * contain the same string as @src (including the terminating null character), and
 * should not overlap in memory with @src.
 * */
char *
strcpy(char *dst, const char *src) {
  102ddc:	f3 0f 1e fb          	endbr32 
  102de0:	55                   	push   %ebp
  102de1:	89 e5                	mov    %esp,%ebp
  102de3:	57                   	push   %edi
  102de4:	56                   	push   %esi
  102de5:	83 ec 20             	sub    $0x20,%esp
  102de8:	e8 b3 d4 ff ff       	call   1002a0 <__x86.get_pc_thunk.ax>
  102ded:	05 63 cb 00 00       	add    $0xcb63,%eax
  102df2:	8b 45 08             	mov    0x8(%ebp),%eax
  102df5:	89 45 f4             	mov    %eax,-0xc(%ebp)
  102df8:	8b 45 0c             	mov    0xc(%ebp),%eax
  102dfb:	89 45 f0             	mov    %eax,-0x10(%ebp)
#ifndef __HAVE_ARCH_STRCPY
#define __HAVE_ARCH_STRCPY
static inline char *
__strcpy(char *dst, const char *src) {
    int d0, d1, d2;
    asm volatile (
  102dfe:	8b 55 f0             	mov    -0x10(%ebp),%edx
  102e01:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102e04:	89 d1                	mov    %edx,%ecx
  102e06:	89 c2                	mov    %eax,%edx
  102e08:	89 ce                	mov    %ecx,%esi
  102e0a:	89 d7                	mov    %edx,%edi
  102e0c:	ac                   	lods   %ds:(%esi),%al
  102e0d:	aa                   	stos   %al,%es:(%edi)
  102e0e:	84 c0                	test   %al,%al
  102e10:	75 fa                	jne    102e0c <strcpy+0x30>
  102e12:	89 fa                	mov    %edi,%edx
  102e14:	89 f1                	mov    %esi,%ecx
  102e16:	89 4d ec             	mov    %ecx,-0x14(%ebp)
  102e19:	89 55 e8             	mov    %edx,-0x18(%ebp)
  102e1c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "stosb;"
            "testb %%al, %%al;"
            "jne 1b;"
            : "=&S" (d0), "=&D" (d1), "=&a" (d2)
            : "0" (src), "1" (dst) : "memory");
    return dst;
  102e1f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    char *p = dst;
    while ((*p ++ = *src ++) != '\0')
        /* nothing */;
    return dst;
#endif /* __HAVE_ARCH_STRCPY */
}
  102e22:	83 c4 20             	add    $0x20,%esp
  102e25:	5e                   	pop    %esi
  102e26:	5f                   	pop    %edi
  102e27:	5d                   	pop    %ebp
  102e28:	c3                   	ret    

00102e29 <strncpy>:
 * @len:    maximum number of characters to be copied from @src
 *
 * The return value is @dst
 * */
char *
strncpy(char *dst, const char *src, size_t len) {
  102e29:	f3 0f 1e fb          	endbr32 
  102e2d:	55                   	push   %ebp
  102e2e:	89 e5                	mov    %esp,%ebp
  102e30:	83 ec 10             	sub    $0x10,%esp
  102e33:	e8 68 d4 ff ff       	call   1002a0 <__x86.get_pc_thunk.ax>
  102e38:	05 18 cb 00 00       	add    $0xcb18,%eax
    char *p = dst;
  102e3d:	8b 45 08             	mov    0x8(%ebp),%eax
  102e40:	89 45 fc             	mov    %eax,-0x4(%ebp)
    while (len > 0) {
  102e43:	eb 21                	jmp    102e66 <strncpy+0x3d>
        if ((*p = *src) != '\0') {
  102e45:	8b 45 0c             	mov    0xc(%ebp),%eax
  102e48:	0f b6 10             	movzbl (%eax),%edx
  102e4b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  102e4e:	88 10                	mov    %dl,(%eax)
  102e50:	8b 45 fc             	mov    -0x4(%ebp),%eax
  102e53:	0f b6 00             	movzbl (%eax),%eax
  102e56:	84 c0                	test   %al,%al
  102e58:	74 04                	je     102e5e <strncpy+0x35>
            src ++;
  102e5a:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
        }
        p ++, len --;
  102e5e:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  102e62:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
    while (len > 0) {
  102e66:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  102e6a:	75 d9                	jne    102e45 <strncpy+0x1c>
    }
    return dst;
  102e6c:	8b 45 08             	mov    0x8(%ebp),%eax
}
  102e6f:	c9                   	leave  
  102e70:	c3                   	ret    

00102e71 <strcmp>:
 * - A value greater than zero indicates that the first character that does
 *   not match has a greater value in @s1 than in @s2;
 * - And a value less than zero indicates the opposite.
 * */
int
strcmp(const char *s1, const char *s2) {
  102e71:	f3 0f 1e fb          	endbr32 
  102e75:	55                   	push   %ebp
  102e76:	89 e5                	mov    %esp,%ebp
  102e78:	57                   	push   %edi
  102e79:	56                   	push   %esi
  102e7a:	83 ec 20             	sub    $0x20,%esp
  102e7d:	e8 1e d4 ff ff       	call   1002a0 <__x86.get_pc_thunk.ax>
  102e82:	05 ce ca 00 00       	add    $0xcace,%eax
  102e87:	8b 45 08             	mov    0x8(%ebp),%eax
  102e8a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  102e8d:	8b 45 0c             	mov    0xc(%ebp),%eax
  102e90:	89 45 f0             	mov    %eax,-0x10(%ebp)
    asm volatile (
  102e93:	8b 55 f4             	mov    -0xc(%ebp),%edx
  102e96:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102e99:	89 d1                	mov    %edx,%ecx
  102e9b:	89 c2                	mov    %eax,%edx
  102e9d:	89 ce                	mov    %ecx,%esi
  102e9f:	89 d7                	mov    %edx,%edi
  102ea1:	ac                   	lods   %ds:(%esi),%al
  102ea2:	ae                   	scas   %es:(%edi),%al
  102ea3:	75 08                	jne    102ead <strcmp+0x3c>
  102ea5:	84 c0                	test   %al,%al
  102ea7:	75 f8                	jne    102ea1 <strcmp+0x30>
  102ea9:	31 c0                	xor    %eax,%eax
  102eab:	eb 04                	jmp    102eb1 <strcmp+0x40>
  102ead:	19 c0                	sbb    %eax,%eax
  102eaf:	0c 01                	or     $0x1,%al
  102eb1:	89 fa                	mov    %edi,%edx
  102eb3:	89 f1                	mov    %esi,%ecx
  102eb5:	89 45 ec             	mov    %eax,-0x14(%ebp)
  102eb8:	89 4d e8             	mov    %ecx,-0x18(%ebp)
  102ebb:	89 55 e4             	mov    %edx,-0x1c(%ebp)
    return ret;
  102ebe:	8b 45 ec             	mov    -0x14(%ebp),%eax
    while (*s1 != '\0' && *s1 == *s2) {
        s1 ++, s2 ++;
    }
    return (int)((unsigned char)*s1 - (unsigned char)*s2);
#endif /* __HAVE_ARCH_STRCMP */
}
  102ec1:	83 c4 20             	add    $0x20,%esp
  102ec4:	5e                   	pop    %esi
  102ec5:	5f                   	pop    %edi
  102ec6:	5d                   	pop    %ebp
  102ec7:	c3                   	ret    

00102ec8 <strncmp>:
 * they are equal to each other, it continues with the following pairs until
 * the characters differ, until a terminating null-character is reached, or
 * until @n characters match in both strings, whichever happens first.
 * */
int
strncmp(const char *s1, const char *s2, size_t n) {
  102ec8:	f3 0f 1e fb          	endbr32 
  102ecc:	55                   	push   %ebp
  102ecd:	89 e5                	mov    %esp,%ebp
  102ecf:	e8 cc d3 ff ff       	call   1002a0 <__x86.get_pc_thunk.ax>
  102ed4:	05 7c ca 00 00       	add    $0xca7c,%eax
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
  102ed9:	eb 0c                	jmp    102ee7 <strncmp+0x1f>
        n --, s1 ++, s2 ++;
  102edb:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
  102edf:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  102ee3:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
  102ee7:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  102eeb:	74 1a                	je     102f07 <strncmp+0x3f>
  102eed:	8b 45 08             	mov    0x8(%ebp),%eax
  102ef0:	0f b6 00             	movzbl (%eax),%eax
  102ef3:	84 c0                	test   %al,%al
  102ef5:	74 10                	je     102f07 <strncmp+0x3f>
  102ef7:	8b 45 08             	mov    0x8(%ebp),%eax
  102efa:	0f b6 10             	movzbl (%eax),%edx
  102efd:	8b 45 0c             	mov    0xc(%ebp),%eax
  102f00:	0f b6 00             	movzbl (%eax),%eax
  102f03:	38 c2                	cmp    %al,%dl
  102f05:	74 d4                	je     102edb <strncmp+0x13>
    }
    return (n == 0) ? 0 : (int)((unsigned char)*s1 - (unsigned char)*s2);
  102f07:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  102f0b:	74 18                	je     102f25 <strncmp+0x5d>
  102f0d:	8b 45 08             	mov    0x8(%ebp),%eax
  102f10:	0f b6 00             	movzbl (%eax),%eax
  102f13:	0f b6 d0             	movzbl %al,%edx
  102f16:	8b 45 0c             	mov    0xc(%ebp),%eax
  102f19:	0f b6 00             	movzbl (%eax),%eax
  102f1c:	0f b6 c0             	movzbl %al,%eax
  102f1f:	29 c2                	sub    %eax,%edx
  102f21:	89 d0                	mov    %edx,%eax
  102f23:	eb 05                	jmp    102f2a <strncmp+0x62>
  102f25:	b8 00 00 00 00       	mov    $0x0,%eax
}
  102f2a:	5d                   	pop    %ebp
  102f2b:	c3                   	ret    

00102f2c <strchr>:
 *
 * The strchr() function returns a pointer to the first occurrence of
 * character in @s. If the value is not found, the function returns 'NULL'.
 * */
char *
strchr(const char *s, char c) {
  102f2c:	f3 0f 1e fb          	endbr32 
  102f30:	55                   	push   %ebp
  102f31:	89 e5                	mov    %esp,%ebp
  102f33:	83 ec 04             	sub    $0x4,%esp
  102f36:	e8 65 d3 ff ff       	call   1002a0 <__x86.get_pc_thunk.ax>
  102f3b:	05 15 ca 00 00       	add    $0xca15,%eax
  102f40:	8b 45 0c             	mov    0xc(%ebp),%eax
  102f43:	88 45 fc             	mov    %al,-0x4(%ebp)
    while (*s != '\0') {
  102f46:	eb 14                	jmp    102f5c <strchr+0x30>
        if (*s == c) {
  102f48:	8b 45 08             	mov    0x8(%ebp),%eax
  102f4b:	0f b6 00             	movzbl (%eax),%eax
  102f4e:	38 45 fc             	cmp    %al,-0x4(%ebp)
  102f51:	75 05                	jne    102f58 <strchr+0x2c>
            return (char *)s;
  102f53:	8b 45 08             	mov    0x8(%ebp),%eax
  102f56:	eb 13                	jmp    102f6b <strchr+0x3f>
        }
        s ++;
  102f58:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    while (*s != '\0') {
  102f5c:	8b 45 08             	mov    0x8(%ebp),%eax
  102f5f:	0f b6 00             	movzbl (%eax),%eax
  102f62:	84 c0                	test   %al,%al
  102f64:	75 e2                	jne    102f48 <strchr+0x1c>
    }
    return NULL;
  102f66:	b8 00 00 00 00       	mov    $0x0,%eax
}
  102f6b:	c9                   	leave  
  102f6c:	c3                   	ret    

00102f6d <strfind>:
 * The strfind() function is like strchr() except that if @c is
 * not found in @s, then it returns a pointer to the null byte at the
 * end of @s, rather than 'NULL'.
 * */
char *
strfind(const char *s, char c) {
  102f6d:	f3 0f 1e fb          	endbr32 
  102f71:	55                   	push   %ebp
  102f72:	89 e5                	mov    %esp,%ebp
  102f74:	83 ec 04             	sub    $0x4,%esp
  102f77:	e8 24 d3 ff ff       	call   1002a0 <__x86.get_pc_thunk.ax>
  102f7c:	05 d4 c9 00 00       	add    $0xc9d4,%eax
  102f81:	8b 45 0c             	mov    0xc(%ebp),%eax
  102f84:	88 45 fc             	mov    %al,-0x4(%ebp)
    while (*s != '\0') {
  102f87:	eb 0f                	jmp    102f98 <strfind+0x2b>
        if (*s == c) {
  102f89:	8b 45 08             	mov    0x8(%ebp),%eax
  102f8c:	0f b6 00             	movzbl (%eax),%eax
  102f8f:	38 45 fc             	cmp    %al,-0x4(%ebp)
  102f92:	74 10                	je     102fa4 <strfind+0x37>
            break;
        }
        s ++;
  102f94:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    while (*s != '\0') {
  102f98:	8b 45 08             	mov    0x8(%ebp),%eax
  102f9b:	0f b6 00             	movzbl (%eax),%eax
  102f9e:	84 c0                	test   %al,%al
  102fa0:	75 e7                	jne    102f89 <strfind+0x1c>
  102fa2:	eb 01                	jmp    102fa5 <strfind+0x38>
            break;
  102fa4:	90                   	nop
    }
    return (char *)s;
  102fa5:	8b 45 08             	mov    0x8(%ebp),%eax
}
  102fa8:	c9                   	leave  
  102fa9:	c3                   	ret    

00102faa <strtol>:
 * an optional "0x" or "0X" prefix.
 *
 * The strtol() function returns the converted integral number as a long int value.
 * */
long
strtol(const char *s, char **endptr, int base) {
  102faa:	f3 0f 1e fb          	endbr32 
  102fae:	55                   	push   %ebp
  102faf:	89 e5                	mov    %esp,%ebp
  102fb1:	83 ec 10             	sub    $0x10,%esp
  102fb4:	e8 e7 d2 ff ff       	call   1002a0 <__x86.get_pc_thunk.ax>
  102fb9:	05 97 c9 00 00       	add    $0xc997,%eax
    int neg = 0;
  102fbe:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    long val = 0;
  102fc5:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

    // gobble initial whitespace
    while (*s == ' ' || *s == '\t') {
  102fcc:	eb 04                	jmp    102fd2 <strtol+0x28>
        s ++;
  102fce:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    while (*s == ' ' || *s == '\t') {
  102fd2:	8b 45 08             	mov    0x8(%ebp),%eax
  102fd5:	0f b6 00             	movzbl (%eax),%eax
  102fd8:	3c 20                	cmp    $0x20,%al
  102fda:	74 f2                	je     102fce <strtol+0x24>
  102fdc:	8b 45 08             	mov    0x8(%ebp),%eax
  102fdf:	0f b6 00             	movzbl (%eax),%eax
  102fe2:	3c 09                	cmp    $0x9,%al
  102fe4:	74 e8                	je     102fce <strtol+0x24>
    }

    // plus/minus sign
    if (*s == '+') {
  102fe6:	8b 45 08             	mov    0x8(%ebp),%eax
  102fe9:	0f b6 00             	movzbl (%eax),%eax
  102fec:	3c 2b                	cmp    $0x2b,%al
  102fee:	75 06                	jne    102ff6 <strtol+0x4c>
        s ++;
  102ff0:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  102ff4:	eb 15                	jmp    10300b <strtol+0x61>
    }
    else if (*s == '-') {
  102ff6:	8b 45 08             	mov    0x8(%ebp),%eax
  102ff9:	0f b6 00             	movzbl (%eax),%eax
  102ffc:	3c 2d                	cmp    $0x2d,%al
  102ffe:	75 0b                	jne    10300b <strtol+0x61>
        s ++, neg = 1;
  103000:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  103004:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
    }

    // hex or octal base prefix
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x')) {
  10300b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  10300f:	74 06                	je     103017 <strtol+0x6d>
  103011:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  103015:	75 24                	jne    10303b <strtol+0x91>
  103017:	8b 45 08             	mov    0x8(%ebp),%eax
  10301a:	0f b6 00             	movzbl (%eax),%eax
  10301d:	3c 30                	cmp    $0x30,%al
  10301f:	75 1a                	jne    10303b <strtol+0x91>
  103021:	8b 45 08             	mov    0x8(%ebp),%eax
  103024:	83 c0 01             	add    $0x1,%eax
  103027:	0f b6 00             	movzbl (%eax),%eax
  10302a:	3c 78                	cmp    $0x78,%al
  10302c:	75 0d                	jne    10303b <strtol+0x91>
        s += 2, base = 16;
  10302e:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  103032:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  103039:	eb 2a                	jmp    103065 <strtol+0xbb>
    }
    else if (base == 0 && s[0] == '0') {
  10303b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  10303f:	75 17                	jne    103058 <strtol+0xae>
  103041:	8b 45 08             	mov    0x8(%ebp),%eax
  103044:	0f b6 00             	movzbl (%eax),%eax
  103047:	3c 30                	cmp    $0x30,%al
  103049:	75 0d                	jne    103058 <strtol+0xae>
        s ++, base = 8;
  10304b:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  10304f:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  103056:	eb 0d                	jmp    103065 <strtol+0xbb>
    }
    else if (base == 0) {
  103058:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  10305c:	75 07                	jne    103065 <strtol+0xbb>
        base = 10;
  10305e:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

    // digits
    while (1) {
        int dig;

        if (*s >= '0' && *s <= '9') {
  103065:	8b 45 08             	mov    0x8(%ebp),%eax
  103068:	0f b6 00             	movzbl (%eax),%eax
  10306b:	3c 2f                	cmp    $0x2f,%al
  10306d:	7e 1b                	jle    10308a <strtol+0xe0>
  10306f:	8b 45 08             	mov    0x8(%ebp),%eax
  103072:	0f b6 00             	movzbl (%eax),%eax
  103075:	3c 39                	cmp    $0x39,%al
  103077:	7f 11                	jg     10308a <strtol+0xe0>
            dig = *s - '0';
  103079:	8b 45 08             	mov    0x8(%ebp),%eax
  10307c:	0f b6 00             	movzbl (%eax),%eax
  10307f:	0f be c0             	movsbl %al,%eax
  103082:	83 e8 30             	sub    $0x30,%eax
  103085:	89 45 f4             	mov    %eax,-0xc(%ebp)
  103088:	eb 48                	jmp    1030d2 <strtol+0x128>
        }
        else if (*s >= 'a' && *s <= 'z') {
  10308a:	8b 45 08             	mov    0x8(%ebp),%eax
  10308d:	0f b6 00             	movzbl (%eax),%eax
  103090:	3c 60                	cmp    $0x60,%al
  103092:	7e 1b                	jle    1030af <strtol+0x105>
  103094:	8b 45 08             	mov    0x8(%ebp),%eax
  103097:	0f b6 00             	movzbl (%eax),%eax
  10309a:	3c 7a                	cmp    $0x7a,%al
  10309c:	7f 11                	jg     1030af <strtol+0x105>
            dig = *s - 'a' + 10;
  10309e:	8b 45 08             	mov    0x8(%ebp),%eax
  1030a1:	0f b6 00             	movzbl (%eax),%eax
  1030a4:	0f be c0             	movsbl %al,%eax
  1030a7:	83 e8 57             	sub    $0x57,%eax
  1030aa:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1030ad:	eb 23                	jmp    1030d2 <strtol+0x128>
        }
        else if (*s >= 'A' && *s <= 'Z') {
  1030af:	8b 45 08             	mov    0x8(%ebp),%eax
  1030b2:	0f b6 00             	movzbl (%eax),%eax
  1030b5:	3c 40                	cmp    $0x40,%al
  1030b7:	7e 3c                	jle    1030f5 <strtol+0x14b>
  1030b9:	8b 45 08             	mov    0x8(%ebp),%eax
  1030bc:	0f b6 00             	movzbl (%eax),%eax
  1030bf:	3c 5a                	cmp    $0x5a,%al
  1030c1:	7f 32                	jg     1030f5 <strtol+0x14b>
            dig = *s - 'A' + 10;
  1030c3:	8b 45 08             	mov    0x8(%ebp),%eax
  1030c6:	0f b6 00             	movzbl (%eax),%eax
  1030c9:	0f be c0             	movsbl %al,%eax
  1030cc:	83 e8 37             	sub    $0x37,%eax
  1030cf:	89 45 f4             	mov    %eax,-0xc(%ebp)
        }
        else {
            break;
        }
        if (dig >= base) {
  1030d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1030d5:	3b 45 10             	cmp    0x10(%ebp),%eax
  1030d8:	7d 1a                	jge    1030f4 <strtol+0x14a>
            break;
        }
        s ++, val = (val * base) + dig;
  1030da:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  1030de:	8b 45 f8             	mov    -0x8(%ebp),%eax
  1030e1:	0f af 45 10          	imul   0x10(%ebp),%eax
  1030e5:	89 c2                	mov    %eax,%edx
  1030e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1030ea:	01 d0                	add    %edx,%eax
  1030ec:	89 45 f8             	mov    %eax,-0x8(%ebp)
    while (1) {
  1030ef:	e9 71 ff ff ff       	jmp    103065 <strtol+0xbb>
            break;
  1030f4:	90                   	nop
        // we don't properly detect overflow!
    }

    if (endptr) {
  1030f5:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  1030f9:	74 08                	je     103103 <strtol+0x159>
        *endptr = (char *) s;
  1030fb:	8b 45 0c             	mov    0xc(%ebp),%eax
  1030fe:	8b 55 08             	mov    0x8(%ebp),%edx
  103101:	89 10                	mov    %edx,(%eax)
    }
    return (neg ? -val : val);
  103103:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  103107:	74 07                	je     103110 <strtol+0x166>
  103109:	8b 45 f8             	mov    -0x8(%ebp),%eax
  10310c:	f7 d8                	neg    %eax
  10310e:	eb 03                	jmp    103113 <strtol+0x169>
  103110:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  103113:	c9                   	leave  
  103114:	c3                   	ret    

00103115 <memset>:
 * @n:        number of bytes to be set to the value
 *
 * The memset() function returns @s.
 * */
void *
memset(void *s, char c, size_t n) {
  103115:	f3 0f 1e fb          	endbr32 
  103119:	55                   	push   %ebp
  10311a:	89 e5                	mov    %esp,%ebp
  10311c:	57                   	push   %edi
  10311d:	83 ec 24             	sub    $0x24,%esp
  103120:	e8 7b d1 ff ff       	call   1002a0 <__x86.get_pc_thunk.ax>
  103125:	05 2b c8 00 00       	add    $0xc82b,%eax
  10312a:	8b 45 0c             	mov    0xc(%ebp),%eax
  10312d:	88 45 d8             	mov    %al,-0x28(%ebp)
#ifdef __HAVE_ARCH_MEMSET
    return __memset(s, c, n);
  103130:	0f be 45 d8          	movsbl -0x28(%ebp),%eax
  103134:	8b 55 08             	mov    0x8(%ebp),%edx
  103137:	89 55 f8             	mov    %edx,-0x8(%ebp)
  10313a:	88 45 f7             	mov    %al,-0x9(%ebp)
  10313d:	8b 45 10             	mov    0x10(%ebp),%eax
  103140:	89 45 f0             	mov    %eax,-0x10(%ebp)
#ifndef __HAVE_ARCH_MEMSET
#define __HAVE_ARCH_MEMSET
static inline void *
__memset(void *s, char c, size_t n) {
    int d0, d1;
    asm volatile (
  103143:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  103146:	0f b6 45 f7          	movzbl -0x9(%ebp),%eax
  10314a:	8b 55 f8             	mov    -0x8(%ebp),%edx
  10314d:	89 d7                	mov    %edx,%edi
  10314f:	f3 aa                	rep stos %al,%es:(%edi)
  103151:	89 fa                	mov    %edi,%edx
  103153:	89 4d ec             	mov    %ecx,-0x14(%ebp)
  103156:	89 55 e8             	mov    %edx,-0x18(%ebp)
            "rep; stosb;"
            : "=&c" (d0), "=&D" (d1)
            : "0" (n), "a" (c), "1" (s)
            : "memory");
    return s;
  103159:	8b 45 f8             	mov    -0x8(%ebp),%eax
    while (n -- > 0) {
        *p ++ = c;
    }
    return s;
#endif /* __HAVE_ARCH_MEMSET */
}
  10315c:	83 c4 24             	add    $0x24,%esp
  10315f:	5f                   	pop    %edi
  103160:	5d                   	pop    %ebp
  103161:	c3                   	ret    

00103162 <memmove>:
 * @n:        number of bytes to copy
 *
 * The memmove() function returns @dst.
 * */
void *
memmove(void *dst, const void *src, size_t n) {
  103162:	f3 0f 1e fb          	endbr32 
  103166:	55                   	push   %ebp
  103167:	89 e5                	mov    %esp,%ebp
  103169:	57                   	push   %edi
  10316a:	56                   	push   %esi
  10316b:	53                   	push   %ebx
  10316c:	83 ec 30             	sub    $0x30,%esp
  10316f:	e8 2c d1 ff ff       	call   1002a0 <__x86.get_pc_thunk.ax>
  103174:	05 dc c7 00 00       	add    $0xc7dc,%eax
  103179:	8b 45 08             	mov    0x8(%ebp),%eax
  10317c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  10317f:	8b 45 0c             	mov    0xc(%ebp),%eax
  103182:	89 45 ec             	mov    %eax,-0x14(%ebp)
  103185:	8b 45 10             	mov    0x10(%ebp),%eax
  103188:	89 45 e8             	mov    %eax,-0x18(%ebp)

#ifndef __HAVE_ARCH_MEMMOVE
#define __HAVE_ARCH_MEMMOVE
static inline void *
__memmove(void *dst, const void *src, size_t n) {
    if (dst < src) {
  10318b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10318e:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  103191:	73 42                	jae    1031d5 <memmove+0x73>
  103193:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103196:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  103199:	8b 45 ec             	mov    -0x14(%ebp),%eax
  10319c:	89 45 e0             	mov    %eax,-0x20(%ebp)
  10319f:	8b 45 e8             	mov    -0x18(%ebp),%eax
  1031a2:	89 45 dc             	mov    %eax,-0x24(%ebp)
            "andl $3, %%ecx;"
            "jz 1f;"
            "rep; movsb;"
            "1:"
            : "=&c" (d0), "=&D" (d1), "=&S" (d2)
            : "0" (n / 4), "g" (n), "1" (dst), "2" (src)
  1031a5:	8b 45 dc             	mov    -0x24(%ebp),%eax
  1031a8:	c1 e8 02             	shr    $0x2,%eax
  1031ab:	89 c1                	mov    %eax,%ecx
    asm volatile (
  1031ad:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  1031b0:	8b 45 e0             	mov    -0x20(%ebp),%eax
  1031b3:	89 d7                	mov    %edx,%edi
  1031b5:	89 c6                	mov    %eax,%esi
  1031b7:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  1031b9:	8b 4d dc             	mov    -0x24(%ebp),%ecx
  1031bc:	83 e1 03             	and    $0x3,%ecx
  1031bf:	74 02                	je     1031c3 <memmove+0x61>
  1031c1:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  1031c3:	89 f0                	mov    %esi,%eax
  1031c5:	89 fa                	mov    %edi,%edx
  1031c7:	89 4d d8             	mov    %ecx,-0x28(%ebp)
  1031ca:	89 55 d4             	mov    %edx,-0x2c(%ebp)
  1031cd:	89 45 d0             	mov    %eax,-0x30(%ebp)
            : "memory");
    return dst;
  1031d0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
        return __memcpy(dst, src, n);
  1031d3:	eb 36                	jmp    10320b <memmove+0xa9>
            : "0" (n), "1" (n - 1 + src), "2" (n - 1 + dst)
  1031d5:	8b 45 e8             	mov    -0x18(%ebp),%eax
  1031d8:	8d 50 ff             	lea    -0x1(%eax),%edx
  1031db:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1031de:	01 c2                	add    %eax,%edx
  1031e0:	8b 45 e8             	mov    -0x18(%ebp),%eax
  1031e3:	8d 48 ff             	lea    -0x1(%eax),%ecx
  1031e6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1031e9:	8d 1c 01             	lea    (%ecx,%eax,1),%ebx
    asm volatile (
  1031ec:	8b 45 e8             	mov    -0x18(%ebp),%eax
  1031ef:	89 c1                	mov    %eax,%ecx
  1031f1:	89 d8                	mov    %ebx,%eax
  1031f3:	89 d6                	mov    %edx,%esi
  1031f5:	89 c7                	mov    %eax,%edi
  1031f7:	fd                   	std    
  1031f8:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  1031fa:	fc                   	cld    
  1031fb:	89 f8                	mov    %edi,%eax
  1031fd:	89 f2                	mov    %esi,%edx
  1031ff:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  103202:	89 55 c8             	mov    %edx,-0x38(%ebp)
  103205:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    return dst;
  103208:	8b 45 f0             	mov    -0x10(%ebp),%eax
            *d ++ = *s ++;
        }
    }
    return dst;
#endif /* __HAVE_ARCH_MEMMOVE */
}
  10320b:	83 c4 30             	add    $0x30,%esp
  10320e:	5b                   	pop    %ebx
  10320f:	5e                   	pop    %esi
  103210:	5f                   	pop    %edi
  103211:	5d                   	pop    %ebp
  103212:	c3                   	ret    

00103213 <memcpy>:
 * it always copies exactly @n bytes. To avoid overflows, the size of arrays pointed
 * by both @src and @dst, should be at least @n bytes, and should not overlap
 * (for overlapping memory area, memmove is a safer approach).
 * */
void *
memcpy(void *dst, const void *src, size_t n) {
  103213:	f3 0f 1e fb          	endbr32 
  103217:	55                   	push   %ebp
  103218:	89 e5                	mov    %esp,%ebp
  10321a:	57                   	push   %edi
  10321b:	56                   	push   %esi
  10321c:	83 ec 20             	sub    $0x20,%esp
  10321f:	e8 7c d0 ff ff       	call   1002a0 <__x86.get_pc_thunk.ax>
  103224:	05 2c c7 00 00       	add    $0xc72c,%eax
  103229:	8b 45 08             	mov    0x8(%ebp),%eax
  10322c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  10322f:	8b 45 0c             	mov    0xc(%ebp),%eax
  103232:	89 45 f0             	mov    %eax,-0x10(%ebp)
  103235:	8b 45 10             	mov    0x10(%ebp),%eax
  103238:	89 45 ec             	mov    %eax,-0x14(%ebp)
            : "0" (n / 4), "g" (n), "1" (dst), "2" (src)
  10323b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  10323e:	c1 e8 02             	shr    $0x2,%eax
  103241:	89 c1                	mov    %eax,%ecx
    asm volatile (
  103243:	8b 55 f4             	mov    -0xc(%ebp),%edx
  103246:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103249:	89 d7                	mov    %edx,%edi
  10324b:	89 c6                	mov    %eax,%esi
  10324d:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  10324f:	8b 4d ec             	mov    -0x14(%ebp),%ecx
  103252:	83 e1 03             	and    $0x3,%ecx
  103255:	74 02                	je     103259 <memcpy+0x46>
  103257:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  103259:	89 f0                	mov    %esi,%eax
  10325b:	89 fa                	mov    %edi,%edx
  10325d:	89 4d e8             	mov    %ecx,-0x18(%ebp)
  103260:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  103263:	89 45 e0             	mov    %eax,-0x20(%ebp)
    return dst;
  103266:	8b 45 f4             	mov    -0xc(%ebp),%eax
    while (n -- > 0) {
        *d ++ = *s ++;
    }
    return dst;
#endif /* __HAVE_ARCH_MEMCPY */
}
  103269:	83 c4 20             	add    $0x20,%esp
  10326c:	5e                   	pop    %esi
  10326d:	5f                   	pop    %edi
  10326e:	5d                   	pop    %ebp
  10326f:	c3                   	ret    

00103270 <memcmp>:
 *   match in both memory blocks has a greater value in @v1 than in @v2
 *   as if evaluated as unsigned char values;
 * - And a value less than zero indicates the opposite.
 * */
int
memcmp(const void *v1, const void *v2, size_t n) {
  103270:	f3 0f 1e fb          	endbr32 
  103274:	55                   	push   %ebp
  103275:	89 e5                	mov    %esp,%ebp
  103277:	83 ec 10             	sub    $0x10,%esp
  10327a:	e8 21 d0 ff ff       	call   1002a0 <__x86.get_pc_thunk.ax>
  10327f:	05 d1 c6 00 00       	add    $0xc6d1,%eax
    const char *s1 = (const char *)v1;
  103284:	8b 45 08             	mov    0x8(%ebp),%eax
  103287:	89 45 fc             	mov    %eax,-0x4(%ebp)
    const char *s2 = (const char *)v2;
  10328a:	8b 45 0c             	mov    0xc(%ebp),%eax
  10328d:	89 45 f8             	mov    %eax,-0x8(%ebp)
    while (n -- > 0) {
  103290:	eb 30                	jmp    1032c2 <memcmp+0x52>
        if (*s1 != *s2) {
  103292:	8b 45 fc             	mov    -0x4(%ebp),%eax
  103295:	0f b6 10             	movzbl (%eax),%edx
  103298:	8b 45 f8             	mov    -0x8(%ebp),%eax
  10329b:	0f b6 00             	movzbl (%eax),%eax
  10329e:	38 c2                	cmp    %al,%dl
  1032a0:	74 18                	je     1032ba <memcmp+0x4a>
            return (int)((unsigned char)*s1 - (unsigned char)*s2);
  1032a2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1032a5:	0f b6 00             	movzbl (%eax),%eax
  1032a8:	0f b6 d0             	movzbl %al,%edx
  1032ab:	8b 45 f8             	mov    -0x8(%ebp),%eax
  1032ae:	0f b6 00             	movzbl (%eax),%eax
  1032b1:	0f b6 c0             	movzbl %al,%eax
  1032b4:	29 c2                	sub    %eax,%edx
  1032b6:	89 d0                	mov    %edx,%eax
  1032b8:	eb 1a                	jmp    1032d4 <memcmp+0x64>
        }
        s1 ++, s2 ++;
  1032ba:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  1032be:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    while (n -- > 0) {
  1032c2:	8b 45 10             	mov    0x10(%ebp),%eax
  1032c5:	8d 50 ff             	lea    -0x1(%eax),%edx
  1032c8:	89 55 10             	mov    %edx,0x10(%ebp)
  1032cb:	85 c0                	test   %eax,%eax
  1032cd:	75 c3                	jne    103292 <memcmp+0x22>
    }
    return 0;
  1032cf:	b8 00 00 00 00       	mov    $0x0,%eax
}
  1032d4:	c9                   	leave  
  1032d5:	c3                   	ret    

001032d6 <printnum>:
 * @width:         maximum number of digits, if the actual width is less than @width, use @padc instead
 * @padc:        character that padded on the left if the actual width is less than @width
 * */
static void
printnum(void (*putch)(int, void*), void *putdat,
        unsigned long long num, unsigned base, int width, int padc) {
  1032d6:	f3 0f 1e fb          	endbr32 
  1032da:	55                   	push   %ebp
  1032db:	89 e5                	mov    %esp,%ebp
  1032dd:	53                   	push   %ebx
  1032de:	83 ec 34             	sub    $0x34,%esp
  1032e1:	e8 be cf ff ff       	call   1002a4 <__x86.get_pc_thunk.bx>
  1032e6:	81 c3 6a c6 00 00    	add    $0xc66a,%ebx
  1032ec:	8b 45 10             	mov    0x10(%ebp),%eax
  1032ef:	89 45 d0             	mov    %eax,-0x30(%ebp)
  1032f2:	8b 45 14             	mov    0x14(%ebp),%eax
  1032f5:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    unsigned long long result = num;
  1032f8:	8b 45 d0             	mov    -0x30(%ebp),%eax
  1032fb:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  1032fe:	89 45 e8             	mov    %eax,-0x18(%ebp)
  103301:	89 55 ec             	mov    %edx,-0x14(%ebp)
    unsigned mod = do_div(result, base);
  103304:	8b 45 18             	mov    0x18(%ebp),%eax
  103307:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  10330a:	8b 45 e8             	mov    -0x18(%ebp),%eax
  10330d:	8b 55 ec             	mov    -0x14(%ebp),%edx
  103310:	89 45 e0             	mov    %eax,-0x20(%ebp)
  103313:	89 55 f0             	mov    %edx,-0x10(%ebp)
  103316:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103319:	89 45 f4             	mov    %eax,-0xc(%ebp)
  10331c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  103320:	74 1c                	je     10333e <printnum+0x68>
  103322:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103325:	ba 00 00 00 00       	mov    $0x0,%edx
  10332a:	f7 75 e4             	divl   -0x1c(%ebp)
  10332d:	89 55 f4             	mov    %edx,-0xc(%ebp)
  103330:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103333:	ba 00 00 00 00       	mov    $0x0,%edx
  103338:	f7 75 e4             	divl   -0x1c(%ebp)
  10333b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  10333e:	8b 45 e0             	mov    -0x20(%ebp),%eax
  103341:	8b 55 f4             	mov    -0xc(%ebp),%edx
  103344:	f7 75 e4             	divl   -0x1c(%ebp)
  103347:	89 45 e0             	mov    %eax,-0x20(%ebp)
  10334a:	89 55 dc             	mov    %edx,-0x24(%ebp)
  10334d:	8b 45 e0             	mov    -0x20(%ebp),%eax
  103350:	8b 55 f0             	mov    -0x10(%ebp),%edx
  103353:	89 45 e8             	mov    %eax,-0x18(%ebp)
  103356:	89 55 ec             	mov    %edx,-0x14(%ebp)
  103359:	8b 45 dc             	mov    -0x24(%ebp),%eax
  10335c:	89 45 d8             	mov    %eax,-0x28(%ebp)

    // first recursively print all preceding (more significant) digits
    if (num >= base) {
  10335f:	8b 45 18             	mov    0x18(%ebp),%eax
  103362:	ba 00 00 00 00       	mov    $0x0,%edx
  103367:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
  10336a:	39 45 d0             	cmp    %eax,-0x30(%ebp)
  10336d:	19 d1                	sbb    %edx,%ecx
  10336f:	72 37                	jb     1033a8 <printnum+0xd2>
        printnum(putch, putdat, result, base, width - 1, padc);
  103371:	8b 45 1c             	mov    0x1c(%ebp),%eax
  103374:	83 e8 01             	sub    $0x1,%eax
  103377:	83 ec 04             	sub    $0x4,%esp
  10337a:	ff 75 20             	pushl  0x20(%ebp)
  10337d:	50                   	push   %eax
  10337e:	ff 75 18             	pushl  0x18(%ebp)
  103381:	ff 75 ec             	pushl  -0x14(%ebp)
  103384:	ff 75 e8             	pushl  -0x18(%ebp)
  103387:	ff 75 0c             	pushl  0xc(%ebp)
  10338a:	ff 75 08             	pushl  0x8(%ebp)
  10338d:	e8 44 ff ff ff       	call   1032d6 <printnum>
  103392:	83 c4 20             	add    $0x20,%esp
  103395:	eb 1b                	jmp    1033b2 <printnum+0xdc>
    } else {
        // print any needed pad characters before first digit
        while (-- width > 0)
            putch(padc, putdat);
  103397:	83 ec 08             	sub    $0x8,%esp
  10339a:	ff 75 0c             	pushl  0xc(%ebp)
  10339d:	ff 75 20             	pushl  0x20(%ebp)
  1033a0:	8b 45 08             	mov    0x8(%ebp),%eax
  1033a3:	ff d0                	call   *%eax
  1033a5:	83 c4 10             	add    $0x10,%esp
        while (-- width > 0)
  1033a8:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
  1033ac:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  1033b0:	7f e5                	jg     103397 <printnum+0xc1>
    }
    // then print this (the least significant) digit
    putch("0123456789abcdef"[mod], putdat);
  1033b2:	8d 93 4a 47 ff ff    	lea    -0xb8b6(%ebx),%edx
  1033b8:	8b 45 d8             	mov    -0x28(%ebp),%eax
  1033bb:	01 d0                	add    %edx,%eax
  1033bd:	0f b6 00             	movzbl (%eax),%eax
  1033c0:	0f be c0             	movsbl %al,%eax
  1033c3:	83 ec 08             	sub    $0x8,%esp
  1033c6:	ff 75 0c             	pushl  0xc(%ebp)
  1033c9:	50                   	push   %eax
  1033ca:	8b 45 08             	mov    0x8(%ebp),%eax
  1033cd:	ff d0                	call   *%eax
  1033cf:	83 c4 10             	add    $0x10,%esp
}
  1033d2:	90                   	nop
  1033d3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  1033d6:	c9                   	leave  
  1033d7:	c3                   	ret    

001033d8 <getuint>:
 * getuint - get an unsigned int of various possible sizes from a varargs list
 * @ap:            a varargs list pointer
 * @lflag:        determines the size of the vararg that @ap points to
 * */
static unsigned long long
getuint(va_list *ap, int lflag) {
  1033d8:	f3 0f 1e fb          	endbr32 
  1033dc:	55                   	push   %ebp
  1033dd:	89 e5                	mov    %esp,%ebp
  1033df:	e8 bc ce ff ff       	call   1002a0 <__x86.get_pc_thunk.ax>
  1033e4:	05 6c c5 00 00       	add    $0xc56c,%eax
    if (lflag >= 2) {
  1033e9:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  1033ed:	7e 14                	jle    103403 <getuint+0x2b>
        return va_arg(*ap, unsigned long long);
  1033ef:	8b 45 08             	mov    0x8(%ebp),%eax
  1033f2:	8b 00                	mov    (%eax),%eax
  1033f4:	8d 48 08             	lea    0x8(%eax),%ecx
  1033f7:	8b 55 08             	mov    0x8(%ebp),%edx
  1033fa:	89 0a                	mov    %ecx,(%edx)
  1033fc:	8b 50 04             	mov    0x4(%eax),%edx
  1033ff:	8b 00                	mov    (%eax),%eax
  103401:	eb 30                	jmp    103433 <getuint+0x5b>
    }
    else if (lflag) {
  103403:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  103407:	74 16                	je     10341f <getuint+0x47>
        return va_arg(*ap, unsigned long);
  103409:	8b 45 08             	mov    0x8(%ebp),%eax
  10340c:	8b 00                	mov    (%eax),%eax
  10340e:	8d 48 04             	lea    0x4(%eax),%ecx
  103411:	8b 55 08             	mov    0x8(%ebp),%edx
  103414:	89 0a                	mov    %ecx,(%edx)
  103416:	8b 00                	mov    (%eax),%eax
  103418:	ba 00 00 00 00       	mov    $0x0,%edx
  10341d:	eb 14                	jmp    103433 <getuint+0x5b>
    }
    else {
        return va_arg(*ap, unsigned int);
  10341f:	8b 45 08             	mov    0x8(%ebp),%eax
  103422:	8b 00                	mov    (%eax),%eax
  103424:	8d 48 04             	lea    0x4(%eax),%ecx
  103427:	8b 55 08             	mov    0x8(%ebp),%edx
  10342a:	89 0a                	mov    %ecx,(%edx)
  10342c:	8b 00                	mov    (%eax),%eax
  10342e:	ba 00 00 00 00       	mov    $0x0,%edx
    }
}
  103433:	5d                   	pop    %ebp
  103434:	c3                   	ret    

00103435 <getint>:
 * getint - same as getuint but signed, we can't use getuint because of sign extension
 * @ap:            a varargs list pointer
 * @lflag:        determines the size of the vararg that @ap points to
 * */
static long long
getint(va_list *ap, int lflag) {
  103435:	f3 0f 1e fb          	endbr32 
  103439:	55                   	push   %ebp
  10343a:	89 e5                	mov    %esp,%ebp
  10343c:	e8 5f ce ff ff       	call   1002a0 <__x86.get_pc_thunk.ax>
  103441:	05 0f c5 00 00       	add    $0xc50f,%eax
    if (lflag >= 2) {
  103446:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  10344a:	7e 14                	jle    103460 <getint+0x2b>
        return va_arg(*ap, long long);
  10344c:	8b 45 08             	mov    0x8(%ebp),%eax
  10344f:	8b 00                	mov    (%eax),%eax
  103451:	8d 48 08             	lea    0x8(%eax),%ecx
  103454:	8b 55 08             	mov    0x8(%ebp),%edx
  103457:	89 0a                	mov    %ecx,(%edx)
  103459:	8b 50 04             	mov    0x4(%eax),%edx
  10345c:	8b 00                	mov    (%eax),%eax
  10345e:	eb 28                	jmp    103488 <getint+0x53>
    }
    else if (lflag) {
  103460:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  103464:	74 12                	je     103478 <getint+0x43>
        return va_arg(*ap, long);
  103466:	8b 45 08             	mov    0x8(%ebp),%eax
  103469:	8b 00                	mov    (%eax),%eax
  10346b:	8d 48 04             	lea    0x4(%eax),%ecx
  10346e:	8b 55 08             	mov    0x8(%ebp),%edx
  103471:	89 0a                	mov    %ecx,(%edx)
  103473:	8b 00                	mov    (%eax),%eax
  103475:	99                   	cltd   
  103476:	eb 10                	jmp    103488 <getint+0x53>
    }
    else {
        return va_arg(*ap, int);
  103478:	8b 45 08             	mov    0x8(%ebp),%eax
  10347b:	8b 00                	mov    (%eax),%eax
  10347d:	8d 48 04             	lea    0x4(%eax),%ecx
  103480:	8b 55 08             	mov    0x8(%ebp),%edx
  103483:	89 0a                	mov    %ecx,(%edx)
  103485:	8b 00                	mov    (%eax),%eax
  103487:	99                   	cltd   
    }
}
  103488:	5d                   	pop    %ebp
  103489:	c3                   	ret    

0010348a <printfmt>:
 * @putch:        specified putch function, print a single character
 * @putdat:        used by @putch function
 * @fmt:        the format string to use
 * */
void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
  10348a:	f3 0f 1e fb          	endbr32 
  10348e:	55                   	push   %ebp
  10348f:	89 e5                	mov    %esp,%ebp
  103491:	83 ec 18             	sub    $0x18,%esp
  103494:	e8 07 ce ff ff       	call   1002a0 <__x86.get_pc_thunk.ax>
  103499:	05 b7 c4 00 00       	add    $0xc4b7,%eax
    va_list ap;

    va_start(ap, fmt);
  10349e:	8d 45 14             	lea    0x14(%ebp),%eax
  1034a1:	89 45 f4             	mov    %eax,-0xc(%ebp)
    vprintfmt(putch, putdat, fmt, ap);
  1034a4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1034a7:	50                   	push   %eax
  1034a8:	ff 75 10             	pushl  0x10(%ebp)
  1034ab:	ff 75 0c             	pushl  0xc(%ebp)
  1034ae:	ff 75 08             	pushl  0x8(%ebp)
  1034b1:	e8 06 00 00 00       	call   1034bc <vprintfmt>
  1034b6:	83 c4 10             	add    $0x10,%esp
    va_end(ap);
}
  1034b9:	90                   	nop
  1034ba:	c9                   	leave  
  1034bb:	c3                   	ret    

001034bc <vprintfmt>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want printfmt() instead.
 * */
void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap) {
  1034bc:	f3 0f 1e fb          	endbr32 
  1034c0:	55                   	push   %ebp
  1034c1:	89 e5                	mov    %esp,%ebp
  1034c3:	57                   	push   %edi
  1034c4:	56                   	push   %esi
  1034c5:	53                   	push   %ebx
  1034c6:	83 ec 2c             	sub    $0x2c,%esp
  1034c9:	e8 99 04 00 00       	call   103967 <__x86.get_pc_thunk.di>
  1034ce:	81 c7 82 c4 00 00    	add    $0xc482,%edi
    register int ch, err;
    unsigned long long num;
    int base, width, precision, lflag, altflag;

    while (1) {
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  1034d4:	eb 17                	jmp    1034ed <vprintfmt+0x31>
            if (ch == '\0') {
  1034d6:	85 db                	test   %ebx,%ebx
  1034d8:	0f 84 9b 03 00 00    	je     103879 <.L22+0x2d>
                return;
            }
            putch(ch, putdat);
  1034de:	83 ec 08             	sub    $0x8,%esp
  1034e1:	ff 75 0c             	pushl  0xc(%ebp)
  1034e4:	53                   	push   %ebx
  1034e5:	8b 45 08             	mov    0x8(%ebp),%eax
  1034e8:	ff d0                	call   *%eax
  1034ea:	83 c4 10             	add    $0x10,%esp
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  1034ed:	8b 45 10             	mov    0x10(%ebp),%eax
  1034f0:	8d 50 01             	lea    0x1(%eax),%edx
  1034f3:	89 55 10             	mov    %edx,0x10(%ebp)
  1034f6:	0f b6 00             	movzbl (%eax),%eax
  1034f9:	0f b6 d8             	movzbl %al,%ebx
  1034fc:	83 fb 25             	cmp    $0x25,%ebx
  1034ff:	75 d5                	jne    1034d6 <vprintfmt+0x1a>
        }

        // Process a %-escape sequence
        char padc = ' ';
  103501:	c6 45 cb 20          	movb   $0x20,-0x35(%ebp)
        width = precision = -1;
  103505:	c7 45 d4 ff ff ff ff 	movl   $0xffffffff,-0x2c(%ebp)
  10350c:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  10350f:	89 45 d8             	mov    %eax,-0x28(%ebp)
        lflag = altflag = 0;
  103512:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
  103519:	8b 45 cc             	mov    -0x34(%ebp),%eax
  10351c:	89 45 d0             	mov    %eax,-0x30(%ebp)

    reswitch:
        switch (ch = *(unsigned char *)fmt ++) {
  10351f:	8b 45 10             	mov    0x10(%ebp),%eax
  103522:	8d 50 01             	lea    0x1(%eax),%edx
  103525:	89 55 10             	mov    %edx,0x10(%ebp)
  103528:	0f b6 00             	movzbl (%eax),%eax
  10352b:	0f b6 d8             	movzbl %al,%ebx
  10352e:	8d 43 dd             	lea    -0x23(%ebx),%eax
  103531:	83 f8 55             	cmp    $0x55,%eax
  103534:	0f 87 12 03 00 00    	ja     10384c <.L22>
  10353a:	c1 e0 02             	shl    $0x2,%eax
  10353d:	8b 84 38 70 47 ff ff 	mov    -0xb890(%eax,%edi,1),%eax
  103544:	01 f8                	add    %edi,%eax
  103546:	3e ff e0             	notrack jmp *%eax

00103549 <.L36>:

        // flag to pad on the right
        case '-':
            padc = '-';
  103549:	c6 45 cb 2d          	movb   $0x2d,-0x35(%ebp)
            goto reswitch;
  10354d:	eb d0                	jmp    10351f <vprintfmt+0x63>

0010354f <.L34>:

        // flag to pad with 0's instead of spaces
        case '0':
            padc = '0';
  10354f:	c6 45 cb 30          	movb   $0x30,-0x35(%ebp)
            goto reswitch;
  103553:	eb ca                	jmp    10351f <vprintfmt+0x63>

00103555 <.L33>:

        // width field
        case '1' ... '9':
            for (precision = 0; ; ++ fmt) {
  103555:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
                precision = precision * 10 + ch - '0';
  10355c:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  10355f:	89 d0                	mov    %edx,%eax
  103561:	c1 e0 02             	shl    $0x2,%eax
  103564:	01 d0                	add    %edx,%eax
  103566:	01 c0                	add    %eax,%eax
  103568:	01 d8                	add    %ebx,%eax
  10356a:	83 e8 30             	sub    $0x30,%eax
  10356d:	89 45 d4             	mov    %eax,-0x2c(%ebp)
                ch = *fmt;
  103570:	8b 45 10             	mov    0x10(%ebp),%eax
  103573:	0f b6 00             	movzbl (%eax),%eax
  103576:	0f be d8             	movsbl %al,%ebx
                if (ch < '0' || ch > '9') {
  103579:	83 fb 2f             	cmp    $0x2f,%ebx
  10357c:	7e 39                	jle    1035b7 <.L39+0xc>
  10357e:	83 fb 39             	cmp    $0x39,%ebx
  103581:	7f 34                	jg     1035b7 <.L39+0xc>
            for (precision = 0; ; ++ fmt) {
  103583:	83 45 10 01          	addl   $0x1,0x10(%ebp)
                precision = precision * 10 + ch - '0';
  103587:	eb d3                	jmp    10355c <.L33+0x7>

00103589 <.L37>:
                }
            }
            goto process_precision;

        case '*':
            precision = va_arg(ap, int);
  103589:	8b 45 14             	mov    0x14(%ebp),%eax
  10358c:	8d 50 04             	lea    0x4(%eax),%edx
  10358f:	89 55 14             	mov    %edx,0x14(%ebp)
  103592:	8b 00                	mov    (%eax),%eax
  103594:	89 45 d4             	mov    %eax,-0x2c(%ebp)
            goto process_precision;
  103597:	eb 1f                	jmp    1035b8 <.L39+0xd>

00103599 <.L35>:

        case '.':
            if (width < 0)
  103599:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
  10359d:	79 80                	jns    10351f <vprintfmt+0x63>
                width = 0;
  10359f:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
            goto reswitch;
  1035a6:	e9 74 ff ff ff       	jmp    10351f <vprintfmt+0x63>

001035ab <.L39>:

        case '#':
            altflag = 1;
  1035ab:	c7 45 cc 01 00 00 00 	movl   $0x1,-0x34(%ebp)
            goto reswitch;
  1035b2:	e9 68 ff ff ff       	jmp    10351f <vprintfmt+0x63>
            goto process_precision;
  1035b7:	90                   	nop

        process_precision:
            if (width < 0)
  1035b8:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
  1035bc:	0f 89 5d ff ff ff    	jns    10351f <vprintfmt+0x63>
                width = precision, precision = -1;
  1035c2:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  1035c5:	89 45 d8             	mov    %eax,-0x28(%ebp)
  1035c8:	c7 45 d4 ff ff ff ff 	movl   $0xffffffff,-0x2c(%ebp)
            goto reswitch;
  1035cf:	e9 4b ff ff ff       	jmp    10351f <vprintfmt+0x63>

001035d4 <.L29>:

        // long flag (doubled for long long)
        case 'l':
            lflag ++;
  1035d4:	83 45 d0 01          	addl   $0x1,-0x30(%ebp)
            goto reswitch;
  1035d8:	e9 42 ff ff ff       	jmp    10351f <vprintfmt+0x63>

001035dd <.L32>:

        // character
        case 'c':
            putch(va_arg(ap, int), putdat);
  1035dd:	8b 45 14             	mov    0x14(%ebp),%eax
  1035e0:	8d 50 04             	lea    0x4(%eax),%edx
  1035e3:	89 55 14             	mov    %edx,0x14(%ebp)
  1035e6:	8b 00                	mov    (%eax),%eax
  1035e8:	83 ec 08             	sub    $0x8,%esp
  1035eb:	ff 75 0c             	pushl  0xc(%ebp)
  1035ee:	50                   	push   %eax
  1035ef:	8b 45 08             	mov    0x8(%ebp),%eax
  1035f2:	ff d0                	call   *%eax
  1035f4:	83 c4 10             	add    $0x10,%esp
            break;
  1035f7:	e9 78 02 00 00       	jmp    103874 <.L22+0x28>

001035fc <.L30>:

        // error message
        case 'e':
            err = va_arg(ap, int);
  1035fc:	8b 45 14             	mov    0x14(%ebp),%eax
  1035ff:	8d 50 04             	lea    0x4(%eax),%edx
  103602:	89 55 14             	mov    %edx,0x14(%ebp)
  103605:	8b 18                	mov    (%eax),%ebx
            if (err < 0) {
  103607:	85 db                	test   %ebx,%ebx
  103609:	79 02                	jns    10360d <.L30+0x11>
                err = -err;
  10360b:	f7 db                	neg    %ebx
            }
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
  10360d:	83 fb 06             	cmp    $0x6,%ebx
  103610:	7f 0b                	jg     10361d <.L30+0x21>
  103612:	8b b4 9f 40 01 00 00 	mov    0x140(%edi,%ebx,4),%esi
  103619:	85 f6                	test   %esi,%esi
  10361b:	75 1b                	jne    103638 <.L30+0x3c>
                printfmt(putch, putdat, "error %d", err);
  10361d:	53                   	push   %ebx
  10361e:	8d 87 5b 47 ff ff    	lea    -0xb8a5(%edi),%eax
  103624:	50                   	push   %eax
  103625:	ff 75 0c             	pushl  0xc(%ebp)
  103628:	ff 75 08             	pushl  0x8(%ebp)
  10362b:	e8 5a fe ff ff       	call   10348a <printfmt>
  103630:	83 c4 10             	add    $0x10,%esp
            }
            else {
                printfmt(putch, putdat, "%s", p);
            }
            break;
  103633:	e9 3c 02 00 00       	jmp    103874 <.L22+0x28>
                printfmt(putch, putdat, "%s", p);
  103638:	56                   	push   %esi
  103639:	8d 87 64 47 ff ff    	lea    -0xb89c(%edi),%eax
  10363f:	50                   	push   %eax
  103640:	ff 75 0c             	pushl  0xc(%ebp)
  103643:	ff 75 08             	pushl  0x8(%ebp)
  103646:	e8 3f fe ff ff       	call   10348a <printfmt>
  10364b:	83 c4 10             	add    $0x10,%esp
            break;
  10364e:	e9 21 02 00 00       	jmp    103874 <.L22+0x28>

00103653 <.L26>:

        // string
        case 's':
            if ((p = va_arg(ap, char *)) == NULL) {
  103653:	8b 45 14             	mov    0x14(%ebp),%eax
  103656:	8d 50 04             	lea    0x4(%eax),%edx
  103659:	89 55 14             	mov    %edx,0x14(%ebp)
  10365c:	8b 30                	mov    (%eax),%esi
  10365e:	85 f6                	test   %esi,%esi
  103660:	75 06                	jne    103668 <.L26+0x15>
                p = "(null)";
  103662:	8d b7 67 47 ff ff    	lea    -0xb899(%edi),%esi
            }
            if (width > 0 && padc != '-') {
  103668:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
  10366c:	7e 78                	jle    1036e6 <.L26+0x93>
  10366e:	80 7d cb 2d          	cmpb   $0x2d,-0x35(%ebp)
  103672:	74 72                	je     1036e6 <.L26+0x93>
                for (width -= strnlen(p, precision); width > 0; width --) {
  103674:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  103677:	83 ec 08             	sub    $0x8,%esp
  10367a:	50                   	push   %eax
  10367b:	56                   	push   %esi
  10367c:	89 fb                	mov    %edi,%ebx
  10367e:	e8 1b f7 ff ff       	call   102d9e <strnlen>
  103683:	83 c4 10             	add    $0x10,%esp
  103686:	8b 55 d8             	mov    -0x28(%ebp),%edx
  103689:	29 c2                	sub    %eax,%edx
  10368b:	89 d0                	mov    %edx,%eax
  10368d:	89 45 d8             	mov    %eax,-0x28(%ebp)
  103690:	eb 17                	jmp    1036a9 <.L26+0x56>
                    putch(padc, putdat);
  103692:	0f be 45 cb          	movsbl -0x35(%ebp),%eax
  103696:	83 ec 08             	sub    $0x8,%esp
  103699:	ff 75 0c             	pushl  0xc(%ebp)
  10369c:	50                   	push   %eax
  10369d:	8b 45 08             	mov    0x8(%ebp),%eax
  1036a0:	ff d0                	call   *%eax
  1036a2:	83 c4 10             	add    $0x10,%esp
                for (width -= strnlen(p, precision); width > 0; width --) {
  1036a5:	83 6d d8 01          	subl   $0x1,-0x28(%ebp)
  1036a9:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
  1036ad:	7f e3                	jg     103692 <.L26+0x3f>
                }
            }
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  1036af:	eb 35                	jmp    1036e6 <.L26+0x93>
                if (altflag && (ch < ' ' || ch > '~')) {
  1036b1:	83 7d cc 00          	cmpl   $0x0,-0x34(%ebp)
  1036b5:	74 1c                	je     1036d3 <.L26+0x80>
  1036b7:	83 fb 1f             	cmp    $0x1f,%ebx
  1036ba:	7e 05                	jle    1036c1 <.L26+0x6e>
  1036bc:	83 fb 7e             	cmp    $0x7e,%ebx
  1036bf:	7e 12                	jle    1036d3 <.L26+0x80>
                    putch('?', putdat);
  1036c1:	83 ec 08             	sub    $0x8,%esp
  1036c4:	ff 75 0c             	pushl  0xc(%ebp)
  1036c7:	6a 3f                	push   $0x3f
  1036c9:	8b 45 08             	mov    0x8(%ebp),%eax
  1036cc:	ff d0                	call   *%eax
  1036ce:	83 c4 10             	add    $0x10,%esp
  1036d1:	eb 0f                	jmp    1036e2 <.L26+0x8f>
                }
                else {
                    putch(ch, putdat);
  1036d3:	83 ec 08             	sub    $0x8,%esp
  1036d6:	ff 75 0c             	pushl  0xc(%ebp)
  1036d9:	53                   	push   %ebx
  1036da:	8b 45 08             	mov    0x8(%ebp),%eax
  1036dd:	ff d0                	call   *%eax
  1036df:	83 c4 10             	add    $0x10,%esp
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  1036e2:	83 6d d8 01          	subl   $0x1,-0x28(%ebp)
  1036e6:	89 f0                	mov    %esi,%eax
  1036e8:	8d 70 01             	lea    0x1(%eax),%esi
  1036eb:	0f b6 00             	movzbl (%eax),%eax
  1036ee:	0f be d8             	movsbl %al,%ebx
  1036f1:	85 db                	test   %ebx,%ebx
  1036f3:	74 26                	je     10371b <.L26+0xc8>
  1036f5:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
  1036f9:	78 b6                	js     1036b1 <.L26+0x5e>
  1036fb:	83 6d d4 01          	subl   $0x1,-0x2c(%ebp)
  1036ff:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
  103703:	79 ac                	jns    1036b1 <.L26+0x5e>
                }
            }
            for (; width > 0; width --) {
  103705:	eb 14                	jmp    10371b <.L26+0xc8>
                putch(' ', putdat);
  103707:	83 ec 08             	sub    $0x8,%esp
  10370a:	ff 75 0c             	pushl  0xc(%ebp)
  10370d:	6a 20                	push   $0x20
  10370f:	8b 45 08             	mov    0x8(%ebp),%eax
  103712:	ff d0                	call   *%eax
  103714:	83 c4 10             	add    $0x10,%esp
            for (; width > 0; width --) {
  103717:	83 6d d8 01          	subl   $0x1,-0x28(%ebp)
  10371b:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
  10371f:	7f e6                	jg     103707 <.L26+0xb4>
            }
            break;
  103721:	e9 4e 01 00 00       	jmp    103874 <.L22+0x28>

00103726 <.L31>:

        // (signed) decimal
        case 'd':
            num = getint(&ap, lflag);
  103726:	83 ec 08             	sub    $0x8,%esp
  103729:	ff 75 d0             	pushl  -0x30(%ebp)
  10372c:	8d 45 14             	lea    0x14(%ebp),%eax
  10372f:	50                   	push   %eax
  103730:	e8 00 fd ff ff       	call   103435 <getint>
  103735:	83 c4 10             	add    $0x10,%esp
  103738:	89 45 e0             	mov    %eax,-0x20(%ebp)
  10373b:	89 55 e4             	mov    %edx,-0x1c(%ebp)
            if ((long long)num < 0) {
  10373e:	8b 45 e0             	mov    -0x20(%ebp),%eax
  103741:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  103744:	85 d2                	test   %edx,%edx
  103746:	79 23                	jns    10376b <.L31+0x45>
                putch('-', putdat);
  103748:	83 ec 08             	sub    $0x8,%esp
  10374b:	ff 75 0c             	pushl  0xc(%ebp)
  10374e:	6a 2d                	push   $0x2d
  103750:	8b 45 08             	mov    0x8(%ebp),%eax
  103753:	ff d0                	call   *%eax
  103755:	83 c4 10             	add    $0x10,%esp
                num = -(long long)num;
  103758:	8b 45 e0             	mov    -0x20(%ebp),%eax
  10375b:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  10375e:	f7 d8                	neg    %eax
  103760:	83 d2 00             	adc    $0x0,%edx
  103763:	f7 da                	neg    %edx
  103765:	89 45 e0             	mov    %eax,-0x20(%ebp)
  103768:	89 55 e4             	mov    %edx,-0x1c(%ebp)
            }
            base = 10;
  10376b:	c7 45 dc 0a 00 00 00 	movl   $0xa,-0x24(%ebp)
            goto number;
  103772:	e9 9f 00 00 00       	jmp    103816 <.L23+0x1f>

00103777 <.L25>:

        // unsigned decimal
        case 'u':
            num = getuint(&ap, lflag);
  103777:	83 ec 08             	sub    $0x8,%esp
  10377a:	ff 75 d0             	pushl  -0x30(%ebp)
  10377d:	8d 45 14             	lea    0x14(%ebp),%eax
  103780:	50                   	push   %eax
  103781:	e8 52 fc ff ff       	call   1033d8 <getuint>
  103786:	83 c4 10             	add    $0x10,%esp
  103789:	89 45 e0             	mov    %eax,-0x20(%ebp)
  10378c:	89 55 e4             	mov    %edx,-0x1c(%ebp)
            base = 10;
  10378f:	c7 45 dc 0a 00 00 00 	movl   $0xa,-0x24(%ebp)
            goto number;
  103796:	eb 7e                	jmp    103816 <.L23+0x1f>

00103798 <.L28>:

        // (unsigned) octal
        case 'o':
            num = getuint(&ap, lflag);
  103798:	83 ec 08             	sub    $0x8,%esp
  10379b:	ff 75 d0             	pushl  -0x30(%ebp)
  10379e:	8d 45 14             	lea    0x14(%ebp),%eax
  1037a1:	50                   	push   %eax
  1037a2:	e8 31 fc ff ff       	call   1033d8 <getuint>
  1037a7:	83 c4 10             	add    $0x10,%esp
  1037aa:	89 45 e0             	mov    %eax,-0x20(%ebp)
  1037ad:	89 55 e4             	mov    %edx,-0x1c(%ebp)
            base = 8;
  1037b0:	c7 45 dc 08 00 00 00 	movl   $0x8,-0x24(%ebp)
            goto number;
  1037b7:	eb 5d                	jmp    103816 <.L23+0x1f>

001037b9 <.L27>:

        // pointer
        case 'p':
            putch('0', putdat);
  1037b9:	83 ec 08             	sub    $0x8,%esp
  1037bc:	ff 75 0c             	pushl  0xc(%ebp)
  1037bf:	6a 30                	push   $0x30
  1037c1:	8b 45 08             	mov    0x8(%ebp),%eax
  1037c4:	ff d0                	call   *%eax
  1037c6:	83 c4 10             	add    $0x10,%esp
            putch('x', putdat);
  1037c9:	83 ec 08             	sub    $0x8,%esp
  1037cc:	ff 75 0c             	pushl  0xc(%ebp)
  1037cf:	6a 78                	push   $0x78
  1037d1:	8b 45 08             	mov    0x8(%ebp),%eax
  1037d4:	ff d0                	call   *%eax
  1037d6:	83 c4 10             	add    $0x10,%esp
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
  1037d9:	8b 45 14             	mov    0x14(%ebp),%eax
  1037dc:	8d 50 04             	lea    0x4(%eax),%edx
  1037df:	89 55 14             	mov    %edx,0x14(%ebp)
  1037e2:	8b 00                	mov    (%eax),%eax
  1037e4:	89 45 e0             	mov    %eax,-0x20(%ebp)
  1037e7:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
            base = 16;
  1037ee:	c7 45 dc 10 00 00 00 	movl   $0x10,-0x24(%ebp)
            goto number;
  1037f5:	eb 1f                	jmp    103816 <.L23+0x1f>

001037f7 <.L23>:

        // (unsigned) hexadecimal
        case 'x':
            num = getuint(&ap, lflag);
  1037f7:	83 ec 08             	sub    $0x8,%esp
  1037fa:	ff 75 d0             	pushl  -0x30(%ebp)
  1037fd:	8d 45 14             	lea    0x14(%ebp),%eax
  103800:	50                   	push   %eax
  103801:	e8 d2 fb ff ff       	call   1033d8 <getuint>
  103806:	83 c4 10             	add    $0x10,%esp
  103809:	89 45 e0             	mov    %eax,-0x20(%ebp)
  10380c:	89 55 e4             	mov    %edx,-0x1c(%ebp)
            base = 16;
  10380f:	c7 45 dc 10 00 00 00 	movl   $0x10,-0x24(%ebp)
        number:
            printnum(putch, putdat, num, base, width, padc);
  103816:	0f be 55 cb          	movsbl -0x35(%ebp),%edx
  10381a:	8b 45 dc             	mov    -0x24(%ebp),%eax
  10381d:	83 ec 04             	sub    $0x4,%esp
  103820:	52                   	push   %edx
  103821:	ff 75 d8             	pushl  -0x28(%ebp)
  103824:	50                   	push   %eax
  103825:	ff 75 e4             	pushl  -0x1c(%ebp)
  103828:	ff 75 e0             	pushl  -0x20(%ebp)
  10382b:	ff 75 0c             	pushl  0xc(%ebp)
  10382e:	ff 75 08             	pushl  0x8(%ebp)
  103831:	e8 a0 fa ff ff       	call   1032d6 <printnum>
  103836:	83 c4 20             	add    $0x20,%esp
            break;
  103839:	eb 39                	jmp    103874 <.L22+0x28>

0010383b <.L38>:

        // escaped '%' character
        case '%':
            putch(ch, putdat);
  10383b:	83 ec 08             	sub    $0x8,%esp
  10383e:	ff 75 0c             	pushl  0xc(%ebp)
  103841:	53                   	push   %ebx
  103842:	8b 45 08             	mov    0x8(%ebp),%eax
  103845:	ff d0                	call   *%eax
  103847:	83 c4 10             	add    $0x10,%esp
            break;
  10384a:	eb 28                	jmp    103874 <.L22+0x28>

0010384c <.L22>:

        // unrecognized escape sequence - just print it literally
        default:
            putch('%', putdat);
  10384c:	83 ec 08             	sub    $0x8,%esp
  10384f:	ff 75 0c             	pushl  0xc(%ebp)
  103852:	6a 25                	push   $0x25
  103854:	8b 45 08             	mov    0x8(%ebp),%eax
  103857:	ff d0                	call   *%eax
  103859:	83 c4 10             	add    $0x10,%esp
            for (fmt --; fmt[-1] != '%'; fmt --)
  10385c:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
  103860:	eb 04                	jmp    103866 <.L22+0x1a>
  103862:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
  103866:	8b 45 10             	mov    0x10(%ebp),%eax
  103869:	83 e8 01             	sub    $0x1,%eax
  10386c:	0f b6 00             	movzbl (%eax),%eax
  10386f:	3c 25                	cmp    $0x25,%al
  103871:	75 ef                	jne    103862 <.L22+0x16>
                /* do nothing */;
            break;
  103873:	90                   	nop
    while (1) {
  103874:	e9 5b fc ff ff       	jmp    1034d4 <vprintfmt+0x18>
                return;
  103879:	90                   	nop
        }
    }
}
  10387a:	8d 65 f4             	lea    -0xc(%ebp),%esp
  10387d:	5b                   	pop    %ebx
  10387e:	5e                   	pop    %esi
  10387f:	5f                   	pop    %edi
  103880:	5d                   	pop    %ebp
  103881:	c3                   	ret    

00103882 <sprintputch>:
 * sprintputch - 'print' a single character in a buffer
 * @ch:            the character will be printed
 * @b:            the buffer to place the character @ch
 * */
static void
sprintputch(int ch, struct sprintbuf *b) {
  103882:	f3 0f 1e fb          	endbr32 
  103886:	55                   	push   %ebp
  103887:	89 e5                	mov    %esp,%ebp
  103889:	e8 12 ca ff ff       	call   1002a0 <__x86.get_pc_thunk.ax>
  10388e:	05 c2 c0 00 00       	add    $0xc0c2,%eax
    b->cnt ++;
  103893:	8b 45 0c             	mov    0xc(%ebp),%eax
  103896:	8b 40 08             	mov    0x8(%eax),%eax
  103899:	8d 50 01             	lea    0x1(%eax),%edx
  10389c:	8b 45 0c             	mov    0xc(%ebp),%eax
  10389f:	89 50 08             	mov    %edx,0x8(%eax)
    if (b->buf < b->ebuf) {
  1038a2:	8b 45 0c             	mov    0xc(%ebp),%eax
  1038a5:	8b 10                	mov    (%eax),%edx
  1038a7:	8b 45 0c             	mov    0xc(%ebp),%eax
  1038aa:	8b 40 04             	mov    0x4(%eax),%eax
  1038ad:	39 c2                	cmp    %eax,%edx
  1038af:	73 12                	jae    1038c3 <sprintputch+0x41>
        *b->buf ++ = ch;
  1038b1:	8b 45 0c             	mov    0xc(%ebp),%eax
  1038b4:	8b 00                	mov    (%eax),%eax
  1038b6:	8d 48 01             	lea    0x1(%eax),%ecx
  1038b9:	8b 55 0c             	mov    0xc(%ebp),%edx
  1038bc:	89 0a                	mov    %ecx,(%edx)
  1038be:	8b 55 08             	mov    0x8(%ebp),%edx
  1038c1:	88 10                	mov    %dl,(%eax)
    }
}
  1038c3:	90                   	nop
  1038c4:	5d                   	pop    %ebp
  1038c5:	c3                   	ret    

001038c6 <snprintf>:
 * @str:        the buffer to place the result into
 * @size:        the size of buffer, including the trailing null space
 * @fmt:        the format string to use
 * */
int
snprintf(char *str, size_t size, const char *fmt, ...) {
  1038c6:	f3 0f 1e fb          	endbr32 
  1038ca:	55                   	push   %ebp
  1038cb:	89 e5                	mov    %esp,%ebp
  1038cd:	83 ec 18             	sub    $0x18,%esp
  1038d0:	e8 cb c9 ff ff       	call   1002a0 <__x86.get_pc_thunk.ax>
  1038d5:	05 7b c0 00 00       	add    $0xc07b,%eax
    va_list ap;
    int cnt;
    va_start(ap, fmt);
  1038da:	8d 45 14             	lea    0x14(%ebp),%eax
  1038dd:	89 45 f0             	mov    %eax,-0x10(%ebp)
    cnt = vsnprintf(str, size, fmt, ap);
  1038e0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1038e3:	50                   	push   %eax
  1038e4:	ff 75 10             	pushl  0x10(%ebp)
  1038e7:	ff 75 0c             	pushl  0xc(%ebp)
  1038ea:	ff 75 08             	pushl  0x8(%ebp)
  1038ed:	e8 0b 00 00 00       	call   1038fd <vsnprintf>
  1038f2:	83 c4 10             	add    $0x10,%esp
  1038f5:	89 45 f4             	mov    %eax,-0xc(%ebp)
    va_end(ap);
    return cnt;
  1038f8:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  1038fb:	c9                   	leave  
  1038fc:	c3                   	ret    

001038fd <vsnprintf>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want snprintf() instead.
 * */
int
vsnprintf(char *str, size_t size, const char *fmt, va_list ap) {
  1038fd:	f3 0f 1e fb          	endbr32 
  103901:	55                   	push   %ebp
  103902:	89 e5                	mov    %esp,%ebp
  103904:	83 ec 18             	sub    $0x18,%esp
  103907:	e8 94 c9 ff ff       	call   1002a0 <__x86.get_pc_thunk.ax>
  10390c:	05 44 c0 00 00       	add    $0xc044,%eax
    struct sprintbuf b = {str, str + size - 1, 0};
  103911:	8b 55 08             	mov    0x8(%ebp),%edx
  103914:	89 55 ec             	mov    %edx,-0x14(%ebp)
  103917:	8b 55 0c             	mov    0xc(%ebp),%edx
  10391a:	8d 4a ff             	lea    -0x1(%edx),%ecx
  10391d:	8b 55 08             	mov    0x8(%ebp),%edx
  103920:	01 ca                	add    %ecx,%edx
  103922:	89 55 f0             	mov    %edx,-0x10(%ebp)
  103925:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if (str == NULL || b.buf > b.ebuf) {
  10392c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  103930:	74 0a                	je     10393c <vsnprintf+0x3f>
  103932:	8b 4d ec             	mov    -0x14(%ebp),%ecx
  103935:	8b 55 f0             	mov    -0x10(%ebp),%edx
  103938:	39 d1                	cmp    %edx,%ecx
  10393a:	76 07                	jbe    103943 <vsnprintf+0x46>
        return -E_INVAL;
  10393c:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  103941:	eb 22                	jmp    103965 <vsnprintf+0x68>
    }
    // print the string to the buffer
    vprintfmt((void*)sprintputch, &b, fmt, ap);
  103943:	ff 75 14             	pushl  0x14(%ebp)
  103946:	ff 75 10             	pushl  0x10(%ebp)
  103949:	8d 55 ec             	lea    -0x14(%ebp),%edx
  10394c:	52                   	push   %edx
  10394d:	8d 80 32 3f ff ff    	lea    -0xc0ce(%eax),%eax
  103953:	50                   	push   %eax
  103954:	e8 63 fb ff ff       	call   1034bc <vprintfmt>
  103959:	83 c4 10             	add    $0x10,%esp
    // null terminate the buffer
    *b.buf = '\0';
  10395c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  10395f:	c6 00 00             	movb   $0x0,(%eax)
    return b.cnt;
  103962:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  103965:	c9                   	leave  
  103966:	c3                   	ret    

00103967 <__x86.get_pc_thunk.di>:
  103967:	8b 3c 24             	mov    (%esp),%edi
  10396a:	c3                   	ret    
