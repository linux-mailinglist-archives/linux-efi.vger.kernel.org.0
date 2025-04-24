Return-Path: <linux-efi+bounces-3450-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2437A9A566
	for <lists+linux-efi@lfdr.de>; Thu, 24 Apr 2025 10:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35D6A4612A0
	for <lists+linux-efi@lfdr.de>; Thu, 24 Apr 2025 08:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6FCD212FAB;
	Thu, 24 Apr 2025 08:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g/tEPKTz"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407982116FA
	for <linux-efi@vger.kernel.org>; Thu, 24 Apr 2025 08:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745482248; cv=none; b=N2VovwM7XPQjfUOZgXCZUlbdTqV26M33bWSTxSdm7neyx0VuGlIDCI7wwAbhhbFb8FOe1TmAEtjfbL3at50GT6mkfUNkioG81h5O4QuWRCgvVFiFezGPs4dGGjhqo17H1G4sqfOSAVy+FHksZwJicNIqgPBqO+F6iDWk5+5wOh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745482248; c=relaxed/simple;
	bh=TH67hndJf5FIDT/iNA8mLp4el/Q9YJ0KwNFDvaHNoy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LcnGKEjb17vV7RgKish7S0YTGbxFjVzEGwBz1jaOmKM3fkjmWuq98zORkQuTsr9fo8YxATNhXAYV4WDPiPILkosGU3sDhirThT+yXarT5Ia8gPBN2UQ83c/R5p/LbFlVtPH0Ra9GzIb0JqeXI7pgkordS706EGEcHkgLny9+0+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g/tEPKTz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745482246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=90i0OCg6Zt5Z8sKdLwCV2r9r1JKdc4QuwHkOEn9E9Jg=;
	b=g/tEPKTzGMolKevEu6X0ViGPCyI+LlFFBsPyW92QR5n2C2b8r94LZxN5lwZkH6QQr1VtRb
	AozsK/URaLCHlEX6KzQAwDtk+SCDYM34c7gebhbuIpmy5qSSnqQu6gXS1CMyaM3kValwbY
	N7j6Gl9Odi/5ubU3Z0TfgKmqkd51tOg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-79-3RHKMFU5PVm64rDqCSspaA-1; Thu,
 24 Apr 2025 04:10:42 -0400
X-MC-Unique: 3RHKMFU5PVm64rDqCSspaA-1
X-Mimecast-MFC-AGG-ID: 3RHKMFU5PVm64rDqCSspaA_1745482240
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5FC2219560BA;
	Thu, 24 Apr 2025 08:10:39 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.198])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B3B5B30001A2;
	Thu, 24 Apr 2025 08:10:25 +0000 (UTC)
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
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] x86/efi: Implement support for embedding SBAT data for x86
Date: Thu, 24 Apr 2025 12:09:50 +0400
Message-ID: <20250424080950.289864-3-vkuznets@redhat.com>
In-Reply-To: <20250424080950.289864-1-vkuznets@redhat.com>
References: <20250424080950.289864-1-vkuznets@redhat.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Similar to zboot architectures, implement support for embedding SBAT data
for x86. Put '.sbat' section to the very end of the binary.

