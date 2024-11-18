Return-Path: <linux-efi+bounces-2170-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D949D18B7
	for <lists+linux-efi@lfdr.de>; Mon, 18 Nov 2024 20:13:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A198A282A9B
	for <lists+linux-efi@lfdr.de>; Mon, 18 Nov 2024 19:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E981E5021;
	Mon, 18 Nov 2024 19:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="Ozf74ThI";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="Ozf74ThI"
X-Original-To: linux-efi@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EE01E4919;
	Mon, 18 Nov 2024 19:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731957178; cv=none; b=KVdee/4OWQabx5mB1MkwTBp5xoAYCJ3C1uewnFVqwPXsMl0vIWt6JMuAIZjvYZja3jc2U+UsfLbISmGS/viSne2QIyGKr53iIiEI2FjO8LpQuZUkn5P8bpt2BybZR/bPzXc8D8MDjJFjDptgXH7f6O+yAJ5W6tgFXKlZqyiqdBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731957178; c=relaxed/simple;
	bh=VdczojjVKyfmXOxOrn7leLrVo11siUvhAyK3RXOyxC0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mMaBg2DSvDM1VXac0uon3nyjMiIdCJPPR3lc3ly8B778GBkcXD7+CTDgPi+6dlNJv0jBct8VNlq8aAbUh6jzNsFhNe00Ah8wXk2sQka1fwi3TqImi6oKgaQPQ3GhjaRpB+JDWcpikPiPSBmASsxxhUnlQFB4+5HMN2jk/KJODGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=Ozf74ThI; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=Ozf74ThI; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1731957175;
	bh=VdczojjVKyfmXOxOrn7leLrVo11siUvhAyK3RXOyxC0=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=Ozf74ThIs6GBipfyjqLtMJkVtEViRF/ojlTWhNT3LFk6V8DzO4GVQlF0IT9oyhi+f
	 MojWf67M2RoTKXTMrKjPqRqkA/EDeEt8yXUJMn0FgYxI2AxW9SPNsgaFwD+xcqM8C7
	 yrk2sf2XQMUc618ipScUnevD1+G7Nhq2XYX19EWo=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id C42F112864AE;
	Mon, 18 Nov 2024 14:12:55 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id ErtHBDOavLJl; Mon, 18 Nov 2024 14:12:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1731957175;
	bh=VdczojjVKyfmXOxOrn7leLrVo11siUvhAyK3RXOyxC0=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=Ozf74ThIs6GBipfyjqLtMJkVtEViRF/ojlTWhNT3LFk6V8DzO4GVQlF0IT9oyhi+f
	 MojWf67M2RoTKXTMrKjPqRqkA/EDeEt8yXUJMn0FgYxI2AxW9SPNsgaFwD+xcqM8C7
	 yrk2sf2XQMUc618ipScUnevD1+G7Nhq2XYX19EWo=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 1A9A312863BD;
	Mon, 18 Nov 2024 14:12:53 -0500 (EST)
Message-ID: <9c80e779b6268fde33c93ed3765ff93b1d6d007b.camel@HansenPartnership.com>
Subject: Re: [PATCH v9 06/19] x86: Add early SHA-1 support for Secure Launch
 early measurements
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Andy Lutomirski <luto@amacapital.net>, "Daniel P. Smith"
	 <dpsmith@apertussolutions.com>
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
Date: Mon, 18 Nov 2024 14:12:51 -0500
In-Reply-To: <CALCETrW6vMYZo-b7N9ojVSeZLVxhZjLBjnMHsULMGP6TaVYRHA@mail.gmail.com>
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
	 <446cf9c70184885e4cec6dd4514ae8daf7accdcb.camel@HansenPartnership.com>
	 <5d1e41d6-b467-4013-a0d0-45f9511c15c6@apertussolutions.com>
	 <CALCETrW6vMYZo-b7N9ojVSeZLVxhZjLBjnMHsULMGP6TaVYRHA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 2024-11-18 at 10:43 -0800, Andy Lutomirski wrote:
> Linux should not use TPM2_PCR_Extend *at all*.  Instead, Linux should
> exclusively use TPM2_PCR_Event.  I would expect that passing, say,
> the entire kernel image to TPM2_PCR_Event would be a big mistake, so
> instead Linux should hash the relevant data with a reasonable
> suggestion of hashes (which includes, mandatorily, SHA-384 and *does
> not* include SHA-1, and may or may not be configurable at build time
> to include things like SM3), concatenate them, and pass that to
> TPM2_PCR_Event.  And Linux should make the value that it passed to
> TPM2_PCR_Event readily accessible to software using it, and should
> also include some straightforward tooling to calculate it from a
> given input so that software that wants to figure out what value to
> expect in a PCR can easily do so.

Just for clarity, this is about how the agile log format works.  Each
event entry in the log contains a list of bank hashes and the extends
occur in log event order, so replaying a log should get you to exactly
the head PCR value of each bank.  If a log doesn't understand a format,
like SM3, then an entry for it doesn't appear in the log and a replay
says nothing about the PCR value.

For some events, the hash is actually the hash of the event entry
itself and for others, the entry is just a hint and the hash is of
something else.

I think part of the confusion stems from the twofold issues of PCRs: at
their simplest they were expected to provide the end policy values
(this turns out to be problematic because there are quite a few ways,
that will produce different end PCR values, that a system could get to
the same state).  If you don't trust a bank (or don't know about it),
you don't code it into a required policy statement and its value
becomes irrelevant.  If, as most remote attestation systems do, you're
analysing log entries, then you can calculate end PCR points for all
banks mentioned in the log and you could ask the TPM to quote all of
them.  In practice, you tend to pick a bank you prefer (sha256 usually)
and quote only that.  Again, if a bank doesn't appear in the log,
you're not going to ask for a quote from it, so what it contains is
irrelevant to the analysis of the log.


The point being that in neither case would the fact that boot software
failed to extend a bank it didn't have a hash for result in some type
of compromise.

Note that one of the things you can do with the log (because the
entries are separable) is strip out all the hashes for a bank. 
However, the remote is likely to refuse to accept the log if you, say,
strip the sha256 ones because you think a collision allows you to fake
a sha1 log because it would know you should have had sha256 entries as
well.

By the way, the only modern hash you can rely on a TPM2 having is
sha256.  Most of the older ones don't have sha384.  They all do have
sha1 for backwards compatibility with TPM1.2

James


