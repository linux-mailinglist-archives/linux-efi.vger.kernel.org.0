Return-Path: <linux-efi+bounces-2240-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C000A9DEEC3
	for <lists+linux-efi@lfdr.de>; Sat, 30 Nov 2024 03:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E8B51634E4
	for <lists+linux-efi@lfdr.de>; Sat, 30 Nov 2024 02:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52B527447;
	Sat, 30 Nov 2024 02:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="noWrXOaU"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50101C6A3;
	Sat, 30 Nov 2024 02:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732934981; cv=none; b=XOEpXrNyLN9Cl2iYmOqciAimidiRhGvwHDIO4n3SiCLsSK4/xF/PuIX0oy+GXIMdZU28EXLo+rMekLz+ag4WrOSyWApbHN6Tg8+UX2ArURLrDgchdhiTj3xdVJpSG3AZe72GFdJuTGPtXFO08H/jHthONAaUoa1aR7EZRK/E4Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732934981; c=relaxed/simple;
	bh=ryF+qSkqVocP8Q4nMQlUJFApq2PR5cRWvM7XoEn5JvQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=f6F3MFyz65VYiS2Qpd0g8WvW94onidr1f1GcmsRgBS3AVVwO9s5hk2s0ESEAIfHV6TEmGE1GXx+OjfMIA9ThPnepUMgtHfnRUXhSY4+ocZQcksqNrpHSHCCMf+CzCIombLKlVltM8j9vnJiHpQ7qA33x71d3zYm3i7hXlOHIaIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=noWrXOaU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ED42C4CECF;
	Sat, 30 Nov 2024 02:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732934981;
	bh=ryF+qSkqVocP8Q4nMQlUJFApq2PR5cRWvM7XoEn5JvQ=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=noWrXOaUQ0sMo/y/xuCrTMv2wF015vo9cSBB4trag15/84jyTEvnkv/XLDVgC95YG
	 q5XmlwLoRTdwEm6q3UZEPu5SdRtQMM84Ah2FrdT2RnkrYTSg1cOIuL9oN3IiGqDPUN
	 Hwxq9z60PCV7BIV4yzL0ORekLZ0ND5qyunBostX7SsFp8TgSoFycZhzDJNTUnSbOO9
	 Mi9Y+3NCohBfFhBYGB1ByPqPJCNggRW/jLiaQmAiraqc3i7v27XUQ+RLEaDDNXOnw6
	 ESBT0aG3IRrJBhCb9Y/59pj2IvGI1FS1MmQT589lHsCaiagUqonY/jmuwHiyjIVXE4
	 WB666iRtqc2Ww==
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 30 Nov 2024 04:49:36 +0200
Message-Id: <D5Z66HQJNNNL.1CPU2KF13269F@kernel.org>
To: "Jiri Slaby" <jirislaby@kernel.org>, "Linus Torvalds"
 <torvalds@linux-foundation.org>, "Linux Kernel Mailing List"
 <linux-kernel@vger.kernel.org>
Cc: =?utf-8?q?Peter_H=C3=BCwe?= <PeterHuewe@gmx.de>, "Jason Gunthorpe"
 <jgg@ziepe.ca>, <linux-integrity@vger.kernel.org>, "Ard Biesheuvel"
 <ardb@kernel.org>, "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>
Subject: Re: TPM/EFI issue [Was: Linux 6.12]
From: "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.18.2
References: <CAHk-=wgtGkHshfvaAe_O2ntnFBH3EprNk1juieLmjcF2HBwBgQ@mail.gmail.com> <9c893c52-e960-4f30-98ce-ba7d873145bb@kernel.org>
In-Reply-To: <9c893c52-e960-4f30-98ce-ba7d873145bb@kernel.org>

On Wed Nov 27, 2024 at 8:46 AM EET, Jiri Slaby wrote:
> Cc TPM + EFI guys.
>
> On 17. 11. 24, 23:26, Linus Torvalds wrote:
> > But before the merge window opens, please give this a quick test to
> > make sure we didn't mess anything up. The shortlog below gives you the
> > summary for the last week, and nothing really jumps out at me. A
> > number of last-minute reverts, and some random fairly small fixes
> > fairly spread out in the tree.
>
> Hi,
>
> there is a subtle bug in 6.12 wrt TPM (in TPM, EFI, or perhaps in=20
> something else):
> https://bugzilla.suse.com/show_bug.cgi?id=3D1233752
>
> Our testing (openQA) fails with 6.12:
> https://openqa.opensuse.org/tests/4657304#step/trup_smoke/26
>
> The last good is with 6.11.7:
> https://openqa.opensuse.org/tests/4648526
>
> In sum:
> TPM is supposed to provide a key for decrypting the root partitition,=20
> but fails for some reason.
>
> It's extremely hard (so far) to reproduce outside of openQA (esp. when=20
> trying custom kernels).
>
> Most of the 6.12 TPM stuff already ended in (good) 6.11.7. I tried to=20
> revert:
>    423893fcbe7e tpm: Disable TPM on tpm2_create_primary() failure
> from 6.12 but that still fails.
>
> We are debugging this further, this is just so you know.
>
> Or maybe you have some immediate ideas?

Nothing immediate but I've had to tweak quite a lot of TPM bus
integrity protection feature so it is a possibility that I've
made a mistake in a point or another.

Can you bisect the issue possibly?

PS. I'm travelling next week in Spain so next time I can debug
the issue is +1 week from now (just so that you know).

BR, Jarkko

