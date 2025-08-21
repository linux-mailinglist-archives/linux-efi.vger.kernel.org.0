Return-Path: <linux-efi+bounces-4587-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B5C8B3019E
	for <lists+linux-efi@lfdr.de>; Thu, 21 Aug 2025 20:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B6C2188EA3A
	for <lists+linux-efi@lfdr.de>; Thu, 21 Aug 2025 18:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E749B338F2C;
	Thu, 21 Aug 2025 18:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="NDwkktZC"
X-Original-To: linux-efi@vger.kernel.org
Received: from pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.35.192.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5529F1EB5C2;
	Thu, 21 Aug 2025 18:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.35.192.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755799259; cv=none; b=f/6LEZwSHNljanfm32l7vgAengvJyOaE/RA2EZ64hDUR0wkLn9o8sha9ZVe8EJf9R0tLy66bhmy/68g0wtS55QhuXvZmMq18jIrx67kZjTOdPbpk6/kb3kXEDM4am4+J89KoXPzLV3h7fWoL+badOO0ivOw98uzSdTqRS6c9xdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755799259; c=relaxed/simple;
	bh=FM6xF0Fuv/RbLNQHDBlDiErQ8/FNScrfjYnZZ6srz40=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RydMnuc0EUX8Kqq9kbQadVDIbYF8HpRbzvT4HHsUUovZExMwH6NH1qSGsmU0788lg69aVYlMewrcZP2v15rWWFBES83y2r1YultxnWq8j+TW5DIi0PXGevWj0znOT/bSwn53IUGhuwfp5K030bH8BVmzpFQvLpVHHu2FUvExDRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=NDwkktZC; arc=none smtp.client-ip=52.35.192.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1755799258; x=1787335258;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kWqXjjUHM7c8KFNVFeI4qCz3BhL3hy0rWcMQ9gV1+Ag=;
  b=NDwkktZCviwBeNN/MOYYM48EJj8MPx/YEUw3cH/fwyaivY2Qv9skoNcY
   9MM5yKBCyHBz9MZt+FTSIPbrhoRQG+N1KkvOc1gZ9XVwbuYm8n7m95UDo
   WiRlKRn0pRy6zwMWWVzjUxZSekQz1iuZ7JQiiBcKMfGoh8pOJ6Q/h3MWF
   H+n0C31o0AGk1jIjAvJ7HxhxC0cjgUyoU4Ivz/kz67nF/iVQgNbQamr+R
   EsOaztVUOFqiGFthjX/urtRZdQ9jn1QTVU08AsGzNmsSgeteq2m5AbInI
   d7bGJ4/wI1cRj9Q3jAQapcQ02izGHEcohxURfzEagUqhAekCFH3Ir0nFy
   A==;
X-CSE-ConnectionGUID: HLKZcqGhSiCPiLwCU2nt1w==
X-CSE-MsgGUID: /M1cOzOZQPSmCqzALH8bdQ==
X-IronPort-AV: E=Sophos;i="6.17,309,1747699200"; 
   d="scan'208";a="1453129"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 17:59:48 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:64601]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.29.152:2525] with esmtp (Farcaster)
 id df03885c-7dc0-4034-8426-e40e01b7df25; Thu, 21 Aug 2025 17:59:48 +0000 (UTC)
X-Farcaster-Flow-ID: df03885c-7dc0-4034-8426-e40e01b7df25
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.17;
 Thu, 21 Aug 2025 17:59:48 +0000
Received: from dev-dsk-epetron-1c-1d4d9719.eu-west-1.amazon.com
 (10.253.109.105) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.17; Thu, 21 Aug 2025
 17:59:46 +0000
From: Evangelos Petrongonas <epetron@amazon.de>
To: Ard Biesheuvel <ardb@kernel.org>, Mike Rapoport <rppt@kernel.org>
CC: Evangelos Petrongonas <epetron@amazon.de>, Alexander Graf
	<graf@amazon.com>, Changyuan Lyu <changyuanl@google.com>, Andrew Morton
	<akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>,
	<kexec@lists.infradead.org>, <linux-mm@kvack.org>,
	<linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nh-open-source@amazon.com>
Subject: [PATCH v3 1/2] kexec: introduce is_kho_boot()
Date: Thu, 21 Aug 2025 17:58:59 +0000
Message-ID: <7dc6674a76bf6e68cca0222ccff32427699cc02e.1755721529.git.epetron@amazon.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1755721529.git.epetron@amazon.de>
References: <cover.1755721529.git.epetron@amazon.de>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D043UWC004.ant.amazon.com (10.13.139.206) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

During early initialisation, after a kexec, other components, like EFI
need to know if a KHO enabled kexec is performed. The `kho_is_enabled`
function is not enough as in the early stages, it only reflects
whether the cmdline has KHO enabled, not if an actual KHO FDT exists.

Extend the KHO API with `is_kho_boot()` to provide a way for components
to check if a KHO enabled kexec is performed.

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Evangelos Petrongonas <epetron@amazon.de>
---
Changes in v3:
	- Condition Only on the existense of the KHO FDT and ignore the
	cmdline `kho` parameter

 include/linux/kexec_handover.h |  6 ++++++
 kernel/kexec_handover.c        | 20 ++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/include/linux/kexec_handover.h b/include/linux/kexec_handover.h
index 348844cffb13..559d13a3bc44 100644
--- a/include/linux/kexec_handover.h
+++ b/include/linux/kexec_handover.h
@@ -40,6 +40,7 @@ struct kho_serialization;
 
 #ifdef CONFIG_KEXEC_HANDOVER
 bool kho_is_enabled(void);
+bool is_kho_boot(void);
 
 int kho_preserve_folio(struct folio *folio);
 int kho_preserve_phys(phys_addr_t phys, size_t size);
@@ -60,6 +61,11 @@ static inline bool kho_is_enabled(void)
 	return false;
 }
 
+static inline bool is_kho_boot(void)
+{
+	return false;
+}
+
 static inline int kho_preserve_folio(struct folio *folio)
 {
 	return -EOPNOTSUPP;
diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index 69b953551677..52e80e0c2238 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -925,6 +925,26 @@ static const void *kho_get_fdt(void)
 	return kho_in.fdt_phys ? phys_to_virt(kho_in.fdt_phys) : NULL;
 }
 
+/**
+ * is_kho_boot - check if current kernel was booted via KHO-enabled
+ * kexec
+ *
+ * This function checks if the current kernel was loaded through a kexec
+ * operation with KHO enabled, by verifying that a valid KHO FDT
+ * was passed.
+ *
+ * Note: This function returns reliable results only after
+ * kho_populate() has been called during early boot. Before that,
+ * it may return false even if KHO data is present.
+ *
+ * Return: true if booted via KHO-enabled kexec, false otherwise
+ */
+bool is_kho_boot(void)
+{
+	return !!kho_get_fdt();
+}
+EXPORT_SYMBOL_GPL(is_kho_boot);
+
 /**
  * kho_retrieve_subtree - retrieve a preserved sub FDT by its name.
  * @name: the name of the sub FDT passed to kho_add_subtree().
-- 
2.47.3




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


