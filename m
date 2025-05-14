Return-Path: <linux-efi+bounces-3703-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D81AB7319
	for <lists+linux-efi@lfdr.de>; Wed, 14 May 2025 19:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F9904C666A
	for <lists+linux-efi@lfdr.de>; Wed, 14 May 2025 17:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE42E285401;
	Wed, 14 May 2025 17:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uEUufJG6"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1CA280316
	for <linux-efi@vger.kernel.org>; Wed, 14 May 2025 17:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747244644; cv=none; b=uOLmQp0Gqm6rq7t2Yw8Wa8vsYCW6ACKqZuyoxSWmp9AAGvS0Jq3iVjkkwOTco2KkfdFhXP5EpbYHm3gONXYNWIDvd+qjYZvG1hL0DCSc/M+bXPfRomHMkSYCZaX3VAzjxCqSj8w2GuqodICw5XjXheFa0QOkDIPIm/vS+QrUprA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747244644; c=relaxed/simple;
	bh=r4eQVxCCQ3NGsGM9bJXrqNCo0KJxcgbpHM71Yu/owQg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=g8NxiiQBuZbPb6N2M5iJ2F+GdIbj9QmDbGBerJRQ+62mNdMnZKi0JBz+v+4HEDz9nSHgIe9SfyYZumqSOyECqOBGQoe30UkB8HA6t8D0/nCL+IaLtJewoAjHDvssUMU/kaiV8VSFjNGiK64uxAEMEy00Luk909jtuo9tLTxpowY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uEUufJG6; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43cf172ffe1so445385e9.3
        for <linux-efi@vger.kernel.org>; Wed, 14 May 2025 10:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747244641; x=1747849441; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lr489qzcXalsUK5OJ8OM0VMNZiYyGTMtXZ1AW7+fvJI=;
        b=uEUufJG6MyG/tZ25duEvJs94ByyQZT5jA1mrkffH4n+Tr7Ubojr9PClwVctTWB9z2P
         uWqZFSr7ii8LuiP+sChSjsMMskLAxS1Rx2GM+0Km/1dh+Y11puMtuCfSyYEh6t5w+pMq
         YF95QpMxg35hWngVSVu3kLv4cOC7nR7OYq61o55kkhPu+6797jiPVsdhxAQVrTy+6sOh
         24J+li/GgAmSIPzP0OM228kyYiZbNqF5o1mNHt+6fqyOUYUtdBYZ08OZT4OWMOdPVKex
         sQH3KnTgbZBawK0jFkIumiD/Aa00nodPvKK38nEw6dI1pDRNs/oMY47J/jGZROg4Pb5x
         eUWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747244641; x=1747849441;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lr489qzcXalsUK5OJ8OM0VMNZiYyGTMtXZ1AW7+fvJI=;
        b=thgGNzlSYzQpMG7p+lzA3GzCAqNfP9YWJeR9CAZCDOwFSyqgCnjDsLOdBCS4j3zwcA
         bcSPo+LufGEvkvt+QfkE62PV67Wp/h0nl1XPQI2F/LFHUcLRb4TCeYECYZxCybAo5o4M
         1EaMU6/zMFrMPDBUC27PZdIha9Gs9fcyx084QP9BFuKuHKiWvn6QpVXwvkJtznYXdiTA
         t0KR+MrmtheK2SdNpA+Lp2hppTYQQLS/ru5C3cVTgHhgj55f8VpBT2VAq8424+faIm9v
         h4WaYuQt4n2GfstxuUN2XtUiKaV96ru4FXnkNGjmlpJzbrthl9+6J511mWo/J8G10Wbo
         QgUw==
X-Gm-Message-State: AOJu0YzglKhu+5i0PWdBIf1uhQEkWKjOH0iKxruHk6KdoZjBFKl12bGK
	ZZXH4MF2wn/gLbYxF9Tn+Nf5/6RlTTiFL/InfrbTCTbQUDNYZvWjSRCijEErjetq+jk08+uXZZN
	sVrFzqD9FU/KpjpDNAlMb+U+DQtFUOw/CeHYkPV0pjZFOp3QJkv5EkBuqzPE3N5BU+zFIoXBU+Y
	zCCe+Y2GmVyZWKotda7wnzrHdjeA==
X-Google-Smtp-Source: AGHT+IF4eQ+ydqWoNEayJUroHoQxAkXTja0NASjKqMSbnY/vDFIWy+Z3Ik1V29mozN3Vprxr/BZDW0of
X-Received: from wmbes6.prod.google.com ([2002:a05:600c:8106:b0:43d:9035:df36])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:3e88:b0:43c:ec28:d31b
 with SMTP id 5b1f17b1804b1-442f20db116mr51865765e9.10.1747244641338; Wed, 14
 May 2025 10:44:01 -0700 (PDT)
Date: Wed, 14 May 2025 19:43:43 +0200
In-Reply-To: <20250514174339.1834871-9-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250514174339.1834871-9-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=4131; i=ardb@kernel.org;
 h=from:subject; bh=x0gdcnYhqzj5S3CKFvtpWSVou+0kjuvQshTcS6vWwRw=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIUPlWtCHRjOVN3Oe9CUE+qgfYqgVFDYN5/fMOJG39Q1XP
 8tvod8dpSwMYhwMsmKKLAKz/77beXqiVK3zLFmYOaxMIEMYuDgFYCIyPxgZJr5t23bkHI+e4L/g
 /Uyb7zvXZkQffX2hPkDyibaNZsRqEUaGu6n26yx+vJ27fmLn2eryZUYT6pUyp/6Y413hmjlb0/I xCwA=
