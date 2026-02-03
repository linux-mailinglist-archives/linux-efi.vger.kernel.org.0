Return-Path: <linux-efi+bounces-6080-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cK9mNUN2gWkYGgMAu9opvQ
	(envelope-from <linux-efi+bounces-6080-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Tue, 03 Feb 2026 05:14:59 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DEA5D4589
	for <lists+linux-efi@lfdr.de>; Tue, 03 Feb 2026 05:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 756563010509
	for <lists+linux-efi@lfdr.de>; Tue,  3 Feb 2026 04:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 203AA31DDBB;
	Tue,  3 Feb 2026 04:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J5/cMmEJ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="e+Fbu4dk"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DC7310779
	for <linux-efi@vger.kernel.org>; Tue,  3 Feb 2026 04:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770092096; cv=none; b=hYUjjj46S4l7UZVBbuRFXPPLm3p5ohtJfIbfG1W//u50kalQsNYCxoY0+VgSAXDZtWWlH2aucGx19V2DNlgUxJ6P2lW7g6km4OOdQlRCxIM57jhurZMGTaeAeGzq35j0HJVBeNY7mMr5iPQCwj3kNoX68zd4LL6HacVP0QyEJ3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770092096; c=relaxed/simple;
	bh=3359cTJuKMQW2Ye5QVpeU9AY7kRuJYqhMLKsSsmWFB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M2hxX7ESJy+GXu8jMND3KbJzjA+rM1e6EsWr8lBSHXxWtJ+uX1OQo1D7itQq4j25G5xsDYtw0JTdT80xQixsEhLZVAGi9BwQoCm56a9Xo/fxl0aC9LF79/n3HzaWZ35zpuSZaKAeVkzO37r8H0j1Hiu95+MK/jvRvbffP4XfQms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J5/cMmEJ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=e+Fbu4dk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770092093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p93KwK3MrQdQe76nVS26U2WG0dvz53eKlShlmT9aWyc=;
	b=J5/cMmEJKD8nLJQ8akQdggdpnhcO4glwP/oFZfdxhUcI4VpBc0rDwZPo+MkNPi9HQjtiFE
	58abc8jU0ahGIX2TUlNOkgFZGso8hQGQeUbMJmjELxIL//LwzAnOi45rlfAhwWOPs9JOJs
	t8NGZ264v+mId4kIdrhN2MR6e1gUDU0=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-312-uF2G07sNMPCeU2mnmUq1PA-1; Mon, 02 Feb 2026 23:14:52 -0500
X-MC-Unique: uF2G07sNMPCeU2mnmUq1PA-1
X-Mimecast-MFC-AGG-ID: uF2G07sNMPCeU2mnmUq1PA_1770092091
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-34abd303b4aso14020941a91.1
        for <linux-efi@vger.kernel.org>; Mon, 02 Feb 2026 20:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770092089; x=1770696889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p93KwK3MrQdQe76nVS26U2WG0dvz53eKlShlmT9aWyc=;
        b=e+Fbu4dk0219+lP1GnLxG8/Q/Kzn8lhzyejqyBiFCxu8k3DkSsEI5go/g4HIbFy3VP
         dAu4ZTD7mJ0l1fDfKwaWmtACC/pU3LmiPxTm5iZOOUBeWNy55Pl8ydiS9GvOiUupTXA/
         DaPVkXzIqvrX6+J+uFb+4Nwb2hGHW77cICOtzDLSwyfFjGDH3ISLMbtQ64kUmNHXQhvO
         nHv6Dbo96nTkEN95v9nfoe95KBrWpdMes9xSYqTkrKsb67jO47sEScNUvDxNjKpZLn1O
         tBjhsfN8TcowwDWtx+MuyEHR+7ewGBSPsunGLkrWLNvLlqrTtq+kFIl9GOA+1MKe912A
         sl1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770092089; x=1770696889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p93KwK3MrQdQe76nVS26U2WG0dvz53eKlShlmT9aWyc=;
        b=BoSBdJl+kuGWwdN+4FD/Zm1cR2aTHomaqYS54Dg3Uwna0Rr9aLdY4JC0zBkDQ4e8hB
         2uqnEme4qKiBzP17CuPRMh8H8FYm01ji1c9jDxHs1YIoxQ+YcGBi8fRDpRM3rS2x/q5p
         gdHt3hFPjJjEESAVn9Nv4226opi2vI6osUgoZUij1XpoB90DVYk6qJspEer5ubjaBS+Y
         5Q6mKGMStocHt9zdZGn/LvvH0Eky7m+JDvE1iKKLs9AeDWH8zSreZxKRAz4NKUSMW3bp
         xG8LGLJVeeGzD4rdGPkafkhzIZaNbu/pPvxeWdAqmQCDckMBiocz0wK/Ves4/ht6851S
         tavA==
X-Forwarded-Encrypted: i=1; AJvYcCVBP90v+sluV3mwh2/JytvmAxB9REDxDGtedLfXVRcRohIl5nvQtmbUfKIR66R1nvQK/8mdxmIuGQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfbt2JxOCopRM8hLnPCxf88m1qfJvhcRCkq1JwEKvR/bvVldVS
	/fnYEB9Z1GCSlcs4GonByc/kuX/BW7CcbidIhJSUqhq+NZLIPtGHWwfqBNMpL8GIY+sNV1b2fed
	ttaU1rYahJ5OvQEicw97SGkTXFHThibIDgaslLFb29DF0umnrrhO1T+tyPwEddA==
X-Gm-Gg: AZuq6aL/QWc4QzGhnunMfc6J2dxeBoYFQcLnYGT/ohtVFw0K+J79tdf+urz2OZzktKF
	FvWzb81KKSRSzIE+PQdr+/aIaeef4mGJXv2GR25VYvgKc9qiGnVGwjG71dcZDcOHSxd/83bPLhU
	Nwkk2GgCESzRaUOOzZFizC4SHwxgd1c3Q87ARI7PXyuemaNPio0cLs/cO/30Md+0UrfjXEDKxXc
	AI4RcHRSysarZmB3jy9OfNzfBR9qO1Ds0nrUTYKws+XBWuQeT6/HeJzGt2qVyloUpjPDQxSSie9
	2DL4Q1jq0gTAUduK5ewkoQNWUD7ilzzAblZeKxpjk+GVzMK/eAHcH7XKePhF8cgmmEhWjo8VoqM
	9
X-Received: by 2002:a17:90b:4a43:b0:32b:c9c0:2a11 with SMTP id 98e67ed59e1d1-3543b2e00bemr13198170a91.4.1770092088885;
        Mon, 02 Feb 2026 20:14:48 -0800 (PST)
X-Received: by 2002:a17:90b:4a43:b0:32b:c9c0:2a11 with SMTP id 98e67ed59e1d1-3543b2e00bemr13198114a91.4.1770092088283;
        Mon, 02 Feb 2026 20:14:48 -0800 (PST)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3547afceeb1sm478001a91.4.2026.02.02.20.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 20:14:47 -0800 (PST)
From: Coiby Xu <coxu@redhat.com>
To: linux-integrity@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>,
	Alexander Egorenkov <egorenar@linux.ibm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Dave Hansen <dave.hansen@intel.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	"H. Peter Anvin" <hpa@zytor.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linuxppc-dev@lists.ozlabs.org (open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)),
	linux-s390@vger.kernel.org (open list:S390 ARCHITECTURE),
	linux-efi@vger.kernel.org (open list:EXTENSIBLE FIRMWARE INTERFACE (EFI)),
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM),
	keyrings@vger.kernel.org (open list:KEYS/KEYRINGS_INTEGRITY)
