Return-Path: <linux-efi+bounces-1877-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4970498CD46
	for <lists+linux-efi@lfdr.de>; Wed,  2 Oct 2024 08:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E160285F11
	for <lists+linux-efi@lfdr.de>; Wed,  2 Oct 2024 06:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E756212F38B;
	Wed,  2 Oct 2024 06:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=illinois-edu.20230601.gappssmtp.com header.i=@illinois-edu.20230601.gappssmtp.com header.b="JKraihz3"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-qv1-f67.google.com (mail-qv1-f67.google.com [209.85.219.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F307B84D12
	for <linux-efi@vger.kernel.org>; Wed,  2 Oct 2024 06:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727851389; cv=none; b=cWJOp9ytGGSCIzK65ph3gfZhc4e7CNenIDxyIEtL5jSFZO8ZTFWv1oQNqiSM4iSZJbb+ch1487BwXBFEStZCJiwHRac95TeHXp7zwOJ9pfQ5vlyxs9EURrddWBg8rU2t0V47sW/hD/S1HihVV6ooxRgoeGTHzKSN3COdajmoIQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727851389; c=relaxed/simple;
	bh=/u7ndM9PjegOZvGmdKHJOiXuqepu5JOIg5M63tk3noI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wv/9of6J01HbWjh2BAY4OV9w8Pf3vrIjY8x+xfxmKXtoli/qn6YWKZhO9P0tEg3IGbE/3Z3r4WV0oIxR2UVL9MA3WJjRdrNtMJ3G8FQw6BSQ3HurW5RGqY3chYqOcv+5S2D09IBqq8NKXjjQVYHO2fDHu2BqW4s1tFH2jc7c83A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=illinois.edu; spf=pass smtp.mailfrom=illinois.edu; dkim=pass (2048-bit key) header.d=illinois-edu.20230601.gappssmtp.com header.i=@illinois-edu.20230601.gappssmtp.com header.b=JKraihz3; arc=none smtp.client-ip=209.85.219.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=illinois.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=illinois.edu
Received: by mail-qv1-f67.google.com with SMTP id 6a1803df08f44-6cb2f271043so66617826d6.0
        for <linux-efi@vger.kernel.org>; Tue, 01 Oct 2024 23:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=illinois-edu.20230601.gappssmtp.com; s=20230601; t=1727851387; x=1728456187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/u7ndM9PjegOZvGmdKHJOiXuqepu5JOIg5M63tk3noI=;
        b=JKraihz301UgOSpZutsGx90b/pNGY8Fj04xgD0SRW5bjY+io2p19hDaXrjENH4ORwg
         UxySXvmuCTaIWG7YePez2eEdUWwLaOjblTSX4XQNbX7Me51QFDnDrKRwGyMg1Wnpj1vY
         NjhkIHLPAegFlg+iwSwIyvILzrhlzuE/S8kSce+Vow6JFAhVyeJroGxlGWG0AHzVMIvo
         Yb3Kz56spRjZmjAdK6i5Nv+09oaYKxlCkzcXTkGmdMEqCGryT3zpgJHbQRLUutRwzhtl
         lqwUuUfY0wtcXEkDc2acgTzyhE2Y/HPtAA8VJII5KY1RfY1ajSdF9U/TRQGeI0z5UPRt
         sxKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727851387; x=1728456187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/u7ndM9PjegOZvGmdKHJOiXuqepu5JOIg5M63tk3noI=;
        b=jhefnSWc4ZDb0zbIp+Xh+ioO7UePefgOCDRhwoJ66ccsNSrEi6deYb/+AlyjcNz0wS
         kXGypWCZXlnGsUqWYQyojucgCqKOzta94DHniyEDjPJHLWqx4SVMVHkcl+OMpRwfPzBI
         sJWdH7pMP92IUKPuPPtzn83UAGvn5C3p2OdK8bUtcEWzIhrbqJjwzWjC110NXG3+1umm
         pkvbcK7Tu3tQyYQTbC4CtbVzvs2DRTjsZ5J64omcYbXX5NyCMXw6O3mvhUCQFRId4uvP
         gj74MY+WRQ4jJD+Jr3Aha5RHCIvkUxO1QGkYmhRR71TKt9TpjpXIxwYtXg6AUsr+Y46f
         +tDw==
X-Forwarded-Encrypted: i=1; AJvYcCU08FJn2m6dvaFUIVXUQSB0nUJ3vY95aLmd1d4bWc5XD5UkUyf8GQLYHpeQPBwokfodgt6lQopKZg4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd+5K2EAFJNutkXjlXzCadDYtpcZ1i/f7r/hpM7sP5IBa7c6kG
	l2bEbfOnTqMkvRNYwJqQqCG3/3t0G6da2mpP0ohvPwDZT2ULnagm7qSHSSqufw==
X-Google-Smtp-Source: AGHT+IHrkRLceuVqxuW80Ei9nOewPBzqZcw30/kwrIYrc0giV5pzOirc+orj5fvwWApNas7yutkn3w==
X-Received: by 2002:a05:6214:3f86:b0:6cb:7fb1:2038 with SMTP id 6a1803df08f44-6cb81cc447emr31672946d6.53.1727851386930;
        Tue, 01 Oct 2024 23:43:06 -0700 (PDT)
Received: from shizuku.. ([2620:0:e00:550a:41e8:eb4:11eb:d3ce])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb3b6008efsm57077246d6.15.2024.10.01.23.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 23:43:06 -0700 (PDT)
From: Wentao Zhang <wentaoz5@illinois.edu>
To: nathan@kernel.org
Cc: Matt.Kelly2@boeing.com,
	akpm@linux-foundation.org,
	andrew.j.oppelt@boeing.com,
	anton.ivanov@cambridgegreys.com,
	ardb@kernel.org,
	arnd@arndb.de,
	bhelgaas@google.com,
	bp@alien8.de,
	chuck.wolber@boeing.com,
	dave.hansen@linux.intel.com,
	dvyukov@google.com,
	hpa@zytor.com,
	jinghao7@illinois.edu,
	johannes@sipsolutions.net,
	jpoimboe@kernel.org,
	justinstitt@google.com,
	kees@kernel.org,
	kent.overstreet@linux.dev,
	linux-arch@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-um@lists.infradead.org,
	llvm@lists.linux.dev,
	luto@kernel.org,
	marinov@illinois.edu,
	masahiroy@kernel.org,
	maskray@google.com,
	mathieu.desnoyers@efficios.com,
	matthew.l.weber3@boeing.com,
	mhiramat@kernel.org,
	mingo@redhat.com,
	morbo@google.com,
	ndesaulniers@google.com,
	oberpar@linux.ibm.com,
	paulmck@kernel.org,
	peterz@infradead.org,
	richard@nod.at,
	rostedt@goodmis.org,
	samitolvanen@google.com,
	samuel.sarkisian@boeing.com,
	steven.h.vanderleest@boeing.com,
	tglx@linutronix.de,
	tingxur@illinois.edu,
	tyxu@illinois.edu,
	wentaoz5@illinois.edu,
	x86@kernel.org
Subject: Re: [PATCH v2 0/4] Enable measuring the kernel's Source-based Code Coverage and MC/DC with Clang
Date: Wed,  2 Oct 2024 01:42:52 -0500
Message-Id: <20241002064252.41999-1-wentaoz5@illinois.edu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241002045347.GE555609@thelio-3990X>
References: <20241002045347.GE555609@thelio-3990X>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Nathan,

Thanks for all the comments!

On 2024-10-01 23:53, Nathan Chancellor wrote:
> Hi Wentao,
>
> I took this series for a spin on next-20241001 with LLVM 19.1.0 using a
> distribution configuration tailored for a local development VM using
> QEMU. You'll notice on the rebase for 6.12-rc1 but there is a small
> conflict in kernel/Makefile due to commit 0e8b67982b48 ("mm: move
> kernel/numa.c to mm/").
>
> I initially did the build on one of my test machines which has 16
> threads with 32GB of RAM and ld.lld got killed while linking vmlinux.o.
> Is your comment in the MC/DC patch "more memory is consumed if larger
> decisions are getting counted" relevant here or is that talking about
> runtime memory on the target device? I assume the latter but I figured I

Yes the build process (linking particularly) is quite memory-intensive if
the whole kernel is instrumented with source-based code coverage, no matter
it's with or without MC/DC. What you've observed is expected. (Although the
quoted message was referring to runtime overhead)

On the last slide of [8] I had some earlier data regarding full-kernel
build- and run-time overhead. In our GitHub Actions builds [9], I have
been keeping track of "/usr/bin/time -v make ..." output and the results
can be found in step => "4. Build the kernel" => "Print kernel build
resource usage". You may want to check them.

I am not aware of neat ways of alleviating this overhead fundamentally so I
would love any advice on it. And perhaps now the more recommended way of
using the proposed feature is to instrument and measure the kernel on a
per-component basis.

[8] https://lpc.events/event/18/contributions/1895/attachments/1643/3462/LPC'24%20Source%20based%20(short).pdf
[9] https://github.com/xlab-uiuc/linux-mcdc/actions

> would make sure. If not, it might be worth a comment somewhere that this
> can also require some heftier build resources possibly? If that is not

Sure.

> expected, I am happy to help look into why it is happening.
>
> I was able to successfully build that same configuration and setup with
> my primary workstation, which is much beefier. Unfortunately, the
> resulting kernel did not boot with my usual VM testing setup. I will see
> if I can narrow down a particular configuration option that causes this
> tomorrow because I did a test with defconfig +
> CONFIG_LLVM_COV_PROFILE_ALL and it booted fine. Perhaps some other
> option that is not compatible with this? I'll follow up with more
> information as I have it.

Good to hear that you've run it and thanks for reporting the booting issue.
You may send me the config if appropriate and I'll also take a look.

>
> On the integration front, I think the -mm tree, run by Andrew Morton,
> would probably be the best place to land this with Acks from the -tip
> folks for the x86 bits? Once the issue above has been understood, I
> think you can send v3 with any of the comments I made addressed and a
> potential fix for the above issue if necessary directly to him, instead
> of just on cc, so that it gets his attention. Other maintainers are free
> to argue that it should go through their trees instead but I think it
> would be good to decide on that sooner rather than later so this
> patchset is not stuck in limbo.

Yeah -mm tree sounds good to me. Let me work on v3 while we address the
booting issue and wait for others' opinions if any.

Thanks,
Wentao

>
> Cheers,
> Nathan

