
bomb:     file format elf64-x86-64


Disassembly of section .init:

0000000000400b38 <_init>:
  400b38:	48 83 ec 08          	sub    $0x8,%rsp
  400b3c:	48 8b 05 b5 34 20 00 	mov    0x2034b5(%rip),%rax        # 603ff8 <__gmon_start__>
  400b43:	48 85 c0             	test   %rax,%rax
  400b46:	74 05                	je     400b4d <_init+0x15>
  400b48:	e8 f3 01 00 00       	callq  400d40 <__gmon_start__@plt>
  400b4d:	48 83 c4 08          	add    $0x8,%rsp
  400b51:	c3                   	retq   

Disassembly of section .plt:

0000000000400b60 <.plt>:
  400b60:	ff 35 a2 34 20 00    	pushq  0x2034a2(%rip)        # 604008 <_GLOBAL_OFFSET_TABLE_+0x8>
  400b66:	ff 25 a4 34 20 00    	jmpq   *0x2034a4(%rip)        # 604010 <_GLOBAL_OFFSET_TABLE_+0x10>
  400b6c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000400b70 <__strcat_chk@plt>:
  400b70:	ff 25 a2 34 20 00    	jmpq   *0x2034a2(%rip)        # 604018 <__strcat_chk@GLIBC_2.3.4>
  400b76:	68 00 00 00 00       	pushq  $0x0
  400b7b:	e9 e0 ff ff ff       	jmpq   400b60 <.plt>

0000000000400b80 <getenv@plt>:
  400b80:	ff 25 9a 34 20 00    	jmpq   *0x20349a(%rip)        # 604020 <getenv@GLIBC_2.2.5>
  400b86:	68 01 00 00 00       	pushq  $0x1
  400b8b:	e9 d0 ff ff ff       	jmpq   400b60 <.plt>

0000000000400b90 <strcasecmp@plt>:
  400b90:	ff 25 92 34 20 00    	jmpq   *0x203492(%rip)        # 604028 <strcasecmp@GLIBC_2.2.5>
  400b96:	68 02 00 00 00       	pushq  $0x2
  400b9b:	e9 c0 ff ff ff       	jmpq   400b60 <.plt>

0000000000400ba0 <__errno_location@plt>:
  400ba0:	ff 25 8a 34 20 00    	jmpq   *0x20348a(%rip)        # 604030 <__errno_location@GLIBC_2.2.5>
  400ba6:	68 03 00 00 00       	pushq  $0x3
  400bab:	e9 b0 ff ff ff       	jmpq   400b60 <.plt>

0000000000400bb0 <strcpy@plt>:
  400bb0:	ff 25 82 34 20 00    	jmpq   *0x203482(%rip)        # 604038 <strcpy@GLIBC_2.2.5>
  400bb6:	68 04 00 00 00       	pushq  $0x4
  400bbb:	e9 a0 ff ff ff       	jmpq   400b60 <.plt>

0000000000400bc0 <puts@plt>:
  400bc0:	ff 25 7a 34 20 00    	jmpq   *0x20347a(%rip)        # 604040 <puts@GLIBC_2.2.5>
  400bc6:	68 05 00 00 00       	pushq  $0x5
  400bcb:	e9 90 ff ff ff       	jmpq   400b60 <.plt>

0000000000400bd0 <write@plt>:
  400bd0:	ff 25 72 34 20 00    	jmpq   *0x203472(%rip)        # 604048 <write@GLIBC_2.2.5>
  400bd6:	68 06 00 00 00       	pushq  $0x6
  400bdb:	e9 80 ff ff ff       	jmpq   400b60 <.plt>

0000000000400be0 <__stack_chk_fail@plt>:
  400be0:	ff 25 6a 34 20 00    	jmpq   *0x20346a(%rip)        # 604050 <__stack_chk_fail@GLIBC_2.4>
  400be6:	68 07 00 00 00       	pushq  $0x7
  400beb:	e9 70 ff ff ff       	jmpq   400b60 <.plt>

0000000000400bf0 <alarm@plt>:
  400bf0:	ff 25 62 34 20 00    	jmpq   *0x203462(%rip)        # 604058 <alarm@GLIBC_2.2.5>
  400bf6:	68 08 00 00 00       	pushq  $0x8
  400bfb:	e9 60 ff ff ff       	jmpq   400b60 <.plt>

0000000000400c00 <close@plt>:
  400c00:	ff 25 5a 34 20 00    	jmpq   *0x20345a(%rip)        # 604060 <close@GLIBC_2.2.5>
  400c06:	68 09 00 00 00       	pushq  $0x9
  400c0b:	e9 50 ff ff ff       	jmpq   400b60 <.plt>

0000000000400c10 <read@plt>:
  400c10:	ff 25 52 34 20 00    	jmpq   *0x203452(%rip)        # 604068 <read@GLIBC_2.2.5>
  400c16:	68 0a 00 00 00       	pushq  $0xa
  400c1b:	e9 40 ff ff ff       	jmpq   400b60 <.plt>

0000000000400c20 <__libc_start_main@plt>:
  400c20:	ff 25 4a 34 20 00    	jmpq   *0x20344a(%rip)        # 604070 <__libc_start_main@GLIBC_2.2.5>
  400c26:	68 0b 00 00 00       	pushq  $0xb
  400c2b:	e9 30 ff ff ff       	jmpq   400b60 <.plt>

0000000000400c30 <fgets@plt>:
  400c30:	ff 25 42 34 20 00    	jmpq   *0x203442(%rip)        # 604078 <fgets@GLIBC_2.2.5>
  400c36:	68 0c 00 00 00       	pushq  $0xc
  400c3b:	e9 20 ff ff ff       	jmpq   400b60 <.plt>

0000000000400c40 <signal@plt>:
  400c40:	ff 25 3a 34 20 00    	jmpq   *0x20343a(%rip)        # 604080 <signal@GLIBC_2.2.5>
  400c46:	68 0d 00 00 00       	pushq  $0xd
  400c4b:	e9 10 ff ff ff       	jmpq   400b60 <.plt>

0000000000400c50 <gethostbyname@plt>:
  400c50:	ff 25 32 34 20 00    	jmpq   *0x203432(%rip)        # 604088 <gethostbyname@GLIBC_2.2.5>
  400c56:	68 0e 00 00 00       	pushq  $0xe
  400c5b:	e9 00 ff ff ff       	jmpq   400b60 <.plt>

0000000000400c60 <__memmove_chk@plt>:
  400c60:	ff 25 2a 34 20 00    	jmpq   *0x20342a(%rip)        # 604090 <__memmove_chk@GLIBC_2.3.4>
  400c66:	68 0f 00 00 00       	pushq  $0xf
  400c6b:	e9 f0 fe ff ff       	jmpq   400b60 <.plt>

0000000000400c70 <strtol@plt>:
  400c70:	ff 25 22 34 20 00    	jmpq   *0x203422(%rip)        # 604098 <strtol@GLIBC_2.2.5>
  400c76:	68 10 00 00 00       	pushq  $0x10
  400c7b:	e9 e0 fe ff ff       	jmpq   400b60 <.plt>

0000000000400c80 <fflush@plt>:
  400c80:	ff 25 1a 34 20 00    	jmpq   *0x20341a(%rip)        # 6040a0 <fflush@GLIBC_2.2.5>
  400c86:	68 11 00 00 00       	pushq  $0x11
  400c8b:	e9 d0 fe ff ff       	jmpq   400b60 <.plt>

0000000000400c90 <__isoc99_sscanf@plt>:
  400c90:	ff 25 12 34 20 00    	jmpq   *0x203412(%rip)        # 6040a8 <__isoc99_sscanf@GLIBC_2.7>
  400c96:	68 12 00 00 00       	pushq  $0x12
  400c9b:	e9 c0 fe ff ff       	jmpq   400b60 <.plt>

0000000000400ca0 <__printf_chk@plt>:
  400ca0:	ff 25 0a 34 20 00    	jmpq   *0x20340a(%rip)        # 6040b0 <__printf_chk@GLIBC_2.3.4>
  400ca6:	68 13 00 00 00       	pushq  $0x13
  400cab:	e9 b0 fe ff ff       	jmpq   400b60 <.plt>

0000000000400cb0 <fopen@plt>:
  400cb0:	ff 25 02 34 20 00    	jmpq   *0x203402(%rip)        # 6040b8 <fopen@GLIBC_2.2.5>
  400cb6:	68 14 00 00 00       	pushq  $0x14
  400cbb:	e9 a0 fe ff ff       	jmpq   400b60 <.plt>

0000000000400cc0 <gethostname@plt>:
  400cc0:	ff 25 fa 33 20 00    	jmpq   *0x2033fa(%rip)        # 6040c0 <gethostname@GLIBC_2.2.5>
  400cc6:	68 15 00 00 00       	pushq  $0x15
  400ccb:	e9 90 fe ff ff       	jmpq   400b60 <.plt>

0000000000400cd0 <exit@plt>:
  400cd0:	ff 25 f2 33 20 00    	jmpq   *0x2033f2(%rip)        # 6040c8 <exit@GLIBC_2.2.5>
  400cd6:	68 16 00 00 00       	pushq  $0x16
  400cdb:	e9 80 fe ff ff       	jmpq   400b60 <.plt>

0000000000400ce0 <connect@plt>:
  400ce0:	ff 25 ea 33 20 00    	jmpq   *0x2033ea(%rip)        # 6040d0 <connect@GLIBC_2.2.5>
  400ce6:	68 17 00 00 00       	pushq  $0x17
  400ceb:	e9 70 fe ff ff       	jmpq   400b60 <.plt>

0000000000400cf0 <__fprintf_chk@plt>:
  400cf0:	ff 25 e2 33 20 00    	jmpq   *0x2033e2(%rip)        # 6040d8 <__fprintf_chk@GLIBC_2.3.4>
  400cf6:	68 18 00 00 00       	pushq  $0x18
  400cfb:	e9 60 fe ff ff       	jmpq   400b60 <.plt>

0000000000400d00 <sleep@plt>:
  400d00:	ff 25 da 33 20 00    	jmpq   *0x2033da(%rip)        # 6040e0 <sleep@GLIBC_2.2.5>
  400d06:	68 19 00 00 00       	pushq  $0x19
  400d0b:	e9 50 fe ff ff       	jmpq   400b60 <.plt>

0000000000400d10 <__ctype_b_loc@plt>:
  400d10:	ff 25 d2 33 20 00    	jmpq   *0x2033d2(%rip)        # 6040e8 <__ctype_b_loc@GLIBC_2.3>
  400d16:	68 1a 00 00 00       	pushq  $0x1a
  400d1b:	e9 40 fe ff ff       	jmpq   400b60 <.plt>

0000000000400d20 <__sprintf_chk@plt>:
  400d20:	ff 25 ca 33 20 00    	jmpq   *0x2033ca(%rip)        # 6040f0 <__sprintf_chk@GLIBC_2.3.4>
  400d26:	68 1b 00 00 00       	pushq  $0x1b
  400d2b:	e9 30 fe ff ff       	jmpq   400b60 <.plt>

0000000000400d30 <socket@plt>:
  400d30:	ff 25 c2 33 20 00    	jmpq   *0x2033c2(%rip)        # 6040f8 <socket@GLIBC_2.2.5>
  400d36:	68 1c 00 00 00       	pushq  $0x1c
  400d3b:	e9 20 fe ff ff       	jmpq   400b60 <.plt>

Disassembly of section .plt.got:

0000000000400d40 <__gmon_start__@plt>:
  400d40:	ff 25 b2 32 20 00    	jmpq   *0x2032b2(%rip)        # 603ff8 <__gmon_start__>
  400d46:	66 90                	xchg   %ax,%ax

Disassembly of section .text:

0000000000400d50 <_start>:
  400d50:	31 ed                	xor    %ebp,%ebp
  400d52:	49 89 d1             	mov    %rdx,%r9
  400d55:	5e                   	pop    %rsi
  400d56:	48 89 e2             	mov    %rsp,%rdx
  400d59:	48 83 e4 f0          	and    $0xfffffffffffffff0,%rsp
  400d5d:	50                   	push   %rax
  400d5e:	54                   	push   %rsp
  400d5f:	49 c7 c0 50 26 40 00 	mov    $0x402650,%r8
  400d66:	48 c7 c1 e0 25 40 00 	mov    $0x4025e0,%rcx
  400d6d:	48 c7 c7 46 0e 40 00 	mov    $0x400e46,%rdi
  400d74:	e8 a7 fe ff ff       	callq  400c20 <__libc_start_main@plt>
  400d79:	f4                   	hlt    
  400d7a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000400d80 <deregister_tm_clones>:
  400d80:	b8 87 47 60 00       	mov    $0x604787,%eax
  400d85:	55                   	push   %rbp
  400d86:	48 2d 80 47 60 00    	sub    $0x604780,%rax
  400d8c:	48 83 f8 0e          	cmp    $0xe,%rax
  400d90:	48 89 e5             	mov    %rsp,%rbp
  400d93:	76 1b                	jbe    400db0 <deregister_tm_clones+0x30>
  400d95:	b8 00 00 00 00       	mov    $0x0,%eax
  400d9a:	48 85 c0             	test   %rax,%rax
  400d9d:	74 11                	je     400db0 <deregister_tm_clones+0x30>
  400d9f:	5d                   	pop    %rbp
  400da0:	bf 80 47 60 00       	mov    $0x604780,%edi
  400da5:	ff e0                	jmpq   *%rax
  400da7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
  400dae:	00 00 
  400db0:	5d                   	pop    %rbp
  400db1:	c3                   	retq   
  400db2:	0f 1f 40 00          	nopl   0x0(%rax)
  400db6:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  400dbd:	00 00 00 

0000000000400dc0 <register_tm_clones>:
  400dc0:	be 80 47 60 00       	mov    $0x604780,%esi
  400dc5:	55                   	push   %rbp
  400dc6:	48 81 ee 80 47 60 00 	sub    $0x604780,%rsi
  400dcd:	48 c1 fe 03          	sar    $0x3,%rsi
  400dd1:	48 89 e5             	mov    %rsp,%rbp
  400dd4:	48 89 f0             	mov    %rsi,%rax
  400dd7:	48 c1 e8 3f          	shr    $0x3f,%rax
  400ddb:	48 01 c6             	add    %rax,%rsi
  400dde:	48 d1 fe             	sar    %rsi
  400de1:	74 15                	je     400df8 <register_tm_clones+0x38>
  400de3:	b8 00 00 00 00       	mov    $0x0,%eax
  400de8:	48 85 c0             	test   %rax,%rax
  400deb:	74 0b                	je     400df8 <register_tm_clones+0x38>
  400ded:	5d                   	pop    %rbp
  400dee:	bf 80 47 60 00       	mov    $0x604780,%edi
  400df3:	ff e0                	jmpq   *%rax
  400df5:	0f 1f 00             	nopl   (%rax)
  400df8:	5d                   	pop    %rbp
  400df9:	c3                   	retq   
  400dfa:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000400e00 <__do_global_dtors_aux>:
  400e00:	80 3d a1 39 20 00 00 	cmpb   $0x0,0x2039a1(%rip)        # 6047a8 <completed.7594>
  400e07:	75 11                	jne    400e1a <__do_global_dtors_aux+0x1a>
  400e09:	55                   	push   %rbp
  400e0a:	48 89 e5             	mov    %rsp,%rbp
  400e0d:	e8 6e ff ff ff       	callq  400d80 <deregister_tm_clones>
  400e12:	5d                   	pop    %rbp
  400e13:	c6 05 8e 39 20 00 01 	movb   $0x1,0x20398e(%rip)        # 6047a8 <completed.7594>
  400e1a:	f3 c3                	repz retq 
  400e1c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000400e20 <frame_dummy>:
  400e20:	bf 20 3e 60 00       	mov    $0x603e20,%edi
  400e25:	48 83 3f 00          	cmpq   $0x0,(%rdi)
  400e29:	75 05                	jne    400e30 <frame_dummy+0x10>
  400e2b:	eb 93                	jmp    400dc0 <register_tm_clones>
  400e2d:	0f 1f 00             	nopl   (%rax)
  400e30:	b8 00 00 00 00       	mov    $0x0,%eax
  400e35:	48 85 c0             	test   %rax,%rax
  400e38:	74 f1                	je     400e2b <frame_dummy+0xb>
  400e3a:	55                   	push   %rbp
  400e3b:	48 89 e5             	mov    %rsp,%rbp
  400e3e:	ff d0                	callq  *%rax
  400e40:	5d                   	pop    %rbp
  400e41:	e9 7a ff ff ff       	jmpq   400dc0 <register_tm_clones>

