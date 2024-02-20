Return-Path: <linux-efi+bounces-592-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF2EE85B51D
	for <lists+linux-efi@lfdr.de>; Tue, 20 Feb 2024 09:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D72D1F21BEA
	for <lists+linux-efi@lfdr.de>; Tue, 20 Feb 2024 08:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9173D5C61A;
	Tue, 20 Feb 2024 08:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VuBTIhfX"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649515C609;
	Tue, 20 Feb 2024 08:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708417688; cv=none; b=qzW70iXsQ+7khRUJadsNVRS2BIspnXk25e/ELRz+beJPoW6lbyqFgtuoljApiJfATyy4Vqx/NM9TXX1wb/DCQtNxAIgDG/5FmdRUSx6bMU5YytG4A7OmshycY0xJ59o7v5Swa3A5tO1L4tUaNOoXeWosEiqm07jWu/CWhZn2UGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708417688; c=relaxed/simple;
	bh=8NojBs5OOxOWAE3h/AeLXQbt98Gk2zBllMx9ZfLFugw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=skTUv7+QKkDbzI2XBWYby+RkGOubT7x7nkex3GqGuPWiXf+WWBpR8hqUSOV5pSbU9WDtYoZwltyRuN8yqB8dMVGap0DnmpbmTGqSLhGP/0wk9vtKJnBBLpD5NitrJh0oBDqYRLitk0EBAAE+9noAZQeC8VR5nWOeFriZnQ0wUUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VuBTIhfX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5C7CC43390;
	Tue, 20 Feb 2024 08:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708417687;
	bh=8NojBs5OOxOWAE3h/AeLXQbt98Gk2zBllMx9ZfLFugw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VuBTIhfXyy1WszQ0KLEYbexwTgrNe7OMEwgEDtOgQcS35Dekd88m8Wr+ccyuzW3EX
	 p2XgwJ31uRUyID+9Wu4P1Re2U8jllGzNO+oaNw7Zvmkslxs35tF2jdqz533H7FICMx
	 vzPkjN1iV/Ikf1c6N4KBgow9b1qBvlF6A4aRmNhEr+h6/rHXoVLwPev1q2DjWHTVvR
	 ufA2gm0WV13GGXFkAO0GZRpzaQacYZHrciuHdLi2womFataACBO22KBnmMcgdcbO9p
	 aya/BsQOYDKcFhA4RktManAULDcuUmroX+p6ApHZOTxvbkxBtus80rCtMVO0WNodiu
	 AEMAp6x+THHFQ==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5112bd13a4fso6685591e87.0;
        Tue, 20 Feb 2024 00:28:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXj9wrWtDHb4EOriYkHH4Q50xJ7ZSdTH0Qbqhu0orxtuPbScmRyGfa8l5N2EneXkb/3VAC+t1VSS7PWoo7F/LT5lYf4Z0y+G9QxFA39ga+VwvHTkRuc76/jYgkjxSIEpvef+Ihkoqh6MAxw02wndJKXPiuS7qz8Ma3bv+0R835a4YUvMphrrRJB5rsyXvQF56NmeBYTRwr6ICiNPrdngWM/bQ==
X-Gm-Message-State: AOJu0YwkZs6udMbAj0nkVluZRz4U3NZG87o5KOdUFPRnY7K/B/5AqR5Z
	QDBLapURY1cJs00cQPDMn2neYLtsJWzrm1lx5asoVa89Be5UTcH8gqdacb6eoC6ufuKsoOgqz1J
	Od2vuytkRNbdkJdrvkY9TI9UVNMs=
X-Google-Smtp-Source: AGHT+IFG5XWQOePlu2a/BI98A1oPfCPp49GB0UY1qIt2KM/lwtnqF5//96XzhpPDrq4mFoV6bCF5jKk3Tcs+aZHZKv8=
X-Received: by 2002:ac2:5394:0:b0:512:b965:f60f with SMTP id
 g20-20020ac25394000000b00512b965f60fmr1206182lfh.9.1708417686087; Tue, 20 Feb
 2024 00:28:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240215225116.3435953-1-boqun.feng@gmail.com>
 <2024021718-dwindling-oval-8183@gregkh> <ZdQmCEepdOE2R7gS@boqun-archlinux>
In-Reply-To: <ZdQmCEepdOE2R7gS@boqun-archlinux>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 20 Feb 2024 09:27:54 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGzaUsgn0DGfy15c+Z5ECNqosjWbci-YZyUTsMWXte21A@mail.gmail.com>
Message-ID: <CAMj1kXGzaUsgn0DGfy15c+Z5ECNqosjWbci-YZyUTsMWXte21A@mail.gmail.com>
Subject: Re: [RFC] efi: Add ACPI_MEMORY_NVS into the linear map
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-arm-kernel@vger.kernel.org, 
	stable@vger.kernel.org, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Oliver Smith-Denny <osde@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 20 Feb 2024 at 05:10, Boqun Feng <boqun.feng@gmail.com> wrote:
>
> On Sat, Feb 17, 2024 at 08:49:32AM +0100, Greg KH wrote:
> > On Thu, Feb 15, 2024 at 02:51:06PM -0800, Boqun Feng wrote:
> > > Currently ACPI_MEMORY_NVS is omitted from the linear map, which causes
> > > a trouble with the following firmware memory region setup:
> > >
> > >     [..] efi:   0x0000dfd62000-0x0000dfd83fff [ACPI Reclaim|...]
> > >     [..] efi:   0x0000dfd84000-0x0000dfd87fff [ACPI Mem NVS|...]
> > >
> > > , on ARM64 with 64k page size, the whole 0x0000dfd80000-0x0000dfd8ffff
> > > range will be omitted from the the linear map due to 64k round-up. And
> > > a page fault happens when trying to access the ACPI_RECLAIM_MEMORY:
> > >
> > >     [...] Unable to handle kernel paging request at virtual address ffff0000dfd80000
> > >
> > > To fix this, add ACPI_MEMORY_NVS into the linear map.
> > >
> > > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > > Cc: stable@vger.kernel.org # 5.15+
> >
> > What commit id does this fix?  Can you include that as well?
> >
>
> It should be 7aff79e297ee ("Drivers: hv: Enable Hyper-V code to be built
> on ARM64"), but as Ard mentioned earlier, this could be fixed at the VM
> firmware, and Oliver is working on that. Should the situation change, I
> will send a V2 with more information and include the commit id.
>

The patch as-is is not acceptable to me, so no need to send a v2 just
to add more information.

Please consider the fix I proposed for arch_memremap_can_ram_remap()
if fixing this in the firmware is not feasible.

