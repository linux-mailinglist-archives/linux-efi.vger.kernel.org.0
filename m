Return-Path: <linux-efi+bounces-2103-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11B089B9A7B
	for <lists+linux-efi@lfdr.de>; Fri,  1 Nov 2024 22:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE04B2820B8
	for <lists+linux-efi@lfdr.de>; Fri,  1 Nov 2024 21:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FBA01E1C32;
	Fri,  1 Nov 2024 21:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P7xA/q3q"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D981A19B3E3;
	Fri,  1 Nov 2024 21:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730498189; cv=none; b=HwS6gchHrUts/YLNNSdjMEbJuoGm8ZIpygM8sTwIUa0zyHvoNEywchfz7LKoQTZIrHo9GVFnliwkyU4SryBOAxBvUnSoTLIAR+6MDkf6iRZIEdad1spgkIrruDqve99+KnuBaayifT0WmyR9Pyll+0Vy15D1KRTdes1Z2M9qLrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730498189; c=relaxed/simple;
	bh=fziVethYd+NPhcx81IKT2ML+GpHUPixc+xtg0E2ky9o=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=leGHc3TjlUPxJSq/yonc3CEOQhaK2ywsHxx2Dw2Top2C5ByFBieFF7QaHZBV+9wxmypAW0d3cpMRx5x8FiI850i/0LoUxMorjTYG8lTe3ai+ntQ1bbPV6IQNZgx30HIkKReb4hQBIDylEgkh/v9riJNbKPduzt4npNvnA9ntKxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P7xA/q3q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A074C4CECD;
	Fri,  1 Nov 2024 21:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730498186;
	bh=fziVethYd+NPhcx81IKT2ML+GpHUPixc+xtg0E2ky9o=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=P7xA/q3qow25TnX1KVFl60EAxmebWXU5zAOwQwJRnaUFpjfJc+7yjIoztedBfWpF9
	 9+2IATFc+NfSL6bu5gW9V2qdOQ/17jwvjeZrNUMek7y57fiGamkutcMRpmylyPhGuq
	 sNPfYAnYu/Ik+PshC2CkZCPrn3CkZrcGRemN9DNxDGGWc95FEG8yNLoIzsbP1Zq63a
	 smRkLu2/c41kaseVGbRe9Fd+e7moKcjBlp/e56O8XS997ZT6kjDWfCOHFDsc140bQB
	 Kjmhb6IsqpZcEV9m6Etr+Vf8uNsUlzqVRBZRyAtMyYfYtX8tvj3VcKr5/4ti6J6h3q
	 AJJcAUgOzYjdg==
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 01 Nov 2024 23:56:22 +0200
Message-Id: <D5B6EQ3BE8HC.2BZ3UDY70CGKG@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Ross Philipson"
 <ross.philipson@oracle.com>, <linux-kernel@vger.kernel.org>,
 <x86@kernel.org>, <linux-integrity@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
 <kexec@lists.infradead.org>, <linux-efi@vger.kernel.org>,
 <iommu@lists.linux-foundation.org>
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
X-Mailer: aerc 0.18.2
References: <20240913200517.3085794-1-ross.philipson@oracle.com>
 <20240913200517.3085794-19-ross.philipson@oracle.com>
 <D5ARBBZU61YW.2SQ35HTOJ85F7@kernel.org>
 <D5B69X48SFO7.RMZ1I1926BPF@kernel.org>
In-Reply-To: <D5B69X48SFO7.RMZ1I1926BPF@kernel.org>

On Fri Nov 1, 2024 at 11:50 PM EET, Jarkko Sakkinen wrote:
> On Fri Nov 1, 2024 at 12:06 PM EET, Jarkko Sakkinen wrote:
> > On Fri Sep 13, 2024 at 11:05 PM EEST, Ross Philipson wrote:
> > > Expose a sysfs interface to allow user mode to set and query the defa=
ult
> > > locality set for the TPM chip.
> > >
> > > Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> >
> > Must be read-only. Should be decided per power cycle.
>
> I'm throwing one incomplete idea not all things considered...
>
> So one idea is would be to apply set operation to /dev/tpm0 as ioctl
> (would not be available for /dev/tpmrm0).
>
> Then at least access control rules would apply.
>
> The open here is that the IMA etc. will use a different locality during
> boot-time, like it would also with sysfs attribute.

Looking at [1] this would become a problem if TPM2_PolicyLocality based
policy is ever used during boot-time.

We can make a choice of not allowing such policies for in-kernel clients
if agree so, but it is a choice that needs to be locked in. With quick
thinking I'm not sure if that is horrible limitation.

Also does not obviously affect clients communicating with /dev/tpm0.
With that constrain it would not matter if during boot-time different
locale is used.

With that constraint and "set" in ioctl instead of sysfs attributes
that might even work out... Open for feedback.

[1] https://trustedcomputinggroup.org/wp-content/uploads/TPM-2.0-1.83-Part-=
3-Commands.pdf

BR, Jarkko