0000000000400e46 <main>:
  400e46:	53                   	push   %rbx
  400e47:	83 ff 01             	cmp    $0x1,%edi
  400e4a:	75 10                	jne    400e5c <main+0x16>
  400e4c:	48 8b 05 3d 39 20 00 	mov    0x20393d(%rip),%rax        # 604790 <stdin@@GLIBC_2.2.5>
  400e53:	48 89 05 56 39 20 00 	mov    %rax,0x203956(%rip)        # 6047b0 <infile>
  400e5a:	eb 63                	jmp    400ebf <main+0x79>
  400e5c:	48 89 f3             	mov    %rsi,%rbx
  400e5f:	83 ff 02             	cmp    $0x2,%edi
  400e62:	75 3a                	jne    400e9e <main+0x58>
  400e64:	48 8b 7e 08          	mov    0x8(%rsi),%rdi
  400e68:	be 1e 2f 40 00       	mov    $0x402f1e,%esi
  400e6d:	e8 3e fe ff ff       	callq  400cb0 <fopen@plt>
  400e72:	48 89 05 37 39 20 00 	mov    %rax,0x203937(%rip)        # 6047b0 <infile>
  400e79:	48 85 c0             	test   %rax,%rax
  400e7c:	75 41                	jne    400ebf <main+0x79>
  400e7e:	48 8b 4b 08          	mov    0x8(%rbx),%rcx
  400e82:	48 8b 13             	mov    (%rbx),%rdx
  400e85:	be 64 26 40 00       	mov    $0x402664,%esi
  400e8a:	bf 01 00 00 00       	mov    $0x1,%edi
  400e8f:	e8 0c fe ff ff       	callq  400ca0 <__printf_chk@plt>
  400e94:	bf 08 00 00 00       	mov    $0x8,%edi
  400e99:	e8 32 fe ff ff       	callq  400cd0 <exit@plt>
  400e9e:	48 8b 16             	mov    (%rsi),%rdx
  400ea1:	be 81 26 40 00       	mov    $0x402681,%esi
  400ea6:	bf 01 00 00 00       	mov    $0x1,%edi
  400eab:	b8 00 00 00 00       	mov    $0x0,%eax
  400eb0:	e8 eb fd ff ff       	callq  400ca0 <__printf_chk@plt>
  400eb5:	bf 08 00 00 00       	mov    $0x8,%edi
  400eba:	e8 11 fe ff ff       	callq  400cd0 <exit@plt>
  400ebf:	e8 c8 06 00 00       	callq  40158c <initialize_bomb>
  400ec4:	bf e8 26 40 00       	mov    $0x4026e8,%edi
  400ec9:	e8 f2 fc ff ff       	callq  400bc0 <puts@plt>
  400ece:	bf 28 27 40 00       	mov    $0x402728,%edi
  400ed3:	e8 e8 fc ff ff       	callq  400bc0 <puts@plt>
  400ed8:	e8 91 09 00 00       	callq  40186e <read_line>
  400edd:	48 89 c7             	mov    %rax,%rdi
  400ee0:	e8 98 00 00 00       	callq  400f7d <phase_1>
  400ee5:	e8 aa 0a 00 00       	callq  401994 <phase_defused>
  400eea:	bf 58 27 40 00       	mov    $0x402758,%edi
  400eef:	e8 cc fc ff ff       	callq  400bc0 <puts@plt>
  400ef4:	e8 75 09 00 00       	callq  40186e <read_line>
  400ef9:	48 89 c7             	mov    %rax,%rdi
  400efc:	e8 fe 00 00 00       	callq  400fff <phase_2>
  400f01:	e8 8e 0a 00 00       	callq  401994 <phase_defused>
  400f06:	bf 9b 26 40 00       	mov    $0x40269b,%edi
  400f0b:	e8 b0 fc ff ff       	callq  400bc0 <puts@plt>
  400f10:	e8 59 09 00 00       	callq  40186e <read_line>
  400f15:	48 89 c7             	mov    %rax,%rdi
  400f18:	e8 46 01 00 00       	callq  401063 <phase_3>
  400f1d:	e8 72 0a 00 00       	callq  401994 <phase_defused>
  400f22:	bf b9 26 40 00       	mov    $0x4026b9,%edi
  400f27:	e8 94 fc ff ff       	callq  400bc0 <puts@plt>
  400f2c:	e8 3d 09 00 00       	callq  40186e <read_line>
  400f31:	48 89 c7             	mov    %rax,%rdi
  400f34:	e8 0c 02 00 00       	callq  401145 <phase_4>
  400f39:	e8 56 0a 00 00       	callq  401994 <phase_defused>
  400f3e:	bf 88 27 40 00       	mov    $0x402788,%edi
  400f43:	e8 78 fc ff ff       	callq  400bc0 <puts@plt>
  400f48:	e8 21 09 00 00       	callq  40186e <read_line>
  400f4d:	48 89 c7             	mov    %rax,%rdi
  400f50:	e8 69 02 00 00       	callq  4011be <phase_5>
  400f55:	e8 3a 0a 00 00       	callq  401994 <phase_defused>
  400f5a:	bf c8 26 40 00       	mov    $0x4026c8,%edi
  400f5f:	e8 5c fc ff ff       	callq  400bc0 <puts@plt>
  400f64:	e8 05 09 00 00       	callq  40186e <read_line>
  400f69:	48 89 c7             	mov    %rax,%rdi
  400f6c:	e8 dc 02 00 00       	callq  40124d <phase_6>
  400f71:	e8 1e 0a 00 00       	callq  401994 <phase_defused>
  400f76:	b8 00 00 00 00       	mov    $0x0,%eax
  400f7b:	5b                   	pop    %rbx
  400f7c:	c3                   	retq   

0000000000400f7d <phase_1>:
  400f7d:	53                   	push   %rbx
  400f7e:	48 83 ec 60          	sub    $0x60,%rsp
  400f82:	48 89 fb             	mov    %rdi,%rbx
  400f85:	64 48 8b 04 25 28 00 	mov    %fs:0x28,%rax
  400f8c:	00 00 
  400f8e:	48 89 44 24 58       	mov    %rax,0x58(%rsp)
  400f93:	31 c0                	xor    %eax,%eax
  400f95:	48 b8 4d 79 20 74 65 	movabs $0x207478657420794d,%rax
  400f9c:	78 74 20 
  400f9f:	48 89 04 24          	mov    %rax,(%rsp)
  400fa3:	48 c7 44 24 08 69 73 	movq   $0x207369,0x8(%rsp)
  400faa:	20 00 
  400fac:	48 8d 7c 24 10       	lea    0x10(%rsp),%rdi
  400fb1:	b9 08 00 00 00       	mov    $0x8,%ecx
  400fb6:	b8 00 00 00 00       	mov    $0x0,%eax
  400fbb:	f3 48 ab             	rep stos %rax,%es:(%rdi)
  400fbe:	ba 50 00 00 00       	mov    $0x50,%edx
  400fc3:	be b0 27 40 00       	mov    $0x4027b0,%esi
  400fc8:	48 89 e7             	mov    %rsp,%rdi
  400fcb:	e8 a0 fb ff ff       	callq  400b70 <__strcat_chk@plt>
  400fd0:	48 89 e6             	mov    %rsp,%rsi
  400fd3:	48 89 df             	mov    %rbx,%rdi
  400fd6:	e8 2e 05 00 00       	callq  401509 <strings_not_equal>
  400fdb:	85 c0                	test   %eax,%eax
  400fdd:	74 05                	je     400fe4 <phase_1+0x67>
  400fdf:	e8 15 08 00 00       	callq  4017f9 <explode_bomb>
  400fe4:	48 8b 44 24 58       	mov    0x58(%rsp),%rax
  400fe9:	64 48 33 04 25 28 00 	xor    %fs:0x28,%rax
  400ff0:	00 00 
  400ff2:	74 05                	je     400ff9 <phase_1+0x7c>
  400ff4:	e8 e7 fb ff ff       	callq  400be0 <__stack_chk_fail@plt>
  400ff9:	48 83 c4 60          	add    $0x60,%rsp
  400ffd:	5b                   	pop    %rbx
  400ffe:	c3                   	retq   

0000000000400fff <phase_2>:
  400fff:	55                   	push   %rbp
  401000:	53                   	push   %rbx
  401001:	48 83 ec 28          	sub    $0x28,%rsp
  401005:	64 48 8b 04 25 28 00 	mov    %fs:0x28,%rax
  40100c:	00 00 
  40100e:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
  401013:	31 c0                	xor    %eax,%eax
  401015:	48 89 e6             	mov    %rsp,%rsi
  401018:	e8 12 08 00 00       	callq  40182f <read_six_numbers>
  40101d:	48 89 e5             	mov    %rsp,%rbp
  401020:	bb 02 00 00 00       	mov    $0x2,%ebx
  401025:	89 d8                	mov    %ebx,%eax
  401027:	c1 e8 1f             	shr    $0x1f,%eax
  40102a:	01 d8                	add    %ebx,%eax
  40102c:	d1 f8                	sar    %eax
  40102e:	03 45 04             	add    0x4(%rbp),%eax
  401031:	39 45 08             	cmp    %eax,0x8(%rbp)
  401034:	74 05                	je     40103b <phase_2+0x3c>
  401036:	e8 be 07 00 00       	callq  4017f9 <explode_bomb>
  40103b:	83 c3 01             	add    $0x1,%ebx
  40103e:	48 83 c5 04          	add    $0x4,%rbp
  401042:	83 fb 06             	cmp    $0x6,%ebx
  401045:	75 de                	jne    401025 <phase_2+0x26>
  401047:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
  40104c:	64 48 33 04 25 28 00 	xor    %fs:0x28,%rax
  401053:	00 00 
  401055:	74 05                	je     40105c <phase_2+0x5d>
  401057:	e8 84 fb ff ff       	callq  400be0 <__stack_chk_fail@plt>
  40105c:	48 83 c4 28          	add    $0x28,%rsp
  401060:	5b                   	pop    %rbx
  401061:	5d                   	pop    %rbp
  401062:	c3                   	retq   

0000000000401063 <phase_3>:
  401063:	48 83 ec 28          	sub    $0x28,%rsp
  401067:	64 48 8b 04 25 28 00 	mov    %fs:0x28,%rax
  40106e:	00 00 
  401070:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
  401075:	31 c0                	xor    %eax,%eax
  401077:	4c 8d 44 24 14       	lea    0x14(%rsp),%r8
  40107c:	48 8d 4c 24 10       	lea    0x10(%rsp),%rcx
  401081:	48 8d 54 24 0c       	lea    0xc(%rsp),%rdx
  401086:	be ea 2a 40 00       	mov    $0x402aea,%esi
  40108b:	e8 00 fc ff ff       	callq  400c90 <__isoc99_sscanf@plt>
  401090:	83 f8 02             	cmp    $0x2,%eax
  401093:	7f 05                	jg     40109a <phase_3+0x37>
  401095:	e8 5f 07 00 00       	callq  4017f9 <explode_bomb>
  40109a:	83 7c 24 0c 07       	cmpl   $0x7,0xc(%rsp)
  40109f:	77 3c                	ja     4010dd <phase_3+0x7a>
  4010a1:	8b 44 24 0c          	mov    0xc(%rsp),%eax
  4010a5:	ff 24 c5 20 28 40 00 	jmpq   *0x402820(,%rax,8)
  4010ac:	be a5 03 00 00       	mov    $0x3a5,%esi
  4010b1:	eb 3b                	jmp    4010ee <phase_3+0x8b>
  4010b3:	be 7d 00 00 00       	mov    $0x7d,%esi
  4010b8:	eb 34                	jmp    4010ee <phase_3+0x8b>
  4010ba:	be a6 02 00 00       	mov    $0x2a6,%esi
  4010bf:	eb 2d                	jmp    4010ee <phase_3+0x8b>
  4010c1:	be 7a 02 00 00       	mov    $0x27a,%esi
  4010c6:	eb 26                	jmp    4010ee <phase_3+0x8b>
  4010c8:	be 5a 00 00 00       	mov    $0x5a,%esi
  4010cd:	eb 1f                	jmp    4010ee <phase_3+0x8b>
  4010cf:	be 4f 03 00 00       	mov    $0x34f,%esi
  4010d4:	eb 18                	jmp    4010ee <phase_3+0x8b>
  4010d6:	be a8 03 00 00       	mov    $0x3a8,%esi
  4010db:	eb 11                	jmp    4010ee <phase_3+0x8b>
  4010dd:	e8 17 07 00 00       	callq  4017f9 <explode_bomb>
  4010e2:	be 00 00 00 00       	mov    $0x0,%esi
  4010e7:	eb 05                	jmp    4010ee <phase_3+0x8b>
  4010e9:	be 86 02 00 00       	mov    $0x286,%esi
  4010ee:	8b 54 24 10          	mov    0x10(%rsp),%edx
  4010f2:	8b 7c 24 14          	mov    0x14(%rsp),%edi
  4010f6:	e8 ba 03 00 00       	callq  4014b5 <check_substraction_equal>
  4010fb:	85 c0                	test   %eax,%eax
  4010fd:	75 05                	jne    401104 <phase_3+0xa1>
  4010ff:	e8 f5 06 00 00       	callq  4017f9 <explode_bomb>
  401104:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
  401109:	64 48 33 04 25 28 00 	xor    %fs:0x28,%rax
  401110:	00 00 
  401112:	74 05                	je     401119 <phase_3+0xb6>
  401114:	e8 c7 fa ff ff       	callq  400be0 <__stack_chk_fail@plt>
  401119:	48 83 c4 28          	add    $0x28,%rsp
  40111d:	c3                   	retq   

000000000040111e <func4>:
  40111e:	83 ff 01             	cmp    $0x1,%edi
  401121:	7f 0c                	jg     40112f <func4+0x11>
  401123:	c7 06 01 00 00 00    	movl   $0x1,(%rsi)
  401129:	b8 01 00 00 00       	mov    $0x1,%eax
  40112e:	c3                   	retq   
  40112f:	53                   	push   %rbx
  401130:	48 89 f3             	mov    %rsi,%rbx
  401133:	83 ef 01             	sub    $0x1,%edi
  401136:	e8 e3 ff ff ff       	callq  40111e <func4>
  40113b:	89 c2                	mov    %eax,%edx
  40113d:	03 13                	add    (%rbx),%edx
  40113f:	89 03                	mov    %eax,(%rbx)
  401141:	89 d0                	mov    %edx,%eax
  401143:	5b                   	pop    %rbx
  401144:	c3                   	retq   

0000000000401145 <phase_4>:
  401145:	48 83 ec 28          	sub    $0x28,%rsp
  401149:	64 48 8b 04 25 28 00 	mov    %fs:0x28,%rax
  401150:	00 00 
  401152:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
  401157:	31 c0                	xor    %eax,%eax
  401159:	48 8d 4c 24 10       	lea    0x10(%rsp),%rcx
  40115e:	48 8d 54 24 0c       	lea    0xc(%rsp),%rdx
  401163:	be ed 2a 40 00       	mov    $0x402aed,%esi
  401168:	e8 23 fb ff ff       	callq  400c90 <__isoc99_sscanf@plt>
  40116d:	83 f8 02             	cmp    $0x2,%eax
  401170:	75 0c                	jne    40117e <phase_4+0x39>
  401172:	8b 44 24 0c          	mov    0xc(%rsp),%eax
  401176:	83 e8 01             	sub    $0x1,%eax
  401179:	83 f8 13             	cmp    $0x13,%eax
  40117c:	76 05                	jbe    401183 <phase_4+0x3e>
  40117e:	e8 76 06 00 00       	callq  4017f9 <explode_bomb>
  401183:	48 8d 74 24 14       	lea    0x14(%rsp),%rsi
  401188:	8b 7c 24 0c          	mov    0xc(%rsp),%edi
  40118c:	e8 8d ff ff ff       	callq  40111e <func4>
  401191:	83 7c 24 14 02       	cmpl   $0x2,0x14(%rsp)
  401196:	75 07                	jne    40119f <phase_4+0x5a>
  401198:	83 7c 24 10 02       	cmpl   $0x2,0x10(%rsp)
  40119d:	74 05                	je     4011a4 <phase_4+0x5f>
  40119f:	e8 55 06 00 00       	callq  4017f9 <explode_bomb>
  4011a4:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
  4011a9:	64 48 33 04 25 28 00 	xor    %fs:0x28,%rax
  4011b0:	00 00 
  4011b2:	74 05                	je     4011b9 <phase_4+0x74>
  4011b4:	e8 27 fa ff ff       	callq  400be0 <__stack_chk_fail@plt>
  4011b9:	48 83 c4 28          	add    $0x28,%rsp
  4011bd:	c3                   	retq   

