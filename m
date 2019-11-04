Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB8B3EE351
	for <lists+linux-efi@lfdr.de>; Mon,  4 Nov 2019 16:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728178AbfKDPPc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 4 Nov 2019 10:15:32 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:54044 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727796AbfKDPPb (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 4 Nov 2019 10:15:31 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA4FCRhY032276;
        Mon, 4 Nov 2019 15:14:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=DKkR9B0pyfeJWw3qfq3SJ4xhN9wi6hAARN2vGh5YHPc=;
 b=dZr8UmC9gIfWcs0WK5ETtt3pPs4C337gYK4dgkfk/PWmbwAoDuprjLQ+ydN7VX+BCikP
 ZmMJhbt0JUsmLHUHeGMo0/md0JKo6gE1CrCqeHgBM2+Knq9Bm0JQWPDJkrhpsQN12Nup
 pkBZB9zvi8IxNVeRs0zbUW/jZb2ZeHThtlvl23jJw4cdY1Ok/mDcxVox+nK/PjmOFmpj
 gIhV75FerBpZScRaoOP8guER/kZ6Citk/H6RNM/yk5HANkQbssS2XVwcVsPsLLXS9K6X
 cjpe2bqWJHwc/3U7k+M3ohHaG7sShK+LoJyH/W9pY79J1FSxe+Ouakdry1iHcU56YnWk bg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2w11rpr135-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Nov 2019 15:14:30 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA4FAARU019949;
        Mon, 4 Nov 2019 15:14:30 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2w1kxmhhe0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Nov 2019 15:14:29 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xA4FELkw010740;
        Mon, 4 Nov 2019 15:14:25 GMT
Received: from tomti.i.net-space.pl (/10.175.168.29)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 Nov 2019 07:14:21 -0800
From:   Daniel Kiper <daniel.kiper@oracle.com>
To:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, xen-devel@lists.xenproject.org
Cc:     ard.biesheuvel@linaro.org, boris.ostrovsky@oracle.com,
        bp@alien8.de, corbet@lwn.net, dave.hansen@linux.intel.com,
        luto@kernel.org, peterz@infradead.org, eric.snowberg@oracle.com,
        hpa@zytor.com, jgross@suse.com, kanth.ghatraju@oracle.com,
        konrad.wilk@oracle.com, mingo@redhat.com, rdunlap@infradead.org,
        ross.philipson@oracle.com, tglx@linutronix.de
Subject: [PATCH v5 1/3] x86/boot: Introduce the kernel_info
Date:   Mon,  4 Nov 2019 16:13:52 +0100
Message-Id: <20191104151354.28145-2-daniel.kiper@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20191104151354.28145-1-daniel.kiper@oracle.com>
References: <20191104151354.28145-1-daniel.kiper@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9431 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1911040151
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9431 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1911040151
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

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

This patch does not bump setup_header version in arch/x86/boot/header.S
because it will be followed by additional changes coming into the
Linux/x86 boot protocol.

Suggested-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Reviewed-by: Ross Philipson <ross.philipson@oracle.com>
Reviewed-by: H. Peter Anvin (Intel) <hpa@zytor.com>
---
v4 - suggestions/fixes:
   - improve the documentation
     (suggested by Randy Dunlap and Konrad Rzeszutek Wilk).

v3 - suggestions/fixes:
   - split kernel_info data into fixed and variable sized regions,
     (suggested by H. Peter Anvin),
   - change kernel_info.header value to "LToP" (0x506f544c),
     (suggested by H. Peter Anvin),
   - improve the comments,
   - improve the documentation.

v2 - suggestions/fixes:
   - rename setup_header2 to kernel_info,
     (suggested by H. Peter Anvin),
   - change kernel_info.header value to "InfO" (0x4f666e49),
   - new kernel_info description in Documentation/x86/boot.rst,
     (suggested by H. Peter Anvin),
   - drop kernel_info_offset_update() as an overkill and
     update kernel_info offset directly from main(),
     (suggested by Eric Snowberg),
   - new commit message
     (suggested by H. Peter Anvin),
   - fix some commit message misspellings
     (suggested by Eric Snowberg).
---
 Documentation/x86/boot.rst             | 126 +++++++++++++++++++++++++++++++++
 arch/x86/boot/Makefile                 |   2 +-
 arch/x86/boot/compressed/Makefile      |   4 +-
 arch/x86/boot/compressed/kernel_info.S |  17 +++++
 arch/x86/boot/header.S                 |   1 +
 arch/x86/boot/tools/build.c            |   5 ++
 arch/x86/include/uapi/asm/bootparam.h  |   1 +
 7 files changed, 153 insertions(+), 3 deletions(-)
 create mode 100644 arch/x86/boot/compressed/kernel_info.S

diff --git a/Documentation/x86/boot.rst b/Documentation/x86/boot.rst
index 08a2f100c0e6..c60fafda9427 100644
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
index e2839b5c246c..c30a9b642a86 100644
--- a/arch/x86/boot/Makefile
+++ b/arch/x86/boot/Makefile
@@ -87,7 +87,7 @@ $(obj)/vmlinux.bin: $(obj)/compressed/vmlinux FORCE
 
 SETUP_OBJS = $(addprefix $(obj)/,$(setup-y))
 
-sed-zoffset := -e 's/^\([0-9a-fA-F]*\) [ABCDGRSTVW] \(startup_32\|startup_64\|efi32_stub_entry\|efi64_stub_entry\|efi_pe_entry\|input_data\|_end\|_ehead\|_text\|z_.*\)$$/\#define ZO_\2 0x\1/p'
+sed-zoffset := -e 's/^\([0-9a-fA-F]*\) [ABCDGRSTVW] \(startup_32\|startup_64\|efi32_stub_entry\|efi64_stub_entry\|efi_pe_entry\|input_data\|kernel_info\|_end\|_ehead\|_text\|z_.*\)$$/\#define ZO_\2 0x\1/p'
 
 quiet_cmd_zoffset = ZOFFSET $@
       cmd_zoffset = $(NM) $< | sed -n $(sed-zoffset) > $@
diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 6b84afdd7538..fad3b18e2cc3 100644
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
index 000000000000..8ea6f6e3feef
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
index 2c11c0f45d49..22dcecaaa898 100644
--- a/arch/x86/boot/header.S
+++ b/arch/x86/boot/header.S
@@ -567,6 +567,7 @@ pref_address:		.quad LOAD_PHYSICAL_ADDR	# preferred load addr
 
 init_size:		.long INIT_SIZE		# kernel initialization size
 handover_offset:	.long 0			# Filled in by build.c
+kernel_info_offset:	.long 0			# Filled in by build.c
 
 # End of setup header #####################################################
 
diff --git a/arch/x86/boot/tools/build.c b/arch/x86/boot/tools/build.c
index a93d44e58f9c..55e669d29e54 100644
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
index c895df5482c5..a1ebcd7a991c 100644
--- a/arch/x86/include/uapi/asm/bootparam.h
+++ b/arch/x86/include/uapi/asm/bootparam.h
@@ -88,6 +88,7 @@ struct setup_header {
 	__u64	pref_address;
 	__u32	init_size;
 	__u32	handover_offset;
+	__u32	kernel_info_offset;
 } __attribute__((packed));
 
 struct sys_desc_table {
-- 
2.11.0

