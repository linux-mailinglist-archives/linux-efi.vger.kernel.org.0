Return-Path: <linux-efi+bounces-2234-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D78F9DBF81
	for <lists+linux-efi@lfdr.de>; Fri, 29 Nov 2024 07:37:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C672B16450D
	for <lists+linux-efi@lfdr.de>; Fri, 29 Nov 2024 06:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D52413DB9F;
	Fri, 29 Nov 2024 06:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m2v89CIj"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF07BA4B;
	Fri, 29 Nov 2024 06:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732862224; cv=none; b=I2Luw4PS/AntJCOc89BWgchbVZ9BL3ZovD76HFQgxaCVL0Jc/KIGbhbpnb2iNT1oiJzk+yFhjSaN+v5Cro4zx7+AZibLEe6WaEwol4V2RGxosq95/419KMRO/LVoIxUCvF2noaijIZvcMCdMqGsj/AxekV9teQuaTqlgqcfgTzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732862224; c=relaxed/simple;
	bh=B6cpIRlYYtXakyvuo2coY5b7cQpBoWozH0nVbzGvnTM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qX3eEpnzoDHzuOIgAAP5z5HsN4omOQT7GzUOPzQnz+FDHmuc4cyGwSvZDCzaivWT8Z/NydtYXvzMXq4O4IWJOKLYh6gTpQUwnkHUxP8wObY6t8RzDND39YTzFX1HE8nO6gPxLQFVsyWJ9oxSNxCrgsLZvnl4bdNioCL8cb/Cehs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m2v89CIj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EDE0C4CECF;
	Fri, 29 Nov 2024 06:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732862223;
	bh=B6cpIRlYYtXakyvuo2coY5b7cQpBoWozH0nVbzGvnTM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=m2v89CIjolKGGvsx1u+j+0DDcjHKMFKFuZJJlQ2ozmGa+6URFnFjeuKDseD8JQ8qh
	 H8kvDFPAA5dz+iv1SHirlTLc1E5thvjOb6nffcTSVVD3fULHTXgkIt+/bQ/6UlWiet
	 zrGjkbU5T0Uex0gU9HFYBvYU/FENfdQfxH42aia/T4c5YQyD0dw7BnOC/2wAsHjzCd
	 fpHhzbJOs4raeGFkd8bZTY4hg7v1FUCUp+7ZK+QOOm3ta+2JoySqKqlzbXb8iXUv9o
	 FDiUaeopZJk7dYdDg6TfCtfXs85NrtN2uG+2LWTzxhsuej5qgZd60E5+pL3g+xxKTB
	 EEKHj/PaNVUkw==
