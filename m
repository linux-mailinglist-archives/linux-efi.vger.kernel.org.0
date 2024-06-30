Return-Path: <linux-efi+bounces-1322-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B910D91D158
	for <lists+linux-efi@lfdr.de>; Sun, 30 Jun 2024 13:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D16771C2147E
	for <lists+linux-efi@lfdr.de>; Sun, 30 Jun 2024 11:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828E913AA35;
	Sun, 30 Jun 2024 11:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FSQcB3Gd"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C752526AEA;
	Sun, 30 Jun 2024 11:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719745502; cv=none; b=BIabzmVnryr7QI+7pjqG2TejnJ7VYf+tHqeSZjcwrWPl8rkCkZNVYe3Zo7csDAEn/lnStssRMAlK0GsVol7ZK87fI4gLMKhDlkNf4zM5t94/qUpDJCRIss7T/pNVAHNElad0Gt3hWcZlIZfWUhTufxHOl65ZsJV+A8rSFBtAnWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719745502; c=relaxed/simple;
	bh=3oTcgFFEabFUHR4BN5HWFRl903EH/sfNAXoX6hgtzOY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y8OLHAk4RSBqCmBM6v6bCliDXTkcC3nuB8iTrSlm5VHvQf7psdGBFDLL/6ALNWrMqHotcd9LIXajIZSGxTVvycHYOfQ08OFbnKpiKpr7JAS4qu7xnXolHIMgNnXXhJPygQi7NU7TKbqUbPa7zORu9Y6ZTT/ZjFY92tTUkmlR8co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FSQcB3Gd; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-4ef2006dcdbso684914e0c.3;
        Sun, 30 Jun 2024 04:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719745499; x=1720350299; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OQbh5b9f2jn9p/VBOf+euH8ks1nyqbf4ekAmXJMwNA8=;
        b=FSQcB3Gdy1K8hoTGOIQoHPGOc1LrkhSIaY9tBwK97vXkk0URlt3t/ZAFpZZy+9XZWR
         uESiqsw0ufXZJR/J1pZ8hPbNaxmRP8IJMTiMmN3u04gMKRood+xVKNvqH8OhkGPq8HiQ
         hG77iyptkqpg0kpPvj90Ip3QofJxpYX2oMBPdfnnLT8cB2wuUU3G/wloYrUf9MriXAZe
         6kv7Yr80AbHYN/OZOSZP6lvsD/Et9GA9GqGs5Bw/3IhPdpYpeC0WZDXzx1rcfqf4QFRs
         zv7NtxKp1MNTUds5flXSx4V+bjobh7Q+eS2BAuUHaxX802hSURDyuHk7b/SD5JIVrHJu
         W8Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719745499; x=1720350299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OQbh5b9f2jn9p/VBOf+euH8ks1nyqbf4ekAmXJMwNA8=;
        b=tNps8IsLe9somLCwFzEHk9L/WaBAJYZKOT0J5gE6kaKkfnyHTn9osmvYJz5Om3CuYy
         +0YS2gtUcYugp6rfPkmoGgF1IcYqxpFKFmtC/xR0qXhl1jpvrp0qqezOuN9wNZN1lqzy
         nmVxlGuiOKKaP/WTF3xkPDyJ0UoTSUnLJabeAcj8o4Ygy5d9w1zSApWJof/gyKPrfsWa
         sPWxqQjhJZ1FxoR6VH7BpLRTLvkEa+EUG39LlARbUxLJApEIEuIEUw8Gbs7wWbBnkTi5
         Yvupsjkgrk4MeEm5OqHhOvWP0YtoUrNaKwH+ZpmEabP8fROhfgJlIcrS31DL1nxDZHXp
         JmoA==
X-Forwarded-Encrypted: i=1; AJvYcCWc15wY21l9V3TKfQgoovuUI1rgjjY7kffVo6Pb22v9/bojiHdM2P7SFeqcT+SXMcChKcDFYFqmjIPJwXlRjY60esKkS+5EYpx25TEnbcIaLlc6U+iSSPRA+OpHaUB12sd7bPZXOrKo
X-Gm-Message-State: AOJu0Yw5dg6GUr5vbWdOkQU9+j7b8n8ARAWX57h4QXiG+yzpgLVt2ECj
	hnNvU3VYjf72AM3BaxY6GSARuSwqORnr6Di/mIqYfHvCGWXPxVwJTaXq8+YvT5MdVIJQkr1CNU/
	6toqcOi4S/9Ff6uYJUM+8Sv3zP7E=
X-Google-Smtp-Source: AGHT+IEmYCF04/6qjuvJxwTbmOn0mUraHsGZiA9+fjY01GPc+8mRN52E3SfeV6FfkozXleVb2SSrat02LBykXWEHnhs=
X-Received: by 2002:a05:6122:2899:b0:4ec:f9ad:d21a with SMTP id
 71dfb90a1353d-4f2a56db17cmr3093066e0c.10.1719745499347; Sun, 30 Jun 2024
 04:04:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <EBE51900-DA87-4113-B389-80B9C9160F0F@live.com>
 <ZoERl1PWoc2xDGWz@wunner.de> <MA0P287MB021730971A804FB760463A39B8D22@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
 <ZoEtG0DUJOS4ROQC@wunner.de> <MA0P287MB0217B3F9B9E1CFA54FAD96CEB8D22@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
