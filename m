Return-Path: <linux-efi+bounces-879-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C7888AB7D
	for <lists+linux-efi@lfdr.de>; Mon, 25 Mar 2024 18:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A386B33D3F
	for <lists+linux-efi@lfdr.de>; Mon, 25 Mar 2024 15:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3553E14EC64;
	Mon, 25 Mar 2024 13:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pp5dXZro"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0287486AD2;
	Mon, 25 Mar 2024 13:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711372943; cv=none; b=T6bGBlepzj5hR/wQWEcGrdo9t2T3S9T87erPVVIYBIWpXMRcXS7HgePxB1bTxWfbQ2If/rFWhaL0rOjuh9AYogkwN4gB9gaOPwXtwD7kvnd+YT3UFvmMmRwFyIAFz3uzflam71PmjckdDZkP/OEwf7H/HSnT3HYsnuDVxrjPYjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711372943; c=relaxed/simple;
	bh=gDfNLDwNK3vhReU1Xjnf+yFbmbGIUtPObU0OoBUTG4Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=px3pfqj8EPLJWpuWfITl9zJkV6TwJ23/ovuuQXmV0PGUsmKw+/MLOim1KyjyZDdm6iCmFOQ016GgZj/OagJcb4zWl8yq5nNM6sRq5olYUgNGmOuj/kSP7fIJrpDa7jOx8DRimWMwbe87r27FAQlb1jz17dI0OKSE7dC6SwHDwdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pp5dXZro; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8715AC43394;
	Mon, 25 Mar 2024 13:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711372942;
	bh=gDfNLDwNK3vhReU1Xjnf+yFbmbGIUtPObU0OoBUTG4Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Pp5dXZroXxSbf4pol9a4BzttJLuVe9BAfmgtcdZtZz3BVvUzcSjRuSqXZHRlVjyxg
	 qoLEAgcg+RD8wLQpDiHVr9zKlNWCUi6KI+8GO/v+HOR+7SSIoLjYmx6OaqjJDUgOfe
	 dk9Dr55aRY6c8474Gpfm5fd7W9OILkcSXK84sV8Fwqy45Y2i1W4clhbpymWnqqh2id
	 guhzbmJsO4Coiu9vrXS0T9n8298wFdc1De4+WmYyRuAOaVbY2IvdEpS3idmXcKWfAe
	 TetAcUAp/8prFR6LqEeOZXD9uB/FxW8aacPs2fW/ri+gmDpTZEEmeYqQmeMxMW/5a/
	 /YqS585xnQOdw==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d485886545so76098931fa.2;
        Mon, 25 Mar 2024 06:22:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU83LnaqHmbBsltCxO1VvVfc2nUSqYHdQe2mX7VyL36XQcC+2oVlR3wZ85uO6vYl4LQyX95UYFT4sPsqeGVRWyntabPckdx0dmGV/753AMuaCp2RbY7pir+1LpjpzaMwmY6bHpVzoIW
X-Gm-Message-State: AOJu0YwKTLdmrAvelSq5RjNna1NYvRvGr0HSErVrogwAFGkDpscqosWq
	+aNWiTs5/l3b6mz2VMfw4DZhzNCNBW7I2E7HO/C0D2SJUDoQ0i/ARYgaig/PzecDxMyDV27DWfE
	GhA7OAdTnY3mcTeTwVvvT7CSxj4M=
X-Google-Smtp-Source: AGHT+IHbwlCR0xnsvrPhdmqdgYKGDz+lSxSom3pLFlGrH48RY2bQ3M8ItlHq7AKTtg7FXY0khuaqj6z/hfAWLNTfAjw=
X-Received: by 2002:a05:651c:1501:b0:2d4:707d:8b3c with SMTP id
 e1-20020a05651c150100b002d4707d8b3cmr7428132ljf.18.1711372940882; Mon, 25 Mar
 2024 06:22:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325083905.13163-2-ardb+git@google.com> <5b32b8c8-0a1b-44cf-aedf-cca1d6c83bd8@redhat.com>
