Return-Path: <linux-efi+bounces-3227-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBDDEA7F8BE
	for <lists+linux-efi@lfdr.de>; Tue,  8 Apr 2025 10:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DB0B188E2A6
	for <lists+linux-efi@lfdr.de>; Tue,  8 Apr 2025 08:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124F7266EF4;
	Tue,  8 Apr 2025 08:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ou2OvDhq"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138AA266B76
	for <linux-efi@vger.kernel.org>; Tue,  8 Apr 2025 08:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744102413; cv=none; b=skQkm7tobZHZpGo+znzlNkjc4p8+qN1GHCbLVW39omrrcbZEehnloVqwrtiWc80CZbBkDTd8dQLtshiQ/G203WlA7GRSXYOc85Vl1ZArMI4ChUOqWTkrnsRgvya52OfeKVQasTQJsL4zmDf3cPwAK2FfUHeqeZxp9iYCLJX2/LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744102413; c=relaxed/simple;
	bh=nMTMqzq37ZDdZSy/ASJb7GM4lqZTMOHxEOCfZ5XR4c8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AQSrSIIaH7Ooi0cYCF1JAhh8ueIsE/qeph256OHgAw/Wr4MYi+SkjDjxcQbu5Vmi11OuNUf8OxGvqAEHU1Kkv5Rl15R4boDMOp4SpL5YhTZXZ3JU2aCukF/PANahpisZJFPrRdIgtAho3m0v8YzuIwA2EVNWUNAOysN9M9owTPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ou2OvDhq; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43cf327e9a2so44743015e9.3
        for <linux-efi@vger.kernel.org>; Tue, 08 Apr 2025 01:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744102409; x=1744707209; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Bu1M3/PvdkhGWlHIRkQzAzcvhk8sTE/2aa4WDt4cxm0=;
        b=Ou2OvDhqh0F1r2X1jAwfX2upSEP+PcLqN/rT1Us36IXDGNF3qxlIwKBAgzk6iZrsQ5
         xVEElmYCNo63KgwSGlPqSsGpDBtMP8cjOUH95MlsQHDDDZkv+zIGRLoVqNdX4UhqZGS/
         j+5xEXk/UaerEG6IXxz54pP1r+DuHs9bxMiB7NDG+GcGdQwE5v7YjRYTV3D3oZgHCEWh
         +AH4CxIGF8T5z3yEf1shxdqalq6MrYs8pYAeCczvV+7jmk39i44XVwXstd5mkdEUQjiS
         SXRvDpN5+NcclY6Ws0yn18fu1+mUxj9VYGOhglCASYRK/doejtdrA/UB6zT3LL8m4uW3
         5gVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744102409; x=1744707209;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bu1M3/PvdkhGWlHIRkQzAzcvhk8sTE/2aa4WDt4cxm0=;
        b=VGHoPmSOUCVR5FUJuIV3yOJic9QROmGn6ahi4e28cfeQCnvRW/bQGYqMR3q+GtT8Ig
         yG46TqckDmczwQdYtykJww5GQNeW+JNe4jjpLgBRsU8MCr8W+IDQWQbfXd7DlXfO/v/W
         M8wX2yFsOTy/LqQ4MU4AkL1c88PjrE5zd+2r9x064ujQ2TGDuA+xo299vT34TvCJ8mgI
         H1Mx/5AGsUrrre74Yno/WWFXNZEcMi1QL4w3tFhn1Daqnqi1SIRz1XWxj3pfzMSEW7TX
         j21VbdkXxTOpU+RTlIcyar2G5a0n1l1VorLJJYTLXTpR29vtAYXq9+RGXGGNkW09NIvs
         4hvQ==
X-Gm-Message-State: AOJu0Yy6fbFZ7UxBinumc+a05Eis+MedOQEBkqtder/Ed2L4uYRz04mk
	HcjDU/pzhZxTHZas7ipu9Ga1ro4sem7H1r7LvLTO6UeUluLUwikNFUfz8qomt6WcxdXBFWNRJhX
	VDwVfG+Vmb6DvEFsDxxb7mDiM0K8Y/G2UdntV427FTsTqb/FobFWnWqXStLJ9FjQp+Ue4PRM4D+
	Swk/y6i/OJsSqeIayF5f+qipLG5Q==
X-Google-Smtp-Source: AGHT+IE/uHSaVtNKee/dmkihc8dBSaKxeFeUFpLQgCV3qUZJUtmlBi/YqSX0r50x/1aUdAmTZhKi+Myg
X-Received: from wmcq3.prod.google.com ([2002:a05:600c:c103:b0:43d:41a2:b768])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:1e89:b0:43c:f184:2e16
 with SMTP id 5b1f17b1804b1-43ee06134f3mr112581425e9.5.1744102409707; Tue, 08
 Apr 2025 01:53:29 -0700 (PDT)
Date: Tue,  8 Apr 2025 10:53:02 +0200
In-Reply-To: <20250408085254.836788-9-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250408085254.836788-9-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2567; i=ardb@kernel.org;
 h=from:subject; bh=HHqxACxmdTzUBkBumD23I1ULhjlW30p2Zg7pYMcwt7Y=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIf3L448arJuLf4nqf91whyWSa+EJ42CPa6UX9+39nhZjm
 eN+8vzMjlIWBjEOBlkxRRaB2X/f7Tw9UarWeZYszBxWJpAhDFycAjCRoksM/71OLbmk/1CnadfT
 by8Y94YeZPL2Ypwfkbj5irzG2pB4Xg+G/wk87GJ1Fzlfrdxhb3yM3cgoi8dvMtMDlxvVC56+Xaa zhgsA
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250408085254.836788-16-ardb+git@google.com>
Subject: [PATCH v3 7/7] x86/boot: Drop RIP_REL_REF() uses from SME startup code
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


