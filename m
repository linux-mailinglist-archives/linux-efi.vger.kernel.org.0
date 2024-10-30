Return-Path: <linux-efi+bounces-2062-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20BBC9B5D0A
	for <lists+linux-efi@lfdr.de>; Wed, 30 Oct 2024 08:37:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D33F4284280
	for <lists+linux-efi@lfdr.de>; Wed, 30 Oct 2024 07:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC76B1E0E0F;
	Wed, 30 Oct 2024 07:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bomLUd2e"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB2485931;
	Wed, 30 Oct 2024 07:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730273810; cv=none; b=Onp5kBdtbOY4Ibr9w9yRJrHkE6du5jRzEndApUVGxzCOvfVIIYOI6ZoYsGIPlZ4lKP5bNLvFRGSwAbbq7bMc7+ik207WBfpp46DTdF6RIGf/iQ1pYsIO+4Dv7/Qa4xvzrh1yOr/xiOfpEfpFC+L6tn0eJXPBKXTfIHDPuC2dlM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730273810; c=relaxed/simple;
	bh=JcuajlUbi+mLKwNDmwNSmyG+iuUggDWRZn1C/kccl3o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LBtjf0x+xfKuBN8mMk1I+9e7mtuOjzJGqA4wZmCeEJSi9wx/xJCn4iC9QYaWw6XCsxUc8A7fUG0/JD1gSKtRans6NoeE61yiLjYSLfA7UpTTz8ZC+ev6x/6A9w+kFnOSGOnaOO1LrfUpUG7Bui+ROp152zrBByrae1FsMcl3fpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bomLUd2e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A977C4CEFF;
	Wed, 30 Oct 2024 07:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730273810;
	bh=JcuajlUbi+mLKwNDmwNSmyG+iuUggDWRZn1C/kccl3o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bomLUd2eL2qsGYNJMaiDyjIJSzXzwXcI0nDPZ+e2kNBnxpqyydUDDgAlJMxOV1GrF
	 8D/BzeEApRrF9rsa5N63Dr/u0YRyxyswxVyYFt6nlf/EcD7haJ6oaQRB6QQiCNmzNL
	 kpyddBVNFgmyBHDYeUW13yALL52ApNPf7fABxxat4VH0uRti/MISXgqRZuGSWXyu+U
	 Qg4VDfkox2IiQdUoD6RCMt5uIsqRxFjzqHyjyd7mAlTYxPOthtK+KqxywpQztXRa96
	 +cBeKFj9VAFyzVEUSM8BCEbMW9wht/m1Y2i13idOFlR/10wbmr4ilUCq/A/apDmec5
	 CqJ3xHFH++2Ww==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2fb388e64b0so62273391fa.0;
        Wed, 30 Oct 2024 00:36:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUJhBvmtnfFS2BiZ2EC8dloac6q3kwuvEwtB8PwYPZe9Q15jkor0u/Z0twa69+OObOa4cNLagqs/4Q=@vger.kernel.org, AJvYcCWKbX9YeW594tFyshXPLElxw1LXA9rtAPG/wexfJ4j4lKDjxEwljhw4Ekw89scPhnnhjmHAvd6FpSC/@vger.kernel.org, AJvYcCX19swX3LSOsTuxwuOBlfNllCZxnahHVArZkVymFccAZXV4j91PiyE+zZuv/paI1Dp8OH2NH4vhhsd7gWU1@vger.kernel.org
X-Gm-Message-State: AOJu0YwU8Jfu0ziOZPUnzJio3JJ/AfrT0T3sigEa4uQKeuUAiAdj9yQU
	JAw4kVnZGkHj3IQEx/gQz+XpaIFjQhn7MNjxMAT1KOffJeTs4L6rLUedtjd9S9ZRv0+vBvqyV+D
	1V0a9hcbKujBZoM2E65m+Du1dizo=
X-Google-Smtp-Source: AGHT+IHEC1owlVvHeaDQCyHThIjPcHIWQqcLRHMiPQPGFvES+bevgKgmXGlSOSrzrpZSmW6ivspNh3kKshYRDPTi/yU=
X-Received: by 2002:a2e:a99b:0:b0:2fb:5bb8:7c00 with SMTP id
 38308e7fff4ca-2fd058fb962mr12759191fa.2.1730273807953; Wed, 30 Oct 2024
 00:36:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028160917.1380714-1-alexander.shishkin@linux.intel.com> <20241028160917.1380714-5-alexander.shishkin@linux.intel.com>
