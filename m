Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59A04F97AE
	for <lists+linux-efi@lfdr.de>; Tue, 12 Nov 2019 18:54:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbfKLRyX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 12 Nov 2019 12:54:23 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:35231 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbfKLRyW (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 12 Nov 2019 12:54:22 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iUaMX-0000f4-BJ; Tue, 12 Nov 2019 18:53:57 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id E64A01C0084;
        Tue, 12 Nov 2019 18:53:56 +0100 (CET)
Date:   Tue, 12 Nov 2019 17:53:56 -0000
From:   "tip-bot2 for Daniel Kiper" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/boot: Introduce kernel_info
Cc:     "H. Peter Anvin (Intel)" <hpa@zytor.com>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Borislav Petkov <bp@suse.de>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Ross Philipson <ross.philipson@oracle.com>,
        Andy Lutomirski <luto@amacapital.net>,
        ard.biesheuvel@linaro.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        dave.hansen@linux.intel.com, eric.snowberg@oracle.com,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Juergen Gross <jgross@suse.com>, kanth.ghatraju@oracle.com,
        linux-doc@vger.kernel.org, "linux-efi" <linux-efi@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, rdunlap@infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        "x86-ml" <x86@kernel.org>, xen-devel@lists.xenproject.org,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191112134640.16035-2-daniel.kiper@oracle.com>
References: <20191112134640.16035-2-daniel.kiper@oracle.com>
MIME-Version: 1.0
Message-ID: <157358123647.29376.11005597821774950557.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     2c33c27fd6033ced942c9a591b8ac15c07c57d70
Gitweb:        https://git.kernel.org/tip/2c33c27fd6033ced942c9a591b8ac15c07c57d70
Author:        Daniel Kiper <daniel.kiper@oracle.com>
AuthorDate:    Tue, 12 Nov 2019 14:46:38 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 12 Nov 2019 16:10:34 +01:00

x86/boot: Introduce kernel_info

The relationships between the headers are analogous to the various data
sections:

  setup_header = .data
  boot_params/setup_data = .bss

What is missing from the above list? That's right:

  kernel_info = .rodata

We have been (ab)using .data for things that could go into .rodata or .bss for
a long time, for lack of alternatives and -- especially early on -- inertia.
Also, the BIOS stub is responsible for creating boot_params, so it isn't
available to a BIOS-based loader (setup_data is, though).

setup_header is permanently limited to 144 bytes due to the reach of the
2-byte jump field, which doubles as a length field for the structure, combined
with the size of the "hole" in struct boot_params that a protected-mode loader
or the BIOS stub has to copy it into. It is currently 119 bytes long, which
leaves us with 25 very precious bytes. This isn't something that can be fixed
without revising the boot protocol entirely, breaking backwards compatibility.

boot_params proper is limited to 4096 bytes, but can be arbitrarily extended
by adding setup_data entries. It cannot be used to communicate properties of
the kernel image, because it is .bss and has no image-provided content.

kernel_info solves this by providing an extensible place for information about
the kernel image. It is readonly, because the kernel cannot rely on a
bootloader copying its contents anywhere, but that is OK; if it becomes
necessary it can still contain data items that an enabled bootloader would be
expected to copy into a setup_data chunk.

Do not bump setup_header version in arch/x86/boot/header.S because it
will be followed by additional changes coming into the Linux/x86 boot
protocol.

Suggested-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Reviewed-by: Ross Philipson <ross.philipson@oracle.com>
Reviewed-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: ard.biesheuvel@linaro.org
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: dave.hansen@linux.intel.com
Cc: eric.snowberg@oracle.com
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Juergen Gross <jgross@suse.com>
Cc: kanth.ghatraju@oracle.com
Cc: linux-doc@vger.kernel.org
Cc: linux-efi <linux-efi@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: rdunlap@infradead.org
Cc: ross.philipson@oracle.com
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Cc: xen-devel@lists.xenproject.org
Link: https://lkml.kernel.org/r/20191112134640.16035-2-daniel.kiper@oracle.com
---
 Documentation/x86/boot.rst             | 126 ++++++++++++++++++++++++-
 arch/x86/boot/Makefile                 |   2 +-
 arch/x86/boot/compressed/Makefile      |   4 +-
 arch/x86/boot/compressed/kernel_info.S |  17 +++-
 arch/x86/boot/header.S                 |   1 +-
 arch/x86/boot/tools/build.c            |   5 +-
 arch/x86/include/uapi/asm/bootparam.h  |   1 +-
 7 files changed, 153 insertions(+), 3 deletions(-)
 create mode 100644 arch/x86/boot/compressed/kernel_info.S

diff --git a/Documentation/x86/boot.rst b/Documentation/x86/boot.rst
index 08a2f10..c60fafd 100644
--- a/Documentation/x86/boot.rst
+++ b/Documentation/x86/boot.rst
@@ -68,8 +68,25 @@ Protocol 2.12	(Kernel 3.8) Added the xloadflags field and extension fields
 Protocol 2.13	(Kernel 3.14) Support 32- and 64-bit flags being set in
 		xloadflags to support booting a 64-bit kernel from 32-bit
 		EFI
+
+Protocol 2.14:	BURNT BY INCORRECT COMMIT ae7e1238e68f2a472a125673ab506d49158c1889
+		(x86/boot: Add ACPI RSDP address to setup_header)
+		DO NOT USE!!! ASSUME SAME AS 2.13.
+
+Protocol 2.15:	(Kernel 5.5) Added the kernel_info.
 =============	============================================================
 
+.. note::
+     The protocol version number should be changed only if the setup header
+     is changed. There is no need to update the version number if boot_params
+     or kernel_info are changed. Additionally, it is recommended to use
+     xloadflags (in this case the protocol version number should not be
+     updated either) or kernel_info to communicate supported Linux kernel
+     features to the boot loader. Due to very limited space available in
+     the original setup header every update to it should be considered
+     with great care. Starting from the protocol 2.15 the primary way to
+     communicate things to the boot loader is the kernel_info.
+
 
 Memory Layout
 =============
@@ -207,6 +224,7 @@ Offset/Size	Proto		Name			Meaning
 0258/8		2.10+		pref_address		Preferred loading address
 0260/4		2.10+		init_size		Linear memory required during initialization
 0264/4		2.11+		handover_offset		Offset of handover entry point
+0268/4		2.15+		kernel_info_offset	Offset of the kernel_info
 ===========	========	=====================	============================================
 
 .. note::
@@ -855,6 +873,114 @@ Offset/size:	0x264/4
 
   See EFI HANDOVER PROTOCOL below for more details.
 
+============	==================
+Field name:	kernel_info_offset
+Type:		read
+Offset/size:	0x268/4
+Protocol:	2.15+
+============	==================
+
+  This field is the offset from the beginning of the kernel image to the
+  kernel_info. The kernel_info structure is embedded in the Linux image
+  in the uncompressed protected mode region.
+
+
+The kernel_info
+===============
+
+The relationships between the headers are analogous to the various data
+sections:
+
+  setup_header = .data
+  boot_params/setup_data = .bss
+
+What is missing from the above list? That's right:
+
+  kernel_info = .rodata
+
+We have been (ab)using .data for things that could go into .rodata or .bss for
+a long time, for lack of alternatives and -- especially early on -- inertia.
+Also, the BIOS stub is responsible for creating boot_params, so it isn't
+available to a BIOS-based loader (setup_data is, though).
+
+setup_header is permanently limited to 144 bytes due to the reach of the
+2-byte jump field, which doubles as a length field for the structure, combined
+with the size of the "hole" in struct boot_params that a protected-mode loader
+or the BIOS stub has to copy it into. It is currently 119 bytes long, which
+leaves us with 25 very precious bytes. This isn't something that can be fixed
+without revising the boot protocol entirely, breaking backwards compatibility.
+
+boot_params proper is limited to 4096 bytes, but can be arbitrarily extended
+by adding setup_data entries. It cannot be used to communicate properties of
+the kernel image, because it is .bss and has no image-provided content.
+
+kernel_info solves this by providing an extensible place for information about
+the kernel image. It is readonly, because the kernel cannot rely on a
+bootloader copying its contents anywhere, but that is OK; if it becomes
+necessary it can still contain data items that an enabled bootloader would be
+expected to copy into a setup_data chunk.
+
+All kernel_info data should be part of this structure. Fixed size data have to
+be put before kernel_info_var_len_data label. Variable size data have to be put
+after kernel_info_var_len_data label. Each chunk of variable size data has to
+be prefixed with header/magic and its size, e.g.:
+
+  kernel_info:
+          .ascii  "LToP"          /* Header, Linux top (structure). */
+          .long   kernel_info_var_len_data - kernel_info
+          .long   kernel_info_end - kernel_info
+          .long   0x01234567      /* Some fixed size data for the bootloaders. */
+  kernel_info_var_len_data:
+  example_struct:                 /* Some variable size data for the bootloaders. */
+          .ascii  "0123"          /* Header/Magic. */
+          .long   example_struct_end - example_struct
+          .ascii  "Struct"
+          .long   0x89012345
+  example_struct_end:
+  example_strings:                /* Some variable size data for the bootloaders. */
+          .ascii  "ABCD"          /* Header/Magic. */
+          .long   example_strings_end - example_strings
+          .asciz  "String_0"
+          .asciz  "String_1"
+  example_strings_end:
+  kernel_info_end:
+
+This way the kernel_info is self-contained blob.
+
+.. note::
+     Each variable size data header/magic can be any 4-character string,
+     without \0 at the end of the string, which does not collide with
+     existing variable length data headers/magics.
+
+
+Details of the kernel_info Fields
+=================================
+
+============	========
+Field name:	header
+Offset/size:	0x0000/4
+============	========
+
+  Contains the magic number "LToP" (0x506f544c).
+
+============	========
+Field name:	size
+Offset/size:	0x0004/4
+============	========
+
+  This field contains the size of the kernel_info including kernel_info.header.
+  It does not count kernel_info.kernel_info_var_len_data size. This field should be
+  used by the bootloaders to detect supported fixed size fields in the kernel_info
+  and beginning of kernel_info.kernel_info_var_len_data.
+
+============	========
+Field name:	size_total
+Offset/size:	0x0008/4
+============	========
+
+  This field contains the size of the kernel_info including kernel_info.header
+  and kernel_info.kernel_info_var_len_data.
+
 
 The Image Checksum
 ==================
diff --git a/arch/x86/boot/Makefile b/arch/x86/boot/Makefile
index e2839b5..c30a9b6 100644
--- a/arch/x86/boot/Makefile
+++ b/arch/x86/boot/Makefile
@@ -87,7 +87,7 @@ $(obj)/vmlinux.bin: $(obj)/compressed/vmlinux FORCE
 
 SETUP_OBJS = $(addprefix $(obj)/,$(setup-y))
 
-sed-zoffset := -e 's/^\([0-9a-fA-F]*\) [ABCDGRSTVW] \(startup_32\|startup_64\|efi32_stub_entry\|efi64_stub_entry\|efi_pe_entry\|input_data\|_end\|_ehead\|_text\|z_.*\)$$/\#define ZO_\2 0x\1/p'
+sed-zoffset := -e 's/^\([0-9a-fA-F]*\) [ABCDGRSTVW] \(startup_32\|startup_64\|efi32_stub_entry\|efi64_stub_entry\|efi_pe_entry\|input_data\|kernel_info\|_end\|_ehead\|_text\|z_.*\)$$/\#define ZO_\2 0x\1/p'
 
 quiet_cmd_zoffset = ZOFFSET $@
       cmd_zoffset = $(NM) $< | sed -n $(sed-zoffset) > $@
diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 6b84afd..fad3b18 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -72,8 +72,8 @@ $(obj)/../voffset.h: vmlinux FORCE
 
 $(obj)/misc.o: $(obj)/../voffset.h
 
-vmlinux-objs-y := $(obj)/vmlinux.lds $(obj)/head_$(BITS).o $(obj)/misc.o \
-	$(obj)/string.o $(obj)/cmdline.o $(obj)/error.o \
+vmlinux-objs-y := $(obj)/vmlinux.lds $(obj)/kernel_info.o $(obj)/head_$(BITS).o \
+	$(obj)/misc.o $(obj)/string.o $(obj)/cmdline.o $(obj)/error.o \
 	$(obj)/piggy.o $(obj)/cpuflags.o
 
 vmlinux-objs-$(CONFIG_EARLY_PRINTK) += $(obj)/early_serial_console.o
diff --git a/arch/x86/boot/compressed/kernel_info.S b/arch/x86/boot/compressed/kernel_info.S
new file mode 100644
index 0000000..8ea6f6e
--- /dev/null
+++ b/arch/x86/boot/compressed/kernel_info.S
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+	.section ".rodata.kernel_info", "a"
+
+	.global kernel_info
+
+kernel_info:
+	/* Header, Linux top (structure). */
+	.ascii	"LToP"
+	/* Size. */
+	.long	kernel_info_var_len_data - kernel_info
+	/* Size total. */
+	.long	kernel_info_end - kernel_info
+
+kernel_info_var_len_data:
+	/* Empty for time being... */
+kernel_info_end:
diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
index 2c11c0f..22dceca 100644
--- a/arch/x86/boot/header.S
+++ b/arch/x86/boot/header.S
@@ -567,6 +567,7 @@ pref_address:		.quad LOAD_PHYSICAL_ADDR	# preferred load addr
 
 init_size:		.long INIT_SIZE		# kernel initialization size
 handover_offset:	.long 0			# Filled in by build.c
+kernel_info_offset:	.long 0			# Filled in by build.c
 
 # End of setup header #####################################################
 
diff --git a/arch/x86/boot/tools/build.c b/arch/x86/boot/tools/build.c
index a93d44e..55e669d 100644
--- a/arch/x86/boot/tools/build.c
+++ b/arch/x86/boot/tools/build.c
@@ -56,6 +56,7 @@ u8 buf[SETUP_SECT_MAX*512];
 unsigned long efi32_stub_entry;
 unsigned long efi64_stub_entry;
 unsigned long efi_pe_entry;
+unsigned long kernel_info;
 unsigned long startup_64;
 
 /*----------------------------------------------------------------------*/
@@ -321,6 +322,7 @@ static void parse_zoffset(char *fname)
 		PARSE_ZOFS(p, efi32_stub_entry);
 		PARSE_ZOFS(p, efi64_stub_entry);
 		PARSE_ZOFS(p, efi_pe_entry);
+		PARSE_ZOFS(p, kernel_info);
 		PARSE_ZOFS(p, startup_64);
 
 		p = strchr(p, '\n');
@@ -410,6 +412,9 @@ int main(int argc, char ** argv)
 
 	efi_stub_entry_update();
 
+	/* Update kernel_info offset. */
+	put_unaligned_le32(kernel_info, &buf[0x268]);
+
 	crc = partial_crc32(buf, i, crc);
 	if (fwrite(buf, 1, i, dest) != i)
 		die("Writing setup failed");
diff --git a/arch/x86/include/uapi/asm/bootparam.h b/arch/x86/include/uapi/asm/bootparam.h
index c895df5..a1ebcd7 100644
--- a/arch/x86/include/uapi/asm/bootparam.h
+++ b/arch/x86/include/uapi/asm/bootparam.h
@@ -88,6 +88,7 @@ struct setup_header {
 	__u64	pref_address;
 	__u32	init_size;
 	__u32	handover_offset;
+	__u32	kernel_info_offset;
 } __attribute__((packed));
 
 struct sys_desc_table {
