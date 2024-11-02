Return-Path: <linux-efi+bounces-2110-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE82D9B9D71
	for <lists+linux-efi@lfdr.de>; Sat,  2 Nov 2024 07:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36A27B211DB
	for <lists+linux-efi@lfdr.de>; Sat,  2 Nov 2024 06:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4732214B959;
	Sat,  2 Nov 2024 06:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ALPVFF+h"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AEDA140E50;
	Sat,  2 Nov 2024 06:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730528997; cv=none; b=qDLw/yyEQBlgH5JnRfBjYo+Egoh/8bSx+42Uc54Q+vIeE5aqqODJ9ufKqaiGluyC1LM+kfEPzRQMW8I87i71Dx/BKJz4/OHDqY3DyA1eOdv81OXa5pq7yzsFroxhkCsOnBBVV1bDynrizj9K/31z3Job7j+4Ypmt31OPz1E4BBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730528997; c=relaxed/simple;
	bh=AejcdqpcwMWOPEQZmVB9jxMS0zZ7y/2eLXzF4TJa3MQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=e+wh7MnUo+o6c6ifcDKdi3mxHo/A7E8kAWE6yjK8a6lz2vd6gO7/WyWv8zqa+ShjeD/x0rrCGGz7nRC8F62jBgYv1z4k2uRzvfZZfbYyOftU50aDHfoDmPJ+PthtPNwauiVngeV8e0/7Gi+KWcPUmjDMMwkgY6417b5KDh6X2sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ALPVFF+h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01092C4CEC3;
	Sat,  2 Nov 2024 06:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730528996;
	bh=AejcdqpcwMWOPEQZmVB9jxMS0zZ7y/2eLXzF4TJa3MQ=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=ALPVFF+hrO9HeqxEgbkfMmsoELwZFdlNAjWivqSYXgwASxpMajXOVTUj9JqmiafsB
	 KcSwhiT9gnGtHYRSDYUBTrKjpzZacYR/g+FbsdwVdavBVsC6skwMbPHj9/C/79OsHs
	 YR44bWFtGZkXZ0glq5nvxEbhQApXhNTqqCoj4m8XUBG5YJc4II9yARjvrUFsaJQHcB
	 gwDfAha47/nHVv9kn2KWpG1oWd0d+1chHquFe2WgrtMBlrPdFjrQ9oDhvubNMEWXpU
	 MXsIVBtYgsVhM+1ZgxyVI3VFkF+cvvOe1PKo45cdDFKyJXT0p7qrdAKffcQAtQvr4d
	 huhhNFM4A3ppA==
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 02 Nov 2024 08:29:52 +0200
Message-Id: <D5BHBW3NUS5C.293GUI03HMTCF@kernel.org>
Subject: Re: [RFC PATCH v2 1/2] tpm, tpm_tis: Introduce TPM_IOC_SET_LOCALITY
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Jonathan Corbet"
 <corbet@lwn.net>, "Peter Huewe" <peterhuewe@gmx.de>, "Jason Gunthorpe"
 <jgg@ziepe.ca>
Cc: <James.Bottomley@hansenpartnership.com>, <andrew.cooper3@citrix.com>,
 <ardb@kernel.org>, <baolu.lu@linux.intel.com>, <bp@alien8.de>,
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
X-Mailer: aerc 0.18.2
References: <D5BB5GX4KEUO.VJ2G9G9QKYRR@kernel.org>
 <20241102062259.2521361-1-jarkko@kernel.org>
In-Reply-To: <20241102062259.2521361-1-jarkko@kernel.org>

On Sat Nov 2, 2024 at 8:22 AM EET, Jarkko Sakkinen wrote:
> DRTM needs to be able to set the locality used by kernel. Provide
> TPM_IOC_SET_LOCALITY operation for this purpose. It is enabled only if
> the kernel command-line has 'tpm.set_locality_enabled=3D1'. The operation
> is one-shot allowed only for tpm_tis for the moment.
>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
> v2:
> - Do not ignore the return value of tpm_ioc_set_locality().
> - if (!(chip->flags & TPM_CHIP_FLAG_SET_LOCALITY_ENABLED))
> - Refined kernel-parameters.txt description.
> - Use __u8 instead of u8 in the uapi.
> - Tested with https://codeberg.org/jarkko/tpm-set-locality-test/src/branc=
h/main/src/main.rs

This version has been also tested (and encountered bugs fixed). I wrote
a small test program to verify that it works linked above.

After the boot, the new ioctl can reset exactly once the locality. Other
benefit is that the feature can be selected per driver (at this point
tpm_tis drivers) and protection of the access with DAC, SELinux etc.

And thanks to the kernel command-line parameter, it is an opt-in
feature like it should because vast majority of users will probably
never use trenchboot. I.e. set 'tpm.set_locality_enable=3D1' to have
the ioctl available.

I think this is a solution that at least I could live with. It has
somewhat rigid commmon-sense constraints.

BR, Jarkko

