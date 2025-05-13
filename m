Return-Path: <linux-efi+bounces-3684-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7889AB5566
	for <lists+linux-efi@lfdr.de>; Tue, 13 May 2025 14:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FA347B2DA9
	for <lists+linux-efi@lfdr.de>; Tue, 13 May 2025 12:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E0B28DB63;
	Tue, 13 May 2025 12:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MWPD8l0Y"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766E328DB4C
	for <linux-efi@vger.kernel.org>; Tue, 13 May 2025 12:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747141115; cv=none; b=uxauyiCTo6NxZc+X5msa2LKzya+kvHOeidYXlFkxYmHu5TQEyz8ooOZ1y1l3UBxvljJVmQNaH8p5FU1EfM+0jrQ/4KQHIxMuLVBwdrneF1QJsbKgexHxwHCvMuSpP974NPJl8GVTuDE2cGYoLwSOn3pd6lZhzayBxfj1EaO7UYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747141115; c=relaxed/simple;
	bh=kt7GnTJL1CaA1mUlHvICLaxMTk9O+YjLGaA7NSQcSDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UuB8/x4SkMMXGs68w5wGOD9EOmh2jeB4z/TGfUVDb4rH7HVTFxnlGsILRkNsZWo27xwbK+tOPHj3c6dShhVe6c3yERhvZ1F6TvH7JHDQgri6C+BvvQRVesRDf1hSc53qt1x/gELXFN9ZtiRFUPreTZOtbFHenMswA4+UMM9VNgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MWPD8l0Y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747141112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=08WBpn+iyyprhjRm2HRUWE66nH/RM96nI6IqFMpyWjI=;
	b=MWPD8l0Y8w6f0T6A6I9S+5gXQqlvtaiG5fL/zMY4VytA94W4ERahEpBlSiCceC0aAlRAKV
	r8tZThyE4CTURKgQ+f59hbRVoq5ex4OOuIXvprRzW27Cc16mLZ54HbCedYHNlkdfV0ox2j
	+K0CbClQ0ekcbPYVWoD7h3xPwPZX6MQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-410-KK1KX4XJPuOQMkEwxIU3aA-1; Tue,
 13 May 2025 08:58:29 -0400
X-MC-Unique: KK1KX4XJPuOQMkEwxIU3aA-1
X-Mimecast-MFC-AGG-ID: KK1KX4XJPuOQMkEwxIU3aA_1747141107
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D3E941955DE9;
	Tue, 13 May 2025 12:58:25 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.16])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D306D30002DE;
	Tue, 13 May 2025 12:58:18 +0000 (UTC)
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
Subject: [PATCH v3 1/2] efi: zboot specific mechanism for embedding SBAT section
Date: Tue, 13 May 2025 14:58:07 +0200
Message-ID: <20250513125808.75510-2-vkuznets@redhat.com>
In-Reply-To: <20250513125808.75510-1-vkuznets@redhat.com>
References: <20250513125808.75510-1-vkuznets@redhat.com>
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
zboot (arm64, loongarch, riscv). Put '.sbat' section in between '.data' and
'.text' as the former also covers '.bss' and thus must be the last one.

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 drivers/firmware/efi/Kconfig                | 24 +++++++++++++++++++++
 drivers/firmware/efi/libstub/Makefile.zboot |  4 ++++
 drivers/firmware/efi/libstub/zboot-header.S | 22 +++++++++++++++++--
 drivers/firmware/efi/libstub/zboot.lds      | 11 ++++++++++
 4 files changed, 59 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index 5fe61b9ab5f9..db8c5c03d3a2 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -281,6 +281,30 @@ config EFI_EMBEDDED_FIRMWARE
 	bool
 	select CRYPTO_LIB_SHA256
 
+config EFI_SBAT
+       def_bool y if EFI_SBAT_FILE!=""
+
+config EFI_SBAT_FILE
+	string "Embedded SBAT section file path"
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
+	  Specify a file with SBAT data which is going to be embedded as '.sbat'
+	  section into the kernel.
+
+	  If unsure, leave blank.
+
 endmenu
 
 config UEFI_CPER
