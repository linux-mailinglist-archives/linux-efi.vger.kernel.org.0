Return-Path: <linux-efi+bounces-2896-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7246EA4FBA7
	for <lists+linux-efi@lfdr.de>; Wed,  5 Mar 2025 11:20:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59A813A8399
	for <lists+linux-efi@lfdr.de>; Wed,  5 Mar 2025 10:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A58205E31;
	Wed,  5 Mar 2025 10:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LqKWPP92"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D87206F35
	for <linux-efi@vger.kernel.org>; Wed,  5 Mar 2025 10:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741169891; cv=none; b=Xzp+ZndL5UJh8mFDoAXd52KRnZcE68uQ8LjCCZf+dSkXV7KNwIQ1Xucc02ChGhWj7IUFEUKWK5jtDMBMuS6f1GJC7znZT0cllVqQ7VJG6GoK9jK9sIJH1py4HvwosmxH1Dda2+O61w0EXC/6NIsolJZ9EbSpzldsktzuukvT0/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741169891; c=relaxed/simple;
	bh=118liTgV0wKocxi9/1QW5+iRDLcHLLLHDDoPJXkrKlU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sH/5vRObxA5j7Xxs0DS2l0ZLXzD0cuHcgxPKB4ZuWxX7NPU1AfrqMxzc3oGvZ6CcEz9unMXObOgsjyxj+IveKaiAzyPeBpNJWgrOCkuo+1SigBHCc9v6I+3B4oQfos9WP0Y/f519zAAxDvFd5wAVaBeBE7zfXTv969X8hs72JqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LqKWPP92; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741169888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iJTt4ngPplVdPv8SpfpvbsPxEEu6phBmoiPjcfLKRDY=;
	b=LqKWPP92u+3K34ohHC8feUIgVvFYK00ndkW/k+lQm9zewOLip+Xq8NjohVWelgzWIe9lsy
	SA24HpOHVOnAso6pJOxz8RiPWJX55kDubMYhmx8/o4G9aDqDciEX7XtSYds0wQYfTdMsp4
	i99pA618g14TwXTwoRiwlR0wp9J2Xr8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-413-umcmZr_VP8a5FKXQAksJ-Q-1; Wed,
 05 Mar 2025 05:17:55 -0500
X-MC-Unique: umcmZr_VP8a5FKXQAksJ-Q-1
X-Mimecast-MFC-AGG-ID: umcmZr_VP8a5FKXQAksJ-Q_1741169873
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1161B195608F;
	Wed,  5 Mar 2025 10:17:53 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.34.97])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3EBFE180035E;
	Wed,  5 Mar 2025 10:17:45 +0000 (UTC)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: x86@kernel.org,
	linux-efi@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Peter Jones <pjones@redhat.com>,
	Daniel Berrange <berrange@redhat.com>,
	Emanuele Giuseppe Esposito <eesposit@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Luca Boccassi <bluca@debian.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Matthew Garrett <mjg59@srcf.ucam.org>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC] x86/efi: Add a mechanism for embedding SBAT section
Date: Wed,  5 Mar 2025 11:17:44 +0100
Message-ID: <20250305101744.1706803-1-vkuznets@redhat.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

SBAT is a mechanism which improves SecureBoot revocations of UEFI binaries
by introducing a generation-based technique. Compromised or vulnerable UEFI
binaries can be prevented from booting by bumping the minimal required
generation for the specific component in the bootloader. More information
on the SBAT can be obtained here:

https://github.com/rhboot/shim/blob/main/SBAT.md

Previously, an attempt was made to add ".sbat" section to the linux kernel:

https://lwn.net/Articles/938422/

The approach was rejected mainly because currently there's no policy on how
to update SBAT generation number when a new vulnerability is discovered. In
particular, it is unclear what to do with stable kernels which may or may
not backport certain patches making it impossible to describe the current
state with a simple number.

This patch suggests a different approach: instead of defining SBAT
information, provide a mechanism for downstream kernel builders (distros)
to include their own SBAT data. This leaves the decision on the policy to
the distro vendors. Basically, each distro implementing SecureBoot today,
will have an option to inject their own SBAT data during kernel build and
before it gets signed by their SecureBoot CA. Different distro do not need
to agree on the common SBAT component names or generation numbers as each
distro ships its own 'shim' with their own 'vendor_cert'/'vendor_db'. Linux
upstream will never, ever need to care about the data unless they choose in
the future to participate in that way.