Note, the obsolete CRC-32 checksum (see commit 9c54baab4401 ("x86/boot:
Drop CRC-32 checksum and the build tool that generates it")) is gone and
while it would've been possible to reserve the last 4 bytes in '.sbat'
section too (like it's done today in '.data'), it seems to be a pointless
exercise: SBAT makes zero sense without a signature on the EFI binary so
'.sbat' won't be at the very end of the file anyway. Any tool which uses
the last 4 bytes of the file as a checksum is broken with signed EFI
binaries already.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/boot/Makefile                 |  2 +-
 arch/x86/boot/compressed/Makefile      |  2 ++
 arch/x86/boot/compressed/vmlinux.lds.S | 13 +++++++++++++
 arch/x86/boot/header.S                 | 13 +++++++++++++
 drivers/firmware/efi/Kconfig           |  2 +-
 5 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/arch/x86/boot/Makefile b/arch/x86/boot/Makefile
index 81f55da81967..5f7b52f0e7f5 100644
--- a/arch/x86/boot/Makefile
+++ b/arch/x86/boot/Makefile
@@ -71,7 +71,7 @@ $(obj)/vmlinux.bin: $(obj)/compressed/vmlinux FORCE
 
 SETUP_OBJS = $(addprefix $(obj)/,$(setup-y))
 
-sed-zoffset := -e 's/^\([0-9a-fA-F]*\) [a-zA-Z] \(startup_32\|efi.._stub_entry\|efi\(32\)\?_pe_entry\|input_data\|kernel_info\|_end\|_ehead\|_text\|_e\?data\|z_.*\)$$/\#define ZO_\2 0x\1/p'
+sed-zoffset := -e 's/^\([0-9a-fA-F]*\) [a-zA-Z] \(startup_32\|efi.._stub_entry\|efi\(32\)\?_pe_entry\|input_data\|kernel_info\|_end\|_ehead\|_text\|_e\?data\|_e\?sbat\|z_.*\)$$/\#define ZO_\2 0x\1/p'
 
 quiet_cmd_zoffset = ZOFFSET $@
       cmd_zoffset = $(NM) $< | sed -n $(sed-zoffset) > $@
diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index fdbce022db55..b9b80eccdc02 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -107,6 +107,8 @@ vmlinux-objs-$(CONFIG_UNACCEPTED_MEMORY) += $(obj)/mem.o
 vmlinux-objs-$(CONFIG_EFI) += $(obj)/efi.o
 vmlinux-libs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
 
+vmlinux-objs-$(CONFIG_EFI_SBAT) += $(objtree)/drivers/firmware/efi/libstub/sbat.o
+
 $(obj)/vmlinux: $(vmlinux-objs-y) $(vmlinux-libs-y) FORCE
 	$(call if_changed,ld)
 
diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
index 3b2bc61c9408..d0a27905de90 100644
--- a/arch/x86/boot/compressed/vmlinux.lds.S
+++ b/arch/x86/boot/compressed/vmlinux.lds.S
@@ -49,9 +49,22 @@ SECTIONS
 		*(.data.*)
 
 		/* Add 4 bytes of extra space for the obsolete CRC-32 checksum */
+#ifndef CONFIG_EFI_SBAT
 		. = ALIGN(. + 4, 0x200);
+#else
+		/* Avoid gap between '.data' and '.sbat' */
+		. = ALIGN(. + 4, 0x1000);
+#endif
 		_edata = . ;
 	}
+#ifdef CONFIG_EFI_SBAT
+	.sbat : ALIGN(0x1000) {
+		_sbat = . ;
+		*(.sbat)
+		_esbat = ALIGN(0x200);
+		. = _esbat;
+	}
+#endif
 	. = ALIGN(L1_CACHE_BYTES);
 	.bss : {
 		_bss = . ;
diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
index b5c79f43359b..ab851490ef74 100644
--- a/arch/x86/boot/header.S
+++ b/arch/x86/boot/header.S
@@ -207,6 +207,19 @@ pecompat_fstart:
 		IMAGE_SCN_MEM_READ		| \
 		IMAGE_SCN_MEM_WRITE		# Characteristics
 
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
+#endif
+
 	.set	section_count, (. - section_table) / 40
 #endif /* CONFIG_EFI_STUB */
 
diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index 2edb0167ba49..5022a378fec1 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -283,7 +283,7 @@ config EFI_EMBEDDED_FIRMWARE
 
 config EFI_SBAT
 	bool "Embed SBAT section in the kernel"
-	depends on EFI_ZBOOT
+	depends on EFI_ZBOOT || (EFI_STUB && X86)
 	help
 	  SBAT section provides a way to improve SecureBoot revocations of UEFI
 	  binaries by introducing a generation-based mechanism. With SBAT, older
-- 
2.49.0


