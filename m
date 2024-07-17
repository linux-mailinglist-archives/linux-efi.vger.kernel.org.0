Return-Path: <linux-efi+bounces-1455-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 856DE934443
	for <lists+linux-efi@lfdr.de>; Wed, 17 Jul 2024 23:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B70751C21170
	for <lists+linux-efi@lfdr.de>; Wed, 17 Jul 2024 21:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C18540849;
	Wed, 17 Jul 2024 21:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AnPX+U9c"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C824688;
	Wed, 17 Jul 2024 21:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721253206; cv=none; b=oUB/EGerLDw+x7AUvbljujj9lVZvLZ5PiS1iJOlKOFXggmFERdpiClgqAuuT74NxQz2oRGSBUVaMCT34uGc4aaJQwTmFv1ejrXEftde5KGLhrQkvokwOjBy7D9XVoH1vD3r3jpGpGowj+R5uEOc8+2mnL3ocUVFMdLfqUR2Dk2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721253206; c=relaxed/simple;
	bh=2hNKo4PRlRL5HpgATzZ4TV0W6nttMnM5e0eF+5Mjub0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YV2AmJtNtGswKUZQv84px71x7WH2fO25fmKzsBv7DTUua1wQxc1cBfHmF9Aa+P3s+wKyEKKrKuePuOkB8Ske3CGfLBPWEBSgnpouQErJVAAoXIRtPCdcrhf1IGjstS4X5AM8dGnfn3gkrAAnTEB1BSFiFxnxs/TxcJEWZYWObRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AnPX+U9c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D010EC4AF48;
	Wed, 17 Jul 2024 21:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721253204;
	bh=2hNKo4PRlRL5HpgATzZ4TV0W6nttMnM5e0eF+5Mjub0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AnPX+U9c48j4O8UxGmxwQ0NrNzpMU+YP8PL8yLystZQLYQOOX0lcLezJB2hX300zT
	 fcx1FaWwSaZc6pBsAs1p4/GJDztsgmWvSqohxbnkINB/bWV12WeUINHgRaqQxWaq7P
	 l4y7SIxldsYUU9YCM4hoiVEBAUzp3Jm0Mk0IjNzzPBbtQ5UeQUwudCmrvdKLO0oYcO
	 HHTUWVaPXh18rdymSaWnXJEwnG7J1Vm60MldsOriyf/TRLhZdAYLjOkZ07d5iZtZPa
	 jtJVRv87NA05+y/2uGjhB7Kxji4l2ujQ+vrlTBv4xJR4e4WqO+1V4Q8X7t5M9zq7v0
	 0vudlyMAI45ag==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2eecd2c6432so2931511fa.3;
        Wed, 17 Jul 2024 14:53:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWizsIByu0Peq+B+bQZ98sg5/ijGgw/3KpwUS0u8qwE8Xuhn373WWQOIaoziS9C2mncb8k7yX/bP4dh3637Qjeyq3dJV8CWLgCKWch3u4vQ1CzwHI+o/+RHxjsu2Bs2QpOj1jwl8VPG
X-Gm-Message-State: AOJu0YxJDg4GMB6s3WOyEhAUWOuelKrL+v//kJbxpc6rXUsExF5hqaAt
	2+bw+hVRri+onbcg8DmkzP0eFbDbb5R5Zfn59htm1nbnt2BhmnTRF7OM2h6oFn5VAJc88jY38Od
	nqn6gT/yIJsANti5jKASuO9pXM24=
X-Google-Smtp-Source: AGHT+IHQA5REQfR6PJuDJ5WJHovXh5yxPkwShu/QgAgI8DmO7TG1mfxo+DDoQQvj4nWpnCxV2bSVNwiXncM9U1sfLSs=
X-Received: by 2002:a2e:b60c:0:b0:2ee:52f4:266 with SMTP id
 38308e7fff4ca-2ef05c53bd9mr5245661fa.3.1721253202794; Wed, 17 Jul 2024
 14:53:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240717213121.3064030-1-steve.wahl@hpe.com> <20240717213121.3064030-2-steve.wahl@hpe.com>