00000000004011be <phase_5>:
  4011be:	48 83 ec 18          	sub    $0x18,%rsp
  4011c2:	64 48 8b 04 25 28 00 	mov    %fs:0x28,%rax
  4011c9:	00 00 
  4011cb:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
  4011d0:	31 c0                	xor    %eax,%eax
  4011d2:	48 8d 4c 24 04       	lea    0x4(%rsp),%rcx
  4011d7:	48 89 e2             	mov    %rsp,%rdx
  4011da:	be ed 2a 40 00       	mov    $0x402aed,%esi
  4011df:	e8 ac fa ff ff       	callq  400c90 <__isoc99_sscanf@plt>
  4011e4:	83 f8 01             	cmp    $0x1,%eax
  4011e7:	7f 05                	jg     4011ee <phase_5+0x30>
  4011e9:	e8 0b 06 00 00       	callq  4017f9 <explode_bomb>
  4011ee:	8b 34 24             	mov    (%rsp),%esi
  4011f1:	83 e6 0f             	and    $0xf,%esi
  4011f4:	89 34 24             	mov    %esi,(%rsp)
  4011f7:	83 fe 0f             	cmp    $0xf,%esi
  4011fa:	74 27                	je     401223 <phase_5+0x65>
  4011fc:	89 f0                	mov    %esi,%eax
  4011fe:	ba 00 00 00 00       	mov    $0x0,%edx
  401203:	48 63 c8             	movslq %eax,%rcx
  401206:	03 14 8d 60 28 40 00 	add    0x402860(,%rcx,4),%edx
  40120d:	83 c0 01             	add    $0x1,%eax
  401210:	83 f8 0f             	cmp    $0xf,%eax
  401213:	75 ee                	jne    401203 <phase_5+0x45>
  401215:	c7 04 24 0f 00 00 00 	movl   $0xf,(%rsp)
  40121c:	83 fe 0f             	cmp    $0xf,%esi
  40121f:	74 07                	je     401228 <phase_5+0x6a>
  401221:	eb 0b                	jmp    40122e <phase_5+0x70>
  401223:	ba 00 00 00 00       	mov    $0x0,%edx
  401228:	39 54 24 04          	cmp    %edx,0x4(%rsp)
  40122c:	74 05                	je     401233 <phase_5+0x75>
  40122e:	e8 c6 05 00 00       	callq  4017f9 <explode_bomb>
  401233:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
  401238:	64 48 33 04 25 28 00 	xor    %fs:0x28,%rax
  40123f:	00 00 
  401241:	74 05                	je     401248 <phase_5+0x8a>
  401243:	e8 98 f9 ff ff       	callq  400be0 <__stack_chk_fail@plt>
  401248:	48 83 c4 18          	add    $0x18,%rsp
  40124c:	c3                   	retq   

000000000040124d <phase_6>:
  40124d:	41 55                	push   %r13
  40124f:	41 54                	push   %r12
  401251:	55                   	push   %rbp
  401252:	53                   	push   %rbx
  401253:	48 83 ec 68          	sub    $0x68,%rsp
  401257:	64 48 8b 04 25 28 00 	mov    %fs:0x28,%rax
  40125e:	00 00 
  401260:	48 89 44 24 58       	mov    %rax,0x58(%rsp)
  401265:	31 c0                	xor    %eax,%eax
  401267:	48 89 e6             	mov    %rsp,%rsi
  40126a:	e8 c0 05 00 00       	callq  40182f <read_six_numbers>
  40126f:	49 89 e4             	mov    %rsp,%r12
  401272:	41 bd 00 00 00 00    	mov    $0x0,%r13d
  401278:	4c 89 e5             	mov    %r12,%rbp
  40127b:	41 8b 04 24          	mov    (%r12),%eax
  40127f:	83 e8 01             	sub    $0x1,%eax
  401282:	83 f8 05             	cmp    $0x5,%eax
  401285:	76 05                	jbe    40128c <phase_6+0x3f>
  401287:	e8 6d 05 00 00       	callq  4017f9 <explode_bomb>
  
  # for loop starts for 6 times			== checks for distinction & < 6
  40128c:	41 83 c5 01          	add    $0x1,%r13d
  401290:	41 83 fd 06          	cmp    $0x6,%r13d
  401294:	74 3d                	je     4012d3 <phase_6+0x86>    #4012d3
  401296:	44 89 eb             	mov    %r13d,%ebx
  #loop returns here : +0x4c  ::: inside loop
  401299:	48 63 c3             	movslq %ebx,%rax
  40129c:	8b 04 84             	mov    (%rsp,%rax,4),%eax
  40129f:	39 45 00             	cmp    %eax,0x0(%rbp)
  4012a2:	75 05                	jne    4012a9 <phase_6+0x5c>
  4012a4:	e8 50 05 00 00       	callq  4017f9 <explode_bomb>
  4012a9:	83 c3 01             	add    $0x1,%ebx
  4012ac:	83 fb 05             	cmp    $0x5,%ebx
  4012af:	7e e8                	jle    401299 <phase_6+0x4c>


  4012b1:	49 83 c4 04          	add    $0x4,%r12
  4012b5:	eb c1                	jmp    401278 <phase_6+0x2b>
  4012b7:	48 8b 52 08          	mov    0x8(%rdx),%rdx #continue'lar buraya
  4012bb:	83 c0 01             	add    $0x1,%eax
  4012be:	39 c8                	cmp    %ecx,%eax
  4012c0:	75 f5                	jne    4012b7 <phase_6+0x6a> # continue
  4012c2:	48 89 54 74 20       	mov    %rdx,0x20(%rsp,%rsi,2) #0x75
  4012c7:	48 83 c6 04          	add    $0x4,%rsi
  4012cb:	48 83 fe 18          	cmp    $0x18,%rsi
  4012cf:	75 07                	jne    4012d8 <phase_6+0x8b>
  4012d1:	eb 19                	jmp    4012ec <phase_6+0x9f>




  4012d3:	be 00 00 00 00       	mov    $0x0,%esi
  4012d8:	8b 0c 34             	mov    (%rsp,%rsi,1),%ecx
  4012db:	b8 01 00 00 00       	mov    $0x1,%eax
  4012e0:	ba f0 42 60 00       	mov    $0x6042f0,%edx
  4012e5:	83 f9 01             	cmp    $0x1,%ecx
  4012e8:	7f cd                	jg     4012b7 <phase_6+0x6a> #continue
  4012ea:	eb d6                	jmp    4012c2 <phase_6+0x75>		--> 4012c2
  4012ec:	48 8b 5c 24 20       	mov    0x20(%rsp),%rbx				--> 0x9f
  4012f1:	48 8d 44 24 20       	lea    0x20(%rsp),%rax
  4012f6:	48 8d 74 24 48       	lea    0x48(%rsp),%rsi
  4012fb:	48 89 d9             	mov    %rbx,%rcx
  4012fe:	48 8b 50 08          	mov    0x8(%rax),%rdx    #0xb1
  401302:	48 89 51 08          	mov    %rdx,0x8(%rcx)
  401306:	48 83 c0 08          	add    $0x8,%rax
  40130a:	48 89 d1             	mov    %rdx,%rcx
  40130d:	48 39 f0             	cmp    %rsi,%rax
  401310:	75 ec                	jne    4012fe <phase_6+0xb1>



  401312:	48 c7 42 08 00 00 00 	movq   $0x0,0x8(%rdx)
  401319:	00 
  40131a:	bd 00 00 00 00       	mov    $0x0,%ebp
  40131f:	40 f6 c5 01          	test   $0x1,%bpl
  401323:	75 11                	jne    401336 <phase_6+0xe9>
  401325:	48 8b 43 08          	mov    0x8(%rbx),%rax
  401329:	8b 00                	mov    (%rax),%eax
  40132b:	39 03                	cmp    %eax,(%rbx)
  40132d:	7e 16                	jle    401345 <phase_6+0xf8>
  40132f:	e8 c5 04 00 00       	callq  4017f9 <explode_bomb>
  401334:	eb 0f                	jmp    401345 <phase_6+0xf8>
  401336:	48 8b 43 08          	mov    0x8(%rbx),%rax
  40133a:	8b 00                	mov    (%rax),%eax
  40133c:	39 03                	cmp    %eax,(%rbx)
  40133e:	7d 05                	jge    401345 <phase_6+0xf8>
  401340:	e8 b4 04 00 00       	callq  4017f9 <explode_bomb>
  401345:	48 8b 5b 08          	mov    0x8(%rbx),%rbx
  401349:	83 c5 01             	add    $0x1,%ebp
  40134c:	83 fd 05             	cmp    $0x5,%ebp
  40134f:	75 ce                	jne    40131f <phase_6+0xd2>
  401351:	48 8b 44 24 58       	mov    0x58(%rsp),%rax
  401356:	64 48 33 04 25 28 00 	xor    %fs:0x28,%rax
  40135d:	00 00 
  40135f:	74 05                	je     401366 <phase_6+0x119>
  401361:	e8 7a f8 ff ff       	callq  400be0 <__stack_chk_fail@plt>
  401366:	48 83 c4 68          	add    $0x68,%rsp
  40136a:	5b                   	pop    %rbx
  40136b:	5d                   	pop    %rbp
  40136c:	41 5c                	pop    %r12
  40136e:	41 5d                	pop    %r13
  401370:	c3                   	retq   

0000000000401371 <fun7>:
  401371:	48 83 ec 08          	sub    $0x8,%rsp
  401375:	48 85 ff             	test   %rdi,%rdi
  401378:	74 2b                	je     4013a5 <fun7+0x34>
  40137a:	8b 17                	mov    (%rdi),%edx
  40137c:	39 f2                	cmp    %esi,%edx
  40137e:	7e 0d                	jle    40138d <fun7+0x1c>
  401380:	48 8b 7f 08          	mov    0x8(%rdi),%rdi
  401384:	e8 e8 ff ff ff       	callq  401371 <fun7>
  401389:	01 c0                	add    %eax,%eax
  40138b:	eb 1d                	jmp    4013aa <fun7+0x39>
  40138d:	b8 00 00 00 00       	mov    $0x0,%eax
  401392:	39 f2                	cmp    %esi,%edx
  401394:	74 14                	je     4013aa <fun7+0x39>
  401396:	48 8b 7f 10          	mov    0x10(%rdi),%rdi
  40139a:	e8 d2 ff ff ff       	callq  401371 <fun7>
  40139f:	8d 44 00 01          	lea    0x1(%rax,%rax,1),%eax
  4013a3:	eb 05                	jmp    4013aa <fun7+0x39>
  4013a5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  4013aa:	48 83 c4 08          	add    $0x8,%rsp
  4013ae:	c3                   	retq   

00000000004013af <secret_phase>:
  4013af:	53                   	push   %rbx
  4013b0:	e8 b9 04 00 00       	callq  40186e <read_line>
  4013b5:	ba 0a 00 00 00       	mov    $0xa,%edx
  4013ba:	be 00 00 00 00       	mov    $0x0,%esi
  4013bf:	48 89 c7             	mov    %rax,%rdi
  4013c2:	e8 a9 f8 ff ff       	callq  400c70 <strtol@plt>
  4013c7:	48 89 c3             	mov    %rax,%rbx
  4013ca:	8d 40 ff             	lea    -0x1(%rax),%eax
  4013cd:	3d e8 03 00 00       	cmp    $0x3e8,%eax
  4013d2:	76 05                	jbe    4013d9 <secret_phase+0x2a>
  4013d4:	e8 20 04 00 00       	callq  4017f9 <explode_bomb>
  4013d9:	89 de                	mov    %ebx,%esi
  4013db:	bf 10 41 60 00       	mov    $0x604110,%edi
  4013e0:	e8 8c ff ff ff       	callq  401371 <fun7>
  4013e5:	83 f8 01             	cmp    $0x1,%eax
  4013e8:	74 05                	je     4013ef <secret_phase+0x40>
  4013ea:	e8 0a 04 00 00       	callq  4017f9 <explode_bomb>
  4013ef:	bf e0 27 40 00       	mov    $0x4027e0,%edi
  4013f4:	e8 c7 f7 ff ff       	callq  400bc0 <puts@plt>
  4013f9:	e8 96 05 00 00       	callq  401994 <phase_defused>
  4013fe:	5b                   	pop    %rbx
  4013ff:	c3                   	retq   

0000000000401400 <sig_handler>:
  401400:	48 83 ec 08          	sub    $0x8,%rsp
  401404:	bf a0 28 40 00       	mov    $0x4028a0,%edi
  401409:	e8 b2 f7 ff ff       	callq  400bc0 <puts@plt>
  40140e:	bf 03 00 00 00       	mov    $0x3,%edi
  401413:	e8 e8 f8 ff ff       	callq  400d00 <sleep@plt>
  401418:	be 69 2a 40 00       	mov    $0x402a69,%esi
  40141d:	bf 01 00 00 00       	mov    $0x1,%edi
  401422:	b8 00 00 00 00       	mov    $0x0,%eax
  401427:	e8 74 f8 ff ff       	callq  400ca0 <__printf_chk@plt>
  40142c:	48 8b 3d 4d 33 20 00 	mov    0x20334d(%rip),%rdi        # 604780 <stdout@@GLIBC_2.2.5>
  401433:	e8 48 f8 ff ff       	callq  400c80 <fflush@plt>
  401438:	bf 01 00 00 00       	mov    $0x1,%edi
  40143d:	e8 be f8 ff ff       	callq  400d00 <sleep@plt>
  401442:	bf 71 2a 40 00       	mov    $0x402a71,%edi
  401447:	e8 74 f7 ff ff       	callq  400bc0 <puts@plt>
  40144c:	bf 10 00 00 00       	mov    $0x10,%edi
  401451:	e8 7a f8 ff ff       	callq  400cd0 <exit@plt>

0000000000401456 <invalid_phase>:
  401456:	48 83 ec 08          	sub    $0x8,%rsp
  40145a:	48 89 fa             	mov    %rdi,%rdx
  40145d:	be 79 2a 40 00       	mov    $0x402a79,%esi
  401462:	bf 01 00 00 00       	mov    $0x1,%edi
  401467:	b8 00 00 00 00       	mov    $0x0,%eax
  40146c:	e8 2f f8 ff ff       	callq  400ca0 <__printf_chk@plt>
  401471:	bf 08 00 00 00       	mov    $0x8,%edi
  401476:	e8 55 f8 ff ff       	callq  400cd0 <exit@plt>

000000000040147b <string_length>:
  40147b:	80 3f 00             	cmpb   $0x0,(%rdi)
  40147e:	74 13                	je     401493 <string_length+0x18>
  401480:	b8 00 00 00 00       	mov    $0x0,%eax
  401485:	48 83 c7 01          	add    $0x1,%rdi
  401489:	83 c0 01             	add    $0x1,%eax
  40148c:	80 3f 00             	cmpb   $0x0,(%rdi)
  40148f:	75 f4                	jne    401485 <string_length+0xa>
  401491:	f3 c3                	repz retq 
  401493:	b8 00 00 00 00       	mov    $0x0,%eax
  401498:	c3                   	retq   

0000000000401499 <check_division_equal>:
  401499:	89 d1                	mov    %edx,%ecx
  40149b:	89 f8                	mov    %edi,%eax
  40149d:	99                   	cltd   
  40149e:	f7 fe                	idiv   %esi
  4014a0:	39 c8                	cmp    %ecx,%eax
  4014a2:	0f 94 c0             	sete   %al
  4014a5:	0f b6 c0             	movzbl %al,%eax
  4014a8:	c3                   	retq   

00000000004014a9 <check_multiplication_equal>:
  4014a9:	0f af f7             	imul   %edi,%esi
  4014ac:	39 d6                	cmp    %edx,%esi
  4014ae:	0f 94 c0             	sete   %al
  4014b1:	0f b6 c0             	movzbl %al,%eax
  4014b4:	c3                   	retq   

00000000004014b5 <check_substraction_equal>:
  4014b5:	29 f7                	sub    %esi,%edi
  4014b7:	39 d7                	cmp    %edx,%edi
  4014b9:	0f 94 c0             	sete   %al
  4014bc:	0f b6 c0             	movzbl %al,%eax
  4014bf:	c3                   	retq   

