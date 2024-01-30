Return-Path: <linux-efi+bounces-437-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12016842891
	for <lists+linux-efi@lfdr.de>; Tue, 30 Jan 2024 17:00:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5E131F28BD0
	for <lists+linux-efi@lfdr.de>; Tue, 30 Jan 2024 16:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894FB86152;
	Tue, 30 Jan 2024 16:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=timschumi@gmx.de header.b="bEVyglh2"
X-Original-To: linux-efi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C74D85C5C;
	Tue, 30 Jan 2024 16:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706630437; cv=none; b=e/3AirslNDj9Vg/JGYmDC3gCqmyv/G2W/w7k/kpvX0xibN2ksQXuNSrsOARjR4GiK6cWkGirWQ5/ubHjjQgUd4l3e9+AxccFGbmodSY2Ub3CcHIzkv5ElJ4WOpNIpv6F2di18QIT6Z7McyNjWA8xojH+4LmKgEZSPP/2hCQ4gJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706630437; c=relaxed/simple;
	bh=Sd2TBz8i472kEAnJMWJEafNr6Q7/YeKh7j8vwLAbrOw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ONj669aMwioBY5ZB/9WZe12o3SC50+37w2Uf53/gbw2I/OO7qgE3+qga4Yl175Uu2fwmCekacIVijM6hk0Uyxf2T84IiZKM8+cfMTsSz4jzglIFTbonK0Tt4t66zVUbleLAlf7EBk6LJ0S3rCfKuX6sZJUzIqzY9olUBLByalO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=timschumi@gmx.de header.b=bEVyglh2; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1706630422; x=1707235222; i=timschumi@gmx.de;
	bh=Sd2TBz8i472kEAnJMWJEafNr6Q7/YeKh7j8vwLAbrOw=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=bEVyglh2XyIm2kVWdb8o8PI1YI9jWaTs5mtwxYrAIMgkLVZ8gfta+PXE/SL58PCV
	 +zJ9HHvEz6eP8+VjdgY3jpePGHGoB/ZGIclw/ux9m+C7/071+LgLBHV74G/s0EOdk
	 zq849hWGc91fhBLyhQ88DCKLm0OgD7zGHcSlANWcJdRT9mA8SOJ3+rNZeWNlbY1bj
	 cXu85DcOkZhEGH9MTOpkcXyouI1ycn0bGSlHU3ag8WjbSFOQeb5PzUaON5PPjDl2g
	 W4BjJKEzIoA8IF66p/+D6jCN2fccjq8QOu1U5zhEPsJ2NUUbU2MjcR7dawcukmXC8
	 CQhDxMpL9bTVVc6R1A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.222.0.4] ([93.218.111.23]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Md6Mj-1qw3wj2azz-00aByq; Tue, 30
 Jan 2024 17:00:22 +0100
Message-ID: <8caa916b-5b40-446a-9a80-68a4cf0fc75f@gmx.de>
Date: Tue, 30 Jan 2024 17:00:16 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] efivarfs: Request at most 512 bytes for variable names
From: Tim Schumacher <timschumi@gmx.de>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org, jk@ozlabs.org, mjg59@srcf.ucam.org,
 pjones@redhat.com, linux-kernel@vger.kernel.org
References: <20240123202743.1591165-1-timschumi@gmx.de>
 <20240126162524.52051-1-timschumi@gmx.de>
 <CAMj1kXGOzk4OnsxL8T7Finx8RzNu23SriY7QokAvKD=BkEvpjw@mail.gmail.com>
 <00d699b5-bf2f-4411-af3b-30ca6fadf66a@gmx.de>
