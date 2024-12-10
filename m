Return-Path: <linux-efi+bounces-2339-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9849EB19D
	for <lists+linux-efi@lfdr.de>; Tue, 10 Dec 2024 14:04:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 319A41881F04
	for <lists+linux-efi@lfdr.de>; Tue, 10 Dec 2024 13:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757101A0B15;
	Tue, 10 Dec 2024 13:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="q4pb9jgd";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="Agwvew+k"
X-Original-To: linux-efi@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03021A3AB1;
	Tue, 10 Dec 2024 13:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733835879; cv=none; b=ac48H2s8tOixN40dCMNMWtg+5Cx9CAmGze67h5yFdG6Vxziy0lh2j6emwoUY7XFSAg8C7XeuwTrHgOWuXfdTcMCZezxyaTpV2nnAZZYytjSn7HpZdbWGhFeAw0PbG+bPgRS5LmnneNJzTM10IIk/HQoXX5UjBzS+mJp50D23ZDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733835879; c=relaxed/simple;
	bh=VvN9FYSNCkoFMcyKSVhsCAhYYZInwHxYGswpfrol008=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QQWXvDe7kHD/pDrQIGmvRhT5g7wmpWZOpYAYVF9TfAlFjIpR7uWRMeXCqrF5MrDApIgScoZ573N8Fl6Nl15C2WFcjv5ckja6Bw969G7/bfCKplu58mBY1ZqmSOlCKl8oCz7zB7phv04aKEx930bNsfyePFOIUh9hnR+CNKKRyJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=q4pb9jgd; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=Agwvew+k; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1733835875;
	bh=VvN9FYSNCkoFMcyKSVhsCAhYYZInwHxYGswpfrol008=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=q4pb9jgdNlZbY44rtSzRs3lUbKsNjG2m4n4aSrhmF8fJvyM5esDOC5HH46FSO7D2m
	 k7iPOfGUPTLdCpcM7ctapOr2iDGYKyud8DEkB3CndG4OKXh2J7Qyk/f+A/LFnGj1Ou
	 75f/yq5UmWB9TUS+1MQrnWezOFkNDCecW1QA0KyM=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 82F311285CB9;
	Tue, 10 Dec 2024 08:04:35 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id D6ffbscE564v; Tue, 10 Dec 2024 08:04:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1733835873;
	bh=VvN9FYSNCkoFMcyKSVhsCAhYYZInwHxYGswpfrol008=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=Agwvew+kq96tTSc8V8kGL4qi3wVcVNhcqLLY6ophzYlXn6CgeYsPw7SSmTMJ0uPQD
	 M2toeMnTbJN0fWsQH5BKItdQHVIKxOX4F2j5XWQnCF0Owcf5iIndSThiYk8C1aUlYR
	 JRMD7KJpKfKkcGZle3n0cpeqX/Q8E3Jh7EsiPxD4=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 26EA5128165E;
	Tue, 10 Dec 2024 08:04:33 -0500 (EST)
Message-ID: <878beebf9064abb7911c015d894192077f17ef0b.camel@HansenPartnership.com>
Subject: Re: TPM/EFI issue [Was: Linux 6.12]
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Jiri Slaby <jirislaby@kernel.org>, Jarkko Sakkinen <jarkko@kernel.org>, 
 Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>
Cc: Peter =?ISO-8859-1?Q?H=FCwe?= <PeterHuewe@gmx.de>, Jason Gunthorpe
 <jgg@ziepe.ca>, linux-integrity@vger.kernel.org, Ard Biesheuvel
 <ardb@kernel.org>,  "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>
Date: Tue, 10 Dec 2024 08:04:31 -0500
In-Reply-To: <b33007e9-c468-4395-8eac-8e0f9860562a@kernel.org>
References: 
	<CAHk-=wgtGkHshfvaAe_O2ntnFBH3EprNk1juieLmjcF2HBwBgQ@mail.gmail.com>
	 <9c893c52-e960-4f30-98ce-ba7d873145bb@kernel.org>
	 <D5Z66HQJNNNL.1CPU2KF13269F@kernel.org>
	 <39f16df2-9f4b-49e9-b004-b0e702d08dad@kernel.org>
	 <D65GMNDAP2VG.1OM0JQG5Q934M@kernel.org>
	 <D676OAD5YQU7.26INY71381WIO@kernel.org>
	 <b33007e9-c468-4395-8eac-8e0f9860562a@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Tue, 2024-12-10 at 07:13 +0100, Jiri Slaby wrote:
[...]
> Perhaps, you can give a hint why those happen exclusively with 6.12+?

For which one: the ramdisk size not being modulo 4 or the unseal
getting a PCR changed error?  For the former I don't have much of an
idea, it would seem to be a dracut (or whatever initrd builder you use)
issue; the kernel doesn't care about the ramdisk size.  For the latter,
I would suspect something is delaying IMA measurements such that
they're still going on when you're trying to unseal.  The error you're
getting occurs if any PCR changes, not just the ones the policy is
locked to (thanks TCG).  We have had syzbot reports of processes
getting stuck in measurement that have been identified as exfat
related:

https://syzkaller.appspot.com/bug?extid=1de5a37cb85a2d536330

But it could be a more generic filesystem issue that measurement is
slowing but not enough to trigger the stuck process warning.

In particular systemd parallelizes a lot of stuff, so if it's doing
something that causes IMA measurement in parallel with the unseal and
this parallel process finished before unseal on an earlier kernel, that
would explain it.  You could probably verify this by adding more
dependencies to the tpm target, but I'm not really well versed in
systemd.

Regards,

James


