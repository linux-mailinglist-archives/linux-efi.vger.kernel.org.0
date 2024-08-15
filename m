Return-Path: <linux-efi+bounces-1540-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B2F953A31
	for <lists+linux-efi@lfdr.de>; Thu, 15 Aug 2024 20:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B88B28322F
	for <lists+linux-efi@lfdr.de>; Thu, 15 Aug 2024 18:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E1B52F70;
	Thu, 15 Aug 2024 18:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ABo/r0Kp"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD013A8CB;
	Thu, 15 Aug 2024 18:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723746918; cv=none; b=JHN6/lvWdXEdWv8L02lGgiuWWxiam0mBvF9xeZjHjcHMzZsa+8V5eRUY9F7ev4tF9EWklNGlQJeiWF3/DDeJSPFCvxy9Y4rIYCpswXq9Hn4xKLSk+d44F8OK3H0sGrWtbwNgpAKUNYt1ajDFP/tTvTz9DSsCvD5dHFsrLQ2SNMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723746918; c=relaxed/simple;
	bh=cTCsOgynQ4MwhMR6ZY7de0r7dfkhZkEHbhoL0qooFwQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=DDlBqo184Wc9mG0Oxiwlmm0E9sXsSlzNUB1EHilvWnk2c9gzYPF6TKpPrI7EFLQMQf8X6g1TTuNl0aF+eU40+YdgibW8UxkwTiqPNcnidEj1KGLfLITORUEEwL7pj3p/3ePtE18XWPdJAru1AryJJypOQKMF1pz5dG4345xqwRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ABo/r0Kp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB574C32786;
	Thu, 15 Aug 2024 18:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723746917;
	bh=cTCsOgynQ4MwhMR6ZY7de0r7dfkhZkEHbhoL0qooFwQ=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=ABo/r0KpwzV2fsu7t9P88x9rSwJlLxWCZferGBEeusbxc7rkDoUTF3J8FWwiBqwqT
	 NWJ2Xp90EgLXVEbil6GcV6DJHVaeoSTZi0TgVXlv9VIiBMvvFYrRJid9gLrX/txws7
	 siYy5jScFJrXwMXXkt0d9iiK3DUfh5wGFRCEdfchdNfkT04PQWTO+dMD6ip9w5NLB1
	 REC4S4UU4k9XDBy0Bx9u67wRSu7YIcEuxtwUQDBRVZ86u/aPmhNmriluSFbl0eVYSV
	 Vj+N++DUAjE6ZtDvBDIcwM/lybcx0V1R3Q/dmHf3imznH1+CD3U7BBdaxQlqGS7Aqi
	 LrEYvArcKSYNA==
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 15 Aug 2024 21:35:13 +0300
Message-Id: <D3GPA85MRNMM.3GMP3BTBEEYFP@kernel.org>
Cc: <dpsmith@apertussolutions.com>, <tglx@linutronix.de>,
 <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
 <dave.hansen@linux.intel.com>, <ardb@kernel.org>, <mjg59@srcf.ucam.org>,
 <James.Bottomley@hansenpartnership.com>, <peterhuewe@gmx.de>,
 <jgg@ziepe.ca>, <luto@amacapital.net>, <nivedita@alum.mit.edu>,
 <herbert@gondor.apana.org.au>, <davem@davemloft.net>, <corbet@lwn.net>,
 <ebiederm@xmission.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
 <kanth.ghatraju@oracle.com>, <andrew.cooper3@citrix.com>,
 <trenchboot-devel@googlegroups.com>
Subject: Re: [PATCH v9 09/19] x86: Secure Launch kernel late boot stub
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: <ross.philipson@oracle.com>, <linux-kernel@vger.kernel.org>,
 <x86@kernel.org>, <linux-integrity@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
 <kexec@lists.infradead.org>, <linux-efi@vger.kernel.org>,
 <iommu@lists.linux-foundation.org>
X-Mailer: aerc 0.17.0
References: <20240531010331.134441-1-ross.philipson@oracle.com>
 <20240531010331.134441-10-ross.philipson@oracle.com>
 <D1RHZDG3HJNK.ZWTFLXDBEXD1@kernel.org>
 <ad84cdaf-bea6-483e-82f3-c83a6b7006c3@oracle.com>
In-Reply-To: <ad84cdaf-bea6-483e-82f3-c83a6b7006c3@oracle.com>

On Mon Aug 12, 2024 at 10:02 PM EEST,  wrote:
> On 6/4/24 3:59 PM, Jarkko Sakkinen wrote:
> > On Fri May 31, 2024 at 4:03 AM EEST, Ross Philipson wrote:
> >> The routine slaunch_setup is called out of the x86 specific setup_arch=
()
> >> routine during early kernel boot. After determining what platform is
> >> present, various operations specific to that platform occur. This
> >> includes finalizing setting for the platform late launch and verifying
> >> that memory protections are in place.
> >>
> >> For TXT, this code also reserves the original compressed kernel setup
> >> area where the APs were left looping so that this memory cannot be use=
d.
> >>
> >> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> >> ---
> >>   arch/x86/kernel/Makefile   |   1 +
> >>   arch/x86/kernel/setup.c    |   3 +
> >>   arch/x86/kernel/slaunch.c  | 525 +++++++++++++++++++++++++++++++++++=
++
> >>   drivers/iommu/intel/dmar.c |   4 +
> >>   4 files changed, 533 insertions(+)
> >>   create mode 100644 arch/x86/kernel/slaunch.c
> >>
> >> diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
> >> index 5d128167e2e2..b35ca99ab0a0 100644
> >> --- a/arch/x86/kernel/Makefile
> >> +++ b/arch/x86/kernel/Makefile
> >> @@ -76,6 +76,7 @@ obj-$(CONFIG_X86_32)		+=3D tls.o
> >>   obj-$(CONFIG_IA32_EMULATION)	+=3D tls.o
> >>   obj-y				+=3D step.o
> >>   obj-$(CONFIG_INTEL_TXT)		+=3D tboot.o
> >> +obj-$(CONFIG_SECURE_LAUNCH)	+=3D slaunch.o
> >=20
> > Hmm... should that be CONFIG_X86_SECURE_LAUNCH?
>
> Further thoughts on this after discussions...
>
> The Secure Launch feature will cover other architectures beyond x86 in=20
> the future. We may have to rework/move the config settings at that point=
=20
> but for now I don't think we want to change it.

OK got it.

BR, Jarkko

