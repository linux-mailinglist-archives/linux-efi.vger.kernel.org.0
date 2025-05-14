Return-Path: <linux-efi+bounces-3706-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 098EDAB731F
	for <lists+linux-efi@lfdr.de>; Wed, 14 May 2025 19:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6237D1BA4E80
	for <lists+linux-efi@lfdr.de>; Wed, 14 May 2025 17:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93CF42882D4;
	Wed, 14 May 2025 17:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VbheYpyu"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCB12882B4
	for <linux-efi@vger.kernel.org>; Wed, 14 May 2025 17:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747244650; cv=none; b=c3ev1dVEfmFZ1KjnQP4vuj3rO9WmyY0QPc0KdKrM7NlDIsxWB7ZBra889dpr6+f+muKWRDh96/sy7n6W5HcuZKXloE7/PoTjHH+8P82hoadJ8t6vjETd+lMqb3LF2Hu3oszWBeTwJNpr/pcNZGvHMluGIRz++URLXLWa5Asv+Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747244650; c=relaxed/simple;
	bh=2pTyG7a78PYxDJeFo/V+utVWoYoeAwSEDNzrtnCQ2TU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=if+g8DHa6UHXh/jxLWS9uS27IyJeLo0Qaxc4BnLPO8iItsWmmrtOuJTg5huy+xxDKyFxkiq7qErpO97sqIfDslMA8f8Djaz8FnrSj7euDdPRnhmWzwTqzRKASmAkO4Zqvp00PGU+LRWkmTzowZbeKRca00OOjcUEMSxUI/vGry8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VbheYpyu; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3a0adce033bso17354f8f.2
        for <linux-efi@vger.kernel.org>; Wed, 14 May 2025 10:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747244647; x=1747849447; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rPT2qHs8nb8woLd8l62ZcLF4l1Hy/juOm4dBzovnmEc=;
        b=VbheYpyuZmTK32ENushkLvqdzvpvoiit4idGHh9MdglHqz1lvUXEB2847hJHOF9Kbw
         hWOXB4DYvjwJrRweLh7k+TzdI20fOa/AhsziP5gnMLSr6jqbL5fgDIGlw77ijzPdPPNq
         Se11b3y6kIsyLnJVFkOEqGs2AG2sNYIKwiJLrRyqPqnk9b2ctzwAFIknOVQqZQ0Dl2Lj
         VBiqCYyY7jS4c87RQo/pPYOV2uFrxG2/f0xEgJ/3JEggshaYGr8mEOOPqVOMBQ8prSkn
         8DDSkI2yWWUyri2aP1qP/zK5VbGt6gcBS61Bx9InhqkeFKhn2fsjccZ54Ug8Sg8lGxkf
         d/ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747244647; x=1747849447;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rPT2qHs8nb8woLd8l62ZcLF4l1Hy/juOm4dBzovnmEc=;
        b=QMbNvT1MQWxcIAFxFX6rl5pDhM4O+L+lRpZMVkUHRr6Z4aGQa/PW8Pop6t0hBP8zOl
         XIo+WJz27NbRjEuGXPCnmRgoi445k5R44Xl17XPa0hFdoPJEDeoikDCJzLdSW21caihz
         lfkPGiNEOh+jWsfY/UoxGCKJCV0icUZaHJkC4aW+p88UTrzY2qX4iVKVjZ+3zoGMbb9Y
         Q7CImImFXIODNt/TKtH8eFBJ1gyd1M4hPLXe5R8qZUEabGH0BIvGAZ1KPFfIouSbxIKM
         aeGlyPh4ok9B05EtGOI8UU7nsMb0NT2JSqdTkURszdpje7KaAwfgeAxv/pJ8Mx8G+vO8
         bkcw==
