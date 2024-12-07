Return-Path: <linux-efi+bounces-2313-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F659E7FCC
	for <lists+linux-efi@lfdr.de>; Sat,  7 Dec 2024 13:17:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD39118844CD
	for <lists+linux-efi@lfdr.de>; Sat,  7 Dec 2024 12:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA05313DBA0;
	Sat,  7 Dec 2024 12:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iY8lGttF"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D6310E0;
	Sat,  7 Dec 2024 12:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733573818; cv=none; b=mq2Uyjq/i/zbkyu1enO6drGgL67xBPbJZlQNnyEGnaH6KK95FTod7/UCAbBx71Q4tiJOsehNa/znlliWpRfJvlwX2i803+I2g1gH7KbIHqpnX4p4sr0Nxw2ccfYTkb6+QzLRHmKPAJuEAJ0BfQN2l+OrOtEdJN7xO42h3HskZ+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733573818; c=relaxed/simple;
	bh=CkElxWvsq/QqHUCfWutc1AcWmJQ8qL47g7SoraOle44=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=MYTB15hiLkeXN4yfhXQPCx7mI/KpXNRENDUaO7vx09+vArTuAp+nZeWVyVtSbpXxNpFPnTaluZOSWE2Ho2bvcdPCWXtyDxidRJtynMpdv1HaYMLPssJPSKfxZPXt57xHPpG8z/VR4YF7ADhboZUguyRuT1uDjYaDb57IP5AtNT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iY8lGttF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FE41C4CECD;
	Sat,  7 Dec 2024 12:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733573818;
	bh=CkElxWvsq/QqHUCfWutc1AcWmJQ8qL47g7SoraOle44=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=iY8lGttFR8MA+KR1z0mS360bSDvsEhdnjbt8UcrCnPdXwD4eE0xKCZe0z9Y8l/wQP
	 8xo+zHAa8qqz7QbO7PkOWH1YIqj6IPKaTHPm11z5zr9/wuvxQEKaScwPGAqr69GBt0
	 e9nOXIIaPWbjz1mb4kCsIjoIrD14p+DHxJDnwIb8Hi2i+a7tKi/x6snFxdZ02rC0lo
	 vi+oERPY2/HMLbdoDFXg4wXmoBtFoC4naJsfFDYuN9h5rNCWiVW/2QLreXJiUkQyN4
	 zRO4u/zwCFHCb5UnpQCp1eNWZidCN1Alm0x/1F2Uv5hJ0YdtCFOTuwtFeDHrSppzKs
	 ICKJeuQZx6QEg==
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 07 Dec 2024 14:16:53 +0200
Message-Id: <D65GMNDAP2VG.1OM0JQG5Q934M@kernel.org>
To: "Jiri Slaby" <jirislaby@kernel.org>, "Linus Torvalds"
 <torvalds@linux-foundation.org>, "Linux Kernel Mailing List"
 <linux-kernel@vger.kernel.org>
Cc: =?utf-8?q?Peter_H=C3=BCwe?= <PeterHuewe@gmx.de>, "Jason Gunthorpe"
 <jgg@ziepe.ca>, <linux-integrity@vger.kernel.org>, "Ard Biesheuvel"
 <ardb@kernel.org>, "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>
Subject: Re: TPM/EFI issue [Was: Linux 6.12]
From: "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.18.2
References: <CAHk-=wgtGkHshfvaAe_O2ntnFBH3EprNk1juieLmjcF2HBwBgQ@mail.gmail.com> <9c893c52-e960-4f30-98ce-ba7d873145bb@kernel.org> <D5Z66HQJNNNL.1CPU2KF13269F@kernel.org> <39f16df2-9f4b-49e9-b004-b0e702d08dad@kernel.org>
In-Reply-To: <39f16df2-9f4b-49e9-b004-b0e702d08dad@kernel.org>

On Mon Dec 2, 2024 at 9:52 AM EET, Jiri Slaby wrote:
> On 30. 11. 24, 3:49, Jarkko Sakkinen wrote:
> > On Wed Nov 27, 2024 at 8:46 AM EET, Jiri Slaby wrote:
> >> Cc TPM + EFI guys.
> >>
> >> On 17. 11. 24, 23:26, Linus Torvalds wrote:
> >>> But before the merge window opens, please give this a quick test to
> >>> make sure we didn't mess anything up. The shortlog below gives you th=
e
> >>> summary for the last week, and nothing really jumps out at me. A
> >>> number of last-minute reverts, and some random fairly small fixes
> >>> fairly spread out in the tree.
> >>
> >> Hi,
> >>
> >> there is a subtle bug in 6.12 wrt TPM (in TPM, EFI, or perhaps in
> >> something else):
> >> https://bugzilla.suse.com/show_bug.cgi?id=3D1233752
> >>
> >> Our testing (openQA) fails with 6.12:
> >> https://openqa.opensuse.org/tests/4657304#step/trup_smoke/26
> >>
> >> The last good is with 6.11.7:
> >> https://openqa.opensuse.org/tests/4648526
> >>
> >> In sum:
> >> TPM is supposed to provide a key for decrypting the root partitition,
> >> but fails for some reason.
> >>
> >> It's extremely hard (so far) to reproduce outside of openQA (esp. when
> >> trying custom kernels).
>
> Mark "X".
>
> >> Most of the 6.12 TPM stuff already ended in (good) 6.11.7. I tried to
> >> revert:
> >>     423893fcbe7e tpm: Disable TPM on tpm2_create_primary() failure
> >> from 6.12 but that still fails.
> >>
> >> We are debugging this further, this is just so you know.
> >>
> >> Or maybe you have some immediate ideas?
> >=20
> > Nothing immediate but I've had to tweak quite a lot of TPM bus
> > integrity protection feature so it is a possibility that I've
> > made a mistake in a point or another.
> >=20
> > Can you bisect the issue possibly?
>
> No, see mark "X" :).
>
> But follow the downstream bug for progress:
> https://bugzilla.suse.com/show_bug.cgi?id=3D1233752

Just came back from company retrite from BCN.

I can follow this but cannot comment because I've never been
able to get a bugzilla account working for any of SUSE infra
:-)

I was actually surprised that I'm able to view the bug at
all... Bookmarked it and this thread from lore and revisit
like in the middle of the week (my calendar is filled with
meetings Mon/Tue).

BR, Jarkko

