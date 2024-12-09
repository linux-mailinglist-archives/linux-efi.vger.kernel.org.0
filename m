Return-Path: <linux-efi+bounces-2325-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABBA39E952F
	for <lists+linux-efi@lfdr.de>; Mon,  9 Dec 2024 13:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 821221656B3
	for <lists+linux-efi@lfdr.de>; Mon,  9 Dec 2024 12:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D380B2500A8;
	Mon,  9 Dec 2024 12:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CEl8K0CG"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9831F238759;
	Mon,  9 Dec 2024 12:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733748856; cv=none; b=QnVKcAS0nWwYREDg2KIlLod/0HbD4v/ph49vyzNdRVoNDPykBDhtNqJe3KOgIA2YzUDGSrsg1rFD4uaI6Um0a7xu+yqr1e107BC944+MueTUH3wJNt/Wtd6AjPTvRKOyQoA9Sg/auxr7XFM7TiyMBRY7r0UuLU1svGFX0B85wR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733748856; c=relaxed/simple;
	bh=0lz30qD1y1+rEtIXsDpq+djUbafzcUlUtCck/+flSX4=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=o2Dsqvo+d7gYBBTYoVvJ4NmwtaH6V/gL/p+noRS54LiXggiWEEm/YFkcvl73US1QO8HxSjRp6WlvZMlmwQ/i+BCjWVOwE+Ok4qx9cVpB3jb4wHzg+Hz5l2bXN3M4JMyvDxp5o4Rd01aZnktQKO7eRwCoPafMv5zWzi0siP4wouM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CEl8K0CG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AE8FC4CED1;
	Mon,  9 Dec 2024 12:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733748856;
	bh=0lz30qD1y1+rEtIXsDpq+djUbafzcUlUtCck/+flSX4=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=CEl8K0CGM7DRb6e0F3zTTS/oT4vy05t4fuXb/nFjaS5YXLRA38BmZsbrXMxJlO9p1
	 CXvlm3Gbw/Qf/vozdVBGzDyflP61gO4gN4lM4zD3PD1VwkOHWg7+14rHHxwovWy3FM
	 RyPBNMRAJFXYBhGIl4LRC6GCuUxjg9usWXBFMKNBbl5yNZNJv0eteXj2p6djqrMJo0
	 8ogTewJpSNTkGiRxtBG/H4QsrNL/zkB6BN02tCGi0WL7dANfWYN4tTs0SQzmop3CMp
	 KzHJo4/0XNyEKayZaPQX1U+8Q5PUd0fRAOqM2exjr9brbHen6MN7sjqvwywqkgvLrn
	 SuRXXcAV4u/6Q==
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 09 Dec 2024 14:54:10 +0200
Message-Id: <D676OAD5YQU7.26INY71381WIO@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Jiri Slaby"
 <jirislaby@kernel.org>, "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Cc: =?utf-8?q?Peter_H=C3=BCwe?= <PeterHuewe@gmx.de>, "Jason Gunthorpe"
 <jgg@ziepe.ca>, <linux-integrity@vger.kernel.org>, "Ard Biesheuvel"
 <ardb@kernel.org>, "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>
Subject: Re: TPM/EFI issue [Was: Linux 6.12]
From: "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.18.2
References: <CAHk-=wgtGkHshfvaAe_O2ntnFBH3EprNk1juieLmjcF2HBwBgQ@mail.gmail.com> <9c893c52-e960-4f30-98ce-ba7d873145bb@kernel.org> <D5Z66HQJNNNL.1CPU2KF13269F@kernel.org> <39f16df2-9f4b-49e9-b004-b0e702d08dad@kernel.org> <D65GMNDAP2VG.1OM0JQG5Q934M@kernel.org>
In-Reply-To: <D65GMNDAP2VG.1OM0JQG5Q934M@kernel.org>

On Sat Dec 7, 2024 at 2:16 PM EET, Jarkko Sakkinen wrote:
> On Mon Dec 2, 2024 at 9:52 AM EET, Jiri Slaby wrote:
> > On 30. 11. 24, 3:49, Jarkko Sakkinen wrote:
> > > On Wed Nov 27, 2024 at 8:46 AM EET, Jiri Slaby wrote:
> > >> Cc TPM + EFI guys.
> > >>
> > >> On 17. 11. 24, 23:26, Linus Torvalds wrote:
> > >>> But before the merge window opens, please give this a quick test to
> > >>> make sure we didn't mess anything up. The shortlog below gives you =
the
> > >>> summary for the last week, and nothing really jumps out at me. A
> > >>> number of last-minute reverts, and some random fairly small fixes
> > >>> fairly spread out in the tree.
> > >>
> > >> Hi,
> > >>
> > >> there is a subtle bug in 6.12 wrt TPM (in TPM, EFI, or perhaps in
> > >> something else):
> > >> https://bugzilla.suse.com/show_bug.cgi?id=3D1233752
> > >>
> > >> Our testing (openQA) fails with 6.12:
> > >> https://openqa.opensuse.org/tests/4657304#step/trup_smoke/26
> > >>
> > >> The last good is with 6.11.7:
> > >> https://openqa.opensuse.org/tests/4648526
> > >>
> > >> In sum:
> > >> TPM is supposed to provide a key for decrypting the root partitition=
,
> > >> but fails for some reason.
> > >>
> > >> It's extremely hard (so far) to reproduce outside of openQA (esp. wh=
en
> > >> trying custom kernels).
> >
> > Mark "X".
> >
> > >> Most of the 6.12 TPM stuff already ended in (good) 6.11.7. I tried t=
o
> > >> revert:
> > >>     423893fcbe7e tpm: Disable TPM on tpm2_create_primary() failure
> > >> from 6.12 but that still fails.
> > >>
> > >> We are debugging this further, this is just so you know.
> > >>
> > >> Or maybe you have some immediate ideas?
> > >=20
> > > Nothing immediate but I've had to tweak quite a lot of TPM bus
> > > integrity protection feature so it is a possibility that I've
> > > made a mistake in a point or another.
> > >=20
> > > Can you bisect the issue possibly?
> >
> > No, see mark "X" :).
> >
> > But follow the downstream bug for progress:
> > https://bugzilla.suse.com/show_bug.cgi?id=3D1233752
>
> Just came back from company retrite from BCN.
>
> I can follow this but cannot comment because I've never been
> able to get a bugzilla account working for any of SUSE infra
> :-)
>
> I was actually surprised that I'm able to view the bug at
> all... Bookmarked it and this thread from lore and revisit
> like in the middle of the week (my calendar is filled with
> meetings Mon/Tue).

Hmm... OK, so no action from my side I guess (sorry if I ignored
something did not read every single comment)?

BR, Jarkko

