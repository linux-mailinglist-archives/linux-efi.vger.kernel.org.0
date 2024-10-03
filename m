Return-Path: <linux-efi+bounces-1892-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C5DD98E8C1
	for <lists+linux-efi@lfdr.de>; Thu,  3 Oct 2024 05:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80FC31C23BF4
	for <lists+linux-efi@lfdr.de>; Thu,  3 Oct 2024 03:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FFF928370;
	Thu,  3 Oct 2024 03:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=illinois-edu.20230601.gappssmtp.com header.i=@illinois-edu.20230601.gappssmtp.com header.b="RyXLRa78"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-qk1-f196.google.com (mail-qk1-f196.google.com [209.85.222.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636571DFFB
	for <linux-efi@vger.kernel.org>; Thu,  3 Oct 2024 03:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727925277; cv=none; b=UC7ynYLaiOWHEivpfabdXp9IfwGqJnsNoi0nea/epT3KzteR8uRlKyt9sLu8f6eqtI3NLVrsuTujV4QZvajI11bXQD5Lbfj8hiX4+1/ljqdtjerH6vOFSfHeV5xPqnl/BINJHpZUNFgNMIVWgvRTHTaNrXCWGJwZ+TfKvQlSi+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727925277; c=relaxed/simple;
	bh=jKTsXBcNO/miLEA0jRPsm6kZWhLrFZu0gIUjdZSMDbU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n4lPQsOm66TuK4EbklH1JfHdBAgQswIvmI7jcBSy5ee3tsb4LoWAv89664MEz+HwgboZMkoMroaVYAaR9RuKnngnMtxTi3yNQIEvKwrVhyCBWTXYVK8CYheE5hs57mzUHmF2u3cWgKbRWPCC3ZUZ9SYqCtUXkqa8Y01Zk43eIbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=illinois.edu; spf=pass smtp.mailfrom=illinois.edu; dkim=pass (2048-bit key) header.d=illinois-edu.20230601.gappssmtp.com header.i=@illinois-edu.20230601.gappssmtp.com header.b=RyXLRa78; arc=none smtp.client-ip=209.85.222.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=illinois.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=illinois.edu
Received: by mail-qk1-f196.google.com with SMTP id af79cd13be357-7a99d23e036so51501185a.1
        for <linux-efi@vger.kernel.org>; Wed, 02 Oct 2024 20:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=illinois-edu.20230601.gappssmtp.com; s=20230601; t=1727925273; x=1728530073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bVmdUELTDUmyOs2T634ZSBxOSroRBta42gzygmF21tA=;
        b=RyXLRa78Q/eUKVFYaCd/tclyx2QoGYtdKAWCcsWRR6dzm7b41l2xPTm5P7T956sBBF
         nomdJJTM2c2cWkzgx7H2BuSC53CfNHXb5mU8Du/PI0eWQcQmUEPGKHbPnVozxK8EpL2V
         l8SmMhBnEoX7M1G93ie3ItkT35qaElp6afhfiw2doDr/beM8PfMU4ZmHBWDkN1GW/BL1
         Xf50p5mctT7HynzQ3AHeDwz6k9g1IANORPLevVN6wF+0bey0nN0m43kSNgPLiSVDTJQY
         5IU0fjKtSfW+Tgz09cKaAi5/0+JEkES1Hfjf8uoX/UZ21aIWEDGwcZnt7RVlcH57WjH3
         lzOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727925273; x=1728530073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bVmdUELTDUmyOs2T634ZSBxOSroRBta42gzygmF21tA=;
        b=hO06n0VDcE6ToNPR15wxAkDyocYY4E0n7XriTQw+GKJ0QwvCajHohKhJMmhe6NoaRz
         1hzrYepP/a+EV8J69z3dfgF4FnsNFgqTMl4qIWKi4fiHJsjz7DPJK0rxe5kV+sQApEaz
         K/AahnLf5tF6Fn82kI+JBSf7DiJRNZzVKoQfAX5b5DhNv2X5uNTolwLB+1raTawWbm98
         3Lqb/XWi/6bNS+60syPtp8tSfdQqm5su/r6NMoMJ4mAQV7C/6n5iohAR5ltBrvZ/nCe+
         vUjI0nRmcO2UbQK6cTdMjHGzDHVfl7NCp7sbat9njjU16o3ZxszE/LMAKC1ihrxvKWhW
         geSg==
X-Forwarded-Encrypted: i=1; AJvYcCXsExxZGrbRmq00vFFs5KexdPH8SrvZ9ZQZ1KwQSkRHfsWmH42Y0Ay0ErMY/z2ueX+Y81V9J3csmDs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAZQ95kB4YcZmxNGQsvy6kRfduMvu20JZB9SnH92Odwi+noGF8
	qzzqENZtX0s/vRCnW61Mem4CvL1soHcah3FAl6osBZT4PKCYXexFZX+iBAoWtQ==
X-Google-Smtp-Source: AGHT+IHyjSRkhjgcIpyEOBBu1F4Ot9eDMUivzJG0kRwm+KN8Ac30ciJk502QH5kn26uBubpxXFT/Wg==
X-Received: by 2002:a05:620a:1923:b0:7a9:a63a:9f48 with SMTP id af79cd13be357-7ae626ac34dmr793486485a.11.1727925273322;
        Wed, 02 Oct 2024 20:14:33 -0700 (PDT)
Received: from shizuku.. ([2620:0:e00:550a:6782:866c:334a:d5e9])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae6b29e2c9sm6901385a.15.2024.10.02.20.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 20:14:33 -0700 (PDT)
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
Subject: Re: [PATCH v2 2/4] llvm-cov: add Clang's MC/DC support
Date: Wed,  2 Oct 2024 22:14:29 -0500
Message-Id: <20241003031429.46276-1-wentaoz5@illinois.edu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241002011030.GB555609@thelio-3990X>
References: <20241002011030.GB555609@thelio-3990X>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Nathan,

Thanks for your review! See some of my responses below inline. Other
comments, including those to [1/4] and [4/4], are acknowledged and will be
updated in v3.

On 2024-10-01 20:10, Nathan Chancellor wrote:
> ...
> > maximum value supported by Clang is 32767. According to local experiments,
> > the working maximum for Linux kernel is 46, with the largest decisions in
> > kernel codebase (with 47 conditions, as of v6.11) excluded, otherwise the
> > kernel image size limit will be exceeded. The largest decisions in kernel
> > are contributed for example by macros checking CPUID.
> > 
> > Code exceeding LLVM_COV_KERNEL_MCDC_MAX_CONDITIONS will produce compiler
> > warnings.
> > 
> > As of LLVM 19, certain expressions are still not covered, and will produce
> > build warnings when they are encountered:
> > 
> > "[...] if a boolean expression is embedded in the nest of another boolean
> >  expression but separated by a non-logical operator, this is also not
> >  supported. For example, in x = (a && b && c && func(d && f)), the d && f
> >  case starts a new boolean expression that is separated from the other
> >  conditions by the operator func(). When this is encountered, a warning
> >  will be generated and the boolean expression will not be
> >  instrumented." [4]
> 
> These two sets of warnings appear to be pretty noisy in my build
> testing... Is there any way to shut them up? Perhaps it is good for

These two warnings are currently implemented as custom diagnostic in
clang/lib/CodeGen/CodeGenPGO.cpp:dataTraverseStmtPost. So I'm afraid there
is no corresponding "-W[no-]xxx" flag at this moment. I agree such switches
would be desirable but we might have to nudge this in LLVM community.

> users to see these limitations but it basically makes the build output
> useless. If there were switches, then they could be disabled in the
> default case with a Kconfig option to turn them on if the user is
> concerned with seeing which parts of their code are not instrumented. I
> could see developers wanting to run this for writing tests and they
> might not care about this as much as someone else might.
> 
> I did leave LLVM_COV_KERNEL_MCDC_MAX_CONDITIONS at its default value.
> Perhaps there is a more reasonable default that would result in less
> noisy build output but not run afoul of potential memory usage concerns?
> I assume that mention means that memory usage may be a concern for the
> type of deployments this technology would commonly be used with?

To my own experiences, enlarging this threshold won't really help with the
issue, because the other type of warning ("nested boolean") is even more
prevalent in kernel codebase. I once built the kernel serially and counted
the number of instances from the gigantic log:

  unsupported number of conditions (>6): 837
  unsupported nested boolean:            8029

So again we should probably improve this on the tool side. I can talk to
developers there separately.

> ...
> > diff --git a/Makefile b/Makefile
> > index 51498134c..1185b38d6 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -740,6 +740,12 @@ all: vmlinux
> >  CFLAGS_LLVM_COV := -fprofile-instr-generate -fcoverage-mapping
> >  export CFLAGS_LLVM_COV
> >  
> > +CFLAGS_LLVM_COV_MCDC := -fcoverage-mcdc
> > +ifdef CONFIG_LLVM_COV_KERNEL_MCDC_MAX_CONDITIONS
> > +CFLAGS_LLVM_COV_MCDC += -Xclang -fmcdc-max-conditions=$(CONFIG_LLVM_COV_KERNEL_MCDC_MAX_CONDITIONS)
> 
> Why is -Xclang needed here? Is this not a full frontend flag?

"-fmcdc-max-conditions" is a cc1 option only, while "-fcoverage-mcdc" is
both a cc1 option and a clang option. See llvm/llvm-project#82448 and their
changes to clang/include/clang/Driver/Options.td.

Thanks,
Wentao

> 
> > +endif
> > +export CFLAGS_LLVM_COV_MCDC
> > +
> >  CFLAGS_GCOV	:= -fprofile-arcs -ftest-coverage
> >  ifdef CONFIG_CC_IS_GCC
> >  CFLAGS_GCOV	+= -fno-tree-loop-im

