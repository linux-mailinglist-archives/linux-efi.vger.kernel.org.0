Return-Path: <linux-efi+bounces-2301-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF579E63E2
	for <lists+linux-efi@lfdr.de>; Fri,  6 Dec 2024 03:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A95E283D88
	for <lists+linux-efi@lfdr.de>; Fri,  6 Dec 2024 02:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD5A14A4F9;
	Fri,  6 Dec 2024 02:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EDgAeyTT"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CD813BAC6
	for <linux-efi@vger.kernel.org>; Fri,  6 Dec 2024 02:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733451037; cv=none; b=ctJPv9ACjELiE64HtIGFSYdZNO8AyHDgQJ1uZRzWsb77NRDhbeOcDXS/nPl7r5vwpM8WiImFaNwyCVeQLrD2ZS8GLE6mBfQjDFJMi9wrHdbLfK4e2sEZJvJXPuu4kJVAK4c+VEKqKKVfTL3o1R88ZrGYVYyTaLWwtQ4ZKUZBaVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733451037; c=relaxed/simple;
	bh=J6MixGnkMzE/sJIw4nmNj3TwLW66uyCuY+Ga3QrQlUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VW01SOxylVGZv2h+vQCCTWHM23mgpCYdhLcMI1sLFhC9hCOuN32WsuZAECFTBMgzJ5xUI/BD2RVnX8VHNryoZnv9fEKJHlO+6AUSanD8tRjnewczsiPLdtIm8jMACI9w2SaNHiLcs3fpinOUOniQ+QXKycH/E8CY91mPd7SN11U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EDgAeyTT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733451034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jsPZwEXQZGRCo/m/bK+RdDHTquXhI7KUQp7LVr17TGA=;
	b=EDgAeyTTrp+70VvvYV9UqETIY2B/B0t5wKIvogvY4i6nB+uSPAztM2hQ3ClUVWMidPUreV
	XPtGrsBy0kA9IfGurjuyU7cMLf62x0LZJ+46auFd5X8gRG06S3X3ac7kizbqHV8ASZHThy
	mDghFVGTPcUuHI26i7c3Q0rpAoyGRy8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-49--jHL_aNbNDe2C9SJiENPFg-1; Thu,
 05 Dec 2024 21:10:31 -0500
X-MC-Unique: -jHL_aNbNDe2C9SJiENPFg-1
X-Mimecast-MFC-AGG-ID: -jHL_aNbNDe2C9SJiENPFg
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2987A1955F42;
	Fri,  6 Dec 2024 02:10:30 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.101])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D6B331955F3F;
	Fri,  6 Dec 2024 02:10:24 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: linux-efi@vger.kernel.org
Cc: Pingfan Liu <piliu@redhat.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Will Deacon <will@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>
Subject: [PATCH 1/2] Makefile.zboot: Sign Image before packing into EFI-STUB shell
Date: Fri,  6 Dec 2024 10:09:56 +0800
Message-ID: <20241206021000.8953-2-piliu@redhat.com>
In-Reply-To: <20241206021000.8953-1-piliu@redhat.com>
References: <20241206021000.8953-1-piliu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

At present, the kexec_file_load of either zboot or UKI kernel relies on
the user space to parse and extract the Image, and then pass the Image
through that syscall. During this process, the outmost signature on
zboot or UKI kernel is stripped and discarded.

On the other hand, a secure boot platform enforces the signature
verfiication on the kernel image passed through the kexec_file_load
syscall. To cater to this requirement, this patch applies signature on
the PE format 'Image' before padding.

The key used to sign is the same as module sign key, and the signing
tool is sbsign. And the configure macro KEXEC_SIGN_IMAGE will be
introduced in the next patch. (Hence actually this patch does not take
effect)

Signed-off-by: Pingfan Liu <piliu@redhat.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>
To: linux-efi@vger.kernel.org
---
 drivers/firmware/efi/libstub/Makefile.zboot | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/firmware/efi/libstub/Makefile.zboot b/drivers/firmware/efi/libstub/Makefile.zboot
index 65ffd0b760b2..8852289f80e8 100644
--- a/drivers/firmware/efi/libstub/Makefile.zboot
+++ b/drivers/firmware/efi/libstub/Makefile.zboot
@@ -4,9 +4,22 @@
 # EFI_ZBOOT_PAYLOAD, EFI_ZBOOT_BFD_TARGET, EFI_ZBOOT_MACH_TYPE and
 # EFI_ZBOOT_FORWARD_CFI
 
+ifeq ($(filter pkcs11:%, $(CONFIG_MODULE_SIG_KEY)),)
+sig-key := $(if $(wildcard $(CONFIG_MODULE_SIG_KEY)),,$(srctree)/)$(CONFIG_MODULE_SIG_KEY)
+else
+sig-key := $(CONFIG_MODULE_SIG_KEY)
+endif
+
 quiet_cmd_copy_and_pad = PAD     $@
+ifeq ($(CONFIG_KEXEC_SIGN_IMAGE),y)
+      cmd_copy_and_pad = openssl x509 -in certs/signing_key.x509 -inform DER -outform PEM -out certs/signing_key_cert.pem; \
+			 sbsign  --key "$(sig-key)" --cert certs/signing_key_cert.pem --output $<.signed $<; \
+			 cp $<.signed $@; \
+			 truncate -s $$(hexdump -s16 -n4 -e '"%u"' $<) $@
+else
       cmd_copy_and_pad = cp $< $@; \
 			 truncate -s $$(hexdump -s16 -n4 -e '"%u"' $<) $@
+endif
 
 # Pad the file to the size of the uncompressed image in memory, including BSS
 $(obj)/vmlinux.bin: $(obj)/$(EFI_ZBOOT_PAYLOAD) FORCE
-- 
2.41.0


