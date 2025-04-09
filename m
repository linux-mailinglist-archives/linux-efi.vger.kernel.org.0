Return-Path: <linux-efi+bounces-3254-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B194A823C6
	for <lists+linux-efi@lfdr.de>; Wed,  9 Apr 2025 13:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70DC53B7040
	for <lists+linux-efi@lfdr.de>; Wed,  9 Apr 2025 11:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AAB825E466;
	Wed,  9 Apr 2025 11:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lnFLH3Hq"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A0E2566CB;
	Wed,  9 Apr 2025 11:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744198970; cv=none; b=T0zqWhtLm5zbX6GMI8En9SkatFOcsmqJLhbwEANxyeOAnxjulU8QlZwJCz46U976j7clLesLUoy14GkSCPa304WzS4no+/htsjfx+yWEKQscE+GiUibpJaWRQwkAe1EiPfCd20ZCtko1tSgLtXuU5PcuqIBRMdgoyE88x2xJxfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744198970; c=relaxed/simple;
	bh=iqaMeYVNNYVmGtQqhPrNkb07SIsjhTN5GAKF6ZKeG0s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s0V+CsngiBCMuEtD6lB82vSlzWlCzcVK8gm72n3i5GHUKZpXE9JUW+qXVbEpU3wRnlYu3SrJryzlkD10xQzSfNFWidbrVKM/ZzFK+tQwgCf7YcWcUCU2kXL8JdrZKCfHC7FZ3cftgAmz0drkJi1Du1DsuGHa56eeede1HTY+Svs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lnFLH3Hq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6E77C4CEE8;
	Wed,  9 Apr 2025 11:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744198969;
	bh=iqaMeYVNNYVmGtQqhPrNkb07SIsjhTN5GAKF6ZKeG0s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lnFLH3HqtV8FXoTkmL7NtjtdEblX3eMmAoBFEqVCV1Xipm0BNmkGOfhAWc/oVoZ+J
	 JMa3xNvSp9NOeVDEP35+UlseULYFJpT/lt8BBQIobHP06+Cx62t02LKMYWobb3yUH+
	 OG4uI36ZDZbC9jih6nPF5bzmgxp270lJYtzQJYgoKYFiVRlsGezteDBpjYL7vsvwyK
	 qg5o3HkI2IT3E0/0E1uiL0UaomqU00ttlmABEuWsCPyRbnBeMtwsuZd1pUILAyte3x
	 +zG8FMtHbJFIGNrxUPYVxopSMBD9p2qJDkUiOjyOqTryH8gmKUfP/Drzxai+0oIfkW
	 xLrv+utG1299Q==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-30beedb99c9so61355801fa.3;
        Wed, 09 Apr 2025 04:42:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUMKYD8lUvwbTx+Kv9DFaxAqx1b751kcIm52DWlD7IeUu2K6Z6x8+cGqEKmfU0CBwZeSvdC65stXMWEvZ4+@vger.kernel.org, AJvYcCUllWd4ULq1F5Z9wt7tcDGElHR2ejeY5MFDNXyqaSZRl9TFVeK5AwSYsQMrhzbHzq85eK4q0++xOK8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9WzdtOcakTCD7+zVBon4/zyLi8HcNZi29TVWA3vN7Sv4ZrkAO
	bXBdELtl/tBqy2euMPzqOrtdfkXsEOFlX3r8OXYPMrJ2RDW4Y9+qVflA5bXiu1gPT6QUu/rNeeQ
	RtalvlhLXriGt9luKY79Y9y1zkOA=
X-Google-Smtp-Source: AGHT+IGQSP8+6AsISaE1ZhDtFdRsCfGrrYxgteffT8tUbUUYdpO9q5O1mM7uYgtX5rdtsg4FNqcqW92Ihpu0V3T0cQ4=
X-Received: by 2002:a2e:a992:0:b0:30b:d5ed:55c7 with SMTP id
 38308e7fff4ca-30f438c92aemr9078581fa.36.1744198968173; Wed, 09 Apr 2025
 04:42:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250408085254.836788-9-ardb+git@google.com> <20250408085254.836788-12-ardb+git@google.com>
 <Z_ZGbVXOTPbGXleS@gmail.com> <Z_ZG7pAZavKDgFDK@gmail.com>
In-Reply-To: <Z_ZG7pAZavKDgFDK@gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 9 Apr 2025 13:42:37 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHPg7NxFwyT6jNp5FunnGbWRW7Kd2FG5UPntLb-sxB03Q@mail.gmail.com>
X-Gm-Features: ATxdqUEUhHLGmGj3vsrX4mTUz4tOeWrXq8zbxM8v4VlIRMM1gXQaK0ptAN4G_zM
Message-ID: <CAMj1kXHPg7NxFwyT6jNp5FunnGbWRW7Kd2FG5UPntLb-sxB03Q@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] x86/boot: Move the early GDT/IDT setup code into startup/
To: Ingo Molnar <mingo@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-efi@vger.kernel.org, x86@kernel.org, 
	linux-kernel@vger.kernel.org, Tom Lendacky <thomas.lendacky@amd.com>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 9 Apr 2025 at 12:07, Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Ingo Molnar <mingo@kernel.org> wrote:
>
> >
> > * Ard Biesheuvel <ardb+git@google.com> wrote:
> >
> > > From: Ard Biesheuvel <ardb@kernel.org>
> > >
> > > Move the early GDT/IDT setup code that runs long before the kernel
> > > virtual mapping is up into arch/x86/boot/startup/, and build it in a =
way
> > > that ensures that the code tolerates being called from the 1:1 mappin=
g
> > > of memory. The code itself is left unchanged by this patch.
> > >
> > > Also tweak the sed symbol matching pattern in the decompressor to mat=
ch
> > > on lower case 't' or 'b', as these will be emitted by Clang for symbo=
ls
> > > with hidden linkage.
> > >
> > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > > ---
> > >  arch/x86/boot/compressed/Makefile |  2 +-
> > >  arch/x86/boot/startup/Makefile    | 15 ++++
> > >  arch/x86/boot/startup/gdt_idt.c   | 83 ++++++++++++++++++++
> > >  arch/x86/kernel/head64.c          | 73 -----------------
> > >  4 files changed, 99 insertions(+), 74 deletions(-)
> >
> > This causes the following build failure on x86-64-defconfig:
> >
> >    arch/x86/boot/startup/gdt_idt.c:67:55: error: cast to generic addres=
s space pointer from disjoint =E2=80=98__seg_gs=E2=80=99 address space poin=
ter [-Werror]
>
> Caused by the previous patch:
>
>   x86/asm: Make rip_rel_ptr() usable from fPIC code
>

Oops, sorry about that. I saw that error and thought I had fixed it
with the (__force void*) cast.