Subject: [PATCH v2 1/3] integrity: Make arch_ima_get_secureboot integrity-wide
Date: Tue,  3 Feb 2026 12:14:29 +0800
Message-ID: <20260203041434.872784-2-coxu@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260203041434.872784-1-coxu@redhat.com>
References: <20260203041434.872784-1-coxu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux.ibm.com,kernel.org,intel.com,huawei.com,ellerman.id.au,gmail.com,redhat.com,alien8.de,linux.intel.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-6080-lists,linux-efi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[coxu@redhat.com,linux-efi@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-efi];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 7DEA5D4589
X-Rspamd-Action: no action

EVM and other LSMs need the ability to query the secure boot status of
the system, without directly calling the IMA arch_ima_get_secureboot
function. Refactor the secure boot status check into a general function
named arch_get_secureboot.

Reported-and-suggested-by: Mimi Zohar <zohar@linux.ibm.com>
Suggested-by: Roberto Sassu <roberto.sassu@huawei.com>
Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 MAINTAINERS                                   |  1 +
 arch/powerpc/kernel/ima_arch.c                |  5 --
 arch/powerpc/kernel/secure_boot.c             |  6 ++
 arch/s390/kernel/ima_arch.c                   |  6 --
 arch/s390/kernel/ipl.c                        |  5 ++
 arch/x86/include/asm/efi.h                    |  4 +-
 arch/x86/platform/efi/efi.c                   |  2 +-
 include/linux/ima.h                           |  7 +--
 include/linux/secure_boot.h                   | 19 +++++++
 security/integrity/Makefile                   |  3 +-
 security/integrity/efi_secureboot.c           | 56 +++++++++++++++++++
 security/integrity/ima/ima_appraise.c         |  2 +-
 security/integrity/ima/ima_efi.c              | 48 +---------------
 security/integrity/ima/ima_main.c             |  4 +-
 security/integrity/integrity.h                |  1 +
 security/integrity/platform_certs/load_uefi.c |  2 +-
 security/integrity/secure_boot.c              | 16 ++++++
 17 files changed, 117 insertions(+), 70 deletions(-)
 create mode 100644 include/linux/secure_boot.h
 create mode 100644 security/integrity/efi_secureboot.c
 create mode 100644 security/integrity/secure_boot.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 67db88b04537..1f963a621a99 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12519,6 +12519,7 @@ R:	Eric Snowberg <eric.snowberg@oracle.com>
 L:	linux-integrity@vger.kernel.org
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git
+F:	include/linux/secure_boot.h
 F:	security/integrity/
 F:	security/integrity/ima/
 
