Return-Path: <linux-efi+bounces-3258-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E59A844E0
	for <lists+linux-efi@lfdr.de>; Thu, 10 Apr 2025 15:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B2D23B2CD2
	for <lists+linux-efi@lfdr.de>; Thu, 10 Apr 2025 13:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56FD52853FA;
	Thu, 10 Apr 2025 13:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MWiuy6XX"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE0C42AA3;
	Thu, 10 Apr 2025 13:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744291699; cv=none; b=K/tfb1mKGuzXRkl9ALixePfDAH6XSIAiN4TWX725pZuEhSOrHHrw0uZcFznVgZFwTIaCPlR9nBwSCWt8CX66Q/cTkq5uasZCu+1V2jNIzeVW7M+PSXUOiDmVTD/B2/F4BV1GDHMrH6QjIovwbAsfUDDJV60floKDc2MkQHdinfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744291699; c=relaxed/simple;
	bh=25WXp4v8nKiw/QuMnvlfgXLqcjF1eNEhl3pKk7QdpQM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MuA+QuUgh/NTu9bQ80kCVH5R3yPthehWoTwCz+9rMFa5EOgFaVAKxOat2Osnzubu+WCRO4dzwW0k1N/7iBzLM2a88xyHUsTdqd7JkLIWesk0L+6yv3wsxXZ+GbCVHTrRDxqzXIJ++VhQg7+C6u+1y6ug1JnIMcaMWjUPDFh0pMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MWiuy6XX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A003BC4AF09;
	Thu, 10 Apr 2025 13:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744291698;
	bh=25WXp4v8nKiw/QuMnvlfgXLqcjF1eNEhl3pKk7QdpQM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MWiuy6XXpiI9GK9W38RQoneWdJOq7+9Xzyc5UkBDbpuFb9IJkbttdRkullwEAUtwh
	 p/uRaNvPcYhyjG6vMCAxZ8Ajf4FSEEz/cy3yc8cVkE76bkrSWQN1Lgv5vnSJc+oKCk
	 WH89fbcAU1RYXJ2G/z7FsSQAO1FSNM5A0x0OkVbcQ3+CP+975tgkJF8wRF2DVYIfsO
	 mOH3qUXYx++IUv33KsGZ0NlgQLk/JDMWP9sOvZnwv7MGefvLnNP765qbUpfHmNOEvb
	 b98HmuhX/82ErOsdLBt9wiapcond4Wv2OFrY6wv2ZSsOIebAJUHaG5JI2BAc3WBDSB
	 EKphKRGy2lF7g==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-549963b5551so1046665e87.2;
        Thu, 10 Apr 2025 06:28:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXS1eTVmoEKy19/WlKh7OedrlJXVw7slaLKFdPW+5Q0ImBA7LBrnosqTGlwSEleiM47wwiSHeQ6rznneayG@vger.kernel.org, AJvYcCXi2emXbo1CEl4JYyrLlKd1Usn2pLuFnlCvzP9ExICwhCnKzhZGB2r6FMPAYaZwVHu5IUPfbwliLPY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywop2ejQniXNQYFZBZuTMaATdlKJmNDaO6yxn0b0HjC7PzCnJZj
	mUolrNrM1knumc9jMs2mBX/s5QHrSFzy5BmVAIfMkspxJa6AA4Jg3l7EV8a2ruGajIUvPTcvRfK
	hQ6MjhmUyhiVWDZCUeUMsqevNt3w=
