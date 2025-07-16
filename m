Return-Path: <linux-efi+bounces-4358-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E52BCB06C1E
	for <lists+linux-efi@lfdr.de>; Wed, 16 Jul 2025 05:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C8CB1AA2157
	for <lists+linux-efi@lfdr.de>; Wed, 16 Jul 2025 03:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF00E27EFEF;
	Wed, 16 Jul 2025 03:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3jkSRlII"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FEB279DC8
	for <linux-efi@vger.kernel.org>; Wed, 16 Jul 2025 03:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752636154; cv=none; b=QJi4MwIIK4yp5Vleh51pbPDBsARP3K7/c6xRe022l04dQ/wABfMksgZBwE9IFMbE+I0eWmGNycoPXmTpeSpv8vs29t89w49QAhCv3A/1pZ5LdKEWZKFhQQUHzhjp+NtBJpiLeeWu+2IKH/GsCdLux87ti7JlvAW+/5vKizXAzOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752636154; c=relaxed/simple;
	bh=dwWCVYWLxvz5MeaLqdk6rU+JPa17U0A/FyYg+rIEEKA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=u7ISfaG1QymNcD6W7VJ5tdqhAs0yVhdtrfaWbBo95uPMZNLWHwh9SApGZBriLFm/bJoCLVEuYOerDXiaWTeD0RnyVeFGItxhW6v4EuKh2UgppQNkFDEfnEiTtYbZyIWTugXkz0R/P3dQTcy/EUFCfC/YoWVS1Ljzh4K4tEf9q9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3jkSRlII; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4560b81ff9eso23314495e9.1
        for <linux-efi@vger.kernel.org>; Tue, 15 Jul 2025 20:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752636151; x=1753240951; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/jHar7LpfB+CDDd+fbj3NyAJt7qq3hvz0nbJoCsOjz0=;
        b=3jkSRlIIIEjeccQ7+2f8VkIpyVTLuFr7Wof1AoczY8rPZUiDn06w8qyPpXnO8Levkp
         izybGnGL+n47HpQl05Px8ZSf3vcqzLuvaNM2SXCGLaIl6ochR3kMVLMBqcxOwuGstDq9
         mC0202lvEcTqYVtBYKuHy6q1bpjgBdvZMYTgpjVNe74tjauj53uRuLQp+pen2XszYEiQ
         2tBGboxWCYF35aYajxNuLVwouDkurTJkIB7AON7PCnxUJTvhQPUnPbxIv2zy1s2M1jT2
         xMs07XXZ6rB+DVBnLrvyce5Ul0b1LKN0/1b9Om/i3zELiDsws2P5MXCOyh28u5Ecq3RL
         kfqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752636151; x=1753240951;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/jHar7LpfB+CDDd+fbj3NyAJt7qq3hvz0nbJoCsOjz0=;
        b=sDmW6njlyIbfDcCUdXH/b/Eq//ON472iNC8igxSCj7McWRp08hqj4/FwN2iq3tBnty
         f2K2fj+rGOZzvsJ9zca+gCQCifxnuywmK1Ex1ZBWHT7kKZ7enAL/uHkKwRzbT8jDHKLw
         J/DZAFWTCXa2EE1LZy2eyGmvleRyYAXkLK2TytTs4dGlHYWoky7DrVhx1Ox3ovST0aQe
         b22F2gECNEAsWYVoFt3Jz71nQpG/ZpCMQagAP35836cs1x1/+zFu5bPYpRtIMywHSf2W
         0x2BBWLxnX46+kHpk5GQw2F5shKWluTkeNOtigBjshKktXhrY3MwFsi2qQhVEKo36F3n
         4/YQ==
X-Gm-Message-State: AOJu0Yxtkaf1v/Ipwfr2zhq3SPPRxPlP68e+V2yGrQMdgzgHa8Ajge4j
	9f+h4NU0sZNK2Rc+e34J50tmZsotoVl3YLSgKKFa86HKNQwxVmb/MJ567yjTF9ll21E5taMaMA=
	=
X-Google-Smtp-Source: AGHT+IFEuJ4DENIJrP3qoayaohC8oM7ZFjNQPr9UUJ7+oEl5naP+4gZNWHLaAp+vi1pyt3SJfKEIVuCG
X-Received: from wroy15.prod.google.com ([2002:adf:f14f:0:b0:3b2:14c1:2180])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:4412:b0:3a4:dd8e:e16b
 with SMTP id ffacd0b85a97d-3b60dd5520cmr677901f8f.20.1752636151576; Tue, 15
 Jul 2025 20:22:31 -0700 (PDT)
