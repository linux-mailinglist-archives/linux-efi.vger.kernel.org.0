Return-Path: <linux-efi+bounces-2079-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A56929B7CE6
	for <lists+linux-efi@lfdr.de>; Thu, 31 Oct 2024 15:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ACDC281790
	for <lists+linux-efi@lfdr.de>; Thu, 31 Oct 2024 14:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0772049641;
	Thu, 31 Oct 2024 14:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JvShhpZL"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59AF175BF
	for <linux-efi@vger.kernel.org>; Thu, 31 Oct 2024 14:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730385144; cv=none; b=ExN03RC/dzn0YD9Ermij4RjdR8oaUe0P8nTkOyhaCER4vL/EsJpK3FcigmLaj8xjTSCdAD+uoQo6KEyzGYLcFDVj2HLhyO0epZ49TRiBZYhEf4XbDpfqmwhjnKn3cugQQYJQ3I0Ig9K1HLtbxLsehe4NRDR2We1FAnIfKsgmikE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730385144; c=relaxed/simple;
	bh=rDYCy8Isd+Gm3zg7473Pwa8KOtqMDdqg90j6TZspFk8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cAHtkthjr0eGptNZT+N9YJuBfti9mDrmeLBOYrTPdbX+RoQu9+A5D4m5ycCl613yzV+iKc/xthBS0g41QDD5SUxzKnDEQNPAPiZmLgvSsUujcQtNhbwGtD1RxjDzSoYNkiiGs208fQ2Nm5yh8mOrrLnqfaM0bdUn1r4rbBi8FGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JvShhpZL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6954BC4DDF6
	for <linux-efi@vger.kernel.org>; Thu, 31 Oct 2024 14:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730385144;
	bh=rDYCy8Isd+Gm3zg7473Pwa8KOtqMDdqg90j6TZspFk8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JvShhpZLS/h6MK3MWslAWczmYOKmrc0FZKT7UJnKHgLo865lMN55vOSDV8tVQ61VN
	 pr8KrkaaQ89RupZGvg06axrJU/dE1TgOsFBrZGAG1T/viFSg3UiL1Eq7x1beFZp80P
	 zC1PzK2h1nMjmtmpMf9DC/R8jkhnileD0zi3RJV/SCc5vJWRaRFwdIpTnkG924F0tN
	 GtSrfYLUmV147FvWtpELjFDemzPXFMH+gba+8LUjHLKT0IQSqzaiGHexXO9xrBeBzx
	 mlyajZAI2uMlDm0wK9UpGuBGrY+87wUZfZ///mC0MW6vA8/SlcxwSSS+Hq56GyKcPO
	 yWjOpvnu57RCw==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-539e13375d3so1119282e87.3
        for <linux-efi@vger.kernel.org>; Thu, 31 Oct 2024 07:32:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCULphG24xkDEhrxBxqY7ZoLuEWINyd0EwckcM2lPYRJMC99Bs/vzMq3ykG8Yur4sCfVSTBxPPyxjs0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/21fG2nmBdHW85T4coD0XVAkfihOVgiXIsL+sANayTYBO24lt
	PX4RU2QZxY3pIl4WQyfW0W04O6G/fyCseRqZKpp7OuJQIpWdbGHM5SYvvrN03+Tk+Hvowg91d8k
	ucdTgEw7VAdbEh27nHuNH0qwB2Uo=
X-Google-Smtp-Source: AGHT+IEHI2aaXgRgj3z9jVva3t+mlUTokyAIp/OlMT8NnI6P68q4cYWVOC32837r6j8bssBxGWm5fdvArrnbYhp/ys4=
X-Received: by 2002:a05:6512:1241:b0:539:f8c7:4211 with SMTP id
 2adb3069b0e04-53c79e4a990mr1579781e87.26.1730385142727; Thu, 31 Oct 2024
 07:32:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241031104359.2613133-2-ardb+git@google.com> <20241031-classic-eager-bullfrog-abe9ef@leitao>
In-Reply-To: <20241031-classic-eager-bullfrog-abe9ef@leitao>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 31 Oct 2024 15:32:11 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFXMwE__vkKgYcvrnXAw896diTihtTLuWaqFfYsxsq7FA@mail.gmail.com>
Message-ID: <CAMj1kXFXMwE__vkKgYcvrnXAw896diTihtTLuWaqFfYsxsq7FA@mail.gmail.com>
Subject: Re: [PATCH] efi/memattr: Ignore table if the size is clearly bogus
To: Breno Leitao <leitao@debian.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-efi@vger.kernel.org, 
	Gregory Price <gourry@gourry.net>, Usama Arif <usamaarif642@gmail.com>, 
	Jiri Slaby <jirislaby@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 31 Oct 2024 at 15:17, Breno Leitao <leitao@debian.org> wrote:
>
> Hello Ard,
>
> On Thu, Oct 31, 2024 at 11:44:00AM +0100, Ard Biesheuvel wrote:
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > There are reports [0] of cases where a corrupt EFI Memory Attributes
> > Table leads to out of memory issues at boot because the descriptor size
> > and entry count in the table header are still used to reserve the entire
> > table in memory, even though the resulting region is gigabytes in size.
> >
> > Given that the EFI Memory Attributes Table is supposed to carry up to 3
> > entries for each EfiRuntimeServicesCode region in the EFI memory map,
> > and given that there is no reason for the descriptor size used in the
> > table to exceed the one used in the EFI memory map, 3x the size of the
> > entire EFI memory map is a reasonable upper bound for the size of this
> > table. This means that sizes exceeding that are highly likely to be
> > based on corrupted data, and the table should just be ignored instead.
>
> First of all, *thank you* for the quick fix.
>

My pleasure

> A few questions/thoughts that are still bugging me. If you know the
> answer for any, I would appreciate hearing from you.
>
> 1) This patch protects the kernel from a broken firmware. It has nothing
> to do with the kernel code. The kernel is being a victim here.
>

Indeed. And this is arguably something I should have added at the time
when support for this table was first added.

> 2) The bug reported in [0], clearly found that the problem was likely
> introduced by 2e6871a632a99d9b9e2ce3a7847acabe99e5a26e[1] from a cold
> boot. How it might be related to
> 2e6871a632a99d9b9e2ce3a7847acabe99e5a26e ?
>

To me, it does not seem related to the TPM event log handling at all.
The only change made there is the memory type, and none of the other
logic is modified.

What seems more likely to me is that allocating pool memory of type
'ACPI reclaim' triggers a page allocation in this case, to add enough
pages to the pool to satisfy the allocation request. Page allocations
modify the EFI memory map, and therefore trigger an update of the EFI
memory attributes table.

What I suspect is that this firmware doesn't handle this very well
when it happens late in the boot.

It would be useful to boot the affected system with 'efi=debug' to get
a look at the entire EFI memory map.

> 3) Does having 2e6871a632a99d9b9e2ce3a7847acabe99e5a26e make the
> firmware bug (EFI Memory Attribute Trable corruption) more visible by
> any chance?
>

Exactly.