diff --git a/drivers/firmware/efi/libstub/Makefile.zboot b/drivers/firmware/efi/libstub/Makefile.zboot
index 48842b5c106b..92e3c73502ba 100644
--- a/drivers/firmware/efi/libstub/Makefile.zboot
+++ b/drivers/firmware/efi/libstub/Makefile.zboot
@@ -44,6 +44,10 @@ AFLAGS_zboot-header.o += -DMACHINE_TYPE=IMAGE_FILE_MACHINE_$(EFI_ZBOOT_MACH_TYPE
 $(obj)/zboot-header.o: $(srctree)/drivers/firmware/efi/libstub/zboot-header.S FORCE
 	$(call if_changed_rule,as_o_S)
 
+ifneq ($(CONFIG_EFI_SBAT_FILE),)
+$(obj)/zboot-header.o: $(CONFIG_EFI_SBAT_FILE)
+endif
+
 ZBOOT_DEPS := $(obj)/zboot-header.o $(objtree)/drivers/firmware/efi/libstub/lib.a
 
 LDFLAGS_vmlinuz.efi.elf := -T $(srctree)/drivers/firmware/efi/libstub/zboot.lds
diff --git a/drivers/firmware/efi/libstub/zboot-header.S b/drivers/firmware/efi/libstub/zboot-header.S
index fb676ded47fa..e02247458b65 100644
--- a/drivers/firmware/efi/libstub/zboot-header.S
+++ b/drivers/firmware/efi/libstub/zboot-header.S
@@ -123,11 +123,29 @@ __efistub_efi_zboot_header:
 			IMAGE_SCN_MEM_READ | \
 			IMAGE_SCN_MEM_EXECUTE
 
+#ifdef CONFIG_EFI_SBAT
+	.ascii		".sbat\0\0\0"
+	.long		__sbat_size
+	.long		_sbat - .Ldoshdr
+	.long		__sbat_size
+	.long		_sbat - .Ldoshdr
+
+	.long		0, 0
+	.short		0, 0
+	.long		IMAGE_SCN_CNT_INITIALIZED_DATA | \
+			IMAGE_SCN_MEM_READ | \
+			IMAGE_SCN_MEM_DISCARDABLE
+
+	.pushsection ".sbat", "a", @progbits
+	.incbin CONFIG_EFI_SBAT_FILE
+	.popsection
+#endif
+
 	.ascii		".data\0\0\0"
 	.long		__data_size
-	.long		_etext - .Ldoshdr
+	.long		_data - .Ldoshdr
 	.long		__data_rawsize
-	.long		_etext - .Ldoshdr
+	.long		_data - .Ldoshdr
 
 	.long		0, 0
 	.short		0, 0
diff --git a/drivers/firmware/efi/libstub/zboot.lds b/drivers/firmware/efi/libstub/zboot.lds
index 9ecc57ff5b45..c3a166675450 100644
--- a/drivers/firmware/efi/libstub/zboot.lds
+++ b/drivers/firmware/efi/libstub/zboot.lds
@@ -29,7 +29,17 @@ SECTIONS
 		. = _etext;
 	}
 
+#ifdef CONFIG_EFI_SBAT
+        .sbat : ALIGN(4096) {
+		_sbat = .;
+		*(.sbat)
+		_esbat = ALIGN(4096);
+		. = _esbat;
+	}
+#endif
+
 	.data : ALIGN(4096) {
+		_data = .;
 		*(.data* .init.data*)
 		_edata = ALIGN(512);
 		. = _edata;
@@ -52,3 +62,4 @@ PROVIDE(__efistub__gzdata_size =
 
 PROVIDE(__data_rawsize = ABSOLUTE(_edata - _etext));
 PROVIDE(__data_size = ABSOLUTE(_end - _etext));
+PROVIDE(__sbat_size = ABSOLUTE(_esbat - _sbat));
-- 
2.49.0


