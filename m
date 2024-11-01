Return-Path: <linux-efi+bounces-2105-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8BCE9B9AC3
	for <lists+linux-efi@lfdr.de>; Fri,  1 Nov 2024 23:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 703A51F221EB
	for <lists+linux-efi@lfdr.de>; Fri,  1 Nov 2024 22:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65181AAE06;
	Fri,  1 Nov 2024 22:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G8B5Fbih"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD4F1BDC3;
	Fri,  1 Nov 2024 22:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730499524; cv=none; b=Xm88zyOtTxggdAmEmwJX6CS4MJEK87I1dc+nGZomr/0y5RMpk8Ama2M94FRLC+qyErWFfvczndiZwxPS3j52epFhdyx+F0rOTgy3yTyJHD8U2viEdCkSjeU/UoWvZKmYy2hN1uvZSfsMeV2dTLr9z30lORcYre6cIGS9aMGazs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730499524; c=relaxed/simple;
	bh=SfvWv72ZbUeIjpMhK1H+Di14U2NJnni6MvQ7OWwTfDo=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=Tgk8V7UiG9fDuH1MkAMx4AGoUCWqxpr/uJi/XTGgSN4+PBJ3hK1QAUijCdkJLiUNvADPAxT6wSMk5oN46NF+adxRBABufqz0tJWNYqph9rtdWIFZddGiLOnLy4bWtEK5yW1e6715795CnekstnYP3yw9Ii3CojTjBDm/sYQxeTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G8B5Fbih; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E707C4CECD;
	Fri,  1 Nov 2024 22:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730499523;
	bh=SfvWv72ZbUeIjpMhK1H+Di14U2NJnni6MvQ7OWwTfDo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G8B5FbihtNvVjmiGncdZkw/5g49VXEDLWU6dCd6f7AgBZV7b3MDz4Mio9teMOIupZ
	 ARqPuoMHB79uUnWfl+rqF4KTcZ/gObfhf3oVmSS9eCRk0qutPaqPxfYhbHSu3Vq/je
	 HAnbzuzI/c9euOqXkGM4iUaORjvXEUct9BNxVVJk/Pbc72JYcDPtDceTthEVk9fecj
	 /Eb+mS/2aEEzZIyWFJQYVe4M7FITlC7FUxUCj5mBCz6yf4dfV6rgbJW7pxdd+uGM6c
	 HQnGDrwoQ/wXmcgGWjGK7qycALq7sacle8cuCNP5D38T9ddXyPOhWhHpmJw1iV1I20
	 ayJ6MSw0pdYXA==
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 02 Nov 2024 00:18:39 +0200
Message-Id: <D5B6VSE24UFU.3IMXJC23PCNFW@kernel.org>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Thomas Gleixner" <tglx@linutronix.de>, "Ross Philipson"
 <ross.philipson@oracle.com>, <linux-kernel@vger.kernel.org>,
 <x86@kernel.org>, <linux-integrity@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
 <kexec@lists.infradead.org>, <linux-efi@vger.kernel.org>,
 <iommu@lists.linux-foundation.org>
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
X-Mailer: aerc 0.18.2
References: <20240913200517.3085794-1-ross.philipson@oracle.com>
 <D5ARS5Y7EATS.2GVNSARKXKIDI@kernel.org> <87a5eivgku.ffs@tglx>
 <D5B5I0WUU8F0.30JMZ6QHPOFRK@kernel.org>
 <D5B5MLX1C8TS.2U6YPCYBWBTYT@kernel.org> <87msiitxto.ffs@tglx>
In-Reply-To: <87msiitxto.ffs@tglx>

On Sat Nov 2, 2024 at 12:04 AM EET, Thomas Gleixner wrote:
> On Fri, Nov 01 2024 at 23:19, Jarkko Sakkinen wrote:
> > On Fri Nov 1, 2024 at 11:13 PM EET, Jarkko Sakkinen wrote:
> >> I think we can sort them out independently as long as we find a
> >> conclusion how to address locality change.
> >
> > And to be fair: there was no reaction from anyone. It is mostly x86
> > patch set, meaning that I was waiting for some reaction first from that
> > side.  And I did respond to that when it came.
>
> The x86 side is mostly self contained, so the damage there is minimal,
> but the TPM parts are changing the generic operations and the x86 parts
> depend on them.
>
> So let's not create a chicken and egg problem and solve the TPM parts,
> which at my cursory glance are partially legitimate fixes, independent
> of the actual trenchboot x86 functionality.

Yeah, I'm already writing a (draft/RFC) patch to demonstrate my
proposal that I sent so all good.

>
> Thanks,
>
>         tglx

BR, Jarkko

