Return-Path: <linux-efi+bounces-821-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96DF487D41E
	for <lists+linux-efi@lfdr.de>; Fri, 15 Mar 2024 19:53:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C89511C22623
	for <lists+linux-efi@lfdr.de>; Fri, 15 Mar 2024 18:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09001EB48;
	Fri, 15 Mar 2024 18:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=timschumi@gmx.de header.b="SYHRT5Hi"
X-Original-To: linux-efi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE57A8BEC
	for <linux-efi@vger.kernel.org>; Fri, 15 Mar 2024 18:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710528738; cv=none; b=kHkTIkv7dDitQNxCbEkHbowjOG6L0zos/cDi7lLr2yA0s82CoUlTJF7tmbxmqjiU9NNW8JjCqXjVK2qL9kZTTbmoya79JkA5zfo86gC3fvbjeNn043XFAZh05g2FQF81erOi9Vz2SglUIsOKj525t2p9KQa1maYsFQiKKXrkIcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710528738; c=relaxed/simple;
	bh=CTS0HyRqMIYubKonfhZDfvz8Jy6XncJXb4oCTmD8zEc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nL6QrvTnA5N6EmUR9ZmLjKKMD1vbgYB5OwRv5k9e3LuGj7+J5kQoBsealTNs7TvIDO5eEIz9I3fHH16VwcAdH4lnWUWG9V38yRmhYoiqnXQD1iBK/NoJdPe+hWsiotS8rypxiyrtSXU68inh4hPxaDTyhlV8MYPDg7pxEQfZ+Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=timschumi@gmx.de header.b=SYHRT5Hi; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1710528727; x=1711133527; i=timschumi@gmx.de;
	bh=yingDEKITlgVEmAuSa5LiMmto8K11Rbzysdl3TxQBLE=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=SYHRT5Hi4I2mbOSuDV7MalN/7NF93j0b2Q/VKbb6V9e/RGWAcKfVCpkaZjzKKVxw
	 i8JY9kufV357+BATusl/x/3E9XDzEcw9VTAKOrME/ISdogQmMHpkO0BkGPbBT1vcW
	 0j5CjSDDsoxVgwaXcc3F8Euk+LMalmsMKV7cs2AvfbCFdOTep8VcB1bsco3Sd2lWu
	 zTl873H/mvef+JCSnpiEUzlZ12k9JvdD72KbVYxgKP58YlDYELVjPzMK7zAZ3fQKr
	 W34bQCZkn1cR+DS6hBVUP8ZS0jWpHkAdTOjADPq3qmFWix20+EYzFgJSML3yiWYpU
	 Eo1RjbFvXj+URX3HJg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.222.0.4] ([93.218.98.241]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N95iR-1qgt613TEt-0164Hd; Fri, 15
 Mar 2024 19:52:06 +0100
Message-ID: <cef105fb-2e59-4131-8ee7-21b67f538b3c@gmx.de>
Date: Fri, 15 Mar 2024 19:52:05 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] efivarfs: Remove unused internal struct members
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org, Jeremy Kerr <jk@ozlabs.org>
References: <20240315002616.422802-1-timschumi@gmx.de>
 <20240315002616.422802-2-timschumi@gmx.de>
 <CAMj1kXFf8tmTkO+xn4PwumJ3pQQUQ7TUMtEBNBMc+HXb4ab5dQ@mail.gmail.com>
