Return-Path: <linux-efi+bounces-1797-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD07E986242
	for <lists+linux-efi@lfdr.de>; Wed, 25 Sep 2024 17:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 771CE28A741
	for <lists+linux-efi@lfdr.de>; Wed, 25 Sep 2024 15:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16D182488;
	Wed, 25 Sep 2024 15:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yEqqSHTi"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFB347F46
	for <linux-efi@vger.kernel.org>; Wed, 25 Sep 2024 15:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727276516; cv=none; b=p52BB6NT7A2CoP3L+S3Gq1t+skYsjaGfGqBTylBpmVTZzR79Q+yhyRRCVxcDnBO8RpC+pZU8g7xqQ/yonwDwu9WLZnwcWoPnxx/kkIPRn8x1AOtadjhDVktwkPsD+6xpYEYEZYj9m704dhF/qA0jJQcatqiz48YcOIaudH/rA00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727276516; c=relaxed/simple;
	bh=7J0jWEjwrexzo9oPbBgZ33ZQC1xyFpo8+XmzUWJ/VHg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=B9MJTeGCFvfQVnG5dJlG0rb6FtvC7XBabX7czZ3zkdOC/uwUZ+Z2rO1tSPP/LYCrAJSMDIYUWgpxzPfHMI8o1YEF0jJKV3sCeMIN/3oLniW6EkAczvzcEXhGw/3g7+MMGxQvGlGqbfTV8lVOsXf2cVwMmLuGQFSObn3w4MtKHzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yEqqSHTi; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-42cb080ab53so45816415e9.0
        for <linux-efi@vger.kernel.org>; Wed, 25 Sep 2024 08:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727276512; x=1727881312; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bvHrMBM7osvq1YNoyXkrrTpmrTIb8bNW96uzrIXNQu8=;
        b=yEqqSHTileV8mRFw/uWhSlHf8HPvgLYHAzC0BoLZiiRPC+JG3TnSCk/wzr0FcVCQ4C
         u1wy8geYYzk+k4fHyl0oA//q+pNRtKEVT0HoK/m1g7ACiBEhqCqS7nfz/jBUWb10ZUrv
         gQHVZ3OYRmXq4n1p6xDqyQVOury3bDN40Tm7ZUTsfao/pHE9eY6s3wdLgrHqAipLGuHU
         HazsPfuHo6iAIwTZzdr3uqUJRMvzHVWSm9Mtyt29amKKtthr4fq4j66MH5FvyNglmzG5
         PANRA3J72y8uR8mXzuGElRpueMNhdk3AB8ci0000K0KiLGQ3Pdy3CtmRJ5FM1N7rpZGA
         SXtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727276512; x=1727881312;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bvHrMBM7osvq1YNoyXkrrTpmrTIb8bNW96uzrIXNQu8=;
        b=nUbEoeF1nX1xWHy6hr3rtZXapHUKAe3PH12iNR+LBGhApCIURlCoOWFq1K/Kj9y29a
         NeC1/ZhHNJZN2FloDRwqAuPQpF/6bbfwTvhAKMQQ1AiP+u8hM/lOWO+Lpf7Se4bFHyfy
         lDDyFTDqFZ8N8qTCnmZ/H6KREwZh9Mh/gWb68oatfiPioqiApe1vpB+B75/wR3+fGUhj
         zlFe3hiSk9CBXwprH/92iJyfb6KcawgkxQ1M6LY0+AsA19Y/XGBjljtZ2x4kI40wJ3O9
         drCXOyxKqLmdNZiW/0P7lo40oOrAi0k9EoCh4uu7V3Pkiyqr3pJOAPMEbDcRni0cd/J3
         bL2A==
X-Forwarded-Encrypted: i=1; AJvYcCU/cHxbqsOU+oGe7lxlXfCi09HMFRLhH3xc6CfKqOmcbAUhLnamFq9wYN6FBCIU2/RSnAAAbwXlGSs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYZsPpZx7kFWXHfy404ItXIlNQ+3htj8VqzmaN7gbSFRZvstp5
	nvbg/Be+dntpi6KYb0T3wdBkROuoIuVCOpMisvrwYmga9wl5dukD9/vR1vz+nOGgdhhH7A==
X-Google-Smtp-Source: AGHT+IGNEZwim//wtoUQ0IgEwXQAmuWMXuvjVNrkXztiUbXuSVle0sf2azOpfGly/wGUuNh4kSi9g764
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:7b:198d:ac11:8138])
 (user=ardb job=sendgmr) by 2002:a05:600c:4b23:b0:42c:b635:9ba7 with SMTP id
 5b1f17b1804b1-42e961449f9mr294105e9.3.1727276511763; Wed, 25 Sep 2024
 08:01:51 -0700 (PDT)
Date: Wed, 25 Sep 2024 17:01:01 +0200
In-Reply-To: <20240925150059.3955569-30-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240925150059.3955569-30-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1383; i=ardb@kernel.org;
 h=from:subject; bh=kkus52hb+9U3rGqLGvcTtWiqi7ULiH1wdI2hpFI7/9I=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIe2L6loPG1eTz6/TRZ+ExF55v9yoPVaMz0DJP05TXvNix
 3yvWS87SlkYxDgYZMUUWQRm/3238/REqVrnWbIwc1iZQIYwcHEKwER0vzAyLNdk+Hf0DcN93e0c
 kou2iV0ReKfEPrsn3ORh04fsoM3R+gz/0yZt5ne4cnJFldTMQpGfLor75ZYczDujFLCs+4iee6Q pMwA=
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
Message-ID: <20240925150059.3955569-31-ardb+git@google.com>
Subject: [RFC PATCH 01/28] x86/pvh: Call C code via the kernel virtual mapping
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Uros Bizjak <ubizjak@gmail.com>, 
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Juergen Gross <jgross@suse.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Masahiro Yamada <masahiroy@kernel.org>, Kees Cook <kees@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Keith Packard <keithp@keithp.com>, 
	Justin Stitt <justinstitt@google.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-doc@vger.kernel.org, 
	linux-pm@vger.kernel.org, kvm@vger.kernel.org, xen-devel@lists.xenproject.org, 
	linux-efi@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-sparse@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Calling C code via a different mapping than it was linked at is
problematic, because the compiler assumes that RIP-relative and absolute
symbol references are interchangeable. GCC in particular may use
RIP-relative per-CPU variable references even when not using -fpic.

So call xen_prepare_pvh() via its kernel virtual mapping on x86_64, so
that those RIP-relative references produce the correct values. This
matches the pre-existing behavior for i386, which also invokes
xen_prepare_pvh() via the kernel virtual mapping before invoking
startup_32 with paging disabled again.

Fixes: 7243b93345f7 ("xen/pvh: Bootstrap PVH guest")
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/platform/pvh/head.S | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/platform/pvh/head.S b/arch/x86/platform/pvh/head.S
index f7235ef87bc3..a308b79a887c 100644
--- a/arch/x86/platform/pvh/head.S
+++ b/arch/x86/platform/pvh/head.S
@@ -101,7 +101,11 @@ SYM_CODE_START_LOCAL(pvh_start_xen)
 	xor %edx, %edx
 	wrmsr
 
-	call xen_prepare_pvh
+	/* Call xen_prepare_pvh() via the kernel virtual mapping */
+	leaq xen_prepare_pvh(%rip), %rax
+	addq $__START_KERNEL_map, %rax
+	ANNOTATE_RETPOLINE_SAFE
+	call *%rax
 
 	/* startup_64 expects boot_params in %rsi. */
 	mov $_pa(pvh_bootparams), %rsi
-- 
2.46.0.792.g87dc391469-goog


