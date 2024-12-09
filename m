Return-Path: <linux-efi+bounces-2327-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F20D79E97C3
	for <lists+linux-efi@lfdr.de>; Mon,  9 Dec 2024 14:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B6AC166C11
	for <lists+linux-efi@lfdr.de>; Mon,  9 Dec 2024 13:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B111E35957;
	Mon,  9 Dec 2024 13:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u2L1D0HY"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C04723313C
	for <linux-efi@vger.kernel.org>; Mon,  9 Dec 2024 13:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733752184; cv=none; b=qFj9Vq+p/1nV+3FY0J8LtrUBi/PYaumTsDeZxkmp9fes87GsXHixhMi/A2v0bXc3VLUzUQBGj3S8IacfOKK8MEbMl4JdoniYKsyCXbqdfQQe6IfbYK24m+QFIZeKQgtWU/ULKpNHyGUlQ9gOsZqV92owuzuqZK8H0a5So2uO/60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733752184; c=relaxed/simple;
	bh=XWhL4Dos5H0ahmti1nSJ2rdBbZS1IzRJQS/CJGLR3no=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PgwupxRHxoe48iSvbkqu+FKWMTCDfalcZsubK71xxUkx4x9BMLW/NxAOrMSPP4lpqaAyiUpyonUURCAUtH0sMKDA553sEYN2FlqrDH/p/kqoNWEQDO9G4NO41NeCae7uS6Zo9rAdQaFij6NI08DB8X++I9OjsRBbX3jv+0dyq/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u2L1D0HY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12FC1C4CEE2
	for <linux-efi@vger.kernel.org>; Mon,  9 Dec 2024 13:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733752184;
	bh=XWhL4Dos5H0ahmti1nSJ2rdBbZS1IzRJQS/CJGLR3no=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=u2L1D0HY7xmJ2/RVIsBr6An/xD5yhkeywxxkigUHD4DQvcoEhiCs71H6IYp76qgrc
	 qt5IVPTxlw8RUzN12FToRZKEidQDyfYbdm9b4zE9YrvZiX5ExPsV2uug/oEfnekRvy
	 Us5Tc3jypm90c0zDnjeY1VR4kV8qz2wmKIsoSBKMHpViNLA5uRLSSUZONRgkM0ZBop
	 rY21PWKbHvXlDgm2QML0UjGdVzflYGKk9DDnjoHeP/uDyBa8fhiOIYuasi3p+bNhly
	 eayMBHU2JAayT0gNDcynDke1vKsmCpnQ9Xbg/TDYLupllNUQhdVguvCg1ERy6Knagl
	 p6KVGFrDkwm8g==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-53e399e3310so2410218e87.1
        for <linux-efi@vger.kernel.org>; Mon, 09 Dec 2024 05:49:43 -0800 (PST)
X-Gm-Message-State: AOJu0Yw1D45cbeY+ZygPwqSwdlQ62GhfjvBxB31V/HW/OAO47t1BQbQz
	HG9vCzX9YL7mwZLSJ4vZaya8XK7mcZts1DJdp4d6E+Y0zc6mMYg1xfglSRlo6CpU243jAKqb/fX
	dBBXEzen1ri93tW73A48+kyol+8I=
X-Google-Smtp-Source: AGHT+IH2Uy8wv6ERePrWqYDPAQPg+5ODlMr9aiGQS6x8E6gDi8bPtmYTx+FW07+R5Wum7o/edZ/960Gd7F0vRuNEDw4=
X-Received: by 2002:a05:6512:2812:b0:53e:3729:eaf7 with SMTP id
 2adb3069b0e04-53e3729ee24mr4695911e87.34.1733752182380; Mon, 09 Dec 2024
 05:49:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241208183415.21181-1-James.Bottomley@HansenPartnership.com>
 <CAMj1kXEULbHRF4ywSGeRGPJeVe9P5r1D_Gvt55TZBKHvGsEdGw@mail.gmail.com> <e6f802491e912b0907d2990c712210b0350db9aa.camel@HansenPartnership.com>
In-Reply-To: <e6f802491e912b0907d2990c712210b0350db9aa.camel@HansenPartnership.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 9 Dec 2024 14:49:31 +0100
X-Gmail-Original-Message-ID: <CAMj1kXE0o+ct7v+Ab9+auXnWphMXXK5b9iz3vn6nBfuhOu_QRA@mail.gmail.com>
Message-ID: <CAMj1kXE0o+ct7v+Ab9+auXnWphMXXK5b9iz3vn6nBfuhOu_QRA@mail.gmail.com>
Subject: Re: [PATCH 0/3] efivarfs: bug fixes
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: linux-efi@vger.kernel.org, Jeremy Kerr <jk@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 9 Dec 2024 at 14:34, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> On Mon, 2024-12-09 at 10:20 +0100, Ard Biesheuvel wrote:
> > On Sun, 8 Dec 2024 at 19:34, James Bottomley
> > <James.Bottomley@hansenpartnership.com> wrote:
> > >
> > > Patch 1 is stand alone, but 2 depends on 3
> > >
> > > Regards,
> > >
> > > James
> > >
> > > ---
> > >
> > > James Bottomley (3):
> > >   efivarfs: fix error on non-existent file
> > >   efivarfs: fix memory leak on variable removal
> > >   efivarfs: fix incorrect variable creation
> > >
> >
> > Thanks James,
> >
> > I've queued these up now.
>
> Thanks, but I need to redo 3/3: there's a bug where if the variable is
> created to do a write which fails, it remains on the list even though
> the entry is freed.
>

OK. I'm a bit out of my depth here with the VFS stuff.

So efivarfs_create() creates the file and efivarfs_file_write() writes
the contents of the variables, right? So what is the correct behavior
here if the write fails? If the file exists as an empty file, but
might still be open, surely we cannot just drop it from the list?

> It also begs the question: why does this list of variables exist?  All
> it does is cause management complexity and overhead and its only
> function seems to be to free the entries when the filesystem is
> unmounted, which could much more easily be accomplished by implementing
> a superblock evict_inode() callback that kfree's i_private, which would
> mean the entry was freed when the inode was and thus wouldn't have to
> be explicitly freed anywhere.
>

I have no idea - this code existed before I got involved with EFI.

However, a related issue came up here [0]: the list may get out of
sync after a resume from hibernate, and so it needs to be brought up
to date. Not having a list in the first place seems like a step in the
right direction, as we'd need to synchronize that with the updated
varstore as well.

So IIUC, you are suggesting to keep the caching behavior of the name
and attributes, but not keep a list at all? Would that work with the
needed resync above?


[0] https://github.com/systemd/systemd/pull/35497

