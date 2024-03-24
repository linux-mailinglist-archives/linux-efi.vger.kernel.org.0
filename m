Return-Path: <linux-efi+bounces-868-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87BAD887BCD
	for <lists+linux-efi@lfdr.de>; Sun, 24 Mar 2024 06:54:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D85F2823C1
	for <lists+linux-efi@lfdr.de>; Sun, 24 Mar 2024 05:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F7B1400B;
	Sun, 24 Mar 2024 05:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=craftyguy.net header.i=@craftyguy.net header.b="FRt+yN14"
X-Original-To: linux-efi@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B55112E7C
	for <linux-efi@vger.kernel.org>; Sun, 24 Mar 2024 05:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711259639; cv=none; b=KZyjhA4q9rEbjfn/hy4pLuNURAslZasclxndLLyp+N2NjTnzrtW5cufL1jCOQC929b30Zhmrxg/krbYkki0E3yr+cNArckKqUdX0sJHWwrNQJDcOvsfy0fvlTwQe4kdRfScz+gVFO6+G4OiWu9Vg4exwkCTNq5CDp16OEYYR7Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711259639; c=relaxed/simple;
	bh=k6K1qJsbWkoTQwo17/BGCwBZeOrK8asEP4jPl+ndMqc=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=E+Ebt4hG+KiKyS8m9u7KgVND7ojSpl8HXrwlImKTa/w8HQG2HRn3CAQ/8nQez1u6MaHwEmyxfOUDhD9482za8HSMshmb+Nx9ODffUMoq5ZO4KtvlqZC+fviUv/zRucuuYXoD55xG7zsha5S3YmF9MTlxCjtewFi9MhPK/IrnCwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=craftyguy.net; spf=pass smtp.mailfrom=craftyguy.net; dkim=pass (2048-bit key) header.d=craftyguy.net header.i=@craftyguy.net header.b=FRt+yN14; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=craftyguy.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=craftyguy.net
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=craftyguy.net;
	s=key1; t=1711259634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9noNjRG5J01WXAhzTC1re8jGZ/L4ci7PArNMcz5zSdQ=;
	b=FRt+yN14LDuW1S6eg8vkC3y3RQTlw8VeiBduPXcNaOVh2vzfl3Zr4moDi2HpyjFMUdKOG7
	iJpbQ2XpTeuM7oTLaEpRiPsG511uyJ0jk2Wv6FictZ5XD6ZyQeFKhhkxMA5EEqqk+2hvgg
	xURZ9BsoXz99aUh/+kz7tnMFILdhGP2a6DrluqaWS/MIX/hP0g8f6OhQK0YGNYScJmDd9j
	RTLTehHG3wy9zfyT83xUbnTJA26G5wviE+rTe4eQsvJM069gvwCJQFBS0JdHI+SQsQgQzb
	84VwvrMMSuLUGL6hyCjqGVmpioNzTJXPOWF2Jqi8B3uxNV/it1K5/uBGpUSndw==
Date: Sun, 24 Mar 2024 05:53:52 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Clayton Craft" <clayton@craftyguy.net>
Message-ID: <2a15095b2b6343f63e228443d9fd3f35872b6d09@craftyguy.net>
TLS-Required: No
Subject: Re: x86_64 32-bit EFI mixed mode boot broken
To: "Ard Biesheuvel" <ardb@kernel.org>
Cc: "Hans de Goede" <hdegoede@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org, "Thomas
 Gleixner" <tglx@linutronix.de>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>, "Dave Hansen"
 <dave.hansen@linux.intel.com>, regressions@lists.linux.dev
In-Reply-To: <CAMj1kXHEJuZH4GsPKpu2vn6NQtKq1FBUtb-Rkfatwa63brgXpw@mail.gmail.com>
References: <20240321150510.GI8211@craftyguy.net>
 <CAMj1kXGzH4TiwvSF3bZsJpuuWf04Ri_852fUMTdH8pLRaH3+Yg@mail.gmail.com>
 <20240321170641.GK8211@craftyguy.net>
 <CAMj1kXE-sxGM2H8akunJ1mZPDSVX1+2ehDtK-jqW--8tw9J5LA@mail.gmail.com>
 <20240322091857.GM8211@craftyguy.net>
 <CAMj1kXFmnv+FGRMnnJMJejj5yvSybgZTNEYZz0hxb6K9VAeo1Q@mail.gmail.com>
 <fe09869c2d853bde8ce0feb537c4dab09014f5d9@craftyguy.net>
 <CAMj1kXEH4CTnQ3d+Z-TnqNUhFaFc1yH+Eaa6cHk9-vZ_geQ2nw@mail.gmail.com>
 <8a64ba697d719bc9750e6fffc268e194dfde16e5@craftyguy.net>
 <CAMj1kXEk=7_BoaavZtZs7giBq4Kwk-QQoNjMZS=rWLJP=LdVLw@mail.gmail.com>
 <CAMj1kXHEJuZH4GsPKpu2vn6NQtKq1FBUtb-Rkfatwa63brgXpw@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

March 23, 2024 at 10:18 AM, "Ard Biesheuvel" <ardb@kernel.org> wrote:
> On Sat, 23 Mar 2024 at 14:39, Ard Biesheuvel <ardb@kernel.org> wrote:
> >=20
>=20>  OK.
> >=20
>=20>  I have reshuffled the branch and put the patch you identified as t=
he
> >=20
>=20>  one fixing the boot first. Please double check whether this change
> >=20
>=20>  still fixes the boot for you.
> >=20
>=20>  https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log=
/?h=3Defi-clayton-2
> >=20
>=20>  If so, we can try applying it to mainline, and merge it if it work=
s there too.

This branch boots on my Bay Trail systems.


> I have a mainline branch with the same change applied, please try that =
one too.

I assume this is the `efi-mixed-mode-boot-hack` branch, if so then this b=
ranch also boots on these systems.

-Clayton