In-Reply-To: <MA0P287MB0217B3F9B9E1CFA54FAD96CEB8D22@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
From: Orlando Chamberlain <orlandoch.dev@gmail.com>
Date: Sun, 30 Jun 2024 21:04:48 +1000
Message-ID: <CADfWnbYVko8R1WHuDugEp4_HzrfHRJH8G2Fk_Orxbt1UL+E8KQ@mail.gmail.com>
Subject: Re: [PATCH] efi: libstub: add support for the apple_set_os protocol
To: Aditya Garg <gargaditya08@live.com>
Cc: Lukas Wunner <lukas@wunner.de>, Ard Biesheuvel <ardb@kernel.org>, 
	Hans de Goede <hdegoede@redhat.com>, 
	"linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Kerem Karabay <kekrby@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 30 Jun 2024 at 20:50, Aditya Garg <gargaditya08@live.com> wrote:
>
>
>
> > On 30 Jun 2024, at 3:32=E2=80=AFPM, Lukas Wunner <lukas@wunner.de> wrot=
e:
> >
> > =EF=BB=BFOn Sun, Jun 30, 2024 at 09:13:33AM +0000, Aditya Garg wrote:
> >>>> On 30 Jun 2024, at 1:34 PM, Lukas Wunner <lukas@wunner.de> wrote:
> >>> On Sun, Jun 30, 2024 at 04:42:55AM +0000, Aditya Garg wrote:
> >>>> Based on this patch for GRUB by Andreas Heider <andreas@heider.io>:
> >>>> https://lists.gnu.org/archive/html/grub-devel/2013-12/msg00442.html
> >>>
> >>> Please include his Signed-off-by and cc him.
> >>
> >> Not sure about this since the patch was send to grub and not lkml,
> >> and his work has been used without informing him for this patch solely
> >> on the basis of GPL.
> >>
> >> I've always been confused in signed-off-by in case of authors whose wo=
rk
> >> has been used without their explicit consent just because the license
> >> permits it.
> >>
> >> Should I still add his signed-off-by?
> >
> > I would.
> >
> >
> >>>> --- a/Documentation/admin-guide/kernel-parameters.txt
> >>>> +++ b/Documentation/admin-guide/kernel-parameters.txt
> >>>> @@ -399,6 +399,8 @@
> >>>>                 useful so that a dump capture kernel won't be
> >>>>                 shot down by NMI
> >>>>
> >>>> +    apple_set_os    [KNL] Report that macOS is being booted to the =
firmware
> >>>> +
> >>>
> >>> Why the kernel parameter?  Why not do this unconditionally?
> >>
> >> 1. Not all Macs have dual GPU. We don't want to unnecessarily "fool"
> >> the firmware in thinking macOS is being booted.
> >> 2. apple-gmux is a reverse engineered driver, although upstreamed,
> >> not very efficient in switching GPUs. So it's better to make unlocking
> >> the GPU optional. + not everyone wants the intel GPU, people are happy
> >> working with the dedicated AMD GPU (used by default if apple_set_os
> >> isn't enabled).
> >
> > So my opinion is that these aren't good arguments.  We should be
> > identifying as Darwin by default in EFI, just as we've been doing
> > in ACPI since 7bc5a2bad0b8.  If there are any adverse effects,
> > we should look into them, but users shouldn't be forced to set
> > an obscure kernel parameter only to enable certain features of
> > their hardware.  It is for this reason that you'll usually get
> > Greg KH's trademark "this isn't the 90s anymore" comment when
> > adding new kernel parameters.  We need to handle the hardware
> > correctly *automatically*.
> >
> I'm not in a favour of "forcing" dual GPU on users, especially because th=
e features are quite unstable. On some distros like Ubuntu, since kernel 6.=
8, unlocking the GPU results in blank screen instead of igpu due to a regre=
ssion (note that this patch has nothing to do with this regression, it's so=
mething the platform drivers people will look into).

Is this just with apple-set-os or was
https://github.com/t2linux/linux-t2-patches/blob/main/2009-apple-gmux-allow=
-switching-to-igpu-at-probe.patch
and the kernel parameter it adds being used when that issue happened?

>
> On the 2019 MacBook Pros the vgaswitchroo is not working and inputs from =
AMD are nil. Basically you get stuck to the Intel GPU and if you try to use=
 the AMD GPU, but the GPUs remain on (currently no way has been found to sw=
itch off the AMD one)

Do you mean that switching which gpu is connected to the display at
runtime isn't working? I *think* is is related to the not-upstream
patch I linked above?

>
> So I guess we have 2 options:
>
> 1. Wait until apple-gmux becomes quite stable before merging this (fat ch=
ance)
> 2. Give me some better idea to handle this.
>

