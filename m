Return-Path: <linux-efi+bounces-2826-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D64A45D2C
	for <lists+linux-efi@lfdr.de>; Wed, 26 Feb 2025 12:31:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE5B418910FE
	for <lists+linux-efi@lfdr.de>; Wed, 26 Feb 2025 11:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28C7217654;
	Wed, 26 Feb 2025 11:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bMaH22kE"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F96217648
	for <linux-efi@vger.kernel.org>; Wed, 26 Feb 2025 11:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740569441; cv=none; b=C0gnfPo4LPn8DSJWSCPhAiwkrWbmWMImVornQUxPq+Vzya+PuBBW5h7Gnst9p5SRGf/nu3sGmraMfx2/iEgZpxjGLHYKgyb+K+SZPkE8l9tJ6jBKUxRIH4umjjny/h7sg1tqxXcab7v/H50kl+WqmmPKpHvvtggcGVqjP60Gubg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740569441; c=relaxed/simple;
	bh=iYYoc1Z0HkDhw/dJ3x+Q/rx0kEwmXh2bp/9SiQhdF4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fGLI8U6CWh/J3ciBwzzaOEWCwkINgw4sw5ulTyBMYDqL1Pqjpds2B4H3JYSSR4kyT9QHsHuR9l5JrxqayJmU0tOB23hm9O/Jzz5eDTo5ftWU6g8zBMhUuoz+6ZIKAwvecxHDfAHr7rRWb/vmrTHBie42mJxV4VyPdQfnU+fqT3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bMaH22kE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E58D9C4CEF7
	for <linux-efi@vger.kernel.org>; Wed, 26 Feb 2025 11:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740569440;
	bh=iYYoc1Z0HkDhw/dJ3x+Q/rx0kEwmXh2bp/9SiQhdF4c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bMaH22kEv0uXMeHCXAwUkfluLcjmO9njcMH/MWJR+2AGAmpaOHR4Ye7E9oD9Ha0NS
	 h3DdRKsm+JBZ/MzuIAnVVgreRMxMxTVXKuie2mJw2GwCkT2kNaqy0s6JxFSolgaiI2
	 IOjtF+Scc7tKqMrXzEVv7SEWsttos/IiY6rzxOHpuReANI4ai4qERkl+Zr9cpxeDv7
	 fMl4OFEauahVs3IOOgKPY1206adcJOP6Feeu5w/b+K25U4MGv+wOS+ifihX8RWrip8
	 IQIJ3hm5wzarcRFlktxNvwHWCUlnNU3WlmxyiQB4VnsVgHNOGXHRH+xWEP3wy9xao3
	 Zw+Uxvo9Up7jw==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-548430564d9so4284853e87.2
        for <linux-efi@vger.kernel.org>; Wed, 26 Feb 2025 03:30:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXyabSdFAKpSPaS8nqozibH+LXCLUjSm8r0TnJwdRH5fLGN02rfZ1icUroMue6THJlQKQqcM6Fp84M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYU5jl6EKgBkjtHzLeL1o0X/GUYPlSc9vo2IhG4gvfaPsNaRgA
	OpHDX1UVjnKE/9ahV5+A+1tYEmEIg75u11mDRh4vmlzv8YbnERl9cG2DjKxpQhId5av0qjePmul
	9eYCPhBoOsrzCzrMydw+CzJgVNa0=
X-Google-Smtp-Source: AGHT+IElPtphWvRZrQBxccrWBPUlMU+Dgy1tO0Wnv9BlnFoqXeelshroiJ9W3prnDncjn9DGKgvm78wZlt8Teae6QWc=
X-Received: by 2002:a05:6512:3b0f:b0:545:60b:f394 with SMTP id
 2adb3069b0e04-54839129bd9mr10987894e87.4.1740569438061; Wed, 26 Feb 2025
 03:30:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <SBFUY-p4-fI9JOrQa51x141vKHs_rbFLw4q9kfPGAK8Z76PQfgYl6zM3nUjlOeIPY6PgEhqLFaSJkW0vdBVzET3MDYUBZwzmYCJuNK4TaYU=@hughsie.com>
 <ffd953c76d3a0bc0f88aeb319589632e8da032dc.camel@HansenPartnership.com>
In-Reply-To: <ffd953c76d3a0bc0f88aeb319589632e8da032dc.camel@HansenPartnership.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 26 Feb 2025 12:30:26 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGsZVAWmG7NV+6fevvZy6RwEXrw2avT1EBRWjn5Kk_hvw@mail.gmail.com>
X-Gm-Features: AQ5f1Jrd4NkLahjbctIukvx_xK4u8RI7cQ7aEqEH54ecT22Xol6BiqV2CBKE6Fc
Message-ID: <CAMj1kXGsZVAWmG7NV+6fevvZy6RwEXrw2avT1EBRWjn5Kk_hvw@mail.gmail.com>
Subject: Re: efivarfs: fix error on write to new variable leaving remnants
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Richard Hughes <richard@hughsie.com>, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Feb 2025 at 13:59, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> [added correct mailing list for bug report]
> On Tue, 2025-02-25 at 12:10 +0000, Richard Hughes wrote:
> > Hi,
> >
> > I'm not sure what I'm supposed to do about:
> >
> > commit 908af31f4896f2c0645031f8b74a89d3a8beb5b9
> > Author: James Bottomley <James.Bottomley@HansenPartnership.com>
> > Date:   Sun Jan 19 10:12:12 2025 -0500
> >
> >     efivarfs: fix error on write to new variable leaving remnants
> >
...
> >
> > It causes a regression in fwupd -- seen in
> > https://github.com/fwupd/fwupd/issues/8495 and
> > https://bugzilla.redhat.com/show_bug.cgi?id=2346831 so far -- and it
> > seems broken for anyone (including me) updating to 6.14.
>
> OK, so the problem with this as a bug report is that it doesn't explain
> what you're doing.  However
>
> > I can work around the behavior in
> > https://github.com/fwupd/fwupd/pull/8500 (which is also the arguably
> > correct thing to do) but it's going to cause a panic as I have to get
> > an updated fwupd out on all distros so we'll need releases for
> > multiple branches.

This code was introduced in the merge window for v6.14, which is due
to be released end of March. How much time do you need?

Derailing LVFS is the last thing I want to do, but we all know how
this works: once a workaround is put in, it is never going to be
removed.

>
> Reading the code in the fix, it looks like you were creating a file in
> EFI (which is naturally zero length), then closing it (because glib gio
> specifically has an API for this), then clearing the immutable bit and
> then writing to it to actually create a variable?
>
> However, none of that dance is at all required.  A newly created file
> naturally allows writing on the file descriptor you used to create it.
> It's only if you open it again that the entry becomes immutable.

Should we be doing this in the first place? It makes sense for
efivarfs to mark variables that it doesn't know about as immutable if
they are present at boot - the original rationale here was systems
with buggy firmware, where an inadvertent 'rm -r
/sys/firmware/efivars/*' would brick the device.

But the fact that a newly created file becomes immutable once you
close and reopen it seems unnecessarily strict to me.

(I am aware that this is orthogonal to the issue at hand, but it is
something we might fix nonetheless)