In-Reply-To: <20240717213121.3064030-2-steve.wahl@hpe.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 17 Jul 2024 14:53:11 -0700
X-Gmail-Original-Message-ID: <CAMj1kXEgvORTj3FT54Dq39d-tQLXDdmEPEVc=x6H8Schmdu6fg@mail.gmail.com>
Message-ID: <CAMj1kXEgvORTj3FT54Dq39d-tQLXDdmEPEVc=x6H8Schmdu6fg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] x86/kexec: Add EFI config table identity mapping
 for kexec kernel
To: Steve Wahl <steve.wahl@hpe.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, 
	Pavin Joseph <me@pavinjoseph.com>, Eric Hagberg <ehagberg@gmail.com>, 
	Simon Horman <horms@verge.net.au>, Eric Biederman <ebiederm@xmission.com>, 
	Dave Young <dyoung@redhat.com>, Sarah Brofeldt <srhb@dbc.dk>, Russ Anderson <rja@hpe.com>, 
	Dimitri Sivanich <sivanich@hpe.com>, Hou Wenlong <houwenlong.hwl@antgroup.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, 
	Yuntao Wang <ytcoode@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, Joerg Roedel <jroedel@suse.de>, 
	Michael Roth <michael.roth@amd.com>, Tao Liu <ltao@redhat.com>, kexec@lists.infradead.org, 
	"Kalra, Ashish" <ashish.kalra@amd.com>, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 17 Jul 2024 at 14:32, Steve Wahl <steve.wahl@hpe.com> wrote:
>
> From: Tao Liu <ltao@redhat.com>
>
> A kexec kernel boot failure is sometimes observed on AMD CPUs due to
> an unmapped EFI config table array.  This can be seen when "nogbpages"
> is on the kernel command line, and has been observed as a full BIOS
> reboot rather than a successful kexec.
>
> This was also the cause of reported regressions attributed to Commit
> 7143c5f4cf20 ("x86/mm/ident_map: Use gbpages only where full GB page
> should be mapped.") which was subsequently reverted.
>
> To avoid this page fault, explicitly include the EFI config table
> array in the kexec identity map.
>
> Further explanation:
>
> The following 2 commits caused the EFI config table array to be
> accessed when enabling sev at kernel startup.
>
>     commit ec1c66af3a30 ("x86/compressed/64: Detect/setup SEV/SME features
>                           earlier during boot")
>     commit c01fce9cef84 ("x86/compressed: Add SEV-SNP feature
>                           detection/setup")
>
> This is in the code that examines whether SEV should be enabled or
> not, so it can even affect systems that are not SEV capable.
>
> This may result in a page fault if the EFI config table array's
> address is unmapped. Since the page fault occurs before the new kernel
> establishes its own identity map and page fault routines, it is
> unrecoverable and kexec fails.
>
> Most often, this problem is not seen because the EFI config table
> array gets included in the map by the luck of being placed at a memory
> address close enough to other memory areas that *are* included in the
> map created by kexec.
>
> Both the "nogbpages" command line option and the "use gpbages only
> where full GB page should be mapped" patch greatly reduce the chance
> of being included in the map by luck, which is why the problem
> appears.
>
> Signed-off-by: Tao Liu <ltao@redhat.com>
> Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
> Tested-by: Pavin Joseph <me@pavinjoseph.com>
> Tested-by: Sarah Brofeldt <srhb@dbc.dk>
> Tested-by: Eric Hagberg <ehagberg@gmail.com>
> ---
>
> Version 3: Do not rename map_efi_systab to map_efi_tables, and don't add
> 'config table' to the comments, per Ard Biesheuvel request.
>
>  arch/x86/kernel/machine_kexec_64.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

