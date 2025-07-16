Return-Path: <linux-efi+bounces-4376-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 816D7B06C44
	for <lists+linux-efi@lfdr.de>; Wed, 16 Jul 2025 05:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68DF35613BC
	for <lists+linux-efi@lfdr.de>; Wed, 16 Jul 2025 03:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53834290DBC;
	Wed, 16 Jul 2025 03:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YaBIwLRj"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7804228FABE
	for <linux-efi@vger.kernel.org>; Wed, 16 Jul 2025 03:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752636175; cv=none; b=eCgla4s3gLO+bCUE98ozJ904hjFUdnzyQFDvZ4lqUV+M/diIJ/HeYByhOMJX6IyCBcWYIenIs9mGJvlOVREfBrv/zV29ZOMjNIwpl6rV7U43TWhksVqaTUdMzyuUBiMwGYET2eRBYN5EwZZSxrGtyF9ZRairzlNiysMCBoT2bC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752636175; c=relaxed/simple;
	bh=MlIRBxRaja7ZlU2OXFrbRrUPNNl74/HsMd4o37sL9hE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MfQVbWDsgCfVU7pILfUFn494/F7YvRTf5HlMkekGydaWgZFRXSgY269zSi/LF0hV4vrEb5o+Tpl/gAMBWxx+3e7RxuxvPUA/aUWkQEQaRlQdABRJwKxINR/qtF/PcMdc1dQdXUOFQF49xcWm36pKVB8ar7z0AagI0b5Y5j93oQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YaBIwLRj; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4561dfd07bcso14327305e9.1
        for <linux-efi@vger.kernel.org>; Tue, 15 Jul 2025 20:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752636172; x=1753240972; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sRQugI64DfH4l5motO7Op00/v3FgIyII8TOhMD/41k4=;
        b=YaBIwLRj4Vr6UldV0Y0mL9F1KzgLePgj8fmf3/zkzrzFJlCjZnHQInfIYTtayANFs3
         DqvNij75wD+pJyqKSHgS/gZbokP3haFC91+btCgXJx8oxUcLfNFQ3ypOCo6WRLChQ03g
         ye5QYmLRJ56/HyQ2AtcS2EPdUiwwyb+dl+UQ3dZYKDhe9UhFMulS91IgYNtYcbOwkILi
         w1TdKzgK+eTOljJZvYD3LoDp0HQkD32xrtDwjumDZqUezru+lmVNCx6FaeFkmU8HryCE
         i5gn8X0CZw1ViTfEwVptDH9U5Z8jFd6b8XEf5U/WmZadqZ4mOvzeE/PsA0abTHjC9K/5
         72+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752636172; x=1753240972;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sRQugI64DfH4l5motO7Op00/v3FgIyII8TOhMD/41k4=;
        b=IAIgUBMiVG7oKJ1AVURmadIbGGe+9OSiOlHgEuLcwis3NlZQArfCef6fX2vMwH0iWm
         IazAatcM0jg3hM77qwzKWbFFd9krNRvsBIVRI9CfYIIQmOvpAvVW2c9ax01WYFF4BNVo
         /X6ZhxLuYeEFufPQo4ohPgOA1I/ofGZ8lWROnumfQI0nPzLv7U2AU9BBjY+ig3s9JKXj
         PeV5aB4gysJglq3LTZL0uW36WSckrM1PuY+ZH0qkO51i8AwxT1clHBfTohf30Y9ixbi6
         NdJOCkxaQeFGsQHO6Yc4PooXUzf6toDvYFhzptT+qdmvBTawMOWNxXFqqnVxThOVVuUG
         37Wg==
X-Gm-Message-State: AOJu0Yyh74Vy2/5ATAARdR7DmvE0K+QvFUyZt9u2jSN1CslpGMCADVBH
	xY+QnaUA4qsVB3uou1DKXwiOyA6Xs6VN2aZlt/tp4l+xP93/v04ZUxEKAm4NTR1eFnUHyAx1Ow=
	=
X-Google-Smtp-Source: AGHT+IFnCj8jxS3KgaXjMYNa9itLUHslkb0mJZSlS2GukOKKJ7oOdH9vQZsgJLJZCFlbor9UZzf5RFXO
X-Received: from wmbeq12.prod.google.com ([2002:a05:600c:848c:b0:456:c7c:3165])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:3b2a:b0:442:dc6f:2f11
 with SMTP id 5b1f17b1804b1-4562e37c114mr7388035e9.25.1752636171834; Tue, 15
 Jul 2025 20:22:51 -0700 (PDT)
Date: Wed, 16 Jul 2025 05:18:37 +0200
In-Reply-To: <20250716031814.2096113-24-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250716031814.2096113-24-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=737; i=ardb@kernel.org;
 h=from:subject; bh=2wDANTljMa+3l9R4Cw8PAic5NzJMQu4mfQTgCSM10MY=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIaNcKucX9+Kv8/UmBnls2hwsZnLF65Plcca6y0LPlX8/q
 zgfkTOjo5SFQYyLQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAEzkw3NGhh3NvT4B8qV73KUO
 V91+kfcnjb3jj4L8rNXHT2q9SDj1X5mR4dVnn77qeZtvLriWkFFgotIVblooeGyHVBL/Byktdxc NJgA=
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250716031814.2096113-46-ardb+git@google.com>
Subject: [PATCH v5 22/22] x86/boot: Get rid of the .head.text section
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


