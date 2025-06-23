Return-Path: <linux-efi+bounces-3917-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C72AE4AC9
	for <lists+linux-efi@lfdr.de>; Mon, 23 Jun 2025 18:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82EC0174756
	for <lists+linux-efi@lfdr.de>; Mon, 23 Jun 2025 16:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1FC28CF6D;
	Mon, 23 Jun 2025 16:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OhIi8qbv"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151D52D29B1;
	Mon, 23 Jun 2025 16:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750695545; cv=none; b=gEfZq0WOsJdfeWqP6E7W+KAnEXA1+ffNDIY92BT/HK2q9b7Mb6i7/v+uVu9zqCPQxoe0HBUV8yz9vg4jdbIy1dvZQQyTziHMNc6UHFGUjlgAThdrI9mJBkW37SBkxrk7+JuKzKUuxxHDIVknxsiE9f7G/N7Mlj9W32HP0J7ywt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750695545; c=relaxed/simple;
	bh=bJeI13UOBy2+tAGnslx3UMPJTEgbJ0XaXFZ2738ja9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A3VzNeXAjRLPYR28ykrqJA76Yg1mylwMw+gXfDaLct8tT6aBBncJHdF8q0zy0VLkewVxTO3Va8gUKFcdPmoFZV5aVfc9V8SzjYMcLYJEkC2C4S8od1Owz/ugWR1eBNpvs8IAVxNfvgFqSE8qeyG1dybW9bYVYX8dbX98dRf1FBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OhIi8qbv; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-441ab63a415so46433535e9.3;
        Mon, 23 Jun 2025 09:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750695542; x=1751300342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+tpOC8J9R9fSt7hQyUzw01Amv/SyWf6vMX3xdtAovfw=;
        b=OhIi8qbvRlt7og2gfT1ORU+GTIsR8Jig2tiHmsXlp+6UD8CbDhQkAORML6gnek038M
         EYmaqHr31bmoCo09Uwb+plPJOwp+RL7q+WSbmswNoSn3fz0i7AVhx62ohPyRsdfF0btU
         r6n/kjtBTkqtWKMvTdvJ0Bv/aPFWVDfuROTjN8f9BXlhRrCQz0hs3Qf+MDTroVnkDs+h
         WMaQcKRTnE7efiuBDMm6wpGGFEapqJhYlfQYih5tKxb2egeCo/tQxdTIofGaIyHN/7wj
         XLooahR74GpELPnCvl52g7WoFz9MwL6VPCmkKS5WGT0qjuZS14JKVJSJKxNRs7K93sgV
         6xzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750695542; x=1751300342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+tpOC8J9R9fSt7hQyUzw01Amv/SyWf6vMX3xdtAovfw=;
        b=m4C/AzUvMsbKEhb6ewbPU+hA/PlRBY8KGvl09L1vEpTE6m6Bn5SpOUV/vc7R5GQ+K+
         dncOhAoctxLDvIPxZAonOHz5Bj4mD/uXlhSaow4sRo9nld8C0PsV91c6ZXUhT49vR0c7
         a4wy1ukPUhj+dOY0YSHtOYr/rBh3mj9F1rgit0uDk84Reb17WKEYBa8TN111ZaPbEl44
         aAIzp+LhN24f0BogCDKASbBQzGrCemW35EWa8jMhUIQPLd3BKjGSb3RqMSR4ucYfDPpo
         EYeq8DT6Ylz191aqKGb+feiYqoZ2eNclnpHMhmOxBz8kiAzRMauSTGOZdvfVtBpd3UJ6
         xu2A==
X-Forwarded-Encrypted: i=1; AJvYcCVyZjvOaPIcahlX2o1dJ+QsNIe4KRUO7oYRz2ui+SYfEkogb/19hILQ6QkcjTloq9nt/6oHOYHf36k=@vger.kernel.org, AJvYcCW2yUmfzOfD6z0x0deEoq/ylR0AT3sEzOf45e0B40AzpcYc+kDizjm3geTXRHxtK1rQ0sDmh4XoJIoy6pV5@vger.kernel.org
X-Gm-Message-State: AOJu0YwSdVvfV/UwmaQYMsu7io9CmWFzwpUl+QXO8mtJiFIQkTwvDs9C
	koaMVrzI1NMgXVW5ij6r/Op+/WbnhUSpJusvGKOtvheeYATvHY0o7b/r
