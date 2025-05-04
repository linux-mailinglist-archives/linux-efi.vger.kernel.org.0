Return-Path: <linux-efi+bounces-3550-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D3B0AA8490
	for <lists+linux-efi@lfdr.de>; Sun,  4 May 2025 09:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADD913B9EE6
	for <lists+linux-efi@lfdr.de>; Sun,  4 May 2025 07:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E237B130A7D;
	Sun,  4 May 2025 07:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u8cdBDcs"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B090B28F4;
	Sun,  4 May 2025 07:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746344555; cv=none; b=UDMH37hqZ2IFo0N+nJlZv+ffAoF9zImmZN5Vav8vMkXAN5PnNEip16rdFaEk2KQxxv4Ubeg5V5n+AUXlo5H68QdsKPnOONCCAwvENOvsy7kyDOLe19d3FHMMrWMW66FsJxWjMxdw8D1aA8G9l4mb4A+e+8P31RpCSy8UijoG0S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746344555; c=relaxed/simple;
	bh=tURvEWvLmmzNtjgzAiaJRRvxI3lI/vGQR1F1GwuJVfs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QKpxzoo5WcMdwpY8zaMsidBPstUw6P4I9ibX345JmyY2t1qp5mftI0IDfgEvwBb+yP6LyY5haV6BWNjufpBwG2J5fUMvbHZgelusaD0qUy0yooDtWlywK8JHjAiHbakElUCYZH/sS9dDEY3Bv9fMn+rWFYPC4c0kRFOjonffMI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u8cdBDcs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 289E4C4CEEF;
	Sun,  4 May 2025 07:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746344555;
	bh=tURvEWvLmmzNtjgzAiaJRRvxI3lI/vGQR1F1GwuJVfs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=u8cdBDcsYafoxpnLGV5JvVgfutH7m/pYu28aDVqsGNawvmLK+XMik2VcRTLeWgDYr
	 oVLYtgwQoHEtX8cbijHF9omBlnom7mnTBYrUfZBKX4R7UYwYgiHo8XSsevwGYSBPBN
	 5j/FJpleQ1dTzb2nmD4ZGznP+nGaanVY+KLqVTWXbWTy7Z0HBaSE9SGCEMqWhB2/SC
	 hFKFOSmCmkNhbGsgeK2PbFGuhjdBK8o2EESJjc1dZlY3gZXV/IQYH7DVQaCfnGgdP4
	 4V9bR+Tw4SlFzUllwwT7aNbpwzEcjxYHWCgQNXGE5Fh0iL1SYllf0WWRPkX9foyr6k
	 rd0fKhlLexoTA==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-30db1bd3bddso32214991fa.3;
        Sun, 04 May 2025 00:42:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUBnmU3VLayWSuhGLEYsCIxgetScd5YH0Kb8ylMdRKHdCmZrR/NZ52LC8OrQrqofTA+Oy5qHqmKYoLoxufY@vger.kernel.org, AJvYcCX+h5HAie+TpX3xd1PqqkeJieLZjtm3Tx5/sCXHY6BGaGmSSCr4363oUKqRsWKQMhQVKTjIeQtO5RU=@vger.kernel.org, AJvYcCXDW4eOk9fLUlGqZfvQlqX0kQJouZi935k/RjWcLhNteCieL0EYvEiCNDVgsqAdXEhsZSVN59ia@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1Oh2MXg/CLi3cilUJEEDiZJdXDni5W3JwmPwXvnOuHRdiMSLU
	V1TOFGlzAKqpiqT79IG7eN5QjKiHKBBga/ybPoOLq5qWgF2sL9/yEXO3ejurZmqIIyadl8DDdpo
	51e609U++gup4clUrw8I4JJk4Oqw=
