Return-Path: <linux-efi+bounces-5965-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A10D04E4E
	for <lists+linux-efi@lfdr.de>; Thu, 08 Jan 2026 18:22:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 893A930AE2F6
	for <lists+linux-efi@lfdr.de>; Thu,  8 Jan 2026 16:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91DBC27280F;
	Thu,  8 Jan 2026 16:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=apertussolutions.com header.i=dpsmith@apertussolutions.com header.b="dlxv/K6Z"
X-Original-To: linux-efi@vger.kernel.org
Received: from sender4-of-o50.zoho.com (sender4-of-o50.zoho.com [136.143.188.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348772F85B;
	Thu,  8 Jan 2026 16:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767889375; cv=pass; b=ufus9ogG5DwBsBoOFlxyEoxzgi5CXTp+OuzdZ5w/yuT1kdsA6kPRCC8p4+qsz/ErYwC3oqIAvTClh5RWD0WlCFx47kjkxaQTvGIlp2E4ZJBJ5u3brg0876PtfTK8hMGUTdLKvYvAj0Hb32kbQMYS4NIuYx2qHdrtwKasj14k18U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767889375; c=relaxed/simple;
	bh=+zUpWzhBo4C4q4QtCguT1lWr97eOh1cfKA9jqI4g5Ug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bsCQTwT4/K861wxWK1FsA9HsXjM7tEayLT2L9RdYcCBR0sqyN4xfP3cvHbFsWEh3rQKUxfYeSF83kTZ++6B5drvrCcQjkqXkqfsO5DwRQx/cV9lxFG6nou45VzTPHl914XTHdatCYdGhB4Je8jprpB9SRY08r+faYiDXydLDxcQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apertussolutions.com; spf=pass smtp.mailfrom=apertussolutions.com; dkim=pass (1024-bit key) header.d=apertussolutions.com header.i=dpsmith@apertussolutions.com header.b=dlxv/K6Z; arc=pass smtp.client-ip=136.143.188.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apertussolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=apertussolutions.com
ARC-Seal: i=1; a=rsa-sha256; t=1767889297; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=IXM3IwQSRjpf/AjEz0IjjgNpQjKhbp5nQ8u43T/PE0S2VoEpHrCn41jycdM712iwf9SCmkXoHzMIahruw+OiMdoiMDU65J49RY54wL/zZJJwPKVDBCcDoveqL4CBjR4yE9wL/S0hCXYHl4a3+rJ6q4JdT07ezzAMed44GQyD5w0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1767889297; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=oqv29i/Jkyku4YGsPHEwXi5y4vCYAIfyZbGbk20cx3Q=; 
	b=V4u9qhFfLwuC/8Ag3Sr7TEjepvSGOCV/0ZLCktSz/x6xG7OdamVnnr7uXXtZ8K05UG6IkM2ElQmmVgs2MgnTSYFX8utd266JxvnAhmeeOd5+bfetzHyFAJxsbX51kZa008dUmX9puWqIpF2mcE2Ew2pQNnqeiiGZ8FHA5+0eop4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=apertussolutions.com;
	spf=pass  smtp.mailfrom=dpsmith@apertussolutions.com;
	dmarc=pass header.from=<dpsmith@apertussolutions.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1767889297;
	s=zoho; d=apertussolutions.com; i=dpsmith@apertussolutions.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=oqv29i/Jkyku4YGsPHEwXi5y4vCYAIfyZbGbk20cx3Q=;
	b=dlxv/K6ZtChdyvl/fMxeMprD8qzLhwyyhoGEar4fSoaloeGwKaCIeVO/F2y/Q5Ka
	T744G8PcyfblQWZlsHFeICcqT+L/mnCRbA9zEbnGSZ4EGhtqWDeoxqlA7dmfI0TpyXU
	7GSm0GZP1/k+gmQmJ7byGqtM0ntYyCd6Cup03B7E=
Received: by mx.zohomail.com with SMTPS id 1767889293888361.3114789025136;
	Thu, 8 Jan 2026 08:21:33 -0800 (PST)
Message-ID: <adb92eca-440b-4322-b65b-c21279710a0a@apertussolutions.com>
Date: Thu, 8 Jan 2026 11:21:31 -0500
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 19/28] x86/tpm: Early TPM PCR extending driver
Content-Language: en-US
To: Dave Hansen <dave.hansen@intel.com>,
 Ross Philipson <ross.philipson@oracle.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
 linux-efi@vger.kernel.org, iommu@lists.linux.dev
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
 dave.hansen@linux.intel.com, ardb@kernel.org, mjg59@srcf.ucam.org,
 James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de, jarkko@kernel.org,
 jgg@ziepe.ca, luto@amacapital.net, nivedita@alum.mit.edu,
 herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net,
 ebiederm@xmission.com, dwmw2@infradead.org, baolu.lu@linux.intel.com,
 kanth.ghatraju@oracle.com, andrew.cooper3@citrix.com,
 trenchboot-devel@googlegroups.com
References: <20251215233316.1076248-1-ross.philipson@oracle.com>
 <20251215233316.1076248-20-ross.philipson@oracle.com>
 <56929e8b-a7cf-4390-b4ec-0b4c2c32b311@intel.com>
 <62227ed3-3804-4795-93c9-ce2bbad3f2a7@apertussolutions.com>
 <a507a85c-e1dd-4c63-94b2-9756ea9ece63@intel.com>
From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
Autocrypt: addr=dpsmith@apertussolutions.com; keydata=
 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
In-Reply-To: <a507a85c-e1dd-4c63-94b2-9756ea9ece63@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 1/3/26 15:44, Dave Hansen wrote:
> On 12/19/25 13:26, Daniel P. Smith wrote:
> ...
>>> I also seem to remember that there are special rules around the US
>>> federal government's inability to hold copyrights. This seems worth at
>>> least a mention ... somewhere.
>>
>> IANAL either, but in general the safest/correct approach is to retain
>> any CRs placed on the code being reused, and the above is the CR on the
>> source from the Xen tree.
> 
> Yeah, in general, that's a good thing to do.
> 
> But I'm puzzled by your response. Are you making an attempt to justify
> the past choice to copy the copyrights verbatim? Or are you declining to
> follow my request to involve your companies' legal experts given that
> you used the "safest/correct approach"?

My apologies that it came across like I was rebuffing your request. I 
was just trying to inform as to why it was there. Yes, we are working to 
determine the answer to your concern and what should be the correct 
course of action.

> FWIW, I don't think what you did was bad here. You _did_ use a quite
> reasonable approach in the case that a copyright was copied verbatim
> from an existing legitimate* project.
> 
>   * I'll give Xen the benefit of the doubt just this one time and put it
>     in the "legitimate" bucket. :P

As a Xen contributor/maintainer, thanks ... I think. (^_^)

V/r,
dps

