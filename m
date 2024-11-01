Return-Path: <linux-efi+bounces-2102-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 622B79B9A6E
	for <lists+linux-efi@lfdr.de>; Fri,  1 Nov 2024 22:51:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93DDB1C21AD9
	for <lists+linux-efi@lfdr.de>; Fri,  1 Nov 2024 21:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FAAF1E572C;
	Fri,  1 Nov 2024 21:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UWcBm+Xp"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26ECF1E571D;
	Fri,  1 Nov 2024 21:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730497810; cv=none; b=DBqZBjpFHoSlCMsmIA4qnDVPf9KZqhaEhHSwBKnRSli6QUxL5KYzC0cUpp7E/JPACAgoGb9mchDBOk3i1fUiC1EbDgJAKHegCTJGDjl71BM78nz2fic1u1qerySswuf8AZAtFE3VT6mXOuX8dRI2Brtk1v1XVjJ1R4TBmTV7l+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730497810; c=relaxed/simple;
	bh=KEMzaKGo3anPlxd3W6Jufkxyiqrz0Fn3Kr0IoeQ02K4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=kLG92ONafaduMJCzj82JTVOLAB+lyhgxE7hag0DKZKsLcDYB+nc6l3MoYeZN5i/I2j6g8N/vNs3cs4BaGfDInW+/QlsBmq3qrkTEQe5+TSpvRj4c+7Kq9yu7dVybsPBA+4fG33tKwN0XJQZCfhnU0/32c7FjwWsf4sEwTS8dSzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UWcBm+Xp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1406AC4CECD;
	Fri,  1 Nov 2024 21:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730497809;
	bh=KEMzaKGo3anPlxd3W6Jufkxyiqrz0Fn3Kr0IoeQ02K4=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=UWcBm+Xpl3DlVCGQvVDnSl9k2SmTDdR0uxFOt2euozsCGAqRdZKyXvLnDTJfRW925
	 x9/vMH6AjJvjF+Qak0qjfHiUes4mKkaAMHQYoVUROVmXM5Hr3mmxnja4R5D7mACU2w
	 cW7LSmFhm2JnXt32AxHF0n3LgUyIk/4nE+l0JXyvScKlTbFwobSpbRH3HwPhB8uYAa
	 c2RozITzQlxydytXz18BwrCWnrmBlhA9PXwqKsFqyC0p2hf+53Qcmhl+LUiuUpy3bp
	 QTFnT+QCPtEQ5sr7ni4fh+2ldDghLhrXtlaBK87wxznb4EZuJWk5ESN1iMSe6KBAFz
	 YFrDxBo6CDv+g==
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 01 Nov 2024 23:50:05 +0200
Message-Id: <D5B69X48SFO7.RMZ1I1926BPF@kernel.org>
Cc: <dpsmith@apertussolutions.com>, <tglx@linutronix.de>,
 <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
 <dave.hansen@linux.intel.com>, <ardb@kernel.org>, <mjg59@srcf.ucam.org>,
 <James.Bottomley@hansenpartnership.com>, <peterhuewe@gmx.de>,
 <jgg@ziepe.ca>, <luto@amacapital.net>, <nivedita@alum.mit.edu>,
 <herbert@gondor.apana.org.au>, <davem@davemloft.net>, <corbet@lwn.net>,
 <ebiederm@xmission.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
 <kanth.ghatraju@oracle.com>, <andrew.cooper3@citrix.com>,
 <trenchboot-devel@googlegroups.com>
Subject: Re: [PATCH v11 18/20] tpm: Add sysfs interface to allow setting and
 querying the default locality
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Ross Philipson"
 <ross.philipson@oracle.com>, <linux-kernel@vger.kernel.org>,
 <x86@kernel.org>, <linux-integrity@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
 <kexec@lists.infradead.org>, <linux-efi@vger.kernel.org>,
 <iommu@lists.linux-foundation.org>
X-Mailer: aerc 0.18.2
References: <20240913200517.3085794-1-ross.philipson@oracle.com>
 <20240913200517.3085794-19-ross.philipson@oracle.com>
 <D5ARBBZU61YW.2SQ35HTOJ85F7@kernel.org>
In-Reply-To: <D5ARBBZU61YW.2SQ35HTOJ85F7@kernel.org>

On Fri Nov 1, 2024 at 12:06 PM EET, Jarkko Sakkinen wrote:
> On Fri Sep 13, 2024 at 11:05 PM EEST, Ross Philipson wrote:
> > Expose a sysfs interface to allow user mode to set and query the defaul=
t
> > locality set for the TPM chip.
> >
> > Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
>
> Must be read-only. Should be decided per power cycle.

I'm throwing one incomplete idea not all things considered...

So one idea is would be to apply set operation to /dev/tpm0 as ioctl
(would not be available for /dev/tpmrm0).

Then at least access control rules would apply.

The open here is that the IMA etc. will use a different locality during
boot-time, like it would also with sysfs attribute.

BR, Jarkko

