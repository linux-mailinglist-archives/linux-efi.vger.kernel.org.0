Return-Path: <linux-efi+bounces-2112-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF979B9EF1
	for <lists+linux-efi@lfdr.de>; Sat,  2 Nov 2024 11:39:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84653282CC1
	for <lists+linux-efi@lfdr.de>; Sat,  2 Nov 2024 10:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 389CE170826;
	Sat,  2 Nov 2024 10:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gOtMufXP"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE243165F18;
	Sat,  2 Nov 2024 10:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730543939; cv=none; b=qFo5mln3t+Fg35nHl8EYtPURsBvtXRtgomQhEDRwPbQRgg9a8QMOqsKbpHKicSoFI3YmjTGvSm32He1X3NWvRY/V48tjSw9qCW0M3GdAClAqCJudAzziS2w8UkAYDtLpzducReZbODP7SRiBOb5gvhrz3It9ey4ig7jAQ1vOLZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730543939; c=relaxed/simple;
	bh=VBKEa56BIF6QsRkD7RAecoTuv66Z7zv8Det8m4u7ftI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=fdimTfroDMxnB8lTKocPMvL7hborgGTTXWaWMCGV3uYoK1++GaMm5vngoDLyHqVRi2k87f5KDGMXWh+hoAJFKXIbBCtlor5yJAyJIKWvaP3r06fb830qjTRI5UryE2sb1VKkW//cmBclNBMGl+j485zdCu604MK4g9WMRHmPeTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gOtMufXP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACC7DC4CEC3;
	Sat,  2 Nov 2024 10:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730543938;
	bh=VBKEa56BIF6QsRkD7RAecoTuv66Z7zv8Det8m4u7ftI=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=gOtMufXPnc1DFubhW7urf50dPP0bw7KIiI3fvULoHrreHHmwFH9QwAfpNb54uDN18
	 kaAGkZTYHObw5uIJMbV9bUddVCc1ac0Saz5R1wPok7rFAng3z5LsAVZOXlyl/LCoCt
	 G1hsDOSZJJDG9/uEQhCnicp3jmsm2plmYOIQmF7hHiJ/+a4a9RXHKtxhsRYhofwHAA
	 lLkViIuMowQlJi/iR0N36yOu8ktoVAz+045SjYt1aw8Ju46YHIUBQqLfWk7NqGhDuM
	 AEFABWsbKJAh+lmxj5cmSoWXmdQVVQTiAKI8qVrgMtzWekCyE9Ldt7bWWVUyLtMp5U
	 CZ0rOmGMK8dyQ==
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 02 Nov 2024 12:38:53 +0200
Message-Id: <D5BMMJYMVWKJ.3MIGB8KW34PR2@kernel.org>
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
In-Reply-To: <CAMj1kXGk8y=rZiNiDcD-8mDKJB5HkTowM7g+kjO6616MGdTQaQ@mail.gmail.com>

On Sat Nov 2, 2024 at 11:02 AM EET, Ard Biesheuvel wrote:
> Same for the ioctl() [as well as the read-write sysfs node]: looking
> at the code (patch 19/20) it doesn't seem like user space needs to be
> able to modify this at all, at least not for the patch set as
> presented. So for now, can we just stick with making the sysfs node
> read-only?

Short answer: I have no idea. I would not mind that but neither
the commit message for TPM give a clue on this. Actually, I *do
not care* if it is RO and RW but I'm neither good at guessing
random shit.

I haad to assume it was *needed* for reason that I do not know
given that sysfs attribute was RW.

BR, Jarkko