00000000004014c0 <reverse_string>:
  4014c0:	48 89 fe             	mov    %rdi,%rsi
  4014c3:	48 85 ff             	test   %rdi,%rdi
  4014c6:	74 3d                	je     401505 <reverse_string+0x45>
  4014c8:	80 3f 00             	cmpb   $0x0,(%rdi)
  4014cb:	74 38                	je     401505 <reverse_string+0x45>
  4014cd:	b8 00 00 00 00       	mov    $0x0,%eax
  4014d2:	48 c7 c1 ff ff ff ff 	mov    $0xffffffffffffffff,%rcx
  4014d9:	f2 ae                	repnz scas %es:(%rdi),%al
  4014db:	48 f7 d1             	not    %rcx
  4014de:	48 8d 4c 0e fe       	lea    -0x2(%rsi,%rcx,1),%rcx
  4014e3:	48 39 ce             	cmp    %rcx,%rsi
  4014e6:	73 1d                	jae    401505 <reverse_string+0x45>
  4014e8:	48 89 f2             	mov    %rsi,%rdx
  4014eb:	0f b6 02             	movzbl (%rdx),%eax
  4014ee:	32 01                	xor    (%rcx),%al
  4014f0:	88 02                	mov    %al,(%rdx)
  4014f2:	32 01                	xor    (%rcx),%al
  4014f4:	88 01                	mov    %al,(%rcx)
  4014f6:	30 02                	xor    %al,(%rdx)
  4014f8:	48 83 c2 01          	add    $0x1,%rdx
  4014fc:	48 83 e9 01          	sub    $0x1,%rcx
  401500:	48 39 ca             	cmp    %rcx,%rdx
  401503:	72 e6                	jb     4014eb <reverse_string+0x2b>
  401505:	48 89 f0             	mov    %rsi,%rax
  401508:	c3                   	retq   

0000000000401509 <strings_not_equal>:
  401509:	41 54                	push   %r12
  40150b:	55                   	push   %rbp
  40150c:	53                   	push   %rbx
  40150d:	48 89 fb             	mov    %rdi,%rbx
  401510:	48 89 f5             	mov    %rsi,%rbp
  401513:	e8 63 ff ff ff       	callq  40147b <string_length>
  401518:	41 89 c4             	mov    %eax,%r12d
  40151b:	48 89 ef             	mov    %rbp,%rdi
  40151e:	e8 58 ff ff ff       	callq  40147b <string_length>
  401523:	ba 01 00 00 00       	mov    $0x1,%edx
  401528:	41 39 c4             	cmp    %eax,%r12d
  40152b:	75 3c                	jne    401569 <strings_not_equal+0x60>
  40152d:	0f b6 03             	movzbl (%rbx),%eax
  401530:	84 c0                	test   %al,%al
  401532:	74 22                	je     401556 <strings_not_equal+0x4d>
  401534:	3a 45 00             	cmp    0x0(%rbp),%al
  401537:	74 07                	je     401540 <strings_not_equal+0x37>
  401539:	eb 22                	jmp    40155d <strings_not_equal+0x54>
  40153b:	3a 45 00             	cmp    0x0(%rbp),%al
  40153e:	75 24                	jne    401564 <strings_not_equal+0x5b>
  401540:	48 83 c3 01          	add    $0x1,%rbx
  401544:	48 83 c5 01          	add    $0x1,%rbp
  401548:	0f b6 03             	movzbl (%rbx),%eax
  40154b:	84 c0                	test   %al,%al
  40154d:	75 ec                	jne    40153b <strings_not_equal+0x32>
  40154f:	ba 00 00 00 00       	mov    $0x0,%edx
  401554:	eb 13                	jmp    401569 <strings_not_equal+0x60>
  401556:	ba 00 00 00 00       	mov    $0x0,%edx
  40155b:	eb 0c                	jmp    401569 <strings_not_equal+0x60>
  40155d:	ba 01 00 00 00       	mov    $0x1,%edx
  401562:	eb 05                	jmp    401569 <strings_not_equal+0x60>
  401564:	ba 01 00 00 00       	mov    $0x1,%edx
  401569:	89 d0                	mov    %edx,%eax
  40156b:	5b                   	pop    %rbx
  40156c:	5d                   	pop    %rbp
  40156d:	41 5c                	pop    %r12
  40156f:	c3                   	retq   

0000000000401570 <from_char_to_int>:
  401570:	40 0f be c7          	movsbl %dil,%eax
  401574:	40 80 ff 69          	cmp    $0x69,%dil
  401578:	7e 04                	jle    40157e <from_char_to_int+0xe>
  40157a:	83 e8 09             	sub    $0x9,%eax
  40157d:	c3                   	retq   
  40157e:	83 ef 33             	sub    $0x33,%edi
  401581:	8d 50 fd             	lea    -0x3(%rax),%edx
  401584:	40 80 ff 09          	cmp    $0x9,%dil
  401588:	0f 46 c2             	cmovbe %edx,%eax
  40158b:	c3                   	retq   

000000000040158c <initialize_bomb>:
  40158c:	53                   	push   %rbx
  40158d:	48 81 ec 50 20 00 00 	sub    $0x2050,%rsp
  401594:	64 48 8b 04 25 28 00 	mov    %fs:0x28,%rax
  40159b:	00 00 
  40159d:	48 89 84 24 48 20 00 	mov    %rax,0x2048(%rsp)
  4015a4:	00 
  4015a5:	31 c0                	xor    %eax,%eax
  4015a7:	be 00 14 40 00       	mov    $0x401400,%esi
  4015ac:	bf 02 00 00 00       	mov    $0x2,%edi
  4015b1:	e8 8a f6 ff ff       	callq  400c40 <signal@plt>
  4015b6:	be 40 00 00 00       	mov    $0x40,%esi
  4015bb:	48 89 e7             	mov    %rsp,%rdi
  4015be:	e8 fd f6 ff ff       	callq  400cc0 <gethostname@plt>
  4015c3:	85 c0                	test   %eax,%eax
  4015c5:	75 13                	jne    4015da <initialize_bomb+0x4e>
  4015c7:	48 8b 3d b2 2d 20 00 	mov    0x202db2(%rip),%rdi        # 604380 <host_table>
  4015ce:	bb 88 43 60 00       	mov    $0x604388,%ebx
  4015d3:	48 85 ff             	test   %rdi,%rdi
  4015d6:	75 16                	jne    4015ee <initialize_bomb+0x62>
  4015d8:	eb 52                	jmp    40162c <initialize_bomb+0xa0>
  4015da:	bf d8 28 40 00       	mov    $0x4028d8,%edi
  4015df:	e8 dc f5 ff ff       	callq  400bc0 <puts@plt>
  4015e4:	bf 08 00 00 00       	mov    $0x8,%edi
  4015e9:	e8 e2 f6 ff ff       	callq  400cd0 <exit@plt>
  4015ee:	48 89 e6             	mov    %rsp,%rsi
  4015f1:	e8 9a f5 ff ff       	callq  400b90 <strcasecmp@plt>
  4015f6:	85 c0                	test   %eax,%eax
  4015f8:	74 46                	je     401640 <initialize_bomb+0xb4>
  4015fa:	48 83 c3 08          	add    $0x8,%rbx
  4015fe:	48 8b 7b f8          	mov    -0x8(%rbx),%rdi
  401602:	48 85 ff             	test   %rdi,%rdi
  401605:	75 e7                	jne    4015ee <initialize_bomb+0x62>
  401607:	eb 23                	jmp    40162c <initialize_bomb+0xa0>
  401609:	48 8d 54 24 40       	lea    0x40(%rsp),%rdx
  40160e:	be 8a 2a 40 00       	mov    $0x402a8a,%esi
  401613:	bf 01 00 00 00       	mov    $0x1,%edi
  401618:	b8 00 00 00 00       	mov    $0x0,%eax
  40161d:	e8 7e f6 ff ff       	callq  400ca0 <__printf_chk@plt>
  401622:	bf 08 00 00 00       	mov    $0x8,%edi
  401627:	e8 a4 f6 ff ff       	callq  400cd0 <exit@plt>
  40162c:	bf 10 29 40 00       	mov    $0x402910,%edi
  401631:	e8 8a f5 ff ff       	callq  400bc0 <puts@plt>
  401636:	bf 08 00 00 00       	mov    $0x8,%edi
  40163b:	e8 90 f6 ff ff       	callq  400cd0 <exit@plt>
  401640:	48 8d 7c 24 40       	lea    0x40(%rsp),%rdi
  401645:	e8 49 0d 00 00       	callq  402393 <init_driver>
  40164a:	85 c0                	test   %eax,%eax
  40164c:	78 bb                	js     401609 <initialize_bomb+0x7d>
  40164e:	48 8b 84 24 48 20 00 	mov    0x2048(%rsp),%rax
  401655:	00 
  401656:	64 48 33 04 25 28 00 	xor    %fs:0x28,%rax
  40165d:	00 00 
  40165f:	74 05                	je     401666 <initialize_bomb+0xda>
  401661:	e8 7a f5 ff ff       	callq  400be0 <__stack_chk_fail@plt>
  401666:	48 81 c4 50 20 00 00 	add    $0x2050,%rsp
  40166d:	5b                   	pop    %rbx
  40166e:	c3                   	retq   

000000000040166f <initialize_bomb_solve>:
  40166f:	f3 c3                	repz retq 

0000000000401671 <blank_line>:
  401671:	55                   	push   %rbp
  401672:	53                   	push   %rbx
  401673:	48 83 ec 08          	sub    $0x8,%rsp
  401677:	48 89 fd             	mov    %rdi,%rbp
  40167a:	eb 17                	jmp    401693 <blank_line+0x22>
  40167c:	e8 8f f6 ff ff       	callq  400d10 <__ctype_b_loc@plt>
  401681:	48 83 c5 01          	add    $0x1,%rbp
  401685:	48 0f be db          	movsbq %bl,%rbx
  401689:	48 8b 00             	mov    (%rax),%rax
  40168c:	f6 44 58 01 20       	testb  $0x20,0x1(%rax,%rbx,2)
  401691:	74 0f                	je     4016a2 <blank_line+0x31>
  401693:	0f b6 5d 00          	movzbl 0x0(%rbp),%ebx
  401697:	84 db                	test   %bl,%bl
  401699:	75 e1                	jne    40167c <blank_line+0xb>
  40169b:	b8 01 00 00 00       	mov    $0x1,%eax
  4016a0:	eb 05                	jmp    4016a7 <blank_line+0x36>
  4016a2:	b8 00 00 00 00       	mov    $0x0,%eax
  4016a7:	48 83 c4 08          	add    $0x8,%rsp
  4016ab:	5b                   	pop    %rbx
  4016ac:	5d                   	pop    %rbp
  4016ad:	c3                   	retq   

00000000004016ae <skip>:
  4016ae:	53                   	push   %rbx
  4016af:	48 63 05 f6 30 20 00 	movslq 0x2030f6(%rip),%rax        # 6047ac <num_input_strings>
  4016b6:	48 8d 3c 80          	lea    (%rax,%rax,4),%rdi
  4016ba:	48 c1 e7 04          	shl    $0x4,%rdi
  4016be:	48 81 c7 c0 47 60 00 	add    $0x6047c0,%rdi
  4016c5:	48 8b 15 e4 30 20 00 	mov    0x2030e4(%rip),%rdx        # 6047b0 <infile>
  4016cc:	be 50 00 00 00       	mov    $0x50,%esi
  4016d1:	e8 5a f5 ff ff       	callq  400c30 <fgets@plt>
  4016d6:	48 89 c3             	mov    %rax,%rbx
  4016d9:	48 85 c0             	test   %rax,%rax
  4016dc:	74 0c                	je     4016ea <skip+0x3c>
  4016de:	48 89 c7             	mov    %rax,%rdi
  4016e1:	e8 8b ff ff ff       	callq  401671 <blank_line>
  4016e6:	85 c0                	test   %eax,%eax
  4016e8:	75 c5                	jne    4016af <skip+0x1>
  4016ea:	48 89 d8             	mov    %rbx,%rax
  4016ed:	5b                   	pop    %rbx
  4016ee:	c3                   	retq   

00000000004016ef <send_msg>:
  4016ef:	48 81 ec 18 40 00 00 	sub    $0x4018,%rsp
  4016f6:	41 89 f8             	mov    %edi,%r8d
  4016f9:	64 48 8b 04 25 28 00 	mov    %fs:0x28,%rax
  401700:	00 00 
  401702:	48 89 84 24 08 40 00 	mov    %rax,0x4008(%rsp)
  401709:	00 
  40170a:	31 c0                	xor    %eax,%eax
  40170c:	8b 35 9a 30 20 00    	mov    0x20309a(%rip),%esi        # 6047ac <num_input_strings>
  401712:	8d 46 ff             	lea    -0x1(%rsi),%eax
  401715:	48 98                	cltq   
  401717:	48 8d 14 80          	lea    (%rax,%rax,4),%rdx
  40171b:	48 c1 e2 04          	shl    $0x4,%rdx
  40171f:	48 81 c2 c0 47 60 00 	add    $0x6047c0,%rdx
  401726:	b8 00 00 00 00       	mov    $0x0,%eax
  40172b:	48 c7 c1 ff ff ff ff 	mov    $0xffffffffffffffff,%rcx
  401732:	48 89 d7             	mov    %rdx,%rdi
  401735:	f2 ae                	repnz scas %es:(%rdi),%al
  401737:	48 f7 d1             	not    %rcx
  40173a:	48 83 c1 63          	add    $0x63,%rcx
  40173e:	48 81 f9 00 20 00 00 	cmp    $0x2000,%rcx
  401745:	76 19                	jbe    401760 <send_msg+0x71>
  401747:	be 48 29 40 00       	mov    $0x402948,%esi
  40174c:	bf 01 00 00 00       	mov    $0x1,%edi
  401751:	e8 4a f5 ff ff       	callq  400ca0 <__printf_chk@plt>
  401756:	bf 08 00 00 00       	mov    $0x8,%edi
  40175b:	e8 70 f5 ff ff       	callq  400cd0 <exit@plt>
  401760:	45 85 c0             	test   %r8d,%r8d
  401763:	41 b9 ac 2a 40 00    	mov    $0x402aac,%r9d
  401769:	b8 a4 2a 40 00       	mov    $0x402aa4,%eax
  40176e:	4c 0f 45 c8          	cmovne %rax,%r9
  401772:	52                   	push   %rdx
  401773:	56                   	push   %rsi
  401774:	44 8b 05 f5 2b 20 00 	mov    0x202bf5(%rip),%r8d        # 604370 <bomb_id>
  40177b:	b9 b5 2a 40 00       	mov    $0x402ab5,%ecx
  401780:	ba 00 20 00 00       	mov    $0x2000,%edx
  401785:	be 01 00 00 00       	mov    $0x1,%esi
  40178a:	48 8d 7c 24 10       	lea    0x10(%rsp),%rdi
  40178f:	b8 00 00 00 00       	mov    $0x0,%eax
  401794:	e8 87 f5 ff ff       	callq  400d20 <__sprintf_chk@plt>
  401799:	4c 8d 84 24 10 20 00 	lea    0x2010(%rsp),%r8
  4017a0:	00 
  4017a1:	b9 00 00 00 00       	mov    $0x0,%ecx
  4017a6:	48 8d 54 24 10       	lea    0x10(%rsp),%rdx
  4017ab:	be 50 43 60 00       	mov    $0x604350,%esi
  4017b0:	bf 68 43 60 00       	mov    $0x604368,%edi
  4017b5:	e8 ae 0d 00 00       	callq  402568 <driver_post>
  4017ba:	48 83 c4 10          	add    $0x10,%rsp
  4017be:	85 c0                	test   %eax,%eax
  4017c0:	79 17                	jns    4017d9 <send_msg+0xea>
  4017c2:	48 8d bc 24 00 20 00 	lea    0x2000(%rsp),%rdi
  4017c9:	00 
  4017ca:	e8 f1 f3 ff ff       	callq  400bc0 <puts@plt>
  4017cf:	bf 00 00 00 00       	mov    $0x0,%edi
  4017d4:	e8 f7 f4 ff ff       	callq  400cd0 <exit@plt>
  4017d9:	48 8b 84 24 08 40 00 	mov    0x4008(%rsp),%rax
  4017e0:	00 
  4017e1:	64 48 33 04 25 28 00 	xor    %fs:0x28,%rax
  4017e8:	00 00 
  4017ea:	74 05                	je     4017f1 <send_msg+0x102>
  4017ec:	e8 ef f3 ff ff       	callq  400be0 <__stack_chk_fail@plt>
  4017f1:	48 81 c4 18 40 00 00 	add    $0x4018,%rsp
  4017f8:	c3                   	retq   