diff --git a/arch/powerpc/kernel/ima_arch.c b/arch/powerpc/kernel/ima_arch.c
index b7029beed847..0d8892a03526 100644
--- a/arch/powerpc/kernel/ima_arch.c
+++ b/arch/powerpc/kernel/ima_arch.c
@@ -7,11 +7,6 @@
 #include <linux/ima.h>
 #include <asm/secure_boot.h>
 
-bool arch_ima_get_secureboot(void)
-{
-	return is_ppc_secureboot_enabled();
-}
-
 /*
  * The "secure_rules" are enabled only on "secureboot" enabled systems.
  * These rules verify the file signatures against known good values.
diff --git a/arch/powerpc/kernel/secure_boot.c b/arch/powerpc/kernel/secure_boot.c
index 3a28795b4ed8..28436c1599e0 100644
--- a/arch/powerpc/kernel/secure_boot.c
+++ b/arch/powerpc/kernel/secure_boot.c
@@ -5,6 +5,7 @@
  */
 #include <linux/types.h>
 #include <linux/of.h>
+#include <linux/secure_boot.h>
 #include <linux/string_choices.h>
 #include <asm/secure_boot.h>
 
@@ -44,6 +45,11 @@ bool is_ppc_secureboot_enabled(void)
 	return enabled;
 }
 