X-Mailer: git-send-email 2.49.0.1101.gccaa498523-goog
Message-ID: <20250514174339.1834871-12-ardb+git@google.com>
Subject: [RFC PATCH 3/7] efi/runtime: Deal with arch_efi_call_virt_setup()
 returning failure
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Ard Biesheuvel <ardb@kernel.org>, Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Deal with arch_efi_call_virt_setup() returning failure, by giving up and
returning an appropriate error code to the caller.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/platform/uv/bios_uv.c          |  3 ++-
 drivers/firmware/efi/runtime-wrappers.c | 20 +++++++++++++-------
 include/linux/efi.h                     |  8 ++++----
 3 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/arch/x86/platform/uv/bios_uv.c b/arch/x86/platform/uv/bios_uv.c
index bf31af3d32d6..a442bbe5b1c2 100644
--- a/arch/x86/platform/uv/bios_uv.c
+++ b/arch/x86/platform/uv/bios_uv.c
@@ -32,7 +32,8 @@ static s64 __uv_bios_call(enum uv_bios_cmd which, u64 a1, u64 a2, u64 a3,
 		 */
 		return BIOS_STATUS_UNIMPLEMENTED;
 
-	ret = efi_call_virt_pointer(tab, function, (u64)which, a1, a2, a3, a4, a5);
+	ret = efi_call_virt_pointer(tab, function, BIOS_STATUS_UNIMPLEMENTED,
+				    (u64)which, a1, a2, a3, a4, a5);
 
 	return ret;
 }
diff --git a/drivers/firmware/efi/runtime-wrappers.c b/drivers/firmware/efi/runtime-wrappers.c
index 708b777857d3..82a27b414485 100644
--- a/drivers/firmware/efi/runtime-wrappers.c
+++ b/drivers/firmware/efi/runtime-wrappers.c
@@ -219,7 +219,10 @@ static void __nocfi efi_call_rts(struct work_struct *work)
 	efi_status_t status = EFI_NOT_FOUND;
 	unsigned long flags;
 
-	arch_efi_call_virt_setup();
+	if (!arch_efi_call_virt_setup()) {
+		status = EFI_NOT_READY;
+		goto out;
+	}
 	flags = efi_call_virt_save_flags();
 
 	switch (efi_rts_work.efi_rts_id) {
@@ -308,6 +311,7 @@ static void __nocfi efi_call_rts(struct work_struct *work)
 	efi_call_virt_check_flags(flags, efi_rts_work.caller);
 	arch_efi_call_virt_teardown();
 
+out:
 	efi_rts_work.status = status;
 	complete(&efi_rts_work.efi_rts_comp);
 }
@@ -444,8 +448,8 @@ virt_efi_set_variable_nb(efi_char16_t *name, efi_guid_t *vendor, u32 attr,
 	if (down_trylock(&efi_runtime_lock))
 		return EFI_NOT_READY;
 
-	status = efi_call_virt_pointer(efi.runtime, set_variable, name, vendor,
-				       attr, data_size, data);
+	status = efi_call_virt_pointer(efi.runtime, set_variable, EFI_NOT_READY,
+				       name, vendor, attr, data_size, data);
 	up(&efi_runtime_lock);
 	return status;
 }
@@ -481,9 +485,9 @@ virt_efi_query_variable_info_nb(u32 attr, u64 *storage_space,
 	if (down_trylock(&efi_runtime_lock))
 		return EFI_NOT_READY;
 
-	status = efi_call_virt_pointer(efi.runtime, query_variable_info, attr,
-				       storage_space, remaining_space,
-				       max_variable_size);
+	status = efi_call_virt_pointer(efi.runtime, query_variable_info,
+				       EFI_NOT_READY, attr, storage_space,
+				       remaining_space, max_variable_size);
 	up(&efi_runtime_lock);
 	return status;
 }
@@ -509,12 +513,14 @@ virt_efi_reset_system(int reset_type, efi_status_t status,
 		return;
 	}
 
-	arch_efi_call_virt_setup();
+	if (!arch_efi_call_virt_setup())
+		goto out;
 	efi_rts_work.efi_rts_id = EFI_RESET_SYSTEM;
 	arch_efi_call_virt(efi.runtime, reset_system, reset_type, status,
 			   data_size, data);
 	arch_efi_call_virt_teardown();
 
+out:
 	up(&efi_runtime_lock);
 }
 
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 7d63d1d75f22..13aff30be3a9 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1179,19 +1179,19 @@ static inline void efi_check_for_embedded_firmwares(void) { }
  *    Restores the usual kernel environment once the call has returned.
  */
 
-#define efi_call_virt_pointer(p, f, args...)				\
+#define efi_call_virt_pointer(p, f, busy, args...)			\
 ({									\
-	typeof((p)->f(args)) __s;					\
+	typeof((p)->f(args)) __s = (busy);				\
 	unsigned long __flags;						\
 									\
-	arch_efi_call_virt_setup();					\
+	if (!arch_efi_call_virt_setup()) goto __out;			\
 									\
 	__flags = efi_call_virt_save_flags();				\
 	__s = arch_efi_call_virt(p, f, args);				\
 	efi_call_virt_check_flags(__flags, NULL);			\
 									\
 	arch_efi_call_virt_teardown();					\
-									\
+__out:									\
 	__s;								\
 })
 
-- 
2.49.0.1101.gccaa498523-goog


