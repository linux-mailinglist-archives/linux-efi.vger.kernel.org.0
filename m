Return-Path: <linux-efi+bounces-2724-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB35A1A0B6
	for <lists+linux-efi@lfdr.de>; Thu, 23 Jan 2025 10:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FC8D188172E
	for <lists+linux-efi@lfdr.de>; Thu, 23 Jan 2025 09:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623C020CCEB;
	Thu, 23 Jan 2025 09:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hQAuzL9R"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FC620CCE3;
	Thu, 23 Jan 2025 09:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737623885; cv=none; b=CPJ1W/hMMLZlc68C9x0plaLb0jo8mBXUxdQZuHWNEADFXFwHjAEDIhLslQvxpF0ENo3uinDZmWgWb3/vMGR5vhpg9BBHn0aVuDnAB//+TU4FmT9wjDEZJDGDslmDpNErsc2Z8q35nYLnS8VyJeW3DheDvzP+5+gjy/ZgVdPcjYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737623885; c=relaxed/simple;
	bh=cwVbpER6j1F84CaEftcblW1AjMF+eT07Jp5Ea0UZq18=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=stIrUdyj1q9SWpD4c22D+zJnmNhe9Cq0/ApO3Z/ad9KBHFic8j3XBsKkvX046AULJz2i5ej5tT9tVtO+wVExc4AMTtQZwXMYWU5jIlLgktyHL19N0AeMiqU+zVR7pxw+TZxox1kPlu46ohQY/FAfvakSvkLlXr+S+rzW+sfov2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hQAuzL9R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9417CC4CEE2;
	Thu, 23 Jan 2025 09:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737623884;
	bh=cwVbpER6j1F84CaEftcblW1AjMF+eT07Jp5Ea0UZq18=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hQAuzL9ReXztjmjmw9mtKLNaC6QnhlVMLVm2uwvKOKMa34YAzVGubogED6ABFYdwP
	 DXhRiEkogOVKpEVTZWZlizGpLl49Vrpb2owiWnZ7rsxtiLQzRjLAi/oktuOhn4DOYW
	 WrVyi5yK2Y0ke/MUJL1OqdIWB2KzjMuz59s/MkmtSiO3ayiRO8hNqLwqMHL/GHmd2N
	 kNZjwThcJKVhIDCOAcDFrgUwBaJl0Y5SMNa1SYUU6G615Eo2eRcsvAywsiNG/DAZyz
	 VfJxeCNKkoYRJmAw2+7XrV88AxiCfIUZX+T1OLVQqOCCcC4wsVl1TyzTfIk0cuCNcT
	 dRWKXSWVa/Wqg==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-3003c0c43c0so6384321fa.1;
        Thu, 23 Jan 2025 01:18:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUnKjS/Jpjm6SHc+02LxgX5JuUpwGT0zM8O04hQCUeIiSe+xyaRP7Mv8YMNfeftKoLHmhTDT/OAJ8s=@vger.kernel.org, AJvYcCWx1RL5oFJDqsq7VbbEzkozddpq4Mn9TX6wEFs+DBvnGViN2FZjesiRispFkP88s8dLuTMGP8PoO0xR9xVY@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9j3+pfx+mWyiqrdxnD1VEABOdNusDt1njCq8/IpTAlFONi5Co
	EDI/SAmcc/FX9JHAOtK/wzjJYdMVqH9NfDdhFyDxWBqltCNF4Ib2KrZ9CGc4QSoQe1Ss6eYR0AB
	RRd83J07YoLx3oMX5/lbOGTnJXj8=
X-Google-Smtp-Source: AGHT+IFg5anTPNIwZuGThorwrA/7bluFKX5hdt4Mvyrgzh1VDjtaql2A/D3p2BY+f8cyS4uQ6EUccU0NX+ll7knhcsw=
X-Received: by 2002:a2e:a98e:0:b0:302:27ea:a56e with SMTP id
 38308e7fff4ca-3072cb3ee90mr100096001fa.32.1737623882947; Thu, 23 Jan 2025
 01:18:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z5Hja30Wb94uGQ3L@darkstar.users.ipa.redhat.com>
In-Reply-To: <Z5Hja30Wb94uGQ3L@darkstar.users.ipa.redhat.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 23 Jan 2025 10:17:51 +0100
X-Gmail-Original-Message-ID: <CAMj1kXH6yorrBNYyuO2YrX_Q4cCW8LoyHOZMb=a5k0Euuooznw@mail.gmail.com>
X-Gm-Features: AbW1kvb-93ZaeBmySOwZwTV0VF9jUFmzHZKRgAk2dsgRXgVRcwKkn0oNXh6Qwok
Message-ID: <CAMj1kXH6yorrBNYyuO2YrX_Q4cCW8LoyHOZMb=a5k0Euuooznw@mail.gmail.com>
Subject: Re: [PATCH] x86/efi: skip memattr table on kexec boot
To: Dave Young <dyoung@redhat.com>
Cc: Usama Arif <usamaarif642@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-efi@vger.kernel.org, Breno Leitao <leitao@debian.org>, kexec@lists.infradead.org, 
	x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 23 Jan 2025 at 07:36, Dave Young <dyoung@redhat.com> wrote:
>
> efi_memattr_init() added a sanity check to avoid firmware caused corruption.
> The check is based on efi memmap entry numbers, but kexec only takes the
> runtime related memmap entries thus this caused many false warnings, see
> below thread for details:
>
> https://lore.kernel.org/all/20250108215957.3437660-2-usamaarif642@gmail.com/
>
> Ard suggests to skip the efi memattr table in kexec, this makes sense because
> those memattr fixups are not critical.
>
> Reported-by: Breno Leitao <leitao@debian.org>
> Reported-and-tested-by: Usama Arif <usamaarif642@gmail.com>
> Suggested-by: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Dave Young <dyoung@redhat.com>
>
> diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
> index 846bf49f2508..553f330198f2 100644
> --- a/arch/x86/platform/efi/quirks.c
> +++ b/arch/x86/platform/efi/quirks.c
> @@ -561,6 +561,11 @@ int __init efi_reuse_config(u64 tables, int nr_tables)
>
>                 if (!efi_guidcmp(guid, SMBIOS_TABLE_GUID))
>                         ((efi_config_table_64_t *)p)->table = data->smbios;
> +
> +               /* Do not bother to play with mem attr table across kexec */
> +               if (!efi_guidcmp(guid, EFI_MEMORY_ATTRIBUTES_TABLE_GUID))
> +                       ((efi_config_table_64_t *)p)->table = EFI_INVALID_TABLE_ADDR;
> +
>                 p += sz;
>         }
>         early_memunmap(tablep, nr_tables * sz);
>

Thanks. I've queued this up now.

