Return-Path: <linux-efi+bounces-3266-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F56A84545
	for <lists+linux-efi@lfdr.de>; Thu, 10 Apr 2025 15:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CE1F8A3B8C
	for <lists+linux-efi@lfdr.de>; Thu, 10 Apr 2025 13:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8AEF28CF6A;
	Thu, 10 Apr 2025 13:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lsNO/Plv"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F131E28CF56
	for <linux-efi@vger.kernel.org>; Thu, 10 Apr 2025 13:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744292515; cv=none; b=u4fkC6hw0qAw+87VGIo2slPLmWTCISaPVzyDxqm9VN2AE46QJdpLuNRyWOEI1UfwGd+FJ7abOO0yEhURd0bPZontayEPujIQlGvhSXcqerO15HZnrp2y+E6/xQmISWiRt/yUFV+2Z9+k9A/aDs+ex+YYKrugFYcuW+ho8pJv2fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744292515; c=relaxed/simple;
	bh=nMTMqzq37ZDdZSy/ASJb7GM4lqZTMOHxEOCfZ5XR4c8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AAlkcqAyK46nazJYRrYpKNHpYptkehnjq2vvpmqfEOcFs075FbDUFwOgxKj24aheNhgKvQ0eIwctVoJ06jBgLj7t4XXhPPkFoLIrlnE9vfExy8onodrYiMWYUk6UxXboDVjie39QjA7Yn8kLj82qceJY7b35aD7YyV4mJ/wcC6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lsNO/Plv; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-39d917b1455so285262f8f.3
        for <linux-efi@vger.kernel.org>; Thu, 10 Apr 2025 06:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744292512; x=1744897312; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Bu1M3/PvdkhGWlHIRkQzAzcvhk8sTE/2aa4WDt4cxm0=;
        b=lsNO/Plv7GrYSyZsgRRIoR0xzAlUQGfCsPUP3cYTd+Mv7PS5GPTSDTYQqJDz3XoZ4K
         IRMUDdRO0JlpwiYnonf7c3jmqfABNexQv41K6GqWcxVw9kiI2IMz3uhOCMh1SlQqGtjM
         n+gpy4nAWXLkxJuY6c6a8LUB/S75wacUQSMZF3bkNXJhemggj9nzYnPeuDefJpiPT38V
         mhYndEv5uBQKy+s2UVBilZ8bUv/ZIp77zaNgg1retkENSM2IhRKGF3QMeVFHRhHv+TeA
         PcMOlo5k6Vrkxum/+PCDC0Eza6O2q4DEt7j41qtW8EL07m8ZZw8vHj3P6PpiYaKdpBO2
         5xWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744292512; x=1744897312;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bu1M3/PvdkhGWlHIRkQzAzcvhk8sTE/2aa4WDt4cxm0=;
        b=ABgZ+7jZqhCwy1ZhfYhvYdShPahWroz8DhHByMumgslcSMLy8N4qhhKXjOsDnY+qQ/
         hD3i9JlOWWqrVkh3Ag78bkIcyNcuJ6SvTsr1gKIEnWnkfIQzfsPY6WWBAqgvJsYdekck
         TQFT606o2L4DINXettTHr2j6vFkSwJVq11B79q3YLsHBD/OH9GLQ/X6lYRQWHK6ZYiKi
         isXiGa5e0DAR9kqHkQ/Zzu4szRSOU4Fd2113U+HgDn5YliUSrFJK5gYbEVm4KhIatZ7Y
         I0KelxV8PqteAdNCEJmT3WN50RpTrUpvBY8DfWwe4WIxFks4gtwRESpWOmFev54qvu8a
         p5Dg==
X-Gm-Message-State: AOJu0YxpVpZ0aXlvDJgsgmDhytI//IzfaowRySnsAindC6xw9jPo7C4E
	L/ksTTxAwhsou/HetIQDlA9QZ2Y/FozKpCt71Kd1VC5DjN5JJ2k7SyT7pT+OsZlnz/SA9NFBuO+
	a+kxGL7NSuCSjj506K9fttwrmKz4LcasJMWTSnV1CgbN2J8rgT+oW6+U+zWgZB4E15X1wUFJGdW
	7HHbVBRk6JW6sJWq62ha+7IxJVSw==
X-Google-Smtp-Source: AGHT+IHjGJ8my3L+/VrQ6z6E/5WTYGRGconWFEeiWV78b8cMZMlPoKQBR0w9iIS6PTwJ1hNbOmGkrZ05
X-Received: from wmbet13.prod.google.com ([2002:a05:600c:818d:b0:43c:f5b8:aad0])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:4404:b0:39c:13fd:ea9c
 with SMTP id ffacd0b85a97d-39d8f4e4741mr1694110f8f.47.1744292512486; Thu, 10
 Apr 2025 06:41:52 -0700 (PDT)
