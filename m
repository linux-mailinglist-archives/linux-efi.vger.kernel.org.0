Return-Path: <linux-efi+bounces-4727-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CEFAB528FF
	for <lists+linux-efi@lfdr.de>; Thu, 11 Sep 2025 08:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA3177BC03F
	for <lists+linux-efi@lfdr.de>; Thu, 11 Sep 2025 06:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3769027701E;
	Thu, 11 Sep 2025 06:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="czuRzHvM"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB9E2765E8;
	Thu, 11 Sep 2025 06:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757572540; cv=none; b=V/WQhvReWSXqkh5QOLV2O729O0wIYG0LFsPT3MBTWuLZONlOuI7lZBCnjyq+HAq6FppYSMp9zZ0hu/S8Eo6P8fLLu6DMT/i5+f2s/m6+hNQIShbYFOGf/pPl6gZr7Q+tTkgdQRWUvEXFJF9P7rrwzBoNI4eAT984V6Ejkny0xLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757572540; c=relaxed/simple;
	bh=msWaeJylOdNznN7lCZGe+G5W85AOZcgnyTSK3DdHstY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OEk5aHwMiZYriJJDpf53xoYrBdOw7nGKLg6vYexKr+EFVVAyyud6kZ/Uwzbd8C+WhWPmw/8tmJiyJhl75MNxKPjLLHeC7764xwHzRudDl6E1e4BDD7BOnPBPxDvOgRFFG6n0nlsj750Yk6FOmtxLoYXpd10BfGE0HZn8/DrQaUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=czuRzHvM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D09CC4CEF9;
	Thu, 11 Sep 2025 06:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757572539;
	bh=msWaeJylOdNznN7lCZGe+G5W85AOZcgnyTSK3DdHstY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=czuRzHvMYGogrUdPs6e08p+cJ/m8kf/elWNrlM+IbOrGlRTS38x2drb9lx+bXHH+J
	 jiT9LTmDhGHpKk2luz6jsjEZqjqLQ4zTTxjhxZtharvk6b7ajRA04jG4i6rW4NMeWR
	 hxQbpwCHYIV/HnXmyquQLkL7/5a6fcDd2RBGfkN5qJDrULuEvhfhfGv7VuwDW36vyq
	 nVFtN5M4IsS7xl8Ey55bZLnu5hx9DFEoJALyD/fTNIz02q94YCmGIr4FzZzhgp7SYD
	 6TG1DsLYMHv6r32RkUvRua9Fm1iIGNguxXI+xhWT087EEh6OXmD5ciK97Axa8k8NOl
	 5L4/AQD6Mp+gw==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-56d1b40ed70so193795e87.3;
        Wed, 10 Sep 2025 23:35:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUQW1CtVFPYM/2f9/8VfK8LU4Q2iXj074VTo8klAzAubwexa91dn8sfrs+JUaIeDM6pXmjuwPX2mJfVJ8N+@vger.kernel.org, AJvYcCVVVzEHCcHQyk+jAVRsYg9rbZtsshb5GQ68y9YKMmv0ws3UTKszQrecMFKKpt/KQ0/g4j2m3G1oAfk=@vger.kernel.org, AJvYcCWPwDEXSbwJZTwkvz/oW2bpQS+znI4wIcQMThNCNAibPiccc6wOFFZMn3mTE/DxaJW/5OXEeIPQxpqA@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3byULcvzPJ8myuLhQoTojvivqWNQ+oJgnZnARv91fOaMZLLiT
	MfvQ1Hvd/ZR+NP5T59H7QfMsA6qn9Jtf5qlEAo8lBWYnSLwpEWfhetCMfuZGZ7AbU0ndshhlFkj
	+QG3Jz/KAoXIu6m4jVYUfanCe67m57Rg=
