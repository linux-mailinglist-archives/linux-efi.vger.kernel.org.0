Return-Path: <linux-efi+bounces-4661-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E3DBB3D2DA
	for <lists+linux-efi@lfdr.de>; Sun, 31 Aug 2025 14:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92493189320D
	for <lists+linux-efi@lfdr.de>; Sun, 31 Aug 2025 12:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8231719F111;
	Sun, 31 Aug 2025 12:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QQiei4E6"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596181CD15;
	Sun, 31 Aug 2025 12:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756643442; cv=none; b=LQtsWc7sZ/9R6MubyGENQw/8TkEFGmAxIyyPRBkJWCdy1GM7HndyKtCWLrLTDao38VtpEgGtgl0yjxNzEx49Q3vhuN/liM5qjsGhai5XL9TmediCC2rKI+tLmgqOPR/Jw/qi/usOwamSRKpCPeIL6uJ1Lj9p4qdPOB2hxDOQi0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756643442; c=relaxed/simple;
	bh=fp0NecBk67eDoijTtzTAXNUtVQXDgzvZwFD9iIiuTao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FWHJqCYaIXWYheWD9HoeKD6HwbIsMdDsugilPA1PtHxdpBS9GnZyz9HaV255S9zNl6anB+B8swsbj+a58+BRaapWOm270mkVwueA4Y2UrL0cFTPJ0h0BvvGdDz0gPRwu1GkGwA3xvdFkNqsVhe/oXmQ1Nsw+Pi92qDSJXKFLwKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QQiei4E6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8D36C4CEED;
	Sun, 31 Aug 2025 12:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756643441;
	bh=fp0NecBk67eDoijTtzTAXNUtVQXDgzvZwFD9iIiuTao=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QQiei4E6cgamgDzBArsbpMnpNKqESbR0DlhhSxnRZbrJvMMxjC+6ECmTKO+Im6U4J
	 Mjwh+V/iiaJgWquJ/Bb0ue+Bd5fzh/h8SUtRHABADzIuA8WOE4VMs0Gx9BjZyaRZtu
	 Mb9QPHoh0iYoScdimpODusUFScMhZQH8PqslBbTijUxe3DpCzWJP7i955IdEmvinnU
	 CXqHSepfqYWafid3/pcHtOj0y7nrCsU3bJryJhzNnHdHC6lo35+oxLxiVwn17ydM20
	 koKZ4vjtmGInc2/rW9ZSBKQSZd5RWlOW1EbxUKQxKT2hc6islCpKLrlner1sAiYcvq
	 puas9i5j37Hiw==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-33682342180so31350531fa.0;
        Sun, 31 Aug 2025 05:30:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVYahDbNACOsxrIFLi6UW/1oizADdKpG32DqOh/sTZuQuQvETQvVmGfCYXHB49Cr5rakmjerI4YquMuxOyl@vger.kernel.org, AJvYcCVqcDnGvce36DZkbUDBWEw2I/WTNUYmnVpXCcnClpdB395lvavgDdOwc1suZaZKrvZjP1G3KhQ0hVE=@vger.kernel.org
X-Gm-Message-State: AOJu0YywABB+16hZoS4vWWfWzY/0Qriq8hTe2XKMVoJiGQmOKGOnha5L
	KMb3V0ulUhnwKW1djNwcAN4TAYu5HkDfo3xyCdV3WXI8YmAAUuuR8bjeJ2Sjjb7EM6/JaTntZ+N
	bpBKCrtu+HJJFwSE9NPBaWtz4NB1x41o=
X-Google-Smtp-Source: AGHT+IFnvnUY/s56Lavj9vIjkj2XI337CclASlpjXosuobBPXV+3vK3I53AS3L72NB3QR8c7ydHkLRo0iUrFUY3yixA=
X-Received: by 2002:a05:651c:2210:b0:336:c080:4149 with SMTP id
 38308e7fff4ca-336caac6994mr11293081fa.18.1756643440303; Sun, 31 Aug 2025
 05:30:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828102202.1849035-24-ardb+git@google.com>
 <20250828102202.1849035-29-ardb+git@google.com> <20250831104945.GAaLQoyYmr316kHrKs@fat_crate.local>
 <CAMj1kXF-aD74+O_xf_f902wq2RdPpiXCEjJ9osbnEwAMoN_5Rw@mail.gmail.com>
 <CAMj1kXEQghhi4qCdV6PrYK-mTYFu5yVcn3fEOSZsC6vR7TiMEg@mail.gmail.com> <20250831111521.GAaLQuyYLUSN24_ZmT@fat_crate.local>
In-Reply-To: <20250831111521.GAaLQuyYLUSN24_ZmT@fat_crate.local>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sun, 31 Aug 2025 14:30:29 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFHrkY9R8xjrB_PFqswc2yOHGpPfEBq5WZ0rH_vbo55Mw@mail.gmail.com>
X-Gm-Features: Ac12FXx5EBW5F4f81RiPM-Myf6XGbVWx423QKwsN1YFoiYzN3hrfnM9zXX3Ueig
Message-ID: <CAMj1kXFHrkY9R8xjrB_PFqswc2yOHGpPfEBq5WZ0rH_vbo55Mw@mail.gmail.com>
Subject: Re: [PATCH v7 05/22] x86/sev: Move GHCB page based HV communication
 out of startup code
To: Borislav Petkov <bp@alien8.de>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, 
	linux-efi@vger.kernel.org, x86@kernel.org, Ingo Molnar <mingo@kernel.org>, 
	Kevin Loughlin <kevinloughlin@google.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Nikunj A Dadhania <nikunj@amd.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 31 Aug 2025 at 13:15, Borislav Petkov <bp@alien8.de> wrote:
>
> On Sun, Aug 31, 2025 at 12:56:41PM +0200, Ard Biesheuvel wrote:
> > OK it appears I've fixed it in the wrong place: the next patch adds
> > back the definition of has_cpuflag() so I squashed that hunk into the
> > wrong patch, it seems.
>
> The real question is - and I'm sceptical - whether the startup code runs too
> early for boot_cpu_has(). And how is the startup code going to call
> boot_cpu_has().
>
> /me builds .s
>
> Aha, so it gets converted into a boot_cpu_data access:
>
> # arch/x86/boot/startup/sev-shared.c:662:       if (validate && !has_cpuflag(X86_FEATURE_COHERENCY_SFW_NO))
>         testb   %r13b, %r13b    # validate
>         je      .L46    #,
> # ./arch/x86/include/asm/bitops.h:206:          (addr[nr >> _BITOPS_LONG_SHIFT])) != 0;
>         movq    80+boot_cpu_data(%rip), %rax    # MEM[(const volatile long unsigned int *)&boot_cpu_data + 80B], _15
> # arch/x86/boot/startup/sev-shared.c:662:       if (validate && !has_cpuflag(X86_FEATURE_COHERENCY_SFW_NO))
>
> But former question remains: AFAIK, you want to run the startup code waaay
> earlier, before we do identify_boot_cpu() which prepares boot_cpu_data, right?
>

I suppose that in this particular case, things work out fine because
calling sev_evict_cache() unnecessarily is harmless. But I agree that
in general, relying on CPU flags in code that may be called this early
is not great.

Perhaps this conditional should be moved into the caller instead
(early_set_pages_state()), and early callers from inside the startup
code should call sev_evict_cache() unconditionally?

