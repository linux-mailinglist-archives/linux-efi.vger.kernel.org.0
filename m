Return-Path: <linux-efi+bounces-1625-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55ADE9647B3
	for <lists+linux-efi@lfdr.de>; Thu, 29 Aug 2024 16:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7E18B22BBA
	for <lists+linux-efi@lfdr.de>; Thu, 29 Aug 2024 14:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00011AD419;
	Thu, 29 Aug 2024 14:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=apertussolutions.com header.i=dpsmith@apertussolutions.com header.b="fRJYXpXL"
X-Original-To: linux-efi@vger.kernel.org
Received: from sender4-of-o51.zoho.com (sender4-of-o51.zoho.com [136.143.188.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9034E1A3BDD;
	Thu, 29 Aug 2024 14:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724940747; cv=pass; b=MbqgQEZK5Xk+2D+sOpjtK2h+HFdl+0bfkj37W1K1Uds1NxXSt78iZyNW93HJ2rFrgcJzjKZMxgYrhyvsJpTZ87TKTGpadfQfoTBwhTaexdPGBv5T7SB1uCKGR37iXhBTzW/4zZHknpr67Vv3YwgMiqf/Ah8ym8wJMIiAo15+A/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724940747; c=relaxed/simple;
	bh=7hB/1UOJaiqQ99Joa1DObT9nogjXVp6w2U15f4FVo3Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lxb0veOerT8BEIzmJq9Tk7r/EASVTsWNexoWFtVdf0MxZOZfnpPtwQ+VtE1GHfeH/V3xMNoD2tNr8GuK6Y7VWRCRCJgqDLDOKK6CpYcj5wwtUJWS9N4ED2EpPwtwequwRmLlVNfxbsu3UpsA0DFVu51hnzxJ/y8gQzsIfBRX+jA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apertussolutions.com; spf=pass smtp.mailfrom=apertussolutions.com; dkim=pass (1024-bit key) header.d=apertussolutions.com header.i=dpsmith@apertussolutions.com header.b=fRJYXpXL; arc=pass smtp.client-ip=136.143.188.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apertussolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=apertussolutions.com
ARC-Seal: i=1; a=rsa-sha256; t=1724940676; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=E7EusWO6er6F2xI1Zxfssj17795cFIrBU9nS7H5PyLGs+6UWBCNXAkfV+JQpsvkn4X6QnDjZg59GcAbdwpZwp541+ugqTaxP6T/nv6M351s7VISQpTXJZegJ/QpLmHKW8PhIgd5ObyYNwREe1/OqSZxAHGA/WYAAlVOJLcXTMDk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1724940676; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=HgDBKtReaNoT627XPwozc8cV/1MN4aAoTtHPOciy3pM=; 
	b=F8+Ieta99m9Sb6grjg5r5Hse1Vt8cQANARXzRz4E2JRoFdXjGYznYWVRmMvi/k0t3GJxjfgkNXCi7mbnz93mta8ovG1WRwOCa2szi73evgpHYzIgytv1sd3soamVZ71SpJYmuyZoaySGKcb25OExw2BJMSP43syvz3OmqKbf23o=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=apertussolutions.com;
	spf=pass  smtp.mailfrom=dpsmith@apertussolutions.com;
	dmarc=pass header.from=<dpsmith@apertussolutions.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1724940676;
	s=zoho; d=apertussolutions.com; i=dpsmith@apertussolutions.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=HgDBKtReaNoT627XPwozc8cV/1MN4aAoTtHPOciy3pM=;
	b=fRJYXpXL9J45pXy0RROxungza/op8PLpbcAgBCB2imI/b3vHv4nw02sEX8neAivz
	PPiCX2FneFCwIi7K74vsx1xZ2NcmUIkgDl+v3rZoRF1EkHBouBvTymaYqasGUoGZL83
	itV4OEfBmfm1uvXSAhidcGZMH/LIAtY/V/1UW3+4=
Received: by mx.zohomail.com with SMTPS id 1724940674239491.862092879441;
	Thu, 29 Aug 2024 07:11:14 -0700 (PDT)
Message-ID: <e3194ad1-e976-40a6-a8f3-98081b0b07ea@apertussolutions.com>
Date: Thu, 29 Aug 2024 10:11:11 -0400
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 01/15] x86/boot: Place kernel_info at a fixed offset
To: Ard Biesheuvel <ardb@kernel.org>, Stuart Yoder <stuart.yoder@arm.com>
Cc: Ross Philipson <ross.philipson@oracle.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
 linux-efi@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com,
 mjg59@srcf.ucam.org, James.Bottomley@hansenpartnership.com,
 peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net,
 nivedita@alum.mit.edu, herbert@gondor.apana.org.au, davem@davemloft.net,
 kanth.ghatraju@oracle.com, trenchboot-devel@googlegroups.com
References: <20240214221847.2066632-1-ross.philipson@oracle.com>
 <20240214221847.2066632-2-ross.philipson@oracle.com>
 <CAMj1kXH3Gvr3vDRLDdXuc0s7ZAQYE6+D7tmCRBjJWwWt2fn4-w@mail.gmail.com>
 <9d01a6d2-4dd9-4331-8fc9-b01c07cfdbb5@apertussolutions.com>
 <CAMj1kXHn6xeAskWiDLvvA4oG3j9_tqx+iMYJXMqmgvyX4pMzgg@mail.gmail.com>
Content-Language: en-US
From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
In-Reply-To: <CAMj1kXHn6xeAskWiDLvvA4oG3j9_tqx+iMYJXMqmgvyX4pMzgg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 8/28/24 13:45, Ard Biesheuvel wrote:
> (cc Stuart)
> 
> On Thu, 21 Mar 2024 at 15:46, Daniel P. Smith
> <dpsmith@apertussolutions.com> wrote:
>>
>> Hi Ard!
>>
>> On 2/15/24 02:56, Ard Biesheuvel wrote:
>>> On Wed, 14 Feb 2024 at 23:31, Ross Philipson <ross.philipson@oracle.com> wrote:
>>>>
>>>> From: Arvind Sankar <nivedita@alum.mit.edu>
>>>>
>>>> There are use cases for storing the offset of a symbol in kernel_info.
>>>> For example, the trenchboot series [0] needs to store the offset of the
>>>> Measured Launch Environment header in kernel_info.
>>>>
>>>
>>> Why? Is this information consumed by the bootloader?
>>
>> Yes, the bootloader needs a standardized means to find the offset of the
>> MLE header, which communicates a set of meta-data needed by the DCE in
>> order to set up for and start the loaded kernel. Arm will also need to
>> provide a similar metadata structure and alternative entry point (or a
>> complete rewrite of the existing entry point), as the current Arm entry
>> point is in direct conflict with Arm DRTM specification.
>>
> 
> Digging up an old thread here: could you elaborate on this? What do
> you mean by 'Arm entry point' and how does it conflict directly with
> the Arm DRTM specification? The Linux/arm64 port predates that spec by
> about 10 years, so I would expect the latter to take the former into
> account. If that failed to happen, we should fix the spec while we
> still can.

Yes, we have been working with Stuart regarding the specification and 
crafting a compliant implementation approach. It is still very early 
days, we are attempting to draft a plan around the specification with no 
physical implementation to validate against. After some discussion, the 
concern that a separate entry point may be needed has faded and in fact 
it likely will not be needed. As always, the devil is in the details, 
and until we have a hardware that has implemented the specification, and 
we attempt to light it up, we won't know what will be needed for the 
implementation.

In short, at this point it was determined no update to the DRTM spec is 
needed. As hardware becomes available, and we do battle with it, Stuart 
will be kept up to date. We will work with him to ensure any changes are 
captured that will help reduce chances that vendors and developers do 
not misinterpret the spec.

V/r,
Daniel P. Smith

