
bin/kernel_nopage：     文件格式 elf32-i386


Disassembly of section .text:

00100000 <kern_entry>:
.text
.globl kern_entry
kern_entry:
    # reload temperate gdt (second time) to remap all physical memory
    # virtual_addr 0~4G=linear_addr&physical_addr -KERNBASE~4G-KERNBASE 
    lgdt REALLOC(__gdtdesc)
  100000:	0f 01 15 18 90 11 40 	lgdtl  0x40119018
    movl $KERNEL_DS, %eax
  100007:	b8 10 00 00 00       	mov    $0x10,%eax
    movw %ax, %ds
  10000c:	8e d8                	mov    %eax,%ds
    movw %ax, %es
  10000e:	8e c0                	mov    %eax,%es
    movw %ax, %ss
  100010:	8e d0                	mov    %eax,%ss

    ljmp $KERNEL_CS, $relocated
  100012:	ea 19 00 10 00 08 00 	ljmp   $0x8,$0x100019

00100019 <relocated>:

relocated:

    # set ebp, esp
    movl $0x0, %ebp
  100019:	bd 00 00 00 00       	mov    $0x0,%ebp
    # the kernel stack region is from bootstack -- bootstacktop,
    # the kernel stack size is KSTACKSIZE (8KB)defined in memlayout.h
    movl $bootstacktop, %esp
  10001e:	bc 00 90 11 00       	mov    $0x119000,%esp
    # now kernel stack is ready , call the first C function
    call kern_init
  100023:	e8 02 00 00 00       	call   10002a <kern_init>

00100028 <spin>:

# should never get here
spin:
    jmp spin
  100028:	eb fe                	jmp    100028 <spin>

0010002a <kern_init>:
int kern_init(void) __attribute__((noreturn));
void grade_backtrace(void);
static void lab1_switch_test(void);

int
kern_init(void) {
  10002a:	f3 0f 1e fb          	endbr32 
  10002e:	55                   	push   %ebp
  10002f:	89 e5                	mov    %esp,%ebp
  100031:	83 ec 18             	sub    $0x18,%esp
    extern char edata[], end[];
    memset(edata, 0, end - edata);
  100034:	b8 68 a9 11 00       	mov    $0x11a968,%eax
  100039:	2d 36 9a 11 00       	sub    $0x119a36,%eax
  10003e:	83 ec 04             	sub    $0x4,%esp
  100041:	50                   	push   %eax
  100042:	6a 00                	push   $0x0
  100044:	68 36 9a 11 00       	push   $0x119a36
  100049:	e8 ea 54 00 00       	call   105538 <memset>
  10004e:	83 c4 10             	add    $0x10,%esp

    cons_init();                // init the console
  100051:	e8 42 16 00 00       	call   101698 <cons_init>

    const char *message = "(THU.CST) os is loading ...";
  100056:	c7 45 f4 00 5d 10 00 	movl   $0x105d00,-0xc(%ebp)
    cprintf("%s\n\n", message);
  10005d:	83 ec 08             	sub    $0x8,%esp
  100060:	ff 75 f4             	pushl  -0xc(%ebp)
  100063:	68 1c 5d 10 00       	push   $0x105d1c
  100068:	e8 22 02 00 00       	call   10028f <cprintf>
  10006d:	83 c4 10             	add    $0x10,%esp

    print_kerninfo();
  100070:	e8 c1 08 00 00       	call   100936 <print_kerninfo>

    grade_backtrace();
  100075:	e8 80 00 00 00       	call   1000fa <grade_backtrace>

    pmm_init();                 // init physical memory management
  10007a:	e8 29 32 00 00       	call   1032a8 <pmm_init>

    pic_init();                 // init interrupt controller
  10007f:	e8 9c 17 00 00       	call   101820 <pic_init>
    idt_init();                 // init interrupt descriptor table
  100084:	e8 1d 19 00 00       	call   1019a6 <idt_init>

    clock_init();               // init clock interrupt
  100089:	e8 51 0d 00 00       	call   100ddf <clock_init>
    intr_enable();              // enable irq interrupt
  10008e:	e8 dc 18 00 00       	call   10196f <intr_enable>
    //LAB1: CAHLLENGE 1 If you try to do it, uncomment lab1_switch_test()
    // user/kernel mode switch test
    //lab1_switch_test();

    /* do nothing */
    while (1);
  100093:	eb fe                	jmp    100093 <kern_init+0x69>

00100095 <grade_backtrace2>:
}

void __attribute__((noinline))
grade_backtrace2(int arg0, int arg1, int arg2, int arg3) {
  100095:	f3 0f 1e fb          	endbr32 
  100099:	55                   	push   %ebp
  10009a:	89 e5                	mov    %esp,%ebp
  10009c:	83 ec 08             	sub    $0x8,%esp
    mon_backtrace(0, NULL, NULL);
  10009f:	83 ec 04             	sub    $0x4,%esp
  1000a2:	6a 00                	push   $0x0
  1000a4:	6a 00                	push   $0x0
  1000a6:	6a 00                	push   $0x0
  1000a8:	e8 1c 0d 00 00       	call   100dc9 <mon_backtrace>
  1000ad:	83 c4 10             	add    $0x10,%esp
}
  1000b0:	90                   	nop
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
    grade_backtrace2(arg0, (int)&arg0, arg1, (int)&arg1);
  1000be:	8d 4d 0c             	lea    0xc(%ebp),%ecx
  1000c1:	8b 55 0c             	mov    0xc(%ebp),%edx
  1000c4:	8d 5d 08             	lea    0x8(%ebp),%ebx
  1000c7:	8b 45 08             	mov    0x8(%ebp),%eax
  1000ca:	51                   	push   %ecx
  1000cb:	52                   	push   %edx
  1000cc:	53                   	push   %ebx
  1000cd:	50                   	push   %eax
  1000ce:	e8 c2 ff ff ff       	call   100095 <grade_backtrace2>
  1000d3:	83 c4 10             	add    $0x10,%esp
}
  1000d6:	90                   	nop
  1000d7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  1000da:	c9                   	leave  
  1000db:	c3                   	ret    

001000dc <grade_backtrace0>:

void __attribute__((noinline))
grade_backtrace0(int arg0, int arg1, int arg2) {
  1000dc:	f3 0f 1e fb          	endbr32 
  1000e0:	55                   	push   %ebp
  1000e1:	89 e5                	mov    %esp,%ebp
  1000e3:	83 ec 08             	sub    $0x8,%esp
    grade_backtrace1(arg0, arg2);
  1000e6:	83 ec 08             	sub    $0x8,%esp
  1000e9:	ff 75 10             	pushl  0x10(%ebp)
  1000ec:	ff 75 08             	pushl  0x8(%ebp)
  1000ef:	e8 bf ff ff ff       	call   1000b3 <grade_backtrace1>
  1000f4:	83 c4 10             	add    $0x10,%esp
}
  1000f7:	90                   	nop
  1000f8:	c9                   	leave  
  1000f9:	c3                   	ret    

001000fa <grade_backtrace>:

void
grade_backtrace(void) {
  1000fa:	f3 0f 1e fb          	endbr32 
  1000fe:	55                   	push   %ebp
  1000ff:	89 e5                	mov    %esp,%ebp
  100101:	83 ec 08             	sub    $0x8,%esp
    grade_backtrace0(0, (int)kern_init, 0xffff0000);
  100104:	b8 2a 00 10 00       	mov    $0x10002a,%eax
  100109:	83 ec 04             	sub    $0x4,%esp
  10010c:	68 00 00 ff ff       	push   $0xffff0000
  100111:	50                   	push   %eax
  100112:	6a 00                	push   $0x0
  100114:	e8 c3 ff ff ff       	call   1000dc <grade_backtrace0>
  100119:	83 c4 10             	add    $0x10,%esp
}
  10011c:	90                   	nop
  10011d:	c9                   	leave  
  10011e:	c3                   	ret    

0010011f <lab1_print_cur_status>:

static void
lab1_print_cur_status(void) {
  10011f:	f3 0f 1e fb          	endbr32 
  100123:	55                   	push   %ebp
  100124:	89 e5                	mov    %esp,%ebp
  100126:	83 ec 18             	sub    $0x18,%esp
    static int round = 0;
    uint16_t reg1, reg2, reg3, reg4;
    asm volatile (
  100129:	8c 4d f6             	mov    %cs,-0xa(%ebp)
  10012c:	8c 5d f4             	mov    %ds,-0xc(%ebp)
  10012f:	8c 45 f2             	mov    %es,-0xe(%ebp)
  100132:	8c 55 f0             	mov    %ss,-0x10(%ebp)
            "mov %%cs, %0;"
            "mov %%ds, %1;"
            "mov %%es, %2;"
            "mov %%ss, %3;"
            : "=m"(reg1), "=m"(reg2), "=m"(reg3), "=m"(reg4));
    cprintf("%d: @ring %d\n", round, reg1 & 3);
  100135:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  100139:	0f b7 c0             	movzwl %ax,%eax
  10013c:	83 e0 03             	and    $0x3,%eax
  10013f:	89 c2                	mov    %eax,%edx
  100141:	a1 40 9a 11 00       	mov    0x119a40,%eax
  100146:	83 ec 04             	sub    $0x4,%esp
  100149:	52                   	push   %edx
  10014a:	50                   	push   %eax
  10014b:	68 21 5d 10 00       	push   $0x105d21
  100150:	e8 3a 01 00 00       	call   10028f <cprintf>
  100155:	83 c4 10             	add    $0x10,%esp
    cprintf("%d:  cs = %x\n", round, reg1);
  100158:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  10015c:	0f b7 d0             	movzwl %ax,%edx
  10015f:	a1 40 9a 11 00       	mov    0x119a40,%eax
  100164:	83 ec 04             	sub    $0x4,%esp
  100167:	52                   	push   %edx
  100168:	50                   	push   %eax
  100169:	68 2f 5d 10 00       	push   $0x105d2f
  10016e:	e8 1c 01 00 00       	call   10028f <cprintf>
  100173:	83 c4 10             	add    $0x10,%esp
    cprintf("%d:  ds = %x\n", round, reg2);
  100176:	0f b7 45 f4          	movzwl -0xc(%ebp),%eax
  10017a:	0f b7 d0             	movzwl %ax,%edx
  10017d:	a1 40 9a 11 00       	mov    0x119a40,%eax
  100182:	83 ec 04             	sub    $0x4,%esp
  100185:	52                   	push   %edx
  100186:	50                   	push   %eax
  100187:	68 3d 5d 10 00       	push   $0x105d3d
  10018c:	e8 fe 00 00 00       	call   10028f <cprintf>
  100191:	83 c4 10             	add    $0x10,%esp
    cprintf("%d:  es = %x\n", round, reg3);
  100194:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
  100198:	0f b7 d0             	movzwl %ax,%edx
  10019b:	a1 40 9a 11 00       	mov    0x119a40,%eax
  1001a0:	83 ec 04             	sub    $0x4,%esp
  1001a3:	52                   	push   %edx
  1001a4:	50                   	push   %eax
  1001a5:	68 4b 5d 10 00       	push   $0x105d4b
  1001aa:	e8 e0 00 00 00       	call   10028f <cprintf>
  1001af:	83 c4 10             	add    $0x10,%esp
    cprintf("%d:  ss = %x\n", round, reg4);
  1001b2:	0f b7 45 f0          	movzwl -0x10(%ebp),%eax
  1001b6:	0f b7 d0             	movzwl %ax,%edx
  1001b9:	a1 40 9a 11 00       	mov    0x119a40,%eax
  1001be:	83 ec 04             	sub    $0x4,%esp
  1001c1:	52                   	push   %edx
  1001c2:	50                   	push   %eax
  1001c3:	68 59 5d 10 00       	push   $0x105d59
  1001c8:	e8 c2 00 00 00       	call   10028f <cprintf>
  1001cd:	83 c4 10             	add    $0x10,%esp
    round ++;
  1001d0:	a1 40 9a 11 00       	mov    0x119a40,%eax
  1001d5:	83 c0 01             	add    $0x1,%eax
  1001d8:	a3 40 9a 11 00       	mov    %eax,0x119a40
}
  1001dd:	90                   	nop
  1001de:	c9                   	leave  
  1001df:	c3                   	ret    

001001e0 <lab1_switch_to_user>:

static void
lab1_switch_to_user(void) {
  1001e0:	f3 0f 1e fb          	endbr32 
  1001e4:	55                   	push   %ebp
  1001e5:	89 e5                	mov    %esp,%ebp
    //LAB1 CHALLENGE 1 : TODO
}
  1001e7:	90                   	nop
  1001e8:	5d                   	pop    %ebp
  1001e9:	c3                   	ret    

001001ea <lab1_switch_to_kernel>:

static void
lab1_switch_to_kernel(void) {
  1001ea:	f3 0f 1e fb          	endbr32 
  1001ee:	55                   	push   %ebp
  1001ef:	89 e5                	mov    %esp,%ebp
    //LAB1 CHALLENGE 1 :  TODO
}
  1001f1:	90                   	nop
  1001f2:	5d                   	pop    %ebp
  1001f3:	c3                   	ret    

001001f4 <lab1_switch_test>:

static void
lab1_switch_test(void) {
  1001f4:	f3 0f 1e fb          	endbr32 
  1001f8:	55                   	push   %ebp
  1001f9:	89 e5                	mov    %esp,%ebp
  1001fb:	83 ec 08             	sub    $0x8,%esp
    lab1_print_cur_status();
  1001fe:	e8 1c ff ff ff       	call   10011f <lab1_print_cur_status>
    cprintf("+++ switch to  user  mode +++\n");
  100203:	83 ec 0c             	sub    $0xc,%esp
  100206:	68 68 5d 10 00       	push   $0x105d68
  10020b:	e8 7f 00 00 00       	call   10028f <cprintf>
  100210:	83 c4 10             	add    $0x10,%esp
    lab1_switch_to_user();
  100213:	e8 c8 ff ff ff       	call   1001e0 <lab1_switch_to_user>
    lab1_print_cur_status();
  100218:	e8 02 ff ff ff       	call   10011f <lab1_print_cur_status>
    cprintf("+++ switch to kernel mode +++\n");
  10021d:	83 ec 0c             	sub    $0xc,%esp
  100220:	68 88 5d 10 00       	push   $0x105d88
  100225:	e8 65 00 00 00       	call   10028f <cprintf>
  10022a:	83 c4 10             	add    $0x10,%esp
    lab1_switch_to_kernel();
  10022d:	e8 b8 ff ff ff       	call   1001ea <lab1_switch_to_kernel>
    lab1_print_cur_status();
  100232:	e8 e8 fe ff ff       	call   10011f <lab1_print_cur_status>
}
  100237:	90                   	nop
  100238:	c9                   	leave  
  100239:	c3                   	ret    

0010023a <cputch>:
/* *
 * cputch - writes a single character @c to stdout, and it will
 * increace the value of counter pointed by @cnt.
 * */
static void
cputch(int c, int *cnt) {
  10023a:	f3 0f 1e fb          	endbr32 
  10023e:	55                   	push   %ebp
  10023f:	89 e5                	mov    %esp,%ebp
  100241:	83 ec 08             	sub    $0x8,%esp
    cons_putc(c);
  100244:	83 ec 0c             	sub    $0xc,%esp
  100247:	ff 75 08             	pushl  0x8(%ebp)
  10024a:	e8 7e 14 00 00       	call   1016cd <cons_putc>
  10024f:	83 c4 10             	add    $0x10,%esp
    (*cnt) ++;
  100252:	8b 45 0c             	mov    0xc(%ebp),%eax
  100255:	8b 00                	mov    (%eax),%eax
  100257:	8d 50 01             	lea    0x1(%eax),%edx
  10025a:	8b 45 0c             	mov    0xc(%ebp),%eax
  10025d:	89 10                	mov    %edx,(%eax)
}
  10025f:	90                   	nop
  100260:	c9                   	leave  
  100261:	c3                   	ret    

00100262 <vcprintf>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want cprintf() instead.
 * */
int
vcprintf(const char *fmt, va_list ap) {
  100262:	f3 0f 1e fb          	endbr32 
  100266:	55                   	push   %ebp
  100267:	89 e5                	mov    %esp,%ebp
  100269:	83 ec 18             	sub    $0x18,%esp
    int cnt = 0;
  10026c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    vprintfmt((void*)cputch, &cnt, fmt, ap);
  100273:	ff 75 0c             	pushl  0xc(%ebp)
  100276:	ff 75 08             	pushl  0x8(%ebp)
  100279:	8d 45 f4             	lea    -0xc(%ebp),%eax
  10027c:	50                   	push   %eax
  10027d:	68 3a 02 10 00       	push   $0x10023a
  100282:	e8 00 56 00 00       	call   105887 <vprintfmt>
  100287:	83 c4 10             	add    $0x10,%esp
    return cnt;
  10028a:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  10028d:	c9                   	leave  
  10028e:	c3                   	ret    

0010028f <cprintf>:
 *
 * The return value is the number of characters which would be
 * written to stdout.
 * */
int
cprintf(const char *fmt, ...) {
  10028f:	f3 0f 1e fb          	endbr32 
  100293:	55                   	push   %ebp
  100294:	89 e5                	mov    %esp,%ebp
  100296:	83 ec 18             	sub    $0x18,%esp
    va_list ap;
    int cnt;
    va_start(ap, fmt);
  100299:	8d 45 0c             	lea    0xc(%ebp),%eax
  10029c:	89 45 f0             	mov    %eax,-0x10(%ebp)
    cnt = vcprintf(fmt, ap);
  10029f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1002a2:	83 ec 08             	sub    $0x8,%esp
  1002a5:	50                   	push   %eax
  1002a6:	ff 75 08             	pushl  0x8(%ebp)
  1002a9:	e8 b4 ff ff ff       	call   100262 <vcprintf>
  1002ae:	83 c4 10             	add    $0x10,%esp
  1002b1:	89 45 f4             	mov    %eax,-0xc(%ebp)
    va_end(ap);
    return cnt;
  1002b4:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  1002b7:	c9                   	leave  
  1002b8:	c3                   	ret    

001002b9 <cputchar>:

/* cputchar - writes a single character to stdout */
void
cputchar(int c) {
  1002b9:	f3 0f 1e fb          	endbr32 
  1002bd:	55                   	push   %ebp
  1002be:	89 e5                	mov    %esp,%ebp
  1002c0:	83 ec 08             	sub    $0x8,%esp
    cons_putc(c);
  1002c3:	83 ec 0c             	sub    $0xc,%esp
  1002c6:	ff 75 08             	pushl  0x8(%ebp)
  1002c9:	e8 ff 13 00 00       	call   1016cd <cons_putc>
  1002ce:	83 c4 10             	add    $0x10,%esp
}
  1002d1:	90                   	nop
  1002d2:	c9                   	leave  
  1002d3:	c3                   	ret    

001002d4 <cputs>:
/* *
 * cputs- writes the string pointed by @str to stdout and
 * appends a newline character.
 * */
int
cputs(const char *str) {
  1002d4:	f3 0f 1e fb          	endbr32 
  1002d8:	55                   	push   %ebp
  1002d9:	89 e5                	mov    %esp,%ebp
  1002db:	83 ec 18             	sub    $0x18,%esp
    int cnt = 0;
  1002de:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    char c;
    while ((c = *str ++) != '\0') {
  1002e5:	eb 14                	jmp    1002fb <cputs+0x27>
        cputch(c, &cnt);
  1002e7:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  1002eb:	83 ec 08             	sub    $0x8,%esp
  1002ee:	8d 55 f0             	lea    -0x10(%ebp),%edx
  1002f1:	52                   	push   %edx
  1002f2:	50                   	push   %eax
  1002f3:	e8 42 ff ff ff       	call   10023a <cputch>
  1002f8:	83 c4 10             	add    $0x10,%esp
    while ((c = *str ++) != '\0') {
  1002fb:	8b 45 08             	mov    0x8(%ebp),%eax
  1002fe:	8d 50 01             	lea    0x1(%eax),%edx
  100301:	89 55 08             	mov    %edx,0x8(%ebp)
  100304:	0f b6 00             	movzbl (%eax),%eax
  100307:	88 45 f7             	mov    %al,-0x9(%ebp)
  10030a:	80 7d f7 00          	cmpb   $0x0,-0x9(%ebp)
  10030e:	75 d7                	jne    1002e7 <cputs+0x13>
    }
    cputch('\n', &cnt);
  100310:	83 ec 08             	sub    $0x8,%esp
  100313:	8d 45 f0             	lea    -0x10(%ebp),%eax
  100316:	50                   	push   %eax
  100317:	6a 0a                	push   $0xa
  100319:	e8 1c ff ff ff       	call   10023a <cputch>
  10031e:	83 c4 10             	add    $0x10,%esp
    return cnt;
  100321:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  100324:	c9                   	leave  
  100325:	c3                   	ret    

00100326 <getchar>:

/* getchar - reads a single non-zero character from stdin */
int
getchar(void) {
  100326:	f3 0f 1e fb          	endbr32 
  10032a:	55                   	push   %ebp
  10032b:	89 e5                	mov    %esp,%ebp
  10032d:	83 ec 18             	sub    $0x18,%esp
    int c;
    while ((c = cons_getc()) == 0)
  100330:	90                   	nop
  100331:	e8 e4 13 00 00       	call   10171a <cons_getc>
  100336:	89 45 f4             	mov    %eax,-0xc(%ebp)
  100339:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  10033d:	74 f2                	je     100331 <getchar+0xb>
        /* do nothing */;
    return c;
  10033f:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  100342:	c9                   	leave  
  100343:	c3                   	ret    

00100344 <readline>:
 * The readline() function returns the text of the line read. If some errors
 * are happened, NULL is returned. The return value is a global variable,
 * thus it should be copied before it is used.
 * */
char *
readline(const char *prompt) {
  100344:	f3 0f 1e fb          	endbr32 
  100348:	55                   	push   %ebp
  100349:	89 e5                	mov    %esp,%ebp
  10034b:	83 ec 18             	sub    $0x18,%esp
    if (prompt != NULL) {
  10034e:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  100352:	74 13                	je     100367 <readline+0x23>
        cprintf("%s", prompt);
  100354:	83 ec 08             	sub    $0x8,%esp
  100357:	ff 75 08             	pushl  0x8(%ebp)
  10035a:	68 a7 5d 10 00       	push   $0x105da7
  10035f:	e8 2b ff ff ff       	call   10028f <cprintf>
  100364:	83 c4 10             	add    $0x10,%esp
    }
    int i = 0, c;
  100367:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while (1) {
        c = getchar();
  10036e:	e8 b3 ff ff ff       	call   100326 <getchar>
  100373:	89 45 f0             	mov    %eax,-0x10(%ebp)
        if (c < 0) {
  100376:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  10037a:	79 0a                	jns    100386 <readline+0x42>
            return NULL;
  10037c:	b8 00 00 00 00       	mov    $0x0,%eax
  100381:	e9 82 00 00 00       	jmp    100408 <readline+0xc4>
        }
        else if (c >= ' ' && i < BUFSIZE - 1) {
  100386:	83 7d f0 1f          	cmpl   $0x1f,-0x10(%ebp)
  10038a:	7e 2b                	jle    1003b7 <readline+0x73>
  10038c:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  100393:	7f 22                	jg     1003b7 <readline+0x73>
            cputchar(c);
  100395:	83 ec 0c             	sub    $0xc,%esp
  100398:	ff 75 f0             	pushl  -0x10(%ebp)
  10039b:	e8 19 ff ff ff       	call   1002b9 <cputchar>
  1003a0:	83 c4 10             	add    $0x10,%esp
            buf[i ++] = c;
  1003a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1003a6:	8d 50 01             	lea    0x1(%eax),%edx
  1003a9:	89 55 f4             	mov    %edx,-0xc(%ebp)
  1003ac:	8b 55 f0             	mov    -0x10(%ebp),%edx
  1003af:	88 90 60 9a 11 00    	mov    %dl,0x119a60(%eax)
  1003b5:	eb 4c                	jmp    100403 <readline+0xbf>
        }
        else if (c == '\b' && i > 0) {
  1003b7:	83 7d f0 08          	cmpl   $0x8,-0x10(%ebp)
  1003bb:	75 1a                	jne    1003d7 <readline+0x93>
  1003bd:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  1003c1:	7e 14                	jle    1003d7 <readline+0x93>
            cputchar(c);
  1003c3:	83 ec 0c             	sub    $0xc,%esp
  1003c6:	ff 75 f0             	pushl  -0x10(%ebp)
  1003c9:	e8 eb fe ff ff       	call   1002b9 <cputchar>
  1003ce:	83 c4 10             	add    $0x10,%esp
            i --;
  1003d1:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
  1003d5:	eb 2c                	jmp    100403 <readline+0xbf>
        }
        else if (c == '\n' || c == '\r') {
  1003d7:	83 7d f0 0a          	cmpl   $0xa,-0x10(%ebp)
  1003db:	74 06                	je     1003e3 <readline+0x9f>
  1003dd:	83 7d f0 0d          	cmpl   $0xd,-0x10(%ebp)
  1003e1:	75 8b                	jne    10036e <readline+0x2a>
            cputchar(c);
  1003e3:	83 ec 0c             	sub    $0xc,%esp
  1003e6:	ff 75 f0             	pushl  -0x10(%ebp)
  1003e9:	e8 cb fe ff ff       	call   1002b9 <cputchar>
  1003ee:	83 c4 10             	add    $0x10,%esp
            buf[i] = '\0';
  1003f1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1003f4:	05 60 9a 11 00       	add    $0x119a60,%eax
  1003f9:	c6 00 00             	movb   $0x0,(%eax)
            return buf;
  1003fc:	b8 60 9a 11 00       	mov    $0x119a60,%eax
  100401:	eb 05                	jmp    100408 <readline+0xc4>
        c = getchar();
  100403:	e9 66 ff ff ff       	jmp    10036e <readline+0x2a>
        }
    }
}
  100408:	c9                   	leave  
  100409:	c3                   	ret    

0010040a <__panic>:
/* *
 * __panic - __panic is called on unresolvable fatal errors. it prints
 * "panic: 'message'", and then enters the kernel monitor.
 * */
void
__panic(const char *file, int line, const char *fmt, ...) {
  10040a:	f3 0f 1e fb          	endbr32 
  10040e:	55                   	push   %ebp
  10040f:	89 e5                	mov    %esp,%ebp
  100411:	83 ec 18             	sub    $0x18,%esp
    if (is_panic) {
  100414:	a1 60 9e 11 00       	mov    0x119e60,%eax
  100419:	85 c0                	test   %eax,%eax
  10041b:	75 4a                	jne    100467 <__panic+0x5d>
        goto panic_dead;
    }
    is_panic = 1;
  10041d:	c7 05 60 9e 11 00 01 	movl   $0x1,0x119e60
  100424:	00 00 00 

    // print the 'message'
    va_list ap;
    va_start(ap, fmt);
  100427:	8d 45 14             	lea    0x14(%ebp),%eax
  10042a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    cprintf("kernel panic at %s:%d:\n    ", file, line);
  10042d:	83 ec 04             	sub    $0x4,%esp
  100430:	ff 75 0c             	pushl  0xc(%ebp)
  100433:	ff 75 08             	pushl  0x8(%ebp)
  100436:	68 aa 5d 10 00       	push   $0x105daa
  10043b:	e8 4f fe ff ff       	call   10028f <cprintf>
  100440:	83 c4 10             	add    $0x10,%esp
    vcprintf(fmt, ap);
  100443:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100446:	83 ec 08             	sub    $0x8,%esp
  100449:	50                   	push   %eax
  10044a:	ff 75 10             	pushl  0x10(%ebp)
  10044d:	e8 10 fe ff ff       	call   100262 <vcprintf>
  100452:	83 c4 10             	add    $0x10,%esp
    cprintf("\n");
  100455:	83 ec 0c             	sub    $0xc,%esp
  100458:	68 c6 5d 10 00       	push   $0x105dc6
  10045d:	e8 2d fe ff ff       	call   10028f <cprintf>
  100462:	83 c4 10             	add    $0x10,%esp
  100465:	eb 01                	jmp    100468 <__panic+0x5e>
        goto panic_dead;
  100467:	90                   	nop
    va_end(ap);

panic_dead:
    intr_disable();
  100468:	e8 0e 15 00 00       	call   10197b <intr_disable>
    while (1) {
        kmonitor(NULL);
  10046d:	83 ec 0c             	sub    $0xc,%esp
  100470:	6a 00                	push   $0x0
  100472:	e8 6c 08 00 00       	call   100ce3 <kmonitor>
  100477:	83 c4 10             	add    $0x10,%esp
  10047a:	eb f1                	jmp    10046d <__panic+0x63>

0010047c <__warn>:
    }
}

/* __warn - like panic, but don't */
void
__warn(const char *file, int line, const char *fmt, ...) {
  10047c:	f3 0f 1e fb          	endbr32 
  100480:	55                   	push   %ebp
  100481:	89 e5                	mov    %esp,%ebp
  100483:	83 ec 18             	sub    $0x18,%esp
    va_list ap;
    va_start(ap, fmt);
  100486:	8d 45 14             	lea    0x14(%ebp),%eax
  100489:	89 45 f4             	mov    %eax,-0xc(%ebp)
    cprintf("kernel warning at %s:%d:\n    ", file, line);
  10048c:	83 ec 04             	sub    $0x4,%esp
  10048f:	ff 75 0c             	pushl  0xc(%ebp)
  100492:	ff 75 08             	pushl  0x8(%ebp)
  100495:	68 c8 5d 10 00       	push   $0x105dc8
  10049a:	e8 f0 fd ff ff       	call   10028f <cprintf>
  10049f:	83 c4 10             	add    $0x10,%esp
    vcprintf(fmt, ap);
  1004a2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1004a5:	83 ec 08             	sub    $0x8,%esp
  1004a8:	50                   	push   %eax
  1004a9:	ff 75 10             	pushl  0x10(%ebp)
  1004ac:	e8 b1 fd ff ff       	call   100262 <vcprintf>
  1004b1:	83 c4 10             	add    $0x10,%esp
    cprintf("\n");
  1004b4:	83 ec 0c             	sub    $0xc,%esp
  1004b7:	68 c6 5d 10 00       	push   $0x105dc6
  1004bc:	e8 ce fd ff ff       	call   10028f <cprintf>
  1004c1:	83 c4 10             	add    $0x10,%esp
    va_end(ap);
}
  1004c4:	90                   	nop
  1004c5:	c9                   	leave  
  1004c6:	c3                   	ret    

001004c7 <is_kernel_panic>:

bool
is_kernel_panic(void) {
  1004c7:	f3 0f 1e fb          	endbr32 
  1004cb:	55                   	push   %ebp
  1004cc:	89 e5                	mov    %esp,%ebp
    return is_panic;
  1004ce:	a1 60 9e 11 00       	mov    0x119e60,%eax
}
  1004d3:	5d                   	pop    %ebp
  1004d4:	c3                   	ret    

001004d5 <stab_binsearch>:
 *      stab_binsearch(stabs, &left, &right, N_SO, 0xf0100184);
 * will exit setting left = 118, right = 554.
 * */
static void
stab_binsearch(const struct stab *stabs, int *region_left, int *region_right,
           int type, uintptr_t addr) {
  1004d5:	f3 0f 1e fb          	endbr32 
  1004d9:	55                   	push   %ebp
  1004da:	89 e5                	mov    %esp,%ebp
  1004dc:	83 ec 20             	sub    $0x20,%esp
    int l = *region_left, r = *region_right, any_matches = 0;
  1004df:	8b 45 0c             	mov    0xc(%ebp),%eax
  1004e2:	8b 00                	mov    (%eax),%eax
  1004e4:	89 45 fc             	mov    %eax,-0x4(%ebp)
  1004e7:	8b 45 10             	mov    0x10(%ebp),%eax
  1004ea:	8b 00                	mov    (%eax),%eax
  1004ec:	89 45 f8             	mov    %eax,-0x8(%ebp)
  1004ef:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

    while (l <= r) {
  1004f6:	e9 d2 00 00 00       	jmp    1005cd <stab_binsearch+0xf8>
        int true_m = (l + r) / 2, m = true_m;
  1004fb:	8b 55 fc             	mov    -0x4(%ebp),%edx
  1004fe:	8b 45 f8             	mov    -0x8(%ebp),%eax
  100501:	01 d0                	add    %edx,%eax
  100503:	89 c2                	mov    %eax,%edx
  100505:	c1 ea 1f             	shr    $0x1f,%edx
  100508:	01 d0                	add    %edx,%eax
  10050a:	d1 f8                	sar    %eax
  10050c:	89 45 ec             	mov    %eax,-0x14(%ebp)
  10050f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  100512:	89 45 f0             	mov    %eax,-0x10(%ebp)

        // search for earliest stab with right type
        while (m >= l && stabs[m].n_type != type) {
  100515:	eb 04                	jmp    10051b <stab_binsearch+0x46>
            m --;
  100517:	83 6d f0 01          	subl   $0x1,-0x10(%ebp)
        while (m >= l && stabs[m].n_type != type) {
  10051b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10051e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  100521:	7c 1f                	jl     100542 <stab_binsearch+0x6d>
  100523:	8b 55 f0             	mov    -0x10(%ebp),%edx
  100526:	89 d0                	mov    %edx,%eax
  100528:	01 c0                	add    %eax,%eax
  10052a:	01 d0                	add    %edx,%eax
  10052c:	c1 e0 02             	shl    $0x2,%eax
  10052f:	89 c2                	mov    %eax,%edx
  100531:	8b 45 08             	mov    0x8(%ebp),%eax
  100534:	01 d0                	add    %edx,%eax
  100536:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  10053a:	0f b6 c0             	movzbl %al,%eax
  10053d:	39 45 14             	cmp    %eax,0x14(%ebp)
  100540:	75 d5                	jne    100517 <stab_binsearch+0x42>
        }
        if (m < l) {    // no match in [l, m]
  100542:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100545:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  100548:	7d 0b                	jge    100555 <stab_binsearch+0x80>
            l = true_m + 1;
  10054a:	8b 45 ec             	mov    -0x14(%ebp),%eax
  10054d:	83 c0 01             	add    $0x1,%eax
  100550:	89 45 fc             	mov    %eax,-0x4(%ebp)
            continue;
  100553:	eb 78                	jmp    1005cd <stab_binsearch+0xf8>
        }

        // actual binary search
        any_matches = 1;
  100555:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        if (stabs[m].n_value < addr) {
  10055c:	8b 55 f0             	mov    -0x10(%ebp),%edx
  10055f:	89 d0                	mov    %edx,%eax
  100561:	01 c0                	add    %eax,%eax
  100563:	01 d0                	add    %edx,%eax
  100565:	c1 e0 02             	shl    $0x2,%eax
  100568:	89 c2                	mov    %eax,%edx
  10056a:	8b 45 08             	mov    0x8(%ebp),%eax
  10056d:	01 d0                	add    %edx,%eax
  10056f:	8b 40 08             	mov    0x8(%eax),%eax
  100572:	39 45 18             	cmp    %eax,0x18(%ebp)
  100575:	76 13                	jbe    10058a <stab_binsearch+0xb5>
            *region_left = m;
  100577:	8b 45 0c             	mov    0xc(%ebp),%eax
  10057a:	8b 55 f0             	mov    -0x10(%ebp),%edx
  10057d:	89 10                	mov    %edx,(%eax)
            l = true_m + 1;
  10057f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  100582:	83 c0 01             	add    $0x1,%eax
  100585:	89 45 fc             	mov    %eax,-0x4(%ebp)
  100588:	eb 43                	jmp    1005cd <stab_binsearch+0xf8>
        } else if (stabs[m].n_value > addr) {
  10058a:	8b 55 f0             	mov    -0x10(%ebp),%edx
  10058d:	89 d0                	mov    %edx,%eax
  10058f:	01 c0                	add    %eax,%eax
  100591:	01 d0                	add    %edx,%eax
  100593:	c1 e0 02             	shl    $0x2,%eax
  100596:	89 c2                	mov    %eax,%edx
  100598:	8b 45 08             	mov    0x8(%ebp),%eax
  10059b:	01 d0                	add    %edx,%eax
  10059d:	8b 40 08             	mov    0x8(%eax),%eax
  1005a0:	39 45 18             	cmp    %eax,0x18(%ebp)
  1005a3:	73 16                	jae    1005bb <stab_binsearch+0xe6>
            *region_right = m - 1;
  1005a5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1005a8:	8d 50 ff             	lea    -0x1(%eax),%edx
  1005ab:	8b 45 10             	mov    0x10(%ebp),%eax
  1005ae:	89 10                	mov    %edx,(%eax)
            r = m - 1;
  1005b0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1005b3:	83 e8 01             	sub    $0x1,%eax
  1005b6:	89 45 f8             	mov    %eax,-0x8(%ebp)
  1005b9:	eb 12                	jmp    1005cd <stab_binsearch+0xf8>
        } else {
            // exact match for 'addr', but continue loop to find
            // *region_right
            *region_left = m;
  1005bb:	8b 45 0c             	mov    0xc(%ebp),%eax
  1005be:	8b 55 f0             	mov    -0x10(%ebp),%edx
  1005c1:	89 10                	mov    %edx,(%eax)
            l = m;
  1005c3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1005c6:	89 45 fc             	mov    %eax,-0x4(%ebp)
            addr ++;
  1005c9:	83 45 18 01          	addl   $0x1,0x18(%ebp)
    while (l <= r) {
  1005cd:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1005d0:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  1005d3:	0f 8e 22 ff ff ff    	jle    1004fb <stab_binsearch+0x26>
        }
    }

    if (!any_matches) {
  1005d9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  1005dd:	75 0f                	jne    1005ee <stab_binsearch+0x119>
        *region_right = *region_left - 1;
  1005df:	8b 45 0c             	mov    0xc(%ebp),%eax
  1005e2:	8b 00                	mov    (%eax),%eax
  1005e4:	8d 50 ff             	lea    -0x1(%eax),%edx
  1005e7:	8b 45 10             	mov    0x10(%ebp),%eax
  1005ea:	89 10                	mov    %edx,(%eax)
        l = *region_right;
        for (; l > *region_left && stabs[l].n_type != type; l --)
            /* do nothing */;
        *region_left = l;
    }
}
  1005ec:	eb 3f                	jmp    10062d <stab_binsearch+0x158>
        l = *region_right;
  1005ee:	8b 45 10             	mov    0x10(%ebp),%eax
  1005f1:	8b 00                	mov    (%eax),%eax
  1005f3:	89 45 fc             	mov    %eax,-0x4(%ebp)
        for (; l > *region_left && stabs[l].n_type != type; l --)
  1005f6:	eb 04                	jmp    1005fc <stab_binsearch+0x127>
  1005f8:	83 6d fc 01          	subl   $0x1,-0x4(%ebp)
  1005fc:	8b 45 0c             	mov    0xc(%ebp),%eax
  1005ff:	8b 00                	mov    (%eax),%eax
  100601:	39 45 fc             	cmp    %eax,-0x4(%ebp)
  100604:	7e 1f                	jle    100625 <stab_binsearch+0x150>
  100606:	8b 55 fc             	mov    -0x4(%ebp),%edx
  100609:	89 d0                	mov    %edx,%eax
  10060b:	01 c0                	add    %eax,%eax
  10060d:	01 d0                	add    %edx,%eax
  10060f:	c1 e0 02             	shl    $0x2,%eax
  100612:	89 c2                	mov    %eax,%edx
  100614:	8b 45 08             	mov    0x8(%ebp),%eax
  100617:	01 d0                	add    %edx,%eax
  100619:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  10061d:	0f b6 c0             	movzbl %al,%eax
  100620:	39 45 14             	cmp    %eax,0x14(%ebp)
  100623:	75 d3                	jne    1005f8 <stab_binsearch+0x123>
        *region_left = l;
  100625:	8b 45 0c             	mov    0xc(%ebp),%eax
  100628:	8b 55 fc             	mov    -0x4(%ebp),%edx
  10062b:	89 10                	mov    %edx,(%eax)
}
  10062d:	90                   	nop
  10062e:	c9                   	leave  
  10062f:	c3                   	ret    

00100630 <debuginfo_eip>:
 * the specified instruction address, @addr.  Returns 0 if information
 * was found, and negative if not.  But even if it returns negative it
 * has stored some information into '*info'.
 * */
int
debuginfo_eip(uintptr_t addr, struct eipdebuginfo *info) {
  100630:	f3 0f 1e fb          	endbr32 
  100634:	55                   	push   %ebp
  100635:	89 e5                	mov    %esp,%ebp
  100637:	83 ec 38             	sub    $0x38,%esp
    const struct stab *stabs, *stab_end;
    const char *stabstr, *stabstr_end;

    info->eip_file = "<unknown>";
  10063a:	8b 45 0c             	mov    0xc(%ebp),%eax
  10063d:	c7 00 e8 5d 10 00    	movl   $0x105de8,(%eax)
    info->eip_line = 0;
  100643:	8b 45 0c             	mov    0xc(%ebp),%eax
  100646:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    info->eip_fn_name = "<unknown>";
  10064d:	8b 45 0c             	mov    0xc(%ebp),%eax
  100650:	c7 40 08 e8 5d 10 00 	movl   $0x105de8,0x8(%eax)
    info->eip_fn_namelen = 9;
  100657:	8b 45 0c             	mov    0xc(%ebp),%eax
  10065a:	c7 40 0c 09 00 00 00 	movl   $0x9,0xc(%eax)
    info->eip_fn_addr = addr;
  100661:	8b 45 0c             	mov    0xc(%ebp),%eax
  100664:	8b 55 08             	mov    0x8(%ebp),%edx
  100667:	89 50 10             	mov    %edx,0x10(%eax)
    info->eip_fn_narg = 0;
  10066a:	8b 45 0c             	mov    0xc(%ebp),%eax
  10066d:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)

    stabs = __STAB_BEGIN__;
  100674:	c7 45 f4 00 70 10 00 	movl   $0x107000,-0xc(%ebp)
    stab_end = __STAB_END__;
  10067b:	c7 45 f0 84 39 11 00 	movl   $0x113984,-0x10(%ebp)
    stabstr = __STABSTR_BEGIN__;
  100682:	c7 45 ec 85 39 11 00 	movl   $0x113985,-0x14(%ebp)
    stabstr_end = __STABSTR_END__;
  100689:	c7 45 e8 a0 64 11 00 	movl   $0x1164a0,-0x18(%ebp)

    // String table validity checks
    if (stabstr_end <= stabstr || stabstr_end[-1] != 0) {
  100690:	8b 45 e8             	mov    -0x18(%ebp),%eax
  100693:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  100696:	76 0d                	jbe    1006a5 <debuginfo_eip+0x75>
  100698:	8b 45 e8             	mov    -0x18(%ebp),%eax
  10069b:	83 e8 01             	sub    $0x1,%eax
  10069e:	0f b6 00             	movzbl (%eax),%eax
  1006a1:	84 c0                	test   %al,%al
  1006a3:	74 0a                	je     1006af <debuginfo_eip+0x7f>
        return -1;
  1006a5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  1006aa:	e9 85 02 00 00       	jmp    100934 <debuginfo_eip+0x304>
    // 'eip'.  First, we find the basic source file containing 'eip'.
    // Then, we look in that source file for the function.  Then we look
    // for the line number.

    // Search the entire set of stabs for the source file (type N_SO).
    int lfile = 0, rfile = (stab_end - stabs) - 1;
  1006af:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  1006b6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1006b9:	2b 45 f4             	sub    -0xc(%ebp),%eax
  1006bc:	c1 f8 02             	sar    $0x2,%eax
  1006bf:	69 c0 ab aa aa aa    	imul   $0xaaaaaaab,%eax,%eax
  1006c5:	83 e8 01             	sub    $0x1,%eax
  1006c8:	89 45 e0             	mov    %eax,-0x20(%ebp)
    stab_binsearch(stabs, &lfile, &rfile, N_SO, addr);
  1006cb:	ff 75 08             	pushl  0x8(%ebp)
  1006ce:	6a 64                	push   $0x64
  1006d0:	8d 45 e0             	lea    -0x20(%ebp),%eax
  1006d3:	50                   	push   %eax
  1006d4:	8d 45 e4             	lea    -0x1c(%ebp),%eax
  1006d7:	50                   	push   %eax
  1006d8:	ff 75 f4             	pushl  -0xc(%ebp)
  1006db:	e8 f5 fd ff ff       	call   1004d5 <stab_binsearch>
  1006e0:	83 c4 14             	add    $0x14,%esp
    if (lfile == 0)
  1006e3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1006e6:	85 c0                	test   %eax,%eax
  1006e8:	75 0a                	jne    1006f4 <debuginfo_eip+0xc4>
        return -1;
  1006ea:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  1006ef:	e9 40 02 00 00       	jmp    100934 <debuginfo_eip+0x304>

    // Search within that file's stabs for the function definition
    // (N_FUN).
    int lfun = lfile, rfun = rfile;
  1006f4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1006f7:	89 45 dc             	mov    %eax,-0x24(%ebp)
  1006fa:	8b 45 e0             	mov    -0x20(%ebp),%eax
  1006fd:	89 45 d8             	mov    %eax,-0x28(%ebp)
    int lline, rline;
    stab_binsearch(stabs, &lfun, &rfun, N_FUN, addr);
  100700:	ff 75 08             	pushl  0x8(%ebp)
  100703:	6a 24                	push   $0x24
  100705:	8d 45 d8             	lea    -0x28(%ebp),%eax
  100708:	50                   	push   %eax
  100709:	8d 45 dc             	lea    -0x24(%ebp),%eax
  10070c:	50                   	push   %eax
  10070d:	ff 75 f4             	pushl  -0xc(%ebp)
  100710:	e8 c0 fd ff ff       	call   1004d5 <stab_binsearch>
  100715:	83 c4 14             	add    $0x14,%esp

    if (lfun <= rfun) {
  100718:	8b 55 dc             	mov    -0x24(%ebp),%edx
  10071b:	8b 45 d8             	mov    -0x28(%ebp),%eax
  10071e:	39 c2                	cmp    %eax,%edx
  100720:	7f 78                	jg     10079a <debuginfo_eip+0x16a>
        // stabs[lfun] points to the function name
        // in the string table, but check bounds just in case.
        if (stabs[lfun].n_strx < stabstr_end - stabstr) {
  100722:	8b 45 dc             	mov    -0x24(%ebp),%eax
  100725:	89 c2                	mov    %eax,%edx
  100727:	89 d0                	mov    %edx,%eax
  100729:	01 c0                	add    %eax,%eax
  10072b:	01 d0                	add    %edx,%eax
  10072d:	c1 e0 02             	shl    $0x2,%eax
  100730:	89 c2                	mov    %eax,%edx
  100732:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100735:	01 d0                	add    %edx,%eax
  100737:	8b 10                	mov    (%eax),%edx
  100739:	8b 45 e8             	mov    -0x18(%ebp),%eax
  10073c:	2b 45 ec             	sub    -0x14(%ebp),%eax
  10073f:	39 c2                	cmp    %eax,%edx
  100741:	73 22                	jae    100765 <debuginfo_eip+0x135>
            info->eip_fn_name = stabstr + stabs[lfun].n_strx;
  100743:	8b 45 dc             	mov    -0x24(%ebp),%eax
  100746:	89 c2                	mov    %eax,%edx
  100748:	89 d0                	mov    %edx,%eax
  10074a:	01 c0                	add    %eax,%eax
  10074c:	01 d0                	add    %edx,%eax
  10074e:	c1 e0 02             	shl    $0x2,%eax
  100751:	89 c2                	mov    %eax,%edx
  100753:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100756:	01 d0                	add    %edx,%eax
  100758:	8b 10                	mov    (%eax),%edx
  10075a:	8b 45 ec             	mov    -0x14(%ebp),%eax
  10075d:	01 c2                	add    %eax,%edx
  10075f:	8b 45 0c             	mov    0xc(%ebp),%eax
  100762:	89 50 08             	mov    %edx,0x8(%eax)
        }
        info->eip_fn_addr = stabs[lfun].n_value;
  100765:	8b 45 dc             	mov    -0x24(%ebp),%eax
  100768:	89 c2                	mov    %eax,%edx
  10076a:	89 d0                	mov    %edx,%eax
  10076c:	01 c0                	add    %eax,%eax
  10076e:	01 d0                	add    %edx,%eax
  100770:	c1 e0 02             	shl    $0x2,%eax
  100773:	89 c2                	mov    %eax,%edx
  100775:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100778:	01 d0                	add    %edx,%eax
  10077a:	8b 50 08             	mov    0x8(%eax),%edx
  10077d:	8b 45 0c             	mov    0xc(%ebp),%eax
  100780:	89 50 10             	mov    %edx,0x10(%eax)
        addr -= info->eip_fn_addr;
  100783:	8b 45 0c             	mov    0xc(%ebp),%eax
  100786:	8b 40 10             	mov    0x10(%eax),%eax
  100789:	29 45 08             	sub    %eax,0x8(%ebp)
        // Search within the function definition for the line number.
        lline = lfun;
  10078c:	8b 45 dc             	mov    -0x24(%ebp),%eax
  10078f:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        rline = rfun;
  100792:	8b 45 d8             	mov    -0x28(%ebp),%eax
  100795:	89 45 d0             	mov    %eax,-0x30(%ebp)
  100798:	eb 15                	jmp    1007af <debuginfo_eip+0x17f>
    } else {
        // Couldn't find function stab!  Maybe we're in an assembly
        // file.  Search the whole file for the line number.
        info->eip_fn_addr = addr;
  10079a:	8b 45 0c             	mov    0xc(%ebp),%eax
  10079d:	8b 55 08             	mov    0x8(%ebp),%edx
  1007a0:	89 50 10             	mov    %edx,0x10(%eax)
        lline = lfile;
  1007a3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1007a6:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        rline = rfile;
  1007a9:	8b 45 e0             	mov    -0x20(%ebp),%eax
  1007ac:	89 45 d0             	mov    %eax,-0x30(%ebp)
    }
    info->eip_fn_namelen = strfind(info->eip_fn_name, ':') - info->eip_fn_name;
  1007af:	8b 45 0c             	mov    0xc(%ebp),%eax
  1007b2:	8b 40 08             	mov    0x8(%eax),%eax
  1007b5:	83 ec 08             	sub    $0x8,%esp
  1007b8:	6a 3a                	push   $0x3a
  1007ba:	50                   	push   %eax
  1007bb:	e8 e4 4b 00 00       	call   1053a4 <strfind>
  1007c0:	83 c4 10             	add    $0x10,%esp
  1007c3:	8b 55 0c             	mov    0xc(%ebp),%edx
  1007c6:	8b 52 08             	mov    0x8(%edx),%edx
  1007c9:	29 d0                	sub    %edx,%eax
  1007cb:	89 c2                	mov    %eax,%edx
  1007cd:	8b 45 0c             	mov    0xc(%ebp),%eax
  1007d0:	89 50 0c             	mov    %edx,0xc(%eax)

    // Search within [lline, rline] for the line number stab.
    // If found, set info->eip_line to the right line number.
    // If not found, return -1.
    stab_binsearch(stabs, &lline, &rline, N_SLINE, addr);
  1007d3:	83 ec 0c             	sub    $0xc,%esp
  1007d6:	ff 75 08             	pushl  0x8(%ebp)
  1007d9:	6a 44                	push   $0x44
  1007db:	8d 45 d0             	lea    -0x30(%ebp),%eax
  1007de:	50                   	push   %eax
  1007df:	8d 45 d4             	lea    -0x2c(%ebp),%eax
  1007e2:	50                   	push   %eax
  1007e3:	ff 75 f4             	pushl  -0xc(%ebp)
  1007e6:	e8 ea fc ff ff       	call   1004d5 <stab_binsearch>
  1007eb:	83 c4 20             	add    $0x20,%esp
    if (lline <= rline) {
  1007ee:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  1007f1:	8b 45 d0             	mov    -0x30(%ebp),%eax
  1007f4:	39 c2                	cmp    %eax,%edx
  1007f6:	7f 24                	jg     10081c <debuginfo_eip+0x1ec>
        info->eip_line = stabs[rline].n_desc;
  1007f8:	8b 45 d0             	mov    -0x30(%ebp),%eax
  1007fb:	89 c2                	mov    %eax,%edx
  1007fd:	89 d0                	mov    %edx,%eax
  1007ff:	01 c0                	add    %eax,%eax
  100801:	01 d0                	add    %edx,%eax
  100803:	c1 e0 02             	shl    $0x2,%eax
  100806:	89 c2                	mov    %eax,%edx
  100808:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10080b:	01 d0                	add    %edx,%eax
  10080d:	0f b7 40 06          	movzwl 0x6(%eax),%eax
  100811:	0f b7 d0             	movzwl %ax,%edx
  100814:	8b 45 0c             	mov    0xc(%ebp),%eax
  100817:	89 50 04             	mov    %edx,0x4(%eax)

    // Search backwards from the line number for the relevant filename stab.
    // We can't just use the "lfile" stab because inlined functions
    // can interpolate code from a different file!
    // Such included source files use the N_SOL stab type.
    while (lline >= lfile
  10081a:	eb 13                	jmp    10082f <debuginfo_eip+0x1ff>
        return -1;
  10081c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  100821:	e9 0e 01 00 00       	jmp    100934 <debuginfo_eip+0x304>
           && stabs[lline].n_type != N_SOL
           && (stabs[lline].n_type != N_SO || !stabs[lline].n_value)) {
        lline --;
  100826:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100829:	83 e8 01             	sub    $0x1,%eax
  10082c:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    while (lline >= lfile
  10082f:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  100832:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  100835:	39 c2                	cmp    %eax,%edx
  100837:	7c 56                	jl     10088f <debuginfo_eip+0x25f>
           && stabs[lline].n_type != N_SOL
  100839:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  10083c:	89 c2                	mov    %eax,%edx
  10083e:	89 d0                	mov    %edx,%eax
  100840:	01 c0                	add    %eax,%eax
  100842:	01 d0                	add    %edx,%eax
  100844:	c1 e0 02             	shl    $0x2,%eax
  100847:	89 c2                	mov    %eax,%edx
  100849:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10084c:	01 d0                	add    %edx,%eax
  10084e:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  100852:	3c 84                	cmp    $0x84,%al
  100854:	74 39                	je     10088f <debuginfo_eip+0x25f>
           && (stabs[lline].n_type != N_SO || !stabs[lline].n_value)) {
  100856:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100859:	89 c2                	mov    %eax,%edx
  10085b:	89 d0                	mov    %edx,%eax
  10085d:	01 c0                	add    %eax,%eax
  10085f:	01 d0                	add    %edx,%eax
  100861:	c1 e0 02             	shl    $0x2,%eax
  100864:	89 c2                	mov    %eax,%edx
  100866:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100869:	01 d0                	add    %edx,%eax
  10086b:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  10086f:	3c 64                	cmp    $0x64,%al
  100871:	75 b3                	jne    100826 <debuginfo_eip+0x1f6>
  100873:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100876:	89 c2                	mov    %eax,%edx
  100878:	89 d0                	mov    %edx,%eax
  10087a:	01 c0                	add    %eax,%eax
  10087c:	01 d0                	add    %edx,%eax
  10087e:	c1 e0 02             	shl    $0x2,%eax
  100881:	89 c2                	mov    %eax,%edx
  100883:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100886:	01 d0                	add    %edx,%eax
  100888:	8b 40 08             	mov    0x8(%eax),%eax
  10088b:	85 c0                	test   %eax,%eax
  10088d:	74 97                	je     100826 <debuginfo_eip+0x1f6>
    }
    if (lline >= lfile && stabs[lline].n_strx < stabstr_end - stabstr) {
  10088f:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  100892:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  100895:	39 c2                	cmp    %eax,%edx
  100897:	7c 42                	jl     1008db <debuginfo_eip+0x2ab>
  100899:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  10089c:	89 c2                	mov    %eax,%edx
  10089e:	89 d0                	mov    %edx,%eax
  1008a0:	01 c0                	add    %eax,%eax
  1008a2:	01 d0                	add    %edx,%eax
  1008a4:	c1 e0 02             	shl    $0x2,%eax
  1008a7:	89 c2                	mov    %eax,%edx
  1008a9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1008ac:	01 d0                	add    %edx,%eax
  1008ae:	8b 10                	mov    (%eax),%edx
  1008b0:	8b 45 e8             	mov    -0x18(%ebp),%eax
  1008b3:	2b 45 ec             	sub    -0x14(%ebp),%eax
  1008b6:	39 c2                	cmp    %eax,%edx
  1008b8:	73 21                	jae    1008db <debuginfo_eip+0x2ab>
        info->eip_file = stabstr + stabs[lline].n_strx;
  1008ba:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  1008bd:	89 c2                	mov    %eax,%edx
  1008bf:	89 d0                	mov    %edx,%eax
  1008c1:	01 c0                	add    %eax,%eax
  1008c3:	01 d0                	add    %edx,%eax
  1008c5:	c1 e0 02             	shl    $0x2,%eax
  1008c8:	89 c2                	mov    %eax,%edx
  1008ca:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1008cd:	01 d0                	add    %edx,%eax
  1008cf:	8b 10                	mov    (%eax),%edx
  1008d1:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1008d4:	01 c2                	add    %eax,%edx
  1008d6:	8b 45 0c             	mov    0xc(%ebp),%eax
  1008d9:	89 10                	mov    %edx,(%eax)
    }

    // Set eip_fn_narg to the number of arguments taken by the function,
    // or 0 if there was no containing function.
    if (lfun < rfun) {
  1008db:	8b 55 dc             	mov    -0x24(%ebp),%edx
  1008de:	8b 45 d8             	mov    -0x28(%ebp),%eax
  1008e1:	39 c2                	cmp    %eax,%edx
  1008e3:	7d 4a                	jge    10092f <debuginfo_eip+0x2ff>
        for (lline = lfun + 1;
  1008e5:	8b 45 dc             	mov    -0x24(%ebp),%eax
  1008e8:	83 c0 01             	add    $0x1,%eax
  1008eb:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  1008ee:	eb 18                	jmp    100908 <debuginfo_eip+0x2d8>
             lline < rfun && stabs[lline].n_type == N_PSYM;
             lline ++) {
            info->eip_fn_narg ++;
  1008f0:	8b 45 0c             	mov    0xc(%ebp),%eax
  1008f3:	8b 40 14             	mov    0x14(%eax),%eax
  1008f6:	8d 50 01             	lea    0x1(%eax),%edx
  1008f9:	8b 45 0c             	mov    0xc(%ebp),%eax
  1008fc:	89 50 14             	mov    %edx,0x14(%eax)
             lline ++) {
  1008ff:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100902:	83 c0 01             	add    $0x1,%eax
  100905:	89 45 d4             	mov    %eax,-0x2c(%ebp)
             lline < rfun && stabs[lline].n_type == N_PSYM;
  100908:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  10090b:	8b 45 d8             	mov    -0x28(%ebp),%eax
        for (lline = lfun + 1;
  10090e:	39 c2                	cmp    %eax,%edx
  100910:	7d 1d                	jge    10092f <debuginfo_eip+0x2ff>
             lline < rfun && stabs[lline].n_type == N_PSYM;
  100912:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100915:	89 c2                	mov    %eax,%edx
  100917:	89 d0                	mov    %edx,%eax
  100919:	01 c0                	add    %eax,%eax
  10091b:	01 d0                	add    %edx,%eax
  10091d:	c1 e0 02             	shl    $0x2,%eax
  100920:	89 c2                	mov    %eax,%edx
  100922:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100925:	01 d0                	add    %edx,%eax
  100927:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  10092b:	3c a0                	cmp    $0xa0,%al
  10092d:	74 c1                	je     1008f0 <debuginfo_eip+0x2c0>
        }
    }
    return 0;
  10092f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100934:	c9                   	leave  
  100935:	c3                   	ret    

00100936 <print_kerninfo>:
 * print_kerninfo - print the information about kernel, including the location
 * of kernel entry, the start addresses of data and text segements, the start
 * address of free memory and how many memory that kernel has used.
 * */
void
print_kerninfo(void) {
  100936:	f3 0f 1e fb          	endbr32 
  10093a:	55                   	push   %ebp
  10093b:	89 e5                	mov    %esp,%ebp
  10093d:	83 ec 08             	sub    $0x8,%esp
    extern char etext[], edata[], end[], kern_init[];
    cprintf("Special kernel symbols:\n");
  100940:	83 ec 0c             	sub    $0xc,%esp
  100943:	68 f2 5d 10 00       	push   $0x105df2
  100948:	e8 42 f9 ff ff       	call   10028f <cprintf>
  10094d:	83 c4 10             	add    $0x10,%esp
    cprintf("  entry  0x%08x (phys)\n", kern_init);
  100950:	83 ec 08             	sub    $0x8,%esp
  100953:	68 2a 00 10 00       	push   $0x10002a
  100958:	68 0b 5e 10 00       	push   $0x105e0b
  10095d:	e8 2d f9 ff ff       	call   10028f <cprintf>
  100962:	83 c4 10             	add    $0x10,%esp
    cprintf("  etext  0x%08x (phys)\n", etext);
  100965:	83 ec 08             	sub    $0x8,%esp
  100968:	68 f9 5c 10 00       	push   $0x105cf9
  10096d:	68 23 5e 10 00       	push   $0x105e23
  100972:	e8 18 f9 ff ff       	call   10028f <cprintf>
  100977:	83 c4 10             	add    $0x10,%esp
    cprintf("  edata  0x%08x (phys)\n", edata);
  10097a:	83 ec 08             	sub    $0x8,%esp
  10097d:	68 36 9a 11 00       	push   $0x119a36
  100982:	68 3b 5e 10 00       	push   $0x105e3b
  100987:	e8 03 f9 ff ff       	call   10028f <cprintf>
  10098c:	83 c4 10             	add    $0x10,%esp
    cprintf("  end    0x%08x (phys)\n", end);
  10098f:	83 ec 08             	sub    $0x8,%esp
  100992:	68 68 a9 11 00       	push   $0x11a968
  100997:	68 53 5e 10 00       	push   $0x105e53
  10099c:	e8 ee f8 ff ff       	call   10028f <cprintf>
  1009a1:	83 c4 10             	add    $0x10,%esp
    cprintf("Kernel executable memory footprint: %dKB\n", (end - kern_init + 1023)/1024);
  1009a4:	b8 68 a9 11 00       	mov    $0x11a968,%eax
  1009a9:	2d 2a 00 10 00       	sub    $0x10002a,%eax
  1009ae:	05 ff 03 00 00       	add    $0x3ff,%eax
  1009b3:	8d 90 ff 03 00 00    	lea    0x3ff(%eax),%edx
  1009b9:	85 c0                	test   %eax,%eax
  1009bb:	0f 48 c2             	cmovs  %edx,%eax
  1009be:	c1 f8 0a             	sar    $0xa,%eax
  1009c1:	83 ec 08             	sub    $0x8,%esp
  1009c4:	50                   	push   %eax
  1009c5:	68 6c 5e 10 00       	push   $0x105e6c
  1009ca:	e8 c0 f8 ff ff       	call   10028f <cprintf>
  1009cf:	83 c4 10             	add    $0x10,%esp
}
  1009d2:	90                   	nop
  1009d3:	c9                   	leave  
  1009d4:	c3                   	ret    

001009d5 <print_debuginfo>:
/* *
 * print_debuginfo - read and print the stat information for the address @eip,
 * and info.eip_fn_addr should be the first address of the related function.
 * */
void
print_debuginfo(uintptr_t eip) {
  1009d5:	f3 0f 1e fb          	endbr32 
  1009d9:	55                   	push   %ebp
  1009da:	89 e5                	mov    %esp,%ebp
  1009dc:	81 ec 28 01 00 00    	sub    $0x128,%esp
    struct eipdebuginfo info;
    if (debuginfo_eip(eip, &info) != 0) {
  1009e2:	83 ec 08             	sub    $0x8,%esp
  1009e5:	8d 45 dc             	lea    -0x24(%ebp),%eax
  1009e8:	50                   	push   %eax
  1009e9:	ff 75 08             	pushl  0x8(%ebp)
  1009ec:	e8 3f fc ff ff       	call   100630 <debuginfo_eip>
  1009f1:	83 c4 10             	add    $0x10,%esp
  1009f4:	85 c0                	test   %eax,%eax
  1009f6:	74 15                	je     100a0d <print_debuginfo+0x38>
        cprintf("    <unknow>: -- 0x%08x --\n", eip);
  1009f8:	83 ec 08             	sub    $0x8,%esp
  1009fb:	ff 75 08             	pushl  0x8(%ebp)
  1009fe:	68 96 5e 10 00       	push   $0x105e96
  100a03:	e8 87 f8 ff ff       	call   10028f <cprintf>
  100a08:	83 c4 10             	add    $0x10,%esp
        }
        fnname[j] = '\0';
        cprintf("    %s:%d: %s+%d\n", info.eip_file, info.eip_line,
                fnname, eip - info.eip_fn_addr);
    }
}
  100a0b:	eb 65                	jmp    100a72 <print_debuginfo+0x9d>
        for (j = 0; j < info.eip_fn_namelen; j ++) {
  100a0d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  100a14:	eb 1c                	jmp    100a32 <print_debuginfo+0x5d>
            fnname[j] = info.eip_fn_name[j];
  100a16:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  100a19:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100a1c:	01 d0                	add    %edx,%eax
  100a1e:	0f b6 00             	movzbl (%eax),%eax
  100a21:	8d 8d dc fe ff ff    	lea    -0x124(%ebp),%ecx
  100a27:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100a2a:	01 ca                	add    %ecx,%edx
  100a2c:	88 02                	mov    %al,(%edx)
        for (j = 0; j < info.eip_fn_namelen; j ++) {
  100a2e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  100a32:	8b 45 e8             	mov    -0x18(%ebp),%eax
  100a35:	39 45 f4             	cmp    %eax,-0xc(%ebp)
  100a38:	7c dc                	jl     100a16 <print_debuginfo+0x41>
        fnname[j] = '\0';
  100a3a:	8d 95 dc fe ff ff    	lea    -0x124(%ebp),%edx
  100a40:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100a43:	01 d0                	add    %edx,%eax
  100a45:	c6 00 00             	movb   $0x0,(%eax)
                fnname, eip - info.eip_fn_addr);
  100a48:	8b 45 ec             	mov    -0x14(%ebp),%eax
        cprintf("    %s:%d: %s+%d\n", info.eip_file, info.eip_line,
  100a4b:	8b 55 08             	mov    0x8(%ebp),%edx
  100a4e:	89 d1                	mov    %edx,%ecx
  100a50:	29 c1                	sub    %eax,%ecx
  100a52:	8b 55 e0             	mov    -0x20(%ebp),%edx
  100a55:	8b 45 dc             	mov    -0x24(%ebp),%eax
  100a58:	83 ec 0c             	sub    $0xc,%esp
  100a5b:	51                   	push   %ecx
  100a5c:	8d 8d dc fe ff ff    	lea    -0x124(%ebp),%ecx
  100a62:	51                   	push   %ecx
  100a63:	52                   	push   %edx
  100a64:	50                   	push   %eax
  100a65:	68 b2 5e 10 00       	push   $0x105eb2
  100a6a:	e8 20 f8 ff ff       	call   10028f <cprintf>
  100a6f:	83 c4 20             	add    $0x20,%esp
}
  100a72:	90                   	nop
  100a73:	c9                   	leave  
  100a74:	c3                   	ret    

00100a75 <read_eip>:

static __noinline uint32_t
read_eip(void) {
  100a75:	f3 0f 1e fb          	endbr32 
  100a79:	55                   	push   %ebp
  100a7a:	89 e5                	mov    %esp,%ebp
  100a7c:	83 ec 10             	sub    $0x10,%esp
    uint32_t eip;
    asm volatile("movl 4(%%ebp), %0" : "=r" (eip));
  100a7f:	8b 45 04             	mov    0x4(%ebp),%eax
  100a82:	89 45 fc             	mov    %eax,-0x4(%ebp)
    return eip;
  100a85:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  100a88:	c9                   	leave  
  100a89:	c3                   	ret    

00100a8a <print_stackframe>:
 *
 * Note that, the length of ebp-chain is limited. In boot/bootasm.S, before jumping
 * to the kernel entry, the value of ebp has been set to zero, that's the boundary.
 * */
void
print_stackframe(void) {
  100a8a:	f3 0f 1e fb          	endbr32 
  100a8e:	55                   	push   %ebp
  100a8f:	89 e5                	mov    %esp,%ebp
  100a91:	83 ec 28             	sub    $0x28,%esp
}

static inline uint32_t
read_ebp(void) {
    uint32_t ebp;
    asm volatile ("movl %%ebp, %0" : "=r" (ebp));
  100a94:	89 e8                	mov    %ebp,%eax
  100a96:	89 45 e0             	mov    %eax,-0x20(%ebp)
    return ebp;
  100a99:	8b 45 e0             	mov    -0x20(%ebp),%eax
      *    (3.4) call print_debuginfo(eip-1) to print the C calling function name and line number, etc.
      *    (3.5) popup a calling stackframe
      *           NOTICE: the calling funciton's return addr eip  = ss:[ebp+4]
      *                   the calling funciton's ebp = ss:[ebp]
      */
	uint32_t ebp = read_ebp();
  100a9c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	uint32_t eip = read_eip();
  100a9f:	e8 d1 ff ff ff       	call   100a75 <read_eip>
  100aa4:	89 45 f0             	mov    %eax,-0x10(%ebp)
	for (int i = 0; i < STACKFRAME_DEPTH && ebp != 0; i++)
  100aa7:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  100aae:	e9 ad 00 00 00       	jmp    100b60 <print_stackframe+0xd6>
	{
		cprintf("ebp is 0x%08x ", ebp);
  100ab3:	83 ec 08             	sub    $0x8,%esp
  100ab6:	ff 75 f4             	pushl  -0xc(%ebp)
  100ab9:	68 c4 5e 10 00       	push   $0x105ec4
  100abe:	e8 cc f7 ff ff       	call   10028f <cprintf>
  100ac3:	83 c4 10             	add    $0x10,%esp
		cprintf("eip is 0x%08x ", eip);
  100ac6:	83 ec 08             	sub    $0x8,%esp
  100ac9:	ff 75 f0             	pushl  -0x10(%ebp)
  100acc:	68 d3 5e 10 00       	push   $0x105ed3
  100ad1:	e8 b9 f7 ff ff       	call   10028f <cprintf>
  100ad6:	83 c4 10             	add    $0x10,%esp
		uint32_t* args = (uint32_t*) ebp + 2;
  100ad9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100adc:	83 c0 08             	add    $0x8,%eax
  100adf:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		cprintf("args is ");
  100ae2:	83 ec 0c             	sub    $0xc,%esp
  100ae5:	68 e2 5e 10 00       	push   $0x105ee2
  100aea:	e8 a0 f7 ff ff       	call   10028f <cprintf>
  100aef:	83 c4 10             	add    $0x10,%esp
		for(int j = 0; j < 4; j++)
  100af2:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  100af9:	eb 26                	jmp    100b21 <print_stackframe+0x97>
		{
			cprintf("0x%08x ", args[j]);
  100afb:	8b 45 e8             	mov    -0x18(%ebp),%eax
  100afe:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  100b05:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  100b08:	01 d0                	add    %edx,%eax
  100b0a:	8b 00                	mov    (%eax),%eax
  100b0c:	83 ec 08             	sub    $0x8,%esp
  100b0f:	50                   	push   %eax
  100b10:	68 eb 5e 10 00       	push   $0x105eeb
  100b15:	e8 75 f7 ff ff       	call   10028f <cprintf>
  100b1a:	83 c4 10             	add    $0x10,%esp
		for(int j = 0; j < 4; j++)
  100b1d:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
  100b21:	83 7d e8 03          	cmpl   $0x3,-0x18(%ebp)
  100b25:	7e d4                	jle    100afb <print_stackframe+0x71>
		}
		cprintf("\n");
  100b27:	83 ec 0c             	sub    $0xc,%esp
  100b2a:	68 f3 5e 10 00       	push   $0x105ef3
  100b2f:	e8 5b f7 ff ff       	call   10028f <cprintf>
  100b34:	83 c4 10             	add    $0x10,%esp
		print_debuginfo(eip-1);
  100b37:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100b3a:	83 e8 01             	sub    $0x1,%eax
  100b3d:	83 ec 0c             	sub    $0xc,%esp
  100b40:	50                   	push   %eax
  100b41:	e8 8f fe ff ff       	call   1009d5 <print_debuginfo>
  100b46:	83 c4 10             	add    $0x10,%esp
		eip = ((uint32_t*) ebp) [1];
  100b49:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100b4c:	83 c0 04             	add    $0x4,%eax
  100b4f:	8b 00                	mov    (%eax),%eax
  100b51:	89 45 f0             	mov    %eax,-0x10(%ebp)
		ebp = ((uint32_t*) ebp) [0];
  100b54:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100b57:	8b 00                	mov    (%eax),%eax
  100b59:	89 45 f4             	mov    %eax,-0xc(%ebp)
	for (int i = 0; i < STACKFRAME_DEPTH && ebp != 0; i++)
  100b5c:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
  100b60:	83 7d ec 13          	cmpl   $0x13,-0x14(%ebp)
  100b64:	7f 0a                	jg     100b70 <print_stackframe+0xe6>
  100b66:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  100b6a:	0f 85 43 ff ff ff    	jne    100ab3 <print_stackframe+0x29>

	}
}
  100b70:	90                   	nop
  100b71:	c9                   	leave  
  100b72:	c3                   	ret    

00100b73 <parse>:
#define MAXARGS         16
#define WHITESPACE      " \t\n\r"

/* parse - parse the command buffer into whitespace-separated arguments */
static int
parse(char *buf, char **argv) {
  100b73:	f3 0f 1e fb          	endbr32 
  100b77:	55                   	push   %ebp
  100b78:	89 e5                	mov    %esp,%ebp
  100b7a:	83 ec 18             	sub    $0x18,%esp
    int argc = 0;
  100b7d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while (1) {
        // find global whitespace
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
  100b84:	eb 0c                	jmp    100b92 <parse+0x1f>
            *buf ++ = '\0';
  100b86:	8b 45 08             	mov    0x8(%ebp),%eax
  100b89:	8d 50 01             	lea    0x1(%eax),%edx
  100b8c:	89 55 08             	mov    %edx,0x8(%ebp)
  100b8f:	c6 00 00             	movb   $0x0,(%eax)
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
  100b92:	8b 45 08             	mov    0x8(%ebp),%eax
  100b95:	0f b6 00             	movzbl (%eax),%eax
  100b98:	84 c0                	test   %al,%al
  100b9a:	74 1e                	je     100bba <parse+0x47>
  100b9c:	8b 45 08             	mov    0x8(%ebp),%eax
  100b9f:	0f b6 00             	movzbl (%eax),%eax
  100ba2:	0f be c0             	movsbl %al,%eax
  100ba5:	83 ec 08             	sub    $0x8,%esp
  100ba8:	50                   	push   %eax
  100ba9:	68 78 5f 10 00       	push   $0x105f78
  100bae:	e8 ba 47 00 00       	call   10536d <strchr>
  100bb3:	83 c4 10             	add    $0x10,%esp
  100bb6:	85 c0                	test   %eax,%eax
  100bb8:	75 cc                	jne    100b86 <parse+0x13>
        }
        if (*buf == '\0') {
  100bba:	8b 45 08             	mov    0x8(%ebp),%eax
  100bbd:	0f b6 00             	movzbl (%eax),%eax
  100bc0:	84 c0                	test   %al,%al
  100bc2:	74 65                	je     100c29 <parse+0xb6>
            break;
        }

        // save and scan past next arg
        if (argc == MAXARGS - 1) {
  100bc4:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
  100bc8:	75 12                	jne    100bdc <parse+0x69>
            cprintf("Too many arguments (max %d).\n", MAXARGS);
  100bca:	83 ec 08             	sub    $0x8,%esp
  100bcd:	6a 10                	push   $0x10
  100bcf:	68 7d 5f 10 00       	push   $0x105f7d
  100bd4:	e8 b6 f6 ff ff       	call   10028f <cprintf>
  100bd9:	83 c4 10             	add    $0x10,%esp
        }
        argv[argc ++] = buf;
  100bdc:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100bdf:	8d 50 01             	lea    0x1(%eax),%edx
  100be2:	89 55 f4             	mov    %edx,-0xc(%ebp)
  100be5:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  100bec:	8b 45 0c             	mov    0xc(%ebp),%eax
  100bef:	01 c2                	add    %eax,%edx
  100bf1:	8b 45 08             	mov    0x8(%ebp),%eax
  100bf4:	89 02                	mov    %eax,(%edx)
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
  100bf6:	eb 04                	jmp    100bfc <parse+0x89>
            buf ++;
  100bf8:	83 45 08 01          	addl   $0x1,0x8(%ebp)
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
  100bfc:	8b 45 08             	mov    0x8(%ebp),%eax
  100bff:	0f b6 00             	movzbl (%eax),%eax
  100c02:	84 c0                	test   %al,%al
  100c04:	74 8c                	je     100b92 <parse+0x1f>
  100c06:	8b 45 08             	mov    0x8(%ebp),%eax
  100c09:	0f b6 00             	movzbl (%eax),%eax
  100c0c:	0f be c0             	movsbl %al,%eax
  100c0f:	83 ec 08             	sub    $0x8,%esp
  100c12:	50                   	push   %eax
  100c13:	68 78 5f 10 00       	push   $0x105f78
  100c18:	e8 50 47 00 00       	call   10536d <strchr>
  100c1d:	83 c4 10             	add    $0x10,%esp
  100c20:	85 c0                	test   %eax,%eax
  100c22:	74 d4                	je     100bf8 <parse+0x85>
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
  100c24:	e9 69 ff ff ff       	jmp    100b92 <parse+0x1f>
            break;
  100c29:	90                   	nop
        }
    }
    return argc;
  100c2a:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  100c2d:	c9                   	leave  
  100c2e:	c3                   	ret    

00100c2f <runcmd>:
/* *
 * runcmd - parse the input string, split it into separated arguments
 * and then lookup and invoke some related commands/
 * */
static int
runcmd(char *buf, struct trapframe *tf) {
  100c2f:	f3 0f 1e fb          	endbr32 
  100c33:	55                   	push   %ebp
  100c34:	89 e5                	mov    %esp,%ebp
  100c36:	83 ec 58             	sub    $0x58,%esp
    char *argv[MAXARGS];
    int argc = parse(buf, argv);
  100c39:	83 ec 08             	sub    $0x8,%esp
  100c3c:	8d 45 b0             	lea    -0x50(%ebp),%eax
  100c3f:	50                   	push   %eax
  100c40:	ff 75 08             	pushl  0x8(%ebp)
  100c43:	e8 2b ff ff ff       	call   100b73 <parse>
  100c48:	83 c4 10             	add    $0x10,%esp
  100c4b:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if (argc == 0) {
  100c4e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  100c52:	75 0a                	jne    100c5e <runcmd+0x2f>
        return 0;
  100c54:	b8 00 00 00 00       	mov    $0x0,%eax
  100c59:	e9 83 00 00 00       	jmp    100ce1 <runcmd+0xb2>
    }
    int i;
    for (i = 0; i < NCOMMANDS; i ++) {
  100c5e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  100c65:	eb 59                	jmp    100cc0 <runcmd+0x91>
        if (strcmp(commands[i].name, argv[0]) == 0) {
  100c67:	8b 4d b0             	mov    -0x50(%ebp),%ecx
  100c6a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100c6d:	89 d0                	mov    %edx,%eax
  100c6f:	01 c0                	add    %eax,%eax
  100c71:	01 d0                	add    %edx,%eax
  100c73:	c1 e0 02             	shl    $0x2,%eax
  100c76:	05 20 90 11 00       	add    $0x119020,%eax
  100c7b:	8b 00                	mov    (%eax),%eax
  100c7d:	83 ec 08             	sub    $0x8,%esp
  100c80:	51                   	push   %ecx
  100c81:	50                   	push   %eax
  100c82:	e8 3f 46 00 00       	call   1052c6 <strcmp>
  100c87:	83 c4 10             	add    $0x10,%esp
  100c8a:	85 c0                	test   %eax,%eax
  100c8c:	75 2e                	jne    100cbc <runcmd+0x8d>
            return commands[i].func(argc - 1, argv + 1, tf);
  100c8e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100c91:	89 d0                	mov    %edx,%eax
  100c93:	01 c0                	add    %eax,%eax
  100c95:	01 d0                	add    %edx,%eax
  100c97:	c1 e0 02             	shl    $0x2,%eax
  100c9a:	05 28 90 11 00       	add    $0x119028,%eax
  100c9f:	8b 10                	mov    (%eax),%edx
  100ca1:	8d 45 b0             	lea    -0x50(%ebp),%eax
  100ca4:	83 c0 04             	add    $0x4,%eax
  100ca7:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  100caa:	83 e9 01             	sub    $0x1,%ecx
  100cad:	83 ec 04             	sub    $0x4,%esp
  100cb0:	ff 75 0c             	pushl  0xc(%ebp)
  100cb3:	50                   	push   %eax
  100cb4:	51                   	push   %ecx
  100cb5:	ff d2                	call   *%edx
  100cb7:	83 c4 10             	add    $0x10,%esp
  100cba:	eb 25                	jmp    100ce1 <runcmd+0xb2>
    for (i = 0; i < NCOMMANDS; i ++) {
  100cbc:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  100cc0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100cc3:	83 f8 02             	cmp    $0x2,%eax
  100cc6:	76 9f                	jbe    100c67 <runcmd+0x38>
        }
    }
    cprintf("Unknown command '%s'\n", argv[0]);
  100cc8:	8b 45 b0             	mov    -0x50(%ebp),%eax
  100ccb:	83 ec 08             	sub    $0x8,%esp
  100cce:	50                   	push   %eax
  100ccf:	68 9b 5f 10 00       	push   $0x105f9b
  100cd4:	e8 b6 f5 ff ff       	call   10028f <cprintf>
  100cd9:	83 c4 10             	add    $0x10,%esp
    return 0;
  100cdc:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100ce1:	c9                   	leave  
  100ce2:	c3                   	ret    

00100ce3 <kmonitor>:

/***** Implementations of basic kernel monitor commands *****/

void
kmonitor(struct trapframe *tf) {
  100ce3:	f3 0f 1e fb          	endbr32 
  100ce7:	55                   	push   %ebp
  100ce8:	89 e5                	mov    %esp,%ebp
  100cea:	83 ec 18             	sub    $0x18,%esp
    cprintf("Welcome to the kernel debug monitor!!\n");
  100ced:	83 ec 0c             	sub    $0xc,%esp
  100cf0:	68 b4 5f 10 00       	push   $0x105fb4
  100cf5:	e8 95 f5 ff ff       	call   10028f <cprintf>
  100cfa:	83 c4 10             	add    $0x10,%esp
    cprintf("Type 'help' for a list of commands.\n");
  100cfd:	83 ec 0c             	sub    $0xc,%esp
  100d00:	68 dc 5f 10 00       	push   $0x105fdc
  100d05:	e8 85 f5 ff ff       	call   10028f <cprintf>
  100d0a:	83 c4 10             	add    $0x10,%esp

    if (tf != NULL) {
  100d0d:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  100d11:	74 0e                	je     100d21 <kmonitor+0x3e>
        print_trapframe(tf);
  100d13:	83 ec 0c             	sub    $0xc,%esp
  100d16:	ff 75 08             	pushl  0x8(%ebp)
  100d19:	e8 4e 0e 00 00       	call   101b6c <print_trapframe>
  100d1e:	83 c4 10             	add    $0x10,%esp
    }

    char *buf;
    while (1) {
        if ((buf = readline("K> ")) != NULL) {
  100d21:	83 ec 0c             	sub    $0xc,%esp
  100d24:	68 01 60 10 00       	push   $0x106001
  100d29:	e8 16 f6 ff ff       	call   100344 <readline>
  100d2e:	83 c4 10             	add    $0x10,%esp
  100d31:	89 45 f4             	mov    %eax,-0xc(%ebp)
  100d34:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  100d38:	74 e7                	je     100d21 <kmonitor+0x3e>
            if (runcmd(buf, tf) < 0) {
  100d3a:	83 ec 08             	sub    $0x8,%esp
  100d3d:	ff 75 08             	pushl  0x8(%ebp)
  100d40:	ff 75 f4             	pushl  -0xc(%ebp)
  100d43:	e8 e7 fe ff ff       	call   100c2f <runcmd>
  100d48:	83 c4 10             	add    $0x10,%esp
  100d4b:	85 c0                	test   %eax,%eax
  100d4d:	78 02                	js     100d51 <kmonitor+0x6e>
        if ((buf = readline("K> ")) != NULL) {
  100d4f:	eb d0                	jmp    100d21 <kmonitor+0x3e>
                break;
  100d51:	90                   	nop
            }
        }
    }
}
  100d52:	90                   	nop
  100d53:	c9                   	leave  
  100d54:	c3                   	ret    

00100d55 <mon_help>:

/* mon_help - print the information about mon_* functions */
int
mon_help(int argc, char **argv, struct trapframe *tf) {
  100d55:	f3 0f 1e fb          	endbr32 
  100d59:	55                   	push   %ebp
  100d5a:	89 e5                	mov    %esp,%ebp
  100d5c:	83 ec 18             	sub    $0x18,%esp
    int i;
    for (i = 0; i < NCOMMANDS; i ++) {
  100d5f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  100d66:	eb 3c                	jmp    100da4 <mon_help+0x4f>
        cprintf("%s - %s\n", commands[i].name, commands[i].desc);
  100d68:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100d6b:	89 d0                	mov    %edx,%eax
  100d6d:	01 c0                	add    %eax,%eax
  100d6f:	01 d0                	add    %edx,%eax
  100d71:	c1 e0 02             	shl    $0x2,%eax
  100d74:	05 24 90 11 00       	add    $0x119024,%eax
  100d79:	8b 08                	mov    (%eax),%ecx
  100d7b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100d7e:	89 d0                	mov    %edx,%eax
  100d80:	01 c0                	add    %eax,%eax
  100d82:	01 d0                	add    %edx,%eax
  100d84:	c1 e0 02             	shl    $0x2,%eax
  100d87:	05 20 90 11 00       	add    $0x119020,%eax
  100d8c:	8b 00                	mov    (%eax),%eax
  100d8e:	83 ec 04             	sub    $0x4,%esp
  100d91:	51                   	push   %ecx
  100d92:	50                   	push   %eax
  100d93:	68 05 60 10 00       	push   $0x106005
  100d98:	e8 f2 f4 ff ff       	call   10028f <cprintf>
  100d9d:	83 c4 10             	add    $0x10,%esp
    for (i = 0; i < NCOMMANDS; i ++) {
  100da0:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  100da4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100da7:	83 f8 02             	cmp    $0x2,%eax
  100daa:	76 bc                	jbe    100d68 <mon_help+0x13>
    }
    return 0;
  100dac:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100db1:	c9                   	leave  
  100db2:	c3                   	ret    

00100db3 <mon_kerninfo>:
/* *
 * mon_kerninfo - call print_kerninfo in kern/debug/kdebug.c to
 * print the memory occupancy in kernel.
 * */
int
mon_kerninfo(int argc, char **argv, struct trapframe *tf) {
  100db3:	f3 0f 1e fb          	endbr32 
  100db7:	55                   	push   %ebp
  100db8:	89 e5                	mov    %esp,%ebp
  100dba:	83 ec 08             	sub    $0x8,%esp
    print_kerninfo();
  100dbd:	e8 74 fb ff ff       	call   100936 <print_kerninfo>
    return 0;
  100dc2:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100dc7:	c9                   	leave  
  100dc8:	c3                   	ret    

00100dc9 <mon_backtrace>:
/* *
 * mon_backtrace - call print_stackframe in kern/debug/kdebug.c to
 * print a backtrace of the stack.
 * */
int
mon_backtrace(int argc, char **argv, struct trapframe *tf) {
  100dc9:	f3 0f 1e fb          	endbr32 
  100dcd:	55                   	push   %ebp
  100dce:	89 e5                	mov    %esp,%ebp
  100dd0:	83 ec 08             	sub    $0x8,%esp
    print_stackframe();
  100dd3:	e8 b2 fc ff ff       	call   100a8a <print_stackframe>
    return 0;
  100dd8:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100ddd:	c9                   	leave  
  100dde:	c3                   	ret    

00100ddf <clock_init>:
/* *
 * clock_init - initialize 8253 clock to interrupt 100 times per second,
 * and then enable IRQ_TIMER.
 * */
void
clock_init(void) {
  100ddf:	f3 0f 1e fb          	endbr32 
  100de3:	55                   	push   %ebp
  100de4:	89 e5                	mov    %esp,%ebp
  100de6:	83 ec 18             	sub    $0x18,%esp
  100de9:	66 c7 45 ee 43 00    	movw   $0x43,-0x12(%ebp)
  100def:	c6 45 ed 34          	movb   $0x34,-0x13(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
  100df3:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  100df7:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  100dfb:	ee                   	out    %al,(%dx)
}
  100dfc:	90                   	nop
  100dfd:	66 c7 45 f2 40 00    	movw   $0x40,-0xe(%ebp)
  100e03:	c6 45 f1 9c          	movb   $0x9c,-0xf(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
  100e07:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  100e0b:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  100e0f:	ee                   	out    %al,(%dx)
}
  100e10:	90                   	nop
  100e11:	66 c7 45 f6 40 00    	movw   $0x40,-0xa(%ebp)
  100e17:	c6 45 f5 2e          	movb   $0x2e,-0xb(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
  100e1b:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  100e1f:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  100e23:	ee                   	out    %al,(%dx)
}
  100e24:	90                   	nop
    outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
    outb(IO_TIMER1, TIMER_DIV(100) % 256);
    outb(IO_TIMER1, TIMER_DIV(100) / 256);

    // initialize time counter 'ticks' to zero
    ticks = 0;
  100e25:	c7 05 4c a9 11 00 00 	movl   $0x0,0x11a94c
  100e2c:	00 00 00 

    cprintf("++ setup timer interrupts\n");
  100e2f:	83 ec 0c             	sub    $0xc,%esp
  100e32:	68 0e 60 10 00       	push   $0x10600e
  100e37:	e8 53 f4 ff ff       	call   10028f <cprintf>
  100e3c:	83 c4 10             	add    $0x10,%esp
    pic_enable(IRQ_TIMER);
  100e3f:	83 ec 0c             	sub    $0xc,%esp
  100e42:	6a 00                	push   $0x0
  100e44:	e8 a6 09 00 00       	call   1017ef <pic_enable>
  100e49:	83 c4 10             	add    $0x10,%esp
}
  100e4c:	90                   	nop
  100e4d:	c9                   	leave  
  100e4e:	c3                   	ret    

00100e4f <__intr_save>:
#include <x86.h>
#include <intr.h>
#include <mmu.h>

static inline bool
__intr_save(void) {
  100e4f:	55                   	push   %ebp
  100e50:	89 e5                	mov    %esp,%ebp
  100e52:	83 ec 18             	sub    $0x18,%esp
}

static inline uint32_t
read_eflags(void) {
    uint32_t eflags;
    asm volatile ("pushfl; popl %0" : "=r" (eflags));
  100e55:	9c                   	pushf  
  100e56:	58                   	pop    %eax
  100e57:	89 45 f4             	mov    %eax,-0xc(%ebp)
    return eflags;
  100e5a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    if (read_eflags() & FL_IF) {
  100e5d:	25 00 02 00 00       	and    $0x200,%eax
  100e62:	85 c0                	test   %eax,%eax
  100e64:	74 0c                	je     100e72 <__intr_save+0x23>
        intr_disable();
  100e66:	e8 10 0b 00 00       	call   10197b <intr_disable>
        return 1;
  100e6b:	b8 01 00 00 00       	mov    $0x1,%eax
  100e70:	eb 05                	jmp    100e77 <__intr_save+0x28>
    }
    return 0;
  100e72:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100e77:	c9                   	leave  
  100e78:	c3                   	ret    

00100e79 <__intr_restore>:

static inline void
__intr_restore(bool flag) {
  100e79:	55                   	push   %ebp
  100e7a:	89 e5                	mov    %esp,%ebp
  100e7c:	83 ec 08             	sub    $0x8,%esp
    if (flag) {
  100e7f:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  100e83:	74 05                	je     100e8a <__intr_restore+0x11>
        intr_enable();
  100e85:	e8 e5 0a 00 00       	call   10196f <intr_enable>
    }
}
  100e8a:	90                   	nop
  100e8b:	c9                   	leave  
  100e8c:	c3                   	ret    

00100e8d <delay>:
#include <memlayout.h>
#include <sync.h>

/* stupid I/O delay routine necessitated by historical PC design flaws */
static void
delay(void) {
  100e8d:	f3 0f 1e fb          	endbr32 
  100e91:	55                   	push   %ebp
  100e92:	89 e5                	mov    %esp,%ebp
  100e94:	83 ec 10             	sub    $0x10,%esp
  100e97:	66 c7 45 f2 84 00    	movw   $0x84,-0xe(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port) : "memory");
  100e9d:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
  100ea1:	89 c2                	mov    %eax,%edx
  100ea3:	ec                   	in     (%dx),%al
  100ea4:	88 45 f1             	mov    %al,-0xf(%ebp)
  100ea7:	66 c7 45 f6 84 00    	movw   $0x84,-0xa(%ebp)
  100ead:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  100eb1:	89 c2                	mov    %eax,%edx
  100eb3:	ec                   	in     (%dx),%al
  100eb4:	88 45 f5             	mov    %al,-0xb(%ebp)
  100eb7:	66 c7 45 fa 84 00    	movw   $0x84,-0x6(%ebp)
  100ebd:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
  100ec1:	89 c2                	mov    %eax,%edx
  100ec3:	ec                   	in     (%dx),%al
  100ec4:	88 45 f9             	mov    %al,-0x7(%ebp)
  100ec7:	66 c7 45 fe 84 00    	movw   $0x84,-0x2(%ebp)
  100ecd:	0f b7 45 fe          	movzwl -0x2(%ebp),%eax
  100ed1:	89 c2                	mov    %eax,%edx
  100ed3:	ec                   	in     (%dx),%al
  100ed4:	88 45 fd             	mov    %al,-0x3(%ebp)
    inb(0x84);
    inb(0x84);
    inb(0x84);
    inb(0x84);
}
  100ed7:	90                   	nop
  100ed8:	c9                   	leave  
  100ed9:	c3                   	ret    

00100eda <cga_init>:
static uint16_t addr_6845;

/* TEXT-mode CGA/VGA display output */

static void
cga_init(void) {
  100eda:	f3 0f 1e fb          	endbr32 
  100ede:	55                   	push   %ebp
  100edf:	89 e5                	mov    %esp,%ebp
  100ee1:	83 ec 20             	sub    $0x20,%esp
    volatile uint16_t *cp = (uint16_t *)(CGA_BUF + KERNBASE);
  100ee4:	c7 45 fc 00 80 0b c0 	movl   $0xc00b8000,-0x4(%ebp)
    uint16_t was = *cp;
  100eeb:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100eee:	0f b7 00             	movzwl (%eax),%eax
  100ef1:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
    *cp = (uint16_t) 0xA55A;
  100ef5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100ef8:	66 c7 00 5a a5       	movw   $0xa55a,(%eax)
    if (*cp != 0xA55A) {
  100efd:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100f00:	0f b7 00             	movzwl (%eax),%eax
  100f03:	66 3d 5a a5          	cmp    $0xa55a,%ax
  100f07:	74 12                	je     100f1b <cga_init+0x41>
        cp = (uint16_t*)(MONO_BUF + KERNBASE);
  100f09:	c7 45 fc 00 00 0b c0 	movl   $0xc00b0000,-0x4(%ebp)
        addr_6845 = MONO_BASE;
  100f10:	66 c7 05 86 9e 11 00 	movw   $0x3b4,0x119e86
  100f17:	b4 03 
  100f19:	eb 13                	jmp    100f2e <cga_init+0x54>
    } else {
        *cp = was;
  100f1b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100f1e:	0f b7 55 fa          	movzwl -0x6(%ebp),%edx
  100f22:	66 89 10             	mov    %dx,(%eax)
        addr_6845 = CGA_BASE;
  100f25:	66 c7 05 86 9e 11 00 	movw   $0x3d4,0x119e86
  100f2c:	d4 03 
    }

    // Extract cursor location
    uint32_t pos;
    outb(addr_6845, 14);
  100f2e:	0f b7 05 86 9e 11 00 	movzwl 0x119e86,%eax
  100f35:	0f b7 c0             	movzwl %ax,%eax
  100f38:	66 89 45 e6          	mov    %ax,-0x1a(%ebp)
  100f3c:	c6 45 e5 0e          	movb   $0xe,-0x1b(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
  100f40:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
  100f44:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
  100f48:	ee                   	out    %al,(%dx)
}
  100f49:	90                   	nop
    pos = inb(addr_6845 + 1) << 8;
  100f4a:	0f b7 05 86 9e 11 00 	movzwl 0x119e86,%eax
  100f51:	83 c0 01             	add    $0x1,%eax
  100f54:	0f b7 c0             	movzwl %ax,%eax
  100f57:	66 89 45 ea          	mov    %ax,-0x16(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port) : "memory");
  100f5b:	0f b7 45 ea          	movzwl -0x16(%ebp),%eax
  100f5f:	89 c2                	mov    %eax,%edx
  100f61:	ec                   	in     (%dx),%al
  100f62:	88 45 e9             	mov    %al,-0x17(%ebp)
    return data;
  100f65:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
  100f69:	0f b6 c0             	movzbl %al,%eax
  100f6c:	c1 e0 08             	shl    $0x8,%eax
  100f6f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    outb(addr_6845, 15);
  100f72:	0f b7 05 86 9e 11 00 	movzwl 0x119e86,%eax
  100f79:	0f b7 c0             	movzwl %ax,%eax
  100f7c:	66 89 45 ee          	mov    %ax,-0x12(%ebp)
  100f80:	c6 45 ed 0f          	movb   $0xf,-0x13(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
  100f84:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  100f88:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  100f8c:	ee                   	out    %al,(%dx)
}
  100f8d:	90                   	nop
    pos |= inb(addr_6845 + 1);
  100f8e:	0f b7 05 86 9e 11 00 	movzwl 0x119e86,%eax
  100f95:	83 c0 01             	add    $0x1,%eax
  100f98:	0f b7 c0             	movzwl %ax,%eax
  100f9b:	66 89 45 f2          	mov    %ax,-0xe(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port) : "memory");
  100f9f:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
  100fa3:	89 c2                	mov    %eax,%edx
  100fa5:	ec                   	in     (%dx),%al
  100fa6:	88 45 f1             	mov    %al,-0xf(%ebp)
    return data;
  100fa9:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  100fad:	0f b6 c0             	movzbl %al,%eax
  100fb0:	09 45 f4             	or     %eax,-0xc(%ebp)

    crt_buf = (uint16_t*) cp;
  100fb3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100fb6:	a3 80 9e 11 00       	mov    %eax,0x119e80
    crt_pos = pos;
  100fbb:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100fbe:	66 a3 84 9e 11 00    	mov    %ax,0x119e84
}
  100fc4:	90                   	nop
  100fc5:	c9                   	leave  
  100fc6:	c3                   	ret    

00100fc7 <serial_init>:

static bool serial_exists = 0;

static void
serial_init(void) {
  100fc7:	f3 0f 1e fb          	endbr32 
  100fcb:	55                   	push   %ebp
  100fcc:	89 e5                	mov    %esp,%ebp
  100fce:	83 ec 38             	sub    $0x38,%esp
  100fd1:	66 c7 45 d2 fa 03    	movw   $0x3fa,-0x2e(%ebp)
  100fd7:	c6 45 d1 00          	movb   $0x0,-0x2f(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
  100fdb:	0f b6 45 d1          	movzbl -0x2f(%ebp),%eax
  100fdf:	0f b7 55 d2          	movzwl -0x2e(%ebp),%edx
  100fe3:	ee                   	out    %al,(%dx)
}
  100fe4:	90                   	nop
  100fe5:	66 c7 45 d6 fb 03    	movw   $0x3fb,-0x2a(%ebp)
  100feb:	c6 45 d5 80          	movb   $0x80,-0x2b(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
  100fef:	0f b6 45 d5          	movzbl -0x2b(%ebp),%eax
  100ff3:	0f b7 55 d6          	movzwl -0x2a(%ebp),%edx
  100ff7:	ee                   	out    %al,(%dx)
}
  100ff8:	90                   	nop
  100ff9:	66 c7 45 da f8 03    	movw   $0x3f8,-0x26(%ebp)
  100fff:	c6 45 d9 0c          	movb   $0xc,-0x27(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
  101003:	0f b6 45 d9          	movzbl -0x27(%ebp),%eax
  101007:	0f b7 55 da          	movzwl -0x26(%ebp),%edx
  10100b:	ee                   	out    %al,(%dx)
}
  10100c:	90                   	nop
  10100d:	66 c7 45 de f9 03    	movw   $0x3f9,-0x22(%ebp)
  101013:	c6 45 dd 00          	movb   $0x0,-0x23(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
  101017:	0f b6 45 dd          	movzbl -0x23(%ebp),%eax
  10101b:	0f b7 55 de          	movzwl -0x22(%ebp),%edx
  10101f:	ee                   	out    %al,(%dx)
}
  101020:	90                   	nop
  101021:	66 c7 45 e2 fb 03    	movw   $0x3fb,-0x1e(%ebp)
  101027:	c6 45 e1 03          	movb   $0x3,-0x1f(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
  10102b:	0f b6 45 e1          	movzbl -0x1f(%ebp),%eax
  10102f:	0f b7 55 e2          	movzwl -0x1e(%ebp),%edx
  101033:	ee                   	out    %al,(%dx)
}
  101034:	90                   	nop
  101035:	66 c7 45 e6 fc 03    	movw   $0x3fc,-0x1a(%ebp)
  10103b:	c6 45 e5 00          	movb   $0x0,-0x1b(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
  10103f:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
  101043:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
  101047:	ee                   	out    %al,(%dx)
}
  101048:	90                   	nop
  101049:	66 c7 45 ea f9 03    	movw   $0x3f9,-0x16(%ebp)
  10104f:	c6 45 e9 01          	movb   $0x1,-0x17(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
  101053:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
  101057:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
  10105b:	ee                   	out    %al,(%dx)
}
  10105c:	90                   	nop
  10105d:	66 c7 45 ee fd 03    	movw   $0x3fd,-0x12(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port) : "memory");
  101063:	0f b7 45 ee          	movzwl -0x12(%ebp),%eax
  101067:	89 c2                	mov    %eax,%edx
  101069:	ec                   	in     (%dx),%al
  10106a:	88 45 ed             	mov    %al,-0x13(%ebp)
    return data;
  10106d:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
    // Enable rcv interrupts
    outb(COM1 + COM_IER, COM_IER_RDI);

    // Clear any preexisting overrun indications and interrupts
    // Serial port doesn't exist if COM_LSR returns 0xFF
    serial_exists = (inb(COM1 + COM_LSR) != 0xFF);
  101071:	3c ff                	cmp    $0xff,%al
  101073:	0f 95 c0             	setne  %al
  101076:	0f b6 c0             	movzbl %al,%eax
  101079:	a3 88 9e 11 00       	mov    %eax,0x119e88
  10107e:	66 c7 45 f2 fa 03    	movw   $0x3fa,-0xe(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port) : "memory");
  101084:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
  101088:	89 c2                	mov    %eax,%edx
  10108a:	ec                   	in     (%dx),%al
  10108b:	88 45 f1             	mov    %al,-0xf(%ebp)
  10108e:	66 c7 45 f6 f8 03    	movw   $0x3f8,-0xa(%ebp)
  101094:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  101098:	89 c2                	mov    %eax,%edx
  10109a:	ec                   	in     (%dx),%al
  10109b:	88 45 f5             	mov    %al,-0xb(%ebp)
    (void) inb(COM1+COM_IIR);
    (void) inb(COM1+COM_RX);

    if (serial_exists) {
  10109e:	a1 88 9e 11 00       	mov    0x119e88,%eax
  1010a3:	85 c0                	test   %eax,%eax
  1010a5:	74 0d                	je     1010b4 <serial_init+0xed>
        pic_enable(IRQ_COM1);
  1010a7:	83 ec 0c             	sub    $0xc,%esp
  1010aa:	6a 04                	push   $0x4
  1010ac:	e8 3e 07 00 00       	call   1017ef <pic_enable>
  1010b1:	83 c4 10             	add    $0x10,%esp
    }
}
  1010b4:	90                   	nop
  1010b5:	c9                   	leave  
  1010b6:	c3                   	ret    

001010b7 <lpt_putc_sub>:

static void
lpt_putc_sub(int c) {
  1010b7:	f3 0f 1e fb          	endbr32 
  1010bb:	55                   	push   %ebp
  1010bc:	89 e5                	mov    %esp,%ebp
  1010be:	83 ec 20             	sub    $0x20,%esp
    int i;
    for (i = 0; !(inb(LPTPORT + 1) & 0x80) && i < 12800; i ++) {
  1010c1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  1010c8:	eb 09                	jmp    1010d3 <lpt_putc_sub+0x1c>
        delay();
  1010ca:	e8 be fd ff ff       	call   100e8d <delay>
    for (i = 0; !(inb(LPTPORT + 1) & 0x80) && i < 12800; i ++) {
  1010cf:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  1010d3:	66 c7 45 fa 79 03    	movw   $0x379,-0x6(%ebp)
  1010d9:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
  1010dd:	89 c2                	mov    %eax,%edx
  1010df:	ec                   	in     (%dx),%al
  1010e0:	88 45 f9             	mov    %al,-0x7(%ebp)
    return data;
  1010e3:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
  1010e7:	84 c0                	test   %al,%al
  1010e9:	78 09                	js     1010f4 <lpt_putc_sub+0x3d>
  1010eb:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%ebp)
  1010f2:	7e d6                	jle    1010ca <lpt_putc_sub+0x13>
    }
    outb(LPTPORT + 0, c);
  1010f4:	8b 45 08             	mov    0x8(%ebp),%eax
  1010f7:	0f b6 c0             	movzbl %al,%eax
  1010fa:	66 c7 45 ee 78 03    	movw   $0x378,-0x12(%ebp)
  101100:	88 45 ed             	mov    %al,-0x13(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
  101103:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  101107:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  10110b:	ee                   	out    %al,(%dx)
}
  10110c:	90                   	nop
  10110d:	66 c7 45 f2 7a 03    	movw   $0x37a,-0xe(%ebp)
  101113:	c6 45 f1 0d          	movb   $0xd,-0xf(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
  101117:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  10111b:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  10111f:	ee                   	out    %al,(%dx)
}
  101120:	90                   	nop
  101121:	66 c7 45 f6 7a 03    	movw   $0x37a,-0xa(%ebp)
  101127:	c6 45 f5 08          	movb   $0x8,-0xb(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
  10112b:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  10112f:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  101133:	ee                   	out    %al,(%dx)
}
  101134:	90                   	nop
    outb(LPTPORT + 2, 0x08 | 0x04 | 0x01);
    outb(LPTPORT + 2, 0x08);
}
  101135:	90                   	nop
  101136:	c9                   	leave  
  101137:	c3                   	ret    

00101138 <lpt_putc>:

/* lpt_putc - copy console output to parallel port */
static void
lpt_putc(int c) {
  101138:	f3 0f 1e fb          	endbr32 
  10113c:	55                   	push   %ebp
  10113d:	89 e5                	mov    %esp,%ebp
    if (c != '\b') {
  10113f:	83 7d 08 08          	cmpl   $0x8,0x8(%ebp)
  101143:	74 0d                	je     101152 <lpt_putc+0x1a>
        lpt_putc_sub(c);
  101145:	ff 75 08             	pushl  0x8(%ebp)
  101148:	e8 6a ff ff ff       	call   1010b7 <lpt_putc_sub>
  10114d:	83 c4 04             	add    $0x4,%esp
    else {
        lpt_putc_sub('\b');
        lpt_putc_sub(' ');
        lpt_putc_sub('\b');
    }
}
  101150:	eb 1e                	jmp    101170 <lpt_putc+0x38>
        lpt_putc_sub('\b');
  101152:	6a 08                	push   $0x8
  101154:	e8 5e ff ff ff       	call   1010b7 <lpt_putc_sub>
  101159:	83 c4 04             	add    $0x4,%esp
        lpt_putc_sub(' ');
  10115c:	6a 20                	push   $0x20
  10115e:	e8 54 ff ff ff       	call   1010b7 <lpt_putc_sub>
  101163:	83 c4 04             	add    $0x4,%esp
        lpt_putc_sub('\b');
  101166:	6a 08                	push   $0x8
  101168:	e8 4a ff ff ff       	call   1010b7 <lpt_putc_sub>
  10116d:	83 c4 04             	add    $0x4,%esp
}
  101170:	90                   	nop
  101171:	c9                   	leave  
  101172:	c3                   	ret    

00101173 <cga_putc>:

/* cga_putc - print character to console */
static void
cga_putc(int c) {
  101173:	f3 0f 1e fb          	endbr32 
  101177:	55                   	push   %ebp
  101178:	89 e5                	mov    %esp,%ebp
  10117a:	53                   	push   %ebx
  10117b:	83 ec 24             	sub    $0x24,%esp
    // set black on white
    if (!(c & ~0xFF)) {
  10117e:	8b 45 08             	mov    0x8(%ebp),%eax
  101181:	b0 00                	mov    $0x0,%al
  101183:	85 c0                	test   %eax,%eax
  101185:	75 07                	jne    10118e <cga_putc+0x1b>
        c |= 0x0700;
  101187:	81 4d 08 00 07 00 00 	orl    $0x700,0x8(%ebp)
    }

    switch (c & 0xff) {
  10118e:	8b 45 08             	mov    0x8(%ebp),%eax
  101191:	0f b6 c0             	movzbl %al,%eax
  101194:	83 f8 0d             	cmp    $0xd,%eax
  101197:	74 6c                	je     101205 <cga_putc+0x92>
  101199:	83 f8 0d             	cmp    $0xd,%eax
  10119c:	0f 8f 9d 00 00 00    	jg     10123f <cga_putc+0xcc>
  1011a2:	83 f8 08             	cmp    $0x8,%eax
  1011a5:	74 0a                	je     1011b1 <cga_putc+0x3e>
  1011a7:	83 f8 0a             	cmp    $0xa,%eax
  1011aa:	74 49                	je     1011f5 <cga_putc+0x82>
  1011ac:	e9 8e 00 00 00       	jmp    10123f <cga_putc+0xcc>
    case '\b':
        if (crt_pos > 0) {
  1011b1:	0f b7 05 84 9e 11 00 	movzwl 0x119e84,%eax
  1011b8:	66 85 c0             	test   %ax,%ax
  1011bb:	0f 84 a4 00 00 00    	je     101265 <cga_putc+0xf2>
            crt_pos --;
  1011c1:	0f b7 05 84 9e 11 00 	movzwl 0x119e84,%eax
  1011c8:	83 e8 01             	sub    $0x1,%eax
  1011cb:	66 a3 84 9e 11 00    	mov    %ax,0x119e84
            crt_buf[crt_pos] = (c & ~0xff) | ' ';
  1011d1:	8b 45 08             	mov    0x8(%ebp),%eax
  1011d4:	b0 00                	mov    $0x0,%al
  1011d6:	83 c8 20             	or     $0x20,%eax
  1011d9:	89 c1                	mov    %eax,%ecx
  1011db:	a1 80 9e 11 00       	mov    0x119e80,%eax
  1011e0:	0f b7 15 84 9e 11 00 	movzwl 0x119e84,%edx
  1011e7:	0f b7 d2             	movzwl %dx,%edx
  1011ea:	01 d2                	add    %edx,%edx
  1011ec:	01 d0                	add    %edx,%eax
  1011ee:	89 ca                	mov    %ecx,%edx
  1011f0:	66 89 10             	mov    %dx,(%eax)
        }
        break;
  1011f3:	eb 70                	jmp    101265 <cga_putc+0xf2>
    case '\n':
        crt_pos += CRT_COLS;
  1011f5:	0f b7 05 84 9e 11 00 	movzwl 0x119e84,%eax
  1011fc:	83 c0 50             	add    $0x50,%eax
  1011ff:	66 a3 84 9e 11 00    	mov    %ax,0x119e84
    case '\r':
        crt_pos -= (crt_pos % CRT_COLS);
  101205:	0f b7 1d 84 9e 11 00 	movzwl 0x119e84,%ebx
  10120c:	0f b7 0d 84 9e 11 00 	movzwl 0x119e84,%ecx
  101213:	0f b7 c1             	movzwl %cx,%eax
  101216:	69 c0 cd cc 00 00    	imul   $0xcccd,%eax,%eax
  10121c:	c1 e8 10             	shr    $0x10,%eax
  10121f:	89 c2                	mov    %eax,%edx
  101221:	66 c1 ea 06          	shr    $0x6,%dx
  101225:	89 d0                	mov    %edx,%eax
  101227:	c1 e0 02             	shl    $0x2,%eax
  10122a:	01 d0                	add    %edx,%eax
  10122c:	c1 e0 04             	shl    $0x4,%eax
  10122f:	29 c1                	sub    %eax,%ecx
  101231:	89 ca                	mov    %ecx,%edx
  101233:	89 d8                	mov    %ebx,%eax
  101235:	29 d0                	sub    %edx,%eax
  101237:	66 a3 84 9e 11 00    	mov    %ax,0x119e84
        break;
  10123d:	eb 27                	jmp    101266 <cga_putc+0xf3>
    default:
        crt_buf[crt_pos ++] = c;     // write the character
  10123f:	8b 0d 80 9e 11 00    	mov    0x119e80,%ecx
  101245:	0f b7 05 84 9e 11 00 	movzwl 0x119e84,%eax
  10124c:	8d 50 01             	lea    0x1(%eax),%edx
  10124f:	66 89 15 84 9e 11 00 	mov    %dx,0x119e84
  101256:	0f b7 c0             	movzwl %ax,%eax
  101259:	01 c0                	add    %eax,%eax
  10125b:	01 c8                	add    %ecx,%eax
  10125d:	8b 55 08             	mov    0x8(%ebp),%edx
  101260:	66 89 10             	mov    %dx,(%eax)
        break;
  101263:	eb 01                	jmp    101266 <cga_putc+0xf3>
        break;
  101265:	90                   	nop
    }

    // What is the purpose of this?
    if (crt_pos >= CRT_SIZE) {
  101266:	0f b7 05 84 9e 11 00 	movzwl 0x119e84,%eax
  10126d:	66 3d cf 07          	cmp    $0x7cf,%ax
  101271:	76 59                	jbe    1012cc <cga_putc+0x159>
        int i;
        memmove(crt_buf, crt_buf + CRT_COLS, (CRT_SIZE - CRT_COLS) * sizeof(uint16_t));
  101273:	a1 80 9e 11 00       	mov    0x119e80,%eax
  101278:	8d 90 a0 00 00 00    	lea    0xa0(%eax),%edx
  10127e:	a1 80 9e 11 00       	mov    0x119e80,%eax
  101283:	83 ec 04             	sub    $0x4,%esp
  101286:	68 00 0f 00 00       	push   $0xf00
  10128b:	52                   	push   %edx
  10128c:	50                   	push   %eax
  10128d:	e8 e9 42 00 00       	call   10557b <memmove>
  101292:	83 c4 10             	add    $0x10,%esp
        for (i = CRT_SIZE - CRT_COLS; i < CRT_SIZE; i ++) {
  101295:	c7 45 f4 80 07 00 00 	movl   $0x780,-0xc(%ebp)
  10129c:	eb 15                	jmp    1012b3 <cga_putc+0x140>
            crt_buf[i] = 0x0700 | ' ';
  10129e:	a1 80 9e 11 00       	mov    0x119e80,%eax
  1012a3:	8b 55 f4             	mov    -0xc(%ebp),%edx
  1012a6:	01 d2                	add    %edx,%edx
  1012a8:	01 d0                	add    %edx,%eax
  1012aa:	66 c7 00 20 07       	movw   $0x720,(%eax)
        for (i = CRT_SIZE - CRT_COLS; i < CRT_SIZE; i ++) {
  1012af:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  1012b3:	81 7d f4 cf 07 00 00 	cmpl   $0x7cf,-0xc(%ebp)
  1012ba:	7e e2                	jle    10129e <cga_putc+0x12b>
        }
        crt_pos -= CRT_COLS;
  1012bc:	0f b7 05 84 9e 11 00 	movzwl 0x119e84,%eax
  1012c3:	83 e8 50             	sub    $0x50,%eax
  1012c6:	66 a3 84 9e 11 00    	mov    %ax,0x119e84
    }

    // move that little blinky thing
    outb(addr_6845, 14);
  1012cc:	0f b7 05 86 9e 11 00 	movzwl 0x119e86,%eax
  1012d3:	0f b7 c0             	movzwl %ax,%eax
  1012d6:	66 89 45 e6          	mov    %ax,-0x1a(%ebp)
  1012da:	c6 45 e5 0e          	movb   $0xe,-0x1b(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
  1012de:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
  1012e2:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
  1012e6:	ee                   	out    %al,(%dx)
}
  1012e7:	90                   	nop
    outb(addr_6845 + 1, crt_pos >> 8);
  1012e8:	0f b7 05 84 9e 11 00 	movzwl 0x119e84,%eax
  1012ef:	66 c1 e8 08          	shr    $0x8,%ax
  1012f3:	0f b6 c0             	movzbl %al,%eax
  1012f6:	0f b7 15 86 9e 11 00 	movzwl 0x119e86,%edx
  1012fd:	83 c2 01             	add    $0x1,%edx
  101300:	0f b7 d2             	movzwl %dx,%edx
  101303:	66 89 55 ea          	mov    %dx,-0x16(%ebp)
  101307:	88 45 e9             	mov    %al,-0x17(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
  10130a:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
  10130e:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
  101312:	ee                   	out    %al,(%dx)
}
  101313:	90                   	nop
    outb(addr_6845, 15);
  101314:	0f b7 05 86 9e 11 00 	movzwl 0x119e86,%eax
  10131b:	0f b7 c0             	movzwl %ax,%eax
  10131e:	66 89 45 ee          	mov    %ax,-0x12(%ebp)
  101322:	c6 45 ed 0f          	movb   $0xf,-0x13(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
  101326:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  10132a:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  10132e:	ee                   	out    %al,(%dx)
}
  10132f:	90                   	nop
    outb(addr_6845 + 1, crt_pos);
  101330:	0f b7 05 84 9e 11 00 	movzwl 0x119e84,%eax
  101337:	0f b6 c0             	movzbl %al,%eax
  10133a:	0f b7 15 86 9e 11 00 	movzwl 0x119e86,%edx
  101341:	83 c2 01             	add    $0x1,%edx
  101344:	0f b7 d2             	movzwl %dx,%edx
  101347:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  10134b:	88 45 f1             	mov    %al,-0xf(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
  10134e:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  101352:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  101356:	ee                   	out    %al,(%dx)
}
  101357:	90                   	nop
}
  101358:	90                   	nop
  101359:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  10135c:	c9                   	leave  
  10135d:	c3                   	ret    

0010135e <serial_putc_sub>:

static void
serial_putc_sub(int c) {
  10135e:	f3 0f 1e fb          	endbr32 
  101362:	55                   	push   %ebp
  101363:	89 e5                	mov    %esp,%ebp
  101365:	83 ec 10             	sub    $0x10,%esp
    int i;
    for (i = 0; !(inb(COM1 + COM_LSR) & COM_LSR_TXRDY) && i < 12800; i ++) {
  101368:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  10136f:	eb 09                	jmp    10137a <serial_putc_sub+0x1c>
        delay();
  101371:	e8 17 fb ff ff       	call   100e8d <delay>
    for (i = 0; !(inb(COM1 + COM_LSR) & COM_LSR_TXRDY) && i < 12800; i ++) {
  101376:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  10137a:	66 c7 45 fa fd 03    	movw   $0x3fd,-0x6(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port) : "memory");
  101380:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
  101384:	89 c2                	mov    %eax,%edx
  101386:	ec                   	in     (%dx),%al
  101387:	88 45 f9             	mov    %al,-0x7(%ebp)
    return data;
  10138a:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
  10138e:	0f b6 c0             	movzbl %al,%eax
  101391:	83 e0 20             	and    $0x20,%eax
  101394:	85 c0                	test   %eax,%eax
  101396:	75 09                	jne    1013a1 <serial_putc_sub+0x43>
  101398:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%ebp)
  10139f:	7e d0                	jle    101371 <serial_putc_sub+0x13>
    }
    outb(COM1 + COM_TX, c);
  1013a1:	8b 45 08             	mov    0x8(%ebp),%eax
  1013a4:	0f b6 c0             	movzbl %al,%eax
  1013a7:	66 c7 45 f6 f8 03    	movw   $0x3f8,-0xa(%ebp)
  1013ad:	88 45 f5             	mov    %al,-0xb(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
  1013b0:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  1013b4:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  1013b8:	ee                   	out    %al,(%dx)
}
  1013b9:	90                   	nop
}
  1013ba:	90                   	nop
  1013bb:	c9                   	leave  
  1013bc:	c3                   	ret    

001013bd <serial_putc>:

/* serial_putc - print character to serial port */
static void
serial_putc(int c) {
  1013bd:	f3 0f 1e fb          	endbr32 
  1013c1:	55                   	push   %ebp
  1013c2:	89 e5                	mov    %esp,%ebp
    if (c != '\b') {
  1013c4:	83 7d 08 08          	cmpl   $0x8,0x8(%ebp)
  1013c8:	74 0d                	je     1013d7 <serial_putc+0x1a>
        serial_putc_sub(c);
  1013ca:	ff 75 08             	pushl  0x8(%ebp)
  1013cd:	e8 8c ff ff ff       	call   10135e <serial_putc_sub>
  1013d2:	83 c4 04             	add    $0x4,%esp
    else {
        serial_putc_sub('\b');
        serial_putc_sub(' ');
        serial_putc_sub('\b');
    }
}
  1013d5:	eb 1e                	jmp    1013f5 <serial_putc+0x38>
        serial_putc_sub('\b');
  1013d7:	6a 08                	push   $0x8
  1013d9:	e8 80 ff ff ff       	call   10135e <serial_putc_sub>
  1013de:	83 c4 04             	add    $0x4,%esp
        serial_putc_sub(' ');
  1013e1:	6a 20                	push   $0x20
  1013e3:	e8 76 ff ff ff       	call   10135e <serial_putc_sub>
  1013e8:	83 c4 04             	add    $0x4,%esp
        serial_putc_sub('\b');
  1013eb:	6a 08                	push   $0x8
  1013ed:	e8 6c ff ff ff       	call   10135e <serial_putc_sub>
  1013f2:	83 c4 04             	add    $0x4,%esp
}
  1013f5:	90                   	nop
  1013f6:	c9                   	leave  
  1013f7:	c3                   	ret    

001013f8 <cons_intr>:
/* *
 * cons_intr - called by device interrupt routines to feed input
 * characters into the circular console input buffer.
 * */
static void
cons_intr(int (*proc)(void)) {
  1013f8:	f3 0f 1e fb          	endbr32 
  1013fc:	55                   	push   %ebp
  1013fd:	89 e5                	mov    %esp,%ebp
  1013ff:	83 ec 18             	sub    $0x18,%esp
    int c;
    while ((c = (*proc)()) != -1) {
  101402:	eb 33                	jmp    101437 <cons_intr+0x3f>
        if (c != 0) {
  101404:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  101408:	74 2d                	je     101437 <cons_intr+0x3f>
            cons.buf[cons.wpos ++] = c;
  10140a:	a1 a4 a0 11 00       	mov    0x11a0a4,%eax
  10140f:	8d 50 01             	lea    0x1(%eax),%edx
  101412:	89 15 a4 a0 11 00    	mov    %edx,0x11a0a4
  101418:	8b 55 f4             	mov    -0xc(%ebp),%edx
  10141b:	88 90 a0 9e 11 00    	mov    %dl,0x119ea0(%eax)
            if (cons.wpos == CONSBUFSIZE) {
  101421:	a1 a4 a0 11 00       	mov    0x11a0a4,%eax
  101426:	3d 00 02 00 00       	cmp    $0x200,%eax
  10142b:	75 0a                	jne    101437 <cons_intr+0x3f>
                cons.wpos = 0;
  10142d:	c7 05 a4 a0 11 00 00 	movl   $0x0,0x11a0a4
  101434:	00 00 00 
    while ((c = (*proc)()) != -1) {
  101437:	8b 45 08             	mov    0x8(%ebp),%eax
  10143a:	ff d0                	call   *%eax
  10143c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  10143f:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
  101443:	75 bf                	jne    101404 <cons_intr+0xc>
            }
        }
    }
}
  101445:	90                   	nop
  101446:	90                   	nop
  101447:	c9                   	leave  
  101448:	c3                   	ret    

00101449 <serial_proc_data>:

/* serial_proc_data - get data from serial port */
static int
serial_proc_data(void) {
  101449:	f3 0f 1e fb          	endbr32 
  10144d:	55                   	push   %ebp
  10144e:	89 e5                	mov    %esp,%ebp
  101450:	83 ec 10             	sub    $0x10,%esp
  101453:	66 c7 45 fa fd 03    	movw   $0x3fd,-0x6(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port) : "memory");
  101459:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
  10145d:	89 c2                	mov    %eax,%edx
  10145f:	ec                   	in     (%dx),%al
  101460:	88 45 f9             	mov    %al,-0x7(%ebp)
    return data;
  101463:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
    if (!(inb(COM1 + COM_LSR) & COM_LSR_DATA)) {
  101467:	0f b6 c0             	movzbl %al,%eax
  10146a:	83 e0 01             	and    $0x1,%eax
  10146d:	85 c0                	test   %eax,%eax
  10146f:	75 07                	jne    101478 <serial_proc_data+0x2f>
        return -1;
  101471:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  101476:	eb 2a                	jmp    1014a2 <serial_proc_data+0x59>
  101478:	66 c7 45 f6 f8 03    	movw   $0x3f8,-0xa(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port) : "memory");
  10147e:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  101482:	89 c2                	mov    %eax,%edx
  101484:	ec                   	in     (%dx),%al
  101485:	88 45 f5             	mov    %al,-0xb(%ebp)
    return data;
  101488:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
    }
    int c = inb(COM1 + COM_RX);
  10148c:	0f b6 c0             	movzbl %al,%eax
  10148f:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (c == 127) {
  101492:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%ebp)
  101496:	75 07                	jne    10149f <serial_proc_data+0x56>
        c = '\b';
  101498:	c7 45 fc 08 00 00 00 	movl   $0x8,-0x4(%ebp)
    }
    return c;
  10149f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  1014a2:	c9                   	leave  
  1014a3:	c3                   	ret    

001014a4 <serial_intr>:

/* serial_intr - try to feed input characters from serial port */
void
serial_intr(void) {
  1014a4:	f3 0f 1e fb          	endbr32 
  1014a8:	55                   	push   %ebp
  1014a9:	89 e5                	mov    %esp,%ebp
  1014ab:	83 ec 08             	sub    $0x8,%esp
    if (serial_exists) {
  1014ae:	a1 88 9e 11 00       	mov    0x119e88,%eax
  1014b3:	85 c0                	test   %eax,%eax
  1014b5:	74 10                	je     1014c7 <serial_intr+0x23>
        cons_intr(serial_proc_data);
  1014b7:	83 ec 0c             	sub    $0xc,%esp
  1014ba:	68 49 14 10 00       	push   $0x101449
  1014bf:	e8 34 ff ff ff       	call   1013f8 <cons_intr>
  1014c4:	83 c4 10             	add    $0x10,%esp
    }
}
  1014c7:	90                   	nop
  1014c8:	c9                   	leave  
  1014c9:	c3                   	ret    

001014ca <kbd_proc_data>:
 *
 * The kbd_proc_data() function gets data from the keyboard.
 * If we finish a character, return it, else 0. And return -1 if no data.
 * */
static int
kbd_proc_data(void) {
  1014ca:	f3 0f 1e fb          	endbr32 
  1014ce:	55                   	push   %ebp
  1014cf:	89 e5                	mov    %esp,%ebp
  1014d1:	83 ec 28             	sub    $0x28,%esp
  1014d4:	66 c7 45 f0 64 00    	movw   $0x64,-0x10(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port) : "memory");
  1014da:	0f b7 45 f0          	movzwl -0x10(%ebp),%eax
  1014de:	89 c2                	mov    %eax,%edx
  1014e0:	ec                   	in     (%dx),%al
  1014e1:	88 45 ef             	mov    %al,-0x11(%ebp)
    return data;
  1014e4:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    int c;
    uint8_t data;
    static uint32_t shift;

    if ((inb(KBSTATP) & KBS_DIB) == 0) {
  1014e8:	0f b6 c0             	movzbl %al,%eax
  1014eb:	83 e0 01             	and    $0x1,%eax
  1014ee:	85 c0                	test   %eax,%eax
  1014f0:	75 0a                	jne    1014fc <kbd_proc_data+0x32>
        return -1;
  1014f2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  1014f7:	e9 5e 01 00 00       	jmp    10165a <kbd_proc_data+0x190>
  1014fc:	66 c7 45 ec 60 00    	movw   $0x60,-0x14(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port) : "memory");
  101502:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
  101506:	89 c2                	mov    %eax,%edx
  101508:	ec                   	in     (%dx),%al
  101509:	88 45 eb             	mov    %al,-0x15(%ebp)
    return data;
  10150c:	0f b6 45 eb          	movzbl -0x15(%ebp),%eax
    }

    data = inb(KBDATAP);
  101510:	88 45 f3             	mov    %al,-0xd(%ebp)

    if (data == 0xE0) {
  101513:	80 7d f3 e0          	cmpb   $0xe0,-0xd(%ebp)
  101517:	75 17                	jne    101530 <kbd_proc_data+0x66>
        // E0 escape character
        shift |= E0ESC;
  101519:	a1 a8 a0 11 00       	mov    0x11a0a8,%eax
  10151e:	83 c8 40             	or     $0x40,%eax
  101521:	a3 a8 a0 11 00       	mov    %eax,0x11a0a8
        return 0;
  101526:	b8 00 00 00 00       	mov    $0x0,%eax
  10152b:	e9 2a 01 00 00       	jmp    10165a <kbd_proc_data+0x190>
    } else if (data & 0x80) {
  101530:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  101534:	84 c0                	test   %al,%al
  101536:	79 47                	jns    10157f <kbd_proc_data+0xb5>
        // Key released
        data = (shift & E0ESC ? data : data & 0x7F);
  101538:	a1 a8 a0 11 00       	mov    0x11a0a8,%eax
  10153d:	83 e0 40             	and    $0x40,%eax
  101540:	85 c0                	test   %eax,%eax
  101542:	75 09                	jne    10154d <kbd_proc_data+0x83>
  101544:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  101548:	83 e0 7f             	and    $0x7f,%eax
  10154b:	eb 04                	jmp    101551 <kbd_proc_data+0x87>
  10154d:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  101551:	88 45 f3             	mov    %al,-0xd(%ebp)
        shift &= ~(shiftcode[data] | E0ESC);
  101554:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  101558:	0f b6 80 60 90 11 00 	movzbl 0x119060(%eax),%eax
  10155f:	83 c8 40             	or     $0x40,%eax
  101562:	0f b6 c0             	movzbl %al,%eax
  101565:	f7 d0                	not    %eax
  101567:	89 c2                	mov    %eax,%edx
  101569:	a1 a8 a0 11 00       	mov    0x11a0a8,%eax
  10156e:	21 d0                	and    %edx,%eax
  101570:	a3 a8 a0 11 00       	mov    %eax,0x11a0a8
        return 0;
  101575:	b8 00 00 00 00       	mov    $0x0,%eax
  10157a:	e9 db 00 00 00       	jmp    10165a <kbd_proc_data+0x190>
    } else if (shift & E0ESC) {
  10157f:	a1 a8 a0 11 00       	mov    0x11a0a8,%eax
  101584:	83 e0 40             	and    $0x40,%eax
  101587:	85 c0                	test   %eax,%eax
  101589:	74 11                	je     10159c <kbd_proc_data+0xd2>
        // Last character was an E0 escape; or with 0x80
        data |= 0x80;
  10158b:	80 4d f3 80          	orb    $0x80,-0xd(%ebp)
        shift &= ~E0ESC;
  10158f:	a1 a8 a0 11 00       	mov    0x11a0a8,%eax
  101594:	83 e0 bf             	and    $0xffffffbf,%eax
  101597:	a3 a8 a0 11 00       	mov    %eax,0x11a0a8
    }

    shift |= shiftcode[data];
  10159c:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  1015a0:	0f b6 80 60 90 11 00 	movzbl 0x119060(%eax),%eax
  1015a7:	0f b6 d0             	movzbl %al,%edx
  1015aa:	a1 a8 a0 11 00       	mov    0x11a0a8,%eax
  1015af:	09 d0                	or     %edx,%eax
  1015b1:	a3 a8 a0 11 00       	mov    %eax,0x11a0a8
    shift ^= togglecode[data];
  1015b6:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  1015ba:	0f b6 80 60 91 11 00 	movzbl 0x119160(%eax),%eax
  1015c1:	0f b6 d0             	movzbl %al,%edx
  1015c4:	a1 a8 a0 11 00       	mov    0x11a0a8,%eax
  1015c9:	31 d0                	xor    %edx,%eax
  1015cb:	a3 a8 a0 11 00       	mov    %eax,0x11a0a8

    c = charcode[shift & (CTL | SHIFT)][data];
  1015d0:	a1 a8 a0 11 00       	mov    0x11a0a8,%eax
  1015d5:	83 e0 03             	and    $0x3,%eax
  1015d8:	8b 14 85 60 95 11 00 	mov    0x119560(,%eax,4),%edx
  1015df:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  1015e3:	01 d0                	add    %edx,%eax
  1015e5:	0f b6 00             	movzbl (%eax),%eax
  1015e8:	0f b6 c0             	movzbl %al,%eax
  1015eb:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (shift & CAPSLOCK) {
  1015ee:	a1 a8 a0 11 00       	mov    0x11a0a8,%eax
  1015f3:	83 e0 08             	and    $0x8,%eax
  1015f6:	85 c0                	test   %eax,%eax
  1015f8:	74 22                	je     10161c <kbd_proc_data+0x152>
        if ('a' <= c && c <= 'z')
  1015fa:	83 7d f4 60          	cmpl   $0x60,-0xc(%ebp)
  1015fe:	7e 0c                	jle    10160c <kbd_proc_data+0x142>
  101600:	83 7d f4 7a          	cmpl   $0x7a,-0xc(%ebp)
  101604:	7f 06                	jg     10160c <kbd_proc_data+0x142>
            c += 'A' - 'a';
  101606:	83 6d f4 20          	subl   $0x20,-0xc(%ebp)
  10160a:	eb 10                	jmp    10161c <kbd_proc_data+0x152>
        else if ('A' <= c && c <= 'Z')
  10160c:	83 7d f4 40          	cmpl   $0x40,-0xc(%ebp)
  101610:	7e 0a                	jle    10161c <kbd_proc_data+0x152>
  101612:	83 7d f4 5a          	cmpl   $0x5a,-0xc(%ebp)
  101616:	7f 04                	jg     10161c <kbd_proc_data+0x152>
            c += 'a' - 'A';
  101618:	83 45 f4 20          	addl   $0x20,-0xc(%ebp)
    }

    // Process special keys
    // Ctrl-Alt-Del: reboot
    if (!(~shift & (CTL | ALT)) && c == KEY_DEL) {
  10161c:	a1 a8 a0 11 00       	mov    0x11a0a8,%eax
  101621:	f7 d0                	not    %eax
  101623:	83 e0 06             	and    $0x6,%eax
  101626:	85 c0                	test   %eax,%eax
  101628:	75 2d                	jne    101657 <kbd_proc_data+0x18d>
  10162a:	81 7d f4 e9 00 00 00 	cmpl   $0xe9,-0xc(%ebp)
  101631:	75 24                	jne    101657 <kbd_proc_data+0x18d>
        cprintf("Rebooting!\n");
  101633:	83 ec 0c             	sub    $0xc,%esp
  101636:	68 29 60 10 00       	push   $0x106029
  10163b:	e8 4f ec ff ff       	call   10028f <cprintf>
  101640:	83 c4 10             	add    $0x10,%esp
  101643:	66 c7 45 e8 92 00    	movw   $0x92,-0x18(%ebp)
  101649:	c6 45 e7 03          	movb   $0x3,-0x19(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
  10164d:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
  101651:	0f b7 55 e8          	movzwl -0x18(%ebp),%edx
  101655:	ee                   	out    %al,(%dx)
}
  101656:	90                   	nop
        outb(0x92, 0x3); // courtesy of Chris Frost
    }
    return c;
  101657:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  10165a:	c9                   	leave  
  10165b:	c3                   	ret    

0010165c <kbd_intr>:

/* kbd_intr - try to feed input characters from keyboard */
static void
kbd_intr(void) {
  10165c:	f3 0f 1e fb          	endbr32 
  101660:	55                   	push   %ebp
  101661:	89 e5                	mov    %esp,%ebp
  101663:	83 ec 08             	sub    $0x8,%esp
    cons_intr(kbd_proc_data);
  101666:	83 ec 0c             	sub    $0xc,%esp
  101669:	68 ca 14 10 00       	push   $0x1014ca
  10166e:	e8 85 fd ff ff       	call   1013f8 <cons_intr>
  101673:	83 c4 10             	add    $0x10,%esp
}
  101676:	90                   	nop
  101677:	c9                   	leave  
  101678:	c3                   	ret    

00101679 <kbd_init>:

static void
kbd_init(void) {
  101679:	f3 0f 1e fb          	endbr32 
  10167d:	55                   	push   %ebp
  10167e:	89 e5                	mov    %esp,%ebp
  101680:	83 ec 08             	sub    $0x8,%esp
    // drain the kbd buffer
    kbd_intr();
  101683:	e8 d4 ff ff ff       	call   10165c <kbd_intr>
    pic_enable(IRQ_KBD);
  101688:	83 ec 0c             	sub    $0xc,%esp
  10168b:	6a 01                	push   $0x1
  10168d:	e8 5d 01 00 00       	call   1017ef <pic_enable>
  101692:	83 c4 10             	add    $0x10,%esp
}
  101695:	90                   	nop
  101696:	c9                   	leave  
  101697:	c3                   	ret    

00101698 <cons_init>:

/* cons_init - initializes the console devices */
void
cons_init(void) {
  101698:	f3 0f 1e fb          	endbr32 
  10169c:	55                   	push   %ebp
  10169d:	89 e5                	mov    %esp,%ebp
  10169f:	83 ec 08             	sub    $0x8,%esp
    cga_init();
  1016a2:	e8 33 f8 ff ff       	call   100eda <cga_init>
    serial_init();
  1016a7:	e8 1b f9 ff ff       	call   100fc7 <serial_init>
    kbd_init();
  1016ac:	e8 c8 ff ff ff       	call   101679 <kbd_init>
    if (!serial_exists) {
  1016b1:	a1 88 9e 11 00       	mov    0x119e88,%eax
  1016b6:	85 c0                	test   %eax,%eax
  1016b8:	75 10                	jne    1016ca <cons_init+0x32>
        cprintf("serial port does not exist!!\n");
  1016ba:	83 ec 0c             	sub    $0xc,%esp
  1016bd:	68 35 60 10 00       	push   $0x106035
  1016c2:	e8 c8 eb ff ff       	call   10028f <cprintf>
  1016c7:	83 c4 10             	add    $0x10,%esp
    }
}
  1016ca:	90                   	nop
  1016cb:	c9                   	leave  
  1016cc:	c3                   	ret    

001016cd <cons_putc>:

/* cons_putc - print a single character @c to console devices */
void
cons_putc(int c) {
  1016cd:	f3 0f 1e fb          	endbr32 
  1016d1:	55                   	push   %ebp
  1016d2:	89 e5                	mov    %esp,%ebp
  1016d4:	83 ec 18             	sub    $0x18,%esp
    bool intr_flag;
    local_intr_save(intr_flag);
  1016d7:	e8 73 f7 ff ff       	call   100e4f <__intr_save>
  1016dc:	89 45 f4             	mov    %eax,-0xc(%ebp)
    {
        lpt_putc(c);
  1016df:	83 ec 0c             	sub    $0xc,%esp
  1016e2:	ff 75 08             	pushl  0x8(%ebp)
  1016e5:	e8 4e fa ff ff       	call   101138 <lpt_putc>
  1016ea:	83 c4 10             	add    $0x10,%esp
        cga_putc(c);
  1016ed:	83 ec 0c             	sub    $0xc,%esp
  1016f0:	ff 75 08             	pushl  0x8(%ebp)
  1016f3:	e8 7b fa ff ff       	call   101173 <cga_putc>
  1016f8:	83 c4 10             	add    $0x10,%esp
        serial_putc(c);
  1016fb:	83 ec 0c             	sub    $0xc,%esp
  1016fe:	ff 75 08             	pushl  0x8(%ebp)
  101701:	e8 b7 fc ff ff       	call   1013bd <serial_putc>
  101706:	83 c4 10             	add    $0x10,%esp
    }
    local_intr_restore(intr_flag);
  101709:	83 ec 0c             	sub    $0xc,%esp
  10170c:	ff 75 f4             	pushl  -0xc(%ebp)
  10170f:	e8 65 f7 ff ff       	call   100e79 <__intr_restore>
  101714:	83 c4 10             	add    $0x10,%esp
}
  101717:	90                   	nop
  101718:	c9                   	leave  
  101719:	c3                   	ret    

0010171a <cons_getc>:
/* *
 * cons_getc - return the next input character from console,
 * or 0 if none waiting.
 * */
int
cons_getc(void) {
  10171a:	f3 0f 1e fb          	endbr32 
  10171e:	55                   	push   %ebp
  10171f:	89 e5                	mov    %esp,%ebp
  101721:	83 ec 18             	sub    $0x18,%esp
    int c = 0;
  101724:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    bool intr_flag;
    local_intr_save(intr_flag);
  10172b:	e8 1f f7 ff ff       	call   100e4f <__intr_save>
  101730:	89 45 f0             	mov    %eax,-0x10(%ebp)
    {
        // poll for any pending input characters,
        // so that this function works even when interrupts are disabled
        // (e.g., when called from the kernel monitor).
        serial_intr();
  101733:	e8 6c fd ff ff       	call   1014a4 <serial_intr>
        kbd_intr();
  101738:	e8 1f ff ff ff       	call   10165c <kbd_intr>

        // grab the next character from the input buffer.
        if (cons.rpos != cons.wpos) {
  10173d:	8b 15 a0 a0 11 00    	mov    0x11a0a0,%edx
  101743:	a1 a4 a0 11 00       	mov    0x11a0a4,%eax
  101748:	39 c2                	cmp    %eax,%edx
  10174a:	74 31                	je     10177d <cons_getc+0x63>
            c = cons.buf[cons.rpos ++];
  10174c:	a1 a0 a0 11 00       	mov    0x11a0a0,%eax
  101751:	8d 50 01             	lea    0x1(%eax),%edx
  101754:	89 15 a0 a0 11 00    	mov    %edx,0x11a0a0
  10175a:	0f b6 80 a0 9e 11 00 	movzbl 0x119ea0(%eax),%eax
  101761:	0f b6 c0             	movzbl %al,%eax
  101764:	89 45 f4             	mov    %eax,-0xc(%ebp)
            if (cons.rpos == CONSBUFSIZE) {
  101767:	a1 a0 a0 11 00       	mov    0x11a0a0,%eax
  10176c:	3d 00 02 00 00       	cmp    $0x200,%eax
  101771:	75 0a                	jne    10177d <cons_getc+0x63>
                cons.rpos = 0;
  101773:	c7 05 a0 a0 11 00 00 	movl   $0x0,0x11a0a0
  10177a:	00 00 00 
            }
        }
    }
    local_intr_restore(intr_flag);
  10177d:	83 ec 0c             	sub    $0xc,%esp
  101780:	ff 75 f0             	pushl  -0x10(%ebp)
  101783:	e8 f1 f6 ff ff       	call   100e79 <__intr_restore>
  101788:	83 c4 10             	add    $0x10,%esp
    return c;
  10178b:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  10178e:	c9                   	leave  
  10178f:	c3                   	ret    

00101790 <pic_setmask>:
// Initial IRQ mask has interrupt 2 enabled (for slave 8259A).
static uint16_t irq_mask = 0xFFFF & ~(1 << IRQ_SLAVE);
static bool did_init = 0;

static void
pic_setmask(uint16_t mask) {
  101790:	f3 0f 1e fb          	endbr32 
  101794:	55                   	push   %ebp
  101795:	89 e5                	mov    %esp,%ebp
  101797:	83 ec 14             	sub    $0x14,%esp
  10179a:	8b 45 08             	mov    0x8(%ebp),%eax
  10179d:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
    irq_mask = mask;
  1017a1:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
  1017a5:	66 a3 70 95 11 00    	mov    %ax,0x119570
    if (did_init) {
  1017ab:	a1 ac a0 11 00       	mov    0x11a0ac,%eax
  1017b0:	85 c0                	test   %eax,%eax
  1017b2:	74 38                	je     1017ec <pic_setmask+0x5c>
        outb(IO_PIC1 + 1, mask);
  1017b4:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
  1017b8:	0f b6 c0             	movzbl %al,%eax
  1017bb:	66 c7 45 fa 21 00    	movw   $0x21,-0x6(%ebp)
  1017c1:	88 45 f9             	mov    %al,-0x7(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
  1017c4:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
  1017c8:	0f b7 55 fa          	movzwl -0x6(%ebp),%edx
  1017cc:	ee                   	out    %al,(%dx)
}
  1017cd:	90                   	nop
        outb(IO_PIC2 + 1, mask >> 8);
  1017ce:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
  1017d2:	66 c1 e8 08          	shr    $0x8,%ax
  1017d6:	0f b6 c0             	movzbl %al,%eax
  1017d9:	66 c7 45 fe a1 00    	movw   $0xa1,-0x2(%ebp)
  1017df:	88 45 fd             	mov    %al,-0x3(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
  1017e2:	0f b6 45 fd          	movzbl -0x3(%ebp),%eax
  1017e6:	0f b7 55 fe          	movzwl -0x2(%ebp),%edx
  1017ea:	ee                   	out    %al,(%dx)
}
  1017eb:	90                   	nop
    }
}
  1017ec:	90                   	nop
  1017ed:	c9                   	leave  
  1017ee:	c3                   	ret    

001017ef <pic_enable>:

void
pic_enable(unsigned int irq) {
  1017ef:	f3 0f 1e fb          	endbr32 
  1017f3:	55                   	push   %ebp
  1017f4:	89 e5                	mov    %esp,%ebp
    pic_setmask(irq_mask & ~(1 << irq));
  1017f6:	8b 45 08             	mov    0x8(%ebp),%eax
  1017f9:	ba 01 00 00 00       	mov    $0x1,%edx
  1017fe:	89 c1                	mov    %eax,%ecx
  101800:	d3 e2                	shl    %cl,%edx
  101802:	89 d0                	mov    %edx,%eax
  101804:	f7 d0                	not    %eax
  101806:	89 c2                	mov    %eax,%edx
  101808:	0f b7 05 70 95 11 00 	movzwl 0x119570,%eax
  10180f:	21 d0                	and    %edx,%eax
  101811:	0f b7 c0             	movzwl %ax,%eax
  101814:	50                   	push   %eax
  101815:	e8 76 ff ff ff       	call   101790 <pic_setmask>
  10181a:	83 c4 04             	add    $0x4,%esp
}
  10181d:	90                   	nop
  10181e:	c9                   	leave  
  10181f:	c3                   	ret    

00101820 <pic_init>:

/* pic_init - initialize the 8259A interrupt controllers */
void
pic_init(void) {
  101820:	f3 0f 1e fb          	endbr32 
  101824:	55                   	push   %ebp
  101825:	89 e5                	mov    %esp,%ebp
  101827:	83 ec 40             	sub    $0x40,%esp
    did_init = 1;
  10182a:	c7 05 ac a0 11 00 01 	movl   $0x1,0x11a0ac
  101831:	00 00 00 
  101834:	66 c7 45 ca 21 00    	movw   $0x21,-0x36(%ebp)
  10183a:	c6 45 c9 ff          	movb   $0xff,-0x37(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
  10183e:	0f b6 45 c9          	movzbl -0x37(%ebp),%eax
  101842:	0f b7 55 ca          	movzwl -0x36(%ebp),%edx
  101846:	ee                   	out    %al,(%dx)
}
  101847:	90                   	nop
  101848:	66 c7 45 ce a1 00    	movw   $0xa1,-0x32(%ebp)
  10184e:	c6 45 cd ff          	movb   $0xff,-0x33(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
  101852:	0f b6 45 cd          	movzbl -0x33(%ebp),%eax
  101856:	0f b7 55 ce          	movzwl -0x32(%ebp),%edx
  10185a:	ee                   	out    %al,(%dx)
}
  10185b:	90                   	nop
  10185c:	66 c7 45 d2 20 00    	movw   $0x20,-0x2e(%ebp)
  101862:	c6 45 d1 11          	movb   $0x11,-0x2f(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
  101866:	0f b6 45 d1          	movzbl -0x2f(%ebp),%eax
  10186a:	0f b7 55 d2          	movzwl -0x2e(%ebp),%edx
  10186e:	ee                   	out    %al,(%dx)
}
  10186f:	90                   	nop
  101870:	66 c7 45 d6 21 00    	movw   $0x21,-0x2a(%ebp)
  101876:	c6 45 d5 20          	movb   $0x20,-0x2b(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
  10187a:	0f b6 45 d5          	movzbl -0x2b(%ebp),%eax
  10187e:	0f b7 55 d6          	movzwl -0x2a(%ebp),%edx
  101882:	ee                   	out    %al,(%dx)
}
  101883:	90                   	nop
  101884:	66 c7 45 da 21 00    	movw   $0x21,-0x26(%ebp)
  10188a:	c6 45 d9 04          	movb   $0x4,-0x27(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
  10188e:	0f b6 45 d9          	movzbl -0x27(%ebp),%eax
  101892:	0f b7 55 da          	movzwl -0x26(%ebp),%edx
  101896:	ee                   	out    %al,(%dx)
}
  101897:	90                   	nop
  101898:	66 c7 45 de 21 00    	movw   $0x21,-0x22(%ebp)
  10189e:	c6 45 dd 03          	movb   $0x3,-0x23(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
  1018a2:	0f b6 45 dd          	movzbl -0x23(%ebp),%eax
  1018a6:	0f b7 55 de          	movzwl -0x22(%ebp),%edx
  1018aa:	ee                   	out    %al,(%dx)
}
  1018ab:	90                   	nop
  1018ac:	66 c7 45 e2 a0 00    	movw   $0xa0,-0x1e(%ebp)
  1018b2:	c6 45 e1 11          	movb   $0x11,-0x1f(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
  1018b6:	0f b6 45 e1          	movzbl -0x1f(%ebp),%eax
  1018ba:	0f b7 55 e2          	movzwl -0x1e(%ebp),%edx
  1018be:	ee                   	out    %al,(%dx)
}
  1018bf:	90                   	nop
  1018c0:	66 c7 45 e6 a1 00    	movw   $0xa1,-0x1a(%ebp)
  1018c6:	c6 45 e5 28          	movb   $0x28,-0x1b(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
  1018ca:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
  1018ce:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
  1018d2:	ee                   	out    %al,(%dx)
}
  1018d3:	90                   	nop
  1018d4:	66 c7 45 ea a1 00    	movw   $0xa1,-0x16(%ebp)
  1018da:	c6 45 e9 02          	movb   $0x2,-0x17(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
  1018de:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
  1018e2:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
  1018e6:	ee                   	out    %al,(%dx)
}
  1018e7:	90                   	nop
  1018e8:	66 c7 45 ee a1 00    	movw   $0xa1,-0x12(%ebp)
  1018ee:	c6 45 ed 03          	movb   $0x3,-0x13(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
  1018f2:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  1018f6:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  1018fa:	ee                   	out    %al,(%dx)
}
  1018fb:	90                   	nop
  1018fc:	66 c7 45 f2 20 00    	movw   $0x20,-0xe(%ebp)
  101902:	c6 45 f1 68          	movb   $0x68,-0xf(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
  101906:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  10190a:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  10190e:	ee                   	out    %al,(%dx)
}
  10190f:	90                   	nop
  101910:	66 c7 45 f6 20 00    	movw   $0x20,-0xa(%ebp)
  101916:	c6 45 f5 0a          	movb   $0xa,-0xb(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
  10191a:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  10191e:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  101922:	ee                   	out    %al,(%dx)
}
  101923:	90                   	nop
  101924:	66 c7 45 fa a0 00    	movw   $0xa0,-0x6(%ebp)
  10192a:	c6 45 f9 68          	movb   $0x68,-0x7(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
  10192e:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
  101932:	0f b7 55 fa          	movzwl -0x6(%ebp),%edx
  101936:	ee                   	out    %al,(%dx)
}
  101937:	90                   	nop
  101938:	66 c7 45 fe a0 00    	movw   $0xa0,-0x2(%ebp)
  10193e:	c6 45 fd 0a          	movb   $0xa,-0x3(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
  101942:	0f b6 45 fd          	movzbl -0x3(%ebp),%eax
  101946:	0f b7 55 fe          	movzwl -0x2(%ebp),%edx
  10194a:	ee                   	out    %al,(%dx)
}
  10194b:	90                   	nop
    outb(IO_PIC1, 0x0a);    // read IRR by default

    outb(IO_PIC2, 0x68);    // OCW3
    outb(IO_PIC2, 0x0a);    // OCW3

    if (irq_mask != 0xFFFF) {
  10194c:	0f b7 05 70 95 11 00 	movzwl 0x119570,%eax
  101953:	66 83 f8 ff          	cmp    $0xffff,%ax
  101957:	74 13                	je     10196c <pic_init+0x14c>
        pic_setmask(irq_mask);
  101959:	0f b7 05 70 95 11 00 	movzwl 0x119570,%eax
  101960:	0f b7 c0             	movzwl %ax,%eax
  101963:	50                   	push   %eax
  101964:	e8 27 fe ff ff       	call   101790 <pic_setmask>
  101969:	83 c4 04             	add    $0x4,%esp
    }
}
  10196c:	90                   	nop
  10196d:	c9                   	leave  
  10196e:	c3                   	ret    

0010196f <intr_enable>:
#include <x86.h>
#include <intr.h>

/* intr_enable - enable irq interrupt */
void
intr_enable(void) {
  10196f:	f3 0f 1e fb          	endbr32 
  101973:	55                   	push   %ebp
  101974:	89 e5                	mov    %esp,%ebp
    asm volatile ("sti");
  101976:	fb                   	sti    
}
  101977:	90                   	nop
    sti();
}
  101978:	90                   	nop
  101979:	5d                   	pop    %ebp
  10197a:	c3                   	ret    

0010197b <intr_disable>:

/* intr_disable - disable irq interrupt */
void
intr_disable(void) {
  10197b:	f3 0f 1e fb          	endbr32 
  10197f:	55                   	push   %ebp
  101980:	89 e5                	mov    %esp,%ebp
    asm volatile ("cli" ::: "memory");
  101982:	fa                   	cli    
}
  101983:	90                   	nop
    cli();
}
  101984:	90                   	nop
  101985:	5d                   	pop    %ebp
  101986:	c3                   	ret    

00101987 <print_ticks>:
#include <console.h>
#include <kdebug.h>

#define TICK_NUM 100

static void print_ticks() {
  101987:	f3 0f 1e fb          	endbr32 
  10198b:	55                   	push   %ebp
  10198c:	89 e5                	mov    %esp,%ebp
  10198e:	83 ec 08             	sub    $0x8,%esp
    cprintf("%d ticks\n",TICK_NUM);
  101991:	83 ec 08             	sub    $0x8,%esp
  101994:	6a 64                	push   $0x64
  101996:	68 60 60 10 00       	push   $0x106060
  10199b:	e8 ef e8 ff ff       	call   10028f <cprintf>
  1019a0:	83 c4 10             	add    $0x10,%esp
#ifdef DEBUG_GRADE
    cprintf("End of Test.\n");
    panic("EOT: kernel seems ok.");
#endif
}
  1019a3:	90                   	nop
  1019a4:	c9                   	leave  
  1019a5:	c3                   	ret    

001019a6 <idt_init>:
    sizeof(idt) - 1, (uintptr_t)idt
};

/* idt_init - initialize IDT to each of the entry points in kern/trap/vectors.S */
void
idt_init(void) {
  1019a6:	f3 0f 1e fb          	endbr32 
  1019aa:	55                   	push   %ebp
  1019ab:	89 e5                	mov    %esp,%ebp
  1019ad:	83 ec 10             	sub    $0x10,%esp
      * (3) After setup the contents of IDT, you will let CPU know where is the IDT by using 'lidt' instruction.
      *     You don't know the meaning of this instruction? just google it! and check the libs/x86.h to know more.
      *     Notice: the argument of lidt is idt_pd. try to find it!
      */
      extern uintptr_t __vectors[];
	for(int i=0; i < sizeof(idt)/sizeof(struct gatedesc); i++)
  1019b0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  1019b7:	e9 c3 00 00 00       	jmp    101a7f <idt_init+0xd9>
	{
		SETGATE(idt[i], 0, GD_KTEXT, __vectors[i], DPL_KERNEL);
  1019bc:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1019bf:	8b 04 85 00 96 11 00 	mov    0x119600(,%eax,4),%eax
  1019c6:	89 c2                	mov    %eax,%edx
  1019c8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1019cb:	66 89 14 c5 c0 a0 11 	mov    %dx,0x11a0c0(,%eax,8)
  1019d2:	00 
  1019d3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1019d6:	66 c7 04 c5 c2 a0 11 	movw   $0x8,0x11a0c2(,%eax,8)
  1019dd:	00 08 00 
  1019e0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1019e3:	0f b6 14 c5 c4 a0 11 	movzbl 0x11a0c4(,%eax,8),%edx
  1019ea:	00 
  1019eb:	83 e2 e0             	and    $0xffffffe0,%edx
  1019ee:	88 14 c5 c4 a0 11 00 	mov    %dl,0x11a0c4(,%eax,8)
  1019f5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1019f8:	0f b6 14 c5 c4 a0 11 	movzbl 0x11a0c4(,%eax,8),%edx
  1019ff:	00 
  101a00:	83 e2 1f             	and    $0x1f,%edx
  101a03:	88 14 c5 c4 a0 11 00 	mov    %dl,0x11a0c4(,%eax,8)
  101a0a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101a0d:	0f b6 14 c5 c5 a0 11 	movzbl 0x11a0c5(,%eax,8),%edx
  101a14:	00 
  101a15:	83 e2 f0             	and    $0xfffffff0,%edx
  101a18:	83 ca 0e             	or     $0xe,%edx
  101a1b:	88 14 c5 c5 a0 11 00 	mov    %dl,0x11a0c5(,%eax,8)
  101a22:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101a25:	0f b6 14 c5 c5 a0 11 	movzbl 0x11a0c5(,%eax,8),%edx
  101a2c:	00 
  101a2d:	83 e2 ef             	and    $0xffffffef,%edx
  101a30:	88 14 c5 c5 a0 11 00 	mov    %dl,0x11a0c5(,%eax,8)
  101a37:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101a3a:	0f b6 14 c5 c5 a0 11 	movzbl 0x11a0c5(,%eax,8),%edx
  101a41:	00 
  101a42:	83 e2 9f             	and    $0xffffff9f,%edx
  101a45:	88 14 c5 c5 a0 11 00 	mov    %dl,0x11a0c5(,%eax,8)
  101a4c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101a4f:	0f b6 14 c5 c5 a0 11 	movzbl 0x11a0c5(,%eax,8),%edx
  101a56:	00 
  101a57:	83 ca 80             	or     $0xffffff80,%edx
  101a5a:	88 14 c5 c5 a0 11 00 	mov    %dl,0x11a0c5(,%eax,8)
  101a61:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101a64:	8b 04 85 00 96 11 00 	mov    0x119600(,%eax,4),%eax
  101a6b:	c1 e8 10             	shr    $0x10,%eax
  101a6e:	89 c2                	mov    %eax,%edx
  101a70:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101a73:	66 89 14 c5 c6 a0 11 	mov    %dx,0x11a0c6(,%eax,8)
  101a7a:	00 
	for(int i=0; i < sizeof(idt)/sizeof(struct gatedesc); i++)
  101a7b:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  101a7f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101a82:	3d ff 00 00 00       	cmp    $0xff,%eax
  101a87:	0f 86 2f ff ff ff    	jbe    1019bc <idt_init+0x16>
	}
	SETGATE(idt[T_SWITCH_TOK], 0, GD_KTEXT, __vectors[T_SWITCH_TOK], DPL_USER);
  101a8d:	a1 e4 97 11 00       	mov    0x1197e4,%eax
  101a92:	66 a3 88 a4 11 00    	mov    %ax,0x11a488
  101a98:	66 c7 05 8a a4 11 00 	movw   $0x8,0x11a48a
  101a9f:	08 00 
  101aa1:	0f b6 05 8c a4 11 00 	movzbl 0x11a48c,%eax
  101aa8:	83 e0 e0             	and    $0xffffffe0,%eax
  101aab:	a2 8c a4 11 00       	mov    %al,0x11a48c
  101ab0:	0f b6 05 8c a4 11 00 	movzbl 0x11a48c,%eax
  101ab7:	83 e0 1f             	and    $0x1f,%eax
  101aba:	a2 8c a4 11 00       	mov    %al,0x11a48c
  101abf:	0f b6 05 8d a4 11 00 	movzbl 0x11a48d,%eax
  101ac6:	83 e0 f0             	and    $0xfffffff0,%eax
  101ac9:	83 c8 0e             	or     $0xe,%eax
  101acc:	a2 8d a4 11 00       	mov    %al,0x11a48d
  101ad1:	0f b6 05 8d a4 11 00 	movzbl 0x11a48d,%eax
  101ad8:	83 e0 ef             	and    $0xffffffef,%eax
  101adb:	a2 8d a4 11 00       	mov    %al,0x11a48d
  101ae0:	0f b6 05 8d a4 11 00 	movzbl 0x11a48d,%eax
  101ae7:	83 c8 60             	or     $0x60,%eax
  101aea:	a2 8d a4 11 00       	mov    %al,0x11a48d
  101aef:	0f b6 05 8d a4 11 00 	movzbl 0x11a48d,%eax
  101af6:	83 c8 80             	or     $0xffffff80,%eax
  101af9:	a2 8d a4 11 00       	mov    %al,0x11a48d
  101afe:	a1 e4 97 11 00       	mov    0x1197e4,%eax
  101b03:	c1 e8 10             	shr    $0x10,%eax
  101b06:	66 a3 8e a4 11 00    	mov    %ax,0x11a48e
  101b0c:	c7 45 f8 80 95 11 00 	movl   $0x119580,-0x8(%ebp)
    asm volatile ("lidt (%0)" :: "r" (pd) : "memory");
  101b13:	8b 45 f8             	mov    -0x8(%ebp),%eax
  101b16:	0f 01 18             	lidtl  (%eax)
}
  101b19:	90                   	nop
	lidt(&idt_pd);
}
  101b1a:	90                   	nop
  101b1b:	c9                   	leave  
  101b1c:	c3                   	ret    

00101b1d <trapname>:

static const char *
trapname(int trapno) {
  101b1d:	f3 0f 1e fb          	endbr32 
  101b21:	55                   	push   %ebp
  101b22:	89 e5                	mov    %esp,%ebp
        "Alignment Check",
        "Machine-Check",
        "SIMD Floating-Point Exception"
    };

    if (trapno < sizeof(excnames)/sizeof(const char * const)) {
  101b24:	8b 45 08             	mov    0x8(%ebp),%eax
  101b27:	83 f8 13             	cmp    $0x13,%eax
  101b2a:	77 0c                	ja     101b38 <trapname+0x1b>
        return excnames[trapno];
  101b2c:	8b 45 08             	mov    0x8(%ebp),%eax
  101b2f:	8b 04 85 c0 63 10 00 	mov    0x1063c0(,%eax,4),%eax
  101b36:	eb 18                	jmp    101b50 <trapname+0x33>
    }
    if (trapno >= IRQ_OFFSET && trapno < IRQ_OFFSET + 16) {
  101b38:	83 7d 08 1f          	cmpl   $0x1f,0x8(%ebp)
  101b3c:	7e 0d                	jle    101b4b <trapname+0x2e>
  101b3e:	83 7d 08 2f          	cmpl   $0x2f,0x8(%ebp)
  101b42:	7f 07                	jg     101b4b <trapname+0x2e>
        return "Hardware Interrupt";
  101b44:	b8 6a 60 10 00       	mov    $0x10606a,%eax
  101b49:	eb 05                	jmp    101b50 <trapname+0x33>
    }
    return "(unknown trap)";
  101b4b:	b8 7d 60 10 00       	mov    $0x10607d,%eax
}
  101b50:	5d                   	pop    %ebp
  101b51:	c3                   	ret    

00101b52 <trap_in_kernel>:

/* trap_in_kernel - test if trap happened in kernel */
bool
trap_in_kernel(struct trapframe *tf) {
  101b52:	f3 0f 1e fb          	endbr32 
  101b56:	55                   	push   %ebp
  101b57:	89 e5                	mov    %esp,%ebp
    return (tf->tf_cs == (uint16_t)KERNEL_CS);
  101b59:	8b 45 08             	mov    0x8(%ebp),%eax
  101b5c:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101b60:	66 83 f8 08          	cmp    $0x8,%ax
  101b64:	0f 94 c0             	sete   %al
  101b67:	0f b6 c0             	movzbl %al,%eax
}
  101b6a:	5d                   	pop    %ebp
  101b6b:	c3                   	ret    

00101b6c <print_trapframe>:
    "TF", "IF", "DF", "OF", NULL, NULL, "NT", NULL,
    "RF", "VM", "AC", "VIF", "VIP", "ID", NULL, NULL,
};

void
print_trapframe(struct trapframe *tf) {
  101b6c:	f3 0f 1e fb          	endbr32 
  101b70:	55                   	push   %ebp
  101b71:	89 e5                	mov    %esp,%ebp
  101b73:	83 ec 18             	sub    $0x18,%esp
    cprintf("trapframe at %p\n", tf);
  101b76:	83 ec 08             	sub    $0x8,%esp
  101b79:	ff 75 08             	pushl  0x8(%ebp)
  101b7c:	68 be 60 10 00       	push   $0x1060be
  101b81:	e8 09 e7 ff ff       	call   10028f <cprintf>
  101b86:	83 c4 10             	add    $0x10,%esp
    print_regs(&tf->tf_regs);
  101b89:	8b 45 08             	mov    0x8(%ebp),%eax
  101b8c:	83 ec 0c             	sub    $0xc,%esp
  101b8f:	50                   	push   %eax
  101b90:	e8 b4 01 00 00       	call   101d49 <print_regs>
  101b95:	83 c4 10             	add    $0x10,%esp
    cprintf("  ds   0x----%04x\n", tf->tf_ds);
  101b98:	8b 45 08             	mov    0x8(%ebp),%eax
  101b9b:	0f b7 40 2c          	movzwl 0x2c(%eax),%eax
  101b9f:	0f b7 c0             	movzwl %ax,%eax
  101ba2:	83 ec 08             	sub    $0x8,%esp
  101ba5:	50                   	push   %eax
  101ba6:	68 cf 60 10 00       	push   $0x1060cf
  101bab:	e8 df e6 ff ff       	call   10028f <cprintf>
  101bb0:	83 c4 10             	add    $0x10,%esp
    cprintf("  es   0x----%04x\n", tf->tf_es);
  101bb3:	8b 45 08             	mov    0x8(%ebp),%eax
  101bb6:	0f b7 40 28          	movzwl 0x28(%eax),%eax
  101bba:	0f b7 c0             	movzwl %ax,%eax
  101bbd:	83 ec 08             	sub    $0x8,%esp
  101bc0:	50                   	push   %eax
  101bc1:	68 e2 60 10 00       	push   $0x1060e2
  101bc6:	e8 c4 e6 ff ff       	call   10028f <cprintf>
  101bcb:	83 c4 10             	add    $0x10,%esp
    cprintf("  fs   0x----%04x\n", tf->tf_fs);
  101bce:	8b 45 08             	mov    0x8(%ebp),%eax
  101bd1:	0f b7 40 24          	movzwl 0x24(%eax),%eax
  101bd5:	0f b7 c0             	movzwl %ax,%eax
  101bd8:	83 ec 08             	sub    $0x8,%esp
  101bdb:	50                   	push   %eax
  101bdc:	68 f5 60 10 00       	push   $0x1060f5
  101be1:	e8 a9 e6 ff ff       	call   10028f <cprintf>
  101be6:	83 c4 10             	add    $0x10,%esp
    cprintf("  gs   0x----%04x\n", tf->tf_gs);
  101be9:	8b 45 08             	mov    0x8(%ebp),%eax
  101bec:	0f b7 40 20          	movzwl 0x20(%eax),%eax
  101bf0:	0f b7 c0             	movzwl %ax,%eax
  101bf3:	83 ec 08             	sub    $0x8,%esp
  101bf6:	50                   	push   %eax
  101bf7:	68 08 61 10 00       	push   $0x106108
  101bfc:	e8 8e e6 ff ff       	call   10028f <cprintf>
  101c01:	83 c4 10             	add    $0x10,%esp
    cprintf("  trap 0x%08x %s\n", tf->tf_trapno, trapname(tf->tf_trapno));
  101c04:	8b 45 08             	mov    0x8(%ebp),%eax
  101c07:	8b 40 30             	mov    0x30(%eax),%eax
  101c0a:	83 ec 0c             	sub    $0xc,%esp
  101c0d:	50                   	push   %eax
  101c0e:	e8 0a ff ff ff       	call   101b1d <trapname>
  101c13:	83 c4 10             	add    $0x10,%esp
  101c16:	8b 55 08             	mov    0x8(%ebp),%edx
  101c19:	8b 52 30             	mov    0x30(%edx),%edx
  101c1c:	83 ec 04             	sub    $0x4,%esp
  101c1f:	50                   	push   %eax
  101c20:	52                   	push   %edx
  101c21:	68 1b 61 10 00       	push   $0x10611b
  101c26:	e8 64 e6 ff ff       	call   10028f <cprintf>
  101c2b:	83 c4 10             	add    $0x10,%esp
    cprintf("  err  0x%08x\n", tf->tf_err);
  101c2e:	8b 45 08             	mov    0x8(%ebp),%eax
  101c31:	8b 40 34             	mov    0x34(%eax),%eax
  101c34:	83 ec 08             	sub    $0x8,%esp
  101c37:	50                   	push   %eax
  101c38:	68 2d 61 10 00       	push   $0x10612d
  101c3d:	e8 4d e6 ff ff       	call   10028f <cprintf>
  101c42:	83 c4 10             	add    $0x10,%esp
    cprintf("  eip  0x%08x\n", tf->tf_eip);
  101c45:	8b 45 08             	mov    0x8(%ebp),%eax
  101c48:	8b 40 38             	mov    0x38(%eax),%eax
  101c4b:	83 ec 08             	sub    $0x8,%esp
  101c4e:	50                   	push   %eax
  101c4f:	68 3c 61 10 00       	push   $0x10613c
  101c54:	e8 36 e6 ff ff       	call   10028f <cprintf>
  101c59:	83 c4 10             	add    $0x10,%esp
    cprintf("  cs   0x----%04x\n", tf->tf_cs);
  101c5c:	8b 45 08             	mov    0x8(%ebp),%eax
  101c5f:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101c63:	0f b7 c0             	movzwl %ax,%eax
  101c66:	83 ec 08             	sub    $0x8,%esp
  101c69:	50                   	push   %eax
  101c6a:	68 4b 61 10 00       	push   $0x10614b
  101c6f:	e8 1b e6 ff ff       	call   10028f <cprintf>
  101c74:	83 c4 10             	add    $0x10,%esp
    cprintf("  flag 0x%08x ", tf->tf_eflags);
  101c77:	8b 45 08             	mov    0x8(%ebp),%eax
  101c7a:	8b 40 40             	mov    0x40(%eax),%eax
  101c7d:	83 ec 08             	sub    $0x8,%esp
  101c80:	50                   	push   %eax
  101c81:	68 5e 61 10 00       	push   $0x10615e
  101c86:	e8 04 e6 ff ff       	call   10028f <cprintf>
  101c8b:	83 c4 10             	add    $0x10,%esp

    int i, j;
    for (i = 0, j = 1; i < sizeof(IA32flags) / sizeof(IA32flags[0]); i ++, j <<= 1) {
  101c8e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  101c95:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
  101c9c:	eb 3f                	jmp    101cdd <print_trapframe+0x171>
        if ((tf->tf_eflags & j) && IA32flags[i] != NULL) {
  101c9e:	8b 45 08             	mov    0x8(%ebp),%eax
  101ca1:	8b 50 40             	mov    0x40(%eax),%edx
  101ca4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  101ca7:	21 d0                	and    %edx,%eax
  101ca9:	85 c0                	test   %eax,%eax
  101cab:	74 29                	je     101cd6 <print_trapframe+0x16a>
  101cad:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101cb0:	8b 04 85 a0 95 11 00 	mov    0x1195a0(,%eax,4),%eax
  101cb7:	85 c0                	test   %eax,%eax
  101cb9:	74 1b                	je     101cd6 <print_trapframe+0x16a>
            cprintf("%s,", IA32flags[i]);
  101cbb:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101cbe:	8b 04 85 a0 95 11 00 	mov    0x1195a0(,%eax,4),%eax
  101cc5:	83 ec 08             	sub    $0x8,%esp
  101cc8:	50                   	push   %eax
  101cc9:	68 6d 61 10 00       	push   $0x10616d
  101cce:	e8 bc e5 ff ff       	call   10028f <cprintf>
  101cd3:	83 c4 10             	add    $0x10,%esp
    for (i = 0, j = 1; i < sizeof(IA32flags) / sizeof(IA32flags[0]); i ++, j <<= 1) {
  101cd6:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  101cda:	d1 65 f0             	shll   -0x10(%ebp)
  101cdd:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101ce0:	83 f8 17             	cmp    $0x17,%eax
  101ce3:	76 b9                	jbe    101c9e <print_trapframe+0x132>
        }
    }
    cprintf("IOPL=%d\n", (tf->tf_eflags & FL_IOPL_MASK) >> 12);
  101ce5:	8b 45 08             	mov    0x8(%ebp),%eax
  101ce8:	8b 40 40             	mov    0x40(%eax),%eax
  101ceb:	c1 e8 0c             	shr    $0xc,%eax
  101cee:	83 e0 03             	and    $0x3,%eax
  101cf1:	83 ec 08             	sub    $0x8,%esp
  101cf4:	50                   	push   %eax
  101cf5:	68 71 61 10 00       	push   $0x106171
  101cfa:	e8 90 e5 ff ff       	call   10028f <cprintf>
  101cff:	83 c4 10             	add    $0x10,%esp

    if (!trap_in_kernel(tf)) {
  101d02:	83 ec 0c             	sub    $0xc,%esp
  101d05:	ff 75 08             	pushl  0x8(%ebp)
  101d08:	e8 45 fe ff ff       	call   101b52 <trap_in_kernel>
  101d0d:	83 c4 10             	add    $0x10,%esp
  101d10:	85 c0                	test   %eax,%eax
  101d12:	75 32                	jne    101d46 <print_trapframe+0x1da>
        cprintf("  esp  0x%08x\n", tf->tf_esp);
  101d14:	8b 45 08             	mov    0x8(%ebp),%eax
  101d17:	8b 40 44             	mov    0x44(%eax),%eax
  101d1a:	83 ec 08             	sub    $0x8,%esp
  101d1d:	50                   	push   %eax
  101d1e:	68 7a 61 10 00       	push   $0x10617a
  101d23:	e8 67 e5 ff ff       	call   10028f <cprintf>
  101d28:	83 c4 10             	add    $0x10,%esp
        cprintf("  ss   0x----%04x\n", tf->tf_ss);
  101d2b:	8b 45 08             	mov    0x8(%ebp),%eax
  101d2e:	0f b7 40 48          	movzwl 0x48(%eax),%eax
  101d32:	0f b7 c0             	movzwl %ax,%eax
  101d35:	83 ec 08             	sub    $0x8,%esp
  101d38:	50                   	push   %eax
  101d39:	68 89 61 10 00       	push   $0x106189
  101d3e:	e8 4c e5 ff ff       	call   10028f <cprintf>
  101d43:	83 c4 10             	add    $0x10,%esp
    }
}
  101d46:	90                   	nop
  101d47:	c9                   	leave  
  101d48:	c3                   	ret    

00101d49 <print_regs>:

void
print_regs(struct pushregs *regs) {
  101d49:	f3 0f 1e fb          	endbr32 
  101d4d:	55                   	push   %ebp
  101d4e:	89 e5                	mov    %esp,%ebp
  101d50:	83 ec 08             	sub    $0x8,%esp
    cprintf("  edi  0x%08x\n", regs->reg_edi);
  101d53:	8b 45 08             	mov    0x8(%ebp),%eax
  101d56:	8b 00                	mov    (%eax),%eax
  101d58:	83 ec 08             	sub    $0x8,%esp
  101d5b:	50                   	push   %eax
  101d5c:	68 9c 61 10 00       	push   $0x10619c
  101d61:	e8 29 e5 ff ff       	call   10028f <cprintf>
  101d66:	83 c4 10             	add    $0x10,%esp
    cprintf("  esi  0x%08x\n", regs->reg_esi);
  101d69:	8b 45 08             	mov    0x8(%ebp),%eax
  101d6c:	8b 40 04             	mov    0x4(%eax),%eax
  101d6f:	83 ec 08             	sub    $0x8,%esp
  101d72:	50                   	push   %eax
  101d73:	68 ab 61 10 00       	push   $0x1061ab
  101d78:	e8 12 e5 ff ff       	call   10028f <cprintf>
  101d7d:	83 c4 10             	add    $0x10,%esp
    cprintf("  ebp  0x%08x\n", regs->reg_ebp);
  101d80:	8b 45 08             	mov    0x8(%ebp),%eax
  101d83:	8b 40 08             	mov    0x8(%eax),%eax
  101d86:	83 ec 08             	sub    $0x8,%esp
  101d89:	50                   	push   %eax
  101d8a:	68 ba 61 10 00       	push   $0x1061ba
  101d8f:	e8 fb e4 ff ff       	call   10028f <cprintf>
  101d94:	83 c4 10             	add    $0x10,%esp
    cprintf("  oesp 0x%08x\n", regs->reg_oesp);
  101d97:	8b 45 08             	mov    0x8(%ebp),%eax
  101d9a:	8b 40 0c             	mov    0xc(%eax),%eax
  101d9d:	83 ec 08             	sub    $0x8,%esp
  101da0:	50                   	push   %eax
  101da1:	68 c9 61 10 00       	push   $0x1061c9
  101da6:	e8 e4 e4 ff ff       	call   10028f <cprintf>
  101dab:	83 c4 10             	add    $0x10,%esp
    cprintf("  ebx  0x%08x\n", regs->reg_ebx);
  101dae:	8b 45 08             	mov    0x8(%ebp),%eax
  101db1:	8b 40 10             	mov    0x10(%eax),%eax
  101db4:	83 ec 08             	sub    $0x8,%esp
  101db7:	50                   	push   %eax
  101db8:	68 d8 61 10 00       	push   $0x1061d8
  101dbd:	e8 cd e4 ff ff       	call   10028f <cprintf>
  101dc2:	83 c4 10             	add    $0x10,%esp
    cprintf("  edx  0x%08x\n", regs->reg_edx);
  101dc5:	8b 45 08             	mov    0x8(%ebp),%eax
  101dc8:	8b 40 14             	mov    0x14(%eax),%eax
  101dcb:	83 ec 08             	sub    $0x8,%esp
  101dce:	50                   	push   %eax
  101dcf:	68 e7 61 10 00       	push   $0x1061e7
  101dd4:	e8 b6 e4 ff ff       	call   10028f <cprintf>
  101dd9:	83 c4 10             	add    $0x10,%esp
    cprintf("  ecx  0x%08x\n", regs->reg_ecx);
  101ddc:	8b 45 08             	mov    0x8(%ebp),%eax
  101ddf:	8b 40 18             	mov    0x18(%eax),%eax
  101de2:	83 ec 08             	sub    $0x8,%esp
  101de5:	50                   	push   %eax
  101de6:	68 f6 61 10 00       	push   $0x1061f6
  101deb:	e8 9f e4 ff ff       	call   10028f <cprintf>
  101df0:	83 c4 10             	add    $0x10,%esp
    cprintf("  eax  0x%08x\n", regs->reg_eax);
  101df3:	8b 45 08             	mov    0x8(%ebp),%eax
  101df6:	8b 40 1c             	mov    0x1c(%eax),%eax
  101df9:	83 ec 08             	sub    $0x8,%esp
  101dfc:	50                   	push   %eax
  101dfd:	68 05 62 10 00       	push   $0x106205
  101e02:	e8 88 e4 ff ff       	call   10028f <cprintf>
  101e07:	83 c4 10             	add    $0x10,%esp
}
  101e0a:	90                   	nop
  101e0b:	c9                   	leave  
  101e0c:	c3                   	ret    

00101e0d <trap_dispatch>:

/* trap_dispatch - dispatch based on what type of trap occurred */
static void
trap_dispatch(struct trapframe *tf) {
  101e0d:	f3 0f 1e fb          	endbr32 
  101e11:	55                   	push   %ebp
  101e12:	89 e5                	mov    %esp,%ebp
  101e14:	83 ec 18             	sub    $0x18,%esp
    char c;

    switch (tf->tf_trapno) {
  101e17:	8b 45 08             	mov    0x8(%ebp),%eax
  101e1a:	8b 40 30             	mov    0x30(%eax),%eax
  101e1d:	83 f8 79             	cmp    $0x79,%eax
  101e20:	0f 87 d1 00 00 00    	ja     101ef7 <trap_dispatch+0xea>
  101e26:	83 f8 78             	cmp    $0x78,%eax
  101e29:	0f 83 b1 00 00 00    	jae    101ee0 <trap_dispatch+0xd3>
  101e2f:	83 f8 2f             	cmp    $0x2f,%eax
  101e32:	0f 87 bf 00 00 00    	ja     101ef7 <trap_dispatch+0xea>
  101e38:	83 f8 2e             	cmp    $0x2e,%eax
  101e3b:	0f 83 ec 00 00 00    	jae    101f2d <trap_dispatch+0x120>
  101e41:	83 f8 24             	cmp    $0x24,%eax
  101e44:	74 52                	je     101e98 <trap_dispatch+0x8b>
  101e46:	83 f8 24             	cmp    $0x24,%eax
  101e49:	0f 87 a8 00 00 00    	ja     101ef7 <trap_dispatch+0xea>
  101e4f:	83 f8 20             	cmp    $0x20,%eax
  101e52:	74 0a                	je     101e5e <trap_dispatch+0x51>
  101e54:	83 f8 21             	cmp    $0x21,%eax
  101e57:	74 63                	je     101ebc <trap_dispatch+0xaf>
  101e59:	e9 99 00 00 00       	jmp    101ef7 <trap_dispatch+0xea>
        /* handle the timer interrupt */
        /* (1) After a timer interrupt, you should record this event using a global variable (increase it), such as ticks in kern/driver/clock.c
         * (2) Every TICK_NUM cycle, you can print some info using a funciton, such as print_ticks().
         * (3) Too Simple? Yes, I think so!
         */
         ticks++;
  101e5e:	a1 4c a9 11 00       	mov    0x11a94c,%eax
  101e63:	83 c0 01             	add    $0x1,%eax
  101e66:	a3 4c a9 11 00       	mov    %eax,0x11a94c
	if(ticks%TICK_NUM==0){
  101e6b:	8b 0d 4c a9 11 00    	mov    0x11a94c,%ecx
  101e71:	ba 1f 85 eb 51       	mov    $0x51eb851f,%edx
  101e76:	89 c8                	mov    %ecx,%eax
  101e78:	f7 e2                	mul    %edx
  101e7a:	89 d0                	mov    %edx,%eax
  101e7c:	c1 e8 05             	shr    $0x5,%eax
  101e7f:	6b c0 64             	imul   $0x64,%eax,%eax
  101e82:	29 c1                	sub    %eax,%ecx
  101e84:	89 c8                	mov    %ecx,%eax
  101e86:	85 c0                	test   %eax,%eax
  101e88:	0f 85 a2 00 00 00    	jne    101f30 <trap_dispatch+0x123>
		print_ticks();
  101e8e:	e8 f4 fa ff ff       	call   101987 <print_ticks>
	}
        break;
  101e93:	e9 98 00 00 00       	jmp    101f30 <trap_dispatch+0x123>
    case IRQ_OFFSET + IRQ_COM1:
        c = cons_getc();
  101e98:	e8 7d f8 ff ff       	call   10171a <cons_getc>
  101e9d:	88 45 f7             	mov    %al,-0x9(%ebp)
        cprintf("serial [%03d] %c\n", c, c);
  101ea0:	0f be 55 f7          	movsbl -0x9(%ebp),%edx
  101ea4:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  101ea8:	83 ec 04             	sub    $0x4,%esp
  101eab:	52                   	push   %edx
  101eac:	50                   	push   %eax
  101ead:	68 14 62 10 00       	push   $0x106214
  101eb2:	e8 d8 e3 ff ff       	call   10028f <cprintf>
  101eb7:	83 c4 10             	add    $0x10,%esp
        break;
  101eba:	eb 75                	jmp    101f31 <trap_dispatch+0x124>
    case IRQ_OFFSET + IRQ_KBD:
        c = cons_getc();
  101ebc:	e8 59 f8 ff ff       	call   10171a <cons_getc>
  101ec1:	88 45 f7             	mov    %al,-0x9(%ebp)
        cprintf("kbd [%03d] %c\n", c, c);
  101ec4:	0f be 55 f7          	movsbl -0x9(%ebp),%edx
  101ec8:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  101ecc:	83 ec 04             	sub    $0x4,%esp
  101ecf:	52                   	push   %edx
  101ed0:	50                   	push   %eax
  101ed1:	68 26 62 10 00       	push   $0x106226
  101ed6:	e8 b4 e3 ff ff       	call   10028f <cprintf>
  101edb:	83 c4 10             	add    $0x10,%esp
        break;
  101ede:	eb 51                	jmp    101f31 <trap_dispatch+0x124>
    //LAB1 CHALLENGE 1 : YOUR CODE you should modify below codes.
    case T_SWITCH_TOU:
    case T_SWITCH_TOK:
        panic("T_SWITCH_** ??\n");
  101ee0:	83 ec 04             	sub    $0x4,%esp
  101ee3:	68 35 62 10 00       	push   $0x106235
  101ee8:	68 ad 00 00 00       	push   $0xad
  101eed:	68 45 62 10 00       	push   $0x106245
  101ef2:	e8 13 e5 ff ff       	call   10040a <__panic>
    case IRQ_OFFSET + IRQ_IDE2:
        /* do nothing */
        break;
    default:
        // in kernel, it must be a mistake
        if ((tf->tf_cs & 3) == 0) {
  101ef7:	8b 45 08             	mov    0x8(%ebp),%eax
  101efa:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101efe:	0f b7 c0             	movzwl %ax,%eax
  101f01:	83 e0 03             	and    $0x3,%eax
  101f04:	85 c0                	test   %eax,%eax
  101f06:	75 29                	jne    101f31 <trap_dispatch+0x124>
            print_trapframe(tf);
  101f08:	83 ec 0c             	sub    $0xc,%esp
  101f0b:	ff 75 08             	pushl  0x8(%ebp)
  101f0e:	e8 59 fc ff ff       	call   101b6c <print_trapframe>
  101f13:	83 c4 10             	add    $0x10,%esp
            panic("unexpected trap in kernel.\n");
  101f16:	83 ec 04             	sub    $0x4,%esp
  101f19:	68 56 62 10 00       	push   $0x106256
  101f1e:	68 b7 00 00 00       	push   $0xb7
  101f23:	68 45 62 10 00       	push   $0x106245
  101f28:	e8 dd e4 ff ff       	call   10040a <__panic>
        break;
  101f2d:	90                   	nop
  101f2e:	eb 01                	jmp    101f31 <trap_dispatch+0x124>
        break;
  101f30:	90                   	nop
        }
    }
}
  101f31:	90                   	nop
  101f32:	c9                   	leave  
  101f33:	c3                   	ret    

00101f34 <trap>:
 * trap - handles or dispatches an exception/interrupt. if and when trap() returns,
 * the code in kern/trap/trapentry.S restores the old CPU state saved in the
 * trapframe and then uses the iret instruction to return from the exception.
 * */
void
trap(struct trapframe *tf) {
  101f34:	f3 0f 1e fb          	endbr32 
  101f38:	55                   	push   %ebp
  101f39:	89 e5                	mov    %esp,%ebp
  101f3b:	83 ec 08             	sub    $0x8,%esp
    // dispatch based on what type of trap occurred
    trap_dispatch(tf);
  101f3e:	83 ec 0c             	sub    $0xc,%esp
  101f41:	ff 75 08             	pushl  0x8(%ebp)
  101f44:	e8 c4 fe ff ff       	call   101e0d <trap_dispatch>
  101f49:	83 c4 10             	add    $0x10,%esp
}
  101f4c:	90                   	nop
  101f4d:	c9                   	leave  
  101f4e:	c3                   	ret    

00101f4f <vector0>:
# handler
.text
.globl __alltraps
.globl vector0
vector0:
  pushl $0
  101f4f:	6a 00                	push   $0x0
  pushl $0
  101f51:	6a 00                	push   $0x0
  jmp __alltraps
  101f53:	e9 67 0a 00 00       	jmp    1029bf <__alltraps>

00101f58 <vector1>:
.globl vector1
vector1:
  pushl $0
  101f58:	6a 00                	push   $0x0
  pushl $1
  101f5a:	6a 01                	push   $0x1
  jmp __alltraps
  101f5c:	e9 5e 0a 00 00       	jmp    1029bf <__alltraps>

00101f61 <vector2>:
.globl vector2
vector2:
  pushl $0
  101f61:	6a 00                	push   $0x0
  pushl $2
  101f63:	6a 02                	push   $0x2
  jmp __alltraps
  101f65:	e9 55 0a 00 00       	jmp    1029bf <__alltraps>

00101f6a <vector3>:
.globl vector3
vector3:
  pushl $0
  101f6a:	6a 00                	push   $0x0
  pushl $3
  101f6c:	6a 03                	push   $0x3
  jmp __alltraps
  101f6e:	e9 4c 0a 00 00       	jmp    1029bf <__alltraps>

00101f73 <vector4>:
.globl vector4
vector4:
  pushl $0
  101f73:	6a 00                	push   $0x0
  pushl $4
  101f75:	6a 04                	push   $0x4
  jmp __alltraps
  101f77:	e9 43 0a 00 00       	jmp    1029bf <__alltraps>

00101f7c <vector5>:
.globl vector5
vector5:
  pushl $0
  101f7c:	6a 00                	push   $0x0
  pushl $5
  101f7e:	6a 05                	push   $0x5
  jmp __alltraps
  101f80:	e9 3a 0a 00 00       	jmp    1029bf <__alltraps>

00101f85 <vector6>:
.globl vector6
vector6:
  pushl $0
  101f85:	6a 00                	push   $0x0
  pushl $6
  101f87:	6a 06                	push   $0x6
  jmp __alltraps
  101f89:	e9 31 0a 00 00       	jmp    1029bf <__alltraps>

00101f8e <vector7>:
.globl vector7
vector7:
  pushl $0
  101f8e:	6a 00                	push   $0x0
  pushl $7
  101f90:	6a 07                	push   $0x7
  jmp __alltraps
  101f92:	e9 28 0a 00 00       	jmp    1029bf <__alltraps>

00101f97 <vector8>:
.globl vector8
vector8:
  pushl $8
  101f97:	6a 08                	push   $0x8
  jmp __alltraps
  101f99:	e9 21 0a 00 00       	jmp    1029bf <__alltraps>

00101f9e <vector9>:
.globl vector9
vector9:
  pushl $9
  101f9e:	6a 09                	push   $0x9
  jmp __alltraps
  101fa0:	e9 1a 0a 00 00       	jmp    1029bf <__alltraps>

00101fa5 <vector10>:
.globl vector10
vector10:
  pushl $10
  101fa5:	6a 0a                	push   $0xa
  jmp __alltraps
  101fa7:	e9 13 0a 00 00       	jmp    1029bf <__alltraps>

00101fac <vector11>:
.globl vector11
vector11:
  pushl $11
  101fac:	6a 0b                	push   $0xb
  jmp __alltraps
  101fae:	e9 0c 0a 00 00       	jmp    1029bf <__alltraps>

00101fb3 <vector12>:
.globl vector12
vector12:
  pushl $12
  101fb3:	6a 0c                	push   $0xc
  jmp __alltraps
  101fb5:	e9 05 0a 00 00       	jmp    1029bf <__alltraps>

00101fba <vector13>:
.globl vector13
vector13:
  pushl $13
  101fba:	6a 0d                	push   $0xd
  jmp __alltraps
  101fbc:	e9 fe 09 00 00       	jmp    1029bf <__alltraps>

00101fc1 <vector14>:
.globl vector14
vector14:
  pushl $14
  101fc1:	6a 0e                	push   $0xe
  jmp __alltraps
  101fc3:	e9 f7 09 00 00       	jmp    1029bf <__alltraps>

00101fc8 <vector15>:
.globl vector15
vector15:
  pushl $0
  101fc8:	6a 00                	push   $0x0
  pushl $15
  101fca:	6a 0f                	push   $0xf
  jmp __alltraps
  101fcc:	e9 ee 09 00 00       	jmp    1029bf <__alltraps>

00101fd1 <vector16>:
.globl vector16
vector16:
  pushl $0
  101fd1:	6a 00                	push   $0x0
  pushl $16
  101fd3:	6a 10                	push   $0x10
  jmp __alltraps
  101fd5:	e9 e5 09 00 00       	jmp    1029bf <__alltraps>

00101fda <vector17>:
.globl vector17
vector17:
  pushl $17
  101fda:	6a 11                	push   $0x11
  jmp __alltraps
  101fdc:	e9 de 09 00 00       	jmp    1029bf <__alltraps>

00101fe1 <vector18>:
.globl vector18
vector18:
  pushl $0
  101fe1:	6a 00                	push   $0x0
  pushl $18
  101fe3:	6a 12                	push   $0x12
  jmp __alltraps
  101fe5:	e9 d5 09 00 00       	jmp    1029bf <__alltraps>

00101fea <vector19>:
.globl vector19
vector19:
  pushl $0
  101fea:	6a 00                	push   $0x0
  pushl $19
  101fec:	6a 13                	push   $0x13
  jmp __alltraps
  101fee:	e9 cc 09 00 00       	jmp    1029bf <__alltraps>

00101ff3 <vector20>:
.globl vector20
vector20:
  pushl $0
  101ff3:	6a 00                	push   $0x0
  pushl $20
  101ff5:	6a 14                	push   $0x14
  jmp __alltraps
  101ff7:	e9 c3 09 00 00       	jmp    1029bf <__alltraps>

00101ffc <vector21>:
.globl vector21
vector21:
  pushl $0
  101ffc:	6a 00                	push   $0x0
  pushl $21
  101ffe:	6a 15                	push   $0x15
  jmp __alltraps
  102000:	e9 ba 09 00 00       	jmp    1029bf <__alltraps>

00102005 <vector22>:
.globl vector22
vector22:
  pushl $0
  102005:	6a 00                	push   $0x0
  pushl $22
  102007:	6a 16                	push   $0x16
  jmp __alltraps
  102009:	e9 b1 09 00 00       	jmp    1029bf <__alltraps>

0010200e <vector23>:
.globl vector23
vector23:
  pushl $0
  10200e:	6a 00                	push   $0x0
  pushl $23
  102010:	6a 17                	push   $0x17
  jmp __alltraps
  102012:	e9 a8 09 00 00       	jmp    1029bf <__alltraps>

00102017 <vector24>:
.globl vector24
vector24:
  pushl $0
  102017:	6a 00                	push   $0x0
  pushl $24
  102019:	6a 18                	push   $0x18
  jmp __alltraps
  10201b:	e9 9f 09 00 00       	jmp    1029bf <__alltraps>

00102020 <vector25>:
.globl vector25
vector25:
  pushl $0
  102020:	6a 00                	push   $0x0
  pushl $25
  102022:	6a 19                	push   $0x19
  jmp __alltraps
  102024:	e9 96 09 00 00       	jmp    1029bf <__alltraps>

00102029 <vector26>:
.globl vector26
vector26:
  pushl $0
  102029:	6a 00                	push   $0x0
  pushl $26
  10202b:	6a 1a                	push   $0x1a
  jmp __alltraps
  10202d:	e9 8d 09 00 00       	jmp    1029bf <__alltraps>

00102032 <vector27>:
.globl vector27
vector27:
  pushl $0
  102032:	6a 00                	push   $0x0
  pushl $27
  102034:	6a 1b                	push   $0x1b
  jmp __alltraps
  102036:	e9 84 09 00 00       	jmp    1029bf <__alltraps>

0010203b <vector28>:
.globl vector28
vector28:
  pushl $0
  10203b:	6a 00                	push   $0x0
  pushl $28
  10203d:	6a 1c                	push   $0x1c
  jmp __alltraps
  10203f:	e9 7b 09 00 00       	jmp    1029bf <__alltraps>

00102044 <vector29>:
.globl vector29
vector29:
  pushl $0
  102044:	6a 00                	push   $0x0
  pushl $29
  102046:	6a 1d                	push   $0x1d
  jmp __alltraps
  102048:	e9 72 09 00 00       	jmp    1029bf <__alltraps>

0010204d <vector30>:
.globl vector30
vector30:
  pushl $0
  10204d:	6a 00                	push   $0x0
  pushl $30
  10204f:	6a 1e                	push   $0x1e
  jmp __alltraps
  102051:	e9 69 09 00 00       	jmp    1029bf <__alltraps>

00102056 <vector31>:
.globl vector31
vector31:
  pushl $0
  102056:	6a 00                	push   $0x0
  pushl $31
  102058:	6a 1f                	push   $0x1f
  jmp __alltraps
  10205a:	e9 60 09 00 00       	jmp    1029bf <__alltraps>

0010205f <vector32>:
.globl vector32
vector32:
  pushl $0
  10205f:	6a 00                	push   $0x0
  pushl $32
  102061:	6a 20                	push   $0x20
  jmp __alltraps
  102063:	e9 57 09 00 00       	jmp    1029bf <__alltraps>

00102068 <vector33>:
.globl vector33
vector33:
  pushl $0
  102068:	6a 00                	push   $0x0
  pushl $33
  10206a:	6a 21                	push   $0x21
  jmp __alltraps
  10206c:	e9 4e 09 00 00       	jmp    1029bf <__alltraps>

00102071 <vector34>:
.globl vector34
vector34:
  pushl $0
  102071:	6a 00                	push   $0x0
  pushl $34
  102073:	6a 22                	push   $0x22
  jmp __alltraps
  102075:	e9 45 09 00 00       	jmp    1029bf <__alltraps>

0010207a <vector35>:
.globl vector35
vector35:
  pushl $0
  10207a:	6a 00                	push   $0x0
  pushl $35
  10207c:	6a 23                	push   $0x23
  jmp __alltraps
  10207e:	e9 3c 09 00 00       	jmp    1029bf <__alltraps>

00102083 <vector36>:
.globl vector36
vector36:
  pushl $0
  102083:	6a 00                	push   $0x0
  pushl $36
  102085:	6a 24                	push   $0x24
  jmp __alltraps
  102087:	e9 33 09 00 00       	jmp    1029bf <__alltraps>

0010208c <vector37>:
.globl vector37
vector37:
  pushl $0
  10208c:	6a 00                	push   $0x0
  pushl $37
  10208e:	6a 25                	push   $0x25
  jmp __alltraps
  102090:	e9 2a 09 00 00       	jmp    1029bf <__alltraps>

00102095 <vector38>:
.globl vector38
vector38:
  pushl $0
  102095:	6a 00                	push   $0x0
  pushl $38
  102097:	6a 26                	push   $0x26
  jmp __alltraps
  102099:	e9 21 09 00 00       	jmp    1029bf <__alltraps>

0010209e <vector39>:
.globl vector39
vector39:
  pushl $0
  10209e:	6a 00                	push   $0x0
  pushl $39
  1020a0:	6a 27                	push   $0x27
  jmp __alltraps
  1020a2:	e9 18 09 00 00       	jmp    1029bf <__alltraps>

001020a7 <vector40>:
.globl vector40
vector40:
  pushl $0
  1020a7:	6a 00                	push   $0x0
  pushl $40
  1020a9:	6a 28                	push   $0x28
  jmp __alltraps
  1020ab:	e9 0f 09 00 00       	jmp    1029bf <__alltraps>

001020b0 <vector41>:
.globl vector41
vector41:
  pushl $0
  1020b0:	6a 00                	push   $0x0
  pushl $41
  1020b2:	6a 29                	push   $0x29
  jmp __alltraps
  1020b4:	e9 06 09 00 00       	jmp    1029bf <__alltraps>

001020b9 <vector42>:
.globl vector42
vector42:
  pushl $0
  1020b9:	6a 00                	push   $0x0
  pushl $42
  1020bb:	6a 2a                	push   $0x2a
  jmp __alltraps
  1020bd:	e9 fd 08 00 00       	jmp    1029bf <__alltraps>

001020c2 <vector43>:
.globl vector43
vector43:
  pushl $0
  1020c2:	6a 00                	push   $0x0
  pushl $43
  1020c4:	6a 2b                	push   $0x2b
  jmp __alltraps
  1020c6:	e9 f4 08 00 00       	jmp    1029bf <__alltraps>

001020cb <vector44>:
.globl vector44
vector44:
  pushl $0
  1020cb:	6a 00                	push   $0x0
  pushl $44
  1020cd:	6a 2c                	push   $0x2c
  jmp __alltraps
  1020cf:	e9 eb 08 00 00       	jmp    1029bf <__alltraps>

001020d4 <vector45>:
.globl vector45
vector45:
  pushl $0
  1020d4:	6a 00                	push   $0x0
  pushl $45
  1020d6:	6a 2d                	push   $0x2d
  jmp __alltraps
  1020d8:	e9 e2 08 00 00       	jmp    1029bf <__alltraps>

001020dd <vector46>:
.globl vector46
vector46:
  pushl $0
  1020dd:	6a 00                	push   $0x0
  pushl $46
  1020df:	6a 2e                	push   $0x2e
  jmp __alltraps
  1020e1:	e9 d9 08 00 00       	jmp    1029bf <__alltraps>

001020e6 <vector47>:
.globl vector47
vector47:
  pushl $0
  1020e6:	6a 00                	push   $0x0
  pushl $47
  1020e8:	6a 2f                	push   $0x2f
  jmp __alltraps
  1020ea:	e9 d0 08 00 00       	jmp    1029bf <__alltraps>

001020ef <vector48>:
.globl vector48
vector48:
  pushl $0
  1020ef:	6a 00                	push   $0x0
  pushl $48
  1020f1:	6a 30                	push   $0x30
  jmp __alltraps
  1020f3:	e9 c7 08 00 00       	jmp    1029bf <__alltraps>

001020f8 <vector49>:
.globl vector49
vector49:
  pushl $0
  1020f8:	6a 00                	push   $0x0
  pushl $49
  1020fa:	6a 31                	push   $0x31
  jmp __alltraps
  1020fc:	e9 be 08 00 00       	jmp    1029bf <__alltraps>

00102101 <vector50>:
.globl vector50
vector50:
  pushl $0
  102101:	6a 00                	push   $0x0
  pushl $50
  102103:	6a 32                	push   $0x32
  jmp __alltraps
  102105:	e9 b5 08 00 00       	jmp    1029bf <__alltraps>

0010210a <vector51>:
.globl vector51
vector51:
  pushl $0
  10210a:	6a 00                	push   $0x0
  pushl $51
  10210c:	6a 33                	push   $0x33
  jmp __alltraps
  10210e:	e9 ac 08 00 00       	jmp    1029bf <__alltraps>

00102113 <vector52>:
.globl vector52
vector52:
  pushl $0
  102113:	6a 00                	push   $0x0
  pushl $52
  102115:	6a 34                	push   $0x34
  jmp __alltraps
  102117:	e9 a3 08 00 00       	jmp    1029bf <__alltraps>

0010211c <vector53>:
.globl vector53
vector53:
  pushl $0
  10211c:	6a 00                	push   $0x0
  pushl $53
  10211e:	6a 35                	push   $0x35
  jmp __alltraps
  102120:	e9 9a 08 00 00       	jmp    1029bf <__alltraps>

00102125 <vector54>:
.globl vector54
vector54:
  pushl $0
  102125:	6a 00                	push   $0x0
  pushl $54
  102127:	6a 36                	push   $0x36
  jmp __alltraps
  102129:	e9 91 08 00 00       	jmp    1029bf <__alltraps>

0010212e <vector55>:
.globl vector55
vector55:
  pushl $0
  10212e:	6a 00                	push   $0x0
  pushl $55
  102130:	6a 37                	push   $0x37
  jmp __alltraps
  102132:	e9 88 08 00 00       	jmp    1029bf <__alltraps>

00102137 <vector56>:
.globl vector56
vector56:
  pushl $0
  102137:	6a 00                	push   $0x0
  pushl $56
  102139:	6a 38                	push   $0x38
  jmp __alltraps
  10213b:	e9 7f 08 00 00       	jmp    1029bf <__alltraps>

00102140 <vector57>:
.globl vector57
vector57:
  pushl $0
  102140:	6a 00                	push   $0x0
  pushl $57
  102142:	6a 39                	push   $0x39
  jmp __alltraps
  102144:	e9 76 08 00 00       	jmp    1029bf <__alltraps>

00102149 <vector58>:
.globl vector58
vector58:
  pushl $0
  102149:	6a 00                	push   $0x0
  pushl $58
  10214b:	6a 3a                	push   $0x3a
  jmp __alltraps
  10214d:	e9 6d 08 00 00       	jmp    1029bf <__alltraps>

00102152 <vector59>:
.globl vector59
vector59:
  pushl $0
  102152:	6a 00                	push   $0x0
  pushl $59
  102154:	6a 3b                	push   $0x3b
  jmp __alltraps
  102156:	e9 64 08 00 00       	jmp    1029bf <__alltraps>

0010215b <vector60>:
.globl vector60
vector60:
  pushl $0
  10215b:	6a 00                	push   $0x0
  pushl $60
  10215d:	6a 3c                	push   $0x3c
  jmp __alltraps
  10215f:	e9 5b 08 00 00       	jmp    1029bf <__alltraps>

00102164 <vector61>:
.globl vector61
vector61:
  pushl $0
  102164:	6a 00                	push   $0x0
  pushl $61
  102166:	6a 3d                	push   $0x3d
  jmp __alltraps
  102168:	e9 52 08 00 00       	jmp    1029bf <__alltraps>

0010216d <vector62>:
.globl vector62
vector62:
  pushl $0
  10216d:	6a 00                	push   $0x0
  pushl $62
  10216f:	6a 3e                	push   $0x3e
  jmp __alltraps
  102171:	e9 49 08 00 00       	jmp    1029bf <__alltraps>

00102176 <vector63>:
.globl vector63
vector63:
  pushl $0
  102176:	6a 00                	push   $0x0
  pushl $63
  102178:	6a 3f                	push   $0x3f
  jmp __alltraps
  10217a:	e9 40 08 00 00       	jmp    1029bf <__alltraps>

0010217f <vector64>:
.globl vector64
vector64:
  pushl $0
  10217f:	6a 00                	push   $0x0
  pushl $64
  102181:	6a 40                	push   $0x40
  jmp __alltraps
  102183:	e9 37 08 00 00       	jmp    1029bf <__alltraps>

00102188 <vector65>:
.globl vector65
vector65:
  pushl $0
  102188:	6a 00                	push   $0x0
  pushl $65
  10218a:	6a 41                	push   $0x41
  jmp __alltraps
  10218c:	e9 2e 08 00 00       	jmp    1029bf <__alltraps>

00102191 <vector66>:
.globl vector66
vector66:
  pushl $0
  102191:	6a 00                	push   $0x0
  pushl $66
  102193:	6a 42                	push   $0x42
  jmp __alltraps
  102195:	e9 25 08 00 00       	jmp    1029bf <__alltraps>

0010219a <vector67>:
.globl vector67
vector67:
  pushl $0
  10219a:	6a 00                	push   $0x0
  pushl $67
  10219c:	6a 43                	push   $0x43
  jmp __alltraps
  10219e:	e9 1c 08 00 00       	jmp    1029bf <__alltraps>

001021a3 <vector68>:
.globl vector68
vector68:
  pushl $0
  1021a3:	6a 00                	push   $0x0
  pushl $68
  1021a5:	6a 44                	push   $0x44
  jmp __alltraps
  1021a7:	e9 13 08 00 00       	jmp    1029bf <__alltraps>

001021ac <vector69>:
.globl vector69
vector69:
  pushl $0
  1021ac:	6a 00                	push   $0x0
  pushl $69
  1021ae:	6a 45                	push   $0x45
  jmp __alltraps
  1021b0:	e9 0a 08 00 00       	jmp    1029bf <__alltraps>

001021b5 <vector70>:
.globl vector70
vector70:
  pushl $0
  1021b5:	6a 00                	push   $0x0
  pushl $70
  1021b7:	6a 46                	push   $0x46
  jmp __alltraps
  1021b9:	e9 01 08 00 00       	jmp    1029bf <__alltraps>

001021be <vector71>:
.globl vector71
vector71:
  pushl $0
  1021be:	6a 00                	push   $0x0
  pushl $71
  1021c0:	6a 47                	push   $0x47
  jmp __alltraps
  1021c2:	e9 f8 07 00 00       	jmp    1029bf <__alltraps>

001021c7 <vector72>:
.globl vector72
vector72:
  pushl $0
  1021c7:	6a 00                	push   $0x0
  pushl $72
  1021c9:	6a 48                	push   $0x48
  jmp __alltraps
  1021cb:	e9 ef 07 00 00       	jmp    1029bf <__alltraps>

001021d0 <vector73>:
.globl vector73
vector73:
  pushl $0
  1021d0:	6a 00                	push   $0x0
  pushl $73
  1021d2:	6a 49                	push   $0x49
  jmp __alltraps
  1021d4:	e9 e6 07 00 00       	jmp    1029bf <__alltraps>

001021d9 <vector74>:
.globl vector74
vector74:
  pushl $0
  1021d9:	6a 00                	push   $0x0
  pushl $74
  1021db:	6a 4a                	push   $0x4a
  jmp __alltraps
  1021dd:	e9 dd 07 00 00       	jmp    1029bf <__alltraps>

001021e2 <vector75>:
.globl vector75
vector75:
  pushl $0
  1021e2:	6a 00                	push   $0x0
  pushl $75
  1021e4:	6a 4b                	push   $0x4b
  jmp __alltraps
  1021e6:	e9 d4 07 00 00       	jmp    1029bf <__alltraps>

001021eb <vector76>:
.globl vector76
vector76:
  pushl $0
  1021eb:	6a 00                	push   $0x0
  pushl $76
  1021ed:	6a 4c                	push   $0x4c
  jmp __alltraps
  1021ef:	e9 cb 07 00 00       	jmp    1029bf <__alltraps>

001021f4 <vector77>:
.globl vector77
vector77:
  pushl $0
  1021f4:	6a 00                	push   $0x0
  pushl $77
  1021f6:	6a 4d                	push   $0x4d
  jmp __alltraps
  1021f8:	e9 c2 07 00 00       	jmp    1029bf <__alltraps>

001021fd <vector78>:
.globl vector78
vector78:
  pushl $0
  1021fd:	6a 00                	push   $0x0
  pushl $78
  1021ff:	6a 4e                	push   $0x4e
  jmp __alltraps
  102201:	e9 b9 07 00 00       	jmp    1029bf <__alltraps>

00102206 <vector79>:
.globl vector79
vector79:
  pushl $0
  102206:	6a 00                	push   $0x0
  pushl $79
  102208:	6a 4f                	push   $0x4f
  jmp __alltraps
  10220a:	e9 b0 07 00 00       	jmp    1029bf <__alltraps>

0010220f <vector80>:
.globl vector80
vector80:
  pushl $0
  10220f:	6a 00                	push   $0x0
  pushl $80
  102211:	6a 50                	push   $0x50
  jmp __alltraps
  102213:	e9 a7 07 00 00       	jmp    1029bf <__alltraps>

00102218 <vector81>:
.globl vector81
vector81:
  pushl $0
  102218:	6a 00                	push   $0x0
  pushl $81
  10221a:	6a 51                	push   $0x51
  jmp __alltraps
  10221c:	e9 9e 07 00 00       	jmp    1029bf <__alltraps>

00102221 <vector82>:
.globl vector82
vector82:
  pushl $0
  102221:	6a 00                	push   $0x0
  pushl $82
  102223:	6a 52                	push   $0x52
  jmp __alltraps
  102225:	e9 95 07 00 00       	jmp    1029bf <__alltraps>

0010222a <vector83>:
.globl vector83
vector83:
  pushl $0
  10222a:	6a 00                	push   $0x0
  pushl $83
  10222c:	6a 53                	push   $0x53
  jmp __alltraps
  10222e:	e9 8c 07 00 00       	jmp    1029bf <__alltraps>

00102233 <vector84>:
.globl vector84
vector84:
  pushl $0
  102233:	6a 00                	push   $0x0
  pushl $84
  102235:	6a 54                	push   $0x54
  jmp __alltraps
  102237:	e9 83 07 00 00       	jmp    1029bf <__alltraps>

0010223c <vector85>:
.globl vector85
vector85:
  pushl $0
  10223c:	6a 00                	push   $0x0
  pushl $85
  10223e:	6a 55                	push   $0x55
  jmp __alltraps
  102240:	e9 7a 07 00 00       	jmp    1029bf <__alltraps>

00102245 <vector86>:
.globl vector86
vector86:
  pushl $0
  102245:	6a 00                	push   $0x0
  pushl $86
  102247:	6a 56                	push   $0x56
  jmp __alltraps
  102249:	e9 71 07 00 00       	jmp    1029bf <__alltraps>

0010224e <vector87>:
.globl vector87
vector87:
  pushl $0
  10224e:	6a 00                	push   $0x0
  pushl $87
  102250:	6a 57                	push   $0x57
  jmp __alltraps
  102252:	e9 68 07 00 00       	jmp    1029bf <__alltraps>

00102257 <vector88>:
.globl vector88
vector88:
  pushl $0
  102257:	6a 00                	push   $0x0
  pushl $88
  102259:	6a 58                	push   $0x58
  jmp __alltraps
  10225b:	e9 5f 07 00 00       	jmp    1029bf <__alltraps>

00102260 <vector89>:
.globl vector89
vector89:
  pushl $0
  102260:	6a 00                	push   $0x0
  pushl $89
  102262:	6a 59                	push   $0x59
  jmp __alltraps
  102264:	e9 56 07 00 00       	jmp    1029bf <__alltraps>

00102269 <vector90>:
.globl vector90
vector90:
  pushl $0
  102269:	6a 00                	push   $0x0
  pushl $90
  10226b:	6a 5a                	push   $0x5a
  jmp __alltraps
  10226d:	e9 4d 07 00 00       	jmp    1029bf <__alltraps>

00102272 <vector91>:
.globl vector91
vector91:
  pushl $0
  102272:	6a 00                	push   $0x0
  pushl $91
  102274:	6a 5b                	push   $0x5b
  jmp __alltraps
  102276:	e9 44 07 00 00       	jmp    1029bf <__alltraps>

0010227b <vector92>:
.globl vector92
vector92:
  pushl $0
  10227b:	6a 00                	push   $0x0
  pushl $92
  10227d:	6a 5c                	push   $0x5c
  jmp __alltraps
  10227f:	e9 3b 07 00 00       	jmp    1029bf <__alltraps>

00102284 <vector93>:
.globl vector93
vector93:
  pushl $0
  102284:	6a 00                	push   $0x0
  pushl $93
  102286:	6a 5d                	push   $0x5d
  jmp __alltraps
  102288:	e9 32 07 00 00       	jmp    1029bf <__alltraps>

0010228d <vector94>:
.globl vector94
vector94:
  pushl $0
  10228d:	6a 00                	push   $0x0
  pushl $94
  10228f:	6a 5e                	push   $0x5e
  jmp __alltraps
  102291:	e9 29 07 00 00       	jmp    1029bf <__alltraps>

00102296 <vector95>:
.globl vector95
vector95:
  pushl $0
  102296:	6a 00                	push   $0x0
  pushl $95
  102298:	6a 5f                	push   $0x5f
  jmp __alltraps
  10229a:	e9 20 07 00 00       	jmp    1029bf <__alltraps>

0010229f <vector96>:
.globl vector96
vector96:
  pushl $0
  10229f:	6a 00                	push   $0x0
  pushl $96
  1022a1:	6a 60                	push   $0x60
  jmp __alltraps
  1022a3:	e9 17 07 00 00       	jmp    1029bf <__alltraps>

001022a8 <vector97>:
.globl vector97
vector97:
  pushl $0
  1022a8:	6a 00                	push   $0x0
  pushl $97
  1022aa:	6a 61                	push   $0x61
  jmp __alltraps
  1022ac:	e9 0e 07 00 00       	jmp    1029bf <__alltraps>

001022b1 <vector98>:
.globl vector98
vector98:
  pushl $0
  1022b1:	6a 00                	push   $0x0
  pushl $98
  1022b3:	6a 62                	push   $0x62
  jmp __alltraps
  1022b5:	e9 05 07 00 00       	jmp    1029bf <__alltraps>

001022ba <vector99>:
.globl vector99
vector99:
  pushl $0
  1022ba:	6a 00                	push   $0x0
  pushl $99
  1022bc:	6a 63                	push   $0x63
  jmp __alltraps
  1022be:	e9 fc 06 00 00       	jmp    1029bf <__alltraps>

001022c3 <vector100>:
.globl vector100
vector100:
  pushl $0
  1022c3:	6a 00                	push   $0x0
  pushl $100
  1022c5:	6a 64                	push   $0x64
  jmp __alltraps
  1022c7:	e9 f3 06 00 00       	jmp    1029bf <__alltraps>

001022cc <vector101>:
.globl vector101
vector101:
  pushl $0
  1022cc:	6a 00                	push   $0x0
  pushl $101
  1022ce:	6a 65                	push   $0x65
  jmp __alltraps
  1022d0:	e9 ea 06 00 00       	jmp    1029bf <__alltraps>

001022d5 <vector102>:
.globl vector102
vector102:
  pushl $0
  1022d5:	6a 00                	push   $0x0
  pushl $102
  1022d7:	6a 66                	push   $0x66
  jmp __alltraps
  1022d9:	e9 e1 06 00 00       	jmp    1029bf <__alltraps>

001022de <vector103>:
.globl vector103
vector103:
  pushl $0
  1022de:	6a 00                	push   $0x0
  pushl $103
  1022e0:	6a 67                	push   $0x67
  jmp __alltraps
  1022e2:	e9 d8 06 00 00       	jmp    1029bf <__alltraps>

001022e7 <vector104>:
.globl vector104
vector104:
  pushl $0
  1022e7:	6a 00                	push   $0x0
  pushl $104
  1022e9:	6a 68                	push   $0x68
  jmp __alltraps
  1022eb:	e9 cf 06 00 00       	jmp    1029bf <__alltraps>

001022f0 <vector105>:
.globl vector105
vector105:
  pushl $0
  1022f0:	6a 00                	push   $0x0
  pushl $105
  1022f2:	6a 69                	push   $0x69
  jmp __alltraps
  1022f4:	e9 c6 06 00 00       	jmp    1029bf <__alltraps>

001022f9 <vector106>:
.globl vector106
vector106:
  pushl $0
  1022f9:	6a 00                	push   $0x0
  pushl $106
  1022fb:	6a 6a                	push   $0x6a
  jmp __alltraps
  1022fd:	e9 bd 06 00 00       	jmp    1029bf <__alltraps>

00102302 <vector107>:
.globl vector107
vector107:
  pushl $0
  102302:	6a 00                	push   $0x0
  pushl $107
  102304:	6a 6b                	push   $0x6b
  jmp __alltraps
  102306:	e9 b4 06 00 00       	jmp    1029bf <__alltraps>

0010230b <vector108>:
.globl vector108
vector108:
  pushl $0
  10230b:	6a 00                	push   $0x0
  pushl $108
  10230d:	6a 6c                	push   $0x6c
  jmp __alltraps
  10230f:	e9 ab 06 00 00       	jmp    1029bf <__alltraps>

00102314 <vector109>:
.globl vector109
vector109:
  pushl $0
  102314:	6a 00                	push   $0x0
  pushl $109
  102316:	6a 6d                	push   $0x6d
  jmp __alltraps
  102318:	e9 a2 06 00 00       	jmp    1029bf <__alltraps>

0010231d <vector110>:
.globl vector110
vector110:
  pushl $0
  10231d:	6a 00                	push   $0x0
  pushl $110
  10231f:	6a 6e                	push   $0x6e
  jmp __alltraps
  102321:	e9 99 06 00 00       	jmp    1029bf <__alltraps>

00102326 <vector111>:
.globl vector111
vector111:
  pushl $0
  102326:	6a 00                	push   $0x0
  pushl $111
  102328:	6a 6f                	push   $0x6f
  jmp __alltraps
  10232a:	e9 90 06 00 00       	jmp    1029bf <__alltraps>

0010232f <vector112>:
.globl vector112
vector112:
  pushl $0
  10232f:	6a 00                	push   $0x0
  pushl $112
  102331:	6a 70                	push   $0x70
  jmp __alltraps
  102333:	e9 87 06 00 00       	jmp    1029bf <__alltraps>

00102338 <vector113>:
.globl vector113
vector113:
  pushl $0
  102338:	6a 00                	push   $0x0
  pushl $113
  10233a:	6a 71                	push   $0x71
  jmp __alltraps
  10233c:	e9 7e 06 00 00       	jmp    1029bf <__alltraps>

00102341 <vector114>:
.globl vector114
vector114:
  pushl $0
  102341:	6a 00                	push   $0x0
  pushl $114
  102343:	6a 72                	push   $0x72
  jmp __alltraps
  102345:	e9 75 06 00 00       	jmp    1029bf <__alltraps>

0010234a <vector115>:
.globl vector115
vector115:
  pushl $0
  10234a:	6a 00                	push   $0x0
  pushl $115
  10234c:	6a 73                	push   $0x73
  jmp __alltraps
  10234e:	e9 6c 06 00 00       	jmp    1029bf <__alltraps>

00102353 <vector116>:
.globl vector116
vector116:
  pushl $0
  102353:	6a 00                	push   $0x0
  pushl $116
  102355:	6a 74                	push   $0x74
  jmp __alltraps
  102357:	e9 63 06 00 00       	jmp    1029bf <__alltraps>

0010235c <vector117>:
.globl vector117
vector117:
  pushl $0
  10235c:	6a 00                	push   $0x0
  pushl $117
  10235e:	6a 75                	push   $0x75
  jmp __alltraps
  102360:	e9 5a 06 00 00       	jmp    1029bf <__alltraps>

00102365 <vector118>:
.globl vector118
vector118:
  pushl $0
  102365:	6a 00                	push   $0x0
  pushl $118
  102367:	6a 76                	push   $0x76
  jmp __alltraps
  102369:	e9 51 06 00 00       	jmp    1029bf <__alltraps>

0010236e <vector119>:
.globl vector119
vector119:
  pushl $0
  10236e:	6a 00                	push   $0x0
  pushl $119
  102370:	6a 77                	push   $0x77
  jmp __alltraps
  102372:	e9 48 06 00 00       	jmp    1029bf <__alltraps>

00102377 <vector120>:
.globl vector120
vector120:
  pushl $0
  102377:	6a 00                	push   $0x0
  pushl $120
  102379:	6a 78                	push   $0x78
  jmp __alltraps
  10237b:	e9 3f 06 00 00       	jmp    1029bf <__alltraps>

00102380 <vector121>:
.globl vector121
vector121:
  pushl $0
  102380:	6a 00                	push   $0x0
  pushl $121
  102382:	6a 79                	push   $0x79
  jmp __alltraps
  102384:	e9 36 06 00 00       	jmp    1029bf <__alltraps>

00102389 <vector122>:
.globl vector122
vector122:
  pushl $0
  102389:	6a 00                	push   $0x0
  pushl $122
  10238b:	6a 7a                	push   $0x7a
  jmp __alltraps
  10238d:	e9 2d 06 00 00       	jmp    1029bf <__alltraps>

00102392 <vector123>:
.globl vector123
vector123:
  pushl $0
  102392:	6a 00                	push   $0x0
  pushl $123
  102394:	6a 7b                	push   $0x7b
  jmp __alltraps
  102396:	e9 24 06 00 00       	jmp    1029bf <__alltraps>

0010239b <vector124>:
.globl vector124
vector124:
  pushl $0
  10239b:	6a 00                	push   $0x0
  pushl $124
  10239d:	6a 7c                	push   $0x7c
  jmp __alltraps
  10239f:	e9 1b 06 00 00       	jmp    1029bf <__alltraps>

001023a4 <vector125>:
.globl vector125
vector125:
  pushl $0
  1023a4:	6a 00                	push   $0x0
  pushl $125
  1023a6:	6a 7d                	push   $0x7d
  jmp __alltraps
  1023a8:	e9 12 06 00 00       	jmp    1029bf <__alltraps>

001023ad <vector126>:
.globl vector126
vector126:
  pushl $0
  1023ad:	6a 00                	push   $0x0
  pushl $126
  1023af:	6a 7e                	push   $0x7e
  jmp __alltraps
  1023b1:	e9 09 06 00 00       	jmp    1029bf <__alltraps>

001023b6 <vector127>:
.globl vector127
vector127:
  pushl $0
  1023b6:	6a 00                	push   $0x0
  pushl $127
  1023b8:	6a 7f                	push   $0x7f
  jmp __alltraps
  1023ba:	e9 00 06 00 00       	jmp    1029bf <__alltraps>

001023bf <vector128>:
.globl vector128
vector128:
  pushl $0
  1023bf:	6a 00                	push   $0x0
  pushl $128
  1023c1:	68 80 00 00 00       	push   $0x80
  jmp __alltraps
  1023c6:	e9 f4 05 00 00       	jmp    1029bf <__alltraps>

001023cb <vector129>:
.globl vector129
vector129:
  pushl $0
  1023cb:	6a 00                	push   $0x0
  pushl $129
  1023cd:	68 81 00 00 00       	push   $0x81
  jmp __alltraps
  1023d2:	e9 e8 05 00 00       	jmp    1029bf <__alltraps>

001023d7 <vector130>:
.globl vector130
vector130:
  pushl $0
  1023d7:	6a 00                	push   $0x0
  pushl $130
  1023d9:	68 82 00 00 00       	push   $0x82
  jmp __alltraps
  1023de:	e9 dc 05 00 00       	jmp    1029bf <__alltraps>

001023e3 <vector131>:
.globl vector131
vector131:
  pushl $0
  1023e3:	6a 00                	push   $0x0
  pushl $131
  1023e5:	68 83 00 00 00       	push   $0x83
  jmp __alltraps
  1023ea:	e9 d0 05 00 00       	jmp    1029bf <__alltraps>

001023ef <vector132>:
.globl vector132
vector132:
  pushl $0
  1023ef:	6a 00                	push   $0x0
  pushl $132
  1023f1:	68 84 00 00 00       	push   $0x84
  jmp __alltraps
  1023f6:	e9 c4 05 00 00       	jmp    1029bf <__alltraps>

001023fb <vector133>:
.globl vector133
vector133:
  pushl $0
  1023fb:	6a 00                	push   $0x0
  pushl $133
  1023fd:	68 85 00 00 00       	push   $0x85
  jmp __alltraps
  102402:	e9 b8 05 00 00       	jmp    1029bf <__alltraps>

00102407 <vector134>:
.globl vector134
vector134:
  pushl $0
  102407:	6a 00                	push   $0x0
  pushl $134
  102409:	68 86 00 00 00       	push   $0x86
  jmp __alltraps
  10240e:	e9 ac 05 00 00       	jmp    1029bf <__alltraps>

00102413 <vector135>:
.globl vector135
vector135:
  pushl $0
  102413:	6a 00                	push   $0x0
  pushl $135
  102415:	68 87 00 00 00       	push   $0x87
  jmp __alltraps
  10241a:	e9 a0 05 00 00       	jmp    1029bf <__alltraps>

0010241f <vector136>:
.globl vector136
vector136:
  pushl $0
  10241f:	6a 00                	push   $0x0
  pushl $136
  102421:	68 88 00 00 00       	push   $0x88
  jmp __alltraps
  102426:	e9 94 05 00 00       	jmp    1029bf <__alltraps>

0010242b <vector137>:
.globl vector137
vector137:
  pushl $0
  10242b:	6a 00                	push   $0x0
  pushl $137
  10242d:	68 89 00 00 00       	push   $0x89
  jmp __alltraps
  102432:	e9 88 05 00 00       	jmp    1029bf <__alltraps>

00102437 <vector138>:
.globl vector138
vector138:
  pushl $0
  102437:	6a 00                	push   $0x0
  pushl $138
  102439:	68 8a 00 00 00       	push   $0x8a
  jmp __alltraps
  10243e:	e9 7c 05 00 00       	jmp    1029bf <__alltraps>

00102443 <vector139>:
.globl vector139
vector139:
  pushl $0
  102443:	6a 00                	push   $0x0
  pushl $139
  102445:	68 8b 00 00 00       	push   $0x8b
  jmp __alltraps
  10244a:	e9 70 05 00 00       	jmp    1029bf <__alltraps>

0010244f <vector140>:
.globl vector140
vector140:
  pushl $0
  10244f:	6a 00                	push   $0x0
  pushl $140
  102451:	68 8c 00 00 00       	push   $0x8c
  jmp __alltraps
  102456:	e9 64 05 00 00       	jmp    1029bf <__alltraps>

0010245b <vector141>:
.globl vector141
vector141:
  pushl $0
  10245b:	6a 00                	push   $0x0
  pushl $141
  10245d:	68 8d 00 00 00       	push   $0x8d
  jmp __alltraps
  102462:	e9 58 05 00 00       	jmp    1029bf <__alltraps>

00102467 <vector142>:
.globl vector142
vector142:
  pushl $0
  102467:	6a 00                	push   $0x0
  pushl $142
  102469:	68 8e 00 00 00       	push   $0x8e
  jmp __alltraps
  10246e:	e9 4c 05 00 00       	jmp    1029bf <__alltraps>

00102473 <vector143>:
.globl vector143
vector143:
  pushl $0
  102473:	6a 00                	push   $0x0
  pushl $143
  102475:	68 8f 00 00 00       	push   $0x8f
  jmp __alltraps
  10247a:	e9 40 05 00 00       	jmp    1029bf <__alltraps>

0010247f <vector144>:
.globl vector144
vector144:
  pushl $0
  10247f:	6a 00                	push   $0x0
  pushl $144
  102481:	68 90 00 00 00       	push   $0x90
  jmp __alltraps
  102486:	e9 34 05 00 00       	jmp    1029bf <__alltraps>

0010248b <vector145>:
.globl vector145
vector145:
  pushl $0
  10248b:	6a 00                	push   $0x0
  pushl $145
  10248d:	68 91 00 00 00       	push   $0x91
  jmp __alltraps
  102492:	e9 28 05 00 00       	jmp    1029bf <__alltraps>

00102497 <vector146>:
.globl vector146
vector146:
  pushl $0
  102497:	6a 00                	push   $0x0
  pushl $146
  102499:	68 92 00 00 00       	push   $0x92
  jmp __alltraps
  10249e:	e9 1c 05 00 00       	jmp    1029bf <__alltraps>

001024a3 <vector147>:
.globl vector147
vector147:
  pushl $0
  1024a3:	6a 00                	push   $0x0
  pushl $147
  1024a5:	68 93 00 00 00       	push   $0x93
  jmp __alltraps
  1024aa:	e9 10 05 00 00       	jmp    1029bf <__alltraps>

001024af <vector148>:
.globl vector148
vector148:
  pushl $0
  1024af:	6a 00                	push   $0x0
  pushl $148
  1024b1:	68 94 00 00 00       	push   $0x94
  jmp __alltraps
  1024b6:	e9 04 05 00 00       	jmp    1029bf <__alltraps>

001024bb <vector149>:
.globl vector149
vector149:
  pushl $0
  1024bb:	6a 00                	push   $0x0
  pushl $149
  1024bd:	68 95 00 00 00       	push   $0x95
  jmp __alltraps
  1024c2:	e9 f8 04 00 00       	jmp    1029bf <__alltraps>

001024c7 <vector150>:
.globl vector150
vector150:
  pushl $0
  1024c7:	6a 00                	push   $0x0
  pushl $150
  1024c9:	68 96 00 00 00       	push   $0x96
  jmp __alltraps
  1024ce:	e9 ec 04 00 00       	jmp    1029bf <__alltraps>

001024d3 <vector151>:
.globl vector151
vector151:
  pushl $0
  1024d3:	6a 00                	push   $0x0
  pushl $151
  1024d5:	68 97 00 00 00       	push   $0x97
  jmp __alltraps
  1024da:	e9 e0 04 00 00       	jmp    1029bf <__alltraps>

001024df <vector152>:
.globl vector152
vector152:
  pushl $0
  1024df:	6a 00                	push   $0x0
  pushl $152
  1024e1:	68 98 00 00 00       	push   $0x98
  jmp __alltraps
  1024e6:	e9 d4 04 00 00       	jmp    1029bf <__alltraps>

001024eb <vector153>:
.globl vector153
vector153:
  pushl $0
  1024eb:	6a 00                	push   $0x0
  pushl $153
  1024ed:	68 99 00 00 00       	push   $0x99
  jmp __alltraps
  1024f2:	e9 c8 04 00 00       	jmp    1029bf <__alltraps>

001024f7 <vector154>:
.globl vector154
vector154:
  pushl $0
  1024f7:	6a 00                	push   $0x0
  pushl $154
  1024f9:	68 9a 00 00 00       	push   $0x9a
  jmp __alltraps
  1024fe:	e9 bc 04 00 00       	jmp    1029bf <__alltraps>

00102503 <vector155>:
.globl vector155
vector155:
  pushl $0
  102503:	6a 00                	push   $0x0
  pushl $155
  102505:	68 9b 00 00 00       	push   $0x9b
  jmp __alltraps
  10250a:	e9 b0 04 00 00       	jmp    1029bf <__alltraps>

0010250f <vector156>:
.globl vector156
vector156:
  pushl $0
  10250f:	6a 00                	push   $0x0
  pushl $156
  102511:	68 9c 00 00 00       	push   $0x9c
  jmp __alltraps
  102516:	e9 a4 04 00 00       	jmp    1029bf <__alltraps>

0010251b <vector157>:
.globl vector157
vector157:
  pushl $0
  10251b:	6a 00                	push   $0x0
  pushl $157
  10251d:	68 9d 00 00 00       	push   $0x9d
  jmp __alltraps
  102522:	e9 98 04 00 00       	jmp    1029bf <__alltraps>

00102527 <vector158>:
.globl vector158
vector158:
  pushl $0
  102527:	6a 00                	push   $0x0
  pushl $158
  102529:	68 9e 00 00 00       	push   $0x9e
  jmp __alltraps
  10252e:	e9 8c 04 00 00       	jmp    1029bf <__alltraps>

00102533 <vector159>:
.globl vector159
vector159:
  pushl $0
  102533:	6a 00                	push   $0x0
  pushl $159
  102535:	68 9f 00 00 00       	push   $0x9f
  jmp __alltraps
  10253a:	e9 80 04 00 00       	jmp    1029bf <__alltraps>

0010253f <vector160>:
.globl vector160
vector160:
  pushl $0
  10253f:	6a 00                	push   $0x0
  pushl $160
  102541:	68 a0 00 00 00       	push   $0xa0
  jmp __alltraps
  102546:	e9 74 04 00 00       	jmp    1029bf <__alltraps>

0010254b <vector161>:
.globl vector161
vector161:
  pushl $0
  10254b:	6a 00                	push   $0x0
  pushl $161
  10254d:	68 a1 00 00 00       	push   $0xa1
  jmp __alltraps
  102552:	e9 68 04 00 00       	jmp    1029bf <__alltraps>

00102557 <vector162>:
.globl vector162
vector162:
  pushl $0
  102557:	6a 00                	push   $0x0
  pushl $162
  102559:	68 a2 00 00 00       	push   $0xa2
  jmp __alltraps
  10255e:	e9 5c 04 00 00       	jmp    1029bf <__alltraps>

00102563 <vector163>:
.globl vector163
vector163:
  pushl $0
  102563:	6a 00                	push   $0x0
  pushl $163
  102565:	68 a3 00 00 00       	push   $0xa3
  jmp __alltraps
  10256a:	e9 50 04 00 00       	jmp    1029bf <__alltraps>

0010256f <vector164>:
.globl vector164
vector164:
  pushl $0
  10256f:	6a 00                	push   $0x0
  pushl $164
  102571:	68 a4 00 00 00       	push   $0xa4
  jmp __alltraps
  102576:	e9 44 04 00 00       	jmp    1029bf <__alltraps>

0010257b <vector165>:
.globl vector165
vector165:
  pushl $0
  10257b:	6a 00                	push   $0x0
  pushl $165
  10257d:	68 a5 00 00 00       	push   $0xa5
  jmp __alltraps
  102582:	e9 38 04 00 00       	jmp    1029bf <__alltraps>

00102587 <vector166>:
.globl vector166
vector166:
  pushl $0
  102587:	6a 00                	push   $0x0
  pushl $166
  102589:	68 a6 00 00 00       	push   $0xa6
  jmp __alltraps
  10258e:	e9 2c 04 00 00       	jmp    1029bf <__alltraps>

00102593 <vector167>:
.globl vector167
vector167:
  pushl $0
  102593:	6a 00                	push   $0x0
  pushl $167
  102595:	68 a7 00 00 00       	push   $0xa7
  jmp __alltraps
  10259a:	e9 20 04 00 00       	jmp    1029bf <__alltraps>

0010259f <vector168>:
.globl vector168
vector168:
  pushl $0
  10259f:	6a 00                	push   $0x0
  pushl $168
  1025a1:	68 a8 00 00 00       	push   $0xa8
  jmp __alltraps
  1025a6:	e9 14 04 00 00       	jmp    1029bf <__alltraps>

001025ab <vector169>:
.globl vector169
vector169:
  pushl $0
  1025ab:	6a 00                	push   $0x0
  pushl $169
  1025ad:	68 a9 00 00 00       	push   $0xa9
  jmp __alltraps
  1025b2:	e9 08 04 00 00       	jmp    1029bf <__alltraps>

001025b7 <vector170>:
.globl vector170
vector170:
  pushl $0
  1025b7:	6a 00                	push   $0x0
  pushl $170
  1025b9:	68 aa 00 00 00       	push   $0xaa
  jmp __alltraps
  1025be:	e9 fc 03 00 00       	jmp    1029bf <__alltraps>

001025c3 <vector171>:
.globl vector171
vector171:
  pushl $0
  1025c3:	6a 00                	push   $0x0
  pushl $171
  1025c5:	68 ab 00 00 00       	push   $0xab
  jmp __alltraps
  1025ca:	e9 f0 03 00 00       	jmp    1029bf <__alltraps>

001025cf <vector172>:
.globl vector172
vector172:
  pushl $0
  1025cf:	6a 00                	push   $0x0
  pushl $172
  1025d1:	68 ac 00 00 00       	push   $0xac
  jmp __alltraps
  1025d6:	e9 e4 03 00 00       	jmp    1029bf <__alltraps>

001025db <vector173>:
.globl vector173
vector173:
  pushl $0
  1025db:	6a 00                	push   $0x0
  pushl $173
  1025dd:	68 ad 00 00 00       	push   $0xad
  jmp __alltraps
  1025e2:	e9 d8 03 00 00       	jmp    1029bf <__alltraps>

001025e7 <vector174>:
.globl vector174
vector174:
  pushl $0
  1025e7:	6a 00                	push   $0x0
  pushl $174
  1025e9:	68 ae 00 00 00       	push   $0xae
  jmp __alltraps
  1025ee:	e9 cc 03 00 00       	jmp    1029bf <__alltraps>

001025f3 <vector175>:
.globl vector175
vector175:
  pushl $0
  1025f3:	6a 00                	push   $0x0
  pushl $175
  1025f5:	68 af 00 00 00       	push   $0xaf
  jmp __alltraps
  1025fa:	e9 c0 03 00 00       	jmp    1029bf <__alltraps>

001025ff <vector176>:
.globl vector176
vector176:
  pushl $0
  1025ff:	6a 00                	push   $0x0
  pushl $176
  102601:	68 b0 00 00 00       	push   $0xb0
  jmp __alltraps
  102606:	e9 b4 03 00 00       	jmp    1029bf <__alltraps>

0010260b <vector177>:
.globl vector177
vector177:
  pushl $0
  10260b:	6a 00                	push   $0x0
  pushl $177
  10260d:	68 b1 00 00 00       	push   $0xb1
  jmp __alltraps
  102612:	e9 a8 03 00 00       	jmp    1029bf <__alltraps>

00102617 <vector178>:
.globl vector178
vector178:
  pushl $0
  102617:	6a 00                	push   $0x0
  pushl $178
  102619:	68 b2 00 00 00       	push   $0xb2
  jmp __alltraps
  10261e:	e9 9c 03 00 00       	jmp    1029bf <__alltraps>

00102623 <vector179>:
.globl vector179
vector179:
  pushl $0
  102623:	6a 00                	push   $0x0
  pushl $179
  102625:	68 b3 00 00 00       	push   $0xb3
  jmp __alltraps
  10262a:	e9 90 03 00 00       	jmp    1029bf <__alltraps>

0010262f <vector180>:
.globl vector180
vector180:
  pushl $0
  10262f:	6a 00                	push   $0x0
  pushl $180
  102631:	68 b4 00 00 00       	push   $0xb4
  jmp __alltraps
  102636:	e9 84 03 00 00       	jmp    1029bf <__alltraps>

0010263b <vector181>:
.globl vector181
vector181:
  pushl $0
  10263b:	6a 00                	push   $0x0
  pushl $181
  10263d:	68 b5 00 00 00       	push   $0xb5
  jmp __alltraps
  102642:	e9 78 03 00 00       	jmp    1029bf <__alltraps>

00102647 <vector182>:
.globl vector182
vector182:
  pushl $0
  102647:	6a 00                	push   $0x0
  pushl $182
  102649:	68 b6 00 00 00       	push   $0xb6
  jmp __alltraps
  10264e:	e9 6c 03 00 00       	jmp    1029bf <__alltraps>

00102653 <vector183>:
.globl vector183
vector183:
  pushl $0
  102653:	6a 00                	push   $0x0
  pushl $183
  102655:	68 b7 00 00 00       	push   $0xb7
  jmp __alltraps
  10265a:	e9 60 03 00 00       	jmp    1029bf <__alltraps>

0010265f <vector184>:
.globl vector184
vector184:
  pushl $0
  10265f:	6a 00                	push   $0x0
  pushl $184
  102661:	68 b8 00 00 00       	push   $0xb8
  jmp __alltraps
  102666:	e9 54 03 00 00       	jmp    1029bf <__alltraps>

0010266b <vector185>:
.globl vector185
vector185:
  pushl $0
  10266b:	6a 00                	push   $0x0
  pushl $185
  10266d:	68 b9 00 00 00       	push   $0xb9
  jmp __alltraps
  102672:	e9 48 03 00 00       	jmp    1029bf <__alltraps>

00102677 <vector186>:
.globl vector186
vector186:
  pushl $0
  102677:	6a 00                	push   $0x0
  pushl $186
  102679:	68 ba 00 00 00       	push   $0xba
  jmp __alltraps
  10267e:	e9 3c 03 00 00       	jmp    1029bf <__alltraps>

00102683 <vector187>:
.globl vector187
vector187:
  pushl $0
  102683:	6a 00                	push   $0x0
  pushl $187
  102685:	68 bb 00 00 00       	push   $0xbb
  jmp __alltraps
  10268a:	e9 30 03 00 00       	jmp    1029bf <__alltraps>

0010268f <vector188>:
.globl vector188
vector188:
  pushl $0
  10268f:	6a 00                	push   $0x0
  pushl $188
  102691:	68 bc 00 00 00       	push   $0xbc
  jmp __alltraps
  102696:	e9 24 03 00 00       	jmp    1029bf <__alltraps>

0010269b <vector189>:
.globl vector189
vector189:
  pushl $0
  10269b:	6a 00                	push   $0x0
  pushl $189
  10269d:	68 bd 00 00 00       	push   $0xbd
  jmp __alltraps
  1026a2:	e9 18 03 00 00       	jmp    1029bf <__alltraps>

001026a7 <vector190>:
.globl vector190
vector190:
  pushl $0
  1026a7:	6a 00                	push   $0x0
  pushl $190
  1026a9:	68 be 00 00 00       	push   $0xbe
  jmp __alltraps
  1026ae:	e9 0c 03 00 00       	jmp    1029bf <__alltraps>

001026b3 <vector191>:
.globl vector191
vector191:
  pushl $0
  1026b3:	6a 00                	push   $0x0
  pushl $191
  1026b5:	68 bf 00 00 00       	push   $0xbf
  jmp __alltraps
  1026ba:	e9 00 03 00 00       	jmp    1029bf <__alltraps>

001026bf <vector192>:
.globl vector192
vector192:
  pushl $0
  1026bf:	6a 00                	push   $0x0
  pushl $192
  1026c1:	68 c0 00 00 00       	push   $0xc0
  jmp __alltraps
  1026c6:	e9 f4 02 00 00       	jmp    1029bf <__alltraps>

001026cb <vector193>:
.globl vector193
vector193:
  pushl $0
  1026cb:	6a 00                	push   $0x0
  pushl $193
  1026cd:	68 c1 00 00 00       	push   $0xc1
  jmp __alltraps
  1026d2:	e9 e8 02 00 00       	jmp    1029bf <__alltraps>

001026d7 <vector194>:
.globl vector194
vector194:
  pushl $0
  1026d7:	6a 00                	push   $0x0
  pushl $194
  1026d9:	68 c2 00 00 00       	push   $0xc2
  jmp __alltraps
  1026de:	e9 dc 02 00 00       	jmp    1029bf <__alltraps>

001026e3 <vector195>:
.globl vector195
vector195:
  pushl $0
  1026e3:	6a 00                	push   $0x0
  pushl $195
  1026e5:	68 c3 00 00 00       	push   $0xc3
  jmp __alltraps
  1026ea:	e9 d0 02 00 00       	jmp    1029bf <__alltraps>

001026ef <vector196>:
.globl vector196
vector196:
  pushl $0
  1026ef:	6a 00                	push   $0x0
  pushl $196
  1026f1:	68 c4 00 00 00       	push   $0xc4
  jmp __alltraps
  1026f6:	e9 c4 02 00 00       	jmp    1029bf <__alltraps>

001026fb <vector197>:
.globl vector197
vector197:
  pushl $0
  1026fb:	6a 00                	push   $0x0
  pushl $197
  1026fd:	68 c5 00 00 00       	push   $0xc5
  jmp __alltraps
  102702:	e9 b8 02 00 00       	jmp    1029bf <__alltraps>

00102707 <vector198>:
.globl vector198
vector198:
  pushl $0
  102707:	6a 00                	push   $0x0
  pushl $198
  102709:	68 c6 00 00 00       	push   $0xc6
  jmp __alltraps
  10270e:	e9 ac 02 00 00       	jmp    1029bf <__alltraps>

00102713 <vector199>:
.globl vector199
vector199:
  pushl $0
  102713:	6a 00                	push   $0x0
  pushl $199
  102715:	68 c7 00 00 00       	push   $0xc7
  jmp __alltraps
  10271a:	e9 a0 02 00 00       	jmp    1029bf <__alltraps>

0010271f <vector200>:
.globl vector200
vector200:
  pushl $0
  10271f:	6a 00                	push   $0x0
  pushl $200
  102721:	68 c8 00 00 00       	push   $0xc8
  jmp __alltraps
  102726:	e9 94 02 00 00       	jmp    1029bf <__alltraps>

0010272b <vector201>:
.globl vector201
vector201:
  pushl $0
  10272b:	6a 00                	push   $0x0
  pushl $201
  10272d:	68 c9 00 00 00       	push   $0xc9
  jmp __alltraps
  102732:	e9 88 02 00 00       	jmp    1029bf <__alltraps>

00102737 <vector202>:
.globl vector202
vector202:
  pushl $0
  102737:	6a 00                	push   $0x0
  pushl $202
  102739:	68 ca 00 00 00       	push   $0xca
  jmp __alltraps
  10273e:	e9 7c 02 00 00       	jmp    1029bf <__alltraps>

00102743 <vector203>:
.globl vector203
vector203:
  pushl $0
  102743:	6a 00                	push   $0x0
  pushl $203
  102745:	68 cb 00 00 00       	push   $0xcb
  jmp __alltraps
  10274a:	e9 70 02 00 00       	jmp    1029bf <__alltraps>

0010274f <vector204>:
.globl vector204
vector204:
  pushl $0
  10274f:	6a 00                	push   $0x0
  pushl $204
  102751:	68 cc 00 00 00       	push   $0xcc
  jmp __alltraps
  102756:	e9 64 02 00 00       	jmp    1029bf <__alltraps>

0010275b <vector205>:
.globl vector205
vector205:
  pushl $0
  10275b:	6a 00                	push   $0x0
  pushl $205
  10275d:	68 cd 00 00 00       	push   $0xcd
  jmp __alltraps
  102762:	e9 58 02 00 00       	jmp    1029bf <__alltraps>

00102767 <vector206>:
.globl vector206
vector206:
  pushl $0
  102767:	6a 00                	push   $0x0
  pushl $206
  102769:	68 ce 00 00 00       	push   $0xce
  jmp __alltraps
  10276e:	e9 4c 02 00 00       	jmp    1029bf <__alltraps>

00102773 <vector207>:
.globl vector207
vector207:
  pushl $0
  102773:	6a 00                	push   $0x0
  pushl $207
  102775:	68 cf 00 00 00       	push   $0xcf
  jmp __alltraps
  10277a:	e9 40 02 00 00       	jmp    1029bf <__alltraps>

0010277f <vector208>:
.globl vector208
vector208:
  pushl $0
  10277f:	6a 00                	push   $0x0
  pushl $208
  102781:	68 d0 00 00 00       	push   $0xd0
  jmp __alltraps
  102786:	e9 34 02 00 00       	jmp    1029bf <__alltraps>

0010278b <vector209>:
.globl vector209
vector209:
  pushl $0
  10278b:	6a 00                	push   $0x0
  pushl $209
  10278d:	68 d1 00 00 00       	push   $0xd1
  jmp __alltraps
  102792:	e9 28 02 00 00       	jmp    1029bf <__alltraps>

00102797 <vector210>:
.globl vector210
vector210:
  pushl $0
  102797:	6a 00                	push   $0x0
  pushl $210
  102799:	68 d2 00 00 00       	push   $0xd2
  jmp __alltraps
  10279e:	e9 1c 02 00 00       	jmp    1029bf <__alltraps>

001027a3 <vector211>:
.globl vector211
vector211:
  pushl $0
  1027a3:	6a 00                	push   $0x0
  pushl $211
  1027a5:	68 d3 00 00 00       	push   $0xd3
  jmp __alltraps
  1027aa:	e9 10 02 00 00       	jmp    1029bf <__alltraps>

001027af <vector212>:
.globl vector212
vector212:
  pushl $0
  1027af:	6a 00                	push   $0x0
  pushl $212
  1027b1:	68 d4 00 00 00       	push   $0xd4
  jmp __alltraps
  1027b6:	e9 04 02 00 00       	jmp    1029bf <__alltraps>

001027bb <vector213>:
.globl vector213
vector213:
  pushl $0
  1027bb:	6a 00                	push   $0x0
  pushl $213
  1027bd:	68 d5 00 00 00       	push   $0xd5
  jmp __alltraps
  1027c2:	e9 f8 01 00 00       	jmp    1029bf <__alltraps>

001027c7 <vector214>:
.globl vector214
vector214:
  pushl $0
  1027c7:	6a 00                	push   $0x0
  pushl $214
  1027c9:	68 d6 00 00 00       	push   $0xd6
  jmp __alltraps
  1027ce:	e9 ec 01 00 00       	jmp    1029bf <__alltraps>

001027d3 <vector215>:
.globl vector215
vector215:
  pushl $0
  1027d3:	6a 00                	push   $0x0
  pushl $215
  1027d5:	68 d7 00 00 00       	push   $0xd7
  jmp __alltraps
  1027da:	e9 e0 01 00 00       	jmp    1029bf <__alltraps>

001027df <vector216>:
.globl vector216
vector216:
  pushl $0
  1027df:	6a 00                	push   $0x0
  pushl $216
  1027e1:	68 d8 00 00 00       	push   $0xd8
  jmp __alltraps
  1027e6:	e9 d4 01 00 00       	jmp    1029bf <__alltraps>

001027eb <vector217>:
.globl vector217
vector217:
  pushl $0
  1027eb:	6a 00                	push   $0x0
  pushl $217
  1027ed:	68 d9 00 00 00       	push   $0xd9
  jmp __alltraps
  1027f2:	e9 c8 01 00 00       	jmp    1029bf <__alltraps>

001027f7 <vector218>:
.globl vector218
vector218:
  pushl $0
  1027f7:	6a 00                	push   $0x0
  pushl $218
  1027f9:	68 da 00 00 00       	push   $0xda
  jmp __alltraps
  1027fe:	e9 bc 01 00 00       	jmp    1029bf <__alltraps>

00102803 <vector219>:
.globl vector219
vector219:
  pushl $0
  102803:	6a 00                	push   $0x0
  pushl $219
  102805:	68 db 00 00 00       	push   $0xdb
  jmp __alltraps
  10280a:	e9 b0 01 00 00       	jmp    1029bf <__alltraps>

0010280f <vector220>:
.globl vector220
vector220:
  pushl $0
  10280f:	6a 00                	push   $0x0
  pushl $220
  102811:	68 dc 00 00 00       	push   $0xdc
  jmp __alltraps
  102816:	e9 a4 01 00 00       	jmp    1029bf <__alltraps>

0010281b <vector221>:
.globl vector221
vector221:
  pushl $0
  10281b:	6a 00                	push   $0x0
  pushl $221
  10281d:	68 dd 00 00 00       	push   $0xdd
  jmp __alltraps
  102822:	e9 98 01 00 00       	jmp    1029bf <__alltraps>

00102827 <vector222>:
.globl vector222
vector222:
  pushl $0
  102827:	6a 00                	push   $0x0
  pushl $222
  102829:	68 de 00 00 00       	push   $0xde
  jmp __alltraps
  10282e:	e9 8c 01 00 00       	jmp    1029bf <__alltraps>

00102833 <vector223>:
.globl vector223
vector223:
  pushl $0
  102833:	6a 00                	push   $0x0
  pushl $223
  102835:	68 df 00 00 00       	push   $0xdf
  jmp __alltraps
  10283a:	e9 80 01 00 00       	jmp    1029bf <__alltraps>

0010283f <vector224>:
.globl vector224
vector224:
  pushl $0
  10283f:	6a 00                	push   $0x0
  pushl $224
  102841:	68 e0 00 00 00       	push   $0xe0
  jmp __alltraps
  102846:	e9 74 01 00 00       	jmp    1029bf <__alltraps>

0010284b <vector225>:
.globl vector225
vector225:
  pushl $0
  10284b:	6a 00                	push   $0x0
  pushl $225
  10284d:	68 e1 00 00 00       	push   $0xe1
  jmp __alltraps
  102852:	e9 68 01 00 00       	jmp    1029bf <__alltraps>

00102857 <vector226>:
.globl vector226
vector226:
  pushl $0
  102857:	6a 00                	push   $0x0
  pushl $226
  102859:	68 e2 00 00 00       	push   $0xe2
  jmp __alltraps
  10285e:	e9 5c 01 00 00       	jmp    1029bf <__alltraps>

00102863 <vector227>:
.globl vector227
vector227:
  pushl $0
  102863:	6a 00                	push   $0x0
  pushl $227
  102865:	68 e3 00 00 00       	push   $0xe3
  jmp __alltraps
  10286a:	e9 50 01 00 00       	jmp    1029bf <__alltraps>

0010286f <vector228>:
.globl vector228
vector228:
  pushl $0
  10286f:	6a 00                	push   $0x0
  pushl $228
  102871:	68 e4 00 00 00       	push   $0xe4
  jmp __alltraps
  102876:	e9 44 01 00 00       	jmp    1029bf <__alltraps>

0010287b <vector229>:
.globl vector229
vector229:
  pushl $0
  10287b:	6a 00                	push   $0x0
  pushl $229
  10287d:	68 e5 00 00 00       	push   $0xe5
  jmp __alltraps
  102882:	e9 38 01 00 00       	jmp    1029bf <__alltraps>

00102887 <vector230>:
.globl vector230
vector230:
  pushl $0
  102887:	6a 00                	push   $0x0
  pushl $230
  102889:	68 e6 00 00 00       	push   $0xe6
  jmp __alltraps
  10288e:	e9 2c 01 00 00       	jmp    1029bf <__alltraps>

00102893 <vector231>:
.globl vector231
vector231:
  pushl $0
  102893:	6a 00                	push   $0x0
  pushl $231
  102895:	68 e7 00 00 00       	push   $0xe7
  jmp __alltraps
  10289a:	e9 20 01 00 00       	jmp    1029bf <__alltraps>

0010289f <vector232>:
.globl vector232
vector232:
  pushl $0
  10289f:	6a 00                	push   $0x0
  pushl $232
  1028a1:	68 e8 00 00 00       	push   $0xe8
  jmp __alltraps
  1028a6:	e9 14 01 00 00       	jmp    1029bf <__alltraps>

001028ab <vector233>:
.globl vector233
vector233:
  pushl $0
  1028ab:	6a 00                	push   $0x0
  pushl $233
  1028ad:	68 e9 00 00 00       	push   $0xe9
  jmp __alltraps
  1028b2:	e9 08 01 00 00       	jmp    1029bf <__alltraps>

001028b7 <vector234>:
.globl vector234
vector234:
  pushl $0
  1028b7:	6a 00                	push   $0x0
  pushl $234
  1028b9:	68 ea 00 00 00       	push   $0xea
  jmp __alltraps
  1028be:	e9 fc 00 00 00       	jmp    1029bf <__alltraps>

001028c3 <vector235>:
.globl vector235
vector235:
  pushl $0
  1028c3:	6a 00                	push   $0x0
  pushl $235
  1028c5:	68 eb 00 00 00       	push   $0xeb
  jmp __alltraps
  1028ca:	e9 f0 00 00 00       	jmp    1029bf <__alltraps>

001028cf <vector236>:
.globl vector236
vector236:
  pushl $0
  1028cf:	6a 00                	push   $0x0
  pushl $236
  1028d1:	68 ec 00 00 00       	push   $0xec
  jmp __alltraps
  1028d6:	e9 e4 00 00 00       	jmp    1029bf <__alltraps>

001028db <vector237>:
.globl vector237
vector237:
  pushl $0
  1028db:	6a 00                	push   $0x0
  pushl $237
  1028dd:	68 ed 00 00 00       	push   $0xed
  jmp __alltraps
  1028e2:	e9 d8 00 00 00       	jmp    1029bf <__alltraps>

001028e7 <vector238>:
.globl vector238
vector238:
  pushl $0
  1028e7:	6a 00                	push   $0x0
  pushl $238
  1028e9:	68 ee 00 00 00       	push   $0xee
  jmp __alltraps
  1028ee:	e9 cc 00 00 00       	jmp    1029bf <__alltraps>

001028f3 <vector239>:
.globl vector239
vector239:
  pushl $0
  1028f3:	6a 00                	push   $0x0
  pushl $239
  1028f5:	68 ef 00 00 00       	push   $0xef
  jmp __alltraps
  1028fa:	e9 c0 00 00 00       	jmp    1029bf <__alltraps>

001028ff <vector240>:
.globl vector240
vector240:
  pushl $0
  1028ff:	6a 00                	push   $0x0
  pushl $240
  102901:	68 f0 00 00 00       	push   $0xf0
  jmp __alltraps
  102906:	e9 b4 00 00 00       	jmp    1029bf <__alltraps>

0010290b <vector241>:
.globl vector241
vector241:
  pushl $0
  10290b:	6a 00                	push   $0x0
  pushl $241
  10290d:	68 f1 00 00 00       	push   $0xf1
  jmp __alltraps
  102912:	e9 a8 00 00 00       	jmp    1029bf <__alltraps>

00102917 <vector242>:
.globl vector242
vector242:
  pushl $0
  102917:	6a 00                	push   $0x0
  pushl $242
  102919:	68 f2 00 00 00       	push   $0xf2
  jmp __alltraps
  10291e:	e9 9c 00 00 00       	jmp    1029bf <__alltraps>

00102923 <vector243>:
.globl vector243
vector243:
  pushl $0
  102923:	6a 00                	push   $0x0
  pushl $243
  102925:	68 f3 00 00 00       	push   $0xf3
  jmp __alltraps
  10292a:	e9 90 00 00 00       	jmp    1029bf <__alltraps>

0010292f <vector244>:
.globl vector244
vector244:
  pushl $0
  10292f:	6a 00                	push   $0x0
  pushl $244
  102931:	68 f4 00 00 00       	push   $0xf4
  jmp __alltraps
  102936:	e9 84 00 00 00       	jmp    1029bf <__alltraps>

0010293b <vector245>:
.globl vector245
vector245:
  pushl $0
  10293b:	6a 00                	push   $0x0
  pushl $245
  10293d:	68 f5 00 00 00       	push   $0xf5
  jmp __alltraps
  102942:	e9 78 00 00 00       	jmp    1029bf <__alltraps>

00102947 <vector246>:
.globl vector246
vector246:
  pushl $0
  102947:	6a 00                	push   $0x0
  pushl $246
  102949:	68 f6 00 00 00       	push   $0xf6
  jmp __alltraps
  10294e:	e9 6c 00 00 00       	jmp    1029bf <__alltraps>

00102953 <vector247>:
.globl vector247
vector247:
  pushl $0
  102953:	6a 00                	push   $0x0
  pushl $247
  102955:	68 f7 00 00 00       	push   $0xf7
  jmp __alltraps
  10295a:	e9 60 00 00 00       	jmp    1029bf <__alltraps>

0010295f <vector248>:
.globl vector248
vector248:
  pushl $0
  10295f:	6a 00                	push   $0x0
  pushl $248
  102961:	68 f8 00 00 00       	push   $0xf8
  jmp __alltraps
  102966:	e9 54 00 00 00       	jmp    1029bf <__alltraps>

0010296b <vector249>:
.globl vector249
vector249:
  pushl $0
  10296b:	6a 00                	push   $0x0
  pushl $249
  10296d:	68 f9 00 00 00       	push   $0xf9
  jmp __alltraps
  102972:	e9 48 00 00 00       	jmp    1029bf <__alltraps>

00102977 <vector250>:
.globl vector250
vector250:
  pushl $0
  102977:	6a 00                	push   $0x0
  pushl $250
  102979:	68 fa 00 00 00       	push   $0xfa
  jmp __alltraps
  10297e:	e9 3c 00 00 00       	jmp    1029bf <__alltraps>

00102983 <vector251>:
.globl vector251
vector251:
  pushl $0
  102983:	6a 00                	push   $0x0
  pushl $251
  102985:	68 fb 00 00 00       	push   $0xfb
  jmp __alltraps
  10298a:	e9 30 00 00 00       	jmp    1029bf <__alltraps>

0010298f <vector252>:
.globl vector252
vector252:
  pushl $0
  10298f:	6a 00                	push   $0x0
  pushl $252
  102991:	68 fc 00 00 00       	push   $0xfc
  jmp __alltraps
  102996:	e9 24 00 00 00       	jmp    1029bf <__alltraps>

0010299b <vector253>:
.globl vector253
vector253:
  pushl $0
  10299b:	6a 00                	push   $0x0
  pushl $253
  10299d:	68 fd 00 00 00       	push   $0xfd
  jmp __alltraps
  1029a2:	e9 18 00 00 00       	jmp    1029bf <__alltraps>

001029a7 <vector254>:
.globl vector254
vector254:
  pushl $0
  1029a7:	6a 00                	push   $0x0
  pushl $254
  1029a9:	68 fe 00 00 00       	push   $0xfe
  jmp __alltraps
  1029ae:	e9 0c 00 00 00       	jmp    1029bf <__alltraps>

001029b3 <vector255>:
.globl vector255
vector255:
  pushl $0
  1029b3:	6a 00                	push   $0x0
  pushl $255
  1029b5:	68 ff 00 00 00       	push   $0xff
  jmp __alltraps
  1029ba:	e9 00 00 00 00       	jmp    1029bf <__alltraps>

001029bf <__alltraps>:
.text
.globl __alltraps
__alltraps:
    # push registers to build a trap frame
    # therefore make the stack look like a struct trapframe
    pushl %ds
  1029bf:	1e                   	push   %ds
    pushl %es
  1029c0:	06                   	push   %es
    pushl %fs
  1029c1:	0f a0                	push   %fs
    pushl %gs
  1029c3:	0f a8                	push   %gs
    pushal
  1029c5:	60                   	pusha  

    # load GD_KDATA into %ds and %es to set up data segments for kernel
    movl $GD_KDATA, %eax
  1029c6:	b8 10 00 00 00       	mov    $0x10,%eax
    movw %ax, %ds
  1029cb:	8e d8                	mov    %eax,%ds
    movw %ax, %es
  1029cd:	8e c0                	mov    %eax,%es

    # push %esp to pass a pointer to the trapframe as an argument to trap()
    pushl %esp
  1029cf:	54                   	push   %esp

    # call trap(tf), where tf=%esp
    call trap
  1029d0:	e8 5f f5 ff ff       	call   101f34 <trap>

    # pop the pushed stack pointer
    popl %esp
  1029d5:	5c                   	pop    %esp

001029d6 <__trapret>:

    # return falls through to trapret...
.globl __trapret
__trapret:
    # restore registers from stack
    popal
  1029d6:	61                   	popa   

    # restore %ds, %es, %fs and %gs
    popl %gs
  1029d7:	0f a9                	pop    %gs
    popl %fs
  1029d9:	0f a1                	pop    %fs
    popl %es
  1029db:	07                   	pop    %es
    popl %ds
  1029dc:	1f                   	pop    %ds

    # get rid of the trap number and error code
    addl $0x8, %esp
  1029dd:	83 c4 08             	add    $0x8,%esp
    iret
  1029e0:	cf                   	iret   

001029e1 <page2ppn>:

extern struct Page *pages;
extern size_t npage;

static inline ppn_t
page2ppn(struct Page *page) {
  1029e1:	55                   	push   %ebp
  1029e2:	89 e5                	mov    %esp,%ebp
    return page - pages;
  1029e4:	a1 58 a9 11 00       	mov    0x11a958,%eax
  1029e9:	8b 55 08             	mov    0x8(%ebp),%edx
  1029ec:	29 c2                	sub    %eax,%edx
  1029ee:	89 d0                	mov    %edx,%eax
  1029f0:	c1 f8 02             	sar    $0x2,%eax
  1029f3:	69 c0 cd cc cc cc    	imul   $0xcccccccd,%eax,%eax
}
  1029f9:	5d                   	pop    %ebp
  1029fa:	c3                   	ret    

001029fb <page2pa>:

static inline uintptr_t
page2pa(struct Page *page) {
  1029fb:	55                   	push   %ebp
  1029fc:	89 e5                	mov    %esp,%ebp
    return page2ppn(page) << PGSHIFT;
  1029fe:	ff 75 08             	pushl  0x8(%ebp)
  102a01:	e8 db ff ff ff       	call   1029e1 <page2ppn>
  102a06:	83 c4 04             	add    $0x4,%esp
  102a09:	c1 e0 0c             	shl    $0xc,%eax
}
  102a0c:	c9                   	leave  
  102a0d:	c3                   	ret    

00102a0e <pa2page>:

static inline struct Page *
pa2page(uintptr_t pa) {
  102a0e:	55                   	push   %ebp
  102a0f:	89 e5                	mov    %esp,%ebp
  102a11:	83 ec 08             	sub    $0x8,%esp
    if (PPN(pa) >= npage) {
  102a14:	8b 45 08             	mov    0x8(%ebp),%eax
  102a17:	c1 e8 0c             	shr    $0xc,%eax
  102a1a:	89 c2                	mov    %eax,%edx
  102a1c:	a1 c0 a8 11 00       	mov    0x11a8c0,%eax
  102a21:	39 c2                	cmp    %eax,%edx
  102a23:	72 14                	jb     102a39 <pa2page+0x2b>
        panic("pa2page called with invalid pa");
  102a25:	83 ec 04             	sub    $0x4,%esp
  102a28:	68 10 64 10 00       	push   $0x106410
  102a2d:	6a 5a                	push   $0x5a
  102a2f:	68 2f 64 10 00       	push   $0x10642f
  102a34:	e8 d1 d9 ff ff       	call   10040a <__panic>
    }
    return &pages[PPN(pa)];
  102a39:	8b 0d 58 a9 11 00    	mov    0x11a958,%ecx
  102a3f:	8b 45 08             	mov    0x8(%ebp),%eax
  102a42:	c1 e8 0c             	shr    $0xc,%eax
  102a45:	89 c2                	mov    %eax,%edx
  102a47:	89 d0                	mov    %edx,%eax
  102a49:	c1 e0 02             	shl    $0x2,%eax
  102a4c:	01 d0                	add    %edx,%eax
  102a4e:	c1 e0 02             	shl    $0x2,%eax
  102a51:	01 c8                	add    %ecx,%eax
}
  102a53:	c9                   	leave  
  102a54:	c3                   	ret    

00102a55 <page2kva>:

static inline void *
page2kva(struct Page *page) {
  102a55:	55                   	push   %ebp
  102a56:	89 e5                	mov    %esp,%ebp
  102a58:	83 ec 18             	sub    $0x18,%esp
    return KADDR(page2pa(page));
  102a5b:	ff 75 08             	pushl  0x8(%ebp)
  102a5e:	e8 98 ff ff ff       	call   1029fb <page2pa>
  102a63:	83 c4 04             	add    $0x4,%esp
  102a66:	89 45 f4             	mov    %eax,-0xc(%ebp)
  102a69:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102a6c:	c1 e8 0c             	shr    $0xc,%eax
  102a6f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  102a72:	a1 c0 a8 11 00       	mov    0x11a8c0,%eax
  102a77:	39 45 f0             	cmp    %eax,-0x10(%ebp)
  102a7a:	72 14                	jb     102a90 <page2kva+0x3b>
  102a7c:	ff 75 f4             	pushl  -0xc(%ebp)
  102a7f:	68 40 64 10 00       	push   $0x106440
  102a84:	6a 61                	push   $0x61
  102a86:	68 2f 64 10 00       	push   $0x10642f
  102a8b:	e8 7a d9 ff ff       	call   10040a <__panic>
  102a90:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102a93:	2d 00 00 00 40       	sub    $0x40000000,%eax
}
  102a98:	c9                   	leave  
  102a99:	c3                   	ret    

00102a9a <pte2page>:
kva2page(void *kva) {
    return pa2page(PADDR(kva));
}

static inline struct Page *
pte2page(pte_t pte) {
  102a9a:	55                   	push   %ebp
  102a9b:	89 e5                	mov    %esp,%ebp
  102a9d:	83 ec 08             	sub    $0x8,%esp
    if (!(pte & PTE_P)) {
  102aa0:	8b 45 08             	mov    0x8(%ebp),%eax
  102aa3:	83 e0 01             	and    $0x1,%eax
  102aa6:	85 c0                	test   %eax,%eax
  102aa8:	75 14                	jne    102abe <pte2page+0x24>
        panic("pte2page called with invalid pte");
  102aaa:	83 ec 04             	sub    $0x4,%esp
  102aad:	68 64 64 10 00       	push   $0x106464
  102ab2:	6a 6c                	push   $0x6c
  102ab4:	68 2f 64 10 00       	push   $0x10642f
  102ab9:	e8 4c d9 ff ff       	call   10040a <__panic>
    }
    return pa2page(PTE_ADDR(pte));
  102abe:	8b 45 08             	mov    0x8(%ebp),%eax
  102ac1:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  102ac6:	83 ec 0c             	sub    $0xc,%esp
  102ac9:	50                   	push   %eax
  102aca:	e8 3f ff ff ff       	call   102a0e <pa2page>
  102acf:	83 c4 10             	add    $0x10,%esp
}
  102ad2:	c9                   	leave  
  102ad3:	c3                   	ret    

00102ad4 <page_ref>:
pde2page(pde_t pde) {
    return pa2page(PDE_ADDR(pde));
}

static inline int
page_ref(struct Page *page) {
  102ad4:	55                   	push   %ebp
  102ad5:	89 e5                	mov    %esp,%ebp
    return page->ref;
  102ad7:	8b 45 08             	mov    0x8(%ebp),%eax
  102ada:	8b 00                	mov    (%eax),%eax
}
  102adc:	5d                   	pop    %ebp
  102add:	c3                   	ret    

00102ade <page_ref_inc>:
set_page_ref(struct Page *page, int val) {
    page->ref = val;
}

static inline int
page_ref_inc(struct Page *page) {
  102ade:	55                   	push   %ebp
  102adf:	89 e5                	mov    %esp,%ebp
    page->ref += 1;
  102ae1:	8b 45 08             	mov    0x8(%ebp),%eax
  102ae4:	8b 00                	mov    (%eax),%eax
  102ae6:	8d 50 01             	lea    0x1(%eax),%edx
  102ae9:	8b 45 08             	mov    0x8(%ebp),%eax
  102aec:	89 10                	mov    %edx,(%eax)
    return page->ref;
  102aee:	8b 45 08             	mov    0x8(%ebp),%eax
  102af1:	8b 00                	mov    (%eax),%eax
}
  102af3:	5d                   	pop    %ebp
  102af4:	c3                   	ret    

00102af5 <page_ref_dec>:

static inline int
page_ref_dec(struct Page *page) {
  102af5:	55                   	push   %ebp
  102af6:	89 e5                	mov    %esp,%ebp
    page->ref -= 1;
  102af8:	8b 45 08             	mov    0x8(%ebp),%eax
  102afb:	8b 00                	mov    (%eax),%eax
  102afd:	8d 50 ff             	lea    -0x1(%eax),%edx
  102b00:	8b 45 08             	mov    0x8(%ebp),%eax
  102b03:	89 10                	mov    %edx,(%eax)
    return page->ref;
  102b05:	8b 45 08             	mov    0x8(%ebp),%eax
  102b08:	8b 00                	mov    (%eax),%eax
}
  102b0a:	5d                   	pop    %ebp
  102b0b:	c3                   	ret    

00102b0c <__intr_save>:
__intr_save(void) {
  102b0c:	55                   	push   %ebp
  102b0d:	89 e5                	mov    %esp,%ebp
  102b0f:	83 ec 18             	sub    $0x18,%esp
    asm volatile ("pushfl; popl %0" : "=r" (eflags));
  102b12:	9c                   	pushf  
  102b13:	58                   	pop    %eax
  102b14:	89 45 f4             	mov    %eax,-0xc(%ebp)
    return eflags;
  102b17:	8b 45 f4             	mov    -0xc(%ebp),%eax
    if (read_eflags() & FL_IF) {
  102b1a:	25 00 02 00 00       	and    $0x200,%eax
  102b1f:	85 c0                	test   %eax,%eax
  102b21:	74 0c                	je     102b2f <__intr_save+0x23>
        intr_disable();
  102b23:	e8 53 ee ff ff       	call   10197b <intr_disable>
        return 1;
  102b28:	b8 01 00 00 00       	mov    $0x1,%eax
  102b2d:	eb 05                	jmp    102b34 <__intr_save+0x28>
    return 0;
  102b2f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  102b34:	c9                   	leave  
  102b35:	c3                   	ret    

00102b36 <__intr_restore>:
__intr_restore(bool flag) {
  102b36:	55                   	push   %ebp
  102b37:	89 e5                	mov    %esp,%ebp
  102b39:	83 ec 08             	sub    $0x8,%esp
    if (flag) {
  102b3c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  102b40:	74 05                	je     102b47 <__intr_restore+0x11>
        intr_enable();
  102b42:	e8 28 ee ff ff       	call   10196f <intr_enable>
}
  102b47:	90                   	nop
  102b48:	c9                   	leave  
  102b49:	c3                   	ret    

00102b4a <lgdt>:
/* *
 * lgdt - load the global descriptor table register and reset the
 * data/code segement registers for kernel.
 * */
static inline void
lgdt(struct pseudodesc *pd) {
  102b4a:	55                   	push   %ebp
  102b4b:	89 e5                	mov    %esp,%ebp
    asm volatile ("lgdt (%0)" :: "r" (pd));
  102b4d:	8b 45 08             	mov    0x8(%ebp),%eax
  102b50:	0f 01 10             	lgdtl  (%eax)
    asm volatile ("movw %%ax, %%gs" :: "a" (USER_DS));
  102b53:	b8 23 00 00 00       	mov    $0x23,%eax
  102b58:	8e e8                	mov    %eax,%gs
    asm volatile ("movw %%ax, %%fs" :: "a" (USER_DS));
  102b5a:	b8 23 00 00 00       	mov    $0x23,%eax
  102b5f:	8e e0                	mov    %eax,%fs
    asm volatile ("movw %%ax, %%es" :: "a" (KERNEL_DS));
  102b61:	b8 10 00 00 00       	mov    $0x10,%eax
  102b66:	8e c0                	mov    %eax,%es
    asm volatile ("movw %%ax, %%ds" :: "a" (KERNEL_DS));
  102b68:	b8 10 00 00 00       	mov    $0x10,%eax
  102b6d:	8e d8                	mov    %eax,%ds
    asm volatile ("movw %%ax, %%ss" :: "a" (KERNEL_DS));
  102b6f:	b8 10 00 00 00       	mov    $0x10,%eax
  102b74:	8e d0                	mov    %eax,%ss
    // reload cs
    asm volatile ("ljmp %0, $1f\n 1:\n" :: "i" (KERNEL_CS));
  102b76:	ea 7d 2b 10 00 08 00 	ljmp   $0x8,$0x102b7d
}
  102b7d:	90                   	nop
  102b7e:	5d                   	pop    %ebp
  102b7f:	c3                   	ret    

00102b80 <load_esp0>:
 * load_esp0 - change the ESP0 in default task state segment,
 * so that we can use different kernel stack when we trap frame
 * user to kernel.
 * */
void
load_esp0(uintptr_t esp0) {
  102b80:	f3 0f 1e fb          	endbr32 
  102b84:	55                   	push   %ebp
  102b85:	89 e5                	mov    %esp,%ebp
    ts.ts_esp0 = esp0;
  102b87:	8b 45 08             	mov    0x8(%ebp),%eax
  102b8a:	a3 e4 a8 11 00       	mov    %eax,0x11a8e4
}
  102b8f:	90                   	nop
  102b90:	5d                   	pop    %ebp
  102b91:	c3                   	ret    

00102b92 <gdt_init>:

/* gdt_init - initialize the default GDT and TSS */
static void
gdt_init(void) {
  102b92:	f3 0f 1e fb          	endbr32 
  102b96:	55                   	push   %ebp
  102b97:	89 e5                	mov    %esp,%ebp
  102b99:	83 ec 10             	sub    $0x10,%esp
    // set boot kernel stack and default SS0
    load_esp0((uintptr_t)bootstacktop);
  102b9c:	b8 00 90 11 00       	mov    $0x119000,%eax
  102ba1:	50                   	push   %eax
  102ba2:	e8 d9 ff ff ff       	call   102b80 <load_esp0>
  102ba7:	83 c4 04             	add    $0x4,%esp
    ts.ts_ss0 = KERNEL_DS;
  102baa:	66 c7 05 e8 a8 11 00 	movw   $0x10,0x11a8e8
  102bb1:	10 00 

    // initialize the TSS filed of the gdt
    gdt[SEG_TSS] = SEGTSS(STS_T32A, (uintptr_t)&ts, sizeof(ts), DPL_KERNEL);
  102bb3:	66 c7 05 28 9a 11 00 	movw   $0x68,0x119a28
  102bba:	68 00 
  102bbc:	b8 e0 a8 11 00       	mov    $0x11a8e0,%eax
  102bc1:	66 a3 2a 9a 11 00    	mov    %ax,0x119a2a
  102bc7:	b8 e0 a8 11 00       	mov    $0x11a8e0,%eax
  102bcc:	c1 e8 10             	shr    $0x10,%eax
  102bcf:	a2 2c 9a 11 00       	mov    %al,0x119a2c
  102bd4:	0f b6 05 2d 9a 11 00 	movzbl 0x119a2d,%eax
  102bdb:	83 e0 f0             	and    $0xfffffff0,%eax
  102bde:	83 c8 09             	or     $0x9,%eax
  102be1:	a2 2d 9a 11 00       	mov    %al,0x119a2d
  102be6:	0f b6 05 2d 9a 11 00 	movzbl 0x119a2d,%eax
  102bed:	83 e0 ef             	and    $0xffffffef,%eax
  102bf0:	a2 2d 9a 11 00       	mov    %al,0x119a2d
  102bf5:	0f b6 05 2d 9a 11 00 	movzbl 0x119a2d,%eax
  102bfc:	83 e0 9f             	and    $0xffffff9f,%eax
  102bff:	a2 2d 9a 11 00       	mov    %al,0x119a2d
  102c04:	0f b6 05 2d 9a 11 00 	movzbl 0x119a2d,%eax
  102c0b:	83 c8 80             	or     $0xffffff80,%eax
  102c0e:	a2 2d 9a 11 00       	mov    %al,0x119a2d
  102c13:	0f b6 05 2e 9a 11 00 	movzbl 0x119a2e,%eax
  102c1a:	83 e0 f0             	and    $0xfffffff0,%eax
  102c1d:	a2 2e 9a 11 00       	mov    %al,0x119a2e
  102c22:	0f b6 05 2e 9a 11 00 	movzbl 0x119a2e,%eax
  102c29:	83 e0 ef             	and    $0xffffffef,%eax
  102c2c:	a2 2e 9a 11 00       	mov    %al,0x119a2e
  102c31:	0f b6 05 2e 9a 11 00 	movzbl 0x119a2e,%eax
  102c38:	83 e0 df             	and    $0xffffffdf,%eax
  102c3b:	a2 2e 9a 11 00       	mov    %al,0x119a2e
  102c40:	0f b6 05 2e 9a 11 00 	movzbl 0x119a2e,%eax
  102c47:	83 c8 40             	or     $0x40,%eax
  102c4a:	a2 2e 9a 11 00       	mov    %al,0x119a2e
  102c4f:	0f b6 05 2e 9a 11 00 	movzbl 0x119a2e,%eax
  102c56:	83 e0 7f             	and    $0x7f,%eax
  102c59:	a2 2e 9a 11 00       	mov    %al,0x119a2e
  102c5e:	b8 e0 a8 11 00       	mov    $0x11a8e0,%eax
  102c63:	c1 e8 18             	shr    $0x18,%eax
  102c66:	a2 2f 9a 11 00       	mov    %al,0x119a2f

    // reload all segment registers
    lgdt(&gdt_pd);
  102c6b:	68 30 9a 11 00       	push   $0x119a30
  102c70:	e8 d5 fe ff ff       	call   102b4a <lgdt>
  102c75:	83 c4 04             	add    $0x4,%esp
  102c78:	66 c7 45 fe 28 00    	movw   $0x28,-0x2(%ebp)
    asm volatile ("ltr %0" :: "r" (sel) : "memory");
  102c7e:	0f b7 45 fe          	movzwl -0x2(%ebp),%eax
  102c82:	0f 00 d8             	ltr    %ax
}
  102c85:	90                   	nop

    // load the TSS
    ltr(GD_TSS);
}
  102c86:	90                   	nop
  102c87:	c9                   	leave  
  102c88:	c3                   	ret    

00102c89 <init_pmm_manager>:

//init_pmm_manager - initialize a pmm_manager instance
static void
init_pmm_manager(void) {
  102c89:	f3 0f 1e fb          	endbr32 
  102c8d:	55                   	push   %ebp
  102c8e:	89 e5                	mov    %esp,%ebp
  102c90:	83 ec 08             	sub    $0x8,%esp
    pmm_manager = &default_pmm_manager;
  102c93:	c7 05 50 a9 11 00 e8 	movl   $0x106de8,0x11a950
  102c9a:	6d 10 00 
    cprintf("memory management: %s\n", pmm_manager->name);
  102c9d:	a1 50 a9 11 00       	mov    0x11a950,%eax
  102ca2:	8b 00                	mov    (%eax),%eax
  102ca4:	83 ec 08             	sub    $0x8,%esp
  102ca7:	50                   	push   %eax
  102ca8:	68 90 64 10 00       	push   $0x106490
  102cad:	e8 dd d5 ff ff       	call   10028f <cprintf>
  102cb2:	83 c4 10             	add    $0x10,%esp
    pmm_manager->init();
  102cb5:	a1 50 a9 11 00       	mov    0x11a950,%eax
  102cba:	8b 40 04             	mov    0x4(%eax),%eax
  102cbd:	ff d0                	call   *%eax
}
  102cbf:	90                   	nop
  102cc0:	c9                   	leave  
  102cc1:	c3                   	ret    

00102cc2 <init_memmap>:

//init_memmap - call pmm->init_memmap to build Page struct for free memory  
static void
init_memmap(struct Page *base, size_t n) {
  102cc2:	f3 0f 1e fb          	endbr32 
  102cc6:	55                   	push   %ebp
  102cc7:	89 e5                	mov    %esp,%ebp
  102cc9:	83 ec 08             	sub    $0x8,%esp
    pmm_manager->init_memmap(base, n);
  102ccc:	a1 50 a9 11 00       	mov    0x11a950,%eax
  102cd1:	8b 40 08             	mov    0x8(%eax),%eax
  102cd4:	83 ec 08             	sub    $0x8,%esp
  102cd7:	ff 75 0c             	pushl  0xc(%ebp)
  102cda:	ff 75 08             	pushl  0x8(%ebp)
  102cdd:	ff d0                	call   *%eax
  102cdf:	83 c4 10             	add    $0x10,%esp
}
  102ce2:	90                   	nop
  102ce3:	c9                   	leave  
  102ce4:	c3                   	ret    

00102ce5 <alloc_pages>:

//alloc_pages - call pmm->alloc_pages to allocate a continuous n*PAGESIZE memory 
struct Page *
alloc_pages(size_t n) {
  102ce5:	f3 0f 1e fb          	endbr32 
  102ce9:	55                   	push   %ebp
  102cea:	89 e5                	mov    %esp,%ebp
  102cec:	83 ec 18             	sub    $0x18,%esp
    struct Page *page=NULL;
  102cef:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    bool intr_flag;
    local_intr_save(intr_flag);
  102cf6:	e8 11 fe ff ff       	call   102b0c <__intr_save>
  102cfb:	89 45 f0             	mov    %eax,-0x10(%ebp)
    {
        page = pmm_manager->alloc_pages(n);
  102cfe:	a1 50 a9 11 00       	mov    0x11a950,%eax
  102d03:	8b 40 0c             	mov    0xc(%eax),%eax
  102d06:	83 ec 0c             	sub    $0xc,%esp
  102d09:	ff 75 08             	pushl  0x8(%ebp)
  102d0c:	ff d0                	call   *%eax
  102d0e:	83 c4 10             	add    $0x10,%esp
  102d11:	89 45 f4             	mov    %eax,-0xc(%ebp)
    }
    local_intr_restore(intr_flag);
  102d14:	83 ec 0c             	sub    $0xc,%esp
  102d17:	ff 75 f0             	pushl  -0x10(%ebp)
  102d1a:	e8 17 fe ff ff       	call   102b36 <__intr_restore>
  102d1f:	83 c4 10             	add    $0x10,%esp
    return page;
  102d22:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  102d25:	c9                   	leave  
  102d26:	c3                   	ret    

00102d27 <free_pages>:

//free_pages - call pmm->free_pages to free a continuous n*PAGESIZE memory 
void
free_pages(struct Page *base, size_t n) {
  102d27:	f3 0f 1e fb          	endbr32 
  102d2b:	55                   	push   %ebp
  102d2c:	89 e5                	mov    %esp,%ebp
  102d2e:	83 ec 18             	sub    $0x18,%esp
    bool intr_flag;
    local_intr_save(intr_flag);
  102d31:	e8 d6 fd ff ff       	call   102b0c <__intr_save>
  102d36:	89 45 f4             	mov    %eax,-0xc(%ebp)
    {
        pmm_manager->free_pages(base, n);
  102d39:	a1 50 a9 11 00       	mov    0x11a950,%eax
  102d3e:	8b 40 10             	mov    0x10(%eax),%eax
  102d41:	83 ec 08             	sub    $0x8,%esp
  102d44:	ff 75 0c             	pushl  0xc(%ebp)
  102d47:	ff 75 08             	pushl  0x8(%ebp)
  102d4a:	ff d0                	call   *%eax
  102d4c:	83 c4 10             	add    $0x10,%esp
    }
    local_intr_restore(intr_flag);
  102d4f:	83 ec 0c             	sub    $0xc,%esp
  102d52:	ff 75 f4             	pushl  -0xc(%ebp)
  102d55:	e8 dc fd ff ff       	call   102b36 <__intr_restore>
  102d5a:	83 c4 10             	add    $0x10,%esp
}
  102d5d:	90                   	nop
  102d5e:	c9                   	leave  
  102d5f:	c3                   	ret    

00102d60 <nr_free_pages>:

//nr_free_pages - call pmm->nr_free_pages to get the size (nr*PAGESIZE) 
//of current free memory
size_t
nr_free_pages(void) {
  102d60:	f3 0f 1e fb          	endbr32 
  102d64:	55                   	push   %ebp
  102d65:	89 e5                	mov    %esp,%ebp
  102d67:	83 ec 18             	sub    $0x18,%esp
    size_t ret;
    bool intr_flag;
    local_intr_save(intr_flag);
  102d6a:	e8 9d fd ff ff       	call   102b0c <__intr_save>
  102d6f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    {
        ret = pmm_manager->nr_free_pages();
  102d72:	a1 50 a9 11 00       	mov    0x11a950,%eax
  102d77:	8b 40 14             	mov    0x14(%eax),%eax
  102d7a:	ff d0                	call   *%eax
  102d7c:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }
    local_intr_restore(intr_flag);
  102d7f:	83 ec 0c             	sub    $0xc,%esp
  102d82:	ff 75 f4             	pushl  -0xc(%ebp)
  102d85:	e8 ac fd ff ff       	call   102b36 <__intr_restore>
  102d8a:	83 c4 10             	add    $0x10,%esp
    return ret;
  102d8d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  102d90:	c9                   	leave  
  102d91:	c3                   	ret    

00102d92 <page_init>:

/* pmm_init - initialize the physical memory management */
static void
page_init(void) {
  102d92:	f3 0f 1e fb          	endbr32 
  102d96:	55                   	push   %ebp
  102d97:	89 e5                	mov    %esp,%ebp
  102d99:	57                   	push   %edi
  102d9a:	56                   	push   %esi
  102d9b:	53                   	push   %ebx
  102d9c:	83 ec 7c             	sub    $0x7c,%esp
    struct e820map *memmap = (struct e820map *)(0x8000 + KERNBASE);
  102d9f:	c7 45 c4 00 80 00 c0 	movl   $0xc0008000,-0x3c(%ebp)
    uint64_t maxpa = 0;
  102da6:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  102dad:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)

    cprintf("e820map:\n");
  102db4:	83 ec 0c             	sub    $0xc,%esp
  102db7:	68 a7 64 10 00       	push   $0x1064a7
  102dbc:	e8 ce d4 ff ff       	call   10028f <cprintf>
  102dc1:	83 c4 10             	add    $0x10,%esp
    int i;
    for (i = 0; i < memmap->nr_map; i ++) {
  102dc4:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  102dcb:	e9 f4 00 00 00       	jmp    102ec4 <page_init+0x132>
        uint64_t begin = memmap->map[i].addr, end = begin + memmap->map[i].size;
  102dd0:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
  102dd3:	8b 55 dc             	mov    -0x24(%ebp),%edx
  102dd6:	89 d0                	mov    %edx,%eax
  102dd8:	c1 e0 02             	shl    $0x2,%eax
  102ddb:	01 d0                	add    %edx,%eax
  102ddd:	c1 e0 02             	shl    $0x2,%eax
  102de0:	01 c8                	add    %ecx,%eax
  102de2:	8b 50 08             	mov    0x8(%eax),%edx
  102de5:	8b 40 04             	mov    0x4(%eax),%eax
  102de8:	89 45 a0             	mov    %eax,-0x60(%ebp)
  102deb:	89 55 a4             	mov    %edx,-0x5c(%ebp)
  102dee:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
  102df1:	8b 55 dc             	mov    -0x24(%ebp),%edx
  102df4:	89 d0                	mov    %edx,%eax
  102df6:	c1 e0 02             	shl    $0x2,%eax
  102df9:	01 d0                	add    %edx,%eax
  102dfb:	c1 e0 02             	shl    $0x2,%eax
  102dfe:	01 c8                	add    %ecx,%eax
  102e00:	8b 48 0c             	mov    0xc(%eax),%ecx
  102e03:	8b 58 10             	mov    0x10(%eax),%ebx
  102e06:	8b 45 a0             	mov    -0x60(%ebp),%eax
  102e09:	8b 55 a4             	mov    -0x5c(%ebp),%edx
  102e0c:	01 c8                	add    %ecx,%eax
  102e0e:	11 da                	adc    %ebx,%edx
  102e10:	89 45 98             	mov    %eax,-0x68(%ebp)
  102e13:	89 55 9c             	mov    %edx,-0x64(%ebp)
        cprintf("  memory: %08llx, [%08llx, %08llx], type = %d.\n",
  102e16:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
  102e19:	8b 55 dc             	mov    -0x24(%ebp),%edx
  102e1c:	89 d0                	mov    %edx,%eax
  102e1e:	c1 e0 02             	shl    $0x2,%eax
  102e21:	01 d0                	add    %edx,%eax
  102e23:	c1 e0 02             	shl    $0x2,%eax
  102e26:	01 c8                	add    %ecx,%eax
  102e28:	83 c0 14             	add    $0x14,%eax
  102e2b:	8b 00                	mov    (%eax),%eax
  102e2d:	89 45 84             	mov    %eax,-0x7c(%ebp)
  102e30:	8b 45 98             	mov    -0x68(%ebp),%eax
  102e33:	8b 55 9c             	mov    -0x64(%ebp),%edx
  102e36:	83 c0 ff             	add    $0xffffffff,%eax
  102e39:	83 d2 ff             	adc    $0xffffffff,%edx
  102e3c:	89 c1                	mov    %eax,%ecx
  102e3e:	89 d3                	mov    %edx,%ebx
  102e40:	8b 55 c4             	mov    -0x3c(%ebp),%edx
  102e43:	89 55 80             	mov    %edx,-0x80(%ebp)
  102e46:	8b 55 dc             	mov    -0x24(%ebp),%edx
  102e49:	89 d0                	mov    %edx,%eax
  102e4b:	c1 e0 02             	shl    $0x2,%eax
  102e4e:	01 d0                	add    %edx,%eax
  102e50:	c1 e0 02             	shl    $0x2,%eax
  102e53:	03 45 80             	add    -0x80(%ebp),%eax
  102e56:	8b 50 10             	mov    0x10(%eax),%edx
  102e59:	8b 40 0c             	mov    0xc(%eax),%eax
  102e5c:	ff 75 84             	pushl  -0x7c(%ebp)
  102e5f:	53                   	push   %ebx
  102e60:	51                   	push   %ecx
  102e61:	ff 75 a4             	pushl  -0x5c(%ebp)
  102e64:	ff 75 a0             	pushl  -0x60(%ebp)
  102e67:	52                   	push   %edx
  102e68:	50                   	push   %eax
  102e69:	68 b4 64 10 00       	push   $0x1064b4
  102e6e:	e8 1c d4 ff ff       	call   10028f <cprintf>
  102e73:	83 c4 20             	add    $0x20,%esp
                memmap->map[i].size, begin, end - 1, memmap->map[i].type);
        if (memmap->map[i].type == E820_ARM) {
  102e76:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
  102e79:	8b 55 dc             	mov    -0x24(%ebp),%edx
  102e7c:	89 d0                	mov    %edx,%eax
  102e7e:	c1 e0 02             	shl    $0x2,%eax
  102e81:	01 d0                	add    %edx,%eax
  102e83:	c1 e0 02             	shl    $0x2,%eax
  102e86:	01 c8                	add    %ecx,%eax
  102e88:	83 c0 14             	add    $0x14,%eax
  102e8b:	8b 00                	mov    (%eax),%eax
  102e8d:	83 f8 01             	cmp    $0x1,%eax
  102e90:	75 2e                	jne    102ec0 <page_init+0x12e>
            if (maxpa < end && begin < KMEMSIZE) {
  102e92:	8b 45 e0             	mov    -0x20(%ebp),%eax
  102e95:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  102e98:	3b 45 98             	cmp    -0x68(%ebp),%eax
  102e9b:	89 d0                	mov    %edx,%eax
  102e9d:	1b 45 9c             	sbb    -0x64(%ebp),%eax
  102ea0:	73 1e                	jae    102ec0 <page_init+0x12e>
  102ea2:	ba ff ff ff 37       	mov    $0x37ffffff,%edx
  102ea7:	b8 00 00 00 00       	mov    $0x0,%eax
  102eac:	3b 55 a0             	cmp    -0x60(%ebp),%edx
  102eaf:	1b 45 a4             	sbb    -0x5c(%ebp),%eax
  102eb2:	72 0c                	jb     102ec0 <page_init+0x12e>
                maxpa = end;
  102eb4:	8b 45 98             	mov    -0x68(%ebp),%eax
  102eb7:	8b 55 9c             	mov    -0x64(%ebp),%edx
  102eba:	89 45 e0             	mov    %eax,-0x20(%ebp)
  102ebd:	89 55 e4             	mov    %edx,-0x1c(%ebp)
    for (i = 0; i < memmap->nr_map; i ++) {
  102ec0:	83 45 dc 01          	addl   $0x1,-0x24(%ebp)
  102ec4:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  102ec7:	8b 00                	mov    (%eax),%eax
  102ec9:	39 45 dc             	cmp    %eax,-0x24(%ebp)
  102ecc:	0f 8c fe fe ff ff    	jl     102dd0 <page_init+0x3e>
            }
        }
    }
    if (maxpa > KMEMSIZE) {
  102ed2:	ba 00 00 00 38       	mov    $0x38000000,%edx
  102ed7:	b8 00 00 00 00       	mov    $0x0,%eax
  102edc:	3b 55 e0             	cmp    -0x20(%ebp),%edx
  102edf:	1b 45 e4             	sbb    -0x1c(%ebp),%eax
  102ee2:	73 0e                	jae    102ef2 <page_init+0x160>
        maxpa = KMEMSIZE;
  102ee4:	c7 45 e0 00 00 00 38 	movl   $0x38000000,-0x20(%ebp)
  102eeb:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    }

    extern char end[];

    npage = maxpa / PGSIZE;
  102ef2:	8b 45 e0             	mov    -0x20(%ebp),%eax
  102ef5:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  102ef8:	0f ac d0 0c          	shrd   $0xc,%edx,%eax
  102efc:	c1 ea 0c             	shr    $0xc,%edx
  102eff:	a3 c0 a8 11 00       	mov    %eax,0x11a8c0
    pages = (struct Page *)ROUNDUP((void *)end, PGSIZE);
  102f04:	c7 45 c0 00 10 00 00 	movl   $0x1000,-0x40(%ebp)
  102f0b:	b8 68 a9 11 00       	mov    $0x11a968,%eax
  102f10:	8d 50 ff             	lea    -0x1(%eax),%edx
  102f13:	8b 45 c0             	mov    -0x40(%ebp),%eax
  102f16:	01 d0                	add    %edx,%eax
  102f18:	89 45 bc             	mov    %eax,-0x44(%ebp)
  102f1b:	8b 45 bc             	mov    -0x44(%ebp),%eax
  102f1e:	ba 00 00 00 00       	mov    $0x0,%edx
  102f23:	f7 75 c0             	divl   -0x40(%ebp)
  102f26:	8b 45 bc             	mov    -0x44(%ebp),%eax
  102f29:	29 d0                	sub    %edx,%eax
  102f2b:	a3 58 a9 11 00       	mov    %eax,0x11a958

    for (i = 0; i < npage; i ++) {
  102f30:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  102f37:	eb 30                	jmp    102f69 <page_init+0x1d7>
        SetPageReserved(pages + i);
  102f39:	8b 0d 58 a9 11 00    	mov    0x11a958,%ecx
  102f3f:	8b 55 dc             	mov    -0x24(%ebp),%edx
  102f42:	89 d0                	mov    %edx,%eax
  102f44:	c1 e0 02             	shl    $0x2,%eax
  102f47:	01 d0                	add    %edx,%eax
  102f49:	c1 e0 02             	shl    $0x2,%eax
  102f4c:	01 c8                	add    %ecx,%eax
  102f4e:	83 c0 04             	add    $0x4,%eax
  102f51:	c7 45 94 00 00 00 00 	movl   $0x0,-0x6c(%ebp)
  102f58:	89 45 90             	mov    %eax,-0x70(%ebp)
 * Note that @nr may be almost arbitrarily large; this function is not
 * restricted to acting on a single-word quantity.
 * */
static inline void
set_bit(int nr, volatile void *addr) {
    asm volatile ("btsl %1, %0" :"=m" (*(volatile long *)addr) : "Ir" (nr));
  102f5b:	8b 45 90             	mov    -0x70(%ebp),%eax
  102f5e:	8b 55 94             	mov    -0x6c(%ebp),%edx
  102f61:	0f ab 10             	bts    %edx,(%eax)
}
  102f64:	90                   	nop
    for (i = 0; i < npage; i ++) {
  102f65:	83 45 dc 01          	addl   $0x1,-0x24(%ebp)
  102f69:	8b 55 dc             	mov    -0x24(%ebp),%edx
  102f6c:	a1 c0 a8 11 00       	mov    0x11a8c0,%eax
  102f71:	39 c2                	cmp    %eax,%edx
  102f73:	72 c4                	jb     102f39 <page_init+0x1a7>
    }

    uintptr_t freemem = PADDR((uintptr_t)pages + sizeof(struct Page) * npage);
  102f75:	8b 15 c0 a8 11 00    	mov    0x11a8c0,%edx
  102f7b:	89 d0                	mov    %edx,%eax
  102f7d:	c1 e0 02             	shl    $0x2,%eax
  102f80:	01 d0                	add    %edx,%eax
  102f82:	c1 e0 02             	shl    $0x2,%eax
  102f85:	89 c2                	mov    %eax,%edx
  102f87:	a1 58 a9 11 00       	mov    0x11a958,%eax
  102f8c:	01 d0                	add    %edx,%eax
  102f8e:	89 45 b8             	mov    %eax,-0x48(%ebp)
  102f91:	81 7d b8 ff ff ff bf 	cmpl   $0xbfffffff,-0x48(%ebp)
  102f98:	77 17                	ja     102fb1 <page_init+0x21f>
  102f9a:	ff 75 b8             	pushl  -0x48(%ebp)
  102f9d:	68 e4 64 10 00       	push   $0x1064e4
  102fa2:	68 db 00 00 00       	push   $0xdb
  102fa7:	68 08 65 10 00       	push   $0x106508
  102fac:	e8 59 d4 ff ff       	call   10040a <__panic>
  102fb1:	8b 45 b8             	mov    -0x48(%ebp),%eax
  102fb4:	05 00 00 00 40       	add    $0x40000000,%eax
  102fb9:	89 45 b4             	mov    %eax,-0x4c(%ebp)

    for (i = 0; i < memmap->nr_map; i ++) {
  102fbc:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  102fc3:	e9 53 01 00 00       	jmp    10311b <page_init+0x389>
        uint64_t begin = memmap->map[i].addr, end = begin + memmap->map[i].size;
  102fc8:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
  102fcb:	8b 55 dc             	mov    -0x24(%ebp),%edx
  102fce:	89 d0                	mov    %edx,%eax
  102fd0:	c1 e0 02             	shl    $0x2,%eax
  102fd3:	01 d0                	add    %edx,%eax
  102fd5:	c1 e0 02             	shl    $0x2,%eax
  102fd8:	01 c8                	add    %ecx,%eax
  102fda:	8b 50 08             	mov    0x8(%eax),%edx
  102fdd:	8b 40 04             	mov    0x4(%eax),%eax
  102fe0:	89 45 d0             	mov    %eax,-0x30(%ebp)
  102fe3:	89 55 d4             	mov    %edx,-0x2c(%ebp)
  102fe6:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
  102fe9:	8b 55 dc             	mov    -0x24(%ebp),%edx
  102fec:	89 d0                	mov    %edx,%eax
  102fee:	c1 e0 02             	shl    $0x2,%eax
  102ff1:	01 d0                	add    %edx,%eax
  102ff3:	c1 e0 02             	shl    $0x2,%eax
  102ff6:	01 c8                	add    %ecx,%eax
  102ff8:	8b 48 0c             	mov    0xc(%eax),%ecx
  102ffb:	8b 58 10             	mov    0x10(%eax),%ebx
  102ffe:	8b 45 d0             	mov    -0x30(%ebp),%eax
  103001:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  103004:	01 c8                	add    %ecx,%eax
  103006:	11 da                	adc    %ebx,%edx
  103008:	89 45 c8             	mov    %eax,-0x38(%ebp)
  10300b:	89 55 cc             	mov    %edx,-0x34(%ebp)
        if (memmap->map[i].type == E820_ARM) {
  10300e:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
  103011:	8b 55 dc             	mov    -0x24(%ebp),%edx
  103014:	89 d0                	mov    %edx,%eax
  103016:	c1 e0 02             	shl    $0x2,%eax
  103019:	01 d0                	add    %edx,%eax
  10301b:	c1 e0 02             	shl    $0x2,%eax
  10301e:	01 c8                	add    %ecx,%eax
  103020:	83 c0 14             	add    $0x14,%eax
  103023:	8b 00                	mov    (%eax),%eax
  103025:	83 f8 01             	cmp    $0x1,%eax
  103028:	0f 85 e9 00 00 00    	jne    103117 <page_init+0x385>
            if (begin < freemem) {
  10302e:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  103031:	ba 00 00 00 00       	mov    $0x0,%edx
  103036:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
  103039:	39 45 d0             	cmp    %eax,-0x30(%ebp)
  10303c:	19 d1                	sbb    %edx,%ecx
  10303e:	73 0d                	jae    10304d <page_init+0x2bb>
                begin = freemem;
  103040:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  103043:	89 45 d0             	mov    %eax,-0x30(%ebp)
  103046:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
            }
            if (end > KMEMSIZE) {
  10304d:	ba 00 00 00 38       	mov    $0x38000000,%edx
  103052:	b8 00 00 00 00       	mov    $0x0,%eax
  103057:	3b 55 c8             	cmp    -0x38(%ebp),%edx
  10305a:	1b 45 cc             	sbb    -0x34(%ebp),%eax
  10305d:	73 0e                	jae    10306d <page_init+0x2db>
                end = KMEMSIZE;
  10305f:	c7 45 c8 00 00 00 38 	movl   $0x38000000,-0x38(%ebp)
  103066:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
            }
            if (begin < end) {
  10306d:	8b 45 d0             	mov    -0x30(%ebp),%eax
  103070:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  103073:	3b 45 c8             	cmp    -0x38(%ebp),%eax
  103076:	89 d0                	mov    %edx,%eax
  103078:	1b 45 cc             	sbb    -0x34(%ebp),%eax
  10307b:	0f 83 96 00 00 00    	jae    103117 <page_init+0x385>
                begin = ROUNDUP(begin, PGSIZE);
  103081:	c7 45 b0 00 10 00 00 	movl   $0x1000,-0x50(%ebp)
  103088:	8b 55 d0             	mov    -0x30(%ebp),%edx
  10308b:	8b 45 b0             	mov    -0x50(%ebp),%eax
  10308e:	01 d0                	add    %edx,%eax
  103090:	83 e8 01             	sub    $0x1,%eax
  103093:	89 45 ac             	mov    %eax,-0x54(%ebp)
  103096:	8b 45 ac             	mov    -0x54(%ebp),%eax
  103099:	ba 00 00 00 00       	mov    $0x0,%edx
  10309e:	f7 75 b0             	divl   -0x50(%ebp)
  1030a1:	8b 45 ac             	mov    -0x54(%ebp),%eax
  1030a4:	29 d0                	sub    %edx,%eax
  1030a6:	ba 00 00 00 00       	mov    $0x0,%edx
  1030ab:	89 45 d0             	mov    %eax,-0x30(%ebp)
  1030ae:	89 55 d4             	mov    %edx,-0x2c(%ebp)
                end = ROUNDDOWN(end, PGSIZE);
  1030b1:	8b 45 c8             	mov    -0x38(%ebp),%eax
  1030b4:	89 45 a8             	mov    %eax,-0x58(%ebp)
  1030b7:	8b 45 a8             	mov    -0x58(%ebp),%eax
  1030ba:	ba 00 00 00 00       	mov    $0x0,%edx
  1030bf:	89 c3                	mov    %eax,%ebx
  1030c1:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  1030c7:	89 de                	mov    %ebx,%esi
  1030c9:	89 d0                	mov    %edx,%eax
  1030cb:	83 e0 00             	and    $0x0,%eax
  1030ce:	89 c7                	mov    %eax,%edi
  1030d0:	89 75 c8             	mov    %esi,-0x38(%ebp)
  1030d3:	89 7d cc             	mov    %edi,-0x34(%ebp)
                if (begin < end) {
  1030d6:	8b 45 d0             	mov    -0x30(%ebp),%eax
  1030d9:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  1030dc:	3b 45 c8             	cmp    -0x38(%ebp),%eax
  1030df:	89 d0                	mov    %edx,%eax
  1030e1:	1b 45 cc             	sbb    -0x34(%ebp),%eax
  1030e4:	73 31                	jae    103117 <page_init+0x385>
                    init_memmap(pa2page(begin), (end - begin) / PGSIZE);
  1030e6:	8b 45 c8             	mov    -0x38(%ebp),%eax
  1030e9:	8b 55 cc             	mov    -0x34(%ebp),%edx
  1030ec:	2b 45 d0             	sub    -0x30(%ebp),%eax
  1030ef:	1b 55 d4             	sbb    -0x2c(%ebp),%edx
  1030f2:	0f ac d0 0c          	shrd   $0xc,%edx,%eax
  1030f6:	c1 ea 0c             	shr    $0xc,%edx
  1030f9:	89 c3                	mov    %eax,%ebx
  1030fb:	8b 45 d0             	mov    -0x30(%ebp),%eax
  1030fe:	83 ec 0c             	sub    $0xc,%esp
  103101:	50                   	push   %eax
  103102:	e8 07 f9 ff ff       	call   102a0e <pa2page>
  103107:	83 c4 10             	add    $0x10,%esp
  10310a:	83 ec 08             	sub    $0x8,%esp
  10310d:	53                   	push   %ebx
  10310e:	50                   	push   %eax
  10310f:	e8 ae fb ff ff       	call   102cc2 <init_memmap>
  103114:	83 c4 10             	add    $0x10,%esp
    for (i = 0; i < memmap->nr_map; i ++) {
  103117:	83 45 dc 01          	addl   $0x1,-0x24(%ebp)
  10311b:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  10311e:	8b 00                	mov    (%eax),%eax
  103120:	39 45 dc             	cmp    %eax,-0x24(%ebp)
  103123:	0f 8c 9f fe ff ff    	jl     102fc8 <page_init+0x236>
                }
            }
        }
    }
}
  103129:	90                   	nop
  10312a:	90                   	nop
  10312b:	8d 65 f4             	lea    -0xc(%ebp),%esp
  10312e:	5b                   	pop    %ebx
  10312f:	5e                   	pop    %esi
  103130:	5f                   	pop    %edi
  103131:	5d                   	pop    %ebp
  103132:	c3                   	ret    

00103133 <enable_paging>:

static void
enable_paging(void) {
  103133:	f3 0f 1e fb          	endbr32 
  103137:	55                   	push   %ebp
  103138:	89 e5                	mov    %esp,%ebp
  10313a:	83 ec 10             	sub    $0x10,%esp
    lcr3(boot_cr3);
  10313d:	a1 54 a9 11 00       	mov    0x11a954,%eax
  103142:	89 45 f0             	mov    %eax,-0x10(%ebp)
    asm volatile ("mov %0, %%cr0" :: "r" (cr0) : "memory");
}

static inline void
lcr3(uintptr_t cr3) {
    asm volatile ("mov %0, %%cr3" :: "r" (cr3) : "memory");
  103145:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103148:	0f 22 d8             	mov    %eax,%cr3
}
  10314b:	90                   	nop

static inline uintptr_t
rcr0(void) {
    uintptr_t cr0;
    asm volatile ("mov %%cr0, %0" : "=r" (cr0) :: "memory");
  10314c:	0f 20 c0             	mov    %cr0,%eax
  10314f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    return cr0;
  103152:	8b 45 f4             	mov    -0xc(%ebp),%eax

    // turn on paging
    uint32_t cr0 = rcr0();
  103155:	89 45 fc             	mov    %eax,-0x4(%ebp)
    cr0 |= CR0_PE | CR0_PG | CR0_AM | CR0_WP | CR0_NE | CR0_TS | CR0_EM | CR0_MP;
  103158:	81 4d fc 2f 00 05 80 	orl    $0x8005002f,-0x4(%ebp)
    cr0 &= ~(CR0_TS | CR0_EM);
  10315f:	83 65 fc f3          	andl   $0xfffffff3,-0x4(%ebp)
  103163:	8b 45 fc             	mov    -0x4(%ebp),%eax
  103166:	89 45 f8             	mov    %eax,-0x8(%ebp)
    asm volatile ("mov %0, %%cr0" :: "r" (cr0) : "memory");
  103169:	8b 45 f8             	mov    -0x8(%ebp),%eax
  10316c:	0f 22 c0             	mov    %eax,%cr0
}
  10316f:	90                   	nop
    lcr0(cr0);
}
  103170:	90                   	nop
  103171:	c9                   	leave  
  103172:	c3                   	ret    

00103173 <boot_map_segment>:
//  la:   linear address of this memory need to map (after x86 segment map)
//  size: memory size
//  pa:   physical address of this memory
//  perm: permission of this memory  
static void
boot_map_segment(pde_t *pgdir, uintptr_t la, size_t size, uintptr_t pa, uint32_t perm) {
  103173:	f3 0f 1e fb          	endbr32 
  103177:	55                   	push   %ebp
  103178:	89 e5                	mov    %esp,%ebp
  10317a:	83 ec 28             	sub    $0x28,%esp
    assert(PGOFF(la) == PGOFF(pa));
  10317d:	8b 45 0c             	mov    0xc(%ebp),%eax
  103180:	33 45 14             	xor    0x14(%ebp),%eax
  103183:	25 ff 0f 00 00       	and    $0xfff,%eax
  103188:	85 c0                	test   %eax,%eax
  10318a:	74 19                	je     1031a5 <boot_map_segment+0x32>
  10318c:	68 16 65 10 00       	push   $0x106516
  103191:	68 2d 65 10 00       	push   $0x10652d
  103196:	68 04 01 00 00       	push   $0x104
  10319b:	68 08 65 10 00       	push   $0x106508
  1031a0:	e8 65 d2 ff ff       	call   10040a <__panic>
    size_t n = ROUNDUP(size + PGOFF(la), PGSIZE) / PGSIZE;
  1031a5:	c7 45 f0 00 10 00 00 	movl   $0x1000,-0x10(%ebp)
  1031ac:	8b 45 0c             	mov    0xc(%ebp),%eax
  1031af:	25 ff 0f 00 00       	and    $0xfff,%eax
  1031b4:	89 c2                	mov    %eax,%edx
  1031b6:	8b 45 10             	mov    0x10(%ebp),%eax
  1031b9:	01 c2                	add    %eax,%edx
  1031bb:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1031be:	01 d0                	add    %edx,%eax
  1031c0:	83 e8 01             	sub    $0x1,%eax
  1031c3:	89 45 ec             	mov    %eax,-0x14(%ebp)
  1031c6:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1031c9:	ba 00 00 00 00       	mov    $0x0,%edx
  1031ce:	f7 75 f0             	divl   -0x10(%ebp)
  1031d1:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1031d4:	29 d0                	sub    %edx,%eax
  1031d6:	c1 e8 0c             	shr    $0xc,%eax
  1031d9:	89 45 f4             	mov    %eax,-0xc(%ebp)
    la = ROUNDDOWN(la, PGSIZE);
  1031dc:	8b 45 0c             	mov    0xc(%ebp),%eax
  1031df:	89 45 e8             	mov    %eax,-0x18(%ebp)
  1031e2:	8b 45 e8             	mov    -0x18(%ebp),%eax
  1031e5:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  1031ea:	89 45 0c             	mov    %eax,0xc(%ebp)
    pa = ROUNDDOWN(pa, PGSIZE);
  1031ed:	8b 45 14             	mov    0x14(%ebp),%eax
  1031f0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  1031f3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1031f6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  1031fb:	89 45 14             	mov    %eax,0x14(%ebp)
    for (; n > 0; n --, la += PGSIZE, pa += PGSIZE) {
  1031fe:	eb 57                	jmp    103257 <boot_map_segment+0xe4>
        pte_t *ptep = get_pte(pgdir, la, 1);
  103200:	83 ec 04             	sub    $0x4,%esp
  103203:	6a 01                	push   $0x1
  103205:	ff 75 0c             	pushl  0xc(%ebp)
  103208:	ff 75 08             	pushl  0x8(%ebp)
  10320b:	e8 a1 01 00 00       	call   1033b1 <get_pte>
  103210:	83 c4 10             	add    $0x10,%esp
  103213:	89 45 e0             	mov    %eax,-0x20(%ebp)
        assert(ptep != NULL);
  103216:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  10321a:	75 19                	jne    103235 <boot_map_segment+0xc2>
  10321c:	68 42 65 10 00       	push   $0x106542
  103221:	68 2d 65 10 00       	push   $0x10652d
  103226:	68 0a 01 00 00       	push   $0x10a
  10322b:	68 08 65 10 00       	push   $0x106508
  103230:	e8 d5 d1 ff ff       	call   10040a <__panic>
        *ptep = pa | PTE_P | perm;
  103235:	8b 45 14             	mov    0x14(%ebp),%eax
  103238:	0b 45 18             	or     0x18(%ebp),%eax
  10323b:	83 c8 01             	or     $0x1,%eax
  10323e:	89 c2                	mov    %eax,%edx
  103240:	8b 45 e0             	mov    -0x20(%ebp),%eax
  103243:	89 10                	mov    %edx,(%eax)
    for (; n > 0; n --, la += PGSIZE, pa += PGSIZE) {
  103245:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
  103249:	81 45 0c 00 10 00 00 	addl   $0x1000,0xc(%ebp)
  103250:	81 45 14 00 10 00 00 	addl   $0x1000,0x14(%ebp)
  103257:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  10325b:	75 a3                	jne    103200 <boot_map_segment+0x8d>
    }
}
  10325d:	90                   	nop
  10325e:	90                   	nop
  10325f:	c9                   	leave  
  103260:	c3                   	ret    

00103261 <boot_alloc_page>:

//boot_alloc_page - allocate one page using pmm->alloc_pages(1) 
// return value: the kernel virtual address of this allocated page
//note: this function is used to get the memory for PDT(Page Directory Table)&PT(Page Table)
static void *
boot_alloc_page(void) {
  103261:	f3 0f 1e fb          	endbr32 
  103265:	55                   	push   %ebp
  103266:	89 e5                	mov    %esp,%ebp
  103268:	83 ec 18             	sub    $0x18,%esp
    struct Page *p = alloc_page();
  10326b:	83 ec 0c             	sub    $0xc,%esp
  10326e:	6a 01                	push   $0x1
  103270:	e8 70 fa ff ff       	call   102ce5 <alloc_pages>
  103275:	83 c4 10             	add    $0x10,%esp
  103278:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (p == NULL) {
  10327b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  10327f:	75 17                	jne    103298 <boot_alloc_page+0x37>
        panic("boot_alloc_page failed.\n");
  103281:	83 ec 04             	sub    $0x4,%esp
  103284:	68 4f 65 10 00       	push   $0x10654f
  103289:	68 16 01 00 00       	push   $0x116
  10328e:	68 08 65 10 00       	push   $0x106508
  103293:	e8 72 d1 ff ff       	call   10040a <__panic>
    }
    return page2kva(p);
  103298:	83 ec 0c             	sub    $0xc,%esp
  10329b:	ff 75 f4             	pushl  -0xc(%ebp)
  10329e:	e8 b2 f7 ff ff       	call   102a55 <page2kva>
  1032a3:	83 c4 10             	add    $0x10,%esp
}
  1032a6:	c9                   	leave  
  1032a7:	c3                   	ret    

001032a8 <pmm_init>:

//pmm_init - setup a pmm to manage physical memory, build PDT&PT to setup paging mechanism 
//         - check the correctness of pmm & paging mechanism, print PDT&PT
void
pmm_init(void) {
  1032a8:	f3 0f 1e fb          	endbr32 
  1032ac:	55                   	push   %ebp
  1032ad:	89 e5                	mov    %esp,%ebp
  1032af:	83 ec 18             	sub    $0x18,%esp
    //We need to alloc/free the physical memory (granularity is 4KB or other size). 
    //So a framework of physical memory manager (struct pmm_manager)is defined in pmm.h
    //First we should init a physical memory manager(pmm) based on the framework.
    //Then pmm can alloc/free the physical memory. 
    //Now the first_fit/best_fit/worst_fit/buddy_system pmm are available.
    init_pmm_manager();
  1032b2:	e8 d2 f9 ff ff       	call   102c89 <init_pmm_manager>

    // detect physical memory space, reserve already used memory,
    // then use pmm->init_memmap to create free page list
    page_init();
  1032b7:	e8 d6 fa ff ff       	call   102d92 <page_init>

    //use pmm->check to verify the correctness of the alloc/free function in a pmm
    check_alloc_page();
  1032bc:	e8 9a 02 00 00       	call   10355b <check_alloc_page>

    // create boot_pgdir, an initial page directory(Page Directory Table, PDT)
    boot_pgdir = boot_alloc_page();
  1032c1:	e8 9b ff ff ff       	call   103261 <boot_alloc_page>
  1032c6:	a3 c4 a8 11 00       	mov    %eax,0x11a8c4
    memset(boot_pgdir, 0, PGSIZE);
  1032cb:	a1 c4 a8 11 00       	mov    0x11a8c4,%eax
  1032d0:	83 ec 04             	sub    $0x4,%esp
  1032d3:	68 00 10 00 00       	push   $0x1000
  1032d8:	6a 00                	push   $0x0
  1032da:	50                   	push   %eax
  1032db:	e8 58 22 00 00       	call   105538 <memset>
  1032e0:	83 c4 10             	add    $0x10,%esp
    boot_cr3 = PADDR(boot_pgdir);
  1032e3:	a1 c4 a8 11 00       	mov    0x11a8c4,%eax
  1032e8:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1032eb:	81 7d f4 ff ff ff bf 	cmpl   $0xbfffffff,-0xc(%ebp)
  1032f2:	77 17                	ja     10330b <pmm_init+0x63>
  1032f4:	ff 75 f4             	pushl  -0xc(%ebp)
  1032f7:	68 e4 64 10 00       	push   $0x1064e4
  1032fc:	68 30 01 00 00       	push   $0x130
  103301:	68 08 65 10 00       	push   $0x106508
  103306:	e8 ff d0 ff ff       	call   10040a <__panic>
  10330b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10330e:	05 00 00 00 40       	add    $0x40000000,%eax
  103313:	a3 54 a9 11 00       	mov    %eax,0x11a954

    check_pgdir();
  103318:	e8 65 02 00 00       	call   103582 <check_pgdir>

    static_assert(KERNBASE % PTSIZE == 0 && KERNTOP % PTSIZE == 0);

    // recursively insert boot_pgdir in itself
    // to form a virtual page table at virtual address VPT
    boot_pgdir[PDX(VPT)] = PADDR(boot_pgdir) | PTE_P | PTE_W;
  10331d:	a1 c4 a8 11 00       	mov    0x11a8c4,%eax
  103322:	89 45 f0             	mov    %eax,-0x10(%ebp)
  103325:	81 7d f0 ff ff ff bf 	cmpl   $0xbfffffff,-0x10(%ebp)
  10332c:	77 17                	ja     103345 <pmm_init+0x9d>
  10332e:	ff 75 f0             	pushl  -0x10(%ebp)
  103331:	68 e4 64 10 00       	push   $0x1064e4
  103336:	68 38 01 00 00       	push   $0x138
  10333b:	68 08 65 10 00       	push   $0x106508
  103340:	e8 c5 d0 ff ff       	call   10040a <__panic>
  103345:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103348:	8d 90 00 00 00 40    	lea    0x40000000(%eax),%edx
  10334e:	a1 c4 a8 11 00       	mov    0x11a8c4,%eax
  103353:	05 ac 0f 00 00       	add    $0xfac,%eax
  103358:	83 ca 03             	or     $0x3,%edx
  10335b:	89 10                	mov    %edx,(%eax)

    // map all physical memory to linear memory with base linear addr KERNBASE
    //linear_addr KERNBASE~KERNBASE+KMEMSIZE = phy_addr 0~KMEMSIZE
    //But shouldn't use this map until enable_paging() & gdt_init() finished.
    boot_map_segment(boot_pgdir, KERNBASE, KMEMSIZE, 0, PTE_W);
  10335d:	a1 c4 a8 11 00       	mov    0x11a8c4,%eax
  103362:	83 ec 0c             	sub    $0xc,%esp
  103365:	6a 02                	push   $0x2
  103367:	6a 00                	push   $0x0
  103369:	68 00 00 00 38       	push   $0x38000000
  10336e:	68 00 00 00 c0       	push   $0xc0000000
  103373:	50                   	push   %eax
  103374:	e8 fa fd ff ff       	call   103173 <boot_map_segment>
  103379:	83 c4 20             	add    $0x20,%esp

    //temporary map: 
    //virtual_addr 3G~3G+4M = linear_addr 0~4M = linear_addr 3G~3G+4M = phy_addr 0~4M     
    boot_pgdir[0] = boot_pgdir[PDX(KERNBASE)];
  10337c:	8b 15 c4 a8 11 00    	mov    0x11a8c4,%edx
  103382:	a1 c4 a8 11 00       	mov    0x11a8c4,%eax
  103387:	8b 92 00 0c 00 00    	mov    0xc00(%edx),%edx
  10338d:	89 10                	mov    %edx,(%eax)

    enable_paging();
  10338f:	e8 9f fd ff ff       	call   103133 <enable_paging>

    //reload gdt(third time,the last time) to map all physical memory
    //virtual_addr 0~4G=liear_addr 0~4G
    //then set kernel stack(ss:esp) in TSS, setup TSS in gdt, load TSS
    gdt_init();
  103394:	e8 f9 f7 ff ff       	call   102b92 <gdt_init>

    //disable the map of virtual_addr 0~4M
    boot_pgdir[0] = 0;
  103399:	a1 c4 a8 11 00       	mov    0x11a8c4,%eax
  10339e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

    //now the basic virtual memory map(see memalyout.h) is established.
    //check the correctness of the basic virtual memory map.
    check_boot_pgdir();
  1033a4:	e8 43 07 00 00       	call   103aec <check_boot_pgdir>

    print_pgdir();
  1033a9:	e8 4a 0b 00 00       	call   103ef8 <print_pgdir>

}
  1033ae:	90                   	nop
  1033af:	c9                   	leave  
  1033b0:	c3                   	ret    

001033b1 <get_pte>:
//  pgdir:  the kernel virtual base address of PDT
//  la:     the linear address need to map
//  create: a logical value to decide if alloc a page for PT
// return vaule: the kernel virtual address of this pte
pte_t *
get_pte(pde_t *pgdir, uintptr_t la, bool create) {
  1033b1:	f3 0f 1e fb          	endbr32 
  1033b5:	55                   	push   %ebp
  1033b6:	89 e5                	mov    %esp,%ebp
                          // (6) clear page content using memset
                          // (7) set page directory entry's permission
    }
    return NULL;          // (8) return page table entry
#endif
}
  1033b8:	90                   	nop
  1033b9:	5d                   	pop    %ebp
  1033ba:	c3                   	ret    

001033bb <get_page>:

//get_page - get related Page struct for linear address la using PDT pgdir
struct Page *
get_page(pde_t *pgdir, uintptr_t la, pte_t **ptep_store) {
  1033bb:	f3 0f 1e fb          	endbr32 
  1033bf:	55                   	push   %ebp
  1033c0:	89 e5                	mov    %esp,%ebp
  1033c2:	83 ec 18             	sub    $0x18,%esp
    pte_t *ptep = get_pte(pgdir, la, 0);
  1033c5:	6a 00                	push   $0x0
  1033c7:	ff 75 0c             	pushl  0xc(%ebp)
  1033ca:	ff 75 08             	pushl  0x8(%ebp)
  1033cd:	e8 df ff ff ff       	call   1033b1 <get_pte>
  1033d2:	83 c4 0c             	add    $0xc,%esp
  1033d5:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (ptep_store != NULL) {
  1033d8:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  1033dc:	74 08                	je     1033e6 <get_page+0x2b>
        *ptep_store = ptep;
  1033de:	8b 45 10             	mov    0x10(%ebp),%eax
  1033e1:	8b 55 f4             	mov    -0xc(%ebp),%edx
  1033e4:	89 10                	mov    %edx,(%eax)
    }
    if (ptep != NULL && *ptep & PTE_P) {
  1033e6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  1033ea:	74 1f                	je     10340b <get_page+0x50>
  1033ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1033ef:	8b 00                	mov    (%eax),%eax
  1033f1:	83 e0 01             	and    $0x1,%eax
  1033f4:	85 c0                	test   %eax,%eax
  1033f6:	74 13                	je     10340b <get_page+0x50>
        return pa2page(*ptep);
  1033f8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1033fb:	8b 00                	mov    (%eax),%eax
  1033fd:	83 ec 0c             	sub    $0xc,%esp
  103400:	50                   	push   %eax
  103401:	e8 08 f6 ff ff       	call   102a0e <pa2page>
  103406:	83 c4 10             	add    $0x10,%esp
  103409:	eb 05                	jmp    103410 <get_page+0x55>
    }
    return NULL;
  10340b:	b8 00 00 00 00       	mov    $0x0,%eax
}
  103410:	c9                   	leave  
  103411:	c3                   	ret    

00103412 <page_remove_pte>:

//page_remove_pte - free an Page sturct which is related linear address la
//                - and clean(invalidate) pte which is related linear address la
//note: PT is changed, so the TLB need to be invalidate 
static inline void
page_remove_pte(pde_t *pgdir, uintptr_t la, pte_t *ptep) {
  103412:	55                   	push   %ebp
  103413:	89 e5                	mov    %esp,%ebp
                                  //(4) and free this page when page reference reachs 0
                                  //(5) clear second page table entry
                                  //(6) flush tlb
    }
#endif
}
  103415:	90                   	nop
  103416:	5d                   	pop    %ebp
  103417:	c3                   	ret    

00103418 <page_remove>:

//page_remove - free an Page which is related linear address la and has an validated pte
void
page_remove(pde_t *pgdir, uintptr_t la) {
  103418:	f3 0f 1e fb          	endbr32 
  10341c:	55                   	push   %ebp
  10341d:	89 e5                	mov    %esp,%ebp
  10341f:	83 ec 10             	sub    $0x10,%esp
    pte_t *ptep = get_pte(pgdir, la, 0);
  103422:	6a 00                	push   $0x0
  103424:	ff 75 0c             	pushl  0xc(%ebp)
  103427:	ff 75 08             	pushl  0x8(%ebp)
  10342a:	e8 82 ff ff ff       	call   1033b1 <get_pte>
  10342f:	83 c4 0c             	add    $0xc,%esp
  103432:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (ptep != NULL) {
  103435:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  103439:	74 11                	je     10344c <page_remove+0x34>
        page_remove_pte(pgdir, la, ptep);
  10343b:	ff 75 fc             	pushl  -0x4(%ebp)
  10343e:	ff 75 0c             	pushl  0xc(%ebp)
  103441:	ff 75 08             	pushl  0x8(%ebp)
  103444:	e8 c9 ff ff ff       	call   103412 <page_remove_pte>
  103449:	83 c4 0c             	add    $0xc,%esp
    }
}
  10344c:	90                   	nop
  10344d:	c9                   	leave  
  10344e:	c3                   	ret    

0010344f <page_insert>:
//  la:    the linear address need to map
//  perm:  the permission of this Page which is setted in related pte
// return value: always 0
//note: PT is changed, so the TLB need to be invalidate 
int
page_insert(pde_t *pgdir, struct Page *page, uintptr_t la, uint32_t perm) {
  10344f:	f3 0f 1e fb          	endbr32 
  103453:	55                   	push   %ebp
  103454:	89 e5                	mov    %esp,%ebp
  103456:	83 ec 18             	sub    $0x18,%esp
    pte_t *ptep = get_pte(pgdir, la, 1);
  103459:	6a 01                	push   $0x1
  10345b:	ff 75 10             	pushl  0x10(%ebp)
  10345e:	ff 75 08             	pushl  0x8(%ebp)
  103461:	e8 4b ff ff ff       	call   1033b1 <get_pte>
  103466:	83 c4 0c             	add    $0xc,%esp
  103469:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (ptep == NULL) {
  10346c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  103470:	75 0a                	jne    10347c <page_insert+0x2d>
        return -E_NO_MEM;
  103472:	b8 fc ff ff ff       	mov    $0xfffffffc,%eax
  103477:	e9 88 00 00 00       	jmp    103504 <page_insert+0xb5>
    }
    page_ref_inc(page);
  10347c:	ff 75 0c             	pushl  0xc(%ebp)
  10347f:	e8 5a f6 ff ff       	call   102ade <page_ref_inc>
  103484:	83 c4 04             	add    $0x4,%esp
    if (*ptep & PTE_P) {
  103487:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10348a:	8b 00                	mov    (%eax),%eax
  10348c:	83 e0 01             	and    $0x1,%eax
  10348f:	85 c0                	test   %eax,%eax
  103491:	74 40                	je     1034d3 <page_insert+0x84>
        struct Page *p = pte2page(*ptep);
  103493:	8b 45 f4             	mov    -0xc(%ebp),%eax
  103496:	8b 00                	mov    (%eax),%eax
  103498:	83 ec 0c             	sub    $0xc,%esp
  10349b:	50                   	push   %eax
  10349c:	e8 f9 f5 ff ff       	call   102a9a <pte2page>
  1034a1:	83 c4 10             	add    $0x10,%esp
  1034a4:	89 45 f0             	mov    %eax,-0x10(%ebp)
        if (p == page) {
  1034a7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1034aa:	3b 45 0c             	cmp    0xc(%ebp),%eax
  1034ad:	75 10                	jne    1034bf <page_insert+0x70>
            page_ref_dec(page);
  1034af:	83 ec 0c             	sub    $0xc,%esp
  1034b2:	ff 75 0c             	pushl  0xc(%ebp)
  1034b5:	e8 3b f6 ff ff       	call   102af5 <page_ref_dec>
  1034ba:	83 c4 10             	add    $0x10,%esp
  1034bd:	eb 14                	jmp    1034d3 <page_insert+0x84>
        }
        else {
            page_remove_pte(pgdir, la, ptep);
  1034bf:	83 ec 04             	sub    $0x4,%esp
  1034c2:	ff 75 f4             	pushl  -0xc(%ebp)
  1034c5:	ff 75 10             	pushl  0x10(%ebp)
  1034c8:	ff 75 08             	pushl  0x8(%ebp)
  1034cb:	e8 42 ff ff ff       	call   103412 <page_remove_pte>
  1034d0:	83 c4 10             	add    $0x10,%esp
        }
    }
    *ptep = page2pa(page) | PTE_P | perm;
  1034d3:	83 ec 0c             	sub    $0xc,%esp
  1034d6:	ff 75 0c             	pushl  0xc(%ebp)
  1034d9:	e8 1d f5 ff ff       	call   1029fb <page2pa>
  1034de:	83 c4 10             	add    $0x10,%esp
  1034e1:	0b 45 14             	or     0x14(%ebp),%eax
  1034e4:	83 c8 01             	or     $0x1,%eax
  1034e7:	89 c2                	mov    %eax,%edx
  1034e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1034ec:	89 10                	mov    %edx,(%eax)
    tlb_invalidate(pgdir, la);
  1034ee:	83 ec 08             	sub    $0x8,%esp
  1034f1:	ff 75 10             	pushl  0x10(%ebp)
  1034f4:	ff 75 08             	pushl  0x8(%ebp)
  1034f7:	e8 0a 00 00 00       	call   103506 <tlb_invalidate>
  1034fc:	83 c4 10             	add    $0x10,%esp
    return 0;
  1034ff:	b8 00 00 00 00       	mov    $0x0,%eax
}
  103504:	c9                   	leave  
  103505:	c3                   	ret    

00103506 <tlb_invalidate>:

// invalidate a TLB entry, but only if the page tables being
// edited are the ones currently in use by the processor.
void
tlb_invalidate(pde_t *pgdir, uintptr_t la) {
  103506:	f3 0f 1e fb          	endbr32 
  10350a:	55                   	push   %ebp
  10350b:	89 e5                	mov    %esp,%ebp
  10350d:	83 ec 18             	sub    $0x18,%esp
}

static inline uintptr_t
rcr3(void) {
    uintptr_t cr3;
    asm volatile ("mov %%cr3, %0" : "=r" (cr3) :: "memory");
  103510:	0f 20 d8             	mov    %cr3,%eax
  103513:	89 45 f0             	mov    %eax,-0x10(%ebp)
    return cr3;
  103516:	8b 55 f0             	mov    -0x10(%ebp),%edx
    if (rcr3() == PADDR(pgdir)) {
  103519:	8b 45 08             	mov    0x8(%ebp),%eax
  10351c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  10351f:	81 7d f4 ff ff ff bf 	cmpl   $0xbfffffff,-0xc(%ebp)
  103526:	77 17                	ja     10353f <tlb_invalidate+0x39>
  103528:	ff 75 f4             	pushl  -0xc(%ebp)
  10352b:	68 e4 64 10 00       	push   $0x1064e4
  103530:	68 d8 01 00 00       	push   $0x1d8
  103535:	68 08 65 10 00       	push   $0x106508
  10353a:	e8 cb ce ff ff       	call   10040a <__panic>
  10353f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  103542:	05 00 00 00 40       	add    $0x40000000,%eax
  103547:	39 d0                	cmp    %edx,%eax
  103549:	75 0d                	jne    103558 <tlb_invalidate+0x52>
        invlpg((void *)la);
  10354b:	8b 45 0c             	mov    0xc(%ebp),%eax
  10354e:	89 45 ec             	mov    %eax,-0x14(%ebp)
}

static inline void
invlpg(void *addr) {
    asm volatile ("invlpg (%0)" :: "r" (addr) : "memory");
  103551:	8b 45 ec             	mov    -0x14(%ebp),%eax
  103554:	0f 01 38             	invlpg (%eax)
}
  103557:	90                   	nop
    }
}
  103558:	90                   	nop
  103559:	c9                   	leave  
  10355a:	c3                   	ret    

0010355b <check_alloc_page>:

static void
check_alloc_page(void) {
  10355b:	f3 0f 1e fb          	endbr32 
  10355f:	55                   	push   %ebp
  103560:	89 e5                	mov    %esp,%ebp
  103562:	83 ec 08             	sub    $0x8,%esp
    pmm_manager->check();
  103565:	a1 50 a9 11 00       	mov    0x11a950,%eax
  10356a:	8b 40 18             	mov    0x18(%eax),%eax
  10356d:	ff d0                	call   *%eax
    cprintf("check_alloc_page() succeeded!\n");
  10356f:	83 ec 0c             	sub    $0xc,%esp
  103572:	68 68 65 10 00       	push   $0x106568
  103577:	e8 13 cd ff ff       	call   10028f <cprintf>
  10357c:	83 c4 10             	add    $0x10,%esp
}
  10357f:	90                   	nop
  103580:	c9                   	leave  
  103581:	c3                   	ret    

00103582 <check_pgdir>:

static void
check_pgdir(void) {
  103582:	f3 0f 1e fb          	endbr32 
  103586:	55                   	push   %ebp
  103587:	89 e5                	mov    %esp,%ebp
  103589:	83 ec 28             	sub    $0x28,%esp
    assert(npage <= KMEMSIZE / PGSIZE);
  10358c:	a1 c0 a8 11 00       	mov    0x11a8c0,%eax
  103591:	3d 00 80 03 00       	cmp    $0x38000,%eax
  103596:	76 19                	jbe    1035b1 <check_pgdir+0x2f>
  103598:	68 87 65 10 00       	push   $0x106587
  10359d:	68 2d 65 10 00       	push   $0x10652d
  1035a2:	68 e5 01 00 00       	push   $0x1e5
  1035a7:	68 08 65 10 00       	push   $0x106508
  1035ac:	e8 59 ce ff ff       	call   10040a <__panic>
    assert(boot_pgdir != NULL && (uint32_t)PGOFF(boot_pgdir) == 0);
  1035b1:	a1 c4 a8 11 00       	mov    0x11a8c4,%eax
  1035b6:	85 c0                	test   %eax,%eax
  1035b8:	74 0e                	je     1035c8 <check_pgdir+0x46>
  1035ba:	a1 c4 a8 11 00       	mov    0x11a8c4,%eax
  1035bf:	25 ff 0f 00 00       	and    $0xfff,%eax
  1035c4:	85 c0                	test   %eax,%eax
  1035c6:	74 19                	je     1035e1 <check_pgdir+0x5f>
  1035c8:	68 a4 65 10 00       	push   $0x1065a4
  1035cd:	68 2d 65 10 00       	push   $0x10652d
  1035d2:	68 e6 01 00 00       	push   $0x1e6
  1035d7:	68 08 65 10 00       	push   $0x106508
  1035dc:	e8 29 ce ff ff       	call   10040a <__panic>
    assert(get_page(boot_pgdir, 0x0, NULL) == NULL);
  1035e1:	a1 c4 a8 11 00       	mov    0x11a8c4,%eax
  1035e6:	83 ec 04             	sub    $0x4,%esp
  1035e9:	6a 00                	push   $0x0
  1035eb:	6a 00                	push   $0x0
  1035ed:	50                   	push   %eax
  1035ee:	e8 c8 fd ff ff       	call   1033bb <get_page>
  1035f3:	83 c4 10             	add    $0x10,%esp
  1035f6:	85 c0                	test   %eax,%eax
  1035f8:	74 19                	je     103613 <check_pgdir+0x91>
  1035fa:	68 dc 65 10 00       	push   $0x1065dc
  1035ff:	68 2d 65 10 00       	push   $0x10652d
  103604:	68 e7 01 00 00       	push   $0x1e7
  103609:	68 08 65 10 00       	push   $0x106508
  10360e:	e8 f7 cd ff ff       	call   10040a <__panic>

    struct Page *p1, *p2;
    p1 = alloc_page();
  103613:	83 ec 0c             	sub    $0xc,%esp
  103616:	6a 01                	push   $0x1
  103618:	e8 c8 f6 ff ff       	call   102ce5 <alloc_pages>
  10361d:	83 c4 10             	add    $0x10,%esp
  103620:	89 45 f4             	mov    %eax,-0xc(%ebp)
    assert(page_insert(boot_pgdir, p1, 0x0, 0) == 0);
  103623:	a1 c4 a8 11 00       	mov    0x11a8c4,%eax
  103628:	6a 00                	push   $0x0
  10362a:	6a 00                	push   $0x0
  10362c:	ff 75 f4             	pushl  -0xc(%ebp)
  10362f:	50                   	push   %eax
  103630:	e8 1a fe ff ff       	call   10344f <page_insert>
  103635:	83 c4 10             	add    $0x10,%esp
  103638:	85 c0                	test   %eax,%eax
  10363a:	74 19                	je     103655 <check_pgdir+0xd3>
  10363c:	68 04 66 10 00       	push   $0x106604
  103641:	68 2d 65 10 00       	push   $0x10652d
  103646:	68 eb 01 00 00       	push   $0x1eb
  10364b:	68 08 65 10 00       	push   $0x106508
  103650:	e8 b5 cd ff ff       	call   10040a <__panic>

    pte_t *ptep;
    assert((ptep = get_pte(boot_pgdir, 0x0, 0)) != NULL);
  103655:	a1 c4 a8 11 00       	mov    0x11a8c4,%eax
  10365a:	83 ec 04             	sub    $0x4,%esp
  10365d:	6a 00                	push   $0x0
  10365f:	6a 00                	push   $0x0
  103661:	50                   	push   %eax
  103662:	e8 4a fd ff ff       	call   1033b1 <get_pte>
  103667:	83 c4 10             	add    $0x10,%esp
  10366a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  10366d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  103671:	75 19                	jne    10368c <check_pgdir+0x10a>
  103673:	68 30 66 10 00       	push   $0x106630
  103678:	68 2d 65 10 00       	push   $0x10652d
  10367d:	68 ee 01 00 00       	push   $0x1ee
  103682:	68 08 65 10 00       	push   $0x106508
  103687:	e8 7e cd ff ff       	call   10040a <__panic>
    assert(pa2page(*ptep) == p1);
  10368c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10368f:	8b 00                	mov    (%eax),%eax
  103691:	83 ec 0c             	sub    $0xc,%esp
  103694:	50                   	push   %eax
  103695:	e8 74 f3 ff ff       	call   102a0e <pa2page>
  10369a:	83 c4 10             	add    $0x10,%esp
  10369d:	39 45 f4             	cmp    %eax,-0xc(%ebp)
  1036a0:	74 19                	je     1036bb <check_pgdir+0x139>
  1036a2:	68 5d 66 10 00       	push   $0x10665d
  1036a7:	68 2d 65 10 00       	push   $0x10652d
  1036ac:	68 ef 01 00 00       	push   $0x1ef
  1036b1:	68 08 65 10 00       	push   $0x106508
  1036b6:	e8 4f cd ff ff       	call   10040a <__panic>
    assert(page_ref(p1) == 1);
  1036bb:	83 ec 0c             	sub    $0xc,%esp
  1036be:	ff 75 f4             	pushl  -0xc(%ebp)
  1036c1:	e8 0e f4 ff ff       	call   102ad4 <page_ref>
  1036c6:	83 c4 10             	add    $0x10,%esp
  1036c9:	83 f8 01             	cmp    $0x1,%eax
  1036cc:	74 19                	je     1036e7 <check_pgdir+0x165>
  1036ce:	68 72 66 10 00       	push   $0x106672
  1036d3:	68 2d 65 10 00       	push   $0x10652d
  1036d8:	68 f0 01 00 00       	push   $0x1f0
  1036dd:	68 08 65 10 00       	push   $0x106508
  1036e2:	e8 23 cd ff ff       	call   10040a <__panic>

    ptep = &((pte_t *)KADDR(PDE_ADDR(boot_pgdir[0])))[1];
  1036e7:	a1 c4 a8 11 00       	mov    0x11a8c4,%eax
  1036ec:	8b 00                	mov    (%eax),%eax
  1036ee:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  1036f3:	89 45 ec             	mov    %eax,-0x14(%ebp)
  1036f6:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1036f9:	c1 e8 0c             	shr    $0xc,%eax
  1036fc:	89 45 e8             	mov    %eax,-0x18(%ebp)
  1036ff:	a1 c0 a8 11 00       	mov    0x11a8c0,%eax
  103704:	39 45 e8             	cmp    %eax,-0x18(%ebp)
  103707:	72 17                	jb     103720 <check_pgdir+0x19e>
  103709:	ff 75 ec             	pushl  -0x14(%ebp)
  10370c:	68 40 64 10 00       	push   $0x106440
  103711:	68 f2 01 00 00       	push   $0x1f2
  103716:	68 08 65 10 00       	push   $0x106508
  10371b:	e8 ea cc ff ff       	call   10040a <__panic>
  103720:	8b 45 ec             	mov    -0x14(%ebp),%eax
  103723:	2d 00 00 00 40       	sub    $0x40000000,%eax
  103728:	83 c0 04             	add    $0x4,%eax
  10372b:	89 45 f0             	mov    %eax,-0x10(%ebp)
    assert(get_pte(boot_pgdir, PGSIZE, 0) == ptep);
  10372e:	a1 c4 a8 11 00       	mov    0x11a8c4,%eax
  103733:	83 ec 04             	sub    $0x4,%esp
  103736:	6a 00                	push   $0x0
  103738:	68 00 10 00 00       	push   $0x1000
  10373d:	50                   	push   %eax
  10373e:	e8 6e fc ff ff       	call   1033b1 <get_pte>
  103743:	83 c4 10             	add    $0x10,%esp
  103746:	39 45 f0             	cmp    %eax,-0x10(%ebp)
  103749:	74 19                	je     103764 <check_pgdir+0x1e2>
  10374b:	68 84 66 10 00       	push   $0x106684
  103750:	68 2d 65 10 00       	push   $0x10652d
  103755:	68 f3 01 00 00       	push   $0x1f3
  10375a:	68 08 65 10 00       	push   $0x106508
  10375f:	e8 a6 cc ff ff       	call   10040a <__panic>

    p2 = alloc_page();
  103764:	83 ec 0c             	sub    $0xc,%esp
  103767:	6a 01                	push   $0x1
  103769:	e8 77 f5 ff ff       	call   102ce5 <alloc_pages>
  10376e:	83 c4 10             	add    $0x10,%esp
  103771:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    assert(page_insert(boot_pgdir, p2, PGSIZE, PTE_U | PTE_W) == 0);
  103774:	a1 c4 a8 11 00       	mov    0x11a8c4,%eax
  103779:	6a 06                	push   $0x6
  10377b:	68 00 10 00 00       	push   $0x1000
  103780:	ff 75 e4             	pushl  -0x1c(%ebp)
  103783:	50                   	push   %eax
  103784:	e8 c6 fc ff ff       	call   10344f <page_insert>
  103789:	83 c4 10             	add    $0x10,%esp
  10378c:	85 c0                	test   %eax,%eax
  10378e:	74 19                	je     1037a9 <check_pgdir+0x227>
  103790:	68 ac 66 10 00       	push   $0x1066ac
  103795:	68 2d 65 10 00       	push   $0x10652d
  10379a:	68 f6 01 00 00       	push   $0x1f6
  10379f:	68 08 65 10 00       	push   $0x106508
  1037a4:	e8 61 cc ff ff       	call   10040a <__panic>
    assert((ptep = get_pte(boot_pgdir, PGSIZE, 0)) != NULL);
  1037a9:	a1 c4 a8 11 00       	mov    0x11a8c4,%eax
  1037ae:	83 ec 04             	sub    $0x4,%esp
  1037b1:	6a 00                	push   $0x0
  1037b3:	68 00 10 00 00       	push   $0x1000
  1037b8:	50                   	push   %eax
  1037b9:	e8 f3 fb ff ff       	call   1033b1 <get_pte>
  1037be:	83 c4 10             	add    $0x10,%esp
  1037c1:	89 45 f0             	mov    %eax,-0x10(%ebp)
  1037c4:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  1037c8:	75 19                	jne    1037e3 <check_pgdir+0x261>
  1037ca:	68 e4 66 10 00       	push   $0x1066e4
  1037cf:	68 2d 65 10 00       	push   $0x10652d
  1037d4:	68 f7 01 00 00       	push   $0x1f7
  1037d9:	68 08 65 10 00       	push   $0x106508
  1037de:	e8 27 cc ff ff       	call   10040a <__panic>
    assert(*ptep & PTE_U);
  1037e3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1037e6:	8b 00                	mov    (%eax),%eax
  1037e8:	83 e0 04             	and    $0x4,%eax
  1037eb:	85 c0                	test   %eax,%eax
  1037ed:	75 19                	jne    103808 <check_pgdir+0x286>
  1037ef:	68 14 67 10 00       	push   $0x106714
  1037f4:	68 2d 65 10 00       	push   $0x10652d
  1037f9:	68 f8 01 00 00       	push   $0x1f8
  1037fe:	68 08 65 10 00       	push   $0x106508
  103803:	e8 02 cc ff ff       	call   10040a <__panic>
    assert(*ptep & PTE_W);
  103808:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10380b:	8b 00                	mov    (%eax),%eax
  10380d:	83 e0 02             	and    $0x2,%eax
  103810:	85 c0                	test   %eax,%eax
  103812:	75 19                	jne    10382d <check_pgdir+0x2ab>
  103814:	68 22 67 10 00       	push   $0x106722
  103819:	68 2d 65 10 00       	push   $0x10652d
  10381e:	68 f9 01 00 00       	push   $0x1f9
  103823:	68 08 65 10 00       	push   $0x106508
  103828:	e8 dd cb ff ff       	call   10040a <__panic>
    assert(boot_pgdir[0] & PTE_U);
  10382d:	a1 c4 a8 11 00       	mov    0x11a8c4,%eax
  103832:	8b 00                	mov    (%eax),%eax
  103834:	83 e0 04             	and    $0x4,%eax
  103837:	85 c0                	test   %eax,%eax
  103839:	75 19                	jne    103854 <check_pgdir+0x2d2>
  10383b:	68 30 67 10 00       	push   $0x106730
  103840:	68 2d 65 10 00       	push   $0x10652d
  103845:	68 fa 01 00 00       	push   $0x1fa
  10384a:	68 08 65 10 00       	push   $0x106508
  10384f:	e8 b6 cb ff ff       	call   10040a <__panic>
    assert(page_ref(p2) == 1);
  103854:	83 ec 0c             	sub    $0xc,%esp
  103857:	ff 75 e4             	pushl  -0x1c(%ebp)
  10385a:	e8 75 f2 ff ff       	call   102ad4 <page_ref>
  10385f:	83 c4 10             	add    $0x10,%esp
  103862:	83 f8 01             	cmp    $0x1,%eax
  103865:	74 19                	je     103880 <check_pgdir+0x2fe>
  103867:	68 46 67 10 00       	push   $0x106746
  10386c:	68 2d 65 10 00       	push   $0x10652d
  103871:	68 fb 01 00 00       	push   $0x1fb
  103876:	68 08 65 10 00       	push   $0x106508
  10387b:	e8 8a cb ff ff       	call   10040a <__panic>

    assert(page_insert(boot_pgdir, p1, PGSIZE, 0) == 0);
  103880:	a1 c4 a8 11 00       	mov    0x11a8c4,%eax
  103885:	6a 00                	push   $0x0
  103887:	68 00 10 00 00       	push   $0x1000
  10388c:	ff 75 f4             	pushl  -0xc(%ebp)
  10388f:	50                   	push   %eax
  103890:	e8 ba fb ff ff       	call   10344f <page_insert>
  103895:	83 c4 10             	add    $0x10,%esp
  103898:	85 c0                	test   %eax,%eax
  10389a:	74 19                	je     1038b5 <check_pgdir+0x333>
  10389c:	68 58 67 10 00       	push   $0x106758
  1038a1:	68 2d 65 10 00       	push   $0x10652d
  1038a6:	68 fd 01 00 00       	push   $0x1fd
  1038ab:	68 08 65 10 00       	push   $0x106508
  1038b0:	e8 55 cb ff ff       	call   10040a <__panic>
    assert(page_ref(p1) == 2);
  1038b5:	83 ec 0c             	sub    $0xc,%esp
  1038b8:	ff 75 f4             	pushl  -0xc(%ebp)
  1038bb:	e8 14 f2 ff ff       	call   102ad4 <page_ref>
  1038c0:	83 c4 10             	add    $0x10,%esp
  1038c3:	83 f8 02             	cmp    $0x2,%eax
  1038c6:	74 19                	je     1038e1 <check_pgdir+0x35f>
  1038c8:	68 84 67 10 00       	push   $0x106784
  1038cd:	68 2d 65 10 00       	push   $0x10652d
  1038d2:	68 fe 01 00 00       	push   $0x1fe
  1038d7:	68 08 65 10 00       	push   $0x106508
  1038dc:	e8 29 cb ff ff       	call   10040a <__panic>
    assert(page_ref(p2) == 0);
  1038e1:	83 ec 0c             	sub    $0xc,%esp
  1038e4:	ff 75 e4             	pushl  -0x1c(%ebp)
  1038e7:	e8 e8 f1 ff ff       	call   102ad4 <page_ref>
  1038ec:	83 c4 10             	add    $0x10,%esp
  1038ef:	85 c0                	test   %eax,%eax
  1038f1:	74 19                	je     10390c <check_pgdir+0x38a>
  1038f3:	68 96 67 10 00       	push   $0x106796
  1038f8:	68 2d 65 10 00       	push   $0x10652d
  1038fd:	68 ff 01 00 00       	push   $0x1ff
  103902:	68 08 65 10 00       	push   $0x106508
  103907:	e8 fe ca ff ff       	call   10040a <__panic>
    assert((ptep = get_pte(boot_pgdir, PGSIZE, 0)) != NULL);
  10390c:	a1 c4 a8 11 00       	mov    0x11a8c4,%eax
  103911:	83 ec 04             	sub    $0x4,%esp
  103914:	6a 00                	push   $0x0
  103916:	68 00 10 00 00       	push   $0x1000
  10391b:	50                   	push   %eax
  10391c:	e8 90 fa ff ff       	call   1033b1 <get_pte>
  103921:	83 c4 10             	add    $0x10,%esp
  103924:	89 45 f0             	mov    %eax,-0x10(%ebp)
  103927:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  10392b:	75 19                	jne    103946 <check_pgdir+0x3c4>
  10392d:	68 e4 66 10 00       	push   $0x1066e4
  103932:	68 2d 65 10 00       	push   $0x10652d
  103937:	68 00 02 00 00       	push   $0x200
  10393c:	68 08 65 10 00       	push   $0x106508
  103941:	e8 c4 ca ff ff       	call   10040a <__panic>
    assert(pa2page(*ptep) == p1);
  103946:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103949:	8b 00                	mov    (%eax),%eax
  10394b:	83 ec 0c             	sub    $0xc,%esp
  10394e:	50                   	push   %eax
  10394f:	e8 ba f0 ff ff       	call   102a0e <pa2page>
  103954:	83 c4 10             	add    $0x10,%esp
  103957:	39 45 f4             	cmp    %eax,-0xc(%ebp)
  10395a:	74 19                	je     103975 <check_pgdir+0x3f3>
  10395c:	68 5d 66 10 00       	push   $0x10665d
  103961:	68 2d 65 10 00       	push   $0x10652d
  103966:	68 01 02 00 00       	push   $0x201
  10396b:	68 08 65 10 00       	push   $0x106508
  103970:	e8 95 ca ff ff       	call   10040a <__panic>
    assert((*ptep & PTE_U) == 0);
  103975:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103978:	8b 00                	mov    (%eax),%eax
  10397a:	83 e0 04             	and    $0x4,%eax
  10397d:	85 c0                	test   %eax,%eax
  10397f:	74 19                	je     10399a <check_pgdir+0x418>
  103981:	68 a8 67 10 00       	push   $0x1067a8
  103986:	68 2d 65 10 00       	push   $0x10652d
  10398b:	68 02 02 00 00       	push   $0x202
  103990:	68 08 65 10 00       	push   $0x106508
  103995:	e8 70 ca ff ff       	call   10040a <__panic>

    page_remove(boot_pgdir, 0x0);
  10399a:	a1 c4 a8 11 00       	mov    0x11a8c4,%eax
  10399f:	83 ec 08             	sub    $0x8,%esp
  1039a2:	6a 00                	push   $0x0
  1039a4:	50                   	push   %eax
  1039a5:	e8 6e fa ff ff       	call   103418 <page_remove>
  1039aa:	83 c4 10             	add    $0x10,%esp
    assert(page_ref(p1) == 1);
  1039ad:	83 ec 0c             	sub    $0xc,%esp
  1039b0:	ff 75 f4             	pushl  -0xc(%ebp)
  1039b3:	e8 1c f1 ff ff       	call   102ad4 <page_ref>
  1039b8:	83 c4 10             	add    $0x10,%esp
  1039bb:	83 f8 01             	cmp    $0x1,%eax
  1039be:	74 19                	je     1039d9 <check_pgdir+0x457>
  1039c0:	68 72 66 10 00       	push   $0x106672
  1039c5:	68 2d 65 10 00       	push   $0x10652d
  1039ca:	68 05 02 00 00       	push   $0x205
  1039cf:	68 08 65 10 00       	push   $0x106508
  1039d4:	e8 31 ca ff ff       	call   10040a <__panic>
    assert(page_ref(p2) == 0);
  1039d9:	83 ec 0c             	sub    $0xc,%esp
  1039dc:	ff 75 e4             	pushl  -0x1c(%ebp)
  1039df:	e8 f0 f0 ff ff       	call   102ad4 <page_ref>
  1039e4:	83 c4 10             	add    $0x10,%esp
  1039e7:	85 c0                	test   %eax,%eax
  1039e9:	74 19                	je     103a04 <check_pgdir+0x482>
  1039eb:	68 96 67 10 00       	push   $0x106796
  1039f0:	68 2d 65 10 00       	push   $0x10652d
  1039f5:	68 06 02 00 00       	push   $0x206
  1039fa:	68 08 65 10 00       	push   $0x106508
  1039ff:	e8 06 ca ff ff       	call   10040a <__panic>

    page_remove(boot_pgdir, PGSIZE);
  103a04:	a1 c4 a8 11 00       	mov    0x11a8c4,%eax
  103a09:	83 ec 08             	sub    $0x8,%esp
  103a0c:	68 00 10 00 00       	push   $0x1000
  103a11:	50                   	push   %eax
  103a12:	e8 01 fa ff ff       	call   103418 <page_remove>
  103a17:	83 c4 10             	add    $0x10,%esp
    assert(page_ref(p1) == 0);
  103a1a:	83 ec 0c             	sub    $0xc,%esp
  103a1d:	ff 75 f4             	pushl  -0xc(%ebp)
  103a20:	e8 af f0 ff ff       	call   102ad4 <page_ref>
  103a25:	83 c4 10             	add    $0x10,%esp
  103a28:	85 c0                	test   %eax,%eax
  103a2a:	74 19                	je     103a45 <check_pgdir+0x4c3>
  103a2c:	68 bd 67 10 00       	push   $0x1067bd
  103a31:	68 2d 65 10 00       	push   $0x10652d
  103a36:	68 09 02 00 00       	push   $0x209
  103a3b:	68 08 65 10 00       	push   $0x106508
  103a40:	e8 c5 c9 ff ff       	call   10040a <__panic>
    assert(page_ref(p2) == 0);
  103a45:	83 ec 0c             	sub    $0xc,%esp
  103a48:	ff 75 e4             	pushl  -0x1c(%ebp)
  103a4b:	e8 84 f0 ff ff       	call   102ad4 <page_ref>
  103a50:	83 c4 10             	add    $0x10,%esp
  103a53:	85 c0                	test   %eax,%eax
  103a55:	74 19                	je     103a70 <check_pgdir+0x4ee>
  103a57:	68 96 67 10 00       	push   $0x106796
  103a5c:	68 2d 65 10 00       	push   $0x10652d
  103a61:	68 0a 02 00 00       	push   $0x20a
  103a66:	68 08 65 10 00       	push   $0x106508
  103a6b:	e8 9a c9 ff ff       	call   10040a <__panic>

    assert(page_ref(pa2page(boot_pgdir[0])) == 1);
  103a70:	a1 c4 a8 11 00       	mov    0x11a8c4,%eax
  103a75:	8b 00                	mov    (%eax),%eax
  103a77:	83 ec 0c             	sub    $0xc,%esp
  103a7a:	50                   	push   %eax
  103a7b:	e8 8e ef ff ff       	call   102a0e <pa2page>
  103a80:	83 c4 10             	add    $0x10,%esp
  103a83:	83 ec 0c             	sub    $0xc,%esp
  103a86:	50                   	push   %eax
  103a87:	e8 48 f0 ff ff       	call   102ad4 <page_ref>
  103a8c:	83 c4 10             	add    $0x10,%esp
  103a8f:	83 f8 01             	cmp    $0x1,%eax
  103a92:	74 19                	je     103aad <check_pgdir+0x52b>
  103a94:	68 d0 67 10 00       	push   $0x1067d0
  103a99:	68 2d 65 10 00       	push   $0x10652d
  103a9e:	68 0c 02 00 00       	push   $0x20c
  103aa3:	68 08 65 10 00       	push   $0x106508
  103aa8:	e8 5d c9 ff ff       	call   10040a <__panic>
    free_page(pa2page(boot_pgdir[0]));
  103aad:	a1 c4 a8 11 00       	mov    0x11a8c4,%eax
  103ab2:	8b 00                	mov    (%eax),%eax
  103ab4:	83 ec 0c             	sub    $0xc,%esp
  103ab7:	50                   	push   %eax
  103ab8:	e8 51 ef ff ff       	call   102a0e <pa2page>
  103abd:	83 c4 10             	add    $0x10,%esp
  103ac0:	83 ec 08             	sub    $0x8,%esp
  103ac3:	6a 01                	push   $0x1
  103ac5:	50                   	push   %eax
  103ac6:	e8 5c f2 ff ff       	call   102d27 <free_pages>
  103acb:	83 c4 10             	add    $0x10,%esp
    boot_pgdir[0] = 0;
  103ace:	a1 c4 a8 11 00       	mov    0x11a8c4,%eax
  103ad3:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

    cprintf("check_pgdir() succeeded!\n");
  103ad9:	83 ec 0c             	sub    $0xc,%esp
  103adc:	68 f6 67 10 00       	push   $0x1067f6
  103ae1:	e8 a9 c7 ff ff       	call   10028f <cprintf>
  103ae6:	83 c4 10             	add    $0x10,%esp
}
  103ae9:	90                   	nop
  103aea:	c9                   	leave  
  103aeb:	c3                   	ret    

00103aec <check_boot_pgdir>:

static void
check_boot_pgdir(void) {
  103aec:	f3 0f 1e fb          	endbr32 
  103af0:	55                   	push   %ebp
  103af1:	89 e5                	mov    %esp,%ebp
  103af3:	83 ec 28             	sub    $0x28,%esp
    pte_t *ptep;
    int i;
    for (i = 0; i < npage; i += PGSIZE) {
  103af6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  103afd:	e9 a3 00 00 00       	jmp    103ba5 <check_boot_pgdir+0xb9>
        assert((ptep = get_pte(boot_pgdir, (uintptr_t)KADDR(i), 0)) != NULL);
  103b02:	8b 45 f4             	mov    -0xc(%ebp),%eax
  103b05:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  103b08:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  103b0b:	c1 e8 0c             	shr    $0xc,%eax
  103b0e:	89 45 e0             	mov    %eax,-0x20(%ebp)
  103b11:	a1 c0 a8 11 00       	mov    0x11a8c0,%eax
  103b16:	39 45 e0             	cmp    %eax,-0x20(%ebp)
  103b19:	72 17                	jb     103b32 <check_boot_pgdir+0x46>
  103b1b:	ff 75 e4             	pushl  -0x1c(%ebp)
  103b1e:	68 40 64 10 00       	push   $0x106440
  103b23:	68 18 02 00 00       	push   $0x218
  103b28:	68 08 65 10 00       	push   $0x106508
  103b2d:	e8 d8 c8 ff ff       	call   10040a <__panic>
  103b32:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  103b35:	2d 00 00 00 40       	sub    $0x40000000,%eax
  103b3a:	89 c2                	mov    %eax,%edx
  103b3c:	a1 c4 a8 11 00       	mov    0x11a8c4,%eax
  103b41:	83 ec 04             	sub    $0x4,%esp
  103b44:	6a 00                	push   $0x0
  103b46:	52                   	push   %edx
  103b47:	50                   	push   %eax
  103b48:	e8 64 f8 ff ff       	call   1033b1 <get_pte>
  103b4d:	83 c4 10             	add    $0x10,%esp
  103b50:	89 45 dc             	mov    %eax,-0x24(%ebp)
  103b53:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  103b57:	75 19                	jne    103b72 <check_boot_pgdir+0x86>
  103b59:	68 10 68 10 00       	push   $0x106810
  103b5e:	68 2d 65 10 00       	push   $0x10652d
  103b63:	68 18 02 00 00       	push   $0x218
  103b68:	68 08 65 10 00       	push   $0x106508
  103b6d:	e8 98 c8 ff ff       	call   10040a <__panic>
        assert(PTE_ADDR(*ptep) == i);
  103b72:	8b 45 dc             	mov    -0x24(%ebp),%eax
  103b75:	8b 00                	mov    (%eax),%eax
  103b77:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  103b7c:	89 c2                	mov    %eax,%edx
  103b7e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  103b81:	39 c2                	cmp    %eax,%edx
  103b83:	74 19                	je     103b9e <check_boot_pgdir+0xb2>
  103b85:	68 4d 68 10 00       	push   $0x10684d
  103b8a:	68 2d 65 10 00       	push   $0x10652d
  103b8f:	68 19 02 00 00       	push   $0x219
  103b94:	68 08 65 10 00       	push   $0x106508
  103b99:	e8 6c c8 ff ff       	call   10040a <__panic>
    for (i = 0; i < npage; i += PGSIZE) {
  103b9e:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
  103ba5:	8b 55 f4             	mov    -0xc(%ebp),%edx
  103ba8:	a1 c0 a8 11 00       	mov    0x11a8c0,%eax
  103bad:	39 c2                	cmp    %eax,%edx
  103baf:	0f 82 4d ff ff ff    	jb     103b02 <check_boot_pgdir+0x16>
    }

    assert(PDE_ADDR(boot_pgdir[PDX(VPT)]) == PADDR(boot_pgdir));
  103bb5:	a1 c4 a8 11 00       	mov    0x11a8c4,%eax
  103bba:	05 ac 0f 00 00       	add    $0xfac,%eax
  103bbf:	8b 00                	mov    (%eax),%eax
  103bc1:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  103bc6:	89 c2                	mov    %eax,%edx
  103bc8:	a1 c4 a8 11 00       	mov    0x11a8c4,%eax
  103bcd:	89 45 f0             	mov    %eax,-0x10(%ebp)
  103bd0:	81 7d f0 ff ff ff bf 	cmpl   $0xbfffffff,-0x10(%ebp)
  103bd7:	77 17                	ja     103bf0 <check_boot_pgdir+0x104>
  103bd9:	ff 75 f0             	pushl  -0x10(%ebp)
  103bdc:	68 e4 64 10 00       	push   $0x1064e4
  103be1:	68 1c 02 00 00       	push   $0x21c
  103be6:	68 08 65 10 00       	push   $0x106508
  103beb:	e8 1a c8 ff ff       	call   10040a <__panic>
  103bf0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103bf3:	05 00 00 00 40       	add    $0x40000000,%eax
  103bf8:	39 d0                	cmp    %edx,%eax
  103bfa:	74 19                	je     103c15 <check_boot_pgdir+0x129>
  103bfc:	68 64 68 10 00       	push   $0x106864
  103c01:	68 2d 65 10 00       	push   $0x10652d
  103c06:	68 1c 02 00 00       	push   $0x21c
  103c0b:	68 08 65 10 00       	push   $0x106508
  103c10:	e8 f5 c7 ff ff       	call   10040a <__panic>

    assert(boot_pgdir[0] == 0);
  103c15:	a1 c4 a8 11 00       	mov    0x11a8c4,%eax
  103c1a:	8b 00                	mov    (%eax),%eax
  103c1c:	85 c0                	test   %eax,%eax
  103c1e:	74 19                	je     103c39 <check_boot_pgdir+0x14d>
  103c20:	68 98 68 10 00       	push   $0x106898
  103c25:	68 2d 65 10 00       	push   $0x10652d
  103c2a:	68 1e 02 00 00       	push   $0x21e
  103c2f:	68 08 65 10 00       	push   $0x106508
  103c34:	e8 d1 c7 ff ff       	call   10040a <__panic>

    struct Page *p;
    p = alloc_page();
  103c39:	83 ec 0c             	sub    $0xc,%esp
  103c3c:	6a 01                	push   $0x1
  103c3e:	e8 a2 f0 ff ff       	call   102ce5 <alloc_pages>
  103c43:	83 c4 10             	add    $0x10,%esp
  103c46:	89 45 ec             	mov    %eax,-0x14(%ebp)
    assert(page_insert(boot_pgdir, p, 0x100, PTE_W) == 0);
  103c49:	a1 c4 a8 11 00       	mov    0x11a8c4,%eax
  103c4e:	6a 02                	push   $0x2
  103c50:	68 00 01 00 00       	push   $0x100
  103c55:	ff 75 ec             	pushl  -0x14(%ebp)
  103c58:	50                   	push   %eax
  103c59:	e8 f1 f7 ff ff       	call   10344f <page_insert>
  103c5e:	83 c4 10             	add    $0x10,%esp
  103c61:	85 c0                	test   %eax,%eax
  103c63:	74 19                	je     103c7e <check_boot_pgdir+0x192>
  103c65:	68 ac 68 10 00       	push   $0x1068ac
  103c6a:	68 2d 65 10 00       	push   $0x10652d
  103c6f:	68 22 02 00 00       	push   $0x222
  103c74:	68 08 65 10 00       	push   $0x106508
  103c79:	e8 8c c7 ff ff       	call   10040a <__panic>
    assert(page_ref(p) == 1);
  103c7e:	83 ec 0c             	sub    $0xc,%esp
  103c81:	ff 75 ec             	pushl  -0x14(%ebp)
  103c84:	e8 4b ee ff ff       	call   102ad4 <page_ref>
  103c89:	83 c4 10             	add    $0x10,%esp
  103c8c:	83 f8 01             	cmp    $0x1,%eax
  103c8f:	74 19                	je     103caa <check_boot_pgdir+0x1be>
  103c91:	68 da 68 10 00       	push   $0x1068da
  103c96:	68 2d 65 10 00       	push   $0x10652d
  103c9b:	68 23 02 00 00       	push   $0x223
  103ca0:	68 08 65 10 00       	push   $0x106508
  103ca5:	e8 60 c7 ff ff       	call   10040a <__panic>
    assert(page_insert(boot_pgdir, p, 0x100 + PGSIZE, PTE_W) == 0);
  103caa:	a1 c4 a8 11 00       	mov    0x11a8c4,%eax
  103caf:	6a 02                	push   $0x2
  103cb1:	68 00 11 00 00       	push   $0x1100
  103cb6:	ff 75 ec             	pushl  -0x14(%ebp)
  103cb9:	50                   	push   %eax
  103cba:	e8 90 f7 ff ff       	call   10344f <page_insert>
  103cbf:	83 c4 10             	add    $0x10,%esp
  103cc2:	85 c0                	test   %eax,%eax
  103cc4:	74 19                	je     103cdf <check_boot_pgdir+0x1f3>
  103cc6:	68 ec 68 10 00       	push   $0x1068ec
  103ccb:	68 2d 65 10 00       	push   $0x10652d
  103cd0:	68 24 02 00 00       	push   $0x224
  103cd5:	68 08 65 10 00       	push   $0x106508
  103cda:	e8 2b c7 ff ff       	call   10040a <__panic>
    assert(page_ref(p) == 2);
  103cdf:	83 ec 0c             	sub    $0xc,%esp
  103ce2:	ff 75 ec             	pushl  -0x14(%ebp)
  103ce5:	e8 ea ed ff ff       	call   102ad4 <page_ref>
  103cea:	83 c4 10             	add    $0x10,%esp
  103ced:	83 f8 02             	cmp    $0x2,%eax
  103cf0:	74 19                	je     103d0b <check_boot_pgdir+0x21f>
  103cf2:	68 23 69 10 00       	push   $0x106923
  103cf7:	68 2d 65 10 00       	push   $0x10652d
  103cfc:	68 25 02 00 00       	push   $0x225
  103d01:	68 08 65 10 00       	push   $0x106508
  103d06:	e8 ff c6 ff ff       	call   10040a <__panic>

    const char *str = "ucore: Hello world!!";
  103d0b:	c7 45 e8 34 69 10 00 	movl   $0x106934,-0x18(%ebp)
    strcpy((void *)0x100, str);
  103d12:	83 ec 08             	sub    $0x8,%esp
  103d15:	ff 75 e8             	pushl  -0x18(%ebp)
  103d18:	68 00 01 00 00       	push   $0x100
  103d1d:	e8 23 15 00 00       	call   105245 <strcpy>
  103d22:	83 c4 10             	add    $0x10,%esp
    assert(strcmp((void *)0x100, (void *)(0x100 + PGSIZE)) == 0);
  103d25:	83 ec 08             	sub    $0x8,%esp
  103d28:	68 00 11 00 00       	push   $0x1100
  103d2d:	68 00 01 00 00       	push   $0x100
  103d32:	e8 8f 15 00 00       	call   1052c6 <strcmp>
  103d37:	83 c4 10             	add    $0x10,%esp
  103d3a:	85 c0                	test   %eax,%eax
  103d3c:	74 19                	je     103d57 <check_boot_pgdir+0x26b>
  103d3e:	68 4c 69 10 00       	push   $0x10694c
  103d43:	68 2d 65 10 00       	push   $0x10652d
  103d48:	68 29 02 00 00       	push   $0x229
  103d4d:	68 08 65 10 00       	push   $0x106508
  103d52:	e8 b3 c6 ff ff       	call   10040a <__panic>

    *(char *)(page2kva(p) + 0x100) = '\0';
  103d57:	83 ec 0c             	sub    $0xc,%esp
  103d5a:	ff 75 ec             	pushl  -0x14(%ebp)
  103d5d:	e8 f3 ec ff ff       	call   102a55 <page2kva>
  103d62:	83 c4 10             	add    $0x10,%esp
  103d65:	05 00 01 00 00       	add    $0x100,%eax
  103d6a:	c6 00 00             	movb   $0x0,(%eax)
    assert(strlen((const char *)0x100) == 0);
  103d6d:	83 ec 0c             	sub    $0xc,%esp
  103d70:	68 00 01 00 00       	push   $0x100
  103d75:	e8 6b 14 00 00       	call   1051e5 <strlen>
  103d7a:	83 c4 10             	add    $0x10,%esp
  103d7d:	85 c0                	test   %eax,%eax
  103d7f:	74 19                	je     103d9a <check_boot_pgdir+0x2ae>
  103d81:	68 84 69 10 00       	push   $0x106984
  103d86:	68 2d 65 10 00       	push   $0x10652d
  103d8b:	68 2c 02 00 00       	push   $0x22c
  103d90:	68 08 65 10 00       	push   $0x106508
  103d95:	e8 70 c6 ff ff       	call   10040a <__panic>

    free_page(p);
  103d9a:	83 ec 08             	sub    $0x8,%esp
  103d9d:	6a 01                	push   $0x1
  103d9f:	ff 75 ec             	pushl  -0x14(%ebp)
  103da2:	e8 80 ef ff ff       	call   102d27 <free_pages>
  103da7:	83 c4 10             	add    $0x10,%esp
    free_page(pa2page(PDE_ADDR(boot_pgdir[0])));
  103daa:	a1 c4 a8 11 00       	mov    0x11a8c4,%eax
  103daf:	8b 00                	mov    (%eax),%eax
  103db1:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  103db6:	83 ec 0c             	sub    $0xc,%esp
  103db9:	50                   	push   %eax
  103dba:	e8 4f ec ff ff       	call   102a0e <pa2page>
  103dbf:	83 c4 10             	add    $0x10,%esp
  103dc2:	83 ec 08             	sub    $0x8,%esp
  103dc5:	6a 01                	push   $0x1
  103dc7:	50                   	push   %eax
  103dc8:	e8 5a ef ff ff       	call   102d27 <free_pages>
  103dcd:	83 c4 10             	add    $0x10,%esp
    boot_pgdir[0] = 0;
  103dd0:	a1 c4 a8 11 00       	mov    0x11a8c4,%eax
  103dd5:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

    cprintf("check_boot_pgdir() succeeded!\n");
  103ddb:	83 ec 0c             	sub    $0xc,%esp
  103dde:	68 a8 69 10 00       	push   $0x1069a8
  103de3:	e8 a7 c4 ff ff       	call   10028f <cprintf>
  103de8:	83 c4 10             	add    $0x10,%esp
}
  103deb:	90                   	nop
  103dec:	c9                   	leave  
  103ded:	c3                   	ret    

00103dee <perm2str>:

//perm2str - use string 'u,r,w,-' to present the permission
static const char *
perm2str(int perm) {
  103dee:	f3 0f 1e fb          	endbr32 
  103df2:	55                   	push   %ebp
  103df3:	89 e5                	mov    %esp,%ebp
    static char str[4];
    str[0] = (perm & PTE_U) ? 'u' : '-';
  103df5:	8b 45 08             	mov    0x8(%ebp),%eax
  103df8:	83 e0 04             	and    $0x4,%eax
  103dfb:	85 c0                	test   %eax,%eax
  103dfd:	74 07                	je     103e06 <perm2str+0x18>
  103dff:	b8 75 00 00 00       	mov    $0x75,%eax
  103e04:	eb 05                	jmp    103e0b <perm2str+0x1d>
  103e06:	b8 2d 00 00 00       	mov    $0x2d,%eax
  103e0b:	a2 48 a9 11 00       	mov    %al,0x11a948
    str[1] = 'r';
  103e10:	c6 05 49 a9 11 00 72 	movb   $0x72,0x11a949
    str[2] = (perm & PTE_W) ? 'w' : '-';
  103e17:	8b 45 08             	mov    0x8(%ebp),%eax
  103e1a:	83 e0 02             	and    $0x2,%eax
  103e1d:	85 c0                	test   %eax,%eax
  103e1f:	74 07                	je     103e28 <perm2str+0x3a>
  103e21:	b8 77 00 00 00       	mov    $0x77,%eax
  103e26:	eb 05                	jmp    103e2d <perm2str+0x3f>
  103e28:	b8 2d 00 00 00       	mov    $0x2d,%eax
  103e2d:	a2 4a a9 11 00       	mov    %al,0x11a94a
    str[3] = '\0';
  103e32:	c6 05 4b a9 11 00 00 	movb   $0x0,0x11a94b
    return str;
  103e39:	b8 48 a9 11 00       	mov    $0x11a948,%eax
}
  103e3e:	5d                   	pop    %ebp
  103e3f:	c3                   	ret    

00103e40 <get_pgtable_items>:
//  table:       the beginning addr of table
//  left_store:  the pointer of the high side of table's next range
//  right_store: the pointer of the low side of table's next range
// return value: 0 - not a invalid item range, perm - a valid item range with perm permission 
static int
get_pgtable_items(size_t left, size_t right, size_t start, uintptr_t *table, size_t *left_store, size_t *right_store) {
  103e40:	f3 0f 1e fb          	endbr32 
  103e44:	55                   	push   %ebp
  103e45:	89 e5                	mov    %esp,%ebp
  103e47:	83 ec 10             	sub    $0x10,%esp
    if (start >= right) {
  103e4a:	8b 45 10             	mov    0x10(%ebp),%eax
  103e4d:	3b 45 0c             	cmp    0xc(%ebp),%eax
  103e50:	72 0e                	jb     103e60 <get_pgtable_items+0x20>
        return 0;
  103e52:	b8 00 00 00 00       	mov    $0x0,%eax
  103e57:	e9 9a 00 00 00       	jmp    103ef6 <get_pgtable_items+0xb6>
    }
    while (start < right && !(table[start] & PTE_P)) {
        start ++;
  103e5c:	83 45 10 01          	addl   $0x1,0x10(%ebp)
    while (start < right && !(table[start] & PTE_P)) {
  103e60:	8b 45 10             	mov    0x10(%ebp),%eax
  103e63:	3b 45 0c             	cmp    0xc(%ebp),%eax
  103e66:	73 18                	jae    103e80 <get_pgtable_items+0x40>
  103e68:	8b 45 10             	mov    0x10(%ebp),%eax
  103e6b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  103e72:	8b 45 14             	mov    0x14(%ebp),%eax
  103e75:	01 d0                	add    %edx,%eax
  103e77:	8b 00                	mov    (%eax),%eax
  103e79:	83 e0 01             	and    $0x1,%eax
  103e7c:	85 c0                	test   %eax,%eax
  103e7e:	74 dc                	je     103e5c <get_pgtable_items+0x1c>
    }
    if (start < right) {
  103e80:	8b 45 10             	mov    0x10(%ebp),%eax
  103e83:	3b 45 0c             	cmp    0xc(%ebp),%eax
  103e86:	73 69                	jae    103ef1 <get_pgtable_items+0xb1>
        if (left_store != NULL) {
  103e88:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
  103e8c:	74 08                	je     103e96 <get_pgtable_items+0x56>
            *left_store = start;
  103e8e:	8b 45 18             	mov    0x18(%ebp),%eax
  103e91:	8b 55 10             	mov    0x10(%ebp),%edx
  103e94:	89 10                	mov    %edx,(%eax)
        }
        int perm = (table[start ++] & PTE_USER);
  103e96:	8b 45 10             	mov    0x10(%ebp),%eax
  103e99:	8d 50 01             	lea    0x1(%eax),%edx
  103e9c:	89 55 10             	mov    %edx,0x10(%ebp)
  103e9f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  103ea6:	8b 45 14             	mov    0x14(%ebp),%eax
  103ea9:	01 d0                	add    %edx,%eax
  103eab:	8b 00                	mov    (%eax),%eax
  103ead:	83 e0 07             	and    $0x7,%eax
  103eb0:	89 45 fc             	mov    %eax,-0x4(%ebp)
        while (start < right && (table[start] & PTE_USER) == perm) {
  103eb3:	eb 04                	jmp    103eb9 <get_pgtable_items+0x79>
            start ++;
  103eb5:	83 45 10 01          	addl   $0x1,0x10(%ebp)
        while (start < right && (table[start] & PTE_USER) == perm) {
  103eb9:	8b 45 10             	mov    0x10(%ebp),%eax
  103ebc:	3b 45 0c             	cmp    0xc(%ebp),%eax
  103ebf:	73 1d                	jae    103ede <get_pgtable_items+0x9e>
  103ec1:	8b 45 10             	mov    0x10(%ebp),%eax
  103ec4:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  103ecb:	8b 45 14             	mov    0x14(%ebp),%eax
  103ece:	01 d0                	add    %edx,%eax
  103ed0:	8b 00                	mov    (%eax),%eax
  103ed2:	83 e0 07             	and    $0x7,%eax
  103ed5:	89 c2                	mov    %eax,%edx
  103ed7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  103eda:	39 c2                	cmp    %eax,%edx
  103edc:	74 d7                	je     103eb5 <get_pgtable_items+0x75>
        }
        if (right_store != NULL) {
  103ede:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  103ee2:	74 08                	je     103eec <get_pgtable_items+0xac>
            *right_store = start;
  103ee4:	8b 45 1c             	mov    0x1c(%ebp),%eax
  103ee7:	8b 55 10             	mov    0x10(%ebp),%edx
  103eea:	89 10                	mov    %edx,(%eax)
        }
        return perm;
  103eec:	8b 45 fc             	mov    -0x4(%ebp),%eax
  103eef:	eb 05                	jmp    103ef6 <get_pgtable_items+0xb6>
    }
    return 0;
  103ef1:	b8 00 00 00 00       	mov    $0x0,%eax
}
  103ef6:	c9                   	leave  
  103ef7:	c3                   	ret    

00103ef8 <print_pgdir>:

//print_pgdir - print the PDT&PT
void
print_pgdir(void) {
  103ef8:	f3 0f 1e fb          	endbr32 
  103efc:	55                   	push   %ebp
  103efd:	89 e5                	mov    %esp,%ebp
  103eff:	57                   	push   %edi
  103f00:	56                   	push   %esi
  103f01:	53                   	push   %ebx
  103f02:	83 ec 2c             	sub    $0x2c,%esp
    cprintf("-------------------- BEGIN --------------------\n");
  103f05:	83 ec 0c             	sub    $0xc,%esp
  103f08:	68 c8 69 10 00       	push   $0x1069c8
  103f0d:	e8 7d c3 ff ff       	call   10028f <cprintf>
  103f12:	83 c4 10             	add    $0x10,%esp
    size_t left, right = 0, perm;
  103f15:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    while ((perm = get_pgtable_items(0, NPDEENTRY, right, vpd, &left, &right)) != 0) {
  103f1c:	e9 e1 00 00 00       	jmp    104002 <print_pgdir+0x10a>
        cprintf("PDE(%03x) %08x-%08x %08x %s\n", right - left,
  103f21:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  103f24:	83 ec 0c             	sub    $0xc,%esp
  103f27:	50                   	push   %eax
  103f28:	e8 c1 fe ff ff       	call   103dee <perm2str>
  103f2d:	83 c4 10             	add    $0x10,%esp
                left * PTSIZE, right * PTSIZE, (right - left) * PTSIZE, perm2str(perm));
  103f30:	8b 4d dc             	mov    -0x24(%ebp),%ecx
  103f33:	8b 55 e0             	mov    -0x20(%ebp),%edx
  103f36:	29 d1                	sub    %edx,%ecx
  103f38:	89 ca                	mov    %ecx,%edx
        cprintf("PDE(%03x) %08x-%08x %08x %s\n", right - left,
  103f3a:	89 d6                	mov    %edx,%esi
  103f3c:	c1 e6 16             	shl    $0x16,%esi
  103f3f:	8b 55 dc             	mov    -0x24(%ebp),%edx
  103f42:	89 d3                	mov    %edx,%ebx
  103f44:	c1 e3 16             	shl    $0x16,%ebx
  103f47:	8b 55 e0             	mov    -0x20(%ebp),%edx
  103f4a:	89 d1                	mov    %edx,%ecx
  103f4c:	c1 e1 16             	shl    $0x16,%ecx
  103f4f:	8b 7d dc             	mov    -0x24(%ebp),%edi
  103f52:	8b 55 e0             	mov    -0x20(%ebp),%edx
  103f55:	29 d7                	sub    %edx,%edi
  103f57:	89 fa                	mov    %edi,%edx
  103f59:	83 ec 08             	sub    $0x8,%esp
  103f5c:	50                   	push   %eax
  103f5d:	56                   	push   %esi
  103f5e:	53                   	push   %ebx
  103f5f:	51                   	push   %ecx
  103f60:	52                   	push   %edx
  103f61:	68 f9 69 10 00       	push   $0x1069f9
  103f66:	e8 24 c3 ff ff       	call   10028f <cprintf>
  103f6b:	83 c4 20             	add    $0x20,%esp
        size_t l, r = left * NPTEENTRY;
  103f6e:	8b 45 e0             	mov    -0x20(%ebp),%eax
  103f71:	c1 e0 0a             	shl    $0xa,%eax
  103f74:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        while ((perm = get_pgtable_items(left * NPTEENTRY, right * NPTEENTRY, r, vpt, &l, &r)) != 0) {
  103f77:	eb 4d                	jmp    103fc6 <print_pgdir+0xce>
            cprintf("  |-- PTE(%05x) %08x-%08x %08x %s\n", r - l,
  103f79:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  103f7c:	83 ec 0c             	sub    $0xc,%esp
  103f7f:	50                   	push   %eax
  103f80:	e8 69 fe ff ff       	call   103dee <perm2str>
  103f85:	83 c4 10             	add    $0x10,%esp
                    l * PGSIZE, r * PGSIZE, (r - l) * PGSIZE, perm2str(perm));
  103f88:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
  103f8b:	8b 55 d8             	mov    -0x28(%ebp),%edx
  103f8e:	29 d1                	sub    %edx,%ecx
  103f90:	89 ca                	mov    %ecx,%edx
            cprintf("  |-- PTE(%05x) %08x-%08x %08x %s\n", r - l,
  103f92:	89 d6                	mov    %edx,%esi
  103f94:	c1 e6 0c             	shl    $0xc,%esi
  103f97:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  103f9a:	89 d3                	mov    %edx,%ebx
  103f9c:	c1 e3 0c             	shl    $0xc,%ebx
  103f9f:	8b 55 d8             	mov    -0x28(%ebp),%edx
  103fa2:	89 d1                	mov    %edx,%ecx
  103fa4:	c1 e1 0c             	shl    $0xc,%ecx
  103fa7:	8b 7d d4             	mov    -0x2c(%ebp),%edi
  103faa:	8b 55 d8             	mov    -0x28(%ebp),%edx
  103fad:	29 d7                	sub    %edx,%edi
  103faf:	89 fa                	mov    %edi,%edx
  103fb1:	83 ec 08             	sub    $0x8,%esp
  103fb4:	50                   	push   %eax
  103fb5:	56                   	push   %esi
  103fb6:	53                   	push   %ebx
  103fb7:	51                   	push   %ecx
  103fb8:	52                   	push   %edx
  103fb9:	68 18 6a 10 00       	push   $0x106a18
  103fbe:	e8 cc c2 ff ff       	call   10028f <cprintf>
  103fc3:	83 c4 20             	add    $0x20,%esp
        while ((perm = get_pgtable_items(left * NPTEENTRY, right * NPTEENTRY, r, vpt, &l, &r)) != 0) {
  103fc6:	be 00 00 c0 fa       	mov    $0xfac00000,%esi
  103fcb:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  103fce:	8b 55 dc             	mov    -0x24(%ebp),%edx
  103fd1:	89 d3                	mov    %edx,%ebx
  103fd3:	c1 e3 0a             	shl    $0xa,%ebx
  103fd6:	8b 55 e0             	mov    -0x20(%ebp),%edx
  103fd9:	89 d1                	mov    %edx,%ecx
  103fdb:	c1 e1 0a             	shl    $0xa,%ecx
  103fde:	83 ec 08             	sub    $0x8,%esp
  103fe1:	8d 55 d4             	lea    -0x2c(%ebp),%edx
  103fe4:	52                   	push   %edx
  103fe5:	8d 55 d8             	lea    -0x28(%ebp),%edx
  103fe8:	52                   	push   %edx
  103fe9:	56                   	push   %esi
  103fea:	50                   	push   %eax
  103feb:	53                   	push   %ebx
  103fec:	51                   	push   %ecx
  103fed:	e8 4e fe ff ff       	call   103e40 <get_pgtable_items>
  103ff2:	83 c4 20             	add    $0x20,%esp
  103ff5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  103ff8:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  103ffc:	0f 85 77 ff ff ff    	jne    103f79 <print_pgdir+0x81>
    while ((perm = get_pgtable_items(0, NPDEENTRY, right, vpd, &left, &right)) != 0) {
  104002:	b9 00 b0 fe fa       	mov    $0xfafeb000,%ecx
  104007:	8b 45 dc             	mov    -0x24(%ebp),%eax
  10400a:	83 ec 08             	sub    $0x8,%esp
  10400d:	8d 55 dc             	lea    -0x24(%ebp),%edx
  104010:	52                   	push   %edx
  104011:	8d 55 e0             	lea    -0x20(%ebp),%edx
  104014:	52                   	push   %edx
  104015:	51                   	push   %ecx
  104016:	50                   	push   %eax
  104017:	68 00 04 00 00       	push   $0x400
  10401c:	6a 00                	push   $0x0
  10401e:	e8 1d fe ff ff       	call   103e40 <get_pgtable_items>
  104023:	83 c4 20             	add    $0x20,%esp
  104026:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  104029:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  10402d:	0f 85 ee fe ff ff    	jne    103f21 <print_pgdir+0x29>
        }
    }
    cprintf("--------------------- END ---------------------\n");
  104033:	83 ec 0c             	sub    $0xc,%esp
  104036:	68 3c 6a 10 00       	push   $0x106a3c
  10403b:	e8 4f c2 ff ff       	call   10028f <cprintf>
  104040:	83 c4 10             	add    $0x10,%esp
}
  104043:	90                   	nop
  104044:	8d 65 f4             	lea    -0xc(%ebp),%esp
  104047:	5b                   	pop    %ebx
  104048:	5e                   	pop    %esi
  104049:	5f                   	pop    %edi
  10404a:	5d                   	pop    %ebp
  10404b:	c3                   	ret    

0010404c <page2ppn>:
page2ppn(struct Page *page) {
  10404c:	55                   	push   %ebp
  10404d:	89 e5                	mov    %esp,%ebp
    return page - pages;
  10404f:	a1 58 a9 11 00       	mov    0x11a958,%eax
  104054:	8b 55 08             	mov    0x8(%ebp),%edx
  104057:	29 c2                	sub    %eax,%edx
  104059:	89 d0                	mov    %edx,%eax
  10405b:	c1 f8 02             	sar    $0x2,%eax
  10405e:	69 c0 cd cc cc cc    	imul   $0xcccccccd,%eax,%eax
}
  104064:	5d                   	pop    %ebp
  104065:	c3                   	ret    

00104066 <page2pa>:
page2pa(struct Page *page) {
  104066:	55                   	push   %ebp
  104067:	89 e5                	mov    %esp,%ebp
    return page2ppn(page) << PGSHIFT;
  104069:	ff 75 08             	pushl  0x8(%ebp)
  10406c:	e8 db ff ff ff       	call   10404c <page2ppn>
  104071:	83 c4 04             	add    $0x4,%esp
  104074:	c1 e0 0c             	shl    $0xc,%eax
}
  104077:	c9                   	leave  
  104078:	c3                   	ret    

00104079 <page_ref>:
page_ref(struct Page *page) {
  104079:	55                   	push   %ebp
  10407a:	89 e5                	mov    %esp,%ebp
    return page->ref;
  10407c:	8b 45 08             	mov    0x8(%ebp),%eax
  10407f:	8b 00                	mov    (%eax),%eax
}
  104081:	5d                   	pop    %ebp
  104082:	c3                   	ret    

00104083 <set_page_ref>:
set_page_ref(struct Page *page, int val) {
  104083:	55                   	push   %ebp
  104084:	89 e5                	mov    %esp,%ebp
    page->ref = val;
  104086:	8b 45 08             	mov    0x8(%ebp),%eax
  104089:	8b 55 0c             	mov    0xc(%ebp),%edx
  10408c:	89 10                	mov    %edx,(%eax)
}
  10408e:	90                   	nop
  10408f:	5d                   	pop    %ebp
  104090:	c3                   	ret    

00104091 <default_init>:

#define free_list (free_area.free_list)
#define nr_free (free_area.nr_free)

static void
default_init(void) {
  104091:	f3 0f 1e fb          	endbr32 
  104095:	55                   	push   %ebp
  104096:	89 e5                	mov    %esp,%ebp
  104098:	83 ec 10             	sub    $0x10,%esp
  10409b:	c7 45 fc 5c a9 11 00 	movl   $0x11a95c,-0x4(%ebp)
 * list_init - initialize a new entry
 * @elm:        new entry to be initialized
 * */
static inline void
list_init(list_entry_t *elm) {
    elm->prev = elm->next = elm;
  1040a2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1040a5:	8b 55 fc             	mov    -0x4(%ebp),%edx
  1040a8:	89 50 04             	mov    %edx,0x4(%eax)
  1040ab:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1040ae:	8b 50 04             	mov    0x4(%eax),%edx
  1040b1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1040b4:	89 10                	mov    %edx,(%eax)
}
  1040b6:	90                   	nop
    list_init(&free_list);//空闲链表初始化
    nr_free = 0;//初始空闲页为0
  1040b7:	c7 05 64 a9 11 00 00 	movl   $0x0,0x11a964
  1040be:	00 00 00 
}
  1040c1:	90                   	nop
  1040c2:	c9                   	leave  
  1040c3:	c3                   	ret    

001040c4 <default_init_memmap>:

static void
default_init_memmap(struct Page *base, size_t n) {
  1040c4:	f3 0f 1e fb          	endbr32 
  1040c8:	55                   	push   %ebp
  1040c9:	89 e5                	mov    %esp,%ebp
  1040cb:	83 ec 48             	sub    $0x48,%esp

    assert(n > 0);
  1040ce:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  1040d2:	75 16                	jne    1040ea <default_init_memmap+0x26>
  1040d4:	68 70 6a 10 00       	push   $0x106a70
  1040d9:	68 76 6a 10 00       	push   $0x106a76
  1040de:	6a 47                	push   $0x47
  1040e0:	68 8b 6a 10 00       	push   $0x106a8b
  1040e5:	e8 20 c3 ff ff       	call   10040a <__panic>
    struct Page *p = base;
  1040ea:	8b 45 08             	mov    0x8(%ebp),%eax
  1040ed:	89 45 f4             	mov    %eax,-0xc(%ebp)
    for (; p != base + n; p ++) {
  1040f0:	e9 84 00 00 00       	jmp    104179 <default_init_memmap+0xb5>
        assert(PageReserved(p));//p是一个预留页
  1040f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1040f8:	83 c0 04             	add    $0x4,%eax
  1040fb:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  104102:	89 45 ec             	mov    %eax,-0x14(%ebp)
 * @addr:   the address to count from
 * */
static inline bool
test_bit(int nr, volatile void *addr) {
    int oldbit;
    asm volatile ("btl %2, %1; sbbl %0,%0" : "=r" (oldbit) : "m" (*(volatile long *)addr), "Ir" (nr));
  104105:	8b 45 ec             	mov    -0x14(%ebp),%eax
  104108:	8b 55 f0             	mov    -0x10(%ebp),%edx
  10410b:	0f a3 10             	bt     %edx,(%eax)
  10410e:	19 c0                	sbb    %eax,%eax
  104110:	89 45 e8             	mov    %eax,-0x18(%ebp)
    return oldbit != 0;
  104113:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  104117:	0f 95 c0             	setne  %al
  10411a:	0f b6 c0             	movzbl %al,%eax
  10411d:	85 c0                	test   %eax,%eax
  10411f:	75 16                	jne    104137 <default_init_memmap+0x73>
  104121:	68 a1 6a 10 00       	push   $0x106aa1
  104126:	68 76 6a 10 00       	push   $0x106a76
  10412b:	6a 4a                	push   $0x4a
  10412d:	68 8b 6a 10 00       	push   $0x106a8b
  104132:	e8 d3 c2 ff ff       	call   10040a <__panic>
        p->flags = 0;        
  104137:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10413a:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
        p->property = 0;
  104141:	8b 45 f4             	mov    -0xc(%ebp),%eax
  104144:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
        set_page_ref(p, 0);//映射到此页的虚拟页个数为0
  10414b:	83 ec 08             	sub    $0x8,%esp
  10414e:	6a 00                	push   $0x0
  104150:	ff 75 f4             	pushl  -0xc(%ebp)
  104153:	e8 2b ff ff ff       	call   104083 <set_page_ref>
  104158:	83 c4 10             	add    $0x10,%esp
        SetPageProperty(p);//标记为空页面
  10415b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10415e:	83 c0 04             	add    $0x4,%eax
  104161:	c7 45 e4 01 00 00 00 	movl   $0x1,-0x1c(%ebp)
  104168:	89 45 e0             	mov    %eax,-0x20(%ebp)
    asm volatile ("btsl %1, %0" :"=m" (*(volatile long *)addr) : "Ir" (nr));
  10416b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  10416e:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  104171:	0f ab 10             	bts    %edx,(%eax)
}
  104174:	90                   	nop
    for (; p != base + n; p ++) {
  104175:	83 45 f4 14          	addl   $0x14,-0xc(%ebp)
  104179:	8b 55 0c             	mov    0xc(%ebp),%edx
  10417c:	89 d0                	mov    %edx,%eax
  10417e:	c1 e0 02             	shl    $0x2,%eax
  104181:	01 d0                	add    %edx,%eax
  104183:	c1 e0 02             	shl    $0x2,%eax
  104186:	89 c2                	mov    %eax,%edx
  104188:	8b 45 08             	mov    0x8(%ebp),%eax
  10418b:	01 d0                	add    %edx,%eax
  10418d:	39 45 f4             	cmp    %eax,-0xc(%ebp)
  104190:	0f 85 5f ff ff ff    	jne    1040f5 <default_init_memmap+0x31>
         
    	//list_add_before(&free_list, &(p->page_link));//加入空页链表       
    }
    base->property = n;//连续的n个空页面
  104196:	8b 45 08             	mov    0x8(%ebp),%eax
  104199:	8b 55 0c             	mov    0xc(%ebp),%edx
  10419c:	89 50 08             	mov    %edx,0x8(%eax)
    //SetPageProperty(base);
    nr_free += n;//剩余空页面增加n个
  10419f:	8b 15 64 a9 11 00    	mov    0x11a964,%edx
  1041a5:	8b 45 0c             	mov    0xc(%ebp),%eax
  1041a8:	01 d0                	add    %edx,%eax
  1041aa:	a3 64 a9 11 00       	mov    %eax,0x11a964
    list_add(&free_list, &(base->page_link));//将第一页加入空页链表
  1041af:	8b 45 08             	mov    0x8(%ebp),%eax
  1041b2:	83 c0 0c             	add    $0xc,%eax
  1041b5:	c7 45 dc 5c a9 11 00 	movl   $0x11a95c,-0x24(%ebp)
  1041bc:	89 45 d8             	mov    %eax,-0x28(%ebp)
  1041bf:	8b 45 dc             	mov    -0x24(%ebp),%eax
  1041c2:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  1041c5:	8b 45 d8             	mov    -0x28(%ebp),%eax
  1041c8:	89 45 d0             	mov    %eax,-0x30(%ebp)
 * Insert the new element @elm *after* the element @listelm which
 * is already in the list.
 * */
static inline void
list_add_after(list_entry_t *listelm, list_entry_t *elm) {
    __list_add(elm, listelm, listelm->next);
  1041cb:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  1041ce:	8b 40 04             	mov    0x4(%eax),%eax
  1041d1:	8b 55 d0             	mov    -0x30(%ebp),%edx
  1041d4:	89 55 cc             	mov    %edx,-0x34(%ebp)
  1041d7:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  1041da:	89 55 c8             	mov    %edx,-0x38(%ebp)
  1041dd:	89 45 c4             	mov    %eax,-0x3c(%ebp)
 * This is only for internal list manipulation where we know
 * the prev/next entries already!
 * */
static inline void
__list_add(list_entry_t *elm, list_entry_t *prev, list_entry_t *next) {
    prev->next = next->prev = elm;
  1041e0:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  1041e3:	8b 55 cc             	mov    -0x34(%ebp),%edx
  1041e6:	89 10                	mov    %edx,(%eax)
  1041e8:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  1041eb:	8b 10                	mov    (%eax),%edx
  1041ed:	8b 45 c8             	mov    -0x38(%ebp),%eax
  1041f0:	89 50 04             	mov    %edx,0x4(%eax)
    elm->next = next;
  1041f3:	8b 45 cc             	mov    -0x34(%ebp),%eax
  1041f6:	8b 55 c4             	mov    -0x3c(%ebp),%edx
  1041f9:	89 50 04             	mov    %edx,0x4(%eax)
    elm->prev = prev;
  1041fc:	8b 45 cc             	mov    -0x34(%ebp),%eax
  1041ff:	8b 55 c8             	mov    -0x38(%ebp),%edx
  104202:	89 10                	mov    %edx,(%eax)
}
  104204:	90                   	nop
}
  104205:	90                   	nop
}
  104206:	90                   	nop
	
}
  104207:	90                   	nop
  104208:	c9                   	leave  
  104209:	c3                   	ret    

0010420a <default_alloc_pages>:

static struct Page *
default_alloc_pages(size_t n) {
  10420a:	f3 0f 1e fb          	endbr32 
  10420e:	55                   	push   %ebp
  10420f:	89 e5                	mov    %esp,%ebp
  104211:	83 ec 58             	sub    $0x58,%esp
    assert(n > 0);
  104214:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  104218:	75 16                	jne    104230 <default_alloc_pages+0x26>
  10421a:	68 70 6a 10 00       	push   $0x106a70
  10421f:	68 76 6a 10 00       	push   $0x106a76
  104224:	6a 5b                	push   $0x5b
  104226:	68 8b 6a 10 00       	push   $0x106a8b
  10422b:	e8 da c1 ff ff       	call   10040a <__panic>
    if (n > nr_free) {
  104230:	a1 64 a9 11 00       	mov    0x11a964,%eax
  104235:	39 45 08             	cmp    %eax,0x8(%ebp)
  104238:	76 0a                	jbe    104244 <default_alloc_pages+0x3a>
    	//大于剩余空页，无法分配
        return NULL;
  10423a:	b8 00 00 00 00       	mov    $0x0,%eax
  10423f:	e9 7a 01 00 00       	jmp    1043be <default_alloc_pages+0x1b4>
    }
    struct Page *page = NULL;
  104244:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    list_entry_t *le = &free_list;
  10424b:	c7 45 f0 5c a9 11 00 	movl   $0x11a95c,-0x10(%ebp)
    
    while ((le = list_next(le)) != &free_list) {
  104252:	eb 1c                	jmp    104270 <default_alloc_pages+0x66>
        struct Page *p = le2page(le, page_link);
  104254:	8b 45 f0             	mov    -0x10(%ebp),%eax
  104257:	83 e8 0c             	sub    $0xc,%eax
  10425a:	89 45 e8             	mov    %eax,-0x18(%ebp)
        if (p->property >= n) {
  10425d:	8b 45 e8             	mov    -0x18(%ebp),%eax
  104260:	8b 40 08             	mov    0x8(%eax),%eax
  104263:	39 45 08             	cmp    %eax,0x8(%ebp)
  104266:	77 08                	ja     104270 <default_alloc_pages+0x66>
            page = p;//找到第一个适合的页
  104268:	8b 45 e8             	mov    -0x18(%ebp),%eax
  10426b:	89 45 f4             	mov    %eax,-0xc(%ebp)
            break;
  10426e:	eb 18                	jmp    104288 <default_alloc_pages+0x7e>
  104270:	8b 45 f0             	mov    -0x10(%ebp),%eax
  104273:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    return listelm->next;
  104276:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  104279:	8b 40 04             	mov    0x4(%eax),%eax
    while ((le = list_next(le)) != &free_list) {
  10427c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  10427f:	81 7d f0 5c a9 11 00 	cmpl   $0x11a95c,-0x10(%ebp)
  104286:	75 cc                	jne    104254 <default_alloc_pages+0x4a>
        }
    }
    if (page != NULL) {
  104288:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  10428c:	0f 84 29 01 00 00    	je     1043bb <default_alloc_pages+0x1b1>
    	
    	struct Page *p;
    	
    	for (p = page; p != (page + n); ++p) {
  104292:	8b 45 f4             	mov    -0xc(%ebp),%eax
  104295:	89 45 ec             	mov    %eax,-0x14(%ebp)
  104298:	eb 1e                	jmp    1042b8 <default_alloc_pages+0xae>
        ClearPageProperty(p); // 将分配出去的内存页标记为非空闲
  10429a:	8b 45 ec             	mov    -0x14(%ebp),%eax
  10429d:	83 c0 04             	add    $0x4,%eax
  1042a0:	c7 45 e0 01 00 00 00 	movl   $0x1,-0x20(%ebp)
  1042a7:	89 45 dc             	mov    %eax,-0x24(%ebp)
    asm volatile ("btrl %1, %0" :"=m" (*(volatile long *)addr) : "Ir" (nr));
  1042aa:	8b 45 dc             	mov    -0x24(%ebp),%eax
  1042ad:	8b 55 e0             	mov    -0x20(%ebp),%edx
  1042b0:	0f b3 10             	btr    %edx,(%eax)
}
  1042b3:	90                   	nop
    	for (p = page; p != (page + n); ++p) {
  1042b4:	83 45 ec 14          	addl   $0x14,-0x14(%ebp)
  1042b8:	8b 55 08             	mov    0x8(%ebp),%edx
  1042bb:	89 d0                	mov    %edx,%eax
  1042bd:	c1 e0 02             	shl    $0x2,%eax
  1042c0:	01 d0                	add    %edx,%eax
  1042c2:	c1 e0 02             	shl    $0x2,%eax
  1042c5:	89 c2                	mov    %eax,%edx
  1042c7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1042ca:	01 d0                	add    %edx,%eax
  1042cc:	39 45 ec             	cmp    %eax,-0x14(%ebp)
  1042cf:	75 c9                	jne    10429a <default_alloc_pages+0x90>
    }
    	
        list_del(&(page->page_link));//从空闲页链表中删除
  1042d1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1042d4:	83 c0 0c             	add    $0xc,%eax
  1042d7:	89 45 d8             	mov    %eax,-0x28(%ebp)
    __list_del(listelm->prev, listelm->next);
  1042da:	8b 45 d8             	mov    -0x28(%ebp),%eax
  1042dd:	8b 40 04             	mov    0x4(%eax),%eax
  1042e0:	8b 55 d8             	mov    -0x28(%ebp),%edx
  1042e3:	8b 12                	mov    (%edx),%edx
  1042e5:	89 55 d4             	mov    %edx,-0x2c(%ebp)
  1042e8:	89 45 d0             	mov    %eax,-0x30(%ebp)
 * This is only for internal list manipulation where we know
 * the prev/next entries already!
 * */
static inline void
__list_del(list_entry_t *prev, list_entry_t *next) {
    prev->next = next;
  1042eb:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  1042ee:	8b 55 d0             	mov    -0x30(%ebp),%edx
  1042f1:	89 50 04             	mov    %edx,0x4(%eax)
    next->prev = prev;
  1042f4:	8b 45 d0             	mov    -0x30(%ebp),%eax
  1042f7:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  1042fa:	89 10                	mov    %edx,(%eax)
}
  1042fc:	90                   	nop
}
  1042fd:	90                   	nop
        if (page->property > n) {
  1042fe:	8b 45 f4             	mov    -0xc(%ebp),%eax
  104301:	8b 40 08             	mov    0x8(%eax),%eax
  104304:	39 45 08             	cmp    %eax,0x8(%ebp)
  104307:	0f 83 87 00 00 00    	jae    104394 <default_alloc_pages+0x18a>
            p = page + n;//跳到最近的空页
  10430d:	8b 55 08             	mov    0x8(%ebp),%edx
  104310:	89 d0                	mov    %edx,%eax
  104312:	c1 e0 02             	shl    $0x2,%eax
  104315:	01 d0                	add    %edx,%eax
  104317:	c1 e0 02             	shl    $0x2,%eax
  10431a:	89 c2                	mov    %eax,%edx
  10431c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10431f:	01 d0                	add    %edx,%eax
  104321:	89 45 ec             	mov    %eax,-0x14(%ebp)
            p->property = page->property - n;//重新计算剩余空间
  104324:	8b 45 f4             	mov    -0xc(%ebp),%eax
  104327:	8b 40 08             	mov    0x8(%eax),%eax
  10432a:	2b 45 08             	sub    0x8(%ebp),%eax
  10432d:	89 c2                	mov    %eax,%edx
  10432f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  104332:	89 50 08             	mov    %edx,0x8(%eax)
            //list_add(&free_list, &(p->page_link));
            //加入空闲页链表中,注意按顺序加
            list_add(list_prev(le), &(p->page_link));
  104335:	8b 45 ec             	mov    -0x14(%ebp),%eax
  104338:	8d 50 0c             	lea    0xc(%eax),%edx
  10433b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10433e:	89 45 b0             	mov    %eax,-0x50(%ebp)
    return listelm->prev;
  104341:	8b 45 b0             	mov    -0x50(%ebp),%eax
  104344:	8b 00                	mov    (%eax),%eax
  104346:	89 45 cc             	mov    %eax,-0x34(%ebp)
  104349:	89 55 c8             	mov    %edx,-0x38(%ebp)
  10434c:	8b 45 cc             	mov    -0x34(%ebp),%eax
  10434f:	89 45 c4             	mov    %eax,-0x3c(%ebp)
  104352:	8b 45 c8             	mov    -0x38(%ebp),%eax
  104355:	89 45 c0             	mov    %eax,-0x40(%ebp)
    __list_add(elm, listelm, listelm->next);
  104358:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  10435b:	8b 40 04             	mov    0x4(%eax),%eax
  10435e:	8b 55 c0             	mov    -0x40(%ebp),%edx
  104361:	89 55 bc             	mov    %edx,-0x44(%ebp)
  104364:	8b 55 c4             	mov    -0x3c(%ebp),%edx
  104367:	89 55 b8             	mov    %edx,-0x48(%ebp)
  10436a:	89 45 b4             	mov    %eax,-0x4c(%ebp)
    prev->next = next->prev = elm;
  10436d:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  104370:	8b 55 bc             	mov    -0x44(%ebp),%edx
  104373:	89 10                	mov    %edx,(%eax)
  104375:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  104378:	8b 10                	mov    (%eax),%edx
  10437a:	8b 45 b8             	mov    -0x48(%ebp),%eax
  10437d:	89 50 04             	mov    %edx,0x4(%eax)
    elm->next = next;
  104380:	8b 45 bc             	mov    -0x44(%ebp),%eax
  104383:	8b 55 b4             	mov    -0x4c(%ebp),%edx
  104386:	89 50 04             	mov    %edx,0x4(%eax)
    elm->prev = prev;
  104389:	8b 45 bc             	mov    -0x44(%ebp),%eax
  10438c:	8b 55 b8             	mov    -0x48(%ebp),%edx
  10438f:	89 10                	mov    %edx,(%eax)
}
  104391:	90                   	nop
}
  104392:	90                   	nop
}
  104393:	90                   	nop
    }
        nr_free -= n;//剩余页数量减少
  104394:	a1 64 a9 11 00       	mov    0x11a964,%eax
  104399:	2b 45 08             	sub    0x8(%ebp),%eax
  10439c:	a3 64 a9 11 00       	mov    %eax,0x11a964
        ClearPageProperty(page);
  1043a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1043a4:	83 c0 04             	add    $0x4,%eax
  1043a7:	c7 45 ac 01 00 00 00 	movl   $0x1,-0x54(%ebp)
  1043ae:	89 45 a8             	mov    %eax,-0x58(%ebp)
    asm volatile ("btrl %1, %0" :"=m" (*(volatile long *)addr) : "Ir" (nr));
  1043b1:	8b 45 a8             	mov    -0x58(%ebp),%eax
  1043b4:	8b 55 ac             	mov    -0x54(%ebp),%edx
  1043b7:	0f b3 10             	btr    %edx,(%eax)
}
  1043ba:	90                   	nop
    }
    return page;
  1043bb:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  1043be:	c9                   	leave  
  1043bf:	c3                   	ret    

001043c0 <default_free_pages>:

static void
default_free_pages(struct Page *base, size_t n) {
  1043c0:	f3 0f 1e fb          	endbr32 
  1043c4:	55                   	push   %ebp
  1043c5:	89 e5                	mov    %esp,%ebp
  1043c7:	81 ec b8 00 00 00    	sub    $0xb8,%esp
    assert(n > 0);
  1043cd:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  1043d1:	75 19                	jne    1043ec <default_free_pages+0x2c>
  1043d3:	68 70 6a 10 00       	push   $0x106a70
  1043d8:	68 76 6a 10 00       	push   $0x106a76
  1043dd:	68 82 00 00 00       	push   $0x82
  1043e2:	68 8b 6a 10 00       	push   $0x106a8b
  1043e7:	e8 1e c0 ff ff       	call   10040a <__panic>
    struct Page *p = base;
  1043ec:	8b 45 08             	mov    0x8(%ebp),%eax
  1043ef:	89 45 f4             	mov    %eax,-0xc(%ebp)
    for (; p != base + n; p ++) {
  1043f2:	e9 9f 00 00 00       	jmp    104496 <default_free_pages+0xd6>
        assert(!PageReserved(p) && !PageProperty(p));
  1043f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1043fa:	83 c0 04             	add    $0x4,%eax
  1043fd:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  104404:	89 45 e0             	mov    %eax,-0x20(%ebp)
    asm volatile ("btl %2, %1; sbbl %0,%0" : "=r" (oldbit) : "m" (*(volatile long *)addr), "Ir" (nr));
  104407:	8b 45 e0             	mov    -0x20(%ebp),%eax
  10440a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  10440d:	0f a3 10             	bt     %edx,(%eax)
  104410:	19 c0                	sbb    %eax,%eax
  104412:	89 45 dc             	mov    %eax,-0x24(%ebp)
    return oldbit != 0;
  104415:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  104419:	0f 95 c0             	setne  %al
  10441c:	0f b6 c0             	movzbl %al,%eax
  10441f:	85 c0                	test   %eax,%eax
  104421:	75 2c                	jne    10444f <default_free_pages+0x8f>
  104423:	8b 45 f4             	mov    -0xc(%ebp),%eax
  104426:	83 c0 04             	add    $0x4,%eax
  104429:	c7 45 d8 01 00 00 00 	movl   $0x1,-0x28(%ebp)
  104430:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    asm volatile ("btl %2, %1; sbbl %0,%0" : "=r" (oldbit) : "m" (*(volatile long *)addr), "Ir" (nr));
  104433:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  104436:	8b 55 d8             	mov    -0x28(%ebp),%edx
  104439:	0f a3 10             	bt     %edx,(%eax)
  10443c:	19 c0                	sbb    %eax,%eax
  10443e:	89 45 d0             	mov    %eax,-0x30(%ebp)
    return oldbit != 0;
  104441:	83 7d d0 00          	cmpl   $0x0,-0x30(%ebp)
  104445:	0f 95 c0             	setne  %al
  104448:	0f b6 c0             	movzbl %al,%eax
  10444b:	85 c0                	test   %eax,%eax
  10444d:	74 19                	je     104468 <default_free_pages+0xa8>
  10444f:	68 b4 6a 10 00       	push   $0x106ab4
  104454:	68 76 6a 10 00       	push   $0x106a76
  104459:	68 85 00 00 00       	push   $0x85
  10445e:	68 8b 6a 10 00       	push   $0x106a8b
  104463:	e8 a2 bf ff ff       	call   10040a <__panic>
        SetPageProperty(p);
  104468:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10446b:	83 c0 04             	add    $0x4,%eax
  10446e:	c7 45 cc 01 00 00 00 	movl   $0x1,-0x34(%ebp)
  104475:	89 45 c8             	mov    %eax,-0x38(%ebp)
    asm volatile ("btsl %1, %0" :"=m" (*(volatile long *)addr) : "Ir" (nr));
  104478:	8b 45 c8             	mov    -0x38(%ebp),%eax
  10447b:	8b 55 cc             	mov    -0x34(%ebp),%edx
  10447e:	0f ab 10             	bts    %edx,(%eax)
}
  104481:	90                   	nop
        set_page_ref(p, 0);//指向此页的虚拟页为0
  104482:	83 ec 08             	sub    $0x8,%esp
  104485:	6a 00                	push   $0x0
  104487:	ff 75 f4             	pushl  -0xc(%ebp)
  10448a:	e8 f4 fb ff ff       	call   104083 <set_page_ref>
  10448f:	83 c4 10             	add    $0x10,%esp
    for (; p != base + n; p ++) {
  104492:	83 45 f4 14          	addl   $0x14,-0xc(%ebp)
  104496:	8b 55 0c             	mov    0xc(%ebp),%edx
  104499:	89 d0                	mov    %edx,%eax
  10449b:	c1 e0 02             	shl    $0x2,%eax
  10449e:	01 d0                	add    %edx,%eax
  1044a0:	c1 e0 02             	shl    $0x2,%eax
  1044a3:	89 c2                	mov    %eax,%edx
  1044a5:	8b 45 08             	mov    0x8(%ebp),%eax
  1044a8:	01 d0                	add    %edx,%eax
  1044aa:	39 45 f4             	cmp    %eax,-0xc(%ebp)
  1044ad:	0f 85 44 ff ff ff    	jne    1043f7 <default_free_pages+0x37>
    }
    base->property = n;//设置空闲块大小
  1044b3:	8b 45 08             	mov    0x8(%ebp),%eax
  1044b6:	8b 55 0c             	mov    0xc(%ebp),%edx
  1044b9:	89 50 08             	mov    %edx,0x8(%eax)
  1044bc:	c7 45 c4 5c a9 11 00 	movl   $0x11a95c,-0x3c(%ebp)
    return listelm->next;
  1044c3:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  1044c6:	8b 40 04             	mov    0x4(%eax),%eax
    //SetPageProperty(base);
    list_entry_t *le = list_next(&free_list);
  1044c9:	89 45 f0             	mov    %eax,-0x10(%ebp)
    while (le != &free_list) {
  1044cc:	e9 0e 01 00 00       	jmp    1045df <default_free_pages+0x21f>
    	//遍历空闲链表中的每个页
        p = le2page(le, page_link);
  1044d1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1044d4:	83 e8 0c             	sub    $0xc,%eax
  1044d7:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1044da:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1044dd:	89 45 c0             	mov    %eax,-0x40(%ebp)
  1044e0:	8b 45 c0             	mov    -0x40(%ebp),%eax
  1044e3:	8b 40 04             	mov    0x4(%eax),%eax
        le = list_next(le);
  1044e6:	89 45 f0             	mov    %eax,-0x10(%ebp)
        if (base + base->property == p) {
  1044e9:	8b 45 08             	mov    0x8(%ebp),%eax
  1044ec:	8b 50 08             	mov    0x8(%eax),%edx
  1044ef:	89 d0                	mov    %edx,%eax
  1044f1:	c1 e0 02             	shl    $0x2,%eax
  1044f4:	01 d0                	add    %edx,%eax
  1044f6:	c1 e0 02             	shl    $0x2,%eax
  1044f9:	89 c2                	mov    %eax,%edx
  1044fb:	8b 45 08             	mov    0x8(%ebp),%eax
  1044fe:	01 d0                	add    %edx,%eax
  104500:	39 45 f4             	cmp    %eax,-0xc(%ebp)
  104503:	75 5d                	jne    104562 <default_free_pages+0x1a2>
        //如果当前页可以连在base的后面
            base->property += p->property;
  104505:	8b 45 08             	mov    0x8(%ebp),%eax
  104508:	8b 50 08             	mov    0x8(%eax),%edx
  10450b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10450e:	8b 40 08             	mov    0x8(%eax),%eax
  104511:	01 c2                	add    %eax,%edx
  104513:	8b 45 08             	mov    0x8(%ebp),%eax
  104516:	89 50 08             	mov    %edx,0x8(%eax)
            ClearPageProperty(p);
  104519:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10451c:	83 c0 04             	add    $0x4,%eax
  10451f:	c7 45 b0 01 00 00 00 	movl   $0x1,-0x50(%ebp)
  104526:	89 45 ac             	mov    %eax,-0x54(%ebp)
    asm volatile ("btrl %1, %0" :"=m" (*(volatile long *)addr) : "Ir" (nr));
  104529:	8b 45 ac             	mov    -0x54(%ebp),%eax
  10452c:	8b 55 b0             	mov    -0x50(%ebp),%edx
  10452f:	0f b3 10             	btr    %edx,(%eax)
}
  104532:	90                   	nop
            list_del(&(p->page_link));
  104533:	8b 45 f4             	mov    -0xc(%ebp),%eax
  104536:	83 c0 0c             	add    $0xc,%eax
  104539:	89 45 bc             	mov    %eax,-0x44(%ebp)
    __list_del(listelm->prev, listelm->next);
  10453c:	8b 45 bc             	mov    -0x44(%ebp),%eax
  10453f:	8b 40 04             	mov    0x4(%eax),%eax
  104542:	8b 55 bc             	mov    -0x44(%ebp),%edx
  104545:	8b 12                	mov    (%edx),%edx
  104547:	89 55 b8             	mov    %edx,-0x48(%ebp)
  10454a:	89 45 b4             	mov    %eax,-0x4c(%ebp)
    prev->next = next;
  10454d:	8b 45 b8             	mov    -0x48(%ebp),%eax
  104550:	8b 55 b4             	mov    -0x4c(%ebp),%edx
  104553:	89 50 04             	mov    %edx,0x4(%eax)
    next->prev = prev;
  104556:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  104559:	8b 55 b8             	mov    -0x48(%ebp),%edx
  10455c:	89 10                	mov    %edx,(%eax)
}
  10455e:	90                   	nop
}
  10455f:	90                   	nop
  104560:	eb 7d                	jmp    1045df <default_free_pages+0x21f>
        }
        else if (p + p->property == base) {
  104562:	8b 45 f4             	mov    -0xc(%ebp),%eax
  104565:	8b 50 08             	mov    0x8(%eax),%edx
  104568:	89 d0                	mov    %edx,%eax
  10456a:	c1 e0 02             	shl    $0x2,%eax
  10456d:	01 d0                	add    %edx,%eax
  10456f:	c1 e0 02             	shl    $0x2,%eax
  104572:	89 c2                	mov    %eax,%edx
  104574:	8b 45 f4             	mov    -0xc(%ebp),%eax
  104577:	01 d0                	add    %edx,%eax
  104579:	39 45 08             	cmp    %eax,0x8(%ebp)
  10457c:	75 61                	jne    1045df <default_free_pages+0x21f>
        //如果base可以连在当前页的后面
            p->property += base->property;
  10457e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  104581:	8b 50 08             	mov    0x8(%eax),%edx
  104584:	8b 45 08             	mov    0x8(%ebp),%eax
  104587:	8b 40 08             	mov    0x8(%eax),%eax
  10458a:	01 c2                	add    %eax,%edx
  10458c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10458f:	89 50 08             	mov    %edx,0x8(%eax)
            ClearPageProperty(base);
  104592:	8b 45 08             	mov    0x8(%ebp),%eax
  104595:	83 c0 04             	add    $0x4,%eax
  104598:	c7 45 9c 01 00 00 00 	movl   $0x1,-0x64(%ebp)
  10459f:	89 45 98             	mov    %eax,-0x68(%ebp)
    asm volatile ("btrl %1, %0" :"=m" (*(volatile long *)addr) : "Ir" (nr));
  1045a2:	8b 45 98             	mov    -0x68(%ebp),%eax
  1045a5:	8b 55 9c             	mov    -0x64(%ebp),%edx
  1045a8:	0f b3 10             	btr    %edx,(%eax)
}
  1045ab:	90                   	nop
            base = p;
  1045ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1045af:	89 45 08             	mov    %eax,0x8(%ebp)
            list_del(&(p->page_link));
  1045b2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1045b5:	83 c0 0c             	add    $0xc,%eax
  1045b8:	89 45 a8             	mov    %eax,-0x58(%ebp)
    __list_del(listelm->prev, listelm->next);
  1045bb:	8b 45 a8             	mov    -0x58(%ebp),%eax
  1045be:	8b 40 04             	mov    0x4(%eax),%eax
  1045c1:	8b 55 a8             	mov    -0x58(%ebp),%edx
  1045c4:	8b 12                	mov    (%edx),%edx
  1045c6:	89 55 a4             	mov    %edx,-0x5c(%ebp)
  1045c9:	89 45 a0             	mov    %eax,-0x60(%ebp)
    prev->next = next;
  1045cc:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  1045cf:	8b 55 a0             	mov    -0x60(%ebp),%edx
  1045d2:	89 50 04             	mov    %edx,0x4(%eax)
    next->prev = prev;
  1045d5:	8b 45 a0             	mov    -0x60(%ebp),%eax
  1045d8:	8b 55 a4             	mov    -0x5c(%ebp),%edx
  1045db:	89 10                	mov    %edx,(%eax)
}
  1045dd:	90                   	nop
}
  1045de:	90                   	nop
    while (le != &free_list) {
  1045df:	81 7d f0 5c a9 11 00 	cmpl   $0x11a95c,-0x10(%ebp)
  1045e6:	0f 85 e5 fe ff ff    	jne    1044d1 <default_free_pages+0x111>
        }
    }
    nr_free += n;//剩余空页增加n
  1045ec:	8b 15 64 a9 11 00    	mov    0x11a964,%edx
  1045f2:	8b 45 0c             	mov    0xc(%ebp),%eax
  1045f5:	01 d0                	add    %edx,%eax
  1045f7:	a3 64 a9 11 00       	mov    %eax,0x11a964
  1045fc:	c7 45 94 5c a9 11 00 	movl   $0x11a95c,-0x6c(%ebp)
    return listelm->next;
  104603:	8b 45 94             	mov    -0x6c(%ebp),%eax
  104606:	8b 40 04             	mov    0x4(%eax),%eax
    //将空闲块的基页加入到链表中,按顺序！！
    //list_add(&free_list, &(base->page_link));
    le=list_next(&free_list);
  104609:	89 45 f0             	mov    %eax,-0x10(%ebp)
    int flag=0;    
  10460c:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    while(le!=&free_list)
  104613:	e9 4c 01 00 00       	jmp    104764 <default_free_pages+0x3a4>
    {
    	//遍历空闲页表
    	p=le2page(le,page_link);
  104618:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10461b:	83 e8 0c             	sub    $0xc,%eax
  10461e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  104621:	8b 45 f0             	mov    -0x10(%ebp),%eax
  104624:	89 45 90             	mov    %eax,-0x70(%ebp)
  104627:	8b 45 90             	mov    -0x70(%ebp),%eax
  10462a:	8b 40 04             	mov    0x4(%eax),%eax
    	le=list_next(le);
  10462d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    	struct Page *q=le2page(le,page_link);
  104630:	8b 45 f0             	mov    -0x10(%ebp),%eax
  104633:	83 e8 0c             	sub    $0xc,%eax
  104636:	89 45 e8             	mov    %eax,-0x18(%ebp)
    	if(p>base)//插入头部
  104639:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10463c:	3b 45 08             	cmp    0x8(%ebp),%eax
  10463f:	0f 86 85 00 00 00    	jbe    1046ca <default_free_pages+0x30a>
    	{
    		list_add(&free_list,&(base->page_link));
  104645:	8b 45 08             	mov    0x8(%ebp),%eax
  104648:	83 c0 0c             	add    $0xc,%eax
  10464b:	c7 45 8c 5c a9 11 00 	movl   $0x11a95c,-0x74(%ebp)
  104652:	89 45 88             	mov    %eax,-0x78(%ebp)
  104655:	8b 45 8c             	mov    -0x74(%ebp),%eax
  104658:	89 45 84             	mov    %eax,-0x7c(%ebp)
  10465b:	8b 45 88             	mov    -0x78(%ebp),%eax
  10465e:	89 45 80             	mov    %eax,-0x80(%ebp)
    __list_add(elm, listelm, listelm->next);
  104661:	8b 45 84             	mov    -0x7c(%ebp),%eax
  104664:	8b 40 04             	mov    0x4(%eax),%eax
  104667:	8b 55 80             	mov    -0x80(%ebp),%edx
  10466a:	89 95 7c ff ff ff    	mov    %edx,-0x84(%ebp)
  104670:	8b 55 84             	mov    -0x7c(%ebp),%edx
  104673:	89 95 78 ff ff ff    	mov    %edx,-0x88(%ebp)
  104679:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%ebp)
    prev->next = next->prev = elm;
  10467f:	8b 85 74 ff ff ff    	mov    -0x8c(%ebp),%eax
  104685:	8b 95 7c ff ff ff    	mov    -0x84(%ebp),%edx
  10468b:	89 10                	mov    %edx,(%eax)
  10468d:	8b 85 74 ff ff ff    	mov    -0x8c(%ebp),%eax
  104693:	8b 10                	mov    (%eax),%edx
  104695:	8b 85 78 ff ff ff    	mov    -0x88(%ebp),%eax
  10469b:	89 50 04             	mov    %edx,0x4(%eax)
    elm->next = next;
  10469e:	8b 85 7c ff ff ff    	mov    -0x84(%ebp),%eax
  1046a4:	8b 95 74 ff ff ff    	mov    -0x8c(%ebp),%edx
  1046aa:	89 50 04             	mov    %edx,0x4(%eax)
    elm->prev = prev;
  1046ad:	8b 85 7c ff ff ff    	mov    -0x84(%ebp),%eax
  1046b3:	8b 95 78 ff ff ff    	mov    -0x88(%ebp),%edx
  1046b9:	89 10                	mov    %edx,(%eax)
}
  1046bb:	90                   	nop
}
  1046bc:	90                   	nop
}
  1046bd:	90                   	nop
    		flag=1;
  1046be:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
    		break;
  1046c5:	e9 a7 00 00 00       	jmp    104771 <default_free_pages+0x3b1>
    	}
    	if(p<base&&base<q)//插入中间
  1046ca:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1046cd:	3b 45 08             	cmp    0x8(%ebp),%eax
  1046d0:	0f 83 8e 00 00 00    	jae    104764 <default_free_pages+0x3a4>
  1046d6:	8b 45 08             	mov    0x8(%ebp),%eax
  1046d9:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  1046dc:	0f 83 82 00 00 00    	jae    104764 <default_free_pages+0x3a4>
    	{
    		list_add_before(le,&(base->page_link));
  1046e2:	8b 45 08             	mov    0x8(%ebp),%eax
  1046e5:	8d 50 0c             	lea    0xc(%eax),%edx
  1046e8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1046eb:	89 85 70 ff ff ff    	mov    %eax,-0x90(%ebp)
  1046f1:	89 95 6c ff ff ff    	mov    %edx,-0x94(%ebp)
    __list_add(elm, listelm->prev, listelm);
  1046f7:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
  1046fd:	8b 00                	mov    (%eax),%eax
  1046ff:	8b 95 6c ff ff ff    	mov    -0x94(%ebp),%edx
  104705:	89 95 68 ff ff ff    	mov    %edx,-0x98(%ebp)
  10470b:	89 85 64 ff ff ff    	mov    %eax,-0x9c(%ebp)
  104711:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
  104717:	89 85 60 ff ff ff    	mov    %eax,-0xa0(%ebp)
    prev->next = next->prev = elm;
  10471d:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
  104723:	8b 95 68 ff ff ff    	mov    -0x98(%ebp),%edx
  104729:	89 10                	mov    %edx,(%eax)
  10472b:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
  104731:	8b 10                	mov    (%eax),%edx
  104733:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
  104739:	89 50 04             	mov    %edx,0x4(%eax)
    elm->next = next;
  10473c:	8b 85 68 ff ff ff    	mov    -0x98(%ebp),%eax
  104742:	8b 95 60 ff ff ff    	mov    -0xa0(%ebp),%edx
  104748:	89 50 04             	mov    %edx,0x4(%eax)
    elm->prev = prev;
  10474b:	8b 85 68 ff ff ff    	mov    -0x98(%ebp),%eax
  104751:	8b 95 64 ff ff ff    	mov    -0x9c(%ebp),%edx
  104757:	89 10                	mov    %edx,(%eax)
}
  104759:	90                   	nop
}
  10475a:	90                   	nop
    		flag=1;
  10475b:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
    		break;
  104762:	eb 0d                	jmp    104771 <default_free_pages+0x3b1>
    while(le!=&free_list)
  104764:	81 7d f0 5c a9 11 00 	cmpl   $0x11a95c,-0x10(%ebp)
  10476b:	0f 85 a7 fe ff ff    	jne    104618 <default_free_pages+0x258>
    	}
    }
    if(flag==0)//插入尾部
  104771:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  104775:	75 7a                	jne    1047f1 <default_free_pages+0x431>
    {
    	list_add_before(&free_list,&(base->page_link));
  104777:	8b 45 08             	mov    0x8(%ebp),%eax
  10477a:	83 c0 0c             	add    $0xc,%eax
  10477d:	c7 85 5c ff ff ff 5c 	movl   $0x11a95c,-0xa4(%ebp)
  104784:	a9 11 00 
  104787:	89 85 58 ff ff ff    	mov    %eax,-0xa8(%ebp)
    __list_add(elm, listelm->prev, listelm);
  10478d:	8b 85 5c ff ff ff    	mov    -0xa4(%ebp),%eax
  104793:	8b 00                	mov    (%eax),%eax
  104795:	8b 95 58 ff ff ff    	mov    -0xa8(%ebp),%edx
  10479b:	89 95 54 ff ff ff    	mov    %edx,-0xac(%ebp)
  1047a1:	89 85 50 ff ff ff    	mov    %eax,-0xb0(%ebp)
  1047a7:	8b 85 5c ff ff ff    	mov    -0xa4(%ebp),%eax
  1047ad:	89 85 4c ff ff ff    	mov    %eax,-0xb4(%ebp)
    prev->next = next->prev = elm;
  1047b3:	8b 85 4c ff ff ff    	mov    -0xb4(%ebp),%eax
  1047b9:	8b 95 54 ff ff ff    	mov    -0xac(%ebp),%edx
  1047bf:	89 10                	mov    %edx,(%eax)
  1047c1:	8b 85 4c ff ff ff    	mov    -0xb4(%ebp),%eax
  1047c7:	8b 10                	mov    (%eax),%edx
  1047c9:	8b 85 50 ff ff ff    	mov    -0xb0(%ebp),%eax
  1047cf:	89 50 04             	mov    %edx,0x4(%eax)
    elm->next = next;
  1047d2:	8b 85 54 ff ff ff    	mov    -0xac(%ebp),%eax
  1047d8:	8b 95 4c ff ff ff    	mov    -0xb4(%ebp),%edx
  1047de:	89 50 04             	mov    %edx,0x4(%eax)
    elm->prev = prev;
  1047e1:	8b 85 54 ff ff ff    	mov    -0xac(%ebp),%eax
  1047e7:	8b 95 50 ff ff ff    	mov    -0xb0(%ebp),%edx
  1047ed:	89 10                	mov    %edx,(%eax)
}
  1047ef:	90                   	nop
}
  1047f0:	90                   	nop
    }    
}
  1047f1:	90                   	nop
  1047f2:	c9                   	leave  
  1047f3:	c3                   	ret    

001047f4 <default_nr_free_pages>:

static size_t
default_nr_free_pages(void) {
  1047f4:	f3 0f 1e fb          	endbr32 
  1047f8:	55                   	push   %ebp
  1047f9:	89 e5                	mov    %esp,%ebp
    return nr_free;
  1047fb:	a1 64 a9 11 00       	mov    0x11a964,%eax
}
  104800:	5d                   	pop    %ebp
  104801:	c3                   	ret    

00104802 <basic_check>:

static void
basic_check(void) {
  104802:	f3 0f 1e fb          	endbr32 
  104806:	55                   	push   %ebp
  104807:	89 e5                	mov    %esp,%ebp
  104809:	83 ec 38             	sub    $0x38,%esp
    struct Page *p0, *p1, *p2;
    p0 = p1 = p2 = NULL;
  10480c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  104813:	8b 45 f4             	mov    -0xc(%ebp),%eax
  104816:	89 45 f0             	mov    %eax,-0x10(%ebp)
  104819:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10481c:	89 45 ec             	mov    %eax,-0x14(%ebp)
    assert((p0 = alloc_page()) != NULL);
  10481f:	83 ec 0c             	sub    $0xc,%esp
  104822:	6a 01                	push   $0x1
  104824:	e8 bc e4 ff ff       	call   102ce5 <alloc_pages>
  104829:	83 c4 10             	add    $0x10,%esp
  10482c:	89 45 ec             	mov    %eax,-0x14(%ebp)
  10482f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  104833:	75 19                	jne    10484e <basic_check+0x4c>
  104835:	68 d9 6a 10 00       	push   $0x106ad9
  10483a:	68 76 6a 10 00       	push   $0x106a76
  10483f:	68 c5 00 00 00       	push   $0xc5
  104844:	68 8b 6a 10 00       	push   $0x106a8b
  104849:	e8 bc bb ff ff       	call   10040a <__panic>
    assert((p1 = alloc_page()) != NULL);
  10484e:	83 ec 0c             	sub    $0xc,%esp
  104851:	6a 01                	push   $0x1
  104853:	e8 8d e4 ff ff       	call   102ce5 <alloc_pages>
  104858:	83 c4 10             	add    $0x10,%esp
  10485b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  10485e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  104862:	75 19                	jne    10487d <basic_check+0x7b>
  104864:	68 f5 6a 10 00       	push   $0x106af5
  104869:	68 76 6a 10 00       	push   $0x106a76
  10486e:	68 c6 00 00 00       	push   $0xc6
  104873:	68 8b 6a 10 00       	push   $0x106a8b
  104878:	e8 8d bb ff ff       	call   10040a <__panic>
    assert((p2 = alloc_page()) != NULL);
  10487d:	83 ec 0c             	sub    $0xc,%esp
  104880:	6a 01                	push   $0x1
  104882:	e8 5e e4 ff ff       	call   102ce5 <alloc_pages>
  104887:	83 c4 10             	add    $0x10,%esp
  10488a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  10488d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  104891:	75 19                	jne    1048ac <basic_check+0xaa>
  104893:	68 11 6b 10 00       	push   $0x106b11
  104898:	68 76 6a 10 00       	push   $0x106a76
  10489d:	68 c7 00 00 00       	push   $0xc7
  1048a2:	68 8b 6a 10 00       	push   $0x106a8b
  1048a7:	e8 5e bb ff ff       	call   10040a <__panic>

    assert(p0 != p1 && p0 != p2 && p1 != p2);
  1048ac:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1048af:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  1048b2:	74 10                	je     1048c4 <basic_check+0xc2>
  1048b4:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1048b7:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  1048ba:	74 08                	je     1048c4 <basic_check+0xc2>
  1048bc:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1048bf:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  1048c2:	75 19                	jne    1048dd <basic_check+0xdb>
  1048c4:	68 30 6b 10 00       	push   $0x106b30
  1048c9:	68 76 6a 10 00       	push   $0x106a76
  1048ce:	68 c9 00 00 00       	push   $0xc9
  1048d3:	68 8b 6a 10 00       	push   $0x106a8b
  1048d8:	e8 2d bb ff ff       	call   10040a <__panic>
    assert(page_ref(p0) == 0 && page_ref(p1) == 0 && page_ref(p2) == 0);
  1048dd:	83 ec 0c             	sub    $0xc,%esp
  1048e0:	ff 75 ec             	pushl  -0x14(%ebp)
  1048e3:	e8 91 f7 ff ff       	call   104079 <page_ref>
  1048e8:	83 c4 10             	add    $0x10,%esp
  1048eb:	85 c0                	test   %eax,%eax
  1048ed:	75 24                	jne    104913 <basic_check+0x111>
  1048ef:	83 ec 0c             	sub    $0xc,%esp
  1048f2:	ff 75 f0             	pushl  -0x10(%ebp)
  1048f5:	e8 7f f7 ff ff       	call   104079 <page_ref>
  1048fa:	83 c4 10             	add    $0x10,%esp
  1048fd:	85 c0                	test   %eax,%eax
  1048ff:	75 12                	jne    104913 <basic_check+0x111>
  104901:	83 ec 0c             	sub    $0xc,%esp
  104904:	ff 75 f4             	pushl  -0xc(%ebp)
  104907:	e8 6d f7 ff ff       	call   104079 <page_ref>
  10490c:	83 c4 10             	add    $0x10,%esp
  10490f:	85 c0                	test   %eax,%eax
  104911:	74 19                	je     10492c <basic_check+0x12a>
  104913:	68 54 6b 10 00       	push   $0x106b54
  104918:	68 76 6a 10 00       	push   $0x106a76
  10491d:	68 ca 00 00 00       	push   $0xca
  104922:	68 8b 6a 10 00       	push   $0x106a8b
  104927:	e8 de ba ff ff       	call   10040a <__panic>

    assert(page2pa(p0) < npage * PGSIZE);
  10492c:	83 ec 0c             	sub    $0xc,%esp
  10492f:	ff 75 ec             	pushl  -0x14(%ebp)
  104932:	e8 2f f7 ff ff       	call   104066 <page2pa>
  104937:	83 c4 10             	add    $0x10,%esp
  10493a:	8b 15 c0 a8 11 00    	mov    0x11a8c0,%edx
  104940:	c1 e2 0c             	shl    $0xc,%edx
  104943:	39 d0                	cmp    %edx,%eax
  104945:	72 19                	jb     104960 <basic_check+0x15e>
  104947:	68 90 6b 10 00       	push   $0x106b90
  10494c:	68 76 6a 10 00       	push   $0x106a76
  104951:	68 cc 00 00 00       	push   $0xcc
  104956:	68 8b 6a 10 00       	push   $0x106a8b
  10495b:	e8 aa ba ff ff       	call   10040a <__panic>
    assert(page2pa(p1) < npage * PGSIZE);
  104960:	83 ec 0c             	sub    $0xc,%esp
  104963:	ff 75 f0             	pushl  -0x10(%ebp)
  104966:	e8 fb f6 ff ff       	call   104066 <page2pa>
  10496b:	83 c4 10             	add    $0x10,%esp
  10496e:	8b 15 c0 a8 11 00    	mov    0x11a8c0,%edx
  104974:	c1 e2 0c             	shl    $0xc,%edx
  104977:	39 d0                	cmp    %edx,%eax
  104979:	72 19                	jb     104994 <basic_check+0x192>
  10497b:	68 ad 6b 10 00       	push   $0x106bad
  104980:	68 76 6a 10 00       	push   $0x106a76
  104985:	68 cd 00 00 00       	push   $0xcd
  10498a:	68 8b 6a 10 00       	push   $0x106a8b
  10498f:	e8 76 ba ff ff       	call   10040a <__panic>
    assert(page2pa(p2) < npage * PGSIZE);
  104994:	83 ec 0c             	sub    $0xc,%esp
  104997:	ff 75 f4             	pushl  -0xc(%ebp)
  10499a:	e8 c7 f6 ff ff       	call   104066 <page2pa>
  10499f:	83 c4 10             	add    $0x10,%esp
  1049a2:	8b 15 c0 a8 11 00    	mov    0x11a8c0,%edx
  1049a8:	c1 e2 0c             	shl    $0xc,%edx
  1049ab:	39 d0                	cmp    %edx,%eax
  1049ad:	72 19                	jb     1049c8 <basic_check+0x1c6>
  1049af:	68 ca 6b 10 00       	push   $0x106bca
  1049b4:	68 76 6a 10 00       	push   $0x106a76
  1049b9:	68 ce 00 00 00       	push   $0xce
  1049be:	68 8b 6a 10 00       	push   $0x106a8b
  1049c3:	e8 42 ba ff ff       	call   10040a <__panic>

    list_entry_t free_list_store = free_list;
  1049c8:	a1 5c a9 11 00       	mov    0x11a95c,%eax
  1049cd:	8b 15 60 a9 11 00    	mov    0x11a960,%edx
  1049d3:	89 45 d0             	mov    %eax,-0x30(%ebp)
  1049d6:	89 55 d4             	mov    %edx,-0x2c(%ebp)
  1049d9:	c7 45 dc 5c a9 11 00 	movl   $0x11a95c,-0x24(%ebp)
    elm->prev = elm->next = elm;
  1049e0:	8b 45 dc             	mov    -0x24(%ebp),%eax
  1049e3:	8b 55 dc             	mov    -0x24(%ebp),%edx
  1049e6:	89 50 04             	mov    %edx,0x4(%eax)
  1049e9:	8b 45 dc             	mov    -0x24(%ebp),%eax
  1049ec:	8b 50 04             	mov    0x4(%eax),%edx
  1049ef:	8b 45 dc             	mov    -0x24(%ebp),%eax
  1049f2:	89 10                	mov    %edx,(%eax)
}
  1049f4:	90                   	nop
  1049f5:	c7 45 e0 5c a9 11 00 	movl   $0x11a95c,-0x20(%ebp)
    return list->next == list;
  1049fc:	8b 45 e0             	mov    -0x20(%ebp),%eax
  1049ff:	8b 40 04             	mov    0x4(%eax),%eax
  104a02:	39 45 e0             	cmp    %eax,-0x20(%ebp)
  104a05:	0f 94 c0             	sete   %al
  104a08:	0f b6 c0             	movzbl %al,%eax
    list_init(&free_list);
    assert(list_empty(&free_list));
  104a0b:	85 c0                	test   %eax,%eax
  104a0d:	75 19                	jne    104a28 <basic_check+0x226>
  104a0f:	68 e7 6b 10 00       	push   $0x106be7
  104a14:	68 76 6a 10 00       	push   $0x106a76
  104a19:	68 d2 00 00 00       	push   $0xd2
  104a1e:	68 8b 6a 10 00       	push   $0x106a8b
  104a23:	e8 e2 b9 ff ff       	call   10040a <__panic>

    unsigned int nr_free_store = nr_free;
  104a28:	a1 64 a9 11 00       	mov    0x11a964,%eax
  104a2d:	89 45 e8             	mov    %eax,-0x18(%ebp)
    nr_free = 0;
  104a30:	c7 05 64 a9 11 00 00 	movl   $0x0,0x11a964
  104a37:	00 00 00 

    assert(alloc_page() == NULL);
  104a3a:	83 ec 0c             	sub    $0xc,%esp
  104a3d:	6a 01                	push   $0x1
  104a3f:	e8 a1 e2 ff ff       	call   102ce5 <alloc_pages>
  104a44:	83 c4 10             	add    $0x10,%esp
  104a47:	85 c0                	test   %eax,%eax
  104a49:	74 19                	je     104a64 <basic_check+0x262>
  104a4b:	68 fe 6b 10 00       	push   $0x106bfe
  104a50:	68 76 6a 10 00       	push   $0x106a76
  104a55:	68 d7 00 00 00       	push   $0xd7
  104a5a:	68 8b 6a 10 00       	push   $0x106a8b
  104a5f:	e8 a6 b9 ff ff       	call   10040a <__panic>

    free_page(p0);
  104a64:	83 ec 08             	sub    $0x8,%esp
  104a67:	6a 01                	push   $0x1
  104a69:	ff 75 ec             	pushl  -0x14(%ebp)
  104a6c:	e8 b6 e2 ff ff       	call   102d27 <free_pages>
  104a71:	83 c4 10             	add    $0x10,%esp
    free_page(p1);
  104a74:	83 ec 08             	sub    $0x8,%esp
  104a77:	6a 01                	push   $0x1
  104a79:	ff 75 f0             	pushl  -0x10(%ebp)
  104a7c:	e8 a6 e2 ff ff       	call   102d27 <free_pages>
  104a81:	83 c4 10             	add    $0x10,%esp
    free_page(p2);
  104a84:	83 ec 08             	sub    $0x8,%esp
  104a87:	6a 01                	push   $0x1
  104a89:	ff 75 f4             	pushl  -0xc(%ebp)
  104a8c:	e8 96 e2 ff ff       	call   102d27 <free_pages>
  104a91:	83 c4 10             	add    $0x10,%esp
    assert(nr_free == 3);
  104a94:	a1 64 a9 11 00       	mov    0x11a964,%eax
  104a99:	83 f8 03             	cmp    $0x3,%eax
  104a9c:	74 19                	je     104ab7 <basic_check+0x2b5>
  104a9e:	68 13 6c 10 00       	push   $0x106c13
  104aa3:	68 76 6a 10 00       	push   $0x106a76
  104aa8:	68 dc 00 00 00       	push   $0xdc
  104aad:	68 8b 6a 10 00       	push   $0x106a8b
  104ab2:	e8 53 b9 ff ff       	call   10040a <__panic>

    assert((p0 = alloc_page()) != NULL);
  104ab7:	83 ec 0c             	sub    $0xc,%esp
  104aba:	6a 01                	push   $0x1
  104abc:	e8 24 e2 ff ff       	call   102ce5 <alloc_pages>
  104ac1:	83 c4 10             	add    $0x10,%esp
  104ac4:	89 45 ec             	mov    %eax,-0x14(%ebp)
  104ac7:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  104acb:	75 19                	jne    104ae6 <basic_check+0x2e4>
  104acd:	68 d9 6a 10 00       	push   $0x106ad9
  104ad2:	68 76 6a 10 00       	push   $0x106a76
  104ad7:	68 de 00 00 00       	push   $0xde
  104adc:	68 8b 6a 10 00       	push   $0x106a8b
  104ae1:	e8 24 b9 ff ff       	call   10040a <__panic>
    assert((p1 = alloc_page()) != NULL);
  104ae6:	83 ec 0c             	sub    $0xc,%esp
  104ae9:	6a 01                	push   $0x1
  104aeb:	e8 f5 e1 ff ff       	call   102ce5 <alloc_pages>
  104af0:	83 c4 10             	add    $0x10,%esp
  104af3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  104af6:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  104afa:	75 19                	jne    104b15 <basic_check+0x313>
  104afc:	68 f5 6a 10 00       	push   $0x106af5
  104b01:	68 76 6a 10 00       	push   $0x106a76
  104b06:	68 df 00 00 00       	push   $0xdf
  104b0b:	68 8b 6a 10 00       	push   $0x106a8b
  104b10:	e8 f5 b8 ff ff       	call   10040a <__panic>
    assert((p2 = alloc_page()) != NULL);
  104b15:	83 ec 0c             	sub    $0xc,%esp
  104b18:	6a 01                	push   $0x1
  104b1a:	e8 c6 e1 ff ff       	call   102ce5 <alloc_pages>
  104b1f:	83 c4 10             	add    $0x10,%esp
  104b22:	89 45 f4             	mov    %eax,-0xc(%ebp)
  104b25:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  104b29:	75 19                	jne    104b44 <basic_check+0x342>
  104b2b:	68 11 6b 10 00       	push   $0x106b11
  104b30:	68 76 6a 10 00       	push   $0x106a76
  104b35:	68 e0 00 00 00       	push   $0xe0
  104b3a:	68 8b 6a 10 00       	push   $0x106a8b
  104b3f:	e8 c6 b8 ff ff       	call   10040a <__panic>

    assert(alloc_page() == NULL);
  104b44:	83 ec 0c             	sub    $0xc,%esp
  104b47:	6a 01                	push   $0x1
  104b49:	e8 97 e1 ff ff       	call   102ce5 <alloc_pages>
  104b4e:	83 c4 10             	add    $0x10,%esp
  104b51:	85 c0                	test   %eax,%eax
  104b53:	74 19                	je     104b6e <basic_check+0x36c>
  104b55:	68 fe 6b 10 00       	push   $0x106bfe
  104b5a:	68 76 6a 10 00       	push   $0x106a76
  104b5f:	68 e2 00 00 00       	push   $0xe2
  104b64:	68 8b 6a 10 00       	push   $0x106a8b
  104b69:	e8 9c b8 ff ff       	call   10040a <__panic>

    free_page(p0);
  104b6e:	83 ec 08             	sub    $0x8,%esp
  104b71:	6a 01                	push   $0x1
  104b73:	ff 75 ec             	pushl  -0x14(%ebp)
  104b76:	e8 ac e1 ff ff       	call   102d27 <free_pages>
  104b7b:	83 c4 10             	add    $0x10,%esp
  104b7e:	c7 45 d8 5c a9 11 00 	movl   $0x11a95c,-0x28(%ebp)
  104b85:	8b 45 d8             	mov    -0x28(%ebp),%eax
  104b88:	8b 40 04             	mov    0x4(%eax),%eax
  104b8b:	39 45 d8             	cmp    %eax,-0x28(%ebp)
  104b8e:	0f 94 c0             	sete   %al
  104b91:	0f b6 c0             	movzbl %al,%eax
    assert(!list_empty(&free_list));
  104b94:	85 c0                	test   %eax,%eax
  104b96:	74 19                	je     104bb1 <basic_check+0x3af>
  104b98:	68 20 6c 10 00       	push   $0x106c20
  104b9d:	68 76 6a 10 00       	push   $0x106a76
  104ba2:	68 e5 00 00 00       	push   $0xe5
  104ba7:	68 8b 6a 10 00       	push   $0x106a8b
  104bac:	e8 59 b8 ff ff       	call   10040a <__panic>

    struct Page *p;
    assert((p = alloc_page()) == p0);
  104bb1:	83 ec 0c             	sub    $0xc,%esp
  104bb4:	6a 01                	push   $0x1
  104bb6:	e8 2a e1 ff ff       	call   102ce5 <alloc_pages>
  104bbb:	83 c4 10             	add    $0x10,%esp
  104bbe:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  104bc1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  104bc4:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  104bc7:	74 19                	je     104be2 <basic_check+0x3e0>
  104bc9:	68 38 6c 10 00       	push   $0x106c38
  104bce:	68 76 6a 10 00       	push   $0x106a76
  104bd3:	68 e8 00 00 00       	push   $0xe8
  104bd8:	68 8b 6a 10 00       	push   $0x106a8b
  104bdd:	e8 28 b8 ff ff       	call   10040a <__panic>
    assert(alloc_page() == NULL);
  104be2:	83 ec 0c             	sub    $0xc,%esp
  104be5:	6a 01                	push   $0x1
  104be7:	e8 f9 e0 ff ff       	call   102ce5 <alloc_pages>
  104bec:	83 c4 10             	add    $0x10,%esp
  104bef:	85 c0                	test   %eax,%eax
  104bf1:	74 19                	je     104c0c <basic_check+0x40a>
  104bf3:	68 fe 6b 10 00       	push   $0x106bfe
  104bf8:	68 76 6a 10 00       	push   $0x106a76
  104bfd:	68 e9 00 00 00       	push   $0xe9
  104c02:	68 8b 6a 10 00       	push   $0x106a8b
  104c07:	e8 fe b7 ff ff       	call   10040a <__panic>

    assert(nr_free == 0);
  104c0c:	a1 64 a9 11 00       	mov    0x11a964,%eax
  104c11:	85 c0                	test   %eax,%eax
  104c13:	74 19                	je     104c2e <basic_check+0x42c>
  104c15:	68 51 6c 10 00       	push   $0x106c51
  104c1a:	68 76 6a 10 00       	push   $0x106a76
  104c1f:	68 eb 00 00 00       	push   $0xeb
  104c24:	68 8b 6a 10 00       	push   $0x106a8b
  104c29:	e8 dc b7 ff ff       	call   10040a <__panic>
    free_list = free_list_store;
  104c2e:	8b 45 d0             	mov    -0x30(%ebp),%eax
  104c31:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  104c34:	a3 5c a9 11 00       	mov    %eax,0x11a95c
  104c39:	89 15 60 a9 11 00    	mov    %edx,0x11a960
    nr_free = nr_free_store;
  104c3f:	8b 45 e8             	mov    -0x18(%ebp),%eax
  104c42:	a3 64 a9 11 00       	mov    %eax,0x11a964

    free_page(p);
  104c47:	83 ec 08             	sub    $0x8,%esp
  104c4a:	6a 01                	push   $0x1
  104c4c:	ff 75 e4             	pushl  -0x1c(%ebp)
  104c4f:	e8 d3 e0 ff ff       	call   102d27 <free_pages>
  104c54:	83 c4 10             	add    $0x10,%esp
    free_page(p1);
  104c57:	83 ec 08             	sub    $0x8,%esp
  104c5a:	6a 01                	push   $0x1
  104c5c:	ff 75 f0             	pushl  -0x10(%ebp)
  104c5f:	e8 c3 e0 ff ff       	call   102d27 <free_pages>
  104c64:	83 c4 10             	add    $0x10,%esp
    free_page(p2);
  104c67:	83 ec 08             	sub    $0x8,%esp
  104c6a:	6a 01                	push   $0x1
  104c6c:	ff 75 f4             	pushl  -0xc(%ebp)
  104c6f:	e8 b3 e0 ff ff       	call   102d27 <free_pages>
  104c74:	83 c4 10             	add    $0x10,%esp
}
  104c77:	90                   	nop
  104c78:	c9                   	leave  
  104c79:	c3                   	ret    

00104c7a <default_check>:

// LAB2: below code is used to check the first fit allocation algorithm (your EXERCISE 1) 
// NOTICE: You SHOULD NOT CHANGE basic_check, default_check functions!
static void
default_check(void) {
  104c7a:	f3 0f 1e fb          	endbr32 
  104c7e:	55                   	push   %ebp
  104c7f:	89 e5                	mov    %esp,%ebp
  104c81:	81 ec 88 00 00 00    	sub    $0x88,%esp
    int count = 0, total = 0;
  104c87:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  104c8e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    list_entry_t *le = &free_list;
  104c95:	c7 45 ec 5c a9 11 00 	movl   $0x11a95c,-0x14(%ebp)
    while ((le = list_next(le)) != &free_list) {
  104c9c:	eb 60                	jmp    104cfe <default_check+0x84>
        struct Page *p = le2page(le, page_link);
  104c9e:	8b 45 ec             	mov    -0x14(%ebp),%eax
  104ca1:	83 e8 0c             	sub    $0xc,%eax
  104ca4:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        assert(PageProperty(p));
  104ca7:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  104caa:	83 c0 04             	add    $0x4,%eax
  104cad:	c7 45 d0 01 00 00 00 	movl   $0x1,-0x30(%ebp)
  104cb4:	89 45 cc             	mov    %eax,-0x34(%ebp)
    asm volatile ("btl %2, %1; sbbl %0,%0" : "=r" (oldbit) : "m" (*(volatile long *)addr), "Ir" (nr));
  104cb7:	8b 45 cc             	mov    -0x34(%ebp),%eax
  104cba:	8b 55 d0             	mov    -0x30(%ebp),%edx
  104cbd:	0f a3 10             	bt     %edx,(%eax)
  104cc0:	19 c0                	sbb    %eax,%eax
  104cc2:	89 45 c8             	mov    %eax,-0x38(%ebp)
    return oldbit != 0;
  104cc5:	83 7d c8 00          	cmpl   $0x0,-0x38(%ebp)
  104cc9:	0f 95 c0             	setne  %al
  104ccc:	0f b6 c0             	movzbl %al,%eax
  104ccf:	85 c0                	test   %eax,%eax
  104cd1:	75 19                	jne    104cec <default_check+0x72>
  104cd3:	68 5e 6c 10 00       	push   $0x106c5e
  104cd8:	68 76 6a 10 00       	push   $0x106a76
  104cdd:	68 fc 00 00 00       	push   $0xfc
  104ce2:	68 8b 6a 10 00       	push   $0x106a8b
  104ce7:	e8 1e b7 ff ff       	call   10040a <__panic>
        count ++, total += p->property;
  104cec:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  104cf0:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  104cf3:	8b 50 08             	mov    0x8(%eax),%edx
  104cf6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  104cf9:	01 d0                	add    %edx,%eax
  104cfb:	89 45 f0             	mov    %eax,-0x10(%ebp)
  104cfe:	8b 45 ec             	mov    -0x14(%ebp),%eax
  104d01:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    return listelm->next;
  104d04:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  104d07:	8b 40 04             	mov    0x4(%eax),%eax
    while ((le = list_next(le)) != &free_list) {
  104d0a:	89 45 ec             	mov    %eax,-0x14(%ebp)
  104d0d:	81 7d ec 5c a9 11 00 	cmpl   $0x11a95c,-0x14(%ebp)
  104d14:	75 88                	jne    104c9e <default_check+0x24>
    }
    assert(total == nr_free_pages());
  104d16:	e8 45 e0 ff ff       	call   102d60 <nr_free_pages>
  104d1b:	8b 55 f0             	mov    -0x10(%ebp),%edx
  104d1e:	39 d0                	cmp    %edx,%eax
  104d20:	74 19                	je     104d3b <default_check+0xc1>
  104d22:	68 6e 6c 10 00       	push   $0x106c6e
  104d27:	68 76 6a 10 00       	push   $0x106a76
  104d2c:	68 ff 00 00 00       	push   $0xff
  104d31:	68 8b 6a 10 00       	push   $0x106a8b
  104d36:	e8 cf b6 ff ff       	call   10040a <__panic>

    basic_check();
  104d3b:	e8 c2 fa ff ff       	call   104802 <basic_check>

    struct Page *p0 = alloc_pages(5), *p1, *p2;
  104d40:	83 ec 0c             	sub    $0xc,%esp
  104d43:	6a 05                	push   $0x5
  104d45:	e8 9b df ff ff       	call   102ce5 <alloc_pages>
  104d4a:	83 c4 10             	add    $0x10,%esp
  104d4d:	89 45 e8             	mov    %eax,-0x18(%ebp)
    assert(p0 != NULL);
  104d50:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  104d54:	75 19                	jne    104d6f <default_check+0xf5>
  104d56:	68 87 6c 10 00       	push   $0x106c87
  104d5b:	68 76 6a 10 00       	push   $0x106a76
  104d60:	68 04 01 00 00       	push   $0x104
  104d65:	68 8b 6a 10 00       	push   $0x106a8b
  104d6a:	e8 9b b6 ff ff       	call   10040a <__panic>
    assert(!PageProperty(p0));
  104d6f:	8b 45 e8             	mov    -0x18(%ebp),%eax
  104d72:	83 c0 04             	add    $0x4,%eax
  104d75:	c7 45 c0 01 00 00 00 	movl   $0x1,-0x40(%ebp)
  104d7c:	89 45 bc             	mov    %eax,-0x44(%ebp)
    asm volatile ("btl %2, %1; sbbl %0,%0" : "=r" (oldbit) : "m" (*(volatile long *)addr), "Ir" (nr));
  104d7f:	8b 45 bc             	mov    -0x44(%ebp),%eax
  104d82:	8b 55 c0             	mov    -0x40(%ebp),%edx
  104d85:	0f a3 10             	bt     %edx,(%eax)
  104d88:	19 c0                	sbb    %eax,%eax
  104d8a:	89 45 b8             	mov    %eax,-0x48(%ebp)
    return oldbit != 0;
  104d8d:	83 7d b8 00          	cmpl   $0x0,-0x48(%ebp)
  104d91:	0f 95 c0             	setne  %al
  104d94:	0f b6 c0             	movzbl %al,%eax
  104d97:	85 c0                	test   %eax,%eax
  104d99:	74 19                	je     104db4 <default_check+0x13a>
  104d9b:	68 92 6c 10 00       	push   $0x106c92
  104da0:	68 76 6a 10 00       	push   $0x106a76
  104da5:	68 05 01 00 00       	push   $0x105
  104daa:	68 8b 6a 10 00       	push   $0x106a8b
  104daf:	e8 56 b6 ff ff       	call   10040a <__panic>

    list_entry_t free_list_store = free_list;
  104db4:	a1 5c a9 11 00       	mov    0x11a95c,%eax
  104db9:	8b 15 60 a9 11 00    	mov    0x11a960,%edx
  104dbf:	89 45 80             	mov    %eax,-0x80(%ebp)
  104dc2:	89 55 84             	mov    %edx,-0x7c(%ebp)
  104dc5:	c7 45 b0 5c a9 11 00 	movl   $0x11a95c,-0x50(%ebp)
    elm->prev = elm->next = elm;
  104dcc:	8b 45 b0             	mov    -0x50(%ebp),%eax
  104dcf:	8b 55 b0             	mov    -0x50(%ebp),%edx
  104dd2:	89 50 04             	mov    %edx,0x4(%eax)
  104dd5:	8b 45 b0             	mov    -0x50(%ebp),%eax
  104dd8:	8b 50 04             	mov    0x4(%eax),%edx
  104ddb:	8b 45 b0             	mov    -0x50(%ebp),%eax
  104dde:	89 10                	mov    %edx,(%eax)
}
  104de0:	90                   	nop
  104de1:	c7 45 b4 5c a9 11 00 	movl   $0x11a95c,-0x4c(%ebp)
    return list->next == list;
  104de8:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  104deb:	8b 40 04             	mov    0x4(%eax),%eax
  104dee:	39 45 b4             	cmp    %eax,-0x4c(%ebp)
  104df1:	0f 94 c0             	sete   %al
  104df4:	0f b6 c0             	movzbl %al,%eax
    list_init(&free_list);
    assert(list_empty(&free_list));
  104df7:	85 c0                	test   %eax,%eax
  104df9:	75 19                	jne    104e14 <default_check+0x19a>
  104dfb:	68 e7 6b 10 00       	push   $0x106be7
  104e00:	68 76 6a 10 00       	push   $0x106a76
  104e05:	68 09 01 00 00       	push   $0x109
  104e0a:	68 8b 6a 10 00       	push   $0x106a8b
  104e0f:	e8 f6 b5 ff ff       	call   10040a <__panic>
    assert(alloc_page() == NULL);
  104e14:	83 ec 0c             	sub    $0xc,%esp
  104e17:	6a 01                	push   $0x1
  104e19:	e8 c7 de ff ff       	call   102ce5 <alloc_pages>
  104e1e:	83 c4 10             	add    $0x10,%esp
  104e21:	85 c0                	test   %eax,%eax
  104e23:	74 19                	je     104e3e <default_check+0x1c4>
  104e25:	68 fe 6b 10 00       	push   $0x106bfe
  104e2a:	68 76 6a 10 00       	push   $0x106a76
  104e2f:	68 0a 01 00 00       	push   $0x10a
  104e34:	68 8b 6a 10 00       	push   $0x106a8b
  104e39:	e8 cc b5 ff ff       	call   10040a <__panic>

    unsigned int nr_free_store = nr_free;
  104e3e:	a1 64 a9 11 00       	mov    0x11a964,%eax
  104e43:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    nr_free = 0;
  104e46:	c7 05 64 a9 11 00 00 	movl   $0x0,0x11a964
  104e4d:	00 00 00 

    free_pages(p0 + 2, 3);
  104e50:	8b 45 e8             	mov    -0x18(%ebp),%eax
  104e53:	83 c0 28             	add    $0x28,%eax
  104e56:	83 ec 08             	sub    $0x8,%esp
  104e59:	6a 03                	push   $0x3
  104e5b:	50                   	push   %eax
  104e5c:	e8 c6 de ff ff       	call   102d27 <free_pages>
  104e61:	83 c4 10             	add    $0x10,%esp
    assert(alloc_pages(4) == NULL);
  104e64:	83 ec 0c             	sub    $0xc,%esp
  104e67:	6a 04                	push   $0x4
  104e69:	e8 77 de ff ff       	call   102ce5 <alloc_pages>
  104e6e:	83 c4 10             	add    $0x10,%esp
  104e71:	85 c0                	test   %eax,%eax
  104e73:	74 19                	je     104e8e <default_check+0x214>
  104e75:	68 a4 6c 10 00       	push   $0x106ca4
  104e7a:	68 76 6a 10 00       	push   $0x106a76
  104e7f:	68 10 01 00 00       	push   $0x110
  104e84:	68 8b 6a 10 00       	push   $0x106a8b
  104e89:	e8 7c b5 ff ff       	call   10040a <__panic>
    assert(PageProperty(p0 + 2) && p0[2].property == 3);
  104e8e:	8b 45 e8             	mov    -0x18(%ebp),%eax
  104e91:	83 c0 28             	add    $0x28,%eax
  104e94:	83 c0 04             	add    $0x4,%eax
  104e97:	c7 45 ac 01 00 00 00 	movl   $0x1,-0x54(%ebp)
  104e9e:	89 45 a8             	mov    %eax,-0x58(%ebp)
    asm volatile ("btl %2, %1; sbbl %0,%0" : "=r" (oldbit) : "m" (*(volatile long *)addr), "Ir" (nr));
  104ea1:	8b 45 a8             	mov    -0x58(%ebp),%eax
  104ea4:	8b 55 ac             	mov    -0x54(%ebp),%edx
  104ea7:	0f a3 10             	bt     %edx,(%eax)
  104eaa:	19 c0                	sbb    %eax,%eax
  104eac:	89 45 a4             	mov    %eax,-0x5c(%ebp)
    return oldbit != 0;
  104eaf:	83 7d a4 00          	cmpl   $0x0,-0x5c(%ebp)
  104eb3:	0f 95 c0             	setne  %al
  104eb6:	0f b6 c0             	movzbl %al,%eax
  104eb9:	85 c0                	test   %eax,%eax
  104ebb:	74 0e                	je     104ecb <default_check+0x251>
  104ebd:	8b 45 e8             	mov    -0x18(%ebp),%eax
  104ec0:	83 c0 28             	add    $0x28,%eax
  104ec3:	8b 40 08             	mov    0x8(%eax),%eax
  104ec6:	83 f8 03             	cmp    $0x3,%eax
  104ec9:	74 19                	je     104ee4 <default_check+0x26a>
  104ecb:	68 bc 6c 10 00       	push   $0x106cbc
  104ed0:	68 76 6a 10 00       	push   $0x106a76
  104ed5:	68 11 01 00 00       	push   $0x111
  104eda:	68 8b 6a 10 00       	push   $0x106a8b
  104edf:	e8 26 b5 ff ff       	call   10040a <__panic>
    assert((p1 = alloc_pages(3)) != NULL);
  104ee4:	83 ec 0c             	sub    $0xc,%esp
  104ee7:	6a 03                	push   $0x3
  104ee9:	e8 f7 dd ff ff       	call   102ce5 <alloc_pages>
  104eee:	83 c4 10             	add    $0x10,%esp
  104ef1:	89 45 e0             	mov    %eax,-0x20(%ebp)
  104ef4:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  104ef8:	75 19                	jne    104f13 <default_check+0x299>
  104efa:	68 e8 6c 10 00       	push   $0x106ce8
  104eff:	68 76 6a 10 00       	push   $0x106a76
  104f04:	68 12 01 00 00       	push   $0x112
  104f09:	68 8b 6a 10 00       	push   $0x106a8b
  104f0e:	e8 f7 b4 ff ff       	call   10040a <__panic>
    assert(alloc_page() == NULL);
  104f13:	83 ec 0c             	sub    $0xc,%esp
  104f16:	6a 01                	push   $0x1
  104f18:	e8 c8 dd ff ff       	call   102ce5 <alloc_pages>
  104f1d:	83 c4 10             	add    $0x10,%esp
  104f20:	85 c0                	test   %eax,%eax
  104f22:	74 19                	je     104f3d <default_check+0x2c3>
  104f24:	68 fe 6b 10 00       	push   $0x106bfe
  104f29:	68 76 6a 10 00       	push   $0x106a76
  104f2e:	68 13 01 00 00       	push   $0x113
  104f33:	68 8b 6a 10 00       	push   $0x106a8b
  104f38:	e8 cd b4 ff ff       	call   10040a <__panic>
    assert(p0 + 2 == p1);
  104f3d:	8b 45 e8             	mov    -0x18(%ebp),%eax
  104f40:	83 c0 28             	add    $0x28,%eax
  104f43:	39 45 e0             	cmp    %eax,-0x20(%ebp)
  104f46:	74 19                	je     104f61 <default_check+0x2e7>
  104f48:	68 06 6d 10 00       	push   $0x106d06
  104f4d:	68 76 6a 10 00       	push   $0x106a76
  104f52:	68 14 01 00 00       	push   $0x114
  104f57:	68 8b 6a 10 00       	push   $0x106a8b
  104f5c:	e8 a9 b4 ff ff       	call   10040a <__panic>

    p2 = p0 + 1;
  104f61:	8b 45 e8             	mov    -0x18(%ebp),%eax
  104f64:	83 c0 14             	add    $0x14,%eax
  104f67:	89 45 dc             	mov    %eax,-0x24(%ebp)
    free_page(p0);
  104f6a:	83 ec 08             	sub    $0x8,%esp
  104f6d:	6a 01                	push   $0x1
  104f6f:	ff 75 e8             	pushl  -0x18(%ebp)
  104f72:	e8 b0 dd ff ff       	call   102d27 <free_pages>
  104f77:	83 c4 10             	add    $0x10,%esp
    free_pages(p1, 3);
  104f7a:	83 ec 08             	sub    $0x8,%esp
  104f7d:	6a 03                	push   $0x3
  104f7f:	ff 75 e0             	pushl  -0x20(%ebp)
  104f82:	e8 a0 dd ff ff       	call   102d27 <free_pages>
  104f87:	83 c4 10             	add    $0x10,%esp
    assert(PageProperty(p0) && p0->property == 1);
  104f8a:	8b 45 e8             	mov    -0x18(%ebp),%eax
  104f8d:	83 c0 04             	add    $0x4,%eax
  104f90:	c7 45 a0 01 00 00 00 	movl   $0x1,-0x60(%ebp)
  104f97:	89 45 9c             	mov    %eax,-0x64(%ebp)
    asm volatile ("btl %2, %1; sbbl %0,%0" : "=r" (oldbit) : "m" (*(volatile long *)addr), "Ir" (nr));
  104f9a:	8b 45 9c             	mov    -0x64(%ebp),%eax
  104f9d:	8b 55 a0             	mov    -0x60(%ebp),%edx
  104fa0:	0f a3 10             	bt     %edx,(%eax)
  104fa3:	19 c0                	sbb    %eax,%eax
  104fa5:	89 45 98             	mov    %eax,-0x68(%ebp)
    return oldbit != 0;
  104fa8:	83 7d 98 00          	cmpl   $0x0,-0x68(%ebp)
  104fac:	0f 95 c0             	setne  %al
  104faf:	0f b6 c0             	movzbl %al,%eax
  104fb2:	85 c0                	test   %eax,%eax
  104fb4:	74 0b                	je     104fc1 <default_check+0x347>
  104fb6:	8b 45 e8             	mov    -0x18(%ebp),%eax
  104fb9:	8b 40 08             	mov    0x8(%eax),%eax
  104fbc:	83 f8 01             	cmp    $0x1,%eax
  104fbf:	74 19                	je     104fda <default_check+0x360>
  104fc1:	68 14 6d 10 00       	push   $0x106d14
  104fc6:	68 76 6a 10 00       	push   $0x106a76
  104fcb:	68 19 01 00 00       	push   $0x119
  104fd0:	68 8b 6a 10 00       	push   $0x106a8b
  104fd5:	e8 30 b4 ff ff       	call   10040a <__panic>
    assert(PageProperty(p1) && p1->property == 3);
  104fda:	8b 45 e0             	mov    -0x20(%ebp),%eax
  104fdd:	83 c0 04             	add    $0x4,%eax
  104fe0:	c7 45 94 01 00 00 00 	movl   $0x1,-0x6c(%ebp)
  104fe7:	89 45 90             	mov    %eax,-0x70(%ebp)
    asm volatile ("btl %2, %1; sbbl %0,%0" : "=r" (oldbit) : "m" (*(volatile long *)addr), "Ir" (nr));
  104fea:	8b 45 90             	mov    -0x70(%ebp),%eax
  104fed:	8b 55 94             	mov    -0x6c(%ebp),%edx
  104ff0:	0f a3 10             	bt     %edx,(%eax)
  104ff3:	19 c0                	sbb    %eax,%eax
  104ff5:	89 45 8c             	mov    %eax,-0x74(%ebp)
    return oldbit != 0;
  104ff8:	83 7d 8c 00          	cmpl   $0x0,-0x74(%ebp)
  104ffc:	0f 95 c0             	setne  %al
  104fff:	0f b6 c0             	movzbl %al,%eax
  105002:	85 c0                	test   %eax,%eax
  105004:	74 0b                	je     105011 <default_check+0x397>
  105006:	8b 45 e0             	mov    -0x20(%ebp),%eax
  105009:	8b 40 08             	mov    0x8(%eax),%eax
  10500c:	83 f8 03             	cmp    $0x3,%eax
  10500f:	74 19                	je     10502a <default_check+0x3b0>
  105011:	68 3c 6d 10 00       	push   $0x106d3c
  105016:	68 76 6a 10 00       	push   $0x106a76
  10501b:	68 1a 01 00 00       	push   $0x11a
  105020:	68 8b 6a 10 00       	push   $0x106a8b
  105025:	e8 e0 b3 ff ff       	call   10040a <__panic>

    assert((p0 = alloc_page()) == p2 - 1);
  10502a:	83 ec 0c             	sub    $0xc,%esp
  10502d:	6a 01                	push   $0x1
  10502f:	e8 b1 dc ff ff       	call   102ce5 <alloc_pages>
  105034:	83 c4 10             	add    $0x10,%esp
  105037:	89 45 e8             	mov    %eax,-0x18(%ebp)
  10503a:	8b 45 dc             	mov    -0x24(%ebp),%eax
  10503d:	83 e8 14             	sub    $0x14,%eax
  105040:	39 45 e8             	cmp    %eax,-0x18(%ebp)
  105043:	74 19                	je     10505e <default_check+0x3e4>
  105045:	68 62 6d 10 00       	push   $0x106d62
  10504a:	68 76 6a 10 00       	push   $0x106a76
  10504f:	68 1c 01 00 00       	push   $0x11c
  105054:	68 8b 6a 10 00       	push   $0x106a8b
  105059:	e8 ac b3 ff ff       	call   10040a <__panic>
    free_page(p0);
  10505e:	83 ec 08             	sub    $0x8,%esp
  105061:	6a 01                	push   $0x1
  105063:	ff 75 e8             	pushl  -0x18(%ebp)
  105066:	e8 bc dc ff ff       	call   102d27 <free_pages>
  10506b:	83 c4 10             	add    $0x10,%esp
    assert((p0 = alloc_pages(2)) == p2 + 1);
  10506e:	83 ec 0c             	sub    $0xc,%esp
  105071:	6a 02                	push   $0x2
  105073:	e8 6d dc ff ff       	call   102ce5 <alloc_pages>
  105078:	83 c4 10             	add    $0x10,%esp
  10507b:	89 45 e8             	mov    %eax,-0x18(%ebp)
  10507e:	8b 45 dc             	mov    -0x24(%ebp),%eax
  105081:	83 c0 14             	add    $0x14,%eax
  105084:	39 45 e8             	cmp    %eax,-0x18(%ebp)
  105087:	74 19                	je     1050a2 <default_check+0x428>
  105089:	68 80 6d 10 00       	push   $0x106d80
  10508e:	68 76 6a 10 00       	push   $0x106a76
  105093:	68 1e 01 00 00       	push   $0x11e
  105098:	68 8b 6a 10 00       	push   $0x106a8b
  10509d:	e8 68 b3 ff ff       	call   10040a <__panic>

    free_pages(p0, 2);
  1050a2:	83 ec 08             	sub    $0x8,%esp
  1050a5:	6a 02                	push   $0x2
  1050a7:	ff 75 e8             	pushl  -0x18(%ebp)
  1050aa:	e8 78 dc ff ff       	call   102d27 <free_pages>
  1050af:	83 c4 10             	add    $0x10,%esp
    free_page(p2);
  1050b2:	83 ec 08             	sub    $0x8,%esp
  1050b5:	6a 01                	push   $0x1
  1050b7:	ff 75 dc             	pushl  -0x24(%ebp)
  1050ba:	e8 68 dc ff ff       	call   102d27 <free_pages>
  1050bf:	83 c4 10             	add    $0x10,%esp

    assert((p0 = alloc_pages(5)) != NULL);
  1050c2:	83 ec 0c             	sub    $0xc,%esp
  1050c5:	6a 05                	push   $0x5
  1050c7:	e8 19 dc ff ff       	call   102ce5 <alloc_pages>
  1050cc:	83 c4 10             	add    $0x10,%esp
  1050cf:	89 45 e8             	mov    %eax,-0x18(%ebp)
  1050d2:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  1050d6:	75 19                	jne    1050f1 <default_check+0x477>
  1050d8:	68 a0 6d 10 00       	push   $0x106da0
  1050dd:	68 76 6a 10 00       	push   $0x106a76
  1050e2:	68 23 01 00 00       	push   $0x123
  1050e7:	68 8b 6a 10 00       	push   $0x106a8b
  1050ec:	e8 19 b3 ff ff       	call   10040a <__panic>
    assert(alloc_page() == NULL);
  1050f1:	83 ec 0c             	sub    $0xc,%esp
  1050f4:	6a 01                	push   $0x1
  1050f6:	e8 ea db ff ff       	call   102ce5 <alloc_pages>
  1050fb:	83 c4 10             	add    $0x10,%esp
  1050fe:	85 c0                	test   %eax,%eax
  105100:	74 19                	je     10511b <default_check+0x4a1>
  105102:	68 fe 6b 10 00       	push   $0x106bfe
  105107:	68 76 6a 10 00       	push   $0x106a76
  10510c:	68 24 01 00 00       	push   $0x124
  105111:	68 8b 6a 10 00       	push   $0x106a8b
  105116:	e8 ef b2 ff ff       	call   10040a <__panic>

    assert(nr_free == 0);
  10511b:	a1 64 a9 11 00       	mov    0x11a964,%eax
  105120:	85 c0                	test   %eax,%eax
  105122:	74 19                	je     10513d <default_check+0x4c3>
  105124:	68 51 6c 10 00       	push   $0x106c51
  105129:	68 76 6a 10 00       	push   $0x106a76
  10512e:	68 26 01 00 00       	push   $0x126
  105133:	68 8b 6a 10 00       	push   $0x106a8b
  105138:	e8 cd b2 ff ff       	call   10040a <__panic>
    nr_free = nr_free_store;
  10513d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  105140:	a3 64 a9 11 00       	mov    %eax,0x11a964

    free_list = free_list_store;
  105145:	8b 45 80             	mov    -0x80(%ebp),%eax
  105148:	8b 55 84             	mov    -0x7c(%ebp),%edx
  10514b:	a3 5c a9 11 00       	mov    %eax,0x11a95c
  105150:	89 15 60 a9 11 00    	mov    %edx,0x11a960
    free_pages(p0, 5);
  105156:	83 ec 08             	sub    $0x8,%esp
  105159:	6a 05                	push   $0x5
  10515b:	ff 75 e8             	pushl  -0x18(%ebp)
  10515e:	e8 c4 db ff ff       	call   102d27 <free_pages>
  105163:	83 c4 10             	add    $0x10,%esp

    le = &free_list;
  105166:	c7 45 ec 5c a9 11 00 	movl   $0x11a95c,-0x14(%ebp)
    while ((le = list_next(le)) != &free_list) {
  10516d:	eb 1d                	jmp    10518c <default_check+0x512>
        struct Page *p = le2page(le, page_link);
  10516f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  105172:	83 e8 0c             	sub    $0xc,%eax
  105175:	89 45 d8             	mov    %eax,-0x28(%ebp)
        count --, total -= p->property;
  105178:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
  10517c:	8b 55 f0             	mov    -0x10(%ebp),%edx
  10517f:	8b 45 d8             	mov    -0x28(%ebp),%eax
  105182:	8b 40 08             	mov    0x8(%eax),%eax
  105185:	29 c2                	sub    %eax,%edx
  105187:	89 d0                	mov    %edx,%eax
  105189:	89 45 f0             	mov    %eax,-0x10(%ebp)
  10518c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  10518f:	89 45 88             	mov    %eax,-0x78(%ebp)
    return listelm->next;
  105192:	8b 45 88             	mov    -0x78(%ebp),%eax
  105195:	8b 40 04             	mov    0x4(%eax),%eax
    while ((le = list_next(le)) != &free_list) {
  105198:	89 45 ec             	mov    %eax,-0x14(%ebp)
  10519b:	81 7d ec 5c a9 11 00 	cmpl   $0x11a95c,-0x14(%ebp)
  1051a2:	75 cb                	jne    10516f <default_check+0x4f5>
    }
    assert(count == 0);
  1051a4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  1051a8:	74 19                	je     1051c3 <default_check+0x549>
  1051aa:	68 be 6d 10 00       	push   $0x106dbe
  1051af:	68 76 6a 10 00       	push   $0x106a76
  1051b4:	68 31 01 00 00       	push   $0x131
  1051b9:	68 8b 6a 10 00       	push   $0x106a8b
  1051be:	e8 47 b2 ff ff       	call   10040a <__panic>
    assert(total == 0);
  1051c3:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  1051c7:	74 19                	je     1051e2 <default_check+0x568>
  1051c9:	68 c9 6d 10 00       	push   $0x106dc9
  1051ce:	68 76 6a 10 00       	push   $0x106a76
  1051d3:	68 32 01 00 00       	push   $0x132
  1051d8:	68 8b 6a 10 00       	push   $0x106a8b
  1051dd:	e8 28 b2 ff ff       	call   10040a <__panic>
}
  1051e2:	90                   	nop
  1051e3:	c9                   	leave  
  1051e4:	c3                   	ret    

001051e5 <strlen>:
 * @s:      the input string
 *
 * The strlen() function returns the length of string @s.
 * */
size_t
strlen(const char *s) {
  1051e5:	f3 0f 1e fb          	endbr32 
  1051e9:	55                   	push   %ebp
  1051ea:	89 e5                	mov    %esp,%ebp
  1051ec:	83 ec 10             	sub    $0x10,%esp
    size_t cnt = 0;
  1051ef:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    while (*s ++ != '\0') {
  1051f6:	eb 04                	jmp    1051fc <strlen+0x17>
        cnt ++;
  1051f8:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    while (*s ++ != '\0') {
  1051fc:	8b 45 08             	mov    0x8(%ebp),%eax
  1051ff:	8d 50 01             	lea    0x1(%eax),%edx
  105202:	89 55 08             	mov    %edx,0x8(%ebp)
  105205:	0f b6 00             	movzbl (%eax),%eax
  105208:	84 c0                	test   %al,%al
  10520a:	75 ec                	jne    1051f8 <strlen+0x13>
    }
    return cnt;
  10520c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  10520f:	c9                   	leave  
  105210:	c3                   	ret    

00105211 <strnlen>:
 * The return value is strlen(s), if that is less than @len, or
 * @len if there is no '\0' character among the first @len characters
 * pointed by @s.
 * */
size_t
strnlen(const char *s, size_t len) {
  105211:	f3 0f 1e fb          	endbr32 
  105215:	55                   	push   %ebp
  105216:	89 e5                	mov    %esp,%ebp
  105218:	83 ec 10             	sub    $0x10,%esp
    size_t cnt = 0;
  10521b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    while (cnt < len && *s ++ != '\0') {
  105222:	eb 04                	jmp    105228 <strnlen+0x17>
        cnt ++;
  105224:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    while (cnt < len && *s ++ != '\0') {
  105228:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10522b:	3b 45 0c             	cmp    0xc(%ebp),%eax
  10522e:	73 10                	jae    105240 <strnlen+0x2f>
  105230:	8b 45 08             	mov    0x8(%ebp),%eax
  105233:	8d 50 01             	lea    0x1(%eax),%edx
  105236:	89 55 08             	mov    %edx,0x8(%ebp)
  105239:	0f b6 00             	movzbl (%eax),%eax
  10523c:	84 c0                	test   %al,%al
  10523e:	75 e4                	jne    105224 <strnlen+0x13>
    }
    return cnt;
  105240:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  105243:	c9                   	leave  
  105244:	c3                   	ret    

00105245 <strcpy>:
 * To avoid overflows, the size of array pointed by @dst should be long enough to
 * contain the same string as @src (including the terminating null character), and
 * should not overlap in memory with @src.
 * */
char *
strcpy(char *dst, const char *src) {
  105245:	f3 0f 1e fb          	endbr32 
  105249:	55                   	push   %ebp
  10524a:	89 e5                	mov    %esp,%ebp
  10524c:	57                   	push   %edi
  10524d:	56                   	push   %esi
  10524e:	83 ec 20             	sub    $0x20,%esp
  105251:	8b 45 08             	mov    0x8(%ebp),%eax
  105254:	89 45 f4             	mov    %eax,-0xc(%ebp)
  105257:	8b 45 0c             	mov    0xc(%ebp),%eax
  10525a:	89 45 f0             	mov    %eax,-0x10(%ebp)
#ifndef __HAVE_ARCH_STRCPY
#define __HAVE_ARCH_STRCPY
static inline char *
__strcpy(char *dst, const char *src) {
    int d0, d1, d2;
    asm volatile (
  10525d:	8b 55 f0             	mov    -0x10(%ebp),%edx
  105260:	8b 45 f4             	mov    -0xc(%ebp),%eax
  105263:	89 d1                	mov    %edx,%ecx
  105265:	89 c2                	mov    %eax,%edx
  105267:	89 ce                	mov    %ecx,%esi
  105269:	89 d7                	mov    %edx,%edi
  10526b:	ac                   	lods   %ds:(%esi),%al
  10526c:	aa                   	stos   %al,%es:(%edi)
  10526d:	84 c0                	test   %al,%al
  10526f:	75 fa                	jne    10526b <strcpy+0x26>
  105271:	89 fa                	mov    %edi,%edx
  105273:	89 f1                	mov    %esi,%ecx
  105275:	89 4d ec             	mov    %ecx,-0x14(%ebp)
  105278:	89 55 e8             	mov    %edx,-0x18(%ebp)
  10527b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        "stosb;"
        "testb %%al, %%al;"
        "jne 1b;"
        : "=&S" (d0), "=&D" (d1), "=&a" (d2)
        : "0" (src), "1" (dst) : "memory");
    return dst;
  10527e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    char *p = dst;
    while ((*p ++ = *src ++) != '\0')
        /* nothing */;
    return dst;
#endif /* __HAVE_ARCH_STRCPY */
}
  105281:	83 c4 20             	add    $0x20,%esp
  105284:	5e                   	pop    %esi
  105285:	5f                   	pop    %edi
  105286:	5d                   	pop    %ebp
  105287:	c3                   	ret    

00105288 <strncpy>:
 * @len:    maximum number of characters to be copied from @src
 *
 * The return value is @dst
 * */
char *
strncpy(char *dst, const char *src, size_t len) {
  105288:	f3 0f 1e fb          	endbr32 
  10528c:	55                   	push   %ebp
  10528d:	89 e5                	mov    %esp,%ebp
  10528f:	83 ec 10             	sub    $0x10,%esp
    char *p = dst;
  105292:	8b 45 08             	mov    0x8(%ebp),%eax
  105295:	89 45 fc             	mov    %eax,-0x4(%ebp)
    while (len > 0) {
  105298:	eb 21                	jmp    1052bb <strncpy+0x33>
        if ((*p = *src) != '\0') {
  10529a:	8b 45 0c             	mov    0xc(%ebp),%eax
  10529d:	0f b6 10             	movzbl (%eax),%edx
  1052a0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1052a3:	88 10                	mov    %dl,(%eax)
  1052a5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1052a8:	0f b6 00             	movzbl (%eax),%eax
  1052ab:	84 c0                	test   %al,%al
  1052ad:	74 04                	je     1052b3 <strncpy+0x2b>
            src ++;
  1052af:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
        }
        p ++, len --;
  1052b3:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  1052b7:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
    while (len > 0) {
  1052bb:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  1052bf:	75 d9                	jne    10529a <strncpy+0x12>
    }
    return dst;
  1052c1:	8b 45 08             	mov    0x8(%ebp),%eax
}
  1052c4:	c9                   	leave  
  1052c5:	c3                   	ret    

001052c6 <strcmp>:
 * - A value greater than zero indicates that the first character that does
 *   not match has a greater value in @s1 than in @s2;
 * - And a value less than zero indicates the opposite.
 * */
int
strcmp(const char *s1, const char *s2) {
  1052c6:	f3 0f 1e fb          	endbr32 
  1052ca:	55                   	push   %ebp
  1052cb:	89 e5                	mov    %esp,%ebp
  1052cd:	57                   	push   %edi
  1052ce:	56                   	push   %esi
  1052cf:	83 ec 20             	sub    $0x20,%esp
  1052d2:	8b 45 08             	mov    0x8(%ebp),%eax
  1052d5:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1052d8:	8b 45 0c             	mov    0xc(%ebp),%eax
  1052db:	89 45 f0             	mov    %eax,-0x10(%ebp)
    asm volatile (
  1052de:	8b 55 f4             	mov    -0xc(%ebp),%edx
  1052e1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1052e4:	89 d1                	mov    %edx,%ecx
  1052e6:	89 c2                	mov    %eax,%edx
  1052e8:	89 ce                	mov    %ecx,%esi
  1052ea:	89 d7                	mov    %edx,%edi
  1052ec:	ac                   	lods   %ds:(%esi),%al
  1052ed:	ae                   	scas   %es:(%edi),%al
  1052ee:	75 08                	jne    1052f8 <strcmp+0x32>
  1052f0:	84 c0                	test   %al,%al
  1052f2:	75 f8                	jne    1052ec <strcmp+0x26>
  1052f4:	31 c0                	xor    %eax,%eax
  1052f6:	eb 04                	jmp    1052fc <strcmp+0x36>
  1052f8:	19 c0                	sbb    %eax,%eax
  1052fa:	0c 01                	or     $0x1,%al
  1052fc:	89 fa                	mov    %edi,%edx
  1052fe:	89 f1                	mov    %esi,%ecx
  105300:	89 45 ec             	mov    %eax,-0x14(%ebp)
  105303:	89 4d e8             	mov    %ecx,-0x18(%ebp)
  105306:	89 55 e4             	mov    %edx,-0x1c(%ebp)
    return ret;
  105309:	8b 45 ec             	mov    -0x14(%ebp),%eax
    while (*s1 != '\0' && *s1 == *s2) {
        s1 ++, s2 ++;
    }
    return (int)((unsigned char)*s1 - (unsigned char)*s2);
#endif /* __HAVE_ARCH_STRCMP */
}
  10530c:	83 c4 20             	add    $0x20,%esp
  10530f:	5e                   	pop    %esi
  105310:	5f                   	pop    %edi
  105311:	5d                   	pop    %ebp
  105312:	c3                   	ret    

00105313 <strncmp>:
 * they are equal to each other, it continues with the following pairs until
 * the characters differ, until a terminating null-character is reached, or
 * until @n characters match in both strings, whichever happens first.
 * */
int
strncmp(const char *s1, const char *s2, size_t n) {
  105313:	f3 0f 1e fb          	endbr32 
  105317:	55                   	push   %ebp
  105318:	89 e5                	mov    %esp,%ebp
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
  10531a:	eb 0c                	jmp    105328 <strncmp+0x15>
        n --, s1 ++, s2 ++;
  10531c:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
  105320:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  105324:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
  105328:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  10532c:	74 1a                	je     105348 <strncmp+0x35>
  10532e:	8b 45 08             	mov    0x8(%ebp),%eax
  105331:	0f b6 00             	movzbl (%eax),%eax
  105334:	84 c0                	test   %al,%al
  105336:	74 10                	je     105348 <strncmp+0x35>
  105338:	8b 45 08             	mov    0x8(%ebp),%eax
  10533b:	0f b6 10             	movzbl (%eax),%edx
  10533e:	8b 45 0c             	mov    0xc(%ebp),%eax
  105341:	0f b6 00             	movzbl (%eax),%eax
  105344:	38 c2                	cmp    %al,%dl
  105346:	74 d4                	je     10531c <strncmp+0x9>
    }
    return (n == 0) ? 0 : (int)((unsigned char)*s1 - (unsigned char)*s2);
  105348:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  10534c:	74 18                	je     105366 <strncmp+0x53>
  10534e:	8b 45 08             	mov    0x8(%ebp),%eax
  105351:	0f b6 00             	movzbl (%eax),%eax
  105354:	0f b6 d0             	movzbl %al,%edx
  105357:	8b 45 0c             	mov    0xc(%ebp),%eax
  10535a:	0f b6 00             	movzbl (%eax),%eax
  10535d:	0f b6 c0             	movzbl %al,%eax
  105360:	29 c2                	sub    %eax,%edx
  105362:	89 d0                	mov    %edx,%eax
  105364:	eb 05                	jmp    10536b <strncmp+0x58>
  105366:	b8 00 00 00 00       	mov    $0x0,%eax
}
  10536b:	5d                   	pop    %ebp
  10536c:	c3                   	ret    

0010536d <strchr>:
 *
 * The strchr() function returns a pointer to the first occurrence of
 * character in @s. If the value is not found, the function returns 'NULL'.
 * */
char *
strchr(const char *s, char c) {
  10536d:	f3 0f 1e fb          	endbr32 
  105371:	55                   	push   %ebp
  105372:	89 e5                	mov    %esp,%ebp
  105374:	83 ec 04             	sub    $0x4,%esp
  105377:	8b 45 0c             	mov    0xc(%ebp),%eax
  10537a:	88 45 fc             	mov    %al,-0x4(%ebp)
    while (*s != '\0') {
  10537d:	eb 14                	jmp    105393 <strchr+0x26>
        if (*s == c) {
  10537f:	8b 45 08             	mov    0x8(%ebp),%eax
  105382:	0f b6 00             	movzbl (%eax),%eax
  105385:	38 45 fc             	cmp    %al,-0x4(%ebp)
  105388:	75 05                	jne    10538f <strchr+0x22>
            return (char *)s;
  10538a:	8b 45 08             	mov    0x8(%ebp),%eax
  10538d:	eb 13                	jmp    1053a2 <strchr+0x35>
        }
        s ++;
  10538f:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    while (*s != '\0') {
  105393:	8b 45 08             	mov    0x8(%ebp),%eax
  105396:	0f b6 00             	movzbl (%eax),%eax
  105399:	84 c0                	test   %al,%al
  10539b:	75 e2                	jne    10537f <strchr+0x12>
    }
    return NULL;
  10539d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  1053a2:	c9                   	leave  
  1053a3:	c3                   	ret    

001053a4 <strfind>:
 * The strfind() function is like strchr() except that if @c is
 * not found in @s, then it returns a pointer to the null byte at the
 * end of @s, rather than 'NULL'.
 * */
char *
strfind(const char *s, char c) {
  1053a4:	f3 0f 1e fb          	endbr32 
  1053a8:	55                   	push   %ebp
  1053a9:	89 e5                	mov    %esp,%ebp
  1053ab:	83 ec 04             	sub    $0x4,%esp
  1053ae:	8b 45 0c             	mov    0xc(%ebp),%eax
  1053b1:	88 45 fc             	mov    %al,-0x4(%ebp)
    while (*s != '\0') {
  1053b4:	eb 0f                	jmp    1053c5 <strfind+0x21>
        if (*s == c) {
  1053b6:	8b 45 08             	mov    0x8(%ebp),%eax
  1053b9:	0f b6 00             	movzbl (%eax),%eax
  1053bc:	38 45 fc             	cmp    %al,-0x4(%ebp)
  1053bf:	74 10                	je     1053d1 <strfind+0x2d>
            break;
        }
        s ++;
  1053c1:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    while (*s != '\0') {
  1053c5:	8b 45 08             	mov    0x8(%ebp),%eax
  1053c8:	0f b6 00             	movzbl (%eax),%eax
  1053cb:	84 c0                	test   %al,%al
  1053cd:	75 e7                	jne    1053b6 <strfind+0x12>
  1053cf:	eb 01                	jmp    1053d2 <strfind+0x2e>
            break;
  1053d1:	90                   	nop
    }
    return (char *)s;
  1053d2:	8b 45 08             	mov    0x8(%ebp),%eax
}
  1053d5:	c9                   	leave  
  1053d6:	c3                   	ret    

001053d7 <strtol>:
 * an optional "0x" or "0X" prefix.
 *
 * The strtol() function returns the converted integral number as a long int value.
 * */
long
strtol(const char *s, char **endptr, int base) {
  1053d7:	f3 0f 1e fb          	endbr32 
  1053db:	55                   	push   %ebp
  1053dc:	89 e5                	mov    %esp,%ebp
  1053de:	83 ec 10             	sub    $0x10,%esp
    int neg = 0;
  1053e1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    long val = 0;
  1053e8:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

    // gobble initial whitespace
    while (*s == ' ' || *s == '\t') {
  1053ef:	eb 04                	jmp    1053f5 <strtol+0x1e>
        s ++;
  1053f1:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    while (*s == ' ' || *s == '\t') {
  1053f5:	8b 45 08             	mov    0x8(%ebp),%eax
  1053f8:	0f b6 00             	movzbl (%eax),%eax
  1053fb:	3c 20                	cmp    $0x20,%al
  1053fd:	74 f2                	je     1053f1 <strtol+0x1a>
  1053ff:	8b 45 08             	mov    0x8(%ebp),%eax
  105402:	0f b6 00             	movzbl (%eax),%eax
  105405:	3c 09                	cmp    $0x9,%al
  105407:	74 e8                	je     1053f1 <strtol+0x1a>
    }

    // plus/minus sign
    if (*s == '+') {
  105409:	8b 45 08             	mov    0x8(%ebp),%eax
  10540c:	0f b6 00             	movzbl (%eax),%eax
  10540f:	3c 2b                	cmp    $0x2b,%al
  105411:	75 06                	jne    105419 <strtol+0x42>
        s ++;
  105413:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  105417:	eb 15                	jmp    10542e <strtol+0x57>
    }
    else if (*s == '-') {
  105419:	8b 45 08             	mov    0x8(%ebp),%eax
  10541c:	0f b6 00             	movzbl (%eax),%eax
  10541f:	3c 2d                	cmp    $0x2d,%al
  105421:	75 0b                	jne    10542e <strtol+0x57>
        s ++, neg = 1;
  105423:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  105427:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
    }

    // hex or octal base prefix
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x')) {
  10542e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  105432:	74 06                	je     10543a <strtol+0x63>
  105434:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  105438:	75 24                	jne    10545e <strtol+0x87>
  10543a:	8b 45 08             	mov    0x8(%ebp),%eax
  10543d:	0f b6 00             	movzbl (%eax),%eax
  105440:	3c 30                	cmp    $0x30,%al
  105442:	75 1a                	jne    10545e <strtol+0x87>
  105444:	8b 45 08             	mov    0x8(%ebp),%eax
  105447:	83 c0 01             	add    $0x1,%eax
  10544a:	0f b6 00             	movzbl (%eax),%eax
  10544d:	3c 78                	cmp    $0x78,%al
  10544f:	75 0d                	jne    10545e <strtol+0x87>
        s += 2, base = 16;
  105451:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  105455:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  10545c:	eb 2a                	jmp    105488 <strtol+0xb1>
    }
    else if (base == 0 && s[0] == '0') {
  10545e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  105462:	75 17                	jne    10547b <strtol+0xa4>
  105464:	8b 45 08             	mov    0x8(%ebp),%eax
  105467:	0f b6 00             	movzbl (%eax),%eax
  10546a:	3c 30                	cmp    $0x30,%al
  10546c:	75 0d                	jne    10547b <strtol+0xa4>
        s ++, base = 8;
  10546e:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  105472:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  105479:	eb 0d                	jmp    105488 <strtol+0xb1>
    }
    else if (base == 0) {
  10547b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  10547f:	75 07                	jne    105488 <strtol+0xb1>
        base = 10;
  105481:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

    // digits
    while (1) {
        int dig;

        if (*s >= '0' && *s <= '9') {
  105488:	8b 45 08             	mov    0x8(%ebp),%eax
  10548b:	0f b6 00             	movzbl (%eax),%eax
  10548e:	3c 2f                	cmp    $0x2f,%al
  105490:	7e 1b                	jle    1054ad <strtol+0xd6>
  105492:	8b 45 08             	mov    0x8(%ebp),%eax
  105495:	0f b6 00             	movzbl (%eax),%eax
  105498:	3c 39                	cmp    $0x39,%al
  10549a:	7f 11                	jg     1054ad <strtol+0xd6>
            dig = *s - '0';
  10549c:	8b 45 08             	mov    0x8(%ebp),%eax
  10549f:	0f b6 00             	movzbl (%eax),%eax
  1054a2:	0f be c0             	movsbl %al,%eax
  1054a5:	83 e8 30             	sub    $0x30,%eax
  1054a8:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1054ab:	eb 48                	jmp    1054f5 <strtol+0x11e>
        }
        else if (*s >= 'a' && *s <= 'z') {
  1054ad:	8b 45 08             	mov    0x8(%ebp),%eax
  1054b0:	0f b6 00             	movzbl (%eax),%eax
  1054b3:	3c 60                	cmp    $0x60,%al
  1054b5:	7e 1b                	jle    1054d2 <strtol+0xfb>
  1054b7:	8b 45 08             	mov    0x8(%ebp),%eax
  1054ba:	0f b6 00             	movzbl (%eax),%eax
  1054bd:	3c 7a                	cmp    $0x7a,%al
  1054bf:	7f 11                	jg     1054d2 <strtol+0xfb>
            dig = *s - 'a' + 10;
  1054c1:	8b 45 08             	mov    0x8(%ebp),%eax
  1054c4:	0f b6 00             	movzbl (%eax),%eax
  1054c7:	0f be c0             	movsbl %al,%eax
  1054ca:	83 e8 57             	sub    $0x57,%eax
  1054cd:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1054d0:	eb 23                	jmp    1054f5 <strtol+0x11e>
        }
        else if (*s >= 'A' && *s <= 'Z') {
  1054d2:	8b 45 08             	mov    0x8(%ebp),%eax
  1054d5:	0f b6 00             	movzbl (%eax),%eax
  1054d8:	3c 40                	cmp    $0x40,%al
  1054da:	7e 3c                	jle    105518 <strtol+0x141>
  1054dc:	8b 45 08             	mov    0x8(%ebp),%eax
  1054df:	0f b6 00             	movzbl (%eax),%eax
  1054e2:	3c 5a                	cmp    $0x5a,%al
  1054e4:	7f 32                	jg     105518 <strtol+0x141>
            dig = *s - 'A' + 10;
  1054e6:	8b 45 08             	mov    0x8(%ebp),%eax
  1054e9:	0f b6 00             	movzbl (%eax),%eax
  1054ec:	0f be c0             	movsbl %al,%eax
  1054ef:	83 e8 37             	sub    $0x37,%eax
  1054f2:	89 45 f4             	mov    %eax,-0xc(%ebp)
        }
        else {
            break;
        }
        if (dig >= base) {
  1054f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1054f8:	3b 45 10             	cmp    0x10(%ebp),%eax
  1054fb:	7d 1a                	jge    105517 <strtol+0x140>
            break;
        }
        s ++, val = (val * base) + dig;
  1054fd:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  105501:	8b 45 f8             	mov    -0x8(%ebp),%eax
  105504:	0f af 45 10          	imul   0x10(%ebp),%eax
  105508:	89 c2                	mov    %eax,%edx
  10550a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10550d:	01 d0                	add    %edx,%eax
  10550f:	89 45 f8             	mov    %eax,-0x8(%ebp)
    while (1) {
  105512:	e9 71 ff ff ff       	jmp    105488 <strtol+0xb1>
            break;
  105517:	90                   	nop
        // we don't properly detect overflow!
    }

    if (endptr) {
  105518:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  10551c:	74 08                	je     105526 <strtol+0x14f>
        *endptr = (char *) s;
  10551e:	8b 45 0c             	mov    0xc(%ebp),%eax
  105521:	8b 55 08             	mov    0x8(%ebp),%edx
  105524:	89 10                	mov    %edx,(%eax)
    }
    return (neg ? -val : val);
  105526:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  10552a:	74 07                	je     105533 <strtol+0x15c>
  10552c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  10552f:	f7 d8                	neg    %eax
  105531:	eb 03                	jmp    105536 <strtol+0x15f>
  105533:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  105536:	c9                   	leave  
  105537:	c3                   	ret    

00105538 <memset>:
 * @n:      number of bytes to be set to the value
 *
 * The memset() function returns @s.
 * */
void *
memset(void *s, char c, size_t n) {
  105538:	f3 0f 1e fb          	endbr32 
  10553c:	55                   	push   %ebp
  10553d:	89 e5                	mov    %esp,%ebp
  10553f:	57                   	push   %edi
  105540:	83 ec 24             	sub    $0x24,%esp
  105543:	8b 45 0c             	mov    0xc(%ebp),%eax
  105546:	88 45 d8             	mov    %al,-0x28(%ebp)
#ifdef __HAVE_ARCH_MEMSET
    return __memset(s, c, n);
  105549:	0f be 45 d8          	movsbl -0x28(%ebp),%eax
  10554d:	8b 55 08             	mov    0x8(%ebp),%edx
  105550:	89 55 f8             	mov    %edx,-0x8(%ebp)
  105553:	88 45 f7             	mov    %al,-0x9(%ebp)
  105556:	8b 45 10             	mov    0x10(%ebp),%eax
  105559:	89 45 f0             	mov    %eax,-0x10(%ebp)
#ifndef __HAVE_ARCH_MEMSET
#define __HAVE_ARCH_MEMSET
static inline void *
__memset(void *s, char c, size_t n) {
    int d0, d1;
    asm volatile (
  10555c:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  10555f:	0f b6 45 f7          	movzbl -0x9(%ebp),%eax
  105563:	8b 55 f8             	mov    -0x8(%ebp),%edx
  105566:	89 d7                	mov    %edx,%edi
  105568:	f3 aa                	rep stos %al,%es:(%edi)
  10556a:	89 fa                	mov    %edi,%edx
  10556c:	89 4d ec             	mov    %ecx,-0x14(%ebp)
  10556f:	89 55 e8             	mov    %edx,-0x18(%ebp)
        "rep; stosb;"
        : "=&c" (d0), "=&D" (d1)
        : "0" (n), "a" (c), "1" (s)
        : "memory");
    return s;
  105572:	8b 45 f8             	mov    -0x8(%ebp),%eax
    while (n -- > 0) {
        *p ++ = c;
    }
    return s;
#endif /* __HAVE_ARCH_MEMSET */
}
  105575:	83 c4 24             	add    $0x24,%esp
  105578:	5f                   	pop    %edi
  105579:	5d                   	pop    %ebp
  10557a:	c3                   	ret    

0010557b <memmove>:
 * @n:      number of bytes to copy
 *
 * The memmove() function returns @dst.
 * */
void *
memmove(void *dst, const void *src, size_t n) {
  10557b:	f3 0f 1e fb          	endbr32 
  10557f:	55                   	push   %ebp
  105580:	89 e5                	mov    %esp,%ebp
  105582:	57                   	push   %edi
  105583:	56                   	push   %esi
  105584:	53                   	push   %ebx
  105585:	83 ec 30             	sub    $0x30,%esp
  105588:	8b 45 08             	mov    0x8(%ebp),%eax
  10558b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  10558e:	8b 45 0c             	mov    0xc(%ebp),%eax
  105591:	89 45 ec             	mov    %eax,-0x14(%ebp)
  105594:	8b 45 10             	mov    0x10(%ebp),%eax
  105597:	89 45 e8             	mov    %eax,-0x18(%ebp)

#ifndef __HAVE_ARCH_MEMMOVE
#define __HAVE_ARCH_MEMMOVE
static inline void *
__memmove(void *dst, const void *src, size_t n) {
    if (dst < src) {
  10559a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10559d:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  1055a0:	73 42                	jae    1055e4 <memmove+0x69>
  1055a2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1055a5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  1055a8:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1055ab:	89 45 e0             	mov    %eax,-0x20(%ebp)
  1055ae:	8b 45 e8             	mov    -0x18(%ebp),%eax
  1055b1:	89 45 dc             	mov    %eax,-0x24(%ebp)
        "andl $3, %%ecx;"
        "jz 1f;"
        "rep; movsb;"
        "1:"
        : "=&c" (d0), "=&D" (d1), "=&S" (d2)
        : "0" (n / 4), "g" (n), "1" (dst), "2" (src)
  1055b4:	8b 45 dc             	mov    -0x24(%ebp),%eax
  1055b7:	c1 e8 02             	shr    $0x2,%eax
  1055ba:	89 c1                	mov    %eax,%ecx
    asm volatile (
  1055bc:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  1055bf:	8b 45 e0             	mov    -0x20(%ebp),%eax
  1055c2:	89 d7                	mov    %edx,%edi
  1055c4:	89 c6                	mov    %eax,%esi
  1055c6:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  1055c8:	8b 4d dc             	mov    -0x24(%ebp),%ecx
  1055cb:	83 e1 03             	and    $0x3,%ecx
  1055ce:	74 02                	je     1055d2 <memmove+0x57>
  1055d0:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  1055d2:	89 f0                	mov    %esi,%eax
  1055d4:	89 fa                	mov    %edi,%edx
  1055d6:	89 4d d8             	mov    %ecx,-0x28(%ebp)
  1055d9:	89 55 d4             	mov    %edx,-0x2c(%ebp)
  1055dc:	89 45 d0             	mov    %eax,-0x30(%ebp)
        : "memory");
    return dst;
  1055df:	8b 45 e4             	mov    -0x1c(%ebp),%eax
        return __memcpy(dst, src, n);
  1055e2:	eb 36                	jmp    10561a <memmove+0x9f>
        : "0" (n), "1" (n - 1 + src), "2" (n - 1 + dst)
  1055e4:	8b 45 e8             	mov    -0x18(%ebp),%eax
  1055e7:	8d 50 ff             	lea    -0x1(%eax),%edx
  1055ea:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1055ed:	01 c2                	add    %eax,%edx
  1055ef:	8b 45 e8             	mov    -0x18(%ebp),%eax
  1055f2:	8d 48 ff             	lea    -0x1(%eax),%ecx
  1055f5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1055f8:	8d 1c 01             	lea    (%ecx,%eax,1),%ebx
    asm volatile (
  1055fb:	8b 45 e8             	mov    -0x18(%ebp),%eax
  1055fe:	89 c1                	mov    %eax,%ecx
  105600:	89 d8                	mov    %ebx,%eax
  105602:	89 d6                	mov    %edx,%esi
  105604:	89 c7                	mov    %eax,%edi
  105606:	fd                   	std    
  105607:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  105609:	fc                   	cld    
  10560a:	89 f8                	mov    %edi,%eax
  10560c:	89 f2                	mov    %esi,%edx
  10560e:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  105611:	89 55 c8             	mov    %edx,-0x38(%ebp)
  105614:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    return dst;
  105617:	8b 45 f0             	mov    -0x10(%ebp),%eax
            *d ++ = *s ++;
        }
    }
    return dst;
#endif /* __HAVE_ARCH_MEMMOVE */
}
  10561a:	83 c4 30             	add    $0x30,%esp
  10561d:	5b                   	pop    %ebx
  10561e:	5e                   	pop    %esi
  10561f:	5f                   	pop    %edi
  105620:	5d                   	pop    %ebp
  105621:	c3                   	ret    

00105622 <memcpy>:
 * it always copies exactly @n bytes. To avoid overflows, the size of arrays pointed
 * by both @src and @dst, should be at least @n bytes, and should not overlap
 * (for overlapping memory area, memmove is a safer approach).
 * */
void *
memcpy(void *dst, const void *src, size_t n) {
  105622:	f3 0f 1e fb          	endbr32 
  105626:	55                   	push   %ebp
  105627:	89 e5                	mov    %esp,%ebp
  105629:	57                   	push   %edi
  10562a:	56                   	push   %esi
  10562b:	83 ec 20             	sub    $0x20,%esp
  10562e:	8b 45 08             	mov    0x8(%ebp),%eax
  105631:	89 45 f4             	mov    %eax,-0xc(%ebp)
  105634:	8b 45 0c             	mov    0xc(%ebp),%eax
  105637:	89 45 f0             	mov    %eax,-0x10(%ebp)
  10563a:	8b 45 10             	mov    0x10(%ebp),%eax
  10563d:	89 45 ec             	mov    %eax,-0x14(%ebp)
        : "0" (n / 4), "g" (n), "1" (dst), "2" (src)
  105640:	8b 45 ec             	mov    -0x14(%ebp),%eax
  105643:	c1 e8 02             	shr    $0x2,%eax
  105646:	89 c1                	mov    %eax,%ecx
    asm volatile (
  105648:	8b 55 f4             	mov    -0xc(%ebp),%edx
  10564b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10564e:	89 d7                	mov    %edx,%edi
  105650:	89 c6                	mov    %eax,%esi
  105652:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  105654:	8b 4d ec             	mov    -0x14(%ebp),%ecx
  105657:	83 e1 03             	and    $0x3,%ecx
  10565a:	74 02                	je     10565e <memcpy+0x3c>
  10565c:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  10565e:	89 f0                	mov    %esi,%eax
  105660:	89 fa                	mov    %edi,%edx
  105662:	89 4d e8             	mov    %ecx,-0x18(%ebp)
  105665:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  105668:	89 45 e0             	mov    %eax,-0x20(%ebp)
    return dst;
  10566b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    while (n -- > 0) {
        *d ++ = *s ++;
    }
    return dst;
#endif /* __HAVE_ARCH_MEMCPY */
}
  10566e:	83 c4 20             	add    $0x20,%esp
  105671:	5e                   	pop    %esi
  105672:	5f                   	pop    %edi
  105673:	5d                   	pop    %ebp
  105674:	c3                   	ret    

00105675 <memcmp>:
 *   match in both memory blocks has a greater value in @v1 than in @v2
 *   as if evaluated as unsigned char values;
 * - And a value less than zero indicates the opposite.
 * */
int
memcmp(const void *v1, const void *v2, size_t n) {
  105675:	f3 0f 1e fb          	endbr32 
  105679:	55                   	push   %ebp
  10567a:	89 e5                	mov    %esp,%ebp
  10567c:	83 ec 10             	sub    $0x10,%esp
    const char *s1 = (const char *)v1;
  10567f:	8b 45 08             	mov    0x8(%ebp),%eax
  105682:	89 45 fc             	mov    %eax,-0x4(%ebp)
    const char *s2 = (const char *)v2;
  105685:	8b 45 0c             	mov    0xc(%ebp),%eax
  105688:	89 45 f8             	mov    %eax,-0x8(%ebp)
    while (n -- > 0) {
  10568b:	eb 30                	jmp    1056bd <memcmp+0x48>
        if (*s1 != *s2) {
  10568d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  105690:	0f b6 10             	movzbl (%eax),%edx
  105693:	8b 45 f8             	mov    -0x8(%ebp),%eax
  105696:	0f b6 00             	movzbl (%eax),%eax
  105699:	38 c2                	cmp    %al,%dl
  10569b:	74 18                	je     1056b5 <memcmp+0x40>
            return (int)((unsigned char)*s1 - (unsigned char)*s2);
  10569d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1056a0:	0f b6 00             	movzbl (%eax),%eax
  1056a3:	0f b6 d0             	movzbl %al,%edx
  1056a6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  1056a9:	0f b6 00             	movzbl (%eax),%eax
  1056ac:	0f b6 c0             	movzbl %al,%eax
  1056af:	29 c2                	sub    %eax,%edx
  1056b1:	89 d0                	mov    %edx,%eax
  1056b3:	eb 1a                	jmp    1056cf <memcmp+0x5a>
        }
        s1 ++, s2 ++;
  1056b5:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  1056b9:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    while (n -- > 0) {
  1056bd:	8b 45 10             	mov    0x10(%ebp),%eax
  1056c0:	8d 50 ff             	lea    -0x1(%eax),%edx
  1056c3:	89 55 10             	mov    %edx,0x10(%ebp)
  1056c6:	85 c0                	test   %eax,%eax
  1056c8:	75 c3                	jne    10568d <memcmp+0x18>
    }
    return 0;
  1056ca:	b8 00 00 00 00       	mov    $0x0,%eax
}
  1056cf:	c9                   	leave  
  1056d0:	c3                   	ret    

001056d1 <printnum>:
 * @width:      maximum number of digits, if the actual width is less than @width, use @padc instead
 * @padc:       character that padded on the left if the actual width is less than @width
 * */
static void
printnum(void (*putch)(int, void*), void *putdat,
        unsigned long long num, unsigned base, int width, int padc) {
  1056d1:	f3 0f 1e fb          	endbr32 
  1056d5:	55                   	push   %ebp
  1056d6:	89 e5                	mov    %esp,%ebp
  1056d8:	83 ec 38             	sub    $0x38,%esp
  1056db:	8b 45 10             	mov    0x10(%ebp),%eax
  1056de:	89 45 d0             	mov    %eax,-0x30(%ebp)
  1056e1:	8b 45 14             	mov    0x14(%ebp),%eax
  1056e4:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    unsigned long long result = num;
  1056e7:	8b 45 d0             	mov    -0x30(%ebp),%eax
  1056ea:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  1056ed:	89 45 e8             	mov    %eax,-0x18(%ebp)
  1056f0:	89 55 ec             	mov    %edx,-0x14(%ebp)
    unsigned mod = do_div(result, base);
  1056f3:	8b 45 18             	mov    0x18(%ebp),%eax
  1056f6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  1056f9:	8b 45 e8             	mov    -0x18(%ebp),%eax
  1056fc:	8b 55 ec             	mov    -0x14(%ebp),%edx
  1056ff:	89 45 e0             	mov    %eax,-0x20(%ebp)
  105702:	89 55 f0             	mov    %edx,-0x10(%ebp)
  105705:	8b 45 f0             	mov    -0x10(%ebp),%eax
  105708:	89 45 f4             	mov    %eax,-0xc(%ebp)
  10570b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  10570f:	74 1c                	je     10572d <printnum+0x5c>
  105711:	8b 45 f0             	mov    -0x10(%ebp),%eax
  105714:	ba 00 00 00 00       	mov    $0x0,%edx
  105719:	f7 75 e4             	divl   -0x1c(%ebp)
  10571c:	89 55 f4             	mov    %edx,-0xc(%ebp)
  10571f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  105722:	ba 00 00 00 00       	mov    $0x0,%edx
  105727:	f7 75 e4             	divl   -0x1c(%ebp)
  10572a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  10572d:	8b 45 e0             	mov    -0x20(%ebp),%eax
  105730:	8b 55 f4             	mov    -0xc(%ebp),%edx
  105733:	f7 75 e4             	divl   -0x1c(%ebp)
  105736:	89 45 e0             	mov    %eax,-0x20(%ebp)
  105739:	89 55 dc             	mov    %edx,-0x24(%ebp)
  10573c:	8b 45 e0             	mov    -0x20(%ebp),%eax
  10573f:	8b 55 f0             	mov    -0x10(%ebp),%edx
  105742:	89 45 e8             	mov    %eax,-0x18(%ebp)
  105745:	89 55 ec             	mov    %edx,-0x14(%ebp)
  105748:	8b 45 dc             	mov    -0x24(%ebp),%eax
  10574b:	89 45 d8             	mov    %eax,-0x28(%ebp)

    // first recursively print all preceding (more significant) digits
    if (num >= base) {
  10574e:	8b 45 18             	mov    0x18(%ebp),%eax
  105751:	ba 00 00 00 00       	mov    $0x0,%edx
  105756:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
  105759:	39 45 d0             	cmp    %eax,-0x30(%ebp)
  10575c:	19 d1                	sbb    %edx,%ecx
  10575e:	72 37                	jb     105797 <printnum+0xc6>
        printnum(putch, putdat, result, base, width - 1, padc);
  105760:	8b 45 1c             	mov    0x1c(%ebp),%eax
  105763:	83 e8 01             	sub    $0x1,%eax
  105766:	83 ec 04             	sub    $0x4,%esp
  105769:	ff 75 20             	pushl  0x20(%ebp)
  10576c:	50                   	push   %eax
  10576d:	ff 75 18             	pushl  0x18(%ebp)
  105770:	ff 75 ec             	pushl  -0x14(%ebp)
  105773:	ff 75 e8             	pushl  -0x18(%ebp)
  105776:	ff 75 0c             	pushl  0xc(%ebp)
  105779:	ff 75 08             	pushl  0x8(%ebp)
  10577c:	e8 50 ff ff ff       	call   1056d1 <printnum>
  105781:	83 c4 20             	add    $0x20,%esp
  105784:	eb 1b                	jmp    1057a1 <printnum+0xd0>
    } else {
        // print any needed pad characters before first digit
        while (-- width > 0)
            putch(padc, putdat);
  105786:	83 ec 08             	sub    $0x8,%esp
  105789:	ff 75 0c             	pushl  0xc(%ebp)
  10578c:	ff 75 20             	pushl  0x20(%ebp)
  10578f:	8b 45 08             	mov    0x8(%ebp),%eax
  105792:	ff d0                	call   *%eax
  105794:	83 c4 10             	add    $0x10,%esp
        while (-- width > 0)
  105797:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
  10579b:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  10579f:	7f e5                	jg     105786 <printnum+0xb5>
    }
    // then print this (the least significant) digit
    putch("0123456789abcdef"[mod], putdat);
  1057a1:	8b 45 d8             	mov    -0x28(%ebp),%eax
  1057a4:	05 84 6e 10 00       	add    $0x106e84,%eax
  1057a9:	0f b6 00             	movzbl (%eax),%eax
  1057ac:	0f be c0             	movsbl %al,%eax
  1057af:	83 ec 08             	sub    $0x8,%esp
  1057b2:	ff 75 0c             	pushl  0xc(%ebp)
  1057b5:	50                   	push   %eax
  1057b6:	8b 45 08             	mov    0x8(%ebp),%eax
  1057b9:	ff d0                	call   *%eax
  1057bb:	83 c4 10             	add    $0x10,%esp
}
  1057be:	90                   	nop
  1057bf:	c9                   	leave  
  1057c0:	c3                   	ret    

001057c1 <getuint>:
 * getuint - get an unsigned int of various possible sizes from a varargs list
 * @ap:         a varargs list pointer
 * @lflag:      determines the size of the vararg that @ap points to
 * */
static unsigned long long
getuint(va_list *ap, int lflag) {
  1057c1:	f3 0f 1e fb          	endbr32 
  1057c5:	55                   	push   %ebp
  1057c6:	89 e5                	mov    %esp,%ebp
    if (lflag >= 2) {
  1057c8:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  1057cc:	7e 14                	jle    1057e2 <getuint+0x21>
        return va_arg(*ap, unsigned long long);
  1057ce:	8b 45 08             	mov    0x8(%ebp),%eax
  1057d1:	8b 00                	mov    (%eax),%eax
  1057d3:	8d 48 08             	lea    0x8(%eax),%ecx
  1057d6:	8b 55 08             	mov    0x8(%ebp),%edx
  1057d9:	89 0a                	mov    %ecx,(%edx)
  1057db:	8b 50 04             	mov    0x4(%eax),%edx
  1057de:	8b 00                	mov    (%eax),%eax
  1057e0:	eb 30                	jmp    105812 <getuint+0x51>
    }
    else if (lflag) {
  1057e2:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  1057e6:	74 16                	je     1057fe <getuint+0x3d>
        return va_arg(*ap, unsigned long);
  1057e8:	8b 45 08             	mov    0x8(%ebp),%eax
  1057eb:	8b 00                	mov    (%eax),%eax
  1057ed:	8d 48 04             	lea    0x4(%eax),%ecx
  1057f0:	8b 55 08             	mov    0x8(%ebp),%edx
  1057f3:	89 0a                	mov    %ecx,(%edx)
  1057f5:	8b 00                	mov    (%eax),%eax
  1057f7:	ba 00 00 00 00       	mov    $0x0,%edx
  1057fc:	eb 14                	jmp    105812 <getuint+0x51>
    }
    else {
        return va_arg(*ap, unsigned int);
  1057fe:	8b 45 08             	mov    0x8(%ebp),%eax
  105801:	8b 00                	mov    (%eax),%eax
  105803:	8d 48 04             	lea    0x4(%eax),%ecx
  105806:	8b 55 08             	mov    0x8(%ebp),%edx
  105809:	89 0a                	mov    %ecx,(%edx)
  10580b:	8b 00                	mov    (%eax),%eax
  10580d:	ba 00 00 00 00       	mov    $0x0,%edx
    }
}
  105812:	5d                   	pop    %ebp
  105813:	c3                   	ret    

00105814 <getint>:
 * getint - same as getuint but signed, we can't use getuint because of sign extension
 * @ap:         a varargs list pointer
 * @lflag:      determines the size of the vararg that @ap points to
 * */
static long long
getint(va_list *ap, int lflag) {
  105814:	f3 0f 1e fb          	endbr32 
  105818:	55                   	push   %ebp
  105819:	89 e5                	mov    %esp,%ebp
    if (lflag >= 2) {
  10581b:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  10581f:	7e 14                	jle    105835 <getint+0x21>
        return va_arg(*ap, long long);
  105821:	8b 45 08             	mov    0x8(%ebp),%eax
  105824:	8b 00                	mov    (%eax),%eax
  105826:	8d 48 08             	lea    0x8(%eax),%ecx
  105829:	8b 55 08             	mov    0x8(%ebp),%edx
  10582c:	89 0a                	mov    %ecx,(%edx)
  10582e:	8b 50 04             	mov    0x4(%eax),%edx
  105831:	8b 00                	mov    (%eax),%eax
  105833:	eb 28                	jmp    10585d <getint+0x49>
    }
    else if (lflag) {
  105835:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  105839:	74 12                	je     10584d <getint+0x39>
        return va_arg(*ap, long);
  10583b:	8b 45 08             	mov    0x8(%ebp),%eax
  10583e:	8b 00                	mov    (%eax),%eax
  105840:	8d 48 04             	lea    0x4(%eax),%ecx
  105843:	8b 55 08             	mov    0x8(%ebp),%edx
  105846:	89 0a                	mov    %ecx,(%edx)
  105848:	8b 00                	mov    (%eax),%eax
  10584a:	99                   	cltd   
  10584b:	eb 10                	jmp    10585d <getint+0x49>
    }
    else {
        return va_arg(*ap, int);
  10584d:	8b 45 08             	mov    0x8(%ebp),%eax
  105850:	8b 00                	mov    (%eax),%eax
  105852:	8d 48 04             	lea    0x4(%eax),%ecx
  105855:	8b 55 08             	mov    0x8(%ebp),%edx
  105858:	89 0a                	mov    %ecx,(%edx)
  10585a:	8b 00                	mov    (%eax),%eax
  10585c:	99                   	cltd   
    }
}
  10585d:	5d                   	pop    %ebp
  10585e:	c3                   	ret    

0010585f <printfmt>:
 * @putch:      specified putch function, print a single character
 * @putdat:     used by @putch function
 * @fmt:        the format string to use
 * */
void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
  10585f:	f3 0f 1e fb          	endbr32 
  105863:	55                   	push   %ebp
  105864:	89 e5                	mov    %esp,%ebp
  105866:	83 ec 18             	sub    $0x18,%esp
    va_list ap;

    va_start(ap, fmt);
  105869:	8d 45 14             	lea    0x14(%ebp),%eax
  10586c:	89 45 f4             	mov    %eax,-0xc(%ebp)
    vprintfmt(putch, putdat, fmt, ap);
  10586f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  105872:	50                   	push   %eax
  105873:	ff 75 10             	pushl  0x10(%ebp)
  105876:	ff 75 0c             	pushl  0xc(%ebp)
  105879:	ff 75 08             	pushl  0x8(%ebp)
  10587c:	e8 06 00 00 00       	call   105887 <vprintfmt>
  105881:	83 c4 10             	add    $0x10,%esp
    va_end(ap);
}
  105884:	90                   	nop
  105885:	c9                   	leave  
  105886:	c3                   	ret    

00105887 <vprintfmt>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want printfmt() instead.
 * */
void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap) {
  105887:	f3 0f 1e fb          	endbr32 
  10588b:	55                   	push   %ebp
  10588c:	89 e5                	mov    %esp,%ebp
  10588e:	56                   	push   %esi
  10588f:	53                   	push   %ebx
  105890:	83 ec 20             	sub    $0x20,%esp
    register int ch, err;
    unsigned long long num;
    int base, width, precision, lflag, altflag;

    while (1) {
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  105893:	eb 17                	jmp    1058ac <vprintfmt+0x25>
            if (ch == '\0') {
  105895:	85 db                	test   %ebx,%ebx
  105897:	0f 84 8f 03 00 00    	je     105c2c <vprintfmt+0x3a5>
                return;
            }
            putch(ch, putdat);
  10589d:	83 ec 08             	sub    $0x8,%esp
  1058a0:	ff 75 0c             	pushl  0xc(%ebp)
  1058a3:	53                   	push   %ebx
  1058a4:	8b 45 08             	mov    0x8(%ebp),%eax
  1058a7:	ff d0                	call   *%eax
  1058a9:	83 c4 10             	add    $0x10,%esp
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  1058ac:	8b 45 10             	mov    0x10(%ebp),%eax
  1058af:	8d 50 01             	lea    0x1(%eax),%edx
  1058b2:	89 55 10             	mov    %edx,0x10(%ebp)
  1058b5:	0f b6 00             	movzbl (%eax),%eax
  1058b8:	0f b6 d8             	movzbl %al,%ebx
  1058bb:	83 fb 25             	cmp    $0x25,%ebx
  1058be:	75 d5                	jne    105895 <vprintfmt+0xe>
        }

        // Process a %-escape sequence
        char padc = ' ';
  1058c0:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
        width = precision = -1;
  1058c4:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
  1058cb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1058ce:	89 45 e8             	mov    %eax,-0x18(%ebp)
        lflag = altflag = 0;
  1058d1:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  1058d8:	8b 45 dc             	mov    -0x24(%ebp),%eax
  1058db:	89 45 e0             	mov    %eax,-0x20(%ebp)

    reswitch:
        switch (ch = *(unsigned char *)fmt ++) {
  1058de:	8b 45 10             	mov    0x10(%ebp),%eax
  1058e1:	8d 50 01             	lea    0x1(%eax),%edx
  1058e4:	89 55 10             	mov    %edx,0x10(%ebp)
  1058e7:	0f b6 00             	movzbl (%eax),%eax
  1058ea:	0f b6 d8             	movzbl %al,%ebx
  1058ed:	8d 43 dd             	lea    -0x23(%ebx),%eax
  1058f0:	83 f8 55             	cmp    $0x55,%eax
  1058f3:	0f 87 06 03 00 00    	ja     105bff <vprintfmt+0x378>
  1058f9:	8b 04 85 a8 6e 10 00 	mov    0x106ea8(,%eax,4),%eax
  105900:	3e ff e0             	notrack jmp *%eax

        // flag to pad on the right
        case '-':
            padc = '-';
  105903:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
            goto reswitch;
  105907:	eb d5                	jmp    1058de <vprintfmt+0x57>

        // flag to pad with 0's instead of spaces
        case '0':
            padc = '0';
  105909:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
            goto reswitch;
  10590d:	eb cf                	jmp    1058de <vprintfmt+0x57>

        // width field
        case '1' ... '9':
            for (precision = 0; ; ++ fmt) {
  10590f:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
                precision = precision * 10 + ch - '0';
  105916:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  105919:	89 d0                	mov    %edx,%eax
  10591b:	c1 e0 02             	shl    $0x2,%eax
  10591e:	01 d0                	add    %edx,%eax
  105920:	01 c0                	add    %eax,%eax
  105922:	01 d8                	add    %ebx,%eax
  105924:	83 e8 30             	sub    $0x30,%eax
  105927:	89 45 e4             	mov    %eax,-0x1c(%ebp)
                ch = *fmt;
  10592a:	8b 45 10             	mov    0x10(%ebp),%eax
  10592d:	0f b6 00             	movzbl (%eax),%eax
  105930:	0f be d8             	movsbl %al,%ebx
                if (ch < '0' || ch > '9') {
  105933:	83 fb 2f             	cmp    $0x2f,%ebx
  105936:	7e 39                	jle    105971 <vprintfmt+0xea>
  105938:	83 fb 39             	cmp    $0x39,%ebx
  10593b:	7f 34                	jg     105971 <vprintfmt+0xea>
            for (precision = 0; ; ++ fmt) {
  10593d:	83 45 10 01          	addl   $0x1,0x10(%ebp)
                precision = precision * 10 + ch - '0';
  105941:	eb d3                	jmp    105916 <vprintfmt+0x8f>
                }
            }
            goto process_precision;

        case '*':
            precision = va_arg(ap, int);
  105943:	8b 45 14             	mov    0x14(%ebp),%eax
  105946:	8d 50 04             	lea    0x4(%eax),%edx
  105949:	89 55 14             	mov    %edx,0x14(%ebp)
  10594c:	8b 00                	mov    (%eax),%eax
  10594e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            goto process_precision;
  105951:	eb 1f                	jmp    105972 <vprintfmt+0xeb>

        case '.':
            if (width < 0)
  105953:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  105957:	79 85                	jns    1058de <vprintfmt+0x57>
                width = 0;
  105959:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
            goto reswitch;
  105960:	e9 79 ff ff ff       	jmp    1058de <vprintfmt+0x57>

        case '#':
            altflag = 1;
  105965:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
            goto reswitch;
  10596c:	e9 6d ff ff ff       	jmp    1058de <vprintfmt+0x57>
            goto process_precision;
  105971:	90                   	nop

        process_precision:
            if (width < 0)
  105972:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  105976:	0f 89 62 ff ff ff    	jns    1058de <vprintfmt+0x57>
                width = precision, precision = -1;
  10597c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  10597f:	89 45 e8             	mov    %eax,-0x18(%ebp)
  105982:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
            goto reswitch;
  105989:	e9 50 ff ff ff       	jmp    1058de <vprintfmt+0x57>

        // long flag (doubled for long long)
        case 'l':
            lflag ++;
  10598e:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
            goto reswitch;
  105992:	e9 47 ff ff ff       	jmp    1058de <vprintfmt+0x57>

        // character
        case 'c':
            putch(va_arg(ap, int), putdat);
  105997:	8b 45 14             	mov    0x14(%ebp),%eax
  10599a:	8d 50 04             	lea    0x4(%eax),%edx
  10599d:	89 55 14             	mov    %edx,0x14(%ebp)
  1059a0:	8b 00                	mov    (%eax),%eax
  1059a2:	83 ec 08             	sub    $0x8,%esp
  1059a5:	ff 75 0c             	pushl  0xc(%ebp)
  1059a8:	50                   	push   %eax
  1059a9:	8b 45 08             	mov    0x8(%ebp),%eax
  1059ac:	ff d0                	call   *%eax
  1059ae:	83 c4 10             	add    $0x10,%esp
            break;
  1059b1:	e9 71 02 00 00       	jmp    105c27 <vprintfmt+0x3a0>

        // error message
        case 'e':
            err = va_arg(ap, int);
  1059b6:	8b 45 14             	mov    0x14(%ebp),%eax
  1059b9:	8d 50 04             	lea    0x4(%eax),%edx
  1059bc:	89 55 14             	mov    %edx,0x14(%ebp)
  1059bf:	8b 18                	mov    (%eax),%ebx
            if (err < 0) {
  1059c1:	85 db                	test   %ebx,%ebx
  1059c3:	79 02                	jns    1059c7 <vprintfmt+0x140>
                err = -err;
  1059c5:	f7 db                	neg    %ebx
            }
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
  1059c7:	83 fb 06             	cmp    $0x6,%ebx
  1059ca:	7f 0b                	jg     1059d7 <vprintfmt+0x150>
  1059cc:	8b 34 9d 68 6e 10 00 	mov    0x106e68(,%ebx,4),%esi
  1059d3:	85 f6                	test   %esi,%esi
  1059d5:	75 19                	jne    1059f0 <vprintfmt+0x169>
                printfmt(putch, putdat, "error %d", err);
  1059d7:	53                   	push   %ebx
  1059d8:	68 95 6e 10 00       	push   $0x106e95
  1059dd:	ff 75 0c             	pushl  0xc(%ebp)
  1059e0:	ff 75 08             	pushl  0x8(%ebp)
  1059e3:	e8 77 fe ff ff       	call   10585f <printfmt>
  1059e8:	83 c4 10             	add    $0x10,%esp
            }
            else {
                printfmt(putch, putdat, "%s", p);
            }
            break;
  1059eb:	e9 37 02 00 00       	jmp    105c27 <vprintfmt+0x3a0>
                printfmt(putch, putdat, "%s", p);
  1059f0:	56                   	push   %esi
  1059f1:	68 9e 6e 10 00       	push   $0x106e9e
  1059f6:	ff 75 0c             	pushl  0xc(%ebp)
  1059f9:	ff 75 08             	pushl  0x8(%ebp)
  1059fc:	e8 5e fe ff ff       	call   10585f <printfmt>
  105a01:	83 c4 10             	add    $0x10,%esp
            break;
  105a04:	e9 1e 02 00 00       	jmp    105c27 <vprintfmt+0x3a0>

        // string
        case 's':
            if ((p = va_arg(ap, char *)) == NULL) {
  105a09:	8b 45 14             	mov    0x14(%ebp),%eax
  105a0c:	8d 50 04             	lea    0x4(%eax),%edx
  105a0f:	89 55 14             	mov    %edx,0x14(%ebp)
  105a12:	8b 30                	mov    (%eax),%esi
  105a14:	85 f6                	test   %esi,%esi
  105a16:	75 05                	jne    105a1d <vprintfmt+0x196>
                p = "(null)";
  105a18:	be a1 6e 10 00       	mov    $0x106ea1,%esi
            }
            if (width > 0 && padc != '-') {
  105a1d:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  105a21:	7e 76                	jle    105a99 <vprintfmt+0x212>
  105a23:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  105a27:	74 70                	je     105a99 <vprintfmt+0x212>
                for (width -= strnlen(p, precision); width > 0; width --) {
  105a29:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  105a2c:	83 ec 08             	sub    $0x8,%esp
  105a2f:	50                   	push   %eax
  105a30:	56                   	push   %esi
  105a31:	e8 db f7 ff ff       	call   105211 <strnlen>
  105a36:	83 c4 10             	add    $0x10,%esp
  105a39:	8b 55 e8             	mov    -0x18(%ebp),%edx
  105a3c:	29 c2                	sub    %eax,%edx
  105a3e:	89 d0                	mov    %edx,%eax
  105a40:	89 45 e8             	mov    %eax,-0x18(%ebp)
  105a43:	eb 17                	jmp    105a5c <vprintfmt+0x1d5>
                    putch(padc, putdat);
  105a45:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  105a49:	83 ec 08             	sub    $0x8,%esp
  105a4c:	ff 75 0c             	pushl  0xc(%ebp)
  105a4f:	50                   	push   %eax
  105a50:	8b 45 08             	mov    0x8(%ebp),%eax
  105a53:	ff d0                	call   *%eax
  105a55:	83 c4 10             	add    $0x10,%esp
                for (width -= strnlen(p, precision); width > 0; width --) {
  105a58:	83 6d e8 01          	subl   $0x1,-0x18(%ebp)
  105a5c:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  105a60:	7f e3                	jg     105a45 <vprintfmt+0x1be>
                }
            }
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  105a62:	eb 35                	jmp    105a99 <vprintfmt+0x212>
                if (altflag && (ch < ' ' || ch > '~')) {
  105a64:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  105a68:	74 1c                	je     105a86 <vprintfmt+0x1ff>
  105a6a:	83 fb 1f             	cmp    $0x1f,%ebx
  105a6d:	7e 05                	jle    105a74 <vprintfmt+0x1ed>
  105a6f:	83 fb 7e             	cmp    $0x7e,%ebx
  105a72:	7e 12                	jle    105a86 <vprintfmt+0x1ff>
                    putch('?', putdat);
  105a74:	83 ec 08             	sub    $0x8,%esp
  105a77:	ff 75 0c             	pushl  0xc(%ebp)
  105a7a:	6a 3f                	push   $0x3f
  105a7c:	8b 45 08             	mov    0x8(%ebp),%eax
  105a7f:	ff d0                	call   *%eax
  105a81:	83 c4 10             	add    $0x10,%esp
  105a84:	eb 0f                	jmp    105a95 <vprintfmt+0x20e>
                }
                else {
                    putch(ch, putdat);
  105a86:	83 ec 08             	sub    $0x8,%esp
  105a89:	ff 75 0c             	pushl  0xc(%ebp)
  105a8c:	53                   	push   %ebx
  105a8d:	8b 45 08             	mov    0x8(%ebp),%eax
  105a90:	ff d0                	call   *%eax
  105a92:	83 c4 10             	add    $0x10,%esp
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  105a95:	83 6d e8 01          	subl   $0x1,-0x18(%ebp)
  105a99:	89 f0                	mov    %esi,%eax
  105a9b:	8d 70 01             	lea    0x1(%eax),%esi
  105a9e:	0f b6 00             	movzbl (%eax),%eax
  105aa1:	0f be d8             	movsbl %al,%ebx
  105aa4:	85 db                	test   %ebx,%ebx
  105aa6:	74 26                	je     105ace <vprintfmt+0x247>
  105aa8:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  105aac:	78 b6                	js     105a64 <vprintfmt+0x1dd>
  105aae:	83 6d e4 01          	subl   $0x1,-0x1c(%ebp)
  105ab2:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  105ab6:	79 ac                	jns    105a64 <vprintfmt+0x1dd>
                }
            }
            for (; width > 0; width --) {
  105ab8:	eb 14                	jmp    105ace <vprintfmt+0x247>
                putch(' ', putdat);
  105aba:	83 ec 08             	sub    $0x8,%esp
  105abd:	ff 75 0c             	pushl  0xc(%ebp)
  105ac0:	6a 20                	push   $0x20
  105ac2:	8b 45 08             	mov    0x8(%ebp),%eax
  105ac5:	ff d0                	call   *%eax
  105ac7:	83 c4 10             	add    $0x10,%esp
            for (; width > 0; width --) {
  105aca:	83 6d e8 01          	subl   $0x1,-0x18(%ebp)
  105ace:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  105ad2:	7f e6                	jg     105aba <vprintfmt+0x233>
            }
            break;
  105ad4:	e9 4e 01 00 00       	jmp    105c27 <vprintfmt+0x3a0>

        // (signed) decimal
        case 'd':
            num = getint(&ap, lflag);
  105ad9:	83 ec 08             	sub    $0x8,%esp
  105adc:	ff 75 e0             	pushl  -0x20(%ebp)
  105adf:	8d 45 14             	lea    0x14(%ebp),%eax
  105ae2:	50                   	push   %eax
  105ae3:	e8 2c fd ff ff       	call   105814 <getint>
  105ae8:	83 c4 10             	add    $0x10,%esp
  105aeb:	89 45 f0             	mov    %eax,-0x10(%ebp)
  105aee:	89 55 f4             	mov    %edx,-0xc(%ebp)
            if ((long long)num < 0) {
  105af1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  105af4:	8b 55 f4             	mov    -0xc(%ebp),%edx
  105af7:	85 d2                	test   %edx,%edx
  105af9:	79 23                	jns    105b1e <vprintfmt+0x297>
                putch('-', putdat);
  105afb:	83 ec 08             	sub    $0x8,%esp
  105afe:	ff 75 0c             	pushl  0xc(%ebp)
  105b01:	6a 2d                	push   $0x2d
  105b03:	8b 45 08             	mov    0x8(%ebp),%eax
  105b06:	ff d0                	call   *%eax
  105b08:	83 c4 10             	add    $0x10,%esp
                num = -(long long)num;
  105b0b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  105b0e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  105b11:	f7 d8                	neg    %eax
  105b13:	83 d2 00             	adc    $0x0,%edx
  105b16:	f7 da                	neg    %edx
  105b18:	89 45 f0             	mov    %eax,-0x10(%ebp)
  105b1b:	89 55 f4             	mov    %edx,-0xc(%ebp)
            }
            base = 10;
  105b1e:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
            goto number;
  105b25:	e9 9f 00 00 00       	jmp    105bc9 <vprintfmt+0x342>

        // unsigned decimal
        case 'u':
            num = getuint(&ap, lflag);
  105b2a:	83 ec 08             	sub    $0x8,%esp
  105b2d:	ff 75 e0             	pushl  -0x20(%ebp)
  105b30:	8d 45 14             	lea    0x14(%ebp),%eax
  105b33:	50                   	push   %eax
  105b34:	e8 88 fc ff ff       	call   1057c1 <getuint>
  105b39:	83 c4 10             	add    $0x10,%esp
  105b3c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  105b3f:	89 55 f4             	mov    %edx,-0xc(%ebp)
            base = 10;
  105b42:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
            goto number;
  105b49:	eb 7e                	jmp    105bc9 <vprintfmt+0x342>

        // (unsigned) octal
        case 'o':
            num = getuint(&ap, lflag);
  105b4b:	83 ec 08             	sub    $0x8,%esp
  105b4e:	ff 75 e0             	pushl  -0x20(%ebp)
  105b51:	8d 45 14             	lea    0x14(%ebp),%eax
  105b54:	50                   	push   %eax
  105b55:	e8 67 fc ff ff       	call   1057c1 <getuint>
  105b5a:	83 c4 10             	add    $0x10,%esp
  105b5d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  105b60:	89 55 f4             	mov    %edx,-0xc(%ebp)
            base = 8;
  105b63:	c7 45 ec 08 00 00 00 	movl   $0x8,-0x14(%ebp)
            goto number;
  105b6a:	eb 5d                	jmp    105bc9 <vprintfmt+0x342>

        // pointer
        case 'p':
            putch('0', putdat);
  105b6c:	83 ec 08             	sub    $0x8,%esp
  105b6f:	ff 75 0c             	pushl  0xc(%ebp)
  105b72:	6a 30                	push   $0x30
  105b74:	8b 45 08             	mov    0x8(%ebp),%eax
  105b77:	ff d0                	call   *%eax
  105b79:	83 c4 10             	add    $0x10,%esp
            putch('x', putdat);
  105b7c:	83 ec 08             	sub    $0x8,%esp
  105b7f:	ff 75 0c             	pushl  0xc(%ebp)
  105b82:	6a 78                	push   $0x78
  105b84:	8b 45 08             	mov    0x8(%ebp),%eax
  105b87:	ff d0                	call   *%eax
  105b89:	83 c4 10             	add    $0x10,%esp
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
  105b8c:	8b 45 14             	mov    0x14(%ebp),%eax
  105b8f:	8d 50 04             	lea    0x4(%eax),%edx
  105b92:	89 55 14             	mov    %edx,0x14(%ebp)
  105b95:	8b 00                	mov    (%eax),%eax
  105b97:	89 45 f0             	mov    %eax,-0x10(%ebp)
  105b9a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
            base = 16;
  105ba1:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
            goto number;
  105ba8:	eb 1f                	jmp    105bc9 <vprintfmt+0x342>

        // (unsigned) hexadecimal
        case 'x':
            num = getuint(&ap, lflag);
  105baa:	83 ec 08             	sub    $0x8,%esp
  105bad:	ff 75 e0             	pushl  -0x20(%ebp)
  105bb0:	8d 45 14             	lea    0x14(%ebp),%eax
  105bb3:	50                   	push   %eax
  105bb4:	e8 08 fc ff ff       	call   1057c1 <getuint>
  105bb9:	83 c4 10             	add    $0x10,%esp
  105bbc:	89 45 f0             	mov    %eax,-0x10(%ebp)
  105bbf:	89 55 f4             	mov    %edx,-0xc(%ebp)
            base = 16;
  105bc2:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
        number:
            printnum(putch, putdat, num, base, width, padc);
  105bc9:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  105bcd:	8b 45 ec             	mov    -0x14(%ebp),%eax
  105bd0:	83 ec 04             	sub    $0x4,%esp
  105bd3:	52                   	push   %edx
  105bd4:	ff 75 e8             	pushl  -0x18(%ebp)
  105bd7:	50                   	push   %eax
  105bd8:	ff 75 f4             	pushl  -0xc(%ebp)
  105bdb:	ff 75 f0             	pushl  -0x10(%ebp)
  105bde:	ff 75 0c             	pushl  0xc(%ebp)
  105be1:	ff 75 08             	pushl  0x8(%ebp)
  105be4:	e8 e8 fa ff ff       	call   1056d1 <printnum>
  105be9:	83 c4 20             	add    $0x20,%esp
            break;
  105bec:	eb 39                	jmp    105c27 <vprintfmt+0x3a0>

        // escaped '%' character
        case '%':
            putch(ch, putdat);
  105bee:	83 ec 08             	sub    $0x8,%esp
  105bf1:	ff 75 0c             	pushl  0xc(%ebp)
  105bf4:	53                   	push   %ebx
  105bf5:	8b 45 08             	mov    0x8(%ebp),%eax
  105bf8:	ff d0                	call   *%eax
  105bfa:	83 c4 10             	add    $0x10,%esp
            break;
  105bfd:	eb 28                	jmp    105c27 <vprintfmt+0x3a0>

        // unrecognized escape sequence - just print it literally
        default:
            putch('%', putdat);
  105bff:	83 ec 08             	sub    $0x8,%esp
  105c02:	ff 75 0c             	pushl  0xc(%ebp)
  105c05:	6a 25                	push   $0x25
  105c07:	8b 45 08             	mov    0x8(%ebp),%eax
  105c0a:	ff d0                	call   *%eax
  105c0c:	83 c4 10             	add    $0x10,%esp
            for (fmt --; fmt[-1] != '%'; fmt --)
  105c0f:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
  105c13:	eb 04                	jmp    105c19 <vprintfmt+0x392>
  105c15:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
  105c19:	8b 45 10             	mov    0x10(%ebp),%eax
  105c1c:	83 e8 01             	sub    $0x1,%eax
  105c1f:	0f b6 00             	movzbl (%eax),%eax
  105c22:	3c 25                	cmp    $0x25,%al
  105c24:	75 ef                	jne    105c15 <vprintfmt+0x38e>
                /* do nothing */;
            break;
  105c26:	90                   	nop
    while (1) {
  105c27:	e9 67 fc ff ff       	jmp    105893 <vprintfmt+0xc>
                return;
  105c2c:	90                   	nop
        }
    }
}
  105c2d:	8d 65 f8             	lea    -0x8(%ebp),%esp
  105c30:	5b                   	pop    %ebx
  105c31:	5e                   	pop    %esi
  105c32:	5d                   	pop    %ebp
  105c33:	c3                   	ret    

00105c34 <sprintputch>:
 * sprintputch - 'print' a single character in a buffer
 * @ch:         the character will be printed
 * @b:          the buffer to place the character @ch
 * */
static void
sprintputch(int ch, struct sprintbuf *b) {
  105c34:	f3 0f 1e fb          	endbr32 
  105c38:	55                   	push   %ebp
  105c39:	89 e5                	mov    %esp,%ebp
    b->cnt ++;
  105c3b:	8b 45 0c             	mov    0xc(%ebp),%eax
  105c3e:	8b 40 08             	mov    0x8(%eax),%eax
  105c41:	8d 50 01             	lea    0x1(%eax),%edx
  105c44:	8b 45 0c             	mov    0xc(%ebp),%eax
  105c47:	89 50 08             	mov    %edx,0x8(%eax)
    if (b->buf < b->ebuf) {
  105c4a:	8b 45 0c             	mov    0xc(%ebp),%eax
  105c4d:	8b 10                	mov    (%eax),%edx
  105c4f:	8b 45 0c             	mov    0xc(%ebp),%eax
  105c52:	8b 40 04             	mov    0x4(%eax),%eax
  105c55:	39 c2                	cmp    %eax,%edx
  105c57:	73 12                	jae    105c6b <sprintputch+0x37>
        *b->buf ++ = ch;
  105c59:	8b 45 0c             	mov    0xc(%ebp),%eax
  105c5c:	8b 00                	mov    (%eax),%eax
  105c5e:	8d 48 01             	lea    0x1(%eax),%ecx
  105c61:	8b 55 0c             	mov    0xc(%ebp),%edx
  105c64:	89 0a                	mov    %ecx,(%edx)
  105c66:	8b 55 08             	mov    0x8(%ebp),%edx
  105c69:	88 10                	mov    %dl,(%eax)
    }
}
  105c6b:	90                   	nop
  105c6c:	5d                   	pop    %ebp
  105c6d:	c3                   	ret    

00105c6e <snprintf>:
 * @str:        the buffer to place the result into
 * @size:       the size of buffer, including the trailing null space
 * @fmt:        the format string to use
 * */
int
snprintf(char *str, size_t size, const char *fmt, ...) {
  105c6e:	f3 0f 1e fb          	endbr32 
  105c72:	55                   	push   %ebp
  105c73:	89 e5                	mov    %esp,%ebp
  105c75:	83 ec 18             	sub    $0x18,%esp
    va_list ap;
    int cnt;
    va_start(ap, fmt);
  105c78:	8d 45 14             	lea    0x14(%ebp),%eax
  105c7b:	89 45 f0             	mov    %eax,-0x10(%ebp)
    cnt = vsnprintf(str, size, fmt, ap);
  105c7e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  105c81:	50                   	push   %eax
  105c82:	ff 75 10             	pushl  0x10(%ebp)
  105c85:	ff 75 0c             	pushl  0xc(%ebp)
  105c88:	ff 75 08             	pushl  0x8(%ebp)
  105c8b:	e8 0b 00 00 00       	call   105c9b <vsnprintf>
  105c90:	83 c4 10             	add    $0x10,%esp
  105c93:	89 45 f4             	mov    %eax,-0xc(%ebp)
    va_end(ap);
    return cnt;
  105c96:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  105c99:	c9                   	leave  
  105c9a:	c3                   	ret    

00105c9b <vsnprintf>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want snprintf() instead.
 * */
int
vsnprintf(char *str, size_t size, const char *fmt, va_list ap) {
  105c9b:	f3 0f 1e fb          	endbr32 
  105c9f:	55                   	push   %ebp
  105ca0:	89 e5                	mov    %esp,%ebp
  105ca2:	83 ec 18             	sub    $0x18,%esp
    struct sprintbuf b = {str, str + size - 1, 0};
  105ca5:	8b 45 08             	mov    0x8(%ebp),%eax
  105ca8:	89 45 ec             	mov    %eax,-0x14(%ebp)
  105cab:	8b 45 0c             	mov    0xc(%ebp),%eax
  105cae:	8d 50 ff             	lea    -0x1(%eax),%edx
  105cb1:	8b 45 08             	mov    0x8(%ebp),%eax
  105cb4:	01 d0                	add    %edx,%eax
  105cb6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  105cb9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if (str == NULL || b.buf > b.ebuf) {
  105cc0:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  105cc4:	74 0a                	je     105cd0 <vsnprintf+0x35>
  105cc6:	8b 55 ec             	mov    -0x14(%ebp),%edx
  105cc9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  105ccc:	39 c2                	cmp    %eax,%edx
  105cce:	76 07                	jbe    105cd7 <vsnprintf+0x3c>
        return -E_INVAL;
  105cd0:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  105cd5:	eb 20                	jmp    105cf7 <vsnprintf+0x5c>
    }
    // print the string to the buffer
    vprintfmt((void*)sprintputch, &b, fmt, ap);
  105cd7:	ff 75 14             	pushl  0x14(%ebp)
  105cda:	ff 75 10             	pushl  0x10(%ebp)
  105cdd:	8d 45 ec             	lea    -0x14(%ebp),%eax
  105ce0:	50                   	push   %eax
  105ce1:	68 34 5c 10 00       	push   $0x105c34
  105ce6:	e8 9c fb ff ff       	call   105887 <vprintfmt>
  105ceb:	83 c4 10             	add    $0x10,%esp
    // null terminate the buffer
    *b.buf = '\0';
  105cee:	8b 45 ec             	mov    -0x14(%ebp),%eax
  105cf1:	c6 00 00             	movb   $0x0,(%eax)
    return b.cnt;
  105cf4:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  105cf7:	c9                   	leave  
  105cf8:	c3                   	ret    
