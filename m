Return-Path: <linux-efi+bounces-1352-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5958A91E0AC
	for <lists+linux-efi@lfdr.de>; Mon,  1 Jul 2024 15:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B74CB2815B1
	for <lists+linux-efi@lfdr.de>; Mon,  1 Jul 2024 13:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5208015ECC6;
	Mon,  1 Jul 2024 13:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tpko25GR"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B28D15E5DB;
	Mon,  1 Jul 2024 13:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719840449; cv=none; b=ZhdLEB3PqFjQi9c5blZwTLkXIeIkXzs40sHImuVlPGW46mjq18maf+ATrldeFln0sE/LUwkHUrHQCnYm/JLMSDngTV+C+9phZnx+e7w3/5+ObqxjiVgEcizEvdLhUf7oh9FEEjyzg3igerbkpmEHQiV0vocaZT4iJYbAFYbv9rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719840449; c=relaxed/simple;
	bh=RGVefZ3LYaLLES6iQhtUNZkddbn4IpZ6Q94Sq67kgt4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PIudK+RevOY+z1hluoCu/l1Ya/aymERAUFH/GtCcrrgnotO4M2GUxnHdN5aAQDAVaxgnlIQTeN1YdbUugLOOkXQBZNmd3Flwk2gRnwzr+uvF5ZkjdE8GcvRZ4B+PkgRa7VREUzWw34MiEjCHmf1K959HUkF+wBxWYcQOoUkRMs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tpko25GR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF916C32786;
	Mon,  1 Jul 2024 13:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719840448;
	bh=RGVefZ3LYaLLES6iQhtUNZkddbn4IpZ6Q94Sq67kgt4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tpko25GRoyJ/wADgJ5KwFwp0I+1WiWqPc26GHZ7uIYP3vIqvBPZtiF4OEjdfDtz3i
	 e2vTRJqoLnlf/priLn6gPLJfWGeye6dRY1qDeYyuQjnzRmvT+30ySfRdkJjmKtjGGV
	 Wogc0IQcZUPOtlz4p0s2y3XDGvirxYXg2ZJseDDCeo1g5fBw2gn2vXjErvrkQYjeTk
	 fOU83Cn7aCJGebLaYs5KmUa7tpvPO/9MBqvJrLjywBzq8ZEN9+zFhxtubV5irSa7wK
	 8YjMADZn5Xexs+ujAZaTWugOreCTnuI1UksqPfgi5YtIpghQIuvU0DgL+fyGqSY6O9
	 vVJIxBUpDRi8Q==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ebe0a81dc8so40722061fa.2;
        Mon, 01 Jul 2024 06:27:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUuN7u6TndhP+2C4DBTNhOWVfkr8DjzEvSVlJazuyZ4w+R1x4Vvbn8/Xz42GPYf9Z5k2kJ+mprELzsfm6CPe8LFTEe76YO9//M78vQeJNFMMpHTTO0pXOE5uspVI3RZhZeJcvKMIXnS
X-Gm-Message-State: AOJu0YwRcYE75+4dvIdkK0M5Q3A4kL7R6K08NJzP7KagglSHP++TKT7r
	j9X3VZAbhlmL5rNasFE0ZU+pZHuFfrKf3q1lcVsdPrnqb78iH/wdanUT+j1j5RyFeswAoda3Z87
	y49MCJ1h5rgvLRytg49qRUl6GwYM=
X-Google-Smtp-Source: AGHT+IFwckd+qOlAiDqjYBF2nZ+unD2z8gT4uWHTczXzYQpNgG0hMG6PX00odYf2BECd0DQqpCwr5y6PSlC5EJZ7g3g=
X-Received: by 2002:a2e:300c:0:b0:2ec:4f01:2c0f with SMTP id
 38308e7fff4ca-2ee5e3bf062mr45016221fa.26.1719840447042; Mon, 01 Jul 2024
 06:27:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620073205.1543145-1-ardb+git@google.com> <20240701124734.GFZoKlZhqnWJlz7LKb@fat_crate.local>
In-Reply-To: <20240701124734.GFZoKlZhqnWJlz7LKb@fat_crate.local>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 1 Jul 2024 15:27:15 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEHpezZS_jNoLQoTSKXZ0P8DxQFHNKRS2kkTC-G4MfG0w@mail.gmail.com>
Message-ID: <CAMj1kXEHpezZS_jNoLQoTSKXZ0P8DxQFHNKRS2kkTC-G4MfG0w@mail.gmail.com>
Subject: Re: [RFC PATCH] x86/efi: Drop support for fake EFI memory maps
To: Borislav Petkov <bp@alien8.de>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-efi@vger.kernel.org, x86@kernel.org, 
	linux-kernel@vger.kernel.org, dyoung@redhat.com, 
	Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 1 Jul 2024 at 14:47, Borislav Petkov <bp@alien8.de> wrote:
>
> On Thu, Jun 20, 2024 at 09:32:05AM +0200, Ard Biesheuvel wrote:
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > Between kexec and confidential VM support, handling the EFI memory maps
> > correctly on x86 is already proving to be rather difficult (as opposed
> > to other EFI architectures which manage to never modify the EFI memory
> > map to begin with)
> >
> > EFI fake memory map support is essentially a development hack (for
> > testing new support for the 'special purpose' and 'more reliable' EFI
> > memory attributes) that leaked into production code. The regions marked
> > in this manner are not actually recognized as such by the firmware
> > itself or the EFI stub (and never have), and marking memory as 'more
> > reliable' seems rather futile if the underlying memory is just ordinary
> > RAM.
> >
> > Marking memory as 'special purpose' in this way is also dubious, but may
> > be in use in production code nonetheless. However, the same should be
> > achievable by using the memmap= command line option with the ! operator.
> >
> > EFI fake memmap support is not enabled by any of the major distros
> > (Debian, Fedora, SUSE, Ubuntu) and does not exist on other
> > architectures, so let's drop support for it.
> >
> > Cc: Taku Izumi <izumi.taku@jp.fujitsu.com>
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  Documentation/admin-guide/kernel-parameters.txt |  21 ---
> >  arch/x86/Kconfig                                |  20 --
> >  arch/x86/boot/compressed/kaslr.c                |  43 +----
> >  arch/x86/include/asm/efi.h                      |  15 --
> >  arch/x86/kernel/setup.c                         |   1 -
> >  arch/x86/platform/efi/efi.c                     |   2 -
> >  arch/x86/platform/efi/fake_mem.c                | 197 --------------------
> >  arch/x86/platform/efi/memmap.c                  |   1 +
> >  drivers/firmware/efi/libstub/x86-stub.c         |   2 +-
> >  9 files changed, 11 insertions(+), 291 deletions(-)
>
> I obviously like this:
>
> Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
>
> I don't see the author or anyone else objecting, I guess queue it?
>

Thanks.

> Or if you feel like you wanna give folks a full cycle, you could queue it for
> the next MW...
>

It's been in -next for ~10 days so I might just send it for the next
cycle. We can always revert it if something gets broken.

