Return-Path: <linux-efi+bounces-2115-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 387E09BA093
	for <lists+linux-efi@lfdr.de>; Sat,  2 Nov 2024 14:39:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB8E7281A76
	for <lists+linux-efi@lfdr.de>; Sat,  2 Nov 2024 13:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9910198A3B;
	Sat,  2 Nov 2024 13:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="um5mVVfu"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED9B18BBA2;
	Sat,  2 Nov 2024 13:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730554785; cv=none; b=UVt9+4OAKUDRNT8jAU734NqhHyibru9T67F5Gsy6Cz+HqXgoRj1BinO7tV+6wpbysqX6JT4QqDqyCVCxAPftOYeHFR1wQ3i6L1hysAXnqboB6irqQ2jJn9dCtZn0w51YOdNPnt0Qu/dBwRf46ZcCBZrP8kUqs6Qa7Hbrb4hrnDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730554785; c=relaxed/simple;
	bh=sxBligjgKTVDk7jjHZnmdCYx6SXn35Wcjb9+LxenKDs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=OppJJp8iGZStFVyBHXz9lAELuZqL+vKRf7XlgIUlkUFm3oyOCpmzJ7hEIVIX4+yeYkPvLqo3XT3IUx+HJbHicRl+2EN6y/27e+z+UXta2ucxo+NUAtuRz/gYfhWE6Rsua0Nt4C9WfqWoN/60BOzWeR5jmlPKw3KyINr0R15pfE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=um5mVVfu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74441C4CEC3;
	Sat,  2 Nov 2024 13:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730554783;
	bh=sxBligjgKTVDk7jjHZnmdCYx6SXn35Wcjb9+LxenKDs=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=um5mVVfufD7+UoTS8jMDsamcAhTuEjg6A0ORTzlgu/Q9HKzwpAFL8iOUXfTlXE6SC
	 /p0QR+RtUL9Lu/NsyzijhcdmJ7LLTFvDK0Il25LCvW5ro0aSLqy/cuIPeFJ32CNN2d
	 EN4I7xt4Fqi1xj5fDmEMseVMu5/OUto2eSx8ZhLDvnZMjfVKzFYlhNY8zClW0aRoFG
	 GmnpSIGDIQLBPeArr7ea6SBJDNPyFj71iMd+Eof2IlOmyJdsGPcPMohuEw0fPsUw9F
	 tW483OucMVL5HcSVaPNMb/aegWoBkcTzRpZ2wAr6Pd1DE/c0yJRZl0s9Ce3WF6t1SA
	 LbSvkCk/SYRMQ==
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 02 Nov 2024 15:39:38 +0200
Message-Id: <D5BQGY5425TQ.3U6N698H2KYWO@kernel.org>
Cc: "Jonathan Corbet" <corbet@lwn.net>, "Peter Huewe" <peterhuewe@gmx.de>,
 "Jason Gunthorpe" <jgg@ziepe.ca>, <James.Bottomley@hansenpartnership.com>,
 <andrew.cooper3@citrix.com>, <baolu.lu@linux.intel.com>, <bp@alien8.de>,
 <dave.hansen@linux.intel.com>, <davem@davemloft.net>,
 <dpsmith@apertussolutions.com>, <dwmw2@infradead.org>,
 <ebiederm@xmission.com>, <herbert@gondor.apana.org.au>, <hpa@zytor.com>,
 <iommu@lists.linux-foundation.org>, <kanth.ghatraju@oracle.com>,
 <kexec@lists.infradead.org>, <linux-crypto@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-efi@vger.kernel.org>,
 <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <luto@amacapital.net>, <mingo@redhat.com>, <mjg59@srcf.ucam.org>,
 <nivedita@alum.mit.edu>, <ross.philipson@oracle.com>, <tglx@linutronix.de>,
 <trenchboot-devel@googlegroups.com>, <x86@kernel.org>
Subject: Re: [RFC PATCH v2 1/2] tpm, tpm_tis: Introduce TPM_IOC_SET_LOCALITY
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Ard Biesheuvel" <ardb@kernel.org>
X-Mailer: aerc 0.18.2
References: <D5BB5GX4KEUO.VJ2G9G9QKYRR@kernel.org>
 <20241102062259.2521361-1-jarkko@kernel.org>
 <D5BHBW3NUS5C.293GUI03HMTCF@kernel.org>
 <CAMj1kXGk8y=rZiNiDcD-8mDKJB5HkTowM7g+kjO6616MGdTQaQ@mail.gmail.com>
 <D5BMMJYMVWKJ.3MIGB8KW34PR2@kernel.org>
 <CAMj1kXExMWBAx7geuU8Uwp9CQLpJyTgYmWUw2CtKd3xT8mMFsg@mail.gmail.com>
In-Reply-To: <CAMj1kXExMWBAx7geuU8Uwp9CQLpJyTgYmWUw2CtKd3xT8mMFsg@mail.gmail.com>

On Sat Nov 2, 2024 at 12:52 PM EET, Ard Biesheuvel wrote:
> > Short answer: I have no idea. I would not mind that but neither
> > the commit message for TPM give a clue on this. Actually, I *do
> > not care* if it is RO and RW but I'm neither good at guessing
> > random shit.
> >
>
> You were cc'ed on the rest of the series, no?

Yeah, but that does not make sysfs attribute having store operation less
confusing. At minimum 2/2 should replace the current sysfs patch, if
store operation is not required.

> Shall we clarify this first, before proposing patches that introduce
> new ioctls() and kernel command line parameters to a security
> sensitive subsystem?
>
> My reading of 19/20 is that the secure launch module sets the default
> locality, and given that it can be built as a module, setting the
> default locality needs to be exported to modules (but as I indicated,
> this should probably be in a TPM internal module namespace)
>
> If setting the default locality from user space is a requirement down
> the road, we can discuss it then. For now, let's not go off into the
> weeds and derail this series even more.

If sysfs store is not required after all, and only thing that touches
the locality is slmodule, tweaking 17/20's set operation to this would
be good enough for me:

int tpm_chip_set_locality(struct tpm_chip *chip, u8 locality)
{
	int ret;

	if (locality >=3D TPM_MAX_LOCALITY)
		return false;

	ret =3D tpm_try_get_ops(chip);
	if (ret)
		return ret;

	chip->default_locality =3D locality;

	tpm_put_ops(chip);
	return 0;
}
EXPORT_SYMBOL_GPL(tpm_chip_set_locality);

Now that I've worked on this issue I think also 15/20 and 16/20 are
pretty clear I can suggest some tweaks to the commit messages later to
make then more self-explatonery.

BR, Jarkko