In-Reply-To: <20241028160917.1380714-5-alexander.shishkin@linux.intel.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 30 Oct 2024 08:36:36 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEYHWvyDgTpxa_Afu0dGjEh03G-RT-N0BwUr=Vyb=ATJQ@mail.gmail.com>
Message-ID: <CAMj1kXEYHWvyDgTpxa_Afu0dGjEh03G-RT-N0BwUr=Vyb=ATJQ@mail.gmail.com>
Subject: Re: [PATCH v5 04/16] init/main.c: Move EFI runtime service
 initialization to x86/cpu
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Xiongwei Song <xiongwei.song@windriver.com>, Xin Li <xin3.li@intel.com>, 
	"Mike Rapoport (IBM)" <rppt@kernel.org>, Brijesh Singh <brijesh.singh@amd.com>, 
	Michael Roth <michael.roth@amd.com>, Tony Luck <tony.luck@intel.com>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Alexey Kardashevskiy <aik@amd.com>, 
	Jonathan Corbet <corbet@lwn.net>, Sohil Mehta <sohil.mehta@intel.com>, Ingo Molnar <mingo@kernel.org>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	Daniel Sneddon <daniel.sneddon@linux.intel.com>, Kai Huang <kai.huang@intel.com>, 
	Sandipan Das <sandipan.das@amd.com>, Breno Leitao <leitao@debian.org>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Alexei Starovoitov <ast@kernel.org>, 
	Hou Tao <houtao1@huawei.com>, Juergen Gross <jgross@suse.com>, 
	Vegard Nossum <vegard.nossum@oracle.com>, Kees Cook <kees@kernel.org>, 
	Eric Biggers <ebiggers@google.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Yuntao Wang <ytcoode@gmail.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Tejun Heo <tj@kernel.org>, Changbin Du <changbin.du@huawei.com>, 
	Huang Shijie <shijie@os.amperecomputing.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Namhyung Kim <namhyung@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@redhat.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 28 Oct 2024 at 17:10, Alexander Shishkin
<alexander.shishkin@linux.intel.com> wrote:
>
> The EFI call in start_kernel() is guarded by #ifdef CONFIG_X86. Move
> the thing to the arch_cpu_finalize_init() path on x86 and get rid of
> the #ifdef in start_kernel().
>
> No functional change intended.
>
> Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Suggested-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  arch/x86/kernel/cpu/common.c | 7 +++++++
>  init/main.c                  | 5 -----
>  2 files changed, 7 insertions(+), 5 deletions(-)
>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index 8f41ab219cf1..b24ad418536e 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -26,6 +26,7 @@
>  #include <linux/pgtable.h>
>  #include <linux/stackprotector.h>
>  #include <linux/utsname.h>
> +#include <linux/efi.h>
>
>  #include <asm/alternative.h>
>  #include <asm/cmdline.h>
> @@ -2382,6 +2383,12 @@ void __init arch_cpu_finalize_init(void)
>         fpu__init_system();
>         fpu__init_cpu();
>
> +       /*
> +        * This needs to follow the FPU initializtion, since EFI depends on it.
> +        */
> +       if (efi_enabled(EFI_RUNTIME_SERVICES))
> +               efi_enter_virtual_mode();
> +
>         /*
>          * Ensure that access to the per CPU representation has the initial
>          * boot CPU configuration.
> diff --git a/init/main.c b/init/main.c
> index c4778edae797..1d3a0a82d136 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -51,7 +51,6 @@
>  #include <linux/cpu.h>
>  #include <linux/cpuset.h>
>  #include <linux/cgroup.h>
> -#include <linux/efi.h>
>  #include <linux/tick.h>
>  #include <linux/sched/isolation.h>
>  #include <linux/interrupt.h>
> @@ -1072,10 +1071,6 @@ void start_kernel(void)
>
>         pid_idr_init();
>         anon_vma_init();
> -#ifdef CONFIG_X86
> -       if (efi_enabled(EFI_RUNTIME_SERVICES))
> -               efi_enter_virtual_mode();
> -#endif
>         thread_stack_cache_init();
>         cred_init();
>         fork_init();
> --
> 2.45.2
>