Content-Language: en-US
From: Tim Schumacher <timschumi@gmx.de>
In-Reply-To: <CAMj1kXFf8tmTkO+xn4PwumJ3pQQUQ7TUMtEBNBMc+HXb4ab5dQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MXaKbQQqRgpCLRW/2w7MVQqG/RikICmznEcn4pkpk9DbE6NV6lD
 nQ2Xg6aL5N7KtMcNTNw72DzGeZXPH/QL3SADUPfKn5xqHPina8tg68aUwahvJYg+XuQmu1P
 4PjMA8hoFaTuVtFrtyK/+A4Cz5VhZz91Pyr6jzLViOxa9ZccbOF/P5GhiHpl5YBJJAQIf91
 2PqmDQrYbo2xLv5oXBKpQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1jeolAsvvdw=;Is6uAmFKtkEQdPvKl6ed74+gfpC
 yMH7mAJOWx9tGXd0MrGz1G8aL2qWVJjAGyac0M7RrUn0Kyn+7N1CQar7ZwfT2HfwZWY068mBQ
 7c4hJg3fOJVY8AP9g/dy1zK0r0I1YA3aOfLMWthiW14qsu7SzX9TUQUyjWYf5npSrWeo5+hDX
 MLYIyk12GSAqP7tiRztOA5BXBphzs/Javjf8kj5FFpwFJEkqbNJM5aqmCXl9EJA64BuBC7jMP
 dVF47D6NTLPchlhf5yOnb+pzkdTy0gEATWtrvFL/b0iJiWaebgO1qzhUTuvrDxFb0Qk788Mxm
 DDTEntwC22ao0KAX1kZqTJ4LOHcwyeRQwGBrY0r+TU/HuNt+BM2eIUdEV0dy5R2KXXwNoydic
 2K7gwjIe39NWwAyyXqpDa5pe7t1PcxOswfuTy1xVux2Wxb+HDEnbCRrc7fPybQcznq2YPA+OW
 F/LWz+KZlVbBxGHCkqKNSSKu56FYhbyKMOFQhK97OaUQ0Q19hG7UZKUywLsIat/kbRNhmpCFM
 e5darWPg+OaPnFiXUtHsQMVWS8hwHpzTwDfmL84BYxL052sCawmBSagKxlpl55VQ75Y5bCuOX
 bPOfm5GL8p+Ckl0d0VXNY0yXGqc86OLDZqKSAi63E+4sUFUq5lpftG/wzCd3mxA++TPnVNRGQ
 mhLeesHkT2h2/H0wKe8oM957QmJ6eaIig0XrCwuYkM5uv1S7Y0Gt1Na3KODbX+mE0wC2V4l7n
 WQBQcQNZSp6GBk0NPfizc2DG2HgpF0Bxg8WHuvzv6wQfPB2EK+yK7YBEVbEu27Qs+67VHPXNu
 Hs01mTUMKD4ttsip49G/g9FcurcBaeQ/i77pB1ebMyD1c=

On 15.03.24 10:19, Ard Biesheuvel wrote:
> On Fri, 15 Mar 2024 at 01:27, Tim Schumacher <timschumi@gmx.de> wrote:
>>
>> The structure was moved to the efivarfs internals in commit 2d82e6227ea=
1
>> ("efi: vars: Move efivar caching layer into efivarfs") after previously
>> being used as the data ABI for efivars until its removal in commit
>> 0f5b2c69a4cb ("efi: vars: Remove deprecated 'efivars' sysfs interface")=
.
>>
>> As efivarfs only uses the structure for the variable name caching layer=
,
>> the data-related members were never in use. Remove them to avoid
>> implying that efivarfs is bound by the same restrictions that efivars
>> once had.
>>
>> Since we are changing the last copy of "struct efi_variable", document
>> the former layout in the ABI documentation of /sys/firmware/efi/vars
>> that is still left over.
>>
>> Signed-off-by: Tim Schumacher <timschumi@gmx.de>
>> ---
>> I'm unsure if this is how documentation of removed interfaces is/should
>> be handled, input on this would be greatly appreciated. Of course, the
>> alternative to what I did here is to remove the documentation
>> completely. If someone is running a kernel old enough to have this
>> interface, then the matching kernel source will still contain said
>> documentation.
>> ---
>>   Documentation/ABI/stable/sysfs-firmware-efi-vars | 12 ++++++++++--
>>   fs/efivarfs/internal.h                           |  3 ---
>>   2 files changed, 10 insertions(+), 5 deletions(-)
>>
>
> Please just rip out the doc (but in a separate patch and cc the
> Documentation maintainers)

It appears that Documentation/ABI is explicitly excluded by the Documentat=
ion
maintainers. Scrolling through MAINTAINERS seems to imply that ABI documen=
tation
is usually maintained by the relevant subsystem, and the docs-next tree in=
deed
does not currently carry any ABI documentation changes. A previous attempt=
 to
remove the documentation [1] also yielded no response.

On that note, I found that documentation on removed ABI functionality is g=
enerally
boiled down to a deprecation notice (or kept as-is) and gets moved to
`Documentation/ABI/removed` instead. I can't find where the efivars interf=
ace has
been declared deprecated, so for the purpose of a deprecation notice I'll =
assume
that the "lock to Intel architectures" commit [2] was that point in time.

[1] https://lore.kernel.org/lkml/20230123081905.27283-1-johan+linaro@kerne=
l.org/
[2] https://lore.kernel.org/all/20200923161404.17811-1-ardb@kernel.org/

