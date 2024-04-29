Return-Path: <linux-efi+bounces-999-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8218F8B5DEA
	for <lists+linux-efi@lfdr.de>; Mon, 29 Apr 2024 17:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 217271F21749
	for <lists+linux-efi@lfdr.de>; Mon, 29 Apr 2024 15:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F177382871;
	Mon, 29 Apr 2024 15:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mqJPVpqP"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FA882869;
	Mon, 29 Apr 2024 15:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714405244; cv=none; b=BpAGSRH5k3RYtEoOVXejY4UEaG4k8Dp0KV7mcPIzsJ7v3BYxnkBndR5P/H0wgBjb72nEJvP2rQvzGDGOy5jBGRSPD5TE6xlDb1rs1ES+wyzzRVpZBzf8bfjwDkR7odonnSI+xCoYOj/ZtDSLQLdGnu1/C7iKB2mKiF9SflZrHSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714405244; c=relaxed/simple;
	bh=ogdRWuX7tsdQmtKzPCEo+vOtWyyXCE54MSfI2V0FkgA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s71ddzy0StqV1ISsVjlXiNfRFuyZV3lPKsGJryMyrhvzd8c4CX3DVgJ4L0Oz+5J5BD95ZYXIpviQdCo+rhgksakoHfkSp6m1a9ONlA7tGt+l3tqMJLWFD73SwUIoP7XqOr9O3H8HEY9GlNKq5lPV1p9kzH30/n68B8Yx0dcx9OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mqJPVpqP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E04EC4AF1D;
	Mon, 29 Apr 2024 15:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714405244;
	bh=ogdRWuX7tsdQmtKzPCEo+vOtWyyXCE54MSfI2V0FkgA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mqJPVpqPpOxEltjXLUSQaA7wBXLZozGHCzcoFwDDX812zOsUl9Tn0oSHm56d+ueBs
	 qWhq/JEUdcTYuwzJnZy4llwIhRDVB2p036fepLLjoQkdZry+F8n4SMKo150ky/2cmi
	 tT088q3saf2nwSqLeb0kBtA5j5BLLDCMypHQ3UoIW0bDkrTmsxdwrVRLcoHT1Bu6/J
	 ZP7x/EmSLDYbWJvvKUChizkH7WZ1vvuJqdCNr1vSv1RNGI937rV3jDg3kqvD3LCFoH
	 kK0xubU9UZGLvKhukU6gEHNlfuCP22qOZA4gWfa07DhdqYf9ghHkIgs4BJuGtgy5CF
	 vfrRU8CuJdLsg==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2e09138a2b1so13334191fa.3;
        Mon, 29 Apr 2024 08:40:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUJLLHTjt4Q+cO/0J4NcjbQE/D8O9JiGf2Q0aWN7slme/8CtoeSEwnNfPtVLGVFLILXl8y5tWKAFD165Ozp3d53DcwvwHfG4EFWfwVl0SSiLw5piQDbhgj5lJjwaDQrjstKnkPCEjcD
X-Gm-Message-State: AOJu0Yxt5GFNhHV3TOVYqCxAS3lwFjXlyih7xQmmdDACLF1TSaihlNEx
	mLDbE9hOIpGoteKAh0aZAqHCEfJtcBqb2i8fMaQg9Bi82tycNMbmJShDeh64Ec0mTkjdpeN2YAp
	GqlHhX9AftZqpxWmhMcKoPGO8R/U=
X-Google-Smtp-Source: AGHT+IGdnu7bGK/0mcNSpYjqdoesXmVkZhwsKtfItbYipOa5cAX/3z5pHz0FaxV4tIIfB/iUe338u4cCaOGViy+UMEE=
X-Received: by 2002:a2e:be24:0:b0:2df:98c3:95dd with SMTP id
 z36-20020a2ebe24000000b002df98c395ddmr6578514ljq.22.1714405242556; Mon, 29
 Apr 2024 08:40:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_E910110547D287B13FEDB6E161D8874E6E06@qq.com>
In-Reply-To: <tencent_E910110547D287B13FEDB6E161D8874E6E06@qq.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 29 Apr 2024 17:40:30 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEfdJ9SzPO7NpYwXW3uPGYNOzVFndRswLZb=6TPAgN5TA@mail.gmail.com>
Message-ID: <CAMj1kXEfdJ9SzPO7NpYwXW3uPGYNOzVFndRswLZb=6TPAgN5TA@mail.gmail.com>
Subject: Re: [PATCH] x86/efi: mark racy access on efi_rts_work.efi_rts_id
To: linke li <lilinke99@qq.com>
Cc: xujianhao01@gmail.com, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 27 Apr 2024 at 07:28, linke li <lilinke99@qq.com> wrote:
>
> In efi_crash_gracefully_on_page_fault(), efi_rts_work.efi_rts_id can by
> changed by other thread from the comment. Mark possible data race on
> efi_rts_work.efi_rts_id as benign using READ_ONCE.
>
> This patch is aimed at reducing the number of benign races reported by
> KCSAN in order to focus future debugging effort on harmful races.
>
> Signed-off-by: linke li <lilinke99@qq.com>
> ---
>  arch/x86/platform/efi/quirks.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
> index f0cc00032751..4acb81700caf 100644
> --- a/arch/x86/platform/efi/quirks.c
> +++ b/arch/x86/platform/efi/quirks.c
> @@ -751,7 +751,7 @@ void efi_crash_gracefully_on_page_fault(unsigned long phys_addr)
>          * because this case occurs *very* rarely and hence could be improved
>          * on a need by basis.
>          */
> -       if (efi_rts_work.efi_rts_id == EFI_RESET_SYSTEM) {
> +       if (READ_ONCE(efi_rts_work.efi_rts_id) == EFI_RESET_SYSTEM) {
>                 pr_info("efi_reset_system() buggy! Reboot through BIOS\n");
>                 machine_real_restart(MRR_BIOS);
>                 return;

Why is this the only reference that needs an annotation?