Date: Thu, 10 Apr 2025 15:41:24 +0200
In-Reply-To: <20250410134117.3713574-13-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250410134117.3713574-13-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2567; i=ardb@kernel.org;
 h=from:subject; bh=HHqxACxmdTzUBkBumD23I1ULhjlW30p2Zg7pYMcwt7Y=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIf37qQ4N1s3Fv0T1v264wxLJtfCEcbDHtdKL+/Z+T4uxz
 HE/eX5mRykLgxgHg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZjImWiGv1KL07/qn5N4NVdG
 nkHr9JTMLcfOxu+Kc9m0wHNDmYbfhT0M/+s28xXacfhuDJmutG/pkwcnT9ou+qW/8OAEs9v31u3 5UcQPAA==
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250410134117.3713574-19-ardb+git@google.com>
Subject: [PATCH v4 06/11] x86/boot: Drop RIP_REL_REF() uses from SME startup code
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: x86@kernel.org, mingo@kernel.org, linux-kernel@vger.kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

RIP_REL_REF() has no effect on code residing in arch/x86/boot/startup,
as it is built with -fPIC. So remove any occurrences from the SME
startup code.

Note the SME is the only caller of cc_set_mask() that requires this, so
drop it from there as well.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/startup/sme.c        | 11 +++++------
 arch/x86/include/asm/coco.h        |  2 +-
 arch/x86/include/asm/mem_encrypt.h |  2 +-
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/x86/boot/startup/sme.c b/arch/x86/boot/startup/sme.c
index 23d10cda5b58..5738b31c8e60 100644
--- a/arch/x86/boot/startup/sme.c
+++ b/arch/x86/boot/startup/sme.c
@@ -297,8 +297,7 @@ void __head sme_encrypt_kernel(struct boot_params *bp)
 	 * instrumentation or checking boot_cpu_data in the cc_platform_has()
 	 * function.
 	 */
-	if (!sme_get_me_mask() ||
-	    RIP_REL_REF(sev_status) & MSR_AMD64_SEV_ENABLED)
+	if (!sme_get_me_mask() || sev_status & MSR_AMD64_SEV_ENABLED)
 		return;
 
 	/*
@@ -524,7 +523,7 @@ void __head sme_enable(struct boot_params *bp)
 	me_mask = 1UL << (ebx & 0x3f);
 
 	/* Check the SEV MSR whether SEV or SME is enabled */
-	RIP_REL_REF(sev_status) = msr = __rdmsr(MSR_AMD64_SEV);
+	sev_status = msr = __rdmsr(MSR_AMD64_SEV);
 	feature_mask = (msr & MSR_AMD64_SEV_ENABLED) ? AMD_SEV_BIT : AMD_SME_BIT;
 
 	/*
@@ -560,8 +559,8 @@ void __head sme_enable(struct boot_params *bp)
 			return;
 	}
 
-	RIP_REL_REF(sme_me_mask) = me_mask;
-	RIP_REL_REF(physical_mask) &= ~me_mask;
-	RIP_REL_REF(cc_vendor) = CC_VENDOR_AMD;
+	sme_me_mask	= me_mask;
+	physical_mask	&= ~me_mask;
+	cc_vendor	= CC_VENDOR_AMD;
 	cc_set_mask(me_mask);
 }
diff --git a/arch/x86/include/asm/coco.h b/arch/x86/include/asm/coco.h
index e7225452963f..e1dbf8df1b69 100644
--- a/arch/x86/include/asm/coco.h
+++ b/arch/x86/include/asm/coco.h
@@ -22,7 +22,7 @@ static inline u64 cc_get_mask(void)
 
 static inline void cc_set_mask(u64 mask)
 {
-	RIP_REL_REF(cc_mask) = mask;
+	cc_mask = mask;
 }
 
 u64 cc_mkenc(u64 val);
diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
index 1530ee301dfe..ea6494628cb0 100644
--- a/arch/x86/include/asm/mem_encrypt.h
+++ b/arch/x86/include/asm/mem_encrypt.h
@@ -61,7 +61,7 @@ void __init sev_es_init_vc_handling(void);
 
 static inline u64 sme_get_me_mask(void)
 {
-	return RIP_REL_REF(sme_me_mask);
+	return sme_me_mask;
 }
 
 #define __bss_decrypted __section(".bss..decrypted")
-- 
2.49.0.504.g3bcea36a83-goog


