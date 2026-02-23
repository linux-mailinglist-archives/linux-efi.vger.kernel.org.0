Return-Path: <linux-efi+bounces-6208-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mOzINEzJnGkwKQQAu9opvQ
	(envelope-from <linux-efi+bounces-6208-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Mon, 23 Feb 2026 22:40:28 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 546F717DA71
	for <lists+linux-efi@lfdr.de>; Mon, 23 Feb 2026 22:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4FF693033AA0
	for <lists+linux-efi@lfdr.de>; Mon, 23 Feb 2026 21:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A45B378D8F;
	Mon, 23 Feb 2026 21:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=apertussolutions.com header.i=dpsmith@apertussolutions.com header.b="P7PcAYWe"
X-Original-To: linux-efi@vger.kernel.org
Received: from sender4-of-o51.zoho.com (sender4-of-o51.zoho.com [136.143.188.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D6E377543;
	Mon, 23 Feb 2026 21:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771882764; cv=pass; b=qvoheuN2w0uiLbjy8TcUD1pnLVQkL08kwxb9/Ifa3CU/nX0keWxdWjkp9d28ujkAKMWgn68mLshEC86pmjcPyiEGDxWoh39CIx4DSP+7FTIuC+RsqK5sLy8zjSzYBBS6Br1wYkJXMiUVJqYJLBXrpUUvUEcT0eabdvkRUXldiIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771882764; c=relaxed/simple;
	bh=uZGxSgxVWt2XAaBxrM4B4yacmSav+waMJqGMxbIEW+4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kbtDq8WNpVWlSD3uxcgfEIG8K6rGfAzp4SYdV8Lu9wF1Av6YFwzWJn/oTViK3eRRrhOMx5HjPetHAcDBXxwC0EfA9Tf2rhAFCTd6rgBqp68PvQ0VzFpGBNOFaI90p7Il8xw4fup/QoXBEKI4jFhJSacosTt0/1xhG/7Li52XJzw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apertussolutions.com; spf=pass smtp.mailfrom=apertussolutions.com; dkim=pass (1024-bit key) header.d=apertussolutions.com header.i=dpsmith@apertussolutions.com header.b=P7PcAYWe; arc=pass smtp.client-ip=136.143.188.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apertussolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=apertussolutions.com
ARC-Seal: i=1; a=rsa-sha256; t=1771882677; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ffjYtNOjrVDY85s8H1n2+Y4wa878dKU05XaPBpiQhMjhrkbwRhTcsvhek9WA/vN8ptkYTLjn3ypd8dCSySrh0XT8P/i6R8nunHsBLimTczlL+Ek5eICIVFPgNRrsepAyk10HAydAF5MLLeI1gsErtl0StDUwjMG9hG/FXJrDCb8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1771882677; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=h8NnLyDahIjYa2r/mE8SrBY5YeZya77iJfvSt7LZAuk=; 
	b=cWaxR9XlGzKr65BZnm8jUFH1zgUwhL/DodbGfpIZlIM6Ycs+8FSpsYy5EVqYJ8yvKXz4rWeqH9bMtM4ChWBG1gDLNIVVwqqy22uLA4krxCrJCHSW4H9R2d3sp8gUavrTZM7GdIKtQb+BT4CZpCf0bMFzxB+VnXTtLdxgXKmg9Dc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=apertussolutions.com;
	spf=pass  smtp.mailfrom=dpsmith@apertussolutions.com;
	dmarc=pass header.from=<dpsmith@apertussolutions.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1771882677;
	s=zoho; d=apertussolutions.com; i=dpsmith@apertussolutions.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=h8NnLyDahIjYa2r/mE8SrBY5YeZya77iJfvSt7LZAuk=;
	b=P7PcAYWewsxI7zMHuuIOTExnellqQJfITJDN8fsRqp3WdhX/HuQGt6f8wbGjUdM1
	JnV8NQ1V6ZrXfrsve9kHI39ivmu766uO0AFsZKamepbKgMiMfAH4HyTZfJ7ZQQ9OAZk
	pfRpttFfJlE5rMuuoCcq3Qcr/SI4uvU8EZarOy3A=
Received: by mx.zohomail.com with SMTPS id 1771882674971616.8376032703019;
	Mon, 23 Feb 2026 13:37:54 -0800 (PST)
Message-ID: <f5323525-493c-4419-8199-d65630fce084@apertussolutions.com>
Date: Mon, 23 Feb 2026 16:37:51 -0500
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 00/28] x86: Secure Launch support for Intel TXT
Content-Language: en-US
To: Ard Biesheuvel <ardb@kernel.org>, Andy Lutomirski <luto@amacapital.net>
Cc: Simo Sorce <simo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
 Ross Philipson <ross.philipson@oracle.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
 linux-efi@vger.kernel.org, iommu@lists.linux.dev,
 dave.hansen@linux.intel.com, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 mjg59@srcf.ucam.org, James.Bottomley@hansenpartnership.com,
 peterhuewe@gmx.de, Jarkko Sakkinen <jarkko@kernel.org>, jgg@ziepe.ca,
 nivedita@alum.mit.edu, Herbert Xu <herbert@gondor.apana.org.au>,
 davem@davemloft.net, corbet@lwn.net, ebiederm@xmission.com,
 dwmw2@infradead.org, baolu.lu@linux.intel.com, kanth.ghatraju@oracle.com,
 andrew.cooper3@citrix.com, trenchboot-devel@googlegroups.com
References: <20251215233316.1076248-1-ross.philipson@oracle.com>
 <b5f2b5a5-b984-4ed3-a023-c06d634f9146@app.fastmail.com>
 <1ffd3cb5-2c76-4371-a067-3e4849907d80@apertussolutions.com>
 <49d169bf-0ad2-49be-b7d7-fceb9e7f831a@app.fastmail.com>
 <CALCETrUE8c-dxRWhtHKz_PojwZuWMXJSzOsFQf2vt5LS3ATwpA@mail.gmail.com>
 <1BBD7449-8420-43FD-930B-A4E1BA38FFC6@zytor.com>
 <CALCETrWzG1Mjb-RcwLQ5-tGFZ15WKHjZbqtLvyif+UPuVKJ_5g@mail.gmail.com>
 <32e62cef7b89d9691bdd4120388ce752fd041230.camel@redhat.com>
 <CALCETrUMR0RvOFXGzL7=F4c-3veL+1Sm2xf-BprHTK4=UKw8yA@mail.gmail.com>
 <558d0f28-01fb-4447-891c-2ffbf869c077@app.fastmail.com>
 <CALCETrWynypSD7vEjJNLcym3JhBw4k0ovDiR_3YuOHh92TnM=A@mail.gmail.com>
 <9034c6a1-ebce-40b6-9ac8-0b8cc5a50dd4@app.fastmail.com>
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
In-Reply-To: <9034c6a1-ebce-40b6-9ac8-0b8cc5a50dd4@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[apertussolutions.com:s=zoho];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[apertussolutions.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6208-lists,linux-efi=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[32];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[redhat.com,zytor.com,oracle.com,vger.kernel.org,kernel.org,lists.infradead.org,lists.linux.dev,linux.intel.com,linutronix.de,alien8.de,srcf.ucam.org,hansenpartnership.com,gmx.de,ziepe.ca,alum.mit.edu,gondor.apana.org.au,davemloft.net,lwn.net,xmission.com,infradead.org,citrix.com,googlegroups.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dpsmith@apertussolutions.com,linux-efi@vger.kernel.org];
	DKIM_TRACE(0.00)[apertussolutions.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-efi];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amacapital.net:email,zytor.com:email]
X-Rspamd-Queue-Id: 546F717DA71
X-Rspamd-Action: no action

On 2/20/26 03:30, Ard Biesheuvel wrote:
> 
> 
> On Thu, 19 Feb 2026, at 18:34, Andy Lutomirski wrote:
>> On Wed, Feb 18, 2026 at 11:55 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>>>
>>> On Wed, 18 Feb 2026, at 22:54, Andy Lutomirski wrote:
>>>> On Wed, Feb 18, 2026 at 1:04 PM Simo Sorce <simo@redhat.com> wrote:
>>>>>
>>>>> On Wed, 2026-02-18 at 12:34 -0800, Andy Lutomirski wrote:
>>>>>> On Wed, Feb 18, 2026 at 12:29 PM H. Peter Anvin <hpa@zytor.com> wrote:
>>>>>>>
>>>>>>> On February 18, 2026 12:03:27 PM PST, Andy Lutomirski <luto@amacapital.net> wrote:
>>>>>>>> On Thu, Feb 12, 2026 at 12:40 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>>>>>>>>>
>>>>>>>>> On Thu, 12 Feb 2026, at 20:49, Daniel P. Smith wrote:
>>>>>>>>>> On 2/9/26 09:04, Ard Biesheuvel wrote:
>>>>>>>>> ...
>>>>>>>>> But would it be better to disable the runtime services by default when doing a secure launch? PREEMPT_RT already does the same.
>>>>>>>>
>>>>>>>> So I have a possible way to disable EFI runtime service without losing
>>>>>>>> the ability to write EFI vars.  We come up with a simple file format
>>>>>>>> to store deferred EFI var updates and we come up with a place to put
>>>>>>>> it so that we find it early-ish in boot the next time around.  (This
>>>>>>>> could be done via integration with systemd-boot or shim some other
>>>>>>>> boot loader or it could actually be part of the kernel.)  And then,
>>>>>>>> instead of writing variables directly, we write them to the deferred
>>>>>>>> list and then update them on reboot (before TXT launch, etc).  [0]
>>>>>>>> This would be a distincly nontrivial project and would not work for
>>>>>>>> all configurations.
>>>>>>>>
>>>>>>>> As a maybe less painful option, we could disable EFI runtime services
>>>>>>>> but have a root-writable thing in sysfs that (a) turns them back on
>>>>>>>> but (b) first extends a PCR to say that they're turned back on.
>>>>>>>>
>>>>>>>> (Or someone could try running runtime services at CPL3...)
>>>>>>>>
>>>>>>>> [0] I have thought for years that Intel and AMD should do this on
>>>>>>>> their end, too.  Keep the sensitive part of SMI flash entirely locked
>>>>>>>> after boot and, instead of using magic SMM stuff to validate that
>>>>>>>> write attempts have the appropriate permissions and signatures, queue
>>>>>>>> them up as deferred upates and validate the signatures on the next
>>>>>>>> boot before locking flash.
>>>>>>>>
>>>>>>>
>>>>>>> *If* a physical EFI partition exists there is a lot to be said for this approach.
>>>>>>>
>>>>>>> The only issue with this that I can see is for things like network or CD/DVD booting where there isn't necessarily any EFI boot partition, it might not be writable, or it might not be persistent (e.g. http booting typically uses a ramdisk, like the old Linux initrd.)
>>>>>>
>>>>>> Hmm, I guess my approach is a 100% complete nonstarter for installing
>>>>>> Linux from a CD, and it's really not awesome for installing Linux from
>>>>>> a USB stick.
>>>>>
>>>>> Doing any of this on a removable device feels generally like a trap.
>>>>> You get your USB disk in, try to boot, and it saves vars, but reboot
>>>>> fails for whatever reason, you plug it in another machine ... and it
>>>>> tries to "continue" from there? The amount of validation needed and
>>>>> testing for failure modes across reboots sounds really painful.
>>>>
>>>> I kind of stand by my other previous suggestion, though:
>>>>
>>>> As a maybe less painful option, we could disable EFI runtime services
>>>> but have a root-writable thing in sysfs that (a) turns them back on
>>>> but (b) first extends a PCR to say that they're turned back on.
>>>>
>>>
>>> After setting the EFI boot path to GRUB (or systemd-boot or whatever) at installation time, what other meaningful interactions do we expect with the EFI runtime services?
>>>
>>> And given that the secure launch is orchestrated by the bootloader , with which the kernel has a backchannel via its configuration file, it should be rather straight-forward to implement the staging of variable updates there if we really need it.
>>>
>>> Doing any of this at the EFI/spec level might lead to a situation where the OS now has to guess which of the provided APIs to manipulate variables is the least broken.
>>>
>>> Of course, for readinf variables, dumping the RT variables into a memory buffer at boot time and exposing it via a EFI config table would be rather straight-forward, but it is also something I feel should be the job of the boot component that takes part in the decision to shield the runtime services from the OS.
>>
>> So there's sort of a usability issue here.  On the one hand, this can
>> all be orchestrated to work.  We build a kernel, and the kernel
>> supports secure launch.  Someone makes an installer image, and that
>> image is configured to skip secure launch, then install to disk, then
>> program EFI vars, then reboot.  And the installed image is configured
>> to do the secure launch, and EFI variable writes are turned off.
>>
>> On the other hand, this all sucks.  I'm getting sick of having the
>> kernel tell me that I am not permitted to do things.  I'm sick of
>> writing software that deals with unnecessary restrictions.  If I were
>> writing an OS with a USB stick-based installer, I might want to be
>> able to boot the thing and decide later whether I'm installing an OS
>> to disk.  (In fact, many USB installers work this way.)  But, in the
>> model where EFI variable writes are hard-disabled on a secure launch,
>> the decision to do the secure launch happens before the decision to
>> install an OS, and we all lose.
>>
>> So I'm proposing that EFI variable writes be treated a bit like kexec
>> [0] -- root (which is already part of the TCB for any practical
>> purpose) is going to decide, like a grown up, to execute some code
>> that it doesn't fully trust -- in this case, the EFI variable writes.
>> And root will coordinate, correctly, with whomever it's busy using the
>> TPM to coordinate with, and tell it that it's going to do something
>> that will change its trustworthiness.  So it works like this:
>>
>> 1. Secure launch the environment on the stick.  (At this stage,
>> neither the boot loader nor the kernel has the faintest clue whether
>> anyone needs that secure launch, but this doesn't matter.)
>>
>> 2. The owner of the machine clicks "install".
>>
>> 3. The installer makes some partitions and writes some files.
>>
>> (Up until now, the security posture of the running environment has not changed.)
>>
>> 4. The installer decides that it's now time to do untrustworthy
>> things, namely writing EFI vars.  So it unmounts anything it mounted
>> using TPM-sealed keys (or not -- this is between the distro and
>> whoever trusts the distro), and it does:
>>
>> # echo 1 >/sys/.../extend_pcr_and_unlock_efi
>>
>> which *first* extends a PCR because we are about to change our
>> security posture and *second* sets whatever flag permits use of EFI
>> runtime services.
>>
>> 5. The installer writes to EFI variables.  And the installer can no
>> longer generate attestations to its previous security posture, which
>> is the correct behavior.  And maybe the user can no longer unlock
>> their home directory or whatever until they reboot.  Which is not
>> really a big deal.
>>
>> (This is *dynamic* root of trust.  In theory the system could do a
>> DRTM re-launch and recover its security posture, but I don't think
>> this is implemented.)
>>
>>
>> One thing I like about this is that it involves very little code.
>>
> 
> It does seem rather straight-forward, and it doesn't have to be specific to TXT either. I.e., we should probably always measure the runtime enabled/disabled state into the PCRs.


As you mentioned, this is not unique to the DRTM case, but allow me to 
provide our perspective. We would enjoy a sysfs controlled lock that 
results in a PCR Event. With that said, while it may be getting down 
into the implementation details, I would like to suggest the PCR be 
configurable. When under DRTM, it would be desirable to have the ability 
for the measurement to be extended into a DRTM PCR.

v/r,
dps

> But given the actual problem at hand (untrustworthy glue code running in ring 3 that does little more than poke SMM, which itself fundamentally remains part of the TCB), it would be nice if we could just sandbox that code using virtualization.
> 
> This came up in a separate discussion regarding ACPI PRM (the new dumping ground for evil vendor code now that SMM has gone out of fashion), although there it should be feasible to run it unprivileged, as the spec requires that capability for the PRM payloads.


