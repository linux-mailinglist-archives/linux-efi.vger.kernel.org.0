Return-Path: <linux-efi+bounces-1145-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0268FBD49
	for <lists+linux-efi@lfdr.de>; Tue,  4 Jun 2024 22:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A61F11C21846
	for <lists+linux-efi@lfdr.de>; Tue,  4 Jun 2024 20:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7703B14B95B;
	Tue,  4 Jun 2024 20:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="smGaAySO"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4465E372;
	Tue,  4 Jun 2024 20:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717532868; cv=none; b=mRzbTVWP9uhSC3HwDTz0t+3hqPxn7HSJ7gY+OpTVgejn8JKLbrD/Fx/azeNLoucaowXI5MyYcZ+iUGv3hNIqa5MKoUlekLavK5JOzpoRPP/cc1gxOZxy/MKBV+AXwl54+0K/hbhhSkFJcwVHwuXraaLapnztRr0my9w2zz0UW+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717532868; c=relaxed/simple;
	bh=1WFPt6YbL8G4ZsYp/yQJxcMU9eiBBdcr3RYbZ6QX754=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Yyk9BWJBsr5kni2PywsSPTJwKzY+OOTcz6IUHWZ9/whLoJoJp1TJOF12ImURKNFoxEhWbZvttfilbnuez+IkeWLD407W9Gnu9Ts5MnmQFoiWqQHbthbTLnK2XjCd+QKmGMqsmXxc/mj7sKQOaBpzzQ45sLVrfHL3VfLzVGPfX3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=smGaAySO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF80EC3277B;
	Tue,  4 Jun 2024 20:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717532867;
	bh=1WFPt6YbL8G4ZsYp/yQJxcMU9eiBBdcr3RYbZ6QX754=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=smGaAySOhkWIJykMXHinTp+dGQnhmzYqqhi1VLJH+Z29+8A6YD6CJ/NU2QmUdkOoW
	 jsqnsaeIhP1DTiF7LsEi5hZFOS5vVWW5iezALy7DR4tdBjPZgmV8c8GypDxhJRIKAz
	 Wxpmwg2VabkC0bzd5g9Q1cEjntEqWPI3zwvEJZeYBPws0USxWgQKrYmz8L7lBQf6Ab
	 FpZsjcU0GJvOh2MJjn6ChFV1hrVKM8zuf0hvKWFUBTleIAsUP4qJICuE52/G7oUmtc
	 Itw+MsrusyEgkV4Qe+vJn5Ef0B6954fQjgoJiTRjQIFQ75VFhE+XXsxO9d063YXT6+
	 KZyVye3hR+ihw==
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 04 Jun 2024 23:27:40 +0300
Message-Id: <D1RIL3HMPSXB.PYNHI82D7NI3@kernel.org>
Cc: <dpsmith@apertussolutions.com>, <tglx@linutronix.de>,
 <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
 <dave.hansen@linux.intel.com>, <ardb@kernel.org>, <mjg59@srcf.ucam.org>,
 <James.Bottomley@hansenpartnership.com>, <peterhuewe@gmx.de>,
 <jgg@ziepe.ca>, <luto@amacapital.net>, <nivedita@alum.mit.edu>,
 <herbert@gondor.apana.org.au>, <davem@davemloft.net>, <corbet@lwn.net>,
 <ebiederm@xmission.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
 <kanth.ghatraju@oracle.com>, <andrew.cooper3@citrix.com>,
 <trenchboot-devel@googlegroups.com>
Subject: Re: [PATCH v9 17/19] tpm: Add sysfs interface to allow setting and
 querying the preferred locality
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Ross Philipson" <ross.philipson@oracle.com>,
 <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
 <linux-integrity@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-crypto@vger.kernel.org>, <kexec@lists.infradead.org>,
 <linux-efi@vger.kernel.org>, <iommu@lists.linux-foundation.org>
X-Mailer: aerc 0.17.0
References: <20240531010331.134441-1-ross.philipson@oracle.com>
 <20240531010331.134441-18-ross.philipson@oracle.com>
In-Reply-To: <20240531010331.134441-18-ross.philipson@oracle.com>

On Fri May 31, 2024 at 4:03 AM EEST, Ross Philipson wrote:
> Expose a sysfs interface to allow user mode to set and query the preferre=
d
> locality for the TPM chip.
>
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> ---
>  drivers/char/tpm/tpm-sysfs.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>
> diff --git a/drivers/char/tpm/tpm-sysfs.c b/drivers/char/tpm/tpm-sysfs.c
> index 94231f052ea7..5f4a966a4599 100644
> --- a/drivers/char/tpm/tpm-sysfs.c
> +++ b/drivers/char/tpm/tpm-sysfs.c
> @@ -324,6 +324,34 @@ static ssize_t null_name_show(struct device *dev, st=
ruct device_attribute *attr,
>  static DEVICE_ATTR_RO(null_name);
>  #endif
> =20
> +static ssize_t preferred_locality_show(struct device *dev,
> +				       struct device_attribute *attr, char *buf)
> +{
> +	struct tpm_chip *chip =3D to_tpm_chip(dev);
> +
> +	return sprintf(buf, "%d\n", chip->pref_locality);
> +}

Disagree with the naming.

BR, Jarkko

