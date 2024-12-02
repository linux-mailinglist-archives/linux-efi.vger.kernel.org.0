Return-Path: <linux-efi+bounces-2244-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 871B19DFB82
	for <lists+linux-efi@lfdr.de>; Mon,  2 Dec 2024 08:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD744B23D65
	for <lists+linux-efi@lfdr.de>; Mon,  2 Dec 2024 07:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73DF01FA15B;
	Mon,  2 Dec 2024 07:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Plvk89ER"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430991FA157;
	Mon,  2 Dec 2024 07:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733126175; cv=none; b=IP7PC+1Npx0J4bn2mc7KimKea07oy/TdjPSReNZFNMcKUNrD4nGQK1zgWvWBmdNn7RgKb4HPIwDrrOyuIq6tU8qBh6BtACU4W5qcYynU8DuLkJvYZ4F/Snzndq3MLdYiRtUn03VtWcOkdTKXgAE9oxEvtC1GR6jBZzOcNmRafys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733126175; c=relaxed/simple;
	bh=O91504jWoV1Vdb7DXpja5nd5Wlw+MKpnDaHe5rIB1DE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qfKgwNQXuvyJKtkX5TDczqwhUvvcBKzhsx0mqhcX9FmulA5EIOWnQIzB5gCd0in4Y3oK7rnc4QtD/oF88ubKaqPr28VFSvWgsk830WHFoA3lrWR5QRWpB/qtXQAO18931KOAi5Nq61AMetZHFeZG4uBB1hnoyHEFCW+MkAngRFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Plvk89ER; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4045C4CED9;
	Mon,  2 Dec 2024 07:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733126174;
	bh=O91504jWoV1Vdb7DXpja5nd5Wlw+MKpnDaHe5rIB1DE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Plvk89ER2WJyD6I5FEIQXgOlqxgrzQuVoqJWLugEcJGb4wuylPpPxr0oYHrAhzgWI
	 kDHjW+TYlrGLryC007qmWYbaX4XcWl4jYKoTdEGedorn8f5es9Vc0UcgjJ/p79QaEX
	 4W4EVcb8IUyp5qCsV/iSyO0CZI/Zd5aA2oaq/atQsu/L7PBj7UXWF6gFXpGmVvelFs
	 N4As2UYlrE/8BoQsC01TPzeFWOKOptTxZ3NX0Ur1YLHmNBFhUrWVXVal78ODAQGRRm
	 jRtBea5MeltVLvAlBP27CkfAUmKOsIPZRigZjLuQ8YIcEvoGKnuCDfvhTZju5QtswM
	 kXDpT8vq1bC/g==
Message-ID: <c119df40-5cd9-40f8-b7b7-4085b87e90e5@kernel.org>
Date: Mon, 2 Dec 2024 08:56:11 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: TPM/EFI issue [Was: Linux 6.12]
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: =?UTF-8?Q?Peter_H=C3=BCwe?= <PeterHuewe@gmx.de>,
 Jarkko Sakkinen <jarkko@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 linux-integrity@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
 "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>
References: <CAHk-=wgtGkHshfvaAe_O2ntnFBH3EprNk1juieLmjcF2HBwBgQ@mail.gmail.com>
 <9c893c52-e960-4f30-98ce-ba7d873145bb@kernel.org>
 <ca741d8eade72aa68c389a88d2520f4fe541a1e7.camel@HansenPartnership.com>
 <2a238b61-fa03-4ae4-9dc4-f73834aa3228@kernel.org>
 <70bc83bd7cfb236da030e584e93bfc62c1d9eb6a.camel@HansenPartnership.com>
 <7773891b-b699-4f1d-b9ba-220c649aee9d@kernel.org>
 <02060553aafac7e145e96510a66a6845d389d6ff.camel@HansenPartnership.com>
 <5c474ef503f45745d511c5188addd82a6bf25338.camel@HansenPartnership.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <5c474ef503f45745d511c5188addd82a6bf25338.camel@HansenPartnership.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 29. 11. 24, 22:08, James Bottomley wrote:
> On Fri, 2024-11-29 at 11:03 -0500, James Bottomley wrote:
>> On Fri, 2024-11-29 at 07:36 +0100, Jiri Slaby wrote:
>>> On 28. 11. 24, 17:13, James Bottomley wrote:
>> [...]
>>>> Yes, it tells me the entries in the log for PCR0-7,14 match the
>>>> log entries (for both sha1 and sha256).  However there are
>>>> entries for PCR9,12 which don't match.  The log shows shim
>>>> starting at entry 32, grub starting at entry 37 and the kernel
>>>> loading at entry 39 the kernel command line logged at 40 to PCR
>>>> 12, which is mismatching.
>>>>
>>>> The next two entries (41,42) are for the mismatching PCR9 and are
>>>> of the initrd and the options and come from the libstub code in
>>>> the kernel early boot (efi-stub-helper.c).
>>>
>>> Note that ovmf logged:
>>> Called TcgDxeHashLogExtendEvent 0 58683000 1B1E78C 5FE63C00
>>> 5E3492AA Data 28 B5 2F FD ... E1 29 FE 0
>>>
>>> But initrd on disk is 1B1E78B long, not 1B1E78C. So the excessive 0
>>> at the end above brews the mismatch. See:
>>>     https://bugzilla.suse.com/show_bug.cgi?id=1233752#c14
>>> "By adding the 0 byte I can replicate the measured digest."
>>>
>>> So there is something aligning the initrd. kernel's libstub just
>>> uses and passes load_file2's size down to TcgDxeHashLogExtendEvent,
>>> AIUI. So it'd be sdb, ovmf or something. BTW how are sizes stored
>>> in/fetched from vfat?
>>
>> Well, I was going to explain what EFI does, but it doesn't look
>> relevant now I've had a crash course reading the systemd-boot code.
>> It looks like run() calls image_start() which loads the initrd
>> itself. Then in initrd.c:initrd_prepare() it actually installs its
>> own load file2 protocol which is the protocol the kernel picks up
>> when it loads the initrd.  So whatever length the kernel is picking
>> up is, in fact, provided by systemd-boot.
>>
>> I'd suspect something in this double indirection of load file
>> protocols is causing your length mismatch.
> 
> OK, confirmed it's the Load File2 protocol installed by systemd-boot
> that's doing this.  It seems to be by design: it zero pads and aligns
> on 4 bytes:
> 
> https://github.com/systemd/systemd/blob/3f3b4959e2cb9bca1e1ed527a0692c9a8b6a18ea/src/boot/boot.c#L2498-L2504
> 
> I managed to construct a debian secure boot vm image with the latest
> systemd just to check and sure enough the linux boot stub is using the
> systemd-boot Load file2 protocol module and so does have this zero
> padding issue.
> 
> Although it's a problem if you do a flat file hash, and obviously
> violates the linux stub assumption that that's how we compute the hash,
> I'd have to be reasonably certain that the systemd tools take the zero
> padding into account when constructing the pcr lock values.

Thanks for the investigation. Just for info, the ball looks to be on the 
systemd side now. So as noted to the downstream bug [1], this was also 
reported to systemd [2].

[1] https://bugzilla.suse.com/show_bug.cgi?id=1233752#c19
[2] https://github.com/systemd/systemd/issues/35439

thanks,
-- 
js
suse labs

