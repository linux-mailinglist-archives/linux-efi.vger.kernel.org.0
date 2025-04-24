Return-Path: <linux-efi+bounces-3449-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0FB8A9A565
	for <lists+linux-efi@lfdr.de>; Thu, 24 Apr 2025 10:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48B5F18803A0
	for <lists+linux-efi@lfdr.de>; Thu, 24 Apr 2025 08:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36CF1FDE0E;
	Thu, 24 Apr 2025 08:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hCXrPm+0"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D99207DFF
	for <linux-efi@vger.kernel.org>; Thu, 24 Apr 2025 08:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745482235; cv=none; b=Hq5ixPy5if3L0JXwTvDwg0bG4GyXHDn3LYPE4On6h5UglZDC2mXhZJNIrTMWJjIcSynmqz0KiZT+VCqZdZ41wz7Xa7xLqjhfILMbKc3NaBJe8mlJc8bwFOpaVI18k+Iujo9K8YzXdw4mTFhnmdERIZKrzDdB2PzbQOw+ObTdTr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745482235; c=relaxed/simple;
	bh=wfzfwtAAfE/gqDeQKesSIqyP3cK0GG7CaFYvtfFF1Vo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FaRbIhYWqHU1FvViUHZl2yeLAox1jABtjZqQz2EjsV+jVqDwjEg+gDU5jTTp3R7A4urt6vSmNjQauGk1RZ5wEi+4yV4M5+GBjKQTS3fzZuAO4mvwom4/5s62csnKIA7jW03Bs81E2iLC44CKmTs228owarrx3cJbJeHa3E6EAIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hCXrPm+0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745482232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A+1ZgWYZjkFNKtbyOd5XBijVRyjAhhTtk+/ckQxhbdc=;
	b=hCXrPm+0LxA8X6TYHPYAd+ZD/PDjQtPPbp/0PtBiQUV9hxaIBYBjdCSgTIv5AwRid4Lma5
	rvqifSgsXpYsIdwfi7ZvVARqndcpwjCcYISSg/uhmb1lTmIpytC+JUhJ7Mn+0WE8r0NpJO
	POYH5aAyLjXn71hXfKFgGO6qvFXH7yE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-491-Nz0TM1INMt6rHFY_g5srJw-1; Thu,
 24 Apr 2025 04:10:29 -0400
X-MC-Unique: Nz0TM1INMt6rHFY_g5srJw-1
X-Mimecast-MFC-AGG-ID: Nz0TM1INMt6rHFY_g5srJw_1745482227
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2BF20180034E;
	Thu, 24 Apr 2025 08:10:25 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.198])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B0E9230001AB;
	Thu, 24 Apr 2025 08:10:11 +0000 (UTC)
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
Subject: [PATCH 1/2] efi/libstub: zboot specific mechanism for embedding SBAT section
Date: Thu, 24 Apr 2025 12:09:49 +0400
Message-ID: <20250424080950.289864-2-vkuznets@redhat.com>
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

SBAT is a mechanism which improves SecureBoot revocations of UEFI binaries
by introducing a generation-based technique. Compromised or vulnerable UEFI
binaries can be prevented from booting by bumping the minimal required
generation for the specific component in the bootloader. More information
on the SBAT can be obtained here:

https://github.com/rhboot/shim/blob/main/SBAT.md

Upstream Linux kernel does not currently participate in any way in SBAT as
there's no existing policy in how SBAT generation number should be
defined. Keep the status quo and provide a mechanism for distro vendors and
anyone else who signs their kernel for SecureBoot to include their own SBAT
data. This leaves the decision on the policy to the vendor. Basically, each
distro implementing SecureBoot today, will have an option to inject their
own SBAT data during kernel build and before it gets signed by their
SecureBoot CA. Different distro do not need to agree on the common SBAT
component names or generation numbers as each distro ships its own 'shim'
with their own 'vendor_cert'/'vendor_db'

Implement support for embedding SBAT data for architectures using
zboot (arm64, loongarch, riscv). Build '.sbat' section along with libstub
so it can be reused by x86 implementation later.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 drivers/firmware/efi/Kconfig                | 25 +++++++++++++++++++++
 drivers/firmware/efi/libstub/Makefile       |  7 ++++++
 drivers/firmware/efi/libstub/Makefile.zboot |  3 ++-
 drivers/firmware/efi/libstub/sbat.S         |  7 ++++++
 drivers/firmware/efi/libstub/zboot-header.S | 14 ++++++++++++
 drivers/firmware/efi/libstub/zboot.lds      | 17 ++++++++++++++
 6 files changed, 72 insertions(+), 1 deletion(-)
 create mode 100644 drivers/firmware/efi/libstub/sbat.S

diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index 5fe61b9ab5f9..2edb0167ba49 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -281,6 +281,31 @@ config EFI_EMBEDDED_FIRMWARE
 	bool
 	select CRYPTO_LIB_SHA256
 
+config EFI_SBAT
+	bool "Embed SBAT section in the kernel"
+	depends on EFI_ZBOOT
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
 endmenu
 
 config UEFI_CPER
diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index d23a1b9fed75..5113cbdadf9a 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -105,6 +105,13 @@ lib-$(CONFIG_UNACCEPTED_MEMORY) += unaccepted_memory.o bitmap.o find.o
 extra-y				:= $(lib-y)
 lib-y				:= $(patsubst %.o,%.stub.o,$(lib-y))
 
