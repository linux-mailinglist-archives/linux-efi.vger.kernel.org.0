Return-Path: <linux-efi+bounces-2712-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2880CA193CB
	for <lists+linux-efi@lfdr.de>; Wed, 22 Jan 2025 15:21:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D81D01884A44
	for <lists+linux-efi@lfdr.de>; Wed, 22 Jan 2025 14:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6BF12135DB;
	Wed, 22 Jan 2025 14:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e1TTcsH2"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B3A213259;
	Wed, 22 Jan 2025 14:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737555706; cv=none; b=MIz0uwE0oAPi3uchqDw196yVCbV5Atf+h+7xXURmbpI3WFO3lDZyJpHTNHYyzXxjYUhvHLSEt4DbUwSlwBETfOH5NYaYajsC4YR5v1dFtxAU8+U8lk8YixNuea9LCv4u4cTASr2lndgY4we/ifFirAF8FC0iLtEQpXMBsAjv5RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737555706; c=relaxed/simple;
	bh=vpBXtzTmN7jHisoNI9A1cSaXBZ5prm6zJnF2GrKqI80=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EmMEeqMRGqJsXqn2EBginFLIlJf7JzJ0/vAagFHSzPr+pT/U3WIMgmqcNNVbc3tmKTfnooZqPsdCXU2RSB4DHpxoqgMMs0HxcgvPVVPUMCuRMhoygVKXetkkW3oIP90kdzxXkm8KVAv+kCOXJdm1icQnsp4c3e8fqxtWR4wA61s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e1TTcsH2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1BE1C4CEE0;
	Wed, 22 Jan 2025 14:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737555705;
	bh=vpBXtzTmN7jHisoNI9A1cSaXBZ5prm6zJnF2GrKqI80=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=e1TTcsH22U2K66enkeko0s2zL3C8CVLHY8FYc1GmNg2hF/5+svFzr6tzo4NqSZOez
	 EnVKQ2mg5erD41Xo99zU0PQQGUzcGqFJd7nBenW6lyCRRuD19Zxky3Vaqy6vGF+bNc
	 655nxV0Ytxh+C7eBkFDK7ZBFO2N3Qe6ZSfw8wNs7OoXF6Wj3v8bwS9ONTnFQJyynEy
	 FDQKE8ECxjrVGts6ujdh9RgV2asyK0uQjYlNE87je+AMH6sdU8cCFM5uyWemBiGnvw
	 XuuTl7x3VaHSJRBm14/BvNK9AwqMCA+LmtIN+dBWT1zK+qZb+GdAchGkS9k+TWjY3g
	 mi4zVDmIYUyEg==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-30616d71bb0so65960781fa.3;
        Wed, 22 Jan 2025 06:21:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVO7GCANlXykJUBusfXQJSgFu7krrt68MKIge/9I10I3LeOTwhcsFW7jJtyASnwzIdys36NX+bOg84=@vger.kernel.org, AJvYcCVZY4d218sTpn717hhXn2nlQnnDiniLpI59DFJdTX1ml0OtzVSTNUkJ1OwNIPJohi4CVjwEdcnMA+hy1ZVs@vger.kernel.org, AJvYcCWSc95CFjpmt0VIY7f873f8UiFoxN7dqaCTQlSISAZ3LrBDI2zv5ng2DQvmI9HybfXnKH7fkYNVRZyN224p@vger.kernel.org
X-Gm-Message-State: AOJu0YyllfOIZHm7ycm3OEY9D2KTwoV4oFeujB0f2hASxHVUSUzEMazZ
	RXGdhwdydSqvUkzSNX3StViUwdhP20oyglyeyT6laXCIwRLt3CTWEjfhehs4VmSkl4Gkkcy/AWw
	TZaSQ2IN9MA819uvq7LnLQyjYq/k=
X-Google-Smtp-Source: AGHT+IH8s+zq7WU70XFmeKX/VcWZ5DIFY3tPTSXq/9kaJTekOyyM006hgMxz+MbPFM8/IsysxIA0AFRIZ0WEIxXEkw8=
X-Received: by 2002:a2e:bd07:0:b0:2ff:d3c6:9cf4 with SMTP id
 38308e7fff4ca-3072ca5cab3mr84856431fa.1.1737555704203; Wed, 22 Jan 2025
 06:21:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250121-kernel-compress-fast-v1-1-fa693b6167d4@google.com>
 <CAMj1kXF-GSB9Ty7X1h4u1uA6qhO1Y1UvVrNF=R+hk3PENRz7WA@mail.gmail.com> <CAG48ez2hVHk-C4XAGW2GieHZ9JAF0RrFfpZF7XhYc80pznMwbA@mail.gmail.com>