X-Google-Smtp-Source: AGHT+IGDbmpIyC6cqQ0O4S232jssSQfG5WdfM/lU5QQJKfEg5FWZxC+ceE0VGOhHT6WE2d0nwCz/81Q1X89lnl3mzoU=
X-Received: by 2002:a05:6512:2c09:b0:55f:6649:45b8 with SMTP id
 2adb3069b0e04-5626256fe9amr6077674e87.45.1757572538000; Wed, 10 Sep 2025
 23:35:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910015738.14848-2-bagasdotme@gmail.com> <0b61b6f3-f11a-494c-9d4e-94ca19fd1eb6@infradead.org>
 <aMEUUkVQv2tqpO2L@archie.me> <0C55A642-8BC8-4C19-9FF5-8B803E2CCABA@zytor.com>
In-Reply-To: <0C55A642-8BC8-4C19-9FF5-8B803E2CCABA@zytor.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 11 Sep 2025 08:35:26 +0200
X-Gmail-Original-Message-ID: <CAMj1kXF6FhVjR4chqH-aW09V0HJ=yU33f-jMvr65t_+8ahRGBQ@mail.gmail.com>
X-Gm-Features: Ac12FXyNgWTifalIxFLI4IJKvjRz_QzgcQR1l_pP1TvgHA8Zn_4UP3g56LrbDjY
Message-ID: <CAMj1kXF6FhVjR4chqH-aW09V0HJ=yU33f-jMvr65t_+8ahRGBQ@mail.gmail.com>
Subject: Re: [PATCH] x86/Documentation: explain LINUX_EFI_INITRD_MEDIA_GUID
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>, Randy Dunlap <rdunlap@infradead.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Documentation <linux-doc@vger.kernel.org>, Linux EFI <linux-efi@vger.kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Hugo Osvaldo Barrera <hugo@whynothugo.nl>
Content-Type: text/plain; charset="UTF-8"

On Wed, 10 Sept 2025 at 22:10, H. Peter Anvin <hpa@zytor.com> wrote:
>
> On September 9, 2025 11:01:54 PM PDT, Bagas Sanjaya <bagasdotme@gmail.com> wrote:
> >On Tue, Sep 09, 2025 at 08:25:34PM -0700, Randy Dunlap wrote:
> >> On 9/9/25 6:57 PM, Bagas Sanjaya wrote:
> >> > +.. _pe-coff-entry-point:
> >> > +
> >> > +PE/COFF entry point
> >> > +===================
> >> > +
> >> > +When compiled with ``CONFIG_EFI_STUB=y``, the kernel can be executed as a
> >> > +regular PE/COFF binary. See Documentation/admin-guide/efi-stub.rst for
> >> > +implementation details.
> >> > +
> >> > +The stub loader can request the initrd via a UEFI protocol. For this to work,
> >> > +the firmware or bootloader needs to register a handle which implements the
> >> > +``EFI_LOAD_FILE2`` protocol with the ``LINUX_EFI_INITRD_MEDIA_GUID`` device
> >> > +path. In this case, a kernel booting via the EFI stub will use the ``LoadFile``
> >> > +function on the registered handle to obtain a reference to the initrd.
> >>
> >> drivers/firmware/efi/libstub/efi-stub-helper.c (line 509) says LoadFile2
> >> protocol. Is that the same as the LoadFile function?
> >>
> >> https://github.com/u-boot/u-boot/commit/ec80b4735a593961fe701cc3a5d717d4739b0fd0
> >> (the link below) also says LoadFile2() 4 times (and LoadFile 0 times).
> >
> >From UEFI spec [1], both LoadFile and LoadFile2 protocol versions of LoadFile()
> >function has same prototype but somewhat different in behavior. To answer
> >your question, however, I think so.
> >
> >EFI folks, what are your opinions?
> >
> >Thanks.
> >
> >[1]: https://uefi.org/specs/UEFI/2.10/13_Protocols_Media_Access.html
> >
>
> Sounds like the code was updated but not the documentation.

The UEFI spec defines two protocols, LoadFile and LoadFile2, under two
different GUIDs. They differ slightly in behavior when used to boot
the OS loader from the boot manager, but are identical when used in
other contexts.

The protocol definition (i.e., the struct layout) is identical: they
both implement a LoadFile() method with the same prototype,

So the answer the question: the LoadFile2 *protocol* is not the same
as the LoadFile *function*. And to be pedantic, no LoadFile function
is defined in the spec. It does define LoadFile::LoadFile() and
LoadFile2::LoadFile() protocol methods.

