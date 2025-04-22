Return-Path: <linux-efi+bounces-3404-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2566A96567
	for <lists+linux-efi@lfdr.de>; Tue, 22 Apr 2025 12:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA77617B942
	for <lists+linux-efi@lfdr.de>; Tue, 22 Apr 2025 10:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7606620E703;
	Tue, 22 Apr 2025 10:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gnv98v5g"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB84220D4F6
	for <linux-efi@vger.kernel.org>; Tue, 22 Apr 2025 10:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745316469; cv=none; b=Rbq8/5tf7leAB67d7G4KTiXF8D0I5jxK9thYtx4CZHMO7mIt3GE4xNWZ6xkaDWY1Y/jnoZwstfkC+/3ZhI7BntsKbVf7g0jMAFY7niqDXLpEnyRViYITtwXee8/GiOPovfHQ1VMJ9N0ULJz8+0FNYshJi80nMXS4LyT/BKvBUH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745316469; c=relaxed/simple;
	bh=Cm8NWA5BP3mKS9HwnzkrkrTJStSA8teiiKrtym1me88=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dq74akVjgl44sFPl3ZQl6cOzhwSyxQeF6lJTxPvNL4RZbbkmj6a9Z8+FD/1Cya+TzYS66FXrYZtLhFr8Nw8+2nCwhyHKjvjLtYB/nbO/5isJJUi3JGJ1iP/xz76oWoli1nP6ljGT+j7oAHLbr29o0finSlATTSKYEG3zfkVebRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gnv98v5g; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-44059976a1fso18695415e9.1
        for <linux-efi@vger.kernel.org>; Tue, 22 Apr 2025 03:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745316466; x=1745921266; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xt0ht6liAgPY3lQrG7FkkuME9QDJdGbeFpIuIVjivfE=;
        b=gnv98v5g+ee2IpRCfC+VIpVf1Wg+rOgXD4tOX9hubh77xBTulbIwbhSuFGnnwViKRo
         BQmHbxKyWoGez6D975U1p651TZPs5FB7qSdJP4qqFTKEUygl04s8zNpVsBNxtpHogzoE
         VL2H7L9loKHnA7aT090faDSFK7hFbj6j6STqVAaTwFI5pF6mC084IlD92o8w5P58vGow
         nNcC34+W8W6+gR8secqXWQ9/ZjdoytMCkBZY/zNQ7k9rmXR7bVzmzIvSKVpizA426/94
         nYGFmOihlHUEalJAEA7fWd/fGeqveurn3kp3sRjZMEvJLEgIMRhFRBtv4uSFOPCqqQQM
         MDGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745316466; x=1745921266;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xt0ht6liAgPY3lQrG7FkkuME9QDJdGbeFpIuIVjivfE=;
        b=chn/CErJ9xJM8kBqu/h/M+FTtq8HXDlIisCHGzH7QAHDUnsJFSfuZaULAPlAh5zQKB
         Xd3CKfQeRKHE+7SqDa3mfI1IyvkfYVP5UpOZUULnZ4VDzdsnnSyCKID2h1TdnvHGLgDZ
         0uXpFw/7Za4nNGJBqORooZIgI4izuGrEBgyAw1sYMNOgrLJ2/4SeppHP90/xGq5Qr/7+
         i2zBPf+kgw1BWw0QXotg6sSsuU3K+oTecbOdvTJAOgU6ZDb+NEKlkXw93fwRhtuaJRAg
         TJuHRRD6e9SN8AimFq0rrmbBkIxAW3U+QG2LzPl/YU4COyVjAlJiztfIPiqAPrZWZNiR
         rUpw==
X-Gm-Message-State: AOJu0YxbmJLnVb1n6Xs3xcGxt9tnOndpB3QM5Q8aYTRYm516U0IYuIDP
	FUZi863xpkDWMtGQJTU9wxrSqn5nyYYnhI9vC+k8BFcNPLfIWqPHZ0DpJltgs16eLvIyQKweHqn
	mouH561U/PMjd1QO2fmi3dc+tJhB1gwe3dr8fSYq0VNPzUroHa6ji+WZx/u0E2LQNHdM/v5zgtr
	uwg6bW5Cahwj8JNq5hXSsO9mrd7w==
X-Google-Smtp-Source: AGHT+IFa177tG0VYSvpzMK9rSDaRQOZxLvX6M1Bp/PdZtKRH9VOk+HdFbm4GTEF/y+LLNhansKj0GIP+
X-Received: from wmbef18.prod.google.com ([2002:a05:600c:6612:b0:43d:b71:a576])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:a00e:b0:43c:f050:fee8
 with SMTP id 5b1f17b1804b1-4406abffbdbmr123746275e9.20.1745316466140; Tue, 22
 Apr 2025 03:07:46 -0700 (PDT)
Date: Tue, 22 Apr 2025 12:07:30 +0200
In-Reply-To: <20250422100728.208479-7-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250422100728.208479-7-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1291; i=ardb@kernel.org;
 h=from:subject; bh=EBYOXtesZbsjk0rQlr19cXSRJkHWcOkYu0UuVsNKW58=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIYM9K/V8wE3lQtbPO61Cvi1r5+RStNpdpaTQx/r2+ceWf
 bPkJ8/tKGVhEONgkBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABMRn8HIsL3uyz/HXbkmDyZn
 t+QGTSk8smBP7cMJW85uU7trUPOkRoXhr4zyvZ4/T5dISoZ87Fmbd8cx5+WMU1sETEqWhBf6Ljr MzQAA
X-Mailer: git-send-email 2.49.0.805.g082f7c87e0-goog
Message-ID: <20250422100728.208479-8-ardb+git@google.com>
Subject: [PATCH v3 1/5] x86/boot: Drop unused sev_enable() fallback
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, mingo@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Borislav Petkov <bp@alien8.de>, Dionna Amalie Glaze <dionnaglaze@google.com>, 
	Kevin Loughlin <kevinloughlin@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The misc.h header is not included by the EFI stub, which is the only C
caller of sev_enable(). This means the fallback for cases where
CONFIG_AMD_MEM_ENCRYPT is not set is never used, so it can be dropped.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/misc.h | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index dd8d1a85f671..1e950bc5b085 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -144,17 +144,6 @@ void snp_set_page_private(unsigned long paddr);
 void snp_set_page_shared(unsigned long paddr);
 void sev_prep_identity_maps(unsigned long top_level_pgt);
 #else
-static inline void sev_enable(struct boot_params *bp)
-{
-	/*
-	 * bp->cc_blob_address should only be set by boot/compressed kernel.
-	 * Initialize it to 0 unconditionally (thus here in this stub too) to
-	 * ensure that uninitialized values from buggy bootloaders aren't
-	 * propagated.
-	 */
-	if (bp)
-		bp->cc_blob_address = 0;
-}
 static inline void snp_check_features(void) { }
 static inline void sev_es_shutdown_ghcb(void) { }
 static inline bool sev_es_check_ghcb_fault(unsigned long address)
-- 
2.49.0.805.g082f7c87e0-goog