+extra-$(CONFIG_EFI_SBAT)	+= sbat.o
+$(obj)/sbat.o: $(obj)/sbat.bin
+targets += sbat.bin
+filechk_sbat.bin = cat $(or $(real-prereqs), /dev/null)
+$(obj)/sbat.bin: $(CONFIG_EFI_SBAT_FILE) FORCE
+	$(call filechk,sbat.bin)
+
 # Even when -mbranch-protection=none is set, Clang will generate a
 # .note.gnu.property for code-less object files (like lib/ctype.c),
 # so work around this by explicitly removing the unwanted section.
diff --git a/drivers/firmware/efi/libstub/Makefile.zboot b/drivers/firmware/efi/libstub/Makefile.zboot
index 48842b5c106b..3d2d0b326f7c 100644
--- a/drivers/firmware/efi/libstub/Makefile.zboot
+++ b/drivers/firmware/efi/libstub/Makefile.zboot
@@ -44,7 +44,8 @@ AFLAGS_zboot-header.o += -DMACHINE_TYPE=IMAGE_FILE_MACHINE_$(EFI_ZBOOT_MACH_TYPE
 $(obj)/zboot-header.o: $(srctree)/drivers/firmware/efi/libstub/zboot-header.S FORCE
 	$(call if_changed_rule,as_o_S)
 
-ZBOOT_DEPS := $(obj)/zboot-header.o $(objtree)/drivers/firmware/efi/libstub/lib.a
+ZBOOT_DEPS := $(obj)/zboot-header.o $(objtree)/drivers/firmware/efi/libstub/lib.a \
+	   $(if $(CONFIG_EFI_SBAT),$(objtree)/drivers/firmware/efi/libstub/sbat.o)
 
 LDFLAGS_vmlinuz.efi.elf := -T $(srctree)/drivers/firmware/efi/libstub/zboot.lds
 $(obj)/vmlinuz.efi.elf: $(obj)/vmlinuz.o $(ZBOOT_DEPS) FORCE
diff --git a/drivers/firmware/efi/libstub/sbat.S b/drivers/firmware/efi/libstub/sbat.S
new file mode 100644
index 000000000000..4e99a1bac794
--- /dev/null
+++ b/drivers/firmware/efi/libstub/sbat.S
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Embed SBAT data in the kernel.
+ */
+	.pushsection ".sbat","a",@progbits
+	.incbin "drivers/firmware/efi/libstub/sbat.bin"
+	.popsection
diff --git a/drivers/firmware/efi/libstub/zboot-header.S b/drivers/firmware/efi/libstub/zboot-header.S
index fb676ded47fa..f2df24504fc5 100644
--- a/drivers/firmware/efi/libstub/zboot-header.S
+++ b/drivers/firmware/efi/libstub/zboot-header.S
@@ -135,6 +135,20 @@ __efistub_efi_zboot_header:
 			IMAGE_SCN_MEM_READ | \
 			IMAGE_SCN_MEM_WRITE
 
+#ifdef CONFIG_EFI_SBAT
+	.ascii		".sbat\0\0\0"
+	.long		__sbat_size
+	.long		_edata - .Ldoshdr
+	.long		__sbat_size
+	.long		_edata - .Ldoshdr
+
+	.long		0, 0
+	.short		0, 0
+	.long		IMAGE_SCN_CNT_INITIALIZED_DATA | \
+			IMAGE_SCN_MEM_READ | \
+			IMAGE_SCN_MEM_DISCARDABLE
+#endif
+
 	.set		.Lsection_count, (. - .Lsection_table) / 40
 
 #ifdef PE_DLL_CHAR_EX
diff --git a/drivers/firmware/efi/libstub/zboot.lds b/drivers/firmware/efi/libstub/zboot.lds
index 9ecc57ff5b45..2cd5015c70ce 100644
--- a/drivers/firmware/efi/libstub/zboot.lds
+++ b/drivers/firmware/efi/libstub/zboot.lds
@@ -31,10 +31,24 @@ SECTIONS
 
 	.data : ALIGN(4096) {
 		*(.data* .init.data*)
+#ifndef CONFIG_EFI_SBAT
 		_edata = ALIGN(512);
+#else
+		/* Avoid gap between '.data' and '.sbat' */
+		_edata = ALIGN(4096);
+#endif
 		. = _edata;
 	}
 
+#ifdef CONFIG_EFI_SBAT
+        .sbat : ALIGN(4096) {
+		_sbat = . ;
+		*(.sbat)
+		_esbat = ALIGN(512);
+		. = _esbat;
+	}
+#endif
+
 	.bss : {
 		*(.bss* .init.bss*)
 		_end = ALIGN(512);
@@ -52,3 +66,6 @@ PROVIDE(__efistub__gzdata_size =
 
 PROVIDE(__data_rawsize = ABSOLUTE(_edata - _etext));
 PROVIDE(__data_size = ABSOLUTE(_end - _etext));
+#ifdef CONFIG_EFI_SBAT
+PROVIDE(__sbat_size = ABSOLUTE(_esbat - _sbat));
+#endif
-- 
2.49.0


