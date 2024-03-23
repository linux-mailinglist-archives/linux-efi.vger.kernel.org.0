Return-Path: <linux-efi+bounces-861-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB819887664
	for <lists+linux-efi@lfdr.de>; Sat, 23 Mar 2024 02:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A658B2243F
	for <lists+linux-efi@lfdr.de>; Sat, 23 Mar 2024 01:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B411A59;
	Sat, 23 Mar 2024 01:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=apertussolutions.com header.i=dpsmith@apertussolutions.com header.b="V0YnjjmU"
X-Original-To: linux-efi@vger.kernel.org
Received: from sender4-of-o51.zoho.com (sender4-of-o51.zoho.com [136.143.188.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FC6A31;
	Sat, 23 Mar 2024 01:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711157675; cv=pass; b=Z3bb8jjGWAP5v9ecWBzBvrMOlnc0Mp92ZRfBid6an3mLFWtwpowDrp0wJzSDnQxw6esmVRB8BCSrlubzbmSKV5esOLv2pXhh/pFdYbnPBPR7B/1rcqDHjrRlGFMg4Z6kjRid3d9pYTAWYhuroaOfYz1YP7obsUG3w11Ze5IUWzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711157675; c=relaxed/simple;
	bh=Pcc+e6eivZ3tG225DvlUBIsuw9gooMR9r1KyZYl9irU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VtCBBHk2njlM8IQ6WwSYmd/Tvjd+aekLzwsGtepqisu6hkLUh1BMXT95jz5hqpW0kQQExtNv+3dexwCwWY/c/sdcWIJ5PzmzQjncRi2YE/3psnZpOkI9bFscW5wGgHiZqhay/LM+sslZe+Xc6j5+GaZW+04KbSrYJzKUpff4ioI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apertussolutions.com; spf=pass smtp.mailfrom=apertussolutions.com; dkim=pass (1024-bit key) header.d=apertussolutions.com header.i=dpsmith@apertussolutions.com header.b=V0YnjjmU; arc=pass smtp.client-ip=136.143.188.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apertussolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=apertussolutions.com
ARC-Seal: i=1; a=rsa-sha256; t=1711157626; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Y0P/6LGXB6XbnIcWo4Qk8zcdc8Jw+lAadY5AVPmkdkTcjKL1xfq/phucxRZdbbNgfKSheA1gZ2TCgQmpSop9a93QySuKrHzUX9cA/llTHTSpSkXW+MnPVF1RuubNen2kklKjmr1fhdL+1VTSotCBBBygMpSAIKA4weDZR7NPjbo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1711157626; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=zTwwKIN0GuMJg2NfAmR7tXmcZNVQ9X8RONWejAf+ILA=; 
	b=KDRxtlHCwaLfbAAuvARZF6Zb1Yd9S4Wk7hw94ajl31mDeFrjtRGKo03f3oU0hbeYXY+Twf6jhUzk66U3KG0HakCt85ulldco9lnwqTycdGJ/nGtzkdpct84+lOyaIr0+1VU+BLWyQm0sidgRu09Q3t6da3gTLqs77MzOejmgKmM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=apertussolutions.com;
	spf=pass  smtp.mailfrom=dpsmith@apertussolutions.com;
	dmarc=pass header.from=<dpsmith@apertussolutions.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1711157626;
	s=zoho; d=apertussolutions.com; i=dpsmith@apertussolutions.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=zTwwKIN0GuMJg2NfAmR7tXmcZNVQ9X8RONWejAf+ILA=;
	b=V0YnjjmUHOoqSu0E6ecOozxCpL45ni+sdwedBmm/G4ETjsKhjJ9rjKO5YeE+1DyK
	8x6FH+Z/xHt3BdkK9FPNXFzVS1wE10LyGtbPUcYy13Uwzinw3iZREXxoO1pIcB+2Gnz
	gro6z8WYudke6koxfL07M5d2VG3TE55huGqNCVv0=
Received: from [10.10.1.138] (static-72-81-132-2.bltmmd.fios.verizon.net [72.81.132.2]) by mx.zohomail.com
	with SMTPS id 1711157624195513.236242023147; Fri, 22 Mar 2024 18:33:44 -0700 (PDT)
Message-ID: <e52bbf77-4a80-4ebd-88f2-39e9b4063044@apertussolutions.com>
Date: Fri, 22 Mar 2024 21:33:41 -0400
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 01/15] x86/boot: Place kernel_info at a fixed offset
Content-Language: en-US
To: "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
 Ross Philipson <ross.philipson@oracle.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
 linux-efi@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, mjg59@srcf.ucam.org,
 James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de, jarkko@kernel.org,
 jgg@ziepe.ca, luto@amacapital.net, nivedita@alum.mit.edu,
 herbert@gondor.apana.org.au, davem@davemloft.net, kanth.ghatraju@oracle.com,
 trenchboot-devel@googlegroups.com
References: <20240214221847.2066632-1-ross.philipson@oracle.com>
 <20240214221847.2066632-2-ross.philipson@oracle.com>
 <CAMj1kXH3Gvr3vDRLDdXuc0s7ZAQYE6+D7tmCRBjJWwWt2fn4-w@mail.gmail.com>
 <9d01a6d2-4dd9-4331-8fc9-b01c07cfdbb5@apertussolutions.com>
 <32FDA47A-C87F-406F-A0B9-3AA1BB2EBAFB@zytor.com>
From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
Autocrypt: addr=dpsmith@apertussolutions.com; keydata=
 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
In-Reply-To: <32FDA47A-C87F-406F-A0B9-3AA1BB2EBAFB@zytor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 3/22/24 10:18, H. Peter Anvin wrote:
> On March 21, 2024 6:45:48 AM PDT, "Daniel P. Smith" <dpsmith@apertussolutions.com> wrote:
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
>> Yes, the bootloader needs a standardized means to find the offset of the MLE header, which communicates a set of meta-data needed by the DCE in order to set up for and start the loaded kernel. Arm will also need to provide a similar metadata structure and alternative entry point (or a complete rewrite of the existing entry point), as the current Arm entry point is in direct conflict with Arm DRTM specification.
>>
>>> I'd like to get away from x86 specific hacks for boot code and boot
>>> images, so I would like to explore if we can avoid kernel_info, or at
>>> least expose it in a generic way. We might just add a 32-bit offset
>>> somewhere in the first 64 bytes of the bootable image: this could
>>> co-exist with EFI bootable images, and can be implemented on arm64,
>>> RISC-V and LoongArch as well.
>>
>> With all due respect, I would not refer to boot params and the kern_info extension designed by the x86 maintainers as a hack. It is the well-defined boot protocol for x86, just as Arm has its own boot protocol around Device Tree.
>>
>> We would gladly adopt a cross arch/cross image type, zImage and bzImage, means to embedded meta-data about the kernel that can be discovered by a bootloader. Otherwise, we are relegated to doing a per arch/per image type discovery mechanism. If you have any suggestions that are cross arch/cross image type that we could explore, we would be grateful and willing to investigate how to adopt such a method.
>>
>> V/r,
>> Daniel
> 
> To be fair, the way things are going UEFI, i.e. PE/COFF, is becoming the new standard format. Yes, ELF would have been better, but...

Fully agree with the ELF sentiment. We started looking to see if PE/COFF 
has something similar to a ELF NOTE, but figured maybe this has been 
solved for other cases. If that is not the case or there are not any 
suggestions, then we can see what we can devise.

