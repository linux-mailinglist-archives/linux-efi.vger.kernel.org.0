Return-Path: <linux-efi+bounces-2113-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07FD19B9EFA
	for <lists+linux-efi@lfdr.de>; Sat,  2 Nov 2024 11:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A506E1F21572
	for <lists+linux-efi@lfdr.de>; Sat,  2 Nov 2024 10:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05963170826;
	Sat,  2 Nov 2024 10:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YqfIep9R"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49D916F0EC;
	Sat,  2 Nov 2024 10:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730544037; cv=none; b=BYAgUcBjASHxMjACQ4B9zDcnIwLrV/BNAtB6qh9ybTuQUMortBHNVSuK3cmYhTAfaBVKX/CE+xFTHeAphgUIDsvS0yWnC5yJC1MSaJcXfddQ4vBIBzsegSYjlh8kMowclKLD0cOkdDnheRFp2uG1bHdkPuS+qYt5J9zsRRTNt14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730544037; c=relaxed/simple;
	bh=tV3w/NhiYLlSxyTG9f/8MYrM2eWyQSkpoUd6CUZpQ/s=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=KxKruc3ZGS3t0h0rZWHQ+YisRnnVUsqtvcg9AQJcsnLiknjVVfo4LPE/JS6wtrrXsgu0HdWESkwPu5+3ol2ikM1qcbFLpy6pJehZ57eoFJSSttu0lgdgcHYT0UyBN9f/+x6cRpHYS9fqJUlCh1algjs8qN5wpOKJtYpQ/VJPhFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YqfIep9R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83A74C4CEC3;
	Sat,  2 Nov 2024 10:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730544037;
	bh=tV3w/NhiYLlSxyTG9f/8MYrM2eWyQSkpoUd6CUZpQ/s=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=YqfIep9RAimhK5lG8GqaDVHqPzgB0uQJtTNYapUpHHL3VKHD63sfcJEgzueni7hxh
	 cilOlKzjwtdBMAy/OQZ+l0IpY0UmNFTwXCvsHHnr7kkoK/43Rug3DEoVA+M1xExXzq
	 BOTjSEjqGkivPG88YnB5MWaZUg8+CWRWayIW79lY9vYeYXYzUrSgq8nDMHSDKx2rCF
	 8Q7UW0GpW0FwAXMD9WoKaep1r8yt4QQxPeQLyx1CeRryvMAk5IZgYpA87cz4tAe5PC
	 cmA3WWCIh6wxIYGhm7nB1aprTmMUmQq43pnRUZGmIZNenwodP9jmmhiXWEG730hFGH
	 Ln33GT8WM1epw==
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 02 Nov 2024 12:40:31 +0200
Message-Id: <D5BMNT065TE5.1SV8CSW8KEG6L@kernel.org>
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
In-Reply-To: <D5BMMJYMVWKJ.3MIGB8KW34PR2@kernel.org>

On Sat Nov 2, 2024 at 12:38 PM EET, Jarkko Sakkinen wrote:
> On Sat Nov 2, 2024 at 11:02 AM EET, Ard Biesheuvel wrote:
> > Same for the ioctl() [as well as the read-write sysfs node]: looking
> > at the code (patch 19/20) it doesn't seem like user space needs to be
> > able to modify this at all, at least not for the patch set as
> > presented. So for now, can we just stick with making the sysfs node
> > read-only?
>
> Short answer: I have no idea. I would not mind that but neither
> the commit message for TPM give a clue on this. Actually, I *do
> not care* if it is RO and RW but I'm neither good at guessing
> random shit.
>
> I haad to assume it was *needed* for reason that I do not know
> given that sysfs attribute was RW.

Let's put it this way: *if* write is needed this the way to do
it now and also in the future (or along the lines). Or least
harmful at least (single additional locality change per boot).

BR, Jarkko

