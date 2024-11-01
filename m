Return-Path: <linux-efi+bounces-2101-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26BB59B9A1C
	for <lists+linux-efi@lfdr.de>; Fri,  1 Nov 2024 22:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7434B203DC
	for <lists+linux-efi@lfdr.de>; Fri,  1 Nov 2024 21:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139A01D271A;
	Fri,  1 Nov 2024 21:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nHYL0beI"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C685F1D0F61;
	Fri,  1 Nov 2024 21:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730495984; cv=none; b=blrGWZiDV812455Hjy04XwSLFE1/jEtGWYU5PSL2rI79ie/sLQ62oDHA09e+aLyrz5O+dT7sfoyegVzTBxfppGO8WZBB8mvtwbikRnyZPX43Fy+Zrt/omujDUFB6EoiBdKHqX2/j8SYSYCViQtHjGKZMZ2jfmDjooy6tkf0RVK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730495984; c=relaxed/simple;
	bh=fJEg2VjMXer2Y0al47UWb2qt+VXk29+LnZoE+tlChVM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=TkFezg/GSp57f2lqJBOV4ypHMjposAQkw+ehgXUBQkBM8q+o4ClL/FNTURvJ5wjlJBQOxyQGFKOjRvblAATxtaRNHEqEmQadDxJ1p8FzscQOu9rXg7svVr2XhK55Dcp9NRa3OspnjhFtafWH9MS+3cOMkkhA5QRzvGuJvZp5F40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nHYL0beI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9031C4CECD;
	Fri,  1 Nov 2024 21:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730495983;
	bh=fJEg2VjMXer2Y0al47UWb2qt+VXk29+LnZoE+tlChVM=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=nHYL0beIEk+vI+DD7w/Us6zMyJvldIqAHUSHcrklNSvCq11LHVJ6CBt5xv78b/JJC
	 dPgfCM0V6snWFNmONDbXmhzak1nJPTLPySPFRUP6u0ExWLG4v595JsxTxoCBMrdjFC
	 MemL5Z6ImC8jJD4GJHp89n7ZT8Hlxi8POl1YslvSCwUkZcXMSg4Rv6kE/ZzPa3pG1C
	 hh/T4YG/hSqq/sGxKd6WvIuzu+pTMu7CuG8uE9ou0AIh3M3TG0vQsvpSUDj273uU/N
	 hPD62pWdslpiS1uhT+lzHqwad/pyPyc8nOEunPm6wT3zzTJD7lqpahjKEqBJu4hL8U
	 v723ef+lxzjkA==
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 01 Nov 2024 23:19:38 +0200
Message-Id: <D5B5MLX1C8TS.2U6YPCYBWBTYT@kernel.org>
Cc: <dpsmith@apertussolutions.com>, <mingo@redhat.com>, <bp@alien8.de>,
 <hpa@zytor.com>, <dave.hansen@linux.intel.com>, <ardb@kernel.org>,
 <mjg59@srcf.ucam.org>, <James.Bottomley@hansenpartnership.com>,
 <peterhuewe@gmx.de>, <jgg@ziepe.ca>, <luto@amacapital.net>,
 <nivedita@alum.mit.edu>, <herbert@gondor.apana.org.au>,
 <davem@davemloft.net>, <corbet@lwn.net>, <ebiederm@xmission.com>,
 <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
 <kanth.ghatraju@oracle.com>, <andrew.cooper3@citrix.com>,
 <trenchboot-devel@googlegroups.com>
Subject: Re: [PATCH v11 00/20] x86: Trenchboot secure dynamic launch Linux
 kernel support
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Thomas Gleixner"
 <tglx@linutronix.de>, "Ross Philipson" <ross.philipson@oracle.com>,
 <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
 <linux-integrity@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-crypto@vger.kernel.org>, <kexec@lists.infradead.org>,
 <linux-efi@vger.kernel.org>, <iommu@lists.linux-foundation.org>
X-Mailer: aerc 0.18.2
References: <20240913200517.3085794-1-ross.philipson@oracle.com>
 <D5ARS5Y7EATS.2GVNSARKXKIDI@kernel.org> <87a5eivgku.ffs@tglx>
 <D5B5I0WUU8F0.30JMZ6QHPOFRK@kernel.org>
In-Reply-To: <D5B5I0WUU8F0.30JMZ6QHPOFRK@kernel.org>

On Fri Nov 1, 2024 at 11:13 PM EET, Jarkko Sakkinen wrote:
> On Fri Nov 1, 2024 at 10:34 PM EET, Thomas Gleixner wrote:
> > On Fri, Nov 01 2024 at 12:28, Jarkko Sakkinen wrote:
> > > On Fri Sep 13, 2024 at 11:04 PM EEST, Ross Philipson wrote:
> > >> A quick note on terminology. The larger open source project itself i=
s called
> > >> TrenchBoot, which is hosted on Github (links below). The kernel feat=
ure enabling
> > >> the use of Dynamic Launch technology is referred to as "Secure Launc=
h" within
> > >> the kernel code. As such the prefixes sl_/SL_ or slaunch/SLAUNCH wil=
l be seen
> > >> in the code. The stub code discussed above is referred to as the SL =
stub.
> > >
> > > 1. I don't see any tags in most of the patches so don't get the rush.=
 This
> > >    includes also patches for x86. Why I would care to review TPM patc=
hes
> > >    when there is over a dozen unreviewed and untested patches before =
it?
> > > 2. TPM patches have been in circulation in and out of the patch set
> > >    for some time now with little or no improvement.
> > >
> > > Why the sudden buzz? I have not heard much about this since last earl=
y
> > > summer.  Have to spend some time recalling what this is about anyway.=
 I
> > > cannot trust that my tags make any sense before more reviewed/tested-=
by
> > > tags before the TPM patches.
> >
> > If I intend to merge the patches then I surely have looked at them
> > deeply. I don't have to send a reviewed-by just to apply them
> > afterwards.
> >
> > There was enough motion on these patches and this posting is in your
> > inbox for 6 weeks now without any reaction from you.
> >
> > The TPM changes are very much independent from the x86 specific ones, s=
o
> > why do you want x86 review tags in order to look at the ones which are
> > specific to your subsystem especially as some of them seem to address
> > real short comings there independent of trenchboot.
>
> I think we can sort them out independently as long as we find a
> conclusion how to address locality change.

And to be fair: there was no reaction from anyone. It is mostly x86
patch set, meaning that I was waiting for some reaction first from that
side.  And I did respond to that when it came.

IMHO: let's get a solution for that one problem and then it should be
fine as far as I'm concerned.

BR, Jarkko

