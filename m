Return-Path: <linux-efi+bounces-2334-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7609E9DBA
	for <lists+linux-efi@lfdr.de>; Mon,  9 Dec 2024 19:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB6D01652E2
	for <lists+linux-efi@lfdr.de>; Mon,  9 Dec 2024 18:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47BCF15666A;
	Mon,  9 Dec 2024 18:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WochORv4"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165561537C3;
	Mon,  9 Dec 2024 18:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733767216; cv=none; b=P2lE5akdE/2eoiNwc8Tkl76EQsKk42LdcIsFLF9XnxQ7G0wkiQlXpTc2jMo+4iBdfykqcAhRvtMWgMCLEpe3y9jFqlnMDi6JCpbBo+TeUd1lrGhaEAEUwO0i/CNfFkklU0Wnq0rMV1QXB+h1oL04b1Tgx4vSu0G97A30C+roT6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733767216; c=relaxed/simple;
	bh=bHM3Cp2XFUeSskQHRGNxXjQKVYYNtnn3YxdzVGxd8PQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kp0k87T/mL4KXaeSyuZBK5XKrwqVomdnDQ5wMkiXdqLr37tZAGAb7Geq6VJI2HuLSXxmc5zdKGye/zVDSkNOSadac+SkAD7DRkkrd3UojfLkMk/M8jALKJ0+Frh1e/AcgUpRuZT7CUMZmGJQkh/DfTsy0MlYc+CTT0e6PSMts3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WochORv4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BAE4C4CEE2;
	Mon,  9 Dec 2024 18:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733767215;
	bh=bHM3Cp2XFUeSskQHRGNxXjQKVYYNtnn3YxdzVGxd8PQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WochORv4Pr/ifmCvgBRYX1Ul1Hr32SZ62yzQSBTy19kQwyIjz8KSGb/p35E/dMrS6
	 rh1l5bZKVWkdwLlaysNOlxlRecSwmsZ20r7GA3kUJ1/EKhCNNvi7avmuj81Xhh+aBR
	 jyZg67macFzWpSFNjumqal2cNjzdGGYhyUM5+1vq9AJbmzqx55YQBh7avEKJW9tCzt
	 2qgCoKRol/if9SNHim9DyUII2hS1TArdquMf0o/ijpPjGWMOkSB3m36XDj6XkS5Xgp
	 oH0nrjrWWg6jojyA/xDDwEblE8mKoWaAHV6yv6lK1zi/PyjBhrh15XxO2Z0zDSkFzz
	 RiJ3kddu62Z2Q==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ffd6b7d77aso55433361fa.0;
        Mon, 09 Dec 2024 10:00:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUWKH1MwVvCy23fDOadsBkm8IJyzgQWCBXRGuVHIqfqtW7OpVuKKBPXEOq1zhIfu/gQppKxk6Rj96iaDFY=@vger.kernel.org, AJvYcCVFyMkksLMsQgAlKVpka0IM1inp7HfVrFC6nBblSeCPxQxWlNWn6JBWcXB9X9f9+uv6zDxS7+XC@vger.kernel.org
X-Gm-Message-State: AOJu0YwSP1EWYt/inHqaRB+4nBCkiqyLcsO9UzNA4sAPOI6A8IigoiTT
	bmV5NcPTsXPG3DhMgBHV/aDyMPN92oKophkaHH0XJ2FeyedS0o8pqT7ZrLYa/K5LaekRLYnRQ/Y
	uYuaxZn0e57cI+rlkfrDJeSJXzzo=
X-Google-Smtp-Source: AGHT+IEoon9SsUEzcxQ33uPU1JoEeHSO1ZmTwdIBbFz5a/nQQaFY474MxXcF6HJu6+1bHcrgxrLDfKXS6ZG6AS9/QUY=
X-Received: by 2002:a2e:b891:0:b0:300:3de4:ff7f with SMTP id
 38308e7fff4ca-3003de5096dmr48316171fa.6.1733767213727; Mon, 09 Dec 2024
 10:00:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209162449.48390-1-hamzamahfooz@linux.microsoft.com>
 <CAMj1kXF=f-QAhXJA=U=jbn++Vyzf+e2k+cCS+Jk4Om4p0puD5Q@mail.gmail.com> <380bbf4b-0828-444e-9b93-fa639cc23a1a@linux.microsoft.com>
