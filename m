Return-Path: <linux-efi+bounces-5966-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 069C0D04FF7
	for <lists+linux-efi@lfdr.de>; Thu, 08 Jan 2026 18:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6E8D313AB49
	for <lists+linux-efi@lfdr.de>; Thu,  8 Jan 2026 16:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F0C28688C;
	Thu,  8 Jan 2026 16:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=apertussolutions.com header.i=dpsmith@apertussolutions.com header.b="p2vL/Cl3"
X-Original-To: linux-efi@vger.kernel.org
Received: from sender4-of-o50.zoho.com (sender4-of-o50.zoho.com [136.143.188.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3123D2D73AD;
	Thu,  8 Jan 2026 16:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767890216; cv=pass; b=fd7FhDZHWwYBsoeIEknUcRa9a8gRUVWQU6hTgaEmZqHnnrES5q0cRY2DpUIZeXqUaKI/QY+4tFfemw/wxCJSlz40sMRkeNeoS6wPvEeAg+a6UaC7Z+2jzIQNK2B/F0lhjjn5SfRz1T0GI/6pmhT8suVkr6rPvR5df2Nj3RbZ1VI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767890216; c=relaxed/simple;
	bh=L+IPos5MuKL/ZcH5DfXa/EUElh2E3SkLtomLuaukDOE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iA8yKj2gArosH/vqzTrcjLcks+hs+sSNZkagWYR4IKJx8Ps2ZpOP4gyg/3GdDwna/suSHlN9Blq5urSt5733GMHi03O1sRIvswlnIHxk79caB7uCXSF9BpRsraddm8Oyd0AWK2qjz5z9bYTscCQFEp1eGfyIXmdyUMj4kHZ6ggQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apertussolutions.com; spf=pass smtp.mailfrom=apertussolutions.com; dkim=pass (1024-bit key) header.d=apertussolutions.com header.i=dpsmith@apertussolutions.com header.b=p2vL/Cl3; arc=pass smtp.client-ip=136.143.188.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apertussolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=apertussolutions.com
ARC-Seal: i=1; a=rsa-sha256; t=1767890167; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Li/kXjANjd65RQe/mTVw6fzSsm+4XzsFNDAoVJc2DH33e5Z3708UttYEjOBRBWiP35libMtJUu1XJQRs3oEXvwqXuZelksks5bbxo2n5mUzkNqEBKZiXTzRHsBJ0ChltIcN4pBng1lra7RrDvS+ORllHGM0jUll0xnhGMJus95o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1767890167; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=3fgOKlMQMvrdvMk8koNYIZJMH5yGHQCdYZiiHNFjJEw=; 
	b=LtXrOUVj+ta+dAHw4nMSae0NbI6tIHT8s3vEqH5NLCGCa0QkU40fNXOTzJed0/BX7Rj/hY2tClKd6BDbrZwBpO0qLVniQmIS2WT82lUyob2ZblmmhTV9zCLHGjy5+PSRhCMXmAzWcTeEGSvucrNy82AWRMTYbFzYsSxA8LpMkCQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=apertussolutions.com;
	spf=pass  smtp.mailfrom=dpsmith@apertussolutions.com;
	dmarc=pass header.from=<dpsmith@apertussolutions.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1767890167;
	s=zoho; d=apertussolutions.com; i=dpsmith@apertussolutions.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=3fgOKlMQMvrdvMk8koNYIZJMH5yGHQCdYZiiHNFjJEw=;
	b=p2vL/Cl3px20lR9/1mhM5GDoWubTVBr7vdIAD9h4UIH/mGNndn3QuLbgOZwiyP7J
	h6d8nX+r4RvFu8SOvFWPGE4MO9NZLS+/6NebbLzbxNPPKf+IWCfLA0GcCshBOohIRRP
	MuDRw8u6m4E9AiY1IJLZruEOP7t9ACdbzYWUhXx0=
Received: by mx.zohomail.com with SMTPS id 1767890164219491.1739791671507;
	Thu, 8 Jan 2026 08:36:04 -0800 (PST)
Message-ID: <91fd7e8e-6c64-458c-9d78-d97482d95705@apertussolutions.com>
Date: Thu, 8 Jan 2026 11:36:01 -0500
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 00/28] x86: Secure Launch support for Intel TXT
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
 <0cff620d-9be4-487d-8eb1-19375ca58a70@intel.com>
From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
Autocrypt: addr=dpsmith@apertussolutions.com; keydata=
 xsJuBFYrueARCACPWL3r2bCSI6TrkIE/aRzj4ksFYPzLkJbWLZGBRlv7HQLvs6i/K4y/b4fs
 JDq5eL4e9BdfdnZm/b+K+Gweyc0Px2poDWwKVTFFRgxKWq9R7McwNnvuZ4nyXJBVn7PTEn/Z
 G7D08iZg94ZsnUdeXfgYdJrqmdiWA6iX9u84ARHUtb0K4r5WpLUMcQ8PVmnv1vVrs/3Wy/Rb
 foxebZNWxgUiSx+d02e3Ad0aEIur1SYXXv71mqKwyi/40CBSHq2jk9eF6zmEhaoFi5+MMMgX
 X0i+fcBkvmT0N88W4yCtHhHQds+RDbTPLGm8NBVJb7R5zbJmuQX7ADBVuNYIU8hx3dF3AQCm
 601w0oZJ0jGOV1vXQgHqZYJGHg5wuImhzhZJCRESIwf+PJxik7TJOgBicko1hUVOxJBZxoe0
 x+/SO6tn+s8wKlR1Yxy8gYN9ZRqV2I83JsWZbBXMG1kLzV0SAfk/wq0PAppA1VzrQ3JqXg7T
 MZ3tFgxvxkYqUP11tO2vrgys+InkZAfjBVMjqXWHokyQPpihUaW0a8mr40w9Qui6DoJj7+Gg
 DtDWDZ7Zcn2hoyrypuht88rUuh1JuGYD434Q6qwQjUDlY+4lgrUxKdMD8R7JJWt38MNlTWvy
 rMVscvZUNc7gxcmnFUn41NPSKqzp4DDRbmf37Iz/fL7i01y7IGFTXaYaF3nEACyIUTr/xxi+
 MD1FVtEtJncZNkRn7WBcVFGKMAf+NEeaeQdGYQ6mGgk++i/vJZxkrC/a9ZXme7BhWRP485U5
 sXpFoGjdpMn4VlC7TFk2qsnJi3yF0pXCKVRy1ukEls8o+4PF2JiKrtkCrWCimB6jxGPIG3lk
 3SuKVS/din3RHz+7Sr1lXWFcGYDENmPd/jTwr1A1FiHrSj+u21hnJEHi8eTa9029F1KRfocp
 ig+k0zUEKmFPDabpanI323O5Tahsy7hwf2WOQwTDLvQ+eqQu40wbb6NocmCNFjtRhNZWGKJS
 b5GrGDGu/No5U6w73adighEuNcCSNBsLyUe48CE0uTO7eAL6Vd+2k28ezi6XY4Y0mgASJslb
 NwW54LzSSM0uRGFuaWVsIFAuIFNtaXRoIDxkcHNtaXRoQGFwZXJ0dXNzb2x1dGlvbnMuY29t
 PsJ6BBMRCAAiBQJWK7ngAhsjBgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRBTc6WbYpR8
 KrQ9AP94+xjtFfJ8gj5c7PVx06Zv9rcmFUqQspZ5wSEkvxOuQQEAg6qEsPYegI7iByLVzNEg
 7B7fUG7pqWIfMqFwFghYhQzOwU0EViu54BAIAL6MXXNlrJ5tRUf+KMBtVz1LJQZRt/uxWrCb
 T06nZjnbp2UcceuYNbISOVHGXTzu38r55YzpkEA8eURQf+5hjtvlrOiHxvpD+Z6WcpV6rrMB
 kcAKWiZTQihW2HoGgVB3gwG9dCh+n0X5OzliAMiGK2a5iqnIZi3o0SeW6aME94bSkTkuj6/7
 OmH9KAzK8UnlhfkoMg3tXW8L6/5CGn2VyrjbB/rcrbIR4mCQ+yCUlocuOjFCJhBd10AG1IcX
 OXUa/ux+/OAV9S5mkr5Fh3kQxYCTcTRt8RY7+of9RGBk10txi94dXiU2SjPbassvagvu/hEi
 twNHms8rpkSJIeeq0/cAAwUH/jV3tXpaYubwcL2tkk5ggL9Do+/Yo2WPzXmbp8vDiJPCvSJW
 rz2NrYkd/RoX+42DGqjfu8Y04F9XehN1zZAFmCDUqBMa4tEJ7kOT1FKJTqzNVcgeKNBGcT7q
 27+wsqbAerM4A0X/F/ctjYcKwNtXck1Bmd/T8kiw2IgyeOC+cjyTOSwKJr2gCwZXGi5g+2V8
 NhJ8n72ISPnOh5KCMoAJXmCF+SYaJ6hIIFARmnuessCIGw4ylCRIU/TiXK94soilx5aCqb1z
 ke943EIUts9CmFAHt8cNPYOPRd20pPu4VFNBuT4fv9Ys0iv0XGCEP+sos7/pgJ3gV3pCOric
 p15jV4PCYQQYEQgACQUCViu54AIbDAAKCRBTc6WbYpR8Khu7AP9NJrBUn94C/3PeNbtQlEGZ
 NV46Mx5HF0P27lH3sFpNrwD/dVdZ5PCnHQYBZ287ZxVfVr4Zuxjo5yJbRjT93Hl0vMY=
In-Reply-To: <0cff620d-9be4-487d-8eb1-19375ca58a70@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 12/16/25 17:14, Dave Hansen wrote:
> On 12/15/25 15:32, Ross Philipson wrote:
>> Patch set based on commit:
>> torvalds/master/fd57572253bc356330dbe5b233c2e1d8426c66fd
> 
> That's an interesting place to pick. What was the reasoning behind it?

It was simply that it was the tip of torvalds/master at the time the 
patch series was prepared. As far as we could find, there is not a lot 
of guidance on commit selection in the patch guide. If there is a 
generally accepted convention we should follow, we would be glad to 
follow it.

v/r,
dps

