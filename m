Return-Path: <linux-efi+bounces-1718-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79051977620
	for <lists+linux-efi@lfdr.de>; Fri, 13 Sep 2024 02:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36D19286900
	for <lists+linux-efi@lfdr.de>; Fri, 13 Sep 2024 00:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 814321C14;
	Fri, 13 Sep 2024 00:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=apertussolutions.com header.i=dpsmith@apertussolutions.com header.b="ENsJ49sY"
X-Original-To: linux-efi@vger.kernel.org
Received: from sender4-of-o51.zoho.com (sender4-of-o51.zoho.com [136.143.188.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2308410F7;
	Fri, 13 Sep 2024 00:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726187757; cv=pass; b=KulBmDvIUYPDFVvWlIh9JSnkO9+iWru/k5+FH8ex1wlzhi+dCXIgsM2ru+khLjmN7+JX5HZ+pSmNAN+TTjBUImLqrySKsdeyxQbLJd/ig7xFYijdXDe2ErE2XT86ZzXo5aai1mFoMnKWW6zx8J96YHO00U1NP03QJ6d1Q8uHnjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726187757; c=relaxed/simple;
	bh=ZQqJrDgJY1iWaRecpkr7fz44BBb5Dlfw1AQRQgPg2hQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=FC1j6id+k4Ka9kWjwgXkmQeUqNJuWA9+9/1DAUW1XX9z9n66qgJqG90cn/Y5sGW7NBEW6oGNWxjmShXUOkGYGF/JP7+lqJXax9vYKhVQJUbQ4ovYrrdPmixJrTIyG3tvN3/tw4woutdjdeYiiiOGTnwXy65elUApCRHFKYMmQL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apertussolutions.com; spf=pass smtp.mailfrom=apertussolutions.com; dkim=pass (1024-bit key) header.d=apertussolutions.com header.i=dpsmith@apertussolutions.com header.b=ENsJ49sY; arc=pass smtp.client-ip=136.143.188.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apertussolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=apertussolutions.com
ARC-Seal: i=1; a=rsa-sha256; t=1726187681; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=TQZZoO1GdRMjOMaE+32jcQqZlBE73nFdLQLrlJHHDwWHrSfD9G37df/k8dYYievD5ey3GnDo4v/Torjz4Ea3uaaA4pEISHQTBYWhK6RFiJDXwOyaR+Z5D4O8HOSYtc9eBoQW7I9KYEL6pozwsRcu5nCT+kPD+JpbQg0hMPRorIc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1726187681; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=T7p1rwwLWDZqzIO3KBZ6In4AI2NiE3aqshFaj7LI/og=; 
	b=aJeQ6mVd6eTC96nOK3A63MwDgR17ENPkwQ5IGnCiFEQb/5PrXVw3day5oh/tQhHSKA5pg2T68lu3LNAZ/9eUBAqQs63Cklp62sbpfLON6Z27CJn6Sp9uy0KJ+Jv6HbM43ls6ROmbRzIe7Ai6ms7jxnHg7Op9X6nZaD6qiQcB0vg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=apertussolutions.com;
	spf=pass  smtp.mailfrom=dpsmith@apertussolutions.com;
	dmarc=pass header.from=<dpsmith@apertussolutions.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1726187681;
	s=zoho; d=apertussolutions.com; i=dpsmith@apertussolutions.com;
	h=Message-ID:Date:Date:MIME-Version:From:From:Subject:Subject:To:To:Cc:Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=T7p1rwwLWDZqzIO3KBZ6In4AI2NiE3aqshFaj7LI/og=;
	b=ENsJ49sYMCyT34DFM1kNtaKzqa3g/gukXlVy0JpcXNWf9vA5ZxzXwD1YpEeUrVNU
	Qw0BcfCtgT3WRPi8PdBCfUIMhG4jcb5wLNncyYgsNPbG5B3OT1aeO8tCHORURMWFpti
	YHn/c9fTDv3V09tC5K+Yb8eBRUyr4hO40Eyu1rHw=
Received: by mx.zohomail.com with SMTPS id 1726187680192286.84244920487254;
	Thu, 12 Sep 2024 17:34:40 -0700 (PDT)
Message-ID: <8a0b59a4-a5a2-42ae-bc1c-1ddc8f2aad16@apertussolutions.com>
Date: Thu, 12 Sep 2024 20:34:31 -0400
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
Subject: Re: [PATCH v9 06/19] x86: Add early SHA-1 support for Secure Launch
 early measurements
To: Andy Lutomirski <luto@amacapital.net>,
 Thomas Gleixner <tglx@linutronix.de>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
 Eric Biggers <ebiggers@kernel.org>,
 Ross Philipson <ross.philipson@oracle.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
 linux-efi@vger.kernel.org, iommu@lists.linux-foundation.org,
 mingo@redhat.com, bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com,
 ardb@kernel.org, mjg59@srcf.ucam.org, James.Bottomley@hansenpartnership.com,
 peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca, nivedita@alum.mit.edu,
 herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net,
 dwmw2@infradead.org, baolu.lu@linux.intel.com, kanth.ghatraju@oracle.com,
 andrew.cooper3@citrix.com, trenchboot-devel@googlegroups.com
References: <20240531010331.134441-1-ross.philipson@oracle.com>
 <20240531010331.134441-7-ross.philipson@oracle.com>
 <20240531021656.GA1502@sol.localdomain>
 <874jaegk8i.fsf@email.froward.int.ebiederm.org>
 <5b1ce8d3-516d-4dfd-a976-38e5cee1ef4e@apertussolutions.com>
 <87ttflli09.ffs@tglx>
 <CALCETrXQ7rChWLDqTG0+KY7rsfajSPguMnHO1G4VJi_mgwN9Zw@mail.gmail.com>
 <1a1f0c41-70de-4f46-b91d-6dc7176893ee@apertussolutions.com>
Content-Language: en-US
In-Reply-To: <1a1f0c41-70de-4f46-b91d-6dc7176893ee@apertussolutions.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hey again,

On 9/4/24 21:01, Daniel P. Smith wrote:
> Hi Luto.
> 
> On 8/28/24 23:17, Andy Lutomirski wrote:
>> On Thu, Aug 15, 2024 at 12:10 PM Thomas Gleixner <tglx@linutronix.de> 
>> wrote:
>>>
>>> On Thu, Aug 15 2024 at 13:38, Daniel P. Smith wrote:
>>>> On 5/31/24 09:54, Eric W. Biederman wrote:
>>>>> Eric Biggers <ebiggers@kernel.org> writes:
>>>>>> That paragraph is also phrased as a hypothetical, "Even if we'd 
>>>>>> prefer to use
>>>>>> SHA-256-only".  That implies that you do not, in fact, prefer 
>>>>>> SHA-256 only.  Is
>>>>>> that the case?  Sure, maybe there are situations where you *have* 
>>>>>> to use SHA-1,
>>>>>> but why would you not at least *prefer* SHA-256?
>>>>>
>>>>> Yes.  Please prefer to use SHA-256.
>>>>>
>>>>> Have you considered implementing I think it is SHA1-DC (as git has) 
>>>>> that
>>>>> is compatible with SHA1 but blocks the known class of attacks where
>>>>> sha1 is actively broken at this point?
>>>>
>>>> We are using the kernel's implementation, addressing what the kernel
>>>> provides is beyond our efforts. Perhaps someone who is interested in
>>>> improving the kernel's SHA1 could submit a patch implementing/replacing
>>>> it with SHA1-DC, as I am sure the maintainers would welcome the help.
>>>
>>> Well, someone who is interested to get his "secure" code merged should
>>> have a vested interested to have a non-broken SHA1 implementation if
>>> there is a sensible requirement to use SHA1 in that new "secure" code,
>>> no?
>>>
>>> Just for the record. The related maintainers can rightfully decide to
>>> reject known broken "secure" code on a purely technical argument.
>>>
>>
>> Wait, hold on a second.
>>
>> SHA1-DC isn't SHA1.  It's a different hash function that is mostly
>> compatible with SHA1, is different on some inputs, and is maybe more
>> secure.  But the _whole point_ of using SHA1 in the TPM code (well,
>> this really should be the whole point for new applications) is to
>> correctly cap the SHA1 PCRs so we can correctly _turn them off_ in the
>> best way without breaking compatibility with everything that might
>> read the event log.  I think that anyone suggesting using SHA1-DC for
>> this purpose should give some actual analysis as to why they think
>> it's an improvement, let alone even valid.
> 
> I would say at a minimum it is to provide a means to cap the PCRs. 
> Devices with TPM1.2 are still prevalent in the wild for which members of 
> the TrenchBoot community support, and there are still valid (and secure) 
> verification uses for SHA1 that I outlined in my previous response.
> 
>> Ross et al, can you confirm that your code actually, at least by
>> default and with a monstrous warning to anyone who tries to change the
>> default, caps SHA1 PCRs if SHA256 is available?  And then can we maybe
>> all stop hassling the people trying to develop this series about the
>> fact that they're doing their best with the obnoxious system that the
>> TPM designers gave them?
> 
> Our goal is to keep control in the hands of the user, not making 
> unilateral decisions on their behalf. In the currently deployed 
> solutions it is left to the initrd (user) to cap the PCRs. After some 
> thinking, we can still ensure user control and give an option to cap the 
> PCRs earlier. We hope to post a v11 later this week or early next week 
> that introduces a new policy field to the existing measurement policy 
> framework. Will add/update the kernel docs with respect to the policy 
> expansion. We are also looking the best way we might add a warning to 
> the kernel log if the SHA1 bank is used beyond capping the PCRs.

As the attempt was made to lay in the policy logic, it started to become 
convoluted and unnecessarily complicated. Thus creating more risk with 
all the bookkeeping and yet sha1 hashes still have to be sent, the null 
hash in this case, since the TPM driver will reject extends that do not 
have hashes for all active banks. At this point, we have opted to keep 
the logic simple and add a section to our documentation advising of the 
potential risk should one choose to incorporate SHA1 in their 
attestations of the platform.

v/r,
dps