In-Reply-To: <380bbf4b-0828-444e-9b93-fa639cc23a1a@linux.microsoft.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 9 Dec 2024 19:00:02 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFAbycLk5fLtyDXw2ApPp2ztJ0J7B-De5=eXKtUjvyAfw@mail.gmail.com>
Message-ID: <CAMj1kXFAbycLk5fLtyDXw2ApPp2ztJ0J7B-De5=eXKtUjvyAfw@mail.gmail.com>
Subject: Re: [PATCH] efi: make the min and max mmap slack slots configurable
To: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
Cc: linux-efi@vger.kernel.org, stable@vger.kernel.org, 
	Tyler Hicks <code@tyhicks.com>, Brian Nguyen <nguyenbrian@microsoft.com>, 
	Jacob Pan <panj@microsoft.com>, Allen Pais <apais@microsoft.com>, 
	Jonathan Marek <jonathan@marek.ca>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	Jeremy Linton <jeremy.linton@arm.com>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
	=?UTF-8?B?S09ORE8gS0FaVU1BKOi/keiXpCDlkoznnJ8p?= <kazuma-kondo@nec.com>, 
	Kees Cook <kees@kernel.org>, "Borislav Petkov (AMD)" <bp@alien8.de>, Yuntao Wang <ytcoode@gmail.com>, 
	Aditya Garg <gargaditya08@live.com>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 9 Dec 2024 at 18:02, Hamza Mahfooz
<hamzamahfooz@linux.microsoft.com> wrote:
>
> Hi Ard,
>
> On 12/9/24 11:40, Ard Biesheuvel wrote:
> > Hello Hamza,
> >
> > Thanks for the patch.
> >
> > On Mon, 9 Dec 2024 at 17:25, Hamza Mahfooz
> > <hamzamahfooz@linux.microsoft.com> wrote:
> >>
> >> Recent platforms
> >
> > Which platforms are you referring to here?
>
> Grace Blackwell 200 in particular.
>

Those are arm64 systems, right?

> >
> >> require more slack slots than the current value of
> >> EFI_MMAP_NR_SLACK_SLOTS, otherwise they fail to boot. So, introduce
> >> EFI_MIN_NR_MMAP_SLACK_SLOTS and EFI_MAX_NR_MMAP_SLACK_SLOTS
> >> and use them to determine a number of slots that the platform
> >> is willing to accept.
> >>
> >
> > What does 'acceptance' mean in this case?
>
> Not having allocate_pool() return EFI_BUFFER_TOO_SMALL.
>

I think you may have gotten confused here - see below