X-Gm-Message-State: AOJu0YzFbCtnjlSII5ZKedljHU1pd6NzFQkMq3CnaHGF/y855fEP13br
	l1oxOOcAa61Jzhxc3dS2Gups+aFJdlkEhZPHfjmRVg3wL18FmQVvN05o1tjwQlvOJ+Dk6DmqERz
	y+shPAJHRJEG16Ar6VmgbX20XGlhEkiza2doIrf/dnl4lD11k2hzJFUb98MN1ghORz+c1SA3Fs1
	anrkV10Ad4An+7IYaKiwSBK/FJjg==
X-Google-Smtp-Source: AGHT+IGbwcdtxYzq8nDG7XB20QQ6m24gl78kM2NUn0+FEJqLZ7BDo2egTQqnLcfij6k5NsW+zWNEgZ3T
X-Received: from wmrs6.prod.google.com ([2002:a05:600c:3846:b0:43d:1c63:a630])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:adf:fc11:0:b0:3a2:2586:581e
 with SMTP id ffacd0b85a97d-3a3499532e2mr3010019f8f.53.1747244647113; Wed, 14
 May 2025 10:44:07 -0700 (PDT)
Date: Wed, 14 May 2025 19:43:46 +0200
In-Reply-To: <20250514174339.1834871-9-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250514174339.1834871-9-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1727; i=ardb@kernel.org;
 h=from:subject; bh=JhAXBUO5lApwzqV0/zxSwFWazHc5G4mQ1by8+P/Uv/8=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIUPlWljMtpUJVZ80e6ZI9Ra1zHxSJWYQVOd6b1nCEvHUX
 3qhQjkdpSwMYhwMsmKKLAKz/77beXqiVK3zLFmYOaxMIEMYuDgFYCJyqQz/Q+7ZXWWb8qPRVdt3
 3hqpZOWCDNay+XfdD6woEZAwjeRxZPjvHl77hpX3uNb8PJNws+OinS7mV6NZXMOPe5wSm1kYncI CAA==
X-Mailer: git-send-email 2.49.0.1101.gccaa498523-goog
Message-ID: <20250514174339.1834871-15-ardb+git@google.com>
Subject: [RFC PATCH 6/7] arm64/efi: Move uaccess en/disable out of efi_set_pgd()
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Ard Biesheuvel <ardb@kernel.org>, Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

efi_set_pgd() will no longer be called when invoking EFI runtime
services via the efi_rts_wq work queue, but the uaccess en/disable are
still needed when using PAN emulation using TTBR0 switching. So move
these into the callers.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/include/asm/efi.h | 3 ---
 arch/arm64/kernel/efi.c      | 3 +++
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
index decf87777f57..abe9176a3a23 100644
--- a/arch/arm64/include/asm/efi.h
+++ b/arch/arm64/include/asm/efi.h
@@ -132,15 +132,12 @@ static inline void efi_set_pgd(struct mm_struct *mm)
 			 * exception when invoking the EFI run-time services.
 			 */
 			update_saved_ttbr0(current, mm);
-			uaccess_ttbr0_enable();
-			post_ttbr_update_workaround();
 		} else {
 			/*
 			 * Defer the switch to the current thread's TTBR0_EL1
 			 * until uaccess_enable(). Restore the current
 			 * thread's saved ttbr0 corresponding to its active_mm
 			 */
-			uaccess_ttbr0_disable();
 			update_saved_ttbr0(current, current->active_mm);
 		}
 	}
diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
index d01ae156bb63..5d188c6c44d7 100644
--- a/arch/arm64/kernel/efi.c
+++ b/arch/arm64/kernel/efi.c
@@ -177,6 +177,8 @@ bool arch_efi_call_virt_setup(void)
 		return false;
 
 	efi_virtmap_load();
+	uaccess_ttbr0_enable();
+	post_ttbr_update_workaround();
 	__efi_fpsimd_begin();
 	return true;
 }
@@ -185,6 +187,7 @@ void arch_efi_call_virt_teardown(void)
 {
 	__efi_fpsimd_end();
 	efi_virtmap_unload();
+	uaccess_ttbr0_disable();
 	up(&efi_rt_lock);
 }
 
-- 
2.49.0.1101.gccaa498523-goog