00000000004017f9 <explode_bomb>:
  4017f9:	48 83 ec 08          	sub    $0x8,%rsp
  4017fd:	bf c1 2a 40 00       	mov    $0x402ac1,%edi
  401802:	e8 b9 f3 ff ff       	callq  400bc0 <puts@plt>
  401807:	bf ca 2a 40 00       	mov    $0x402aca,%edi
  40180c:	e8 af f3 ff ff       	callq  400bc0 <puts@plt>
  401811:	bf 00 00 00 00       	mov    $0x0,%edi
  401816:	e8 d4 fe ff ff       	callq  4016ef <send_msg>
  40181b:	bf 70 29 40 00       	mov    $0x402970,%edi
  401820:	e8 9b f3 ff ff       	callq  400bc0 <puts@plt>
  401825:	bf 08 00 00 00       	mov    $0x8,%edi
  40182a:	e8 a1 f4 ff ff       	callq  400cd0 <exit@plt>

000000000040182f <read_six_numbers>:
  40182f:	48 83 ec 08          	sub    $0x8,%rsp
  401833:	48 89 f2             	mov    %rsi,%rdx
  401836:	48 8d 4e 04          	lea    0x4(%rsi),%rcx
  40183a:	48 8d 46 14          	lea    0x14(%rsi),%rax
  40183e:	50                   	push   %rax
  40183f:	48 8d 46 10          	lea    0x10(%rsi),%rax
  401843:	50                   	push   %rax
  401844:	4c 8d 4e 0c          	lea    0xc(%rsi),%r9
  401848:	4c 8d 46 08          	lea    0x8(%rsi),%r8
  40184c:	be e1 2a 40 00       	mov    $0x402ae1,%esi
  401851:	b8 00 00 00 00       	mov    $0x0,%eax
  401856:	e8 35 f4 ff ff       	callq  400c90 <__isoc99_sscanf@plt>
  40185b:	48 83 c4 10          	add    $0x10,%rsp
  40185f:	83 f8 05             	cmp    $0x5,%eax
  401862:	7f 05                	jg     401869 <read_six_numbers+0x3a>
  401864:	e8 90 ff ff ff       	callq  4017f9 <explode_bomb>
  401869:	48 83 c4 08          	add    $0x8,%rsp
  40186d:	c3                   	retq   

000000000040186e <read_line>:
  40186e:	48 83 ec 08          	sub    $0x8,%rsp
  401872:	b8 00 00 00 00       	mov    $0x0,%eax
  401877:	e8 32 fe ff ff       	callq  4016ae <skip>
  40187c:	48 85 c0             	test   %rax,%rax
  40187f:	75 6e                	jne    4018ef <read_line+0x81>
  401881:	48 8b 05 08 2f 20 00 	mov    0x202f08(%rip),%rax        # 604790 <stdin@@GLIBC_2.2.5>
  401888:	48 39 05 21 2f 20 00 	cmp    %rax,0x202f21(%rip)        # 6047b0 <infile>
  40188f:	75 14                	jne    4018a5 <read_line+0x37>
  401891:	bf f3 2a 40 00       	mov    $0x402af3,%edi
  401896:	e8 25 f3 ff ff       	callq  400bc0 <puts@plt>
  40189b:	bf 08 00 00 00       	mov    $0x8,%edi
  4018a0:	e8 2b f4 ff ff       	callq  400cd0 <exit@plt>
  4018a5:	bf 11 2b 40 00       	mov    $0x402b11,%edi
  4018aa:	e8 d1 f2 ff ff       	callq  400b80 <getenv@plt>
  4018af:	48 85 c0             	test   %rax,%rax
  4018b2:	74 0a                	je     4018be <read_line+0x50>
  4018b4:	bf 00 00 00 00       	mov    $0x0,%edi
  4018b9:	e8 12 f4 ff ff       	callq  400cd0 <exit@plt>
  4018be:	48 8b 05 cb 2e 20 00 	mov    0x202ecb(%rip),%rax        # 604790 <stdin@@GLIBC_2.2.5>
  4018c5:	48 89 05 e4 2e 20 00 	mov    %rax,0x202ee4(%rip)        # 6047b0 <infile>
  4018cc:	b8 00 00 00 00       	mov    $0x0,%eax
  4018d1:	e8 d8 fd ff ff       	callq  4016ae <skip>
  4018d6:	48 85 c0             	test   %rax,%rax
  4018d9:	75 14                	jne    4018ef <read_line+0x81>
  4018db:	bf f3 2a 40 00       	mov    $0x402af3,%edi
  4018e0:	e8 db f2 ff ff       	callq  400bc0 <puts@plt>
  4018e5:	bf 00 00 00 00       	mov    $0x0,%edi
  4018ea:	e8 e1 f3 ff ff       	callq  400cd0 <exit@plt>
  4018ef:	8b 35 b7 2e 20 00    	mov    0x202eb7(%rip),%esi        # 6047ac <num_input_strings>
  4018f5:	48 63 c6             	movslq %esi,%rax
  4018f8:	48 8d 14 80          	lea    (%rax,%rax,4),%rdx
  4018fc:	48 c1 e2 04          	shl    $0x4,%rdx
  401900:	48 81 c2 c0 47 60 00 	add    $0x6047c0,%rdx
  401907:	b8 00 00 00 00       	mov    $0x0,%eax
  40190c:	48 c7 c1 ff ff ff ff 	mov    $0xffffffffffffffff,%rcx
  401913:	48 89 d7             	mov    %rdx,%rdi
  401916:	f2 ae                	repnz scas %es:(%rdi),%al
  401918:	48 f7 d1             	not    %rcx
  40191b:	48 83 e9 01          	sub    $0x1,%rcx
  40191f:	83 f9 4e             	cmp    $0x4e,%ecx
  401922:	7e 46                	jle    40196a <read_line+0xfc>
  401924:	bf 1c 2b 40 00       	mov    $0x402b1c,%edi
  401929:	e8 92 f2 ff ff       	callq  400bc0 <puts@plt>
  40192e:	8b 05 78 2e 20 00    	mov    0x202e78(%rip),%eax        # 6047ac <num_input_strings>
  401934:	8d 50 01             	lea    0x1(%rax),%edx
  401937:	89 15 6f 2e 20 00    	mov    %edx,0x202e6f(%rip)        # 6047ac <num_input_strings>
  40193d:	48 98                	cltq   
  40193f:	48 6b c0 50          	imul   $0x50,%rax,%rax
  401943:	48 bf 2a 2a 2a 74 72 	movabs $0x636e7572742a2a2a,%rdi
  40194a:	75 6e 63 
  40194d:	48 89 b8 c0 47 60 00 	mov    %rdi,0x6047c0(%rax)
  401954:	48 bf 61 74 65 64 2a 	movabs $0x2a2a2a64657461,%rdi
  40195b:	2a 2a 00 
  40195e:	48 89 b8 c8 47 60 00 	mov    %rdi,0x6047c8(%rax)
  401965:	e8 8f fe ff ff       	callq  4017f9 <explode_bomb>
  40196a:	83 e9 01             	sub    $0x1,%ecx
  40196d:	48 63 c9             	movslq %ecx,%rcx
  401970:	48 63 c6             	movslq %esi,%rax
  401973:	48 8d 04 80          	lea    (%rax,%rax,4),%rax
  401977:	48 c1 e0 04          	shl    $0x4,%rax
  40197b:	c6 84 01 c0 47 60 00 	movb   $0x0,0x6047c0(%rcx,%rax,1)
  401982:	00 
  401983:	8d 46 01             	lea    0x1(%rsi),%eax
  401986:	89 05 20 2e 20 00    	mov    %eax,0x202e20(%rip)        # 6047ac <num_input_strings>
  40198c:	48 89 d0             	mov    %rdx,%rax
  40198f:	48 83 c4 08          	add    $0x8,%rsp
  401993:	c3                   	retq   

0000000000401994 <phase_defused>:
  401994:	48 83 ec 78          	sub    $0x78,%rsp
  401998:	64 48 8b 04 25 28 00 	mov    %fs:0x28,%rax
  40199f:	00 00 
  4019a1:	48 89 44 24 68       	mov    %rax,0x68(%rsp)
  4019a6:	31 c0                	xor    %eax,%eax
  4019a8:	bf 01 00 00 00       	mov    $0x1,%edi
  4019ad:	e8 3d fd ff ff       	callq  4016ef <send_msg>
  4019b2:	83 3d f3 2d 20 00 06 	cmpl   $0x6,0x202df3(%rip)        # 6047ac <num_input_strings>
  4019b9:	75 6d                	jne    401a28 <phase_defused+0x94>
  4019bb:	4c 8d 44 24 10       	lea    0x10(%rsp),%r8
  4019c0:	48 8d 4c 24 0c       	lea    0xc(%rsp),%rcx
  4019c5:	48 8d 54 24 08       	lea    0x8(%rsp),%rdx
  4019ca:	be 37 2b 40 00       	mov    $0x402b37,%esi
  4019cf:	bf b0 48 60 00       	mov    $0x6048b0,%edi
  4019d4:	b8 00 00 00 00       	mov    $0x0,%eax
  4019d9:	e8 b2 f2 ff ff       	callq  400c90 <__isoc99_sscanf@plt>
  4019de:	83 f8 03             	cmp    $0x3,%eax
  4019e1:	75 31                	jne    401a14 <phase_defused+0x80>
  4019e3:	be 40 2b 40 00       	mov    $0x402b40,%esi
  4019e8:	48 8d 7c 24 10       	lea    0x10(%rsp),%rdi
  4019ed:	e8 17 fb ff ff       	callq  401509 <strings_not_equal>
  4019f2:	85 c0                	test   %eax,%eax
  4019f4:	75 1e                	jne    401a14 <phase_defused+0x80>
  4019f6:	bf 98 29 40 00       	mov    $0x402998,%edi
  4019fb:	e8 c0 f1 ff ff       	callq  400bc0 <puts@plt>
  401a00:	bf c0 29 40 00       	mov    $0x4029c0,%edi
  401a05:	e8 b6 f1 ff ff       	callq  400bc0 <puts@plt>
  401a0a:	b8 00 00 00 00       	mov    $0x0,%eax
  401a0f:	e8 9b f9 ff ff       	callq  4013af <secret_phase>
  401a14:	bf f8 29 40 00       	mov    $0x4029f8,%edi
  401a19:	e8 a2 f1 ff ff       	callq  400bc0 <puts@plt>
  401a1e:	bf 28 2a 40 00       	mov    $0x402a28,%edi
  401a23:	e8 98 f1 ff ff       	callq  400bc0 <puts@plt>
  401a28:	48 8b 44 24 68       	mov    0x68(%rsp),%rax
  401a2d:	64 48 33 04 25 28 00 	xor    %fs:0x28,%rax
  401a34:	00 00 
  401a36:	74 05                	je     401a3d <phase_defused+0xa9>
  401a38:	e8 a3 f1 ff ff       	callq  400be0 <__stack_chk_fail@plt>
  401a3d:	48 83 c4 78          	add    $0x78,%rsp
  401a41:	c3                   	retq   

0000000000401a42 <sigalrm_handler>:
  401a42:	48 83 ec 08          	sub    $0x8,%rsp
  401a46:	b9 00 00 00 00       	mov    $0x0,%ecx
  401a4b:	ba 18 2e 40 00       	mov    $0x402e18,%edx
  401a50:	be 01 00 00 00       	mov    $0x1,%esi
  401a55:	48 8b 3d 44 2d 20 00 	mov    0x202d44(%rip),%rdi        # 6047a0 <stderr@@GLIBC_2.2.5>
  401a5c:	b8 00 00 00 00       	mov    $0x0,%eax
  401a61:	e8 8a f2 ff ff       	callq  400cf0 <__fprintf_chk@plt>
  401a66:	bf 01 00 00 00       	mov    $0x1,%edi
  401a6b:	e8 60 f2 ff ff       	callq  400cd0 <exit@plt>

0000000000401a70 <rio_readlineb>:
  401a70:	41 56                	push   %r14
  401a72:	41 55                	push   %r13
  401a74:	41 54                	push   %r12
  401a76:	55                   	push   %rbp
  401a77:	53                   	push   %rbx
  401a78:	48 83 ec 10          	sub    $0x10,%rsp
  401a7c:	48 89 fb             	mov    %rdi,%rbx
  401a7f:	49 89 f5             	mov    %rsi,%r13
  401a82:	49 89 d6             	mov    %rdx,%r14
  401a85:	64 48 8b 04 25 28 00 	mov    %fs:0x28,%rax
  401a8c:	00 00 
  401a8e:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
  401a93:	31 c0                	xor    %eax,%eax
  401a95:	41 bc 01 00 00 00    	mov    $0x1,%r12d
  401a9b:	48 8d 6f 10          	lea    0x10(%rdi),%rbp
  401a9f:	48 83 fa 01          	cmp    $0x1,%rdx
  401aa3:	77 2c                	ja     401ad1 <rio_readlineb+0x61>
  401aa5:	eb 6d                	jmp    401b14 <rio_readlineb+0xa4>
  401aa7:	ba 00 20 00 00       	mov    $0x2000,%edx
  401aac:	48 89 ee             	mov    %rbp,%rsi
  401aaf:	8b 3b                	mov    (%rbx),%edi
  401ab1:	e8 5a f1 ff ff       	callq  400c10 <read@plt>
  401ab6:	89 43 04             	mov    %eax,0x4(%rbx)
  401ab9:	85 c0                	test   %eax,%eax
  401abb:	79 0c                	jns    401ac9 <rio_readlineb+0x59>
  401abd:	e8 de f0 ff ff       	callq  400ba0 <__errno_location@plt>
  401ac2:	83 38 04             	cmpl   $0x4,(%rax)
  401ac5:	74 0a                	je     401ad1 <rio_readlineb+0x61>
  401ac7:	eb 6c                	jmp    401b35 <rio_readlineb+0xc5>
  401ac9:	85 c0                	test   %eax,%eax
  401acb:	74 71                	je     401b3e <rio_readlineb+0xce>
  401acd:	48 89 6b 08          	mov    %rbp,0x8(%rbx)
  401ad1:	8b 43 04             	mov    0x4(%rbx),%eax
  401ad4:	85 c0                	test   %eax,%eax
  401ad6:	7e cf                	jle    401aa7 <rio_readlineb+0x37>
  401ad8:	48 8b 53 08          	mov    0x8(%rbx),%rdx
  401adc:	0f b6 0a             	movzbl (%rdx),%ecx
  401adf:	88 4c 24 07          	mov    %cl,0x7(%rsp)
  401ae3:	48 83 c2 01          	add    $0x1,%rdx
  401ae7:	48 89 53 08          	mov    %rdx,0x8(%rbx)
  401aeb:	83 e8 01             	sub    $0x1,%eax
  401aee:	89 43 04             	mov    %eax,0x4(%rbx)
  401af1:	49 83 c5 01          	add    $0x1,%r13
  401af5:	41 88 4d ff          	mov    %cl,-0x1(%r13)
  401af9:	80 f9 0a             	cmp    $0xa,%cl
  401afc:	75 0a                	jne    401b08 <rio_readlineb+0x98>
  401afe:	eb 14                	jmp    401b14 <rio_readlineb+0xa4>
  401b00:	41 83 fc 01          	cmp    $0x1,%r12d
  401b04:	75 0e                	jne    401b14 <rio_readlineb+0xa4>
  401b06:	eb 16                	jmp    401b1e <rio_readlineb+0xae>
  401b08:	41 83 c4 01          	add    $0x1,%r12d
  401b0c:	49 63 c4             	movslq %r12d,%rax
  401b0f:	4c 39 f0             	cmp    %r14,%rax
  401b12:	72 bd                	jb     401ad1 <rio_readlineb+0x61>
  401b14:	41 c6 45 00 00       	movb   $0x0,0x0(%r13)
  401b19:	49 63 c4             	movslq %r12d,%rax
  401b1c:	eb 05                	jmp    401b23 <rio_readlineb+0xb3>
  401b1e:	b8 00 00 00 00       	mov    $0x0,%eax
  401b23:	48 8b 4c 24 08       	mov    0x8(%rsp),%rcx
  401b28:	64 48 33 0c 25 28 00 	xor    %fs:0x28,%rcx
  401b2f:	00 00 
  401b31:	74 22                	je     401b55 <rio_readlineb+0xe5>
  401b33:	eb 1b                	jmp    401b50 <rio_readlineb+0xe0>
  401b35:	48 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%rax
  401b3c:	eb 05                	jmp    401b43 <rio_readlineb+0xd3>
  401b3e:	b8 00 00 00 00       	mov    $0x0,%eax
  401b43:	85 c0                	test   %eax,%eax
  401b45:	74 b9                	je     401b00 <rio_readlineb+0x90>
  401b47:	48 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%rax
  401b4e:	eb d3                	jmp    401b23 <rio_readlineb+0xb3>
  401b50:	e8 8b f0 ff ff       	callq  400be0 <__stack_chk_fail@plt>
  401b55:	48 83 c4 10          	add    $0x10,%rsp
  401b59:	5b                   	pop    %rbx
  401b5a:	5d                   	pop    %rbp
  401b5b:	41 5c                	pop    %r12
  401b5d:	41 5d                	pop    %r13
  401b5f:	41 5e                	pop    %r14
  401b61:	c3                   	retq   