> >
> >> Cc: stable@vger.kernel.org
> >> Cc: Tyler Hicks <code@tyhicks.com>
> >> Tested-by: Brian Nguyen <nguyenbrian@microsoft.com>
> >> Tested-by: Jacob Pan <panj@microsoft.com>
> >> Reviewed-by: Allen Pais <apais@microsoft.com>
> >
> > I appreciate the effort of your colleagues, but if these
> > tested/reviewed-bys were not given on an open list, they are
> > meaningless, and I am going to drop them unless the people in question
> > reply to this thread.
> >
> >> Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
> >> ---
...
> >> diff --git a/drivers/firmware/efi/libstub/mem.c b/drivers/firmware/efi/libstub/mem.c
> >> index 4f1fa302234d..cab25183b790 100644
> >> --- a/drivers/firmware/efi/libstub/mem.c
> >> +++ b/drivers/firmware/efi/libstub/mem.c
> >> @@ -13,32 +13,47 @@
> >>   *                     configuration table
> >>   *
> >>   * Retrieve the UEFI memory map. The allocated memory leaves room for
> >> - * up to EFI_MMAP_NR_SLACK_SLOTS additional memory map entries.
> >> + * up to CONFIG_EFI_MAX_NR_MMAP_SLACK_SLOTS additional memory map entries.
> >>   *
> >>   * Return:     status code
> >>   */
> >>  efi_status_t efi_get_memory_map(struct efi_boot_memmap **map,
> >> -                               bool install_cfg_tbl)
> >> +                               bool install_cfg_tbl,
> >> +                               unsigned int *n)
> >
> > What is the purpose of 'n'? Having single letter names for function
> > parameters is not great for legibility.
> >
> >>  {
> >>         int memtype = install_cfg_tbl ? EFI_ACPI_RECLAIM_MEMORY
> >>                                       : EFI_LOADER_DATA;
> >>         efi_guid_t tbl_guid = LINUX_EFI_BOOT_MEMMAP_GUID;
> >> +       unsigned int nr = CONFIG_EFI_MIN_NR_MMAP_SLACK_SLOTS;
> >>         struct efi_boot_memmap *m, tmp;
> >>         efi_status_t status;
> >>         unsigned long size;
> >>
> >> +       BUILD_BUG_ON(!is_power_of_2(CONFIG_EFI_MIN_NR_MMAP_SLACK_SLOTS) ||
> >> +                    !is_power_of_2(CONFIG_EFI_MAX_NR_MMAP_SLACK_SLOTS) ||
> >> +                    CONFIG_EFI_MIN_NR_MMAP_SLACK_SLOTS >=
> >> +                    CONFIG_EFI_MAX_NR_MMAP_SLACK_SLOTS);
> >> +
> >>         tmp.map_size = 0;
> >>         status = efi_bs_call(get_memory_map, &tmp.map_size, NULL, &tmp.map_key,
> >>                              &tmp.desc_size, &tmp.desc_ver);
> >>         if (status != EFI_BUFFER_TOO_SMALL)
> >>                 return EFI_LOAD_ERROR;
> >>
> >> -       size = tmp.map_size + tmp.desc_size * EFI_MMAP_NR_SLACK_SLOTS;
> >> -       status = efi_bs_call(allocate_pool, memtype, sizeof(*m) + size,
> >> -                            (void **)&m);
> >> +       do {
> >> +               size = tmp.map_size + tmp.desc_size * nr;
> >> +               status = efi_bs_call(allocate_pool, memtype, sizeof(*m) + size,
> >> +                                    (void **)&m);
> >> +               nr <<= 1;
> >> +       } while (status == EFI_BUFFER_TOO_SMALL &&
> >> +                nr <= CONFIG_EFI_MAX_NR_MMAP_SLACK_SLOTS);
> >> +
> >
> > Under what circumstances would you expect AllocatePool() to return
> > EFI_BUFFER_TOO_SMALL? What is the purpose of this loop?
>
> We have observed that allocate_pool() will return EFI_BUFFER_TOO_SMALL
> if EFI_MMAP_NR_SLACK_SLOTS is less than 32. The loop is there so only
> the minimum number of extra slots are allocated.
>

But allocate_pool() *never* returns EFI_BUFFER_TOO_SMALL. It is
get_memory_map() that may return EFI_BUFFER_TOO_SMALL if the memory
map is larger than the provided buffer. In this case, allocate_pool()
needs to be called again to allocate a buffer of the appropriate size.

So the loop needs to call get_memory_map() again, but given that the
size is returned directly when the first call fails, this iterative
logic seems misguided.

I also think you might be misunderstanding the purpose of the slack
slots. They exist to reduce the likelihood that the memory map grows
more entries than can be accommodated in the buffer in cases where the
first call to ExitBootServices() fails, and GetMemoryMap() needs to be
called again; at that point, memory allocations are no longer possible
(although the UEFI spec was relaxed in this regard between 2.6 and
2.10).


> >
> > How did you test this code?
>
> I was able to successfully boot the platform with this patch applied,
> without it we need to append `efi=disable_early_pci_dma` to the kernel's
> cmdline be able to boot the system.
>

allocate_pool() never returns EFI_BUFFER_TOO_SMALL, and so your loop
executes only once. I cannot explain how this happens to fix the boot
for you, but your patch as presented is deeply flawed.

If bumping the number of slots to 32 also solves the problem, I'd
happily consider that instead,


>
> >
> >>         if (status != EFI_SUCCESS)
> >>                 return status;
> >>
> >> +       if (n)
> >> +               *n = nr;
> >> +

It seems to me that at this point, nr has been doubled after it was
used to perform the allocation, so you are returning a wrong value
here.

