Return-Path: <linux-efi+bounces-2827-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF573A45FC6
	for <lists+linux-efi@lfdr.de>; Wed, 26 Feb 2025 13:52:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C19CD174081
	for <lists+linux-efi@lfdr.de>; Wed, 26 Feb 2025 12:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E35B2CAB;
	Wed, 26 Feb 2025 12:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u7DBKhpj"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5639D19FA8D
	for <linux-efi@vger.kernel.org>; Wed, 26 Feb 2025 12:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740574345; cv=none; b=AJ+d4oDC817CcTD2Tkt6j6AmjEXS3Kq+ZGmaG72/vvOqSpSD59T4TQ6mOtEad7Uqa60/NFq54x8ABmD76Cc7jxK4C7GOzRXVGH3MipaQYiN671vubEtXMIZo6ykBbWNoHjtu63vHufliMTt+feU+YteF3k4tFHMZHYXzWECpb2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740574345; c=relaxed/simple;
	bh=DLOmgvuYm7rRr1Mn3cTuskhIaAzUIQ9hbGsEkSM4BhA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=bFy+viuzEeStAY5HkeQOKGf934R0aHYLI8LvFTgrb/v27vGm6gmy9JKKaRjpsrvksVCPqhKqOJUMGOCrugWIPKtj5vT5QtsNH4UuS6x4QNPpa/XR8XuwHDHn08pzKKQC1n1mCFhdWjdc4I0ZGTi51n+6eQDbCekh4okxtZUeA9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u7DBKhpj; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43995bff469so51802325e9.2
        for <linux-efi@vger.kernel.org>; Wed, 26 Feb 2025 04:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740574341; x=1741179141; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=p0Eg2HNxJs9v1n92PfG5mSuSMtgXjOi855QUIz3gooQ=;
        b=u7DBKhpjIwRrlwejuLCabcLmY0fFSoCF2wvQc6rtZmjpqG1qe52duowzPnoryDwKHf
         ch9dOk8qbYoUb42iGDOLqwxqFXMg+Ixc5ZhRUU08E/HaLnAKqHIylZ6AYROH4vYe5VMH
         qudlMvP04akfu6Ju9rHheqJgYfJlhkYyvmhZq+O1L+BS6hvRupTtX1+V7GgVXhG31HHh
         8nJRToXWDiUVBomrz04Ltcu6nn5mkq1Sen4ylRhR3EscrHM0PrX8eo/QUVeJoW3oN22I
         fyxWrKqI1olrpRzjHA5d/M+tLNJ5ug//aPnKWm3b0d2dMsweHzj9Ee/E6O6wPqCvvKZc
         k57w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740574341; x=1741179141;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p0Eg2HNxJs9v1n92PfG5mSuSMtgXjOi855QUIz3gooQ=;
        b=McaQmYXyxm9DdqBmVuYT6nODxpcUFZ1c9z47cyOjzQkeKy3EMK6XOH5RPgNC1h+pqF
         73Gc5qeh0RHiVtCrvHBqwrqMEWopzHU+gg5RE+vzwlN3U5K1ypVZe4HVVltlL6KYc94a
         DAzEs43sTNp8eJNG6J7/8//hCe9/mfu1Uz/h39f0y2cIpPThEUN+Wa2Opx/E7R8xJtbm
         xKwodzYkWJNQSi8q/UgbdVIxmPTQ4ttBFQFJcns88pkctW/9jnyr+Lhd/wTTlB7ZqVJd
         zewU8t17hr7J0sch+cD6TPysegdfU6fD0duFnQj/9RbDge6UOXTjN29+8EPB46lw8SGb
         b1Tg==
X-Gm-Message-State: AOJu0YwzUARrxRNqe3BgluGHw5r0TVcRRGzMoNi8a+tFC5tMB2fQp6EZ
	KNvhne34G5BZCVV4F3E0IEanoWrChOL0SsAy5Oisucuyhwj87Dw9iOwlVt1xJLF/1N3KxATTtAn
	3vyvT3peGZTC4P+MJt+1NmrMzca9lcGK3XVcszHyt1OGR09WnGGcDY10QdqaGWhAz7zXND7CpIV
	xlkRMaa8+aJcVg3ICb+UGUFmBE9w==
X-Google-Smtp-Source: AGHT+IGIIdmjDuykOOMG7SMO3gcKyjpeMv6NbatSgSvTu5D7uUhUpHmC6BzdLT2hcOWaE2AjdpWBxP+V
X-Received: from wmsp3.prod.google.com ([2002:a05:600c:1d83:b0:439:7d73:d8fc])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:1550:b0:439:a1b8:a246
 with SMTP id 5b1f17b1804b1-439aeb0d445mr154574925e9.8.1740574341689; Wed, 26
 Feb 2025 04:52:21 -0800 (PST)
Date: Wed, 26 Feb 2025 13:52:16 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1575; i=ardb@kernel.org;
 h=from:subject; bh=yaGFrePe1Yu3ytdtjB75D5E322rvfkclvu9zAW13LoU=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIX0/X0PReZ2LLT8Oc5ZZZZ9Y7O+h+d1gQl6aTdHRoAUxb
 Qplfic7SlkYxDgYZMUUWQRm/3238/REqVrnWbIwc1iZQIYwcHEKwEQOHGH4nz7VhkktzmGll8CS
 xOz6cs5HHhwqU1d5eiz7n7WjTHDXSob/meyBx/q0vWdcUT3Z8lnK7aF3ekm90z2rdsldQVmWJ+Q 5AQ==
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
Message-ID: <20250226125215.2545828-2-ardb+git@google.com>
Subject: [PATCH] efi/zboot: Avoid CopyMem/SetMem EFI services after ExitBootServices
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Given that memset/memcpy are intrinsics, the compiler might insert calls
to these routines unpredictably, including in code that executes after
ExitBootServices(). In this case, the respective boot services are no
longer accessible, and calling them will cause a crash.

So detect this case, and fall back to a bytewise copy/store if it occurs.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/intrinsics.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/libstub/intrinsics.c b/drivers/firmware/efi/libstub/intrinsics.c
index 965e734f6f98..f26c19cf65fb 100644
--- a/drivers/firmware/efi/libstub/intrinsics.c
+++ b/drivers/firmware/efi/libstub/intrinsics.c
@@ -17,7 +17,12 @@ void *__memset(void *s, int c, size_t count) __alias(memset);
 
 void *memcpy(void *dst, const void *src, size_t len)
 {
-	efi_bs_call(copy_mem, dst, src, len);
+	if (efi_table_attr(efi_system_table, boottime) != NULL)
+		efi_bs_call(copy_mem, dst, src, len);
+	else
+		for (size_t i = 0; i < len; i++)
+			((u8 *)dst)[i] = ((u8 *)src)[i];
+
 	return dst;
 }
 
@@ -25,7 +30,12 @@ extern void *memmove(void *dst, const void *src, size_t len) __alias(memcpy);
 
 void *memset(void *dst, int c, size_t len)
 {
-	efi_bs_call(set_mem, dst, len, c & U8_MAX);
+	if (efi_table_attr(efi_system_table, boottime) != NULL)
+		efi_bs_call(set_mem, dst, len, c & U8_MAX);
+	else
+		for (u8 *d = dst; len--; d++)
+			*d = c;
+
 	return dst;
 }
 
-- 
2.48.1.658.g4767266eb4-goog


