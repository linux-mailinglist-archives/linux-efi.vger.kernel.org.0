Return-Path: <linux-efi+bounces-1212-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 226ED9066BA
	for <lists+linux-efi@lfdr.de>; Thu, 13 Jun 2024 10:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 496C31C21795
	for <lists+linux-efi@lfdr.de>; Thu, 13 Jun 2024 08:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF5F1420DB;
	Thu, 13 Jun 2024 08:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WPRKEOuv"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849C113E020;
	Thu, 13 Jun 2024 08:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718267298; cv=none; b=iotrDPVf/Wo8g88reSqUP92D62RjpCAqAh0aOU9k5/IzrBqVBK5YFXJlMXbj6k7ki6Nqrsfaix1PZmd0V7xBX0gH5NbUUbooHu1jU8fMjsSK7PHatz8MEWFbwFLlbBGVtOa22do5kDi+aRpFcEGibhCS7QKsTKnfcxHrCSwqxt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718267298; c=relaxed/simple;
	bh=4n7R2Wjj5XV2Iowlqp+1RuKz8iVi3GSvTL7mxRY+v00=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PNP46cjSF/IbPsVT00LQaQCFolLUDDrDHgcMiThB9gJORS+TvxJ9qLbTRaGn+REcAxDp6GYRTiiIP2tXg/EcQKkcGN4MXbaSmbcjAnIYSB9b9Ylce+3lNBdh3GLbAYrOLTUa8nkuJOh7sDIvZcM1G75e/ylmFgQlrRPQjdq7XCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WPRKEOuv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19A5EC4AF1A;
	Thu, 13 Jun 2024 08:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718267298;
	bh=4n7R2Wjj5XV2Iowlqp+1RuKz8iVi3GSvTL7mxRY+v00=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WPRKEOuv0mOgEHMKvZqGsfkAm5933mmOgHZsOo8HgG0hHGM0fmhkiYDoJxdVQ7neb
	 78YJvklk3YNXcRwTpwUNo80U56Lp7Ac6EmxxgqNYDdGyN45FskVXr7fUrjdCwhceI8
	 Rst5HcwSNfxxM40X2+ixoW5++42/N2kk4oHC8AWOxt18giExrEkjOQL4XwT9c+PqI8
	 lNTjL2aArQUcMKoHfrG0SLzgUXLNL6Tfn3iswvrmteS7U2x8B6ZnTlth6RV8IR212A
	 gz6IKqaWyXAyxns4pvW3FYgTbihGzZbwBaM0al9h35jUt92yPCWUVoj8RW6KcJf5rc
	 EafLYUZ8V5kXQ==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52bbdb15dd5so953877e87.3;
        Thu, 13 Jun 2024 01:28:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV6I/ptSkCY81QGJQDstixRArkxrKF4x3k55YqHgDaUemq8E10FuUV5QZA7UeC3kvb1CmJxOhFqPH/ahjINoRNDpAZUFSLBECihyk+P
X-Gm-Message-State: AOJu0Yw3cQsOdk4e+pICgi9HsfPUufWX61uv+yl3jgqWwH3IwZJl0F2j
	2AobLcn0zyY7hvSs8cDK17XkEP+ttk6eVIG8dBhbIwGAHWbpM/nXxYIZU9D7AtwiP+YAKxEjOLb
	Z+/dT3YqDq1INuryzS+cK6G6blkM=
X-Google-Smtp-Source: AGHT+IG/j++akO5qxY65t0GL+p9ootSMH/RUNfNAQtZCPHxEx6h0eAbolyYYMinKC3GqQKHGKcStF6NdQU+9RZWagDU=
X-Received: by 2002:a05:6512:1d2:b0:52c:8271:5252 with SMTP id
 2adb3069b0e04-52c9a3c6f75mr2286027e87.16.1718267296466; Thu, 13 Jun 2024
 01:28:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240612135638.298882-2-ardb+git@google.com>
In-Reply-To: <20240612135638.298882-2-ardb+git@google.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 13 Jun 2024 10:28:05 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEgAStastV+sMhXt0pUmvM=nr9D-oDctwb8iiYxt9+fAQ@mail.gmail.com>
Message-ID: <CAMj1kXEgAStastV+sMhXt0pUmvM=nr9D-oDctwb8iiYxt9+fAQ@mail.gmail.com>
Subject: Re: [PATCH v3] x86/efi: Free EFI memory map only when installing a
 new one.
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, 
	Ashish Kalra <Ashish.Kalra@amd.com>, Dave Young <dyoung@redhat.com>, 
	Mike Rapoport <rppt@kernel.org>, Borislav Petkov <bp@alien8.de>, Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 12 Jun 2024 at 15:56, Ard Biesheuvel <ardb+git@google.com> wrote:
>
> From: Ard Biesheuvel <ardb@kernel.org>
>
> The logic in __efi_memmap_init() is shared between two different
> execution flows:
> - mapping the EFI memory map early or late into the kernel VA space, so
>   that its entries can be accessed;
> - cloning the EFI memory map in order to insert new entries that are
>   created as a result of creating a memory reservation
>   (efi_arch_mem_reserve())
>
> In the former case, the underlying memory containing the kernel's view
> of the EFI memory map (which may be heavily modified by the kernel
> itself on x86) is not modified at all, and the only thing that changes
> is the virtual mapping of this memory, which is different between early
> and late boot.
>
> In the latter case, an entirely new allocation is created that carries a
> new, updated version of the kernel's view of the EFI memory map. When
> installing this new version, the old version will no longer be
> referenced, and if the memory was allocated by the kernel, it will leak
> unless it gets freed.
>
> The logic that implements this freeing currently lives on the code path
> that is shared between these two use cases, but it should only apply to
> the latter. So move it to the correct spot.
>
> While at it, move __efi_memmap_free() into its only caller, and drop the
> dummy definition for non-x86 architectures, as that is no longer needed.
>
> Cc: Ashish Kalra <Ashish.Kalra@amd.com>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Fixes: f0ef6523475f ("efi: Fix efi_memmap_alloc() leaks")
> Link: https://lore.kernel.org/all/36ad5079-4326-45ed-85f6-928ff76483d3@amd.com
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
> v3:
> - don't move __efi_memmap_free() into what turned out not to be its only
>   caller
> - drop another CPP #define related to the dummy definition
>
> v2:
> - free old memory map only after installing the new one succeeded
> - move __efi_memmap_free() into its only caller
> - drop obsolete dummy declaration from generic code
>
>  arch/x86/include/asm/efi.h     |  1 -
>  arch/x86/platform/efi/memmap.c | 12 +++++++++++-
>  drivers/firmware/efi/memmap.c  |  9 ---------
>  3 files changed, 11 insertions(+), 11 deletions(-)
>

Given that this fixes an actual use-after-free bug that is not
specific to TDX/SEV or kexec, I'm inclined to queue this up as a fix.

@Boris: Mind if I take this as an EFI fix? Otherwise, can you queue
this up? Thanks.

