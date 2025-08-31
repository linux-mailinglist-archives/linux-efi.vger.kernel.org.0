Return-Path: <linux-efi+bounces-4662-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7E1B3D383
	for <lists+linux-efi@lfdr.de>; Sun, 31 Aug 2025 15:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58CB11656F3
	for <lists+linux-efi@lfdr.de>; Sun, 31 Aug 2025 13:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB773253F3A;
	Sun, 31 Aug 2025 13:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pF5Qlp0y"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8385513C3CD;
	Sun, 31 Aug 2025 13:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756645877; cv=none; b=QoPZHI7Ra0Rd/JMdlECReyo26dbADfWlHw+o6FoVTq4oAK0Bi6UinR2iuLdUva1KMwVLqIl3xzB8iR8OboYGsEYv4ZPI6c3cYnkZrRcTzR0I6nkayahLIXtNmt8PuBVwCp/M2p7AVczqB1x6iCk9I5qyjoOl69nKSVLVeJTibkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756645877; c=relaxed/simple;
	bh=KyNp6YyWobDLk1CURhcnhqzmpd1iXHtcZgiYjLdBy1U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LdoZc2heYlrdko+/GBFRFVBunBXLnp2b7e9hUrBtMw/zDMOjzU7SIrAcDUc2ibu+Wheqbv9d7K5D+pqul7Uqp2NF6hd/xLQmi9PLY1OzVMarTgCg/R2PEhpqpVfDJw9cas+Hislth5Cq33CfOeRe1kuG8mKUtU3uPtMu/RzrWwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pF5Qlp0y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00575C4CEED;
	Sun, 31 Aug 2025 13:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756645877;
	bh=KyNp6YyWobDLk1CURhcnhqzmpd1iXHtcZgiYjLdBy1U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pF5Qlp0yPSr5eMhdJz06WdUTqhpsOzTivUEDPEtVR+ANjI5D9iI1xgLsnvtex+38t
	 MWxME8FtIeYfEvBjqSPpHRineM37+YbRCTAJGn4Kym6pOg1Gq1jDlBOWn/4PQiYvoK
	 gWelAspX/KkHZ7OGLFCaJaA8janfunm4J2UxBZG0vSR3NlLCjT214BpARueDigECw/
	 2dtJc+7KhboGJQ+VsYipxJhHfg8Y7w1tFT9xJw8+PGYO7BJYgcJw7rCbSiCQulm+mD
	 oMY+d4PNnkUf9E3EHWT8iHLMvxmaVPc180x7Wo1XSk8NMKKGDWXx86s+XxLRrlIgIi
	 I/TmrXwyy7F3w==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-55f753ec672so849480e87.2;
        Sun, 31 Aug 2025 06:11:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUR6v7t/FgN6cgvL/g0eTGy9e4T20Ieq1AoW3M+PUJClyqrjC0EgYMPWNRb4wSe3jtX2dCT0wdxyBs=@vger.kernel.org, AJvYcCUwaeNeq2wiSVpI4Oyl5suTV9F9NdwCCOu1fQqQcgyEwwusObbvzBgn7o2ZjDqiWI4/HZBke/IPxDRgnlqw@vger.kernel.org
X-Gm-Message-State: AOJu0YxhLheM4CdDMyY84uJ40dESz9QjoANJCEojgLIGipls6GP2Jy5h
	Kn1T5MyjbN9/FzdTGghMiD+7ptq5Yiw//cSwbV9MwAqKMCzZxYUuZRgHCD5XC2VL9FBs4mGKLla
	Dm1b57uWJ7DVnpd4ixuO339kTLif8dp0=
X-Google-Smtp-Source: AGHT+IEV9OA6K7UeIiXXWN5F40GUs8m+IEFhne6Akm5mzPUKHUXXdAiNfAULslqwViThZEgQUfOsAXUkss1JGlWeGLo=
X-Received: by 2002:a05:6512:3da0:b0:55f:701f:937 with SMTP id
 2adb3069b0e04-55f7089c0ebmr1187119e87.12.1756645875358; Sun, 31 Aug 2025
 06:11:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828102202.1849035-24-ardb+git@google.com>
 <20250828102202.1849035-29-ardb+git@google.com> <20250831104945.GAaLQoyYmr316kHrKs@fat_crate.local>
 <CAMj1kXF-aD74+O_xf_f902wq2RdPpiXCEjJ9osbnEwAMoN_5Rw@mail.gmail.com>
 <CAMj1kXEQghhi4qCdV6PrYK-mTYFu5yVcn3fEOSZsC6vR7TiMEg@mail.gmail.com>
 <20250831111521.GAaLQuyYLUSN24_ZmT@fat_crate.local> <CAMj1kXFHrkY9R8xjrB_PFqswc2yOHGpPfEBq5WZ0rH_vbo55Mw@mail.gmail.com>