Currently, shim checks .sbat data for itself in self-test and for second
stage bootloaders (grub, sd-boot, UKIs with sd-stub, ...) but kernel
revocations require cycling signing keys or adding kernel hashes to shim's
internal dbx. Adding .sbat to kernel and enforcing it on kernel loading
will allow us to do the same tracking and revocation distros are already
doing with a simplified mechanism, and without having to keep lists of
kernels outside of the git repos.

Finding a place for SBAT section turned out to be a bit tricky. Current
PE layout looks like this:

- without CONFIG_EFI_MIXED:
  +-----------------------------------+-------------------------------+
  | setup            [setup_signature]| compressed text | data [crc32]|
  +-----------------------------------+-----------------+-------------+

- with CONFIG_EFI_MIXED:
  +-------+---------------------------+----------------+-------------+
  | setup | pecompat [setup_signature]| compressed text| data [crc32]|
  +-------+---------------------------+----------------+-------------+

Limitations are:
- To avoid problems with signatures, all sections must be 4k aligned with
  no gaps between them.
- CRC32 must be at the end of the file.
- Nothing can be put before 'setup'.
- Nothing can be squeezed between [setup_signature] and compressed text.
- The whole 'setup' (everything before '.text') must fit into 8 4k pages.

Note: .pecompat contains only 8 bytes of useful data but to save the space,
the tail from .setup including [setup_signature] is also added to it (see
commit 1ad55cecf22f ("x86/efistub: Use 1:1 file:memory mapping for PE/COFF
.compat section")).

With the limitations, there are three straightforward options:
- Put .sbat between .setup and .pecompat. Advantage: with normal sized
SBAT, kernel grows by 1 page only. Disadvantage: this one page comes from
the precious '8 pages' limit.

- Put .sbat to the very end of the file. Advantage: no need to touch
'setup'. Disadvantage: two pages are now needed as we don't want to make
CRC32 part of the SBAT section.

- Put .sbat between '.text' and '.data'. Advantages: no need to touch
'setup' and CRC32. 'CONFIG_EFI_MIXED' case doesn't seem to make much
difference either.

Implement the last one as it doesn't seem to have obvious disadvantages.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
RFC part:
- General acceptance of the idea.
- .sbat section placement.

The implementation is done for x86 only at this moment but I think it
shouldn't be that hard to extend it to other arches (and I hope the
solution for those which use common zboot mechanism will be the same).
---
 arch/x86/Kconfig                       | 25 +++++++++++++++++++++++++
 arch/x86/boot/Makefile                 |  2 +-
 arch/x86/boot/compressed/Makefile      |  7 +++++++
 arch/x86/boot/compressed/sbat.S        |  8 ++++++++
 arch/x86/boot/compressed/vmlinux.lds.S |  8 ++++++++
 arch/x86/boot/header.S                 | 21 +++++++++++++++++++--
 6 files changed, 68 insertions(+), 3 deletions(-)
 create mode 100644 arch/x86/boot/compressed/sbat.S

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index be2c311f5118..05069b085663 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2062,6 +2062,31 @@ config EFI_RUNTIME_MAP
 
 	  See also Documentation/ABI/testing/sysfs-firmware-efi-runtime-map.
 
+config EFI_SBAT
+	bool "Embed SBAT section in the kernel"
+	depends on EFI_STUB
+	help
+	  SBAT section provides a way to improve SecureBoot revocations of UEFI
+	  binaries by introducing a generation-based mechanism. With SBAT, older
+	  UEFI binaries can be prevented from booting by bumping the minimal
+	  required generation for the specific component in the bootloader.
+
+	  Note: SBAT information is distribution specific, i.e. the owner of the
+	  signing SecureBoot certificate must define the SBAT policy. Linux
+	  kernel upstream does not define SBAT components and their generations.
+
+	  See https://github.com/rhboot/shim/blob/main/SBAT.md for the additional
+	  details.
+
+	  If unsure, say N.
+
+config EFI_SBAT_FILE
+	string "Embedded SBAT section file path"
+	depends on EFI_SBAT
+	help
+	  Specify a file with SBAT data which is going to be embedded as '.sbat'
+	  section into the kernel.
+
 source "kernel/Kconfig.hz"
 
 config ARCH_SUPPORTS_KEXEC
diff --git a/arch/x86/boot/Makefile b/arch/x86/boot/Makefile
index 9cc0ff6e9067..73926fc79127 100644
--- a/arch/x86/boot/Makefile
+++ b/arch/x86/boot/Makefile
@@ -75,7 +75,7 @@ $(obj)/vmlinux.bin: $(obj)/compressed/vmlinux FORCE
 
 SETUP_OBJS = $(addprefix $(obj)/,$(setup-y))
 
-sed-zoffset := -e 's/^\([0-9a-fA-F]*\) [a-zA-Z] \(startup_32\|efi.._stub_entry\|efi\(32\)\?_pe_entry\|input_data\|kernel_info\|_end\|_ehead\|_text\|_e\?data\|z_.*\)$$/\#define ZO_\2 0x\1/p'
+sed-zoffset := -e 's/^\([0-9a-fA-F]*\) [a-zA-Z] \(startup_32\|efi.._stub_entry\|efi\(32\)\?_pe_entry\|input_data\|kernel_info\|_end\|_ehead\|_text\|_e\?data\|_e\?sbat\|z_.*\)$$/\#define ZO_\2 0x\1/p'
 
 quiet_cmd_zoffset = ZOFFSET $@
       cmd_zoffset = $(NM) $< | sed -n $(sed-zoffset) > $@
diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 606c74f27459..aef3e20fdbd4 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -107,6 +107,13 @@ vmlinux-objs-$(CONFIG_UNACCEPTED_MEMORY) += $(obj)/mem.o
 vmlinux-objs-$(CONFIG_EFI) += $(obj)/efi.o
 vmlinux-objs-$(CONFIG_EFI_MIXED) += $(obj)/efi_mixed.o
 vmlinux-libs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
+vmlinux-objs-$(CONFIG_EFI_SBAT) += $(obj)/sbat.o
+
+$(obj)/sbat.o: $(obj)/sbat
+targets += sbat
+filechk_sbat = cat $(or $(real-prereqs), /dev/null)
+$(obj)/sbat: $(CONFIG_EFI_SBAT_FILE) FORCE
+	$(call filechk,sbat)
 
 $(obj)/vmlinux: $(vmlinux-objs-y) $(vmlinux-libs-y) FORCE
 	$(call if_changed,ld)
diff --git a/arch/x86/boot/compressed/sbat.S b/arch/x86/boot/compressed/sbat.S
new file mode 100644
index 000000000000..dfa8aeb36660
--- /dev/null
+++ b/arch/x86/boot/compressed/sbat.S
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Embed SBAT data in the kernel.
+ */
+	.pushsection ".sbat", "a", @progbits
+	.incbin "arch/x86/boot/compressed/sbat"
+	.balign	0x1000
+	.popsection
diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
index 083ec6d7722a..c93670bac7f8 100644
--- a/arch/x86/boot/compressed/vmlinux.lds.S
+++ b/arch/x86/boot/compressed/vmlinux.lds.S
@@ -43,6 +43,14 @@ SECTIONS
 		*(.rodata.*)
 		_erodata = . ;
 	}
