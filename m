Return-Path: <linux-efi+bounces-942-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F548A3C49
	for <lists+linux-efi@lfdr.de>; Sat, 13 Apr 2024 12:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B297B2177C
	for <lists+linux-efi@lfdr.de>; Sat, 13 Apr 2024 10:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C6D1F94C;
	Sat, 13 Apr 2024 10:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=timschumi@gmx.de header.b="f5xYqjrz"
X-Original-To: linux-efi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9041C522A;
	Sat, 13 Apr 2024 10:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713005263; cv=none; b=FPe5Kt8Id6LH/p+doRGjBRyJlmNIzGjCya8zksQrgo50wAvd1FA+N0oAGM2P3/42mqDbMSCY/ap3YRnKIPAKvnMEjffcGV0PA4639OSfLvwxPhO/ozfs3bIvqkp76ZWyDcskCl6KBkZRzSkk0JYU9UT75ncHs/7uNH2KRVSAr+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713005263; c=relaxed/simple;
	bh=dtj8cKaEYZEqPiYf61cd6NvcMFEQuQfVErXWHJY6Kqw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kakVraRYmI42YiOfzJD+nmT+MTjQQ9zhy4Q00cuuGVzXXMDjrFUdfpbwiUirwl2l/KffZogLgVZtBWLXduDIre6pRznHLW278Dk3JYsiCVw9oLL4PTCphFz3nInbQ7lgvbQNkD1rUxQ4iF1toN7s+KE8tObVknD+qKI5Y7y/Ywc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=timschumi@gmx.de header.b=f5xYqjrz; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1713005248; x=1713610048; i=timschumi@gmx.de;
	bh=4a41sV2lx69XoXu8tNnX+vKhNLO8EAHbtWA3k97j/IE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=f5xYqjrzRZMeHje+G++v/bmwri4QC6G4puengRcqLZKfALfc5VEJDqMj9/OVODoL
	 5/FlOTasQjPhETulTC31TiXkLKx2/BlwPDdsR5tRkOReyTl0TBWWoNad88tb01jK3
	 xbLeU1R/+CO3A8nrCArfijwtehKhtSLqSbR8b9S1eDjZJra0TS4Nzk94s3CB3NUIw
	 xYggjyK+WvArVAQ8DoGvQ2TMaJlDn70qQsPIVJjWPnxGpinDMGQsphkDaFPzJJxzw
	 cmhiME95o0qaMDCppFkAbd4YW87/2g4LJcXdfdAkHdH7azvnw9GUqAPJfZTq9cTVC
	 WmNQuZL/hn3i6we1lQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.222.0.2] ([93.218.98.241]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mqs0X-1sZaVt1vWL-00mvpl; Sat, 13
 Apr 2024 12:47:28 +0200
Message-ID: <ef107046-200c-48fc-b678-eb06c1224940@gmx.de>
Date: Sat, 13 Apr 2024 12:47:21 +0200
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efivarfs: Iterate variables with increasing name buffer
 sizes
To: Peter Jones <pjones@redhat.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>,
 linux-efi@vger.kernel.org, Jeremy Kerr <jk@ozlabs.org>,
 linux-kernel@vger.kernel.org
References: <20240122231507.1307793-1-timschumi@gmx.de>
 <CAMj1kXHSSRacU3hp6D3sdUKDESi1FoD33Qi=5Df+=_biZ-vqhA@mail.gmail.com>
 <223a4e75-2e06-4bc6-a70c-823f0eb308d7@gmx.de>
 <CAMj1kXEKF_a6wLtoMYCwBKEVDo6k1u=Cas-=4Ar4WnANHNu+cg@mail.gmail.com>
 <b58a112f-767f-4918-8262-63ac1dbfebbf@gmx.de>
 <CA+g+hrh_REk-bcTt-D+eSngofxdejeRXuXKhf1O15wzn+qMy6Q@mail.gmail.com>
Content-Language: en-US
From: Tim Schumacher <timschumi@gmx.de>
In-Reply-To: <CA+g+hrh_REk-bcTt-D+eSngofxdejeRXuXKhf1O15wzn+qMy6Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KMdOa9E4IU8lq3pORVR6gjmjfH8NPYsjBplgz3AKyOA8WqMMUTe
 k84lWx6ZDhmtw4/IDjuSok3mfYK7P+MmTjZ6sEG8sHUINMnhY25xbLL8gYhw/FxduG+W5k/
 8BU9HmAoj4CoBTWyhWaD25f6OBsytRzDT3UjAnEqzvmPT45qvC2BH5xoqZKA5L2UuG6n5Y0
 ArTVCshObeORT+WYgsKgA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:89TJqehjHG8=;LngesEic6ImhsvOf1pFtjAbbK7u
 DpJ85dSo60lcIcvhVTBtY73rukhqaBYWHwm8zfvxaMIQe7AA4J+iUCoTAC9LkXaNTejGPH7P5
 +Ory3hj/f3orjJ8vy2fiRjEXDIUlVVAsJyvO2DZUceEbaKn3wJkM8tYSX/DPR/Z8Ok7WI3uhB
 3bL+fpSoYjakS5t7m1C304wvedKXxC9JbvZxGhMIqCyHkK2NkFAmJ6LTXlVMEFgjp715Y5e+P
 nEko9ZrDCPs5rFP3dfaZolnaV9P/nzRxNVzIiFAE6Kq+cdOmOfrHUIojwCYPLO9qz/8n98FMz
 hjfkpd2MUdxeZ+tWdGoVCQVXvdNgXG8WqOw82bzNBVTSi9rjVSCzBswNu1GcYkRv/pwZT6vRt
 M7nuHY1D5ZTNoFz7daaaXfYCm/4t9TtzQfAZDNa3ZSaV07jNYSY9sHUwBTl0YBI7qvI362+le
 ChLiXJ9T3hWDc3InomT7rNlV2v6EVdQX82EXcHqkqa5niiYeFE4eIAbmcQkMQ8uiOvYN8F0eq
 cv0e848YACSXc+DStXM/9pjhA2Zpm3TKZzRdryfqySPG8t3+qftzcPUaqsYioPe5wy78DjWC7
 0WmHrxgL+Wmji6YoVnWKNMseT+UYXW4lQKUh78OwuAMDcaQFuQ8X4ZfXA+NrYIJI9J4Jy1mt7
 RfVIJ4TetcGK3gdl/OVoBO3zfjlDqZ9jfG7+45OUFC+VTDk01V4ewN/sQnzyyHGkusiZR3iNb
 tZ8Pu4mRPiJO46BBTmAJrFQzsKbwxr2LfKBkcRgGDAdMgcPdtX6NKl2/bpV0ZyoO4xIdcyuOL
 UkfMnXWX7nsJ3l3kcZeYtFDC3VxBmN0DMDDQbEkr05fEg=

On 24.01.24 22:25, Peter Jones wrote:
> On Tue, Jan 23, 2024 at 12:33=E2=80=AFPM Tim Schumacher <timschumi@gmx.d=
e> wrote:
>>
>> On 23.01.24 15:09, Ard Biesheuvel wrote:
>>> On Tue, 23 Jan 2024 at 14:55, Tim Schumacher <timschumi@gmx.de> wrote:
>>>>
>>>> I'd rather avoid introducing deviations from the specifications on th=
e
>>>> kernel side as well.
>>>
>>> Which specification would this deviate from?
>>
>> The preexisting comment claims "Per EFI spec", and it appears that I go=
t
>> mislead by that. Neither the UEFI specification, nor the newest revisio=
n
>> of the EFI specification (which I guess is what would have been current
>> back in 2004, when this comment was introduced) seem to make any mentio=
n
>> of a maximum length for the variable name.
>
> Curiously, I can't find it in the 1.02 spec (the oldest I can find)
> either.  When I inherited efibootmgr around 2013, this was a
> limitation there, but I don't see anything in that tree that claims
> it's a spec limitation either.  My suspicion is this is a former
> Itanium firmware limit that got promoted to "the spec says" by word of
> mouth, or was in some very early ia64 implementation spec.

In case anyone is still curious about this, I managed to track down where
the supposed limit actually came from.

The efivarfs documentation claims that "The old sysfs EFI variables code o=
nly
supported variables of up to 1024 bytes. This limitation existed in versio=
n
0.99 of the EFI specification, but was removed before any full releases."

With some effort I managed to track down a copy of EFI v0.99 [1], which
indeed says the following:

"The size of the VariableName, including the Unicode Null in bytes plus th=
e
  DataSize is limited to a maximum size of 1024 bytes."

This note was there at least in version 0.92 and 0.99, and gone in at leas=
t
version 1.02. I haven't been able to find a copy of version 1.01, but it m=
ost
likely never even existed online, given that 1.02 happened only 12 days la=
ter
(and for the sole reason of "legal and trademarking requirements").
The EFI 0.99 errata (which might have included more details) sadly doesn't=
 seem
to have been backed up anywhere by third-parties.

Tim

[1] Searching for "EFISpec_V099" on your preferred search engine should
     find it. I doubt that Intel will care about copyright assignments for
     feedback on 0.99 now, but the agreement prompt sadly prevented the We=
b
     Archive from reaching it.

