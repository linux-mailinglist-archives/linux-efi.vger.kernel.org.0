Return-Path: <linux-efi+bounces-4114-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3330AF89BB
	for <lists+linux-efi@lfdr.de>; Fri,  4 Jul 2025 09:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E00381C87F6E
	for <lists+linux-efi@lfdr.de>; Fri,  4 Jul 2025 07:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0DD284B3E;
	Fri,  4 Jul 2025 07:40:37 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B6427A101;
	Fri,  4 Jul 2025 07:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751614836; cv=none; b=K0hht0MdYR8AB1SLo+BlLOxeLpx+0N1kotPX/3/BSW6QVLelm0F1sYZuJHeQey51zYJUTF0bgwf+mF9z+Do6aOvabhrcU6zbiqM9SUo0EYJTJRfTkPACYjXjpP/oQxgDntdX5VeMgtV38BxgkyIGftvYPnuNBOyMPJNa2tZ0JRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751614836; c=relaxed/simple;
	bh=DmKkm+5VZ+nxcvM9V0qn1OfuccxIXOhlkvGYD9U59sw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DUMyYa2a9hyZk9OqH0bbWpxXd3WGzwKCiv108nIEjpG5uAoSHAOx3I38i5EEe6N6XGVmMxB9Ky6GokaVrNpbk8tnyQo9Lrcz8dPX7DDoEo3dWDm/xTWz0v5N/pSUMKJW7DoP4rMjQuGAAIz1AXucAk/FaicRNORovHD0046uj5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4bYQVS6KSxz2SSrM;
	Fri,  4 Jul 2025 15:38:40 +0800 (CST)
Received: from kwepemg100016.china.huawei.com (unknown [7.202.181.57])
	by mail.maildlp.com (Postfix) with ESMTPS id A11E71402CB;
	Fri,  4 Jul 2025 15:40:29 +0800 (CST)
Received: from huawei.com (10.67.174.33) by kwepemg100016.china.huawei.com
 (7.202.181.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 4 Jul
 2025 15:40:28 +0800
From: GONG Ruiqi <gongruiqi1@huawei.com>
To: Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu
	<roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Jarkko Sakkinen <jarkko@kernel.org>, Ard Biesheuvel <ardb@kernel.org>
CC: Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore
	<paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge E . Hallyn"
	<serge@hallyn.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, "H . Peter Anvin"
	<hpa@zytor.com>, <linux-kernel@vger.kernel.org>,
	<linux-integrity@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
	<linux-efi@vger.kernel.org>, <keyrings@vger.kernel.org>, Lu Jialin
	<lujialin4@huawei.com>, <gongruiqi1@huawei.com>
Subject: [PATCH v4 1/2] x86/efi: Rename IMA-related function and macro of boot mode
Date: Fri, 4 Jul 2025 15:51:13 +0800
Message-ID: <20250704075114.3709609-2-gongruiqi1@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250704075114.3709609-1-gongruiqi1@huawei.com>
References: <20250704075114.3709609-1-gongruiqi1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemg100016.china.huawei.com (7.202.181.57)

Rename {__x86,arch}_ima_efi_boot_mode to .._integrity_efi_boot_mode, as
a preparing step for the next patch to decouple the functionality of
arch_ima_get_secureboot() from IMA.

No functional change intended.

Signed-off-by: GONG Ruiqi <gongruiqi1@huawei.com>
---
 arch/x86/include/asm/efi.h       | 4 ++--
 arch/x86/platform/efi/efi.c      | 2 +-
 security/integrity/ima/ima_efi.c | 6 +++---
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index f227a70ac91f..fcac86a1327b 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -401,9 +401,9 @@ extern int __init efi_memmap_split_count(efi_memory_desc_t *md,
 extern void __init efi_memmap_insert(struct efi_memory_map *old_memmap,
 				     void *buf, struct efi_mem_range *mem);
 
-extern enum efi_secureboot_mode __x86_ima_efi_boot_mode(void);
+extern enum efi_secureboot_mode __x86_integrity_efi_boot_mode(void);
 
-#define arch_ima_efi_boot_mode	__x86_ima_efi_boot_mode()
+#define arch_integrity_efi_boot_mode	__x86_integrity_efi_boot_mode()
 
 #ifdef CONFIG_EFI_RUNTIME_MAP
 int efi_get_runtime_map_size(void);
diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index 463b784499a8..94704858f17a 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -921,7 +921,7 @@ umode_t efi_attr_is_visible(struct kobject *kobj, struct attribute *attr, int n)
 	return attr->mode;
 }
 
-enum efi_secureboot_mode __x86_ima_efi_boot_mode(void)
+enum efi_secureboot_mode __x86_integrity_efi_boot_mode(void)
 {
 	return boot_params.secure_boot;
 }
diff --git a/security/integrity/ima/ima_efi.c b/security/integrity/ima/ima_efi.c
index 138029bfcce1..9f9c30dcde17 100644
--- a/security/integrity/ima/ima_efi.c
+++ b/security/integrity/ima/ima_efi.c
@@ -7,8 +7,8 @@
 #include <linux/ima.h>
 #include <asm/efi.h>
 
-#ifndef arch_ima_efi_boot_mode
-#define arch_ima_efi_boot_mode efi_secureboot_mode_unset
+#ifndef arch_integrity_efi_boot_mode
+#define arch_integrity_efi_boot_mode efi_secureboot_mode_unset
 #endif
 
 static enum efi_secureboot_mode get_sb_mode(void)
@@ -36,7 +36,7 @@ bool arch_ima_get_secureboot(void)
 	static bool initialized;
 
 	if (!initialized && efi_enabled(EFI_BOOT)) {
-		sb_mode = arch_ima_efi_boot_mode;
+		sb_mode = arch_integrity_efi_boot_mode;
 
 		if (sb_mode == efi_secureboot_mode_unset)
 			sb_mode = get_sb_mode();
-- 
2.25.1


