Return-Path: <linux-efi+bounces-4449-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C01B0D34A
	for <lists+linux-efi@lfdr.de>; Tue, 22 Jul 2025 09:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F05E93B4492
	for <lists+linux-efi@lfdr.de>; Tue, 22 Jul 2025 07:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A3A2DC356;
	Tue, 22 Jul 2025 07:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xDQ4irDe"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533242DECA3
	for <linux-efi@vger.kernel.org>; Tue, 22 Jul 2025 07:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753169407; cv=none; b=gwSVAliDRvZqCFh0oBcfy0uPtpcSdwaCQ41VYZPkf7uey8OdkWbp6I/K5kfJtmGX+Z0YJIzDSJ3gzSKwsVIs3ntHbtuFjBn+RiCtn/3rnCEUIv6kcSLyI3g92t/flLjydSsnTi89qaugGDfx7zAAbKfG9n5ie+9vG8pn+rBVzaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753169407; c=relaxed/simple;
	bh=AziSCYrqEKp3iXhsTCzhbJczPEzyYFFzm0EbdakEq+k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jlUu09rN9ZH6R1fc4PWGWNiYeIITG5peHUC/1DvYe2jcyL9BM+J0iHjByySkp+v3oL795KFocEAh0azvn6jWu7+Yf3F+Gh58EDCS1RuILhcM5qkAZglhsgprvntFfCDUHHmpNyq7NbpI5anaPAptnKmARuu+IMxETNWQDySsMsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xDQ4irDe; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3b604541741so3876767f8f.3
        for <linux-efi@vger.kernel.org>; Tue, 22 Jul 2025 00:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753169404; x=1753774204; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mW4f9PE0jE0e9wTTI8oFMDAAeEX2PGjVbeFJW21fiSw=;
        b=xDQ4irDe6gaGiGIN1JIk73aO1qf4wT7LOnQUJm1cYtW0wqSe7akPvGjM16onzDcS9T
         3owml4wx2yIJzREx6KcDQ22wHcgKuF6cMJLx3P/F8bmGMFFbaBNz9zmGCNszwcb6nh0H
         fCC4dIghKtT9BgoXBCOw8ZGrYn9/miJsD+jVWVDUnLF1en3lv0WiTHsKELGJYGrFmY8u
         LzFFK/t8fd/gUPq9uHze5VRMXpkF76bK6grhiCx6pnWqlZCmydx2NzDQ6WUjyWDlWkgV
         SWvm8xhStLaF1sFG3KHJ+TP6awkY+ERidMB2MmOeYqc+dE7k/YZe3cdveX2l7Eck8QUH
         4UrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753169404; x=1753774204;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mW4f9PE0jE0e9wTTI8oFMDAAeEX2PGjVbeFJW21fiSw=;
        b=sQbJhEOeuxdN6pMkJUwgnVEp7myRz0D8XNyq5rt3dUvT0DYpS3mGGRhwZ+oQnH0trB
         Q2QVdiYLHzk2WpvS6dKvwVcXXszpes8xXUtojzfsZTGZkCtYQHWv53n+3MMEDdnNqjgo
         U09PL+Asony40C+rNz5KsW3AZNp/KrITs44OjvJ25KPiOSDfMlYxeBwNfI06ZhlgAADF
         0OFrB4GqcpXsLHbbiF3mcU5ucTsuB6vzi7KjVC/cROiOpbwTEDKi1kov8rLkWGcTp05N
         0vJCrwUmZXZwFsTc7vKtQAU2HisbStrkOu9O6f29H5Ny9nk7b1NvbJGcXU/rhFgkLQjr
         nybA==
X-Gm-Message-State: AOJu0Yw4W43LcOwPpfFijajbKcY5T1o/q5mX2L321oVutQaVe3STVgAh
	27fHAP7Etx22Cp4Lbqbgse7XIW2M/e4vssaof6f9Se7OGZ215Ml2fGmkT8ptXOPAZyCVWUvvgw=
	=
X-Google-Smtp-Source: AGHT+IEqIkZaOA4ogOixIf+RDEwpmHqpgza/utnNCA+SqSYOa7J9XOgt60L+JaEZqIQWwlBBUCl7IbnY
X-Received: from wmbeq12.prod.google.com ([2002:a05:600c:848c:b0:456:2437:14d6])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:adf:e19d:0:b0:3a6:f2d7:e22b
 with SMTP id ffacd0b85a97d-3b60e4d2a3bmr14390472f8f.18.1753169403918; Tue, 22
 Jul 2025 00:30:03 -0700 (PDT)
Date: Tue, 22 Jul 2025 09:27:23 +0200
In-Reply-To: <20250722072708.2079165-24-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250722072708.2079165-24-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1696; i=ardb@kernel.org;
 h=from:subject; bh=kOQMYaSiu+ZXQWR7MbRw268I2y+/O3YrdyRKP8LesAE=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIaPedpKM88n9Sbzbf+1YeWOdnNHSbVutr83/+Jjr9Feb8
 59Mpy5m7ChlYRDjYpAVU2QRmP333c7TE6VqnWfJwsxhZQIZwsDFKQATabrH8E+VpXzK6RRBrWyV
 R6k5uQELpfobyuznpr93imm7u+rhQVVGhvVucifUTC8oiDx+eULzbbNri2CBK/ODmzEpSgxZvFf r2AA=
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250722072708.2079165-38-ardb+git@google.com>
Subject: [PATCH v6 14/22] x86/sev: Export startup routines for later use
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Kevin Loughlin <kevinloughlin@google.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Nikunj A Dadhania <nikunj@amd.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Create aliases that expose routines that are part of the startup code to
other code in the core kernel, so that they can be called later as well.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/startup/exports.h | 14 ++++++++++++++
 arch/x86/kernel/vmlinux.lds.S   |  2 ++
 2 files changed, 16 insertions(+)

diff --git a/arch/x86/boot/startup/exports.h b/arch/x86/boot/startup/exports.h
new file mode 100644
index 000000000000..01d2363dc445
--- /dev/null
+++ b/arch/x86/boot/startup/exports.h
@@ -0,0 +1,14 @@
+
+/*
+ * The symbols below are functions that are implemented by the startup code,
+ * but called at runtime by the SEV code residing in the core kernel.
+ */
+PROVIDE(early_set_pages_state		= __pi_early_set_pages_state);
+PROVIDE(early_snp_set_memory_private	= __pi_early_snp_set_memory_private);
+PROVIDE(early_snp_set_memory_shared	= __pi_early_snp_set_memory_shared);
+PROVIDE(get_hv_features			= __pi_get_hv_features);
+PROVIDE(sev_es_terminate		= __pi_sev_es_terminate);
+PROVIDE(snp_cpuid			= __pi_snp_cpuid);
+PROVIDE(snp_cpuid_get_table		= __pi_snp_cpuid_get_table);
+PROVIDE(svsm_issue_call			= __pi_svsm_issue_call);
+PROVIDE(svsm_process_result_codes	= __pi_svsm_process_result_codes);
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 4fa0be732af1..5d5e3a95e1f9 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -535,3 +535,5 @@ xen_elfnote_entry_value =
 xen_elfnote_phys32_entry_value =
 	ABSOLUTE(xen_elfnote_phys32_entry) + ABSOLUTE(pvh_start_xen - LOAD_OFFSET);
 #endif
+
+#include "../boot/startup/exports.h"
-- 
2.50.0.727.gbf7dc18ff4-goog


