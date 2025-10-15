Return-Path: <linux-efi+bounces-5058-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F24CBE0BDF
	for <lists+linux-efi@lfdr.de>; Wed, 15 Oct 2025 23:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E64034F5E31
	for <lists+linux-efi@lfdr.de>; Wed, 15 Oct 2025 21:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A18302150;
	Wed, 15 Oct 2025 21:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oNW7RfHm"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16C52FD7A7
	for <linux-efi@vger.kernel.org>; Wed, 15 Oct 2025 21:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760562070; cv=none; b=s1/02ZyExJibiuCD+GJIKJ+E0uIYCrRxR/xUKiqVl//YWNT4H1brSOwRXOn4QROJ4bu/YhRBdfh+ZAjR7J/g88EvGigg16IedOt/gLZe2SR95Ld9+ZEyNT+0nJpuSyaFYaHkwFv2Wy2348O7Wc4lOfku4nyhkS5+wtJBk1hGBxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760562070; c=relaxed/simple;
	bh=bSLBiu0ysu2fpSjU/5Ic3vJljP+H3GdHCmIfG9IdFAw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rtYi/1a1kl+ze/6/+kN49IRTCHRHfqnsMuXe+5L3NOaDCd40lLCcS6WDCKQ5Z4Hu9uYdTE629DpySncbLkNbuN3KUUetblxK+GEVRZtKEZDhpPynde6vnR7iXMWv0iqw4BPve7jnTTAOJDBkp4W1ZX9CeYqE98FHrH5uajP3BV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oNW7RfHm; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4710d174c31so314705e9.0
        for <linux-efi@vger.kernel.org>; Wed, 15 Oct 2025 14:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760562067; x=1761166867; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=moTm52zNGwrt++YsXPE2KY3jx72epI/Bj7ns6GGNFCU=;
        b=oNW7RfHml7K84ZSq3nmGOcCZWU6o9h0wrhRuN+vZWWdoryoVCrEaXTi6eo4zchcA47
         zBEHevUmzuxU693aY7fl3rJPSmb0QUDR5S3mS8OuqLFAEp68VNzWeU9Njio2bdSQFKBt
         GeSqid2XNLako0eAJPnhIXV09vIedLqYQp7271/qBJ6bgdFQYiDcsyusPcNhhzBy+qP4
         HSrjp8L6Y2gM87aBuz4y/MtXsAmUOL2j3dK11U6A3K+6o3+kpjH9q0dqy3PjR+rOX5wG
         CCLN6AAYQ/h/HBTKOefkDcgbaiVzuXffEUs+3mbpWAOCc0b0iH6bjyx0+68E7kHHS1T/
         XSlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760562067; x=1761166867;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=moTm52zNGwrt++YsXPE2KY3jx72epI/Bj7ns6GGNFCU=;
        b=W01OCrb4GvhYgJ5jrmLFM+I5uHjFfnV4Fnr8SliJOsg/nzhnNMvEE9Row3h+o39/jZ
         pEHjpx7/M4azvvgvVZJJAh2ezYShxs3v8FiYtrq+CbgT2kGj6RU/cjClql/GYYYTa5on
         BbPqyvnWbu7lvModfTQVXlIzol4kNy6bPs87TQDjBDArfODwyILlE2fOrX7QBKfB0vhA
         4QXt3jdY6skdLrT9nlbhcMU4C9U1a1C+X3plpm/6UMHOik+U13nuBANIhe+ffk/py9oR
         XpkOIpf4/sZi9YmO8N9ldWUB2kbt58j0e5Xl3o8MGSRYCsprwqLRufaAOcf8zbXA0TkH
         Dusw==
X-Gm-Message-State: AOJu0YxoYt/6/BsM7X5CsUA7CnbebtGxjTCW444fsDhbQ73LB0zl2d1+
	PmBXNHPxR5E31T5vHR5Fb9OkJnN439tnxqiU4ZHquX0BmSh3Z/QkeYiZrmYR8WjKduph1/NcOH9
	sSOqGdWbiCf9JTxh737AKeIiop+Q16Xjrqt88ZKDsHY7o9d/nT2aTDILwLP+u+D3RQNpDQ8vUPQ
	0NGwnF2EswzOiVfUESQ8/Mv90yMx/zkA==
X-Google-Smtp-Source: AGHT+IHH59sy7BRWjY21dGoKX4xtSPPUT5SSUEKeDj8aOzwiGGO++q5eu2jsvFIaGupUZgFYbR/j27IV
X-Received: from wmbz7.prod.google.com ([2002:a05:600c:c087:b0:45d:d60a:8d7e])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:4745:b0:46d:cfc9:1d0f
 with SMTP id 5b1f17b1804b1-46fa9af30e5mr238090085e9.19.1760562066912; Wed, 15
 Oct 2025 14:01:06 -0700 (PDT)
Date: Wed, 15 Oct 2025 22:56:40 +0200
In-Reply-To: <20251015205634.3820870-9-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251015205634.3820870-9-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1252; i=ardb@kernel.org;
 h=from:subject; bh=oVK+oBrwb79YVKXaSmfzPNI2/YhF6t6CcaRgcjvBZKg=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIeMDV1f3/5ul8hNbKh+8Zbsj80cisndue7zrlEc6PtOnT
 QpiddjXUcrCIMbFICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACYit52RYZ4Qs+dJc9XZnP4n
 frR4rXqa5Ma+X6v4iZ38lyaPotjSK4wMX9/J+1/oEZxeKK1ySNHzvbd/MssT0+t819wvfLoxnVW bDwA=
X-Mailer: git-send-email 2.51.0.869.ge66316f041-goog
Message-ID: <20251015205634.3820870-14-ardb+git@google.com>
Subject: [PATCH v4 resend 5/7] arm64/efi: Drop efi_rt_lock spinlock from EFI
 arch wrapper
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Ard Biesheuvel <ardb@kernel.org>, Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Mark Brown <broonie@kernel.org>, 
	Pierre Gondois <Pierre.Gondois@arm.com>, Sami Mujawar <Sami.Mujawar@arm.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Since commit

  5894cf571e14 ("acpi/prmt: Use EFI runtime sandbox to invoke PRM handlers")

all EFI runtime calls on arm64 are routed via the EFI runtime wrappers,
which are serialized using the efi_runtime_lock semaphore.

This means the efi_rt_lock spinlock in the arm64 arch wrapper code has
become redundant, and can be dropped. For robustness, replace it with an
assert that the EFI runtime lock is in fact held by 'current'.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/efi.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
index 6c371b158b99..0094f5938ba6 100644
--- a/arch/arm64/kernel/efi.c
+++ b/arch/arm64/kernel/efi.c
@@ -165,19 +165,16 @@ asmlinkage efi_status_t efi_handle_corrupted_x18(efi_status_t s, const char *f)
 	return s;
 }
 
-static DEFINE_RAW_SPINLOCK(efi_rt_lock);
-
 void arch_efi_call_virt_setup(void)
 {
+	efi_runtime_assert_lock_held();
 	efi_virtmap_load();
-	raw_spin_lock(&efi_rt_lock);
 	__efi_fpsimd_begin();
 }
 
 void arch_efi_call_virt_teardown(void)
 {
 	__efi_fpsimd_end();
-	raw_spin_unlock(&efi_rt_lock);
 	efi_virtmap_unload();
 }
 
-- 
2.51.0.869.ge66316f041-goog


