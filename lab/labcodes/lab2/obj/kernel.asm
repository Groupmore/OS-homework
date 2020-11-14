
bin/kernel：     文件格式 elf32-i386


Disassembly of section .text:

c0100000 <kern_entry>:
.text
.globl kern_entry
kern_entry:
    # reload temperate gdt (second time) to remap all physical memory
    # virtual_addr 0~4G=linear_addr&physical_addr -KERNBASE~4G-KERNBASE 
    lgdt REALLOC(__gdtdesc)
c0100000:	0f 01 15 18 90 11 00 	lgdtl  0x119018
    movl $KERNEL_DS, %eax
c0100007:	b8 10 00 00 00       	mov    $0x10,%eax
    movw %ax, %ds
c010000c:	8e d8                	mov    %eax,%ds
    movw %ax, %es
c010000e:	8e c0                	mov    %eax,%es
    movw %ax, %ss
c0100010:	8e d0                	mov    %eax,%ss

    ljmp $KERNEL_CS, $relocated
c0100012:	ea 19 00 10 c0 08 00 	ljmp   $0x8,$0xc0100019

c0100019 <relocated>:

relocated:

    # set ebp, esp
    movl $0x0, %ebp
c0100019:	bd 00 00 00 00       	mov    $0x0,%ebp
    # the kernel stack region is from bootstack -- bootstacktop,
    # the kernel stack size is KSTACKSIZE (8KB)defined in memlayout.h
    movl $bootstacktop, %esp
c010001e:	bc 00 90 11 c0       	mov    $0xc0119000,%esp
    # now kernel stack is ready , call the first C function
    call kern_init
c0100023:	e8 02 00 00 00       	call   c010002a <kern_init>

c0100028 <spin>:

# should never get here
spin:
    jmp spin
c0100028:	eb fe                	jmp    c0100028 <spin>

c010002a <kern_init>:
int kern_init(void) __attribute__((noreturn));
void grade_backtrace(void);
static void lab1_switch_test(void);

int
kern_init(void) {
c010002a:	f3 0f 1e fb          	endbr32 
c010002e:	55                   	push   %ebp
c010002f:	89 e5                	mov    %esp,%ebp
c0100031:	83 ec 18             	sub    $0x18,%esp
    extern char edata[], end[];
    memset(edata, 0, end - edata);
c0100034:	b8 68 a9 11 c0       	mov    $0xc011a968,%eax
c0100039:	2d 36 9a 11 c0       	sub    $0xc0119a36,%eax
c010003e:	83 ec 04             	sub    $0x4,%esp
c0100041:	50                   	push   %eax
c0100042:	6a 00                	push   $0x0
c0100044:	68 36 9a 11 c0       	push   $0xc0119a36
c0100049:	e8 ea 54 00 00       	call   c0105538 <memset>
c010004e:	83 c4 10             	add    $0x10,%esp

    cons_init();                // init the console
c0100051:	e8 42 16 00 00       	call   c0101698 <cons_init>

    const char *message = "(THU.CST) os is loading ...";
c0100056:	c7 45 f4 00 5d 10 c0 	movl   $0xc0105d00,-0xc(%ebp)
    cprintf("%s\n\n", message);
c010005d:	83 ec 08             	sub    $0x8,%esp
c0100060:	ff 75 f4             	pushl  -0xc(%ebp)
c0100063:	68 1c 5d 10 c0       	push   $0xc0105d1c
c0100068:	e8 22 02 00 00       	call   c010028f <cprintf>
c010006d:	83 c4 10             	add    $0x10,%esp

    print_kerninfo();
c0100070:	e8 c1 08 00 00       	call   c0100936 <print_kerninfo>

    grade_backtrace();
c0100075:	e8 80 00 00 00       	call   c01000fa <grade_backtrace>

    pmm_init();                 // init physical memory management
c010007a:	e8 29 32 00 00       	call   c01032a8 <pmm_init>

    pic_init();                 // init interrupt controller
c010007f:	e8 9c 17 00 00       	call   c0101820 <pic_init>
    idt_init();                 // init interrupt descriptor table
c0100084:	e8 1d 19 00 00       	call   c01019a6 <idt_init>

    clock_init();               // init clock interrupt
c0100089:	e8 51 0d 00 00       	call   c0100ddf <clock_init>
    intr_enable();              // enable irq interrupt
c010008e:	e8 dc 18 00 00       	call   c010196f <intr_enable>
    //LAB1: CAHLLENGE 1 If you try to do it, uncomment lab1_switch_test()
    // user/kernel mode switch test
    //lab1_switch_test();

    /* do nothing */
    while (1);
c0100093:	eb fe                	jmp    c0100093 <kern_init+0x69>

c0100095 <grade_backtrace2>:
}

void __attribute__((noinline))
grade_backtrace2(int arg0, int arg1, int arg2, int arg3) {
c0100095:	f3 0f 1e fb          	endbr32 
c0100099:	55                   	push   %ebp
c010009a:	89 e5                	mov    %esp,%ebp
c010009c:	83 ec 08             	sub    $0x8,%esp
    mon_backtrace(0, NULL, NULL);
c010009f:	83 ec 04             	sub    $0x4,%esp
c01000a2:	6a 00                	push   $0x0
c01000a4:	6a 00                	push   $0x0
c01000a6:	6a 00                	push   $0x0
c01000a8:	e8 1c 0d 00 00       	call   c0100dc9 <mon_backtrace>
c01000ad:	83 c4 10             	add    $0x10,%esp
}
c01000b0:	90                   	nop
c01000b1:	c9                   	leave  
c01000b2:	c3                   	ret    

c01000b3 <grade_backtrace1>:

void __attribute__((noinline))
grade_backtrace1(int arg0, int arg1) {
c01000b3:	f3 0f 1e fb          	endbr32 
c01000b7:	55                   	push   %ebp
c01000b8:	89 e5                	mov    %esp,%ebp
c01000ba:	53                   	push   %ebx
c01000bb:	83 ec 04             	sub    $0x4,%esp
    grade_backtrace2(arg0, (int)&arg0, arg1, (int)&arg1);
c01000be:	8d 4d 0c             	lea    0xc(%ebp),%ecx
c01000c1:	8b 55 0c             	mov    0xc(%ebp),%edx
c01000c4:	8d 5d 08             	lea    0x8(%ebp),%ebx
c01000c7:	8b 45 08             	mov    0x8(%ebp),%eax
c01000ca:	51                   	push   %ecx
c01000cb:	52                   	push   %edx
c01000cc:	53                   	push   %ebx
c01000cd:	50                   	push   %eax
c01000ce:	e8 c2 ff ff ff       	call   c0100095 <grade_backtrace2>
c01000d3:	83 c4 10             	add    $0x10,%esp
}
c01000d6:	90                   	nop
c01000d7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
c01000da:	c9                   	leave  
c01000db:	c3                   	ret    

c01000dc <grade_backtrace0>:

void __attribute__((noinline))
grade_backtrace0(int arg0, int arg1, int arg2) {
c01000dc:	f3 0f 1e fb          	endbr32 
c01000e0:	55                   	push   %ebp
c01000e1:	89 e5                	mov    %esp,%ebp
c01000e3:	83 ec 08             	sub    $0x8,%esp
    grade_backtrace1(arg0, arg2);
c01000e6:	83 ec 08             	sub    $0x8,%esp
c01000e9:	ff 75 10             	pushl  0x10(%ebp)
c01000ec:	ff 75 08             	pushl  0x8(%ebp)
c01000ef:	e8 bf ff ff ff       	call   c01000b3 <grade_backtrace1>
c01000f4:	83 c4 10             	add    $0x10,%esp
}
c01000f7:	90                   	nop
c01000f8:	c9                   	leave  
c01000f9:	c3                   	ret    

c01000fa <grade_backtrace>:

void
grade_backtrace(void) {
c01000fa:	f3 0f 1e fb          	endbr32 
c01000fe:	55                   	push   %ebp
c01000ff:	89 e5                	mov    %esp,%ebp
c0100101:	83 ec 08             	sub    $0x8,%esp
    grade_backtrace0(0, (int)kern_init, 0xffff0000);
c0100104:	b8 2a 00 10 c0       	mov    $0xc010002a,%eax
c0100109:	83 ec 04             	sub    $0x4,%esp
c010010c:	68 00 00 ff ff       	push   $0xffff0000
c0100111:	50                   	push   %eax
c0100112:	6a 00                	push   $0x0
c0100114:	e8 c3 ff ff ff       	call   c01000dc <grade_backtrace0>
c0100119:	83 c4 10             	add    $0x10,%esp
}
c010011c:	90                   	nop
c010011d:	c9                   	leave  
c010011e:	c3                   	ret    

c010011f <lab1_print_cur_status>:

static void
lab1_print_cur_status(void) {
c010011f:	f3 0f 1e fb          	endbr32 
c0100123:	55                   	push   %ebp
c0100124:	89 e5                	mov    %esp,%ebp
c0100126:	83 ec 18             	sub    $0x18,%esp
    static int round = 0;
    uint16_t reg1, reg2, reg3, reg4;
    asm volatile (
c0100129:	8c 4d f6             	mov    %cs,-0xa(%ebp)
c010012c:	8c 5d f4             	mov    %ds,-0xc(%ebp)
c010012f:	8c 45 f2             	mov    %es,-0xe(%ebp)
c0100132:	8c 55 f0             	mov    %ss,-0x10(%ebp)
            "mov %%cs, %0;"
            "mov %%ds, %1;"
            "mov %%es, %2;"
            "mov %%ss, %3;"
            : "=m"(reg1), "=m"(reg2), "=m"(reg3), "=m"(reg4));
    cprintf("%d: @ring %d\n", round, reg1 & 3);
c0100135:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
c0100139:	0f b7 c0             	movzwl %ax,%eax
c010013c:	83 e0 03             	and    $0x3,%eax
c010013f:	89 c2                	mov    %eax,%edx
c0100141:	a1 40 9a 11 c0       	mov    0xc0119a40,%eax
c0100146:	83 ec 04             	sub    $0x4,%esp
c0100149:	52                   	push   %edx
c010014a:	50                   	push   %eax
c010014b:	68 21 5d 10 c0       	push   $0xc0105d21
c0100150:	e8 3a 01 00 00       	call   c010028f <cprintf>
c0100155:	83 c4 10             	add    $0x10,%esp
    cprintf("%d:  cs = %x\n", round, reg1);
c0100158:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
c010015c:	0f b7 d0             	movzwl %ax,%edx
c010015f:	a1 40 9a 11 c0       	mov    0xc0119a40,%eax
c0100164:	83 ec 04             	sub    $0x4,%esp
c0100167:	52                   	push   %edx
c0100168:	50                   	push   %eax
c0100169:	68 2f 5d 10 c0       	push   $0xc0105d2f
c010016e:	e8 1c 01 00 00       	call   c010028f <cprintf>
c0100173:	83 c4 10             	add    $0x10,%esp
    cprintf("%d:  ds = %x\n", round, reg2);
c0100176:	0f b7 45 f4          	movzwl -0xc(%ebp),%eax
c010017a:	0f b7 d0             	movzwl %ax,%edx
c010017d:	a1 40 9a 11 c0       	mov    0xc0119a40,%eax
c0100182:	83 ec 04             	sub    $0x4,%esp
c0100185:	52                   	push   %edx
c0100186:	50                   	push   %eax
c0100187:	68 3d 5d 10 c0       	push   $0xc0105d3d
c010018c:	e8 fe 00 00 00       	call   c010028f <cprintf>
c0100191:	83 c4 10             	add    $0x10,%esp
    cprintf("%d:  es = %x\n", round, reg3);
c0100194:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
c0100198:	0f b7 d0             	movzwl %ax,%edx
c010019b:	a1 40 9a 11 c0       	mov    0xc0119a40,%eax
c01001a0:	83 ec 04             	sub    $0x4,%esp
c01001a3:	52                   	push   %edx
c01001a4:	50                   	push   %eax
c01001a5:	68 4b 5d 10 c0       	push   $0xc0105d4b
c01001aa:	e8 e0 00 00 00       	call   c010028f <cprintf>
c01001af:	83 c4 10             	add    $0x10,%esp
    cprintf("%d:  ss = %x\n", round, reg4);
c01001b2:	0f b7 45 f0          	movzwl -0x10(%ebp),%eax
c01001b6:	0f b7 d0             	movzwl %ax,%edx
c01001b9:	a1 40 9a 11 c0       	mov    0xc0119a40,%eax
c01001be:	83 ec 04             	sub    $0x4,%esp
c01001c1:	52                   	push   %edx
c01001c2:	50                   	push   %eax
c01001c3:	68 59 5d 10 c0       	push   $0xc0105d59
c01001c8:	e8 c2 00 00 00       	call   c010028f <cprintf>
c01001cd:	83 c4 10             	add    $0x10,%esp
    round ++;
c01001d0:	a1 40 9a 11 c0       	mov    0xc0119a40,%eax
c01001d5:	83 c0 01             	add    $0x1,%eax
c01001d8:	a3 40 9a 11 c0       	mov    %eax,0xc0119a40
}
c01001dd:	90                   	nop
c01001de:	c9                   	leave  
c01001df:	c3                   	ret    

c01001e0 <lab1_switch_to_user>:

static void
lab1_switch_to_user(void) {
c01001e0:	f3 0f 1e fb          	endbr32 
c01001e4:	55                   	push   %ebp
c01001e5:	89 e5                	mov    %esp,%ebp
    //LAB1 CHALLENGE 1 : TODO
}
c01001e7:	90                   	nop
c01001e8:	5d                   	pop    %ebp
c01001e9:	c3                   	ret    

c01001ea <lab1_switch_to_kernel>:

static void
lab1_switch_to_kernel(void) {
c01001ea:	f3 0f 1e fb          	endbr32 
c01001ee:	55                   	push   %ebp
c01001ef:	89 e5                	mov    %esp,%ebp
    //LAB1 CHALLENGE 1 :  TODO
}
c01001f1:	90                   	nop
c01001f2:	5d                   	pop    %ebp
c01001f3:	c3                   	ret    

c01001f4 <lab1_switch_test>:

static void
lab1_switch_test(void) {
c01001f4:	f3 0f 1e fb          	endbr32 
c01001f8:	55                   	push   %ebp
c01001f9:	89 e5                	mov    %esp,%ebp
c01001fb:	83 ec 08             	sub    $0x8,%esp
    lab1_print_cur_status();
c01001fe:	e8 1c ff ff ff       	call   c010011f <lab1_print_cur_status>
    cprintf("+++ switch to  user  mode +++\n");
c0100203:	83 ec 0c             	sub    $0xc,%esp
c0100206:	68 68 5d 10 c0       	push   $0xc0105d68
c010020b:	e8 7f 00 00 00       	call   c010028f <cprintf>
c0100210:	83 c4 10             	add    $0x10,%esp
    lab1_switch_to_user();
c0100213:	e8 c8 ff ff ff       	call   c01001e0 <lab1_switch_to_user>
    lab1_print_cur_status();
c0100218:	e8 02 ff ff ff       	call   c010011f <lab1_print_cur_status>
    cprintf("+++ switch to kernel mode +++\n");
c010021d:	83 ec 0c             	sub    $0xc,%esp
c0100220:	68 88 5d 10 c0       	push   $0xc0105d88
c0100225:	e8 65 00 00 00       	call   c010028f <cprintf>
c010022a:	83 c4 10             	add    $0x10,%esp
    lab1_switch_to_kernel();
c010022d:	e8 b8 ff ff ff       	call   c01001ea <lab1_switch_to_kernel>
    lab1_print_cur_status();
c0100232:	e8 e8 fe ff ff       	call   c010011f <lab1_print_cur_status>
}
c0100237:	90                   	nop
c0100238:	c9                   	leave  
c0100239:	c3                   	ret    

c010023a <cputch>:
/* *
 * cputch - writes a single character @c to stdout, and it will
 * increace the value of counter pointed by @cnt.
 * */
static void
cputch(int c, int *cnt) {
c010023a:	f3 0f 1e fb          	endbr32 
c010023e:	55                   	push   %ebp
c010023f:	89 e5                	mov    %esp,%ebp
c0100241:	83 ec 08             	sub    $0x8,%esp
    cons_putc(c);
c0100244:	83 ec 0c             	sub    $0xc,%esp
c0100247:	ff 75 08             	pushl  0x8(%ebp)
c010024a:	e8 7e 14 00 00       	call   c01016cd <cons_putc>
c010024f:	83 c4 10             	add    $0x10,%esp
    (*cnt) ++;
c0100252:	8b 45 0c             	mov    0xc(%ebp),%eax
c0100255:	8b 00                	mov    (%eax),%eax
c0100257:	8d 50 01             	lea    0x1(%eax),%edx
c010025a:	8b 45 0c             	mov    0xc(%ebp),%eax
c010025d:	89 10                	mov    %edx,(%eax)
}
c010025f:	90                   	nop
c0100260:	c9                   	leave  
c0100261:	c3                   	ret    

c0100262 <vcprintf>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want cprintf() instead.
 * */
int
vcprintf(const char *fmt, va_list ap) {
c0100262:	f3 0f 1e fb          	endbr32 
c0100266:	55                   	push   %ebp
c0100267:	89 e5                	mov    %esp,%ebp
c0100269:	83 ec 18             	sub    $0x18,%esp
    int cnt = 0;
c010026c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    vprintfmt((void*)cputch, &cnt, fmt, ap);
c0100273:	ff 75 0c             	pushl  0xc(%ebp)
c0100276:	ff 75 08             	pushl  0x8(%ebp)
c0100279:	8d 45 f4             	lea    -0xc(%ebp),%eax
c010027c:	50                   	push   %eax
c010027d:	68 3a 02 10 c0       	push   $0xc010023a
c0100282:	e8 00 56 00 00       	call   c0105887 <vprintfmt>
c0100287:	83 c4 10             	add    $0x10,%esp
    return cnt;
c010028a:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
c010028d:	c9                   	leave  
c010028e:	c3                   	ret    

c010028f <cprintf>:
 *
 * The return value is the number of characters which would be
 * written to stdout.
 * */
int
cprintf(const char *fmt, ...) {
c010028f:	f3 0f 1e fb          	endbr32 
c0100293:	55                   	push   %ebp
c0100294:	89 e5                	mov    %esp,%ebp
c0100296:	83 ec 18             	sub    $0x18,%esp
    va_list ap;
    int cnt;
    va_start(ap, fmt);
c0100299:	8d 45 0c             	lea    0xc(%ebp),%eax
c010029c:	89 45 f0             	mov    %eax,-0x10(%ebp)
    cnt = vcprintf(fmt, ap);
c010029f:	8b 45 f0             	mov    -0x10(%ebp),%eax
c01002a2:	83 ec 08             	sub    $0x8,%esp
c01002a5:	50                   	push   %eax
c01002a6:	ff 75 08             	pushl  0x8(%ebp)
c01002a9:	e8 b4 ff ff ff       	call   c0100262 <vcprintf>
c01002ae:	83 c4 10             	add    $0x10,%esp
c01002b1:	89 45 f4             	mov    %eax,-0xc(%ebp)
    va_end(ap);
    return cnt;
c01002b4:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
c01002b7:	c9                   	leave  
c01002b8:	c3                   	ret    

c01002b9 <cputchar>:

/* cputchar - writes a single character to stdout */
void
cputchar(int c) {
c01002b9:	f3 0f 1e fb          	endbr32 
c01002bd:	55                   	push   %ebp
c01002be:	89 e5                	mov    %esp,%ebp
c01002c0:	83 ec 08             	sub    $0x8,%esp
    cons_putc(c);
c01002c3:	83 ec 0c             	sub    $0xc,%esp
c01002c6:	ff 75 08             	pushl  0x8(%ebp)
c01002c9:	e8 ff 13 00 00       	call   c01016cd <cons_putc>
c01002ce:	83 c4 10             	add    $0x10,%esp
}
c01002d1:	90                   	nop
c01002d2:	c9                   	leave  
c01002d3:	c3                   	ret    

c01002d4 <cputs>:
/* *
 * cputs- writes the string pointed by @str to stdout and
 * appends a newline character.
 * */
int
cputs(const char *str) {
c01002d4:	f3 0f 1e fb          	endbr32 
c01002d8:	55                   	push   %ebp
c01002d9:	89 e5                	mov    %esp,%ebp
c01002db:	83 ec 18             	sub    $0x18,%esp
    int cnt = 0;
c01002de:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    char c;
    while ((c = *str ++) != '\0') {
c01002e5:	eb 14                	jmp    c01002fb <cputs+0x27>
        cputch(c, &cnt);
c01002e7:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
c01002eb:	83 ec 08             	sub    $0x8,%esp
c01002ee:	8d 55 f0             	lea    -0x10(%ebp),%edx
c01002f1:	52                   	push   %edx
c01002f2:	50                   	push   %eax
c01002f3:	e8 42 ff ff ff       	call   c010023a <cputch>
c01002f8:	83 c4 10             	add    $0x10,%esp
    while ((c = *str ++) != '\0') {
c01002fb:	8b 45 08             	mov    0x8(%ebp),%eax
c01002fe:	8d 50 01             	lea    0x1(%eax),%edx
c0100301:	89 55 08             	mov    %edx,0x8(%ebp)
c0100304:	0f b6 00             	movzbl (%eax),%eax
c0100307:	88 45 f7             	mov    %al,-0x9(%ebp)
c010030a:	80 7d f7 00          	cmpb   $0x0,-0x9(%ebp)
c010030e:	75 d7                	jne    c01002e7 <cputs+0x13>
    }
    cputch('\n', &cnt);
c0100310:	83 ec 08             	sub    $0x8,%esp
c0100313:	8d 45 f0             	lea    -0x10(%ebp),%eax
c0100316:	50                   	push   %eax
c0100317:	6a 0a                	push   $0xa
c0100319:	e8 1c ff ff ff       	call   c010023a <cputch>
c010031e:	83 c4 10             	add    $0x10,%esp
    return cnt;
c0100321:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
c0100324:	c9                   	leave  
c0100325:	c3                   	ret    

c0100326 <getchar>:

/* getchar - reads a single non-zero character from stdin */
int
getchar(void) {
c0100326:	f3 0f 1e fb          	endbr32 
c010032a:	55                   	push   %ebp
c010032b:	89 e5                	mov    %esp,%ebp
c010032d:	83 ec 18             	sub    $0x18,%esp
    int c;
    while ((c = cons_getc()) == 0)
c0100330:	90                   	nop
c0100331:	e8 e4 13 00 00       	call   c010171a <cons_getc>
c0100336:	89 45 f4             	mov    %eax,-0xc(%ebp)
c0100339:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
c010033d:	74 f2                	je     c0100331 <getchar+0xb>
        /* do nothing */;
    return c;
c010033f:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
c0100342:	c9                   	leave  
c0100343:	c3                   	ret    

c0100344 <readline>:
 * The readline() function returns the text of the line read. If some errors
 * are happened, NULL is returned. The return value is a global variable,
 * thus it should be copied before it is used.
 * */
char *
readline(const char *prompt) {
c0100344:	f3 0f 1e fb          	endbr32 
c0100348:	55                   	push   %ebp
c0100349:	89 e5                	mov    %esp,%ebp
c010034b:	83 ec 18             	sub    $0x18,%esp
    if (prompt != NULL) {
c010034e:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
c0100352:	74 13                	je     c0100367 <readline+0x23>
        cprintf("%s", prompt);
c0100354:	83 ec 08             	sub    $0x8,%esp
c0100357:	ff 75 08             	pushl  0x8(%ebp)
c010035a:	68 a7 5d 10 c0       	push   $0xc0105da7
c010035f:	e8 2b ff ff ff       	call   c010028f <cprintf>
c0100364:	83 c4 10             	add    $0x10,%esp
    }
    int i = 0, c;
c0100367:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while (1) {
        c = getchar();
c010036e:	e8 b3 ff ff ff       	call   c0100326 <getchar>
c0100373:	89 45 f0             	mov    %eax,-0x10(%ebp)
        if (c < 0) {
c0100376:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
c010037a:	79 0a                	jns    c0100386 <readline+0x42>
            return NULL;
c010037c:	b8 00 00 00 00       	mov    $0x0,%eax
c0100381:	e9 82 00 00 00       	jmp    c0100408 <readline+0xc4>
        }
        else if (c >= ' ' && i < BUFSIZE - 1) {
c0100386:	83 7d f0 1f          	cmpl   $0x1f,-0x10(%ebp)
c010038a:	7e 2b                	jle    c01003b7 <readline+0x73>
c010038c:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
c0100393:	7f 22                	jg     c01003b7 <readline+0x73>
            cputchar(c);
c0100395:	83 ec 0c             	sub    $0xc,%esp
c0100398:	ff 75 f0             	pushl  -0x10(%ebp)
c010039b:	e8 19 ff ff ff       	call   c01002b9 <cputchar>
c01003a0:	83 c4 10             	add    $0x10,%esp
            buf[i ++] = c;
c01003a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
c01003a6:	8d 50 01             	lea    0x1(%eax),%edx
c01003a9:	89 55 f4             	mov    %edx,-0xc(%ebp)
c01003ac:	8b 55 f0             	mov    -0x10(%ebp),%edx
c01003af:	88 90 60 9a 11 c0    	mov    %dl,-0x3fee65a0(%eax)
c01003b5:	eb 4c                	jmp    c0100403 <readline+0xbf>
        }
        else if (c == '\b' && i > 0) {
c01003b7:	83 7d f0 08          	cmpl   $0x8,-0x10(%ebp)
c01003bb:	75 1a                	jne    c01003d7 <readline+0x93>
c01003bd:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
c01003c1:	7e 14                	jle    c01003d7 <readline+0x93>
            cputchar(c);
c01003c3:	83 ec 0c             	sub    $0xc,%esp
c01003c6:	ff 75 f0             	pushl  -0x10(%ebp)
c01003c9:	e8 eb fe ff ff       	call   c01002b9 <cputchar>
c01003ce:	83 c4 10             	add    $0x10,%esp
            i --;
c01003d1:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
c01003d5:	eb 2c                	jmp    c0100403 <readline+0xbf>
        }
        else if (c == '\n' || c == '\r') {
c01003d7:	83 7d f0 0a          	cmpl   $0xa,-0x10(%ebp)
c01003db:	74 06                	je     c01003e3 <readline+0x9f>
c01003dd:	83 7d f0 0d          	cmpl   $0xd,-0x10(%ebp)
c01003e1:	75 8b                	jne    c010036e <readline+0x2a>
            cputchar(c);
c01003e3:	83 ec 0c             	sub    $0xc,%esp
c01003e6:	ff 75 f0             	pushl  -0x10(%ebp)
c01003e9:	e8 cb fe ff ff       	call   c01002b9 <cputchar>
c01003ee:	83 c4 10             	add    $0x10,%esp
            buf[i] = '\0';
c01003f1:	8b 45 f4             	mov    -0xc(%ebp),%eax
c01003f4:	05 60 9a 11 c0       	add    $0xc0119a60,%eax
c01003f9:	c6 00 00             	movb   $0x0,(%eax)
            return buf;
c01003fc:	b8 60 9a 11 c0       	mov    $0xc0119a60,%eax
c0100401:	eb 05                	jmp    c0100408 <readline+0xc4>
        c = getchar();
c0100403:	e9 66 ff ff ff       	jmp    c010036e <readline+0x2a>
        }
    }
}
c0100408:	c9                   	leave  
c0100409:	c3                   	ret    

c010040a <__panic>:
/* *
 * __panic - __panic is called on unresolvable fatal errors. it prints
 * "panic: 'message'", and then enters the kernel monitor.
 * */
void
__panic(const char *file, int line, const char *fmt, ...) {
c010040a:	f3 0f 1e fb          	endbr32 
c010040e:	55                   	push   %ebp
c010040f:	89 e5                	mov    %esp,%ebp
c0100411:	83 ec 18             	sub    $0x18,%esp
    if (is_panic) {
c0100414:	a1 60 9e 11 c0       	mov    0xc0119e60,%eax
c0100419:	85 c0                	test   %eax,%eax
c010041b:	75 4a                	jne    c0100467 <__panic+0x5d>
        goto panic_dead;
    }
    is_panic = 1;
c010041d:	c7 05 60 9e 11 c0 01 	movl   $0x1,0xc0119e60
c0100424:	00 00 00 

    // print the 'message'
    va_list ap;
    va_start(ap, fmt);
c0100427:	8d 45 14             	lea    0x14(%ebp),%eax
c010042a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    cprintf("kernel panic at %s:%d:\n    ", file, line);
c010042d:	83 ec 04             	sub    $0x4,%esp
c0100430:	ff 75 0c             	pushl  0xc(%ebp)
c0100433:	ff 75 08             	pushl  0x8(%ebp)
c0100436:	68 aa 5d 10 c0       	push   $0xc0105daa
c010043b:	e8 4f fe ff ff       	call   c010028f <cprintf>
c0100440:	83 c4 10             	add    $0x10,%esp
    vcprintf(fmt, ap);
c0100443:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0100446:	83 ec 08             	sub    $0x8,%esp
c0100449:	50                   	push   %eax
c010044a:	ff 75 10             	pushl  0x10(%ebp)
c010044d:	e8 10 fe ff ff       	call   c0100262 <vcprintf>
c0100452:	83 c4 10             	add    $0x10,%esp
    cprintf("\n");
c0100455:	83 ec 0c             	sub    $0xc,%esp
c0100458:	68 c6 5d 10 c0       	push   $0xc0105dc6
c010045d:	e8 2d fe ff ff       	call   c010028f <cprintf>
c0100462:	83 c4 10             	add    $0x10,%esp
c0100465:	eb 01                	jmp    c0100468 <__panic+0x5e>
        goto panic_dead;
c0100467:	90                   	nop
    va_end(ap);

panic_dead:
    intr_disable();
c0100468:	e8 0e 15 00 00       	call   c010197b <intr_disable>
    while (1) {
        kmonitor(NULL);
c010046d:	83 ec 0c             	sub    $0xc,%esp
c0100470:	6a 00                	push   $0x0
c0100472:	e8 6c 08 00 00       	call   c0100ce3 <kmonitor>
c0100477:	83 c4 10             	add    $0x10,%esp
c010047a:	eb f1                	jmp    c010046d <__panic+0x63>

c010047c <__warn>:
    }
}

/* __warn - like panic, but don't */
void
__warn(const char *file, int line, const char *fmt, ...) {
c010047c:	f3 0f 1e fb          	endbr32 
c0100480:	55                   	push   %ebp
c0100481:	89 e5                	mov    %esp,%ebp
c0100483:	83 ec 18             	sub    $0x18,%esp
    va_list ap;
    va_start(ap, fmt);
c0100486:	8d 45 14             	lea    0x14(%ebp),%eax
c0100489:	89 45 f4             	mov    %eax,-0xc(%ebp)
    cprintf("kernel warning at %s:%d:\n    ", file, line);
c010048c:	83 ec 04             	sub    $0x4,%esp
c010048f:	ff 75 0c             	pushl  0xc(%ebp)
c0100492:	ff 75 08             	pushl  0x8(%ebp)
c0100495:	68 c8 5d 10 c0       	push   $0xc0105dc8
c010049a:	e8 f0 fd ff ff       	call   c010028f <cprintf>
c010049f:	83 c4 10             	add    $0x10,%esp
    vcprintf(fmt, ap);
c01004a2:	8b 45 f4             	mov    -0xc(%ebp),%eax
c01004a5:	83 ec 08             	sub    $0x8,%esp
c01004a8:	50                   	push   %eax
c01004a9:	ff 75 10             	pushl  0x10(%ebp)
c01004ac:	e8 b1 fd ff ff       	call   c0100262 <vcprintf>
c01004b1:	83 c4 10             	add    $0x10,%esp
    cprintf("\n");
c01004b4:	83 ec 0c             	sub    $0xc,%esp
c01004b7:	68 c6 5d 10 c0       	push   $0xc0105dc6
c01004bc:	e8 ce fd ff ff       	call   c010028f <cprintf>
c01004c1:	83 c4 10             	add    $0x10,%esp
    va_end(ap);
}
c01004c4:	90                   	nop
c01004c5:	c9                   	leave  
c01004c6:	c3                   	ret    

c01004c7 <is_kernel_panic>:

bool
is_kernel_panic(void) {
c01004c7:	f3 0f 1e fb          	endbr32 
c01004cb:	55                   	push   %ebp
c01004cc:	89 e5                	mov    %esp,%ebp
    return is_panic;
c01004ce:	a1 60 9e 11 c0       	mov    0xc0119e60,%eax
}
c01004d3:	5d                   	pop    %ebp
c01004d4:	c3                   	ret    

c01004d5 <stab_binsearch>:
 *      stab_binsearch(stabs, &left, &right, N_SO, 0xf0100184);
 * will exit setting left = 118, right = 554.
 * */
static void
stab_binsearch(const struct stab *stabs, int *region_left, int *region_right,
           int type, uintptr_t addr) {
c01004d5:	f3 0f 1e fb          	endbr32 
c01004d9:	55                   	push   %ebp
c01004da:	89 e5                	mov    %esp,%ebp
c01004dc:	83 ec 20             	sub    $0x20,%esp
    int l = *region_left, r = *region_right, any_matches = 0;
c01004df:	8b 45 0c             	mov    0xc(%ebp),%eax
c01004e2:	8b 00                	mov    (%eax),%eax
c01004e4:	89 45 fc             	mov    %eax,-0x4(%ebp)
c01004e7:	8b 45 10             	mov    0x10(%ebp),%eax
c01004ea:	8b 00                	mov    (%eax),%eax
c01004ec:	89 45 f8             	mov    %eax,-0x8(%ebp)
c01004ef:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

    while (l <= r) {
c01004f6:	e9 d2 00 00 00       	jmp    c01005cd <stab_binsearch+0xf8>
        int true_m = (l + r) / 2, m = true_m;
c01004fb:	8b 55 fc             	mov    -0x4(%ebp),%edx
c01004fe:	8b 45 f8             	mov    -0x8(%ebp),%eax
c0100501:	01 d0                	add    %edx,%eax
c0100503:	89 c2                	mov    %eax,%edx
c0100505:	c1 ea 1f             	shr    $0x1f,%edx
c0100508:	01 d0                	add    %edx,%eax
c010050a:	d1 f8                	sar    %eax
c010050c:	89 45 ec             	mov    %eax,-0x14(%ebp)
c010050f:	8b 45 ec             	mov    -0x14(%ebp),%eax
c0100512:	89 45 f0             	mov    %eax,-0x10(%ebp)

        // search for earliest stab with right type
        while (m >= l && stabs[m].n_type != type) {
c0100515:	eb 04                	jmp    c010051b <stab_binsearch+0x46>
            m --;
c0100517:	83 6d f0 01          	subl   $0x1,-0x10(%ebp)
        while (m >= l && stabs[m].n_type != type) {
c010051b:	8b 45 f0             	mov    -0x10(%ebp),%eax
c010051e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
c0100521:	7c 1f                	jl     c0100542 <stab_binsearch+0x6d>
c0100523:	8b 55 f0             	mov    -0x10(%ebp),%edx
c0100526:	89 d0                	mov    %edx,%eax
c0100528:	01 c0                	add    %eax,%eax
c010052a:	01 d0                	add    %edx,%eax
c010052c:	c1 e0 02             	shl    $0x2,%eax
c010052f:	89 c2                	mov    %eax,%edx
c0100531:	8b 45 08             	mov    0x8(%ebp),%eax
c0100534:	01 d0                	add    %edx,%eax
c0100536:	0f b6 40 04          	movzbl 0x4(%eax),%eax
c010053a:	0f b6 c0             	movzbl %al,%eax
c010053d:	39 45 14             	cmp    %eax,0x14(%ebp)
c0100540:	75 d5                	jne    c0100517 <stab_binsearch+0x42>
        }
        if (m < l) {    // no match in [l, m]
c0100542:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0100545:	3b 45 fc             	cmp    -0x4(%ebp),%eax
c0100548:	7d 0b                	jge    c0100555 <stab_binsearch+0x80>
            l = true_m + 1;
c010054a:	8b 45 ec             	mov    -0x14(%ebp),%eax
c010054d:	83 c0 01             	add    $0x1,%eax
c0100550:	89 45 fc             	mov    %eax,-0x4(%ebp)
            continue;
c0100553:	eb 78                	jmp    c01005cd <stab_binsearch+0xf8>
        }

        // actual binary search
        any_matches = 1;
c0100555:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        if (stabs[m].n_value < addr) {
c010055c:	8b 55 f0             	mov    -0x10(%ebp),%edx
c010055f:	89 d0                	mov    %edx,%eax
c0100561:	01 c0                	add    %eax,%eax
c0100563:	01 d0                	add    %edx,%eax
c0100565:	c1 e0 02             	shl    $0x2,%eax
c0100568:	89 c2                	mov    %eax,%edx
c010056a:	8b 45 08             	mov    0x8(%ebp),%eax
c010056d:	01 d0                	add    %edx,%eax
c010056f:	8b 40 08             	mov    0x8(%eax),%eax
c0100572:	39 45 18             	cmp    %eax,0x18(%ebp)
c0100575:	76 13                	jbe    c010058a <stab_binsearch+0xb5>
            *region_left = m;
c0100577:	8b 45 0c             	mov    0xc(%ebp),%eax
c010057a:	8b 55 f0             	mov    -0x10(%ebp),%edx
c010057d:	89 10                	mov    %edx,(%eax)
            l = true_m + 1;
c010057f:	8b 45 ec             	mov    -0x14(%ebp),%eax
c0100582:	83 c0 01             	add    $0x1,%eax
c0100585:	89 45 fc             	mov    %eax,-0x4(%ebp)
c0100588:	eb 43                	jmp    c01005cd <stab_binsearch+0xf8>
        } else if (stabs[m].n_value > addr) {
c010058a:	8b 55 f0             	mov    -0x10(%ebp),%edx
c010058d:	89 d0                	mov    %edx,%eax
c010058f:	01 c0                	add    %eax,%eax
c0100591:	01 d0                	add    %edx,%eax
c0100593:	c1 e0 02             	shl    $0x2,%eax
c0100596:	89 c2                	mov    %eax,%edx
c0100598:	8b 45 08             	mov    0x8(%ebp),%eax
c010059b:	01 d0                	add    %edx,%eax
c010059d:	8b 40 08             	mov    0x8(%eax),%eax
c01005a0:	39 45 18             	cmp    %eax,0x18(%ebp)
c01005a3:	73 16                	jae    c01005bb <stab_binsearch+0xe6>
            *region_right = m - 1;
c01005a5:	8b 45 f0             	mov    -0x10(%ebp),%eax
c01005a8:	8d 50 ff             	lea    -0x1(%eax),%edx
c01005ab:	8b 45 10             	mov    0x10(%ebp),%eax
c01005ae:	89 10                	mov    %edx,(%eax)
            r = m - 1;
c01005b0:	8b 45 f0             	mov    -0x10(%ebp),%eax
c01005b3:	83 e8 01             	sub    $0x1,%eax
c01005b6:	89 45 f8             	mov    %eax,-0x8(%ebp)
c01005b9:	eb 12                	jmp    c01005cd <stab_binsearch+0xf8>
        } else {
            // exact match for 'addr', but continue loop to find
            // *region_right
            *region_left = m;
c01005bb:	8b 45 0c             	mov    0xc(%ebp),%eax
c01005be:	8b 55 f0             	mov    -0x10(%ebp),%edx
c01005c1:	89 10                	mov    %edx,(%eax)
            l = m;
c01005c3:	8b 45 f0             	mov    -0x10(%ebp),%eax
c01005c6:	89 45 fc             	mov    %eax,-0x4(%ebp)
            addr ++;
c01005c9:	83 45 18 01          	addl   $0x1,0x18(%ebp)
    while (l <= r) {
c01005cd:	8b 45 fc             	mov    -0x4(%ebp),%eax
c01005d0:	3b 45 f8             	cmp    -0x8(%ebp),%eax
c01005d3:	0f 8e 22 ff ff ff    	jle    c01004fb <stab_binsearch+0x26>
        }
    }

    if (!any_matches) {
c01005d9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
c01005dd:	75 0f                	jne    c01005ee <stab_binsearch+0x119>
        *region_right = *region_left - 1;
c01005df:	8b 45 0c             	mov    0xc(%ebp),%eax
c01005e2:	8b 00                	mov    (%eax),%eax
c01005e4:	8d 50 ff             	lea    -0x1(%eax),%edx
c01005e7:	8b 45 10             	mov    0x10(%ebp),%eax
c01005ea:	89 10                	mov    %edx,(%eax)
        l = *region_right;
        for (; l > *region_left && stabs[l].n_type != type; l --)
            /* do nothing */;
        *region_left = l;
    }
}
c01005ec:	eb 3f                	jmp    c010062d <stab_binsearch+0x158>
        l = *region_right;
c01005ee:	8b 45 10             	mov    0x10(%ebp),%eax
c01005f1:	8b 00                	mov    (%eax),%eax
c01005f3:	89 45 fc             	mov    %eax,-0x4(%ebp)
        for (; l > *region_left && stabs[l].n_type != type; l --)
c01005f6:	eb 04                	jmp    c01005fc <stab_binsearch+0x127>
c01005f8:	83 6d fc 01          	subl   $0x1,-0x4(%ebp)
c01005fc:	8b 45 0c             	mov    0xc(%ebp),%eax
c01005ff:	8b 00                	mov    (%eax),%eax
c0100601:	39 45 fc             	cmp    %eax,-0x4(%ebp)
c0100604:	7e 1f                	jle    c0100625 <stab_binsearch+0x150>
c0100606:	8b 55 fc             	mov    -0x4(%ebp),%edx
c0100609:	89 d0                	mov    %edx,%eax
c010060b:	01 c0                	add    %eax,%eax
c010060d:	01 d0                	add    %edx,%eax
c010060f:	c1 e0 02             	shl    $0x2,%eax
c0100612:	89 c2                	mov    %eax,%edx
c0100614:	8b 45 08             	mov    0x8(%ebp),%eax
c0100617:	01 d0                	add    %edx,%eax
c0100619:	0f b6 40 04          	movzbl 0x4(%eax),%eax
c010061d:	0f b6 c0             	movzbl %al,%eax
c0100620:	39 45 14             	cmp    %eax,0x14(%ebp)
c0100623:	75 d3                	jne    c01005f8 <stab_binsearch+0x123>
        *region_left = l;
c0100625:	8b 45 0c             	mov    0xc(%ebp),%eax
c0100628:	8b 55 fc             	mov    -0x4(%ebp),%edx
c010062b:	89 10                	mov    %edx,(%eax)
}
c010062d:	90                   	nop
c010062e:	c9                   	leave  
c010062f:	c3                   	ret    

c0100630 <debuginfo_eip>:
 * the specified instruction address, @addr.  Returns 0 if information
 * was found, and negative if not.  But even if it returns negative it
 * has stored some information into '*info'.
 * */
int
debuginfo_eip(uintptr_t addr, struct eipdebuginfo *info) {
c0100630:	f3 0f 1e fb          	endbr32 
c0100634:	55                   	push   %ebp
c0100635:	89 e5                	mov    %esp,%ebp
c0100637:	83 ec 38             	sub    $0x38,%esp
    const struct stab *stabs, *stab_end;
    const char *stabstr, *stabstr_end;

    info->eip_file = "<unknown>";
c010063a:	8b 45 0c             	mov    0xc(%ebp),%eax
c010063d:	c7 00 e8 5d 10 c0    	movl   $0xc0105de8,(%eax)
    info->eip_line = 0;
c0100643:	8b 45 0c             	mov    0xc(%ebp),%eax
c0100646:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    info->eip_fn_name = "<unknown>";
c010064d:	8b 45 0c             	mov    0xc(%ebp),%eax
c0100650:	c7 40 08 e8 5d 10 c0 	movl   $0xc0105de8,0x8(%eax)
    info->eip_fn_namelen = 9;
c0100657:	8b 45 0c             	mov    0xc(%ebp),%eax
c010065a:	c7 40 0c 09 00 00 00 	movl   $0x9,0xc(%eax)
    info->eip_fn_addr = addr;
c0100661:	8b 45 0c             	mov    0xc(%ebp),%eax
c0100664:	8b 55 08             	mov    0x8(%ebp),%edx
c0100667:	89 50 10             	mov    %edx,0x10(%eax)
    info->eip_fn_narg = 0;
c010066a:	8b 45 0c             	mov    0xc(%ebp),%eax
c010066d:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)

    stabs = __STAB_BEGIN__;
c0100674:	c7 45 f4 00 70 10 c0 	movl   $0xc0107000,-0xc(%ebp)
    stab_end = __STAB_END__;
c010067b:	c7 45 f0 84 39 11 c0 	movl   $0xc0113984,-0x10(%ebp)
    stabstr = __STABSTR_BEGIN__;
c0100682:	c7 45 ec 85 39 11 c0 	movl   $0xc0113985,-0x14(%ebp)
    stabstr_end = __STABSTR_END__;
c0100689:	c7 45 e8 a0 64 11 c0 	movl   $0xc01164a0,-0x18(%ebp)

    // String table validity checks
    if (stabstr_end <= stabstr || stabstr_end[-1] != 0) {
c0100690:	8b 45 e8             	mov    -0x18(%ebp),%eax
c0100693:	3b 45 ec             	cmp    -0x14(%ebp),%eax
c0100696:	76 0d                	jbe    c01006a5 <debuginfo_eip+0x75>
c0100698:	8b 45 e8             	mov    -0x18(%ebp),%eax
c010069b:	83 e8 01             	sub    $0x1,%eax
c010069e:	0f b6 00             	movzbl (%eax),%eax
c01006a1:	84 c0                	test   %al,%al
c01006a3:	74 0a                	je     c01006af <debuginfo_eip+0x7f>
        return -1;
c01006a5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
c01006aa:	e9 85 02 00 00       	jmp    c0100934 <debuginfo_eip+0x304>
    // 'eip'.  First, we find the basic source file containing 'eip'.
    // Then, we look in that source file for the function.  Then we look
    // for the line number.

    // Search the entire set of stabs for the source file (type N_SO).
    int lfile = 0, rfile = (stab_end - stabs) - 1;
c01006af:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
c01006b6:	8b 45 f0             	mov    -0x10(%ebp),%eax
c01006b9:	2b 45 f4             	sub    -0xc(%ebp),%eax
c01006bc:	c1 f8 02             	sar    $0x2,%eax
c01006bf:	69 c0 ab aa aa aa    	imul   $0xaaaaaaab,%eax,%eax
c01006c5:	83 e8 01             	sub    $0x1,%eax
c01006c8:	89 45 e0             	mov    %eax,-0x20(%ebp)
    stab_binsearch(stabs, &lfile, &rfile, N_SO, addr);
c01006cb:	ff 75 08             	pushl  0x8(%ebp)
c01006ce:	6a 64                	push   $0x64
c01006d0:	8d 45 e0             	lea    -0x20(%ebp),%eax
c01006d3:	50                   	push   %eax
c01006d4:	8d 45 e4             	lea    -0x1c(%ebp),%eax
c01006d7:	50                   	push   %eax
c01006d8:	ff 75 f4             	pushl  -0xc(%ebp)
c01006db:	e8 f5 fd ff ff       	call   c01004d5 <stab_binsearch>
c01006e0:	83 c4 14             	add    $0x14,%esp
    if (lfile == 0)
c01006e3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c01006e6:	85 c0                	test   %eax,%eax
c01006e8:	75 0a                	jne    c01006f4 <debuginfo_eip+0xc4>
        return -1;
c01006ea:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
c01006ef:	e9 40 02 00 00       	jmp    c0100934 <debuginfo_eip+0x304>

    // Search within that file's stabs for the function definition
    // (N_FUN).
    int lfun = lfile, rfun = rfile;
c01006f4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c01006f7:	89 45 dc             	mov    %eax,-0x24(%ebp)
c01006fa:	8b 45 e0             	mov    -0x20(%ebp),%eax
c01006fd:	89 45 d8             	mov    %eax,-0x28(%ebp)
    int lline, rline;
    stab_binsearch(stabs, &lfun, &rfun, N_FUN, addr);
c0100700:	ff 75 08             	pushl  0x8(%ebp)
c0100703:	6a 24                	push   $0x24
c0100705:	8d 45 d8             	lea    -0x28(%ebp),%eax
c0100708:	50                   	push   %eax
c0100709:	8d 45 dc             	lea    -0x24(%ebp),%eax
c010070c:	50                   	push   %eax
c010070d:	ff 75 f4             	pushl  -0xc(%ebp)
c0100710:	e8 c0 fd ff ff       	call   c01004d5 <stab_binsearch>
c0100715:	83 c4 14             	add    $0x14,%esp

    if (lfun <= rfun) {
c0100718:	8b 55 dc             	mov    -0x24(%ebp),%edx
c010071b:	8b 45 d8             	mov    -0x28(%ebp),%eax
c010071e:	39 c2                	cmp    %eax,%edx
c0100720:	7f 78                	jg     c010079a <debuginfo_eip+0x16a>
        // stabs[lfun] points to the function name
        // in the string table, but check bounds just in case.
        if (stabs[lfun].n_strx < stabstr_end - stabstr) {
c0100722:	8b 45 dc             	mov    -0x24(%ebp),%eax
c0100725:	89 c2                	mov    %eax,%edx
c0100727:	89 d0                	mov    %edx,%eax
c0100729:	01 c0                	add    %eax,%eax
c010072b:	01 d0                	add    %edx,%eax
c010072d:	c1 e0 02             	shl    $0x2,%eax
c0100730:	89 c2                	mov    %eax,%edx
c0100732:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0100735:	01 d0                	add    %edx,%eax
c0100737:	8b 10                	mov    (%eax),%edx
c0100739:	8b 45 e8             	mov    -0x18(%ebp),%eax
c010073c:	2b 45 ec             	sub    -0x14(%ebp),%eax
c010073f:	39 c2                	cmp    %eax,%edx
c0100741:	73 22                	jae    c0100765 <debuginfo_eip+0x135>
            info->eip_fn_name = stabstr + stabs[lfun].n_strx;
c0100743:	8b 45 dc             	mov    -0x24(%ebp),%eax
c0100746:	89 c2                	mov    %eax,%edx
c0100748:	89 d0                	mov    %edx,%eax
c010074a:	01 c0                	add    %eax,%eax
c010074c:	01 d0                	add    %edx,%eax
c010074e:	c1 e0 02             	shl    $0x2,%eax
c0100751:	89 c2                	mov    %eax,%edx
c0100753:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0100756:	01 d0                	add    %edx,%eax
c0100758:	8b 10                	mov    (%eax),%edx
c010075a:	8b 45 ec             	mov    -0x14(%ebp),%eax
c010075d:	01 c2                	add    %eax,%edx
c010075f:	8b 45 0c             	mov    0xc(%ebp),%eax
c0100762:	89 50 08             	mov    %edx,0x8(%eax)
        }
        info->eip_fn_addr = stabs[lfun].n_value;
c0100765:	8b 45 dc             	mov    -0x24(%ebp),%eax
c0100768:	89 c2                	mov    %eax,%edx
c010076a:	89 d0                	mov    %edx,%eax
c010076c:	01 c0                	add    %eax,%eax
c010076e:	01 d0                	add    %edx,%eax
c0100770:	c1 e0 02             	shl    $0x2,%eax
c0100773:	89 c2                	mov    %eax,%edx
c0100775:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0100778:	01 d0                	add    %edx,%eax
c010077a:	8b 50 08             	mov    0x8(%eax),%edx
c010077d:	8b 45 0c             	mov    0xc(%ebp),%eax
c0100780:	89 50 10             	mov    %edx,0x10(%eax)
        addr -= info->eip_fn_addr;
c0100783:	8b 45 0c             	mov    0xc(%ebp),%eax
c0100786:	8b 40 10             	mov    0x10(%eax),%eax
c0100789:	29 45 08             	sub    %eax,0x8(%ebp)
        // Search within the function definition for the line number.
        lline = lfun;
c010078c:	8b 45 dc             	mov    -0x24(%ebp),%eax
c010078f:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        rline = rfun;
c0100792:	8b 45 d8             	mov    -0x28(%ebp),%eax
c0100795:	89 45 d0             	mov    %eax,-0x30(%ebp)
c0100798:	eb 15                	jmp    c01007af <debuginfo_eip+0x17f>
    } else {
        // Couldn't find function stab!  Maybe we're in an assembly
        // file.  Search the whole file for the line number.
        info->eip_fn_addr = addr;
c010079a:	8b 45 0c             	mov    0xc(%ebp),%eax
c010079d:	8b 55 08             	mov    0x8(%ebp),%edx
c01007a0:	89 50 10             	mov    %edx,0x10(%eax)
        lline = lfile;
c01007a3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c01007a6:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        rline = rfile;
c01007a9:	8b 45 e0             	mov    -0x20(%ebp),%eax
c01007ac:	89 45 d0             	mov    %eax,-0x30(%ebp)
    }
    info->eip_fn_namelen = strfind(info->eip_fn_name, ':') - info->eip_fn_name;
c01007af:	8b 45 0c             	mov    0xc(%ebp),%eax
c01007b2:	8b 40 08             	mov    0x8(%eax),%eax
c01007b5:	83 ec 08             	sub    $0x8,%esp
c01007b8:	6a 3a                	push   $0x3a
c01007ba:	50                   	push   %eax
c01007bb:	e8 e4 4b 00 00       	call   c01053a4 <strfind>
c01007c0:	83 c4 10             	add    $0x10,%esp
c01007c3:	8b 55 0c             	mov    0xc(%ebp),%edx
c01007c6:	8b 52 08             	mov    0x8(%edx),%edx
c01007c9:	29 d0                	sub    %edx,%eax
c01007cb:	89 c2                	mov    %eax,%edx
c01007cd:	8b 45 0c             	mov    0xc(%ebp),%eax
c01007d0:	89 50 0c             	mov    %edx,0xc(%eax)

    // Search within [lline, rline] for the line number stab.
    // If found, set info->eip_line to the right line number.
    // If not found, return -1.
    stab_binsearch(stabs, &lline, &rline, N_SLINE, addr);
c01007d3:	83 ec 0c             	sub    $0xc,%esp
c01007d6:	ff 75 08             	pushl  0x8(%ebp)
c01007d9:	6a 44                	push   $0x44
c01007db:	8d 45 d0             	lea    -0x30(%ebp),%eax
c01007de:	50                   	push   %eax
c01007df:	8d 45 d4             	lea    -0x2c(%ebp),%eax
c01007e2:	50                   	push   %eax
c01007e3:	ff 75 f4             	pushl  -0xc(%ebp)
c01007e6:	e8 ea fc ff ff       	call   c01004d5 <stab_binsearch>
c01007eb:	83 c4 20             	add    $0x20,%esp
    if (lline <= rline) {
c01007ee:	8b 55 d4             	mov    -0x2c(%ebp),%edx
c01007f1:	8b 45 d0             	mov    -0x30(%ebp),%eax
c01007f4:	39 c2                	cmp    %eax,%edx
c01007f6:	7f 24                	jg     c010081c <debuginfo_eip+0x1ec>
        info->eip_line = stabs[rline].n_desc;
c01007f8:	8b 45 d0             	mov    -0x30(%ebp),%eax
c01007fb:	89 c2                	mov    %eax,%edx
c01007fd:	89 d0                	mov    %edx,%eax
c01007ff:	01 c0                	add    %eax,%eax
c0100801:	01 d0                	add    %edx,%eax
c0100803:	c1 e0 02             	shl    $0x2,%eax
c0100806:	89 c2                	mov    %eax,%edx
c0100808:	8b 45 f4             	mov    -0xc(%ebp),%eax
c010080b:	01 d0                	add    %edx,%eax
c010080d:	0f b7 40 06          	movzwl 0x6(%eax),%eax
c0100811:	0f b7 d0             	movzwl %ax,%edx
c0100814:	8b 45 0c             	mov    0xc(%ebp),%eax
c0100817:	89 50 04             	mov    %edx,0x4(%eax)

    // Search backwards from the line number for the relevant filename stab.
    // We can't just use the "lfile" stab because inlined functions
    // can interpolate code from a different file!
    // Such included source files use the N_SOL stab type.
    while (lline >= lfile
c010081a:	eb 13                	jmp    c010082f <debuginfo_eip+0x1ff>
        return -1;
c010081c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
c0100821:	e9 0e 01 00 00       	jmp    c0100934 <debuginfo_eip+0x304>
           && stabs[lline].n_type != N_SOL
           && (stabs[lline].n_type != N_SO || !stabs[lline].n_value)) {
        lline --;
c0100826:	8b 45 d4             	mov    -0x2c(%ebp),%eax
c0100829:	83 e8 01             	sub    $0x1,%eax
c010082c:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    while (lline >= lfile
c010082f:	8b 55 d4             	mov    -0x2c(%ebp),%edx
c0100832:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c0100835:	39 c2                	cmp    %eax,%edx
c0100837:	7c 56                	jl     c010088f <debuginfo_eip+0x25f>
           && stabs[lline].n_type != N_SOL
c0100839:	8b 45 d4             	mov    -0x2c(%ebp),%eax
c010083c:	89 c2                	mov    %eax,%edx
c010083e:	89 d0                	mov    %edx,%eax
c0100840:	01 c0                	add    %eax,%eax
c0100842:	01 d0                	add    %edx,%eax
c0100844:	c1 e0 02             	shl    $0x2,%eax
c0100847:	89 c2                	mov    %eax,%edx
c0100849:	8b 45 f4             	mov    -0xc(%ebp),%eax
c010084c:	01 d0                	add    %edx,%eax
c010084e:	0f b6 40 04          	movzbl 0x4(%eax),%eax
c0100852:	3c 84                	cmp    $0x84,%al
c0100854:	74 39                	je     c010088f <debuginfo_eip+0x25f>
           && (stabs[lline].n_type != N_SO || !stabs[lline].n_value)) {
c0100856:	8b 45 d4             	mov    -0x2c(%ebp),%eax
c0100859:	89 c2                	mov    %eax,%edx
c010085b:	89 d0                	mov    %edx,%eax
c010085d:	01 c0                	add    %eax,%eax
c010085f:	01 d0                	add    %edx,%eax
c0100861:	c1 e0 02             	shl    $0x2,%eax
c0100864:	89 c2                	mov    %eax,%edx
c0100866:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0100869:	01 d0                	add    %edx,%eax
c010086b:	0f b6 40 04          	movzbl 0x4(%eax),%eax
c010086f:	3c 64                	cmp    $0x64,%al
c0100871:	75 b3                	jne    c0100826 <debuginfo_eip+0x1f6>
c0100873:	8b 45 d4             	mov    -0x2c(%ebp),%eax
c0100876:	89 c2                	mov    %eax,%edx
c0100878:	89 d0                	mov    %edx,%eax
c010087a:	01 c0                	add    %eax,%eax
c010087c:	01 d0                	add    %edx,%eax
c010087e:	c1 e0 02             	shl    $0x2,%eax
c0100881:	89 c2                	mov    %eax,%edx
c0100883:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0100886:	01 d0                	add    %edx,%eax
c0100888:	8b 40 08             	mov    0x8(%eax),%eax
c010088b:	85 c0                	test   %eax,%eax
c010088d:	74 97                	je     c0100826 <debuginfo_eip+0x1f6>
    }
    if (lline >= lfile && stabs[lline].n_strx < stabstr_end - stabstr) {
c010088f:	8b 55 d4             	mov    -0x2c(%ebp),%edx
c0100892:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c0100895:	39 c2                	cmp    %eax,%edx
c0100897:	7c 42                	jl     c01008db <debuginfo_eip+0x2ab>
c0100899:	8b 45 d4             	mov    -0x2c(%ebp),%eax
c010089c:	89 c2                	mov    %eax,%edx
c010089e:	89 d0                	mov    %edx,%eax
c01008a0:	01 c0                	add    %eax,%eax
c01008a2:	01 d0                	add    %edx,%eax
c01008a4:	c1 e0 02             	shl    $0x2,%eax
c01008a7:	89 c2                	mov    %eax,%edx
c01008a9:	8b 45 f4             	mov    -0xc(%ebp),%eax
c01008ac:	01 d0                	add    %edx,%eax
c01008ae:	8b 10                	mov    (%eax),%edx
c01008b0:	8b 45 e8             	mov    -0x18(%ebp),%eax
c01008b3:	2b 45 ec             	sub    -0x14(%ebp),%eax
c01008b6:	39 c2                	cmp    %eax,%edx
c01008b8:	73 21                	jae    c01008db <debuginfo_eip+0x2ab>
        info->eip_file = stabstr + stabs[lline].n_strx;
c01008ba:	8b 45 d4             	mov    -0x2c(%ebp),%eax
c01008bd:	89 c2                	mov    %eax,%edx
c01008bf:	89 d0                	mov    %edx,%eax
c01008c1:	01 c0                	add    %eax,%eax
c01008c3:	01 d0                	add    %edx,%eax
c01008c5:	c1 e0 02             	shl    $0x2,%eax
c01008c8:	89 c2                	mov    %eax,%edx
c01008ca:	8b 45 f4             	mov    -0xc(%ebp),%eax
c01008cd:	01 d0                	add    %edx,%eax
c01008cf:	8b 10                	mov    (%eax),%edx
c01008d1:	8b 45 ec             	mov    -0x14(%ebp),%eax
c01008d4:	01 c2                	add    %eax,%edx
c01008d6:	8b 45 0c             	mov    0xc(%ebp),%eax
c01008d9:	89 10                	mov    %edx,(%eax)
    }

    // Set eip_fn_narg to the number of arguments taken by the function,
    // or 0 if there was no containing function.
    if (lfun < rfun) {
c01008db:	8b 55 dc             	mov    -0x24(%ebp),%edx
c01008de:	8b 45 d8             	mov    -0x28(%ebp),%eax
c01008e1:	39 c2                	cmp    %eax,%edx
c01008e3:	7d 4a                	jge    c010092f <debuginfo_eip+0x2ff>
        for (lline = lfun + 1;
c01008e5:	8b 45 dc             	mov    -0x24(%ebp),%eax
c01008e8:	83 c0 01             	add    $0x1,%eax
c01008eb:	89 45 d4             	mov    %eax,-0x2c(%ebp)
c01008ee:	eb 18                	jmp    c0100908 <debuginfo_eip+0x2d8>
             lline < rfun && stabs[lline].n_type == N_PSYM;
             lline ++) {
            info->eip_fn_narg ++;
c01008f0:	8b 45 0c             	mov    0xc(%ebp),%eax
c01008f3:	8b 40 14             	mov    0x14(%eax),%eax
c01008f6:	8d 50 01             	lea    0x1(%eax),%edx
c01008f9:	8b 45 0c             	mov    0xc(%ebp),%eax
c01008fc:	89 50 14             	mov    %edx,0x14(%eax)
             lline ++) {
c01008ff:	8b 45 d4             	mov    -0x2c(%ebp),%eax
c0100902:	83 c0 01             	add    $0x1,%eax
c0100905:	89 45 d4             	mov    %eax,-0x2c(%ebp)
             lline < rfun && stabs[lline].n_type == N_PSYM;
c0100908:	8b 55 d4             	mov    -0x2c(%ebp),%edx
c010090b:	8b 45 d8             	mov    -0x28(%ebp),%eax
        for (lline = lfun + 1;
c010090e:	39 c2                	cmp    %eax,%edx
c0100910:	7d 1d                	jge    c010092f <debuginfo_eip+0x2ff>
             lline < rfun && stabs[lline].n_type == N_PSYM;
c0100912:	8b 45 d4             	mov    -0x2c(%ebp),%eax
c0100915:	89 c2                	mov    %eax,%edx
c0100917:	89 d0                	mov    %edx,%eax
c0100919:	01 c0                	add    %eax,%eax
c010091b:	01 d0                	add    %edx,%eax
c010091d:	c1 e0 02             	shl    $0x2,%eax
c0100920:	89 c2                	mov    %eax,%edx
c0100922:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0100925:	01 d0                	add    %edx,%eax
c0100927:	0f b6 40 04          	movzbl 0x4(%eax),%eax
c010092b:	3c a0                	cmp    $0xa0,%al
c010092d:	74 c1                	je     c01008f0 <debuginfo_eip+0x2c0>
        }
    }
    return 0;
c010092f:	b8 00 00 00 00       	mov    $0x0,%eax
}
c0100934:	c9                   	leave  
c0100935:	c3                   	ret    

c0100936 <print_kerninfo>:
 * print_kerninfo - print the information about kernel, including the location
 * of kernel entry, the start addresses of data and text segements, the start
 * address of free memory and how many memory that kernel has used.
 * */
void
print_kerninfo(void) {
c0100936:	f3 0f 1e fb          	endbr32 
c010093a:	55                   	push   %ebp
c010093b:	89 e5                	mov    %esp,%ebp
c010093d:	83 ec 08             	sub    $0x8,%esp
    extern char etext[], edata[], end[], kern_init[];
    cprintf("Special kernel symbols:\n");
c0100940:	83 ec 0c             	sub    $0xc,%esp
c0100943:	68 f2 5d 10 c0       	push   $0xc0105df2
c0100948:	e8 42 f9 ff ff       	call   c010028f <cprintf>
c010094d:	83 c4 10             	add    $0x10,%esp
    cprintf("  entry  0x%08x (phys)\n", kern_init);
c0100950:	83 ec 08             	sub    $0x8,%esp
c0100953:	68 2a 00 10 c0       	push   $0xc010002a
c0100958:	68 0b 5e 10 c0       	push   $0xc0105e0b
c010095d:	e8 2d f9 ff ff       	call   c010028f <cprintf>
c0100962:	83 c4 10             	add    $0x10,%esp
    cprintf("  etext  0x%08x (phys)\n", etext);
c0100965:	83 ec 08             	sub    $0x8,%esp
c0100968:	68 f9 5c 10 c0       	push   $0xc0105cf9
c010096d:	68 23 5e 10 c0       	push   $0xc0105e23
c0100972:	e8 18 f9 ff ff       	call   c010028f <cprintf>
c0100977:	83 c4 10             	add    $0x10,%esp
    cprintf("  edata  0x%08x (phys)\n", edata);
c010097a:	83 ec 08             	sub    $0x8,%esp
c010097d:	68 36 9a 11 c0       	push   $0xc0119a36
c0100982:	68 3b 5e 10 c0       	push   $0xc0105e3b
c0100987:	e8 03 f9 ff ff       	call   c010028f <cprintf>
c010098c:	83 c4 10             	add    $0x10,%esp
    cprintf("  end    0x%08x (phys)\n", end);
c010098f:	83 ec 08             	sub    $0x8,%esp
c0100992:	68 68 a9 11 c0       	push   $0xc011a968
c0100997:	68 53 5e 10 c0       	push   $0xc0105e53
c010099c:	e8 ee f8 ff ff       	call   c010028f <cprintf>
c01009a1:	83 c4 10             	add    $0x10,%esp
    cprintf("Kernel executable memory footprint: %dKB\n", (end - kern_init + 1023)/1024);
c01009a4:	b8 68 a9 11 c0       	mov    $0xc011a968,%eax
c01009a9:	2d 2a 00 10 c0       	sub    $0xc010002a,%eax
c01009ae:	05 ff 03 00 00       	add    $0x3ff,%eax
c01009b3:	8d 90 ff 03 00 00    	lea    0x3ff(%eax),%edx
c01009b9:	85 c0                	test   %eax,%eax
c01009bb:	0f 48 c2             	cmovs  %edx,%eax
c01009be:	c1 f8 0a             	sar    $0xa,%eax
c01009c1:	83 ec 08             	sub    $0x8,%esp
c01009c4:	50                   	push   %eax
c01009c5:	68 6c 5e 10 c0       	push   $0xc0105e6c
c01009ca:	e8 c0 f8 ff ff       	call   c010028f <cprintf>
c01009cf:	83 c4 10             	add    $0x10,%esp
}
c01009d2:	90                   	nop
c01009d3:	c9                   	leave  
c01009d4:	c3                   	ret    

c01009d5 <print_debuginfo>:
/* *
 * print_debuginfo - read and print the stat information for the address @eip,
 * and info.eip_fn_addr should be the first address of the related function.
 * */
void
print_debuginfo(uintptr_t eip) {
c01009d5:	f3 0f 1e fb          	endbr32 
c01009d9:	55                   	push   %ebp
c01009da:	89 e5                	mov    %esp,%ebp
c01009dc:	81 ec 28 01 00 00    	sub    $0x128,%esp
    struct eipdebuginfo info;
    if (debuginfo_eip(eip, &info) != 0) {
c01009e2:	83 ec 08             	sub    $0x8,%esp
c01009e5:	8d 45 dc             	lea    -0x24(%ebp),%eax
c01009e8:	50                   	push   %eax
c01009e9:	ff 75 08             	pushl  0x8(%ebp)
c01009ec:	e8 3f fc ff ff       	call   c0100630 <debuginfo_eip>
c01009f1:	83 c4 10             	add    $0x10,%esp
c01009f4:	85 c0                	test   %eax,%eax
c01009f6:	74 15                	je     c0100a0d <print_debuginfo+0x38>
        cprintf("    <unknow>: -- 0x%08x --\n", eip);
c01009f8:	83 ec 08             	sub    $0x8,%esp
c01009fb:	ff 75 08             	pushl  0x8(%ebp)
c01009fe:	68 96 5e 10 c0       	push   $0xc0105e96
c0100a03:	e8 87 f8 ff ff       	call   c010028f <cprintf>
c0100a08:	83 c4 10             	add    $0x10,%esp
        }
        fnname[j] = '\0';
        cprintf("    %s:%d: %s+%d\n", info.eip_file, info.eip_line,
                fnname, eip - info.eip_fn_addr);
    }
}
c0100a0b:	eb 65                	jmp    c0100a72 <print_debuginfo+0x9d>
        for (j = 0; j < info.eip_fn_namelen; j ++) {
c0100a0d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
c0100a14:	eb 1c                	jmp    c0100a32 <print_debuginfo+0x5d>
            fnname[j] = info.eip_fn_name[j];
c0100a16:	8b 55 e4             	mov    -0x1c(%ebp),%edx
c0100a19:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0100a1c:	01 d0                	add    %edx,%eax
c0100a1e:	0f b6 00             	movzbl (%eax),%eax
c0100a21:	8d 8d dc fe ff ff    	lea    -0x124(%ebp),%ecx
c0100a27:	8b 55 f4             	mov    -0xc(%ebp),%edx
c0100a2a:	01 ca                	add    %ecx,%edx
c0100a2c:	88 02                	mov    %al,(%edx)
        for (j = 0; j < info.eip_fn_namelen; j ++) {
c0100a2e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
c0100a32:	8b 45 e8             	mov    -0x18(%ebp),%eax
c0100a35:	39 45 f4             	cmp    %eax,-0xc(%ebp)
c0100a38:	7c dc                	jl     c0100a16 <print_debuginfo+0x41>
        fnname[j] = '\0';
c0100a3a:	8d 95 dc fe ff ff    	lea    -0x124(%ebp),%edx
c0100a40:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0100a43:	01 d0                	add    %edx,%eax
c0100a45:	c6 00 00             	movb   $0x0,(%eax)
                fnname, eip - info.eip_fn_addr);
c0100a48:	8b 45 ec             	mov    -0x14(%ebp),%eax
        cprintf("    %s:%d: %s+%d\n", info.eip_file, info.eip_line,
c0100a4b:	8b 55 08             	mov    0x8(%ebp),%edx
c0100a4e:	89 d1                	mov    %edx,%ecx
c0100a50:	29 c1                	sub    %eax,%ecx
c0100a52:	8b 55 e0             	mov    -0x20(%ebp),%edx
c0100a55:	8b 45 dc             	mov    -0x24(%ebp),%eax
c0100a58:	83 ec 0c             	sub    $0xc,%esp
c0100a5b:	51                   	push   %ecx
c0100a5c:	8d 8d dc fe ff ff    	lea    -0x124(%ebp),%ecx
c0100a62:	51                   	push   %ecx
c0100a63:	52                   	push   %edx
c0100a64:	50                   	push   %eax
c0100a65:	68 b2 5e 10 c0       	push   $0xc0105eb2
c0100a6a:	e8 20 f8 ff ff       	call   c010028f <cprintf>
c0100a6f:	83 c4 20             	add    $0x20,%esp
}
c0100a72:	90                   	nop
c0100a73:	c9                   	leave  
c0100a74:	c3                   	ret    

c0100a75 <read_eip>:

static __noinline uint32_t
read_eip(void) {
c0100a75:	f3 0f 1e fb          	endbr32 
c0100a79:	55                   	push   %ebp
c0100a7a:	89 e5                	mov    %esp,%ebp
c0100a7c:	83 ec 10             	sub    $0x10,%esp
    uint32_t eip;
    asm volatile("movl 4(%%ebp), %0" : "=r" (eip));
c0100a7f:	8b 45 04             	mov    0x4(%ebp),%eax
c0100a82:	89 45 fc             	mov    %eax,-0x4(%ebp)
    return eip;
c0100a85:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
c0100a88:	c9                   	leave  
c0100a89:	c3                   	ret    

c0100a8a <print_stackframe>:
 *
 * Note that, the length of ebp-chain is limited. In boot/bootasm.S, before jumping
 * to the kernel entry, the value of ebp has been set to zero, that's the boundary.
 * */
void
print_stackframe(void) {
c0100a8a:	f3 0f 1e fb          	endbr32 
c0100a8e:	55                   	push   %ebp
c0100a8f:	89 e5                	mov    %esp,%ebp
c0100a91:	83 ec 28             	sub    $0x28,%esp
}

static inline uint32_t
read_ebp(void) {
    uint32_t ebp;
    asm volatile ("movl %%ebp, %0" : "=r" (ebp));
c0100a94:	89 e8                	mov    %ebp,%eax
c0100a96:	89 45 e0             	mov    %eax,-0x20(%ebp)
    return ebp;
c0100a99:	8b 45 e0             	mov    -0x20(%ebp),%eax
      *    (3.4) call print_debuginfo(eip-1) to print the C calling function name and line number, etc.
      *    (3.5) popup a calling stackframe
      *           NOTICE: the calling funciton's return addr eip  = ss:[ebp+4]
      *                   the calling funciton's ebp = ss:[ebp]
      */
	uint32_t ebp = read_ebp();
c0100a9c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	uint32_t eip = read_eip();
c0100a9f:	e8 d1 ff ff ff       	call   c0100a75 <read_eip>
c0100aa4:	89 45 f0             	mov    %eax,-0x10(%ebp)
	for (int i = 0; i < STACKFRAME_DEPTH && ebp != 0; i++)
c0100aa7:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
c0100aae:	e9 ad 00 00 00       	jmp    c0100b60 <print_stackframe+0xd6>
	{
		cprintf("ebp is 0x%08x ", ebp);
c0100ab3:	83 ec 08             	sub    $0x8,%esp
c0100ab6:	ff 75 f4             	pushl  -0xc(%ebp)
c0100ab9:	68 c4 5e 10 c0       	push   $0xc0105ec4
c0100abe:	e8 cc f7 ff ff       	call   c010028f <cprintf>
c0100ac3:	83 c4 10             	add    $0x10,%esp
		cprintf("eip is 0x%08x ", eip);
c0100ac6:	83 ec 08             	sub    $0x8,%esp
c0100ac9:	ff 75 f0             	pushl  -0x10(%ebp)
c0100acc:	68 d3 5e 10 c0       	push   $0xc0105ed3
c0100ad1:	e8 b9 f7 ff ff       	call   c010028f <cprintf>
c0100ad6:	83 c4 10             	add    $0x10,%esp
		uint32_t* args = (uint32_t*) ebp + 2;
c0100ad9:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0100adc:	83 c0 08             	add    $0x8,%eax
c0100adf:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		cprintf("args is ");
c0100ae2:	83 ec 0c             	sub    $0xc,%esp
c0100ae5:	68 e2 5e 10 c0       	push   $0xc0105ee2
c0100aea:	e8 a0 f7 ff ff       	call   c010028f <cprintf>
c0100aef:	83 c4 10             	add    $0x10,%esp
		for(int j = 0; j < 4; j++)
c0100af2:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
c0100af9:	eb 26                	jmp    c0100b21 <print_stackframe+0x97>
		{
			cprintf("0x%08x ", args[j]);
c0100afb:	8b 45 e8             	mov    -0x18(%ebp),%eax
c0100afe:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
c0100b05:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c0100b08:	01 d0                	add    %edx,%eax
c0100b0a:	8b 00                	mov    (%eax),%eax
c0100b0c:	83 ec 08             	sub    $0x8,%esp
c0100b0f:	50                   	push   %eax
c0100b10:	68 eb 5e 10 c0       	push   $0xc0105eeb
c0100b15:	e8 75 f7 ff ff       	call   c010028f <cprintf>
c0100b1a:	83 c4 10             	add    $0x10,%esp
		for(int j = 0; j < 4; j++)
c0100b1d:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
c0100b21:	83 7d e8 03          	cmpl   $0x3,-0x18(%ebp)
c0100b25:	7e d4                	jle    c0100afb <print_stackframe+0x71>
		}
		cprintf("\n");
c0100b27:	83 ec 0c             	sub    $0xc,%esp
c0100b2a:	68 f3 5e 10 c0       	push   $0xc0105ef3
c0100b2f:	e8 5b f7 ff ff       	call   c010028f <cprintf>
c0100b34:	83 c4 10             	add    $0x10,%esp
		print_debuginfo(eip-1);
c0100b37:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0100b3a:	83 e8 01             	sub    $0x1,%eax
c0100b3d:	83 ec 0c             	sub    $0xc,%esp
c0100b40:	50                   	push   %eax
c0100b41:	e8 8f fe ff ff       	call   c01009d5 <print_debuginfo>
c0100b46:	83 c4 10             	add    $0x10,%esp
		eip = ((uint32_t*) ebp) [1];
c0100b49:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0100b4c:	83 c0 04             	add    $0x4,%eax
c0100b4f:	8b 00                	mov    (%eax),%eax
c0100b51:	89 45 f0             	mov    %eax,-0x10(%ebp)
		ebp = ((uint32_t*) ebp) [0];
c0100b54:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0100b57:	8b 00                	mov    (%eax),%eax
c0100b59:	89 45 f4             	mov    %eax,-0xc(%ebp)
	for (int i = 0; i < STACKFRAME_DEPTH && ebp != 0; i++)
c0100b5c:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
c0100b60:	83 7d ec 13          	cmpl   $0x13,-0x14(%ebp)
c0100b64:	7f 0a                	jg     c0100b70 <print_stackframe+0xe6>
c0100b66:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
c0100b6a:	0f 85 43 ff ff ff    	jne    c0100ab3 <print_stackframe+0x29>

	}
}
c0100b70:	90                   	nop
c0100b71:	c9                   	leave  
c0100b72:	c3                   	ret    

c0100b73 <parse>:
#define MAXARGS         16
#define WHITESPACE      " \t\n\r"

/* parse - parse the command buffer into whitespace-separated arguments */
static int
parse(char *buf, char **argv) {
c0100b73:	f3 0f 1e fb          	endbr32 
c0100b77:	55                   	push   %ebp
c0100b78:	89 e5                	mov    %esp,%ebp
c0100b7a:	83 ec 18             	sub    $0x18,%esp
    int argc = 0;
c0100b7d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while (1) {
        // find global whitespace
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
c0100b84:	eb 0c                	jmp    c0100b92 <parse+0x1f>
            *buf ++ = '\0';
c0100b86:	8b 45 08             	mov    0x8(%ebp),%eax
c0100b89:	8d 50 01             	lea    0x1(%eax),%edx
c0100b8c:	89 55 08             	mov    %edx,0x8(%ebp)
c0100b8f:	c6 00 00             	movb   $0x0,(%eax)
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
c0100b92:	8b 45 08             	mov    0x8(%ebp),%eax
c0100b95:	0f b6 00             	movzbl (%eax),%eax
c0100b98:	84 c0                	test   %al,%al
c0100b9a:	74 1e                	je     c0100bba <parse+0x47>
c0100b9c:	8b 45 08             	mov    0x8(%ebp),%eax
c0100b9f:	0f b6 00             	movzbl (%eax),%eax
c0100ba2:	0f be c0             	movsbl %al,%eax
c0100ba5:	83 ec 08             	sub    $0x8,%esp
c0100ba8:	50                   	push   %eax
c0100ba9:	68 78 5f 10 c0       	push   $0xc0105f78
c0100bae:	e8 ba 47 00 00       	call   c010536d <strchr>
c0100bb3:	83 c4 10             	add    $0x10,%esp
c0100bb6:	85 c0                	test   %eax,%eax
c0100bb8:	75 cc                	jne    c0100b86 <parse+0x13>
        }
        if (*buf == '\0') {
c0100bba:	8b 45 08             	mov    0x8(%ebp),%eax
c0100bbd:	0f b6 00             	movzbl (%eax),%eax
c0100bc0:	84 c0                	test   %al,%al
c0100bc2:	74 65                	je     c0100c29 <parse+0xb6>
            break;
        }

        // save and scan past next arg
        if (argc == MAXARGS - 1) {
c0100bc4:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
c0100bc8:	75 12                	jne    c0100bdc <parse+0x69>
            cprintf("Too many arguments (max %d).\n", MAXARGS);
c0100bca:	83 ec 08             	sub    $0x8,%esp
c0100bcd:	6a 10                	push   $0x10
c0100bcf:	68 7d 5f 10 c0       	push   $0xc0105f7d
c0100bd4:	e8 b6 f6 ff ff       	call   c010028f <cprintf>
c0100bd9:	83 c4 10             	add    $0x10,%esp
        }
        argv[argc ++] = buf;
c0100bdc:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0100bdf:	8d 50 01             	lea    0x1(%eax),%edx
c0100be2:	89 55 f4             	mov    %edx,-0xc(%ebp)
c0100be5:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
c0100bec:	8b 45 0c             	mov    0xc(%ebp),%eax
c0100bef:	01 c2                	add    %eax,%edx
c0100bf1:	8b 45 08             	mov    0x8(%ebp),%eax
c0100bf4:	89 02                	mov    %eax,(%edx)
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
c0100bf6:	eb 04                	jmp    c0100bfc <parse+0x89>
            buf ++;
c0100bf8:	83 45 08 01          	addl   $0x1,0x8(%ebp)
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
c0100bfc:	8b 45 08             	mov    0x8(%ebp),%eax
c0100bff:	0f b6 00             	movzbl (%eax),%eax
c0100c02:	84 c0                	test   %al,%al
c0100c04:	74 8c                	je     c0100b92 <parse+0x1f>
c0100c06:	8b 45 08             	mov    0x8(%ebp),%eax
c0100c09:	0f b6 00             	movzbl (%eax),%eax
c0100c0c:	0f be c0             	movsbl %al,%eax
c0100c0f:	83 ec 08             	sub    $0x8,%esp
c0100c12:	50                   	push   %eax
c0100c13:	68 78 5f 10 c0       	push   $0xc0105f78
c0100c18:	e8 50 47 00 00       	call   c010536d <strchr>
c0100c1d:	83 c4 10             	add    $0x10,%esp
c0100c20:	85 c0                	test   %eax,%eax
c0100c22:	74 d4                	je     c0100bf8 <parse+0x85>
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
c0100c24:	e9 69 ff ff ff       	jmp    c0100b92 <parse+0x1f>
            break;
c0100c29:	90                   	nop
        }
    }
    return argc;
c0100c2a:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
c0100c2d:	c9                   	leave  
c0100c2e:	c3                   	ret    

c0100c2f <runcmd>:
/* *
 * runcmd - parse the input string, split it into separated arguments
 * and then lookup and invoke some related commands/
 * */
static int
runcmd(char *buf, struct trapframe *tf) {
c0100c2f:	f3 0f 1e fb          	endbr32 
c0100c33:	55                   	push   %ebp
c0100c34:	89 e5                	mov    %esp,%ebp
c0100c36:	83 ec 58             	sub    $0x58,%esp
    char *argv[MAXARGS];
    int argc = parse(buf, argv);
c0100c39:	83 ec 08             	sub    $0x8,%esp
c0100c3c:	8d 45 b0             	lea    -0x50(%ebp),%eax
c0100c3f:	50                   	push   %eax
c0100c40:	ff 75 08             	pushl  0x8(%ebp)
c0100c43:	e8 2b ff ff ff       	call   c0100b73 <parse>
c0100c48:	83 c4 10             	add    $0x10,%esp
c0100c4b:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if (argc == 0) {
c0100c4e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
c0100c52:	75 0a                	jne    c0100c5e <runcmd+0x2f>
        return 0;
c0100c54:	b8 00 00 00 00       	mov    $0x0,%eax
c0100c59:	e9 83 00 00 00       	jmp    c0100ce1 <runcmd+0xb2>
    }
    int i;
    for (i = 0; i < NCOMMANDS; i ++) {
c0100c5e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
c0100c65:	eb 59                	jmp    c0100cc0 <runcmd+0x91>
        if (strcmp(commands[i].name, argv[0]) == 0) {
c0100c67:	8b 4d b0             	mov    -0x50(%ebp),%ecx
c0100c6a:	8b 55 f4             	mov    -0xc(%ebp),%edx
c0100c6d:	89 d0                	mov    %edx,%eax
c0100c6f:	01 c0                	add    %eax,%eax
c0100c71:	01 d0                	add    %edx,%eax
c0100c73:	c1 e0 02             	shl    $0x2,%eax
c0100c76:	05 20 90 11 c0       	add    $0xc0119020,%eax
c0100c7b:	8b 00                	mov    (%eax),%eax
c0100c7d:	83 ec 08             	sub    $0x8,%esp
c0100c80:	51                   	push   %ecx
c0100c81:	50                   	push   %eax
c0100c82:	e8 3f 46 00 00       	call   c01052c6 <strcmp>
c0100c87:	83 c4 10             	add    $0x10,%esp
c0100c8a:	85 c0                	test   %eax,%eax
c0100c8c:	75 2e                	jne    c0100cbc <runcmd+0x8d>
            return commands[i].func(argc - 1, argv + 1, tf);
c0100c8e:	8b 55 f4             	mov    -0xc(%ebp),%edx
c0100c91:	89 d0                	mov    %edx,%eax
c0100c93:	01 c0                	add    %eax,%eax
c0100c95:	01 d0                	add    %edx,%eax
c0100c97:	c1 e0 02             	shl    $0x2,%eax
c0100c9a:	05 28 90 11 c0       	add    $0xc0119028,%eax
c0100c9f:	8b 10                	mov    (%eax),%edx
c0100ca1:	8d 45 b0             	lea    -0x50(%ebp),%eax
c0100ca4:	83 c0 04             	add    $0x4,%eax
c0100ca7:	8b 4d f0             	mov    -0x10(%ebp),%ecx
c0100caa:	83 e9 01             	sub    $0x1,%ecx
c0100cad:	83 ec 04             	sub    $0x4,%esp
c0100cb0:	ff 75 0c             	pushl  0xc(%ebp)
c0100cb3:	50                   	push   %eax
c0100cb4:	51                   	push   %ecx
c0100cb5:	ff d2                	call   *%edx
c0100cb7:	83 c4 10             	add    $0x10,%esp
c0100cba:	eb 25                	jmp    c0100ce1 <runcmd+0xb2>
    for (i = 0; i < NCOMMANDS; i ++) {
c0100cbc:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
c0100cc0:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0100cc3:	83 f8 02             	cmp    $0x2,%eax
c0100cc6:	76 9f                	jbe    c0100c67 <runcmd+0x38>
        }
    }
    cprintf("Unknown command '%s'\n", argv[0]);
c0100cc8:	8b 45 b0             	mov    -0x50(%ebp),%eax
c0100ccb:	83 ec 08             	sub    $0x8,%esp
c0100cce:	50                   	push   %eax
c0100ccf:	68 9b 5f 10 c0       	push   $0xc0105f9b
c0100cd4:	e8 b6 f5 ff ff       	call   c010028f <cprintf>
c0100cd9:	83 c4 10             	add    $0x10,%esp
    return 0;
c0100cdc:	b8 00 00 00 00       	mov    $0x0,%eax
}
c0100ce1:	c9                   	leave  
c0100ce2:	c3                   	ret    

c0100ce3 <kmonitor>:

/***** Implementations of basic kernel monitor commands *****/

void
kmonitor(struct trapframe *tf) {
c0100ce3:	f3 0f 1e fb          	endbr32 
c0100ce7:	55                   	push   %ebp
c0100ce8:	89 e5                	mov    %esp,%ebp
c0100cea:	83 ec 18             	sub    $0x18,%esp
    cprintf("Welcome to the kernel debug monitor!!\n");
c0100ced:	83 ec 0c             	sub    $0xc,%esp
c0100cf0:	68 b4 5f 10 c0       	push   $0xc0105fb4
c0100cf5:	e8 95 f5 ff ff       	call   c010028f <cprintf>
c0100cfa:	83 c4 10             	add    $0x10,%esp
    cprintf("Type 'help' for a list of commands.\n");
c0100cfd:	83 ec 0c             	sub    $0xc,%esp
c0100d00:	68 dc 5f 10 c0       	push   $0xc0105fdc
c0100d05:	e8 85 f5 ff ff       	call   c010028f <cprintf>
c0100d0a:	83 c4 10             	add    $0x10,%esp

    if (tf != NULL) {
c0100d0d:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
c0100d11:	74 0e                	je     c0100d21 <kmonitor+0x3e>
        print_trapframe(tf);
c0100d13:	83 ec 0c             	sub    $0xc,%esp
c0100d16:	ff 75 08             	pushl  0x8(%ebp)
c0100d19:	e8 4e 0e 00 00       	call   c0101b6c <print_trapframe>
c0100d1e:	83 c4 10             	add    $0x10,%esp
    }

    char *buf;
    while (1) {
        if ((buf = readline("K> ")) != NULL) {
c0100d21:	83 ec 0c             	sub    $0xc,%esp
c0100d24:	68 01 60 10 c0       	push   $0xc0106001
c0100d29:	e8 16 f6 ff ff       	call   c0100344 <readline>
c0100d2e:	83 c4 10             	add    $0x10,%esp
c0100d31:	89 45 f4             	mov    %eax,-0xc(%ebp)
c0100d34:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
c0100d38:	74 e7                	je     c0100d21 <kmonitor+0x3e>
            if (runcmd(buf, tf) < 0) {
c0100d3a:	83 ec 08             	sub    $0x8,%esp
c0100d3d:	ff 75 08             	pushl  0x8(%ebp)
c0100d40:	ff 75 f4             	pushl  -0xc(%ebp)
c0100d43:	e8 e7 fe ff ff       	call   c0100c2f <runcmd>
c0100d48:	83 c4 10             	add    $0x10,%esp
c0100d4b:	85 c0                	test   %eax,%eax
c0100d4d:	78 02                	js     c0100d51 <kmonitor+0x6e>
        if ((buf = readline("K> ")) != NULL) {
c0100d4f:	eb d0                	jmp    c0100d21 <kmonitor+0x3e>
                break;
c0100d51:	90                   	nop
            }
        }
    }
}
c0100d52:	90                   	nop
c0100d53:	c9                   	leave  
c0100d54:	c3                   	ret    

c0100d55 <mon_help>:

/* mon_help - print the information about mon_* functions */
int
mon_help(int argc, char **argv, struct trapframe *tf) {
c0100d55:	f3 0f 1e fb          	endbr32 
c0100d59:	55                   	push   %ebp
c0100d5a:	89 e5                	mov    %esp,%ebp
c0100d5c:	83 ec 18             	sub    $0x18,%esp
    int i;
    for (i = 0; i < NCOMMANDS; i ++) {
c0100d5f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
c0100d66:	eb 3c                	jmp    c0100da4 <mon_help+0x4f>
        cprintf("%s - %s\n", commands[i].name, commands[i].desc);
c0100d68:	8b 55 f4             	mov    -0xc(%ebp),%edx
c0100d6b:	89 d0                	mov    %edx,%eax
c0100d6d:	01 c0                	add    %eax,%eax
c0100d6f:	01 d0                	add    %edx,%eax
c0100d71:	c1 e0 02             	shl    $0x2,%eax
c0100d74:	05 24 90 11 c0       	add    $0xc0119024,%eax
c0100d79:	8b 08                	mov    (%eax),%ecx
c0100d7b:	8b 55 f4             	mov    -0xc(%ebp),%edx
c0100d7e:	89 d0                	mov    %edx,%eax
c0100d80:	01 c0                	add    %eax,%eax
c0100d82:	01 d0                	add    %edx,%eax
c0100d84:	c1 e0 02             	shl    $0x2,%eax
c0100d87:	05 20 90 11 c0       	add    $0xc0119020,%eax
c0100d8c:	8b 00                	mov    (%eax),%eax
c0100d8e:	83 ec 04             	sub    $0x4,%esp
c0100d91:	51                   	push   %ecx
c0100d92:	50                   	push   %eax
c0100d93:	68 05 60 10 c0       	push   $0xc0106005
c0100d98:	e8 f2 f4 ff ff       	call   c010028f <cprintf>
c0100d9d:	83 c4 10             	add    $0x10,%esp
    for (i = 0; i < NCOMMANDS; i ++) {
c0100da0:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
c0100da4:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0100da7:	83 f8 02             	cmp    $0x2,%eax
c0100daa:	76 bc                	jbe    c0100d68 <mon_help+0x13>
    }
    return 0;
c0100dac:	b8 00 00 00 00       	mov    $0x0,%eax
}
c0100db1:	c9                   	leave  
c0100db2:	c3                   	ret    

c0100db3 <mon_kerninfo>:
/* *
 * mon_kerninfo - call print_kerninfo in kern/debug/kdebug.c to
 * print the memory occupancy in kernel.
 * */
int
mon_kerninfo(int argc, char **argv, struct trapframe *tf) {
c0100db3:	f3 0f 1e fb          	endbr32 
c0100db7:	55                   	push   %ebp
c0100db8:	89 e5                	mov    %esp,%ebp
c0100dba:	83 ec 08             	sub    $0x8,%esp
    print_kerninfo();
c0100dbd:	e8 74 fb ff ff       	call   c0100936 <print_kerninfo>
    return 0;
c0100dc2:	b8 00 00 00 00       	mov    $0x0,%eax
}
c0100dc7:	c9                   	leave  
c0100dc8:	c3                   	ret    

c0100dc9 <mon_backtrace>:
/* *
 * mon_backtrace - call print_stackframe in kern/debug/kdebug.c to
 * print a backtrace of the stack.
 * */
int
mon_backtrace(int argc, char **argv, struct trapframe *tf) {
c0100dc9:	f3 0f 1e fb          	endbr32 
c0100dcd:	55                   	push   %ebp
c0100dce:	89 e5                	mov    %esp,%ebp
c0100dd0:	83 ec 08             	sub    $0x8,%esp
    print_stackframe();
c0100dd3:	e8 b2 fc ff ff       	call   c0100a8a <print_stackframe>
    return 0;
c0100dd8:	b8 00 00 00 00       	mov    $0x0,%eax
}
c0100ddd:	c9                   	leave  
c0100dde:	c3                   	ret    

c0100ddf <clock_init>:
/* *
 * clock_init - initialize 8253 clock to interrupt 100 times per second,
 * and then enable IRQ_TIMER.
 * */
void
clock_init(void) {
c0100ddf:	f3 0f 1e fb          	endbr32 
c0100de3:	55                   	push   %ebp
c0100de4:	89 e5                	mov    %esp,%ebp
c0100de6:	83 ec 18             	sub    $0x18,%esp
c0100de9:	66 c7 45 ee 43 00    	movw   $0x43,-0x12(%ebp)
c0100def:	c6 45 ed 34          	movb   $0x34,-0x13(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c0100df3:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
c0100df7:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
c0100dfb:	ee                   	out    %al,(%dx)
}
c0100dfc:	90                   	nop
c0100dfd:	66 c7 45 f2 40 00    	movw   $0x40,-0xe(%ebp)
c0100e03:	c6 45 f1 9c          	movb   $0x9c,-0xf(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c0100e07:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
c0100e0b:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
c0100e0f:	ee                   	out    %al,(%dx)
}
c0100e10:	90                   	nop
c0100e11:	66 c7 45 f6 40 00    	movw   $0x40,-0xa(%ebp)
c0100e17:	c6 45 f5 2e          	movb   $0x2e,-0xb(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c0100e1b:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
c0100e1f:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
c0100e23:	ee                   	out    %al,(%dx)
}
c0100e24:	90                   	nop
    outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
    outb(IO_TIMER1, TIMER_DIV(100) % 256);
    outb(IO_TIMER1, TIMER_DIV(100) / 256);

    // initialize time counter 'ticks' to zero
    ticks = 0;
c0100e25:	c7 05 4c a9 11 c0 00 	movl   $0x0,0xc011a94c
c0100e2c:	00 00 00 

    cprintf("++ setup timer interrupts\n");
c0100e2f:	83 ec 0c             	sub    $0xc,%esp
c0100e32:	68 0e 60 10 c0       	push   $0xc010600e
c0100e37:	e8 53 f4 ff ff       	call   c010028f <cprintf>
c0100e3c:	83 c4 10             	add    $0x10,%esp
    pic_enable(IRQ_TIMER);
c0100e3f:	83 ec 0c             	sub    $0xc,%esp
c0100e42:	6a 00                	push   $0x0
c0100e44:	e8 a6 09 00 00       	call   c01017ef <pic_enable>
c0100e49:	83 c4 10             	add    $0x10,%esp
}
c0100e4c:	90                   	nop
c0100e4d:	c9                   	leave  
c0100e4e:	c3                   	ret    

c0100e4f <__intr_save>:
#include <x86.h>
#include <intr.h>
#include <mmu.h>

static inline bool
__intr_save(void) {
c0100e4f:	55                   	push   %ebp
c0100e50:	89 e5                	mov    %esp,%ebp
c0100e52:	83 ec 18             	sub    $0x18,%esp
}

static inline uint32_t
read_eflags(void) {
    uint32_t eflags;
    asm volatile ("pushfl; popl %0" : "=r" (eflags));
c0100e55:	9c                   	pushf  
c0100e56:	58                   	pop    %eax
c0100e57:	89 45 f4             	mov    %eax,-0xc(%ebp)
    return eflags;
c0100e5a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    if (read_eflags() & FL_IF) {
c0100e5d:	25 00 02 00 00       	and    $0x200,%eax
c0100e62:	85 c0                	test   %eax,%eax
c0100e64:	74 0c                	je     c0100e72 <__intr_save+0x23>
        intr_disable();
c0100e66:	e8 10 0b 00 00       	call   c010197b <intr_disable>
        return 1;
c0100e6b:	b8 01 00 00 00       	mov    $0x1,%eax
c0100e70:	eb 05                	jmp    c0100e77 <__intr_save+0x28>
    }
    return 0;
c0100e72:	b8 00 00 00 00       	mov    $0x0,%eax
}
c0100e77:	c9                   	leave  
c0100e78:	c3                   	ret    

c0100e79 <__intr_restore>:

static inline void
__intr_restore(bool flag) {
c0100e79:	55                   	push   %ebp
c0100e7a:	89 e5                	mov    %esp,%ebp
c0100e7c:	83 ec 08             	sub    $0x8,%esp
    if (flag) {
c0100e7f:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
c0100e83:	74 05                	je     c0100e8a <__intr_restore+0x11>
        intr_enable();
c0100e85:	e8 e5 0a 00 00       	call   c010196f <intr_enable>
    }
}
c0100e8a:	90                   	nop
c0100e8b:	c9                   	leave  
c0100e8c:	c3                   	ret    

c0100e8d <delay>:
#include <memlayout.h>
#include <sync.h>

/* stupid I/O delay routine necessitated by historical PC design flaws */
static void
delay(void) {
c0100e8d:	f3 0f 1e fb          	endbr32 
c0100e91:	55                   	push   %ebp
c0100e92:	89 e5                	mov    %esp,%ebp
c0100e94:	83 ec 10             	sub    $0x10,%esp
c0100e97:	66 c7 45 f2 84 00    	movw   $0x84,-0xe(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port) : "memory");
c0100e9d:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
c0100ea1:	89 c2                	mov    %eax,%edx
c0100ea3:	ec                   	in     (%dx),%al
c0100ea4:	88 45 f1             	mov    %al,-0xf(%ebp)
c0100ea7:	66 c7 45 f6 84 00    	movw   $0x84,-0xa(%ebp)
c0100ead:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
c0100eb1:	89 c2                	mov    %eax,%edx
c0100eb3:	ec                   	in     (%dx),%al
c0100eb4:	88 45 f5             	mov    %al,-0xb(%ebp)
c0100eb7:	66 c7 45 fa 84 00    	movw   $0x84,-0x6(%ebp)
c0100ebd:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
c0100ec1:	89 c2                	mov    %eax,%edx
c0100ec3:	ec                   	in     (%dx),%al
c0100ec4:	88 45 f9             	mov    %al,-0x7(%ebp)
c0100ec7:	66 c7 45 fe 84 00    	movw   $0x84,-0x2(%ebp)
c0100ecd:	0f b7 45 fe          	movzwl -0x2(%ebp),%eax
c0100ed1:	89 c2                	mov    %eax,%edx
c0100ed3:	ec                   	in     (%dx),%al
c0100ed4:	88 45 fd             	mov    %al,-0x3(%ebp)
    inb(0x84);
    inb(0x84);
    inb(0x84);
    inb(0x84);
}
c0100ed7:	90                   	nop
c0100ed8:	c9                   	leave  
c0100ed9:	c3                   	ret    

c0100eda <cga_init>:
static uint16_t addr_6845;

/* TEXT-mode CGA/VGA display output */

static void
cga_init(void) {
c0100eda:	f3 0f 1e fb          	endbr32 
c0100ede:	55                   	push   %ebp
c0100edf:	89 e5                	mov    %esp,%ebp
c0100ee1:	83 ec 20             	sub    $0x20,%esp
    volatile uint16_t *cp = (uint16_t *)(CGA_BUF + KERNBASE);
c0100ee4:	c7 45 fc 00 80 0b c0 	movl   $0xc00b8000,-0x4(%ebp)
    uint16_t was = *cp;
c0100eeb:	8b 45 fc             	mov    -0x4(%ebp),%eax
c0100eee:	0f b7 00             	movzwl (%eax),%eax
c0100ef1:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
    *cp = (uint16_t) 0xA55A;
c0100ef5:	8b 45 fc             	mov    -0x4(%ebp),%eax
c0100ef8:	66 c7 00 5a a5       	movw   $0xa55a,(%eax)
    if (*cp != 0xA55A) {
c0100efd:	8b 45 fc             	mov    -0x4(%ebp),%eax
c0100f00:	0f b7 00             	movzwl (%eax),%eax
c0100f03:	66 3d 5a a5          	cmp    $0xa55a,%ax
c0100f07:	74 12                	je     c0100f1b <cga_init+0x41>
        cp = (uint16_t*)(MONO_BUF + KERNBASE);
c0100f09:	c7 45 fc 00 00 0b c0 	movl   $0xc00b0000,-0x4(%ebp)
        addr_6845 = MONO_BASE;
c0100f10:	66 c7 05 86 9e 11 c0 	movw   $0x3b4,0xc0119e86
c0100f17:	b4 03 
c0100f19:	eb 13                	jmp    c0100f2e <cga_init+0x54>
    } else {
        *cp = was;
c0100f1b:	8b 45 fc             	mov    -0x4(%ebp),%eax
c0100f1e:	0f b7 55 fa          	movzwl -0x6(%ebp),%edx
c0100f22:	66 89 10             	mov    %dx,(%eax)
        addr_6845 = CGA_BASE;
c0100f25:	66 c7 05 86 9e 11 c0 	movw   $0x3d4,0xc0119e86
c0100f2c:	d4 03 
    }

    // Extract cursor location
    uint32_t pos;
    outb(addr_6845, 14);
c0100f2e:	0f b7 05 86 9e 11 c0 	movzwl 0xc0119e86,%eax
c0100f35:	0f b7 c0             	movzwl %ax,%eax
c0100f38:	66 89 45 e6          	mov    %ax,-0x1a(%ebp)
c0100f3c:	c6 45 e5 0e          	movb   $0xe,-0x1b(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c0100f40:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
c0100f44:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
c0100f48:	ee                   	out    %al,(%dx)
}
c0100f49:	90                   	nop
    pos = inb(addr_6845 + 1) << 8;
c0100f4a:	0f b7 05 86 9e 11 c0 	movzwl 0xc0119e86,%eax
c0100f51:	83 c0 01             	add    $0x1,%eax
c0100f54:	0f b7 c0             	movzwl %ax,%eax
c0100f57:	66 89 45 ea          	mov    %ax,-0x16(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port) : "memory");
c0100f5b:	0f b7 45 ea          	movzwl -0x16(%ebp),%eax
c0100f5f:	89 c2                	mov    %eax,%edx
c0100f61:	ec                   	in     (%dx),%al
c0100f62:	88 45 e9             	mov    %al,-0x17(%ebp)
    return data;
c0100f65:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
c0100f69:	0f b6 c0             	movzbl %al,%eax
c0100f6c:	c1 e0 08             	shl    $0x8,%eax
c0100f6f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    outb(addr_6845, 15);
c0100f72:	0f b7 05 86 9e 11 c0 	movzwl 0xc0119e86,%eax
c0100f79:	0f b7 c0             	movzwl %ax,%eax
c0100f7c:	66 89 45 ee          	mov    %ax,-0x12(%ebp)
c0100f80:	c6 45 ed 0f          	movb   $0xf,-0x13(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c0100f84:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
c0100f88:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
c0100f8c:	ee                   	out    %al,(%dx)
}
c0100f8d:	90                   	nop
    pos |= inb(addr_6845 + 1);
c0100f8e:	0f b7 05 86 9e 11 c0 	movzwl 0xc0119e86,%eax
c0100f95:	83 c0 01             	add    $0x1,%eax
c0100f98:	0f b7 c0             	movzwl %ax,%eax
c0100f9b:	66 89 45 f2          	mov    %ax,-0xe(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port) : "memory");
c0100f9f:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
c0100fa3:	89 c2                	mov    %eax,%edx
c0100fa5:	ec                   	in     (%dx),%al
c0100fa6:	88 45 f1             	mov    %al,-0xf(%ebp)
    return data;
c0100fa9:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
c0100fad:	0f b6 c0             	movzbl %al,%eax
c0100fb0:	09 45 f4             	or     %eax,-0xc(%ebp)

    crt_buf = (uint16_t*) cp;
c0100fb3:	8b 45 fc             	mov    -0x4(%ebp),%eax
c0100fb6:	a3 80 9e 11 c0       	mov    %eax,0xc0119e80
    crt_pos = pos;
c0100fbb:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0100fbe:	66 a3 84 9e 11 c0    	mov    %ax,0xc0119e84
}
c0100fc4:	90                   	nop
c0100fc5:	c9                   	leave  
c0100fc6:	c3                   	ret    

c0100fc7 <serial_init>:

static bool serial_exists = 0;

static void
serial_init(void) {
c0100fc7:	f3 0f 1e fb          	endbr32 
c0100fcb:	55                   	push   %ebp
c0100fcc:	89 e5                	mov    %esp,%ebp
c0100fce:	83 ec 38             	sub    $0x38,%esp
c0100fd1:	66 c7 45 d2 fa 03    	movw   $0x3fa,-0x2e(%ebp)
c0100fd7:	c6 45 d1 00          	movb   $0x0,-0x2f(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c0100fdb:	0f b6 45 d1          	movzbl -0x2f(%ebp),%eax
c0100fdf:	0f b7 55 d2          	movzwl -0x2e(%ebp),%edx
c0100fe3:	ee                   	out    %al,(%dx)
}
c0100fe4:	90                   	nop
c0100fe5:	66 c7 45 d6 fb 03    	movw   $0x3fb,-0x2a(%ebp)
c0100feb:	c6 45 d5 80          	movb   $0x80,-0x2b(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c0100fef:	0f b6 45 d5          	movzbl -0x2b(%ebp),%eax
c0100ff3:	0f b7 55 d6          	movzwl -0x2a(%ebp),%edx
c0100ff7:	ee                   	out    %al,(%dx)
}
c0100ff8:	90                   	nop
c0100ff9:	66 c7 45 da f8 03    	movw   $0x3f8,-0x26(%ebp)
c0100fff:	c6 45 d9 0c          	movb   $0xc,-0x27(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c0101003:	0f b6 45 d9          	movzbl -0x27(%ebp),%eax
c0101007:	0f b7 55 da          	movzwl -0x26(%ebp),%edx
c010100b:	ee                   	out    %al,(%dx)
}
c010100c:	90                   	nop
c010100d:	66 c7 45 de f9 03    	movw   $0x3f9,-0x22(%ebp)
c0101013:	c6 45 dd 00          	movb   $0x0,-0x23(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c0101017:	0f b6 45 dd          	movzbl -0x23(%ebp),%eax
c010101b:	0f b7 55 de          	movzwl -0x22(%ebp),%edx
c010101f:	ee                   	out    %al,(%dx)
}
c0101020:	90                   	nop
c0101021:	66 c7 45 e2 fb 03    	movw   $0x3fb,-0x1e(%ebp)
c0101027:	c6 45 e1 03          	movb   $0x3,-0x1f(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c010102b:	0f b6 45 e1          	movzbl -0x1f(%ebp),%eax
c010102f:	0f b7 55 e2          	movzwl -0x1e(%ebp),%edx
c0101033:	ee                   	out    %al,(%dx)
}
c0101034:	90                   	nop
c0101035:	66 c7 45 e6 fc 03    	movw   $0x3fc,-0x1a(%ebp)
c010103b:	c6 45 e5 00          	movb   $0x0,-0x1b(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c010103f:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
c0101043:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
c0101047:	ee                   	out    %al,(%dx)
}
c0101048:	90                   	nop
c0101049:	66 c7 45 ea f9 03    	movw   $0x3f9,-0x16(%ebp)
c010104f:	c6 45 e9 01          	movb   $0x1,-0x17(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c0101053:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
c0101057:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
c010105b:	ee                   	out    %al,(%dx)
}
c010105c:	90                   	nop
c010105d:	66 c7 45 ee fd 03    	movw   $0x3fd,-0x12(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port) : "memory");
c0101063:	0f b7 45 ee          	movzwl -0x12(%ebp),%eax
c0101067:	89 c2                	mov    %eax,%edx
c0101069:	ec                   	in     (%dx),%al
c010106a:	88 45 ed             	mov    %al,-0x13(%ebp)
    return data;
c010106d:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
    // Enable rcv interrupts
    outb(COM1 + COM_IER, COM_IER_RDI);

    // Clear any preexisting overrun indications and interrupts
    // Serial port doesn't exist if COM_LSR returns 0xFF
    serial_exists = (inb(COM1 + COM_LSR) != 0xFF);
c0101071:	3c ff                	cmp    $0xff,%al
c0101073:	0f 95 c0             	setne  %al
c0101076:	0f b6 c0             	movzbl %al,%eax
c0101079:	a3 88 9e 11 c0       	mov    %eax,0xc0119e88
c010107e:	66 c7 45 f2 fa 03    	movw   $0x3fa,-0xe(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port) : "memory");
c0101084:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
c0101088:	89 c2                	mov    %eax,%edx
c010108a:	ec                   	in     (%dx),%al
c010108b:	88 45 f1             	mov    %al,-0xf(%ebp)
c010108e:	66 c7 45 f6 f8 03    	movw   $0x3f8,-0xa(%ebp)
c0101094:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
c0101098:	89 c2                	mov    %eax,%edx
c010109a:	ec                   	in     (%dx),%al
c010109b:	88 45 f5             	mov    %al,-0xb(%ebp)
    (void) inb(COM1+COM_IIR);
    (void) inb(COM1+COM_RX);

    if (serial_exists) {
c010109e:	a1 88 9e 11 c0       	mov    0xc0119e88,%eax
c01010a3:	85 c0                	test   %eax,%eax
c01010a5:	74 0d                	je     c01010b4 <serial_init+0xed>
        pic_enable(IRQ_COM1);
c01010a7:	83 ec 0c             	sub    $0xc,%esp
c01010aa:	6a 04                	push   $0x4
c01010ac:	e8 3e 07 00 00       	call   c01017ef <pic_enable>
c01010b1:	83 c4 10             	add    $0x10,%esp
    }
}
c01010b4:	90                   	nop
c01010b5:	c9                   	leave  
c01010b6:	c3                   	ret    

c01010b7 <lpt_putc_sub>:

static void
lpt_putc_sub(int c) {
c01010b7:	f3 0f 1e fb          	endbr32 
c01010bb:	55                   	push   %ebp
c01010bc:	89 e5                	mov    %esp,%ebp
c01010be:	83 ec 20             	sub    $0x20,%esp
    int i;
    for (i = 0; !(inb(LPTPORT + 1) & 0x80) && i < 12800; i ++) {
c01010c1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
c01010c8:	eb 09                	jmp    c01010d3 <lpt_putc_sub+0x1c>
        delay();
c01010ca:	e8 be fd ff ff       	call   c0100e8d <delay>
    for (i = 0; !(inb(LPTPORT + 1) & 0x80) && i < 12800; i ++) {
c01010cf:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
c01010d3:	66 c7 45 fa 79 03    	movw   $0x379,-0x6(%ebp)
c01010d9:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
c01010dd:	89 c2                	mov    %eax,%edx
c01010df:	ec                   	in     (%dx),%al
c01010e0:	88 45 f9             	mov    %al,-0x7(%ebp)
    return data;
c01010e3:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
c01010e7:	84 c0                	test   %al,%al
c01010e9:	78 09                	js     c01010f4 <lpt_putc_sub+0x3d>
c01010eb:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%ebp)
c01010f2:	7e d6                	jle    c01010ca <lpt_putc_sub+0x13>
    }
    outb(LPTPORT + 0, c);
c01010f4:	8b 45 08             	mov    0x8(%ebp),%eax
c01010f7:	0f b6 c0             	movzbl %al,%eax
c01010fa:	66 c7 45 ee 78 03    	movw   $0x378,-0x12(%ebp)
c0101100:	88 45 ed             	mov    %al,-0x13(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c0101103:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
c0101107:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
c010110b:	ee                   	out    %al,(%dx)
}
c010110c:	90                   	nop
c010110d:	66 c7 45 f2 7a 03    	movw   $0x37a,-0xe(%ebp)
c0101113:	c6 45 f1 0d          	movb   $0xd,-0xf(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c0101117:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
c010111b:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
c010111f:	ee                   	out    %al,(%dx)
}
c0101120:	90                   	nop
c0101121:	66 c7 45 f6 7a 03    	movw   $0x37a,-0xa(%ebp)
c0101127:	c6 45 f5 08          	movb   $0x8,-0xb(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c010112b:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
c010112f:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
c0101133:	ee                   	out    %al,(%dx)
}
c0101134:	90                   	nop
    outb(LPTPORT + 2, 0x08 | 0x04 | 0x01);
    outb(LPTPORT + 2, 0x08);
}
c0101135:	90                   	nop
c0101136:	c9                   	leave  
c0101137:	c3                   	ret    

c0101138 <lpt_putc>:

/* lpt_putc - copy console output to parallel port */
static void
lpt_putc(int c) {
c0101138:	f3 0f 1e fb          	endbr32 
c010113c:	55                   	push   %ebp
c010113d:	89 e5                	mov    %esp,%ebp
    if (c != '\b') {
c010113f:	83 7d 08 08          	cmpl   $0x8,0x8(%ebp)
c0101143:	74 0d                	je     c0101152 <lpt_putc+0x1a>
        lpt_putc_sub(c);
c0101145:	ff 75 08             	pushl  0x8(%ebp)
c0101148:	e8 6a ff ff ff       	call   c01010b7 <lpt_putc_sub>
c010114d:	83 c4 04             	add    $0x4,%esp
    else {
        lpt_putc_sub('\b');
        lpt_putc_sub(' ');
        lpt_putc_sub('\b');
    }
}
c0101150:	eb 1e                	jmp    c0101170 <lpt_putc+0x38>
        lpt_putc_sub('\b');
c0101152:	6a 08                	push   $0x8
c0101154:	e8 5e ff ff ff       	call   c01010b7 <lpt_putc_sub>
c0101159:	83 c4 04             	add    $0x4,%esp
        lpt_putc_sub(' ');
c010115c:	6a 20                	push   $0x20
c010115e:	e8 54 ff ff ff       	call   c01010b7 <lpt_putc_sub>
c0101163:	83 c4 04             	add    $0x4,%esp
        lpt_putc_sub('\b');
c0101166:	6a 08                	push   $0x8
c0101168:	e8 4a ff ff ff       	call   c01010b7 <lpt_putc_sub>
c010116d:	83 c4 04             	add    $0x4,%esp
}
c0101170:	90                   	nop
c0101171:	c9                   	leave  
c0101172:	c3                   	ret    

c0101173 <cga_putc>:

/* cga_putc - print character to console */
static void
cga_putc(int c) {
c0101173:	f3 0f 1e fb          	endbr32 
c0101177:	55                   	push   %ebp
c0101178:	89 e5                	mov    %esp,%ebp
c010117a:	53                   	push   %ebx
c010117b:	83 ec 24             	sub    $0x24,%esp
    // set black on white
    if (!(c & ~0xFF)) {
c010117e:	8b 45 08             	mov    0x8(%ebp),%eax
c0101181:	b0 00                	mov    $0x0,%al
c0101183:	85 c0                	test   %eax,%eax
c0101185:	75 07                	jne    c010118e <cga_putc+0x1b>
        c |= 0x0700;
c0101187:	81 4d 08 00 07 00 00 	orl    $0x700,0x8(%ebp)
    }

    switch (c & 0xff) {
c010118e:	8b 45 08             	mov    0x8(%ebp),%eax
c0101191:	0f b6 c0             	movzbl %al,%eax
c0101194:	83 f8 0d             	cmp    $0xd,%eax
c0101197:	74 6c                	je     c0101205 <cga_putc+0x92>
c0101199:	83 f8 0d             	cmp    $0xd,%eax
c010119c:	0f 8f 9d 00 00 00    	jg     c010123f <cga_putc+0xcc>
c01011a2:	83 f8 08             	cmp    $0x8,%eax
c01011a5:	74 0a                	je     c01011b1 <cga_putc+0x3e>
c01011a7:	83 f8 0a             	cmp    $0xa,%eax
c01011aa:	74 49                	je     c01011f5 <cga_putc+0x82>
c01011ac:	e9 8e 00 00 00       	jmp    c010123f <cga_putc+0xcc>
    case '\b':
        if (crt_pos > 0) {
c01011b1:	0f b7 05 84 9e 11 c0 	movzwl 0xc0119e84,%eax
c01011b8:	66 85 c0             	test   %ax,%ax
c01011bb:	0f 84 a4 00 00 00    	je     c0101265 <cga_putc+0xf2>
            crt_pos --;
c01011c1:	0f b7 05 84 9e 11 c0 	movzwl 0xc0119e84,%eax
c01011c8:	83 e8 01             	sub    $0x1,%eax
c01011cb:	66 a3 84 9e 11 c0    	mov    %ax,0xc0119e84
            crt_buf[crt_pos] = (c & ~0xff) | ' ';
c01011d1:	8b 45 08             	mov    0x8(%ebp),%eax
c01011d4:	b0 00                	mov    $0x0,%al
c01011d6:	83 c8 20             	or     $0x20,%eax
c01011d9:	89 c1                	mov    %eax,%ecx
c01011db:	a1 80 9e 11 c0       	mov    0xc0119e80,%eax
c01011e0:	0f b7 15 84 9e 11 c0 	movzwl 0xc0119e84,%edx
c01011e7:	0f b7 d2             	movzwl %dx,%edx
c01011ea:	01 d2                	add    %edx,%edx
c01011ec:	01 d0                	add    %edx,%eax
c01011ee:	89 ca                	mov    %ecx,%edx
c01011f0:	66 89 10             	mov    %dx,(%eax)
        }
        break;
c01011f3:	eb 70                	jmp    c0101265 <cga_putc+0xf2>
    case '\n':
        crt_pos += CRT_COLS;
c01011f5:	0f b7 05 84 9e 11 c0 	movzwl 0xc0119e84,%eax
c01011fc:	83 c0 50             	add    $0x50,%eax
c01011ff:	66 a3 84 9e 11 c0    	mov    %ax,0xc0119e84
    case '\r':
        crt_pos -= (crt_pos % CRT_COLS);
c0101205:	0f b7 1d 84 9e 11 c0 	movzwl 0xc0119e84,%ebx
c010120c:	0f b7 0d 84 9e 11 c0 	movzwl 0xc0119e84,%ecx
c0101213:	0f b7 c1             	movzwl %cx,%eax
c0101216:	69 c0 cd cc 00 00    	imul   $0xcccd,%eax,%eax
c010121c:	c1 e8 10             	shr    $0x10,%eax
c010121f:	89 c2                	mov    %eax,%edx
c0101221:	66 c1 ea 06          	shr    $0x6,%dx
c0101225:	89 d0                	mov    %edx,%eax
c0101227:	c1 e0 02             	shl    $0x2,%eax
c010122a:	01 d0                	add    %edx,%eax
c010122c:	c1 e0 04             	shl    $0x4,%eax
c010122f:	29 c1                	sub    %eax,%ecx
c0101231:	89 ca                	mov    %ecx,%edx
c0101233:	89 d8                	mov    %ebx,%eax
c0101235:	29 d0                	sub    %edx,%eax
c0101237:	66 a3 84 9e 11 c0    	mov    %ax,0xc0119e84
        break;
c010123d:	eb 27                	jmp    c0101266 <cga_putc+0xf3>
    default:
        crt_buf[crt_pos ++] = c;     // write the character
c010123f:	8b 0d 80 9e 11 c0    	mov    0xc0119e80,%ecx
c0101245:	0f b7 05 84 9e 11 c0 	movzwl 0xc0119e84,%eax
c010124c:	8d 50 01             	lea    0x1(%eax),%edx
c010124f:	66 89 15 84 9e 11 c0 	mov    %dx,0xc0119e84
c0101256:	0f b7 c0             	movzwl %ax,%eax
c0101259:	01 c0                	add    %eax,%eax
c010125b:	01 c8                	add    %ecx,%eax
c010125d:	8b 55 08             	mov    0x8(%ebp),%edx
c0101260:	66 89 10             	mov    %dx,(%eax)
        break;
c0101263:	eb 01                	jmp    c0101266 <cga_putc+0xf3>
        break;
c0101265:	90                   	nop
    }

    // What is the purpose of this?
    if (crt_pos >= CRT_SIZE) {
c0101266:	0f b7 05 84 9e 11 c0 	movzwl 0xc0119e84,%eax
c010126d:	66 3d cf 07          	cmp    $0x7cf,%ax
c0101271:	76 59                	jbe    c01012cc <cga_putc+0x159>
        int i;
        memmove(crt_buf, crt_buf + CRT_COLS, (CRT_SIZE - CRT_COLS) * sizeof(uint16_t));
c0101273:	a1 80 9e 11 c0       	mov    0xc0119e80,%eax
c0101278:	8d 90 a0 00 00 00    	lea    0xa0(%eax),%edx
c010127e:	a1 80 9e 11 c0       	mov    0xc0119e80,%eax
c0101283:	83 ec 04             	sub    $0x4,%esp
c0101286:	68 00 0f 00 00       	push   $0xf00
c010128b:	52                   	push   %edx
c010128c:	50                   	push   %eax
c010128d:	e8 e9 42 00 00       	call   c010557b <memmove>
c0101292:	83 c4 10             	add    $0x10,%esp
        for (i = CRT_SIZE - CRT_COLS; i < CRT_SIZE; i ++) {
c0101295:	c7 45 f4 80 07 00 00 	movl   $0x780,-0xc(%ebp)
c010129c:	eb 15                	jmp    c01012b3 <cga_putc+0x140>
            crt_buf[i] = 0x0700 | ' ';
c010129e:	a1 80 9e 11 c0       	mov    0xc0119e80,%eax
c01012a3:	8b 55 f4             	mov    -0xc(%ebp),%edx
c01012a6:	01 d2                	add    %edx,%edx
c01012a8:	01 d0                	add    %edx,%eax
c01012aa:	66 c7 00 20 07       	movw   $0x720,(%eax)
        for (i = CRT_SIZE - CRT_COLS; i < CRT_SIZE; i ++) {
c01012af:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
c01012b3:	81 7d f4 cf 07 00 00 	cmpl   $0x7cf,-0xc(%ebp)
c01012ba:	7e e2                	jle    c010129e <cga_putc+0x12b>
        }
        crt_pos -= CRT_COLS;
c01012bc:	0f b7 05 84 9e 11 c0 	movzwl 0xc0119e84,%eax
c01012c3:	83 e8 50             	sub    $0x50,%eax
c01012c6:	66 a3 84 9e 11 c0    	mov    %ax,0xc0119e84
    }

    // move that little blinky thing
    outb(addr_6845, 14);
c01012cc:	0f b7 05 86 9e 11 c0 	movzwl 0xc0119e86,%eax
c01012d3:	0f b7 c0             	movzwl %ax,%eax
c01012d6:	66 89 45 e6          	mov    %ax,-0x1a(%ebp)
c01012da:	c6 45 e5 0e          	movb   $0xe,-0x1b(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c01012de:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
c01012e2:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
c01012e6:	ee                   	out    %al,(%dx)
}
c01012e7:	90                   	nop
    outb(addr_6845 + 1, crt_pos >> 8);
c01012e8:	0f b7 05 84 9e 11 c0 	movzwl 0xc0119e84,%eax
c01012ef:	66 c1 e8 08          	shr    $0x8,%ax
c01012f3:	0f b6 c0             	movzbl %al,%eax
c01012f6:	0f b7 15 86 9e 11 c0 	movzwl 0xc0119e86,%edx
c01012fd:	83 c2 01             	add    $0x1,%edx
c0101300:	0f b7 d2             	movzwl %dx,%edx
c0101303:	66 89 55 ea          	mov    %dx,-0x16(%ebp)
c0101307:	88 45 e9             	mov    %al,-0x17(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c010130a:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
c010130e:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
c0101312:	ee                   	out    %al,(%dx)
}
c0101313:	90                   	nop
    outb(addr_6845, 15);
c0101314:	0f b7 05 86 9e 11 c0 	movzwl 0xc0119e86,%eax
c010131b:	0f b7 c0             	movzwl %ax,%eax
c010131e:	66 89 45 ee          	mov    %ax,-0x12(%ebp)
c0101322:	c6 45 ed 0f          	movb   $0xf,-0x13(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c0101326:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
c010132a:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
c010132e:	ee                   	out    %al,(%dx)
}
c010132f:	90                   	nop
    outb(addr_6845 + 1, crt_pos);
c0101330:	0f b7 05 84 9e 11 c0 	movzwl 0xc0119e84,%eax
c0101337:	0f b6 c0             	movzbl %al,%eax
c010133a:	0f b7 15 86 9e 11 c0 	movzwl 0xc0119e86,%edx
c0101341:	83 c2 01             	add    $0x1,%edx
c0101344:	0f b7 d2             	movzwl %dx,%edx
c0101347:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
c010134b:	88 45 f1             	mov    %al,-0xf(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c010134e:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
c0101352:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
c0101356:	ee                   	out    %al,(%dx)
}
c0101357:	90                   	nop
}
c0101358:	90                   	nop
c0101359:	8b 5d fc             	mov    -0x4(%ebp),%ebx
c010135c:	c9                   	leave  
c010135d:	c3                   	ret    

c010135e <serial_putc_sub>:

static void
serial_putc_sub(int c) {
c010135e:	f3 0f 1e fb          	endbr32 
c0101362:	55                   	push   %ebp
c0101363:	89 e5                	mov    %esp,%ebp
c0101365:	83 ec 10             	sub    $0x10,%esp
    int i;
    for (i = 0; !(inb(COM1 + COM_LSR) & COM_LSR_TXRDY) && i < 12800; i ++) {
c0101368:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
c010136f:	eb 09                	jmp    c010137a <serial_putc_sub+0x1c>
        delay();
c0101371:	e8 17 fb ff ff       	call   c0100e8d <delay>
    for (i = 0; !(inb(COM1 + COM_LSR) & COM_LSR_TXRDY) && i < 12800; i ++) {
c0101376:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
c010137a:	66 c7 45 fa fd 03    	movw   $0x3fd,-0x6(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port) : "memory");
c0101380:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
c0101384:	89 c2                	mov    %eax,%edx
c0101386:	ec                   	in     (%dx),%al
c0101387:	88 45 f9             	mov    %al,-0x7(%ebp)
    return data;
c010138a:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
c010138e:	0f b6 c0             	movzbl %al,%eax
c0101391:	83 e0 20             	and    $0x20,%eax
c0101394:	85 c0                	test   %eax,%eax
c0101396:	75 09                	jne    c01013a1 <serial_putc_sub+0x43>
c0101398:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%ebp)
c010139f:	7e d0                	jle    c0101371 <serial_putc_sub+0x13>
    }
    outb(COM1 + COM_TX, c);
c01013a1:	8b 45 08             	mov    0x8(%ebp),%eax
c01013a4:	0f b6 c0             	movzbl %al,%eax
c01013a7:	66 c7 45 f6 f8 03    	movw   $0x3f8,-0xa(%ebp)
c01013ad:	88 45 f5             	mov    %al,-0xb(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c01013b0:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
c01013b4:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
c01013b8:	ee                   	out    %al,(%dx)
}
c01013b9:	90                   	nop
}
c01013ba:	90                   	nop
c01013bb:	c9                   	leave  
c01013bc:	c3                   	ret    

c01013bd <serial_putc>:

/* serial_putc - print character to serial port */
static void
serial_putc(int c) {
c01013bd:	f3 0f 1e fb          	endbr32 
c01013c1:	55                   	push   %ebp
c01013c2:	89 e5                	mov    %esp,%ebp
    if (c != '\b') {
c01013c4:	83 7d 08 08          	cmpl   $0x8,0x8(%ebp)
c01013c8:	74 0d                	je     c01013d7 <serial_putc+0x1a>
        serial_putc_sub(c);
c01013ca:	ff 75 08             	pushl  0x8(%ebp)
c01013cd:	e8 8c ff ff ff       	call   c010135e <serial_putc_sub>
c01013d2:	83 c4 04             	add    $0x4,%esp
    else {
        serial_putc_sub('\b');
        serial_putc_sub(' ');
        serial_putc_sub('\b');
    }
}
c01013d5:	eb 1e                	jmp    c01013f5 <serial_putc+0x38>
        serial_putc_sub('\b');
c01013d7:	6a 08                	push   $0x8
c01013d9:	e8 80 ff ff ff       	call   c010135e <serial_putc_sub>
c01013de:	83 c4 04             	add    $0x4,%esp
        serial_putc_sub(' ');
c01013e1:	6a 20                	push   $0x20
c01013e3:	e8 76 ff ff ff       	call   c010135e <serial_putc_sub>
c01013e8:	83 c4 04             	add    $0x4,%esp
        serial_putc_sub('\b');
c01013eb:	6a 08                	push   $0x8
c01013ed:	e8 6c ff ff ff       	call   c010135e <serial_putc_sub>
c01013f2:	83 c4 04             	add    $0x4,%esp
}
c01013f5:	90                   	nop
c01013f6:	c9                   	leave  
c01013f7:	c3                   	ret    

c01013f8 <cons_intr>:
/* *
 * cons_intr - called by device interrupt routines to feed input
 * characters into the circular console input buffer.
 * */
static void
cons_intr(int (*proc)(void)) {
c01013f8:	f3 0f 1e fb          	endbr32 
c01013fc:	55                   	push   %ebp
c01013fd:	89 e5                	mov    %esp,%ebp
c01013ff:	83 ec 18             	sub    $0x18,%esp
    int c;
    while ((c = (*proc)()) != -1) {
c0101402:	eb 33                	jmp    c0101437 <cons_intr+0x3f>
        if (c != 0) {
c0101404:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
c0101408:	74 2d                	je     c0101437 <cons_intr+0x3f>
            cons.buf[cons.wpos ++] = c;
c010140a:	a1 a4 a0 11 c0       	mov    0xc011a0a4,%eax
c010140f:	8d 50 01             	lea    0x1(%eax),%edx
c0101412:	89 15 a4 a0 11 c0    	mov    %edx,0xc011a0a4
c0101418:	8b 55 f4             	mov    -0xc(%ebp),%edx
c010141b:	88 90 a0 9e 11 c0    	mov    %dl,-0x3fee6160(%eax)
            if (cons.wpos == CONSBUFSIZE) {
c0101421:	a1 a4 a0 11 c0       	mov    0xc011a0a4,%eax
c0101426:	3d 00 02 00 00       	cmp    $0x200,%eax
c010142b:	75 0a                	jne    c0101437 <cons_intr+0x3f>
                cons.wpos = 0;
c010142d:	c7 05 a4 a0 11 c0 00 	movl   $0x0,0xc011a0a4
c0101434:	00 00 00 
    while ((c = (*proc)()) != -1) {
c0101437:	8b 45 08             	mov    0x8(%ebp),%eax
c010143a:	ff d0                	call   *%eax
c010143c:	89 45 f4             	mov    %eax,-0xc(%ebp)
c010143f:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
c0101443:	75 bf                	jne    c0101404 <cons_intr+0xc>
            }
        }
    }
}
c0101445:	90                   	nop
c0101446:	90                   	nop
c0101447:	c9                   	leave  
c0101448:	c3                   	ret    

c0101449 <serial_proc_data>:

/* serial_proc_data - get data from serial port */
static int
serial_proc_data(void) {
c0101449:	f3 0f 1e fb          	endbr32 
c010144d:	55                   	push   %ebp
c010144e:	89 e5                	mov    %esp,%ebp
c0101450:	83 ec 10             	sub    $0x10,%esp
c0101453:	66 c7 45 fa fd 03    	movw   $0x3fd,-0x6(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port) : "memory");
c0101459:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
c010145d:	89 c2                	mov    %eax,%edx
c010145f:	ec                   	in     (%dx),%al
c0101460:	88 45 f9             	mov    %al,-0x7(%ebp)
    return data;
c0101463:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
    if (!(inb(COM1 + COM_LSR) & COM_LSR_DATA)) {
c0101467:	0f b6 c0             	movzbl %al,%eax
c010146a:	83 e0 01             	and    $0x1,%eax
c010146d:	85 c0                	test   %eax,%eax
c010146f:	75 07                	jne    c0101478 <serial_proc_data+0x2f>
        return -1;
c0101471:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
c0101476:	eb 2a                	jmp    c01014a2 <serial_proc_data+0x59>
c0101478:	66 c7 45 f6 f8 03    	movw   $0x3f8,-0xa(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port) : "memory");
c010147e:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
c0101482:	89 c2                	mov    %eax,%edx
c0101484:	ec                   	in     (%dx),%al
c0101485:	88 45 f5             	mov    %al,-0xb(%ebp)
    return data;
c0101488:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
    }
    int c = inb(COM1 + COM_RX);
c010148c:	0f b6 c0             	movzbl %al,%eax
c010148f:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (c == 127) {
c0101492:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%ebp)
c0101496:	75 07                	jne    c010149f <serial_proc_data+0x56>
        c = '\b';
c0101498:	c7 45 fc 08 00 00 00 	movl   $0x8,-0x4(%ebp)
    }
    return c;
c010149f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
c01014a2:	c9                   	leave  
c01014a3:	c3                   	ret    

c01014a4 <serial_intr>:

/* serial_intr - try to feed input characters from serial port */
void
serial_intr(void) {
c01014a4:	f3 0f 1e fb          	endbr32 
c01014a8:	55                   	push   %ebp
c01014a9:	89 e5                	mov    %esp,%ebp
c01014ab:	83 ec 08             	sub    $0x8,%esp
    if (serial_exists) {
c01014ae:	a1 88 9e 11 c0       	mov    0xc0119e88,%eax
c01014b3:	85 c0                	test   %eax,%eax
c01014b5:	74 10                	je     c01014c7 <serial_intr+0x23>
        cons_intr(serial_proc_data);
c01014b7:	83 ec 0c             	sub    $0xc,%esp
c01014ba:	68 49 14 10 c0       	push   $0xc0101449
c01014bf:	e8 34 ff ff ff       	call   c01013f8 <cons_intr>
c01014c4:	83 c4 10             	add    $0x10,%esp
    }
}
c01014c7:	90                   	nop
c01014c8:	c9                   	leave  
c01014c9:	c3                   	ret    

c01014ca <kbd_proc_data>:
 *
 * The kbd_proc_data() function gets data from the keyboard.
 * If we finish a character, return it, else 0. And return -1 if no data.
 * */
static int
kbd_proc_data(void) {
c01014ca:	f3 0f 1e fb          	endbr32 
c01014ce:	55                   	push   %ebp
c01014cf:	89 e5                	mov    %esp,%ebp
c01014d1:	83 ec 28             	sub    $0x28,%esp
c01014d4:	66 c7 45 f0 64 00    	movw   $0x64,-0x10(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port) : "memory");
c01014da:	0f b7 45 f0          	movzwl -0x10(%ebp),%eax
c01014de:	89 c2                	mov    %eax,%edx
c01014e0:	ec                   	in     (%dx),%al
c01014e1:	88 45 ef             	mov    %al,-0x11(%ebp)
    return data;
c01014e4:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    int c;
    uint8_t data;
    static uint32_t shift;

    if ((inb(KBSTATP) & KBS_DIB) == 0) {
c01014e8:	0f b6 c0             	movzbl %al,%eax
c01014eb:	83 e0 01             	and    $0x1,%eax
c01014ee:	85 c0                	test   %eax,%eax
c01014f0:	75 0a                	jne    c01014fc <kbd_proc_data+0x32>
        return -1;
c01014f2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
c01014f7:	e9 5e 01 00 00       	jmp    c010165a <kbd_proc_data+0x190>
c01014fc:	66 c7 45 ec 60 00    	movw   $0x60,-0x14(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port) : "memory");
c0101502:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
c0101506:	89 c2                	mov    %eax,%edx
c0101508:	ec                   	in     (%dx),%al
c0101509:	88 45 eb             	mov    %al,-0x15(%ebp)
    return data;
c010150c:	0f b6 45 eb          	movzbl -0x15(%ebp),%eax
    }

    data = inb(KBDATAP);
c0101510:	88 45 f3             	mov    %al,-0xd(%ebp)

    if (data == 0xE0) {
c0101513:	80 7d f3 e0          	cmpb   $0xe0,-0xd(%ebp)
c0101517:	75 17                	jne    c0101530 <kbd_proc_data+0x66>
        // E0 escape character
        shift |= E0ESC;
c0101519:	a1 a8 a0 11 c0       	mov    0xc011a0a8,%eax
c010151e:	83 c8 40             	or     $0x40,%eax
c0101521:	a3 a8 a0 11 c0       	mov    %eax,0xc011a0a8
        return 0;
c0101526:	b8 00 00 00 00       	mov    $0x0,%eax
c010152b:	e9 2a 01 00 00       	jmp    c010165a <kbd_proc_data+0x190>
    } else if (data & 0x80) {
c0101530:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
c0101534:	84 c0                	test   %al,%al
c0101536:	79 47                	jns    c010157f <kbd_proc_data+0xb5>
        // Key released
        data = (shift & E0ESC ? data : data & 0x7F);
c0101538:	a1 a8 a0 11 c0       	mov    0xc011a0a8,%eax
c010153d:	83 e0 40             	and    $0x40,%eax
c0101540:	85 c0                	test   %eax,%eax
c0101542:	75 09                	jne    c010154d <kbd_proc_data+0x83>
c0101544:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
c0101548:	83 e0 7f             	and    $0x7f,%eax
c010154b:	eb 04                	jmp    c0101551 <kbd_proc_data+0x87>
c010154d:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
c0101551:	88 45 f3             	mov    %al,-0xd(%ebp)
        shift &= ~(shiftcode[data] | E0ESC);
c0101554:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
c0101558:	0f b6 80 60 90 11 c0 	movzbl -0x3fee6fa0(%eax),%eax
c010155f:	83 c8 40             	or     $0x40,%eax
c0101562:	0f b6 c0             	movzbl %al,%eax
c0101565:	f7 d0                	not    %eax
c0101567:	89 c2                	mov    %eax,%edx
c0101569:	a1 a8 a0 11 c0       	mov    0xc011a0a8,%eax
c010156e:	21 d0                	and    %edx,%eax
c0101570:	a3 a8 a0 11 c0       	mov    %eax,0xc011a0a8
        return 0;
c0101575:	b8 00 00 00 00       	mov    $0x0,%eax
c010157a:	e9 db 00 00 00       	jmp    c010165a <kbd_proc_data+0x190>
    } else if (shift & E0ESC) {
c010157f:	a1 a8 a0 11 c0       	mov    0xc011a0a8,%eax
c0101584:	83 e0 40             	and    $0x40,%eax
c0101587:	85 c0                	test   %eax,%eax
c0101589:	74 11                	je     c010159c <kbd_proc_data+0xd2>
        // Last character was an E0 escape; or with 0x80
        data |= 0x80;
c010158b:	80 4d f3 80          	orb    $0x80,-0xd(%ebp)
        shift &= ~E0ESC;
c010158f:	a1 a8 a0 11 c0       	mov    0xc011a0a8,%eax
c0101594:	83 e0 bf             	and    $0xffffffbf,%eax
c0101597:	a3 a8 a0 11 c0       	mov    %eax,0xc011a0a8
    }

    shift |= shiftcode[data];
c010159c:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
c01015a0:	0f b6 80 60 90 11 c0 	movzbl -0x3fee6fa0(%eax),%eax
c01015a7:	0f b6 d0             	movzbl %al,%edx
c01015aa:	a1 a8 a0 11 c0       	mov    0xc011a0a8,%eax
c01015af:	09 d0                	or     %edx,%eax
c01015b1:	a3 a8 a0 11 c0       	mov    %eax,0xc011a0a8
    shift ^= togglecode[data];
c01015b6:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
c01015ba:	0f b6 80 60 91 11 c0 	movzbl -0x3fee6ea0(%eax),%eax
c01015c1:	0f b6 d0             	movzbl %al,%edx
c01015c4:	a1 a8 a0 11 c0       	mov    0xc011a0a8,%eax
c01015c9:	31 d0                	xor    %edx,%eax
c01015cb:	a3 a8 a0 11 c0       	mov    %eax,0xc011a0a8

    c = charcode[shift & (CTL | SHIFT)][data];
c01015d0:	a1 a8 a0 11 c0       	mov    0xc011a0a8,%eax
c01015d5:	83 e0 03             	and    $0x3,%eax
c01015d8:	8b 14 85 60 95 11 c0 	mov    -0x3fee6aa0(,%eax,4),%edx
c01015df:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
c01015e3:	01 d0                	add    %edx,%eax
c01015e5:	0f b6 00             	movzbl (%eax),%eax
c01015e8:	0f b6 c0             	movzbl %al,%eax
c01015eb:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (shift & CAPSLOCK) {
c01015ee:	a1 a8 a0 11 c0       	mov    0xc011a0a8,%eax
c01015f3:	83 e0 08             	and    $0x8,%eax
c01015f6:	85 c0                	test   %eax,%eax
c01015f8:	74 22                	je     c010161c <kbd_proc_data+0x152>
        if ('a' <= c && c <= 'z')
c01015fa:	83 7d f4 60          	cmpl   $0x60,-0xc(%ebp)
c01015fe:	7e 0c                	jle    c010160c <kbd_proc_data+0x142>
c0101600:	83 7d f4 7a          	cmpl   $0x7a,-0xc(%ebp)
c0101604:	7f 06                	jg     c010160c <kbd_proc_data+0x142>
            c += 'A' - 'a';
c0101606:	83 6d f4 20          	subl   $0x20,-0xc(%ebp)
c010160a:	eb 10                	jmp    c010161c <kbd_proc_data+0x152>
        else if ('A' <= c && c <= 'Z')
c010160c:	83 7d f4 40          	cmpl   $0x40,-0xc(%ebp)
c0101610:	7e 0a                	jle    c010161c <kbd_proc_data+0x152>
c0101612:	83 7d f4 5a          	cmpl   $0x5a,-0xc(%ebp)
c0101616:	7f 04                	jg     c010161c <kbd_proc_data+0x152>
            c += 'a' - 'A';
c0101618:	83 45 f4 20          	addl   $0x20,-0xc(%ebp)
    }

    // Process special keys
    // Ctrl-Alt-Del: reboot
    if (!(~shift & (CTL | ALT)) && c == KEY_DEL) {
c010161c:	a1 a8 a0 11 c0       	mov    0xc011a0a8,%eax
c0101621:	f7 d0                	not    %eax
c0101623:	83 e0 06             	and    $0x6,%eax
c0101626:	85 c0                	test   %eax,%eax
c0101628:	75 2d                	jne    c0101657 <kbd_proc_data+0x18d>
c010162a:	81 7d f4 e9 00 00 00 	cmpl   $0xe9,-0xc(%ebp)
c0101631:	75 24                	jne    c0101657 <kbd_proc_data+0x18d>
        cprintf("Rebooting!\n");
c0101633:	83 ec 0c             	sub    $0xc,%esp
c0101636:	68 29 60 10 c0       	push   $0xc0106029
c010163b:	e8 4f ec ff ff       	call   c010028f <cprintf>
c0101640:	83 c4 10             	add    $0x10,%esp
c0101643:	66 c7 45 e8 92 00    	movw   $0x92,-0x18(%ebp)
c0101649:	c6 45 e7 03          	movb   $0x3,-0x19(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c010164d:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
c0101651:	0f b7 55 e8          	movzwl -0x18(%ebp),%edx
c0101655:	ee                   	out    %al,(%dx)
}
c0101656:	90                   	nop
        outb(0x92, 0x3); // courtesy of Chris Frost
    }
    return c;
c0101657:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
c010165a:	c9                   	leave  
c010165b:	c3                   	ret    

c010165c <kbd_intr>:

/* kbd_intr - try to feed input characters from keyboard */
static void
kbd_intr(void) {
c010165c:	f3 0f 1e fb          	endbr32 
c0101660:	55                   	push   %ebp
c0101661:	89 e5                	mov    %esp,%ebp
c0101663:	83 ec 08             	sub    $0x8,%esp
    cons_intr(kbd_proc_data);
c0101666:	83 ec 0c             	sub    $0xc,%esp
c0101669:	68 ca 14 10 c0       	push   $0xc01014ca
c010166e:	e8 85 fd ff ff       	call   c01013f8 <cons_intr>
c0101673:	83 c4 10             	add    $0x10,%esp
}
c0101676:	90                   	nop
c0101677:	c9                   	leave  
c0101678:	c3                   	ret    

c0101679 <kbd_init>:

static void
kbd_init(void) {
c0101679:	f3 0f 1e fb          	endbr32 
c010167d:	55                   	push   %ebp
c010167e:	89 e5                	mov    %esp,%ebp
c0101680:	83 ec 08             	sub    $0x8,%esp
    // drain the kbd buffer
    kbd_intr();
c0101683:	e8 d4 ff ff ff       	call   c010165c <kbd_intr>
    pic_enable(IRQ_KBD);
c0101688:	83 ec 0c             	sub    $0xc,%esp
c010168b:	6a 01                	push   $0x1
c010168d:	e8 5d 01 00 00       	call   c01017ef <pic_enable>
c0101692:	83 c4 10             	add    $0x10,%esp
}
c0101695:	90                   	nop
c0101696:	c9                   	leave  
c0101697:	c3                   	ret    

c0101698 <cons_init>:

/* cons_init - initializes the console devices */
void
cons_init(void) {
c0101698:	f3 0f 1e fb          	endbr32 
c010169c:	55                   	push   %ebp
c010169d:	89 e5                	mov    %esp,%ebp
c010169f:	83 ec 08             	sub    $0x8,%esp
    cga_init();
c01016a2:	e8 33 f8 ff ff       	call   c0100eda <cga_init>
    serial_init();
c01016a7:	e8 1b f9 ff ff       	call   c0100fc7 <serial_init>
    kbd_init();
c01016ac:	e8 c8 ff ff ff       	call   c0101679 <kbd_init>
    if (!serial_exists) {
c01016b1:	a1 88 9e 11 c0       	mov    0xc0119e88,%eax
c01016b6:	85 c0                	test   %eax,%eax
c01016b8:	75 10                	jne    c01016ca <cons_init+0x32>
        cprintf("serial port does not exist!!\n");
c01016ba:	83 ec 0c             	sub    $0xc,%esp
c01016bd:	68 35 60 10 c0       	push   $0xc0106035
c01016c2:	e8 c8 eb ff ff       	call   c010028f <cprintf>
c01016c7:	83 c4 10             	add    $0x10,%esp
    }
}
c01016ca:	90                   	nop
c01016cb:	c9                   	leave  
c01016cc:	c3                   	ret    

c01016cd <cons_putc>:

/* cons_putc - print a single character @c to console devices */
void
cons_putc(int c) {
c01016cd:	f3 0f 1e fb          	endbr32 
c01016d1:	55                   	push   %ebp
c01016d2:	89 e5                	mov    %esp,%ebp
c01016d4:	83 ec 18             	sub    $0x18,%esp
    bool intr_flag;
    local_intr_save(intr_flag);
c01016d7:	e8 73 f7 ff ff       	call   c0100e4f <__intr_save>
c01016dc:	89 45 f4             	mov    %eax,-0xc(%ebp)
    {
        lpt_putc(c);
c01016df:	83 ec 0c             	sub    $0xc,%esp
c01016e2:	ff 75 08             	pushl  0x8(%ebp)
c01016e5:	e8 4e fa ff ff       	call   c0101138 <lpt_putc>
c01016ea:	83 c4 10             	add    $0x10,%esp
        cga_putc(c);
c01016ed:	83 ec 0c             	sub    $0xc,%esp
c01016f0:	ff 75 08             	pushl  0x8(%ebp)
c01016f3:	e8 7b fa ff ff       	call   c0101173 <cga_putc>
c01016f8:	83 c4 10             	add    $0x10,%esp
        serial_putc(c);
c01016fb:	83 ec 0c             	sub    $0xc,%esp
c01016fe:	ff 75 08             	pushl  0x8(%ebp)
c0101701:	e8 b7 fc ff ff       	call   c01013bd <serial_putc>
c0101706:	83 c4 10             	add    $0x10,%esp
    }
    local_intr_restore(intr_flag);
c0101709:	83 ec 0c             	sub    $0xc,%esp
c010170c:	ff 75 f4             	pushl  -0xc(%ebp)
c010170f:	e8 65 f7 ff ff       	call   c0100e79 <__intr_restore>
c0101714:	83 c4 10             	add    $0x10,%esp
}
c0101717:	90                   	nop
c0101718:	c9                   	leave  
c0101719:	c3                   	ret    

c010171a <cons_getc>:
/* *
 * cons_getc - return the next input character from console,
 * or 0 if none waiting.
 * */
int
cons_getc(void) {
c010171a:	f3 0f 1e fb          	endbr32 
c010171e:	55                   	push   %ebp
c010171f:	89 e5                	mov    %esp,%ebp
c0101721:	83 ec 18             	sub    $0x18,%esp
    int c = 0;
c0101724:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    bool intr_flag;
    local_intr_save(intr_flag);
c010172b:	e8 1f f7 ff ff       	call   c0100e4f <__intr_save>
c0101730:	89 45 f0             	mov    %eax,-0x10(%ebp)
    {
        // poll for any pending input characters,
        // so that this function works even when interrupts are disabled
        // (e.g., when called from the kernel monitor).
        serial_intr();
c0101733:	e8 6c fd ff ff       	call   c01014a4 <serial_intr>
        kbd_intr();
c0101738:	e8 1f ff ff ff       	call   c010165c <kbd_intr>

        // grab the next character from the input buffer.
        if (cons.rpos != cons.wpos) {
c010173d:	8b 15 a0 a0 11 c0    	mov    0xc011a0a0,%edx
c0101743:	a1 a4 a0 11 c0       	mov    0xc011a0a4,%eax
c0101748:	39 c2                	cmp    %eax,%edx
c010174a:	74 31                	je     c010177d <cons_getc+0x63>
            c = cons.buf[cons.rpos ++];
c010174c:	a1 a0 a0 11 c0       	mov    0xc011a0a0,%eax
c0101751:	8d 50 01             	lea    0x1(%eax),%edx
c0101754:	89 15 a0 a0 11 c0    	mov    %edx,0xc011a0a0
c010175a:	0f b6 80 a0 9e 11 c0 	movzbl -0x3fee6160(%eax),%eax
c0101761:	0f b6 c0             	movzbl %al,%eax
c0101764:	89 45 f4             	mov    %eax,-0xc(%ebp)
            if (cons.rpos == CONSBUFSIZE) {
c0101767:	a1 a0 a0 11 c0       	mov    0xc011a0a0,%eax
c010176c:	3d 00 02 00 00       	cmp    $0x200,%eax
c0101771:	75 0a                	jne    c010177d <cons_getc+0x63>
                cons.rpos = 0;
c0101773:	c7 05 a0 a0 11 c0 00 	movl   $0x0,0xc011a0a0
c010177a:	00 00 00 
            }
        }
    }
    local_intr_restore(intr_flag);
c010177d:	83 ec 0c             	sub    $0xc,%esp
c0101780:	ff 75 f0             	pushl  -0x10(%ebp)
c0101783:	e8 f1 f6 ff ff       	call   c0100e79 <__intr_restore>
c0101788:	83 c4 10             	add    $0x10,%esp
    return c;
c010178b:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
c010178e:	c9                   	leave  
c010178f:	c3                   	ret    

c0101790 <pic_setmask>:
// Initial IRQ mask has interrupt 2 enabled (for slave 8259A).
static uint16_t irq_mask = 0xFFFF & ~(1 << IRQ_SLAVE);
static bool did_init = 0;

static void
pic_setmask(uint16_t mask) {
c0101790:	f3 0f 1e fb          	endbr32 
c0101794:	55                   	push   %ebp
c0101795:	89 e5                	mov    %esp,%ebp
c0101797:	83 ec 14             	sub    $0x14,%esp
c010179a:	8b 45 08             	mov    0x8(%ebp),%eax
c010179d:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
    irq_mask = mask;
c01017a1:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
c01017a5:	66 a3 70 95 11 c0    	mov    %ax,0xc0119570
    if (did_init) {
c01017ab:	a1 ac a0 11 c0       	mov    0xc011a0ac,%eax
c01017b0:	85 c0                	test   %eax,%eax
c01017b2:	74 38                	je     c01017ec <pic_setmask+0x5c>
        outb(IO_PIC1 + 1, mask);
c01017b4:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
c01017b8:	0f b6 c0             	movzbl %al,%eax
c01017bb:	66 c7 45 fa 21 00    	movw   $0x21,-0x6(%ebp)
c01017c1:	88 45 f9             	mov    %al,-0x7(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c01017c4:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
c01017c8:	0f b7 55 fa          	movzwl -0x6(%ebp),%edx
c01017cc:	ee                   	out    %al,(%dx)
}
c01017cd:	90                   	nop
        outb(IO_PIC2 + 1, mask >> 8);
c01017ce:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
c01017d2:	66 c1 e8 08          	shr    $0x8,%ax
c01017d6:	0f b6 c0             	movzbl %al,%eax
c01017d9:	66 c7 45 fe a1 00    	movw   $0xa1,-0x2(%ebp)
c01017df:	88 45 fd             	mov    %al,-0x3(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c01017e2:	0f b6 45 fd          	movzbl -0x3(%ebp),%eax
c01017e6:	0f b7 55 fe          	movzwl -0x2(%ebp),%edx
c01017ea:	ee                   	out    %al,(%dx)
}
c01017eb:	90                   	nop
    }
}
c01017ec:	90                   	nop
c01017ed:	c9                   	leave  
c01017ee:	c3                   	ret    

c01017ef <pic_enable>:

void
pic_enable(unsigned int irq) {
c01017ef:	f3 0f 1e fb          	endbr32 
c01017f3:	55                   	push   %ebp
c01017f4:	89 e5                	mov    %esp,%ebp
    pic_setmask(irq_mask & ~(1 << irq));
c01017f6:	8b 45 08             	mov    0x8(%ebp),%eax
c01017f9:	ba 01 00 00 00       	mov    $0x1,%edx
c01017fe:	89 c1                	mov    %eax,%ecx
c0101800:	d3 e2                	shl    %cl,%edx
c0101802:	89 d0                	mov    %edx,%eax
c0101804:	f7 d0                	not    %eax
c0101806:	89 c2                	mov    %eax,%edx
c0101808:	0f b7 05 70 95 11 c0 	movzwl 0xc0119570,%eax
c010180f:	21 d0                	and    %edx,%eax
c0101811:	0f b7 c0             	movzwl %ax,%eax
c0101814:	50                   	push   %eax
c0101815:	e8 76 ff ff ff       	call   c0101790 <pic_setmask>
c010181a:	83 c4 04             	add    $0x4,%esp
}
c010181d:	90                   	nop
c010181e:	c9                   	leave  
c010181f:	c3                   	ret    

c0101820 <pic_init>:

/* pic_init - initialize the 8259A interrupt controllers */
void
pic_init(void) {
c0101820:	f3 0f 1e fb          	endbr32 
c0101824:	55                   	push   %ebp
c0101825:	89 e5                	mov    %esp,%ebp
c0101827:	83 ec 40             	sub    $0x40,%esp
    did_init = 1;
c010182a:	c7 05 ac a0 11 c0 01 	movl   $0x1,0xc011a0ac
c0101831:	00 00 00 
c0101834:	66 c7 45 ca 21 00    	movw   $0x21,-0x36(%ebp)
c010183a:	c6 45 c9 ff          	movb   $0xff,-0x37(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c010183e:	0f b6 45 c9          	movzbl -0x37(%ebp),%eax
c0101842:	0f b7 55 ca          	movzwl -0x36(%ebp),%edx
c0101846:	ee                   	out    %al,(%dx)
}
c0101847:	90                   	nop
c0101848:	66 c7 45 ce a1 00    	movw   $0xa1,-0x32(%ebp)
c010184e:	c6 45 cd ff          	movb   $0xff,-0x33(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c0101852:	0f b6 45 cd          	movzbl -0x33(%ebp),%eax
c0101856:	0f b7 55 ce          	movzwl -0x32(%ebp),%edx
c010185a:	ee                   	out    %al,(%dx)
}
c010185b:	90                   	nop
c010185c:	66 c7 45 d2 20 00    	movw   $0x20,-0x2e(%ebp)
c0101862:	c6 45 d1 11          	movb   $0x11,-0x2f(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c0101866:	0f b6 45 d1          	movzbl -0x2f(%ebp),%eax
c010186a:	0f b7 55 d2          	movzwl -0x2e(%ebp),%edx
c010186e:	ee                   	out    %al,(%dx)
}
c010186f:	90                   	nop
c0101870:	66 c7 45 d6 21 00    	movw   $0x21,-0x2a(%ebp)
c0101876:	c6 45 d5 20          	movb   $0x20,-0x2b(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c010187a:	0f b6 45 d5          	movzbl -0x2b(%ebp),%eax
c010187e:	0f b7 55 d6          	movzwl -0x2a(%ebp),%edx
c0101882:	ee                   	out    %al,(%dx)
}
c0101883:	90                   	nop
c0101884:	66 c7 45 da 21 00    	movw   $0x21,-0x26(%ebp)
c010188a:	c6 45 d9 04          	movb   $0x4,-0x27(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c010188e:	0f b6 45 d9          	movzbl -0x27(%ebp),%eax
c0101892:	0f b7 55 da          	movzwl -0x26(%ebp),%edx
c0101896:	ee                   	out    %al,(%dx)
}
c0101897:	90                   	nop
c0101898:	66 c7 45 de 21 00    	movw   $0x21,-0x22(%ebp)
c010189e:	c6 45 dd 03          	movb   $0x3,-0x23(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c01018a2:	0f b6 45 dd          	movzbl -0x23(%ebp),%eax
c01018a6:	0f b7 55 de          	movzwl -0x22(%ebp),%edx
c01018aa:	ee                   	out    %al,(%dx)
}
c01018ab:	90                   	nop
c01018ac:	66 c7 45 e2 a0 00    	movw   $0xa0,-0x1e(%ebp)
c01018b2:	c6 45 e1 11          	movb   $0x11,-0x1f(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c01018b6:	0f b6 45 e1          	movzbl -0x1f(%ebp),%eax
c01018ba:	0f b7 55 e2          	movzwl -0x1e(%ebp),%edx
c01018be:	ee                   	out    %al,(%dx)
}
c01018bf:	90                   	nop
c01018c0:	66 c7 45 e6 a1 00    	movw   $0xa1,-0x1a(%ebp)
c01018c6:	c6 45 e5 28          	movb   $0x28,-0x1b(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c01018ca:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
c01018ce:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
c01018d2:	ee                   	out    %al,(%dx)
}
c01018d3:	90                   	nop
c01018d4:	66 c7 45 ea a1 00    	movw   $0xa1,-0x16(%ebp)
c01018da:	c6 45 e9 02          	movb   $0x2,-0x17(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c01018de:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
c01018e2:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
c01018e6:	ee                   	out    %al,(%dx)
}
c01018e7:	90                   	nop
c01018e8:	66 c7 45 ee a1 00    	movw   $0xa1,-0x12(%ebp)
c01018ee:	c6 45 ed 03          	movb   $0x3,-0x13(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c01018f2:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
c01018f6:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
c01018fa:	ee                   	out    %al,(%dx)
}
c01018fb:	90                   	nop
c01018fc:	66 c7 45 f2 20 00    	movw   $0x20,-0xe(%ebp)
c0101902:	c6 45 f1 68          	movb   $0x68,-0xf(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c0101906:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
c010190a:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
c010190e:	ee                   	out    %al,(%dx)
}
c010190f:	90                   	nop
c0101910:	66 c7 45 f6 20 00    	movw   $0x20,-0xa(%ebp)
c0101916:	c6 45 f5 0a          	movb   $0xa,-0xb(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c010191a:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
c010191e:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
c0101922:	ee                   	out    %al,(%dx)
}
c0101923:	90                   	nop
c0101924:	66 c7 45 fa a0 00    	movw   $0xa0,-0x6(%ebp)
c010192a:	c6 45 f9 68          	movb   $0x68,-0x7(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c010192e:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
c0101932:	0f b7 55 fa          	movzwl -0x6(%ebp),%edx
c0101936:	ee                   	out    %al,(%dx)
}
c0101937:	90                   	nop
c0101938:	66 c7 45 fe a0 00    	movw   $0xa0,-0x2(%ebp)
c010193e:	c6 45 fd 0a          	movb   $0xa,-0x3(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c0101942:	0f b6 45 fd          	movzbl -0x3(%ebp),%eax
c0101946:	0f b7 55 fe          	movzwl -0x2(%ebp),%edx
c010194a:	ee                   	out    %al,(%dx)
}
c010194b:	90                   	nop
    outb(IO_PIC1, 0x0a);    // read IRR by default

    outb(IO_PIC2, 0x68);    // OCW3
    outb(IO_PIC2, 0x0a);    // OCW3

    if (irq_mask != 0xFFFF) {
c010194c:	0f b7 05 70 95 11 c0 	movzwl 0xc0119570,%eax
c0101953:	66 83 f8 ff          	cmp    $0xffff,%ax
c0101957:	74 13                	je     c010196c <pic_init+0x14c>
        pic_setmask(irq_mask);
c0101959:	0f b7 05 70 95 11 c0 	movzwl 0xc0119570,%eax
c0101960:	0f b7 c0             	movzwl %ax,%eax
c0101963:	50                   	push   %eax
c0101964:	e8 27 fe ff ff       	call   c0101790 <pic_setmask>
c0101969:	83 c4 04             	add    $0x4,%esp
    }
}
c010196c:	90                   	nop
c010196d:	c9                   	leave  
c010196e:	c3                   	ret    

c010196f <intr_enable>:
#include <x86.h>
#include <intr.h>

/* intr_enable - enable irq interrupt */
void
intr_enable(void) {
c010196f:	f3 0f 1e fb          	endbr32 
c0101973:	55                   	push   %ebp
c0101974:	89 e5                	mov    %esp,%ebp
    asm volatile ("sti");
c0101976:	fb                   	sti    
}
c0101977:	90                   	nop
    sti();
}
c0101978:	90                   	nop
c0101979:	5d                   	pop    %ebp
c010197a:	c3                   	ret    

c010197b <intr_disable>:

/* intr_disable - disable irq interrupt */
void
intr_disable(void) {
c010197b:	f3 0f 1e fb          	endbr32 
c010197f:	55                   	push   %ebp
c0101980:	89 e5                	mov    %esp,%ebp
    asm volatile ("cli" ::: "memory");
c0101982:	fa                   	cli    
}
c0101983:	90                   	nop
    cli();
}
c0101984:	90                   	nop
c0101985:	5d                   	pop    %ebp
c0101986:	c3                   	ret    

c0101987 <print_ticks>:
#include <console.h>
#include <kdebug.h>

#define TICK_NUM 100

static void print_ticks() {
c0101987:	f3 0f 1e fb          	endbr32 
c010198b:	55                   	push   %ebp
c010198c:	89 e5                	mov    %esp,%ebp
c010198e:	83 ec 08             	sub    $0x8,%esp
    cprintf("%d ticks\n",TICK_NUM);
c0101991:	83 ec 08             	sub    $0x8,%esp
c0101994:	6a 64                	push   $0x64
c0101996:	68 60 60 10 c0       	push   $0xc0106060
c010199b:	e8 ef e8 ff ff       	call   c010028f <cprintf>
c01019a0:	83 c4 10             	add    $0x10,%esp
#ifdef DEBUG_GRADE
    cprintf("End of Test.\n");
    panic("EOT: kernel seems ok.");
#endif
}
c01019a3:	90                   	nop
c01019a4:	c9                   	leave  
c01019a5:	c3                   	ret    

c01019a6 <idt_init>:
    sizeof(idt) - 1, (uintptr_t)idt
};

/* idt_init - initialize IDT to each of the entry points in kern/trap/vectors.S */
void
idt_init(void) {
c01019a6:	f3 0f 1e fb          	endbr32 
c01019aa:	55                   	push   %ebp
c01019ab:	89 e5                	mov    %esp,%ebp
c01019ad:	83 ec 10             	sub    $0x10,%esp
      * (3) After setup the contents of IDT, you will let CPU know where is the IDT by using 'lidt' instruction.
      *     You don't know the meaning of this instruction? just google it! and check the libs/x86.h to know more.
      *     Notice: the argument of lidt is idt_pd. try to find it!
      */
      extern uintptr_t __vectors[];
	for(int i=0; i < sizeof(idt)/sizeof(struct gatedesc); i++)
c01019b0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
c01019b7:	e9 c3 00 00 00       	jmp    c0101a7f <idt_init+0xd9>
	{
		SETGATE(idt[i], 0, GD_KTEXT, __vectors[i], DPL_KERNEL);
c01019bc:	8b 45 fc             	mov    -0x4(%ebp),%eax
c01019bf:	8b 04 85 00 96 11 c0 	mov    -0x3fee6a00(,%eax,4),%eax
c01019c6:	89 c2                	mov    %eax,%edx
c01019c8:	8b 45 fc             	mov    -0x4(%ebp),%eax
c01019cb:	66 89 14 c5 c0 a0 11 	mov    %dx,-0x3fee5f40(,%eax,8)
c01019d2:	c0 
c01019d3:	8b 45 fc             	mov    -0x4(%ebp),%eax
c01019d6:	66 c7 04 c5 c2 a0 11 	movw   $0x8,-0x3fee5f3e(,%eax,8)
c01019dd:	c0 08 00 
c01019e0:	8b 45 fc             	mov    -0x4(%ebp),%eax
c01019e3:	0f b6 14 c5 c4 a0 11 	movzbl -0x3fee5f3c(,%eax,8),%edx
c01019ea:	c0 
c01019eb:	83 e2 e0             	and    $0xffffffe0,%edx
c01019ee:	88 14 c5 c4 a0 11 c0 	mov    %dl,-0x3fee5f3c(,%eax,8)
c01019f5:	8b 45 fc             	mov    -0x4(%ebp),%eax
c01019f8:	0f b6 14 c5 c4 a0 11 	movzbl -0x3fee5f3c(,%eax,8),%edx
c01019ff:	c0 
c0101a00:	83 e2 1f             	and    $0x1f,%edx
c0101a03:	88 14 c5 c4 a0 11 c0 	mov    %dl,-0x3fee5f3c(,%eax,8)
c0101a0a:	8b 45 fc             	mov    -0x4(%ebp),%eax
c0101a0d:	0f b6 14 c5 c5 a0 11 	movzbl -0x3fee5f3b(,%eax,8),%edx
c0101a14:	c0 
c0101a15:	83 e2 f0             	and    $0xfffffff0,%edx
c0101a18:	83 ca 0e             	or     $0xe,%edx
c0101a1b:	88 14 c5 c5 a0 11 c0 	mov    %dl,-0x3fee5f3b(,%eax,8)
c0101a22:	8b 45 fc             	mov    -0x4(%ebp),%eax
c0101a25:	0f b6 14 c5 c5 a0 11 	movzbl -0x3fee5f3b(,%eax,8),%edx
c0101a2c:	c0 
c0101a2d:	83 e2 ef             	and    $0xffffffef,%edx
c0101a30:	88 14 c5 c5 a0 11 c0 	mov    %dl,-0x3fee5f3b(,%eax,8)
c0101a37:	8b 45 fc             	mov    -0x4(%ebp),%eax
c0101a3a:	0f b6 14 c5 c5 a0 11 	movzbl -0x3fee5f3b(,%eax,8),%edx
c0101a41:	c0 
c0101a42:	83 e2 9f             	and    $0xffffff9f,%edx
c0101a45:	88 14 c5 c5 a0 11 c0 	mov    %dl,-0x3fee5f3b(,%eax,8)
c0101a4c:	8b 45 fc             	mov    -0x4(%ebp),%eax
c0101a4f:	0f b6 14 c5 c5 a0 11 	movzbl -0x3fee5f3b(,%eax,8),%edx
c0101a56:	c0 
c0101a57:	83 ca 80             	or     $0xffffff80,%edx
c0101a5a:	88 14 c5 c5 a0 11 c0 	mov    %dl,-0x3fee5f3b(,%eax,8)
c0101a61:	8b 45 fc             	mov    -0x4(%ebp),%eax
c0101a64:	8b 04 85 00 96 11 c0 	mov    -0x3fee6a00(,%eax,4),%eax
c0101a6b:	c1 e8 10             	shr    $0x10,%eax
c0101a6e:	89 c2                	mov    %eax,%edx
c0101a70:	8b 45 fc             	mov    -0x4(%ebp),%eax
c0101a73:	66 89 14 c5 c6 a0 11 	mov    %dx,-0x3fee5f3a(,%eax,8)
c0101a7a:	c0 
	for(int i=0; i < sizeof(idt)/sizeof(struct gatedesc); i++)
c0101a7b:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
c0101a7f:	8b 45 fc             	mov    -0x4(%ebp),%eax
c0101a82:	3d ff 00 00 00       	cmp    $0xff,%eax
c0101a87:	0f 86 2f ff ff ff    	jbe    c01019bc <idt_init+0x16>
	}
	SETGATE(idt[T_SWITCH_TOK], 0, GD_KTEXT, __vectors[T_SWITCH_TOK], DPL_USER);
c0101a8d:	a1 e4 97 11 c0       	mov    0xc01197e4,%eax
c0101a92:	66 a3 88 a4 11 c0    	mov    %ax,0xc011a488
c0101a98:	66 c7 05 8a a4 11 c0 	movw   $0x8,0xc011a48a
c0101a9f:	08 00 
c0101aa1:	0f b6 05 8c a4 11 c0 	movzbl 0xc011a48c,%eax
c0101aa8:	83 e0 e0             	and    $0xffffffe0,%eax
c0101aab:	a2 8c a4 11 c0       	mov    %al,0xc011a48c
c0101ab0:	0f b6 05 8c a4 11 c0 	movzbl 0xc011a48c,%eax
c0101ab7:	83 e0 1f             	and    $0x1f,%eax
c0101aba:	a2 8c a4 11 c0       	mov    %al,0xc011a48c
c0101abf:	0f b6 05 8d a4 11 c0 	movzbl 0xc011a48d,%eax
c0101ac6:	83 e0 f0             	and    $0xfffffff0,%eax
c0101ac9:	83 c8 0e             	or     $0xe,%eax
c0101acc:	a2 8d a4 11 c0       	mov    %al,0xc011a48d
c0101ad1:	0f b6 05 8d a4 11 c0 	movzbl 0xc011a48d,%eax
c0101ad8:	83 e0 ef             	and    $0xffffffef,%eax
c0101adb:	a2 8d a4 11 c0       	mov    %al,0xc011a48d
c0101ae0:	0f b6 05 8d a4 11 c0 	movzbl 0xc011a48d,%eax
c0101ae7:	83 c8 60             	or     $0x60,%eax
c0101aea:	a2 8d a4 11 c0       	mov    %al,0xc011a48d
c0101aef:	0f b6 05 8d a4 11 c0 	movzbl 0xc011a48d,%eax
c0101af6:	83 c8 80             	or     $0xffffff80,%eax
c0101af9:	a2 8d a4 11 c0       	mov    %al,0xc011a48d
c0101afe:	a1 e4 97 11 c0       	mov    0xc01197e4,%eax
c0101b03:	c1 e8 10             	shr    $0x10,%eax
c0101b06:	66 a3 8e a4 11 c0    	mov    %ax,0xc011a48e
c0101b0c:	c7 45 f8 80 95 11 c0 	movl   $0xc0119580,-0x8(%ebp)
    asm volatile ("lidt (%0)" :: "r" (pd) : "memory");
c0101b13:	8b 45 f8             	mov    -0x8(%ebp),%eax
c0101b16:	0f 01 18             	lidtl  (%eax)
}
c0101b19:	90                   	nop
	lidt(&idt_pd);
}
c0101b1a:	90                   	nop
c0101b1b:	c9                   	leave  
c0101b1c:	c3                   	ret    

c0101b1d <trapname>:

static const char *
trapname(int trapno) {
c0101b1d:	f3 0f 1e fb          	endbr32 
c0101b21:	55                   	push   %ebp
c0101b22:	89 e5                	mov    %esp,%ebp
        "Alignment Check",
        "Machine-Check",
        "SIMD Floating-Point Exception"
    };

    if (trapno < sizeof(excnames)/sizeof(const char * const)) {
c0101b24:	8b 45 08             	mov    0x8(%ebp),%eax
c0101b27:	83 f8 13             	cmp    $0x13,%eax
c0101b2a:	77 0c                	ja     c0101b38 <trapname+0x1b>
        return excnames[trapno];
c0101b2c:	8b 45 08             	mov    0x8(%ebp),%eax
c0101b2f:	8b 04 85 c0 63 10 c0 	mov    -0x3fef9c40(,%eax,4),%eax
c0101b36:	eb 18                	jmp    c0101b50 <trapname+0x33>
    }
    if (trapno >= IRQ_OFFSET && trapno < IRQ_OFFSET + 16) {
c0101b38:	83 7d 08 1f          	cmpl   $0x1f,0x8(%ebp)
c0101b3c:	7e 0d                	jle    c0101b4b <trapname+0x2e>
c0101b3e:	83 7d 08 2f          	cmpl   $0x2f,0x8(%ebp)
c0101b42:	7f 07                	jg     c0101b4b <trapname+0x2e>
        return "Hardware Interrupt";
c0101b44:	b8 6a 60 10 c0       	mov    $0xc010606a,%eax
c0101b49:	eb 05                	jmp    c0101b50 <trapname+0x33>
    }
    return "(unknown trap)";
c0101b4b:	b8 7d 60 10 c0       	mov    $0xc010607d,%eax
}
c0101b50:	5d                   	pop    %ebp
c0101b51:	c3                   	ret    

c0101b52 <trap_in_kernel>:

/* trap_in_kernel - test if trap happened in kernel */
bool
trap_in_kernel(struct trapframe *tf) {
c0101b52:	f3 0f 1e fb          	endbr32 
c0101b56:	55                   	push   %ebp
c0101b57:	89 e5                	mov    %esp,%ebp
    return (tf->tf_cs == (uint16_t)KERNEL_CS);
c0101b59:	8b 45 08             	mov    0x8(%ebp),%eax
c0101b5c:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
c0101b60:	66 83 f8 08          	cmp    $0x8,%ax
c0101b64:	0f 94 c0             	sete   %al
c0101b67:	0f b6 c0             	movzbl %al,%eax
}
c0101b6a:	5d                   	pop    %ebp
c0101b6b:	c3                   	ret    

c0101b6c <print_trapframe>:
    "TF", "IF", "DF", "OF", NULL, NULL, "NT", NULL,
    "RF", "VM", "AC", "VIF", "VIP", "ID", NULL, NULL,
};

void
print_trapframe(struct trapframe *tf) {
c0101b6c:	f3 0f 1e fb          	endbr32 
c0101b70:	55                   	push   %ebp
c0101b71:	89 e5                	mov    %esp,%ebp
c0101b73:	83 ec 18             	sub    $0x18,%esp
    cprintf("trapframe at %p\n", tf);
c0101b76:	83 ec 08             	sub    $0x8,%esp
c0101b79:	ff 75 08             	pushl  0x8(%ebp)
c0101b7c:	68 be 60 10 c0       	push   $0xc01060be
c0101b81:	e8 09 e7 ff ff       	call   c010028f <cprintf>
c0101b86:	83 c4 10             	add    $0x10,%esp
    print_regs(&tf->tf_regs);
c0101b89:	8b 45 08             	mov    0x8(%ebp),%eax
c0101b8c:	83 ec 0c             	sub    $0xc,%esp
c0101b8f:	50                   	push   %eax
c0101b90:	e8 b4 01 00 00       	call   c0101d49 <print_regs>
c0101b95:	83 c4 10             	add    $0x10,%esp
    cprintf("  ds   0x----%04x\n", tf->tf_ds);
c0101b98:	8b 45 08             	mov    0x8(%ebp),%eax
c0101b9b:	0f b7 40 2c          	movzwl 0x2c(%eax),%eax
c0101b9f:	0f b7 c0             	movzwl %ax,%eax
c0101ba2:	83 ec 08             	sub    $0x8,%esp
c0101ba5:	50                   	push   %eax
c0101ba6:	68 cf 60 10 c0       	push   $0xc01060cf
c0101bab:	e8 df e6 ff ff       	call   c010028f <cprintf>
c0101bb0:	83 c4 10             	add    $0x10,%esp
    cprintf("  es   0x----%04x\n", tf->tf_es);
c0101bb3:	8b 45 08             	mov    0x8(%ebp),%eax
c0101bb6:	0f b7 40 28          	movzwl 0x28(%eax),%eax
c0101bba:	0f b7 c0             	movzwl %ax,%eax
c0101bbd:	83 ec 08             	sub    $0x8,%esp
c0101bc0:	50                   	push   %eax
c0101bc1:	68 e2 60 10 c0       	push   $0xc01060e2
c0101bc6:	e8 c4 e6 ff ff       	call   c010028f <cprintf>
c0101bcb:	83 c4 10             	add    $0x10,%esp
    cprintf("  fs   0x----%04x\n", tf->tf_fs);
c0101bce:	8b 45 08             	mov    0x8(%ebp),%eax
c0101bd1:	0f b7 40 24          	movzwl 0x24(%eax),%eax
c0101bd5:	0f b7 c0             	movzwl %ax,%eax
c0101bd8:	83 ec 08             	sub    $0x8,%esp
c0101bdb:	50                   	push   %eax
c0101bdc:	68 f5 60 10 c0       	push   $0xc01060f5
c0101be1:	e8 a9 e6 ff ff       	call   c010028f <cprintf>
c0101be6:	83 c4 10             	add    $0x10,%esp
    cprintf("  gs   0x----%04x\n", tf->tf_gs);
c0101be9:	8b 45 08             	mov    0x8(%ebp),%eax
c0101bec:	0f b7 40 20          	movzwl 0x20(%eax),%eax
c0101bf0:	0f b7 c0             	movzwl %ax,%eax
c0101bf3:	83 ec 08             	sub    $0x8,%esp
c0101bf6:	50                   	push   %eax
c0101bf7:	68 08 61 10 c0       	push   $0xc0106108
c0101bfc:	e8 8e e6 ff ff       	call   c010028f <cprintf>
c0101c01:	83 c4 10             	add    $0x10,%esp
    cprintf("  trap 0x%08x %s\n", tf->tf_trapno, trapname(tf->tf_trapno));
c0101c04:	8b 45 08             	mov    0x8(%ebp),%eax
c0101c07:	8b 40 30             	mov    0x30(%eax),%eax
c0101c0a:	83 ec 0c             	sub    $0xc,%esp
c0101c0d:	50                   	push   %eax
c0101c0e:	e8 0a ff ff ff       	call   c0101b1d <trapname>
c0101c13:	83 c4 10             	add    $0x10,%esp
c0101c16:	8b 55 08             	mov    0x8(%ebp),%edx
c0101c19:	8b 52 30             	mov    0x30(%edx),%edx
c0101c1c:	83 ec 04             	sub    $0x4,%esp
c0101c1f:	50                   	push   %eax
c0101c20:	52                   	push   %edx
c0101c21:	68 1b 61 10 c0       	push   $0xc010611b
c0101c26:	e8 64 e6 ff ff       	call   c010028f <cprintf>
c0101c2b:	83 c4 10             	add    $0x10,%esp
    cprintf("  err  0x%08x\n", tf->tf_err);
c0101c2e:	8b 45 08             	mov    0x8(%ebp),%eax
c0101c31:	8b 40 34             	mov    0x34(%eax),%eax
c0101c34:	83 ec 08             	sub    $0x8,%esp
c0101c37:	50                   	push   %eax
c0101c38:	68 2d 61 10 c0       	push   $0xc010612d
c0101c3d:	e8 4d e6 ff ff       	call   c010028f <cprintf>
c0101c42:	83 c4 10             	add    $0x10,%esp
    cprintf("  eip  0x%08x\n", tf->tf_eip);
c0101c45:	8b 45 08             	mov    0x8(%ebp),%eax
c0101c48:	8b 40 38             	mov    0x38(%eax),%eax
c0101c4b:	83 ec 08             	sub    $0x8,%esp
c0101c4e:	50                   	push   %eax
c0101c4f:	68 3c 61 10 c0       	push   $0xc010613c
c0101c54:	e8 36 e6 ff ff       	call   c010028f <cprintf>
c0101c59:	83 c4 10             	add    $0x10,%esp
    cprintf("  cs   0x----%04x\n", tf->tf_cs);
c0101c5c:	8b 45 08             	mov    0x8(%ebp),%eax
c0101c5f:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
c0101c63:	0f b7 c0             	movzwl %ax,%eax
c0101c66:	83 ec 08             	sub    $0x8,%esp
c0101c69:	50                   	push   %eax
c0101c6a:	68 4b 61 10 c0       	push   $0xc010614b
c0101c6f:	e8 1b e6 ff ff       	call   c010028f <cprintf>
c0101c74:	83 c4 10             	add    $0x10,%esp
    cprintf("  flag 0x%08x ", tf->tf_eflags);
c0101c77:	8b 45 08             	mov    0x8(%ebp),%eax
c0101c7a:	8b 40 40             	mov    0x40(%eax),%eax
c0101c7d:	83 ec 08             	sub    $0x8,%esp
c0101c80:	50                   	push   %eax
c0101c81:	68 5e 61 10 c0       	push   $0xc010615e
c0101c86:	e8 04 e6 ff ff       	call   c010028f <cprintf>
c0101c8b:	83 c4 10             	add    $0x10,%esp

    int i, j;
    for (i = 0, j = 1; i < sizeof(IA32flags) / sizeof(IA32flags[0]); i ++, j <<= 1) {
c0101c8e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
c0101c95:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
c0101c9c:	eb 3f                	jmp    c0101cdd <print_trapframe+0x171>
        if ((tf->tf_eflags & j) && IA32flags[i] != NULL) {
c0101c9e:	8b 45 08             	mov    0x8(%ebp),%eax
c0101ca1:	8b 50 40             	mov    0x40(%eax),%edx
c0101ca4:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0101ca7:	21 d0                	and    %edx,%eax
c0101ca9:	85 c0                	test   %eax,%eax
c0101cab:	74 29                	je     c0101cd6 <print_trapframe+0x16a>
c0101cad:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0101cb0:	8b 04 85 a0 95 11 c0 	mov    -0x3fee6a60(,%eax,4),%eax
c0101cb7:	85 c0                	test   %eax,%eax
c0101cb9:	74 1b                	je     c0101cd6 <print_trapframe+0x16a>
            cprintf("%s,", IA32flags[i]);
c0101cbb:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0101cbe:	8b 04 85 a0 95 11 c0 	mov    -0x3fee6a60(,%eax,4),%eax
c0101cc5:	83 ec 08             	sub    $0x8,%esp
c0101cc8:	50                   	push   %eax
c0101cc9:	68 6d 61 10 c0       	push   $0xc010616d
c0101cce:	e8 bc e5 ff ff       	call   c010028f <cprintf>
c0101cd3:	83 c4 10             	add    $0x10,%esp
    for (i = 0, j = 1; i < sizeof(IA32flags) / sizeof(IA32flags[0]); i ++, j <<= 1) {
c0101cd6:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
c0101cda:	d1 65 f0             	shll   -0x10(%ebp)
c0101cdd:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0101ce0:	83 f8 17             	cmp    $0x17,%eax
c0101ce3:	76 b9                	jbe    c0101c9e <print_trapframe+0x132>
        }
    }
    cprintf("IOPL=%d\n", (tf->tf_eflags & FL_IOPL_MASK) >> 12);
c0101ce5:	8b 45 08             	mov    0x8(%ebp),%eax
c0101ce8:	8b 40 40             	mov    0x40(%eax),%eax
c0101ceb:	c1 e8 0c             	shr    $0xc,%eax
c0101cee:	83 e0 03             	and    $0x3,%eax
c0101cf1:	83 ec 08             	sub    $0x8,%esp
c0101cf4:	50                   	push   %eax
c0101cf5:	68 71 61 10 c0       	push   $0xc0106171
c0101cfa:	e8 90 e5 ff ff       	call   c010028f <cprintf>
c0101cff:	83 c4 10             	add    $0x10,%esp

    if (!trap_in_kernel(tf)) {
c0101d02:	83 ec 0c             	sub    $0xc,%esp
c0101d05:	ff 75 08             	pushl  0x8(%ebp)
c0101d08:	e8 45 fe ff ff       	call   c0101b52 <trap_in_kernel>
c0101d0d:	83 c4 10             	add    $0x10,%esp
c0101d10:	85 c0                	test   %eax,%eax
c0101d12:	75 32                	jne    c0101d46 <print_trapframe+0x1da>
        cprintf("  esp  0x%08x\n", tf->tf_esp);
c0101d14:	8b 45 08             	mov    0x8(%ebp),%eax
c0101d17:	8b 40 44             	mov    0x44(%eax),%eax
c0101d1a:	83 ec 08             	sub    $0x8,%esp
c0101d1d:	50                   	push   %eax
c0101d1e:	68 7a 61 10 c0       	push   $0xc010617a
c0101d23:	e8 67 e5 ff ff       	call   c010028f <cprintf>
c0101d28:	83 c4 10             	add    $0x10,%esp
        cprintf("  ss   0x----%04x\n", tf->tf_ss);
c0101d2b:	8b 45 08             	mov    0x8(%ebp),%eax
c0101d2e:	0f b7 40 48          	movzwl 0x48(%eax),%eax
c0101d32:	0f b7 c0             	movzwl %ax,%eax
c0101d35:	83 ec 08             	sub    $0x8,%esp
c0101d38:	50                   	push   %eax
c0101d39:	68 89 61 10 c0       	push   $0xc0106189
c0101d3e:	e8 4c e5 ff ff       	call   c010028f <cprintf>
c0101d43:	83 c4 10             	add    $0x10,%esp
    }
}
c0101d46:	90                   	nop
c0101d47:	c9                   	leave  
c0101d48:	c3                   	ret    

c0101d49 <print_regs>:

void
print_regs(struct pushregs *regs) {
c0101d49:	f3 0f 1e fb          	endbr32 
c0101d4d:	55                   	push   %ebp
c0101d4e:	89 e5                	mov    %esp,%ebp
c0101d50:	83 ec 08             	sub    $0x8,%esp
    cprintf("  edi  0x%08x\n", regs->reg_edi);
c0101d53:	8b 45 08             	mov    0x8(%ebp),%eax
c0101d56:	8b 00                	mov    (%eax),%eax
c0101d58:	83 ec 08             	sub    $0x8,%esp
c0101d5b:	50                   	push   %eax
c0101d5c:	68 9c 61 10 c0       	push   $0xc010619c
c0101d61:	e8 29 e5 ff ff       	call   c010028f <cprintf>
c0101d66:	83 c4 10             	add    $0x10,%esp
    cprintf("  esi  0x%08x\n", regs->reg_esi);
c0101d69:	8b 45 08             	mov    0x8(%ebp),%eax
c0101d6c:	8b 40 04             	mov    0x4(%eax),%eax
c0101d6f:	83 ec 08             	sub    $0x8,%esp
c0101d72:	50                   	push   %eax
c0101d73:	68 ab 61 10 c0       	push   $0xc01061ab
c0101d78:	e8 12 e5 ff ff       	call   c010028f <cprintf>
c0101d7d:	83 c4 10             	add    $0x10,%esp
    cprintf("  ebp  0x%08x\n", regs->reg_ebp);
c0101d80:	8b 45 08             	mov    0x8(%ebp),%eax
c0101d83:	8b 40 08             	mov    0x8(%eax),%eax
c0101d86:	83 ec 08             	sub    $0x8,%esp
c0101d89:	50                   	push   %eax
c0101d8a:	68 ba 61 10 c0       	push   $0xc01061ba
c0101d8f:	e8 fb e4 ff ff       	call   c010028f <cprintf>
c0101d94:	83 c4 10             	add    $0x10,%esp
    cprintf("  oesp 0x%08x\n", regs->reg_oesp);
c0101d97:	8b 45 08             	mov    0x8(%ebp),%eax
c0101d9a:	8b 40 0c             	mov    0xc(%eax),%eax
c0101d9d:	83 ec 08             	sub    $0x8,%esp
c0101da0:	50                   	push   %eax
c0101da1:	68 c9 61 10 c0       	push   $0xc01061c9
c0101da6:	e8 e4 e4 ff ff       	call   c010028f <cprintf>
c0101dab:	83 c4 10             	add    $0x10,%esp
    cprintf("  ebx  0x%08x\n", regs->reg_ebx);
c0101dae:	8b 45 08             	mov    0x8(%ebp),%eax
c0101db1:	8b 40 10             	mov    0x10(%eax),%eax
c0101db4:	83 ec 08             	sub    $0x8,%esp
c0101db7:	50                   	push   %eax
c0101db8:	68 d8 61 10 c0       	push   $0xc01061d8
c0101dbd:	e8 cd e4 ff ff       	call   c010028f <cprintf>
c0101dc2:	83 c4 10             	add    $0x10,%esp
    cprintf("  edx  0x%08x\n", regs->reg_edx);
c0101dc5:	8b 45 08             	mov    0x8(%ebp),%eax
c0101dc8:	8b 40 14             	mov    0x14(%eax),%eax
c0101dcb:	83 ec 08             	sub    $0x8,%esp
c0101dce:	50                   	push   %eax
c0101dcf:	68 e7 61 10 c0       	push   $0xc01061e7
c0101dd4:	e8 b6 e4 ff ff       	call   c010028f <cprintf>
c0101dd9:	83 c4 10             	add    $0x10,%esp
    cprintf("  ecx  0x%08x\n", regs->reg_ecx);
c0101ddc:	8b 45 08             	mov    0x8(%ebp),%eax
c0101ddf:	8b 40 18             	mov    0x18(%eax),%eax
c0101de2:	83 ec 08             	sub    $0x8,%esp
c0101de5:	50                   	push   %eax
c0101de6:	68 f6 61 10 c0       	push   $0xc01061f6
c0101deb:	e8 9f e4 ff ff       	call   c010028f <cprintf>
c0101df0:	83 c4 10             	add    $0x10,%esp
    cprintf("  eax  0x%08x\n", regs->reg_eax);
c0101df3:	8b 45 08             	mov    0x8(%ebp),%eax
c0101df6:	8b 40 1c             	mov    0x1c(%eax),%eax
c0101df9:	83 ec 08             	sub    $0x8,%esp
c0101dfc:	50                   	push   %eax
c0101dfd:	68 05 62 10 c0       	push   $0xc0106205
c0101e02:	e8 88 e4 ff ff       	call   c010028f <cprintf>
c0101e07:	83 c4 10             	add    $0x10,%esp
}
c0101e0a:	90                   	nop
c0101e0b:	c9                   	leave  
c0101e0c:	c3                   	ret    

c0101e0d <trap_dispatch>:

/* trap_dispatch - dispatch based on what type of trap occurred */
static void
trap_dispatch(struct trapframe *tf) {
c0101e0d:	f3 0f 1e fb          	endbr32 
c0101e11:	55                   	push   %ebp
c0101e12:	89 e5                	mov    %esp,%ebp
c0101e14:	83 ec 18             	sub    $0x18,%esp
    char c;

    switch (tf->tf_trapno) {
c0101e17:	8b 45 08             	mov    0x8(%ebp),%eax
c0101e1a:	8b 40 30             	mov    0x30(%eax),%eax
c0101e1d:	83 f8 79             	cmp    $0x79,%eax
c0101e20:	0f 87 d1 00 00 00    	ja     c0101ef7 <trap_dispatch+0xea>
c0101e26:	83 f8 78             	cmp    $0x78,%eax
c0101e29:	0f 83 b1 00 00 00    	jae    c0101ee0 <trap_dispatch+0xd3>
c0101e2f:	83 f8 2f             	cmp    $0x2f,%eax
c0101e32:	0f 87 bf 00 00 00    	ja     c0101ef7 <trap_dispatch+0xea>
c0101e38:	83 f8 2e             	cmp    $0x2e,%eax
c0101e3b:	0f 83 ec 00 00 00    	jae    c0101f2d <trap_dispatch+0x120>
c0101e41:	83 f8 24             	cmp    $0x24,%eax
c0101e44:	74 52                	je     c0101e98 <trap_dispatch+0x8b>
c0101e46:	83 f8 24             	cmp    $0x24,%eax
c0101e49:	0f 87 a8 00 00 00    	ja     c0101ef7 <trap_dispatch+0xea>
c0101e4f:	83 f8 20             	cmp    $0x20,%eax
c0101e52:	74 0a                	je     c0101e5e <trap_dispatch+0x51>
c0101e54:	83 f8 21             	cmp    $0x21,%eax
c0101e57:	74 63                	je     c0101ebc <trap_dispatch+0xaf>
c0101e59:	e9 99 00 00 00       	jmp    c0101ef7 <trap_dispatch+0xea>
        /* handle the timer interrupt */
        /* (1) After a timer interrupt, you should record this event using a global variable (increase it), such as ticks in kern/driver/clock.c
         * (2) Every TICK_NUM cycle, you can print some info using a funciton, such as print_ticks().
         * (3) Too Simple? Yes, I think so!
         */
         ticks++;
c0101e5e:	a1 4c a9 11 c0       	mov    0xc011a94c,%eax
c0101e63:	83 c0 01             	add    $0x1,%eax
c0101e66:	a3 4c a9 11 c0       	mov    %eax,0xc011a94c
	if(ticks%TICK_NUM==0){
c0101e6b:	8b 0d 4c a9 11 c0    	mov    0xc011a94c,%ecx
c0101e71:	ba 1f 85 eb 51       	mov    $0x51eb851f,%edx
c0101e76:	89 c8                	mov    %ecx,%eax
c0101e78:	f7 e2                	mul    %edx
c0101e7a:	89 d0                	mov    %edx,%eax
c0101e7c:	c1 e8 05             	shr    $0x5,%eax
c0101e7f:	6b c0 64             	imul   $0x64,%eax,%eax
c0101e82:	29 c1                	sub    %eax,%ecx
c0101e84:	89 c8                	mov    %ecx,%eax
c0101e86:	85 c0                	test   %eax,%eax
c0101e88:	0f 85 a2 00 00 00    	jne    c0101f30 <trap_dispatch+0x123>
		print_ticks();
c0101e8e:	e8 f4 fa ff ff       	call   c0101987 <print_ticks>
	}
        break;
c0101e93:	e9 98 00 00 00       	jmp    c0101f30 <trap_dispatch+0x123>
    case IRQ_OFFSET + IRQ_COM1:
        c = cons_getc();
c0101e98:	e8 7d f8 ff ff       	call   c010171a <cons_getc>
c0101e9d:	88 45 f7             	mov    %al,-0x9(%ebp)
        cprintf("serial [%03d] %c\n", c, c);
c0101ea0:	0f be 55 f7          	movsbl -0x9(%ebp),%edx
c0101ea4:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
c0101ea8:	83 ec 04             	sub    $0x4,%esp
c0101eab:	52                   	push   %edx
c0101eac:	50                   	push   %eax
c0101ead:	68 14 62 10 c0       	push   $0xc0106214
c0101eb2:	e8 d8 e3 ff ff       	call   c010028f <cprintf>
c0101eb7:	83 c4 10             	add    $0x10,%esp
        break;
c0101eba:	eb 75                	jmp    c0101f31 <trap_dispatch+0x124>
    case IRQ_OFFSET + IRQ_KBD:
        c = cons_getc();
c0101ebc:	e8 59 f8 ff ff       	call   c010171a <cons_getc>
c0101ec1:	88 45 f7             	mov    %al,-0x9(%ebp)
        cprintf("kbd [%03d] %c\n", c, c);
c0101ec4:	0f be 55 f7          	movsbl -0x9(%ebp),%edx
c0101ec8:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
c0101ecc:	83 ec 04             	sub    $0x4,%esp
c0101ecf:	52                   	push   %edx
c0101ed0:	50                   	push   %eax
c0101ed1:	68 26 62 10 c0       	push   $0xc0106226
c0101ed6:	e8 b4 e3 ff ff       	call   c010028f <cprintf>
c0101edb:	83 c4 10             	add    $0x10,%esp
        break;
c0101ede:	eb 51                	jmp    c0101f31 <trap_dispatch+0x124>
    //LAB1 CHALLENGE 1 : YOUR CODE you should modify below codes.
    case T_SWITCH_TOU:
    case T_SWITCH_TOK:
        panic("T_SWITCH_** ??\n");
c0101ee0:	83 ec 04             	sub    $0x4,%esp
c0101ee3:	68 35 62 10 c0       	push   $0xc0106235
c0101ee8:	68 ad 00 00 00       	push   $0xad
c0101eed:	68 45 62 10 c0       	push   $0xc0106245
c0101ef2:	e8 13 e5 ff ff       	call   c010040a <__panic>
    case IRQ_OFFSET + IRQ_IDE2:
        /* do nothing */
        break;
    default:
        // in kernel, it must be a mistake
        if ((tf->tf_cs & 3) == 0) {
c0101ef7:	8b 45 08             	mov    0x8(%ebp),%eax
c0101efa:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
c0101efe:	0f b7 c0             	movzwl %ax,%eax
c0101f01:	83 e0 03             	and    $0x3,%eax
c0101f04:	85 c0                	test   %eax,%eax
c0101f06:	75 29                	jne    c0101f31 <trap_dispatch+0x124>
            print_trapframe(tf);
c0101f08:	83 ec 0c             	sub    $0xc,%esp
c0101f0b:	ff 75 08             	pushl  0x8(%ebp)
c0101f0e:	e8 59 fc ff ff       	call   c0101b6c <print_trapframe>
c0101f13:	83 c4 10             	add    $0x10,%esp
            panic("unexpected trap in kernel.\n");
c0101f16:	83 ec 04             	sub    $0x4,%esp
c0101f19:	68 56 62 10 c0       	push   $0xc0106256
c0101f1e:	68 b7 00 00 00       	push   $0xb7
c0101f23:	68 45 62 10 c0       	push   $0xc0106245
c0101f28:	e8 dd e4 ff ff       	call   c010040a <__panic>
        break;
c0101f2d:	90                   	nop
c0101f2e:	eb 01                	jmp    c0101f31 <trap_dispatch+0x124>
        break;
c0101f30:	90                   	nop
        }
    }
}
c0101f31:	90                   	nop
c0101f32:	c9                   	leave  
c0101f33:	c3                   	ret    

c0101f34 <trap>:
 * trap - handles or dispatches an exception/interrupt. if and when trap() returns,
 * the code in kern/trap/trapentry.S restores the old CPU state saved in the
 * trapframe and then uses the iret instruction to return from the exception.
 * */
void
trap(struct trapframe *tf) {
c0101f34:	f3 0f 1e fb          	endbr32 
c0101f38:	55                   	push   %ebp
c0101f39:	89 e5                	mov    %esp,%ebp
c0101f3b:	83 ec 08             	sub    $0x8,%esp
    // dispatch based on what type of trap occurred
    trap_dispatch(tf);
c0101f3e:	83 ec 0c             	sub    $0xc,%esp
c0101f41:	ff 75 08             	pushl  0x8(%ebp)
c0101f44:	e8 c4 fe ff ff       	call   c0101e0d <trap_dispatch>
c0101f49:	83 c4 10             	add    $0x10,%esp
}
c0101f4c:	90                   	nop
c0101f4d:	c9                   	leave  
c0101f4e:	c3                   	ret    

c0101f4f <vector0>:
# handler
.text
.globl __alltraps
.globl vector0
vector0:
  pushl $0
c0101f4f:	6a 00                	push   $0x0
  pushl $0
c0101f51:	6a 00                	push   $0x0
  jmp __alltraps
c0101f53:	e9 67 0a 00 00       	jmp    c01029bf <__alltraps>

c0101f58 <vector1>:
.globl vector1
vector1:
  pushl $0
c0101f58:	6a 00                	push   $0x0
  pushl $1
c0101f5a:	6a 01                	push   $0x1
  jmp __alltraps
c0101f5c:	e9 5e 0a 00 00       	jmp    c01029bf <__alltraps>

c0101f61 <vector2>:
.globl vector2
vector2:
  pushl $0
c0101f61:	6a 00                	push   $0x0
  pushl $2
c0101f63:	6a 02                	push   $0x2
  jmp __alltraps
c0101f65:	e9 55 0a 00 00       	jmp    c01029bf <__alltraps>

c0101f6a <vector3>:
.globl vector3
vector3:
  pushl $0
c0101f6a:	6a 00                	push   $0x0
  pushl $3
c0101f6c:	6a 03                	push   $0x3
  jmp __alltraps
c0101f6e:	e9 4c 0a 00 00       	jmp    c01029bf <__alltraps>

c0101f73 <vector4>:
.globl vector4
vector4:
  pushl $0
c0101f73:	6a 00                	push   $0x0
  pushl $4
c0101f75:	6a 04                	push   $0x4
  jmp __alltraps
c0101f77:	e9 43 0a 00 00       	jmp    c01029bf <__alltraps>

c0101f7c <vector5>:
.globl vector5
vector5:
  pushl $0
c0101f7c:	6a 00                	push   $0x0
  pushl $5
c0101f7e:	6a 05                	push   $0x5
  jmp __alltraps
c0101f80:	e9 3a 0a 00 00       	jmp    c01029bf <__alltraps>

c0101f85 <vector6>:
.globl vector6
vector6:
  pushl $0
c0101f85:	6a 00                	push   $0x0
  pushl $6
c0101f87:	6a 06                	push   $0x6
  jmp __alltraps
c0101f89:	e9 31 0a 00 00       	jmp    c01029bf <__alltraps>

c0101f8e <vector7>:
.globl vector7
vector7:
  pushl $0
c0101f8e:	6a 00                	push   $0x0
  pushl $7
c0101f90:	6a 07                	push   $0x7
  jmp __alltraps
c0101f92:	e9 28 0a 00 00       	jmp    c01029bf <__alltraps>

c0101f97 <vector8>:
.globl vector8
vector8:
  pushl $8
c0101f97:	6a 08                	push   $0x8
  jmp __alltraps
c0101f99:	e9 21 0a 00 00       	jmp    c01029bf <__alltraps>

c0101f9e <vector9>:
.globl vector9
vector9:
  pushl $9
c0101f9e:	6a 09                	push   $0x9
  jmp __alltraps
c0101fa0:	e9 1a 0a 00 00       	jmp    c01029bf <__alltraps>

c0101fa5 <vector10>:
.globl vector10
vector10:
  pushl $10
c0101fa5:	6a 0a                	push   $0xa
  jmp __alltraps
c0101fa7:	e9 13 0a 00 00       	jmp    c01029bf <__alltraps>

c0101fac <vector11>:
.globl vector11
vector11:
  pushl $11
c0101fac:	6a 0b                	push   $0xb
  jmp __alltraps
c0101fae:	e9 0c 0a 00 00       	jmp    c01029bf <__alltraps>

c0101fb3 <vector12>:
.globl vector12
vector12:
  pushl $12
c0101fb3:	6a 0c                	push   $0xc
  jmp __alltraps
c0101fb5:	e9 05 0a 00 00       	jmp    c01029bf <__alltraps>

c0101fba <vector13>:
.globl vector13
vector13:
  pushl $13
c0101fba:	6a 0d                	push   $0xd
  jmp __alltraps
c0101fbc:	e9 fe 09 00 00       	jmp    c01029bf <__alltraps>

c0101fc1 <vector14>:
.globl vector14
vector14:
  pushl $14
c0101fc1:	6a 0e                	push   $0xe
  jmp __alltraps
c0101fc3:	e9 f7 09 00 00       	jmp    c01029bf <__alltraps>

c0101fc8 <vector15>:
.globl vector15
vector15:
  pushl $0
c0101fc8:	6a 00                	push   $0x0
  pushl $15
c0101fca:	6a 0f                	push   $0xf
  jmp __alltraps
c0101fcc:	e9 ee 09 00 00       	jmp    c01029bf <__alltraps>

c0101fd1 <vector16>:
.globl vector16
vector16:
  pushl $0
c0101fd1:	6a 00                	push   $0x0
  pushl $16
c0101fd3:	6a 10                	push   $0x10
  jmp __alltraps
c0101fd5:	e9 e5 09 00 00       	jmp    c01029bf <__alltraps>

c0101fda <vector17>:
.globl vector17
vector17:
  pushl $17
c0101fda:	6a 11                	push   $0x11
  jmp __alltraps
c0101fdc:	e9 de 09 00 00       	jmp    c01029bf <__alltraps>

c0101fe1 <vector18>:
.globl vector18
vector18:
  pushl $0
c0101fe1:	6a 00                	push   $0x0
  pushl $18
c0101fe3:	6a 12                	push   $0x12
  jmp __alltraps
c0101fe5:	e9 d5 09 00 00       	jmp    c01029bf <__alltraps>

c0101fea <vector19>:
.globl vector19
vector19:
  pushl $0
c0101fea:	6a 00                	push   $0x0
  pushl $19
c0101fec:	6a 13                	push   $0x13
  jmp __alltraps
c0101fee:	e9 cc 09 00 00       	jmp    c01029bf <__alltraps>

c0101ff3 <vector20>:
.globl vector20
vector20:
  pushl $0
c0101ff3:	6a 00                	push   $0x0
  pushl $20
c0101ff5:	6a 14                	push   $0x14
  jmp __alltraps
c0101ff7:	e9 c3 09 00 00       	jmp    c01029bf <__alltraps>

c0101ffc <vector21>:
.globl vector21
vector21:
  pushl $0
c0101ffc:	6a 00                	push   $0x0
  pushl $21
c0101ffe:	6a 15                	push   $0x15
  jmp __alltraps
c0102000:	e9 ba 09 00 00       	jmp    c01029bf <__alltraps>

c0102005 <vector22>:
.globl vector22
vector22:
  pushl $0
c0102005:	6a 00                	push   $0x0
  pushl $22
c0102007:	6a 16                	push   $0x16
  jmp __alltraps
c0102009:	e9 b1 09 00 00       	jmp    c01029bf <__alltraps>

c010200e <vector23>:
.globl vector23
vector23:
  pushl $0
c010200e:	6a 00                	push   $0x0
  pushl $23
c0102010:	6a 17                	push   $0x17
  jmp __alltraps
c0102012:	e9 a8 09 00 00       	jmp    c01029bf <__alltraps>

c0102017 <vector24>:
.globl vector24
vector24:
  pushl $0
c0102017:	6a 00                	push   $0x0
  pushl $24
c0102019:	6a 18                	push   $0x18
  jmp __alltraps
c010201b:	e9 9f 09 00 00       	jmp    c01029bf <__alltraps>

c0102020 <vector25>:
.globl vector25
vector25:
  pushl $0
c0102020:	6a 00                	push   $0x0
  pushl $25
c0102022:	6a 19                	push   $0x19
  jmp __alltraps
c0102024:	e9 96 09 00 00       	jmp    c01029bf <__alltraps>

c0102029 <vector26>:
.globl vector26
vector26:
  pushl $0
c0102029:	6a 00                	push   $0x0
  pushl $26
c010202b:	6a 1a                	push   $0x1a
  jmp __alltraps
c010202d:	e9 8d 09 00 00       	jmp    c01029bf <__alltraps>

c0102032 <vector27>:
.globl vector27
vector27:
  pushl $0
c0102032:	6a 00                	push   $0x0
  pushl $27
c0102034:	6a 1b                	push   $0x1b
  jmp __alltraps
c0102036:	e9 84 09 00 00       	jmp    c01029bf <__alltraps>

c010203b <vector28>:
.globl vector28
vector28:
  pushl $0
c010203b:	6a 00                	push   $0x0
  pushl $28
c010203d:	6a 1c                	push   $0x1c
  jmp __alltraps
c010203f:	e9 7b 09 00 00       	jmp    c01029bf <__alltraps>

c0102044 <vector29>:
.globl vector29
vector29:
  pushl $0
c0102044:	6a 00                	push   $0x0
  pushl $29
c0102046:	6a 1d                	push   $0x1d
  jmp __alltraps
c0102048:	e9 72 09 00 00       	jmp    c01029bf <__alltraps>

c010204d <vector30>:
.globl vector30
vector30:
  pushl $0
c010204d:	6a 00                	push   $0x0
  pushl $30
c010204f:	6a 1e                	push   $0x1e
  jmp __alltraps
c0102051:	e9 69 09 00 00       	jmp    c01029bf <__alltraps>

c0102056 <vector31>:
.globl vector31
vector31:
  pushl $0
c0102056:	6a 00                	push   $0x0
  pushl $31
c0102058:	6a 1f                	push   $0x1f
  jmp __alltraps
c010205a:	e9 60 09 00 00       	jmp    c01029bf <__alltraps>

c010205f <vector32>:
.globl vector32
vector32:
  pushl $0
c010205f:	6a 00                	push   $0x0
  pushl $32
c0102061:	6a 20                	push   $0x20
  jmp __alltraps
c0102063:	e9 57 09 00 00       	jmp    c01029bf <__alltraps>

c0102068 <vector33>:
.globl vector33
vector33:
  pushl $0
c0102068:	6a 00                	push   $0x0
  pushl $33
c010206a:	6a 21                	push   $0x21
  jmp __alltraps
c010206c:	e9 4e 09 00 00       	jmp    c01029bf <__alltraps>

c0102071 <vector34>:
.globl vector34
vector34:
  pushl $0
c0102071:	6a 00                	push   $0x0
  pushl $34
c0102073:	6a 22                	push   $0x22
  jmp __alltraps
c0102075:	e9 45 09 00 00       	jmp    c01029bf <__alltraps>

c010207a <vector35>:
.globl vector35
vector35:
  pushl $0
c010207a:	6a 00                	push   $0x0
  pushl $35
c010207c:	6a 23                	push   $0x23
  jmp __alltraps
c010207e:	e9 3c 09 00 00       	jmp    c01029bf <__alltraps>

c0102083 <vector36>:
.globl vector36
vector36:
  pushl $0
c0102083:	6a 00                	push   $0x0
  pushl $36
c0102085:	6a 24                	push   $0x24
  jmp __alltraps
c0102087:	e9 33 09 00 00       	jmp    c01029bf <__alltraps>

c010208c <vector37>:
.globl vector37
vector37:
  pushl $0
c010208c:	6a 00                	push   $0x0
  pushl $37
c010208e:	6a 25                	push   $0x25
  jmp __alltraps
c0102090:	e9 2a 09 00 00       	jmp    c01029bf <__alltraps>

c0102095 <vector38>:
.globl vector38
vector38:
  pushl $0
c0102095:	6a 00                	push   $0x0
  pushl $38
c0102097:	6a 26                	push   $0x26
  jmp __alltraps
c0102099:	e9 21 09 00 00       	jmp    c01029bf <__alltraps>

c010209e <vector39>:
.globl vector39
vector39:
  pushl $0
c010209e:	6a 00                	push   $0x0
  pushl $39
c01020a0:	6a 27                	push   $0x27
  jmp __alltraps
c01020a2:	e9 18 09 00 00       	jmp    c01029bf <__alltraps>

c01020a7 <vector40>:
.globl vector40
vector40:
  pushl $0
c01020a7:	6a 00                	push   $0x0
  pushl $40
c01020a9:	6a 28                	push   $0x28
  jmp __alltraps
c01020ab:	e9 0f 09 00 00       	jmp    c01029bf <__alltraps>

c01020b0 <vector41>:
.globl vector41
vector41:
  pushl $0
c01020b0:	6a 00                	push   $0x0
  pushl $41
c01020b2:	6a 29                	push   $0x29
  jmp __alltraps
c01020b4:	e9 06 09 00 00       	jmp    c01029bf <__alltraps>

c01020b9 <vector42>:
.globl vector42
vector42:
  pushl $0
c01020b9:	6a 00                	push   $0x0
  pushl $42
c01020bb:	6a 2a                	push   $0x2a
  jmp __alltraps
c01020bd:	e9 fd 08 00 00       	jmp    c01029bf <__alltraps>

c01020c2 <vector43>:
.globl vector43
vector43:
  pushl $0
c01020c2:	6a 00                	push   $0x0
  pushl $43
c01020c4:	6a 2b                	push   $0x2b
  jmp __alltraps
c01020c6:	e9 f4 08 00 00       	jmp    c01029bf <__alltraps>

c01020cb <vector44>:
.globl vector44
vector44:
  pushl $0
c01020cb:	6a 00                	push   $0x0
  pushl $44
c01020cd:	6a 2c                	push   $0x2c
  jmp __alltraps
c01020cf:	e9 eb 08 00 00       	jmp    c01029bf <__alltraps>

c01020d4 <vector45>:
.globl vector45
vector45:
  pushl $0
c01020d4:	6a 00                	push   $0x0
  pushl $45
c01020d6:	6a 2d                	push   $0x2d
  jmp __alltraps
c01020d8:	e9 e2 08 00 00       	jmp    c01029bf <__alltraps>

c01020dd <vector46>:
.globl vector46
vector46:
  pushl $0
c01020dd:	6a 00                	push   $0x0
  pushl $46
c01020df:	6a 2e                	push   $0x2e
  jmp __alltraps
c01020e1:	e9 d9 08 00 00       	jmp    c01029bf <__alltraps>

c01020e6 <vector47>:
.globl vector47
vector47:
  pushl $0
c01020e6:	6a 00                	push   $0x0
  pushl $47
c01020e8:	6a 2f                	push   $0x2f
  jmp __alltraps
c01020ea:	e9 d0 08 00 00       	jmp    c01029bf <__alltraps>

c01020ef <vector48>:
.globl vector48
vector48:
  pushl $0
c01020ef:	6a 00                	push   $0x0
  pushl $48
c01020f1:	6a 30                	push   $0x30
  jmp __alltraps
c01020f3:	e9 c7 08 00 00       	jmp    c01029bf <__alltraps>

c01020f8 <vector49>:
.globl vector49
vector49:
  pushl $0
c01020f8:	6a 00                	push   $0x0
  pushl $49
c01020fa:	6a 31                	push   $0x31
  jmp __alltraps
c01020fc:	e9 be 08 00 00       	jmp    c01029bf <__alltraps>

c0102101 <vector50>:
.globl vector50
vector50:
  pushl $0
c0102101:	6a 00                	push   $0x0
  pushl $50
c0102103:	6a 32                	push   $0x32
  jmp __alltraps
c0102105:	e9 b5 08 00 00       	jmp    c01029bf <__alltraps>

c010210a <vector51>:
.globl vector51
vector51:
  pushl $0
c010210a:	6a 00                	push   $0x0
  pushl $51
c010210c:	6a 33                	push   $0x33
  jmp __alltraps
c010210e:	e9 ac 08 00 00       	jmp    c01029bf <__alltraps>

c0102113 <vector52>:
.globl vector52
vector52:
  pushl $0
c0102113:	6a 00                	push   $0x0
  pushl $52
c0102115:	6a 34                	push   $0x34
  jmp __alltraps
c0102117:	e9 a3 08 00 00       	jmp    c01029bf <__alltraps>

c010211c <vector53>:
.globl vector53
vector53:
  pushl $0
c010211c:	6a 00                	push   $0x0
  pushl $53
c010211e:	6a 35                	push   $0x35
  jmp __alltraps
c0102120:	e9 9a 08 00 00       	jmp    c01029bf <__alltraps>

c0102125 <vector54>:
.globl vector54
vector54:
  pushl $0
c0102125:	6a 00                	push   $0x0
  pushl $54
c0102127:	6a 36                	push   $0x36
  jmp __alltraps
c0102129:	e9 91 08 00 00       	jmp    c01029bf <__alltraps>

c010212e <vector55>:
.globl vector55
vector55:
  pushl $0
c010212e:	6a 00                	push   $0x0
  pushl $55
c0102130:	6a 37                	push   $0x37
  jmp __alltraps
c0102132:	e9 88 08 00 00       	jmp    c01029bf <__alltraps>

c0102137 <vector56>:
.globl vector56
vector56:
  pushl $0
c0102137:	6a 00                	push   $0x0
  pushl $56
c0102139:	6a 38                	push   $0x38
  jmp __alltraps
c010213b:	e9 7f 08 00 00       	jmp    c01029bf <__alltraps>

c0102140 <vector57>:
.globl vector57
vector57:
  pushl $0
c0102140:	6a 00                	push   $0x0
  pushl $57
c0102142:	6a 39                	push   $0x39
  jmp __alltraps
c0102144:	e9 76 08 00 00       	jmp    c01029bf <__alltraps>

c0102149 <vector58>:
.globl vector58
vector58:
  pushl $0
c0102149:	6a 00                	push   $0x0
  pushl $58
c010214b:	6a 3a                	push   $0x3a
  jmp __alltraps
c010214d:	e9 6d 08 00 00       	jmp    c01029bf <__alltraps>

c0102152 <vector59>:
.globl vector59
vector59:
  pushl $0
c0102152:	6a 00                	push   $0x0
  pushl $59
c0102154:	6a 3b                	push   $0x3b
  jmp __alltraps
c0102156:	e9 64 08 00 00       	jmp    c01029bf <__alltraps>

c010215b <vector60>:
.globl vector60
vector60:
  pushl $0
c010215b:	6a 00                	push   $0x0
  pushl $60
c010215d:	6a 3c                	push   $0x3c
  jmp __alltraps
c010215f:	e9 5b 08 00 00       	jmp    c01029bf <__alltraps>

c0102164 <vector61>:
.globl vector61
vector61:
  pushl $0
c0102164:	6a 00                	push   $0x0
  pushl $61
c0102166:	6a 3d                	push   $0x3d
  jmp __alltraps
c0102168:	e9 52 08 00 00       	jmp    c01029bf <__alltraps>

c010216d <vector62>:
.globl vector62
vector62:
  pushl $0
c010216d:	6a 00                	push   $0x0
  pushl $62
c010216f:	6a 3e                	push   $0x3e
  jmp __alltraps
c0102171:	e9 49 08 00 00       	jmp    c01029bf <__alltraps>

c0102176 <vector63>:
.globl vector63
vector63:
  pushl $0
c0102176:	6a 00                	push   $0x0
  pushl $63
c0102178:	6a 3f                	push   $0x3f
  jmp __alltraps
c010217a:	e9 40 08 00 00       	jmp    c01029bf <__alltraps>

c010217f <vector64>:
.globl vector64
vector64:
  pushl $0
c010217f:	6a 00                	push   $0x0
  pushl $64
c0102181:	6a 40                	push   $0x40
  jmp __alltraps
c0102183:	e9 37 08 00 00       	jmp    c01029bf <__alltraps>

c0102188 <vector65>:
.globl vector65
vector65:
  pushl $0
c0102188:	6a 00                	push   $0x0
  pushl $65
c010218a:	6a 41                	push   $0x41
  jmp __alltraps
c010218c:	e9 2e 08 00 00       	jmp    c01029bf <__alltraps>

c0102191 <vector66>:
.globl vector66
vector66:
  pushl $0
c0102191:	6a 00                	push   $0x0
  pushl $66
c0102193:	6a 42                	push   $0x42
  jmp __alltraps
c0102195:	e9 25 08 00 00       	jmp    c01029bf <__alltraps>

c010219a <vector67>:
.globl vector67
vector67:
  pushl $0
c010219a:	6a 00                	push   $0x0
  pushl $67
c010219c:	6a 43                	push   $0x43
  jmp __alltraps
c010219e:	e9 1c 08 00 00       	jmp    c01029bf <__alltraps>

c01021a3 <vector68>:
.globl vector68
vector68:
  pushl $0
c01021a3:	6a 00                	push   $0x0
  pushl $68
c01021a5:	6a 44                	push   $0x44
  jmp __alltraps
c01021a7:	e9 13 08 00 00       	jmp    c01029bf <__alltraps>

c01021ac <vector69>:
.globl vector69
vector69:
  pushl $0
c01021ac:	6a 00                	push   $0x0
  pushl $69
c01021ae:	6a 45                	push   $0x45
  jmp __alltraps
c01021b0:	e9 0a 08 00 00       	jmp    c01029bf <__alltraps>

c01021b5 <vector70>:
.globl vector70
vector70:
  pushl $0
c01021b5:	6a 00                	push   $0x0
  pushl $70
c01021b7:	6a 46                	push   $0x46
  jmp __alltraps
c01021b9:	e9 01 08 00 00       	jmp    c01029bf <__alltraps>

c01021be <vector71>:
.globl vector71
vector71:
  pushl $0
c01021be:	6a 00                	push   $0x0
  pushl $71
c01021c0:	6a 47                	push   $0x47
  jmp __alltraps
c01021c2:	e9 f8 07 00 00       	jmp    c01029bf <__alltraps>

c01021c7 <vector72>:
.globl vector72
vector72:
  pushl $0
c01021c7:	6a 00                	push   $0x0
  pushl $72
c01021c9:	6a 48                	push   $0x48
  jmp __alltraps
c01021cb:	e9 ef 07 00 00       	jmp    c01029bf <__alltraps>

c01021d0 <vector73>:
.globl vector73
vector73:
  pushl $0
c01021d0:	6a 00                	push   $0x0
  pushl $73
c01021d2:	6a 49                	push   $0x49
  jmp __alltraps
c01021d4:	e9 e6 07 00 00       	jmp    c01029bf <__alltraps>

c01021d9 <vector74>:
.globl vector74
vector74:
  pushl $0
c01021d9:	6a 00                	push   $0x0
  pushl $74
c01021db:	6a 4a                	push   $0x4a
  jmp __alltraps
c01021dd:	e9 dd 07 00 00       	jmp    c01029bf <__alltraps>

c01021e2 <vector75>:
.globl vector75
vector75:
  pushl $0
c01021e2:	6a 00                	push   $0x0
  pushl $75
c01021e4:	6a 4b                	push   $0x4b
  jmp __alltraps
c01021e6:	e9 d4 07 00 00       	jmp    c01029bf <__alltraps>

c01021eb <vector76>:
.globl vector76
vector76:
  pushl $0
c01021eb:	6a 00                	push   $0x0
  pushl $76
c01021ed:	6a 4c                	push   $0x4c
  jmp __alltraps
c01021ef:	e9 cb 07 00 00       	jmp    c01029bf <__alltraps>

c01021f4 <vector77>:
.globl vector77
vector77:
  pushl $0
c01021f4:	6a 00                	push   $0x0
  pushl $77
c01021f6:	6a 4d                	push   $0x4d
  jmp __alltraps
c01021f8:	e9 c2 07 00 00       	jmp    c01029bf <__alltraps>

c01021fd <vector78>:
.globl vector78
vector78:
  pushl $0
c01021fd:	6a 00                	push   $0x0
  pushl $78
c01021ff:	6a 4e                	push   $0x4e
  jmp __alltraps
c0102201:	e9 b9 07 00 00       	jmp    c01029bf <__alltraps>

c0102206 <vector79>:
.globl vector79
vector79:
  pushl $0
c0102206:	6a 00                	push   $0x0
  pushl $79
c0102208:	6a 4f                	push   $0x4f
  jmp __alltraps
c010220a:	e9 b0 07 00 00       	jmp    c01029bf <__alltraps>

c010220f <vector80>:
.globl vector80
vector80:
  pushl $0
c010220f:	6a 00                	push   $0x0
  pushl $80
c0102211:	6a 50                	push   $0x50
  jmp __alltraps
c0102213:	e9 a7 07 00 00       	jmp    c01029bf <__alltraps>

c0102218 <vector81>:
.globl vector81
vector81:
  pushl $0
c0102218:	6a 00                	push   $0x0
  pushl $81
c010221a:	6a 51                	push   $0x51
  jmp __alltraps
c010221c:	e9 9e 07 00 00       	jmp    c01029bf <__alltraps>

c0102221 <vector82>:
.globl vector82
vector82:
  pushl $0
c0102221:	6a 00                	push   $0x0
  pushl $82
c0102223:	6a 52                	push   $0x52
  jmp __alltraps
c0102225:	e9 95 07 00 00       	jmp    c01029bf <__alltraps>

c010222a <vector83>:
.globl vector83
vector83:
  pushl $0
c010222a:	6a 00                	push   $0x0
  pushl $83
c010222c:	6a 53                	push   $0x53
  jmp __alltraps
c010222e:	e9 8c 07 00 00       	jmp    c01029bf <__alltraps>

c0102233 <vector84>:
.globl vector84
vector84:
  pushl $0
c0102233:	6a 00                	push   $0x0
  pushl $84
c0102235:	6a 54                	push   $0x54
  jmp __alltraps
c0102237:	e9 83 07 00 00       	jmp    c01029bf <__alltraps>

c010223c <vector85>:
.globl vector85
vector85:
  pushl $0
c010223c:	6a 00                	push   $0x0
  pushl $85
c010223e:	6a 55                	push   $0x55
  jmp __alltraps
c0102240:	e9 7a 07 00 00       	jmp    c01029bf <__alltraps>

c0102245 <vector86>:
.globl vector86
vector86:
  pushl $0
c0102245:	6a 00                	push   $0x0
  pushl $86
c0102247:	6a 56                	push   $0x56
  jmp __alltraps
c0102249:	e9 71 07 00 00       	jmp    c01029bf <__alltraps>

c010224e <vector87>:
.globl vector87
vector87:
  pushl $0
c010224e:	6a 00                	push   $0x0
  pushl $87
c0102250:	6a 57                	push   $0x57
  jmp __alltraps
c0102252:	e9 68 07 00 00       	jmp    c01029bf <__alltraps>

c0102257 <vector88>:
.globl vector88
vector88:
  pushl $0
c0102257:	6a 00                	push   $0x0
  pushl $88
c0102259:	6a 58                	push   $0x58
  jmp __alltraps
c010225b:	e9 5f 07 00 00       	jmp    c01029bf <__alltraps>

c0102260 <vector89>:
.globl vector89
vector89:
  pushl $0
c0102260:	6a 00                	push   $0x0
  pushl $89
c0102262:	6a 59                	push   $0x59
  jmp __alltraps
c0102264:	e9 56 07 00 00       	jmp    c01029bf <__alltraps>

c0102269 <vector90>:
.globl vector90
vector90:
  pushl $0
c0102269:	6a 00                	push   $0x0
  pushl $90
c010226b:	6a 5a                	push   $0x5a
  jmp __alltraps
c010226d:	e9 4d 07 00 00       	jmp    c01029bf <__alltraps>

c0102272 <vector91>:
.globl vector91
vector91:
  pushl $0
c0102272:	6a 00                	push   $0x0
  pushl $91
c0102274:	6a 5b                	push   $0x5b
  jmp __alltraps
c0102276:	e9 44 07 00 00       	jmp    c01029bf <__alltraps>

c010227b <vector92>:
.globl vector92
vector92:
  pushl $0
c010227b:	6a 00                	push   $0x0
  pushl $92
c010227d:	6a 5c                	push   $0x5c
  jmp __alltraps
c010227f:	e9 3b 07 00 00       	jmp    c01029bf <__alltraps>

c0102284 <vector93>:
.globl vector93
vector93:
  pushl $0
c0102284:	6a 00                	push   $0x0
  pushl $93
c0102286:	6a 5d                	push   $0x5d
  jmp __alltraps
c0102288:	e9 32 07 00 00       	jmp    c01029bf <__alltraps>

c010228d <vector94>:
.globl vector94
vector94:
  pushl $0
c010228d:	6a 00                	push   $0x0
  pushl $94
c010228f:	6a 5e                	push   $0x5e
  jmp __alltraps
c0102291:	e9 29 07 00 00       	jmp    c01029bf <__alltraps>

c0102296 <vector95>:
.globl vector95
vector95:
  pushl $0
c0102296:	6a 00                	push   $0x0
  pushl $95
c0102298:	6a 5f                	push   $0x5f
  jmp __alltraps
c010229a:	e9 20 07 00 00       	jmp    c01029bf <__alltraps>

c010229f <vector96>:
.globl vector96
vector96:
  pushl $0
c010229f:	6a 00                	push   $0x0
  pushl $96
c01022a1:	6a 60                	push   $0x60
  jmp __alltraps
c01022a3:	e9 17 07 00 00       	jmp    c01029bf <__alltraps>

c01022a8 <vector97>:
.globl vector97
vector97:
  pushl $0
c01022a8:	6a 00                	push   $0x0
  pushl $97
c01022aa:	6a 61                	push   $0x61
  jmp __alltraps
c01022ac:	e9 0e 07 00 00       	jmp    c01029bf <__alltraps>

c01022b1 <vector98>:
.globl vector98
vector98:
  pushl $0
c01022b1:	6a 00                	push   $0x0
  pushl $98
c01022b3:	6a 62                	push   $0x62
  jmp __alltraps
c01022b5:	e9 05 07 00 00       	jmp    c01029bf <__alltraps>

c01022ba <vector99>:
.globl vector99
vector99:
  pushl $0
c01022ba:	6a 00                	push   $0x0
  pushl $99
c01022bc:	6a 63                	push   $0x63
  jmp __alltraps
c01022be:	e9 fc 06 00 00       	jmp    c01029bf <__alltraps>

c01022c3 <vector100>:
.globl vector100
vector100:
  pushl $0
c01022c3:	6a 00                	push   $0x0
  pushl $100
c01022c5:	6a 64                	push   $0x64
  jmp __alltraps
c01022c7:	e9 f3 06 00 00       	jmp    c01029bf <__alltraps>

c01022cc <vector101>:
.globl vector101
vector101:
  pushl $0
c01022cc:	6a 00                	push   $0x0
  pushl $101
c01022ce:	6a 65                	push   $0x65
  jmp __alltraps
c01022d0:	e9 ea 06 00 00       	jmp    c01029bf <__alltraps>

c01022d5 <vector102>:
.globl vector102
vector102:
  pushl $0
c01022d5:	6a 00                	push   $0x0
  pushl $102
c01022d7:	6a 66                	push   $0x66
  jmp __alltraps
c01022d9:	e9 e1 06 00 00       	jmp    c01029bf <__alltraps>

c01022de <vector103>:
.globl vector103
vector103:
  pushl $0
c01022de:	6a 00                	push   $0x0
  pushl $103
c01022e0:	6a 67                	push   $0x67
  jmp __alltraps
c01022e2:	e9 d8 06 00 00       	jmp    c01029bf <__alltraps>

c01022e7 <vector104>:
.globl vector104
vector104:
  pushl $0
c01022e7:	6a 00                	push   $0x0
  pushl $104
c01022e9:	6a 68                	push   $0x68
  jmp __alltraps
c01022eb:	e9 cf 06 00 00       	jmp    c01029bf <__alltraps>

c01022f0 <vector105>:
.globl vector105
vector105:
  pushl $0
c01022f0:	6a 00                	push   $0x0
  pushl $105
c01022f2:	6a 69                	push   $0x69
  jmp __alltraps
c01022f4:	e9 c6 06 00 00       	jmp    c01029bf <__alltraps>

c01022f9 <vector106>:
.globl vector106
vector106:
  pushl $0
c01022f9:	6a 00                	push   $0x0
  pushl $106
c01022fb:	6a 6a                	push   $0x6a
  jmp __alltraps
c01022fd:	e9 bd 06 00 00       	jmp    c01029bf <__alltraps>

c0102302 <vector107>:
.globl vector107
vector107:
  pushl $0
c0102302:	6a 00                	push   $0x0
  pushl $107
c0102304:	6a 6b                	push   $0x6b
  jmp __alltraps
c0102306:	e9 b4 06 00 00       	jmp    c01029bf <__alltraps>

c010230b <vector108>:
.globl vector108
vector108:
  pushl $0
c010230b:	6a 00                	push   $0x0
  pushl $108
c010230d:	6a 6c                	push   $0x6c
  jmp __alltraps
c010230f:	e9 ab 06 00 00       	jmp    c01029bf <__alltraps>

c0102314 <vector109>:
.globl vector109
vector109:
  pushl $0
c0102314:	6a 00                	push   $0x0
  pushl $109
c0102316:	6a 6d                	push   $0x6d
  jmp __alltraps
c0102318:	e9 a2 06 00 00       	jmp    c01029bf <__alltraps>

c010231d <vector110>:
.globl vector110
vector110:
  pushl $0
c010231d:	6a 00                	push   $0x0
  pushl $110
c010231f:	6a 6e                	push   $0x6e
  jmp __alltraps
c0102321:	e9 99 06 00 00       	jmp    c01029bf <__alltraps>

c0102326 <vector111>:
.globl vector111
vector111:
  pushl $0
c0102326:	6a 00                	push   $0x0
  pushl $111
c0102328:	6a 6f                	push   $0x6f
  jmp __alltraps
c010232a:	e9 90 06 00 00       	jmp    c01029bf <__alltraps>

c010232f <vector112>:
.globl vector112
vector112:
  pushl $0
c010232f:	6a 00                	push   $0x0
  pushl $112
c0102331:	6a 70                	push   $0x70
  jmp __alltraps
c0102333:	e9 87 06 00 00       	jmp    c01029bf <__alltraps>

c0102338 <vector113>:
.globl vector113
vector113:
  pushl $0
c0102338:	6a 00                	push   $0x0
  pushl $113
c010233a:	6a 71                	push   $0x71
  jmp __alltraps
c010233c:	e9 7e 06 00 00       	jmp    c01029bf <__alltraps>

c0102341 <vector114>:
.globl vector114
vector114:
  pushl $0
c0102341:	6a 00                	push   $0x0
  pushl $114
c0102343:	6a 72                	push   $0x72
  jmp __alltraps
c0102345:	e9 75 06 00 00       	jmp    c01029bf <__alltraps>

c010234a <vector115>:
.globl vector115
vector115:
  pushl $0
c010234a:	6a 00                	push   $0x0
  pushl $115
c010234c:	6a 73                	push   $0x73
  jmp __alltraps
c010234e:	e9 6c 06 00 00       	jmp    c01029bf <__alltraps>

c0102353 <vector116>:
.globl vector116
vector116:
  pushl $0
c0102353:	6a 00                	push   $0x0
  pushl $116
c0102355:	6a 74                	push   $0x74
  jmp __alltraps
c0102357:	e9 63 06 00 00       	jmp    c01029bf <__alltraps>

c010235c <vector117>:
.globl vector117
vector117:
  pushl $0
c010235c:	6a 00                	push   $0x0
  pushl $117
c010235e:	6a 75                	push   $0x75
  jmp __alltraps
c0102360:	e9 5a 06 00 00       	jmp    c01029bf <__alltraps>

c0102365 <vector118>:
.globl vector118
vector118:
  pushl $0
c0102365:	6a 00                	push   $0x0
  pushl $118
c0102367:	6a 76                	push   $0x76
  jmp __alltraps
c0102369:	e9 51 06 00 00       	jmp    c01029bf <__alltraps>

c010236e <vector119>:
.globl vector119
vector119:
  pushl $0
c010236e:	6a 00                	push   $0x0
  pushl $119
c0102370:	6a 77                	push   $0x77
  jmp __alltraps
c0102372:	e9 48 06 00 00       	jmp    c01029bf <__alltraps>

c0102377 <vector120>:
.globl vector120
vector120:
  pushl $0
c0102377:	6a 00                	push   $0x0
  pushl $120
c0102379:	6a 78                	push   $0x78
  jmp __alltraps
c010237b:	e9 3f 06 00 00       	jmp    c01029bf <__alltraps>

c0102380 <vector121>:
.globl vector121
vector121:
  pushl $0
c0102380:	6a 00                	push   $0x0
  pushl $121
c0102382:	6a 79                	push   $0x79
  jmp __alltraps
c0102384:	e9 36 06 00 00       	jmp    c01029bf <__alltraps>

c0102389 <vector122>:
.globl vector122
vector122:
  pushl $0
c0102389:	6a 00                	push   $0x0
  pushl $122
c010238b:	6a 7a                	push   $0x7a
  jmp __alltraps
c010238d:	e9 2d 06 00 00       	jmp    c01029bf <__alltraps>

c0102392 <vector123>:
.globl vector123
vector123:
  pushl $0
c0102392:	6a 00                	push   $0x0
  pushl $123
c0102394:	6a 7b                	push   $0x7b
  jmp __alltraps
c0102396:	e9 24 06 00 00       	jmp    c01029bf <__alltraps>

c010239b <vector124>:
.globl vector124
vector124:
  pushl $0
c010239b:	6a 00                	push   $0x0
  pushl $124
c010239d:	6a 7c                	push   $0x7c
  jmp __alltraps
c010239f:	e9 1b 06 00 00       	jmp    c01029bf <__alltraps>

c01023a4 <vector125>:
.globl vector125
vector125:
  pushl $0
c01023a4:	6a 00                	push   $0x0
  pushl $125
c01023a6:	6a 7d                	push   $0x7d
  jmp __alltraps
c01023a8:	e9 12 06 00 00       	jmp    c01029bf <__alltraps>

c01023ad <vector126>:
.globl vector126
vector126:
  pushl $0
c01023ad:	6a 00                	push   $0x0
  pushl $126
c01023af:	6a 7e                	push   $0x7e
  jmp __alltraps
c01023b1:	e9 09 06 00 00       	jmp    c01029bf <__alltraps>

c01023b6 <vector127>:
.globl vector127
vector127:
  pushl $0
c01023b6:	6a 00                	push   $0x0
  pushl $127
c01023b8:	6a 7f                	push   $0x7f
  jmp __alltraps
c01023ba:	e9 00 06 00 00       	jmp    c01029bf <__alltraps>

c01023bf <vector128>:
.globl vector128
vector128:
  pushl $0
c01023bf:	6a 00                	push   $0x0
  pushl $128
c01023c1:	68 80 00 00 00       	push   $0x80
  jmp __alltraps
c01023c6:	e9 f4 05 00 00       	jmp    c01029bf <__alltraps>

c01023cb <vector129>:
.globl vector129
vector129:
  pushl $0
c01023cb:	6a 00                	push   $0x0
  pushl $129
c01023cd:	68 81 00 00 00       	push   $0x81
  jmp __alltraps
c01023d2:	e9 e8 05 00 00       	jmp    c01029bf <__alltraps>

c01023d7 <vector130>:
.globl vector130
vector130:
  pushl $0
c01023d7:	6a 00                	push   $0x0
  pushl $130
c01023d9:	68 82 00 00 00       	push   $0x82
  jmp __alltraps
c01023de:	e9 dc 05 00 00       	jmp    c01029bf <__alltraps>

c01023e3 <vector131>:
.globl vector131
vector131:
  pushl $0
c01023e3:	6a 00                	push   $0x0
  pushl $131
c01023e5:	68 83 00 00 00       	push   $0x83
  jmp __alltraps
c01023ea:	e9 d0 05 00 00       	jmp    c01029bf <__alltraps>

c01023ef <vector132>:
.globl vector132
vector132:
  pushl $0
c01023ef:	6a 00                	push   $0x0
  pushl $132
c01023f1:	68 84 00 00 00       	push   $0x84
  jmp __alltraps
c01023f6:	e9 c4 05 00 00       	jmp    c01029bf <__alltraps>

c01023fb <vector133>:
.globl vector133
vector133:
  pushl $0
c01023fb:	6a 00                	push   $0x0
  pushl $133
c01023fd:	68 85 00 00 00       	push   $0x85
  jmp __alltraps
c0102402:	e9 b8 05 00 00       	jmp    c01029bf <__alltraps>

c0102407 <vector134>:
.globl vector134
vector134:
  pushl $0
c0102407:	6a 00                	push   $0x0
  pushl $134
c0102409:	68 86 00 00 00       	push   $0x86
  jmp __alltraps
c010240e:	e9 ac 05 00 00       	jmp    c01029bf <__alltraps>

c0102413 <vector135>:
.globl vector135
vector135:
  pushl $0
c0102413:	6a 00                	push   $0x0
  pushl $135
c0102415:	68 87 00 00 00       	push   $0x87
  jmp __alltraps
c010241a:	e9 a0 05 00 00       	jmp    c01029bf <__alltraps>

c010241f <vector136>:
.globl vector136
vector136:
  pushl $0
c010241f:	6a 00                	push   $0x0
  pushl $136
c0102421:	68 88 00 00 00       	push   $0x88
  jmp __alltraps
c0102426:	e9 94 05 00 00       	jmp    c01029bf <__alltraps>

c010242b <vector137>:
.globl vector137
vector137:
  pushl $0
c010242b:	6a 00                	push   $0x0
  pushl $137
c010242d:	68 89 00 00 00       	push   $0x89
  jmp __alltraps
c0102432:	e9 88 05 00 00       	jmp    c01029bf <__alltraps>

c0102437 <vector138>:
.globl vector138
vector138:
  pushl $0
c0102437:	6a 00                	push   $0x0
  pushl $138
c0102439:	68 8a 00 00 00       	push   $0x8a
  jmp __alltraps
c010243e:	e9 7c 05 00 00       	jmp    c01029bf <__alltraps>

c0102443 <vector139>:
.globl vector139
vector139:
  pushl $0
c0102443:	6a 00                	push   $0x0
  pushl $139
c0102445:	68 8b 00 00 00       	push   $0x8b
  jmp __alltraps
c010244a:	e9 70 05 00 00       	jmp    c01029bf <__alltraps>

c010244f <vector140>:
.globl vector140
vector140:
  pushl $0
c010244f:	6a 00                	push   $0x0
  pushl $140
c0102451:	68 8c 00 00 00       	push   $0x8c
  jmp __alltraps
c0102456:	e9 64 05 00 00       	jmp    c01029bf <__alltraps>

c010245b <vector141>:
.globl vector141
vector141:
  pushl $0
c010245b:	6a 00                	push   $0x0
  pushl $141
c010245d:	68 8d 00 00 00       	push   $0x8d
  jmp __alltraps
c0102462:	e9 58 05 00 00       	jmp    c01029bf <__alltraps>

c0102467 <vector142>:
.globl vector142
vector142:
  pushl $0
c0102467:	6a 00                	push   $0x0
  pushl $142
c0102469:	68 8e 00 00 00       	push   $0x8e
  jmp __alltraps
c010246e:	e9 4c 05 00 00       	jmp    c01029bf <__alltraps>

c0102473 <vector143>:
.globl vector143
vector143:
  pushl $0
c0102473:	6a 00                	push   $0x0
  pushl $143
c0102475:	68 8f 00 00 00       	push   $0x8f
  jmp __alltraps
c010247a:	e9 40 05 00 00       	jmp    c01029bf <__alltraps>

c010247f <vector144>:
.globl vector144
vector144:
  pushl $0
c010247f:	6a 00                	push   $0x0
  pushl $144
c0102481:	68 90 00 00 00       	push   $0x90
  jmp __alltraps
c0102486:	e9 34 05 00 00       	jmp    c01029bf <__alltraps>

c010248b <vector145>:
.globl vector145
vector145:
  pushl $0
c010248b:	6a 00                	push   $0x0
  pushl $145
c010248d:	68 91 00 00 00       	push   $0x91
  jmp __alltraps
c0102492:	e9 28 05 00 00       	jmp    c01029bf <__alltraps>

c0102497 <vector146>:
.globl vector146
vector146:
  pushl $0
c0102497:	6a 00                	push   $0x0
  pushl $146
c0102499:	68 92 00 00 00       	push   $0x92
  jmp __alltraps
c010249e:	e9 1c 05 00 00       	jmp    c01029bf <__alltraps>

c01024a3 <vector147>:
.globl vector147
vector147:
  pushl $0
c01024a3:	6a 00                	push   $0x0
  pushl $147
c01024a5:	68 93 00 00 00       	push   $0x93
  jmp __alltraps
c01024aa:	e9 10 05 00 00       	jmp    c01029bf <__alltraps>

c01024af <vector148>:
.globl vector148
vector148:
  pushl $0
c01024af:	6a 00                	push   $0x0
  pushl $148
c01024b1:	68 94 00 00 00       	push   $0x94
  jmp __alltraps
c01024b6:	e9 04 05 00 00       	jmp    c01029bf <__alltraps>

c01024bb <vector149>:
.globl vector149
vector149:
  pushl $0
c01024bb:	6a 00                	push   $0x0
  pushl $149
c01024bd:	68 95 00 00 00       	push   $0x95
  jmp __alltraps
c01024c2:	e9 f8 04 00 00       	jmp    c01029bf <__alltraps>

c01024c7 <vector150>:
.globl vector150
vector150:
  pushl $0
c01024c7:	6a 00                	push   $0x0
  pushl $150
c01024c9:	68 96 00 00 00       	push   $0x96
  jmp __alltraps
c01024ce:	e9 ec 04 00 00       	jmp    c01029bf <__alltraps>

c01024d3 <vector151>:
.globl vector151
vector151:
  pushl $0
c01024d3:	6a 00                	push   $0x0
  pushl $151
c01024d5:	68 97 00 00 00       	push   $0x97
  jmp __alltraps
c01024da:	e9 e0 04 00 00       	jmp    c01029bf <__alltraps>

c01024df <vector152>:
.globl vector152
vector152:
  pushl $0
c01024df:	6a 00                	push   $0x0
  pushl $152
c01024e1:	68 98 00 00 00       	push   $0x98
  jmp __alltraps
c01024e6:	e9 d4 04 00 00       	jmp    c01029bf <__alltraps>

c01024eb <vector153>:
.globl vector153
vector153:
  pushl $0
c01024eb:	6a 00                	push   $0x0
  pushl $153
c01024ed:	68 99 00 00 00       	push   $0x99
  jmp __alltraps
c01024f2:	e9 c8 04 00 00       	jmp    c01029bf <__alltraps>

c01024f7 <vector154>:
.globl vector154
vector154:
  pushl $0
c01024f7:	6a 00                	push   $0x0
  pushl $154
c01024f9:	68 9a 00 00 00       	push   $0x9a
  jmp __alltraps
c01024fe:	e9 bc 04 00 00       	jmp    c01029bf <__alltraps>

c0102503 <vector155>:
.globl vector155
vector155:
  pushl $0
c0102503:	6a 00                	push   $0x0
  pushl $155
c0102505:	68 9b 00 00 00       	push   $0x9b
  jmp __alltraps
c010250a:	e9 b0 04 00 00       	jmp    c01029bf <__alltraps>

c010250f <vector156>:
.globl vector156
vector156:
  pushl $0
c010250f:	6a 00                	push   $0x0
  pushl $156
c0102511:	68 9c 00 00 00       	push   $0x9c
  jmp __alltraps
c0102516:	e9 a4 04 00 00       	jmp    c01029bf <__alltraps>

c010251b <vector157>:
.globl vector157
vector157:
  pushl $0
c010251b:	6a 00                	push   $0x0
  pushl $157
c010251d:	68 9d 00 00 00       	push   $0x9d
  jmp __alltraps
c0102522:	e9 98 04 00 00       	jmp    c01029bf <__alltraps>

c0102527 <vector158>:
.globl vector158
vector158:
  pushl $0
c0102527:	6a 00                	push   $0x0
  pushl $158
c0102529:	68 9e 00 00 00       	push   $0x9e
  jmp __alltraps
c010252e:	e9 8c 04 00 00       	jmp    c01029bf <__alltraps>

c0102533 <vector159>:
.globl vector159
vector159:
  pushl $0
c0102533:	6a 00                	push   $0x0
  pushl $159
c0102535:	68 9f 00 00 00       	push   $0x9f
  jmp __alltraps
c010253a:	e9 80 04 00 00       	jmp    c01029bf <__alltraps>

c010253f <vector160>:
.globl vector160
vector160:
  pushl $0
c010253f:	6a 00                	push   $0x0
  pushl $160
c0102541:	68 a0 00 00 00       	push   $0xa0
  jmp __alltraps
c0102546:	e9 74 04 00 00       	jmp    c01029bf <__alltraps>

c010254b <vector161>:
.globl vector161
vector161:
  pushl $0
c010254b:	6a 00                	push   $0x0
  pushl $161
c010254d:	68 a1 00 00 00       	push   $0xa1
  jmp __alltraps
c0102552:	e9 68 04 00 00       	jmp    c01029bf <__alltraps>

c0102557 <vector162>:
.globl vector162
vector162:
  pushl $0
c0102557:	6a 00                	push   $0x0
  pushl $162
c0102559:	68 a2 00 00 00       	push   $0xa2
  jmp __alltraps
c010255e:	e9 5c 04 00 00       	jmp    c01029bf <__alltraps>

c0102563 <vector163>:
.globl vector163
vector163:
  pushl $0
c0102563:	6a 00                	push   $0x0
  pushl $163
c0102565:	68 a3 00 00 00       	push   $0xa3
  jmp __alltraps
c010256a:	e9 50 04 00 00       	jmp    c01029bf <__alltraps>

c010256f <vector164>:
.globl vector164
vector164:
  pushl $0
c010256f:	6a 00                	push   $0x0
  pushl $164
c0102571:	68 a4 00 00 00       	push   $0xa4
  jmp __alltraps
c0102576:	e9 44 04 00 00       	jmp    c01029bf <__alltraps>

c010257b <vector165>:
.globl vector165
vector165:
  pushl $0
c010257b:	6a 00                	push   $0x0
  pushl $165
c010257d:	68 a5 00 00 00       	push   $0xa5
  jmp __alltraps
c0102582:	e9 38 04 00 00       	jmp    c01029bf <__alltraps>

c0102587 <vector166>:
.globl vector166
vector166:
  pushl $0
c0102587:	6a 00                	push   $0x0
  pushl $166
c0102589:	68 a6 00 00 00       	push   $0xa6
  jmp __alltraps
c010258e:	e9 2c 04 00 00       	jmp    c01029bf <__alltraps>

c0102593 <vector167>:
.globl vector167
vector167:
  pushl $0
c0102593:	6a 00                	push   $0x0
  pushl $167
c0102595:	68 a7 00 00 00       	push   $0xa7
  jmp __alltraps
c010259a:	e9 20 04 00 00       	jmp    c01029bf <__alltraps>

c010259f <vector168>:
.globl vector168
vector168:
  pushl $0
c010259f:	6a 00                	push   $0x0
  pushl $168
c01025a1:	68 a8 00 00 00       	push   $0xa8
  jmp __alltraps
c01025a6:	e9 14 04 00 00       	jmp    c01029bf <__alltraps>

c01025ab <vector169>:
.globl vector169
vector169:
  pushl $0
c01025ab:	6a 00                	push   $0x0
  pushl $169
c01025ad:	68 a9 00 00 00       	push   $0xa9
  jmp __alltraps
c01025b2:	e9 08 04 00 00       	jmp    c01029bf <__alltraps>

c01025b7 <vector170>:
.globl vector170
vector170:
  pushl $0
c01025b7:	6a 00                	push   $0x0
  pushl $170
c01025b9:	68 aa 00 00 00       	push   $0xaa
  jmp __alltraps
c01025be:	e9 fc 03 00 00       	jmp    c01029bf <__alltraps>

c01025c3 <vector171>:
.globl vector171
vector171:
  pushl $0
c01025c3:	6a 00                	push   $0x0
  pushl $171
c01025c5:	68 ab 00 00 00       	push   $0xab
  jmp __alltraps
c01025ca:	e9 f0 03 00 00       	jmp    c01029bf <__alltraps>

c01025cf <vector172>:
.globl vector172
vector172:
  pushl $0
c01025cf:	6a 00                	push   $0x0
  pushl $172
c01025d1:	68 ac 00 00 00       	push   $0xac
  jmp __alltraps
c01025d6:	e9 e4 03 00 00       	jmp    c01029bf <__alltraps>

c01025db <vector173>:
.globl vector173
vector173:
  pushl $0
c01025db:	6a 00                	push   $0x0
  pushl $173
c01025dd:	68 ad 00 00 00       	push   $0xad
  jmp __alltraps
c01025e2:	e9 d8 03 00 00       	jmp    c01029bf <__alltraps>

c01025e7 <vector174>:
.globl vector174
vector174:
  pushl $0
c01025e7:	6a 00                	push   $0x0
  pushl $174
c01025e9:	68 ae 00 00 00       	push   $0xae
  jmp __alltraps
c01025ee:	e9 cc 03 00 00       	jmp    c01029bf <__alltraps>

c01025f3 <vector175>:
.globl vector175
vector175:
  pushl $0
c01025f3:	6a 00                	push   $0x0
  pushl $175
c01025f5:	68 af 00 00 00       	push   $0xaf
  jmp __alltraps
c01025fa:	e9 c0 03 00 00       	jmp    c01029bf <__alltraps>

c01025ff <vector176>:
.globl vector176
vector176:
  pushl $0
c01025ff:	6a 00                	push   $0x0
  pushl $176
c0102601:	68 b0 00 00 00       	push   $0xb0
  jmp __alltraps
c0102606:	e9 b4 03 00 00       	jmp    c01029bf <__alltraps>

c010260b <vector177>:
.globl vector177
vector177:
  pushl $0
c010260b:	6a 00                	push   $0x0
  pushl $177
c010260d:	68 b1 00 00 00       	push   $0xb1
  jmp __alltraps
c0102612:	e9 a8 03 00 00       	jmp    c01029bf <__alltraps>

c0102617 <vector178>:
.globl vector178
vector178:
  pushl $0
c0102617:	6a 00                	push   $0x0
  pushl $178
c0102619:	68 b2 00 00 00       	push   $0xb2
  jmp __alltraps
c010261e:	e9 9c 03 00 00       	jmp    c01029bf <__alltraps>

c0102623 <vector179>:
.globl vector179
vector179:
  pushl $0
c0102623:	6a 00                	push   $0x0
  pushl $179
c0102625:	68 b3 00 00 00       	push   $0xb3
  jmp __alltraps
c010262a:	e9 90 03 00 00       	jmp    c01029bf <__alltraps>

c010262f <vector180>:
.globl vector180
vector180:
  pushl $0
c010262f:	6a 00                	push   $0x0
  pushl $180
c0102631:	68 b4 00 00 00       	push   $0xb4
  jmp __alltraps
c0102636:	e9 84 03 00 00       	jmp    c01029bf <__alltraps>

c010263b <vector181>:
.globl vector181
vector181:
  pushl $0
c010263b:	6a 00                	push   $0x0
  pushl $181
c010263d:	68 b5 00 00 00       	push   $0xb5
  jmp __alltraps
c0102642:	e9 78 03 00 00       	jmp    c01029bf <__alltraps>

c0102647 <vector182>:
.globl vector182
vector182:
  pushl $0
c0102647:	6a 00                	push   $0x0
  pushl $182
c0102649:	68 b6 00 00 00       	push   $0xb6
  jmp __alltraps
c010264e:	e9 6c 03 00 00       	jmp    c01029bf <__alltraps>

c0102653 <vector183>:
.globl vector183
vector183:
  pushl $0
c0102653:	6a 00                	push   $0x0
  pushl $183
c0102655:	68 b7 00 00 00       	push   $0xb7
  jmp __alltraps
c010265a:	e9 60 03 00 00       	jmp    c01029bf <__alltraps>

c010265f <vector184>:
.globl vector184
vector184:
  pushl $0
c010265f:	6a 00                	push   $0x0
  pushl $184
c0102661:	68 b8 00 00 00       	push   $0xb8
  jmp __alltraps
c0102666:	e9 54 03 00 00       	jmp    c01029bf <__alltraps>

c010266b <vector185>:
.globl vector185
vector185:
  pushl $0
c010266b:	6a 00                	push   $0x0
  pushl $185
c010266d:	68 b9 00 00 00       	push   $0xb9
  jmp __alltraps
c0102672:	e9 48 03 00 00       	jmp    c01029bf <__alltraps>

c0102677 <vector186>:
.globl vector186
vector186:
  pushl $0
c0102677:	6a 00                	push   $0x0
  pushl $186
c0102679:	68 ba 00 00 00       	push   $0xba
  jmp __alltraps
c010267e:	e9 3c 03 00 00       	jmp    c01029bf <__alltraps>

c0102683 <vector187>:
.globl vector187
vector187:
  pushl $0
c0102683:	6a 00                	push   $0x0
  pushl $187
c0102685:	68 bb 00 00 00       	push   $0xbb
  jmp __alltraps
c010268a:	e9 30 03 00 00       	jmp    c01029bf <__alltraps>

c010268f <vector188>:
.globl vector188
vector188:
  pushl $0
c010268f:	6a 00                	push   $0x0
  pushl $188
c0102691:	68 bc 00 00 00       	push   $0xbc
  jmp __alltraps
c0102696:	e9 24 03 00 00       	jmp    c01029bf <__alltraps>

c010269b <vector189>:
.globl vector189
vector189:
  pushl $0
c010269b:	6a 00                	push   $0x0
  pushl $189
c010269d:	68 bd 00 00 00       	push   $0xbd
  jmp __alltraps
c01026a2:	e9 18 03 00 00       	jmp    c01029bf <__alltraps>

c01026a7 <vector190>:
.globl vector190
vector190:
  pushl $0
c01026a7:	6a 00                	push   $0x0
  pushl $190
c01026a9:	68 be 00 00 00       	push   $0xbe
  jmp __alltraps
c01026ae:	e9 0c 03 00 00       	jmp    c01029bf <__alltraps>

c01026b3 <vector191>:
.globl vector191
vector191:
  pushl $0
c01026b3:	6a 00                	push   $0x0
  pushl $191
c01026b5:	68 bf 00 00 00       	push   $0xbf
  jmp __alltraps
c01026ba:	e9 00 03 00 00       	jmp    c01029bf <__alltraps>

c01026bf <vector192>:
.globl vector192
vector192:
  pushl $0
c01026bf:	6a 00                	push   $0x0
  pushl $192
c01026c1:	68 c0 00 00 00       	push   $0xc0
  jmp __alltraps
c01026c6:	e9 f4 02 00 00       	jmp    c01029bf <__alltraps>

c01026cb <vector193>:
.globl vector193
vector193:
  pushl $0
c01026cb:	6a 00                	push   $0x0
  pushl $193
c01026cd:	68 c1 00 00 00       	push   $0xc1
  jmp __alltraps
c01026d2:	e9 e8 02 00 00       	jmp    c01029bf <__alltraps>

c01026d7 <vector194>:
.globl vector194
vector194:
  pushl $0
c01026d7:	6a 00                	push   $0x0
  pushl $194
c01026d9:	68 c2 00 00 00       	push   $0xc2
  jmp __alltraps
c01026de:	e9 dc 02 00 00       	jmp    c01029bf <__alltraps>

c01026e3 <vector195>:
.globl vector195
vector195:
  pushl $0
c01026e3:	6a 00                	push   $0x0
  pushl $195
c01026e5:	68 c3 00 00 00       	push   $0xc3
  jmp __alltraps
c01026ea:	e9 d0 02 00 00       	jmp    c01029bf <__alltraps>

c01026ef <vector196>:
.globl vector196
vector196:
  pushl $0
c01026ef:	6a 00                	push   $0x0
  pushl $196
c01026f1:	68 c4 00 00 00       	push   $0xc4
  jmp __alltraps
c01026f6:	e9 c4 02 00 00       	jmp    c01029bf <__alltraps>

c01026fb <vector197>:
.globl vector197
vector197:
  pushl $0
c01026fb:	6a 00                	push   $0x0
  pushl $197
c01026fd:	68 c5 00 00 00       	push   $0xc5
  jmp __alltraps
c0102702:	e9 b8 02 00 00       	jmp    c01029bf <__alltraps>

c0102707 <vector198>:
.globl vector198
vector198:
  pushl $0
c0102707:	6a 00                	push   $0x0
  pushl $198
c0102709:	68 c6 00 00 00       	push   $0xc6
  jmp __alltraps
c010270e:	e9 ac 02 00 00       	jmp    c01029bf <__alltraps>

c0102713 <vector199>:
.globl vector199
vector199:
  pushl $0
c0102713:	6a 00                	push   $0x0
  pushl $199
c0102715:	68 c7 00 00 00       	push   $0xc7
  jmp __alltraps
c010271a:	e9 a0 02 00 00       	jmp    c01029bf <__alltraps>

c010271f <vector200>:
.globl vector200
vector200:
  pushl $0
c010271f:	6a 00                	push   $0x0
  pushl $200
c0102721:	68 c8 00 00 00       	push   $0xc8
  jmp __alltraps
c0102726:	e9 94 02 00 00       	jmp    c01029bf <__alltraps>

c010272b <vector201>:
.globl vector201
vector201:
  pushl $0
c010272b:	6a 00                	push   $0x0
  pushl $201
c010272d:	68 c9 00 00 00       	push   $0xc9
  jmp __alltraps
c0102732:	e9 88 02 00 00       	jmp    c01029bf <__alltraps>

c0102737 <vector202>:
.globl vector202
vector202:
  pushl $0
c0102737:	6a 00                	push   $0x0
  pushl $202
c0102739:	68 ca 00 00 00       	push   $0xca
  jmp __alltraps
c010273e:	e9 7c 02 00 00       	jmp    c01029bf <__alltraps>

c0102743 <vector203>:
.globl vector203
vector203:
  pushl $0
c0102743:	6a 00                	push   $0x0
  pushl $203
c0102745:	68 cb 00 00 00       	push   $0xcb
  jmp __alltraps
c010274a:	e9 70 02 00 00       	jmp    c01029bf <__alltraps>

c010274f <vector204>:
.globl vector204
vector204:
  pushl $0
c010274f:	6a 00                	push   $0x0
  pushl $204
c0102751:	68 cc 00 00 00       	push   $0xcc
  jmp __alltraps
c0102756:	e9 64 02 00 00       	jmp    c01029bf <__alltraps>

c010275b <vector205>:
.globl vector205
vector205:
  pushl $0
c010275b:	6a 00                	push   $0x0
  pushl $205
c010275d:	68 cd 00 00 00       	push   $0xcd
  jmp __alltraps
c0102762:	e9 58 02 00 00       	jmp    c01029bf <__alltraps>

c0102767 <vector206>:
.globl vector206
vector206:
  pushl $0
c0102767:	6a 00                	push   $0x0
  pushl $206
c0102769:	68 ce 00 00 00       	push   $0xce
  jmp __alltraps
c010276e:	e9 4c 02 00 00       	jmp    c01029bf <__alltraps>

c0102773 <vector207>:
.globl vector207
vector207:
  pushl $0
c0102773:	6a 00                	push   $0x0
  pushl $207
c0102775:	68 cf 00 00 00       	push   $0xcf
  jmp __alltraps
c010277a:	e9 40 02 00 00       	jmp    c01029bf <__alltraps>

c010277f <vector208>:
.globl vector208
vector208:
  pushl $0
c010277f:	6a 00                	push   $0x0
  pushl $208
c0102781:	68 d0 00 00 00       	push   $0xd0
  jmp __alltraps
c0102786:	e9 34 02 00 00       	jmp    c01029bf <__alltraps>

c010278b <vector209>:
.globl vector209
vector209:
  pushl $0
c010278b:	6a 00                	push   $0x0
  pushl $209
c010278d:	68 d1 00 00 00       	push   $0xd1
  jmp __alltraps
c0102792:	e9 28 02 00 00       	jmp    c01029bf <__alltraps>

c0102797 <vector210>:
.globl vector210
vector210:
  pushl $0
c0102797:	6a 00                	push   $0x0
  pushl $210
c0102799:	68 d2 00 00 00       	push   $0xd2
  jmp __alltraps
c010279e:	e9 1c 02 00 00       	jmp    c01029bf <__alltraps>

c01027a3 <vector211>:
.globl vector211
vector211:
  pushl $0
c01027a3:	6a 00                	push   $0x0
  pushl $211
c01027a5:	68 d3 00 00 00       	push   $0xd3
  jmp __alltraps
c01027aa:	e9 10 02 00 00       	jmp    c01029bf <__alltraps>

c01027af <vector212>:
.globl vector212
vector212:
  pushl $0
c01027af:	6a 00                	push   $0x0
  pushl $212
c01027b1:	68 d4 00 00 00       	push   $0xd4
  jmp __alltraps
c01027b6:	e9 04 02 00 00       	jmp    c01029bf <__alltraps>

c01027bb <vector213>:
.globl vector213
vector213:
  pushl $0
c01027bb:	6a 00                	push   $0x0
  pushl $213
c01027bd:	68 d5 00 00 00       	push   $0xd5
  jmp __alltraps
c01027c2:	e9 f8 01 00 00       	jmp    c01029bf <__alltraps>

c01027c7 <vector214>:
.globl vector214
vector214:
  pushl $0
c01027c7:	6a 00                	push   $0x0
  pushl $214
c01027c9:	68 d6 00 00 00       	push   $0xd6
  jmp __alltraps
c01027ce:	e9 ec 01 00 00       	jmp    c01029bf <__alltraps>

c01027d3 <vector215>:
.globl vector215
vector215:
  pushl $0
c01027d3:	6a 00                	push   $0x0
  pushl $215
c01027d5:	68 d7 00 00 00       	push   $0xd7
  jmp __alltraps
c01027da:	e9 e0 01 00 00       	jmp    c01029bf <__alltraps>

c01027df <vector216>:
.globl vector216
vector216:
  pushl $0
c01027df:	6a 00                	push   $0x0
  pushl $216
c01027e1:	68 d8 00 00 00       	push   $0xd8
  jmp __alltraps
c01027e6:	e9 d4 01 00 00       	jmp    c01029bf <__alltraps>

c01027eb <vector217>:
.globl vector217
vector217:
  pushl $0
c01027eb:	6a 00                	push   $0x0
  pushl $217
c01027ed:	68 d9 00 00 00       	push   $0xd9
  jmp __alltraps
c01027f2:	e9 c8 01 00 00       	jmp    c01029bf <__alltraps>

c01027f7 <vector218>:
.globl vector218
vector218:
  pushl $0
c01027f7:	6a 00                	push   $0x0
  pushl $218
c01027f9:	68 da 00 00 00       	push   $0xda
  jmp __alltraps
c01027fe:	e9 bc 01 00 00       	jmp    c01029bf <__alltraps>

c0102803 <vector219>:
.globl vector219
vector219:
  pushl $0
c0102803:	6a 00                	push   $0x0
  pushl $219
c0102805:	68 db 00 00 00       	push   $0xdb
  jmp __alltraps
c010280a:	e9 b0 01 00 00       	jmp    c01029bf <__alltraps>

c010280f <vector220>:
.globl vector220
vector220:
  pushl $0
c010280f:	6a 00                	push   $0x0
  pushl $220
c0102811:	68 dc 00 00 00       	push   $0xdc
  jmp __alltraps
c0102816:	e9 a4 01 00 00       	jmp    c01029bf <__alltraps>

c010281b <vector221>:
.globl vector221
vector221:
  pushl $0
c010281b:	6a 00                	push   $0x0
  pushl $221
c010281d:	68 dd 00 00 00       	push   $0xdd
  jmp __alltraps
c0102822:	e9 98 01 00 00       	jmp    c01029bf <__alltraps>

c0102827 <vector222>:
.globl vector222
vector222:
  pushl $0
c0102827:	6a 00                	push   $0x0
  pushl $222
c0102829:	68 de 00 00 00       	push   $0xde
  jmp __alltraps
c010282e:	e9 8c 01 00 00       	jmp    c01029bf <__alltraps>

c0102833 <vector223>:
.globl vector223
vector223:
  pushl $0
c0102833:	6a 00                	push   $0x0
  pushl $223
c0102835:	68 df 00 00 00       	push   $0xdf
  jmp __alltraps
c010283a:	e9 80 01 00 00       	jmp    c01029bf <__alltraps>

c010283f <vector224>:
.globl vector224
vector224:
  pushl $0
c010283f:	6a 00                	push   $0x0
  pushl $224
c0102841:	68 e0 00 00 00       	push   $0xe0
  jmp __alltraps
c0102846:	e9 74 01 00 00       	jmp    c01029bf <__alltraps>

c010284b <vector225>:
.globl vector225
vector225:
  pushl $0
c010284b:	6a 00                	push   $0x0
  pushl $225
c010284d:	68 e1 00 00 00       	push   $0xe1
  jmp __alltraps
c0102852:	e9 68 01 00 00       	jmp    c01029bf <__alltraps>

c0102857 <vector226>:
.globl vector226
vector226:
  pushl $0
c0102857:	6a 00                	push   $0x0
  pushl $226
c0102859:	68 e2 00 00 00       	push   $0xe2
  jmp __alltraps
c010285e:	e9 5c 01 00 00       	jmp    c01029bf <__alltraps>

c0102863 <vector227>:
.globl vector227
vector227:
  pushl $0
c0102863:	6a 00                	push   $0x0
  pushl $227
c0102865:	68 e3 00 00 00       	push   $0xe3
  jmp __alltraps
c010286a:	e9 50 01 00 00       	jmp    c01029bf <__alltraps>

c010286f <vector228>:
.globl vector228
vector228:
  pushl $0
c010286f:	6a 00                	push   $0x0
  pushl $228
c0102871:	68 e4 00 00 00       	push   $0xe4
  jmp __alltraps
c0102876:	e9 44 01 00 00       	jmp    c01029bf <__alltraps>

c010287b <vector229>:
.globl vector229
vector229:
  pushl $0
c010287b:	6a 00                	push   $0x0
  pushl $229
c010287d:	68 e5 00 00 00       	push   $0xe5
  jmp __alltraps
c0102882:	e9 38 01 00 00       	jmp    c01029bf <__alltraps>

c0102887 <vector230>:
.globl vector230
vector230:
  pushl $0
c0102887:	6a 00                	push   $0x0
  pushl $230
c0102889:	68 e6 00 00 00       	push   $0xe6
  jmp __alltraps
c010288e:	e9 2c 01 00 00       	jmp    c01029bf <__alltraps>

c0102893 <vector231>:
.globl vector231
vector231:
  pushl $0
c0102893:	6a 00                	push   $0x0
  pushl $231
c0102895:	68 e7 00 00 00       	push   $0xe7
  jmp __alltraps
c010289a:	e9 20 01 00 00       	jmp    c01029bf <__alltraps>

c010289f <vector232>:
.globl vector232
vector232:
  pushl $0
c010289f:	6a 00                	push   $0x0
  pushl $232
c01028a1:	68 e8 00 00 00       	push   $0xe8
  jmp __alltraps
c01028a6:	e9 14 01 00 00       	jmp    c01029bf <__alltraps>

c01028ab <vector233>:
.globl vector233
vector233:
  pushl $0
c01028ab:	6a 00                	push   $0x0
  pushl $233
c01028ad:	68 e9 00 00 00       	push   $0xe9
  jmp __alltraps
c01028b2:	e9 08 01 00 00       	jmp    c01029bf <__alltraps>

c01028b7 <vector234>:
.globl vector234
vector234:
  pushl $0
c01028b7:	6a 00                	push   $0x0
  pushl $234
c01028b9:	68 ea 00 00 00       	push   $0xea
  jmp __alltraps
c01028be:	e9 fc 00 00 00       	jmp    c01029bf <__alltraps>

c01028c3 <vector235>:
.globl vector235
vector235:
  pushl $0
c01028c3:	6a 00                	push   $0x0
  pushl $235
c01028c5:	68 eb 00 00 00       	push   $0xeb
  jmp __alltraps
c01028ca:	e9 f0 00 00 00       	jmp    c01029bf <__alltraps>

c01028cf <vector236>:
.globl vector236
vector236:
  pushl $0
c01028cf:	6a 00                	push   $0x0
  pushl $236
c01028d1:	68 ec 00 00 00       	push   $0xec
  jmp __alltraps
c01028d6:	e9 e4 00 00 00       	jmp    c01029bf <__alltraps>

c01028db <vector237>:
.globl vector237
vector237:
  pushl $0
c01028db:	6a 00                	push   $0x0
  pushl $237
c01028dd:	68 ed 00 00 00       	push   $0xed
  jmp __alltraps
c01028e2:	e9 d8 00 00 00       	jmp    c01029bf <__alltraps>

c01028e7 <vector238>:
.globl vector238
vector238:
  pushl $0
c01028e7:	6a 00                	push   $0x0
  pushl $238
c01028e9:	68 ee 00 00 00       	push   $0xee
  jmp __alltraps
c01028ee:	e9 cc 00 00 00       	jmp    c01029bf <__alltraps>

c01028f3 <vector239>:
.globl vector239
vector239:
  pushl $0
c01028f3:	6a 00                	push   $0x0
  pushl $239
c01028f5:	68 ef 00 00 00       	push   $0xef
  jmp __alltraps
c01028fa:	e9 c0 00 00 00       	jmp    c01029bf <__alltraps>

c01028ff <vector240>:
.globl vector240
vector240:
  pushl $0
c01028ff:	6a 00                	push   $0x0
  pushl $240
c0102901:	68 f0 00 00 00       	push   $0xf0
  jmp __alltraps
c0102906:	e9 b4 00 00 00       	jmp    c01029bf <__alltraps>

c010290b <vector241>:
.globl vector241
vector241:
  pushl $0
c010290b:	6a 00                	push   $0x0
  pushl $241
c010290d:	68 f1 00 00 00       	push   $0xf1
  jmp __alltraps
c0102912:	e9 a8 00 00 00       	jmp    c01029bf <__alltraps>

c0102917 <vector242>:
.globl vector242
vector242:
  pushl $0
c0102917:	6a 00                	push   $0x0
  pushl $242
c0102919:	68 f2 00 00 00       	push   $0xf2
  jmp __alltraps
c010291e:	e9 9c 00 00 00       	jmp    c01029bf <__alltraps>

c0102923 <vector243>:
.globl vector243
vector243:
  pushl $0
c0102923:	6a 00                	push   $0x0
  pushl $243
c0102925:	68 f3 00 00 00       	push   $0xf3
  jmp __alltraps
c010292a:	e9 90 00 00 00       	jmp    c01029bf <__alltraps>

c010292f <vector244>:
.globl vector244
vector244:
  pushl $0
c010292f:	6a 00                	push   $0x0
  pushl $244
c0102931:	68 f4 00 00 00       	push   $0xf4
  jmp __alltraps
c0102936:	e9 84 00 00 00       	jmp    c01029bf <__alltraps>

c010293b <vector245>:
.globl vector245
vector245:
  pushl $0
c010293b:	6a 00                	push   $0x0
  pushl $245
c010293d:	68 f5 00 00 00       	push   $0xf5
  jmp __alltraps
c0102942:	e9 78 00 00 00       	jmp    c01029bf <__alltraps>

c0102947 <vector246>:
.globl vector246
vector246:
  pushl $0
c0102947:	6a 00                	push   $0x0
  pushl $246
c0102949:	68 f6 00 00 00       	push   $0xf6
  jmp __alltraps
c010294e:	e9 6c 00 00 00       	jmp    c01029bf <__alltraps>

c0102953 <vector247>:
.globl vector247
vector247:
  pushl $0
c0102953:	6a 00                	push   $0x0
  pushl $247
c0102955:	68 f7 00 00 00       	push   $0xf7
  jmp __alltraps
c010295a:	e9 60 00 00 00       	jmp    c01029bf <__alltraps>

c010295f <vector248>:
.globl vector248
vector248:
  pushl $0
c010295f:	6a 00                	push   $0x0
  pushl $248
c0102961:	68 f8 00 00 00       	push   $0xf8
  jmp __alltraps
c0102966:	e9 54 00 00 00       	jmp    c01029bf <__alltraps>

c010296b <vector249>:
.globl vector249
vector249:
  pushl $0
c010296b:	6a 00                	push   $0x0
  pushl $249
c010296d:	68 f9 00 00 00       	push   $0xf9
  jmp __alltraps
c0102972:	e9 48 00 00 00       	jmp    c01029bf <__alltraps>

c0102977 <vector250>:
.globl vector250
vector250:
  pushl $0
c0102977:	6a 00                	push   $0x0
  pushl $250
c0102979:	68 fa 00 00 00       	push   $0xfa
  jmp __alltraps
c010297e:	e9 3c 00 00 00       	jmp    c01029bf <__alltraps>

c0102983 <vector251>:
.globl vector251
vector251:
  pushl $0
c0102983:	6a 00                	push   $0x0
  pushl $251
c0102985:	68 fb 00 00 00       	push   $0xfb
  jmp __alltraps
c010298a:	e9 30 00 00 00       	jmp    c01029bf <__alltraps>

c010298f <vector252>:
.globl vector252
vector252:
  pushl $0
c010298f:	6a 00                	push   $0x0
  pushl $252
c0102991:	68 fc 00 00 00       	push   $0xfc
  jmp __alltraps
c0102996:	e9 24 00 00 00       	jmp    c01029bf <__alltraps>

c010299b <vector253>:
.globl vector253
vector253:
  pushl $0
c010299b:	6a 00                	push   $0x0
  pushl $253
c010299d:	68 fd 00 00 00       	push   $0xfd
  jmp __alltraps
c01029a2:	e9 18 00 00 00       	jmp    c01029bf <__alltraps>

c01029a7 <vector254>:
.globl vector254
vector254:
  pushl $0
c01029a7:	6a 00                	push   $0x0
  pushl $254
c01029a9:	68 fe 00 00 00       	push   $0xfe
  jmp __alltraps
c01029ae:	e9 0c 00 00 00       	jmp    c01029bf <__alltraps>

c01029b3 <vector255>:
.globl vector255
vector255:
  pushl $0
c01029b3:	6a 00                	push   $0x0
  pushl $255
c01029b5:	68 ff 00 00 00       	push   $0xff
  jmp __alltraps
c01029ba:	e9 00 00 00 00       	jmp    c01029bf <__alltraps>

c01029bf <__alltraps>:
.text
.globl __alltraps
__alltraps:
    # push registers to build a trap frame
    # therefore make the stack look like a struct trapframe
    pushl %ds
c01029bf:	1e                   	push   %ds
    pushl %es
c01029c0:	06                   	push   %es
    pushl %fs
c01029c1:	0f a0                	push   %fs
    pushl %gs
c01029c3:	0f a8                	push   %gs
    pushal
c01029c5:	60                   	pusha  

    # load GD_KDATA into %ds and %es to set up data segments for kernel
    movl $GD_KDATA, %eax
c01029c6:	b8 10 00 00 00       	mov    $0x10,%eax
    movw %ax, %ds
c01029cb:	8e d8                	mov    %eax,%ds
    movw %ax, %es
c01029cd:	8e c0                	mov    %eax,%es

    # push %esp to pass a pointer to the trapframe as an argument to trap()
    pushl %esp
c01029cf:	54                   	push   %esp

    # call trap(tf), where tf=%esp
    call trap
c01029d0:	e8 5f f5 ff ff       	call   c0101f34 <trap>

    # pop the pushed stack pointer
    popl %esp
c01029d5:	5c                   	pop    %esp

c01029d6 <__trapret>:

    # return falls through to trapret...
.globl __trapret
__trapret:
    # restore registers from stack
    popal
c01029d6:	61                   	popa   

    # restore %ds, %es, %fs and %gs
    popl %gs
c01029d7:	0f a9                	pop    %gs
    popl %fs
c01029d9:	0f a1                	pop    %fs
    popl %es
c01029db:	07                   	pop    %es
    popl %ds
c01029dc:	1f                   	pop    %ds

    # get rid of the trap number and error code
    addl $0x8, %esp
c01029dd:	83 c4 08             	add    $0x8,%esp
    iret
c01029e0:	cf                   	iret   

c01029e1 <page2ppn>:

extern struct Page *pages;
extern size_t npage;

static inline ppn_t
page2ppn(struct Page *page) {
c01029e1:	55                   	push   %ebp
c01029e2:	89 e5                	mov    %esp,%ebp
    return page - pages;
c01029e4:	a1 58 a9 11 c0       	mov    0xc011a958,%eax
c01029e9:	8b 55 08             	mov    0x8(%ebp),%edx
c01029ec:	29 c2                	sub    %eax,%edx
c01029ee:	89 d0                	mov    %edx,%eax
c01029f0:	c1 f8 02             	sar    $0x2,%eax
c01029f3:	69 c0 cd cc cc cc    	imul   $0xcccccccd,%eax,%eax
}
c01029f9:	5d                   	pop    %ebp
c01029fa:	c3                   	ret    

c01029fb <page2pa>:

static inline uintptr_t
page2pa(struct Page *page) {
c01029fb:	55                   	push   %ebp
c01029fc:	89 e5                	mov    %esp,%ebp
    return page2ppn(page) << PGSHIFT;
c01029fe:	ff 75 08             	pushl  0x8(%ebp)
c0102a01:	e8 db ff ff ff       	call   c01029e1 <page2ppn>
c0102a06:	83 c4 04             	add    $0x4,%esp
c0102a09:	c1 e0 0c             	shl    $0xc,%eax
}
c0102a0c:	c9                   	leave  
c0102a0d:	c3                   	ret    

c0102a0e <pa2page>:

static inline struct Page *
pa2page(uintptr_t pa) {
c0102a0e:	55                   	push   %ebp
c0102a0f:	89 e5                	mov    %esp,%ebp
c0102a11:	83 ec 08             	sub    $0x8,%esp
    if (PPN(pa) >= npage) {
c0102a14:	8b 45 08             	mov    0x8(%ebp),%eax
c0102a17:	c1 e8 0c             	shr    $0xc,%eax
c0102a1a:	89 c2                	mov    %eax,%edx
c0102a1c:	a1 c0 a8 11 c0       	mov    0xc011a8c0,%eax
c0102a21:	39 c2                	cmp    %eax,%edx
c0102a23:	72 14                	jb     c0102a39 <pa2page+0x2b>
        panic("pa2page called with invalid pa");
c0102a25:	83 ec 04             	sub    $0x4,%esp
c0102a28:	68 10 64 10 c0       	push   $0xc0106410
c0102a2d:	6a 5a                	push   $0x5a
c0102a2f:	68 2f 64 10 c0       	push   $0xc010642f
c0102a34:	e8 d1 d9 ff ff       	call   c010040a <__panic>
    }
    return &pages[PPN(pa)];
c0102a39:	8b 0d 58 a9 11 c0    	mov    0xc011a958,%ecx
c0102a3f:	8b 45 08             	mov    0x8(%ebp),%eax
c0102a42:	c1 e8 0c             	shr    $0xc,%eax
c0102a45:	89 c2                	mov    %eax,%edx
c0102a47:	89 d0                	mov    %edx,%eax
c0102a49:	c1 e0 02             	shl    $0x2,%eax
c0102a4c:	01 d0                	add    %edx,%eax
c0102a4e:	c1 e0 02             	shl    $0x2,%eax
c0102a51:	01 c8                	add    %ecx,%eax
}
c0102a53:	c9                   	leave  
c0102a54:	c3                   	ret    

c0102a55 <page2kva>:

static inline void *
page2kva(struct Page *page) {
c0102a55:	55                   	push   %ebp
c0102a56:	89 e5                	mov    %esp,%ebp
c0102a58:	83 ec 18             	sub    $0x18,%esp
    return KADDR(page2pa(page));
c0102a5b:	ff 75 08             	pushl  0x8(%ebp)
c0102a5e:	e8 98 ff ff ff       	call   c01029fb <page2pa>
c0102a63:	83 c4 04             	add    $0x4,%esp
c0102a66:	89 45 f4             	mov    %eax,-0xc(%ebp)
c0102a69:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0102a6c:	c1 e8 0c             	shr    $0xc,%eax
c0102a6f:	89 45 f0             	mov    %eax,-0x10(%ebp)
c0102a72:	a1 c0 a8 11 c0       	mov    0xc011a8c0,%eax
c0102a77:	39 45 f0             	cmp    %eax,-0x10(%ebp)
c0102a7a:	72 14                	jb     c0102a90 <page2kva+0x3b>
c0102a7c:	ff 75 f4             	pushl  -0xc(%ebp)
c0102a7f:	68 40 64 10 c0       	push   $0xc0106440
c0102a84:	6a 61                	push   $0x61
c0102a86:	68 2f 64 10 c0       	push   $0xc010642f
c0102a8b:	e8 7a d9 ff ff       	call   c010040a <__panic>
c0102a90:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0102a93:	2d 00 00 00 40       	sub    $0x40000000,%eax
}
c0102a98:	c9                   	leave  
c0102a99:	c3                   	ret    

c0102a9a <pte2page>:
kva2page(void *kva) {
    return pa2page(PADDR(kva));
}

static inline struct Page *
pte2page(pte_t pte) {
c0102a9a:	55                   	push   %ebp
c0102a9b:	89 e5                	mov    %esp,%ebp
c0102a9d:	83 ec 08             	sub    $0x8,%esp
    if (!(pte & PTE_P)) {
c0102aa0:	8b 45 08             	mov    0x8(%ebp),%eax
c0102aa3:	83 e0 01             	and    $0x1,%eax
c0102aa6:	85 c0                	test   %eax,%eax
c0102aa8:	75 14                	jne    c0102abe <pte2page+0x24>
        panic("pte2page called with invalid pte");
c0102aaa:	83 ec 04             	sub    $0x4,%esp
c0102aad:	68 64 64 10 c0       	push   $0xc0106464
c0102ab2:	6a 6c                	push   $0x6c
c0102ab4:	68 2f 64 10 c0       	push   $0xc010642f
c0102ab9:	e8 4c d9 ff ff       	call   c010040a <__panic>
    }
    return pa2page(PTE_ADDR(pte));
c0102abe:	8b 45 08             	mov    0x8(%ebp),%eax
c0102ac1:	25 00 f0 ff ff       	and    $0xfffff000,%eax
c0102ac6:	83 ec 0c             	sub    $0xc,%esp
c0102ac9:	50                   	push   %eax
c0102aca:	e8 3f ff ff ff       	call   c0102a0e <pa2page>
c0102acf:	83 c4 10             	add    $0x10,%esp
}
c0102ad2:	c9                   	leave  
c0102ad3:	c3                   	ret    

c0102ad4 <page_ref>:
pde2page(pde_t pde) {
    return pa2page(PDE_ADDR(pde));
}

static inline int
page_ref(struct Page *page) {
c0102ad4:	55                   	push   %ebp
c0102ad5:	89 e5                	mov    %esp,%ebp
    return page->ref;
c0102ad7:	8b 45 08             	mov    0x8(%ebp),%eax
c0102ada:	8b 00                	mov    (%eax),%eax
}
c0102adc:	5d                   	pop    %ebp
c0102add:	c3                   	ret    

c0102ade <page_ref_inc>:
set_page_ref(struct Page *page, int val) {
    page->ref = val;
}

static inline int
page_ref_inc(struct Page *page) {
c0102ade:	55                   	push   %ebp
c0102adf:	89 e5                	mov    %esp,%ebp
    page->ref += 1;
c0102ae1:	8b 45 08             	mov    0x8(%ebp),%eax
c0102ae4:	8b 00                	mov    (%eax),%eax
c0102ae6:	8d 50 01             	lea    0x1(%eax),%edx
c0102ae9:	8b 45 08             	mov    0x8(%ebp),%eax
c0102aec:	89 10                	mov    %edx,(%eax)
    return page->ref;
c0102aee:	8b 45 08             	mov    0x8(%ebp),%eax
c0102af1:	8b 00                	mov    (%eax),%eax
}
c0102af3:	5d                   	pop    %ebp
c0102af4:	c3                   	ret    

c0102af5 <page_ref_dec>:

static inline int
page_ref_dec(struct Page *page) {
c0102af5:	55                   	push   %ebp
c0102af6:	89 e5                	mov    %esp,%ebp
    page->ref -= 1;
c0102af8:	8b 45 08             	mov    0x8(%ebp),%eax
c0102afb:	8b 00                	mov    (%eax),%eax
c0102afd:	8d 50 ff             	lea    -0x1(%eax),%edx
c0102b00:	8b 45 08             	mov    0x8(%ebp),%eax
c0102b03:	89 10                	mov    %edx,(%eax)
    return page->ref;
c0102b05:	8b 45 08             	mov    0x8(%ebp),%eax
c0102b08:	8b 00                	mov    (%eax),%eax
}
c0102b0a:	5d                   	pop    %ebp
c0102b0b:	c3                   	ret    

c0102b0c <__intr_save>:
__intr_save(void) {
c0102b0c:	55                   	push   %ebp
c0102b0d:	89 e5                	mov    %esp,%ebp
c0102b0f:	83 ec 18             	sub    $0x18,%esp
    asm volatile ("pushfl; popl %0" : "=r" (eflags));
c0102b12:	9c                   	pushf  
c0102b13:	58                   	pop    %eax
c0102b14:	89 45 f4             	mov    %eax,-0xc(%ebp)
    return eflags;
c0102b17:	8b 45 f4             	mov    -0xc(%ebp),%eax
    if (read_eflags() & FL_IF) {
c0102b1a:	25 00 02 00 00       	and    $0x200,%eax
c0102b1f:	85 c0                	test   %eax,%eax
c0102b21:	74 0c                	je     c0102b2f <__intr_save+0x23>
        intr_disable();
c0102b23:	e8 53 ee ff ff       	call   c010197b <intr_disable>
        return 1;
c0102b28:	b8 01 00 00 00       	mov    $0x1,%eax
c0102b2d:	eb 05                	jmp    c0102b34 <__intr_save+0x28>
    return 0;
c0102b2f:	b8 00 00 00 00       	mov    $0x0,%eax
}
c0102b34:	c9                   	leave  
c0102b35:	c3                   	ret    

c0102b36 <__intr_restore>:
__intr_restore(bool flag) {
c0102b36:	55                   	push   %ebp
c0102b37:	89 e5                	mov    %esp,%ebp
c0102b39:	83 ec 08             	sub    $0x8,%esp
    if (flag) {
c0102b3c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
c0102b40:	74 05                	je     c0102b47 <__intr_restore+0x11>
        intr_enable();
c0102b42:	e8 28 ee ff ff       	call   c010196f <intr_enable>
}
c0102b47:	90                   	nop
c0102b48:	c9                   	leave  
c0102b49:	c3                   	ret    

c0102b4a <lgdt>:
/* *
 * lgdt - load the global descriptor table register and reset the
 * data/code segement registers for kernel.
 * */
static inline void
lgdt(struct pseudodesc *pd) {
c0102b4a:	55                   	push   %ebp
c0102b4b:	89 e5                	mov    %esp,%ebp
    asm volatile ("lgdt (%0)" :: "r" (pd));
c0102b4d:	8b 45 08             	mov    0x8(%ebp),%eax
c0102b50:	0f 01 10             	lgdtl  (%eax)
    asm volatile ("movw %%ax, %%gs" :: "a" (USER_DS));
c0102b53:	b8 23 00 00 00       	mov    $0x23,%eax
c0102b58:	8e e8                	mov    %eax,%gs
    asm volatile ("movw %%ax, %%fs" :: "a" (USER_DS));
c0102b5a:	b8 23 00 00 00       	mov    $0x23,%eax
c0102b5f:	8e e0                	mov    %eax,%fs
    asm volatile ("movw %%ax, %%es" :: "a" (KERNEL_DS));
c0102b61:	b8 10 00 00 00       	mov    $0x10,%eax
c0102b66:	8e c0                	mov    %eax,%es
    asm volatile ("movw %%ax, %%ds" :: "a" (KERNEL_DS));
c0102b68:	b8 10 00 00 00       	mov    $0x10,%eax
c0102b6d:	8e d8                	mov    %eax,%ds
    asm volatile ("movw %%ax, %%ss" :: "a" (KERNEL_DS));
c0102b6f:	b8 10 00 00 00       	mov    $0x10,%eax
c0102b74:	8e d0                	mov    %eax,%ss
    // reload cs
    asm volatile ("ljmp %0, $1f\n 1:\n" :: "i" (KERNEL_CS));
c0102b76:	ea 7d 2b 10 c0 08 00 	ljmp   $0x8,$0xc0102b7d
}
c0102b7d:	90                   	nop
c0102b7e:	5d                   	pop    %ebp
c0102b7f:	c3                   	ret    

c0102b80 <load_esp0>:
 * load_esp0 - change the ESP0 in default task state segment,
 * so that we can use different kernel stack when we trap frame
 * user to kernel.
 * */
void
load_esp0(uintptr_t esp0) {
c0102b80:	f3 0f 1e fb          	endbr32 
c0102b84:	55                   	push   %ebp
c0102b85:	89 e5                	mov    %esp,%ebp
    ts.ts_esp0 = esp0;
c0102b87:	8b 45 08             	mov    0x8(%ebp),%eax
c0102b8a:	a3 e4 a8 11 c0       	mov    %eax,0xc011a8e4
}
c0102b8f:	90                   	nop
c0102b90:	5d                   	pop    %ebp
c0102b91:	c3                   	ret    

c0102b92 <gdt_init>:

/* gdt_init - initialize the default GDT and TSS */
static void
gdt_init(void) {
c0102b92:	f3 0f 1e fb          	endbr32 
c0102b96:	55                   	push   %ebp
c0102b97:	89 e5                	mov    %esp,%ebp
c0102b99:	83 ec 10             	sub    $0x10,%esp
    // set boot kernel stack and default SS0
    load_esp0((uintptr_t)bootstacktop);
c0102b9c:	b8 00 90 11 c0       	mov    $0xc0119000,%eax
c0102ba1:	50                   	push   %eax
c0102ba2:	e8 d9 ff ff ff       	call   c0102b80 <load_esp0>
c0102ba7:	83 c4 04             	add    $0x4,%esp
    ts.ts_ss0 = KERNEL_DS;
c0102baa:	66 c7 05 e8 a8 11 c0 	movw   $0x10,0xc011a8e8
c0102bb1:	10 00 

    // initialize the TSS filed of the gdt
    gdt[SEG_TSS] = SEGTSS(STS_T32A, (uintptr_t)&ts, sizeof(ts), DPL_KERNEL);
c0102bb3:	66 c7 05 28 9a 11 c0 	movw   $0x68,0xc0119a28
c0102bba:	68 00 
c0102bbc:	b8 e0 a8 11 c0       	mov    $0xc011a8e0,%eax
c0102bc1:	66 a3 2a 9a 11 c0    	mov    %ax,0xc0119a2a
c0102bc7:	b8 e0 a8 11 c0       	mov    $0xc011a8e0,%eax
c0102bcc:	c1 e8 10             	shr    $0x10,%eax
c0102bcf:	a2 2c 9a 11 c0       	mov    %al,0xc0119a2c
c0102bd4:	0f b6 05 2d 9a 11 c0 	movzbl 0xc0119a2d,%eax
c0102bdb:	83 e0 f0             	and    $0xfffffff0,%eax
c0102bde:	83 c8 09             	or     $0x9,%eax
c0102be1:	a2 2d 9a 11 c0       	mov    %al,0xc0119a2d
c0102be6:	0f b6 05 2d 9a 11 c0 	movzbl 0xc0119a2d,%eax
c0102bed:	83 e0 ef             	and    $0xffffffef,%eax
c0102bf0:	a2 2d 9a 11 c0       	mov    %al,0xc0119a2d
c0102bf5:	0f b6 05 2d 9a 11 c0 	movzbl 0xc0119a2d,%eax
c0102bfc:	83 e0 9f             	and    $0xffffff9f,%eax
c0102bff:	a2 2d 9a 11 c0       	mov    %al,0xc0119a2d
c0102c04:	0f b6 05 2d 9a 11 c0 	movzbl 0xc0119a2d,%eax
c0102c0b:	83 c8 80             	or     $0xffffff80,%eax
c0102c0e:	a2 2d 9a 11 c0       	mov    %al,0xc0119a2d
c0102c13:	0f b6 05 2e 9a 11 c0 	movzbl 0xc0119a2e,%eax
c0102c1a:	83 e0 f0             	and    $0xfffffff0,%eax
c0102c1d:	a2 2e 9a 11 c0       	mov    %al,0xc0119a2e
c0102c22:	0f b6 05 2e 9a 11 c0 	movzbl 0xc0119a2e,%eax
c0102c29:	83 e0 ef             	and    $0xffffffef,%eax
c0102c2c:	a2 2e 9a 11 c0       	mov    %al,0xc0119a2e
c0102c31:	0f b6 05 2e 9a 11 c0 	movzbl 0xc0119a2e,%eax
c0102c38:	83 e0 df             	and    $0xffffffdf,%eax
c0102c3b:	a2 2e 9a 11 c0       	mov    %al,0xc0119a2e
c0102c40:	0f b6 05 2e 9a 11 c0 	movzbl 0xc0119a2e,%eax
c0102c47:	83 c8 40             	or     $0x40,%eax
c0102c4a:	a2 2e 9a 11 c0       	mov    %al,0xc0119a2e
c0102c4f:	0f b6 05 2e 9a 11 c0 	movzbl 0xc0119a2e,%eax
c0102c56:	83 e0 7f             	and    $0x7f,%eax
c0102c59:	a2 2e 9a 11 c0       	mov    %al,0xc0119a2e
c0102c5e:	b8 e0 a8 11 c0       	mov    $0xc011a8e0,%eax
c0102c63:	c1 e8 18             	shr    $0x18,%eax
c0102c66:	a2 2f 9a 11 c0       	mov    %al,0xc0119a2f

    // reload all segment registers
    lgdt(&gdt_pd);
c0102c6b:	68 30 9a 11 c0       	push   $0xc0119a30
c0102c70:	e8 d5 fe ff ff       	call   c0102b4a <lgdt>
c0102c75:	83 c4 04             	add    $0x4,%esp
c0102c78:	66 c7 45 fe 28 00    	movw   $0x28,-0x2(%ebp)
    asm volatile ("ltr %0" :: "r" (sel) : "memory");
c0102c7e:	0f b7 45 fe          	movzwl -0x2(%ebp),%eax
c0102c82:	0f 00 d8             	ltr    %ax
}
c0102c85:	90                   	nop

    // load the TSS
    ltr(GD_TSS);
}
c0102c86:	90                   	nop
c0102c87:	c9                   	leave  
c0102c88:	c3                   	ret    

c0102c89 <init_pmm_manager>:

//init_pmm_manager - initialize a pmm_manager instance
static void
init_pmm_manager(void) {
c0102c89:	f3 0f 1e fb          	endbr32 
c0102c8d:	55                   	push   %ebp
c0102c8e:	89 e5                	mov    %esp,%ebp
c0102c90:	83 ec 08             	sub    $0x8,%esp
    pmm_manager = &default_pmm_manager;
c0102c93:	c7 05 50 a9 11 c0 e8 	movl   $0xc0106de8,0xc011a950
c0102c9a:	6d 10 c0 
    cprintf("memory management: %s\n", pmm_manager->name);
c0102c9d:	a1 50 a9 11 c0       	mov    0xc011a950,%eax
c0102ca2:	8b 00                	mov    (%eax),%eax
c0102ca4:	83 ec 08             	sub    $0x8,%esp
c0102ca7:	50                   	push   %eax
c0102ca8:	68 90 64 10 c0       	push   $0xc0106490
c0102cad:	e8 dd d5 ff ff       	call   c010028f <cprintf>
c0102cb2:	83 c4 10             	add    $0x10,%esp
    pmm_manager->init();
c0102cb5:	a1 50 a9 11 c0       	mov    0xc011a950,%eax
c0102cba:	8b 40 04             	mov    0x4(%eax),%eax
c0102cbd:	ff d0                	call   *%eax
}
c0102cbf:	90                   	nop
c0102cc0:	c9                   	leave  
c0102cc1:	c3                   	ret    

c0102cc2 <init_memmap>:

//init_memmap - call pmm->init_memmap to build Page struct for free memory  
static void
init_memmap(struct Page *base, size_t n) {
c0102cc2:	f3 0f 1e fb          	endbr32 
c0102cc6:	55                   	push   %ebp
c0102cc7:	89 e5                	mov    %esp,%ebp
c0102cc9:	83 ec 08             	sub    $0x8,%esp
    pmm_manager->init_memmap(base, n);
c0102ccc:	a1 50 a9 11 c0       	mov    0xc011a950,%eax
c0102cd1:	8b 40 08             	mov    0x8(%eax),%eax
c0102cd4:	83 ec 08             	sub    $0x8,%esp
c0102cd7:	ff 75 0c             	pushl  0xc(%ebp)
c0102cda:	ff 75 08             	pushl  0x8(%ebp)
c0102cdd:	ff d0                	call   *%eax
c0102cdf:	83 c4 10             	add    $0x10,%esp
}
c0102ce2:	90                   	nop
c0102ce3:	c9                   	leave  
c0102ce4:	c3                   	ret    

c0102ce5 <alloc_pages>:

//alloc_pages - call pmm->alloc_pages to allocate a continuous n*PAGESIZE memory 
struct Page *
alloc_pages(size_t n) {
c0102ce5:	f3 0f 1e fb          	endbr32 
c0102ce9:	55                   	push   %ebp
c0102cea:	89 e5                	mov    %esp,%ebp
c0102cec:	83 ec 18             	sub    $0x18,%esp
    struct Page *page=NULL;
c0102cef:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    bool intr_flag;
    local_intr_save(intr_flag);
c0102cf6:	e8 11 fe ff ff       	call   c0102b0c <__intr_save>
c0102cfb:	89 45 f0             	mov    %eax,-0x10(%ebp)
    {
        page = pmm_manager->alloc_pages(n);
c0102cfe:	a1 50 a9 11 c0       	mov    0xc011a950,%eax
c0102d03:	8b 40 0c             	mov    0xc(%eax),%eax
c0102d06:	83 ec 0c             	sub    $0xc,%esp
c0102d09:	ff 75 08             	pushl  0x8(%ebp)
c0102d0c:	ff d0                	call   *%eax
c0102d0e:	83 c4 10             	add    $0x10,%esp
c0102d11:	89 45 f4             	mov    %eax,-0xc(%ebp)
    }
    local_intr_restore(intr_flag);
c0102d14:	83 ec 0c             	sub    $0xc,%esp
c0102d17:	ff 75 f0             	pushl  -0x10(%ebp)
c0102d1a:	e8 17 fe ff ff       	call   c0102b36 <__intr_restore>
c0102d1f:	83 c4 10             	add    $0x10,%esp
    return page;
c0102d22:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
c0102d25:	c9                   	leave  
c0102d26:	c3                   	ret    

c0102d27 <free_pages>:

//free_pages - call pmm->free_pages to free a continuous n*PAGESIZE memory 
void
free_pages(struct Page *base, size_t n) {
c0102d27:	f3 0f 1e fb          	endbr32 
c0102d2b:	55                   	push   %ebp
c0102d2c:	89 e5                	mov    %esp,%ebp
c0102d2e:	83 ec 18             	sub    $0x18,%esp
    bool intr_flag;
    local_intr_save(intr_flag);
c0102d31:	e8 d6 fd ff ff       	call   c0102b0c <__intr_save>
c0102d36:	89 45 f4             	mov    %eax,-0xc(%ebp)
    {
        pmm_manager->free_pages(base, n);
c0102d39:	a1 50 a9 11 c0       	mov    0xc011a950,%eax
c0102d3e:	8b 40 10             	mov    0x10(%eax),%eax
c0102d41:	83 ec 08             	sub    $0x8,%esp
c0102d44:	ff 75 0c             	pushl  0xc(%ebp)
c0102d47:	ff 75 08             	pushl  0x8(%ebp)
c0102d4a:	ff d0                	call   *%eax
c0102d4c:	83 c4 10             	add    $0x10,%esp
    }
    local_intr_restore(intr_flag);
c0102d4f:	83 ec 0c             	sub    $0xc,%esp
c0102d52:	ff 75 f4             	pushl  -0xc(%ebp)
c0102d55:	e8 dc fd ff ff       	call   c0102b36 <__intr_restore>
c0102d5a:	83 c4 10             	add    $0x10,%esp
}
c0102d5d:	90                   	nop
c0102d5e:	c9                   	leave  
c0102d5f:	c3                   	ret    

c0102d60 <nr_free_pages>:

//nr_free_pages - call pmm->nr_free_pages to get the size (nr*PAGESIZE) 
//of current free memory
size_t
nr_free_pages(void) {
c0102d60:	f3 0f 1e fb          	endbr32 
c0102d64:	55                   	push   %ebp
c0102d65:	89 e5                	mov    %esp,%ebp
c0102d67:	83 ec 18             	sub    $0x18,%esp
    size_t ret;
    bool intr_flag;
    local_intr_save(intr_flag);
c0102d6a:	e8 9d fd ff ff       	call   c0102b0c <__intr_save>
c0102d6f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    {
        ret = pmm_manager->nr_free_pages();
c0102d72:	a1 50 a9 11 c0       	mov    0xc011a950,%eax
c0102d77:	8b 40 14             	mov    0x14(%eax),%eax
c0102d7a:	ff d0                	call   *%eax
c0102d7c:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }
    local_intr_restore(intr_flag);
c0102d7f:	83 ec 0c             	sub    $0xc,%esp
c0102d82:	ff 75 f4             	pushl  -0xc(%ebp)
c0102d85:	e8 ac fd ff ff       	call   c0102b36 <__intr_restore>
c0102d8a:	83 c4 10             	add    $0x10,%esp
    return ret;
c0102d8d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
c0102d90:	c9                   	leave  
c0102d91:	c3                   	ret    

c0102d92 <page_init>:

/* pmm_init - initialize the physical memory management */
static void
page_init(void) {
c0102d92:	f3 0f 1e fb          	endbr32 
c0102d96:	55                   	push   %ebp
c0102d97:	89 e5                	mov    %esp,%ebp
c0102d99:	57                   	push   %edi
c0102d9a:	56                   	push   %esi
c0102d9b:	53                   	push   %ebx
c0102d9c:	83 ec 7c             	sub    $0x7c,%esp
    struct e820map *memmap = (struct e820map *)(0x8000 + KERNBASE);
c0102d9f:	c7 45 c4 00 80 00 c0 	movl   $0xc0008000,-0x3c(%ebp)
    uint64_t maxpa = 0;
c0102da6:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
c0102dad:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)

    cprintf("e820map:\n");
c0102db4:	83 ec 0c             	sub    $0xc,%esp
c0102db7:	68 a7 64 10 c0       	push   $0xc01064a7
c0102dbc:	e8 ce d4 ff ff       	call   c010028f <cprintf>
c0102dc1:	83 c4 10             	add    $0x10,%esp
    int i;
    for (i = 0; i < memmap->nr_map; i ++) {
c0102dc4:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
c0102dcb:	e9 f4 00 00 00       	jmp    c0102ec4 <page_init+0x132>
        uint64_t begin = memmap->map[i].addr, end = begin + memmap->map[i].size;
c0102dd0:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
c0102dd3:	8b 55 dc             	mov    -0x24(%ebp),%edx
c0102dd6:	89 d0                	mov    %edx,%eax
c0102dd8:	c1 e0 02             	shl    $0x2,%eax
c0102ddb:	01 d0                	add    %edx,%eax
c0102ddd:	c1 e0 02             	shl    $0x2,%eax
c0102de0:	01 c8                	add    %ecx,%eax
c0102de2:	8b 50 08             	mov    0x8(%eax),%edx
c0102de5:	8b 40 04             	mov    0x4(%eax),%eax
c0102de8:	89 45 a0             	mov    %eax,-0x60(%ebp)
c0102deb:	89 55 a4             	mov    %edx,-0x5c(%ebp)
c0102dee:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
c0102df1:	8b 55 dc             	mov    -0x24(%ebp),%edx
c0102df4:	89 d0                	mov    %edx,%eax
c0102df6:	c1 e0 02             	shl    $0x2,%eax
c0102df9:	01 d0                	add    %edx,%eax
c0102dfb:	c1 e0 02             	shl    $0x2,%eax
c0102dfe:	01 c8                	add    %ecx,%eax
c0102e00:	8b 48 0c             	mov    0xc(%eax),%ecx
c0102e03:	8b 58 10             	mov    0x10(%eax),%ebx
c0102e06:	8b 45 a0             	mov    -0x60(%ebp),%eax
c0102e09:	8b 55 a4             	mov    -0x5c(%ebp),%edx
c0102e0c:	01 c8                	add    %ecx,%eax
c0102e0e:	11 da                	adc    %ebx,%edx
c0102e10:	89 45 98             	mov    %eax,-0x68(%ebp)
c0102e13:	89 55 9c             	mov    %edx,-0x64(%ebp)
        cprintf("  memory: %08llx, [%08llx, %08llx], type = %d.\n",
c0102e16:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
c0102e19:	8b 55 dc             	mov    -0x24(%ebp),%edx
c0102e1c:	89 d0                	mov    %edx,%eax
c0102e1e:	c1 e0 02             	shl    $0x2,%eax
c0102e21:	01 d0                	add    %edx,%eax
c0102e23:	c1 e0 02             	shl    $0x2,%eax
c0102e26:	01 c8                	add    %ecx,%eax
c0102e28:	83 c0 14             	add    $0x14,%eax
c0102e2b:	8b 00                	mov    (%eax),%eax
c0102e2d:	89 45 84             	mov    %eax,-0x7c(%ebp)
c0102e30:	8b 45 98             	mov    -0x68(%ebp),%eax
c0102e33:	8b 55 9c             	mov    -0x64(%ebp),%edx
c0102e36:	83 c0 ff             	add    $0xffffffff,%eax
c0102e39:	83 d2 ff             	adc    $0xffffffff,%edx
c0102e3c:	89 c1                	mov    %eax,%ecx
c0102e3e:	89 d3                	mov    %edx,%ebx
c0102e40:	8b 55 c4             	mov    -0x3c(%ebp),%edx
c0102e43:	89 55 80             	mov    %edx,-0x80(%ebp)
c0102e46:	8b 55 dc             	mov    -0x24(%ebp),%edx
c0102e49:	89 d0                	mov    %edx,%eax
c0102e4b:	c1 e0 02             	shl    $0x2,%eax
c0102e4e:	01 d0                	add    %edx,%eax
c0102e50:	c1 e0 02             	shl    $0x2,%eax
c0102e53:	03 45 80             	add    -0x80(%ebp),%eax
c0102e56:	8b 50 10             	mov    0x10(%eax),%edx
c0102e59:	8b 40 0c             	mov    0xc(%eax),%eax
c0102e5c:	ff 75 84             	pushl  -0x7c(%ebp)
c0102e5f:	53                   	push   %ebx
c0102e60:	51                   	push   %ecx
c0102e61:	ff 75 a4             	pushl  -0x5c(%ebp)
c0102e64:	ff 75 a0             	pushl  -0x60(%ebp)
c0102e67:	52                   	push   %edx
c0102e68:	50                   	push   %eax
c0102e69:	68 b4 64 10 c0       	push   $0xc01064b4
c0102e6e:	e8 1c d4 ff ff       	call   c010028f <cprintf>
c0102e73:	83 c4 20             	add    $0x20,%esp
                memmap->map[i].size, begin, end - 1, memmap->map[i].type);
        if (memmap->map[i].type == E820_ARM) {
c0102e76:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
c0102e79:	8b 55 dc             	mov    -0x24(%ebp),%edx
c0102e7c:	89 d0                	mov    %edx,%eax
c0102e7e:	c1 e0 02             	shl    $0x2,%eax
c0102e81:	01 d0                	add    %edx,%eax
c0102e83:	c1 e0 02             	shl    $0x2,%eax
c0102e86:	01 c8                	add    %ecx,%eax
c0102e88:	83 c0 14             	add    $0x14,%eax
c0102e8b:	8b 00                	mov    (%eax),%eax
c0102e8d:	83 f8 01             	cmp    $0x1,%eax
c0102e90:	75 2e                	jne    c0102ec0 <page_init+0x12e>
            if (maxpa < end && begin < KMEMSIZE) {
c0102e92:	8b 45 e0             	mov    -0x20(%ebp),%eax
c0102e95:	8b 55 e4             	mov    -0x1c(%ebp),%edx
c0102e98:	3b 45 98             	cmp    -0x68(%ebp),%eax
c0102e9b:	89 d0                	mov    %edx,%eax
c0102e9d:	1b 45 9c             	sbb    -0x64(%ebp),%eax
c0102ea0:	73 1e                	jae    c0102ec0 <page_init+0x12e>
c0102ea2:	ba ff ff ff 37       	mov    $0x37ffffff,%edx
c0102ea7:	b8 00 00 00 00       	mov    $0x0,%eax
c0102eac:	3b 55 a0             	cmp    -0x60(%ebp),%edx
c0102eaf:	1b 45 a4             	sbb    -0x5c(%ebp),%eax
c0102eb2:	72 0c                	jb     c0102ec0 <page_init+0x12e>
                maxpa = end;
c0102eb4:	8b 45 98             	mov    -0x68(%ebp),%eax
c0102eb7:	8b 55 9c             	mov    -0x64(%ebp),%edx
c0102eba:	89 45 e0             	mov    %eax,-0x20(%ebp)
c0102ebd:	89 55 e4             	mov    %edx,-0x1c(%ebp)
    for (i = 0; i < memmap->nr_map; i ++) {
c0102ec0:	83 45 dc 01          	addl   $0x1,-0x24(%ebp)
c0102ec4:	8b 45 c4             	mov    -0x3c(%ebp),%eax
c0102ec7:	8b 00                	mov    (%eax),%eax
c0102ec9:	39 45 dc             	cmp    %eax,-0x24(%ebp)
c0102ecc:	0f 8c fe fe ff ff    	jl     c0102dd0 <page_init+0x3e>
            }
        }
    }
    if (maxpa > KMEMSIZE) {
c0102ed2:	ba 00 00 00 38       	mov    $0x38000000,%edx
c0102ed7:	b8 00 00 00 00       	mov    $0x0,%eax
c0102edc:	3b 55 e0             	cmp    -0x20(%ebp),%edx
c0102edf:	1b 45 e4             	sbb    -0x1c(%ebp),%eax
c0102ee2:	73 0e                	jae    c0102ef2 <page_init+0x160>
        maxpa = KMEMSIZE;
c0102ee4:	c7 45 e0 00 00 00 38 	movl   $0x38000000,-0x20(%ebp)
c0102eeb:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    }

    extern char end[];

    npage = maxpa / PGSIZE;
c0102ef2:	8b 45 e0             	mov    -0x20(%ebp),%eax
c0102ef5:	8b 55 e4             	mov    -0x1c(%ebp),%edx
c0102ef8:	0f ac d0 0c          	shrd   $0xc,%edx,%eax
c0102efc:	c1 ea 0c             	shr    $0xc,%edx
c0102eff:	a3 c0 a8 11 c0       	mov    %eax,0xc011a8c0
    pages = (struct Page *)ROUNDUP((void *)end, PGSIZE);
c0102f04:	c7 45 c0 00 10 00 00 	movl   $0x1000,-0x40(%ebp)
c0102f0b:	b8 68 a9 11 c0       	mov    $0xc011a968,%eax
c0102f10:	8d 50 ff             	lea    -0x1(%eax),%edx
c0102f13:	8b 45 c0             	mov    -0x40(%ebp),%eax
c0102f16:	01 d0                	add    %edx,%eax
c0102f18:	89 45 bc             	mov    %eax,-0x44(%ebp)
c0102f1b:	8b 45 bc             	mov    -0x44(%ebp),%eax
c0102f1e:	ba 00 00 00 00       	mov    $0x0,%edx
c0102f23:	f7 75 c0             	divl   -0x40(%ebp)
c0102f26:	8b 45 bc             	mov    -0x44(%ebp),%eax
c0102f29:	29 d0                	sub    %edx,%eax
c0102f2b:	a3 58 a9 11 c0       	mov    %eax,0xc011a958

    for (i = 0; i < npage; i ++) {
c0102f30:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
c0102f37:	eb 30                	jmp    c0102f69 <page_init+0x1d7>
        SetPageReserved(pages + i);
c0102f39:	8b 0d 58 a9 11 c0    	mov    0xc011a958,%ecx
c0102f3f:	8b 55 dc             	mov    -0x24(%ebp),%edx
c0102f42:	89 d0                	mov    %edx,%eax
c0102f44:	c1 e0 02             	shl    $0x2,%eax
c0102f47:	01 d0                	add    %edx,%eax
c0102f49:	c1 e0 02             	shl    $0x2,%eax
c0102f4c:	01 c8                	add    %ecx,%eax
c0102f4e:	83 c0 04             	add    $0x4,%eax
c0102f51:	c7 45 94 00 00 00 00 	movl   $0x0,-0x6c(%ebp)
c0102f58:	89 45 90             	mov    %eax,-0x70(%ebp)
 * Note that @nr may be almost arbitrarily large; this function is not
 * restricted to acting on a single-word quantity.
 * */
static inline void
set_bit(int nr, volatile void *addr) {
    asm volatile ("btsl %1, %0" :"=m" (*(volatile long *)addr) : "Ir" (nr));
c0102f5b:	8b 45 90             	mov    -0x70(%ebp),%eax
c0102f5e:	8b 55 94             	mov    -0x6c(%ebp),%edx
c0102f61:	0f ab 10             	bts    %edx,(%eax)
}
c0102f64:	90                   	nop
    for (i = 0; i < npage; i ++) {
c0102f65:	83 45 dc 01          	addl   $0x1,-0x24(%ebp)
c0102f69:	8b 55 dc             	mov    -0x24(%ebp),%edx
c0102f6c:	a1 c0 a8 11 c0       	mov    0xc011a8c0,%eax
c0102f71:	39 c2                	cmp    %eax,%edx
c0102f73:	72 c4                	jb     c0102f39 <page_init+0x1a7>
    }

    uintptr_t freemem = PADDR((uintptr_t)pages + sizeof(struct Page) * npage);
c0102f75:	8b 15 c0 a8 11 c0    	mov    0xc011a8c0,%edx
c0102f7b:	89 d0                	mov    %edx,%eax
c0102f7d:	c1 e0 02             	shl    $0x2,%eax
c0102f80:	01 d0                	add    %edx,%eax
c0102f82:	c1 e0 02             	shl    $0x2,%eax
c0102f85:	89 c2                	mov    %eax,%edx
c0102f87:	a1 58 a9 11 c0       	mov    0xc011a958,%eax
c0102f8c:	01 d0                	add    %edx,%eax
c0102f8e:	89 45 b8             	mov    %eax,-0x48(%ebp)
c0102f91:	81 7d b8 ff ff ff bf 	cmpl   $0xbfffffff,-0x48(%ebp)
c0102f98:	77 17                	ja     c0102fb1 <page_init+0x21f>
c0102f9a:	ff 75 b8             	pushl  -0x48(%ebp)
c0102f9d:	68 e4 64 10 c0       	push   $0xc01064e4
c0102fa2:	68 db 00 00 00       	push   $0xdb
c0102fa7:	68 08 65 10 c0       	push   $0xc0106508
c0102fac:	e8 59 d4 ff ff       	call   c010040a <__panic>
c0102fb1:	8b 45 b8             	mov    -0x48(%ebp),%eax
c0102fb4:	05 00 00 00 40       	add    $0x40000000,%eax
c0102fb9:	89 45 b4             	mov    %eax,-0x4c(%ebp)

    for (i = 0; i < memmap->nr_map; i ++) {
c0102fbc:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
c0102fc3:	e9 53 01 00 00       	jmp    c010311b <page_init+0x389>
        uint64_t begin = memmap->map[i].addr, end = begin + memmap->map[i].size;
c0102fc8:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
c0102fcb:	8b 55 dc             	mov    -0x24(%ebp),%edx
c0102fce:	89 d0                	mov    %edx,%eax
c0102fd0:	c1 e0 02             	shl    $0x2,%eax
c0102fd3:	01 d0                	add    %edx,%eax
c0102fd5:	c1 e0 02             	shl    $0x2,%eax
c0102fd8:	01 c8                	add    %ecx,%eax
c0102fda:	8b 50 08             	mov    0x8(%eax),%edx
c0102fdd:	8b 40 04             	mov    0x4(%eax),%eax
c0102fe0:	89 45 d0             	mov    %eax,-0x30(%ebp)
c0102fe3:	89 55 d4             	mov    %edx,-0x2c(%ebp)
c0102fe6:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
c0102fe9:	8b 55 dc             	mov    -0x24(%ebp),%edx
c0102fec:	89 d0                	mov    %edx,%eax
c0102fee:	c1 e0 02             	shl    $0x2,%eax
c0102ff1:	01 d0                	add    %edx,%eax
c0102ff3:	c1 e0 02             	shl    $0x2,%eax
c0102ff6:	01 c8                	add    %ecx,%eax
c0102ff8:	8b 48 0c             	mov    0xc(%eax),%ecx
c0102ffb:	8b 58 10             	mov    0x10(%eax),%ebx
c0102ffe:	8b 45 d0             	mov    -0x30(%ebp),%eax
c0103001:	8b 55 d4             	mov    -0x2c(%ebp),%edx
c0103004:	01 c8                	add    %ecx,%eax
c0103006:	11 da                	adc    %ebx,%edx
c0103008:	89 45 c8             	mov    %eax,-0x38(%ebp)
c010300b:	89 55 cc             	mov    %edx,-0x34(%ebp)
        if (memmap->map[i].type == E820_ARM) {
c010300e:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
c0103011:	8b 55 dc             	mov    -0x24(%ebp),%edx
c0103014:	89 d0                	mov    %edx,%eax
c0103016:	c1 e0 02             	shl    $0x2,%eax
c0103019:	01 d0                	add    %edx,%eax
c010301b:	c1 e0 02             	shl    $0x2,%eax
c010301e:	01 c8                	add    %ecx,%eax
c0103020:	83 c0 14             	add    $0x14,%eax
c0103023:	8b 00                	mov    (%eax),%eax
c0103025:	83 f8 01             	cmp    $0x1,%eax
c0103028:	0f 85 e9 00 00 00    	jne    c0103117 <page_init+0x385>
            if (begin < freemem) {
c010302e:	8b 45 b4             	mov    -0x4c(%ebp),%eax
c0103031:	ba 00 00 00 00       	mov    $0x0,%edx
c0103036:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
c0103039:	39 45 d0             	cmp    %eax,-0x30(%ebp)
c010303c:	19 d1                	sbb    %edx,%ecx
c010303e:	73 0d                	jae    c010304d <page_init+0x2bb>
                begin = freemem;
c0103040:	8b 45 b4             	mov    -0x4c(%ebp),%eax
c0103043:	89 45 d0             	mov    %eax,-0x30(%ebp)
c0103046:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
            }
            if (end > KMEMSIZE) {
c010304d:	ba 00 00 00 38       	mov    $0x38000000,%edx
c0103052:	b8 00 00 00 00       	mov    $0x0,%eax
c0103057:	3b 55 c8             	cmp    -0x38(%ebp),%edx
c010305a:	1b 45 cc             	sbb    -0x34(%ebp),%eax
c010305d:	73 0e                	jae    c010306d <page_init+0x2db>
                end = KMEMSIZE;
c010305f:	c7 45 c8 00 00 00 38 	movl   $0x38000000,-0x38(%ebp)
c0103066:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
            }
            if (begin < end) {
c010306d:	8b 45 d0             	mov    -0x30(%ebp),%eax
c0103070:	8b 55 d4             	mov    -0x2c(%ebp),%edx
c0103073:	3b 45 c8             	cmp    -0x38(%ebp),%eax
c0103076:	89 d0                	mov    %edx,%eax
c0103078:	1b 45 cc             	sbb    -0x34(%ebp),%eax
c010307b:	0f 83 96 00 00 00    	jae    c0103117 <page_init+0x385>
                begin = ROUNDUP(begin, PGSIZE);
c0103081:	c7 45 b0 00 10 00 00 	movl   $0x1000,-0x50(%ebp)
c0103088:	8b 55 d0             	mov    -0x30(%ebp),%edx
c010308b:	8b 45 b0             	mov    -0x50(%ebp),%eax
c010308e:	01 d0                	add    %edx,%eax
c0103090:	83 e8 01             	sub    $0x1,%eax
c0103093:	89 45 ac             	mov    %eax,-0x54(%ebp)
c0103096:	8b 45 ac             	mov    -0x54(%ebp),%eax
c0103099:	ba 00 00 00 00       	mov    $0x0,%edx
c010309e:	f7 75 b0             	divl   -0x50(%ebp)
c01030a1:	8b 45 ac             	mov    -0x54(%ebp),%eax
c01030a4:	29 d0                	sub    %edx,%eax
c01030a6:	ba 00 00 00 00       	mov    $0x0,%edx
c01030ab:	89 45 d0             	mov    %eax,-0x30(%ebp)
c01030ae:	89 55 d4             	mov    %edx,-0x2c(%ebp)
                end = ROUNDDOWN(end, PGSIZE);
c01030b1:	8b 45 c8             	mov    -0x38(%ebp),%eax
c01030b4:	89 45 a8             	mov    %eax,-0x58(%ebp)
c01030b7:	8b 45 a8             	mov    -0x58(%ebp),%eax
c01030ba:	ba 00 00 00 00       	mov    $0x0,%edx
c01030bf:	89 c3                	mov    %eax,%ebx
c01030c1:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
c01030c7:	89 de                	mov    %ebx,%esi
c01030c9:	89 d0                	mov    %edx,%eax
c01030cb:	83 e0 00             	and    $0x0,%eax
c01030ce:	89 c7                	mov    %eax,%edi
c01030d0:	89 75 c8             	mov    %esi,-0x38(%ebp)
c01030d3:	89 7d cc             	mov    %edi,-0x34(%ebp)
                if (begin < end) {
c01030d6:	8b 45 d0             	mov    -0x30(%ebp),%eax
c01030d9:	8b 55 d4             	mov    -0x2c(%ebp),%edx
c01030dc:	3b 45 c8             	cmp    -0x38(%ebp),%eax
c01030df:	89 d0                	mov    %edx,%eax
c01030e1:	1b 45 cc             	sbb    -0x34(%ebp),%eax
c01030e4:	73 31                	jae    c0103117 <page_init+0x385>
                    init_memmap(pa2page(begin), (end - begin) / PGSIZE);
c01030e6:	8b 45 c8             	mov    -0x38(%ebp),%eax
c01030e9:	8b 55 cc             	mov    -0x34(%ebp),%edx
c01030ec:	2b 45 d0             	sub    -0x30(%ebp),%eax
c01030ef:	1b 55 d4             	sbb    -0x2c(%ebp),%edx
c01030f2:	0f ac d0 0c          	shrd   $0xc,%edx,%eax
c01030f6:	c1 ea 0c             	shr    $0xc,%edx
c01030f9:	89 c3                	mov    %eax,%ebx
c01030fb:	8b 45 d0             	mov    -0x30(%ebp),%eax
c01030fe:	83 ec 0c             	sub    $0xc,%esp
c0103101:	50                   	push   %eax
c0103102:	e8 07 f9 ff ff       	call   c0102a0e <pa2page>
c0103107:	83 c4 10             	add    $0x10,%esp
c010310a:	83 ec 08             	sub    $0x8,%esp
c010310d:	53                   	push   %ebx
c010310e:	50                   	push   %eax
c010310f:	e8 ae fb ff ff       	call   c0102cc2 <init_memmap>
c0103114:	83 c4 10             	add    $0x10,%esp
    for (i = 0; i < memmap->nr_map; i ++) {
c0103117:	83 45 dc 01          	addl   $0x1,-0x24(%ebp)
c010311b:	8b 45 c4             	mov    -0x3c(%ebp),%eax
c010311e:	8b 00                	mov    (%eax),%eax
c0103120:	39 45 dc             	cmp    %eax,-0x24(%ebp)
c0103123:	0f 8c 9f fe ff ff    	jl     c0102fc8 <page_init+0x236>
                }
            }
        }
    }
}
c0103129:	90                   	nop
c010312a:	90                   	nop
c010312b:	8d 65 f4             	lea    -0xc(%ebp),%esp
c010312e:	5b                   	pop    %ebx
c010312f:	5e                   	pop    %esi
c0103130:	5f                   	pop    %edi
c0103131:	5d                   	pop    %ebp
c0103132:	c3                   	ret    

c0103133 <enable_paging>:

static void
enable_paging(void) {
c0103133:	f3 0f 1e fb          	endbr32 
c0103137:	55                   	push   %ebp
c0103138:	89 e5                	mov    %esp,%ebp
c010313a:	83 ec 10             	sub    $0x10,%esp
    lcr3(boot_cr3);
c010313d:	a1 54 a9 11 c0       	mov    0xc011a954,%eax
c0103142:	89 45 f0             	mov    %eax,-0x10(%ebp)
    asm volatile ("mov %0, %%cr0" :: "r" (cr0) : "memory");
}

static inline void
lcr3(uintptr_t cr3) {
    asm volatile ("mov %0, %%cr3" :: "r" (cr3) : "memory");
c0103145:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0103148:	0f 22 d8             	mov    %eax,%cr3
}
c010314b:	90                   	nop

static inline uintptr_t
rcr0(void) {
    uintptr_t cr0;
    asm volatile ("mov %%cr0, %0" : "=r" (cr0) :: "memory");
c010314c:	0f 20 c0             	mov    %cr0,%eax
c010314f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    return cr0;
c0103152:	8b 45 f4             	mov    -0xc(%ebp),%eax

    // turn on paging
    uint32_t cr0 = rcr0();
c0103155:	89 45 fc             	mov    %eax,-0x4(%ebp)
    cr0 |= CR0_PE | CR0_PG | CR0_AM | CR0_WP | CR0_NE | CR0_TS | CR0_EM | CR0_MP;
c0103158:	81 4d fc 2f 00 05 80 	orl    $0x8005002f,-0x4(%ebp)
    cr0 &= ~(CR0_TS | CR0_EM);
c010315f:	83 65 fc f3          	andl   $0xfffffff3,-0x4(%ebp)
c0103163:	8b 45 fc             	mov    -0x4(%ebp),%eax
c0103166:	89 45 f8             	mov    %eax,-0x8(%ebp)
    asm volatile ("mov %0, %%cr0" :: "r" (cr0) : "memory");
c0103169:	8b 45 f8             	mov    -0x8(%ebp),%eax
c010316c:	0f 22 c0             	mov    %eax,%cr0
}
c010316f:	90                   	nop
    lcr0(cr0);
}
c0103170:	90                   	nop
c0103171:	c9                   	leave  
c0103172:	c3                   	ret    

c0103173 <boot_map_segment>:
//  la:   linear address of this memory need to map (after x86 segment map)
//  size: memory size
//  pa:   physical address of this memory
//  perm: permission of this memory  
static void
boot_map_segment(pde_t *pgdir, uintptr_t la, size_t size, uintptr_t pa, uint32_t perm) {
c0103173:	f3 0f 1e fb          	endbr32 
c0103177:	55                   	push   %ebp
c0103178:	89 e5                	mov    %esp,%ebp
c010317a:	83 ec 28             	sub    $0x28,%esp
    assert(PGOFF(la) == PGOFF(pa));
c010317d:	8b 45 0c             	mov    0xc(%ebp),%eax
c0103180:	33 45 14             	xor    0x14(%ebp),%eax
c0103183:	25 ff 0f 00 00       	and    $0xfff,%eax
c0103188:	85 c0                	test   %eax,%eax
c010318a:	74 19                	je     c01031a5 <boot_map_segment+0x32>
c010318c:	68 16 65 10 c0       	push   $0xc0106516
c0103191:	68 2d 65 10 c0       	push   $0xc010652d
c0103196:	68 04 01 00 00       	push   $0x104
c010319b:	68 08 65 10 c0       	push   $0xc0106508
c01031a0:	e8 65 d2 ff ff       	call   c010040a <__panic>
    size_t n = ROUNDUP(size + PGOFF(la), PGSIZE) / PGSIZE;
c01031a5:	c7 45 f0 00 10 00 00 	movl   $0x1000,-0x10(%ebp)
c01031ac:	8b 45 0c             	mov    0xc(%ebp),%eax
c01031af:	25 ff 0f 00 00       	and    $0xfff,%eax
c01031b4:	89 c2                	mov    %eax,%edx
c01031b6:	8b 45 10             	mov    0x10(%ebp),%eax
c01031b9:	01 c2                	add    %eax,%edx
c01031bb:	8b 45 f0             	mov    -0x10(%ebp),%eax
c01031be:	01 d0                	add    %edx,%eax
c01031c0:	83 e8 01             	sub    $0x1,%eax
c01031c3:	89 45 ec             	mov    %eax,-0x14(%ebp)
c01031c6:	8b 45 ec             	mov    -0x14(%ebp),%eax
c01031c9:	ba 00 00 00 00       	mov    $0x0,%edx
c01031ce:	f7 75 f0             	divl   -0x10(%ebp)
c01031d1:	8b 45 ec             	mov    -0x14(%ebp),%eax
c01031d4:	29 d0                	sub    %edx,%eax
c01031d6:	c1 e8 0c             	shr    $0xc,%eax
c01031d9:	89 45 f4             	mov    %eax,-0xc(%ebp)
    la = ROUNDDOWN(la, PGSIZE);
c01031dc:	8b 45 0c             	mov    0xc(%ebp),%eax
c01031df:	89 45 e8             	mov    %eax,-0x18(%ebp)
c01031e2:	8b 45 e8             	mov    -0x18(%ebp),%eax
c01031e5:	25 00 f0 ff ff       	and    $0xfffff000,%eax
c01031ea:	89 45 0c             	mov    %eax,0xc(%ebp)
    pa = ROUNDDOWN(pa, PGSIZE);
c01031ed:	8b 45 14             	mov    0x14(%ebp),%eax
c01031f0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
c01031f3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c01031f6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
c01031fb:	89 45 14             	mov    %eax,0x14(%ebp)
    for (; n > 0; n --, la += PGSIZE, pa += PGSIZE) {
c01031fe:	eb 57                	jmp    c0103257 <boot_map_segment+0xe4>
        pte_t *ptep = get_pte(pgdir, la, 1);
c0103200:	83 ec 04             	sub    $0x4,%esp
c0103203:	6a 01                	push   $0x1
c0103205:	ff 75 0c             	pushl  0xc(%ebp)
c0103208:	ff 75 08             	pushl  0x8(%ebp)
c010320b:	e8 a1 01 00 00       	call   c01033b1 <get_pte>
c0103210:	83 c4 10             	add    $0x10,%esp
c0103213:	89 45 e0             	mov    %eax,-0x20(%ebp)
        assert(ptep != NULL);
c0103216:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
c010321a:	75 19                	jne    c0103235 <boot_map_segment+0xc2>
c010321c:	68 42 65 10 c0       	push   $0xc0106542
c0103221:	68 2d 65 10 c0       	push   $0xc010652d
c0103226:	68 0a 01 00 00       	push   $0x10a
c010322b:	68 08 65 10 c0       	push   $0xc0106508
c0103230:	e8 d5 d1 ff ff       	call   c010040a <__panic>
        *ptep = pa | PTE_P | perm;
c0103235:	8b 45 14             	mov    0x14(%ebp),%eax
c0103238:	0b 45 18             	or     0x18(%ebp),%eax
c010323b:	83 c8 01             	or     $0x1,%eax
c010323e:	89 c2                	mov    %eax,%edx
c0103240:	8b 45 e0             	mov    -0x20(%ebp),%eax
c0103243:	89 10                	mov    %edx,(%eax)
    for (; n > 0; n --, la += PGSIZE, pa += PGSIZE) {
c0103245:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
c0103249:	81 45 0c 00 10 00 00 	addl   $0x1000,0xc(%ebp)
c0103250:	81 45 14 00 10 00 00 	addl   $0x1000,0x14(%ebp)
c0103257:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
c010325b:	75 a3                	jne    c0103200 <boot_map_segment+0x8d>
    }
}
c010325d:	90                   	nop
c010325e:	90                   	nop
c010325f:	c9                   	leave  
c0103260:	c3                   	ret    

c0103261 <boot_alloc_page>:

//boot_alloc_page - allocate one page using pmm->alloc_pages(1) 
// return value: the kernel virtual address of this allocated page
//note: this function is used to get the memory for PDT(Page Directory Table)&PT(Page Table)
static void *
boot_alloc_page(void) {
c0103261:	f3 0f 1e fb          	endbr32 
c0103265:	55                   	push   %ebp
c0103266:	89 e5                	mov    %esp,%ebp
c0103268:	83 ec 18             	sub    $0x18,%esp
    struct Page *p = alloc_page();
c010326b:	83 ec 0c             	sub    $0xc,%esp
c010326e:	6a 01                	push   $0x1
c0103270:	e8 70 fa ff ff       	call   c0102ce5 <alloc_pages>
c0103275:	83 c4 10             	add    $0x10,%esp
c0103278:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (p == NULL) {
c010327b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
c010327f:	75 17                	jne    c0103298 <boot_alloc_page+0x37>
        panic("boot_alloc_page failed.\n");
c0103281:	83 ec 04             	sub    $0x4,%esp
c0103284:	68 4f 65 10 c0       	push   $0xc010654f
c0103289:	68 16 01 00 00       	push   $0x116
c010328e:	68 08 65 10 c0       	push   $0xc0106508
c0103293:	e8 72 d1 ff ff       	call   c010040a <__panic>
    }
    return page2kva(p);
c0103298:	83 ec 0c             	sub    $0xc,%esp
c010329b:	ff 75 f4             	pushl  -0xc(%ebp)
c010329e:	e8 b2 f7 ff ff       	call   c0102a55 <page2kva>
c01032a3:	83 c4 10             	add    $0x10,%esp
}
c01032a6:	c9                   	leave  
c01032a7:	c3                   	ret    

c01032a8 <pmm_init>:

//pmm_init - setup a pmm to manage physical memory, build PDT&PT to setup paging mechanism 
//         - check the correctness of pmm & paging mechanism, print PDT&PT
void
pmm_init(void) {
c01032a8:	f3 0f 1e fb          	endbr32 
c01032ac:	55                   	push   %ebp
c01032ad:	89 e5                	mov    %esp,%ebp
c01032af:	83 ec 18             	sub    $0x18,%esp
    //We need to alloc/free the physical memory (granularity is 4KB or other size). 
    //So a framework of physical memory manager (struct pmm_manager)is defined in pmm.h
    //First we should init a physical memory manager(pmm) based on the framework.
    //Then pmm can alloc/free the physical memory. 
    //Now the first_fit/best_fit/worst_fit/buddy_system pmm are available.
    init_pmm_manager();
c01032b2:	e8 d2 f9 ff ff       	call   c0102c89 <init_pmm_manager>

    // detect physical memory space, reserve already used memory,
    // then use pmm->init_memmap to create free page list
    page_init();
c01032b7:	e8 d6 fa ff ff       	call   c0102d92 <page_init>

    //use pmm->check to verify the correctness of the alloc/free function in a pmm
    check_alloc_page();
c01032bc:	e8 9a 02 00 00       	call   c010355b <check_alloc_page>

    // create boot_pgdir, an initial page directory(Page Directory Table, PDT)
    boot_pgdir = boot_alloc_page();
c01032c1:	e8 9b ff ff ff       	call   c0103261 <boot_alloc_page>
c01032c6:	a3 c4 a8 11 c0       	mov    %eax,0xc011a8c4
    memset(boot_pgdir, 0, PGSIZE);
c01032cb:	a1 c4 a8 11 c0       	mov    0xc011a8c4,%eax
c01032d0:	83 ec 04             	sub    $0x4,%esp
c01032d3:	68 00 10 00 00       	push   $0x1000
c01032d8:	6a 00                	push   $0x0
c01032da:	50                   	push   %eax
c01032db:	e8 58 22 00 00       	call   c0105538 <memset>
c01032e0:	83 c4 10             	add    $0x10,%esp
    boot_cr3 = PADDR(boot_pgdir);
c01032e3:	a1 c4 a8 11 c0       	mov    0xc011a8c4,%eax
c01032e8:	89 45 f4             	mov    %eax,-0xc(%ebp)
c01032eb:	81 7d f4 ff ff ff bf 	cmpl   $0xbfffffff,-0xc(%ebp)
c01032f2:	77 17                	ja     c010330b <pmm_init+0x63>
c01032f4:	ff 75 f4             	pushl  -0xc(%ebp)
c01032f7:	68 e4 64 10 c0       	push   $0xc01064e4
c01032fc:	68 30 01 00 00       	push   $0x130
c0103301:	68 08 65 10 c0       	push   $0xc0106508
c0103306:	e8 ff d0 ff ff       	call   c010040a <__panic>
c010330b:	8b 45 f4             	mov    -0xc(%ebp),%eax
c010330e:	05 00 00 00 40       	add    $0x40000000,%eax
c0103313:	a3 54 a9 11 c0       	mov    %eax,0xc011a954

    check_pgdir();
c0103318:	e8 65 02 00 00       	call   c0103582 <check_pgdir>

    static_assert(KERNBASE % PTSIZE == 0 && KERNTOP % PTSIZE == 0);

    // recursively insert boot_pgdir in itself
    // to form a virtual page table at virtual address VPT
    boot_pgdir[PDX(VPT)] = PADDR(boot_pgdir) | PTE_P | PTE_W;
c010331d:	a1 c4 a8 11 c0       	mov    0xc011a8c4,%eax
c0103322:	89 45 f0             	mov    %eax,-0x10(%ebp)
c0103325:	81 7d f0 ff ff ff bf 	cmpl   $0xbfffffff,-0x10(%ebp)
c010332c:	77 17                	ja     c0103345 <pmm_init+0x9d>
c010332e:	ff 75 f0             	pushl  -0x10(%ebp)
c0103331:	68 e4 64 10 c0       	push   $0xc01064e4
c0103336:	68 38 01 00 00       	push   $0x138
c010333b:	68 08 65 10 c0       	push   $0xc0106508
c0103340:	e8 c5 d0 ff ff       	call   c010040a <__panic>
c0103345:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0103348:	8d 90 00 00 00 40    	lea    0x40000000(%eax),%edx
c010334e:	a1 c4 a8 11 c0       	mov    0xc011a8c4,%eax
c0103353:	05 ac 0f 00 00       	add    $0xfac,%eax
c0103358:	83 ca 03             	or     $0x3,%edx
c010335b:	89 10                	mov    %edx,(%eax)

    // map all physical memory to linear memory with base linear addr KERNBASE
    //linear_addr KERNBASE~KERNBASE+KMEMSIZE = phy_addr 0~KMEMSIZE
    //But shouldn't use this map until enable_paging() & gdt_init() finished.
    boot_map_segment(boot_pgdir, KERNBASE, KMEMSIZE, 0, PTE_W);
c010335d:	a1 c4 a8 11 c0       	mov    0xc011a8c4,%eax
c0103362:	83 ec 0c             	sub    $0xc,%esp
c0103365:	6a 02                	push   $0x2
c0103367:	6a 00                	push   $0x0
c0103369:	68 00 00 00 38       	push   $0x38000000
c010336e:	68 00 00 00 c0       	push   $0xc0000000
c0103373:	50                   	push   %eax
c0103374:	e8 fa fd ff ff       	call   c0103173 <boot_map_segment>
c0103379:	83 c4 20             	add    $0x20,%esp

    //temporary map: 
    //virtual_addr 3G~3G+4M = linear_addr 0~4M = linear_addr 3G~3G+4M = phy_addr 0~4M     
    boot_pgdir[0] = boot_pgdir[PDX(KERNBASE)];
c010337c:	8b 15 c4 a8 11 c0    	mov    0xc011a8c4,%edx
c0103382:	a1 c4 a8 11 c0       	mov    0xc011a8c4,%eax
c0103387:	8b 92 00 0c 00 00    	mov    0xc00(%edx),%edx
c010338d:	89 10                	mov    %edx,(%eax)

    enable_paging();
c010338f:	e8 9f fd ff ff       	call   c0103133 <enable_paging>

    //reload gdt(third time,the last time) to map all physical memory
    //virtual_addr 0~4G=liear_addr 0~4G
    //then set kernel stack(ss:esp) in TSS, setup TSS in gdt, load TSS
    gdt_init();
c0103394:	e8 f9 f7 ff ff       	call   c0102b92 <gdt_init>

    //disable the map of virtual_addr 0~4M
    boot_pgdir[0] = 0;
c0103399:	a1 c4 a8 11 c0       	mov    0xc011a8c4,%eax
c010339e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

    //now the basic virtual memory map(see memalyout.h) is established.
    //check the correctness of the basic virtual memory map.
    check_boot_pgdir();
c01033a4:	e8 43 07 00 00       	call   c0103aec <check_boot_pgdir>

    print_pgdir();
c01033a9:	e8 4a 0b 00 00       	call   c0103ef8 <print_pgdir>

}
c01033ae:	90                   	nop
c01033af:	c9                   	leave  
c01033b0:	c3                   	ret    

c01033b1 <get_pte>:
//  pgdir:  the kernel virtual base address of PDT
//  la:     the linear address need to map
//  create: a logical value to decide if alloc a page for PT
// return vaule: the kernel virtual address of this pte
pte_t *
get_pte(pde_t *pgdir, uintptr_t la, bool create) {
c01033b1:	f3 0f 1e fb          	endbr32 
c01033b5:	55                   	push   %ebp
c01033b6:	89 e5                	mov    %esp,%ebp
                          // (6) clear page content using memset
                          // (7) set page directory entry's permission
    }
    return NULL;          // (8) return page table entry
#endif
}
c01033b8:	90                   	nop
c01033b9:	5d                   	pop    %ebp
c01033ba:	c3                   	ret    

c01033bb <get_page>:

//get_page - get related Page struct for linear address la using PDT pgdir
struct Page *
get_page(pde_t *pgdir, uintptr_t la, pte_t **ptep_store) {
c01033bb:	f3 0f 1e fb          	endbr32 
c01033bf:	55                   	push   %ebp
c01033c0:	89 e5                	mov    %esp,%ebp
c01033c2:	83 ec 18             	sub    $0x18,%esp
    pte_t *ptep = get_pte(pgdir, la, 0);
c01033c5:	6a 00                	push   $0x0
c01033c7:	ff 75 0c             	pushl  0xc(%ebp)
c01033ca:	ff 75 08             	pushl  0x8(%ebp)
c01033cd:	e8 df ff ff ff       	call   c01033b1 <get_pte>
c01033d2:	83 c4 0c             	add    $0xc,%esp
c01033d5:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (ptep_store != NULL) {
c01033d8:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
c01033dc:	74 08                	je     c01033e6 <get_page+0x2b>
        *ptep_store = ptep;
c01033de:	8b 45 10             	mov    0x10(%ebp),%eax
c01033e1:	8b 55 f4             	mov    -0xc(%ebp),%edx
c01033e4:	89 10                	mov    %edx,(%eax)
    }
    if (ptep != NULL && *ptep & PTE_P) {
c01033e6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
c01033ea:	74 1f                	je     c010340b <get_page+0x50>
c01033ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
c01033ef:	8b 00                	mov    (%eax),%eax
c01033f1:	83 e0 01             	and    $0x1,%eax
c01033f4:	85 c0                	test   %eax,%eax
c01033f6:	74 13                	je     c010340b <get_page+0x50>
        return pa2page(*ptep);
c01033f8:	8b 45 f4             	mov    -0xc(%ebp),%eax
c01033fb:	8b 00                	mov    (%eax),%eax
c01033fd:	83 ec 0c             	sub    $0xc,%esp
c0103400:	50                   	push   %eax
c0103401:	e8 08 f6 ff ff       	call   c0102a0e <pa2page>
c0103406:	83 c4 10             	add    $0x10,%esp
c0103409:	eb 05                	jmp    c0103410 <get_page+0x55>
    }
    return NULL;
c010340b:	b8 00 00 00 00       	mov    $0x0,%eax
}
c0103410:	c9                   	leave  
c0103411:	c3                   	ret    

c0103412 <page_remove_pte>:

//page_remove_pte - free an Page sturct which is related linear address la
//                - and clean(invalidate) pte which is related linear address la
//note: PT is changed, so the TLB need to be invalidate 
static inline void
page_remove_pte(pde_t *pgdir, uintptr_t la, pte_t *ptep) {
c0103412:	55                   	push   %ebp
c0103413:	89 e5                	mov    %esp,%ebp
                                  //(4) and free this page when page reference reachs 0
                                  //(5) clear second page table entry
                                  //(6) flush tlb
    }
#endif
}
c0103415:	90                   	nop
c0103416:	5d                   	pop    %ebp
c0103417:	c3                   	ret    

c0103418 <page_remove>:

//page_remove - free an Page which is related linear address la and has an validated pte
void
page_remove(pde_t *pgdir, uintptr_t la) {
c0103418:	f3 0f 1e fb          	endbr32 
c010341c:	55                   	push   %ebp
c010341d:	89 e5                	mov    %esp,%ebp
c010341f:	83 ec 10             	sub    $0x10,%esp
    pte_t *ptep = get_pte(pgdir, la, 0);
c0103422:	6a 00                	push   $0x0
c0103424:	ff 75 0c             	pushl  0xc(%ebp)
c0103427:	ff 75 08             	pushl  0x8(%ebp)
c010342a:	e8 82 ff ff ff       	call   c01033b1 <get_pte>
c010342f:	83 c4 0c             	add    $0xc,%esp
c0103432:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (ptep != NULL) {
c0103435:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
c0103439:	74 11                	je     c010344c <page_remove+0x34>
        page_remove_pte(pgdir, la, ptep);
c010343b:	ff 75 fc             	pushl  -0x4(%ebp)
c010343e:	ff 75 0c             	pushl  0xc(%ebp)
c0103441:	ff 75 08             	pushl  0x8(%ebp)
c0103444:	e8 c9 ff ff ff       	call   c0103412 <page_remove_pte>
c0103449:	83 c4 0c             	add    $0xc,%esp
    }
}
c010344c:	90                   	nop
c010344d:	c9                   	leave  
c010344e:	c3                   	ret    

c010344f <page_insert>:
//  la:    the linear address need to map
//  perm:  the permission of this Page which is setted in related pte
// return value: always 0
//note: PT is changed, so the TLB need to be invalidate 
int
page_insert(pde_t *pgdir, struct Page *page, uintptr_t la, uint32_t perm) {
c010344f:	f3 0f 1e fb          	endbr32 
c0103453:	55                   	push   %ebp
c0103454:	89 e5                	mov    %esp,%ebp
c0103456:	83 ec 18             	sub    $0x18,%esp
    pte_t *ptep = get_pte(pgdir, la, 1);
c0103459:	6a 01                	push   $0x1
c010345b:	ff 75 10             	pushl  0x10(%ebp)
c010345e:	ff 75 08             	pushl  0x8(%ebp)
c0103461:	e8 4b ff ff ff       	call   c01033b1 <get_pte>
c0103466:	83 c4 0c             	add    $0xc,%esp
c0103469:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (ptep == NULL) {
c010346c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
c0103470:	75 0a                	jne    c010347c <page_insert+0x2d>
        return -E_NO_MEM;
c0103472:	b8 fc ff ff ff       	mov    $0xfffffffc,%eax
c0103477:	e9 88 00 00 00       	jmp    c0103504 <page_insert+0xb5>
    }
    page_ref_inc(page);
c010347c:	ff 75 0c             	pushl  0xc(%ebp)
c010347f:	e8 5a f6 ff ff       	call   c0102ade <page_ref_inc>
c0103484:	83 c4 04             	add    $0x4,%esp
    if (*ptep & PTE_P) {
c0103487:	8b 45 f4             	mov    -0xc(%ebp),%eax
c010348a:	8b 00                	mov    (%eax),%eax
c010348c:	83 e0 01             	and    $0x1,%eax
c010348f:	85 c0                	test   %eax,%eax
c0103491:	74 40                	je     c01034d3 <page_insert+0x84>
        struct Page *p = pte2page(*ptep);
c0103493:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0103496:	8b 00                	mov    (%eax),%eax
c0103498:	83 ec 0c             	sub    $0xc,%esp
c010349b:	50                   	push   %eax
c010349c:	e8 f9 f5 ff ff       	call   c0102a9a <pte2page>
c01034a1:	83 c4 10             	add    $0x10,%esp
c01034a4:	89 45 f0             	mov    %eax,-0x10(%ebp)
        if (p == page) {
c01034a7:	8b 45 f0             	mov    -0x10(%ebp),%eax
c01034aa:	3b 45 0c             	cmp    0xc(%ebp),%eax
c01034ad:	75 10                	jne    c01034bf <page_insert+0x70>
            page_ref_dec(page);
c01034af:	83 ec 0c             	sub    $0xc,%esp
c01034b2:	ff 75 0c             	pushl  0xc(%ebp)
c01034b5:	e8 3b f6 ff ff       	call   c0102af5 <page_ref_dec>
c01034ba:	83 c4 10             	add    $0x10,%esp
c01034bd:	eb 14                	jmp    c01034d3 <page_insert+0x84>
        }
        else {
            page_remove_pte(pgdir, la, ptep);
c01034bf:	83 ec 04             	sub    $0x4,%esp
c01034c2:	ff 75 f4             	pushl  -0xc(%ebp)
c01034c5:	ff 75 10             	pushl  0x10(%ebp)
c01034c8:	ff 75 08             	pushl  0x8(%ebp)
c01034cb:	e8 42 ff ff ff       	call   c0103412 <page_remove_pte>
c01034d0:	83 c4 10             	add    $0x10,%esp
        }
    }
    *ptep = page2pa(page) | PTE_P | perm;
c01034d3:	83 ec 0c             	sub    $0xc,%esp
c01034d6:	ff 75 0c             	pushl  0xc(%ebp)
c01034d9:	e8 1d f5 ff ff       	call   c01029fb <page2pa>
c01034de:	83 c4 10             	add    $0x10,%esp
c01034e1:	0b 45 14             	or     0x14(%ebp),%eax
c01034e4:	83 c8 01             	or     $0x1,%eax
c01034e7:	89 c2                	mov    %eax,%edx
c01034e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
c01034ec:	89 10                	mov    %edx,(%eax)
    tlb_invalidate(pgdir, la);
c01034ee:	83 ec 08             	sub    $0x8,%esp
c01034f1:	ff 75 10             	pushl  0x10(%ebp)
c01034f4:	ff 75 08             	pushl  0x8(%ebp)
c01034f7:	e8 0a 00 00 00       	call   c0103506 <tlb_invalidate>
c01034fc:	83 c4 10             	add    $0x10,%esp
    return 0;
c01034ff:	b8 00 00 00 00       	mov    $0x0,%eax
}
c0103504:	c9                   	leave  
c0103505:	c3                   	ret    

c0103506 <tlb_invalidate>:

// invalidate a TLB entry, but only if the page tables being
// edited are the ones currently in use by the processor.
void
tlb_invalidate(pde_t *pgdir, uintptr_t la) {
c0103506:	f3 0f 1e fb          	endbr32 
c010350a:	55                   	push   %ebp
c010350b:	89 e5                	mov    %esp,%ebp
c010350d:	83 ec 18             	sub    $0x18,%esp
}

static inline uintptr_t
rcr3(void) {
    uintptr_t cr3;
    asm volatile ("mov %%cr3, %0" : "=r" (cr3) :: "memory");
c0103510:	0f 20 d8             	mov    %cr3,%eax
c0103513:	89 45 f0             	mov    %eax,-0x10(%ebp)
    return cr3;
c0103516:	8b 55 f0             	mov    -0x10(%ebp),%edx
    if (rcr3() == PADDR(pgdir)) {
c0103519:	8b 45 08             	mov    0x8(%ebp),%eax
c010351c:	89 45 f4             	mov    %eax,-0xc(%ebp)
c010351f:	81 7d f4 ff ff ff bf 	cmpl   $0xbfffffff,-0xc(%ebp)
c0103526:	77 17                	ja     c010353f <tlb_invalidate+0x39>
c0103528:	ff 75 f4             	pushl  -0xc(%ebp)
c010352b:	68 e4 64 10 c0       	push   $0xc01064e4
c0103530:	68 d8 01 00 00       	push   $0x1d8
c0103535:	68 08 65 10 c0       	push   $0xc0106508
c010353a:	e8 cb ce ff ff       	call   c010040a <__panic>
c010353f:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0103542:	05 00 00 00 40       	add    $0x40000000,%eax
c0103547:	39 d0                	cmp    %edx,%eax
c0103549:	75 0d                	jne    c0103558 <tlb_invalidate+0x52>
        invlpg((void *)la);
c010354b:	8b 45 0c             	mov    0xc(%ebp),%eax
c010354e:	89 45 ec             	mov    %eax,-0x14(%ebp)
}

static inline void
invlpg(void *addr) {
    asm volatile ("invlpg (%0)" :: "r" (addr) : "memory");
c0103551:	8b 45 ec             	mov    -0x14(%ebp),%eax
c0103554:	0f 01 38             	invlpg (%eax)
}
c0103557:	90                   	nop
    }
}
c0103558:	90                   	nop
c0103559:	c9                   	leave  
c010355a:	c3                   	ret    

c010355b <check_alloc_page>:

static void
check_alloc_page(void) {
c010355b:	f3 0f 1e fb          	endbr32 
c010355f:	55                   	push   %ebp
c0103560:	89 e5                	mov    %esp,%ebp
c0103562:	83 ec 08             	sub    $0x8,%esp
    pmm_manager->check();
c0103565:	a1 50 a9 11 c0       	mov    0xc011a950,%eax
c010356a:	8b 40 18             	mov    0x18(%eax),%eax
c010356d:	ff d0                	call   *%eax
    cprintf("check_alloc_page() succeeded!\n");
c010356f:	83 ec 0c             	sub    $0xc,%esp
c0103572:	68 68 65 10 c0       	push   $0xc0106568
c0103577:	e8 13 cd ff ff       	call   c010028f <cprintf>
c010357c:	83 c4 10             	add    $0x10,%esp
}
c010357f:	90                   	nop
c0103580:	c9                   	leave  
c0103581:	c3                   	ret    

c0103582 <check_pgdir>:

static void
check_pgdir(void) {
c0103582:	f3 0f 1e fb          	endbr32 
c0103586:	55                   	push   %ebp
c0103587:	89 e5                	mov    %esp,%ebp
c0103589:	83 ec 28             	sub    $0x28,%esp
    assert(npage <= KMEMSIZE / PGSIZE);
c010358c:	a1 c0 a8 11 c0       	mov    0xc011a8c0,%eax
c0103591:	3d 00 80 03 00       	cmp    $0x38000,%eax
c0103596:	76 19                	jbe    c01035b1 <check_pgdir+0x2f>
c0103598:	68 87 65 10 c0       	push   $0xc0106587
c010359d:	68 2d 65 10 c0       	push   $0xc010652d
c01035a2:	68 e5 01 00 00       	push   $0x1e5
c01035a7:	68 08 65 10 c0       	push   $0xc0106508
c01035ac:	e8 59 ce ff ff       	call   c010040a <__panic>
    assert(boot_pgdir != NULL && (uint32_t)PGOFF(boot_pgdir) == 0);
c01035b1:	a1 c4 a8 11 c0       	mov    0xc011a8c4,%eax
c01035b6:	85 c0                	test   %eax,%eax
c01035b8:	74 0e                	je     c01035c8 <check_pgdir+0x46>
c01035ba:	a1 c4 a8 11 c0       	mov    0xc011a8c4,%eax
c01035bf:	25 ff 0f 00 00       	and    $0xfff,%eax
c01035c4:	85 c0                	test   %eax,%eax
c01035c6:	74 19                	je     c01035e1 <check_pgdir+0x5f>
c01035c8:	68 a4 65 10 c0       	push   $0xc01065a4
c01035cd:	68 2d 65 10 c0       	push   $0xc010652d
c01035d2:	68 e6 01 00 00       	push   $0x1e6
c01035d7:	68 08 65 10 c0       	push   $0xc0106508
c01035dc:	e8 29 ce ff ff       	call   c010040a <__panic>
    assert(get_page(boot_pgdir, 0x0, NULL) == NULL);
c01035e1:	a1 c4 a8 11 c0       	mov    0xc011a8c4,%eax
c01035e6:	83 ec 04             	sub    $0x4,%esp
c01035e9:	6a 00                	push   $0x0
c01035eb:	6a 00                	push   $0x0
c01035ed:	50                   	push   %eax
c01035ee:	e8 c8 fd ff ff       	call   c01033bb <get_page>
c01035f3:	83 c4 10             	add    $0x10,%esp
c01035f6:	85 c0                	test   %eax,%eax
c01035f8:	74 19                	je     c0103613 <check_pgdir+0x91>
c01035fa:	68 dc 65 10 c0       	push   $0xc01065dc
c01035ff:	68 2d 65 10 c0       	push   $0xc010652d
c0103604:	68 e7 01 00 00       	push   $0x1e7
c0103609:	68 08 65 10 c0       	push   $0xc0106508
c010360e:	e8 f7 cd ff ff       	call   c010040a <__panic>

    struct Page *p1, *p2;
    p1 = alloc_page();
c0103613:	83 ec 0c             	sub    $0xc,%esp
c0103616:	6a 01                	push   $0x1
c0103618:	e8 c8 f6 ff ff       	call   c0102ce5 <alloc_pages>
c010361d:	83 c4 10             	add    $0x10,%esp
c0103620:	89 45 f4             	mov    %eax,-0xc(%ebp)
    assert(page_insert(boot_pgdir, p1, 0x0, 0) == 0);
c0103623:	a1 c4 a8 11 c0       	mov    0xc011a8c4,%eax
c0103628:	6a 00                	push   $0x0
c010362a:	6a 00                	push   $0x0
c010362c:	ff 75 f4             	pushl  -0xc(%ebp)
c010362f:	50                   	push   %eax
c0103630:	e8 1a fe ff ff       	call   c010344f <page_insert>
c0103635:	83 c4 10             	add    $0x10,%esp
c0103638:	85 c0                	test   %eax,%eax
c010363a:	74 19                	je     c0103655 <check_pgdir+0xd3>
c010363c:	68 04 66 10 c0       	push   $0xc0106604
c0103641:	68 2d 65 10 c0       	push   $0xc010652d
c0103646:	68 eb 01 00 00       	push   $0x1eb
c010364b:	68 08 65 10 c0       	push   $0xc0106508
c0103650:	e8 b5 cd ff ff       	call   c010040a <__panic>

    pte_t *ptep;
    assert((ptep = get_pte(boot_pgdir, 0x0, 0)) != NULL);
c0103655:	a1 c4 a8 11 c0       	mov    0xc011a8c4,%eax
c010365a:	83 ec 04             	sub    $0x4,%esp
c010365d:	6a 00                	push   $0x0
c010365f:	6a 00                	push   $0x0
c0103661:	50                   	push   %eax
c0103662:	e8 4a fd ff ff       	call   c01033b1 <get_pte>
c0103667:	83 c4 10             	add    $0x10,%esp
c010366a:	89 45 f0             	mov    %eax,-0x10(%ebp)
c010366d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
c0103671:	75 19                	jne    c010368c <check_pgdir+0x10a>
c0103673:	68 30 66 10 c0       	push   $0xc0106630
c0103678:	68 2d 65 10 c0       	push   $0xc010652d
c010367d:	68 ee 01 00 00       	push   $0x1ee
c0103682:	68 08 65 10 c0       	push   $0xc0106508
c0103687:	e8 7e cd ff ff       	call   c010040a <__panic>
    assert(pa2page(*ptep) == p1);
c010368c:	8b 45 f0             	mov    -0x10(%ebp),%eax
c010368f:	8b 00                	mov    (%eax),%eax
c0103691:	83 ec 0c             	sub    $0xc,%esp
c0103694:	50                   	push   %eax
c0103695:	e8 74 f3 ff ff       	call   c0102a0e <pa2page>
c010369a:	83 c4 10             	add    $0x10,%esp
c010369d:	39 45 f4             	cmp    %eax,-0xc(%ebp)
c01036a0:	74 19                	je     c01036bb <check_pgdir+0x139>
c01036a2:	68 5d 66 10 c0       	push   $0xc010665d
c01036a7:	68 2d 65 10 c0       	push   $0xc010652d
c01036ac:	68 ef 01 00 00       	push   $0x1ef
c01036b1:	68 08 65 10 c0       	push   $0xc0106508
c01036b6:	e8 4f cd ff ff       	call   c010040a <__panic>
    assert(page_ref(p1) == 1);
c01036bb:	83 ec 0c             	sub    $0xc,%esp
c01036be:	ff 75 f4             	pushl  -0xc(%ebp)
c01036c1:	e8 0e f4 ff ff       	call   c0102ad4 <page_ref>
c01036c6:	83 c4 10             	add    $0x10,%esp
c01036c9:	83 f8 01             	cmp    $0x1,%eax
c01036cc:	74 19                	je     c01036e7 <check_pgdir+0x165>
c01036ce:	68 72 66 10 c0       	push   $0xc0106672
c01036d3:	68 2d 65 10 c0       	push   $0xc010652d
c01036d8:	68 f0 01 00 00       	push   $0x1f0
c01036dd:	68 08 65 10 c0       	push   $0xc0106508
c01036e2:	e8 23 cd ff ff       	call   c010040a <__panic>

    ptep = &((pte_t *)KADDR(PDE_ADDR(boot_pgdir[0])))[1];
c01036e7:	a1 c4 a8 11 c0       	mov    0xc011a8c4,%eax
c01036ec:	8b 00                	mov    (%eax),%eax
c01036ee:	25 00 f0 ff ff       	and    $0xfffff000,%eax
c01036f3:	89 45 ec             	mov    %eax,-0x14(%ebp)
c01036f6:	8b 45 ec             	mov    -0x14(%ebp),%eax
c01036f9:	c1 e8 0c             	shr    $0xc,%eax
c01036fc:	89 45 e8             	mov    %eax,-0x18(%ebp)
c01036ff:	a1 c0 a8 11 c0       	mov    0xc011a8c0,%eax
c0103704:	39 45 e8             	cmp    %eax,-0x18(%ebp)
c0103707:	72 17                	jb     c0103720 <check_pgdir+0x19e>
c0103709:	ff 75 ec             	pushl  -0x14(%ebp)
c010370c:	68 40 64 10 c0       	push   $0xc0106440
c0103711:	68 f2 01 00 00       	push   $0x1f2
c0103716:	68 08 65 10 c0       	push   $0xc0106508
c010371b:	e8 ea cc ff ff       	call   c010040a <__panic>
c0103720:	8b 45 ec             	mov    -0x14(%ebp),%eax
c0103723:	2d 00 00 00 40       	sub    $0x40000000,%eax
c0103728:	83 c0 04             	add    $0x4,%eax
c010372b:	89 45 f0             	mov    %eax,-0x10(%ebp)
    assert(get_pte(boot_pgdir, PGSIZE, 0) == ptep);
c010372e:	a1 c4 a8 11 c0       	mov    0xc011a8c4,%eax
c0103733:	83 ec 04             	sub    $0x4,%esp
c0103736:	6a 00                	push   $0x0
c0103738:	68 00 10 00 00       	push   $0x1000
c010373d:	50                   	push   %eax
c010373e:	e8 6e fc ff ff       	call   c01033b1 <get_pte>
c0103743:	83 c4 10             	add    $0x10,%esp
c0103746:	39 45 f0             	cmp    %eax,-0x10(%ebp)
c0103749:	74 19                	je     c0103764 <check_pgdir+0x1e2>
c010374b:	68 84 66 10 c0       	push   $0xc0106684
c0103750:	68 2d 65 10 c0       	push   $0xc010652d
c0103755:	68 f3 01 00 00       	push   $0x1f3
c010375a:	68 08 65 10 c0       	push   $0xc0106508
c010375f:	e8 a6 cc ff ff       	call   c010040a <__panic>

    p2 = alloc_page();
c0103764:	83 ec 0c             	sub    $0xc,%esp
c0103767:	6a 01                	push   $0x1
c0103769:	e8 77 f5 ff ff       	call   c0102ce5 <alloc_pages>
c010376e:	83 c4 10             	add    $0x10,%esp
c0103771:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    assert(page_insert(boot_pgdir, p2, PGSIZE, PTE_U | PTE_W) == 0);
c0103774:	a1 c4 a8 11 c0       	mov    0xc011a8c4,%eax
c0103779:	6a 06                	push   $0x6
c010377b:	68 00 10 00 00       	push   $0x1000
c0103780:	ff 75 e4             	pushl  -0x1c(%ebp)
c0103783:	50                   	push   %eax
c0103784:	e8 c6 fc ff ff       	call   c010344f <page_insert>
c0103789:	83 c4 10             	add    $0x10,%esp
c010378c:	85 c0                	test   %eax,%eax
c010378e:	74 19                	je     c01037a9 <check_pgdir+0x227>
c0103790:	68 ac 66 10 c0       	push   $0xc01066ac
c0103795:	68 2d 65 10 c0       	push   $0xc010652d
c010379a:	68 f6 01 00 00       	push   $0x1f6
c010379f:	68 08 65 10 c0       	push   $0xc0106508
c01037a4:	e8 61 cc ff ff       	call   c010040a <__panic>
    assert((ptep = get_pte(boot_pgdir, PGSIZE, 0)) != NULL);
c01037a9:	a1 c4 a8 11 c0       	mov    0xc011a8c4,%eax
c01037ae:	83 ec 04             	sub    $0x4,%esp
c01037b1:	6a 00                	push   $0x0
c01037b3:	68 00 10 00 00       	push   $0x1000
c01037b8:	50                   	push   %eax
c01037b9:	e8 f3 fb ff ff       	call   c01033b1 <get_pte>
c01037be:	83 c4 10             	add    $0x10,%esp
c01037c1:	89 45 f0             	mov    %eax,-0x10(%ebp)
c01037c4:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
c01037c8:	75 19                	jne    c01037e3 <check_pgdir+0x261>
c01037ca:	68 e4 66 10 c0       	push   $0xc01066e4
c01037cf:	68 2d 65 10 c0       	push   $0xc010652d
c01037d4:	68 f7 01 00 00       	push   $0x1f7
c01037d9:	68 08 65 10 c0       	push   $0xc0106508
c01037de:	e8 27 cc ff ff       	call   c010040a <__panic>
    assert(*ptep & PTE_U);
c01037e3:	8b 45 f0             	mov    -0x10(%ebp),%eax
c01037e6:	8b 00                	mov    (%eax),%eax
c01037e8:	83 e0 04             	and    $0x4,%eax
c01037eb:	85 c0                	test   %eax,%eax
c01037ed:	75 19                	jne    c0103808 <check_pgdir+0x286>
c01037ef:	68 14 67 10 c0       	push   $0xc0106714
c01037f4:	68 2d 65 10 c0       	push   $0xc010652d
c01037f9:	68 f8 01 00 00       	push   $0x1f8
c01037fe:	68 08 65 10 c0       	push   $0xc0106508
c0103803:	e8 02 cc ff ff       	call   c010040a <__panic>
    assert(*ptep & PTE_W);
c0103808:	8b 45 f0             	mov    -0x10(%ebp),%eax
c010380b:	8b 00                	mov    (%eax),%eax
c010380d:	83 e0 02             	and    $0x2,%eax
c0103810:	85 c0                	test   %eax,%eax
c0103812:	75 19                	jne    c010382d <check_pgdir+0x2ab>
c0103814:	68 22 67 10 c0       	push   $0xc0106722
c0103819:	68 2d 65 10 c0       	push   $0xc010652d
c010381e:	68 f9 01 00 00       	push   $0x1f9
c0103823:	68 08 65 10 c0       	push   $0xc0106508
c0103828:	e8 dd cb ff ff       	call   c010040a <__panic>
    assert(boot_pgdir[0] & PTE_U);
c010382d:	a1 c4 a8 11 c0       	mov    0xc011a8c4,%eax
c0103832:	8b 00                	mov    (%eax),%eax
c0103834:	83 e0 04             	and    $0x4,%eax
c0103837:	85 c0                	test   %eax,%eax
c0103839:	75 19                	jne    c0103854 <check_pgdir+0x2d2>
c010383b:	68 30 67 10 c0       	push   $0xc0106730
c0103840:	68 2d 65 10 c0       	push   $0xc010652d
c0103845:	68 fa 01 00 00       	push   $0x1fa
c010384a:	68 08 65 10 c0       	push   $0xc0106508
c010384f:	e8 b6 cb ff ff       	call   c010040a <__panic>
    assert(page_ref(p2) == 1);
c0103854:	83 ec 0c             	sub    $0xc,%esp
c0103857:	ff 75 e4             	pushl  -0x1c(%ebp)
c010385a:	e8 75 f2 ff ff       	call   c0102ad4 <page_ref>
c010385f:	83 c4 10             	add    $0x10,%esp
c0103862:	83 f8 01             	cmp    $0x1,%eax
c0103865:	74 19                	je     c0103880 <check_pgdir+0x2fe>
c0103867:	68 46 67 10 c0       	push   $0xc0106746
c010386c:	68 2d 65 10 c0       	push   $0xc010652d
c0103871:	68 fb 01 00 00       	push   $0x1fb
c0103876:	68 08 65 10 c0       	push   $0xc0106508
c010387b:	e8 8a cb ff ff       	call   c010040a <__panic>

    assert(page_insert(boot_pgdir, p1, PGSIZE, 0) == 0);
c0103880:	a1 c4 a8 11 c0       	mov    0xc011a8c4,%eax
c0103885:	6a 00                	push   $0x0
c0103887:	68 00 10 00 00       	push   $0x1000
c010388c:	ff 75 f4             	pushl  -0xc(%ebp)
c010388f:	50                   	push   %eax
c0103890:	e8 ba fb ff ff       	call   c010344f <page_insert>
c0103895:	83 c4 10             	add    $0x10,%esp
c0103898:	85 c0                	test   %eax,%eax
c010389a:	74 19                	je     c01038b5 <check_pgdir+0x333>
c010389c:	68 58 67 10 c0       	push   $0xc0106758
c01038a1:	68 2d 65 10 c0       	push   $0xc010652d
c01038a6:	68 fd 01 00 00       	push   $0x1fd
c01038ab:	68 08 65 10 c0       	push   $0xc0106508
c01038b0:	e8 55 cb ff ff       	call   c010040a <__panic>
    assert(page_ref(p1) == 2);
c01038b5:	83 ec 0c             	sub    $0xc,%esp
c01038b8:	ff 75 f4             	pushl  -0xc(%ebp)
c01038bb:	e8 14 f2 ff ff       	call   c0102ad4 <page_ref>
c01038c0:	83 c4 10             	add    $0x10,%esp
c01038c3:	83 f8 02             	cmp    $0x2,%eax
c01038c6:	74 19                	je     c01038e1 <check_pgdir+0x35f>
c01038c8:	68 84 67 10 c0       	push   $0xc0106784
c01038cd:	68 2d 65 10 c0       	push   $0xc010652d
c01038d2:	68 fe 01 00 00       	push   $0x1fe
c01038d7:	68 08 65 10 c0       	push   $0xc0106508
c01038dc:	e8 29 cb ff ff       	call   c010040a <__panic>
    assert(page_ref(p2) == 0);
c01038e1:	83 ec 0c             	sub    $0xc,%esp
c01038e4:	ff 75 e4             	pushl  -0x1c(%ebp)
c01038e7:	e8 e8 f1 ff ff       	call   c0102ad4 <page_ref>
c01038ec:	83 c4 10             	add    $0x10,%esp
c01038ef:	85 c0                	test   %eax,%eax
c01038f1:	74 19                	je     c010390c <check_pgdir+0x38a>
c01038f3:	68 96 67 10 c0       	push   $0xc0106796
c01038f8:	68 2d 65 10 c0       	push   $0xc010652d
c01038fd:	68 ff 01 00 00       	push   $0x1ff
c0103902:	68 08 65 10 c0       	push   $0xc0106508
c0103907:	e8 fe ca ff ff       	call   c010040a <__panic>
    assert((ptep = get_pte(boot_pgdir, PGSIZE, 0)) != NULL);
c010390c:	a1 c4 a8 11 c0       	mov    0xc011a8c4,%eax
c0103911:	83 ec 04             	sub    $0x4,%esp
c0103914:	6a 00                	push   $0x0
c0103916:	68 00 10 00 00       	push   $0x1000
c010391b:	50                   	push   %eax
c010391c:	e8 90 fa ff ff       	call   c01033b1 <get_pte>
c0103921:	83 c4 10             	add    $0x10,%esp
c0103924:	89 45 f0             	mov    %eax,-0x10(%ebp)
c0103927:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
c010392b:	75 19                	jne    c0103946 <check_pgdir+0x3c4>
c010392d:	68 e4 66 10 c0       	push   $0xc01066e4
c0103932:	68 2d 65 10 c0       	push   $0xc010652d
c0103937:	68 00 02 00 00       	push   $0x200
c010393c:	68 08 65 10 c0       	push   $0xc0106508
c0103941:	e8 c4 ca ff ff       	call   c010040a <__panic>
    assert(pa2page(*ptep) == p1);
c0103946:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0103949:	8b 00                	mov    (%eax),%eax
c010394b:	83 ec 0c             	sub    $0xc,%esp
c010394e:	50                   	push   %eax
c010394f:	e8 ba f0 ff ff       	call   c0102a0e <pa2page>
c0103954:	83 c4 10             	add    $0x10,%esp
c0103957:	39 45 f4             	cmp    %eax,-0xc(%ebp)
c010395a:	74 19                	je     c0103975 <check_pgdir+0x3f3>
c010395c:	68 5d 66 10 c0       	push   $0xc010665d
c0103961:	68 2d 65 10 c0       	push   $0xc010652d
c0103966:	68 01 02 00 00       	push   $0x201
c010396b:	68 08 65 10 c0       	push   $0xc0106508
c0103970:	e8 95 ca ff ff       	call   c010040a <__panic>
    assert((*ptep & PTE_U) == 0);
c0103975:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0103978:	8b 00                	mov    (%eax),%eax
c010397a:	83 e0 04             	and    $0x4,%eax
c010397d:	85 c0                	test   %eax,%eax
c010397f:	74 19                	je     c010399a <check_pgdir+0x418>
c0103981:	68 a8 67 10 c0       	push   $0xc01067a8
c0103986:	68 2d 65 10 c0       	push   $0xc010652d
c010398b:	68 02 02 00 00       	push   $0x202
c0103990:	68 08 65 10 c0       	push   $0xc0106508
c0103995:	e8 70 ca ff ff       	call   c010040a <__panic>

    page_remove(boot_pgdir, 0x0);
c010399a:	a1 c4 a8 11 c0       	mov    0xc011a8c4,%eax
c010399f:	83 ec 08             	sub    $0x8,%esp
c01039a2:	6a 00                	push   $0x0
c01039a4:	50                   	push   %eax
c01039a5:	e8 6e fa ff ff       	call   c0103418 <page_remove>
c01039aa:	83 c4 10             	add    $0x10,%esp
    assert(page_ref(p1) == 1);
c01039ad:	83 ec 0c             	sub    $0xc,%esp
c01039b0:	ff 75 f4             	pushl  -0xc(%ebp)
c01039b3:	e8 1c f1 ff ff       	call   c0102ad4 <page_ref>
c01039b8:	83 c4 10             	add    $0x10,%esp
c01039bb:	83 f8 01             	cmp    $0x1,%eax
c01039be:	74 19                	je     c01039d9 <check_pgdir+0x457>
c01039c0:	68 72 66 10 c0       	push   $0xc0106672
c01039c5:	68 2d 65 10 c0       	push   $0xc010652d
c01039ca:	68 05 02 00 00       	push   $0x205
c01039cf:	68 08 65 10 c0       	push   $0xc0106508
c01039d4:	e8 31 ca ff ff       	call   c010040a <__panic>
    assert(page_ref(p2) == 0);
c01039d9:	83 ec 0c             	sub    $0xc,%esp
c01039dc:	ff 75 e4             	pushl  -0x1c(%ebp)
c01039df:	e8 f0 f0 ff ff       	call   c0102ad4 <page_ref>
c01039e4:	83 c4 10             	add    $0x10,%esp
c01039e7:	85 c0                	test   %eax,%eax
c01039e9:	74 19                	je     c0103a04 <check_pgdir+0x482>
c01039eb:	68 96 67 10 c0       	push   $0xc0106796
c01039f0:	68 2d 65 10 c0       	push   $0xc010652d
c01039f5:	68 06 02 00 00       	push   $0x206
c01039fa:	68 08 65 10 c0       	push   $0xc0106508
c01039ff:	e8 06 ca ff ff       	call   c010040a <__panic>

    page_remove(boot_pgdir, PGSIZE);
c0103a04:	a1 c4 a8 11 c0       	mov    0xc011a8c4,%eax
c0103a09:	83 ec 08             	sub    $0x8,%esp
c0103a0c:	68 00 10 00 00       	push   $0x1000
c0103a11:	50                   	push   %eax
c0103a12:	e8 01 fa ff ff       	call   c0103418 <page_remove>
c0103a17:	83 c4 10             	add    $0x10,%esp
    assert(page_ref(p1) == 0);
c0103a1a:	83 ec 0c             	sub    $0xc,%esp
c0103a1d:	ff 75 f4             	pushl  -0xc(%ebp)
c0103a20:	e8 af f0 ff ff       	call   c0102ad4 <page_ref>
c0103a25:	83 c4 10             	add    $0x10,%esp
c0103a28:	85 c0                	test   %eax,%eax
c0103a2a:	74 19                	je     c0103a45 <check_pgdir+0x4c3>
c0103a2c:	68 bd 67 10 c0       	push   $0xc01067bd
c0103a31:	68 2d 65 10 c0       	push   $0xc010652d
c0103a36:	68 09 02 00 00       	push   $0x209
c0103a3b:	68 08 65 10 c0       	push   $0xc0106508
c0103a40:	e8 c5 c9 ff ff       	call   c010040a <__panic>
    assert(page_ref(p2) == 0);
c0103a45:	83 ec 0c             	sub    $0xc,%esp
c0103a48:	ff 75 e4             	pushl  -0x1c(%ebp)
c0103a4b:	e8 84 f0 ff ff       	call   c0102ad4 <page_ref>
c0103a50:	83 c4 10             	add    $0x10,%esp
c0103a53:	85 c0                	test   %eax,%eax
c0103a55:	74 19                	je     c0103a70 <check_pgdir+0x4ee>
c0103a57:	68 96 67 10 c0       	push   $0xc0106796
c0103a5c:	68 2d 65 10 c0       	push   $0xc010652d
c0103a61:	68 0a 02 00 00       	push   $0x20a
c0103a66:	68 08 65 10 c0       	push   $0xc0106508
c0103a6b:	e8 9a c9 ff ff       	call   c010040a <__panic>

    assert(page_ref(pa2page(boot_pgdir[0])) == 1);
c0103a70:	a1 c4 a8 11 c0       	mov    0xc011a8c4,%eax
c0103a75:	8b 00                	mov    (%eax),%eax
c0103a77:	83 ec 0c             	sub    $0xc,%esp
c0103a7a:	50                   	push   %eax
c0103a7b:	e8 8e ef ff ff       	call   c0102a0e <pa2page>
c0103a80:	83 c4 10             	add    $0x10,%esp
c0103a83:	83 ec 0c             	sub    $0xc,%esp
c0103a86:	50                   	push   %eax
c0103a87:	e8 48 f0 ff ff       	call   c0102ad4 <page_ref>
c0103a8c:	83 c4 10             	add    $0x10,%esp
c0103a8f:	83 f8 01             	cmp    $0x1,%eax
c0103a92:	74 19                	je     c0103aad <check_pgdir+0x52b>
c0103a94:	68 d0 67 10 c0       	push   $0xc01067d0
c0103a99:	68 2d 65 10 c0       	push   $0xc010652d
c0103a9e:	68 0c 02 00 00       	push   $0x20c
c0103aa3:	68 08 65 10 c0       	push   $0xc0106508
c0103aa8:	e8 5d c9 ff ff       	call   c010040a <__panic>
    free_page(pa2page(boot_pgdir[0]));
c0103aad:	a1 c4 a8 11 c0       	mov    0xc011a8c4,%eax
c0103ab2:	8b 00                	mov    (%eax),%eax
c0103ab4:	83 ec 0c             	sub    $0xc,%esp
c0103ab7:	50                   	push   %eax
c0103ab8:	e8 51 ef ff ff       	call   c0102a0e <pa2page>
c0103abd:	83 c4 10             	add    $0x10,%esp
c0103ac0:	83 ec 08             	sub    $0x8,%esp
c0103ac3:	6a 01                	push   $0x1
c0103ac5:	50                   	push   %eax
c0103ac6:	e8 5c f2 ff ff       	call   c0102d27 <free_pages>
c0103acb:	83 c4 10             	add    $0x10,%esp
    boot_pgdir[0] = 0;
c0103ace:	a1 c4 a8 11 c0       	mov    0xc011a8c4,%eax
c0103ad3:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

    cprintf("check_pgdir() succeeded!\n");
c0103ad9:	83 ec 0c             	sub    $0xc,%esp
c0103adc:	68 f6 67 10 c0       	push   $0xc01067f6
c0103ae1:	e8 a9 c7 ff ff       	call   c010028f <cprintf>
c0103ae6:	83 c4 10             	add    $0x10,%esp
}
c0103ae9:	90                   	nop
c0103aea:	c9                   	leave  
c0103aeb:	c3                   	ret    

c0103aec <check_boot_pgdir>:

static void
check_boot_pgdir(void) {
c0103aec:	f3 0f 1e fb          	endbr32 
c0103af0:	55                   	push   %ebp
c0103af1:	89 e5                	mov    %esp,%ebp
c0103af3:	83 ec 28             	sub    $0x28,%esp
    pte_t *ptep;
    int i;
    for (i = 0; i < npage; i += PGSIZE) {
c0103af6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
c0103afd:	e9 a3 00 00 00       	jmp    c0103ba5 <check_boot_pgdir+0xb9>
        assert((ptep = get_pte(boot_pgdir, (uintptr_t)KADDR(i), 0)) != NULL);
c0103b02:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0103b05:	89 45 e4             	mov    %eax,-0x1c(%ebp)
c0103b08:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c0103b0b:	c1 e8 0c             	shr    $0xc,%eax
c0103b0e:	89 45 e0             	mov    %eax,-0x20(%ebp)
c0103b11:	a1 c0 a8 11 c0       	mov    0xc011a8c0,%eax
c0103b16:	39 45 e0             	cmp    %eax,-0x20(%ebp)
c0103b19:	72 17                	jb     c0103b32 <check_boot_pgdir+0x46>
c0103b1b:	ff 75 e4             	pushl  -0x1c(%ebp)
c0103b1e:	68 40 64 10 c0       	push   $0xc0106440
c0103b23:	68 18 02 00 00       	push   $0x218
c0103b28:	68 08 65 10 c0       	push   $0xc0106508
c0103b2d:	e8 d8 c8 ff ff       	call   c010040a <__panic>
c0103b32:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c0103b35:	2d 00 00 00 40       	sub    $0x40000000,%eax
c0103b3a:	89 c2                	mov    %eax,%edx
c0103b3c:	a1 c4 a8 11 c0       	mov    0xc011a8c4,%eax
c0103b41:	83 ec 04             	sub    $0x4,%esp
c0103b44:	6a 00                	push   $0x0
c0103b46:	52                   	push   %edx
c0103b47:	50                   	push   %eax
c0103b48:	e8 64 f8 ff ff       	call   c01033b1 <get_pte>
c0103b4d:	83 c4 10             	add    $0x10,%esp
c0103b50:	89 45 dc             	mov    %eax,-0x24(%ebp)
c0103b53:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
c0103b57:	75 19                	jne    c0103b72 <check_boot_pgdir+0x86>
c0103b59:	68 10 68 10 c0       	push   $0xc0106810
c0103b5e:	68 2d 65 10 c0       	push   $0xc010652d
c0103b63:	68 18 02 00 00       	push   $0x218
c0103b68:	68 08 65 10 c0       	push   $0xc0106508
c0103b6d:	e8 98 c8 ff ff       	call   c010040a <__panic>
        assert(PTE_ADDR(*ptep) == i);
c0103b72:	8b 45 dc             	mov    -0x24(%ebp),%eax
c0103b75:	8b 00                	mov    (%eax),%eax
c0103b77:	25 00 f0 ff ff       	and    $0xfffff000,%eax
c0103b7c:	89 c2                	mov    %eax,%edx
c0103b7e:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0103b81:	39 c2                	cmp    %eax,%edx
c0103b83:	74 19                	je     c0103b9e <check_boot_pgdir+0xb2>
c0103b85:	68 4d 68 10 c0       	push   $0xc010684d
c0103b8a:	68 2d 65 10 c0       	push   $0xc010652d
c0103b8f:	68 19 02 00 00       	push   $0x219
c0103b94:	68 08 65 10 c0       	push   $0xc0106508
c0103b99:	e8 6c c8 ff ff       	call   c010040a <__panic>
    for (i = 0; i < npage; i += PGSIZE) {
c0103b9e:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
c0103ba5:	8b 55 f4             	mov    -0xc(%ebp),%edx
c0103ba8:	a1 c0 a8 11 c0       	mov    0xc011a8c0,%eax
c0103bad:	39 c2                	cmp    %eax,%edx
c0103baf:	0f 82 4d ff ff ff    	jb     c0103b02 <check_boot_pgdir+0x16>
    }

    assert(PDE_ADDR(boot_pgdir[PDX(VPT)]) == PADDR(boot_pgdir));
c0103bb5:	a1 c4 a8 11 c0       	mov    0xc011a8c4,%eax
c0103bba:	05 ac 0f 00 00       	add    $0xfac,%eax
c0103bbf:	8b 00                	mov    (%eax),%eax
c0103bc1:	25 00 f0 ff ff       	and    $0xfffff000,%eax
c0103bc6:	89 c2                	mov    %eax,%edx
c0103bc8:	a1 c4 a8 11 c0       	mov    0xc011a8c4,%eax
c0103bcd:	89 45 f0             	mov    %eax,-0x10(%ebp)
c0103bd0:	81 7d f0 ff ff ff bf 	cmpl   $0xbfffffff,-0x10(%ebp)
c0103bd7:	77 17                	ja     c0103bf0 <check_boot_pgdir+0x104>
c0103bd9:	ff 75 f0             	pushl  -0x10(%ebp)
c0103bdc:	68 e4 64 10 c0       	push   $0xc01064e4
c0103be1:	68 1c 02 00 00       	push   $0x21c
c0103be6:	68 08 65 10 c0       	push   $0xc0106508
c0103beb:	e8 1a c8 ff ff       	call   c010040a <__panic>
c0103bf0:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0103bf3:	05 00 00 00 40       	add    $0x40000000,%eax
c0103bf8:	39 d0                	cmp    %edx,%eax
c0103bfa:	74 19                	je     c0103c15 <check_boot_pgdir+0x129>
c0103bfc:	68 64 68 10 c0       	push   $0xc0106864
c0103c01:	68 2d 65 10 c0       	push   $0xc010652d
c0103c06:	68 1c 02 00 00       	push   $0x21c
c0103c0b:	68 08 65 10 c0       	push   $0xc0106508
c0103c10:	e8 f5 c7 ff ff       	call   c010040a <__panic>

    assert(boot_pgdir[0] == 0);
c0103c15:	a1 c4 a8 11 c0       	mov    0xc011a8c4,%eax
c0103c1a:	8b 00                	mov    (%eax),%eax
c0103c1c:	85 c0                	test   %eax,%eax
c0103c1e:	74 19                	je     c0103c39 <check_boot_pgdir+0x14d>
c0103c20:	68 98 68 10 c0       	push   $0xc0106898
c0103c25:	68 2d 65 10 c0       	push   $0xc010652d
c0103c2a:	68 1e 02 00 00       	push   $0x21e
c0103c2f:	68 08 65 10 c0       	push   $0xc0106508
c0103c34:	e8 d1 c7 ff ff       	call   c010040a <__panic>

    struct Page *p;
    p = alloc_page();
c0103c39:	83 ec 0c             	sub    $0xc,%esp
c0103c3c:	6a 01                	push   $0x1
c0103c3e:	e8 a2 f0 ff ff       	call   c0102ce5 <alloc_pages>
c0103c43:	83 c4 10             	add    $0x10,%esp
c0103c46:	89 45 ec             	mov    %eax,-0x14(%ebp)
    assert(page_insert(boot_pgdir, p, 0x100, PTE_W) == 0);
c0103c49:	a1 c4 a8 11 c0       	mov    0xc011a8c4,%eax
c0103c4e:	6a 02                	push   $0x2
c0103c50:	68 00 01 00 00       	push   $0x100
c0103c55:	ff 75 ec             	pushl  -0x14(%ebp)
c0103c58:	50                   	push   %eax
c0103c59:	e8 f1 f7 ff ff       	call   c010344f <page_insert>
c0103c5e:	83 c4 10             	add    $0x10,%esp
c0103c61:	85 c0                	test   %eax,%eax
c0103c63:	74 19                	je     c0103c7e <check_boot_pgdir+0x192>
c0103c65:	68 ac 68 10 c0       	push   $0xc01068ac
c0103c6a:	68 2d 65 10 c0       	push   $0xc010652d
c0103c6f:	68 22 02 00 00       	push   $0x222
c0103c74:	68 08 65 10 c0       	push   $0xc0106508
c0103c79:	e8 8c c7 ff ff       	call   c010040a <__panic>
    assert(page_ref(p) == 1);
c0103c7e:	83 ec 0c             	sub    $0xc,%esp
c0103c81:	ff 75 ec             	pushl  -0x14(%ebp)
c0103c84:	e8 4b ee ff ff       	call   c0102ad4 <page_ref>
c0103c89:	83 c4 10             	add    $0x10,%esp
c0103c8c:	83 f8 01             	cmp    $0x1,%eax
c0103c8f:	74 19                	je     c0103caa <check_boot_pgdir+0x1be>
c0103c91:	68 da 68 10 c0       	push   $0xc01068da
c0103c96:	68 2d 65 10 c0       	push   $0xc010652d
c0103c9b:	68 23 02 00 00       	push   $0x223
c0103ca0:	68 08 65 10 c0       	push   $0xc0106508
c0103ca5:	e8 60 c7 ff ff       	call   c010040a <__panic>
    assert(page_insert(boot_pgdir, p, 0x100 + PGSIZE, PTE_W) == 0);
c0103caa:	a1 c4 a8 11 c0       	mov    0xc011a8c4,%eax
c0103caf:	6a 02                	push   $0x2
c0103cb1:	68 00 11 00 00       	push   $0x1100
c0103cb6:	ff 75 ec             	pushl  -0x14(%ebp)
c0103cb9:	50                   	push   %eax
c0103cba:	e8 90 f7 ff ff       	call   c010344f <page_insert>
c0103cbf:	83 c4 10             	add    $0x10,%esp
c0103cc2:	85 c0                	test   %eax,%eax
c0103cc4:	74 19                	je     c0103cdf <check_boot_pgdir+0x1f3>
c0103cc6:	68 ec 68 10 c0       	push   $0xc01068ec
c0103ccb:	68 2d 65 10 c0       	push   $0xc010652d
c0103cd0:	68 24 02 00 00       	push   $0x224
c0103cd5:	68 08 65 10 c0       	push   $0xc0106508
c0103cda:	e8 2b c7 ff ff       	call   c010040a <__panic>
    assert(page_ref(p) == 2);
c0103cdf:	83 ec 0c             	sub    $0xc,%esp
c0103ce2:	ff 75 ec             	pushl  -0x14(%ebp)
c0103ce5:	e8 ea ed ff ff       	call   c0102ad4 <page_ref>
c0103cea:	83 c4 10             	add    $0x10,%esp
c0103ced:	83 f8 02             	cmp    $0x2,%eax
c0103cf0:	74 19                	je     c0103d0b <check_boot_pgdir+0x21f>
c0103cf2:	68 23 69 10 c0       	push   $0xc0106923
c0103cf7:	68 2d 65 10 c0       	push   $0xc010652d
c0103cfc:	68 25 02 00 00       	push   $0x225
c0103d01:	68 08 65 10 c0       	push   $0xc0106508
c0103d06:	e8 ff c6 ff ff       	call   c010040a <__panic>

    const char *str = "ucore: Hello world!!";
c0103d0b:	c7 45 e8 34 69 10 c0 	movl   $0xc0106934,-0x18(%ebp)
    strcpy((void *)0x100, str);
c0103d12:	83 ec 08             	sub    $0x8,%esp
c0103d15:	ff 75 e8             	pushl  -0x18(%ebp)
c0103d18:	68 00 01 00 00       	push   $0x100
c0103d1d:	e8 23 15 00 00       	call   c0105245 <strcpy>
c0103d22:	83 c4 10             	add    $0x10,%esp
    assert(strcmp((void *)0x100, (void *)(0x100 + PGSIZE)) == 0);
c0103d25:	83 ec 08             	sub    $0x8,%esp
c0103d28:	68 00 11 00 00       	push   $0x1100
c0103d2d:	68 00 01 00 00       	push   $0x100
c0103d32:	e8 8f 15 00 00       	call   c01052c6 <strcmp>
c0103d37:	83 c4 10             	add    $0x10,%esp
c0103d3a:	85 c0                	test   %eax,%eax
c0103d3c:	74 19                	je     c0103d57 <check_boot_pgdir+0x26b>
c0103d3e:	68 4c 69 10 c0       	push   $0xc010694c
c0103d43:	68 2d 65 10 c0       	push   $0xc010652d
c0103d48:	68 29 02 00 00       	push   $0x229
c0103d4d:	68 08 65 10 c0       	push   $0xc0106508
c0103d52:	e8 b3 c6 ff ff       	call   c010040a <__panic>

    *(char *)(page2kva(p) + 0x100) = '\0';
c0103d57:	83 ec 0c             	sub    $0xc,%esp
c0103d5a:	ff 75 ec             	pushl  -0x14(%ebp)
c0103d5d:	e8 f3 ec ff ff       	call   c0102a55 <page2kva>
c0103d62:	83 c4 10             	add    $0x10,%esp
c0103d65:	05 00 01 00 00       	add    $0x100,%eax
c0103d6a:	c6 00 00             	movb   $0x0,(%eax)
    assert(strlen((const char *)0x100) == 0);
c0103d6d:	83 ec 0c             	sub    $0xc,%esp
c0103d70:	68 00 01 00 00       	push   $0x100
c0103d75:	e8 6b 14 00 00       	call   c01051e5 <strlen>
c0103d7a:	83 c4 10             	add    $0x10,%esp
c0103d7d:	85 c0                	test   %eax,%eax
c0103d7f:	74 19                	je     c0103d9a <check_boot_pgdir+0x2ae>
c0103d81:	68 84 69 10 c0       	push   $0xc0106984
c0103d86:	68 2d 65 10 c0       	push   $0xc010652d
c0103d8b:	68 2c 02 00 00       	push   $0x22c
c0103d90:	68 08 65 10 c0       	push   $0xc0106508
c0103d95:	e8 70 c6 ff ff       	call   c010040a <__panic>

    free_page(p);
c0103d9a:	83 ec 08             	sub    $0x8,%esp
c0103d9d:	6a 01                	push   $0x1
c0103d9f:	ff 75 ec             	pushl  -0x14(%ebp)
c0103da2:	e8 80 ef ff ff       	call   c0102d27 <free_pages>
c0103da7:	83 c4 10             	add    $0x10,%esp
    free_page(pa2page(PDE_ADDR(boot_pgdir[0])));
c0103daa:	a1 c4 a8 11 c0       	mov    0xc011a8c4,%eax
c0103daf:	8b 00                	mov    (%eax),%eax
c0103db1:	25 00 f0 ff ff       	and    $0xfffff000,%eax
c0103db6:	83 ec 0c             	sub    $0xc,%esp
c0103db9:	50                   	push   %eax
c0103dba:	e8 4f ec ff ff       	call   c0102a0e <pa2page>
c0103dbf:	83 c4 10             	add    $0x10,%esp
c0103dc2:	83 ec 08             	sub    $0x8,%esp
c0103dc5:	6a 01                	push   $0x1
c0103dc7:	50                   	push   %eax
c0103dc8:	e8 5a ef ff ff       	call   c0102d27 <free_pages>
c0103dcd:	83 c4 10             	add    $0x10,%esp
    boot_pgdir[0] = 0;
c0103dd0:	a1 c4 a8 11 c0       	mov    0xc011a8c4,%eax
c0103dd5:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

    cprintf("check_boot_pgdir() succeeded!\n");
c0103ddb:	83 ec 0c             	sub    $0xc,%esp
c0103dde:	68 a8 69 10 c0       	push   $0xc01069a8
c0103de3:	e8 a7 c4 ff ff       	call   c010028f <cprintf>
c0103de8:	83 c4 10             	add    $0x10,%esp
}
c0103deb:	90                   	nop
c0103dec:	c9                   	leave  
c0103ded:	c3                   	ret    

c0103dee <perm2str>:

//perm2str - use string 'u,r,w,-' to present the permission
static const char *
perm2str(int perm) {
c0103dee:	f3 0f 1e fb          	endbr32 
c0103df2:	55                   	push   %ebp
c0103df3:	89 e5                	mov    %esp,%ebp
    static char str[4];
    str[0] = (perm & PTE_U) ? 'u' : '-';
c0103df5:	8b 45 08             	mov    0x8(%ebp),%eax
c0103df8:	83 e0 04             	and    $0x4,%eax
c0103dfb:	85 c0                	test   %eax,%eax
c0103dfd:	74 07                	je     c0103e06 <perm2str+0x18>
c0103dff:	b8 75 00 00 00       	mov    $0x75,%eax
c0103e04:	eb 05                	jmp    c0103e0b <perm2str+0x1d>
c0103e06:	b8 2d 00 00 00       	mov    $0x2d,%eax
c0103e0b:	a2 48 a9 11 c0       	mov    %al,0xc011a948
    str[1] = 'r';
c0103e10:	c6 05 49 a9 11 c0 72 	movb   $0x72,0xc011a949
    str[2] = (perm & PTE_W) ? 'w' : '-';
c0103e17:	8b 45 08             	mov    0x8(%ebp),%eax
c0103e1a:	83 e0 02             	and    $0x2,%eax
c0103e1d:	85 c0                	test   %eax,%eax
c0103e1f:	74 07                	je     c0103e28 <perm2str+0x3a>
c0103e21:	b8 77 00 00 00       	mov    $0x77,%eax
c0103e26:	eb 05                	jmp    c0103e2d <perm2str+0x3f>
c0103e28:	b8 2d 00 00 00       	mov    $0x2d,%eax
c0103e2d:	a2 4a a9 11 c0       	mov    %al,0xc011a94a
    str[3] = '\0';
c0103e32:	c6 05 4b a9 11 c0 00 	movb   $0x0,0xc011a94b
    return str;
c0103e39:	b8 48 a9 11 c0       	mov    $0xc011a948,%eax
}
c0103e3e:	5d                   	pop    %ebp
c0103e3f:	c3                   	ret    

c0103e40 <get_pgtable_items>:
//  table:       the beginning addr of table
//  left_store:  the pointer of the high side of table's next range
//  right_store: the pointer of the low side of table's next range
// return value: 0 - not a invalid item range, perm - a valid item range with perm permission 
static int
get_pgtable_items(size_t left, size_t right, size_t start, uintptr_t *table, size_t *left_store, size_t *right_store) {
c0103e40:	f3 0f 1e fb          	endbr32 
c0103e44:	55                   	push   %ebp
c0103e45:	89 e5                	mov    %esp,%ebp
c0103e47:	83 ec 10             	sub    $0x10,%esp
    if (start >= right) {
c0103e4a:	8b 45 10             	mov    0x10(%ebp),%eax
c0103e4d:	3b 45 0c             	cmp    0xc(%ebp),%eax
c0103e50:	72 0e                	jb     c0103e60 <get_pgtable_items+0x20>
        return 0;
c0103e52:	b8 00 00 00 00       	mov    $0x0,%eax
c0103e57:	e9 9a 00 00 00       	jmp    c0103ef6 <get_pgtable_items+0xb6>
    }
    while (start < right && !(table[start] & PTE_P)) {
        start ++;
c0103e5c:	83 45 10 01          	addl   $0x1,0x10(%ebp)
    while (start < right && !(table[start] & PTE_P)) {
c0103e60:	8b 45 10             	mov    0x10(%ebp),%eax
c0103e63:	3b 45 0c             	cmp    0xc(%ebp),%eax
c0103e66:	73 18                	jae    c0103e80 <get_pgtable_items+0x40>
c0103e68:	8b 45 10             	mov    0x10(%ebp),%eax
c0103e6b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
c0103e72:	8b 45 14             	mov    0x14(%ebp),%eax
c0103e75:	01 d0                	add    %edx,%eax
c0103e77:	8b 00                	mov    (%eax),%eax
c0103e79:	83 e0 01             	and    $0x1,%eax
c0103e7c:	85 c0                	test   %eax,%eax
c0103e7e:	74 dc                	je     c0103e5c <get_pgtable_items+0x1c>
    }
    if (start < right) {
c0103e80:	8b 45 10             	mov    0x10(%ebp),%eax
c0103e83:	3b 45 0c             	cmp    0xc(%ebp),%eax
c0103e86:	73 69                	jae    c0103ef1 <get_pgtable_items+0xb1>
        if (left_store != NULL) {
c0103e88:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
c0103e8c:	74 08                	je     c0103e96 <get_pgtable_items+0x56>
            *left_store = start;
c0103e8e:	8b 45 18             	mov    0x18(%ebp),%eax
c0103e91:	8b 55 10             	mov    0x10(%ebp),%edx
c0103e94:	89 10                	mov    %edx,(%eax)
        }
        int perm = (table[start ++] & PTE_USER);
c0103e96:	8b 45 10             	mov    0x10(%ebp),%eax
c0103e99:	8d 50 01             	lea    0x1(%eax),%edx
c0103e9c:	89 55 10             	mov    %edx,0x10(%ebp)
c0103e9f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
c0103ea6:	8b 45 14             	mov    0x14(%ebp),%eax
c0103ea9:	01 d0                	add    %edx,%eax
c0103eab:	8b 00                	mov    (%eax),%eax
c0103ead:	83 e0 07             	and    $0x7,%eax
c0103eb0:	89 45 fc             	mov    %eax,-0x4(%ebp)
        while (start < right && (table[start] & PTE_USER) == perm) {
c0103eb3:	eb 04                	jmp    c0103eb9 <get_pgtable_items+0x79>
            start ++;
c0103eb5:	83 45 10 01          	addl   $0x1,0x10(%ebp)
        while (start < right && (table[start] & PTE_USER) == perm) {
c0103eb9:	8b 45 10             	mov    0x10(%ebp),%eax
c0103ebc:	3b 45 0c             	cmp    0xc(%ebp),%eax
c0103ebf:	73 1d                	jae    c0103ede <get_pgtable_items+0x9e>
c0103ec1:	8b 45 10             	mov    0x10(%ebp),%eax
c0103ec4:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
c0103ecb:	8b 45 14             	mov    0x14(%ebp),%eax
c0103ece:	01 d0                	add    %edx,%eax
c0103ed0:	8b 00                	mov    (%eax),%eax
c0103ed2:	83 e0 07             	and    $0x7,%eax
c0103ed5:	89 c2                	mov    %eax,%edx
c0103ed7:	8b 45 fc             	mov    -0x4(%ebp),%eax
c0103eda:	39 c2                	cmp    %eax,%edx
c0103edc:	74 d7                	je     c0103eb5 <get_pgtable_items+0x75>
        }
        if (right_store != NULL) {
c0103ede:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
c0103ee2:	74 08                	je     c0103eec <get_pgtable_items+0xac>
            *right_store = start;
c0103ee4:	8b 45 1c             	mov    0x1c(%ebp),%eax
c0103ee7:	8b 55 10             	mov    0x10(%ebp),%edx
c0103eea:	89 10                	mov    %edx,(%eax)
        }
        return perm;
c0103eec:	8b 45 fc             	mov    -0x4(%ebp),%eax
c0103eef:	eb 05                	jmp    c0103ef6 <get_pgtable_items+0xb6>
    }
    return 0;
c0103ef1:	b8 00 00 00 00       	mov    $0x0,%eax
}
c0103ef6:	c9                   	leave  
c0103ef7:	c3                   	ret    

c0103ef8 <print_pgdir>:

//print_pgdir - print the PDT&PT
void
print_pgdir(void) {
c0103ef8:	f3 0f 1e fb          	endbr32 
c0103efc:	55                   	push   %ebp
c0103efd:	89 e5                	mov    %esp,%ebp
c0103eff:	57                   	push   %edi
c0103f00:	56                   	push   %esi
c0103f01:	53                   	push   %ebx
c0103f02:	83 ec 2c             	sub    $0x2c,%esp
    cprintf("-------------------- BEGIN --------------------\n");
c0103f05:	83 ec 0c             	sub    $0xc,%esp
c0103f08:	68 c8 69 10 c0       	push   $0xc01069c8
c0103f0d:	e8 7d c3 ff ff       	call   c010028f <cprintf>
c0103f12:	83 c4 10             	add    $0x10,%esp
    size_t left, right = 0, perm;
c0103f15:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    while ((perm = get_pgtable_items(0, NPDEENTRY, right, vpd, &left, &right)) != 0) {
c0103f1c:	e9 e1 00 00 00       	jmp    c0104002 <print_pgdir+0x10a>
        cprintf("PDE(%03x) %08x-%08x %08x %s\n", right - left,
c0103f21:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c0103f24:	83 ec 0c             	sub    $0xc,%esp
c0103f27:	50                   	push   %eax
c0103f28:	e8 c1 fe ff ff       	call   c0103dee <perm2str>
c0103f2d:	83 c4 10             	add    $0x10,%esp
                left * PTSIZE, right * PTSIZE, (right - left) * PTSIZE, perm2str(perm));
c0103f30:	8b 4d dc             	mov    -0x24(%ebp),%ecx
c0103f33:	8b 55 e0             	mov    -0x20(%ebp),%edx
c0103f36:	29 d1                	sub    %edx,%ecx
c0103f38:	89 ca                	mov    %ecx,%edx
        cprintf("PDE(%03x) %08x-%08x %08x %s\n", right - left,
c0103f3a:	89 d6                	mov    %edx,%esi
c0103f3c:	c1 e6 16             	shl    $0x16,%esi
c0103f3f:	8b 55 dc             	mov    -0x24(%ebp),%edx
c0103f42:	89 d3                	mov    %edx,%ebx
c0103f44:	c1 e3 16             	shl    $0x16,%ebx
c0103f47:	8b 55 e0             	mov    -0x20(%ebp),%edx
c0103f4a:	89 d1                	mov    %edx,%ecx
c0103f4c:	c1 e1 16             	shl    $0x16,%ecx
c0103f4f:	8b 7d dc             	mov    -0x24(%ebp),%edi
c0103f52:	8b 55 e0             	mov    -0x20(%ebp),%edx
c0103f55:	29 d7                	sub    %edx,%edi
c0103f57:	89 fa                	mov    %edi,%edx
c0103f59:	83 ec 08             	sub    $0x8,%esp
c0103f5c:	50                   	push   %eax
c0103f5d:	56                   	push   %esi
c0103f5e:	53                   	push   %ebx
c0103f5f:	51                   	push   %ecx
c0103f60:	52                   	push   %edx
c0103f61:	68 f9 69 10 c0       	push   $0xc01069f9
c0103f66:	e8 24 c3 ff ff       	call   c010028f <cprintf>
c0103f6b:	83 c4 20             	add    $0x20,%esp
        size_t l, r = left * NPTEENTRY;
c0103f6e:	8b 45 e0             	mov    -0x20(%ebp),%eax
c0103f71:	c1 e0 0a             	shl    $0xa,%eax
c0103f74:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        while ((perm = get_pgtable_items(left * NPTEENTRY, right * NPTEENTRY, r, vpt, &l, &r)) != 0) {
c0103f77:	eb 4d                	jmp    c0103fc6 <print_pgdir+0xce>
            cprintf("  |-- PTE(%05x) %08x-%08x %08x %s\n", r - l,
c0103f79:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c0103f7c:	83 ec 0c             	sub    $0xc,%esp
c0103f7f:	50                   	push   %eax
c0103f80:	e8 69 fe ff ff       	call   c0103dee <perm2str>
c0103f85:	83 c4 10             	add    $0x10,%esp
                    l * PGSIZE, r * PGSIZE, (r - l) * PGSIZE, perm2str(perm));
c0103f88:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
c0103f8b:	8b 55 d8             	mov    -0x28(%ebp),%edx
c0103f8e:	29 d1                	sub    %edx,%ecx
c0103f90:	89 ca                	mov    %ecx,%edx
            cprintf("  |-- PTE(%05x) %08x-%08x %08x %s\n", r - l,
c0103f92:	89 d6                	mov    %edx,%esi
c0103f94:	c1 e6 0c             	shl    $0xc,%esi
c0103f97:	8b 55 d4             	mov    -0x2c(%ebp),%edx
c0103f9a:	89 d3                	mov    %edx,%ebx
c0103f9c:	c1 e3 0c             	shl    $0xc,%ebx
c0103f9f:	8b 55 d8             	mov    -0x28(%ebp),%edx
c0103fa2:	89 d1                	mov    %edx,%ecx
c0103fa4:	c1 e1 0c             	shl    $0xc,%ecx
c0103fa7:	8b 7d d4             	mov    -0x2c(%ebp),%edi
c0103faa:	8b 55 d8             	mov    -0x28(%ebp),%edx
c0103fad:	29 d7                	sub    %edx,%edi
c0103faf:	89 fa                	mov    %edi,%edx
c0103fb1:	83 ec 08             	sub    $0x8,%esp
c0103fb4:	50                   	push   %eax
c0103fb5:	56                   	push   %esi
c0103fb6:	53                   	push   %ebx
c0103fb7:	51                   	push   %ecx
c0103fb8:	52                   	push   %edx
c0103fb9:	68 18 6a 10 c0       	push   $0xc0106a18
c0103fbe:	e8 cc c2 ff ff       	call   c010028f <cprintf>
c0103fc3:	83 c4 20             	add    $0x20,%esp
        while ((perm = get_pgtable_items(left * NPTEENTRY, right * NPTEENTRY, r, vpt, &l, &r)) != 0) {
c0103fc6:	be 00 00 c0 fa       	mov    $0xfac00000,%esi
c0103fcb:	8b 45 d4             	mov    -0x2c(%ebp),%eax
c0103fce:	8b 55 dc             	mov    -0x24(%ebp),%edx
c0103fd1:	89 d3                	mov    %edx,%ebx
c0103fd3:	c1 e3 0a             	shl    $0xa,%ebx
c0103fd6:	8b 55 e0             	mov    -0x20(%ebp),%edx
c0103fd9:	89 d1                	mov    %edx,%ecx
c0103fdb:	c1 e1 0a             	shl    $0xa,%ecx
c0103fde:	83 ec 08             	sub    $0x8,%esp
c0103fe1:	8d 55 d4             	lea    -0x2c(%ebp),%edx
c0103fe4:	52                   	push   %edx
c0103fe5:	8d 55 d8             	lea    -0x28(%ebp),%edx
c0103fe8:	52                   	push   %edx
c0103fe9:	56                   	push   %esi
c0103fea:	50                   	push   %eax
c0103feb:	53                   	push   %ebx
c0103fec:	51                   	push   %ecx
c0103fed:	e8 4e fe ff ff       	call   c0103e40 <get_pgtable_items>
c0103ff2:	83 c4 20             	add    $0x20,%esp
c0103ff5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
c0103ff8:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
c0103ffc:	0f 85 77 ff ff ff    	jne    c0103f79 <print_pgdir+0x81>
    while ((perm = get_pgtable_items(0, NPDEENTRY, right, vpd, &left, &right)) != 0) {
c0104002:	b9 00 b0 fe fa       	mov    $0xfafeb000,%ecx
c0104007:	8b 45 dc             	mov    -0x24(%ebp),%eax
c010400a:	83 ec 08             	sub    $0x8,%esp
c010400d:	8d 55 dc             	lea    -0x24(%ebp),%edx
c0104010:	52                   	push   %edx
c0104011:	8d 55 e0             	lea    -0x20(%ebp),%edx
c0104014:	52                   	push   %edx
c0104015:	51                   	push   %ecx
c0104016:	50                   	push   %eax
c0104017:	68 00 04 00 00       	push   $0x400
c010401c:	6a 00                	push   $0x0
c010401e:	e8 1d fe ff ff       	call   c0103e40 <get_pgtable_items>
c0104023:	83 c4 20             	add    $0x20,%esp
c0104026:	89 45 e4             	mov    %eax,-0x1c(%ebp)
c0104029:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
c010402d:	0f 85 ee fe ff ff    	jne    c0103f21 <print_pgdir+0x29>
        }
    }
    cprintf("--------------------- END ---------------------\n");
c0104033:	83 ec 0c             	sub    $0xc,%esp
c0104036:	68 3c 6a 10 c0       	push   $0xc0106a3c
c010403b:	e8 4f c2 ff ff       	call   c010028f <cprintf>
c0104040:	83 c4 10             	add    $0x10,%esp
}
c0104043:	90                   	nop
c0104044:	8d 65 f4             	lea    -0xc(%ebp),%esp
c0104047:	5b                   	pop    %ebx
c0104048:	5e                   	pop    %esi
c0104049:	5f                   	pop    %edi
c010404a:	5d                   	pop    %ebp
c010404b:	c3                   	ret    

c010404c <page2ppn>:
page2ppn(struct Page *page) {
c010404c:	55                   	push   %ebp
c010404d:	89 e5                	mov    %esp,%ebp
    return page - pages;
c010404f:	a1 58 a9 11 c0       	mov    0xc011a958,%eax
c0104054:	8b 55 08             	mov    0x8(%ebp),%edx
c0104057:	29 c2                	sub    %eax,%edx
c0104059:	89 d0                	mov    %edx,%eax
c010405b:	c1 f8 02             	sar    $0x2,%eax
c010405e:	69 c0 cd cc cc cc    	imul   $0xcccccccd,%eax,%eax
}
c0104064:	5d                   	pop    %ebp
c0104065:	c3                   	ret    

c0104066 <page2pa>:
page2pa(struct Page *page) {
c0104066:	55                   	push   %ebp
c0104067:	89 e5                	mov    %esp,%ebp
    return page2ppn(page) << PGSHIFT;
c0104069:	ff 75 08             	pushl  0x8(%ebp)
c010406c:	e8 db ff ff ff       	call   c010404c <page2ppn>
c0104071:	83 c4 04             	add    $0x4,%esp
c0104074:	c1 e0 0c             	shl    $0xc,%eax
}
c0104077:	c9                   	leave  
c0104078:	c3                   	ret    

c0104079 <page_ref>:
page_ref(struct Page *page) {
c0104079:	55                   	push   %ebp
c010407a:	89 e5                	mov    %esp,%ebp
    return page->ref;
c010407c:	8b 45 08             	mov    0x8(%ebp),%eax
c010407f:	8b 00                	mov    (%eax),%eax
}
c0104081:	5d                   	pop    %ebp
c0104082:	c3                   	ret    

c0104083 <set_page_ref>:
set_page_ref(struct Page *page, int val) {
c0104083:	55                   	push   %ebp
c0104084:	89 e5                	mov    %esp,%ebp
    page->ref = val;
c0104086:	8b 45 08             	mov    0x8(%ebp),%eax
c0104089:	8b 55 0c             	mov    0xc(%ebp),%edx
c010408c:	89 10                	mov    %edx,(%eax)
}
c010408e:	90                   	nop
c010408f:	5d                   	pop    %ebp
c0104090:	c3                   	ret    

c0104091 <default_init>:

#define free_list (free_area.free_list)
#define nr_free (free_area.nr_free)

static void
default_init(void) {
c0104091:	f3 0f 1e fb          	endbr32 
c0104095:	55                   	push   %ebp
c0104096:	89 e5                	mov    %esp,%ebp
c0104098:	83 ec 10             	sub    $0x10,%esp
c010409b:	c7 45 fc 5c a9 11 c0 	movl   $0xc011a95c,-0x4(%ebp)
 * list_init - initialize a new entry
 * @elm:        new entry to be initialized
 * */
static inline void
list_init(list_entry_t *elm) {
    elm->prev = elm->next = elm;
c01040a2:	8b 45 fc             	mov    -0x4(%ebp),%eax
c01040a5:	8b 55 fc             	mov    -0x4(%ebp),%edx
c01040a8:	89 50 04             	mov    %edx,0x4(%eax)
c01040ab:	8b 45 fc             	mov    -0x4(%ebp),%eax
c01040ae:	8b 50 04             	mov    0x4(%eax),%edx
c01040b1:	8b 45 fc             	mov    -0x4(%ebp),%eax
c01040b4:	89 10                	mov    %edx,(%eax)
}
c01040b6:	90                   	nop
    list_init(&free_list);//空闲链表初始化
    nr_free = 0;//初始空闲页为0
c01040b7:	c7 05 64 a9 11 c0 00 	movl   $0x0,0xc011a964
c01040be:	00 00 00 
}
c01040c1:	90                   	nop
c01040c2:	c9                   	leave  
c01040c3:	c3                   	ret    

c01040c4 <default_init_memmap>:

static void
default_init_memmap(struct Page *base, size_t n) {
c01040c4:	f3 0f 1e fb          	endbr32 
c01040c8:	55                   	push   %ebp
c01040c9:	89 e5                	mov    %esp,%ebp
c01040cb:	83 ec 48             	sub    $0x48,%esp

    assert(n > 0);
c01040ce:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
c01040d2:	75 16                	jne    c01040ea <default_init_memmap+0x26>
c01040d4:	68 70 6a 10 c0       	push   $0xc0106a70
c01040d9:	68 76 6a 10 c0       	push   $0xc0106a76
c01040de:	6a 47                	push   $0x47
c01040e0:	68 8b 6a 10 c0       	push   $0xc0106a8b
c01040e5:	e8 20 c3 ff ff       	call   c010040a <__panic>
    struct Page *p = base;
c01040ea:	8b 45 08             	mov    0x8(%ebp),%eax
c01040ed:	89 45 f4             	mov    %eax,-0xc(%ebp)
    for (; p != base + n; p ++) {
c01040f0:	e9 84 00 00 00       	jmp    c0104179 <default_init_memmap+0xb5>
        assert(PageReserved(p));//p是一个预留页
c01040f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
c01040f8:	83 c0 04             	add    $0x4,%eax
c01040fb:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
c0104102:	89 45 ec             	mov    %eax,-0x14(%ebp)
 * @addr:   the address to count from
 * */
static inline bool
test_bit(int nr, volatile void *addr) {
    int oldbit;
    asm volatile ("btl %2, %1; sbbl %0,%0" : "=r" (oldbit) : "m" (*(volatile long *)addr), "Ir" (nr));
c0104105:	8b 45 ec             	mov    -0x14(%ebp),%eax
c0104108:	8b 55 f0             	mov    -0x10(%ebp),%edx
c010410b:	0f a3 10             	bt     %edx,(%eax)
c010410e:	19 c0                	sbb    %eax,%eax
c0104110:	89 45 e8             	mov    %eax,-0x18(%ebp)
    return oldbit != 0;
c0104113:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
c0104117:	0f 95 c0             	setne  %al
c010411a:	0f b6 c0             	movzbl %al,%eax
c010411d:	85 c0                	test   %eax,%eax
c010411f:	75 16                	jne    c0104137 <default_init_memmap+0x73>
c0104121:	68 a1 6a 10 c0       	push   $0xc0106aa1
c0104126:	68 76 6a 10 c0       	push   $0xc0106a76
c010412b:	6a 4a                	push   $0x4a
c010412d:	68 8b 6a 10 c0       	push   $0xc0106a8b
c0104132:	e8 d3 c2 ff ff       	call   c010040a <__panic>
        p->flags = 0;        
c0104137:	8b 45 f4             	mov    -0xc(%ebp),%eax
c010413a:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
        p->property = 0;
c0104141:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0104144:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
        set_page_ref(p, 0);//映射到此页的虚拟页个数为0
c010414b:	83 ec 08             	sub    $0x8,%esp
c010414e:	6a 00                	push   $0x0
c0104150:	ff 75 f4             	pushl  -0xc(%ebp)
c0104153:	e8 2b ff ff ff       	call   c0104083 <set_page_ref>
c0104158:	83 c4 10             	add    $0x10,%esp
        SetPageProperty(p);//标记为空页面
c010415b:	8b 45 f4             	mov    -0xc(%ebp),%eax
c010415e:	83 c0 04             	add    $0x4,%eax
c0104161:	c7 45 e4 01 00 00 00 	movl   $0x1,-0x1c(%ebp)
c0104168:	89 45 e0             	mov    %eax,-0x20(%ebp)
    asm volatile ("btsl %1, %0" :"=m" (*(volatile long *)addr) : "Ir" (nr));
c010416b:	8b 45 e0             	mov    -0x20(%ebp),%eax
c010416e:	8b 55 e4             	mov    -0x1c(%ebp),%edx
c0104171:	0f ab 10             	bts    %edx,(%eax)
}
c0104174:	90                   	nop
    for (; p != base + n; p ++) {
c0104175:	83 45 f4 14          	addl   $0x14,-0xc(%ebp)
c0104179:	8b 55 0c             	mov    0xc(%ebp),%edx
c010417c:	89 d0                	mov    %edx,%eax
c010417e:	c1 e0 02             	shl    $0x2,%eax
c0104181:	01 d0                	add    %edx,%eax
c0104183:	c1 e0 02             	shl    $0x2,%eax
c0104186:	89 c2                	mov    %eax,%edx
c0104188:	8b 45 08             	mov    0x8(%ebp),%eax
c010418b:	01 d0                	add    %edx,%eax
c010418d:	39 45 f4             	cmp    %eax,-0xc(%ebp)
c0104190:	0f 85 5f ff ff ff    	jne    c01040f5 <default_init_memmap+0x31>
         
    	//list_add_before(&free_list, &(p->page_link));//加入空页链表       
    }
    base->property = n;//连续的n个空页面
c0104196:	8b 45 08             	mov    0x8(%ebp),%eax
c0104199:	8b 55 0c             	mov    0xc(%ebp),%edx
c010419c:	89 50 08             	mov    %edx,0x8(%eax)
    //SetPageProperty(base);
    nr_free += n;//剩余空页面增加n个
c010419f:	8b 15 64 a9 11 c0    	mov    0xc011a964,%edx
c01041a5:	8b 45 0c             	mov    0xc(%ebp),%eax
c01041a8:	01 d0                	add    %edx,%eax
c01041aa:	a3 64 a9 11 c0       	mov    %eax,0xc011a964
    list_add(&free_list, &(base->page_link));//将第一页加入空页链表
c01041af:	8b 45 08             	mov    0x8(%ebp),%eax
c01041b2:	83 c0 0c             	add    $0xc,%eax
c01041b5:	c7 45 dc 5c a9 11 c0 	movl   $0xc011a95c,-0x24(%ebp)
c01041bc:	89 45 d8             	mov    %eax,-0x28(%ebp)
c01041bf:	8b 45 dc             	mov    -0x24(%ebp),%eax
c01041c2:	89 45 d4             	mov    %eax,-0x2c(%ebp)
c01041c5:	8b 45 d8             	mov    -0x28(%ebp),%eax
c01041c8:	89 45 d0             	mov    %eax,-0x30(%ebp)
 * Insert the new element @elm *after* the element @listelm which
 * is already in the list.
 * */
static inline void
list_add_after(list_entry_t *listelm, list_entry_t *elm) {
    __list_add(elm, listelm, listelm->next);
c01041cb:	8b 45 d4             	mov    -0x2c(%ebp),%eax
c01041ce:	8b 40 04             	mov    0x4(%eax),%eax
c01041d1:	8b 55 d0             	mov    -0x30(%ebp),%edx
c01041d4:	89 55 cc             	mov    %edx,-0x34(%ebp)
c01041d7:	8b 55 d4             	mov    -0x2c(%ebp),%edx
c01041da:	89 55 c8             	mov    %edx,-0x38(%ebp)
c01041dd:	89 45 c4             	mov    %eax,-0x3c(%ebp)
 * This is only for internal list manipulation where we know
 * the prev/next entries already!
 * */
static inline void
__list_add(list_entry_t *elm, list_entry_t *prev, list_entry_t *next) {
    prev->next = next->prev = elm;
c01041e0:	8b 45 c4             	mov    -0x3c(%ebp),%eax
c01041e3:	8b 55 cc             	mov    -0x34(%ebp),%edx
c01041e6:	89 10                	mov    %edx,(%eax)
c01041e8:	8b 45 c4             	mov    -0x3c(%ebp),%eax
c01041eb:	8b 10                	mov    (%eax),%edx
c01041ed:	8b 45 c8             	mov    -0x38(%ebp),%eax
c01041f0:	89 50 04             	mov    %edx,0x4(%eax)
    elm->next = next;
c01041f3:	8b 45 cc             	mov    -0x34(%ebp),%eax
c01041f6:	8b 55 c4             	mov    -0x3c(%ebp),%edx
c01041f9:	89 50 04             	mov    %edx,0x4(%eax)
    elm->prev = prev;
c01041fc:	8b 45 cc             	mov    -0x34(%ebp),%eax
c01041ff:	8b 55 c8             	mov    -0x38(%ebp),%edx
c0104202:	89 10                	mov    %edx,(%eax)
}
c0104204:	90                   	nop
}
c0104205:	90                   	nop
}
c0104206:	90                   	nop
	
}
c0104207:	90                   	nop
c0104208:	c9                   	leave  
c0104209:	c3                   	ret    

c010420a <default_alloc_pages>:

static struct Page *
default_alloc_pages(size_t n) {
c010420a:	f3 0f 1e fb          	endbr32 
c010420e:	55                   	push   %ebp
c010420f:	89 e5                	mov    %esp,%ebp
c0104211:	83 ec 58             	sub    $0x58,%esp
    assert(n > 0);
c0104214:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
c0104218:	75 16                	jne    c0104230 <default_alloc_pages+0x26>
c010421a:	68 70 6a 10 c0       	push   $0xc0106a70
c010421f:	68 76 6a 10 c0       	push   $0xc0106a76
c0104224:	6a 5b                	push   $0x5b
c0104226:	68 8b 6a 10 c0       	push   $0xc0106a8b
c010422b:	e8 da c1 ff ff       	call   c010040a <__panic>
    if (n > nr_free) {
c0104230:	a1 64 a9 11 c0       	mov    0xc011a964,%eax
c0104235:	39 45 08             	cmp    %eax,0x8(%ebp)
c0104238:	76 0a                	jbe    c0104244 <default_alloc_pages+0x3a>
    	//大于剩余空页，无法分配
        return NULL;
c010423a:	b8 00 00 00 00       	mov    $0x0,%eax
c010423f:	e9 7a 01 00 00       	jmp    c01043be <default_alloc_pages+0x1b4>
    }
    struct Page *page = NULL;
c0104244:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    list_entry_t *le = &free_list;
c010424b:	c7 45 f0 5c a9 11 c0 	movl   $0xc011a95c,-0x10(%ebp)
    
    while ((le = list_next(le)) != &free_list) {
c0104252:	eb 1c                	jmp    c0104270 <default_alloc_pages+0x66>
        struct Page *p = le2page(le, page_link);
c0104254:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0104257:	83 e8 0c             	sub    $0xc,%eax
c010425a:	89 45 e8             	mov    %eax,-0x18(%ebp)
        if (p->property >= n) {
c010425d:	8b 45 e8             	mov    -0x18(%ebp),%eax
c0104260:	8b 40 08             	mov    0x8(%eax),%eax
c0104263:	39 45 08             	cmp    %eax,0x8(%ebp)
c0104266:	77 08                	ja     c0104270 <default_alloc_pages+0x66>
            page = p;//找到第一个适合的页
c0104268:	8b 45 e8             	mov    -0x18(%ebp),%eax
c010426b:	89 45 f4             	mov    %eax,-0xc(%ebp)
            break;
c010426e:	eb 18                	jmp    c0104288 <default_alloc_pages+0x7e>
c0104270:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0104273:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    return listelm->next;
c0104276:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c0104279:	8b 40 04             	mov    0x4(%eax),%eax
    while ((le = list_next(le)) != &free_list) {
c010427c:	89 45 f0             	mov    %eax,-0x10(%ebp)
c010427f:	81 7d f0 5c a9 11 c0 	cmpl   $0xc011a95c,-0x10(%ebp)
c0104286:	75 cc                	jne    c0104254 <default_alloc_pages+0x4a>
        }
    }
    if (page != NULL) {
c0104288:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
c010428c:	0f 84 29 01 00 00    	je     c01043bb <default_alloc_pages+0x1b1>
    	
    	struct Page *p;
    	
    	for (p = page; p != (page + n); ++p) {
c0104292:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0104295:	89 45 ec             	mov    %eax,-0x14(%ebp)
c0104298:	eb 1e                	jmp    c01042b8 <default_alloc_pages+0xae>
        ClearPageProperty(p); // 将分配出去的内存页标记为非空闲
c010429a:	8b 45 ec             	mov    -0x14(%ebp),%eax
c010429d:	83 c0 04             	add    $0x4,%eax
c01042a0:	c7 45 e0 01 00 00 00 	movl   $0x1,-0x20(%ebp)
c01042a7:	89 45 dc             	mov    %eax,-0x24(%ebp)
    asm volatile ("btrl %1, %0" :"=m" (*(volatile long *)addr) : "Ir" (nr));
c01042aa:	8b 45 dc             	mov    -0x24(%ebp),%eax
c01042ad:	8b 55 e0             	mov    -0x20(%ebp),%edx
c01042b0:	0f b3 10             	btr    %edx,(%eax)
}
c01042b3:	90                   	nop
    	for (p = page; p != (page + n); ++p) {
c01042b4:	83 45 ec 14          	addl   $0x14,-0x14(%ebp)
c01042b8:	8b 55 08             	mov    0x8(%ebp),%edx
c01042bb:	89 d0                	mov    %edx,%eax
c01042bd:	c1 e0 02             	shl    $0x2,%eax
c01042c0:	01 d0                	add    %edx,%eax
c01042c2:	c1 e0 02             	shl    $0x2,%eax
c01042c5:	89 c2                	mov    %eax,%edx
c01042c7:	8b 45 f4             	mov    -0xc(%ebp),%eax
c01042ca:	01 d0                	add    %edx,%eax
c01042cc:	39 45 ec             	cmp    %eax,-0x14(%ebp)
c01042cf:	75 c9                	jne    c010429a <default_alloc_pages+0x90>
    }
    	
        list_del(&(page->page_link));//从空闲页链表中删除
c01042d1:	8b 45 f4             	mov    -0xc(%ebp),%eax
c01042d4:	83 c0 0c             	add    $0xc,%eax
c01042d7:	89 45 d8             	mov    %eax,-0x28(%ebp)
    __list_del(listelm->prev, listelm->next);
c01042da:	8b 45 d8             	mov    -0x28(%ebp),%eax
c01042dd:	8b 40 04             	mov    0x4(%eax),%eax
c01042e0:	8b 55 d8             	mov    -0x28(%ebp),%edx
c01042e3:	8b 12                	mov    (%edx),%edx
c01042e5:	89 55 d4             	mov    %edx,-0x2c(%ebp)
c01042e8:	89 45 d0             	mov    %eax,-0x30(%ebp)
 * This is only for internal list manipulation where we know
 * the prev/next entries already!
 * */
static inline void
__list_del(list_entry_t *prev, list_entry_t *next) {
    prev->next = next;
c01042eb:	8b 45 d4             	mov    -0x2c(%ebp),%eax
c01042ee:	8b 55 d0             	mov    -0x30(%ebp),%edx
c01042f1:	89 50 04             	mov    %edx,0x4(%eax)
    next->prev = prev;
c01042f4:	8b 45 d0             	mov    -0x30(%ebp),%eax
c01042f7:	8b 55 d4             	mov    -0x2c(%ebp),%edx
c01042fa:	89 10                	mov    %edx,(%eax)
}
c01042fc:	90                   	nop
}
c01042fd:	90                   	nop
        if (page->property > n) {
c01042fe:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0104301:	8b 40 08             	mov    0x8(%eax),%eax
c0104304:	39 45 08             	cmp    %eax,0x8(%ebp)
c0104307:	0f 83 87 00 00 00    	jae    c0104394 <default_alloc_pages+0x18a>
            p = page + n;//跳到最近的空页
c010430d:	8b 55 08             	mov    0x8(%ebp),%edx
c0104310:	89 d0                	mov    %edx,%eax
c0104312:	c1 e0 02             	shl    $0x2,%eax
c0104315:	01 d0                	add    %edx,%eax
c0104317:	c1 e0 02             	shl    $0x2,%eax
c010431a:	89 c2                	mov    %eax,%edx
c010431c:	8b 45 f4             	mov    -0xc(%ebp),%eax
c010431f:	01 d0                	add    %edx,%eax
c0104321:	89 45 ec             	mov    %eax,-0x14(%ebp)
            p->property = page->property - n;//重新计算剩余空间
c0104324:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0104327:	8b 40 08             	mov    0x8(%eax),%eax
c010432a:	2b 45 08             	sub    0x8(%ebp),%eax
c010432d:	89 c2                	mov    %eax,%edx
c010432f:	8b 45 ec             	mov    -0x14(%ebp),%eax
c0104332:	89 50 08             	mov    %edx,0x8(%eax)
            //list_add(&free_list, &(p->page_link));
            //加入空闲页链表中,注意按顺序加
            list_add(list_prev(le), &(p->page_link));
c0104335:	8b 45 ec             	mov    -0x14(%ebp),%eax
c0104338:	8d 50 0c             	lea    0xc(%eax),%edx
c010433b:	8b 45 f0             	mov    -0x10(%ebp),%eax
c010433e:	89 45 b0             	mov    %eax,-0x50(%ebp)
    return listelm->prev;
c0104341:	8b 45 b0             	mov    -0x50(%ebp),%eax
c0104344:	8b 00                	mov    (%eax),%eax
c0104346:	89 45 cc             	mov    %eax,-0x34(%ebp)
c0104349:	89 55 c8             	mov    %edx,-0x38(%ebp)
c010434c:	8b 45 cc             	mov    -0x34(%ebp),%eax
c010434f:	89 45 c4             	mov    %eax,-0x3c(%ebp)
c0104352:	8b 45 c8             	mov    -0x38(%ebp),%eax
c0104355:	89 45 c0             	mov    %eax,-0x40(%ebp)
    __list_add(elm, listelm, listelm->next);
c0104358:	8b 45 c4             	mov    -0x3c(%ebp),%eax
c010435b:	8b 40 04             	mov    0x4(%eax),%eax
c010435e:	8b 55 c0             	mov    -0x40(%ebp),%edx
c0104361:	89 55 bc             	mov    %edx,-0x44(%ebp)
c0104364:	8b 55 c4             	mov    -0x3c(%ebp),%edx
c0104367:	89 55 b8             	mov    %edx,-0x48(%ebp)
c010436a:	89 45 b4             	mov    %eax,-0x4c(%ebp)
    prev->next = next->prev = elm;
c010436d:	8b 45 b4             	mov    -0x4c(%ebp),%eax
c0104370:	8b 55 bc             	mov    -0x44(%ebp),%edx
c0104373:	89 10                	mov    %edx,(%eax)
c0104375:	8b 45 b4             	mov    -0x4c(%ebp),%eax
c0104378:	8b 10                	mov    (%eax),%edx
c010437a:	8b 45 b8             	mov    -0x48(%ebp),%eax
c010437d:	89 50 04             	mov    %edx,0x4(%eax)
    elm->next = next;
c0104380:	8b 45 bc             	mov    -0x44(%ebp),%eax
c0104383:	8b 55 b4             	mov    -0x4c(%ebp),%edx
c0104386:	89 50 04             	mov    %edx,0x4(%eax)
    elm->prev = prev;
c0104389:	8b 45 bc             	mov    -0x44(%ebp),%eax
c010438c:	8b 55 b8             	mov    -0x48(%ebp),%edx
c010438f:	89 10                	mov    %edx,(%eax)
}
c0104391:	90                   	nop
}
c0104392:	90                   	nop
}
c0104393:	90                   	nop
    }
        nr_free -= n;//剩余页数量减少
c0104394:	a1 64 a9 11 c0       	mov    0xc011a964,%eax
c0104399:	2b 45 08             	sub    0x8(%ebp),%eax
c010439c:	a3 64 a9 11 c0       	mov    %eax,0xc011a964
        ClearPageProperty(page);
c01043a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
c01043a4:	83 c0 04             	add    $0x4,%eax
c01043a7:	c7 45 ac 01 00 00 00 	movl   $0x1,-0x54(%ebp)
c01043ae:	89 45 a8             	mov    %eax,-0x58(%ebp)
    asm volatile ("btrl %1, %0" :"=m" (*(volatile long *)addr) : "Ir" (nr));
c01043b1:	8b 45 a8             	mov    -0x58(%ebp),%eax
c01043b4:	8b 55 ac             	mov    -0x54(%ebp),%edx
c01043b7:	0f b3 10             	btr    %edx,(%eax)
}
c01043ba:	90                   	nop
    }
    return page;
c01043bb:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
c01043be:	c9                   	leave  
c01043bf:	c3                   	ret    

c01043c0 <default_free_pages>:

static void
default_free_pages(struct Page *base, size_t n) {
c01043c0:	f3 0f 1e fb          	endbr32 
c01043c4:	55                   	push   %ebp
c01043c5:	89 e5                	mov    %esp,%ebp
c01043c7:	81 ec b8 00 00 00    	sub    $0xb8,%esp
    assert(n > 0);
c01043cd:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
c01043d1:	75 19                	jne    c01043ec <default_free_pages+0x2c>
c01043d3:	68 70 6a 10 c0       	push   $0xc0106a70
c01043d8:	68 76 6a 10 c0       	push   $0xc0106a76
c01043dd:	68 82 00 00 00       	push   $0x82
c01043e2:	68 8b 6a 10 c0       	push   $0xc0106a8b
c01043e7:	e8 1e c0 ff ff       	call   c010040a <__panic>
    struct Page *p = base;
c01043ec:	8b 45 08             	mov    0x8(%ebp),%eax
c01043ef:	89 45 f4             	mov    %eax,-0xc(%ebp)
    for (; p != base + n; p ++) {
c01043f2:	e9 9f 00 00 00       	jmp    c0104496 <default_free_pages+0xd6>
        assert(!PageReserved(p) && !PageProperty(p));
c01043f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
c01043fa:	83 c0 04             	add    $0x4,%eax
c01043fd:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
c0104404:	89 45 e0             	mov    %eax,-0x20(%ebp)
    asm volatile ("btl %2, %1; sbbl %0,%0" : "=r" (oldbit) : "m" (*(volatile long *)addr), "Ir" (nr));
c0104407:	8b 45 e0             	mov    -0x20(%ebp),%eax
c010440a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
c010440d:	0f a3 10             	bt     %edx,(%eax)
c0104410:	19 c0                	sbb    %eax,%eax
c0104412:	89 45 dc             	mov    %eax,-0x24(%ebp)
    return oldbit != 0;
c0104415:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
c0104419:	0f 95 c0             	setne  %al
c010441c:	0f b6 c0             	movzbl %al,%eax
c010441f:	85 c0                	test   %eax,%eax
c0104421:	75 2c                	jne    c010444f <default_free_pages+0x8f>
c0104423:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0104426:	83 c0 04             	add    $0x4,%eax
c0104429:	c7 45 d8 01 00 00 00 	movl   $0x1,-0x28(%ebp)
c0104430:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    asm volatile ("btl %2, %1; sbbl %0,%0" : "=r" (oldbit) : "m" (*(volatile long *)addr), "Ir" (nr));
c0104433:	8b 45 d4             	mov    -0x2c(%ebp),%eax
c0104436:	8b 55 d8             	mov    -0x28(%ebp),%edx
c0104439:	0f a3 10             	bt     %edx,(%eax)
c010443c:	19 c0                	sbb    %eax,%eax
c010443e:	89 45 d0             	mov    %eax,-0x30(%ebp)
    return oldbit != 0;
c0104441:	83 7d d0 00          	cmpl   $0x0,-0x30(%ebp)
c0104445:	0f 95 c0             	setne  %al
c0104448:	0f b6 c0             	movzbl %al,%eax
c010444b:	85 c0                	test   %eax,%eax
c010444d:	74 19                	je     c0104468 <default_free_pages+0xa8>
c010444f:	68 b4 6a 10 c0       	push   $0xc0106ab4
c0104454:	68 76 6a 10 c0       	push   $0xc0106a76
c0104459:	68 85 00 00 00       	push   $0x85
c010445e:	68 8b 6a 10 c0       	push   $0xc0106a8b
c0104463:	e8 a2 bf ff ff       	call   c010040a <__panic>
        SetPageProperty(p);
c0104468:	8b 45 f4             	mov    -0xc(%ebp),%eax
c010446b:	83 c0 04             	add    $0x4,%eax
c010446e:	c7 45 cc 01 00 00 00 	movl   $0x1,-0x34(%ebp)
c0104475:	89 45 c8             	mov    %eax,-0x38(%ebp)
    asm volatile ("btsl %1, %0" :"=m" (*(volatile long *)addr) : "Ir" (nr));
c0104478:	8b 45 c8             	mov    -0x38(%ebp),%eax
c010447b:	8b 55 cc             	mov    -0x34(%ebp),%edx
c010447e:	0f ab 10             	bts    %edx,(%eax)
}
c0104481:	90                   	nop
        set_page_ref(p, 0);//指向此页的虚拟页为0
c0104482:	83 ec 08             	sub    $0x8,%esp
c0104485:	6a 00                	push   $0x0
c0104487:	ff 75 f4             	pushl  -0xc(%ebp)
c010448a:	e8 f4 fb ff ff       	call   c0104083 <set_page_ref>
c010448f:	83 c4 10             	add    $0x10,%esp
    for (; p != base + n; p ++) {
c0104492:	83 45 f4 14          	addl   $0x14,-0xc(%ebp)
c0104496:	8b 55 0c             	mov    0xc(%ebp),%edx
c0104499:	89 d0                	mov    %edx,%eax
c010449b:	c1 e0 02             	shl    $0x2,%eax
c010449e:	01 d0                	add    %edx,%eax
c01044a0:	c1 e0 02             	shl    $0x2,%eax
c01044a3:	89 c2                	mov    %eax,%edx
c01044a5:	8b 45 08             	mov    0x8(%ebp),%eax
c01044a8:	01 d0                	add    %edx,%eax
c01044aa:	39 45 f4             	cmp    %eax,-0xc(%ebp)
c01044ad:	0f 85 44 ff ff ff    	jne    c01043f7 <default_free_pages+0x37>
    }
    base->property = n;//设置空闲块大小
c01044b3:	8b 45 08             	mov    0x8(%ebp),%eax
c01044b6:	8b 55 0c             	mov    0xc(%ebp),%edx
c01044b9:	89 50 08             	mov    %edx,0x8(%eax)
c01044bc:	c7 45 c4 5c a9 11 c0 	movl   $0xc011a95c,-0x3c(%ebp)
    return listelm->next;
c01044c3:	8b 45 c4             	mov    -0x3c(%ebp),%eax
c01044c6:	8b 40 04             	mov    0x4(%eax),%eax
    //SetPageProperty(base);
    list_entry_t *le = list_next(&free_list);
c01044c9:	89 45 f0             	mov    %eax,-0x10(%ebp)
    while (le != &free_list) {
c01044cc:	e9 0e 01 00 00       	jmp    c01045df <default_free_pages+0x21f>
    	//遍历空闲链表中的每个页
        p = le2page(le, page_link);
c01044d1:	8b 45 f0             	mov    -0x10(%ebp),%eax
c01044d4:	83 e8 0c             	sub    $0xc,%eax
c01044d7:	89 45 f4             	mov    %eax,-0xc(%ebp)
c01044da:	8b 45 f0             	mov    -0x10(%ebp),%eax
c01044dd:	89 45 c0             	mov    %eax,-0x40(%ebp)
c01044e0:	8b 45 c0             	mov    -0x40(%ebp),%eax
c01044e3:	8b 40 04             	mov    0x4(%eax),%eax
        le = list_next(le);
c01044e6:	89 45 f0             	mov    %eax,-0x10(%ebp)
        if (base + base->property == p) {
c01044e9:	8b 45 08             	mov    0x8(%ebp),%eax
c01044ec:	8b 50 08             	mov    0x8(%eax),%edx
c01044ef:	89 d0                	mov    %edx,%eax
c01044f1:	c1 e0 02             	shl    $0x2,%eax
c01044f4:	01 d0                	add    %edx,%eax
c01044f6:	c1 e0 02             	shl    $0x2,%eax
c01044f9:	89 c2                	mov    %eax,%edx
c01044fb:	8b 45 08             	mov    0x8(%ebp),%eax
c01044fe:	01 d0                	add    %edx,%eax
c0104500:	39 45 f4             	cmp    %eax,-0xc(%ebp)
c0104503:	75 5d                	jne    c0104562 <default_free_pages+0x1a2>
        //如果当前页可以连在base的后面
            base->property += p->property;
c0104505:	8b 45 08             	mov    0x8(%ebp),%eax
c0104508:	8b 50 08             	mov    0x8(%eax),%edx
c010450b:	8b 45 f4             	mov    -0xc(%ebp),%eax
c010450e:	8b 40 08             	mov    0x8(%eax),%eax
c0104511:	01 c2                	add    %eax,%edx
c0104513:	8b 45 08             	mov    0x8(%ebp),%eax
c0104516:	89 50 08             	mov    %edx,0x8(%eax)
            ClearPageProperty(p);
c0104519:	8b 45 f4             	mov    -0xc(%ebp),%eax
c010451c:	83 c0 04             	add    $0x4,%eax
c010451f:	c7 45 b0 01 00 00 00 	movl   $0x1,-0x50(%ebp)
c0104526:	89 45 ac             	mov    %eax,-0x54(%ebp)
    asm volatile ("btrl %1, %0" :"=m" (*(volatile long *)addr) : "Ir" (nr));
c0104529:	8b 45 ac             	mov    -0x54(%ebp),%eax
c010452c:	8b 55 b0             	mov    -0x50(%ebp),%edx
c010452f:	0f b3 10             	btr    %edx,(%eax)
}
c0104532:	90                   	nop
            list_del(&(p->page_link));
c0104533:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0104536:	83 c0 0c             	add    $0xc,%eax
c0104539:	89 45 bc             	mov    %eax,-0x44(%ebp)
    __list_del(listelm->prev, listelm->next);
c010453c:	8b 45 bc             	mov    -0x44(%ebp),%eax
c010453f:	8b 40 04             	mov    0x4(%eax),%eax
c0104542:	8b 55 bc             	mov    -0x44(%ebp),%edx
c0104545:	8b 12                	mov    (%edx),%edx
c0104547:	89 55 b8             	mov    %edx,-0x48(%ebp)
c010454a:	89 45 b4             	mov    %eax,-0x4c(%ebp)
    prev->next = next;
c010454d:	8b 45 b8             	mov    -0x48(%ebp),%eax
c0104550:	8b 55 b4             	mov    -0x4c(%ebp),%edx
c0104553:	89 50 04             	mov    %edx,0x4(%eax)
    next->prev = prev;
c0104556:	8b 45 b4             	mov    -0x4c(%ebp),%eax
c0104559:	8b 55 b8             	mov    -0x48(%ebp),%edx
c010455c:	89 10                	mov    %edx,(%eax)
}
c010455e:	90                   	nop
}
c010455f:	90                   	nop
c0104560:	eb 7d                	jmp    c01045df <default_free_pages+0x21f>
        }
        else if (p + p->property == base) {
c0104562:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0104565:	8b 50 08             	mov    0x8(%eax),%edx
c0104568:	89 d0                	mov    %edx,%eax
c010456a:	c1 e0 02             	shl    $0x2,%eax
c010456d:	01 d0                	add    %edx,%eax
c010456f:	c1 e0 02             	shl    $0x2,%eax
c0104572:	89 c2                	mov    %eax,%edx
c0104574:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0104577:	01 d0                	add    %edx,%eax
c0104579:	39 45 08             	cmp    %eax,0x8(%ebp)
c010457c:	75 61                	jne    c01045df <default_free_pages+0x21f>
        //如果base可以连在当前页的后面
            p->property += base->property;
c010457e:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0104581:	8b 50 08             	mov    0x8(%eax),%edx
c0104584:	8b 45 08             	mov    0x8(%ebp),%eax
c0104587:	8b 40 08             	mov    0x8(%eax),%eax
c010458a:	01 c2                	add    %eax,%edx
c010458c:	8b 45 f4             	mov    -0xc(%ebp),%eax
c010458f:	89 50 08             	mov    %edx,0x8(%eax)
            ClearPageProperty(base);
c0104592:	8b 45 08             	mov    0x8(%ebp),%eax
c0104595:	83 c0 04             	add    $0x4,%eax
c0104598:	c7 45 9c 01 00 00 00 	movl   $0x1,-0x64(%ebp)
c010459f:	89 45 98             	mov    %eax,-0x68(%ebp)
    asm volatile ("btrl %1, %0" :"=m" (*(volatile long *)addr) : "Ir" (nr));
c01045a2:	8b 45 98             	mov    -0x68(%ebp),%eax
c01045a5:	8b 55 9c             	mov    -0x64(%ebp),%edx
c01045a8:	0f b3 10             	btr    %edx,(%eax)
}
c01045ab:	90                   	nop
            base = p;
c01045ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
c01045af:	89 45 08             	mov    %eax,0x8(%ebp)
            list_del(&(p->page_link));
c01045b2:	8b 45 f4             	mov    -0xc(%ebp),%eax
c01045b5:	83 c0 0c             	add    $0xc,%eax
c01045b8:	89 45 a8             	mov    %eax,-0x58(%ebp)
    __list_del(listelm->prev, listelm->next);
c01045bb:	8b 45 a8             	mov    -0x58(%ebp),%eax
c01045be:	8b 40 04             	mov    0x4(%eax),%eax
c01045c1:	8b 55 a8             	mov    -0x58(%ebp),%edx
c01045c4:	8b 12                	mov    (%edx),%edx
c01045c6:	89 55 a4             	mov    %edx,-0x5c(%ebp)
c01045c9:	89 45 a0             	mov    %eax,-0x60(%ebp)
    prev->next = next;
c01045cc:	8b 45 a4             	mov    -0x5c(%ebp),%eax
c01045cf:	8b 55 a0             	mov    -0x60(%ebp),%edx
c01045d2:	89 50 04             	mov    %edx,0x4(%eax)
    next->prev = prev;
c01045d5:	8b 45 a0             	mov    -0x60(%ebp),%eax
c01045d8:	8b 55 a4             	mov    -0x5c(%ebp),%edx
c01045db:	89 10                	mov    %edx,(%eax)
}
c01045dd:	90                   	nop
}
c01045de:	90                   	nop
    while (le != &free_list) {
c01045df:	81 7d f0 5c a9 11 c0 	cmpl   $0xc011a95c,-0x10(%ebp)
c01045e6:	0f 85 e5 fe ff ff    	jne    c01044d1 <default_free_pages+0x111>
        }
    }
    nr_free += n;//剩余空页增加n
c01045ec:	8b 15 64 a9 11 c0    	mov    0xc011a964,%edx
c01045f2:	8b 45 0c             	mov    0xc(%ebp),%eax
c01045f5:	01 d0                	add    %edx,%eax
c01045f7:	a3 64 a9 11 c0       	mov    %eax,0xc011a964
c01045fc:	c7 45 94 5c a9 11 c0 	movl   $0xc011a95c,-0x6c(%ebp)
    return listelm->next;
c0104603:	8b 45 94             	mov    -0x6c(%ebp),%eax
c0104606:	8b 40 04             	mov    0x4(%eax),%eax
    //将空闲块的基页加入到链表中,按顺序！！
    //list_add(&free_list, &(base->page_link));
    le=list_next(&free_list);
c0104609:	89 45 f0             	mov    %eax,-0x10(%ebp)
    int flag=0;    
c010460c:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    while(le!=&free_list)
c0104613:	e9 4c 01 00 00       	jmp    c0104764 <default_free_pages+0x3a4>
    {
    	//遍历空闲页表
    	p=le2page(le,page_link);
c0104618:	8b 45 f0             	mov    -0x10(%ebp),%eax
c010461b:	83 e8 0c             	sub    $0xc,%eax
c010461e:	89 45 f4             	mov    %eax,-0xc(%ebp)
c0104621:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0104624:	89 45 90             	mov    %eax,-0x70(%ebp)
c0104627:	8b 45 90             	mov    -0x70(%ebp),%eax
c010462a:	8b 40 04             	mov    0x4(%eax),%eax
    	le=list_next(le);
c010462d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    	struct Page *q=le2page(le,page_link);
c0104630:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0104633:	83 e8 0c             	sub    $0xc,%eax
c0104636:	89 45 e8             	mov    %eax,-0x18(%ebp)
    	if(p>base)//插入头部
c0104639:	8b 45 f4             	mov    -0xc(%ebp),%eax
c010463c:	3b 45 08             	cmp    0x8(%ebp),%eax
c010463f:	0f 86 85 00 00 00    	jbe    c01046ca <default_free_pages+0x30a>
    	{
    		list_add(&free_list,&(base->page_link));
c0104645:	8b 45 08             	mov    0x8(%ebp),%eax
c0104648:	83 c0 0c             	add    $0xc,%eax
c010464b:	c7 45 8c 5c a9 11 c0 	movl   $0xc011a95c,-0x74(%ebp)
c0104652:	89 45 88             	mov    %eax,-0x78(%ebp)
c0104655:	8b 45 8c             	mov    -0x74(%ebp),%eax
c0104658:	89 45 84             	mov    %eax,-0x7c(%ebp)
c010465b:	8b 45 88             	mov    -0x78(%ebp),%eax
c010465e:	89 45 80             	mov    %eax,-0x80(%ebp)
    __list_add(elm, listelm, listelm->next);
c0104661:	8b 45 84             	mov    -0x7c(%ebp),%eax
c0104664:	8b 40 04             	mov    0x4(%eax),%eax
c0104667:	8b 55 80             	mov    -0x80(%ebp),%edx
c010466a:	89 95 7c ff ff ff    	mov    %edx,-0x84(%ebp)
c0104670:	8b 55 84             	mov    -0x7c(%ebp),%edx
c0104673:	89 95 78 ff ff ff    	mov    %edx,-0x88(%ebp)
c0104679:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%ebp)
    prev->next = next->prev = elm;
c010467f:	8b 85 74 ff ff ff    	mov    -0x8c(%ebp),%eax
c0104685:	8b 95 7c ff ff ff    	mov    -0x84(%ebp),%edx
c010468b:	89 10                	mov    %edx,(%eax)
c010468d:	8b 85 74 ff ff ff    	mov    -0x8c(%ebp),%eax
c0104693:	8b 10                	mov    (%eax),%edx
c0104695:	8b 85 78 ff ff ff    	mov    -0x88(%ebp),%eax
c010469b:	89 50 04             	mov    %edx,0x4(%eax)
    elm->next = next;
c010469e:	8b 85 7c ff ff ff    	mov    -0x84(%ebp),%eax
c01046a4:	8b 95 74 ff ff ff    	mov    -0x8c(%ebp),%edx
c01046aa:	89 50 04             	mov    %edx,0x4(%eax)
    elm->prev = prev;
c01046ad:	8b 85 7c ff ff ff    	mov    -0x84(%ebp),%eax
c01046b3:	8b 95 78 ff ff ff    	mov    -0x88(%ebp),%edx
c01046b9:	89 10                	mov    %edx,(%eax)
}
c01046bb:	90                   	nop
}
c01046bc:	90                   	nop
}
c01046bd:	90                   	nop
    		flag=1;
c01046be:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
    		break;
c01046c5:	e9 a7 00 00 00       	jmp    c0104771 <default_free_pages+0x3b1>
    	}
    	if(p<base&&base<q)//插入中间
c01046ca:	8b 45 f4             	mov    -0xc(%ebp),%eax
c01046cd:	3b 45 08             	cmp    0x8(%ebp),%eax
c01046d0:	0f 83 8e 00 00 00    	jae    c0104764 <default_free_pages+0x3a4>
c01046d6:	8b 45 08             	mov    0x8(%ebp),%eax
c01046d9:	3b 45 e8             	cmp    -0x18(%ebp),%eax
c01046dc:	0f 83 82 00 00 00    	jae    c0104764 <default_free_pages+0x3a4>
    	{
    		list_add_before(le,&(base->page_link));
c01046e2:	8b 45 08             	mov    0x8(%ebp),%eax
c01046e5:	8d 50 0c             	lea    0xc(%eax),%edx
c01046e8:	8b 45 f0             	mov    -0x10(%ebp),%eax
c01046eb:	89 85 70 ff ff ff    	mov    %eax,-0x90(%ebp)
c01046f1:	89 95 6c ff ff ff    	mov    %edx,-0x94(%ebp)
    __list_add(elm, listelm->prev, listelm);
c01046f7:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
c01046fd:	8b 00                	mov    (%eax),%eax
c01046ff:	8b 95 6c ff ff ff    	mov    -0x94(%ebp),%edx
c0104705:	89 95 68 ff ff ff    	mov    %edx,-0x98(%ebp)
c010470b:	89 85 64 ff ff ff    	mov    %eax,-0x9c(%ebp)
c0104711:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
c0104717:	89 85 60 ff ff ff    	mov    %eax,-0xa0(%ebp)
    prev->next = next->prev = elm;
c010471d:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
c0104723:	8b 95 68 ff ff ff    	mov    -0x98(%ebp),%edx
c0104729:	89 10                	mov    %edx,(%eax)
c010472b:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
c0104731:	8b 10                	mov    (%eax),%edx
c0104733:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
c0104739:	89 50 04             	mov    %edx,0x4(%eax)
    elm->next = next;
c010473c:	8b 85 68 ff ff ff    	mov    -0x98(%ebp),%eax
c0104742:	8b 95 60 ff ff ff    	mov    -0xa0(%ebp),%edx
c0104748:	89 50 04             	mov    %edx,0x4(%eax)
    elm->prev = prev;
c010474b:	8b 85 68 ff ff ff    	mov    -0x98(%ebp),%eax
c0104751:	8b 95 64 ff ff ff    	mov    -0x9c(%ebp),%edx
c0104757:	89 10                	mov    %edx,(%eax)
}
c0104759:	90                   	nop
}
c010475a:	90                   	nop
    		flag=1;
c010475b:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
    		break;
c0104762:	eb 0d                	jmp    c0104771 <default_free_pages+0x3b1>
    while(le!=&free_list)
c0104764:	81 7d f0 5c a9 11 c0 	cmpl   $0xc011a95c,-0x10(%ebp)
c010476b:	0f 85 a7 fe ff ff    	jne    c0104618 <default_free_pages+0x258>
    	}
    }
    if(flag==0)//插入尾部
c0104771:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
c0104775:	75 7a                	jne    c01047f1 <default_free_pages+0x431>
    {
    	list_add_before(&free_list,&(base->page_link));
c0104777:	8b 45 08             	mov    0x8(%ebp),%eax
c010477a:	83 c0 0c             	add    $0xc,%eax
c010477d:	c7 85 5c ff ff ff 5c 	movl   $0xc011a95c,-0xa4(%ebp)
c0104784:	a9 11 c0 
c0104787:	89 85 58 ff ff ff    	mov    %eax,-0xa8(%ebp)
    __list_add(elm, listelm->prev, listelm);
c010478d:	8b 85 5c ff ff ff    	mov    -0xa4(%ebp),%eax
c0104793:	8b 00                	mov    (%eax),%eax
c0104795:	8b 95 58 ff ff ff    	mov    -0xa8(%ebp),%edx
c010479b:	89 95 54 ff ff ff    	mov    %edx,-0xac(%ebp)
c01047a1:	89 85 50 ff ff ff    	mov    %eax,-0xb0(%ebp)
c01047a7:	8b 85 5c ff ff ff    	mov    -0xa4(%ebp),%eax
c01047ad:	89 85 4c ff ff ff    	mov    %eax,-0xb4(%ebp)
    prev->next = next->prev = elm;
c01047b3:	8b 85 4c ff ff ff    	mov    -0xb4(%ebp),%eax
c01047b9:	8b 95 54 ff ff ff    	mov    -0xac(%ebp),%edx
c01047bf:	89 10                	mov    %edx,(%eax)
c01047c1:	8b 85 4c ff ff ff    	mov    -0xb4(%ebp),%eax
c01047c7:	8b 10                	mov    (%eax),%edx
c01047c9:	8b 85 50 ff ff ff    	mov    -0xb0(%ebp),%eax
c01047cf:	89 50 04             	mov    %edx,0x4(%eax)
    elm->next = next;
c01047d2:	8b 85 54 ff ff ff    	mov    -0xac(%ebp),%eax
c01047d8:	8b 95 4c ff ff ff    	mov    -0xb4(%ebp),%edx
c01047de:	89 50 04             	mov    %edx,0x4(%eax)
    elm->prev = prev;
c01047e1:	8b 85 54 ff ff ff    	mov    -0xac(%ebp),%eax
c01047e7:	8b 95 50 ff ff ff    	mov    -0xb0(%ebp),%edx
c01047ed:	89 10                	mov    %edx,(%eax)
}
c01047ef:	90                   	nop
}
c01047f0:	90                   	nop
    }    
}
c01047f1:	90                   	nop
c01047f2:	c9                   	leave  
c01047f3:	c3                   	ret    

c01047f4 <default_nr_free_pages>:

static size_t
default_nr_free_pages(void) {
c01047f4:	f3 0f 1e fb          	endbr32 
c01047f8:	55                   	push   %ebp
c01047f9:	89 e5                	mov    %esp,%ebp
    return nr_free;
c01047fb:	a1 64 a9 11 c0       	mov    0xc011a964,%eax
}
c0104800:	5d                   	pop    %ebp
c0104801:	c3                   	ret    

c0104802 <basic_check>:

static void
basic_check(void) {
c0104802:	f3 0f 1e fb          	endbr32 
c0104806:	55                   	push   %ebp
c0104807:	89 e5                	mov    %esp,%ebp
c0104809:	83 ec 38             	sub    $0x38,%esp
    struct Page *p0, *p1, *p2;
    p0 = p1 = p2 = NULL;
c010480c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
c0104813:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0104816:	89 45 f0             	mov    %eax,-0x10(%ebp)
c0104819:	8b 45 f0             	mov    -0x10(%ebp),%eax
c010481c:	89 45 ec             	mov    %eax,-0x14(%ebp)
    assert((p0 = alloc_page()) != NULL);
c010481f:	83 ec 0c             	sub    $0xc,%esp
c0104822:	6a 01                	push   $0x1
c0104824:	e8 bc e4 ff ff       	call   c0102ce5 <alloc_pages>
c0104829:	83 c4 10             	add    $0x10,%esp
c010482c:	89 45 ec             	mov    %eax,-0x14(%ebp)
c010482f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
c0104833:	75 19                	jne    c010484e <basic_check+0x4c>
c0104835:	68 d9 6a 10 c0       	push   $0xc0106ad9
c010483a:	68 76 6a 10 c0       	push   $0xc0106a76
c010483f:	68 c5 00 00 00       	push   $0xc5
c0104844:	68 8b 6a 10 c0       	push   $0xc0106a8b
c0104849:	e8 bc bb ff ff       	call   c010040a <__panic>
    assert((p1 = alloc_page()) != NULL);
c010484e:	83 ec 0c             	sub    $0xc,%esp
c0104851:	6a 01                	push   $0x1
c0104853:	e8 8d e4 ff ff       	call   c0102ce5 <alloc_pages>
c0104858:	83 c4 10             	add    $0x10,%esp
c010485b:	89 45 f0             	mov    %eax,-0x10(%ebp)
c010485e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
c0104862:	75 19                	jne    c010487d <basic_check+0x7b>
c0104864:	68 f5 6a 10 c0       	push   $0xc0106af5
c0104869:	68 76 6a 10 c0       	push   $0xc0106a76
c010486e:	68 c6 00 00 00       	push   $0xc6
c0104873:	68 8b 6a 10 c0       	push   $0xc0106a8b
c0104878:	e8 8d bb ff ff       	call   c010040a <__panic>
    assert((p2 = alloc_page()) != NULL);
c010487d:	83 ec 0c             	sub    $0xc,%esp
c0104880:	6a 01                	push   $0x1
c0104882:	e8 5e e4 ff ff       	call   c0102ce5 <alloc_pages>
c0104887:	83 c4 10             	add    $0x10,%esp
c010488a:	89 45 f4             	mov    %eax,-0xc(%ebp)
c010488d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
c0104891:	75 19                	jne    c01048ac <basic_check+0xaa>
c0104893:	68 11 6b 10 c0       	push   $0xc0106b11
c0104898:	68 76 6a 10 c0       	push   $0xc0106a76
c010489d:	68 c7 00 00 00       	push   $0xc7
c01048a2:	68 8b 6a 10 c0       	push   $0xc0106a8b
c01048a7:	e8 5e bb ff ff       	call   c010040a <__panic>

    assert(p0 != p1 && p0 != p2 && p1 != p2);
c01048ac:	8b 45 ec             	mov    -0x14(%ebp),%eax
c01048af:	3b 45 f0             	cmp    -0x10(%ebp),%eax
c01048b2:	74 10                	je     c01048c4 <basic_check+0xc2>
c01048b4:	8b 45 ec             	mov    -0x14(%ebp),%eax
c01048b7:	3b 45 f4             	cmp    -0xc(%ebp),%eax
c01048ba:	74 08                	je     c01048c4 <basic_check+0xc2>
c01048bc:	8b 45 f0             	mov    -0x10(%ebp),%eax
c01048bf:	3b 45 f4             	cmp    -0xc(%ebp),%eax
c01048c2:	75 19                	jne    c01048dd <basic_check+0xdb>
c01048c4:	68 30 6b 10 c0       	push   $0xc0106b30
c01048c9:	68 76 6a 10 c0       	push   $0xc0106a76
c01048ce:	68 c9 00 00 00       	push   $0xc9
c01048d3:	68 8b 6a 10 c0       	push   $0xc0106a8b
c01048d8:	e8 2d bb ff ff       	call   c010040a <__panic>
    assert(page_ref(p0) == 0 && page_ref(p1) == 0 && page_ref(p2) == 0);
c01048dd:	83 ec 0c             	sub    $0xc,%esp
c01048e0:	ff 75 ec             	pushl  -0x14(%ebp)
c01048e3:	e8 91 f7 ff ff       	call   c0104079 <page_ref>
c01048e8:	83 c4 10             	add    $0x10,%esp
c01048eb:	85 c0                	test   %eax,%eax
c01048ed:	75 24                	jne    c0104913 <basic_check+0x111>
c01048ef:	83 ec 0c             	sub    $0xc,%esp
c01048f2:	ff 75 f0             	pushl  -0x10(%ebp)
c01048f5:	e8 7f f7 ff ff       	call   c0104079 <page_ref>
c01048fa:	83 c4 10             	add    $0x10,%esp
c01048fd:	85 c0                	test   %eax,%eax
c01048ff:	75 12                	jne    c0104913 <basic_check+0x111>
c0104901:	83 ec 0c             	sub    $0xc,%esp
c0104904:	ff 75 f4             	pushl  -0xc(%ebp)
c0104907:	e8 6d f7 ff ff       	call   c0104079 <page_ref>
c010490c:	83 c4 10             	add    $0x10,%esp
c010490f:	85 c0                	test   %eax,%eax
c0104911:	74 19                	je     c010492c <basic_check+0x12a>
c0104913:	68 54 6b 10 c0       	push   $0xc0106b54
c0104918:	68 76 6a 10 c0       	push   $0xc0106a76
c010491d:	68 ca 00 00 00       	push   $0xca
c0104922:	68 8b 6a 10 c0       	push   $0xc0106a8b
c0104927:	e8 de ba ff ff       	call   c010040a <__panic>

    assert(page2pa(p0) < npage * PGSIZE);
c010492c:	83 ec 0c             	sub    $0xc,%esp
c010492f:	ff 75 ec             	pushl  -0x14(%ebp)
c0104932:	e8 2f f7 ff ff       	call   c0104066 <page2pa>
c0104937:	83 c4 10             	add    $0x10,%esp
c010493a:	8b 15 c0 a8 11 c0    	mov    0xc011a8c0,%edx
c0104940:	c1 e2 0c             	shl    $0xc,%edx
c0104943:	39 d0                	cmp    %edx,%eax
c0104945:	72 19                	jb     c0104960 <basic_check+0x15e>
c0104947:	68 90 6b 10 c0       	push   $0xc0106b90
c010494c:	68 76 6a 10 c0       	push   $0xc0106a76
c0104951:	68 cc 00 00 00       	push   $0xcc
c0104956:	68 8b 6a 10 c0       	push   $0xc0106a8b
c010495b:	e8 aa ba ff ff       	call   c010040a <__panic>
    assert(page2pa(p1) < npage * PGSIZE);
c0104960:	83 ec 0c             	sub    $0xc,%esp
c0104963:	ff 75 f0             	pushl  -0x10(%ebp)
c0104966:	e8 fb f6 ff ff       	call   c0104066 <page2pa>
c010496b:	83 c4 10             	add    $0x10,%esp
c010496e:	8b 15 c0 a8 11 c0    	mov    0xc011a8c0,%edx
c0104974:	c1 e2 0c             	shl    $0xc,%edx
c0104977:	39 d0                	cmp    %edx,%eax
c0104979:	72 19                	jb     c0104994 <basic_check+0x192>
c010497b:	68 ad 6b 10 c0       	push   $0xc0106bad
c0104980:	68 76 6a 10 c0       	push   $0xc0106a76
c0104985:	68 cd 00 00 00       	push   $0xcd
c010498a:	68 8b 6a 10 c0       	push   $0xc0106a8b
c010498f:	e8 76 ba ff ff       	call   c010040a <__panic>
    assert(page2pa(p2) < npage * PGSIZE);
c0104994:	83 ec 0c             	sub    $0xc,%esp
c0104997:	ff 75 f4             	pushl  -0xc(%ebp)
c010499a:	e8 c7 f6 ff ff       	call   c0104066 <page2pa>
c010499f:	83 c4 10             	add    $0x10,%esp
c01049a2:	8b 15 c0 a8 11 c0    	mov    0xc011a8c0,%edx
c01049a8:	c1 e2 0c             	shl    $0xc,%edx
c01049ab:	39 d0                	cmp    %edx,%eax
c01049ad:	72 19                	jb     c01049c8 <basic_check+0x1c6>
c01049af:	68 ca 6b 10 c0       	push   $0xc0106bca
c01049b4:	68 76 6a 10 c0       	push   $0xc0106a76
c01049b9:	68 ce 00 00 00       	push   $0xce
c01049be:	68 8b 6a 10 c0       	push   $0xc0106a8b
c01049c3:	e8 42 ba ff ff       	call   c010040a <__panic>

    list_entry_t free_list_store = free_list;
c01049c8:	a1 5c a9 11 c0       	mov    0xc011a95c,%eax
c01049cd:	8b 15 60 a9 11 c0    	mov    0xc011a960,%edx
c01049d3:	89 45 d0             	mov    %eax,-0x30(%ebp)
c01049d6:	89 55 d4             	mov    %edx,-0x2c(%ebp)
c01049d9:	c7 45 dc 5c a9 11 c0 	movl   $0xc011a95c,-0x24(%ebp)
    elm->prev = elm->next = elm;
c01049e0:	8b 45 dc             	mov    -0x24(%ebp),%eax
c01049e3:	8b 55 dc             	mov    -0x24(%ebp),%edx
c01049e6:	89 50 04             	mov    %edx,0x4(%eax)
c01049e9:	8b 45 dc             	mov    -0x24(%ebp),%eax
c01049ec:	8b 50 04             	mov    0x4(%eax),%edx
c01049ef:	8b 45 dc             	mov    -0x24(%ebp),%eax
c01049f2:	89 10                	mov    %edx,(%eax)
}
c01049f4:	90                   	nop
c01049f5:	c7 45 e0 5c a9 11 c0 	movl   $0xc011a95c,-0x20(%ebp)
    return list->next == list;
c01049fc:	8b 45 e0             	mov    -0x20(%ebp),%eax
c01049ff:	8b 40 04             	mov    0x4(%eax),%eax
c0104a02:	39 45 e0             	cmp    %eax,-0x20(%ebp)
c0104a05:	0f 94 c0             	sete   %al
c0104a08:	0f b6 c0             	movzbl %al,%eax
    list_init(&free_list);
    assert(list_empty(&free_list));
c0104a0b:	85 c0                	test   %eax,%eax
c0104a0d:	75 19                	jne    c0104a28 <basic_check+0x226>
c0104a0f:	68 e7 6b 10 c0       	push   $0xc0106be7
c0104a14:	68 76 6a 10 c0       	push   $0xc0106a76
c0104a19:	68 d2 00 00 00       	push   $0xd2
c0104a1e:	68 8b 6a 10 c0       	push   $0xc0106a8b
c0104a23:	e8 e2 b9 ff ff       	call   c010040a <__panic>

    unsigned int nr_free_store = nr_free;
c0104a28:	a1 64 a9 11 c0       	mov    0xc011a964,%eax
c0104a2d:	89 45 e8             	mov    %eax,-0x18(%ebp)
    nr_free = 0;
c0104a30:	c7 05 64 a9 11 c0 00 	movl   $0x0,0xc011a964
c0104a37:	00 00 00 

    assert(alloc_page() == NULL);
c0104a3a:	83 ec 0c             	sub    $0xc,%esp
c0104a3d:	6a 01                	push   $0x1
c0104a3f:	e8 a1 e2 ff ff       	call   c0102ce5 <alloc_pages>
c0104a44:	83 c4 10             	add    $0x10,%esp
c0104a47:	85 c0                	test   %eax,%eax
c0104a49:	74 19                	je     c0104a64 <basic_check+0x262>
c0104a4b:	68 fe 6b 10 c0       	push   $0xc0106bfe
c0104a50:	68 76 6a 10 c0       	push   $0xc0106a76
c0104a55:	68 d7 00 00 00       	push   $0xd7
c0104a5a:	68 8b 6a 10 c0       	push   $0xc0106a8b
c0104a5f:	e8 a6 b9 ff ff       	call   c010040a <__panic>

    free_page(p0);
c0104a64:	83 ec 08             	sub    $0x8,%esp
c0104a67:	6a 01                	push   $0x1
c0104a69:	ff 75 ec             	pushl  -0x14(%ebp)
c0104a6c:	e8 b6 e2 ff ff       	call   c0102d27 <free_pages>
c0104a71:	83 c4 10             	add    $0x10,%esp
    free_page(p1);
c0104a74:	83 ec 08             	sub    $0x8,%esp
c0104a77:	6a 01                	push   $0x1
c0104a79:	ff 75 f0             	pushl  -0x10(%ebp)
c0104a7c:	e8 a6 e2 ff ff       	call   c0102d27 <free_pages>
c0104a81:	83 c4 10             	add    $0x10,%esp
    free_page(p2);
c0104a84:	83 ec 08             	sub    $0x8,%esp
c0104a87:	6a 01                	push   $0x1
c0104a89:	ff 75 f4             	pushl  -0xc(%ebp)
c0104a8c:	e8 96 e2 ff ff       	call   c0102d27 <free_pages>
c0104a91:	83 c4 10             	add    $0x10,%esp
    assert(nr_free == 3);
c0104a94:	a1 64 a9 11 c0       	mov    0xc011a964,%eax
c0104a99:	83 f8 03             	cmp    $0x3,%eax
c0104a9c:	74 19                	je     c0104ab7 <basic_check+0x2b5>
c0104a9e:	68 13 6c 10 c0       	push   $0xc0106c13
c0104aa3:	68 76 6a 10 c0       	push   $0xc0106a76
c0104aa8:	68 dc 00 00 00       	push   $0xdc
c0104aad:	68 8b 6a 10 c0       	push   $0xc0106a8b
c0104ab2:	e8 53 b9 ff ff       	call   c010040a <__panic>

    assert((p0 = alloc_page()) != NULL);
c0104ab7:	83 ec 0c             	sub    $0xc,%esp
c0104aba:	6a 01                	push   $0x1
c0104abc:	e8 24 e2 ff ff       	call   c0102ce5 <alloc_pages>
c0104ac1:	83 c4 10             	add    $0x10,%esp
c0104ac4:	89 45 ec             	mov    %eax,-0x14(%ebp)
c0104ac7:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
c0104acb:	75 19                	jne    c0104ae6 <basic_check+0x2e4>
c0104acd:	68 d9 6a 10 c0       	push   $0xc0106ad9
c0104ad2:	68 76 6a 10 c0       	push   $0xc0106a76
c0104ad7:	68 de 00 00 00       	push   $0xde
c0104adc:	68 8b 6a 10 c0       	push   $0xc0106a8b
c0104ae1:	e8 24 b9 ff ff       	call   c010040a <__panic>
    assert((p1 = alloc_page()) != NULL);
c0104ae6:	83 ec 0c             	sub    $0xc,%esp
c0104ae9:	6a 01                	push   $0x1
c0104aeb:	e8 f5 e1 ff ff       	call   c0102ce5 <alloc_pages>
c0104af0:	83 c4 10             	add    $0x10,%esp
c0104af3:	89 45 f0             	mov    %eax,-0x10(%ebp)
c0104af6:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
c0104afa:	75 19                	jne    c0104b15 <basic_check+0x313>
c0104afc:	68 f5 6a 10 c0       	push   $0xc0106af5
c0104b01:	68 76 6a 10 c0       	push   $0xc0106a76
c0104b06:	68 df 00 00 00       	push   $0xdf
c0104b0b:	68 8b 6a 10 c0       	push   $0xc0106a8b
c0104b10:	e8 f5 b8 ff ff       	call   c010040a <__panic>
    assert((p2 = alloc_page()) != NULL);
c0104b15:	83 ec 0c             	sub    $0xc,%esp
c0104b18:	6a 01                	push   $0x1
c0104b1a:	e8 c6 e1 ff ff       	call   c0102ce5 <alloc_pages>
c0104b1f:	83 c4 10             	add    $0x10,%esp
c0104b22:	89 45 f4             	mov    %eax,-0xc(%ebp)
c0104b25:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
c0104b29:	75 19                	jne    c0104b44 <basic_check+0x342>
c0104b2b:	68 11 6b 10 c0       	push   $0xc0106b11
c0104b30:	68 76 6a 10 c0       	push   $0xc0106a76
c0104b35:	68 e0 00 00 00       	push   $0xe0
c0104b3a:	68 8b 6a 10 c0       	push   $0xc0106a8b
c0104b3f:	e8 c6 b8 ff ff       	call   c010040a <__panic>

    assert(alloc_page() == NULL);
c0104b44:	83 ec 0c             	sub    $0xc,%esp
c0104b47:	6a 01                	push   $0x1
c0104b49:	e8 97 e1 ff ff       	call   c0102ce5 <alloc_pages>
c0104b4e:	83 c4 10             	add    $0x10,%esp
c0104b51:	85 c0                	test   %eax,%eax
c0104b53:	74 19                	je     c0104b6e <basic_check+0x36c>
c0104b55:	68 fe 6b 10 c0       	push   $0xc0106bfe
c0104b5a:	68 76 6a 10 c0       	push   $0xc0106a76
c0104b5f:	68 e2 00 00 00       	push   $0xe2
c0104b64:	68 8b 6a 10 c0       	push   $0xc0106a8b
c0104b69:	e8 9c b8 ff ff       	call   c010040a <__panic>

    free_page(p0);
c0104b6e:	83 ec 08             	sub    $0x8,%esp
c0104b71:	6a 01                	push   $0x1
c0104b73:	ff 75 ec             	pushl  -0x14(%ebp)
c0104b76:	e8 ac e1 ff ff       	call   c0102d27 <free_pages>
c0104b7b:	83 c4 10             	add    $0x10,%esp
c0104b7e:	c7 45 d8 5c a9 11 c0 	movl   $0xc011a95c,-0x28(%ebp)
c0104b85:	8b 45 d8             	mov    -0x28(%ebp),%eax
c0104b88:	8b 40 04             	mov    0x4(%eax),%eax
c0104b8b:	39 45 d8             	cmp    %eax,-0x28(%ebp)
c0104b8e:	0f 94 c0             	sete   %al
c0104b91:	0f b6 c0             	movzbl %al,%eax
    assert(!list_empty(&free_list));
c0104b94:	85 c0                	test   %eax,%eax
c0104b96:	74 19                	je     c0104bb1 <basic_check+0x3af>
c0104b98:	68 20 6c 10 c0       	push   $0xc0106c20
c0104b9d:	68 76 6a 10 c0       	push   $0xc0106a76
c0104ba2:	68 e5 00 00 00       	push   $0xe5
c0104ba7:	68 8b 6a 10 c0       	push   $0xc0106a8b
c0104bac:	e8 59 b8 ff ff       	call   c010040a <__panic>

    struct Page *p;
    assert((p = alloc_page()) == p0);
c0104bb1:	83 ec 0c             	sub    $0xc,%esp
c0104bb4:	6a 01                	push   $0x1
c0104bb6:	e8 2a e1 ff ff       	call   c0102ce5 <alloc_pages>
c0104bbb:	83 c4 10             	add    $0x10,%esp
c0104bbe:	89 45 e4             	mov    %eax,-0x1c(%ebp)
c0104bc1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c0104bc4:	3b 45 ec             	cmp    -0x14(%ebp),%eax
c0104bc7:	74 19                	je     c0104be2 <basic_check+0x3e0>
c0104bc9:	68 38 6c 10 c0       	push   $0xc0106c38
c0104bce:	68 76 6a 10 c0       	push   $0xc0106a76
c0104bd3:	68 e8 00 00 00       	push   $0xe8
c0104bd8:	68 8b 6a 10 c0       	push   $0xc0106a8b
c0104bdd:	e8 28 b8 ff ff       	call   c010040a <__panic>
    assert(alloc_page() == NULL);
c0104be2:	83 ec 0c             	sub    $0xc,%esp
c0104be5:	6a 01                	push   $0x1
c0104be7:	e8 f9 e0 ff ff       	call   c0102ce5 <alloc_pages>
c0104bec:	83 c4 10             	add    $0x10,%esp
c0104bef:	85 c0                	test   %eax,%eax
c0104bf1:	74 19                	je     c0104c0c <basic_check+0x40a>
c0104bf3:	68 fe 6b 10 c0       	push   $0xc0106bfe
c0104bf8:	68 76 6a 10 c0       	push   $0xc0106a76
c0104bfd:	68 e9 00 00 00       	push   $0xe9
c0104c02:	68 8b 6a 10 c0       	push   $0xc0106a8b
c0104c07:	e8 fe b7 ff ff       	call   c010040a <__panic>

    assert(nr_free == 0);
c0104c0c:	a1 64 a9 11 c0       	mov    0xc011a964,%eax
c0104c11:	85 c0                	test   %eax,%eax
c0104c13:	74 19                	je     c0104c2e <basic_check+0x42c>
c0104c15:	68 51 6c 10 c0       	push   $0xc0106c51
c0104c1a:	68 76 6a 10 c0       	push   $0xc0106a76
c0104c1f:	68 eb 00 00 00       	push   $0xeb
c0104c24:	68 8b 6a 10 c0       	push   $0xc0106a8b
c0104c29:	e8 dc b7 ff ff       	call   c010040a <__panic>
    free_list = free_list_store;
c0104c2e:	8b 45 d0             	mov    -0x30(%ebp),%eax
c0104c31:	8b 55 d4             	mov    -0x2c(%ebp),%edx
c0104c34:	a3 5c a9 11 c0       	mov    %eax,0xc011a95c
c0104c39:	89 15 60 a9 11 c0    	mov    %edx,0xc011a960
    nr_free = nr_free_store;
c0104c3f:	8b 45 e8             	mov    -0x18(%ebp),%eax
c0104c42:	a3 64 a9 11 c0       	mov    %eax,0xc011a964

    free_page(p);
c0104c47:	83 ec 08             	sub    $0x8,%esp
c0104c4a:	6a 01                	push   $0x1
c0104c4c:	ff 75 e4             	pushl  -0x1c(%ebp)
c0104c4f:	e8 d3 e0 ff ff       	call   c0102d27 <free_pages>
c0104c54:	83 c4 10             	add    $0x10,%esp
    free_page(p1);
c0104c57:	83 ec 08             	sub    $0x8,%esp
c0104c5a:	6a 01                	push   $0x1
c0104c5c:	ff 75 f0             	pushl  -0x10(%ebp)
c0104c5f:	e8 c3 e0 ff ff       	call   c0102d27 <free_pages>
c0104c64:	83 c4 10             	add    $0x10,%esp
    free_page(p2);
c0104c67:	83 ec 08             	sub    $0x8,%esp
c0104c6a:	6a 01                	push   $0x1
c0104c6c:	ff 75 f4             	pushl  -0xc(%ebp)
c0104c6f:	e8 b3 e0 ff ff       	call   c0102d27 <free_pages>
c0104c74:	83 c4 10             	add    $0x10,%esp
}
c0104c77:	90                   	nop
c0104c78:	c9                   	leave  
c0104c79:	c3                   	ret    

c0104c7a <default_check>:

// LAB2: below code is used to check the first fit allocation algorithm (your EXERCISE 1) 
// NOTICE: You SHOULD NOT CHANGE basic_check, default_check functions!
static void
default_check(void) {
c0104c7a:	f3 0f 1e fb          	endbr32 
c0104c7e:	55                   	push   %ebp
c0104c7f:	89 e5                	mov    %esp,%ebp
c0104c81:	81 ec 88 00 00 00    	sub    $0x88,%esp
    int count = 0, total = 0;
c0104c87:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
c0104c8e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    list_entry_t *le = &free_list;
c0104c95:	c7 45 ec 5c a9 11 c0 	movl   $0xc011a95c,-0x14(%ebp)
    while ((le = list_next(le)) != &free_list) {
c0104c9c:	eb 60                	jmp    c0104cfe <default_check+0x84>
        struct Page *p = le2page(le, page_link);
c0104c9e:	8b 45 ec             	mov    -0x14(%ebp),%eax
c0104ca1:	83 e8 0c             	sub    $0xc,%eax
c0104ca4:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        assert(PageProperty(p));
c0104ca7:	8b 45 d4             	mov    -0x2c(%ebp),%eax
c0104caa:	83 c0 04             	add    $0x4,%eax
c0104cad:	c7 45 d0 01 00 00 00 	movl   $0x1,-0x30(%ebp)
c0104cb4:	89 45 cc             	mov    %eax,-0x34(%ebp)
    asm volatile ("btl %2, %1; sbbl %0,%0" : "=r" (oldbit) : "m" (*(volatile long *)addr), "Ir" (nr));
c0104cb7:	8b 45 cc             	mov    -0x34(%ebp),%eax
c0104cba:	8b 55 d0             	mov    -0x30(%ebp),%edx
c0104cbd:	0f a3 10             	bt     %edx,(%eax)
c0104cc0:	19 c0                	sbb    %eax,%eax
c0104cc2:	89 45 c8             	mov    %eax,-0x38(%ebp)
    return oldbit != 0;
c0104cc5:	83 7d c8 00          	cmpl   $0x0,-0x38(%ebp)
c0104cc9:	0f 95 c0             	setne  %al
c0104ccc:	0f b6 c0             	movzbl %al,%eax
c0104ccf:	85 c0                	test   %eax,%eax
c0104cd1:	75 19                	jne    c0104cec <default_check+0x72>
c0104cd3:	68 5e 6c 10 c0       	push   $0xc0106c5e
c0104cd8:	68 76 6a 10 c0       	push   $0xc0106a76
c0104cdd:	68 fc 00 00 00       	push   $0xfc
c0104ce2:	68 8b 6a 10 c0       	push   $0xc0106a8b
c0104ce7:	e8 1e b7 ff ff       	call   c010040a <__panic>
        count ++, total += p->property;
c0104cec:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
c0104cf0:	8b 45 d4             	mov    -0x2c(%ebp),%eax
c0104cf3:	8b 50 08             	mov    0x8(%eax),%edx
c0104cf6:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0104cf9:	01 d0                	add    %edx,%eax
c0104cfb:	89 45 f0             	mov    %eax,-0x10(%ebp)
c0104cfe:	8b 45 ec             	mov    -0x14(%ebp),%eax
c0104d01:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    return listelm->next;
c0104d04:	8b 45 c4             	mov    -0x3c(%ebp),%eax
c0104d07:	8b 40 04             	mov    0x4(%eax),%eax
    while ((le = list_next(le)) != &free_list) {
c0104d0a:	89 45 ec             	mov    %eax,-0x14(%ebp)
c0104d0d:	81 7d ec 5c a9 11 c0 	cmpl   $0xc011a95c,-0x14(%ebp)
c0104d14:	75 88                	jne    c0104c9e <default_check+0x24>
    }
    assert(total == nr_free_pages());
c0104d16:	e8 45 e0 ff ff       	call   c0102d60 <nr_free_pages>
c0104d1b:	8b 55 f0             	mov    -0x10(%ebp),%edx
c0104d1e:	39 d0                	cmp    %edx,%eax
c0104d20:	74 19                	je     c0104d3b <default_check+0xc1>
c0104d22:	68 6e 6c 10 c0       	push   $0xc0106c6e
c0104d27:	68 76 6a 10 c0       	push   $0xc0106a76
c0104d2c:	68 ff 00 00 00       	push   $0xff
c0104d31:	68 8b 6a 10 c0       	push   $0xc0106a8b
c0104d36:	e8 cf b6 ff ff       	call   c010040a <__panic>

    basic_check();
c0104d3b:	e8 c2 fa ff ff       	call   c0104802 <basic_check>

    struct Page *p0 = alloc_pages(5), *p1, *p2;
c0104d40:	83 ec 0c             	sub    $0xc,%esp
c0104d43:	6a 05                	push   $0x5
c0104d45:	e8 9b df ff ff       	call   c0102ce5 <alloc_pages>
c0104d4a:	83 c4 10             	add    $0x10,%esp
c0104d4d:	89 45 e8             	mov    %eax,-0x18(%ebp)
    assert(p0 != NULL);
c0104d50:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
c0104d54:	75 19                	jne    c0104d6f <default_check+0xf5>
c0104d56:	68 87 6c 10 c0       	push   $0xc0106c87
c0104d5b:	68 76 6a 10 c0       	push   $0xc0106a76
c0104d60:	68 04 01 00 00       	push   $0x104
c0104d65:	68 8b 6a 10 c0       	push   $0xc0106a8b
c0104d6a:	e8 9b b6 ff ff       	call   c010040a <__panic>
    assert(!PageProperty(p0));
c0104d6f:	8b 45 e8             	mov    -0x18(%ebp),%eax
c0104d72:	83 c0 04             	add    $0x4,%eax
c0104d75:	c7 45 c0 01 00 00 00 	movl   $0x1,-0x40(%ebp)
c0104d7c:	89 45 bc             	mov    %eax,-0x44(%ebp)
    asm volatile ("btl %2, %1; sbbl %0,%0" : "=r" (oldbit) : "m" (*(volatile long *)addr), "Ir" (nr));
c0104d7f:	8b 45 bc             	mov    -0x44(%ebp),%eax
c0104d82:	8b 55 c0             	mov    -0x40(%ebp),%edx
c0104d85:	0f a3 10             	bt     %edx,(%eax)
c0104d88:	19 c0                	sbb    %eax,%eax
c0104d8a:	89 45 b8             	mov    %eax,-0x48(%ebp)
    return oldbit != 0;
c0104d8d:	83 7d b8 00          	cmpl   $0x0,-0x48(%ebp)
c0104d91:	0f 95 c0             	setne  %al
c0104d94:	0f b6 c0             	movzbl %al,%eax
c0104d97:	85 c0                	test   %eax,%eax
c0104d99:	74 19                	je     c0104db4 <default_check+0x13a>
c0104d9b:	68 92 6c 10 c0       	push   $0xc0106c92
c0104da0:	68 76 6a 10 c0       	push   $0xc0106a76
c0104da5:	68 05 01 00 00       	push   $0x105
c0104daa:	68 8b 6a 10 c0       	push   $0xc0106a8b
c0104daf:	e8 56 b6 ff ff       	call   c010040a <__panic>

    list_entry_t free_list_store = free_list;
c0104db4:	a1 5c a9 11 c0       	mov    0xc011a95c,%eax
c0104db9:	8b 15 60 a9 11 c0    	mov    0xc011a960,%edx
c0104dbf:	89 45 80             	mov    %eax,-0x80(%ebp)
c0104dc2:	89 55 84             	mov    %edx,-0x7c(%ebp)
c0104dc5:	c7 45 b0 5c a9 11 c0 	movl   $0xc011a95c,-0x50(%ebp)
    elm->prev = elm->next = elm;
c0104dcc:	8b 45 b0             	mov    -0x50(%ebp),%eax
c0104dcf:	8b 55 b0             	mov    -0x50(%ebp),%edx
c0104dd2:	89 50 04             	mov    %edx,0x4(%eax)
c0104dd5:	8b 45 b0             	mov    -0x50(%ebp),%eax
c0104dd8:	8b 50 04             	mov    0x4(%eax),%edx
c0104ddb:	8b 45 b0             	mov    -0x50(%ebp),%eax
c0104dde:	89 10                	mov    %edx,(%eax)
}
c0104de0:	90                   	nop
c0104de1:	c7 45 b4 5c a9 11 c0 	movl   $0xc011a95c,-0x4c(%ebp)
    return list->next == list;
c0104de8:	8b 45 b4             	mov    -0x4c(%ebp),%eax
c0104deb:	8b 40 04             	mov    0x4(%eax),%eax
c0104dee:	39 45 b4             	cmp    %eax,-0x4c(%ebp)
c0104df1:	0f 94 c0             	sete   %al
c0104df4:	0f b6 c0             	movzbl %al,%eax
    list_init(&free_list);
    assert(list_empty(&free_list));
c0104df7:	85 c0                	test   %eax,%eax
c0104df9:	75 19                	jne    c0104e14 <default_check+0x19a>
c0104dfb:	68 e7 6b 10 c0       	push   $0xc0106be7
c0104e00:	68 76 6a 10 c0       	push   $0xc0106a76
c0104e05:	68 09 01 00 00       	push   $0x109
c0104e0a:	68 8b 6a 10 c0       	push   $0xc0106a8b
c0104e0f:	e8 f6 b5 ff ff       	call   c010040a <__panic>
    assert(alloc_page() == NULL);
c0104e14:	83 ec 0c             	sub    $0xc,%esp
c0104e17:	6a 01                	push   $0x1
c0104e19:	e8 c7 de ff ff       	call   c0102ce5 <alloc_pages>
c0104e1e:	83 c4 10             	add    $0x10,%esp
c0104e21:	85 c0                	test   %eax,%eax
c0104e23:	74 19                	je     c0104e3e <default_check+0x1c4>
c0104e25:	68 fe 6b 10 c0       	push   $0xc0106bfe
c0104e2a:	68 76 6a 10 c0       	push   $0xc0106a76
c0104e2f:	68 0a 01 00 00       	push   $0x10a
c0104e34:	68 8b 6a 10 c0       	push   $0xc0106a8b
c0104e39:	e8 cc b5 ff ff       	call   c010040a <__panic>

    unsigned int nr_free_store = nr_free;
c0104e3e:	a1 64 a9 11 c0       	mov    0xc011a964,%eax
c0104e43:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    nr_free = 0;
c0104e46:	c7 05 64 a9 11 c0 00 	movl   $0x0,0xc011a964
c0104e4d:	00 00 00 

    free_pages(p0 + 2, 3);
c0104e50:	8b 45 e8             	mov    -0x18(%ebp),%eax
c0104e53:	83 c0 28             	add    $0x28,%eax
c0104e56:	83 ec 08             	sub    $0x8,%esp
c0104e59:	6a 03                	push   $0x3
c0104e5b:	50                   	push   %eax
c0104e5c:	e8 c6 de ff ff       	call   c0102d27 <free_pages>
c0104e61:	83 c4 10             	add    $0x10,%esp
    assert(alloc_pages(4) == NULL);
c0104e64:	83 ec 0c             	sub    $0xc,%esp
c0104e67:	6a 04                	push   $0x4
c0104e69:	e8 77 de ff ff       	call   c0102ce5 <alloc_pages>
c0104e6e:	83 c4 10             	add    $0x10,%esp
c0104e71:	85 c0                	test   %eax,%eax
c0104e73:	74 19                	je     c0104e8e <default_check+0x214>
c0104e75:	68 a4 6c 10 c0       	push   $0xc0106ca4
c0104e7a:	68 76 6a 10 c0       	push   $0xc0106a76
c0104e7f:	68 10 01 00 00       	push   $0x110
c0104e84:	68 8b 6a 10 c0       	push   $0xc0106a8b
c0104e89:	e8 7c b5 ff ff       	call   c010040a <__panic>
    assert(PageProperty(p0 + 2) && p0[2].property == 3);
c0104e8e:	8b 45 e8             	mov    -0x18(%ebp),%eax
c0104e91:	83 c0 28             	add    $0x28,%eax
c0104e94:	83 c0 04             	add    $0x4,%eax
c0104e97:	c7 45 ac 01 00 00 00 	movl   $0x1,-0x54(%ebp)
c0104e9e:	89 45 a8             	mov    %eax,-0x58(%ebp)
    asm volatile ("btl %2, %1; sbbl %0,%0" : "=r" (oldbit) : "m" (*(volatile long *)addr), "Ir" (nr));
c0104ea1:	8b 45 a8             	mov    -0x58(%ebp),%eax
c0104ea4:	8b 55 ac             	mov    -0x54(%ebp),%edx
c0104ea7:	0f a3 10             	bt     %edx,(%eax)
c0104eaa:	19 c0                	sbb    %eax,%eax
c0104eac:	89 45 a4             	mov    %eax,-0x5c(%ebp)
    return oldbit != 0;
c0104eaf:	83 7d a4 00          	cmpl   $0x0,-0x5c(%ebp)
c0104eb3:	0f 95 c0             	setne  %al
c0104eb6:	0f b6 c0             	movzbl %al,%eax
c0104eb9:	85 c0                	test   %eax,%eax
c0104ebb:	74 0e                	je     c0104ecb <default_check+0x251>
c0104ebd:	8b 45 e8             	mov    -0x18(%ebp),%eax
c0104ec0:	83 c0 28             	add    $0x28,%eax
c0104ec3:	8b 40 08             	mov    0x8(%eax),%eax
c0104ec6:	83 f8 03             	cmp    $0x3,%eax
c0104ec9:	74 19                	je     c0104ee4 <default_check+0x26a>
c0104ecb:	68 bc 6c 10 c0       	push   $0xc0106cbc
c0104ed0:	68 76 6a 10 c0       	push   $0xc0106a76
c0104ed5:	68 11 01 00 00       	push   $0x111
c0104eda:	68 8b 6a 10 c0       	push   $0xc0106a8b
c0104edf:	e8 26 b5 ff ff       	call   c010040a <__panic>
    assert((p1 = alloc_pages(3)) != NULL);
c0104ee4:	83 ec 0c             	sub    $0xc,%esp
c0104ee7:	6a 03                	push   $0x3
c0104ee9:	e8 f7 dd ff ff       	call   c0102ce5 <alloc_pages>
c0104eee:	83 c4 10             	add    $0x10,%esp
c0104ef1:	89 45 e0             	mov    %eax,-0x20(%ebp)
c0104ef4:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
c0104ef8:	75 19                	jne    c0104f13 <default_check+0x299>
c0104efa:	68 e8 6c 10 c0       	push   $0xc0106ce8
c0104eff:	68 76 6a 10 c0       	push   $0xc0106a76
c0104f04:	68 12 01 00 00       	push   $0x112
c0104f09:	68 8b 6a 10 c0       	push   $0xc0106a8b
c0104f0e:	e8 f7 b4 ff ff       	call   c010040a <__panic>
    assert(alloc_page() == NULL);
c0104f13:	83 ec 0c             	sub    $0xc,%esp
c0104f16:	6a 01                	push   $0x1
c0104f18:	e8 c8 dd ff ff       	call   c0102ce5 <alloc_pages>
c0104f1d:	83 c4 10             	add    $0x10,%esp
c0104f20:	85 c0                	test   %eax,%eax
c0104f22:	74 19                	je     c0104f3d <default_check+0x2c3>
c0104f24:	68 fe 6b 10 c0       	push   $0xc0106bfe
c0104f29:	68 76 6a 10 c0       	push   $0xc0106a76
c0104f2e:	68 13 01 00 00       	push   $0x113
c0104f33:	68 8b 6a 10 c0       	push   $0xc0106a8b
c0104f38:	e8 cd b4 ff ff       	call   c010040a <__panic>
    assert(p0 + 2 == p1);
c0104f3d:	8b 45 e8             	mov    -0x18(%ebp),%eax
c0104f40:	83 c0 28             	add    $0x28,%eax
c0104f43:	39 45 e0             	cmp    %eax,-0x20(%ebp)
c0104f46:	74 19                	je     c0104f61 <default_check+0x2e7>
c0104f48:	68 06 6d 10 c0       	push   $0xc0106d06
c0104f4d:	68 76 6a 10 c0       	push   $0xc0106a76
c0104f52:	68 14 01 00 00       	push   $0x114
c0104f57:	68 8b 6a 10 c0       	push   $0xc0106a8b
c0104f5c:	e8 a9 b4 ff ff       	call   c010040a <__panic>

    p2 = p0 + 1;
c0104f61:	8b 45 e8             	mov    -0x18(%ebp),%eax
c0104f64:	83 c0 14             	add    $0x14,%eax
c0104f67:	89 45 dc             	mov    %eax,-0x24(%ebp)
    free_page(p0);
c0104f6a:	83 ec 08             	sub    $0x8,%esp
c0104f6d:	6a 01                	push   $0x1
c0104f6f:	ff 75 e8             	pushl  -0x18(%ebp)
c0104f72:	e8 b0 dd ff ff       	call   c0102d27 <free_pages>
c0104f77:	83 c4 10             	add    $0x10,%esp
    free_pages(p1, 3);
c0104f7a:	83 ec 08             	sub    $0x8,%esp
c0104f7d:	6a 03                	push   $0x3
c0104f7f:	ff 75 e0             	pushl  -0x20(%ebp)
c0104f82:	e8 a0 dd ff ff       	call   c0102d27 <free_pages>
c0104f87:	83 c4 10             	add    $0x10,%esp
    assert(PageProperty(p0) && p0->property == 1);
c0104f8a:	8b 45 e8             	mov    -0x18(%ebp),%eax
c0104f8d:	83 c0 04             	add    $0x4,%eax
c0104f90:	c7 45 a0 01 00 00 00 	movl   $0x1,-0x60(%ebp)
c0104f97:	89 45 9c             	mov    %eax,-0x64(%ebp)
    asm volatile ("btl %2, %1; sbbl %0,%0" : "=r" (oldbit) : "m" (*(volatile long *)addr), "Ir" (nr));
c0104f9a:	8b 45 9c             	mov    -0x64(%ebp),%eax
c0104f9d:	8b 55 a0             	mov    -0x60(%ebp),%edx
c0104fa0:	0f a3 10             	bt     %edx,(%eax)
c0104fa3:	19 c0                	sbb    %eax,%eax
c0104fa5:	89 45 98             	mov    %eax,-0x68(%ebp)
    return oldbit != 0;
c0104fa8:	83 7d 98 00          	cmpl   $0x0,-0x68(%ebp)
c0104fac:	0f 95 c0             	setne  %al
c0104faf:	0f b6 c0             	movzbl %al,%eax
c0104fb2:	85 c0                	test   %eax,%eax
c0104fb4:	74 0b                	je     c0104fc1 <default_check+0x347>
c0104fb6:	8b 45 e8             	mov    -0x18(%ebp),%eax
c0104fb9:	8b 40 08             	mov    0x8(%eax),%eax
c0104fbc:	83 f8 01             	cmp    $0x1,%eax
c0104fbf:	74 19                	je     c0104fda <default_check+0x360>
c0104fc1:	68 14 6d 10 c0       	push   $0xc0106d14
c0104fc6:	68 76 6a 10 c0       	push   $0xc0106a76
c0104fcb:	68 19 01 00 00       	push   $0x119
c0104fd0:	68 8b 6a 10 c0       	push   $0xc0106a8b
c0104fd5:	e8 30 b4 ff ff       	call   c010040a <__panic>
    assert(PageProperty(p1) && p1->property == 3);
c0104fda:	8b 45 e0             	mov    -0x20(%ebp),%eax
c0104fdd:	83 c0 04             	add    $0x4,%eax
c0104fe0:	c7 45 94 01 00 00 00 	movl   $0x1,-0x6c(%ebp)
c0104fe7:	89 45 90             	mov    %eax,-0x70(%ebp)
    asm volatile ("btl %2, %1; sbbl %0,%0" : "=r" (oldbit) : "m" (*(volatile long *)addr), "Ir" (nr));
c0104fea:	8b 45 90             	mov    -0x70(%ebp),%eax
c0104fed:	8b 55 94             	mov    -0x6c(%ebp),%edx
c0104ff0:	0f a3 10             	bt     %edx,(%eax)
c0104ff3:	19 c0                	sbb    %eax,%eax
c0104ff5:	89 45 8c             	mov    %eax,-0x74(%ebp)
    return oldbit != 0;
c0104ff8:	83 7d 8c 00          	cmpl   $0x0,-0x74(%ebp)
c0104ffc:	0f 95 c0             	setne  %al
c0104fff:	0f b6 c0             	movzbl %al,%eax
c0105002:	85 c0                	test   %eax,%eax
c0105004:	74 0b                	je     c0105011 <default_check+0x397>
c0105006:	8b 45 e0             	mov    -0x20(%ebp),%eax
c0105009:	8b 40 08             	mov    0x8(%eax),%eax
c010500c:	83 f8 03             	cmp    $0x3,%eax
c010500f:	74 19                	je     c010502a <default_check+0x3b0>
c0105011:	68 3c 6d 10 c0       	push   $0xc0106d3c
c0105016:	68 76 6a 10 c0       	push   $0xc0106a76
c010501b:	68 1a 01 00 00       	push   $0x11a
c0105020:	68 8b 6a 10 c0       	push   $0xc0106a8b
c0105025:	e8 e0 b3 ff ff       	call   c010040a <__panic>

    assert((p0 = alloc_page()) == p2 - 1);
c010502a:	83 ec 0c             	sub    $0xc,%esp
c010502d:	6a 01                	push   $0x1
c010502f:	e8 b1 dc ff ff       	call   c0102ce5 <alloc_pages>
c0105034:	83 c4 10             	add    $0x10,%esp
c0105037:	89 45 e8             	mov    %eax,-0x18(%ebp)
c010503a:	8b 45 dc             	mov    -0x24(%ebp),%eax
c010503d:	83 e8 14             	sub    $0x14,%eax
c0105040:	39 45 e8             	cmp    %eax,-0x18(%ebp)
c0105043:	74 19                	je     c010505e <default_check+0x3e4>
c0105045:	68 62 6d 10 c0       	push   $0xc0106d62
c010504a:	68 76 6a 10 c0       	push   $0xc0106a76
c010504f:	68 1c 01 00 00       	push   $0x11c
c0105054:	68 8b 6a 10 c0       	push   $0xc0106a8b
c0105059:	e8 ac b3 ff ff       	call   c010040a <__panic>
    free_page(p0);
c010505e:	83 ec 08             	sub    $0x8,%esp
c0105061:	6a 01                	push   $0x1
c0105063:	ff 75 e8             	pushl  -0x18(%ebp)
c0105066:	e8 bc dc ff ff       	call   c0102d27 <free_pages>
c010506b:	83 c4 10             	add    $0x10,%esp
    assert((p0 = alloc_pages(2)) == p2 + 1);
c010506e:	83 ec 0c             	sub    $0xc,%esp
c0105071:	6a 02                	push   $0x2
c0105073:	e8 6d dc ff ff       	call   c0102ce5 <alloc_pages>
c0105078:	83 c4 10             	add    $0x10,%esp
c010507b:	89 45 e8             	mov    %eax,-0x18(%ebp)
c010507e:	8b 45 dc             	mov    -0x24(%ebp),%eax
c0105081:	83 c0 14             	add    $0x14,%eax
c0105084:	39 45 e8             	cmp    %eax,-0x18(%ebp)
c0105087:	74 19                	je     c01050a2 <default_check+0x428>
c0105089:	68 80 6d 10 c0       	push   $0xc0106d80
c010508e:	68 76 6a 10 c0       	push   $0xc0106a76
c0105093:	68 1e 01 00 00       	push   $0x11e
c0105098:	68 8b 6a 10 c0       	push   $0xc0106a8b
c010509d:	e8 68 b3 ff ff       	call   c010040a <__panic>

    free_pages(p0, 2);
c01050a2:	83 ec 08             	sub    $0x8,%esp
c01050a5:	6a 02                	push   $0x2
c01050a7:	ff 75 e8             	pushl  -0x18(%ebp)
c01050aa:	e8 78 dc ff ff       	call   c0102d27 <free_pages>
c01050af:	83 c4 10             	add    $0x10,%esp
    free_page(p2);
c01050b2:	83 ec 08             	sub    $0x8,%esp
c01050b5:	6a 01                	push   $0x1
c01050b7:	ff 75 dc             	pushl  -0x24(%ebp)
c01050ba:	e8 68 dc ff ff       	call   c0102d27 <free_pages>
c01050bf:	83 c4 10             	add    $0x10,%esp

    assert((p0 = alloc_pages(5)) != NULL);
c01050c2:	83 ec 0c             	sub    $0xc,%esp
c01050c5:	6a 05                	push   $0x5
c01050c7:	e8 19 dc ff ff       	call   c0102ce5 <alloc_pages>
c01050cc:	83 c4 10             	add    $0x10,%esp
c01050cf:	89 45 e8             	mov    %eax,-0x18(%ebp)
c01050d2:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
c01050d6:	75 19                	jne    c01050f1 <default_check+0x477>
c01050d8:	68 a0 6d 10 c0       	push   $0xc0106da0
c01050dd:	68 76 6a 10 c0       	push   $0xc0106a76
c01050e2:	68 23 01 00 00       	push   $0x123
c01050e7:	68 8b 6a 10 c0       	push   $0xc0106a8b
c01050ec:	e8 19 b3 ff ff       	call   c010040a <__panic>
    assert(alloc_page() == NULL);
c01050f1:	83 ec 0c             	sub    $0xc,%esp
c01050f4:	6a 01                	push   $0x1
c01050f6:	e8 ea db ff ff       	call   c0102ce5 <alloc_pages>
c01050fb:	83 c4 10             	add    $0x10,%esp
c01050fe:	85 c0                	test   %eax,%eax
c0105100:	74 19                	je     c010511b <default_check+0x4a1>
c0105102:	68 fe 6b 10 c0       	push   $0xc0106bfe
c0105107:	68 76 6a 10 c0       	push   $0xc0106a76
c010510c:	68 24 01 00 00       	push   $0x124
c0105111:	68 8b 6a 10 c0       	push   $0xc0106a8b
c0105116:	e8 ef b2 ff ff       	call   c010040a <__panic>

    assert(nr_free == 0);
c010511b:	a1 64 a9 11 c0       	mov    0xc011a964,%eax
c0105120:	85 c0                	test   %eax,%eax
c0105122:	74 19                	je     c010513d <default_check+0x4c3>
c0105124:	68 51 6c 10 c0       	push   $0xc0106c51
c0105129:	68 76 6a 10 c0       	push   $0xc0106a76
c010512e:	68 26 01 00 00       	push   $0x126
c0105133:	68 8b 6a 10 c0       	push   $0xc0106a8b
c0105138:	e8 cd b2 ff ff       	call   c010040a <__panic>
    nr_free = nr_free_store;
c010513d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c0105140:	a3 64 a9 11 c0       	mov    %eax,0xc011a964

    free_list = free_list_store;
c0105145:	8b 45 80             	mov    -0x80(%ebp),%eax
c0105148:	8b 55 84             	mov    -0x7c(%ebp),%edx
c010514b:	a3 5c a9 11 c0       	mov    %eax,0xc011a95c
c0105150:	89 15 60 a9 11 c0    	mov    %edx,0xc011a960
    free_pages(p0, 5);
c0105156:	83 ec 08             	sub    $0x8,%esp
c0105159:	6a 05                	push   $0x5
c010515b:	ff 75 e8             	pushl  -0x18(%ebp)
c010515e:	e8 c4 db ff ff       	call   c0102d27 <free_pages>
c0105163:	83 c4 10             	add    $0x10,%esp

    le = &free_list;
c0105166:	c7 45 ec 5c a9 11 c0 	movl   $0xc011a95c,-0x14(%ebp)
    while ((le = list_next(le)) != &free_list) {
c010516d:	eb 1d                	jmp    c010518c <default_check+0x512>
        struct Page *p = le2page(le, page_link);
c010516f:	8b 45 ec             	mov    -0x14(%ebp),%eax
c0105172:	83 e8 0c             	sub    $0xc,%eax
c0105175:	89 45 d8             	mov    %eax,-0x28(%ebp)
        count --, total -= p->property;
c0105178:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
c010517c:	8b 55 f0             	mov    -0x10(%ebp),%edx
c010517f:	8b 45 d8             	mov    -0x28(%ebp),%eax
c0105182:	8b 40 08             	mov    0x8(%eax),%eax
c0105185:	29 c2                	sub    %eax,%edx
c0105187:	89 d0                	mov    %edx,%eax
c0105189:	89 45 f0             	mov    %eax,-0x10(%ebp)
c010518c:	8b 45 ec             	mov    -0x14(%ebp),%eax
c010518f:	89 45 88             	mov    %eax,-0x78(%ebp)
    return listelm->next;
c0105192:	8b 45 88             	mov    -0x78(%ebp),%eax
c0105195:	8b 40 04             	mov    0x4(%eax),%eax
    while ((le = list_next(le)) != &free_list) {
c0105198:	89 45 ec             	mov    %eax,-0x14(%ebp)
c010519b:	81 7d ec 5c a9 11 c0 	cmpl   $0xc011a95c,-0x14(%ebp)
c01051a2:	75 cb                	jne    c010516f <default_check+0x4f5>
    }
    assert(count == 0);
c01051a4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
c01051a8:	74 19                	je     c01051c3 <default_check+0x549>
c01051aa:	68 be 6d 10 c0       	push   $0xc0106dbe
c01051af:	68 76 6a 10 c0       	push   $0xc0106a76
c01051b4:	68 31 01 00 00       	push   $0x131
c01051b9:	68 8b 6a 10 c0       	push   $0xc0106a8b
c01051be:	e8 47 b2 ff ff       	call   c010040a <__panic>
    assert(total == 0);
c01051c3:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
c01051c7:	74 19                	je     c01051e2 <default_check+0x568>
c01051c9:	68 c9 6d 10 c0       	push   $0xc0106dc9
c01051ce:	68 76 6a 10 c0       	push   $0xc0106a76
c01051d3:	68 32 01 00 00       	push   $0x132
c01051d8:	68 8b 6a 10 c0       	push   $0xc0106a8b
c01051dd:	e8 28 b2 ff ff       	call   c010040a <__panic>
}
c01051e2:	90                   	nop
c01051e3:	c9                   	leave  
c01051e4:	c3                   	ret    

c01051e5 <strlen>:
 * @s:      the input string
 *
 * The strlen() function returns the length of string @s.
 * */
size_t
strlen(const char *s) {
c01051e5:	f3 0f 1e fb          	endbr32 
c01051e9:	55                   	push   %ebp
c01051ea:	89 e5                	mov    %esp,%ebp
c01051ec:	83 ec 10             	sub    $0x10,%esp
    size_t cnt = 0;
c01051ef:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    while (*s ++ != '\0') {
c01051f6:	eb 04                	jmp    c01051fc <strlen+0x17>
        cnt ++;
c01051f8:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    while (*s ++ != '\0') {
c01051fc:	8b 45 08             	mov    0x8(%ebp),%eax
c01051ff:	8d 50 01             	lea    0x1(%eax),%edx
c0105202:	89 55 08             	mov    %edx,0x8(%ebp)
c0105205:	0f b6 00             	movzbl (%eax),%eax
c0105208:	84 c0                	test   %al,%al
c010520a:	75 ec                	jne    c01051f8 <strlen+0x13>
    }
    return cnt;
c010520c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
c010520f:	c9                   	leave  
c0105210:	c3                   	ret    

c0105211 <strnlen>:
 * The return value is strlen(s), if that is less than @len, or
 * @len if there is no '\0' character among the first @len characters
 * pointed by @s.
 * */
size_t
strnlen(const char *s, size_t len) {
c0105211:	f3 0f 1e fb          	endbr32 
c0105215:	55                   	push   %ebp
c0105216:	89 e5                	mov    %esp,%ebp
c0105218:	83 ec 10             	sub    $0x10,%esp
    size_t cnt = 0;
c010521b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    while (cnt < len && *s ++ != '\0') {
c0105222:	eb 04                	jmp    c0105228 <strnlen+0x17>
        cnt ++;
c0105224:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    while (cnt < len && *s ++ != '\0') {
c0105228:	8b 45 fc             	mov    -0x4(%ebp),%eax
c010522b:	3b 45 0c             	cmp    0xc(%ebp),%eax
c010522e:	73 10                	jae    c0105240 <strnlen+0x2f>
c0105230:	8b 45 08             	mov    0x8(%ebp),%eax
c0105233:	8d 50 01             	lea    0x1(%eax),%edx
c0105236:	89 55 08             	mov    %edx,0x8(%ebp)
c0105239:	0f b6 00             	movzbl (%eax),%eax
c010523c:	84 c0                	test   %al,%al
c010523e:	75 e4                	jne    c0105224 <strnlen+0x13>
    }
    return cnt;
c0105240:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
c0105243:	c9                   	leave  
c0105244:	c3                   	ret    

c0105245 <strcpy>:
 * To avoid overflows, the size of array pointed by @dst should be long enough to
 * contain the same string as @src (including the terminating null character), and
 * should not overlap in memory with @src.
 * */
char *
strcpy(char *dst, const char *src) {
c0105245:	f3 0f 1e fb          	endbr32 
c0105249:	55                   	push   %ebp
c010524a:	89 e5                	mov    %esp,%ebp
c010524c:	57                   	push   %edi
c010524d:	56                   	push   %esi
c010524e:	83 ec 20             	sub    $0x20,%esp
c0105251:	8b 45 08             	mov    0x8(%ebp),%eax
c0105254:	89 45 f4             	mov    %eax,-0xc(%ebp)
c0105257:	8b 45 0c             	mov    0xc(%ebp),%eax
c010525a:	89 45 f0             	mov    %eax,-0x10(%ebp)
#ifndef __HAVE_ARCH_STRCPY
#define __HAVE_ARCH_STRCPY
static inline char *
__strcpy(char *dst, const char *src) {
    int d0, d1, d2;
    asm volatile (
c010525d:	8b 55 f0             	mov    -0x10(%ebp),%edx
c0105260:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0105263:	89 d1                	mov    %edx,%ecx
c0105265:	89 c2                	mov    %eax,%edx
c0105267:	89 ce                	mov    %ecx,%esi
c0105269:	89 d7                	mov    %edx,%edi
c010526b:	ac                   	lods   %ds:(%esi),%al
c010526c:	aa                   	stos   %al,%es:(%edi)
c010526d:	84 c0                	test   %al,%al
c010526f:	75 fa                	jne    c010526b <strcpy+0x26>
c0105271:	89 fa                	mov    %edi,%edx
c0105273:	89 f1                	mov    %esi,%ecx
c0105275:	89 4d ec             	mov    %ecx,-0x14(%ebp)
c0105278:	89 55 e8             	mov    %edx,-0x18(%ebp)
c010527b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        "stosb;"
        "testb %%al, %%al;"
        "jne 1b;"
        : "=&S" (d0), "=&D" (d1), "=&a" (d2)
        : "0" (src), "1" (dst) : "memory");
    return dst;
c010527e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    char *p = dst;
    while ((*p ++ = *src ++) != '\0')
        /* nothing */;
    return dst;
#endif /* __HAVE_ARCH_STRCPY */
}
c0105281:	83 c4 20             	add    $0x20,%esp
c0105284:	5e                   	pop    %esi
c0105285:	5f                   	pop    %edi
c0105286:	5d                   	pop    %ebp
c0105287:	c3                   	ret    

c0105288 <strncpy>:
 * @len:    maximum number of characters to be copied from @src
 *
 * The return value is @dst
 * */
char *
strncpy(char *dst, const char *src, size_t len) {
c0105288:	f3 0f 1e fb          	endbr32 
c010528c:	55                   	push   %ebp
c010528d:	89 e5                	mov    %esp,%ebp
c010528f:	83 ec 10             	sub    $0x10,%esp
    char *p = dst;
c0105292:	8b 45 08             	mov    0x8(%ebp),%eax
c0105295:	89 45 fc             	mov    %eax,-0x4(%ebp)
    while (len > 0) {
c0105298:	eb 21                	jmp    c01052bb <strncpy+0x33>
        if ((*p = *src) != '\0') {
c010529a:	8b 45 0c             	mov    0xc(%ebp),%eax
c010529d:	0f b6 10             	movzbl (%eax),%edx
c01052a0:	8b 45 fc             	mov    -0x4(%ebp),%eax
c01052a3:	88 10                	mov    %dl,(%eax)
c01052a5:	8b 45 fc             	mov    -0x4(%ebp),%eax
c01052a8:	0f b6 00             	movzbl (%eax),%eax
c01052ab:	84 c0                	test   %al,%al
c01052ad:	74 04                	je     c01052b3 <strncpy+0x2b>
            src ++;
c01052af:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
        }
        p ++, len --;
c01052b3:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
c01052b7:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
    while (len > 0) {
c01052bb:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
c01052bf:	75 d9                	jne    c010529a <strncpy+0x12>
    }
    return dst;
c01052c1:	8b 45 08             	mov    0x8(%ebp),%eax
}
c01052c4:	c9                   	leave  
c01052c5:	c3                   	ret    

c01052c6 <strcmp>:
 * - A value greater than zero indicates that the first character that does
 *   not match has a greater value in @s1 than in @s2;
 * - And a value less than zero indicates the opposite.
 * */
int
strcmp(const char *s1, const char *s2) {
c01052c6:	f3 0f 1e fb          	endbr32 
c01052ca:	55                   	push   %ebp
c01052cb:	89 e5                	mov    %esp,%ebp
c01052cd:	57                   	push   %edi
c01052ce:	56                   	push   %esi
c01052cf:	83 ec 20             	sub    $0x20,%esp
c01052d2:	8b 45 08             	mov    0x8(%ebp),%eax
c01052d5:	89 45 f4             	mov    %eax,-0xc(%ebp)
c01052d8:	8b 45 0c             	mov    0xc(%ebp),%eax
c01052db:	89 45 f0             	mov    %eax,-0x10(%ebp)
    asm volatile (
c01052de:	8b 55 f4             	mov    -0xc(%ebp),%edx
c01052e1:	8b 45 f0             	mov    -0x10(%ebp),%eax
c01052e4:	89 d1                	mov    %edx,%ecx
c01052e6:	89 c2                	mov    %eax,%edx
c01052e8:	89 ce                	mov    %ecx,%esi
c01052ea:	89 d7                	mov    %edx,%edi
c01052ec:	ac                   	lods   %ds:(%esi),%al
c01052ed:	ae                   	scas   %es:(%edi),%al
c01052ee:	75 08                	jne    c01052f8 <strcmp+0x32>
c01052f0:	84 c0                	test   %al,%al
c01052f2:	75 f8                	jne    c01052ec <strcmp+0x26>
c01052f4:	31 c0                	xor    %eax,%eax
c01052f6:	eb 04                	jmp    c01052fc <strcmp+0x36>
c01052f8:	19 c0                	sbb    %eax,%eax
c01052fa:	0c 01                	or     $0x1,%al
c01052fc:	89 fa                	mov    %edi,%edx
c01052fe:	89 f1                	mov    %esi,%ecx
c0105300:	89 45 ec             	mov    %eax,-0x14(%ebp)
c0105303:	89 4d e8             	mov    %ecx,-0x18(%ebp)
c0105306:	89 55 e4             	mov    %edx,-0x1c(%ebp)
    return ret;
c0105309:	8b 45 ec             	mov    -0x14(%ebp),%eax
    while (*s1 != '\0' && *s1 == *s2) {
        s1 ++, s2 ++;
    }
    return (int)((unsigned char)*s1 - (unsigned char)*s2);
#endif /* __HAVE_ARCH_STRCMP */
}
c010530c:	83 c4 20             	add    $0x20,%esp
c010530f:	5e                   	pop    %esi
c0105310:	5f                   	pop    %edi
c0105311:	5d                   	pop    %ebp
c0105312:	c3                   	ret    

c0105313 <strncmp>:
 * they are equal to each other, it continues with the following pairs until
 * the characters differ, until a terminating null-character is reached, or
 * until @n characters match in both strings, whichever happens first.
 * */
int
strncmp(const char *s1, const char *s2, size_t n) {
c0105313:	f3 0f 1e fb          	endbr32 
c0105317:	55                   	push   %ebp
c0105318:	89 e5                	mov    %esp,%ebp
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
c010531a:	eb 0c                	jmp    c0105328 <strncmp+0x15>
        n --, s1 ++, s2 ++;
c010531c:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
c0105320:	83 45 08 01          	addl   $0x1,0x8(%ebp)
c0105324:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
c0105328:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
c010532c:	74 1a                	je     c0105348 <strncmp+0x35>
c010532e:	8b 45 08             	mov    0x8(%ebp),%eax
c0105331:	0f b6 00             	movzbl (%eax),%eax
c0105334:	84 c0                	test   %al,%al
c0105336:	74 10                	je     c0105348 <strncmp+0x35>
c0105338:	8b 45 08             	mov    0x8(%ebp),%eax
c010533b:	0f b6 10             	movzbl (%eax),%edx
c010533e:	8b 45 0c             	mov    0xc(%ebp),%eax
c0105341:	0f b6 00             	movzbl (%eax),%eax
c0105344:	38 c2                	cmp    %al,%dl
c0105346:	74 d4                	je     c010531c <strncmp+0x9>
    }
    return (n == 0) ? 0 : (int)((unsigned char)*s1 - (unsigned char)*s2);
c0105348:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
c010534c:	74 18                	je     c0105366 <strncmp+0x53>
c010534e:	8b 45 08             	mov    0x8(%ebp),%eax
c0105351:	0f b6 00             	movzbl (%eax),%eax
c0105354:	0f b6 d0             	movzbl %al,%edx
c0105357:	8b 45 0c             	mov    0xc(%ebp),%eax
c010535a:	0f b6 00             	movzbl (%eax),%eax
c010535d:	0f b6 c0             	movzbl %al,%eax
c0105360:	29 c2                	sub    %eax,%edx
c0105362:	89 d0                	mov    %edx,%eax
c0105364:	eb 05                	jmp    c010536b <strncmp+0x58>
c0105366:	b8 00 00 00 00       	mov    $0x0,%eax
}
c010536b:	5d                   	pop    %ebp
c010536c:	c3                   	ret    

c010536d <strchr>:
 *
 * The strchr() function returns a pointer to the first occurrence of
 * character in @s. If the value is not found, the function returns 'NULL'.
 * */
char *
strchr(const char *s, char c) {
c010536d:	f3 0f 1e fb          	endbr32 
c0105371:	55                   	push   %ebp
c0105372:	89 e5                	mov    %esp,%ebp
c0105374:	83 ec 04             	sub    $0x4,%esp
c0105377:	8b 45 0c             	mov    0xc(%ebp),%eax
c010537a:	88 45 fc             	mov    %al,-0x4(%ebp)
    while (*s != '\0') {
c010537d:	eb 14                	jmp    c0105393 <strchr+0x26>
        if (*s == c) {
c010537f:	8b 45 08             	mov    0x8(%ebp),%eax
c0105382:	0f b6 00             	movzbl (%eax),%eax
c0105385:	38 45 fc             	cmp    %al,-0x4(%ebp)
c0105388:	75 05                	jne    c010538f <strchr+0x22>
            return (char *)s;
c010538a:	8b 45 08             	mov    0x8(%ebp),%eax
c010538d:	eb 13                	jmp    c01053a2 <strchr+0x35>
        }
        s ++;
c010538f:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    while (*s != '\0') {
c0105393:	8b 45 08             	mov    0x8(%ebp),%eax
c0105396:	0f b6 00             	movzbl (%eax),%eax
c0105399:	84 c0                	test   %al,%al
c010539b:	75 e2                	jne    c010537f <strchr+0x12>
    }
    return NULL;
c010539d:	b8 00 00 00 00       	mov    $0x0,%eax
}
c01053a2:	c9                   	leave  
c01053a3:	c3                   	ret    

c01053a4 <strfind>:
 * The strfind() function is like strchr() except that if @c is
 * not found in @s, then it returns a pointer to the null byte at the
 * end of @s, rather than 'NULL'.
 * */
char *
strfind(const char *s, char c) {
c01053a4:	f3 0f 1e fb          	endbr32 
c01053a8:	55                   	push   %ebp
c01053a9:	89 e5                	mov    %esp,%ebp
c01053ab:	83 ec 04             	sub    $0x4,%esp
c01053ae:	8b 45 0c             	mov    0xc(%ebp),%eax
c01053b1:	88 45 fc             	mov    %al,-0x4(%ebp)
    while (*s != '\0') {
c01053b4:	eb 0f                	jmp    c01053c5 <strfind+0x21>
        if (*s == c) {
c01053b6:	8b 45 08             	mov    0x8(%ebp),%eax
c01053b9:	0f b6 00             	movzbl (%eax),%eax
c01053bc:	38 45 fc             	cmp    %al,-0x4(%ebp)
c01053bf:	74 10                	je     c01053d1 <strfind+0x2d>
            break;
        }
        s ++;
c01053c1:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    while (*s != '\0') {
c01053c5:	8b 45 08             	mov    0x8(%ebp),%eax
c01053c8:	0f b6 00             	movzbl (%eax),%eax
c01053cb:	84 c0                	test   %al,%al
c01053cd:	75 e7                	jne    c01053b6 <strfind+0x12>
c01053cf:	eb 01                	jmp    c01053d2 <strfind+0x2e>
            break;
c01053d1:	90                   	nop
    }
    return (char *)s;
c01053d2:	8b 45 08             	mov    0x8(%ebp),%eax
}
c01053d5:	c9                   	leave  
c01053d6:	c3                   	ret    

c01053d7 <strtol>:
 * an optional "0x" or "0X" prefix.
 *
 * The strtol() function returns the converted integral number as a long int value.
 * */
long
strtol(const char *s, char **endptr, int base) {
c01053d7:	f3 0f 1e fb          	endbr32 
c01053db:	55                   	push   %ebp
c01053dc:	89 e5                	mov    %esp,%ebp
c01053de:	83 ec 10             	sub    $0x10,%esp
    int neg = 0;
c01053e1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    long val = 0;
c01053e8:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

    // gobble initial whitespace
    while (*s == ' ' || *s == '\t') {
c01053ef:	eb 04                	jmp    c01053f5 <strtol+0x1e>
        s ++;
c01053f1:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    while (*s == ' ' || *s == '\t') {
c01053f5:	8b 45 08             	mov    0x8(%ebp),%eax
c01053f8:	0f b6 00             	movzbl (%eax),%eax
c01053fb:	3c 20                	cmp    $0x20,%al
c01053fd:	74 f2                	je     c01053f1 <strtol+0x1a>
c01053ff:	8b 45 08             	mov    0x8(%ebp),%eax
c0105402:	0f b6 00             	movzbl (%eax),%eax
c0105405:	3c 09                	cmp    $0x9,%al
c0105407:	74 e8                	je     c01053f1 <strtol+0x1a>
    }

    // plus/minus sign
    if (*s == '+') {
c0105409:	8b 45 08             	mov    0x8(%ebp),%eax
c010540c:	0f b6 00             	movzbl (%eax),%eax
c010540f:	3c 2b                	cmp    $0x2b,%al
c0105411:	75 06                	jne    c0105419 <strtol+0x42>
        s ++;
c0105413:	83 45 08 01          	addl   $0x1,0x8(%ebp)
c0105417:	eb 15                	jmp    c010542e <strtol+0x57>
    }
    else if (*s == '-') {
c0105419:	8b 45 08             	mov    0x8(%ebp),%eax
c010541c:	0f b6 00             	movzbl (%eax),%eax
c010541f:	3c 2d                	cmp    $0x2d,%al
c0105421:	75 0b                	jne    c010542e <strtol+0x57>
        s ++, neg = 1;
c0105423:	83 45 08 01          	addl   $0x1,0x8(%ebp)
c0105427:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
    }

    // hex or octal base prefix
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x')) {
c010542e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
c0105432:	74 06                	je     c010543a <strtol+0x63>
c0105434:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
c0105438:	75 24                	jne    c010545e <strtol+0x87>
c010543a:	8b 45 08             	mov    0x8(%ebp),%eax
c010543d:	0f b6 00             	movzbl (%eax),%eax
c0105440:	3c 30                	cmp    $0x30,%al
c0105442:	75 1a                	jne    c010545e <strtol+0x87>
c0105444:	8b 45 08             	mov    0x8(%ebp),%eax
c0105447:	83 c0 01             	add    $0x1,%eax
c010544a:	0f b6 00             	movzbl (%eax),%eax
c010544d:	3c 78                	cmp    $0x78,%al
c010544f:	75 0d                	jne    c010545e <strtol+0x87>
        s += 2, base = 16;
c0105451:	83 45 08 02          	addl   $0x2,0x8(%ebp)
c0105455:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
c010545c:	eb 2a                	jmp    c0105488 <strtol+0xb1>
    }
    else if (base == 0 && s[0] == '0') {
c010545e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
c0105462:	75 17                	jne    c010547b <strtol+0xa4>
c0105464:	8b 45 08             	mov    0x8(%ebp),%eax
c0105467:	0f b6 00             	movzbl (%eax),%eax
c010546a:	3c 30                	cmp    $0x30,%al
c010546c:	75 0d                	jne    c010547b <strtol+0xa4>
        s ++, base = 8;
c010546e:	83 45 08 01          	addl   $0x1,0x8(%ebp)
c0105472:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
c0105479:	eb 0d                	jmp    c0105488 <strtol+0xb1>
    }
    else if (base == 0) {
c010547b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
c010547f:	75 07                	jne    c0105488 <strtol+0xb1>
        base = 10;
c0105481:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

    // digits
    while (1) {
        int dig;

        if (*s >= '0' && *s <= '9') {
c0105488:	8b 45 08             	mov    0x8(%ebp),%eax
c010548b:	0f b6 00             	movzbl (%eax),%eax
c010548e:	3c 2f                	cmp    $0x2f,%al
c0105490:	7e 1b                	jle    c01054ad <strtol+0xd6>
c0105492:	8b 45 08             	mov    0x8(%ebp),%eax
c0105495:	0f b6 00             	movzbl (%eax),%eax
c0105498:	3c 39                	cmp    $0x39,%al
c010549a:	7f 11                	jg     c01054ad <strtol+0xd6>
            dig = *s - '0';
c010549c:	8b 45 08             	mov    0x8(%ebp),%eax
c010549f:	0f b6 00             	movzbl (%eax),%eax
c01054a2:	0f be c0             	movsbl %al,%eax
c01054a5:	83 e8 30             	sub    $0x30,%eax
c01054a8:	89 45 f4             	mov    %eax,-0xc(%ebp)
c01054ab:	eb 48                	jmp    c01054f5 <strtol+0x11e>
        }
        else if (*s >= 'a' && *s <= 'z') {
c01054ad:	8b 45 08             	mov    0x8(%ebp),%eax
c01054b0:	0f b6 00             	movzbl (%eax),%eax
c01054b3:	3c 60                	cmp    $0x60,%al
c01054b5:	7e 1b                	jle    c01054d2 <strtol+0xfb>
c01054b7:	8b 45 08             	mov    0x8(%ebp),%eax
c01054ba:	0f b6 00             	movzbl (%eax),%eax
c01054bd:	3c 7a                	cmp    $0x7a,%al
c01054bf:	7f 11                	jg     c01054d2 <strtol+0xfb>
            dig = *s - 'a' + 10;
c01054c1:	8b 45 08             	mov    0x8(%ebp),%eax
c01054c4:	0f b6 00             	movzbl (%eax),%eax
c01054c7:	0f be c0             	movsbl %al,%eax
c01054ca:	83 e8 57             	sub    $0x57,%eax
c01054cd:	89 45 f4             	mov    %eax,-0xc(%ebp)
c01054d0:	eb 23                	jmp    c01054f5 <strtol+0x11e>
        }
        else if (*s >= 'A' && *s <= 'Z') {
c01054d2:	8b 45 08             	mov    0x8(%ebp),%eax
c01054d5:	0f b6 00             	movzbl (%eax),%eax
c01054d8:	3c 40                	cmp    $0x40,%al
c01054da:	7e 3c                	jle    c0105518 <strtol+0x141>
c01054dc:	8b 45 08             	mov    0x8(%ebp),%eax
c01054df:	0f b6 00             	movzbl (%eax),%eax
c01054e2:	3c 5a                	cmp    $0x5a,%al
c01054e4:	7f 32                	jg     c0105518 <strtol+0x141>
            dig = *s - 'A' + 10;
c01054e6:	8b 45 08             	mov    0x8(%ebp),%eax
c01054e9:	0f b6 00             	movzbl (%eax),%eax
c01054ec:	0f be c0             	movsbl %al,%eax
c01054ef:	83 e8 37             	sub    $0x37,%eax
c01054f2:	89 45 f4             	mov    %eax,-0xc(%ebp)
        }
        else {
            break;
        }
        if (dig >= base) {
c01054f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
c01054f8:	3b 45 10             	cmp    0x10(%ebp),%eax
c01054fb:	7d 1a                	jge    c0105517 <strtol+0x140>
            break;
        }
        s ++, val = (val * base) + dig;
c01054fd:	83 45 08 01          	addl   $0x1,0x8(%ebp)
c0105501:	8b 45 f8             	mov    -0x8(%ebp),%eax
c0105504:	0f af 45 10          	imul   0x10(%ebp),%eax
c0105508:	89 c2                	mov    %eax,%edx
c010550a:	8b 45 f4             	mov    -0xc(%ebp),%eax
c010550d:	01 d0                	add    %edx,%eax
c010550f:	89 45 f8             	mov    %eax,-0x8(%ebp)
    while (1) {
c0105512:	e9 71 ff ff ff       	jmp    c0105488 <strtol+0xb1>
            break;
c0105517:	90                   	nop
        // we don't properly detect overflow!
    }

    if (endptr) {
c0105518:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
c010551c:	74 08                	je     c0105526 <strtol+0x14f>
        *endptr = (char *) s;
c010551e:	8b 45 0c             	mov    0xc(%ebp),%eax
c0105521:	8b 55 08             	mov    0x8(%ebp),%edx
c0105524:	89 10                	mov    %edx,(%eax)
    }
    return (neg ? -val : val);
c0105526:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
c010552a:	74 07                	je     c0105533 <strtol+0x15c>
c010552c:	8b 45 f8             	mov    -0x8(%ebp),%eax
c010552f:	f7 d8                	neg    %eax
c0105531:	eb 03                	jmp    c0105536 <strtol+0x15f>
c0105533:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
c0105536:	c9                   	leave  
c0105537:	c3                   	ret    

c0105538 <memset>:
 * @n:      number of bytes to be set to the value
 *
 * The memset() function returns @s.
 * */
void *
memset(void *s, char c, size_t n) {
c0105538:	f3 0f 1e fb          	endbr32 
c010553c:	55                   	push   %ebp
c010553d:	89 e5                	mov    %esp,%ebp
c010553f:	57                   	push   %edi
c0105540:	83 ec 24             	sub    $0x24,%esp
c0105543:	8b 45 0c             	mov    0xc(%ebp),%eax
c0105546:	88 45 d8             	mov    %al,-0x28(%ebp)
#ifdef __HAVE_ARCH_MEMSET
    return __memset(s, c, n);
c0105549:	0f be 45 d8          	movsbl -0x28(%ebp),%eax
c010554d:	8b 55 08             	mov    0x8(%ebp),%edx
c0105550:	89 55 f8             	mov    %edx,-0x8(%ebp)
c0105553:	88 45 f7             	mov    %al,-0x9(%ebp)
c0105556:	8b 45 10             	mov    0x10(%ebp),%eax
c0105559:	89 45 f0             	mov    %eax,-0x10(%ebp)
#ifndef __HAVE_ARCH_MEMSET
#define __HAVE_ARCH_MEMSET
static inline void *
__memset(void *s, char c, size_t n) {
    int d0, d1;
    asm volatile (
c010555c:	8b 4d f0             	mov    -0x10(%ebp),%ecx
c010555f:	0f b6 45 f7          	movzbl -0x9(%ebp),%eax
c0105563:	8b 55 f8             	mov    -0x8(%ebp),%edx
c0105566:	89 d7                	mov    %edx,%edi
c0105568:	f3 aa                	rep stos %al,%es:(%edi)
c010556a:	89 fa                	mov    %edi,%edx
c010556c:	89 4d ec             	mov    %ecx,-0x14(%ebp)
c010556f:	89 55 e8             	mov    %edx,-0x18(%ebp)
        "rep; stosb;"
        : "=&c" (d0), "=&D" (d1)
        : "0" (n), "a" (c), "1" (s)
        : "memory");
    return s;
c0105572:	8b 45 f8             	mov    -0x8(%ebp),%eax
    while (n -- > 0) {
        *p ++ = c;
    }
    return s;
#endif /* __HAVE_ARCH_MEMSET */
}
c0105575:	83 c4 24             	add    $0x24,%esp
c0105578:	5f                   	pop    %edi
c0105579:	5d                   	pop    %ebp
c010557a:	c3                   	ret    

c010557b <memmove>:
 * @n:      number of bytes to copy
 *
 * The memmove() function returns @dst.
 * */
void *
memmove(void *dst, const void *src, size_t n) {
c010557b:	f3 0f 1e fb          	endbr32 
c010557f:	55                   	push   %ebp
c0105580:	89 e5                	mov    %esp,%ebp
c0105582:	57                   	push   %edi
c0105583:	56                   	push   %esi
c0105584:	53                   	push   %ebx
c0105585:	83 ec 30             	sub    $0x30,%esp
c0105588:	8b 45 08             	mov    0x8(%ebp),%eax
c010558b:	89 45 f0             	mov    %eax,-0x10(%ebp)
c010558e:	8b 45 0c             	mov    0xc(%ebp),%eax
c0105591:	89 45 ec             	mov    %eax,-0x14(%ebp)
c0105594:	8b 45 10             	mov    0x10(%ebp),%eax
c0105597:	89 45 e8             	mov    %eax,-0x18(%ebp)

#ifndef __HAVE_ARCH_MEMMOVE
#define __HAVE_ARCH_MEMMOVE
static inline void *
__memmove(void *dst, const void *src, size_t n) {
    if (dst < src) {
c010559a:	8b 45 f0             	mov    -0x10(%ebp),%eax
c010559d:	3b 45 ec             	cmp    -0x14(%ebp),%eax
c01055a0:	73 42                	jae    c01055e4 <memmove+0x69>
c01055a2:	8b 45 f0             	mov    -0x10(%ebp),%eax
c01055a5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
c01055a8:	8b 45 ec             	mov    -0x14(%ebp),%eax
c01055ab:	89 45 e0             	mov    %eax,-0x20(%ebp)
c01055ae:	8b 45 e8             	mov    -0x18(%ebp),%eax
c01055b1:	89 45 dc             	mov    %eax,-0x24(%ebp)
        "andl $3, %%ecx;"
        "jz 1f;"
        "rep; movsb;"
        "1:"
        : "=&c" (d0), "=&D" (d1), "=&S" (d2)
        : "0" (n / 4), "g" (n), "1" (dst), "2" (src)
c01055b4:	8b 45 dc             	mov    -0x24(%ebp),%eax
c01055b7:	c1 e8 02             	shr    $0x2,%eax
c01055ba:	89 c1                	mov    %eax,%ecx
    asm volatile (
c01055bc:	8b 55 e4             	mov    -0x1c(%ebp),%edx
c01055bf:	8b 45 e0             	mov    -0x20(%ebp),%eax
c01055c2:	89 d7                	mov    %edx,%edi
c01055c4:	89 c6                	mov    %eax,%esi
c01055c6:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
c01055c8:	8b 4d dc             	mov    -0x24(%ebp),%ecx
c01055cb:	83 e1 03             	and    $0x3,%ecx
c01055ce:	74 02                	je     c01055d2 <memmove+0x57>
c01055d0:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
c01055d2:	89 f0                	mov    %esi,%eax
c01055d4:	89 fa                	mov    %edi,%edx
c01055d6:	89 4d d8             	mov    %ecx,-0x28(%ebp)
c01055d9:	89 55 d4             	mov    %edx,-0x2c(%ebp)
c01055dc:	89 45 d0             	mov    %eax,-0x30(%ebp)
        : "memory");
    return dst;
c01055df:	8b 45 e4             	mov    -0x1c(%ebp),%eax
        return __memcpy(dst, src, n);
c01055e2:	eb 36                	jmp    c010561a <memmove+0x9f>
        : "0" (n), "1" (n - 1 + src), "2" (n - 1 + dst)
c01055e4:	8b 45 e8             	mov    -0x18(%ebp),%eax
c01055e7:	8d 50 ff             	lea    -0x1(%eax),%edx
c01055ea:	8b 45 ec             	mov    -0x14(%ebp),%eax
c01055ed:	01 c2                	add    %eax,%edx
c01055ef:	8b 45 e8             	mov    -0x18(%ebp),%eax
c01055f2:	8d 48 ff             	lea    -0x1(%eax),%ecx
c01055f5:	8b 45 f0             	mov    -0x10(%ebp),%eax
c01055f8:	8d 1c 01             	lea    (%ecx,%eax,1),%ebx
    asm volatile (
c01055fb:	8b 45 e8             	mov    -0x18(%ebp),%eax
c01055fe:	89 c1                	mov    %eax,%ecx
c0105600:	89 d8                	mov    %ebx,%eax
c0105602:	89 d6                	mov    %edx,%esi
c0105604:	89 c7                	mov    %eax,%edi
c0105606:	fd                   	std    
c0105607:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
c0105609:	fc                   	cld    
c010560a:	89 f8                	mov    %edi,%eax
c010560c:	89 f2                	mov    %esi,%edx
c010560e:	89 4d cc             	mov    %ecx,-0x34(%ebp)
c0105611:	89 55 c8             	mov    %edx,-0x38(%ebp)
c0105614:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    return dst;
c0105617:	8b 45 f0             	mov    -0x10(%ebp),%eax
            *d ++ = *s ++;
        }
    }
    return dst;
#endif /* __HAVE_ARCH_MEMMOVE */
}
c010561a:	83 c4 30             	add    $0x30,%esp
c010561d:	5b                   	pop    %ebx
c010561e:	5e                   	pop    %esi
c010561f:	5f                   	pop    %edi
c0105620:	5d                   	pop    %ebp
c0105621:	c3                   	ret    

c0105622 <memcpy>:
 * it always copies exactly @n bytes. To avoid overflows, the size of arrays pointed
 * by both @src and @dst, should be at least @n bytes, and should not overlap
 * (for overlapping memory area, memmove is a safer approach).
 * */
void *
memcpy(void *dst, const void *src, size_t n) {
c0105622:	f3 0f 1e fb          	endbr32 
c0105626:	55                   	push   %ebp
c0105627:	89 e5                	mov    %esp,%ebp
c0105629:	57                   	push   %edi
c010562a:	56                   	push   %esi
c010562b:	83 ec 20             	sub    $0x20,%esp
c010562e:	8b 45 08             	mov    0x8(%ebp),%eax
c0105631:	89 45 f4             	mov    %eax,-0xc(%ebp)
c0105634:	8b 45 0c             	mov    0xc(%ebp),%eax
c0105637:	89 45 f0             	mov    %eax,-0x10(%ebp)
c010563a:	8b 45 10             	mov    0x10(%ebp),%eax
c010563d:	89 45 ec             	mov    %eax,-0x14(%ebp)
        : "0" (n / 4), "g" (n), "1" (dst), "2" (src)
c0105640:	8b 45 ec             	mov    -0x14(%ebp),%eax
c0105643:	c1 e8 02             	shr    $0x2,%eax
c0105646:	89 c1                	mov    %eax,%ecx
    asm volatile (
c0105648:	8b 55 f4             	mov    -0xc(%ebp),%edx
c010564b:	8b 45 f0             	mov    -0x10(%ebp),%eax
c010564e:	89 d7                	mov    %edx,%edi
c0105650:	89 c6                	mov    %eax,%esi
c0105652:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
c0105654:	8b 4d ec             	mov    -0x14(%ebp),%ecx
c0105657:	83 e1 03             	and    $0x3,%ecx
c010565a:	74 02                	je     c010565e <memcpy+0x3c>
c010565c:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
c010565e:	89 f0                	mov    %esi,%eax
c0105660:	89 fa                	mov    %edi,%edx
c0105662:	89 4d e8             	mov    %ecx,-0x18(%ebp)
c0105665:	89 55 e4             	mov    %edx,-0x1c(%ebp)
c0105668:	89 45 e0             	mov    %eax,-0x20(%ebp)
    return dst;
c010566b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    while (n -- > 0) {
        *d ++ = *s ++;
    }
    return dst;
#endif /* __HAVE_ARCH_MEMCPY */
}
c010566e:	83 c4 20             	add    $0x20,%esp
c0105671:	5e                   	pop    %esi
c0105672:	5f                   	pop    %edi
c0105673:	5d                   	pop    %ebp
c0105674:	c3                   	ret    

c0105675 <memcmp>:
 *   match in both memory blocks has a greater value in @v1 than in @v2
 *   as if evaluated as unsigned char values;
 * - And a value less than zero indicates the opposite.
 * */
int
memcmp(const void *v1, const void *v2, size_t n) {
c0105675:	f3 0f 1e fb          	endbr32 
c0105679:	55                   	push   %ebp
c010567a:	89 e5                	mov    %esp,%ebp
c010567c:	83 ec 10             	sub    $0x10,%esp
    const char *s1 = (const char *)v1;
c010567f:	8b 45 08             	mov    0x8(%ebp),%eax
c0105682:	89 45 fc             	mov    %eax,-0x4(%ebp)
    const char *s2 = (const char *)v2;
c0105685:	8b 45 0c             	mov    0xc(%ebp),%eax
c0105688:	89 45 f8             	mov    %eax,-0x8(%ebp)
    while (n -- > 0) {
c010568b:	eb 30                	jmp    c01056bd <memcmp+0x48>
        if (*s1 != *s2) {
c010568d:	8b 45 fc             	mov    -0x4(%ebp),%eax
c0105690:	0f b6 10             	movzbl (%eax),%edx
c0105693:	8b 45 f8             	mov    -0x8(%ebp),%eax
c0105696:	0f b6 00             	movzbl (%eax),%eax
c0105699:	38 c2                	cmp    %al,%dl
c010569b:	74 18                	je     c01056b5 <memcmp+0x40>
            return (int)((unsigned char)*s1 - (unsigned char)*s2);
c010569d:	8b 45 fc             	mov    -0x4(%ebp),%eax
c01056a0:	0f b6 00             	movzbl (%eax),%eax
c01056a3:	0f b6 d0             	movzbl %al,%edx
c01056a6:	8b 45 f8             	mov    -0x8(%ebp),%eax
c01056a9:	0f b6 00             	movzbl (%eax),%eax
c01056ac:	0f b6 c0             	movzbl %al,%eax
c01056af:	29 c2                	sub    %eax,%edx
c01056b1:	89 d0                	mov    %edx,%eax
c01056b3:	eb 1a                	jmp    c01056cf <memcmp+0x5a>
        }
        s1 ++, s2 ++;
c01056b5:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
c01056b9:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    while (n -- > 0) {
c01056bd:	8b 45 10             	mov    0x10(%ebp),%eax
c01056c0:	8d 50 ff             	lea    -0x1(%eax),%edx
c01056c3:	89 55 10             	mov    %edx,0x10(%ebp)
c01056c6:	85 c0                	test   %eax,%eax
c01056c8:	75 c3                	jne    c010568d <memcmp+0x18>
    }
    return 0;
c01056ca:	b8 00 00 00 00       	mov    $0x0,%eax
}
c01056cf:	c9                   	leave  
c01056d0:	c3                   	ret    

c01056d1 <printnum>:
 * @width:      maximum number of digits, if the actual width is less than @width, use @padc instead
 * @padc:       character that padded on the left if the actual width is less than @width
 * */
static void
printnum(void (*putch)(int, void*), void *putdat,
        unsigned long long num, unsigned base, int width, int padc) {
c01056d1:	f3 0f 1e fb          	endbr32 
c01056d5:	55                   	push   %ebp
c01056d6:	89 e5                	mov    %esp,%ebp
c01056d8:	83 ec 38             	sub    $0x38,%esp
c01056db:	8b 45 10             	mov    0x10(%ebp),%eax
c01056de:	89 45 d0             	mov    %eax,-0x30(%ebp)
c01056e1:	8b 45 14             	mov    0x14(%ebp),%eax
c01056e4:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    unsigned long long result = num;
c01056e7:	8b 45 d0             	mov    -0x30(%ebp),%eax
c01056ea:	8b 55 d4             	mov    -0x2c(%ebp),%edx
c01056ed:	89 45 e8             	mov    %eax,-0x18(%ebp)
c01056f0:	89 55 ec             	mov    %edx,-0x14(%ebp)
    unsigned mod = do_div(result, base);
c01056f3:	8b 45 18             	mov    0x18(%ebp),%eax
c01056f6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
c01056f9:	8b 45 e8             	mov    -0x18(%ebp),%eax
c01056fc:	8b 55 ec             	mov    -0x14(%ebp),%edx
c01056ff:	89 45 e0             	mov    %eax,-0x20(%ebp)
c0105702:	89 55 f0             	mov    %edx,-0x10(%ebp)
c0105705:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0105708:	89 45 f4             	mov    %eax,-0xc(%ebp)
c010570b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
c010570f:	74 1c                	je     c010572d <printnum+0x5c>
c0105711:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0105714:	ba 00 00 00 00       	mov    $0x0,%edx
c0105719:	f7 75 e4             	divl   -0x1c(%ebp)
c010571c:	89 55 f4             	mov    %edx,-0xc(%ebp)
c010571f:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0105722:	ba 00 00 00 00       	mov    $0x0,%edx
c0105727:	f7 75 e4             	divl   -0x1c(%ebp)
c010572a:	89 45 f0             	mov    %eax,-0x10(%ebp)
c010572d:	8b 45 e0             	mov    -0x20(%ebp),%eax
c0105730:	8b 55 f4             	mov    -0xc(%ebp),%edx
c0105733:	f7 75 e4             	divl   -0x1c(%ebp)
c0105736:	89 45 e0             	mov    %eax,-0x20(%ebp)
c0105739:	89 55 dc             	mov    %edx,-0x24(%ebp)
c010573c:	8b 45 e0             	mov    -0x20(%ebp),%eax
c010573f:	8b 55 f0             	mov    -0x10(%ebp),%edx
c0105742:	89 45 e8             	mov    %eax,-0x18(%ebp)
c0105745:	89 55 ec             	mov    %edx,-0x14(%ebp)
c0105748:	8b 45 dc             	mov    -0x24(%ebp),%eax
c010574b:	89 45 d8             	mov    %eax,-0x28(%ebp)

    // first recursively print all preceding (more significant) digits
    if (num >= base) {
c010574e:	8b 45 18             	mov    0x18(%ebp),%eax
c0105751:	ba 00 00 00 00       	mov    $0x0,%edx
c0105756:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
c0105759:	39 45 d0             	cmp    %eax,-0x30(%ebp)
c010575c:	19 d1                	sbb    %edx,%ecx
c010575e:	72 37                	jb     c0105797 <printnum+0xc6>
        printnum(putch, putdat, result, base, width - 1, padc);
c0105760:	8b 45 1c             	mov    0x1c(%ebp),%eax
c0105763:	83 e8 01             	sub    $0x1,%eax
c0105766:	83 ec 04             	sub    $0x4,%esp
c0105769:	ff 75 20             	pushl  0x20(%ebp)
c010576c:	50                   	push   %eax
c010576d:	ff 75 18             	pushl  0x18(%ebp)
c0105770:	ff 75 ec             	pushl  -0x14(%ebp)
c0105773:	ff 75 e8             	pushl  -0x18(%ebp)
c0105776:	ff 75 0c             	pushl  0xc(%ebp)
c0105779:	ff 75 08             	pushl  0x8(%ebp)
c010577c:	e8 50 ff ff ff       	call   c01056d1 <printnum>
c0105781:	83 c4 20             	add    $0x20,%esp
c0105784:	eb 1b                	jmp    c01057a1 <printnum+0xd0>
    } else {
        // print any needed pad characters before first digit
        while (-- width > 0)
            putch(padc, putdat);
c0105786:	83 ec 08             	sub    $0x8,%esp
c0105789:	ff 75 0c             	pushl  0xc(%ebp)
c010578c:	ff 75 20             	pushl  0x20(%ebp)
c010578f:	8b 45 08             	mov    0x8(%ebp),%eax
c0105792:	ff d0                	call   *%eax
c0105794:	83 c4 10             	add    $0x10,%esp
        while (-- width > 0)
c0105797:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
c010579b:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
c010579f:	7f e5                	jg     c0105786 <printnum+0xb5>
    }
    // then print this (the least significant) digit
    putch("0123456789abcdef"[mod], putdat);
c01057a1:	8b 45 d8             	mov    -0x28(%ebp),%eax
c01057a4:	05 84 6e 10 c0       	add    $0xc0106e84,%eax
c01057a9:	0f b6 00             	movzbl (%eax),%eax
c01057ac:	0f be c0             	movsbl %al,%eax
c01057af:	83 ec 08             	sub    $0x8,%esp
c01057b2:	ff 75 0c             	pushl  0xc(%ebp)
c01057b5:	50                   	push   %eax
c01057b6:	8b 45 08             	mov    0x8(%ebp),%eax
c01057b9:	ff d0                	call   *%eax
c01057bb:	83 c4 10             	add    $0x10,%esp
}
c01057be:	90                   	nop
c01057bf:	c9                   	leave  
c01057c0:	c3                   	ret    

c01057c1 <getuint>:
 * getuint - get an unsigned int of various possible sizes from a varargs list
 * @ap:         a varargs list pointer
 * @lflag:      determines the size of the vararg that @ap points to
 * */
static unsigned long long
getuint(va_list *ap, int lflag) {
c01057c1:	f3 0f 1e fb          	endbr32 
c01057c5:	55                   	push   %ebp
c01057c6:	89 e5                	mov    %esp,%ebp
    if (lflag >= 2) {
c01057c8:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
c01057cc:	7e 14                	jle    c01057e2 <getuint+0x21>
        return va_arg(*ap, unsigned long long);
c01057ce:	8b 45 08             	mov    0x8(%ebp),%eax
c01057d1:	8b 00                	mov    (%eax),%eax
c01057d3:	8d 48 08             	lea    0x8(%eax),%ecx
c01057d6:	8b 55 08             	mov    0x8(%ebp),%edx
c01057d9:	89 0a                	mov    %ecx,(%edx)
c01057db:	8b 50 04             	mov    0x4(%eax),%edx
c01057de:	8b 00                	mov    (%eax),%eax
c01057e0:	eb 30                	jmp    c0105812 <getuint+0x51>
    }
    else if (lflag) {
c01057e2:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
c01057e6:	74 16                	je     c01057fe <getuint+0x3d>
        return va_arg(*ap, unsigned long);
c01057e8:	8b 45 08             	mov    0x8(%ebp),%eax
c01057eb:	8b 00                	mov    (%eax),%eax
c01057ed:	8d 48 04             	lea    0x4(%eax),%ecx
c01057f0:	8b 55 08             	mov    0x8(%ebp),%edx
c01057f3:	89 0a                	mov    %ecx,(%edx)
c01057f5:	8b 00                	mov    (%eax),%eax
c01057f7:	ba 00 00 00 00       	mov    $0x0,%edx
c01057fc:	eb 14                	jmp    c0105812 <getuint+0x51>
    }
    else {
        return va_arg(*ap, unsigned int);
c01057fe:	8b 45 08             	mov    0x8(%ebp),%eax
c0105801:	8b 00                	mov    (%eax),%eax
c0105803:	8d 48 04             	lea    0x4(%eax),%ecx
c0105806:	8b 55 08             	mov    0x8(%ebp),%edx
c0105809:	89 0a                	mov    %ecx,(%edx)
c010580b:	8b 00                	mov    (%eax),%eax
c010580d:	ba 00 00 00 00       	mov    $0x0,%edx
    }
}
c0105812:	5d                   	pop    %ebp
c0105813:	c3                   	ret    

c0105814 <getint>:
 * getint - same as getuint but signed, we can't use getuint because of sign extension
 * @ap:         a varargs list pointer
 * @lflag:      determines the size of the vararg that @ap points to
 * */
static long long
getint(va_list *ap, int lflag) {
c0105814:	f3 0f 1e fb          	endbr32 
c0105818:	55                   	push   %ebp
c0105819:	89 e5                	mov    %esp,%ebp
    if (lflag >= 2) {
c010581b:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
c010581f:	7e 14                	jle    c0105835 <getint+0x21>
        return va_arg(*ap, long long);
c0105821:	8b 45 08             	mov    0x8(%ebp),%eax
c0105824:	8b 00                	mov    (%eax),%eax
c0105826:	8d 48 08             	lea    0x8(%eax),%ecx
c0105829:	8b 55 08             	mov    0x8(%ebp),%edx
c010582c:	89 0a                	mov    %ecx,(%edx)
c010582e:	8b 50 04             	mov    0x4(%eax),%edx
c0105831:	8b 00                	mov    (%eax),%eax
c0105833:	eb 28                	jmp    c010585d <getint+0x49>
    }
    else if (lflag) {
c0105835:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
c0105839:	74 12                	je     c010584d <getint+0x39>
        return va_arg(*ap, long);
c010583b:	8b 45 08             	mov    0x8(%ebp),%eax
c010583e:	8b 00                	mov    (%eax),%eax
c0105840:	8d 48 04             	lea    0x4(%eax),%ecx
c0105843:	8b 55 08             	mov    0x8(%ebp),%edx
c0105846:	89 0a                	mov    %ecx,(%edx)
c0105848:	8b 00                	mov    (%eax),%eax
c010584a:	99                   	cltd   
c010584b:	eb 10                	jmp    c010585d <getint+0x49>
    }
    else {
        return va_arg(*ap, int);
c010584d:	8b 45 08             	mov    0x8(%ebp),%eax
c0105850:	8b 00                	mov    (%eax),%eax
c0105852:	8d 48 04             	lea    0x4(%eax),%ecx
c0105855:	8b 55 08             	mov    0x8(%ebp),%edx
c0105858:	89 0a                	mov    %ecx,(%edx)
c010585a:	8b 00                	mov    (%eax),%eax
c010585c:	99                   	cltd   
    }
}
c010585d:	5d                   	pop    %ebp
c010585e:	c3                   	ret    

c010585f <printfmt>:
 * @putch:      specified putch function, print a single character
 * @putdat:     used by @putch function
 * @fmt:        the format string to use
 * */
void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
c010585f:	f3 0f 1e fb          	endbr32 
c0105863:	55                   	push   %ebp
c0105864:	89 e5                	mov    %esp,%ebp
c0105866:	83 ec 18             	sub    $0x18,%esp
    va_list ap;

    va_start(ap, fmt);
c0105869:	8d 45 14             	lea    0x14(%ebp),%eax
c010586c:	89 45 f4             	mov    %eax,-0xc(%ebp)
    vprintfmt(putch, putdat, fmt, ap);
c010586f:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0105872:	50                   	push   %eax
c0105873:	ff 75 10             	pushl  0x10(%ebp)
c0105876:	ff 75 0c             	pushl  0xc(%ebp)
c0105879:	ff 75 08             	pushl  0x8(%ebp)
c010587c:	e8 06 00 00 00       	call   c0105887 <vprintfmt>
c0105881:	83 c4 10             	add    $0x10,%esp
    va_end(ap);
}
c0105884:	90                   	nop
c0105885:	c9                   	leave  
c0105886:	c3                   	ret    

c0105887 <vprintfmt>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want printfmt() instead.
 * */
void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap) {
c0105887:	f3 0f 1e fb          	endbr32 
c010588b:	55                   	push   %ebp
c010588c:	89 e5                	mov    %esp,%ebp
c010588e:	56                   	push   %esi
c010588f:	53                   	push   %ebx
c0105890:	83 ec 20             	sub    $0x20,%esp
    register int ch, err;
    unsigned long long num;
    int base, width, precision, lflag, altflag;

    while (1) {
        while ((ch = *(unsigned char *)fmt ++) != '%') {
c0105893:	eb 17                	jmp    c01058ac <vprintfmt+0x25>
            if (ch == '\0') {
c0105895:	85 db                	test   %ebx,%ebx
c0105897:	0f 84 8f 03 00 00    	je     c0105c2c <vprintfmt+0x3a5>
                return;
            }
            putch(ch, putdat);
c010589d:	83 ec 08             	sub    $0x8,%esp
c01058a0:	ff 75 0c             	pushl  0xc(%ebp)
c01058a3:	53                   	push   %ebx
c01058a4:	8b 45 08             	mov    0x8(%ebp),%eax
c01058a7:	ff d0                	call   *%eax
c01058a9:	83 c4 10             	add    $0x10,%esp
        while ((ch = *(unsigned char *)fmt ++) != '%') {
c01058ac:	8b 45 10             	mov    0x10(%ebp),%eax
c01058af:	8d 50 01             	lea    0x1(%eax),%edx
c01058b2:	89 55 10             	mov    %edx,0x10(%ebp)
c01058b5:	0f b6 00             	movzbl (%eax),%eax
c01058b8:	0f b6 d8             	movzbl %al,%ebx
c01058bb:	83 fb 25             	cmp    $0x25,%ebx
c01058be:	75 d5                	jne    c0105895 <vprintfmt+0xe>
        }

        // Process a %-escape sequence
        char padc = ' ';
c01058c0:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
        width = precision = -1;
c01058c4:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
c01058cb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c01058ce:	89 45 e8             	mov    %eax,-0x18(%ebp)
        lflag = altflag = 0;
c01058d1:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
c01058d8:	8b 45 dc             	mov    -0x24(%ebp),%eax
c01058db:	89 45 e0             	mov    %eax,-0x20(%ebp)

    reswitch:
        switch (ch = *(unsigned char *)fmt ++) {
c01058de:	8b 45 10             	mov    0x10(%ebp),%eax
c01058e1:	8d 50 01             	lea    0x1(%eax),%edx
c01058e4:	89 55 10             	mov    %edx,0x10(%ebp)
c01058e7:	0f b6 00             	movzbl (%eax),%eax
c01058ea:	0f b6 d8             	movzbl %al,%ebx
c01058ed:	8d 43 dd             	lea    -0x23(%ebx),%eax
c01058f0:	83 f8 55             	cmp    $0x55,%eax
c01058f3:	0f 87 06 03 00 00    	ja     c0105bff <vprintfmt+0x378>
c01058f9:	8b 04 85 a8 6e 10 c0 	mov    -0x3fef9158(,%eax,4),%eax
c0105900:	3e ff e0             	notrack jmp *%eax

        // flag to pad on the right
        case '-':
            padc = '-';
c0105903:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
            goto reswitch;
c0105907:	eb d5                	jmp    c01058de <vprintfmt+0x57>

        // flag to pad with 0's instead of spaces
        case '0':
            padc = '0';
c0105909:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
            goto reswitch;
c010590d:	eb cf                	jmp    c01058de <vprintfmt+0x57>

        // width field
        case '1' ... '9':
            for (precision = 0; ; ++ fmt) {
c010590f:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
                precision = precision * 10 + ch - '0';
c0105916:	8b 55 e4             	mov    -0x1c(%ebp),%edx
c0105919:	89 d0                	mov    %edx,%eax
c010591b:	c1 e0 02             	shl    $0x2,%eax
c010591e:	01 d0                	add    %edx,%eax
c0105920:	01 c0                	add    %eax,%eax
c0105922:	01 d8                	add    %ebx,%eax
c0105924:	83 e8 30             	sub    $0x30,%eax
c0105927:	89 45 e4             	mov    %eax,-0x1c(%ebp)
                ch = *fmt;
c010592a:	8b 45 10             	mov    0x10(%ebp),%eax
c010592d:	0f b6 00             	movzbl (%eax),%eax
c0105930:	0f be d8             	movsbl %al,%ebx
                if (ch < '0' || ch > '9') {
c0105933:	83 fb 2f             	cmp    $0x2f,%ebx
c0105936:	7e 39                	jle    c0105971 <vprintfmt+0xea>
c0105938:	83 fb 39             	cmp    $0x39,%ebx
c010593b:	7f 34                	jg     c0105971 <vprintfmt+0xea>
            for (precision = 0; ; ++ fmt) {
c010593d:	83 45 10 01          	addl   $0x1,0x10(%ebp)
                precision = precision * 10 + ch - '0';
c0105941:	eb d3                	jmp    c0105916 <vprintfmt+0x8f>
                }
            }
            goto process_precision;

        case '*':
            precision = va_arg(ap, int);
c0105943:	8b 45 14             	mov    0x14(%ebp),%eax
c0105946:	8d 50 04             	lea    0x4(%eax),%edx
c0105949:	89 55 14             	mov    %edx,0x14(%ebp)
c010594c:	8b 00                	mov    (%eax),%eax
c010594e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            goto process_precision;
c0105951:	eb 1f                	jmp    c0105972 <vprintfmt+0xeb>

        case '.':
            if (width < 0)
c0105953:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
c0105957:	79 85                	jns    c01058de <vprintfmt+0x57>
                width = 0;
c0105959:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
            goto reswitch;
c0105960:	e9 79 ff ff ff       	jmp    c01058de <vprintfmt+0x57>

        case '#':
            altflag = 1;
c0105965:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
            goto reswitch;
c010596c:	e9 6d ff ff ff       	jmp    c01058de <vprintfmt+0x57>
            goto process_precision;
c0105971:	90                   	nop

        process_precision:
            if (width < 0)
c0105972:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
c0105976:	0f 89 62 ff ff ff    	jns    c01058de <vprintfmt+0x57>
                width = precision, precision = -1;
c010597c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c010597f:	89 45 e8             	mov    %eax,-0x18(%ebp)
c0105982:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
            goto reswitch;
c0105989:	e9 50 ff ff ff       	jmp    c01058de <vprintfmt+0x57>

        // long flag (doubled for long long)
        case 'l':
            lflag ++;
c010598e:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
            goto reswitch;
c0105992:	e9 47 ff ff ff       	jmp    c01058de <vprintfmt+0x57>

        // character
        case 'c':
            putch(va_arg(ap, int), putdat);
c0105997:	8b 45 14             	mov    0x14(%ebp),%eax
c010599a:	8d 50 04             	lea    0x4(%eax),%edx
c010599d:	89 55 14             	mov    %edx,0x14(%ebp)
c01059a0:	8b 00                	mov    (%eax),%eax
c01059a2:	83 ec 08             	sub    $0x8,%esp
c01059a5:	ff 75 0c             	pushl  0xc(%ebp)
c01059a8:	50                   	push   %eax
c01059a9:	8b 45 08             	mov    0x8(%ebp),%eax
c01059ac:	ff d0                	call   *%eax
c01059ae:	83 c4 10             	add    $0x10,%esp
            break;
c01059b1:	e9 71 02 00 00       	jmp    c0105c27 <vprintfmt+0x3a0>

        // error message
        case 'e':
            err = va_arg(ap, int);
c01059b6:	8b 45 14             	mov    0x14(%ebp),%eax
c01059b9:	8d 50 04             	lea    0x4(%eax),%edx
c01059bc:	89 55 14             	mov    %edx,0x14(%ebp)
c01059bf:	8b 18                	mov    (%eax),%ebx
            if (err < 0) {
c01059c1:	85 db                	test   %ebx,%ebx
c01059c3:	79 02                	jns    c01059c7 <vprintfmt+0x140>
                err = -err;
c01059c5:	f7 db                	neg    %ebx
            }
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
c01059c7:	83 fb 06             	cmp    $0x6,%ebx
c01059ca:	7f 0b                	jg     c01059d7 <vprintfmt+0x150>
c01059cc:	8b 34 9d 68 6e 10 c0 	mov    -0x3fef9198(,%ebx,4),%esi
c01059d3:	85 f6                	test   %esi,%esi
c01059d5:	75 19                	jne    c01059f0 <vprintfmt+0x169>
                printfmt(putch, putdat, "error %d", err);
c01059d7:	53                   	push   %ebx
c01059d8:	68 95 6e 10 c0       	push   $0xc0106e95
c01059dd:	ff 75 0c             	pushl  0xc(%ebp)
c01059e0:	ff 75 08             	pushl  0x8(%ebp)
c01059e3:	e8 77 fe ff ff       	call   c010585f <printfmt>
c01059e8:	83 c4 10             	add    $0x10,%esp
            }
            else {
                printfmt(putch, putdat, "%s", p);
            }
            break;
c01059eb:	e9 37 02 00 00       	jmp    c0105c27 <vprintfmt+0x3a0>
                printfmt(putch, putdat, "%s", p);
c01059f0:	56                   	push   %esi
c01059f1:	68 9e 6e 10 c0       	push   $0xc0106e9e
c01059f6:	ff 75 0c             	pushl  0xc(%ebp)
c01059f9:	ff 75 08             	pushl  0x8(%ebp)
c01059fc:	e8 5e fe ff ff       	call   c010585f <printfmt>
c0105a01:	83 c4 10             	add    $0x10,%esp
            break;
c0105a04:	e9 1e 02 00 00       	jmp    c0105c27 <vprintfmt+0x3a0>

        // string
        case 's':
            if ((p = va_arg(ap, char *)) == NULL) {
c0105a09:	8b 45 14             	mov    0x14(%ebp),%eax
c0105a0c:	8d 50 04             	lea    0x4(%eax),%edx
c0105a0f:	89 55 14             	mov    %edx,0x14(%ebp)
c0105a12:	8b 30                	mov    (%eax),%esi
c0105a14:	85 f6                	test   %esi,%esi
c0105a16:	75 05                	jne    c0105a1d <vprintfmt+0x196>
                p = "(null)";
c0105a18:	be a1 6e 10 c0       	mov    $0xc0106ea1,%esi
            }
            if (width > 0 && padc != '-') {
c0105a1d:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
c0105a21:	7e 76                	jle    c0105a99 <vprintfmt+0x212>
c0105a23:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
c0105a27:	74 70                	je     c0105a99 <vprintfmt+0x212>
                for (width -= strnlen(p, precision); width > 0; width --) {
c0105a29:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c0105a2c:	83 ec 08             	sub    $0x8,%esp
c0105a2f:	50                   	push   %eax
c0105a30:	56                   	push   %esi
c0105a31:	e8 db f7 ff ff       	call   c0105211 <strnlen>
c0105a36:	83 c4 10             	add    $0x10,%esp
c0105a39:	8b 55 e8             	mov    -0x18(%ebp),%edx
c0105a3c:	29 c2                	sub    %eax,%edx
c0105a3e:	89 d0                	mov    %edx,%eax
c0105a40:	89 45 e8             	mov    %eax,-0x18(%ebp)
c0105a43:	eb 17                	jmp    c0105a5c <vprintfmt+0x1d5>
                    putch(padc, putdat);
c0105a45:	0f be 45 db          	movsbl -0x25(%ebp),%eax
c0105a49:	83 ec 08             	sub    $0x8,%esp
c0105a4c:	ff 75 0c             	pushl  0xc(%ebp)
c0105a4f:	50                   	push   %eax
c0105a50:	8b 45 08             	mov    0x8(%ebp),%eax
c0105a53:	ff d0                	call   *%eax
c0105a55:	83 c4 10             	add    $0x10,%esp
                for (width -= strnlen(p, precision); width > 0; width --) {
c0105a58:	83 6d e8 01          	subl   $0x1,-0x18(%ebp)
c0105a5c:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
c0105a60:	7f e3                	jg     c0105a45 <vprintfmt+0x1be>
                }
            }
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
c0105a62:	eb 35                	jmp    c0105a99 <vprintfmt+0x212>
                if (altflag && (ch < ' ' || ch > '~')) {
c0105a64:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
c0105a68:	74 1c                	je     c0105a86 <vprintfmt+0x1ff>
c0105a6a:	83 fb 1f             	cmp    $0x1f,%ebx
c0105a6d:	7e 05                	jle    c0105a74 <vprintfmt+0x1ed>
c0105a6f:	83 fb 7e             	cmp    $0x7e,%ebx
c0105a72:	7e 12                	jle    c0105a86 <vprintfmt+0x1ff>
                    putch('?', putdat);
c0105a74:	83 ec 08             	sub    $0x8,%esp
c0105a77:	ff 75 0c             	pushl  0xc(%ebp)
c0105a7a:	6a 3f                	push   $0x3f
c0105a7c:	8b 45 08             	mov    0x8(%ebp),%eax
c0105a7f:	ff d0                	call   *%eax
c0105a81:	83 c4 10             	add    $0x10,%esp
c0105a84:	eb 0f                	jmp    c0105a95 <vprintfmt+0x20e>
                }
                else {
                    putch(ch, putdat);
c0105a86:	83 ec 08             	sub    $0x8,%esp
c0105a89:	ff 75 0c             	pushl  0xc(%ebp)
c0105a8c:	53                   	push   %ebx
c0105a8d:	8b 45 08             	mov    0x8(%ebp),%eax
c0105a90:	ff d0                	call   *%eax
c0105a92:	83 c4 10             	add    $0x10,%esp
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
c0105a95:	83 6d e8 01          	subl   $0x1,-0x18(%ebp)
c0105a99:	89 f0                	mov    %esi,%eax
c0105a9b:	8d 70 01             	lea    0x1(%eax),%esi
c0105a9e:	0f b6 00             	movzbl (%eax),%eax
c0105aa1:	0f be d8             	movsbl %al,%ebx
c0105aa4:	85 db                	test   %ebx,%ebx
c0105aa6:	74 26                	je     c0105ace <vprintfmt+0x247>
c0105aa8:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
c0105aac:	78 b6                	js     c0105a64 <vprintfmt+0x1dd>
c0105aae:	83 6d e4 01          	subl   $0x1,-0x1c(%ebp)
c0105ab2:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
c0105ab6:	79 ac                	jns    c0105a64 <vprintfmt+0x1dd>
                }
            }
            for (; width > 0; width --) {
c0105ab8:	eb 14                	jmp    c0105ace <vprintfmt+0x247>
                putch(' ', putdat);
c0105aba:	83 ec 08             	sub    $0x8,%esp
c0105abd:	ff 75 0c             	pushl  0xc(%ebp)
c0105ac0:	6a 20                	push   $0x20
c0105ac2:	8b 45 08             	mov    0x8(%ebp),%eax
c0105ac5:	ff d0                	call   *%eax
c0105ac7:	83 c4 10             	add    $0x10,%esp
            for (; width > 0; width --) {
c0105aca:	83 6d e8 01          	subl   $0x1,-0x18(%ebp)
c0105ace:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
c0105ad2:	7f e6                	jg     c0105aba <vprintfmt+0x233>
            }
            break;
c0105ad4:	e9 4e 01 00 00       	jmp    c0105c27 <vprintfmt+0x3a0>

        // (signed) decimal
        case 'd':
            num = getint(&ap, lflag);
c0105ad9:	83 ec 08             	sub    $0x8,%esp
c0105adc:	ff 75 e0             	pushl  -0x20(%ebp)
c0105adf:	8d 45 14             	lea    0x14(%ebp),%eax
c0105ae2:	50                   	push   %eax
c0105ae3:	e8 2c fd ff ff       	call   c0105814 <getint>
c0105ae8:	83 c4 10             	add    $0x10,%esp
c0105aeb:	89 45 f0             	mov    %eax,-0x10(%ebp)
c0105aee:	89 55 f4             	mov    %edx,-0xc(%ebp)
            if ((long long)num < 0) {
c0105af1:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0105af4:	8b 55 f4             	mov    -0xc(%ebp),%edx
c0105af7:	85 d2                	test   %edx,%edx
c0105af9:	79 23                	jns    c0105b1e <vprintfmt+0x297>
                putch('-', putdat);
c0105afb:	83 ec 08             	sub    $0x8,%esp
c0105afe:	ff 75 0c             	pushl  0xc(%ebp)
c0105b01:	6a 2d                	push   $0x2d
c0105b03:	8b 45 08             	mov    0x8(%ebp),%eax
c0105b06:	ff d0                	call   *%eax
c0105b08:	83 c4 10             	add    $0x10,%esp
                num = -(long long)num;
c0105b0b:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0105b0e:	8b 55 f4             	mov    -0xc(%ebp),%edx
c0105b11:	f7 d8                	neg    %eax
c0105b13:	83 d2 00             	adc    $0x0,%edx
c0105b16:	f7 da                	neg    %edx
c0105b18:	89 45 f0             	mov    %eax,-0x10(%ebp)
c0105b1b:	89 55 f4             	mov    %edx,-0xc(%ebp)
            }
            base = 10;
c0105b1e:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
            goto number;
c0105b25:	e9 9f 00 00 00       	jmp    c0105bc9 <vprintfmt+0x342>

        // unsigned decimal
        case 'u':
            num = getuint(&ap, lflag);
c0105b2a:	83 ec 08             	sub    $0x8,%esp
c0105b2d:	ff 75 e0             	pushl  -0x20(%ebp)
c0105b30:	8d 45 14             	lea    0x14(%ebp),%eax
c0105b33:	50                   	push   %eax
c0105b34:	e8 88 fc ff ff       	call   c01057c1 <getuint>
c0105b39:	83 c4 10             	add    $0x10,%esp
c0105b3c:	89 45 f0             	mov    %eax,-0x10(%ebp)
c0105b3f:	89 55 f4             	mov    %edx,-0xc(%ebp)
            base = 10;
c0105b42:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
            goto number;
c0105b49:	eb 7e                	jmp    c0105bc9 <vprintfmt+0x342>

        // (unsigned) octal
        case 'o':
            num = getuint(&ap, lflag);
c0105b4b:	83 ec 08             	sub    $0x8,%esp
c0105b4e:	ff 75 e0             	pushl  -0x20(%ebp)
c0105b51:	8d 45 14             	lea    0x14(%ebp),%eax
c0105b54:	50                   	push   %eax
c0105b55:	e8 67 fc ff ff       	call   c01057c1 <getuint>
c0105b5a:	83 c4 10             	add    $0x10,%esp
c0105b5d:	89 45 f0             	mov    %eax,-0x10(%ebp)
c0105b60:	89 55 f4             	mov    %edx,-0xc(%ebp)
            base = 8;
c0105b63:	c7 45 ec 08 00 00 00 	movl   $0x8,-0x14(%ebp)
            goto number;
c0105b6a:	eb 5d                	jmp    c0105bc9 <vprintfmt+0x342>

        // pointer
        case 'p':
            putch('0', putdat);
c0105b6c:	83 ec 08             	sub    $0x8,%esp
c0105b6f:	ff 75 0c             	pushl  0xc(%ebp)
c0105b72:	6a 30                	push   $0x30
c0105b74:	8b 45 08             	mov    0x8(%ebp),%eax
c0105b77:	ff d0                	call   *%eax
c0105b79:	83 c4 10             	add    $0x10,%esp
            putch('x', putdat);
c0105b7c:	83 ec 08             	sub    $0x8,%esp
c0105b7f:	ff 75 0c             	pushl  0xc(%ebp)
c0105b82:	6a 78                	push   $0x78
c0105b84:	8b 45 08             	mov    0x8(%ebp),%eax
c0105b87:	ff d0                	call   *%eax
c0105b89:	83 c4 10             	add    $0x10,%esp
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
c0105b8c:	8b 45 14             	mov    0x14(%ebp),%eax
c0105b8f:	8d 50 04             	lea    0x4(%eax),%edx
c0105b92:	89 55 14             	mov    %edx,0x14(%ebp)
c0105b95:	8b 00                	mov    (%eax),%eax
c0105b97:	89 45 f0             	mov    %eax,-0x10(%ebp)
c0105b9a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
            base = 16;
c0105ba1:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
            goto number;
c0105ba8:	eb 1f                	jmp    c0105bc9 <vprintfmt+0x342>

        // (unsigned) hexadecimal
        case 'x':
            num = getuint(&ap, lflag);
c0105baa:	83 ec 08             	sub    $0x8,%esp
c0105bad:	ff 75 e0             	pushl  -0x20(%ebp)
c0105bb0:	8d 45 14             	lea    0x14(%ebp),%eax
c0105bb3:	50                   	push   %eax
c0105bb4:	e8 08 fc ff ff       	call   c01057c1 <getuint>
c0105bb9:	83 c4 10             	add    $0x10,%esp
c0105bbc:	89 45 f0             	mov    %eax,-0x10(%ebp)
c0105bbf:	89 55 f4             	mov    %edx,-0xc(%ebp)
            base = 16;
c0105bc2:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
        number:
            printnum(putch, putdat, num, base, width, padc);
c0105bc9:	0f be 55 db          	movsbl -0x25(%ebp),%edx
c0105bcd:	8b 45 ec             	mov    -0x14(%ebp),%eax
c0105bd0:	83 ec 04             	sub    $0x4,%esp
c0105bd3:	52                   	push   %edx
c0105bd4:	ff 75 e8             	pushl  -0x18(%ebp)
c0105bd7:	50                   	push   %eax
c0105bd8:	ff 75 f4             	pushl  -0xc(%ebp)
c0105bdb:	ff 75 f0             	pushl  -0x10(%ebp)
c0105bde:	ff 75 0c             	pushl  0xc(%ebp)
c0105be1:	ff 75 08             	pushl  0x8(%ebp)
c0105be4:	e8 e8 fa ff ff       	call   c01056d1 <printnum>
c0105be9:	83 c4 20             	add    $0x20,%esp
            break;
c0105bec:	eb 39                	jmp    c0105c27 <vprintfmt+0x3a0>

        // escaped '%' character
        case '%':
            putch(ch, putdat);
c0105bee:	83 ec 08             	sub    $0x8,%esp
c0105bf1:	ff 75 0c             	pushl  0xc(%ebp)
c0105bf4:	53                   	push   %ebx
c0105bf5:	8b 45 08             	mov    0x8(%ebp),%eax
c0105bf8:	ff d0                	call   *%eax
c0105bfa:	83 c4 10             	add    $0x10,%esp
            break;
c0105bfd:	eb 28                	jmp    c0105c27 <vprintfmt+0x3a0>

        // unrecognized escape sequence - just print it literally
        default:
            putch('%', putdat);
c0105bff:	83 ec 08             	sub    $0x8,%esp
c0105c02:	ff 75 0c             	pushl  0xc(%ebp)
c0105c05:	6a 25                	push   $0x25
c0105c07:	8b 45 08             	mov    0x8(%ebp),%eax
c0105c0a:	ff d0                	call   *%eax
c0105c0c:	83 c4 10             	add    $0x10,%esp
            for (fmt --; fmt[-1] != '%'; fmt --)
c0105c0f:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
c0105c13:	eb 04                	jmp    c0105c19 <vprintfmt+0x392>
c0105c15:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
c0105c19:	8b 45 10             	mov    0x10(%ebp),%eax
c0105c1c:	83 e8 01             	sub    $0x1,%eax
c0105c1f:	0f b6 00             	movzbl (%eax),%eax
c0105c22:	3c 25                	cmp    $0x25,%al
c0105c24:	75 ef                	jne    c0105c15 <vprintfmt+0x38e>
                /* do nothing */;
            break;
c0105c26:	90                   	nop
    while (1) {
c0105c27:	e9 67 fc ff ff       	jmp    c0105893 <vprintfmt+0xc>
                return;
c0105c2c:	90                   	nop
        }
    }
}
c0105c2d:	8d 65 f8             	lea    -0x8(%ebp),%esp
c0105c30:	5b                   	pop    %ebx
c0105c31:	5e                   	pop    %esi
c0105c32:	5d                   	pop    %ebp
c0105c33:	c3                   	ret    

c0105c34 <sprintputch>:
 * sprintputch - 'print' a single character in a buffer
 * @ch:         the character will be printed
 * @b:          the buffer to place the character @ch
 * */
static void
sprintputch(int ch, struct sprintbuf *b) {
c0105c34:	f3 0f 1e fb          	endbr32 
c0105c38:	55                   	push   %ebp
c0105c39:	89 e5                	mov    %esp,%ebp
    b->cnt ++;
c0105c3b:	8b 45 0c             	mov    0xc(%ebp),%eax
c0105c3e:	8b 40 08             	mov    0x8(%eax),%eax
c0105c41:	8d 50 01             	lea    0x1(%eax),%edx
c0105c44:	8b 45 0c             	mov    0xc(%ebp),%eax
c0105c47:	89 50 08             	mov    %edx,0x8(%eax)
    if (b->buf < b->ebuf) {
c0105c4a:	8b 45 0c             	mov    0xc(%ebp),%eax
c0105c4d:	8b 10                	mov    (%eax),%edx
c0105c4f:	8b 45 0c             	mov    0xc(%ebp),%eax
c0105c52:	8b 40 04             	mov    0x4(%eax),%eax
c0105c55:	39 c2                	cmp    %eax,%edx
c0105c57:	73 12                	jae    c0105c6b <sprintputch+0x37>
        *b->buf ++ = ch;
c0105c59:	8b 45 0c             	mov    0xc(%ebp),%eax
c0105c5c:	8b 00                	mov    (%eax),%eax
c0105c5e:	8d 48 01             	lea    0x1(%eax),%ecx
c0105c61:	8b 55 0c             	mov    0xc(%ebp),%edx
c0105c64:	89 0a                	mov    %ecx,(%edx)
c0105c66:	8b 55 08             	mov    0x8(%ebp),%edx
c0105c69:	88 10                	mov    %dl,(%eax)
    }
}
c0105c6b:	90                   	nop
c0105c6c:	5d                   	pop    %ebp
c0105c6d:	c3                   	ret    

c0105c6e <snprintf>:
 * @str:        the buffer to place the result into
 * @size:       the size of buffer, including the trailing null space
 * @fmt:        the format string to use
 * */
int
snprintf(char *str, size_t size, const char *fmt, ...) {
c0105c6e:	f3 0f 1e fb          	endbr32 
c0105c72:	55                   	push   %ebp
c0105c73:	89 e5                	mov    %esp,%ebp
c0105c75:	83 ec 18             	sub    $0x18,%esp
    va_list ap;
    int cnt;
    va_start(ap, fmt);
c0105c78:	8d 45 14             	lea    0x14(%ebp),%eax
c0105c7b:	89 45 f0             	mov    %eax,-0x10(%ebp)
    cnt = vsnprintf(str, size, fmt, ap);
c0105c7e:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0105c81:	50                   	push   %eax
c0105c82:	ff 75 10             	pushl  0x10(%ebp)
c0105c85:	ff 75 0c             	pushl  0xc(%ebp)
c0105c88:	ff 75 08             	pushl  0x8(%ebp)
c0105c8b:	e8 0b 00 00 00       	call   c0105c9b <vsnprintf>
c0105c90:	83 c4 10             	add    $0x10,%esp
c0105c93:	89 45 f4             	mov    %eax,-0xc(%ebp)
    va_end(ap);
    return cnt;
c0105c96:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
c0105c99:	c9                   	leave  
c0105c9a:	c3                   	ret    

c0105c9b <vsnprintf>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want snprintf() instead.
 * */
int
vsnprintf(char *str, size_t size, const char *fmt, va_list ap) {
c0105c9b:	f3 0f 1e fb          	endbr32 
c0105c9f:	55                   	push   %ebp
c0105ca0:	89 e5                	mov    %esp,%ebp
c0105ca2:	83 ec 18             	sub    $0x18,%esp
    struct sprintbuf b = {str, str + size - 1, 0};
c0105ca5:	8b 45 08             	mov    0x8(%ebp),%eax
c0105ca8:	89 45 ec             	mov    %eax,-0x14(%ebp)
c0105cab:	8b 45 0c             	mov    0xc(%ebp),%eax
c0105cae:	8d 50 ff             	lea    -0x1(%eax),%edx
c0105cb1:	8b 45 08             	mov    0x8(%ebp),%eax
c0105cb4:	01 d0                	add    %edx,%eax
c0105cb6:	89 45 f0             	mov    %eax,-0x10(%ebp)
c0105cb9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if (str == NULL || b.buf > b.ebuf) {
c0105cc0:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
c0105cc4:	74 0a                	je     c0105cd0 <vsnprintf+0x35>
c0105cc6:	8b 55 ec             	mov    -0x14(%ebp),%edx
c0105cc9:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0105ccc:	39 c2                	cmp    %eax,%edx
c0105cce:	76 07                	jbe    c0105cd7 <vsnprintf+0x3c>
        return -E_INVAL;
c0105cd0:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
c0105cd5:	eb 20                	jmp    c0105cf7 <vsnprintf+0x5c>
    }
    // print the string to the buffer
    vprintfmt((void*)sprintputch, &b, fmt, ap);
c0105cd7:	ff 75 14             	pushl  0x14(%ebp)
c0105cda:	ff 75 10             	pushl  0x10(%ebp)
c0105cdd:	8d 45 ec             	lea    -0x14(%ebp),%eax
c0105ce0:	50                   	push   %eax
c0105ce1:	68 34 5c 10 c0       	push   $0xc0105c34
c0105ce6:	e8 9c fb ff ff       	call   c0105887 <vprintfmt>
c0105ceb:	83 c4 10             	add    $0x10,%esp
    // null terminate the buffer
    *b.buf = '\0';
c0105cee:	8b 45 ec             	mov    -0x14(%ebp),%eax
c0105cf1:	c6 00 00             	movb   $0x0,(%eax)
    return b.cnt;
c0105cf4:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
c0105cf7:	c9                   	leave  
c0105cf8:	c3                   	ret    
