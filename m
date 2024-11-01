Return-Path: <linux-efi+bounces-2100-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D409B99F2
	for <lists+linux-efi@lfdr.de>; Fri,  1 Nov 2024 22:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E9311F22883
	for <lists+linux-efi@lfdr.de>; Fri,  1 Nov 2024 21:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E53C31E7641;
	Fri,  1 Nov 2024 21:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z27lBmP5"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71FD1E2848;
	Fri,  1 Nov 2024 21:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730495624; cv=none; b=NTww/E0HKkoMpljm3nu7mTDJPjc5eXNg6Mt+yuEWDUC9fjiicfvslB7tLU1ekFhWzo9erUUF79bs5w38b5Vss+9nEx0uSnsLAoJzf2KP9SJk1BNOivwBF1UgAYhk7giZkaNfs72N35wmt0aOyKOlCdC3xmZp0YZyqb1v919M5s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730495624; c=relaxed/simple;
	bh=vrlQ5nkW/wzdW59TsobYC/cGECVvY5bM8O3JACd5vR8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=QsU6pnyVpfJ0NFQT2KC7xBcjQboURj/mp1a57eU3ijperv/Cg3Xi5fQ7kJP9QQm3RupmUcPnR0eRiCzi0Kgkhv2Mr8RQfTInl+hxa53uYlvCxOfveg1SajETvtqgaEwiushAPtz/DcsGww5Ym4wZ6LmGPadrmeAMie/pVreN+GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z27lBmP5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71602C4CECD;
	Fri,  1 Nov 2024 21:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730495624;
	bh=vrlQ5nkW/wzdW59TsobYC/cGECVvY5bM8O3JACd5vR8=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=Z27lBmP5zV5S/Lm4wBLsyOzhvmCy+PaD+aSiDJoAmhJdwIpgWu7go74DLTbL/DmAQ
	 m4VM1XbkSRlPF534HjALo5a+qdkHgu9qy7+8tWZNobfIsypdUOnVT0zMYvrKbUDL4O
	 pr1BHsYZ9HdZm3+qsutLq53SUhzXTlall69hNmqjdD/bOYezVVbNGKRm6m/IunumGl
	 yvVYFXZZqN56obQzEkxMIxL4DYP8SF14xIQkYNBExMzLjQ854ir3tdEZDwvoO4vfKs
	 /NGBCW4lZDq+POOJewWgjrRi1z/wGj1/cGx7DlUqqRKhNteHFYOtX09Yf+Ee0YlFcE
	 f90hDeNlC3TVQ==
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 01 Nov 2024 23:13:39 +0200
Message-Id: <D5B5I0WUU8F0.30JMZ6QHPOFRK@kernel.org>
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
To: "Thomas Gleixner" <tglx@linutronix.de>, "Ross Philipson"
 <ross.philipson@oracle.com>, <linux-kernel@vger.kernel.org>,
 <x86@kernel.org>, <linux-integrity@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
 <kexec@lists.infradead.org>, <linux-efi@vger.kernel.org>,
 <iommu@lists.linux-foundation.org>
X-Mailer: aerc 0.18.2
References: <20240913200517.3085794-1-ross.philipson@oracle.com>
 <D5ARS5Y7EATS.2GVNSARKXKIDI@kernel.org> <87a5eivgku.ffs@tglx>
In-Reply-To: <87a5eivgku.ffs@tglx>

On Fri Nov 1, 2024 at 10:34 PM EET, Thomas Gleixner wrote:
> On Fri, Nov 01 2024 at 12:28, Jarkko Sakkinen wrote:
> > On Fri Sep 13, 2024 at 11:04 PM EEST, Ross Philipson wrote:
> >> A quick note on terminology. The larger open source project itself is =
called
> >> TrenchBoot, which is hosted on Github (links below). The kernel featur=
e enabling
> >> the use of Dynamic Launch technology is referred to as "Secure Launch"=
 within
> >> the kernel code. As such the prefixes sl_/SL_ or slaunch/SLAUNCH will =
be seen
> >> in the code. The stub code discussed above is referred to as the SL st=
ub.
> >
> > 1. I don't see any tags in most of the patches so don't get the rush. T=
his
> >    includes also patches for x86. Why I would care to review TPM patche=
s
> >    when there is over a dozen unreviewed and untested patches before it=
?
> > 2. TPM patches have been in circulation in and out of the patch set
> >    for some time now with little or no improvement.
> >
> > Why the sudden buzz? I have not heard much about this since last early
> > summer.  Have to spend some time recalling what this is about anyway. I
> > cannot trust that my tags make any sense before more reviewed/tested-by
> > tags before the TPM patches.
>
> If I intend to merge the patches then I surely have looked at them
> deeply. I don't have to send a reviewed-by just to apply them
> afterwards.
>
> There was enough motion on these patches and this posting is in your
> inbox for 6 weeks now without any reaction from you.
>
> The TPM changes are very much independent from the x86 specific ones, so
> why do you want x86 review tags in order to look at the ones which are
> specific to your subsystem especially as some of them seem to address
> real short comings there independent of trenchboot.

I think we can sort them out independently as long as we find a
conclusion how to address locality change.

>
> Thanks,
>
>         tglx

BR, Jarkko