X-Google-Smtp-Source: AGHT+IGzjVf5L+3C6B0/XJl+1QrtE9NgY/ESWbLWVaM9p1Yk6xhAdpF757Vf6tvHljn/2Oic3MslWiP2yjhaTb6LPgs=
X-Received: by 2002:a05:6512:6ce:b0:53e:39e6:a1c1 with SMTP id
 2adb3069b0e04-54cb687c283mr987936e87.43.1744291697004; Thu, 10 Apr 2025
 06:28:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250404082921.2767593-5-ardb+git@google.com> <20250404082921.2767593-8-ardb+git@google.com>
 <l6izksy3qtvo6t6l3v44xhuzmrnl2ijv7fx5ypvaz7kjxvpwhh@4zwlvxyfrp43>
 <CAMj1kXGwnTkb1bUDaRpkh3ES8thcUVQE7+qgfZQw+RORtvtv-g@mail.gmail.com>
 <CAAH4kHbxMDGQy3v9ef1ZdqK0TNzpm==BJgx1KiUpRP-CRKDx4w@mail.gmail.com>
 <ldrma6tce2bwhenu5kobjzvk7cz445ubfmpcynwadqudgvzuh3@aibigcdzui6m>
 <9f689ba2-add6-cca2-e7b3-fa0393fe2b98@amd.com> <CAMj1kXERL=8Y51RUJSqgLWVMs4PJa9aQK0puvKaCpg6eRu0t8g@mail.gmail.com>
 <a53b3a3f-9fa1-4939-7885-1c06fe31af23@amd.com>
In-Reply-To: <a53b3a3f-9fa1-4939-7885-1c06fe31af23@amd.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 10 Apr 2025 15:28:05 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEUAaqyySAbpdPsnNsgi=4sHV4DWDOyqMPJBptk_HiF0w@mail.gmail.com>
X-Gm-Features: ATxdqUF13IuFEVHeJfqMAidwW---qt2JZhGLS0LE_1PuNrsOj9-gmAv66Dn_HlM
Message-ID: <CAMj1kXEUAaqyySAbpdPsnNsgi=4sHV4DWDOyqMPJBptk_HiF0w@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] x86/boot: Implement early memory acceptance for SEV-SNP
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Ard Biesheuvel <ardb+git@google.com>, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, x86@kernel.org, Borislav Petkov <bp@alien8.de>, 
	Kevin Loughlin <kevinloughlin@google.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 8 Apr 2025 at 17:53, Tom Lendacky <thomas.lendacky@amd.com> wrote:
>
> On 4/7/25 14:59, Ard Biesheuvel wrote:
> > On Mon, 7 Apr 2025 at 20:05, Tom Lendacky <thomas.lendacky@amd.com> wrote:
> >>
> >> On 4/7/25 04:25, Kirill A. Shutemov wrote:
> >>> On Fri, Apr 04, 2025 at 08:07:03AM -0700, Dionna Amalie Glaze wrote:
> >>>> If the GHCB is available, we should always prefer it.
> >>>
> >>> I believe we should consider the cost of code duplication in this
> >>> situation.
> >>>
> >>> If the non-early version is only used in the kexec path, it will not be
> >>> tested as frequently and could be more easily broken. I think it would be
> >>> acceptable for kexec to be slightly slower if it results in more
> >>> maintainable code.
> >>>
> >>
> >> Is accept_memory() in the decompressor or efistub only used in the kexec
> >> path?
> >>
> >
> > The EFI stub does not call accept_memory(), only the decompressor
> > does. The only use case for explicit memory acceptance in the EFI stub
>
> Since EFI stub never uses accept_memory() I looked at moving enablement
> of SEV to be before the setup of the accepted memory bitmap, as SEV
> enablement doesn't need any e820 info. But that didn't work because the
> real issue is early_setup_ghcb() calls set_page_decrypted() which calls
> set_clr_page_flags(). The latter function is not meant to work with EFI
> page tables, so there is an incompatibility.
>

I would prefer to go into the other direction, and not enable SEV at
all in the EFI stub. The core kernel will happily enable SEV anyway,
right?

> If we had a way to check for whether we are coming through the EFI stub
> vs the decompressor, then snp_accept_memory() could decide to skip
> early_setup_ghcb() when called from the EFI stub and call either
> __snp_accept_memory() from the decompressor or __page_state_change()
> from the EFI stub (the latter having to be updated to return a value).
>
> I think there are other areas that might need investigating because I
> noticed that efi_warn() is successful before efi_exit_boot_services()
> but blows up immediately after (possibly in the EFI #VC handler having
> to do with addressing the string?).
>

efi_warn() blows up because the console is gone after
ExitBootServices(). That is not SEV related.

