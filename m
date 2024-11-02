Return-Path: <linux-efi+bounces-2120-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB4C9BA157
	for <lists+linux-efi@lfdr.de>; Sat,  2 Nov 2024 17:04:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8967281EB8
	for <lists+linux-efi@lfdr.de>; Sat,  2 Nov 2024 16:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08FD219E990;
	Sat,  2 Nov 2024 16:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="g6BcZpKV";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="g6BcZpKV"
X-Original-To: linux-efi@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97B018A6A6;
	Sat,  2 Nov 2024 16:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730563485; cv=none; b=fdPtHmaLBaqyvFA2VElXKR+kH8dygdHeTLHEGClrbcf6sp0F1/G8x6Zz7LOPMvVSDPY4Poo+qti8NpvZVtHnrbz24fKPUIOIf/CgIGJoAO8TOZiZnbVhXNEZh9yhCHn2wfnwDVxCxgp8jrWGXLkLQ9/3MlSV7ge4eW5mLzR6OIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730563485; c=relaxed/simple;
	bh=61z7O+6nYz3jsRlzVcw6dm9APvP6OG4QQ5C+u9mEglw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jOFWNRKN5IujHgkUTE5tSSkJney8PHfyaBNNzqWQjE/8VI8X5tKe9Ha2Ui1JT92AWJhwfIOn6MvRbJzyVsdcPiXnHM7xeJg8TH/Sy4uHAEQkIIQBSgoyHU2/GnPUOZ2yju3HKRN9WuEHfCew0oa+NXeE1l+GG14dTMNTH25CYXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=g6BcZpKV; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=g6BcZpKV; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1730563482;
	bh=61z7O+6nYz3jsRlzVcw6dm9APvP6OG4QQ5C+u9mEglw=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=g6BcZpKVf4c46S0HHQsfEVkmCR8vytCzuWg9yhUnzVRbPLPFtf832nknEPRo/XaP6
	 OUUji43vQhQYci5494j27o3BQsk6r2iQlc0QcFMIMlOdd/IEd2l/gK7g2/DxSdD0q5
	 ZUfWqe3HLLulPV4tZt26FTf3aBgqJisq50jO1ABw=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 536AF12868A1;
	Sat, 02 Nov 2024 12:04:42 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id 9dgDmt7D3IjF; Sat,  2 Nov 2024 12:04:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1730563482;
	bh=61z7O+6nYz3jsRlzVcw6dm9APvP6OG4QQ5C+u9mEglw=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=g6BcZpKVf4c46S0HHQsfEVkmCR8vytCzuWg9yhUnzVRbPLPFtf832nknEPRo/XaP6
	 OUUji43vQhQYci5494j27o3BQsk6r2iQlc0QcFMIMlOdd/IEd2l/gK7g2/DxSdD0q5
	 ZUfWqe3HLLulPV4tZt26FTf3aBgqJisq50jO1ABw=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id C75741286824;
	Sat, 02 Nov 2024 12:04:39 -0400 (EDT)
Message-ID: <446cf9c70184885e4cec6dd4514ae8daf7accdcb.camel@HansenPartnership.com>
Subject: Re: [PATCH v9 06/19] x86: Add early SHA-1 support for Secure Launch
 early measurements
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: "Daniel P. Smith" <dpsmith@apertussolutions.com>, Andy Lutomirski
	 <luto@amacapital.net>
Cc: Thomas Gleixner <tglx@linutronix.de>, "Eric W. Biederman"
 <ebiederm@xmission.com>, Eric Biggers <ebiggers@kernel.org>, Ross Philipson
 <ross.philipson@oracle.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
 linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-crypto@vger.kernel.org, kexec@lists.infradead.org, 
 linux-efi@vger.kernel.org, iommu@lists.linux-foundation.org,
 mingo@redhat.com,  bp@alien8.de, hpa@zytor.com,
 dave.hansen@linux.intel.com, ardb@kernel.org,  mjg59@srcf.ucam.org,
 peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca,  nivedita@alum.mit.edu,
 herbert@gondor.apana.org.au, davem@davemloft.net,  corbet@lwn.net,
 dwmw2@infradead.org, baolu.lu@linux.intel.com,  kanth.ghatraju@oracle.com,
 andrew.cooper3@citrix.com,  trenchboot-devel@googlegroups.com
