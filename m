Return-Path: <linux-efi+bounces-2322-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 319CD9E8B9F
	for <lists+linux-efi@lfdr.de>; Mon,  9 Dec 2024 07:43:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C5AE18822B3
	for <lists+linux-efi@lfdr.de>; Mon,  9 Dec 2024 06:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6DF213E86;
	Mon,  9 Dec 2024 06:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q73XT7LP"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F61615990C;
	Mon,  9 Dec 2024 06:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733726621; cv=none; b=rJLkm4Wmm/vMJ77Pmic3MX27pZ9O51vAwWE7Uz4/XhNxEu4Gmg/6YvwoFh2eAHAMMxRPF/pPBt7AKusBC7p2tSprrJsUGHwuIewND8c1Zh1nPce79IrK3AeV/+OtNzVgDRamX1pV2SKUHrb5pwYlM3NAAbQQOhoKefz3m1TfFwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733726621; c=relaxed/simple;
	bh=UzWlUmHZypaycOfqMws/v+sw32IMPDnWu8nCOqtm00E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Iv5LdrXj6JuZiwdR1/CUfS/KoyjzD4dBMLqOpbXumrY0Y32DwqIikl9fF55aeteBy/1q/DLe51JYR+S5s44ganc0m0qvqHWXWdg4SVmxENhtV2x0g96XShR+3yfuOHfjSxFYlYDuFJ4pL/Dd9G276l/Kxfftg4d9EBW73KQ4QwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q73XT7LP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F4F6C4CEDF;
	Mon,  9 Dec 2024 06:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733726620;
	bh=UzWlUmHZypaycOfqMws/v+sw32IMPDnWu8nCOqtm00E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Q73XT7LPm7DblM+at1WicBCo1xE3gdSkkn/vWIy9gnlXsVjxu4gOAb6Zpbk7cIoks
	 9SxBVU1hTmzmWFQBcMe8uHWwuYhiZ6/QQoziCaYcgLT+dWCgHILQMzqHBBfGwkSU/F
	 DvLDvFYJFFTRSDdQx2Lfrh/+WBzpxcGumLfCqX0q4fGU7s3kkfyXSQYzK8ZsXy5QT2
	 i+A1+nLt+CCptMVtHLA31KsNc2DJ5Yun2hq/aUsOn1GixeFpTGoqN0JGSZpMZeGhV/
	 +Lx/CYvq9EZC7g6UCNuZ4Imly7edoNwGmbLz2/TuPEK0NqKvVEyIAU8OBCS3Ae9kLm
	 rvVHE2RCi1i1w==
Message-ID: <4f82ea4b-687e-4cd5-ba78-12af7cacb7f8@kernel.org>
Date: Mon, 9 Dec 2024 07:43:35 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: TPM/EFI issue [Was: Linux 6.12]
To: Jarkko Sakkinen <jarkko@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: =?UTF-8?Q?Peter_H=C3=BCwe?= <PeterHuewe@gmx.de>,
 Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org,
 Ard Biesheuvel <ardb@kernel.org>,
 "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>
References: <CAHk-=wgtGkHshfvaAe_O2ntnFBH3EprNk1juieLmjcF2HBwBgQ@mail.gmail.com>
 <9c893c52-e960-4f30-98ce-ba7d873145bb@kernel.org>
 <D5Z66HQJNNNL.1CPU2KF13269F@kernel.org>
 <39f16df2-9f4b-49e9-b004-b0e702d08dad@kernel.org>
 <D65GMNDAP2VG.1OM0JQG5Q934M@kernel.org>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <D65GMNDAP2VG.1OM0JQG5Q934M@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07. 12. 24, 13:16, Jarkko Sakkinen wrote:
> On Mon Dec 2, 2024 at 9:52 AM EET, Jiri Slaby wrote:
>> On 30. 11. 24, 3:49, Jarkko Sakkinen wrote:
>>> On Wed Nov 27, 2024 at 8:46 AM EET, Jiri Slaby wrote:
>>>> Cc TPM + EFI guys.
>>>>
>>>> On 17. 11. 24, 23:26, Linus Torvalds wrote:
>>>>> But before the merge window opens, please give this a quick test to
>>>>> make sure we didn't mess anything up. The shortlog below gives you the
>>>>> summary for the last week, and nothing really jumps out at me. A
>>>>> number of last-minute reverts, and some random fairly small fixes
>>>>> fairly spread out in the tree.
>>>>
>>>> Hi,
>>>>
>>>> there is a subtle bug in 6.12 wrt TPM (in TPM, EFI, or perhaps in
>>>> something else):
>>>> https://bugzilla.suse.com/show_bug.cgi?id=1233752
>>>>
>>>> Our testing (openQA) fails with 6.12:
>>>> https://openqa.opensuse.org/tests/4657304#step/trup_smoke/26
>>>>
>>>> The last good is with 6.11.7:
>>>> https://openqa.opensuse.org/tests/4648526
>>>>
>>>> In sum:
>>>> TPM is supposed to provide a key for decrypting the root partitition,
>>>> but fails for some reason.
>>>>
>>>> It's extremely hard (so far) to reproduce outside of openQA (esp. when
>>>> trying custom kernels).
>>
>> Mark "X".
>>
>>>> Most of the 6.12 TPM stuff already ended in (good) 6.11.7. I tried to
>>>> revert:
>>>>      423893fcbe7e tpm: Disable TPM on tpm2_create_primary() failure
>>>> from 6.12 but that still fails.
>>>>
>>>> We are debugging this further, this is just so you know.
>>>>
>>>> Or maybe you have some immediate ideas?
>>>
>>> Nothing immediate but I've had to tweak quite a lot of TPM bus
>>> integrity protection feature so it is a possibility that I've
>>> made a mistake in a point or another.
>>>
>>> Can you bisect the issue possibly?
>>
>> No, see mark "X" :).
>>
>> But follow the downstream bug for progress:
>> https://bugzilla.suse.com/show_bug.cgi?id=1233752
> 
> Just came back from company retrite from BCN.
> 
> I can follow this but cannot comment because I've never been
> able to get a bugzilla account working for any of SUSE infra
> :-)

It should be better now.

> I was actually surprised that I'm able to view the bug at
> all...

Only "enterprise" bugs are invisible by default. openSUSE ones are all 
open (by default).

> Bookmarked it and this thread from lore and revisit
> like in the middle of the week (my calendar is filled with
> meetings Mon/Tue).

Let me sum up: currently, there seem to be two bugs in systemd:
1) password prompt, despite enrolled in TPM
    https://github.com/systemd/systemd/issues/35439
    This is likely fixed by:
    https://github.com/keszybz/systemd/commit/81d59231cbd45
    A revert of the below helps for sure:
    https://github.com/systemd/systemd/commit/d64193a2a652b

2) Failed to unseal secret using TPM2: State not recoverable
    https://github.com/systemd/systemd/issues/35490
    The error is logged, but the decryption succeeds in the end.

We have no clue why this started happening with 6.12. Going back to 6.11 
fixes both of them. For 1), <= 6.11 does not create initrds with size % 
4 != 0, apparently. But why?

thanks,
-- 
js
suse labs

