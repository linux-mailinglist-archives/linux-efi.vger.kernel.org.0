Return-Path: <linux-efi+bounces-2710-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71891A19313
	for <lists+linux-efi@lfdr.de>; Wed, 22 Jan 2025 14:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D5971882536
	for <lists+linux-efi@lfdr.de>; Wed, 22 Jan 2025 13:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0402139BC;
	Wed, 22 Jan 2025 13:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NTphKHzb"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248CE213237
	for <linux-efi@vger.kernel.org>; Wed, 22 Jan 2025 13:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737554082; cv=none; b=jThlNH6001y/ondprCGOttohm1buzoNdeXCajz7jynJ1NxXm5SEV0h56E7j7l1tVgPo16ROCIlJjHKDRBD7gYtbrzr/gPzuRlBLS6SrZfHBUrIXxIDN/uuWTl3XokaA/AlcTnMvaYnl3VxbgtB0IwAqDVHhRtdZJX+yXdpQWFSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737554082; c=relaxed/simple;
	bh=Aja9IWLqIsJ+8STZu81BLfq4DL7+g/ayz7j4EtKld0Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kbl2+860d02obmet52N1EcONFRkiT0WDrzcX36yKYzKBK1rWHlC6cAVpytfPBC7Ua6UsLuDk3s+hO2p2I3VHvL1EPLMjb2NUCJkp2c6FbpMl5foleWlvsYFg0T1ow9gjkhEVOkNT3sudSrNZVoB6W4gholenR4CruPiELMK/29I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NTphKHzb; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5dbfc122b82so2965a12.0
        for <linux-efi@vger.kernel.org>; Wed, 22 Jan 2025 05:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737554078; x=1738158878; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aja9IWLqIsJ+8STZu81BLfq4DL7+g/ayz7j4EtKld0Q=;
        b=NTphKHzbwY7m8x5OaC3hw8quljy6p8P2L//HGQMz4aU4ITZMPMDhtqnHMT2VwwVlAG
         VOx6WYmzr4ULk5ihPH2qFQ5NwLDMwnXsEvBhiagy8I5NBZrsprFV1vng9JsKAs4A96iE
         rEVcRLyw5vuCnr2TSwo4dqWqmTSClNyAcUZvdIbF+Bz92BRkeQ0MeE+tlCeUjYvAF7CR
         WPW196wdjcekOC23BQKZ+blETk3h8SMI7FxGi8ybt+AySS5wtTi4X9YIedgv4zimlrOu
         99uqQ0CGKfeYr6YEQZIL5bRGWpmbyBmknCstwVonhYcowrdKy7XrDcz0siKIag6vW57L
         NJLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737554078; x=1738158878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Aja9IWLqIsJ+8STZu81BLfq4DL7+g/ayz7j4EtKld0Q=;
        b=eAG27/eqNxkIjTdUhqPnAu0RH01ZGwZFUOAErVWHa+ubNFFmandBLqvQqcWU5l3ec9
         V6lcxOrNyEhcaE2R0ZWCSfNHG9XO2Kh9+SDBQyn1b6eq9f7DXgWK861WPs+OsTER0Pq3
         jk4m4ijqJ6RzU7Eqtz9Ejr6NGtURrWTGDIFcaFNtE4h6kEwPB3mC82+p8I+UiWTqBe/Z
         XpENck0CsI6AbHdxWO+65ZSoZy6TnPvsffff9pZEEhxf4O39kWEheGZrhGgRGrYStgqT
         7yGyvBpDfMuOvfa52fLWiyqDdqCcIsryOdyV1oyKaW2EYjcDrEZqfRfPXApCZ2rSJClV
         QX9g==
X-Forwarded-Encrypted: i=1; AJvYcCWhZ3fMeTHSEdIMbDphtc+9CcTKenJIp1w04s17xXTClIyLNaU1FyQUtQSa53/+2PurzEsHxu+tck4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ8xB0ogpPT8Q9i9Oq74ROU4tgXyIITRsPyoW+LN+d8o5j4e86
	I0pMw0k/Cg2FvzYmAltxc07FOXGrFox6ASWZ5rQkOufJ0x4ezQLSxaZtrnu/ZWT5jG/uQBf3Hm3
	tXiE0/wgoi0yen4c9k7+/aSSCvHP67ZHhYMnO
X-Gm-Gg: ASbGncvcsEeDTBHg5sZdDY/dGOEzrE+THUmUGbOmvIN1+ZAeYdfIhvkaXjZN/WAp3Co
	rvrJnNvy7+HQIVrt36gtG2S7yNYvZ6YkgmsdSti0qDjuPvQuyhYQX5FjRqi6Kd/OWfccJkh0ZdR
	oopq0=