Message-ID: <7773891b-b699-4f1d-b9ba-220c649aee9d@kernel.org>
Date: Fri, 29 Nov 2024 07:36:59 +0100
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
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <70bc83bd7cfb236da030e584e93bfc62c1d9eb6a.camel@HansenPartnership.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 28. 11. 24, 17:13, James Bottomley wrote:
> On Thu, 2024-11-28 at 08:20 +0100, Jiri Slaby wrote:
>> On 27. 11. 24, 17:24, James Bottomley wrote:
> [...]
>>> Well, it looks like you eliminated the TPM changes:
>>>
>>> https://bugzilla.suse.com/show_bug.cgi?id=1233752#c6
>>>
>>> So it must be something in the logging or event recording code.
>>> The first thing to check is can you run a replay of the log to get
>>> the end PCR values?  The binary for that is
>>>
>>> tsseventextend -sim -v -if
>>> /sys/kernel/security/tpm0/binary_bios_measurements
>>
>> I put this into bbm (attached).
>>
>>> You'll have to check the values it gives against the values in
>>>
>>> /sys/class/tpm/tpm0/tpm-sha256
>>
>> I have only /sys/class/tpm/tpm0/pcr-sha256/.
>>     grep -H '.*' /sys/class/tpm/tpm0/pcr-sha256/*
>> attached
> 
> Yes, sorry, typo as you figured out.
> 
>>
>> With that:
>>   > $ for aa in /sys/class/tpm/tpm0/pcr-sha256/*; do sha=`cat $aa`;
>> echo
>> === $sha; if [[ ! $sha =~ [F0]{64} ]]; then sha=$(echo $sha | sed
>> 's@..@
>> &@g'); grep -i "$sha" bbm; fi; done
>>> ===
>>> 6C26A8BB35548545A189FFFC421134BE14D94B5E16DB91BA9628CBF67C69DDDA
>>>   PCR 00: 6c 26 a8 bb 35 54 85 45 a1 89 ff fc 42 11 34 be 14 d9 4b
>>> 5e 16 db 91 ba 96 28 cb f6 7c 69 dd da
>>> ===
>>> 9967D57B20DE03689395042372515F2B91A6ADAC4042B5E0139B44A21FB36F7D
>>>   PCR 01: 99 67 d5 7b 20 de 03 68 93 95 04 23 72 51 5f 2b 91 a6 ad
>>> ac 40 42 b5 e0 13 9b 44 a2 1f b3 6f 7d
>>> ===
>>> 002651E9DD78325EFFBC4AE276401522575216280406A0DDA2D41AE8CA2EE3DC
>>> ===
>>> 0000000000000000000000000000000000000000000000000000000000000000
>>> ===
>>> 76E6D50D860B4CBAF4552CBFD4A83309F6DD855040657531DA796A386318CEAA
>>> ===
>>> 0000000000000000000000000000000000000000000000000000000000000000
>>> ===
>>> 30EFACACDAC53DEA877ED268648596776B212A4FF556D9B7FF934BEC5702EDD8
>>>   PCR 14: 30 ef ac ac da c5 3d ea 87 7e d2 68 64 85 96 77 6b 21 2a
>>> 4f f5 56 d9 b7 ff 93 4b ec 57 02 ed d8
>>> ===
>>> 0000000000000000000000000000000000000000000000000000000000000000
>>> ===
>>> 0000000000000000000000000000000000000000000000000000000000000000
>>> ===
>>> FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
>>> ===
>>> FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
>>> ===
>>> FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
>>> ===
>>> C83EA442D306E65267328CC6DA4B539A8F7216C329E90E0AAE5527026E50637D
>>>   PCR 02: c8 3e a4 42 d3 06 e6 52 67 32 8c c6 da 4b 53 9a 8f 72 16
>>> c3 29 e9 0e 0a ae 55 27 02 6e 50 63 7d
>>> ===
>>> FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
>>> ===
>>> FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
>>> ===
>>> FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
>>> ===
>>> 0000000000000000000000000000000000000000000000000000000000000000
>>> ===
>>> 3D458CFE55CC03EA1F443F1562BEEC8DF51C75E14A9FCF9A7234A13F198E7969
>>>   PCR 03: 3d 45 8c fe 55 cc 03 ea 1f 44 3f 15 62 be ec 8d f5 1c 75
>>> e1 4a 9f cf 9a 72 34 a1 3f 19 8e 79 69
>>>   PCR 06: 3d 45 8c fe 55 cc 03 ea 1f 44 3f 15 62 be ec 8d f5 1c 75
>>> e1 4a 9f cf 9a 72 34 a1 3f 19 8e 79 69
>>> ===
>>> 8C5ED4D1866768D7CDEC958584CA4FD9FA94D419EAE0BDEBB4284CF33A82CD9F
>>>   PCR 04: 8c 5e d4 d1 86 67 68 d7 cd ec 95 85 84 ca 4f d9 fa 94 d4
>>> 19 ea e0 bd eb b4 28 4c f3 3a 82 cd 9f
>>> ===
>>> 0AC36B8B8CBD577A01949D77146BAB421E7111A8530DECCB4AC6A4899BD22740
>>>   PCR 05: 0a c3 6b 8b 8c bd 57 7a 01 94 9d 77 14 6b ab 42 1e 71 11
>>> a8 53 0d ec cb 4a c6 a4 89 9b d2 27 40
>>> ===
>>> 3D458CFE55CC03EA1F443F1562BEEC8DF51C75E14A9FCF9A7234A13F198E7969
>>>   PCR 03: 3d 45 8c fe 55 cc 03 ea 1f 44 3f 15 62 be ec 8d f5 1c 75
>>> e1 4a 9f cf 9a 72 34 a1 3f 19 8e 79 69
>>>   PCR 06: 3d 45 8c fe 55 cc 03 ea 1f 44 3f 15 62 be ec 8d f5 1c 75
>>> e1 4a 9f cf 9a 72 34 a1 3f 19 8e 79 69
>>> ===
>>> 6508BC9385D1E735BAC5C87D870962270D5134F4F49ECFFF01ECDC5B4EAD9A56
>>>   PCR 07: 65 08 bc 93 85 d1 e7 35 ba c5 c8 7d 87 09 62 27 0d 51 34
>>> f4 f4 9e cf ff 01 ec dc 5b 4e ad 9a 56
>>> ===
>>> 0000000000000000000000000000000000000000000000000000000000000000
>>> ===
>>> F5A2E8762B524BE1CCAFE763672BC31627C326A1470A9DC351566F2413FDEFC2
>>
>>
>>> Probably also check sha1 to see if it matches.
>>
>>> for aa in /sys/class/tpm/tpm0/pcr-sha1/*; do sha=`cat $aa`; echo
>>> === $sha; if [[ ! $sha =~ [F0]{32} ]]; then sha=$(echo $sha | sed
>>> 's@..@ &@g'); grep -i "$sha" bbm; fi; done
>>> === A4399CFC6A5FD20EC6697913936CBEE35B8353C4
>>>   PCR 00: a4 39 9c fc 6a 5f d2 0e c6 69 79 13 93 6c be e3 5b 83 53
>>> c4
>>> === 24F81DFF31EE374162E759B0395247ADC7A6FFB8
>>>   PCR 01: 24 f8 1d ff 31 ee 37 41 62 e7 59 b0 39 52 47 ad c7 a6 ff
>>> b8
>>> === 466B2B859CA97E60AEAADFD279A689E534D0CE7B
>>> === 0000000000000000000000000000000000000000
>>> === 485E52A350F34D1EF4263C1E2C99D22A771C4C01
>>> === 0000000000000000000000000000000000000000
>>> === 87F3655072D45EA768F02ADB16EF946D42620224
>>>   PCR 14: 87 f3 65 50 72 d4 5e a7 68 f0 2a db 16 ef 94 6d 42 62 02
>>> 24
>>> === 0000000000000000000000000000000000000000
>>> === 0000000000000000000000000000000000000000
>>> === FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
>>> === FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
>>> === FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
>>> === DCFFB00B36562803DDE211D6E07C2D7F123279E3
>>>   PCR 02: dc ff b0 0b 36 56 28 03 dd e2 11 d6 e0 7c 2d 7f 12 32 79
>>> e3
>>> === FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
>>> === FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
>>> === FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
>>> === 0000000000000000000000000000000000000000
>>> === B2A83B0EBF2F8374299A5B2BDFC31EA955AD7236
>>>   PCR 03: b2 a8 3b 0e bf 2f 83 74 29 9a 5b 2b df c3 1e a9 55 ad 72
>>> 36
>>>   PCR 06: b2 a8 3b 0e bf 2f 83 74 29 9a 5b 2b df c3 1e a9 55 ad 72
>>> 36
>>> === DCD4E77C33E164FCC8F3D566AE83840F8265E47D
>>>   PCR 04: dc d4 e7 7c 33 e1 64 fc c8 f3 d5 66 ae 83 84 0f 82 65 e4
>>> 7d
>>> === 35871F5AFB0129A9535C35B6BF82A3DF075E124B
>>>   PCR 05: 35 87 1f 5a fb 01 29 a9 53 5c 35 b6 bf 82 a3 df 07 5e 12
>>> 4b
>>> === B2A83B0EBF2F8374299A5B2BDFC31EA955AD7236
>>>   PCR 03: b2 a8 3b 0e bf 2f 83 74 29 9a 5b 2b df c3 1e a9 55 ad 72
>>> 36
>>>   PCR 06: b2 a8 3b 0e bf 2f 83 74 29 9a 5b 2b df c3 1e a9 55 ad 72
>>> 36
>>> === 16F5D0A8B980EC71DAFAD1E515554482747A4FCE
>>>   PCR 07: 16 f5 d0 a8 b9 80 ec 71 da fa d1 e5 15 55 44 82 74 7a 4f
>>> ce
>>> === 0000000000000000000000000000000000000000
>>> === 8482CFF5AE0D9217ABB8BB82EAC487136DAFFC96
>>
>> I have no idea if this tells you anything :).
> 
> Yes, it tells me the entries in the log for PCR0-7,14 match the log
> entries (for both sha1 and sha256).  However there are entries for
> PCR9,12 which don't match.  The log shows shim starting at entry 32,
> grub starting at entry 37 and the kernel loading at entry 39  the
> kernel command line logged at 40 to PCR 12, which is mismatching.
> 
> The next two entries (41,42) are for the mismatching PCR9 and are of
> the initrd and the options and come from the libstub code in the kernel
> early boot (efi-stub-helper.c).

Note that ovmf logged:
Called TcgDxeHashLogExtendEvent 0 58683000 1B1E78C 5FE63C00 5E3492AA
Data 28 B5 2F FD ... E1 29 FE 0

But initrd on disk is 1B1E78B long, not 1B1E78C. So the excessive 0 at 
the end above brews the mismatch. See:
   https://bugzilla.suse.com/show_bug.cgi?id=1233752#c14
"By adding the 0 byte I can replicate the measured digest."

So there is something aligning the initrd. kernel's libstub just uses 
and passes load_file2's size down to TcgDxeHashLogExtendEvent, AIUI. So 
it'd be sdb, ovmf or something. BTW how are sizes stored in/fetched from 
vfat? But well, fs/fat/ received no significant changes either.

> This code was last updated in 6.9, so
> it seems unlikely to have suddenly caused a problem.  Event 43,44 are
> exit boot services (logged to PCR 5 which matches).
> 
> line 40 is anomalous: grub is supposed to measure the options to the
> string PCR which should be 8 not 12 ... did you patch grub to change
> this?

All this is with sdb, not grub, actually.

> The log can't be corrupt because PCR8 is zero, so nothing got
> logged to it.
> 
> And do you have the same thing for a working system?

Let me try.

thanks,
-- 
js
suse labs

