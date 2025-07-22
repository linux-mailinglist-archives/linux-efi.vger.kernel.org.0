Return-Path: <linux-efi+bounces-4457-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7127EB0D32E
	for <lists+linux-efi@lfdr.de>; Tue, 22 Jul 2025 09:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68D4716F462
	for <lists+linux-efi@lfdr.de>; Tue, 22 Jul 2025 07:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2CF52E339D;
	Tue, 22 Jul 2025 07:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IPCZT3UU"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BF42E2EF4
	for <linux-efi@vger.kernel.org>; Tue, 22 Jul 2025 07:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753169415; cv=none; b=D+wOcBfaAOTM4AJwhNQ9XibmeSSQY8Knvq1maKiZXgtG9VreXrdqdkqGQvHvApy84pUrdeVQ1LmNzPuTPflaVvmJhBF+w9hYftnc+8VQPFhiMlp/3iY9DHOgC0vwCh4/kQaVpCasBXRF9oom6xeo7WqfEVepYQ5PpEFTVkkWk0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753169415; c=relaxed/simple;
	bh=MlIRBxRaja7ZlU2OXFrbRrUPNNl74/HsMd4o37sL9hE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hLjhnXSzFqITN1FbJF8m3iaY09PAmWGvh/9YytGPlDqOgfLu8MooXXaktahsEqLDTDUMqQJXTJvZ1ECkoaKXCtSJUQPeJARD26eXk1D+aQJUm5uXDsokjCxBaz88PwKixnPbU2UIkohUyD0WCmoes3l6NCsH/3V6JLKi2cIQav4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IPCZT3UU; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-455e9daab1cso10840475e9.1
        for <linux-efi@vger.kernel.org>; Tue, 22 Jul 2025 00:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753169412; x=1753774212; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sRQugI64DfH4l5motO7Op00/v3FgIyII8TOhMD/41k4=;
        b=IPCZT3UUPCUicdgRendY75IhkzSoJHNjsfb4VPfAv1pGutN2BQvgjnfUtMYbU94iTW
         ZGzKPKRUmrYDi6vELbHEZQ9j5jJWjraNJvcpLJi0TxgXQiFPprHq8DUbSFDT90SEW0ta
         a6z4Hri6oORrHPSN3kge+OS+8BIX3NR18JvFdX+yoQvDqlXO0sg3+oCti+GLZFqFsndQ
         mEqdAqWcDwHIM7uiquDZAlbpFbz3/xOMv9MMvcI7TEU6GLn1nwIGOTcCtCZAi7oILmk2
         4arIYhjdp3gFtx5E33OrdaYtJ5l3p1orU0IPjLvi1PgnSra28PodSH6kMUpKbiW6j4In
         P0SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753169412; x=1753774212;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sRQugI64DfH4l5motO7Op00/v3FgIyII8TOhMD/41k4=;
        b=ooHpV9NJjhQw52B0hs6nh80czISv403LTDOIDmBpAaB9gbDSB0NYVbm+AJX2rz2Vce
         x+ftjvsHQ7PLhrwTEsWFbWRG9jw1BT8kNyHkGlFS3wrduqjVK1WHKUMDAEfe/eI5DRYv
         EeazISBoYQDBg2lRpY9hx938uWsPCElrWdywWNQA4AIap8O6EA5srGKJeTHMUTIuOl8f
         rm/YD8IfZThFF4fUYN/PQRqC84kd0VeSti37Ac5lo6MsBlpCUdZh7Lgp0ZcsP4HZpCAv
         5mslb/bHHDyw+6fruiKyQXbd/+bF8LqCwitWkITk9nb8cpbJ1XktCLGCwVP43cWtkNWe
         VKGg==
X-Gm-Message-State: AOJu0YwZY3E2g8V76+dOwYyQtoe4Wej1akLOg8I/55cuf3k372Tt2dpJ
	LoahOB7iHi7qkQfe8gBKmmGoOJpsgaPDGOGonDkuKyus03aSpev7jhz7THL9i+ktgbQ4qkxRbQ=
	=
X-Google-Smtp-Source: AGHT+IFHQkrfJj9WX8KbnmcOtmg/6CDYAHe6Xbecpjb7ImR9En+2bUK1m4cqvZAIzJuTNGaHE6HnMSMz
X-Received: from wmqb14.prod.google.com ([2002:a05:600c:4e0e:b0:456:1e7:c024])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:4fc1:b0:454:ccd6:327
 with SMTP id 5b1f17b1804b1-4562e039d10mr224727535e9.1.1753169412279; Tue, 22
 Jul 2025 00:30:12 -0700 (PDT)
Date: Tue, 22 Jul 2025 09:27:31 +0200
In-Reply-To: <20250722072708.2079165-24-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250722072708.2079165-24-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=737; i=ardb@kernel.org;
 h=from:subject; bh=2wDANTljMa+3l9R4Cw8PAic5NzJMQu4mfQTgCSM10MY=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIaPedscv7sVf5+tNDPLYtDlYzOSK1yfL44x1l4WeK/9+V
 nE+ImdGRykLgxgXg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZhIWhsjw7ZFh2580rgz5RJj
 o2hfkkLwj6C4DSzu8yOVV6zZqf9/XiUjw+yKpsIdB99nr5ozVVn9dPwF7xjxzVzSxlPvKfxzunF PmhkA
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250722072708.2079165-46-ardb+git@google.com>
Subject: [PATCH v6 22/22] x86/boot: Get rid of the .head.text section
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Kevin Loughlin <kevinloughlin@google.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Nikunj A Dadhania <nikunj@amd.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The .head.text section is now empty, so it can be dropped from the
linker script.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/kernel/vmlinux.lds.S | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 4277efb26358..d7af4a64c211 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -160,11 +160,6 @@ SECTIONS
 
 	} :text = 0xcccccccc
 
-	/* bootstrapping code */
-	.head.text : AT(ADDR(.head.text) - LOAD_OFFSET) {
-		HEAD_TEXT
-	} :text = 0xcccccccc
-
 	/* End of text section, which should occupy whole number of pages */
 	_etext = .;
 	. = ALIGN(PAGE_SIZE);
-- 
2.50.0.727.gbf7dc18ff4-goog