In-Reply-To: <5b32b8c8-0a1b-44cf-aedf-cca1d6c83bd8@redhat.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 25 Mar 2024 15:22:09 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEHt-UP2MWc_-jBzf22vqhFr2QykwrGwEeYAk2WSkY4Zg@mail.gmail.com>
Message-ID: <CAMj1kXEHt-UP2MWc_-jBzf22vqhFr2QykwrGwEeYAk2WSkY4Zg@mail.gmail.com>
Subject: Re: [PATCH] x86/efistub: Add missing boot_params for mixed mode
 compat entry
To: Hans de Goede <hdegoede@redhat.com>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Clayton Craft <clayton@craftyguy.net>
Content-Type: text/plain; charset="UTF-8"

On Mon, 25 Mar 2024 at 15:18, Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 3/25/24 9:39 AM, Ard Biesheuvel wrote:
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > The native EFI stub entry point does not take a struct boot_params from
> > the boot loader, but creates it from scratch, and populates only the
> > fields that still have meaning in this context (command line, initrd
> > base and size, etc)
> >
> > The original mixed mode implementation used the EFI handover protocol,
> > where the boot loader (i.e., GRUB) populates a struct boot_params and
> > passes it to a special EFI entry point that takes the struct boot_params
> > pointer as the third argument.
> >
> > When the new mixed mode implementation was introduced, using a special
> > 32-bit PE entrypoint in the 64-bit kernel, it adopted the usual
> > prototype, and relied on the EFI stub to create the struct boot_params
> > as usual. This is preferred because it makes the bootloader side much
> > easier to implement, as it does not need any x86-specific knowledge on
> > how struct boot_params and struct setup_header are put together.
> >
> > However, one thing was missed: EFI mixed mode goes through startup_32()
> > *before* entering the 64-bit EFI stub, which is difficult to avoid given
> > that 64-bit execution requires page tables, which can only be populated
> > using 32-bit code, and this piece is what the mixed mode EFI stub relies
> > on. startup_32() accesses a couple of struct boot_params fields to
> > decide where to place the page tables.
> >
> > startup_32() turns out to be quite tolerant to bogus struct boot_params,
> > given that ESI used to contain junk when entering via the new mixed mode
> > protocol. Only when commit
> >
> >   e2ab9eab324c ("x86/boot/compressed: Move 32-bit entrypoint code into .text section")
> >
> > started to zero ESI explicitly when entering via this boot path, boot
> > failures started to appear on some systems, presumably ones that unmap
> > page 0x0 or map it read-only.
> >
> > The solution is to pass a special, temporary struct boot_params to
> > startup_32() via ESI, one that is sufficient for getting it to create
> > the page tables correctly and is discarded right after. This means
> > setting a minimal alignment of 4k, only to get the statically allocated
> > page tables line up correctly, and setting init_size to the executable
> > image size (_end - startup_32). This ensures that the page tables are
> > covered by the static footprint of the PE image.
> >
> > Given that EFI boot no longer calls the decompressor and no longer pads
> > the image to permit the decompressor to execute in place, the same
> > temporary struct boot_params should be used in the EFI handover protocol
> > based mixed mode implementation as well, to prevent the page tables from
> > being placed outside of allocated memory.
> >
> > Cc: Hans de Goede <hdegoede@redhat.com>
> > Fixes: e2ab9eab324c ("x86/boot/compressed: Move 32-bit entrypoint code into .text section")
> > Closes: https://lore.kernel.org/all/20240321150510.GI8211@craftyguy.net/
> > Reported-by: Clayton Craft <clayton@craftyguy.net>
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>
> I have given this a test run (on top of 6.9-rc1) on one of my
> Bay Trail mixed mode tablets and the tablet still boots fine:
>
> Tested-by: Hans de Goede <hdegoede@redhat.com>
>

Many thanks Hans.