X-Google-Smtp-Source: AGHT+IFJAEgh8B21WYTewjh2PkaqKwaubgF9gmuOXnZRCO7Yb2utEOGWGc00W7PN0dZ8DyvdP5aNW0JD6LAhMp4ZWt4=
X-Received: by 2002:a2e:a99a:0:b0:308:e54d:6195 with SMTP id
 38308e7fff4ca-32349057bd0mr7311731fa.24.1746344553477; Sun, 04 May 2025
 00:42:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250428174322.2780170-2-ardb+git@google.com> <0ad5e887-e0f3-6c75-4049-fd728267d9c0@amd.com>
 <CAMj1kXE7=u9xNcUHiyFVPbOpwPvntFjdLfTzD0LeD_7it2MEQg@mail.gmail.com> <aBcZe1amYvqslhvA@gmail.com>
In-Reply-To: <aBcZe1amYvqslhvA@gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sun, 4 May 2025 09:42:22 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEGzmJx9TzHzFT+qBbT_cYXOdcNeuEFGC3zOPZ9AW8BmA@mail.gmail.com>
X-Gm-Features: ATxdqUEKqNBuDyqJpd1D2h40rp4fry7_e1lGThAGHAtBX7p0ZNatV4HanYuJ_Wo
Message-ID: <CAMj1kXEGzmJx9TzHzFT+qBbT_cYXOdcNeuEFGC3zOPZ9AW8BmA@mail.gmail.com>
Subject: Re: [PATCH] x86/boot/sev: Support memory acceptance in the EFI stub
 under SVSM
To: Ingo Molnar <mingo@kernel.org>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, Ard Biesheuvel <ardb+git@google.com>, 
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, 
	Borislav Petkov <bp@alien8.de>, Dionna Amalie Glaze <dionnaglaze@google.com>, 
	Kevin Loughlin <kevinloughlin@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 4 May 2025 at 09:38, Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Ard Biesheuvel <ardb@kernel.org> wrote:
>
> > On Thu, 1 May 2025 at 20:05, Tom Lendacky <thomas.lendacky@amd.com> wrote:
> > >
> > > On 4/28/25 12:43, Ard Biesheuvel wrote:
> > > > From: Ard Biesheuvel <ardb@kernel.org>
> > > >
> > > > Commit
> > > >
> > > >   d54d610243a4 ("x86/boot/sev: Avoid shared GHCB page for early memory acceptance")
> > > >
> > > > provided a fix for SEV-SNP memory acceptance from the EFI stub when
> > > > running at VMPL #0. However, that fix was insufficient for SVSM SEV-SNP
> > > > guests running at VMPL >0, as those rely on a SVSM calling area, which
> > > > is a shared buffer whose address is programmed into a SEV-SNP MSR, and
> > > > the SEV init code that sets up this calling area executes much later
> > > > during the boot.
> > > >
> > > > Given that booting via the EFI stub at VMPL >0 implies that the firmware
> > > > has configured this calling area already, reuse it for performing memory
> > > > acceptance in the EFI stub.
> > >
> > > This looks to be working for SNP guest boot and kexec. SNP guest boot with
> > > an SVSM is also working, but kexec isn't. But the kexec failure of an SVSM
> > > SNP guest is unrelated to this patch, I'll send a fix for that separately.
> > >
> >
> > Thanks for confirming.
> >
> > Ingo, Boris, can we get this queued as a fix, please, and merge it
> > back into x86/boot as was done before?
>
> Just to clarify, memory acceptance trough the EFI stub from VMPL >0
> SEV-SNP guests was broken last summer via fcd042e86422, and it hasn't
> worked since then?
>

It never worked correctly at all for SEV-SNP, since it was enabled in
d54d610243a4.

We never noticed because it appears that the SEV-SNP firmware rarely
exposes EFI_UNACCEPTED regions in chunks that are not 2M aligned, and
the EFI stub only accepts the misaligned bits so it can populate the
unaccepted_memory table accurately, which keeps track of unaccepted
memory with 2M granularity.