In-Reply-To: <CAG48ez2hVHk-C4XAGW2GieHZ9JAF0RrFfpZF7XhYc80pznMwbA@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 22 Jan 2025 15:21:33 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFT6wkP=eRemR1Y=C-fk2VxNurLHMy74VRFLNmx6NkOAA@mail.gmail.com>
X-Gm-Features: AbW1kvZ1W8m-F_X64uYUWsQnlroDVQpdXCUMw3OXK-acihPRYq2eXwkveuJFqLU
Message-ID: <CAMj1kXFT6wkP=eRemR1Y=C-fk2VxNurLHMy74VRFLNmx6NkOAA@mail.gmail.com>
Subject: Re: [PATCH RFC] x86: Add CONFIG_KERNEL_UNCOMPRESSED support
To: Jann Horn <jannh@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, linux-efi@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 22 Jan 2025 at 14:54, Jann Horn <jannh@google.com> wrote:
>
> On Wed, Jan 22, 2025 at 2:31=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> =
wrote:
> > Hi Jann,
> >
> > On Tue, 21 Jan 2025 at 23:16, Jann Horn <jannh@google.com> wrote:
> > >
> > > Support storing the kernel uncompressed for developers who want to qu=
ickly
> > > iterate with one-off kernel builds.
> > > Store it in the usual format with a 4-byte length suffix and keep thi=
s new
> > > codepath as close as possible to the normal path where decompression
> > > happens.
> > >
> > > The other compression methods offered by the kernel take some time;
> > > even LZ4 (which the kernel uses at compression level 9) takes ~2.8
> > > seconds to compress a 110M large vmlinux.bin on my machine.
> > >
> > > An alternate approach to this would be to offer customization of the =
LZ4
> > > compression level through a kconfig variable; and yet another approac=
h
> > > would be to abuse the existing gzip decompression logic by storing th=
e
> > > kernel as "non-compressed" DEFLATE blocks, so that the decompression =
code
> > > will essentially end up just doing a bunch of memcpy() calls.
> > >
> >
> > This all seems pretty complicated, and adding yet another
> > (pseudo-)compression method is not great in terms of maintenance
> > burden, especially because there are other consumers of the compressed
> > images (both for bzImage and EFI zboot)
> >
> > Did you try running gzip with -1 instead of -9? On my build machine,
> > this reduces the compression time of a defconfig bzImage build from
> > 4.3 seconds to 0.9 seconds.
>
> I tried lz4 with -1; that is very fast (240ms wall clock time on my
> machine, and just 120ms user time):
>
> $ ls -lh arch/x86/boot/compressed/vmlinux.bin
> -rwxr-x--- 1 [...] 110M Jan 22 00:01 arch/x86/boot/compressed/vmlinux.bin
> $ cat arch/x86/boot/compressed/vmlinux.bin | time lz4 -l -9 - - | wc -c
> 2.86user 0.04system 0:02.96elapsed 97%CPU (0avgtext+0avgdata 15756maxresi=
dent)k
> 0inputs+0outputs (0major+220minor)pagefaults 0swaps
> 46309676
> $ cat arch/x86/boot/compressed/vmlinux.bin | time lz4 -l -1 - - | wc -c
> 0.12user 0.06system 0:00.24elapsed 75%CPU (0avgtext+0avgdata 15524maxresi=
dent)k
> 0inputs+0outputs (0major+94minor)pagefaults 0swaps
> 56029608
>

Excellent.

> But I wasn't sure how to wire that up in a nice way. I guess the
> nicest option would be to create a separate kconfig variable for the
> compression level to use for any cmd_lz4/cmd_lz4_with_size invocations
> in the build process; and then maybe only make this option visible if
> LZ4 is selected as kernel compression method?
>
> Another option would be to create a new option in the "Kernel
> compression mode" choice menu with a name like "LZ4 (fast)", turn
> CONFIG_KERNEL_LZ4 into an internal flag that is selected by both LZ4
> variants shown in the choice menu, and duplicate some of the make
> rules, but that seems overly complicated.
>

I didn't realise that KERNEL_UNCOMPRESSED already exists and you are
just wiring it up for x86. But I still think that we should avoid
that, not only because it is yet another bzImage format but also
because I still see a 3x size reduction even with the fastest setting.

I think adding one Kconfig symbol that depends on KERNEL_LZ4 and
switches from -9 to -1 for LZ4 only is reasonable.