X-Google-Smtp-Source: AGHT+IHBC6XLtUtYXrzEzVE4IQs6mUaRzxkMW6KbFHU4zq3aeb/bxwC9rANTYWTS6Y5/Lu9/OA24OmLu/FzuZxoGy4w=
X-Received: by 2002:a05:6402:177c:b0:5d0:eb21:264d with SMTP id
 4fb4d7f45d1cf-5dbf52b73f5mr85949a12.1.1737554077893; Wed, 22 Jan 2025
 05:54:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250121-kernel-compress-fast-v1-1-fa693b6167d4@google.com> <CAMj1kXF-GSB9Ty7X1h4u1uA6qhO1Y1UvVrNF=R+hk3PENRz7WA@mail.gmail.com>
In-Reply-To: <CAMj1kXF-GSB9Ty7X1h4u1uA6qhO1Y1UvVrNF=R+hk3PENRz7WA@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Wed, 22 Jan 2025 14:54:01 +0100
X-Gm-Features: AbW1kvbz84okZ8EjFVjUgqmssHigJO0WT_2FKC4hm8C7G6az3kttq8fu5bC2ADo
Message-ID: <CAG48ez2hVHk-C4XAGW2GieHZ9JAF0RrFfpZF7XhYc80pznMwbA@mail.gmail.com>
Subject: Re: [PATCH RFC] x86: Add CONFIG_KERNEL_UNCOMPRESSED support
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, linux-efi@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 22, 2025 at 2:31=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> wr=
ote:
> Hi Jann,
>
> On Tue, 21 Jan 2025 at 23:16, Jann Horn <jannh@google.com> wrote:
> >
> > Support storing the kernel uncompressed for developers who want to quic=
kly
> > iterate with one-off kernel builds.
> > Store it in the usual format with a 4-byte length suffix and keep this =
new
> > codepath as close as possible to the normal path where decompression
> > happens.
> >
> > The other compression methods offered by the kernel take some time;
> > even LZ4 (which the kernel uses at compression level 9) takes ~2.8
> > seconds to compress a 110M large vmlinux.bin on my machine.
> >
> > An alternate approach to this would be to offer customization of the LZ=
4
> > compression level through a kconfig variable; and yet another approach
> > would be to abuse the existing gzip decompression logic by storing the
> > kernel as "non-compressed" DEFLATE blocks, so that the decompression co=
de
> > will essentially end up just doing a bunch of memcpy() calls.
> >
>
> This all seems pretty complicated, and adding yet another
> (pseudo-)compression method is not great in terms of maintenance
> burden, especially because there are other consumers of the compressed
> images (both for bzImage and EFI zboot)
>
> Did you try running gzip with -1 instead of -9? On my build machine,
> this reduces the compression time of a defconfig bzImage build from
> 4.3 seconds to 0.9 seconds.

I tried lz4 with -1; that is very fast (240ms wall clock time on my
machine, and just 120ms user time):

$ ls -lh arch/x86/boot/compressed/vmlinux.bin
-rwxr-x--- 1 [...] 110M Jan 22 00:01 arch/x86/boot/compressed/vmlinux.bin
$ cat arch/x86/boot/compressed/vmlinux.bin | time lz4 -l -9 - - | wc -c
2.86user 0.04system 0:02.96elapsed 97%CPU (0avgtext+0avgdata 15756maxreside=
nt)k
0inputs+0outputs (0major+220minor)pagefaults 0swaps
46309676
$ cat arch/x86/boot/compressed/vmlinux.bin | time lz4 -l -1 - - | wc -c
0.12user 0.06system 0:00.24elapsed 75%CPU (0avgtext+0avgdata 15524maxreside=
nt)k
0inputs+0outputs (0major+94minor)pagefaults 0swaps
56029608

But I wasn't sure how to wire that up in a nice way. I guess the
nicest option would be to create a separate kconfig variable for the
compression level to use for any cmd_lz4/cmd_lz4_with_size invocations
in the build process; and then maybe only make this option visible if
LZ4 is selected as kernel compression method?

Another option would be to create a new option in the "Kernel
compression mode" choice menu with a name like "LZ4 (fast)", turn
CONFIG_KERNEL_LZ4 into an internal flag that is selected by both LZ4
variants shown in the choice menu, and duplicate some of the make
rules, but that seems overly complicated.