Content-Language: en-US
In-Reply-To: <00d699b5-bf2f-4411-af3b-30ca6fadf66a@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RFKXXIB4a7gJGtoO1i8sCB8yePbDkdI6XSo5oE61lZoJU5FSGXZ
 ZynBgkm/Q9to5KRmWR052kbA3BvMfbqHkZUxagJjzKMVqoRtM9iZEPkpu4m6K/V8p9bY+yv
 rXdTxulEnODL79WIKEstrFHDDNBBIuJZSd9l7BQggGOowXjJMliGR1Dwj/EfBpLVHrqNgLu
 5jPhKf0qEDT5SWuAJzMBg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:oN/akEBlZSc=;MYQObOQFeHrQeESuRMkIkqIDGwd
 lxQMShDsLXlB22mX3nii2XX2PU360S9lotNhJOQm3YC9whvOhOJTqtk52ahEf4tGfNVlkvYgq
 eEpL39XWfU0b4YH8k9YlOCTAOqVbF0y5otsNJui9U9Nb1RSQ07rij5HgR2i5787qfgceJItck
 RpyYS4vi0zGxVsh7XbcoKeHsK0hQHDVIguHAdKYcz4fOZqYj+nW+ap0H0HKAeSVqxLxc7/O1a
 B0yF3kFLM+nB5vjBP5my5hYq7Ps4oymRgr7gUAzXu6/foBmR4TFQcH1XeKjCX67ZR6UlPC1eG
 XZtqCB+rQ0A4zBz8Wv9cxACEO0CAt+cK0CkE7k3Dk6X7IiTRHJ/He7kQt3x0B8uolRE0UPoUm
 uN3XgzC+YJKw63UnB/96/OuYqY7UwaahC6HrhZFCjh8Wd3Z2hXPu0ABb9VXYW/Zy5haJJ4KYx
 FlrLXZjQJv0pm0ZtA7yr8OVxSYBFImu6yMkZSS62+emO6F/NFnSlvrowKT9SmAjRAYSkK0WQc
 k0vHpwE1g66QkYNZ/yIhJ6ZzBrlzu4UO3L9e12AD14lh9nhj2FDrD3Rq76qqGs9GE3cWWo2vG
 SXMle/+8sVtK9iWj65sk8X0HYduOs+8vL0iCufmD0pjClT6uE72vuoVC2WZnzsC987VGN852T
 Sq3+y/ZxaGCK1yPgrax0yLWgJKPHcsKIP0Kkd0/vfd66+RkrAusipTPJs5zIca0Kf2KtfX3cG
 PRKJLnBd6HRqohV4oxgKEktjUeeY51bXCTTd2KpKevgKsYemgfjZEMPkyegMn59sjW4zmir9G
 BcGnCxr9YcHWAQVatqnKmf3Dx3KZYw5UZxOdgfVrqE4gk=

On 26.01.24 19:02, Tim Schumacher wrote:
> On 26.01.24 17:35, Ard Biesheuvel wrote:
>> On Fri, 26 Jan 2024 at 17:25, Tim Schumacher <timschumi@gmx.de> wrote:
>>
>>> One thing that I just recently noticed is that properly processing
>>> variables above 512 bytes in size is currently meaningless anyways,
>>> since the VFS layer only allows file name sizes of up to 255 bytes,
>>> and 512 bytes of UCS2 will end up being at least 256 bytes of
>>> UTF-8.
>>>
>>
>> Interesting. Let's add this to the commit log - it makes the case much
>> stronger, given that it proves that it is impossible for anyone to be
>> relying on the current maximum being over 512 bytes.
>
> It makes the case much stronger for why one wouldn't be able to _create_
> variables of that length from Linux userspace, creating dentries interna=
lly
> seems to have different restrictions (or at least their name size seems
> unlimited to me). Therefore, anything external could have still created
> such variables, and such a variable will also affect any variable that
> follows, not just itself. They don't have to be processed properly, but
> they still need to be processed (and they currently aren't processed at =
all).
>

I was able to experimentally confirm that creating dentries internally is
_not_ restricted by the value of NAME_MAX. The test setup was as follows:

- Build and boot a kernel with NAME_MAX bumped to an artificially high
   value (e.g. 1024). This is supposed to simulate an external user.
- Create an UEFI variable with a name of length 254 (ends up at length 291
   with the appended GUID, which is above the normal NAME_MAX limit).
- Create a "sentinel" UEFI variable with a non-critical name size (e.g. 32=
)
   to determine whether iteration has been stopped early during the next b=
oot.
- Reboot into the same kernel but with an unmodified NAME_MAX limit (i.e. =
255).
- Observe that not only the sentinel variable shows up (i.e. iteration
   hasn't stopped early), but that even the variable with a file name leng=
th of
   291 shows up and continues to be readable and writable from userspace.

Notably (and unexpectedly), only the _creation_ of efivarfs files with len=
gth
larger than NAME_MAX (from inside userspace) seems to abide by the NAME_MA=
X
limit, and ends up bailing out with "File name too long" / ENAMETOOLONG.
Therefore, please disregard my earlier statement about "processing such
entries properly is meaningless" that I put into the patch-accompanying me=
ssage.
I assumed it would be enforced across all/most common file operations inst=
ead
of just when creating files.