+bool arch_get_secureboot(void)
+{
+	return is_ppc_secureboot_enabled();
+}
+
 bool is_ppc_trustedboot_enabled(void)
 {
 	struct device_node *node;
diff --git a/arch/s390/kernel/ima_arch.c b/arch/s390/kernel/ima_arch.c
index f3c3e6e1c5d3..6ccbe34ce408 100644
--- a/arch/s390/kernel/ima_arch.c
+++ b/arch/s390/kernel/ima_arch.c
@@ -1,12 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include <linux/ima.h>
-#include <asm/boot_data.h>
-
-bool arch_ima_get_secureboot(void)
-{
-	return ipl_secure_flag;
-}
 
 const char * const *arch_get_ima_policy(void)
 {
diff --git a/arch/s390/kernel/ipl.c b/arch/s390/kernel/ipl.c
index dcdc7e274848..781deb588557 100644
--- a/arch/s390/kernel/ipl.c
+++ b/arch/s390/kernel/ipl.c
@@ -2504,6 +2504,11 @@ void *ipl_report_finish(struct ipl_report *report)
 	return buf;
 }
 
+bool arch_get_secureboot(void)
+{
+	return ipl_secure_flag;
+}
+
 int ipl_report_free(struct ipl_report *report)
 {
 	struct ipl_report_component *comp, *ncomp;
diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index f227a70ac91f..ee382b56dd7b 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -401,9 +401,9 @@ extern int __init efi_memmap_split_count(efi_memory_desc_t *md,
 extern void __init efi_memmap_insert(struct efi_memory_map *old_memmap,
 				     void *buf, struct efi_mem_range *mem);
 
-extern enum efi_secureboot_mode __x86_ima_efi_boot_mode(void);
+enum efi_secureboot_mode __x86_efi_boot_mode(void);
 
-#define arch_ima_efi_boot_mode	__x86_ima_efi_boot_mode()
+#define arch_efi_boot_mode __x86_efi_boot_mode()
 
 #ifdef CONFIG_EFI_RUNTIME_MAP
 int efi_get_runtime_map_size(void);
diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index 463b784499a8..d8b25ae7af1e 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -921,7 +921,7 @@ umode_t efi_attr_is_visible(struct kobject *kobj, struct attribute *attr, int n)
 	return attr->mode;
 }
 
-enum efi_secureboot_mode __x86_ima_efi_boot_mode(void)
+enum efi_secureboot_mode __x86_efi_boot_mode(void)
 {
 	return boot_params.secure_boot;
 }
diff --git a/include/linux/ima.h b/include/linux/ima.h
index 8e29cb4e6a01..b3927b795a60 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -11,6 +11,7 @@
 #include <linux/fs.h>
 #include <linux/security.h>
 #include <linux/kexec.h>
+#include <linux/secure_boot.h>
 #include <crypto/hash_info.h>
 struct linux_binprm;
 
@@ -72,14 +73,8 @@ int __init ima_get_kexec_buffer(void **addr, size_t *size);
 #endif
 
 #ifdef CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT
-extern bool arch_ima_get_secureboot(void);
 extern const char * const *arch_get_ima_policy(void);
 #else
-static inline bool arch_ima_get_secureboot(void)
-{
-	return false;
-}
-
 static inline const char * const *arch_get_ima_policy(void)
 {
 	return NULL;
diff --git a/include/linux/secure_boot.h b/include/linux/secure_boot.h
new file mode 100644
index 000000000000..3ded3f03655c
--- /dev/null
+++ b/include/linux/secure_boot.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2026 Red Hat, Inc. All Rights Reserved.
+ *
+ * Author: Coiby Xu <coxu@redhat.com>
+ */
+
+#ifndef _LINUX_SECURE_BOOT_H
+#define _LINUX_SECURE_BOOT_H
+
+#include <linux/types.h>
+
+/*
+ * Returns true if the platform secure boot is enabled.
+ * Returns false if disabled or not supported.
+ */
+bool arch_get_secureboot(void);
+
+#endif /* _LINUX_SECURE_BOOT_H */
diff --git a/security/integrity/Makefile b/security/integrity/Makefile
index 92b63039c654..548665e2b702 100644
--- a/security/integrity/Makefile
+++ b/security/integrity/Makefile
@@ -5,7 +5,7 @@
 
 obj-$(CONFIG_INTEGRITY) += integrity.o
 
-integrity-y := iint.o
+integrity-y := iint.o secure_boot.o
 integrity-$(CONFIG_INTEGRITY_AUDIT) += integrity_audit.o
 integrity-$(CONFIG_INTEGRITY_SIGNATURE) += digsig.o
 integrity-$(CONFIG_INTEGRITY_ASYMMETRIC_KEYS) += digsig_asymmetric.o
@@ -18,6 +18,7 @@ integrity-$(CONFIG_LOAD_IPL_KEYS) += platform_certs/load_ipl_s390.o
 integrity-$(CONFIG_LOAD_PPC_KEYS) += platform_certs/efi_parser.o \
                                      platform_certs/load_powerpc.o \
                                      platform_certs/keyring_handler.o
+integrity-$(CONFIG_EFI) += efi_secureboot.o
 # The relative order of the 'ima' and 'evm' LSMs depends on the order below.
 obj-$(CONFIG_IMA)			+= ima/
 obj-$(CONFIG_EVM)			+= evm/
diff --git a/security/integrity/efi_secureboot.c b/security/integrity/efi_secureboot.c
new file mode 100644
index 000000000000..bfd4260a83a3
--- /dev/null
+++ b/security/integrity/efi_secureboot.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-1.0+
+/*
+ * Copyright (C) 2018 IBM Corporation
+ */
+#include <linux/efi.h>
+#include <linux/secure_boot.h>
+#include <asm/efi.h>
+
+#ifndef arch_efi_boot_mode
+#define arch_efi_boot_mode efi_secureboot_mode_unset
+#endif
+
+static enum efi_secureboot_mode get_sb_mode(void)
+{
+	enum efi_secureboot_mode mode;
+
+	if (!efi_rt_services_supported(EFI_RT_SUPPORTED_GET_VARIABLE)) {
+		pr_info("integrity: secureboot mode unknown, no efi\n");
+		return efi_secureboot_mode_unknown;
+	}
+
+	mode = efi_get_secureboot_mode(efi.get_variable);
+	if (mode == efi_secureboot_mode_disabled)
+		pr_info("integrity: secureboot mode disabled\n");
+	else if (mode == efi_secureboot_mode_unknown)
+		pr_info("integrity: secureboot mode unknown\n");
+	else
+		pr_info("integrity: secureboot mode enabled\n");
+	return mode;
+}
+
+/*
+ * Query secure boot status
+ *
+ * Note don't call this function too early e.g. in __setup hook otherwise the
+ * kernel may hang when calling efi_get_secureboot_mode.
+ *
+ */
+bool arch_get_secureboot(void)
+{
+	static enum efi_secureboot_mode sb_mode;
+	static bool initialized;
+
+	if (!initialized && efi_enabled(EFI_BOOT)) {
+		sb_mode = arch_efi_boot_mode;
+
+		if (sb_mode == efi_secureboot_mode_unset)
+			sb_mode = get_sb_mode();
+		initialized = true;
+	}
+
+	if (sb_mode == efi_secureboot_mode_enabled)
+		return true;
+	else
+		return false;
+}
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 5149ff4fd50d..9737bf76ce17 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -27,7 +27,7 @@ core_param(ima_appraise, ima_appraise_cmdline_default, charp, 0);
 void __init ima_appraise_parse_cmdline(void)
 {
 	const char *str = ima_appraise_cmdline_default;
-	bool sb_state = arch_ima_get_secureboot();
+	bool sb_state = arch_get_secureboot();
 	int appraisal_state = ima_appraise;
 
 	if (!str)
diff --git a/security/integrity/ima/ima_efi.c b/security/integrity/ima/ima_efi.c
index 138029bfcce1..27521d665d33 100644
--- a/security/integrity/ima/ima_efi.c
+++ b/security/integrity/ima/ima_efi.c
@@ -2,52 +2,9 @@
 /*
  * Copyright (C) 2018 IBM Corporation
  */
-#include <linux/efi.h>
 #include <linux/module.h>
 #include <linux/ima.h>
-#include <asm/efi.h>
-
-#ifndef arch_ima_efi_boot_mode
-#define arch_ima_efi_boot_mode efi_secureboot_mode_unset
-#endif
-
-static enum efi_secureboot_mode get_sb_mode(void)
-{
-	enum efi_secureboot_mode mode;
-
-	if (!efi_rt_services_supported(EFI_RT_SUPPORTED_GET_VARIABLE)) {
-		pr_info("ima: secureboot mode unknown, no efi\n");
-		return efi_secureboot_mode_unknown;
-	}
-
-	mode = efi_get_secureboot_mode(efi.get_variable);
-	if (mode == efi_secureboot_mode_disabled)
-		pr_info("ima: secureboot mode disabled\n");
-	else if (mode == efi_secureboot_mode_unknown)
-		pr_info("ima: secureboot mode unknown\n");
-	else
-		pr_info("ima: secureboot mode enabled\n");
-	return mode;
-}
-
-bool arch_ima_get_secureboot(void)
-{
-	static enum efi_secureboot_mode sb_mode;
-	static bool initialized;
-
-	if (!initialized && efi_enabled(EFI_BOOT)) {
-		sb_mode = arch_ima_efi_boot_mode;
-
-		if (sb_mode == efi_secureboot_mode_unset)
-			sb_mode = get_sb_mode();
-		initialized = true;
-	}
-
-	if (sb_mode == efi_secureboot_mode_enabled)
-		return true;
-	else
-		return false;
-}
+#include <linux/secure_boot.h>
 
 /* secureboot arch rules */
 static const char * const sb_arch_rules[] = {
@@ -67,7 +24,8 @@ static const char * const sb_arch_rules[] = {
 
 const char * const *arch_get_ima_policy(void)
 {
-	if (IS_ENABLED(CONFIG_IMA_ARCH_POLICY) && arch_ima_get_secureboot()) {
+	if (IS_ENABLED(CONFIG_IMA_ARCH_POLICY) &&
+	    arch_get_secureboot()) {
 		if (IS_ENABLED(CONFIG_MODULE_SIG))
 			set_module_sig_enforced();
 		if (IS_ENABLED(CONFIG_KEXEC_SIG))
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 5770cf691912..6d093ac82a45 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -949,8 +949,8 @@ static int ima_load_data(enum kernel_load_data_id id, bool contents)
 
 	switch (id) {
 	case LOADING_KEXEC_IMAGE:
-		if (IS_ENABLED(CONFIG_KEXEC_SIG)
-		    && arch_ima_get_secureboot()) {
+		if (IS_ENABLED(CONFIG_KEXEC_SIG) &&
+		    arch_get_secureboot()) {
 			pr_err("impossible to appraise a kernel image without a file descriptor; try using kexec_file_load syscall.\n");
 			return -EACCES;
 		}
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index 7b388b66cf80..4636629533af 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -14,6 +14,7 @@
 
 #include <linux/types.h>
 #include <linux/integrity.h>
+#include <linux/secure_boot.h>
 #include <crypto/sha1.h>
 #include <crypto/hash.h>
 #include <linux/key.h>
diff --git a/security/integrity/platform_certs/load_uefi.c b/security/integrity/platform_certs/load_uefi.c
index d1fdd113450a..c0d6948446c3 100644
--- a/security/integrity/platform_certs/load_uefi.c
+++ b/security/integrity/platform_certs/load_uefi.c
@@ -212,7 +212,7 @@ static int __init load_uefi_certs(void)
 	}
 
 	/* the MOK/MOKx can not be trusted when secure boot is disabled */
-	if (!arch_ima_get_secureboot())
+	if (!arch_get_secureboot())
 		return 0;
 
 	mokx = get_cert_list(L"MokListXRT", &mok_var, &mokxsize, &status);
diff --git a/security/integrity/secure_boot.c b/security/integrity/secure_boot.c
new file mode 100644
index 000000000000..fc2693c286f8
--- /dev/null
+++ b/security/integrity/secure_boot.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2026 Red Hat, Inc. All Rights Reserved.
+ *
+ * Author: Coiby Xu <coxu@redhat.com>
+ */
+#include <linux/secure_boot.h>
+
+/*
+ * Default weak implementation.
+ * Architectures that support secure boot must override this.
+ */
+__weak bool arch_get_secureboot(void)
+{
+	return false;
+}
-- 
2.52.0


