Return-Path: <linux-efi+bounces-4486-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60144B1292F
	for <lists+linux-efi@lfdr.de>; Sat, 26 Jul 2025 08:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97F2E580125
	for <lists+linux-efi@lfdr.de>; Sat, 26 Jul 2025 06:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C97202F67;
	Sat, 26 Jul 2025 06:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fq2xnjNp"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419F528682;
	Sat, 26 Jul 2025 06:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753511239; cv=none; b=kFDc9yHOe/aM7eBxKJbp2vvZQR1q705ii/YQ4LHSVGmZ9u7lBPNCrv9y9RtR5dedGS22osOdJpmeEZ+NvIwkwd53AeZr5vt2Tv3+qDQdAlEaLXOivh7XCroS3F1T+k/2T5RYsQJMv03BBEeciVQhOFvF4xdTFTGTJK8Cd1QYaD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753511239; c=relaxed/simple;
	bh=LlIMTFVzXwdSlzjowza5NRuahl7DloIjtQs9FFDcY/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=foF31d4U2s2dtFf3urbsX1QONkjfhjzpLBwitga6igL8LZPHuRw+bPgr3m8T2sTMJH5c19H71m86Vqii0YoHd8k6oF3fZTk+bqBF42nEb0im9wz3FC9B78xY9nyFkrVPFrrPFpEA2zVzqZ1HJX2sggVpqA++f9IZXB+ez/ILHBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fq2xnjNp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7054C4CEED;
	Sat, 26 Jul 2025 06:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753511238;
	bh=LlIMTFVzXwdSlzjowza5NRuahl7DloIjtQs9FFDcY/Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fq2xnjNp2Rnf6iAlZuKY1DeL5Taz3Wd30zVOYss8rTdrQFYNsNc7QchDwyboJt8MO
	 GyBnduAMMlNsE8pFM+5ks4z6k6V1Q2RKNUvUebb8ez9Dk91IZbgcxkBTqATFe8mruT
	 F99Rn3HFLCaODcvN0/FwBjHEpq31Kn5eyDzW/dj5r5P0sUBxDUJYgOFUF2H+2OXMD+
	 b0uHv/EensaRP3baa7pQtYIuc8JXI/UQX+u/sHXMOJv7/rcSM6jN0iAiHQTQj5ULlP
	 XjDMcwoXUT3oMirM6oHEboAxIgl2XJlfJ7zAX534y/jxfcJsjtNnBZ1ScfFvhmh9Hi
	 n1Xg4NOsRzPeQ==
Date: Fri, 25 Jul 2025 23:27:18 -0700
From: Kees Cook <kees@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Gavin Shan <gshan@redhat.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	James Morse <james.morse@arm.com>,
	Oza Pawandeep <quic_poza@quicinc.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Mike Rapoport <rppt@kernel.org>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
	Hans de Goede <hansg@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
	Michal Wilczynski <michal.wilczynski@intel.com>,
	Juergen Gross <jgross@suse.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"Kirill A. Shutemov" <kas@kernel.org>,
	Roger Pau Monne <roger.pau@citrix.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Usama Arif <usama.arif@bytedance.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Thomas Huth <thuth@redhat.com>, Brian Gerst <brgerst@gmail.com>,
	Marco Elver <elver@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Hou Wenlong <houwenlong.hwl@antgroup.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Andy Lutomirski <luto@kernel.org>, Baoquan He <bhe@redhat.com>,
	Alexander Graf <graf@amazon.com>,
	Changyuan Lyu <changyuanl@google.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Jan Beulich <jbeulich@suse.com>, Boqun Feng <boqun.feng@gmail.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Bibo Mao <maobibo@loongson.cn>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, x86@kernel.org,
	kvm@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net,
	platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
	linux-mm@kvack.org, kasan-dev@googlegroups.com,
	linux-kbuild@vger.kernel.org, linux-hardening@vger.kernel.org,
	kexec@lists.infradead.org, linux-security-module@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH v4 0/4] stackleak: Support Clang stack depth tracking
Message-ID: <202507252322.8774CA6FCF@keescook>
References: <20250724054419.it.405-kees@kernel.org>
 <20250726004313.GA3650901@ax162>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250726004313.GA3650901@ax162>

On Fri, Jul 25, 2025 at 05:43:13PM -0700, Nathan Chancellor wrote:
> A few build issues that I see when building next-20250725, which seem
> related to this series.

AH! Thank you for letting me know!

> 1. I see
> 
>   ld.lld: error: undefined symbol: __sanitizer_cov_stack_depth
>   >>> referenced by atags_to_fdt.c
>   >>>               arch/arm/boot/compressed/atags_to_fdt.o:(atags_to_fdt)
>   make[5]: *** [arch/arm/boot/compressed/Makefile:152: arch/arm/boot/compressed/vmlinux] Error 1
> 
> when building ARCH=arm allmodconfig on next-20250725. The following diff appears to cure that one.

Ah-ha perfect. Yes, that matches what I was expecting to fix it, I was
just about to start working on it, but you beat me to it. :) The same
was reported here:
https://lore.kernel.org/all/CA+G9fYtBk8qnpWvoaFwymCx5s5i-5KXtPGpmf=_+UKJddCOnLA@mail.gmail.com

> 2. I see
> 
>   kernel/kstack_erase.c:168:2: warning: function with attribute 'no_caller_saved_registers' should only call a function with attribute 'no_caller_saved_registers' or be compiled with '-mgeneral-regs-only' [-Wexcessive-regsave]
> [...]
> when building ARCH=i386 allmodconfig.

Oh, hm, I will figure that out.

> 3. I see
> 
>   In file included from kernel/fork.c:96:
>   include/linux/kstack_erase.h:29:37: error: passing 'const struct task_struct *' to parameter of type 'struct task_struct *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
>      29 |         return (unsigned long)end_of_stack(tsk) + sizeof(unsigned long);
>         |                                            ^~~
>   include/linux/sched/task_stack.h:56:63: note: passing argument to parameter 'p' here
>      56 | static inline unsigned long *end_of_stack(struct task_struct *p)
>         |                                                               ^
> 
> when building ARCH=loongarch allmodconfig, which does not support
> CONFIG_THREAD_INFO_IN_TASK it seems.

Oh, eek. Yeah, I'll need to make an explicit dependency I guess? ("How
did this ever work?")

Thanks again!

-- 
Kees Cook

