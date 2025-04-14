Return-Path: <linux-efi+bounces-3332-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54177A88C67
	for <lists+linux-efi@lfdr.de>; Mon, 14 Apr 2025 21:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC0D17A8CFE
	for <lists+linux-efi@lfdr.de>; Mon, 14 Apr 2025 19:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0BCD1A23A9;
	Mon, 14 Apr 2025 19:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UOFkcywX"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84453383A5;
	Mon, 14 Apr 2025 19:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744659957; cv=none; b=qJD7pZsLjhuOYVT/WlUjdSA1aKF/kZmaMiCYO5l9pBHDhMTHy0vKmGXt/L2ojqawv/Tm6k7A9IHMb9uw/7gSYuxDX5caLDmTSUI2LkN5nkNUSSEPDQnIxpZg19zrcyr5+VWiF2tGA3bD6m6fvr18y2nPNkTVX2CbCmSfE173hcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744659957; c=relaxed/simple;
	bh=IMOh9BCmxuP8X1IrkobhNuG+UnD0MCGF/Hah1mGcikY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kTthd0/BJTCofDt80ExVkv/DOc+rWVCWwXwqP5ktlKY66GplR1vmnPhVIKUk/U+jV+93RIoiysF697kaFPPrgUmkW1zGK8bQf1vlE5lwNtEAxyYSwnhjcsuWeZmZnr5TRsvFPis9ODfitn4x7DUosStufCjGR14bDu6vZ7NRIEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UOFkcywX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D535FC4CEEC;
	Mon, 14 Apr 2025 19:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744659956;
	bh=IMOh9BCmxuP8X1IrkobhNuG+UnD0MCGF/Hah1mGcikY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UOFkcywXAZt3yS7UL34p6e+ECift0SqVFyJk35lCExiMilK3Ge0sN6t/aoYXuX4l5
	 73fy7fceKxuXM1SbKso8LLT15qX8SdpDG/PlwomgNx4jvzM5KRLZFOegmgWk1TOMJp
	 NQMtvcGVHKFprYznfZxmwpYO+zw2B79NUgxBdZpVgGmzNQlmTb7V6kqMwLFWMqBA3W
	 L98gICuhuzbOWfsyYzMlU77yOPICVGXcnTV7gavPz4kYoKHSYbzQ+SbMhJYGWJ2IR5
	 u48TMXD9X4jov5zJYwUgKht1OKi9ZOZz/XlFiBYJE+uNYB5IWVmls2d+7A6zN9Mp7o
	 ktvECox2950rA==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-30bfc8faef9so45005791fa.1;
        Mon, 14 Apr 2025 12:45:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUf28tRsYXLxlUajFgYK/bNQUgRQOXyKKib/jjamVIuv1GkRT432TLU+h2yvjMcNiN4ESJ6uke/8/GVXmMH@vger.kernel.org, AJvYcCWz/zxKyMMJ+t/arW3NIfdRdxVnR2S5/Xi7daRDemOfOrsEO27NDOdCnNQRCBUtiNCFfSGbXlVJ7fQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzxj9FL3BVSIv0xVEe1EeH1+if9dRWMJxGUDsd0JRV2bIDAxg+
	ovguUZQ4bRU3G0eaANTLpouORqhkHVCo0fK1xZIw1HMXfF+4WYwEZQ3UGG7yQkxf5QPrdzrGnXn
	tx10f4A89cZQVFz/lmaiBDWhtF/4=
X-Google-Smtp-Source: AGHT+IEVLrbKVxe/lkRq28/ydzyMaOWT/QfqRrcYYPCVt1jvGt554xAgZAfaKIn+A573laaxDtQMmHcDbsRqa3B9kls=
X-Received: by 2002:a05:651c:19a0:b0:30b:bb45:6616 with SMTP id
 38308e7fff4ca-31049a80874mr47825411fa.29.1744659955161; Mon, 14 Apr 2025
 12:45:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250414130417.1486395-2-ardb+git@google.com> <e48bf1ad-3d48-0867-35ce-068da901d01c@amd.com>
In-Reply-To: <e48bf1ad-3d48-0867-35ce-068da901d01c@amd.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 14 Apr 2025 21:45:42 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGOegcJhOOiyw_0A0Y1GW0K3LqBuhpn1TrVp4aKLGn=-w@mail.gmail.com>
X-Gm-Features: ATxdqUE1QbHKWUxNAg3luWZuL5hQcvn05NE1dpjMR298VxR2vWgqvxb922UwJEg
Message-ID: <CAMj1kXGOegcJhOOiyw_0A0Y1GW0K3LqBuhpn1TrVp4aKLGn=-w@mail.gmail.com>
Subject: Re: [RFC/RFT PATCH] x86/efistub: Don't bother enabling SEV in the EFI stub
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-efi@vger.kernel.org, x86@kernel.org, 
	linux-kernel@vger.kernel.org, mingo@kernel.org, 
	Borislav Petkov <bp@alien8.de>, Dionna Amalie Glaze <dionnaglaze@google.com>, 
	Kevin Loughlin <kevinloughlin@google.com>
Content-Type: text/plain; charset="UTF-8"

Hi Tom,

Thanks for taking a look.


On Mon, 14 Apr 2025 at 21:10, Tom Lendacky <thomas.lendacky@amd.com> wrote:
>
> On 4/14/25 08:04, Ard Biesheuvel wrote:
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > One of the last things the EFI stub does before handing over to the core
> > kernel when booting as a SEV guest is enabling SEV, even though this is
> > mostly redundant: one of the first things the core kernel does is
> > calling sme_enable(), after setting up the early GDT and IDT but before
> > even setting up the kernel page tables.
> >
> > So let's just drop this call to sev_enable(), and rely on the core
> > kernel to initiaize SEV correctly.
>
> SEV support does some things in sev_enable() that aren't done later in
> the kernel proper. For example, we check certain hypervisor features and
> save the CC blob into the boot parameters.

I misread the last part: the kernel proper checks struct boot_params
and setup_data, whereas the decompressor checks both of those as well
as the EFI config table.

It would make sense for the EFI stub to populate the field in struct
boot_params directly.

> And as I look closer, I see
> that we don't call initialize_identity_maps() from the EFI stub so we
> aren't calling snp_check_features() from the EFI stub, which we should
> have been doing.
>

The EFI stub has its own check for this, based on the same underlying
logic (have_unsupported_snp_features()). But it checks this much
earlier so it can fail gracefully and return to the firmware, rather
than terminate.

> Just removing the call does cause an SNP boot to crash. My testing shows
> just ensuring that the cc_blob_address in the boot_params structure is
> set results in a successful boot under SNP. So some of sev_enable()
> needs to remain and some things need to be moved into the kernel proper.
>

Thanks, this is very helpful. I'll dig a bit deeper and try to address
the points you raised.