X-Gm-Gg: ASbGncshAhOUTaKnK9qRF1oUKPjhp9WU4r+GBNnV7HdcBjKUNntpb8mNeCcjxtrWtVQ
	ek4UOJOGQYsTpyja2x9SZYhbTqbEioh2riL3iAD1H+K8C4FJ9svVIYnTbp087edgt2NYDXLZwe3
	62gwTMB3Ab6ohfk/qrTYaOCfIwjiy2CUVG94jD2+1Em6U0LM/JTtmIL5ujrvlyRszLGpirY4gvq
	yybTucKgZwIWJ4CE8lcENwaxJaRQqzGSUc1R04nCTVuvU2HSpqsvx9ODwZAO/1C3lZ1agXY0kRe
	P8yLLj/u+0IZTeVEF6LtiITaClaN+dlPJ0/GlsrJ07EbsXb8M2gubxo/+eEhd8s/3VpLHDcfa5a
	m
X-Google-Smtp-Source: AGHT+IHW1KS6DZgszV8TRKavm2+rGnxthAJy2Y+zJYOtYLaIKnoNeYWITRi9v5gVHXPt24t3FM2Q2w==
X-Received: by 2002:a05:600c:4684:b0:453:d3d:d9fd with SMTP id 5b1f17b1804b1-453654cb7cdmr136417035e9.12.1750695541894;
        Mon, 23 Jun 2025 09:19:01 -0700 (PDT)
Received: from localhost.localdomain ([41.79.198.24])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453646d7fe5sm113817985e9.16.2025.06.23.09.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 09:19:01 -0700 (PDT)
From: Khalid Ali <khaliidcaliy@gmail.com>
X-Google-Original-From: Khalid Ali <khaliidcaliy@gmail.com
To: hpa@zytor.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	ubizjak@gmail.com
Cc: x86@kernel.org,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re:[PATCH v1 1/3] Recieve boot_param from RDI Instead of RSI
Date: Mon, 23 Jun 2025 16:16:56 +0000
Message-ID: <20250623161741.623-1-khaliidcaliy@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <2D63735B-FA76-428E-8F68-8EBCAEA0985E@zytor.com>
References: 
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> On June 23, 2025 1:15:23 AM PDT, Khalid Ali <khaliidcaliy@gmail.com> wrote:
> >From: Khalid Ali <khaliidcaliy@gmail.com>
> >
> >Adjust the kernel entry point to recieve arguments from RDI instead of
> >RSI.
> >
> >Signed-off-by: Khalid Ali <khaliidcaliy@gmail.com>
> >---
> > arch/x86/kernel/head_64.S | 4 ++--
> > 1 file changed, 2 insertions(+), 2 deletions(-)
> >
> >diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
> >index dfb5390e5c9a..d24fea15b6a6 100644
> >--- a/arch/x86/kernel/head_64.S
> >+++ b/arch/x86/kernel/head_64.S
> >@@ -43,7 +43,7 @@ SYM_CODE_START_NOALIGN(startup_64)
> >        * for us.  These identity mapped page tables map all of the
> >        * kernel pages and possibly all of memory.
> >        *
> >-       * %RSI holds the physical address of the boot_params structure
> >+       * %RDI holds the physical address of the boot_params structure
> >        * provided by the bootloader. Preserve it in %R15 so C function calls
> >        * will not clobber it.
> >        *
> >@@ -56,7 +56,7 @@ SYM_CODE_START_NOALIGN(startup_64)
> >        * compiled to run at we first fixup the physical addresses in our page
> >        * tables and then reload them.
> >        */
> >-      mov     %rsi, %r15
> >+      mov     %rdi, %r15
> >
> >       /* Set up the stack for verify_cpu() */
> >       leaq    __top_init_kernel_stack(%rip), %rsp

> This is an ABI.
>
> Nacked-by: H. Peter Anvin <hpa@zytor.com>

Peter, thanks for the response but if i ask you:
What is specific reason that this patch is wrong?
Why used RSI instead of RDI at the first place?

I broke my patch reference and it became stand alone each one, however this is one of three series. 
This makes the entry more ABI complaint, if there is no specific reason of objection.

Thanks