+#ifdef CONFIG_EFI_SBAT
+	.sbat : ALIGN(0x1000) {
+		_sbat = . ;
+		*(.sbat)
+		_esbat = . ;
+	}
+	ASSERT((_esbat % 0x1000) == 0, "SBAT section end is not page-aligned!")
+#endif
 	.data :	ALIGN(0x1000) {
 		_data = . ;
 		*(.data)
diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
index b5c79f43359b..38ce62ef89d9 100644
--- a/arch/x86/boot/header.S
+++ b/arch/x86/boot/header.S
@@ -183,9 +183,9 @@ pecompat_fstart:
 	.byte	0
 	.byte	0
 	.byte	0
-	.long	ZO__data
+	.long	text_fsize
 	.long	setup_size
-	.long	ZO__data			# Size of initialized data
+	.long	text_fsize			# Size of initialized data
 						# on disk
 	.long	setup_size
 	.long	0				# PointerToRelocations
@@ -196,6 +196,23 @@ pecompat_fstart:
 		IMAGE_SCN_MEM_READ		| \
 		IMAGE_SCN_MEM_EXECUTE		# Characteristics
 
+#ifdef CONFIG_EFI_SBAT
+	.ascii ".sbat\0\0\0"
+	.long	ZO__esbat - ZO__sbat		# VirtualSize
+	.long	setup_size + ZO__sbat		# VirtualAddress
+	.long	ZO__esbat - ZO__sbat		# SizeOfRawData
+	.long	setup_size + ZO__sbat		# PointerToRawData
+
+	.long	0, 0, 0
+	.long	IMAGE_SCN_CNT_INITIALIZED_DATA	| \
+		IMAGE_SCN_MEM_READ		| \
+		IMAGE_SCN_MEM_DISCARDABLE	# Characteristics
+
+	.set	text_fsize, ZO__sbat
+#else
+	.set	text_fsize, ZO__data
+#endif
+
 	.ascii	".data\0\0\0"
 	.long	ZO__end - ZO__data		# VirtualSize
 	.long	setup_size + ZO__data		# VirtualAddress
-- 
2.48.1