Date: Sat, 02 Nov 2024 11:04:38 -0500
In-Reply-To: <ff0c8eed-8981-48c4-81d9-56b040ef1c7b@apertussolutions.com>
References: <20240531010331.134441-1-ross.philipson@oracle.com>
	 <20240531010331.134441-7-ross.philipson@oracle.com>
	 <20240531021656.GA1502@sol.localdomain>
	 <874jaegk8i.fsf@email.froward.int.ebiederm.org>
	 <5b1ce8d3-516d-4dfd-a976-38e5cee1ef4e@apertussolutions.com>
	 <87ttflli09.ffs@tglx>
	 <CALCETrXQ7rChWLDqTG0+KY7rsfajSPguMnHO1G4VJi_mgwN9Zw@mail.gmail.com>
	 <1a1f0c41-70de-4f46-b91d-6dc7176893ee@apertussolutions.com>
	 <8a0b59a4-a5a2-42ae-bc1c-1ddc8f2aad16@apertussolutions.com>
	 <CALCETrX8caT5qvCUu24hQfxUF_wUC2XdGpS2YFP6SR++7FiM3Q@mail.gmail.com>
	 <c466ed57-35a8-41c0-9647-c70e588ad1d3@apertussolutions.com>
	 <CALCETrW9WNNGh1dEPKfQoeU+m5q6_m97d0_bzRkZsv2LxqB_ew@mail.gmail.com>
	 <ff0c8eed-8981-48c4-81d9-56b040ef1c7b@apertussolutions.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 2024-11-02 at 10:53 -0400, Daniel P. Smith wrote:
> Hi Luto,
> 
> My apologies, I missed this response and the active on v11 cause me
> to 
> get an inquiry why I hadn't responded.
> 
> On 9/21/24 18:40, Andy Lutomirski wrote:
[...]
> > I assumed that "deliberately cap" meant that there was an actual
> > feature where you write something to the event log (if applicable)
> > and extend the PCR in a special way that *turns that PCR off*. 
> > That is, it does something such that later-loaded software *can't*
> > use that PCR to attest or unseal anything, etc.
> > 
> > But it sounds like you're saying that no such feature exists.  And
> > a quick skim of the specs doesn't come up with anything.  And the
> > SHA1 banks may well be susceptible to a collision attack.
> 
> Correct, the only entity that can disable PCR banks is the firmware. 

No, that's not correct.  Any user can use TPM_PCR_Allocate to activate
or deactivate individual banks.  The caveat is the change is not
implemented until the next TPM reset (which should involve a reboot). 
BIOS also gets to the TPM before the kernel does, so it can, in theory,
check what banks a TPM has and call TPM_PCR_Allocate to change them. 
In practice, because this requires a reboot, this is usually only done
from the BIOS menus not on a direct boot ... so you can be reasonably
sure that whatever changes were made will stick.

> When it initializes the TPM, it can disable banks/algorithms. After 
> that, when an extend operation is done, the TPM is expecting an entry
> for all active PCR banks and the TPM itself does the extend hash that
> is stored into the PCRs.

This, also, is not quite correct: an extend is allowed to specify banks
that don't exist (in which case nothing happens and no error is
reported) and miss banks that do (in which case no extend is done to
that bank).  In the early days of TPM2, some BIOS implementations only
extended sha1 for instance, meaning the sha256 banks were all zero when
the kernel started.

Even today, if you activate a bank the BIOS doesn't know about, it
likely won't extend it.  You can see this in VM boots with OVMF and
software TPMs having esoteric banks like SM3.

Regards,

James


