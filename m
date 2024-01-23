Return-Path: <linux-efi+bounces-425-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C83A8839677
	for <lists+linux-efi@lfdr.de>; Tue, 23 Jan 2024 18:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E29FB21BD2
	for <lists+linux-efi@lfdr.de>; Tue, 23 Jan 2024 17:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4AE97FBA8;
	Tue, 23 Jan 2024 17:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=timschumi@gmx.de header.b="et0LCry3"
X-Original-To: linux-efi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4BB5F555;
	Tue, 23 Jan 2024 17:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706031194; cv=none; b=g2LmpHwJsl397KIbzUQ/UxwUwtBZfnEXSu4acm5CQ6J62uZc0TeyFdhbHZcYC/l4M89njDO3me+M5rIwXvJKsVIDwweFldG2QLbcqQBf8Ej6uoBR2MwnUzTx/sj1WrZl7bSUMIbtCDXTTns4jjaoYgsqKPvjflPjbnzUmbwKj/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706031194; c=relaxed/simple;
	bh=7dxmIkN4TzELfKmvnFNOowNx6VkitytmDjVpjZpsq2k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WKSPxuvQHLShPkGu5sPJqbTZW3p+ay+SCU2NFf603wUQPQjQUl5ZB2+O1WBRBADi7sgTPAJgBvmm3VYDAThYrKU7m6KKctVesk4dQeOVzrMezClKQ0QXkejwHtHn1uOwwVN/Eu7p0v9726VX0Wk0Sh+f+kS5ohxSBt9L7jJw0NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=timschumi@gmx.de header.b=et0LCry3; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1706031181; x=1706635981; i=timschumi@gmx.de;
	bh=7dxmIkN4TzELfKmvnFNOowNx6VkitytmDjVpjZpsq2k=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=et0LCry3JZ3bB/eMf/kEuNJr4d2unIoVaJUuYYUrjBuyAt3CHt5qSVo3mkT0t7xW
	 qplqNJIvMjelWxlcO3tT7JehHdKHj/+FHH+5bruh4qzGbkBPyvLlg8mmkVdmbO69b
	 zDGXAbWPxBQb1ZVvC41gs0aOmWWBuy9/AYuJejMzJBezKeAtDKgA94dxVC0yUu7FV
	 QcNfHQW4Z5gxVeWhFrSISYTDP98q+vMwn3gtfDMp5XcdyxjH2IIy4U6mQS90iyCbY
	 XJwFyFNkA3XUd67UW44jATgrmLbdZW4tYdsEIhrgoO65esfc/Zex1XcbwhuRpugv3
	 AX2PAzcyoGXpE6QuWA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.222.0.4] ([93.218.111.23]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N3KTo-1r195j1Uh8-010Q4F; Tue, 23
 Jan 2024 18:33:01 +0100
Message-ID: <b58a112f-767f-4918-8262-63ac1dbfebbf@gmx.de>
Date: Tue, 23 Jan 2024 18:33:00 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efivarfs: Iterate variables with increasing name buffer
 sizes
Content-Language: en-US
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Peter Jones <pjones@redhat.com>,
 linux-efi@vger.kernel.org, Jeremy Kerr <jk@ozlabs.org>,
 linux-kernel@vger.kernel.org, timschumi@gmx.de
References: <20240122231507.1307793-1-timschumi@gmx.de>
 <CAMj1kXHSSRacU3hp6D3sdUKDESi1FoD33Qi=5Df+=_biZ-vqhA@mail.gmail.com>
 <223a4e75-2e06-4bc6-a70c-823f0eb308d7@gmx.de>
 <CAMj1kXEKF_a6wLtoMYCwBKEVDo6k1u=Cas-=4Ar4WnANHNu+cg@mail.gmail.com>
From: Tim Schumacher <timschumi@gmx.de>
In-Reply-To: <CAMj1kXEKF_a6wLtoMYCwBKEVDo6k1u=Cas-=4Ar4WnANHNu+cg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+oQnGZQ4pztJWaJsbDVw/lgyljs39a8hkfXXOQvQ0J7KeParFwe
 XleV9fUjCihbrX0MABg0upbwl6v8byOLfXn7M+qTVdRO0YnF4dPN2KXaFQ++mi5rVnUqFxj
 z2LXpvlQaXfhfQLpZhjDoovdGnOIHaH3mOncFXIt5MG1+qSyZd8BKcT+81oTb/JFb6PiF0t
 bN5SfhMuokNFV5pHQZ6xA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:HGf5fHXhNAQ=;vQCG0pYDuT95aDxR/yC+WTgX1Ln
 XBnGKoGAz+AmKD3j8pFeqn+gQatPfqw/VsZCaSlF+iEjJkKWdVzw5hHTMtlEW2XqdugSUvqzs
 xJMUhAfGTmauMlZpgMADbaC4X8e3lfnU+N9n9uqw4CWI1aOVVo+c5ikpCbUquR88Q0F/WMMp1
 pbEiuW5Pi+RpZyvPi8o3pJE009NKzOXOYKWkpHdyvP9tyQHphcbKQEaPmh6CZRMLJROpc9qyq
 NgWb0RcwNj832UBQv1rDssKMLrYA6d6HruLXT+iAkUwEcreH0sH8RmqJmj/JL59xSFJXAdHUo
 B37dtWaA3SEqmapRANRKzWr4W4ZoukNl5oEIUGKJ/TFEcJi/tSEHNxwCN+RRoPKMZz+iRRa9e
 w8gMPiWT68xu/vp1NmlkPBisrHb8WhoaZKr3NXmJufSFjND1qiPoGUGFWAL5kT70CnC5d6OcH
 /PSJXPRnmeRlVyHes/SNoeqB8XmPvIS7DpkpkhR6lAeFbLFzJg75uglsWx5O/7TmVnayfzDPF
 Oyzt2X1ElNlnheUt0WmKerXW/MhSfzbY6DCRJJ20cDALVbP8gULTS3NhM+UzFvLmqcQm6ow4N
 9NWgb6XISQ9bmpL3liv+Z0PjwU+e0LNKniexcxwlObGEXlrr8yVMIKLpWQRoKdF0nWcEBQAnt
 9Dv6KU+SZnjXZizhIQNeFipgoeczShUDRNCAlyOOYXtmKnJQmSSl6KMXoiLcoYs1U0evNkJdP
 qMLMSzbumQJenGSaanOH0iePOm1x0iF4cTbjHVSchVRbr4C/HJs4JcYt+hKHZPVEh2k0n92LR
 3WXU7Sxl/LbdqVzcxOgW2B1p1+GP/uZyMcK9XkYIt7rzJjC0f1SjmUsxqAuuoYrx8uTmLcNra
 M29rx7BY0DAR/glLeqjNoEL/9wx6eABiCeCN4R0Gawz1ELC3iA7iPaivrgRiESCPnUN+XYte5
 qNJGFZC9fTvGOG/m/LvsIwyRDTw=

On 23.01.24 15:09, Ard Biesheuvel wrote:
> On Tue, 23 Jan 2024 at 14:55, Tim Schumacher <timschumi@gmx.de> wrote:
>>
>> I'd rather avoid introducing deviations from the specifications on the
>> kernel side as well.
>
> Which specification would this deviate from?

The preexisting comment claims "Per EFI spec", and it appears that I got
mislead by that. Neither the UEFI specification, nor the newest revision
of the EFI specification (which I guess is what would have been current
back in 2004, when this comment was introduced) seem to make any mention
of a maximum length for the variable name.

I'll look into updating it appropriately when doing my changes (or remove
it entirely, since it seems to serve no other purpose than justifying the
starting buffer size).

