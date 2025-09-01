Return-Path: <linux-efi+bounces-4664-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F7CB3E687
	for <lists+linux-efi@lfdr.de>; Mon,  1 Sep 2025 16:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 242A2188350A
	for <lists+linux-efi@lfdr.de>; Mon,  1 Sep 2025 14:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D1D2EFDB3;
	Mon,  1 Sep 2025 14:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u52VoQ/E"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9301B211290;
	Mon,  1 Sep 2025 14:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756735338; cv=none; b=ZytFlCJeO5VlBvFAc+qWrycVvXi7i9ZDEilPVZuH8AeVCXn5sa9dUKN+SM8O1voIfNzLoLXLsINYxY5M0mwjCxcwSvi5GkieOBmJYotQYZ/EJXrpaJUYGKobN107pPhRJc0wLKEtmSeL/OtpBMVwuk1bC9MMWUJerzv2/h8xjQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756735338; c=relaxed/simple;
	bh=+HEKdYmKHDq9vCCENHbez5vOKR4CUdBZxtrI+HxYHGo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OWW4uGvcF6fxfNqMKLu5L1taKafC5O0R/Pe+vkN7jd+USCwPyv6Ro5OiuvbwTdgVa7bx0gDnPZfISTLk25oHMRTBiB9zoCVICbvwvU2m90szDWVqMV6VQLwQHNEF/mWUTAq4ucw5i3+3sKQF1N5rLYYH1Z4r4qlHsRFpye8afMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u52VoQ/E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C54DC4CEF9;
	Mon,  1 Sep 2025 14:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756735338;
	bh=+HEKdYmKHDq9vCCENHbez5vOKR4CUdBZxtrI+HxYHGo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=u52VoQ/EcBM99ezrM+ul4bosvv2oLg+k3In7H8FhsxWpV/X7jY/HaEZUkFxbRvn7M
	 7kTnUhEniFEs9MJJOkDDDVWuslLiAfQuiPH6s/9FWhjsrl6YdIXo6ZZzGdxVmFyTdH
	 d2F4FBfmRqX6XzQAdZFhsUWcgSYG9mJHmivSGb6V3uJaxwjx2XlZbk82AYR5sGiovK
	 lFFk47oTY2aE6Db53Pmdp2h3f4lUl+mzHF7dYC4L82SdXTdFjHjlxad1Pcrs6n2P90
	 er52ikn4Qm6d3bbY4oT0o+P2ZGYnF3gHcUuOp4l+ITiHBVMYINnFP//uvYEI2IZ4r+
	 D9rDpkMYUU7Yw==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-55f78f32580so939739e87.3;
        Mon, 01 Sep 2025 07:02:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV252Uzs/GW1e0UvkfRw4v/0b3SXPU6d6qdUDVWHAxQJbFM92Q8/ic9e+bPoSp9foyf/4H8oyPQdBLvGJEb@vger.kernel.org, AJvYcCVrrp5VsG0IWW7G4isrEII7j1zzqL3yFJw42Ys+lGn10BwLGvR3ACjfWNKPL0dSd3cHfbRswqGX6Z4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+DEjK35xh2cw1iOU2slzNjeewsPBftdU8HzrwodDsBvN8HiE/
	CYvey4elOt8Lj2+IALQq1a4FyYSYi0ue/xRR1X7WcypHAVupsrJRxqPBCS40GUwhOwnRA87BWnK
	bnTcoF6x9IT5Dt8sBb+W4FWX/2DFgW3g=
X-Google-Smtp-Source: AGHT+IFCTZKz1xlU9UfnDqfvPyNh6BZuNR5MGaMt333F2+URSJHJdMNJGAhJxyvUIFGUk5jjVYRKsY4mqF9ft9eb+cA=
X-Received: by 2002:a05:6512:b24:b0:55f:645a:2794 with SMTP id
 2adb3069b0e04-55f70948358mr2038817e87.45.1756735336455; Mon, 01 Sep 2025
 07:02:16 -0700 (PDT)
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
 <CAMj1kXHzK0pSjuRYcZ3E2PQzCx4PTAC-UDHirgFDPYEyLMtoeA@mail.gmail.com> <20250901135459.GAaLWlsx75fnPHveLl@fat_crate.local>
In-Reply-To: <20250901135459.GAaLWlsx75fnPHveLl@fat_crate.local>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 1 Sep 2025 16:02:04 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFRSJ1zT5XvBE2JT1jm2peOs9aymHeydOYk8AZRO=JDbQ@mail.gmail.com>
X-Gm-Features: Ac12FXwUS3elC2X6o1kZtk9kC0ZX5nlyD9qvkqUPJBq1QWF18P3Zgo9vFzZpUSk
Message-ID: <CAMj1kXFRSJ1zT5XvBE2JT1jm2peOs9aymHeydOYk8AZRO=JDbQ@mail.gmail.com>
Subject: Re: [PATCH v7 05/22] x86/sev: Move GHCB page based HV communication
 out of startup code
To: Borislav Petkov <bp@alien8.de>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, 
	linux-efi@vger.kernel.org, x86@kernel.org, Ingo Molnar <mingo@kernel.org>, 
	Kevin Loughlin <kevinloughlin@google.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Nikunj A Dadhania <nikunj@amd.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 1 Sept 2025 at 15:55, Borislav Petkov <bp@alien8.de> wrote:
>
> On Sun, Aug 31, 2025 at 03:11:04PM +0200, Ard Biesheuvel wrote:
> > Alternatively, we might consider the below:
>
> This is the full diff ontop of this current patch - it removes the
> get_cpuflags() hunk too as it is not needed now. It builds fine and I'll test
> with it and if all looks good, merge it with your patch.
>
...
> diff --git a/arch/x86/boot/cpuflags.c b/arch/x86/boot/cpuflags.c
> index 63e037e94e4c..916bac09b464 100644
> --- a/arch/x86/boot/cpuflags.c
> +++ b/arch/x86/boot/cpuflags.c
> @@ -106,18 +106,5 @@ void get_cpuflags(void)
>                         cpuid(0x80000001, &ignored, &ignored, &cpu.flags[6],
>                               &cpu.flags[1]);
>                 }
> -
> -               if (max_amd_level >= 0x8000001f) {
> -                       u32 ebx;
> -
> -                       /*
> -                        * The X86_FEATURE_COHERENCY_SFW_NO feature bit is in
> -                        * the virtualization flags entry (word 8) and set by
> -                        * scattered.c, so the bit needs to be explicitly set.
> -                        */
> -                       cpuid(0x8000001f, &ignored, &ebx, &ignored, &ignored);
> -                       if (ebx & BIT(31))
> -                               set_bit(X86_FEATURE_COHERENCY_SFW_NO, cpu.flags);
> -               }

Are you sure this can be removed? It is tested in other places too
(arch/x86/coco/sev/core.c), and AIUI, it is a Linux defined CPU
feature so it will never be set automatically.

