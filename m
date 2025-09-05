Return-Path: <linux-efi+bounces-4697-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC728B45907
	for <lists+linux-efi@lfdr.de>; Fri,  5 Sep 2025 15:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB1EF7BEF57
	for <lists+linux-efi@lfdr.de>; Fri,  5 Sep 2025 13:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5BA35335B;
	Fri,  5 Sep 2025 13:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1sTFyaI3"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD05352FED
	for <linux-efi@vger.kernel.org>; Fri,  5 Sep 2025 13:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757079052; cv=none; b=f46pEg2urNHovl2AunDYBuyQqxAd+qyJkJG9rV8421TkGBavetokwlThhgkOS6tEBz0MrJI0MN767g+xzLErHywYDWv2G8DFqZIks73SxDcDXLY2FhEtdcd35/2MUUuGtanBvFLlcjcqkW5yQTCcB6ghv+LF5deUM+oZGA6RerE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757079052; c=relaxed/simple;
	bh=96M80QLlOWDIQWQkbn/8Qkxz4zRnLs8vvaM6+45npjA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Z+DIwYI6NuSpHW8JJS8mfxowsQvqwG5Q6pcJn1U3hnVJvX912eMr0sGxV4/4g3ZdIAK+B9PHIG2P0gHbqQZhq62raa4MabqZ3ea/GsaH8yZoKlNDgq+rqepTsSgk30HfSrEndTOl7v4XIl6I2Qvbwy7yhKw4dHkg2hGp2DgS4o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1sTFyaI3; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-45dd9a66cfbso10345875e9.1
        for <linux-efi@vger.kernel.org>; Fri, 05 Sep 2025 06:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757079049; x=1757683849; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6+gwoCjWfTju3sP/jVtuc7/g8X3wct7nCOhB3h1yVAQ=;
        b=1sTFyaI3pftxxcNiRC7sBtXZcP9nDtgJOOu0ivWdNE+mAE8FKifbYbnxFLGC3eEshX
         Cu7uARX8Cn+xw90vJQOVBiFlL8OboeYIC7UFOx+WhrLyGcoNoWkCLuER0UkkjzQA4PVF
         RdJt49TbNMpf2Dylkrzv9gqoWHScsJlhy5z7UvaZfKXH46l2U5YRomVsKC0S3LhKHUSW
         K/PFfvzqnw/mh2+5/HD6Hw/CWTakIZcs7/h7HUTYIJ50AORkxS9FTaMyRJnh0lmzCIpQ
         JSpO8iHRJjH1Ntf/J9IQhFnxcWqqinpSEgh0dEknn1iUiOiW07XuFNrARnmEUVK1Q27s
         nUAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757079049; x=1757683849;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6+gwoCjWfTju3sP/jVtuc7/g8X3wct7nCOhB3h1yVAQ=;
        b=YVqlijdm4ytPb6tlsfEF4GA0iCgeiE6nf6QkLGDe/yBCw1eg6am7bImNL5HKLt0WS9
         4xbNXszaObdTPMUtjsYpSI/WIUq++6TKOsimzm6dUVMpWuj7gvXVwKEZ7wh682vraSE3
         XZCD6/kVfZtYLYlV/rfRIo8/QSO5Xg7W4X5BV/9rAbmrH/v31bBUnYTV3ZgbtQXV4IGy
         rydAN4yGXwzlKDCF3ediv6hj50eOYEsC/5xetO78SOiXSYXjDtTYsKqFDZjW8btoB+ed
         CjilT9ae5gAbEFYcXHSX6IRTa2RvzsIPAvF+XhjUuCcViAqbCMIvZeT1c1R0Ns7bSZoF
         2YDg==
X-Gm-Message-State: AOJu0YztYspPQpRWOgyemt5Y9cZwRUOkypmudUnK0nEabTnhxDsvSJKY
	ZF+lYBrqsvByYaz30uW1wjQRsc2+QAKtWmyyU6zKguid1cf7mQ9EM/zt+DUImNqGd3N6YFY9xnp
	BH591Gui8bjodaB6rlFEzMQhD+VSwwCO6AEhUfkpFgj7SiOpKeg/8GyQBrCcj+B5EWMX/ktBSof
	4ghi8TAMPChgiqQpNOCHH5F10Gg0lg4Q==
X-Google-Smtp-Source: AGHT+IFopEjOcoNJYtItMHOege0+1Lpxw3R3ZwN0yI0iXz4fJJsgWwvzjjGw2Y/Y7xXxRt/ZprPJuGNY
X-Received: from wmqd18.prod.google.com ([2002:a05:600c:34d2:b0:459:d8e5:ae9d])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:1e87:b0:45b:47e1:ef68
 with SMTP id 5b1f17b1804b1-45b855bec6emr184837055e9.35.1757079048728; Fri, 05
 Sep 2025 06:30:48 -0700 (PDT)
Date: Fri,  5 Sep 2025 15:30:39 +0200
In-Reply-To: <20250905133035.275517-9-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250905133035.275517-9-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=4130; i=ardb@kernel.org;
 h=from:subject; bh=zNP081W6ZhtW0flsDQ3N/BMuwKS0QOlu9XU/sv9Pxgo=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIWPX03+yk0xKTJwl38T/f51SZBqVXMC0s9Fo/qwXrmWqL
 PG3gzd3lLIwiHExyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgIloZjP8FXQxVZrZNXWLnZXB
 Ow1ze94vX/Zzz2VK+c92/LwAi+f1BQz/q3YrzN9To71e2LlDVqzuLIftb65dFrlRy2baqk/8tUa YDQA=
X-Mailer: git-send-email 2.51.0.355.g5224444f11-goog
Message-ID: <20250905133035.275517-12-ardb+git@google.com>
Subject: [PATCH v2 3/7] efi/runtime: Deal with arch_efi_call_virt_setup()
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
index a98cc39e7aaa..325d892e559b 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1181,19 +1181,19 @@ static inline void efi_check_for_embedded_firmwares(void) { }
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
2.51.0.355.g5224444f11-goog