In-Reply-To: <CAMj1kXFHrkY9R8xjrB_PFqswc2yOHGpPfEBq5WZ0rH_vbo55Mw@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sun, 31 Aug 2025 15:11:04 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHzK0pSjuRYcZ3E2PQzCx4PTAC-UDHirgFDPYEyLMtoeA@mail.gmail.com>
X-Gm-Features: Ac12FXyxNP4FeYk1d8yGT8j5MesBI_-g2_wMjJpQyBSQqCAIO-Y3E1-MjOpvQNM
Message-ID: <CAMj1kXHzK0pSjuRYcZ3E2PQzCx4PTAC-UDHirgFDPYEyLMtoeA@mail.gmail.com>
Subject: Re: [PATCH v7 05/22] x86/sev: Move GHCB page based HV communication
 out of startup code
To: Borislav Petkov <bp@alien8.de>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, 
	linux-efi@vger.kernel.org, x86@kernel.org, Ingo Molnar <mingo@kernel.org>, 
	Kevin Loughlin <kevinloughlin@google.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Nikunj A Dadhania <nikunj@amd.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 31 Aug 2025 at 14:30, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Sun, 31 Aug 2025 at 13:15, Borislav Petkov <bp@alien8.de> wrote:
> >
> > On Sun, Aug 31, 2025 at 12:56:41PM +0200, Ard Biesheuvel wrote:
> > > OK it appears I've fixed it in the wrong place: the next patch adds
> > > back the definition of has_cpuflag() so I squashed that hunk into the
> > > wrong patch, it seems.
> >
> > The real question is - and I'm sceptical - whether the startup code runs too
> > early for boot_cpu_has(). And how is the startup code going to call
> > boot_cpu_has().
> >
> > /me builds .s
> >
> > Aha, so it gets converted into a boot_cpu_data access:
> >
> > # arch/x86/boot/startup/sev-shared.c:662:       if (validate && !has_cpuflag(X86_FEATURE_COHERENCY_SFW_NO))
> >         testb   %r13b, %r13b    # validate
> >         je      .L46    #,
> > # ./arch/x86/include/asm/bitops.h:206:          (addr[nr >> _BITOPS_LONG_SHIFT])) != 0;
> >         movq    80+boot_cpu_data(%rip), %rax    # MEM[(const volatile long unsigned int *)&boot_cpu_data + 80B], _15
> > # arch/x86/boot/startup/sev-shared.c:662:       if (validate && !has_cpuflag(X86_FEATURE_COHERENCY_SFW_NO))
> >
> > But former question remains: AFAIK, you want to run the startup code waaay
> > earlier, before we do identify_boot_cpu() which prepares boot_cpu_data, right?
> >
>
> I suppose that in this particular case, things work out fine because
> calling sev_evict_cache() unnecessarily is harmless. But I agree that
> in general, relying on CPU flags in code that may be called this early
> is not great.
>
> Perhaps this conditional should be moved into the caller instead
> (early_set_pages_state()), and early callers from inside the startup
> code should call sev_evict_cache() unconditionally?

Alternatively, we might consider the below:

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 235e557fd10c..bc59a421c7b4 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -342,6 +342,8 @@
        if (!(eax & BIT(1)))
                return -ENODEV;

+       sev_snp_needs_sfw = !(ebx & BIT(31));
+
        return ebx & 0x3f;
 }

diff --git a/arch/x86/boot/startup/sev-shared.c
b/arch/x86/boot/startup/sev-shared.c
index 8d2476e1ad3b..08cc1568d8af 100644
--- a/arch/x86/boot/startup/sev-shared.c
+++ b/arch/x86/boot/startup/sev-shared.c
@@ -31,6 +31,8 @@
 static u32 cpuid_hyp_range_max __ro_after_init;
 static u32 cpuid_ext_range_max __ro_after_init;

+bool sev_snp_needs_sfw;
+
 void __noreturn
 sev_es_terminate(unsigned int set, unsigned int reason)
 {
@@ -639,7 +641,7 @@
         * If validating memory (making it private) and affected by the
         * cache-coherency vulnerability, perform the cache eviction mitigation.
         */
-       if (validate && !has_cpuflag(X86_FEATURE_COHERENCY_SFW_NO))
+       if (validate && sev_snp_needs_sfw)
                sev_evict_cache((void *)vaddr, 1);
 }

diff --git a/arch/x86/boot/startup/sme.c b/arch/x86/boot/startup/sme.c
index 39e7e9d18974..2ddde901c8c5 100644
--- a/arch/x86/boot/startup/sme.c
+++ b/arch/x86/boot/startup/sme.c
@@ -521,6 +521,7 @@
                return;

        me_mask = 1UL << (ebx & 0x3f);
+       sev_snp_needs_sfw = !(ebx & BIT(31));

        /* Check the SEV MSR whether SEV or SME is enabled */
        sev_status = msr = native_rdmsrq(MSR_AMD64_SEV);
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index d3f0f17834fa..32178b8f9b87 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -570,6 +570,8 @@
 extern u16 ghcb_version;
 extern struct ghcb *boot_ghcb;

+extern bool sev_snp_needs_sfw;
+
 struct psc_desc {
        enum psc_op op;
        struct svsm_ca *ca;