>> In regards to complexity of the proposed solution, how about we approac=
h
>> this from the other side? Start off with advertising 1024 bytes of
>> buffer storage, and cut that value in half (without actually resizing
>> the buffer) as long as we get `EFI_INVALID_PARAMETER` while on the firs=
t
>> run.
>>
>> If we ever get `EFI_BUFFER_TOO_SMALL`, we know that something is wrong
>> with the UEFI implementation (because that either means that something
>> claims to be larger than 1024 bytes, or that our assumptions about the
>> quirk don't hold up) and can bail out and log as appropriate. That woul=
d
>> limit the complexity to the machines that need it, completely omit the
>> need for resize logic, and would still be specification compliant.
>
> Yes, I would prefer to keep this as simple as possible.

I'll prepare a v2 with those changes then. The 1024 bytes may not be
an actual limit, but I'll keep it as the default size for the second
revision to ensure that we don't break any existing setups.

If this is still considered not simple enough, we can go back to looking
at just doing s/1024/512/ for the static buffer size.

Thank you for the feedback, I greatly appreciate it.

Tim

PS: Apologies in case my previous message ended up with a messed up line
wrap. Thunderbird apparently shows the message with automatic line wrap
while composing, but doesn't actually send it like that (or lines are
magically unwrapped again when displaying the message afterwards).

