Return-Path: <linux-efi+bounces-2241-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A10779DEEC6
	for <lists+linux-efi@lfdr.de>; Sat, 30 Nov 2024 03:52:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6762A162BEB
	for <lists+linux-efi@lfdr.de>; Sat, 30 Nov 2024 02:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D2C25777;
	Sat, 30 Nov 2024 02:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B/a7Ittg"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81BF1C6A3;
	Sat, 30 Nov 2024 02:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732935152; cv=none; b=Df74te61kei2rXNOd17TldFWIax2FPyVO52YnCLIvpOzv/ZPvE/eEtpg/ppMDUCvamZbn/3XNRHPC28R16dIdPOGMnZm4qfa6vFm/nSeg6FM+10pWfQwEf3aKGZPPpWVXlGEOxB6VsXwsOoWsUpNciDV02Boc/bDWQFzW+ZlZn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732935152; c=relaxed/simple;
	bh=fHWRQmO4yP81OeynpU4hBpuD3ZHHDNiTu7XB61+3hsw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=JhR0jMuDrharBKw4xNQN7hRfFFEFWuwwQmQX73Qmjdx36kH3arHaqerqNjOxBOOc3p9P8iriLvsd9RPaytr21v1x6jpzRoKTHAIJ+I5MpGbJOnF0hiQL7z+x0drGZkhhXOU+skcXK5d1p5cpvwHhiwusoMjp5yet2uT7QF/YgCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B/a7Ittg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9364AC4CECF;
	Sat, 30 Nov 2024 02:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732935152;
	bh=fHWRQmO4yP81OeynpU4hBpuD3ZHHDNiTu7XB61+3hsw=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=B/a7IttgtlBJ5oa0M1pwD6DfR97jekEswJJJeyV2hEyn1+j5q4wY9C3edUFSjPir3
	 0ZzaU2HwlRcFAfqG8x/r3eOOgeWXyqJyKxJ8ySzHw/e2albIo4GKIf82fEyIqCmRQf
	 Nwyjd/gSxPg2s3JkBgI/MvfVNipY3/RCKLxUHqImqsmT3Y0W8bafu35PQmBZfq4uly
	 MPxdasL8hqW6a2CqJ5dh3cMyr9SsFPKfCvHHbPcP/bK67LcKhvNrlR2Nqjujds+ibe
	 MrHujOkrbqwZ03EAQ28oOBQULTBBu7H2eif4zhpPu8e9CD9QkrhaciTWFPeUzqeagg
	 gbN9PEGbC/xzg==
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 30 Nov 2024 04:52:27 +0200
Message-Id: <D5Z68OJZN05H.2KQ5Y2C2SG5QH@kernel.org>
Cc: =?utf-8?q?Peter_H=C3=BCwe?= <PeterHuewe@gmx.de>, "Jason Gunthorpe"
 <jgg@ziepe.ca>, <linux-integrity@vger.kernel.org>, "Ard Biesheuvel"
 <ardb@kernel.org>, "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>
Subject: Re: TPM/EFI issue [Was: Linux 6.12]
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Jiri Slaby"
 <jirislaby@kernel.org>, "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.18.2
References: <CAHk-=wgtGkHshfvaAe_O2ntnFBH3EprNk1juieLmjcF2HBwBgQ@mail.gmail.com> <9c893c52-e960-4f30-98ce-ba7d873145bb@kernel.org> <D5Z66HQJNNNL.1CPU2KF13269F@kernel.org>
In-Reply-To: <D5Z66HQJNNNL.1CPU2KF13269F@kernel.org>

On Sat Nov 30, 2024 at 4:49 AM EET, Jarkko Sakkinen wrote:
> On Wed Nov 27, 2024 at 8:46 AM EET, Jiri Slaby wrote:
> > Cc TPM + EFI guys.
> >
> > On 17. 11. 24, 23:26, Linus Torvalds wrote:
> > > But before the merge window opens, please give this a quick test to
> > > make sure we didn't mess anything up. The shortlog below gives you th=
e
> > > summary for the last week, and nothing really jumps out at me. A
> > > number of last-minute reverts, and some random fairly small fixes
> > > fairly spread out in the tree.
> >
> > Hi,
> >
> > there is a subtle bug in 6.12 wrt TPM (in TPM, EFI, or perhaps in=20
> > something else):
> > https://bugzilla.suse.com/show_bug.cgi?id=3D1233752
> >
> > Our testing (openQA) fails with 6.12:
> > https://openqa.opensuse.org/tests/4657304#step/trup_smoke/26
> >
> > The last good is with 6.11.7:
> > https://openqa.opensuse.org/tests/4648526
> >
> > In sum:
> > TPM is supposed to provide a key for decrypting the root partitition,=
=20
> > but fails for some reason.
> >
> > It's extremely hard (so far) to reproduce outside of openQA (esp. when=
=20
> > trying custom kernels).
> >
> > Most of the 6.12 TPM stuff already ended in (good) 6.11.7. I tried to=
=20
> > revert:
> >    423893fcbe7e tpm: Disable TPM on tpm2_create_primary() failure
> > from 6.12 but that still fails.
> >
> > We are debugging this further, this is just so you know.
> >
> > Or maybe you have some immediate ideas?
>
> Nothing immediate but I've had to tweak quite a lot of TPM bus
> integrity protection feature so it is a possibility that I've
> made a mistake in a point or another.
>
> Can you bisect the issue possibly?
>
> PS. I'm travelling next week in Spain so next time I can debug
> the issue is +1 week from now (just so that you know).

I can check up the situation upcoming week Sat (arriving back to
Finland on Fri night). Anything that you carve up within that
window I'll investigate then. Just don't have the bandwidth now
as I'm packing my things for travel ATM so hope that is no
too much harm.

BR, Jarkko


