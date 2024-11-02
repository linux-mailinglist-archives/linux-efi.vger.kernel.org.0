Return-Path: <linux-efi+bounces-2117-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B4A9BA0AD
	for <lists+linux-efi@lfdr.de>; Sat,  2 Nov 2024 15:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 013FE1F21A64
	for <lists+linux-efi@lfdr.de>; Sat,  2 Nov 2024 14:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98FA419AD5C;
	Sat,  2 Nov 2024 14:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IOcQWZtR"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AE419BBA;
	Sat,  2 Nov 2024 14:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730556429; cv=none; b=kjxJs7g6yyCzYPP5yHHdlhEgkKpoL2iUYXnF9szTnsWD41MLHo2OLfgCtbRu/eByIyaKlvmkJu7qKrw19UZo27JiHZhcwcZ3yPtXj2gv+3NxkHNZEgxSwAylr9skuSd7+bRTKemioNdZuVJrNAzZJzWeuxNv9DubvAikSesI3O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730556429; c=relaxed/simple;
	bh=Q821xsKXoJpJAxa6aZg5/VMu9xAoqVqBnQJhUqyV72k=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=jgsV+QGuMQjPNiEiIkMXj6ZLk/3Q8RmxsU8ERcu33bK6fUlfd0Yr0/nWUHec34xLtJPMgajo4HLcGQAey4KZ/DarIhWIBnUPcxXej2cejZ8hMtZviL3a5ZnrZg13yh2pS+sTyd5Ehin2EHOCgd6ZQ3np2h6hEFVsq4WxGT66iwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IOcQWZtR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56207C4CEC3;
	Sat,  2 Nov 2024 14:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730556429;
	bh=Q821xsKXoJpJAxa6aZg5/VMu9xAoqVqBnQJhUqyV72k=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=IOcQWZtRAPtxYRkzOQxHHSquppDz8lzAFNi0f/YvjS7tasWa59/bNiUZYoNhNkaX2
	 yiReHqnCuWv9KDvpJLznhKnSsAM/GWuiXTf6mS0qOY6QPIHUAoKFMBOSI4jV0K4Qjd
	 tHv7ujaIKeF+1aJbmQy7dIifP3mYPQtwAWb5Lo23Etmo8Xzwx8681roOg5DpJ2F05/
	 27dvBPeEX5Ez7GkT+sorULpAYaC2bfUN5oyUPyyrhbqCrxQCayb1kxPUiu7RScXEiw
	 YZ9L3gwbDqvznQ5inQSWLuVdcZoJwqQHEi48Do7mIljbZSCjNNRjtznzvIilf0QzQZ
	 6pbXxvUPnwrlA==
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 02 Nov 2024 16:07:04 +0200
Message-Id: <D5BR1YBPGPWG.28WTN4GE8V87N@kernel.org>
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
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Ard Biesheuvel"
 <ardb@kernel.org>
X-Mailer: aerc 0.18.2
References: <D5BB5GX4KEUO.VJ2G9G9QKYRR@kernel.org>
 <20241102062259.2521361-1-jarkko@kernel.org>
 <D5BHBW3NUS5C.293GUI03HMTCF@kernel.org>
 <CAMj1kXGk8y=rZiNiDcD-8mDKJB5HkTowM7g+kjO6616MGdTQaQ@mail.gmail.com>
 <D5BMMJYMVWKJ.3MIGB8KW34PR2@kernel.org>
 <CAMj1kXExMWBAx7geuU8Uwp9CQLpJyTgYmWUw2CtKd3xT8mMFsg@mail.gmail.com>
 <D5BQGY5425TQ.3U6N698H2KYWO@kernel.org>
In-Reply-To: <D5BQGY5425TQ.3U6N698H2KYWO@kernel.org>

On Sat Nov 2, 2024 at 3:39 PM EET, Jarkko Sakkinen wrote:
> int tpm_chip_set_locality(struct tpm_chip *chip, u8 locality)
> {
> 	int ret;
>
> 	if (locality >=3D TPM_MAX_LOCALITY)
> 		return false;
>
> 	ret =3D tpm_try_get_ops(chip);
> 	if (ret)
> 		return ret;
>
> 	chip->default_locality =3D locality;
>
> 	tpm_put_ops(chip);
> 	return 0;
> }
> EXPORT_SYMBOL_GPL(tpm_chip_set_locality);

Other things to take from 1/2 of my RFC to this:

1. Must be one-shot.
2. Must be only for tpm_tis as this is made to work only with that
   driver. E.g. 15/20 is only for tpm_tis. I guess that is the
   main target anyway here. Future patch sets can extend this to
   other drivers.

TPM_CHIP_FLAG_SET_LOCALITY_ENABLED use in 1/2 can be referenced
for a solution.

Kernel command-line parameter: I agree not having it if no need
for ioctl, so that is addressed too.

BR, Jarkko

