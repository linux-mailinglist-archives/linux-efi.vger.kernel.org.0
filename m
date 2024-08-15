Return-Path: <linux-efi+bounces-1539-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C31953956
	for <lists+linux-efi@lfdr.de>; Thu, 15 Aug 2024 19:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99FD41F25FC8
	for <lists+linux-efi@lfdr.de>; Thu, 15 Aug 2024 17:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E283A57CB6;
	Thu, 15 Aug 2024 17:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=apertussolutions.com header.i=dpsmith@apertussolutions.com header.b="vCX9b9gU"
X-Original-To: linux-efi@vger.kernel.org
Received: from sender4-of-o51.zoho.com (sender4-of-o51.zoho.com [136.143.188.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F921AC8AD;
	Thu, 15 Aug 2024 17:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723743623; cv=pass; b=f0Meej8C3q+Qy8ZxyljpKs82/ivGPVz6fxkPRznmbWUgKDZMX4Clu8kmV146fqZVrMZmksggOnmRNROtyn9qCsFTkjWQs3cgL8PgKhR2akeUAiu608SkmJ7TrHMUIeL5LkcEuPz8MZS9HAPrwh8yw2WL5qdNAI7vXAGawu8vWkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723743623; c=relaxed/simple;
	bh=bVlz1UFh7t4JdgfkTkpQo9XS82KLFdi9kDpfgcsTMuM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IfFcvqRXfzMFlLaDXxCH6XqCaWXTftKlSPer+qsoRc/i48127q70ybZ9L9/Q4MsMh2ko5mFXpNIfr3oVCpjPzzI3Kd1igLy/JPTEoH/XEnUzxx0UxVsuTJqPkvm59BsO8P44+KDM4kQ1PoDTyRjbb1sz59G7gMJyd/51a9mTGAM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apertussolutions.com; spf=pass smtp.mailfrom=apertussolutions.com; dkim=pass (1024-bit key) header.d=apertussolutions.com header.i=dpsmith@apertussolutions.com header.b=vCX9b9gU; arc=pass smtp.client-ip=136.143.188.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apertussolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=apertussolutions.com
ARC-Seal: i=1; a=rsa-sha256; t=1723743539; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=XtGseNy4C77Qkun9eK1PM0fPYtZco/I19ax9wStj3XsehsM63o2G8LEkEnVXVrp11m6R0JzsGNLFv33xWClEax53yJ/cVO5KoeKMGdfqDyYSsuJZMgNCH94Tr46n/8p6UQaijSKzeohjTtKgE/qh7sQM6c6O1rmYfE1aXNJ2wyM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1723743539; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=k1yW3lqDSNMNJ8KRaQwnFW+bmQLXz7OCYYupyBO4txs=; 
	b=JTM7T4rXFqt5jnG/WJsGrc4UGMnI2yC1Yba96T+vZ6JHobJC4A687NAk3Ebt9sImzaYdjdtB0oYtKZH65jzhxKhIHQjJk6ZuTV0CpWVsBiHxYapeE0MZToUFYYqe+3WHtqEeDWDrVZeYcIDB5xNLIv+ylL8h6uM0q7L6VKb75mw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=apertussolutions.com;
	spf=pass  smtp.mailfrom=dpsmith@apertussolutions.com;
	dmarc=pass header.from=<dpsmith@apertussolutions.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1723743539;
	s=zoho; d=apertussolutions.com; i=dpsmith@apertussolutions.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=k1yW3lqDSNMNJ8KRaQwnFW+bmQLXz7OCYYupyBO4txs=;
	b=vCX9b9gUcbLUptKgKJtbd6AX+UcIO83NY+v4mISA1evOj5c51XaFZNoTkefHPKhA
	2RYcT3/+w0fGliPZCs0P2PIulpS4d5LeTrykCZHALZ0/0XuXUck16UUbBQ1PT/5oJUj
	kwT22TRFbbFY+aqfopGNGHOoueq8bTnqaNBwV+o4=
Received: by mx.zohomail.com with SMTPS id 1723743536581442.62993572542007;
	Thu, 15 Aug 2024 10:38:56 -0700 (PDT)
Message-ID: <5b1ce8d3-516d-4dfd-a976-38e5cee1ef4e@apertussolutions.com>
Date: Thu, 15 Aug 2024 13:38:52 -0400
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 06/19] x86: Add early SHA-1 support for Secure Launch
 early measurements
Content-Language: en-US
To: "Eric W. Biederman" <ebiederm@xmission.com>,
 Eric Biggers <ebiggers@kernel.org>
Cc: Ross Philipson <ross.philipson@oracle.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
 linux-efi@vger.kernel.org, iommu@lists.linux-foundation.org,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
 dave.hansen@linux.intel.com, ardb@kernel.org, mjg59@srcf.ucam.org,
 James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de, jarkko@kernel.org,
 jgg@ziepe.ca, luto@amacapital.net, nivedita@alum.mit.edu,
 herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net,
 dwmw2@infradead.org, baolu.lu@linux.intel.com, kanth.ghatraju@oracle.com,
 andrew.cooper3@citrix.com, trenchboot-devel@googlegroups.com
References: <20240531010331.134441-1-ross.philipson@oracle.com>
 <20240531010331.134441-7-ross.philipson@oracle.com>
 <20240531021656.GA1502@sol.localdomain>
 <874jaegk8i.fsf@email.froward.int.ebiederm.org>
From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
Autocrypt: addr=dpsmith@apertussolutions.com; keydata=
 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
In-Reply-To: <874jaegk8i.fsf@email.froward.int.ebiederm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 5/31/24 09:54, Eric W. Biederman wrote:
> Eric Biggers <ebiggers@kernel.org> writes:
> 
>> On Thu, May 30, 2024 at 06:03:18PM -0700, Ross Philipson wrote:
>>> From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
>>>
>>> For better or worse, Secure Launch needs SHA-1 and SHA-256. The
>>> choice of hashes used lie with the platform firmware, not with
>>> software, and is often outside of the users control.
>>>
>>> Even if we'd prefer to use SHA-256-only, if firmware elected to start us
>>> with the SHA-1 and SHA-256 backs active, we still need SHA-1 to parse
>>> the TPM event log thus far, and deliberately cap the SHA-1 PCRs in order
>>> to safely use SHA-256 for everything else.
>>>
>>> The SHA-1 code here has its origins in the code from the main kernel:
>>>
>>> commit c4d5b9ffa31f ("crypto: sha1 - implement base layer for SHA-1")
>>>
>>> A modified version of this code was introduced to the lib/crypto/sha1.c
>>> to bring it in line with the SHA-256 code and allow it to be pulled into the
>>> setup kernel in the same manner as SHA-256 is.
>>>
>>> Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
>>> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
>>
>> Thanks.  This explanation doesn't seem to have made it into the actual code or
>> documentation.  Can you please get it into a more permanent location?
>>
>> Also, can you point to where the "deliberately cap the SHA-1 PCRs" thing happens
>> in the code?
>>
>> That paragraph is also phrased as a hypothetical, "Even if we'd prefer to use
>> SHA-256-only".  That implies that you do not, in fact, prefer SHA-256 only.  Is
>> that the case?  Sure, maybe there are situations where you *have* to use SHA-1,
>> but why would you not at least *prefer* SHA-256?
> 
> Yes.  Please prefer to use SHA-256.
> 
> Have you considered implementing I think it is SHA1-DC (as git has) that
> is compatible with SHA1 but blocks the known class of attacks where
> sha1 is actively broken at this point?

We are using the kernel's implementation, addressing what the kernel 
provides is beyond our efforts. Perhaps someone who is interested in 
improving the kernel's SHA1 could submit a patch implementing/replacing 
it with SHA1-DC, as I am sure the maintainers would welcome the help.

v/r,
dps