Date: Wed, 16 Jul 2025 05:18:19 +0200
In-Reply-To: <20250716031814.2096113-24-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250716031814.2096113-24-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2885; i=ardb@kernel.org;
 h=from:subject; bh=Ooeu1U7xEvLSy0dm4Twfp3IBY3u7/SJY928wtFYKXhs=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIaNcSmg9T0VvQUvpihn79b/dE/D8erhkl12zu9idkn0n2
 qcFOTl3lLIwiHExyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgImcb2Bk2CPVwHhwod1reaFH
 vWyxl09x+cyv/bcp/Nm3K2VPzzHdO8fwv8jQ/ldvSuv2iSedGUqUF0yKVhbl57suHOE7YYrxMQ8 ZBgA=
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250716031814.2096113-28-ardb+git@google.com>
Subject: [PATCH v5 04/22] x86/sev: Run RMPADJUST on SVSM calling area page to
 test VMPL
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Kevin Loughlin <kevinloughlin@google.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Nikunj A Dadhania <nikunj@amd.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Determining the VMPL at which the kernel runs involves performing a
RMPADJUST operation on an arbitrary page of memory, and observing whether
it succeeds.

The use of boot_ghcb_page in the core kernel in this case is completely
arbitrary, but results in the need to provide a PIC alias for it. So use
boot_svsm_ca_page instead, which already needs this alias for other
reasons.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/boot/compressed/sev.c      | 2 +-
 arch/x86/boot/startup/sev-shared.c  | 5 +++--
 arch/x86/boot/startup/sev-startup.c | 2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index b71c1ab6a282..3628e9bddc6a 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -327,7 +327,7 @@ static bool early_snp_init(struct boot_params *bp)
 	 * running at VMPL0. The CA will be used to communicate with the
 	 * SVSM and request its services.
 	 */
-	svsm_setup_ca(cc_info);
+	svsm_setup_ca(cc_info, rip_rel_ptr(&boot_ghcb_page));
 
 	/*
 	 * Pass run-time kernel a pointer to CC info via boot_params so EFI
diff --git a/arch/x86/boot/startup/sev-shared.c b/arch/x86/boot/startup/sev-shared.c
index d9c0c64d80fe..cbf26466e0da 100644
--- a/arch/x86/boot/startup/sev-shared.c
+++ b/arch/x86/boot/startup/sev-shared.c
@@ -792,7 +792,8 @@ static void __head pvalidate_4k_page(unsigned long vaddr, unsigned long paddr,
  * Maintain the GPA of the SVSM Calling Area (CA) in order to utilize the SVSM
  * services needed when not running in VMPL0.
  */
-static bool __head svsm_setup_ca(const struct cc_blob_sev_info *cc_info)
+static bool __head svsm_setup_ca(const struct cc_blob_sev_info *cc_info,
+				 void *page)
 {
 	struct snp_secrets_page *secrets_page;
 	struct snp_cpuid_table *cpuid_table;
@@ -815,7 +816,7 @@ static bool __head svsm_setup_ca(const struct cc_blob_sev_info *cc_info)
 	 * routine is running identity mapped when called, both by the decompressor
 	 * code and the early kernel code.
 	 */
-	if (!rmpadjust((unsigned long)rip_rel_ptr(&boot_ghcb_page), RMP_PG_SIZE_4K, 1))
+	if (!rmpadjust((unsigned long)page, RMP_PG_SIZE_4K, 1))
 		return false;
 
 	/*
diff --git a/arch/x86/boot/startup/sev-startup.c b/arch/x86/boot/startup/sev-startup.c
index c30e0eed0131..4b9e8ccc0e91 100644
--- a/arch/x86/boot/startup/sev-startup.c
+++ b/arch/x86/boot/startup/sev-startup.c
@@ -302,7 +302,7 @@ static __head void svsm_setup(struct cc_blob_sev_info *cc_info)
 	 * running at VMPL0. The CA will be used to communicate with the
 	 * SVSM to perform the SVSM services.
 	 */
-	if (!svsm_setup_ca(cc_info))
+	if (!svsm_setup_ca(cc_info, rip_rel_ptr(&boot_svsm_ca_page)))
 		return;
 
 	/*
-- 
2.50.0.727.gbf7dc18ff4-goog