0000000000401b62 <submitr>:
  401b62:	41 57                	push   %r15
  401b64:	41 56                	push   %r14
  401b66:	41 55                	push   %r13
  401b68:	41 54                	push   %r12
  401b6a:	55                   	push   %rbp
  401b6b:	53                   	push   %rbx
  401b6c:	48 81 ec 68 a0 00 00 	sub    $0xa068,%rsp
  401b73:	49 89 fd             	mov    %rdi,%r13
  401b76:	89 f5                	mov    %esi,%ebp
  401b78:	48 89 14 24          	mov    %rdx,(%rsp)
  401b7c:	48 89 4c 24 08       	mov    %rcx,0x8(%rsp)
  401b81:	4c 89 44 24 18       	mov    %r8,0x18(%rsp)
  401b86:	4c 89 4c 24 10       	mov    %r9,0x10(%rsp)
  401b8b:	48 8b 9c 24 a0 a0 00 	mov    0xa0a0(%rsp),%rbx
  401b92:	00 
  401b93:	4c 8b bc 24 a8 a0 00 	mov    0xa0a8(%rsp),%r15
  401b9a:	00 
  401b9b:	64 48 8b 04 25 28 00 	mov    %fs:0x28,%rax
  401ba2:	00 00 
  401ba4:	48 89 84 24 58 a0 00 	mov    %rax,0xa058(%rsp)
  401bab:	00 
  401bac:	31 c0                	xor    %eax,%eax
  401bae:	c7 44 24 2c 00 00 00 	movl   $0x0,0x2c(%rsp)
  401bb5:	00 
  401bb6:	ba 00 00 00 00       	mov    $0x0,%edx
  401bbb:	be 01 00 00 00       	mov    $0x1,%esi
  401bc0:	bf 02 00 00 00       	mov    $0x2,%edi
  401bc5:	e8 66 f1 ff ff       	callq  400d30 <socket@plt>
  401bca:	85 c0                	test   %eax,%eax
  401bcc:	79 50                	jns    401c1e <submitr+0xbc>
  401bce:	48 b8 45 72 72 6f 72 	movabs $0x43203a726f727245,%rax
  401bd5:	3a 20 43 
  401bd8:	49 89 07             	mov    %rax,(%r15)
  401bdb:	48 b8 6c 69 65 6e 74 	movabs $0x6e7520746e65696c,%rax
  401be2:	20 75 6e 
  401be5:	49 89 47 08          	mov    %rax,0x8(%r15)
  401be9:	48 b8 61 62 6c 65 20 	movabs $0x206f7420656c6261,%rax
  401bf0:	74 6f 20 
  401bf3:	49 89 47 10          	mov    %rax,0x10(%r15)
  401bf7:	48 b8 63 72 65 61 74 	movabs $0x7320657461657263,%rax
  401bfe:	65 20 73 
  401c01:	49 89 47 18          	mov    %rax,0x18(%r15)
  401c05:	41 c7 47 20 6f 63 6b 	movl   $0x656b636f,0x20(%r15)
  401c0c:	65 
  401c0d:	66 41 c7 47 24 74 00 	movw   $0x74,0x24(%r15)
  401c14:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  401c19:	e9 12 06 00 00       	jmpq   402230 <submitr+0x6ce>
  401c1e:	41 89 c4             	mov    %eax,%r12d
  401c21:	4c 89 ef             	mov    %r13,%rdi
  401c24:	e8 27 f0 ff ff       	callq  400c50 <gethostbyname@plt>
  401c29:	48 85 c0             	test   %rax,%rax
  401c2c:	75 6b                	jne    401c99 <submitr+0x137>
  401c2e:	48 b8 45 72 72 6f 72 	movabs $0x44203a726f727245,%rax
  401c35:	3a 20 44 
  401c38:	49 89 07             	mov    %rax,(%r15)
  401c3b:	48 b8 4e 53 20 69 73 	movabs $0x6e7520736920534e,%rax
  401c42:	20 75 6e 
  401c45:	49 89 47 08          	mov    %rax,0x8(%r15)
  401c49:	48 b8 61 62 6c 65 20 	movabs $0x206f7420656c6261,%rax
  401c50:	74 6f 20 
  401c53:	49 89 47 10          	mov    %rax,0x10(%r15)
  401c57:	48 b8 72 65 73 6f 6c 	movabs $0x2065766c6f736572,%rax
  401c5e:	76 65 20 
  401c61:	49 89 47 18          	mov    %rax,0x18(%r15)
  401c65:	48 b8 73 65 72 76 65 	movabs $0x6120726576726573,%rax
  401c6c:	72 20 61 
  401c6f:	49 89 47 20          	mov    %rax,0x20(%r15)
  401c73:	41 c7 47 28 64 64 72 	movl   $0x65726464,0x28(%r15)
  401c7a:	65 
  401c7b:	66 41 c7 47 2c 73 73 	movw   $0x7373,0x2c(%r15)
  401c82:	41 c6 47 2e 00       	movb   $0x0,0x2e(%r15)
  401c87:	44 89 e7             	mov    %r12d,%edi
  401c8a:	e8 71 ef ff ff       	callq  400c00 <close@plt>
  401c8f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  401c94:	e9 97 05 00 00       	jmpq   402230 <submitr+0x6ce>
  401c99:	48 c7 44 24 30 00 00 	movq   $0x0,0x30(%rsp)
  401ca0:	00 00 
  401ca2:	48 c7 44 24 38 00 00 	movq   $0x0,0x38(%rsp)
  401ca9:	00 00 
  401cab:	66 c7 44 24 30 02 00 	movw   $0x2,0x30(%rsp)
  401cb2:	48 63 50 14          	movslq 0x14(%rax),%rdx
  401cb6:	48 8b 40 18          	mov    0x18(%rax),%rax
  401cba:	48 8d 7c 24 34       	lea    0x34(%rsp),%rdi
  401cbf:	b9 0c 00 00 00       	mov    $0xc,%ecx
  401cc4:	48 8b 30             	mov    (%rax),%rsi
  401cc7:	e8 94 ef ff ff       	callq  400c60 <__memmove_chk@plt>
  401ccc:	66 c1 cd 08          	ror    $0x8,%bp
  401cd0:	66 89 6c 24 32       	mov    %bp,0x32(%rsp)
  401cd5:	ba 10 00 00 00       	mov    $0x10,%edx
  401cda:	48 8d 74 24 30       	lea    0x30(%rsp),%rsi
  401cdf:	44 89 e7             	mov    %r12d,%edi
  401ce2:	e8 f9 ef ff ff       	callq  400ce0 <connect@plt>
  401ce7:	85 c0                	test   %eax,%eax
  401ce9:	79 5d                	jns    401d48 <submitr+0x1e6>
  401ceb:	48 b8 45 72 72 6f 72 	movabs $0x55203a726f727245,%rax
  401cf2:	3a 20 55 
  401cf5:	49 89 07             	mov    %rax,(%r15)
  401cf8:	48 b8 6e 61 62 6c 65 	movabs $0x6f7420656c62616e,%rax
  401cff:	20 74 6f 
  401d02:	49 89 47 08          	mov    %rax,0x8(%r15)
  401d06:	48 b8 20 63 6f 6e 6e 	movabs $0x7463656e6e6f6320,%rax
  401d0d:	65 63 74 
  401d10:	49 89 47 10          	mov    %rax,0x10(%r15)
  401d14:	48 b8 20 74 6f 20 74 	movabs $0x20656874206f7420,%rax
  401d1b:	68 65 20 
  401d1e:	49 89 47 18          	mov    %rax,0x18(%r15)
  401d22:	41 c7 47 20 73 65 72 	movl   $0x76726573,0x20(%r15)
  401d29:	76 
  401d2a:	66 41 c7 47 24 65 72 	movw   $0x7265,0x24(%r15)
  401d31:	41 c6 47 26 00       	movb   $0x0,0x26(%r15)
  401d36:	44 89 e7             	mov    %r12d,%edi
  401d39:	e8 c2 ee ff ff       	callq  400c00 <close@plt>
  401d3e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  401d43:	e9 e8 04 00 00       	jmpq   402230 <submitr+0x6ce>
  401d48:	49 c7 c1 ff ff ff ff 	mov    $0xffffffffffffffff,%r9
  401d4f:	b8 00 00 00 00       	mov    $0x0,%eax
  401d54:	4c 89 c9             	mov    %r9,%rcx
  401d57:	48 89 df             	mov    %rbx,%rdi
  401d5a:	f2 ae                	repnz scas %es:(%rdi),%al
  401d5c:	48 f7 d1             	not    %rcx
  401d5f:	48 89 ce             	mov    %rcx,%rsi
  401d62:	4c 89 c9             	mov    %r9,%rcx
  401d65:	48 8b 3c 24          	mov    (%rsp),%rdi
  401d69:	f2 ae                	repnz scas %es:(%rdi),%al
  401d6b:	49 89 c8             	mov    %rcx,%r8
  401d6e:	4c 89 c9             	mov    %r9,%rcx
  401d71:	48 8b 7c 24 08       	mov    0x8(%rsp),%rdi
  401d76:	f2 ae                	repnz scas %es:(%rdi),%al
  401d78:	48 f7 d1             	not    %rcx
  401d7b:	48 89 ca             	mov    %rcx,%rdx
  401d7e:	4c 89 c9             	mov    %r9,%rcx
  401d81:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
  401d86:	f2 ae                	repnz scas %es:(%rdi),%al
  401d88:	4c 29 c2             	sub    %r8,%rdx
  401d8b:	48 29 ca             	sub    %rcx,%rdx
  401d8e:	48 8d 44 76 fd       	lea    -0x3(%rsi,%rsi,2),%rax
  401d93:	48 8d 44 02 7b       	lea    0x7b(%rdx,%rax,1),%rax
  401d98:	48 3d 00 20 00 00    	cmp    $0x2000,%rax
  401d9e:	76 73                	jbe    401e13 <submitr+0x2b1>
  401da0:	48 b8 45 72 72 6f 72 	movabs $0x52203a726f727245,%rax
  401da7:	3a 20 52 
  401daa:	49 89 07             	mov    %rax,(%r15)
  401dad:	48 b8 65 73 75 6c 74 	movabs $0x747320746c757365,%rax
  401db4:	20 73 74 
  401db7:	49 89 47 08          	mov    %rax,0x8(%r15)
  401dbb:	48 b8 72 69 6e 67 20 	movabs $0x6f6f7420676e6972,%rax
  401dc2:	74 6f 6f 
  401dc5:	49 89 47 10          	mov    %rax,0x10(%r15)
  401dc9:	48 b8 20 6c 61 72 67 	movabs $0x202e656772616c20,%rax
  401dd0:	65 2e 20 
  401dd3:	49 89 47 18          	mov    %rax,0x18(%r15)
  401dd7:	48 b8 49 6e 63 72 65 	movabs $0x6573616572636e49,%rax
  401dde:	61 73 65 
  401de1:	49 89 47 20          	mov    %rax,0x20(%r15)
  401de5:	48 b8 20 53 55 42 4d 	movabs $0x5254494d42555320,%rax
  401dec:	49 54 52 
  401def:	49 89 47 28          	mov    %rax,0x28(%r15)
  401df3:	48 b8 5f 4d 41 58 42 	movabs $0x46554258414d5f,%rax
  401dfa:	55 46 00 
  401dfd:	49 89 47 30          	mov    %rax,0x30(%r15)
  401e01:	44 89 e7             	mov    %r12d,%edi
  401e04:	e8 f7 ed ff ff       	callq  400c00 <close@plt>
  401e09:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  401e0e:	e9 1d 04 00 00       	jmpq   402230 <submitr+0x6ce>
  401e13:	48 8d 94 24 50 40 00 	lea    0x4050(%rsp),%rdx
  401e1a:	00 
  401e1b:	b9 00 04 00 00       	mov    $0x400,%ecx
  401e20:	b8 00 00 00 00       	mov    $0x0,%eax
  401e25:	48 89 d7             	mov    %rdx,%rdi
  401e28:	f3 48 ab             	rep stos %rax,%es:(%rdi)
  401e2b:	48 c7 c1 ff ff ff ff 	mov    $0xffffffffffffffff,%rcx
  401e32:	48 89 df             	mov    %rbx,%rdi
  401e35:	f2 ae                	repnz scas %es:(%rdi),%al
  401e37:	48 89 c8             	mov    %rcx,%rax
  401e3a:	48 f7 d0             	not    %rax
  401e3d:	48 83 e8 01          	sub    $0x1,%rax
  401e41:	85 c0                	test   %eax,%eax
  401e43:	0f 84 90 04 00 00    	je     4022d9 <submitr+0x777>
  401e49:	8d 40 ff             	lea    -0x1(%rax),%eax
  401e4c:	4c 8d 74 03 01       	lea    0x1(%rbx,%rax,1),%r14
  401e51:	48 89 d5             	mov    %rdx,%rbp
  401e54:	49 bd d9 ff 00 00 00 	movabs $0x2000000000ffd9,%r13
  401e5b:	00 20 00 
  401e5e:	44 0f b6 03          	movzbl (%rbx),%r8d
  401e62:	41 8d 40 d6          	lea    -0x2a(%r8),%eax
  401e66:	3c 35                	cmp    $0x35,%al
  401e68:	77 06                	ja     401e70 <submitr+0x30e>
  401e6a:	49 0f a3 c5          	bt     %rax,%r13
  401e6e:	72 0d                	jb     401e7d <submitr+0x31b>
  401e70:	44 89 c0             	mov    %r8d,%eax
  401e73:	83 e0 df             	and    $0xffffffdf,%eax
  401e76:	83 e8 41             	sub    $0x41,%eax
  401e79:	3c 19                	cmp    $0x19,%al
  401e7b:	77 0a                	ja     401e87 <submitr+0x325>
  401e7d:	44 88 45 00          	mov    %r8b,0x0(%rbp)
  401e81:	48 8d 6d 01          	lea    0x1(%rbp),%rbp
  401e85:	eb 6c                	jmp    401ef3 <submitr+0x391>
  401e87:	41 80 f8 20          	cmp    $0x20,%r8b
  401e8b:	75 0a                	jne    401e97 <submitr+0x335>
  401e8d:	c6 45 00 2b          	movb   $0x2b,0x0(%rbp)
  401e91:	48 8d 6d 01          	lea    0x1(%rbp),%rbp
  401e95:	eb 5c                	jmp    401ef3 <submitr+0x391>
  401e97:	41 8d 40 e0          	lea    -0x20(%r8),%eax
  401e9b:	3c 5f                	cmp    $0x5f,%al
  401e9d:	76 0a                	jbe    401ea9 <submitr+0x347>
  401e9f:	41 80 f8 09          	cmp    $0x9,%r8b
  401ea3:	0f 85 a3 03 00 00    	jne    40224c <submitr+0x6ea>
  401ea9:	45 0f b6 c0          	movzbl %r8b,%r8d
  401ead:	b9 f0 2e 40 00       	mov    $0x402ef0,%ecx
  401eb2:	ba 08 00 00 00       	mov    $0x8,%edx
  401eb7:	be 01 00 00 00       	mov    $0x1,%esi
  401ebc:	48 8d bc 24 50 80 00 	lea    0x8050(%rsp),%rdi
  401ec3:	00 
  401ec4:	b8 00 00 00 00       	mov    $0x0,%eax
  401ec9:	e8 52 ee ff ff       	callq  400d20 <__sprintf_chk@plt>
  401ece:	0f b6 84 24 50 80 00 	movzbl 0x8050(%rsp),%eax
  401ed5:	00 
  401ed6:	88 45 00             	mov    %al,0x0(%rbp)
  401ed9:	0f b6 84 24 51 80 00 	movzbl 0x8051(%rsp),%eax
  401ee0:	00 
  401ee1:	88 45 01             	mov    %al,0x1(%rbp)
  401ee4:	0f b6 84 24 52 80 00 	movzbl 0x8052(%rsp),%eax
  401eeb:	00 
  401eec:	88 45 02             	mov    %al,0x2(%rbp)
  401eef:	48 8d 6d 03          	lea    0x3(%rbp),%rbp
  401ef3:	48 83 c3 01          	add    $0x1,%rbx
  401ef7:	49 39 de             	cmp    %rbx,%r14
  401efa:	0f 85 5e ff ff ff    	jne    401e5e <submitr+0x2fc>
  401f00:	e9 d4 03 00 00       	jmpq   4022d9 <submitr+0x777>
  401f05:	48 89 da             	mov    %rbx,%rdx
  401f08:	48 89 ee             	mov    %rbp,%rsi
  401f0b:	44 89 e7             	mov    %r12d,%edi
  401f0e:	e8 bd ec ff ff       	callq  400bd0 <write@plt>
  401f13:	48 85 c0             	test   %rax,%rax
  401f16:	7f 0f                	jg     401f27 <submitr+0x3c5>
  401f18:	e8 83 ec ff ff       	callq  400ba0 <__errno_location@plt>
  401f1d:	83 38 04             	cmpl   $0x4,(%rax)
  401f20:	75 12                	jne    401f34 <submitr+0x3d2>
  401f22:	b8 00 00 00 00       	mov    $0x0,%eax
  401f27:	48 01 c5             	add    %rax,%rbp
  401f2a:	48 29 c3             	sub    %rax,%rbx
  401f2d:	75 d6                	jne    401f05 <submitr+0x3a3>
  401f2f:	4d 85 ed             	test   %r13,%r13
  401f32:	79 5f                	jns    401f93 <submitr+0x431>
  401f34:	48 b8 45 72 72 6f 72 	movabs $0x43203a726f727245,%rax
  401f3b:	3a 20 43 
  401f3e:	49 89 07             	mov    %rax,(%r15)
  401f41:	48 b8 6c 69 65 6e 74 	movabs $0x6e7520746e65696c,%rax
  401f48:	20 75 6e 
  401f4b:	49 89 47 08          	mov    %rax,0x8(%r15)
  401f4f:	48 b8 61 62 6c 65 20 	movabs $0x206f7420656c6261,%rax
  401f56:	74 6f 20 
  401f59:	49 89 47 10          	mov    %rax,0x10(%r15)
  401f5d:	48 b8 77 72 69 74 65 	movabs $0x6f74206574697277,%rax
  401f64:	20 74 6f 
  401f67:	49 89 47 18          	mov    %rax,0x18(%r15)
  401f6b:	48 b8 20 74 68 65 20 	movabs $0x7265732065687420,%rax
  401f72:	73 65 72 
  401f75:	49 89 47 20          	mov    %rax,0x20(%r15)
  401f79:	41 c7 47 28 76 65 72 	movl   $0x726576,0x28(%r15)
  401f80:	00 
  401f81:	44 89 e7             	mov    %r12d,%edi
  401f84:	e8 77 ec ff ff       	callq  400c00 <close@plt>
  401f89:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  401f8e:	e9 9d 02 00 00       	jmpq   402230 <submitr+0x6ce>
  401f93:	44 89 64 24 40       	mov    %r12d,0x40(%rsp)
  401f98:	c7 44 24 44 00 00 00 	movl   $0x0,0x44(%rsp)
  401f9f:	00 
  401fa0:	48 8d 44 24 50       	lea    0x50(%rsp),%rax
  401fa5:	48 89 44 24 48       	mov    %rax,0x48(%rsp)
  401faa:	ba 00 20 00 00       	mov    $0x2000,%edx
  401faf:	48 8d b4 24 50 20 00 	lea    0x2050(%rsp),%rsi
  401fb6:	00 
  401fb7:	48 8d 7c 24 40       	lea    0x40(%rsp),%rdi
  401fbc:	e8 af fa ff ff       	callq  401a70 <rio_readlineb>
  401fc1:	48 85 c0             	test   %rax,%rax
  401fc4:	7f 74                	jg     40203a <submitr+0x4d8>
  401fc6:	48 b8 45 72 72 6f 72 	movabs $0x43203a726f727245,%rax
  401fcd:	3a 20 43 
  401fd0:	49 89 07             	mov    %rax,(%r15)
  401fd3:	48 b8 6c 69 65 6e 74 	movabs $0x6e7520746e65696c,%rax
  401fda:	20 75 6e 
  401fdd:	49 89 47 08          	mov    %rax,0x8(%r15)
  401fe1:	48 b8 61 62 6c 65 20 	movabs $0x206f7420656c6261,%rax
  401fe8:	74 6f 20 
  401feb:	49 89 47 10          	mov    %rax,0x10(%r15)
  401fef:	48 b8 72 65 61 64 20 	movabs $0x7269662064616572,%rax
  401ff6:	66 69 72 
  401ff9:	49 89 47 18          	mov    %rax,0x18(%r15)
  401ffd:	48 b8 73 74 20 68 65 	movabs $0x6564616568207473,%rax
  402004:	61 64 65 
  402007:	49 89 47 20          	mov    %rax,0x20(%r15)
  40200b:	48 b8 72 20 66 72 6f 	movabs $0x73206d6f72662072,%rax
  402012:	6d 20 73 
  402015:	49 89 47 28          	mov    %rax,0x28(%r15)
  402019:	41 c7 47 30 65 72 76 	movl   $0x65767265,0x30(%r15)
  402020:	65 
  402021:	66 41 c7 47 34 72 00 	movw   $0x72,0x34(%r15)
  402028:	44 89 e7             	mov    %r12d,%edi
  40202b:	e8 d0 eb ff ff       	callq  400c00 <close@plt>
  402030:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  402035:	e9 f6 01 00 00       	jmpq   402230 <submitr+0x6ce>
  40203a:	4c 8d 84 24 50 80 00 	lea    0x8050(%rsp),%r8
  402041:	00 
  402042:	48 8d 4c 24 2c       	lea    0x2c(%rsp),%rcx
  402047:	48 8d 94 24 50 60 00 	lea    0x6050(%rsp),%rdx
  40204e:	00 
  40204f:	be f7 2e 40 00       	mov    $0x402ef7,%esi
  402054:	48 8d bc 24 50 20 00 	lea    0x2050(%rsp),%rdi
  40205b:	00 
  40205c:	b8 00 00 00 00       	mov    $0x0,%eax
  402061:	e8 2a ec ff ff       	callq  400c90 <__isoc99_sscanf@plt>
  402066:	44 8b 44 24 2c       	mov    0x2c(%rsp),%r8d
  40206b:	41 81 f8 c8 00 00 00 	cmp    $0xc8,%r8d
  402072:	0f 84 be 00 00 00    	je     402136 <submitr+0x5d4>
  402078:	4c 8d 8c 24 50 80 00 	lea    0x8050(%rsp),%r9
  40207f:	00 
  402080:	b9 40 2e 40 00       	mov    $0x402e40,%ecx
  402085:	48 c7 c2 ff ff ff ff 	mov    $0xffffffffffffffff,%rdx
  40208c:	be 01 00 00 00       	mov    $0x1,%esi
  402091:	4c 89 ff             	mov    %r15,%rdi
  402094:	b8 00 00 00 00       	mov    $0x0,%eax
  402099:	e8 82 ec ff ff       	callq  400d20 <__sprintf_chk@plt>
  40209e:	44 89 e7             	mov    %r12d,%edi
  4020a1:	e8 5a eb ff ff       	callq  400c00 <close@plt>
  4020a6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  4020ab:	e9 80 01 00 00       	jmpq   402230 <submitr+0x6ce>
  4020b0:	ba 00 20 00 00       	mov    $0x2000,%edx
  4020b5:	48 8d b4 24 50 20 00 	lea    0x2050(%rsp),%rsi
  4020bc:	00 
  4020bd:	48 8d 7c 24 40       	lea    0x40(%rsp),%rdi
  4020c2:	e8 a9 f9 ff ff       	callq  401a70 <rio_readlineb>
  4020c7:	48 85 c0             	test   %rax,%rax
  4020ca:	7f 6a                	jg     402136 <submitr+0x5d4>
  4020cc:	48 b8 45 72 72 6f 72 	movabs $0x43203a726f727245,%rax
  4020d3:	3a 20 43 
  4020d6:	49 89 07             	mov    %rax,(%r15)
  4020d9:	48 b8 6c 69 65 6e 74 	movabs $0x6e7520746e65696c,%rax
  4020e0:	20 75 6e 
  4020e3:	49 89 47 08          	mov    %rax,0x8(%r15)
  4020e7:	48 b8 61 62 6c 65 20 	movabs $0x206f7420656c6261,%rax
  4020ee:	74 6f 20 
  4020f1:	49 89 47 10          	mov    %rax,0x10(%r15)
  4020f5:	48 b8 72 65 61 64 20 	movabs $0x6165682064616572,%rax
  4020fc:	68 65 61 
  4020ff:	49 89 47 18          	mov    %rax,0x18(%r15)
  402103:	48 b8 64 65 72 73 20 	movabs $0x6f72662073726564,%rax
  40210a:	66 72 6f 
  40210d:	49 89 47 20          	mov    %rax,0x20(%r15)
  402111:	48 b8 6d 20 73 65 72 	movabs $0x726576726573206d,%rax
  402118:	76 65 72 
  40211b:	49 89 47 28          	mov    %rax,0x28(%r15)
  40211f:	41 c6 47 30 00       	movb   $0x0,0x30(%r15)
  402124:	44 89 e7             	mov    %r12d,%edi
  402127:	e8 d4 ea ff ff       	callq  400c00 <close@plt>
  40212c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  402131:	e9 fa 00 00 00       	jmpq   402230 <submitr+0x6ce>
  402136:	80 bc 24 50 20 00 00 	cmpb   $0xd,0x2050(%rsp)
  40213d:	0d 
  40213e:	0f 85 6c ff ff ff    	jne    4020b0 <submitr+0x54e>
  402144:	80 bc 24 51 20 00 00 	cmpb   $0xa,0x2051(%rsp)
  40214b:	0a 
  40214c:	0f 85 5e ff ff ff    	jne    4020b0 <submitr+0x54e>
  402152:	80 bc 24 52 20 00 00 	cmpb   $0x0,0x2052(%rsp)
  402159:	00 
  40215a:	0f 85 50 ff ff ff    	jne    4020b0 <submitr+0x54e>
  402160:	ba 00 20 00 00       	mov    $0x2000,%edx
  402165:	48 8d b4 24 50 20 00 	lea    0x2050(%rsp),%rsi
  40216c:	00 
  40216d:	48 8d 7c 24 40       	lea    0x40(%rsp),%rdi
  402172:	e8 f9 f8 ff ff       	callq  401a70 <rio_readlineb>
  402177:	48 85 c0             	test   %rax,%rax
  40217a:	7f 70                	jg     4021ec <submitr+0x68a>
  40217c:	48 b8 45 72 72 6f 72 	movabs $0x43203a726f727245,%rax
  402183:	3a 20 43 
  402186:	49 89 07             	mov    %rax,(%r15)
  402189:	48 b8 6c 69 65 6e 74 	movabs $0x6e7520746e65696c,%rax
  402190:	20 75 6e 
  402193:	49 89 47 08          	mov    %rax,0x8(%r15)
  402197:	48 b8 61 62 6c 65 20 	movabs $0x206f7420656c6261,%rax
  40219e:	74 6f 20 
  4021a1:	49 89 47 10          	mov    %rax,0x10(%r15)
  4021a5:	48 b8 72 65 61 64 20 	movabs $0x6174732064616572,%rax
  4021ac:	73 74 61 
  4021af:	49 89 47 18          	mov    %rax,0x18(%r15)
  4021b3:	48 b8 74 75 73 20 6d 	movabs $0x7373656d20737574,%rax
  4021ba:	65 73 73 
  4021bd:	49 89 47 20          	mov    %rax,0x20(%r15)
  4021c1:	48 b8 61 67 65 20 66 	movabs $0x6d6f726620656761,%rax
  4021c8:	72 6f 6d 
  4021cb:	49 89 47 28          	mov    %rax,0x28(%r15)
  4021cf:	48 b8 20 73 65 72 76 	movabs $0x72657672657320,%rax
  4021d6:	65 72 00 
  4021d9:	49 89 47 30          	mov    %rax,0x30(%r15)
  4021dd:	44 89 e7             	mov    %r12d,%edi
  4021e0:	e8 1b ea ff ff       	callq  400c00 <close@plt>
  4021e5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  4021ea:	eb 44                	jmp    402230 <submitr+0x6ce>
  4021ec:	48 8d b4 24 50 20 00 	lea    0x2050(%rsp),%rsi
  4021f3:	00 
  4021f4:	4c 89 ff             	mov    %r15,%rdi
  4021f7:	e8 b4 e9 ff ff       	callq  400bb0 <strcpy@plt>
  4021fc:	44 89 e7             	mov    %r12d,%edi
  4021ff:	e8 fc e9 ff ff       	callq  400c00 <close@plt>
  402204:	41 0f b6 17          	movzbl (%r15),%edx
  402208:	b8 4f 00 00 00       	mov    $0x4f,%eax
  40220d:	29 d0                	sub    %edx,%eax
  40220f:	75 15                	jne    402226 <submitr+0x6c4>
  402211:	41 0f b6 57 01       	movzbl 0x1(%r15),%edx
  402216:	b8 4b 00 00 00       	mov    $0x4b,%eax
  40221b:	29 d0                	sub    %edx,%eax
  40221d:	75 07                	jne    402226 <submitr+0x6c4>
  40221f:	41 0f b6 47 02       	movzbl 0x2(%r15),%eax
  402224:	f7 d8                	neg    %eax
  402226:	85 c0                	test   %eax,%eax
  402228:	0f 95 c0             	setne  %al
  40222b:	0f b6 c0             	movzbl %al,%eax
  40222e:	f7 d8                	neg    %eax
  402230:	48 8b 8c 24 58 a0 00 	mov    0xa058(%rsp),%rcx
  402237:	00 
  402238:	64 48 33 0c 25 28 00 	xor    %fs:0x28,%rcx
  40223f:	00 00 
  402241:	0f 84 12 01 00 00    	je     402359 <submitr+0x7f7>
  402247:	e9 08 01 00 00       	jmpq   402354 <submitr+0x7f2>
  40224c:	48 b8 45 72 72 6f 72 	movabs $0x52203a726f727245,%rax
  402253:	3a 20 52 
  402256:	49 89 07             	mov    %rax,(%r15)
  402259:	48 b8 65 73 75 6c 74 	movabs $0x747320746c757365,%rax
  402260:	20 73 74 
  402263:	49 89 47 08          	mov    %rax,0x8(%r15)
  402267:	48 b8 72 69 6e 67 20 	movabs $0x6e6f6320676e6972,%rax
  40226e:	63 6f 6e 
  402271:	49 89 47 10          	mov    %rax,0x10(%r15)
  402275:	48 b8 74 61 69 6e 73 	movabs $0x6e6120736e696174,%rax
  40227c:	20 61 6e 
  40227f:	49 89 47 18          	mov    %rax,0x18(%r15)
  402283:	48 b8 20 69 6c 6c 65 	movabs $0x6c6167656c6c6920,%rax
  40228a:	67 61 6c 
  40228d:	49 89 47 20          	mov    %rax,0x20(%r15)
  402291:	48 b8 20 6f 72 20 75 	movabs $0x72706e7520726f20,%rax
  402298:	6e 70 72 
  40229b:	49 89 47 28          	mov    %rax,0x28(%r15)
  40229f:	48 b8 69 6e 74 61 62 	movabs $0x20656c6261746e69,%rax
  4022a6:	6c 65 20 
  4022a9:	49 89 47 30          	mov    %rax,0x30(%r15)
  4022ad:	48 b8 63 68 61 72 61 	movabs $0x6574636172616863,%rax
  4022b4:	63 74 65 
  4022b7:	49 89 47 38          	mov    %rax,0x38(%r15)
  4022bb:	66 41 c7 47 40 72 2e 	movw   $0x2e72,0x40(%r15)
  4022c2:	41 c6 47 42 00       	movb   $0x0,0x42(%r15)
  4022c7:	44 89 e7             	mov    %r12d,%edi
  4022ca:	e8 31 e9 ff ff       	callq  400c00 <close@plt>
  4022cf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  4022d4:	e9 57 ff ff ff       	jmpq   402230 <submitr+0x6ce>
  4022d9:	48 8d 9c 24 50 20 00 	lea    0x2050(%rsp),%rbx
  4022e0:	00 
  4022e1:	48 83 ec 08          	sub    $0x8,%rsp
  4022e5:	48 8d 84 24 58 40 00 	lea    0x4058(%rsp),%rax
  4022ec:	00 
  4022ed:	50                   	push   %rax
  4022ee:	ff 74 24 20          	pushq  0x20(%rsp)
  4022f2:	ff 74 24 30          	pushq  0x30(%rsp)
  4022f6:	4c 8b 4c 24 28       	mov    0x28(%rsp),%r9
  4022fb:	4c 8b 44 24 20       	mov    0x20(%rsp),%r8
  402300:	b9 70 2e 40 00       	mov    $0x402e70,%ecx
  402305:	ba 00 20 00 00       	mov    $0x2000,%edx
  40230a:	be 01 00 00 00       	mov    $0x1,%esi
  40230f:	48 89 df             	mov    %rbx,%rdi
  402312:	b8 00 00 00 00       	mov    $0x0,%eax
  402317:	e8 04 ea ff ff       	callq  400d20 <__sprintf_chk@plt>
  40231c:	b8 00 00 00 00       	mov    $0x0,%eax
  402321:	48 c7 c1 ff ff ff ff 	mov    $0xffffffffffffffff,%rcx
  402328:	48 89 df             	mov    %rbx,%rdi
  40232b:	f2 ae                	repnz scas %es:(%rdi),%al
  40232d:	48 89 c8             	mov    %rcx,%rax
  402330:	48 f7 d0             	not    %rax
  402333:	4c 8d 68 ff          	lea    -0x1(%rax),%r13
  402337:	48 83 c4 20          	add    $0x20,%rsp
  40233b:	4c 89 eb             	mov    %r13,%rbx
  40233e:	48 8d ac 24 50 20 00 	lea    0x2050(%rsp),%rbp
  402345:	00 
  402346:	4d 85 ed             	test   %r13,%r13
  402349:	0f 85 b6 fb ff ff    	jne    401f05 <submitr+0x3a3>
  40234f:	e9 3f fc ff ff       	jmpq   401f93 <submitr+0x431>
  402354:	e8 87 e8 ff ff       	callq  400be0 <__stack_chk_fail@plt>
  402359:	48 81 c4 68 a0 00 00 	add    $0xa068,%rsp
  402360:	5b                   	pop    %rbx
  402361:	5d                   	pop    %rbp
  402362:	41 5c                	pop    %r12
  402364:	41 5d                	pop    %r13
  402366:	41 5e                	pop    %r14
  402368:	41 5f                	pop    %r15
  40236a:	c3                   	retq   

