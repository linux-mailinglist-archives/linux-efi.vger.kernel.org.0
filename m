Return-Path: <linux-efi+bounces-2377-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 687CB9F1C78
	for <lists+linux-efi@lfdr.de>; Sat, 14 Dec 2024 04:54:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F51D1667D2
	for <lists+linux-efi@lfdr.de>; Sat, 14 Dec 2024 03:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C06C182BC;
	Sat, 14 Dec 2024 03:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o/bpPLUl"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9D12E403;
	Sat, 14 Dec 2024 03:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734148472; cv=none; b=pZ/yw6xPSyUGbAdSrqjGDik/wt/azbfRo1Vcy/pMX0YuRYdlxNaAj99cJ9EubPtdM4b5+oL8yeyNMVQYauHG/G6VwNc+C8M774d5rfj9IUPqy+YukkiJECyoF2S9gR7LoIpkvbtaV8LXAERkbdLpS4kKHtf6IXg5tyAkWLuLcTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734148472; c=relaxed/simple;
	bh=pkMggiR4I9xyqrzBwGdVtJ5InOhQ3pMI9hdzFsc3fVs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=mIBm2BG7Z6TmCY9aNErzhqeR1Dehmw3ACjI2+6fIgcTr1KFQaaQFvTKF+XvkTDdHB39djF50DA8EBQfZUPY7I18ozO3yiZ8umtN1QpWpGUeX0OU7YZTKh5+FHvH/VLct9/ui6EafoX5MBpzZ7fUs0oJH+LtTiDavxi5lLDQRKIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o/bpPLUl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A20DFC4CED1;
	Sat, 14 Dec 2024 03:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734148471;
	bh=pkMggiR4I9xyqrzBwGdVtJ5InOhQ3pMI9hdzFsc3fVs=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=o/bpPLUloyN5mPTJXnop1A3x//2oqdw3fGfEh0BauhlMkMaZS5g/7pkB8qAIjnLue
	 U5mUipwzsWZqHd+3f0NCnyd8qmFEIpRE3UVtmDoXpyFykLsNvu4qoK16Eq/q7IMOSo
	 ghF31vgDN2dbxibVIBzqjwYF2rOmPNftnHywNiYdAiX3UoLArScxoqRNHCLIy1KjiU
	 Q6K1FR9zJoLXQmqWL3UjHgpnqR4sam8b/x76yTh5gMUYmvrtMfM1T+dVIaK6t+UAr9
	 WEper+Rc7axBvadIYXcGXRN+53AsIRpSMO5dGOogYHbu7zJsHURNMOWPu9x3hoXSGq
	 rqudibqoDXEmQ==
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 14 Dec 2024 05:54:26 +0200
Message-Id: <D6B4BRNN9S4U.IJ3IU91D6YRB@kernel.org>
Cc: =?utf-8?q?Peter_H=C3=BCwe?= <PeterHuewe@gmx.de>, "Jason Gunthorpe"
 <jgg@ziepe.ca>, <linux-integrity@vger.kernel.org>, "Ard Biesheuvel"
 <ardb@kernel.org>, "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>
Subject: Re: TPM/EFI issue [Was: Linux 6.12]
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "James Bottomley" <James.Bottomley@HansenPartnership.com>, "Jiri Slaby"
 <jirislaby@kernel.org>, "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.18.2
References: <CAHk-=wgtGkHshfvaAe_O2ntnFBH3EprNk1juieLmjcF2HBwBgQ@mail.gmail.com> <9c893c52-e960-4f30-98ce-ba7d873145bb@kernel.org> <D5Z66HQJNNNL.1CPU2KF13269F@kernel.org> <39f16df2-9f4b-49e9-b004-b0e702d08dad@kernel.org> <D65GMNDAP2VG.1OM0JQG5Q934M@kernel.org> <D676OAD5YQU7.26INY71381WIO@kernel.org> <b33007e9-c468-4395-8eac-8e0f9860562a@kernel.org> <878beebf9064abb7911c015d894192077f17ef0b.camel@HansenPartnership.com>
In-Reply-To: <878beebf9064abb7911c015d894192077f17ef0b.camel@HansenPartnership.com>

On Tue Dec 10, 2024 at 3:04 PM EET, James Bottomley wrote:
> On Tue, 2024-12-10 at 07:13 +0100, Jiri Slaby wrote:
> [...]
> > Perhaps, you can give a hint why those happen exclusively with 6.12+?
>
> For which one: the ramdisk size not being modulo 4 or the unseal
> getting a PCR changed error?  For the former I don't have much of an
> idea, it would seem to be a dracut (or whatever initrd builder you use)
> issue; the kernel doesn't care about the ramdisk size.  For the latter,
> I would suspect something is delaying IMA measurements such that
> they're still going on when you're trying to unseal.  The error you're
> getting occurs if any PCR changes, not just the ones the policy is
> locked to (thanks TCG).  We have had syzbot reports of processes
> getting stuck in measurement that have been identified as exfat
> related:
>
> https://syzkaller.appspot.com/bug?extid=3D1de5a37cb85a2d536330
>
> But it could be a more generic filesystem issue that measurement is
> slowing but not enough to trigger the stuck process warning.
>
> In particular systemd parallelizes a lot of stuff, so if it's doing
> something that causes IMA measurement in parallel with the unseal and
> this parallel process finished before unseal on an earlier kernel, that
> would explain it.  You could probably verify this by adding more
> dependencies to the tpm target, but I'm not really well versed in
> systemd.

Yeah, I agree. This is too much looking for needle from the haystack.
A bit more evidence for kernel issue is needed than just kernel version
change in order to make progress.

> Regards,
>
> James

BR, Jarkko