000000000040236b <init_timeout>:
  40236b:	85 ff                	test   %edi,%edi
  40236d:	74 22                	je     402391 <init_timeout+0x26>
  40236f:	53                   	push   %rbx
  402370:	89 fb                	mov    %edi,%ebx
  402372:	be 42 1a 40 00       	mov    $0x401a42,%esi
  402377:	bf 0e 00 00 00       	mov    $0xe,%edi
  40237c:	e8 bf e8 ff ff       	callq  400c40 <signal@plt>
  402381:	85 db                	test   %ebx,%ebx
  402383:	bf 00 00 00 00       	mov    $0x0,%edi
  402388:	0f 49 fb             	cmovns %ebx,%edi
  40238b:	e8 60 e8 ff ff       	callq  400bf0 <alarm@plt>
  402390:	5b                   	pop    %rbx
  402391:	f3 c3                	repz retq 

0000000000402393 <init_driver>:
  402393:	55                   	push   %rbp
  402394:	53                   	push   %rbx
  402395:	48 83 ec 28          	sub    $0x28,%rsp
  402399:	48 89 fd             	mov    %rdi,%rbp
  40239c:	64 48 8b 04 25 28 00 	mov    %fs:0x28,%rax
  4023a3:	00 00 
  4023a5:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
  4023aa:	31 c0                	xor    %eax,%eax
  4023ac:	be 01 00 00 00       	mov    $0x1,%esi
  4023b1:	bf 0d 00 00 00       	mov    $0xd,%edi
  4023b6:	e8 85 e8 ff ff       	callq  400c40 <signal@plt>
  4023bb:	be 01 00 00 00       	mov    $0x1,%esi
  4023c0:	bf 1d 00 00 00       	mov    $0x1d,%edi
  4023c5:	e8 76 e8 ff ff       	callq  400c40 <signal@plt>
  4023ca:	be 01 00 00 00       	mov    $0x1,%esi
  4023cf:	bf 1d 00 00 00       	mov    $0x1d,%edi
  4023d4:	e8 67 e8 ff ff       	callq  400c40 <signal@plt>
  4023d9:	ba 00 00 00 00       	mov    $0x0,%edx
  4023de:	be 01 00 00 00       	mov    $0x1,%esi
  4023e3:	bf 02 00 00 00       	mov    $0x2,%edi
  4023e8:	e8 43 e9 ff ff       	callq  400d30 <socket@plt>
  4023ed:	85 c0                	test   %eax,%eax
  4023ef:	79 4f                	jns    402440 <init_driver+0xad>
  4023f1:	48 b8 45 72 72 6f 72 	movabs $0x43203a726f727245,%rax
  4023f8:	3a 20 43 
  4023fb:	48 89 45 00          	mov    %rax,0x0(%rbp)
  4023ff:	48 b8 6c 69 65 6e 74 	movabs $0x6e7520746e65696c,%rax
  402406:	20 75 6e 
  402409:	48 89 45 08          	mov    %rax,0x8(%rbp)
  40240d:	48 b8 61 62 6c 65 20 	movabs $0x206f7420656c6261,%rax
  402414:	74 6f 20 
  402417:	48 89 45 10          	mov    %rax,0x10(%rbp)
  40241b:	48 b8 63 72 65 61 74 	movabs $0x7320657461657263,%rax
  402422:	65 20 73 
  402425:	48 89 45 18          	mov    %rax,0x18(%rbp)
  402429:	c7 45 20 6f 63 6b 65 	movl   $0x656b636f,0x20(%rbp)
  402430:	66 c7 45 24 74 00    	movw   $0x74,0x24(%rbp)
  402436:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  40243b:	e9 0c 01 00 00       	jmpq   40254c <init_driver+0x1b9>
  402440:	89 c3                	mov    %eax,%ebx
  402442:	bf 08 2f 40 00       	mov    $0x402f08,%edi
  402447:	e8 04 e8 ff ff       	callq  400c50 <gethostbyname@plt>
  40244c:	48 85 c0             	test   %rax,%rax
  40244f:	75 68                	jne    4024b9 <init_driver+0x126>
  402451:	48 b8 45 72 72 6f 72 	movabs $0x44203a726f727245,%rax
  402458:	3a 20 44 
  40245b:	48 89 45 00          	mov    %rax,0x0(%rbp)
  40245f:	48 b8 4e 53 20 69 73 	movabs $0x6e7520736920534e,%rax
  402466:	20 75 6e 
  402469:	48 89 45 08          	mov    %rax,0x8(%rbp)
  40246d:	48 b8 61 62 6c 65 20 	movabs $0x206f7420656c6261,%rax
  402474:	74 6f 20 
  402477:	48 89 45 10          	mov    %rax,0x10(%rbp)
  40247b:	48 b8 72 65 73 6f 6c 	movabs $0x2065766c6f736572,%rax
  402482:	76 65 20 
  402485:	48 89 45 18          	mov    %rax,0x18(%rbp)
  402489:	48 b8 73 65 72 76 65 	movabs $0x6120726576726573,%rax
  402490:	72 20 61 
  402493:	48 89 45 20          	mov    %rax,0x20(%rbp)
  402497:	c7 45 28 64 64 72 65 	movl   $0x65726464,0x28(%rbp)
  40249e:	66 c7 45 2c 73 73    	movw   $0x7373,0x2c(%rbp)
  4024a4:	c6 45 2e 00          	movb   $0x0,0x2e(%rbp)
  4024a8:	89 df                	mov    %ebx,%edi
  4024aa:	e8 51 e7 ff ff       	callq  400c00 <close@plt>
  4024af:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  4024b4:	e9 93 00 00 00       	jmpq   40254c <init_driver+0x1b9>
  4024b9:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  4024c0:	00 
  4024c1:	48 c7 44 24 08 00 00 	movq   $0x0,0x8(%rsp)
  4024c8:	00 00 
  4024ca:	66 c7 04 24 02 00    	movw   $0x2,(%rsp)
  4024d0:	48 63 50 14          	movslq 0x14(%rax),%rdx
  4024d4:	48 8b 40 18          	mov    0x18(%rax),%rax
  4024d8:	48 8d 7c 24 04       	lea    0x4(%rsp),%rdi
  4024dd:	b9 0c 00 00 00       	mov    $0xc,%ecx
  4024e2:	48 8b 30             	mov    (%rax),%rsi
  4024e5:	e8 76 e7 ff ff       	callq  400c60 <__memmove_chk@plt>
  4024ea:	66 c7 44 24 02 1f 94 	movw   $0x941f,0x2(%rsp)
  4024f1:	ba 10 00 00 00       	mov    $0x10,%edx
  4024f6:	48 89 e6             	mov    %rsp,%rsi
  4024f9:	89 df                	mov    %ebx,%edi
  4024fb:	e8 e0 e7 ff ff       	callq  400ce0 <connect@plt>
  402500:	85 c0                	test   %eax,%eax
  402502:	79 32                	jns    402536 <init_driver+0x1a3>
  402504:	41 b8 08 2f 40 00    	mov    $0x402f08,%r8d
  40250a:	b9 c8 2e 40 00       	mov    $0x402ec8,%ecx
  40250f:	48 c7 c2 ff ff ff ff 	mov    $0xffffffffffffffff,%rdx
  402516:	be 01 00 00 00       	mov    $0x1,%esi
  40251b:	48 89 ef             	mov    %rbp,%rdi
  40251e:	b8 00 00 00 00       	mov    $0x0,%eax
  402523:	e8 f8 e7 ff ff       	callq  400d20 <__sprintf_chk@plt>
  402528:	89 df                	mov    %ebx,%edi
  40252a:	e8 d1 e6 ff ff       	callq  400c00 <close@plt>
  40252f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  402534:	eb 16                	jmp    40254c <init_driver+0x1b9>
  402536:	89 df                	mov    %ebx,%edi
  402538:	e8 c3 e6 ff ff       	callq  400c00 <close@plt>
  40253d:	66 c7 45 00 4f 4b    	movw   $0x4b4f,0x0(%rbp)
  402543:	c6 45 02 00          	movb   $0x0,0x2(%rbp)
  402547:	b8 00 00 00 00       	mov    $0x0,%eax
  40254c:	48 8b 4c 24 18       	mov    0x18(%rsp),%rcx
  402551:	64 48 33 0c 25 28 00 	xor    %fs:0x28,%rcx
  402558:	00 00 
  40255a:	74 05                	je     402561 <init_driver+0x1ce>
  40255c:	e8 7f e6 ff ff       	callq  400be0 <__stack_chk_fail@plt>
  402561:	48 83 c4 28          	add    $0x28,%rsp
  402565:	5b                   	pop    %rbx
  402566:	5d                   	pop    %rbp
  402567:	c3                   	retq   

0000000000402568 <driver_post>:
  402568:	53                   	push   %rbx
  402569:	4c 89 c3             	mov    %r8,%rbx
  40256c:	85 c9                	test   %ecx,%ecx
  40256e:	74 24                	je     402594 <driver_post+0x2c>
  402570:	be 20 2f 40 00       	mov    $0x402f20,%esi
  402575:	bf 01 00 00 00       	mov    $0x1,%edi
  40257a:	b8 00 00 00 00       	mov    $0x0,%eax
  40257f:	e8 1c e7 ff ff       	callq  400ca0 <__printf_chk@plt>
  402584:	66 c7 03 4f 4b       	movw   $0x4b4f,(%rbx)
  402589:	c6 43 02 00          	movb   $0x0,0x2(%rbx)
  40258d:	b8 00 00 00 00       	mov    $0x0,%eax
  402592:	eb 41                	jmp    4025d5 <driver_post+0x6d>
  402594:	48 85 ff             	test   %rdi,%rdi
  402597:	74 2e                	je     4025c7 <driver_post+0x5f>
  402599:	80 3f 00             	cmpb   $0x0,(%rdi)
  40259c:	74 29                	je     4025c7 <driver_post+0x5f>
  40259e:	41 50                	push   %r8
  4025a0:	52                   	push   %rdx
  4025a1:	41 b9 37 2f 40 00    	mov    $0x402f37,%r9d
  4025a7:	49 89 f0             	mov    %rsi,%r8
  4025aa:	48 89 f9             	mov    %rdi,%rcx
  4025ad:	ba 3b 2f 40 00       	mov    $0x402f3b,%edx
  4025b2:	be 94 1f 00 00       	mov    $0x1f94,%esi
  4025b7:	bf 08 2f 40 00       	mov    $0x402f08,%edi
  4025bc:	e8 a1 f5 ff ff       	callq  401b62 <submitr>
  4025c1:	48 83 c4 10          	add    $0x10,%rsp
  4025c5:	eb 0e                	jmp    4025d5 <driver_post+0x6d>
  4025c7:	66 c7 03 4f 4b       	movw   $0x4b4f,(%rbx)
  4025cc:	c6 43 02 00          	movb   $0x0,0x2(%rbx)
  4025d0:	b8 00 00 00 00       	mov    $0x0,%eax
  4025d5:	5b                   	pop    %rbx
  4025d6:	c3                   	retq   
  4025d7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
  4025de:	00 00 

00000000004025e0 <__libc_csu_init>:
  4025e0:	41 57                	push   %r15
  4025e2:	41 56                	push   %r14
  4025e4:	41 89 ff             	mov    %edi,%r15d
  4025e7:	41 55                	push   %r13
  4025e9:	41 54                	push   %r12
  4025eb:	4c 8d 25 1e 18 20 00 	lea    0x20181e(%rip),%r12        # 603e10 <__frame_dummy_init_array_entry>
  4025f2:	55                   	push   %rbp
  4025f3:	48 8d 2d 1e 18 20 00 	lea    0x20181e(%rip),%rbp        # 603e18 <__init_array_end>
  4025fa:	53                   	push   %rbx
  4025fb:	49 89 f6             	mov    %rsi,%r14
  4025fe:	49 89 d5             	mov    %rdx,%r13
  402601:	4c 29 e5             	sub    %r12,%rbp
  402604:	48 83 ec 08          	sub    $0x8,%rsp
  402608:	48 c1 fd 03          	sar    $0x3,%rbp
  40260c:	e8 27 e5 ff ff       	callq  400b38 <_init>
  402611:	48 85 ed             	test   %rbp,%rbp
  402614:	74 20                	je     402636 <__libc_csu_init+0x56>
  402616:	31 db                	xor    %ebx,%ebx
  402618:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
  40261f:	00 
  402620:	4c 89 ea             	mov    %r13,%rdx
  402623:	4c 89 f6             	mov    %r14,%rsi
  402626:	44 89 ff             	mov    %r15d,%edi
  402629:	41 ff 14 dc          	callq  *(%r12,%rbx,8)
  40262d:	48 83 c3 01          	add    $0x1,%rbx
  402631:	48 39 eb             	cmp    %rbp,%rbx
  402634:	75 ea                	jne    402620 <__libc_csu_init+0x40>
  402636:	48 83 c4 08          	add    $0x8,%rsp
  40263a:	5b                   	pop    %rbx
  40263b:	5d                   	pop    %rbp
  40263c:	41 5c                	pop    %r12
  40263e:	41 5d                	pop    %r13
  402640:	41 5e                	pop    %r14
  402642:	41 5f                	pop    %r15
  402644:	c3                   	retq   
  402645:	90                   	nop
  402646:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  40264d:	00 00 00 

0000000000402650 <__libc_csu_fini>:
  402650:	f3 c3                	repz retq 

Disassembly of section .fini:

0000000000402654 <_fini>:
  402654:	48 83 ec 08          	sub    $0x8,%rsp
  402658:	48 83 c4 08          	add    $0x8,%rsp
  40265c:	c3                   	retq   
