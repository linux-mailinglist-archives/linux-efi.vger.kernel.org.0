Return-Path: <linux-efi+bounces-1881-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A19298E126
	for <lists+linux-efi@lfdr.de>; Wed,  2 Oct 2024 18:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D0A31C21A5D
	for <lists+linux-efi@lfdr.de>; Wed,  2 Oct 2024 16:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E76C1CF7C0;
	Wed,  2 Oct 2024 16:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t6/bfoXU"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A9C38DF9;
	Wed,  2 Oct 2024 16:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727887565; cv=none; b=lISyq4lt/cpoSAdwzFBZqF7zb2pGlqkjcSm1X+dN6LIN6cD3e23sklGCW4kFG9KW9lp8Fb11zWhCXC3uCSVvyzUcBNkBNg+PHF1xTf53YgXzL+X786BcAaPmpp0eZwPiPwAKnS2qAauR5B8bWxCqn6Cr+QmTPlZAGfXhLgr5jIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727887565; c=relaxed/simple;
	bh=U6cB3SCcCVusD45xX8BtIzwgINgwV2wQbTjUwpwDe40=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TrLGR4jbFfrnFcqU+xUMjIPiqLNLCrD181eR1J8hy/pT0qkui7Gn91TjpsH3A0q28Al161+nygOwCLHsAdKjhbuLbSRAgDqYTGIZTwLBJ4DKlnXd/rUcwx2CmR76hqzjyo8kYCLyc/iv/RDg8XyLS84jldu4P4ekU141kk9AxRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t6/bfoXU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E567AC4CEC2;
	Wed,  2 Oct 2024 16:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727887564;
	bh=U6cB3SCcCVusD45xX8BtIzwgINgwV2wQbTjUwpwDe40=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=t6/bfoXU1n0Dt/981w+nOpXOxv37lRyVoSpR8IFkneCkdrN1OQ9+Qz3QgYJzQESvU
	 S5RbvDS02w2Vu7oGUPTZKMJ6hWPDBCcfVU4WrMdXYzKnhq6zQqKfqy4+rJ1qBNpyao
	 Ueqr7iegG1icdvT6nyo8EBSQGuWlGELPxdrtSGnZZiqRcEb6uJEvs3966nd//RsgZ1
	 GposXHky61ic+6KLuqfcENpQE3hMicdehJoH2wZJdBER2ItgVgjlnttHxTulbiKitD
	 C+bsF8ulta/qrztBFNlGuTp3HSHVRfm+77eWOPFtfDX3XjYgg67EEHvj0fmk1Tyj8r
	 eguafqhQ54A6g==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2facf48157dso41158011fa.2;
        Wed, 02 Oct 2024 09:46:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUyapK42nDmLbCTdMvF+TNInV811F9uBJb1nuAHqo4+WiwAix3kDZyIPhgy8Y5byznDin0Amh1T9BI=@vger.kernel.org, AJvYcCWhdTn/n6DEuvAGJfUbymGN5iVgOq85cJsTHsfkl6NGV0E2p6fax3/Nv7M+9WQrVi6pJGgpV7We/039s7Hl@vger.kernel.org
X-Gm-Message-State: AOJu0YyIeWDn1sSJG6w7WPTQE/Yy7Q00xgDRJd6FdgfeIuzp0xU8RgaU
	xCoa03saU+uSXnXZYvWSN8+QOsQCEFNxUtWmIfCPXfqFVTFZV3mfK81Ugypb0OzaFxFa02nCf6U
	58mH6eaokfEpzYnuC8hl8dapqTV0=
X-Google-Smtp-Source: AGHT+IFkJ6pAbg5mH1tXxCVw5ypYt5vF2UOZT6HmK/hZVjrPvu6VsfuR0ZsdBnqWojlwIg8wxD7XDMcXafFnoLUThYE=
X-Received: by 2002:a05:651c:b25:b0:2f7:90b8:644e with SMTP id
 38308e7fff4ca-2fae0fffc60mr28540961fa.1.1727887563162; Wed, 02 Oct 2024
 09:46:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001032028.483199-1-jeremy.linton@arm.com>
 <CAMj1kXEwsB2JZeE451Qf=tad7mapWATu_-ty+r7fcMTcxQ=StQ@mail.gmail.com>
 <CAC_iWjJH8JwdPbL9Et6xNLf4vV1AQDm8ZZh8zYVkb+VFLXedTg@mail.gmail.com>
 <0bed3801-47c0-439a-8b46-53c2704e9bb0@arm.com> <CAC_iWjLo3j73J1x1Bw01szxN4uHUU+tPstWkYk3=+7t7DziHpw@mail.gmail.com>
In-Reply-To: <CAC_iWjLo3j73J1x1Bw01szxN4uHUU+tPstWkYk3=+7t7DziHpw@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 2 Oct 2024 18:45:51 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHu_8Ffjznq=-9o2PCquDyoKQ8_aTHDnoGhGopgr_NUKQ@mail.gmail.com>
Message-ID: <CAMj1kXHu_8Ffjznq=-9o2PCquDyoKQ8_aTHDnoGhGopgr_NUKQ@mail.gmail.com>
Subject: Re: [PATCH] efi/libstub: measure initrd to PCR9 independent of source
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jeremy Linton <jeremy.linton@arm.com>, linux-efi@vger.kernel.org, bp@alien8.de, 
	sathyanarayanan.kuppuswamy@linux.intel.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 2 Oct 2024 at 18:36, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Jeremy,
>
> On Wed, 2 Oct 2024 at 18:37, Jeremy Linton <jeremy.linton@arm.com> wrote:
> >
> > Hi,
> >
> > On 10/1/24 2:19 AM, Ilias Apalodimas wrote:
> > > Thanks, Ard
> > >
> > > On Tue, 1 Oct 2024 at 08:59, Ard Biesheuvel <ardb@kernel.org> wrote:
> > >>
> > >> (cc Ilias)
> > >>
> > >> On Tue, 1 Oct 2024 at 05:20, Jeremy Linton <jeremy.linton@arm.com> wrote:
> > >>>
> > >>> Currently the initrd is only measured if it can be loaded using the
> > >>> INITRD_MEDIA_GUID, if we are loading it from a path provided via the
> > >>> command line it is never measured. Lets move the check down a couple
> > >>> lines so the measurement happens independent of the source.
> > >>>
> > >>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> > >>> ---
> > >>>   drivers/firmware/efi/libstub/efi-stub-helper.c | 9 +++++----
> > >>>   1 file changed, 5 insertions(+), 4 deletions(-)
> > >>>
> > >>> diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
> > >>> index de659f6a815f..555f84287f0b 100644
> > >>> --- a/drivers/firmware/efi/libstub/efi-stub-helper.c
> > >>> +++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
> > >>> @@ -621,10 +621,6 @@ efi_status_t efi_load_initrd(efi_loaded_image_t *image,
> > >>>          status = efi_load_initrd_dev_path(&initrd, hard_limit);
> > >>>          if (status == EFI_SUCCESS) {
> > >>>                  efi_info("Loaded initrd from LINUX_EFI_INITRD_MEDIA_GUID device path\n");
> > >>> -               if (initrd.size > 0 &&
> > >>> -                   efi_measure_tagged_event(initrd.base, initrd.size,
> > >>> -                                            EFISTUB_EVT_INITRD) == EFI_SUCCESS)
> > >>> -                       efi_info("Measured initrd data into PCR 9\n");
> > >>>          } else if (status == EFI_NOT_FOUND) {
> > >>>                  status = efi_load_initrd_cmdline(image, &initrd, soft_limit,
> > >>>                                                   hard_limit);
> > >>> @@ -637,6 +633,11 @@ efi_status_t efi_load_initrd(efi_loaded_image_t *image,
> > >>>          if (status != EFI_SUCCESS)
> > >>>                  goto failed;
> > >>>
> > >>> +       if (initrd.size > 0 &&
> > >>> +           efi_measure_tagged_event(initrd.base, initrd.size,
> > >>> +                                    EFISTUB_EVT_INITRD) == EFI_SUCCESS)
> > >>> +               efi_info("Measured initrd data into PCR 9\n");
> > >
> > > Back when we added this we intentionally left loading an initramfs
> > > loaded via the command line out.
> > > We wanted people to start using the LoadFile2 protocol instead of the
> > > command line option, which suffered from various issues  -- e.g could
> > > only be loaded if it resided in the same filesystem as the kernel and
> > > the bootloader had to reason about the kernel memory layout.
> > > I don't think measuring the command line option as well is going to
> > > cause any problems, but isn't it a step backward?
> >
> > Thanks for looking at this. Since no one else seems to have commented, I
> > will just express IMHO, that both methods are useful in differing
> > circumstances.
> >
> > For a heavyweight Linux aware bootloader like grub/sd-boot the
> > INITRD_MEDIA_GUID is obviously preferred. But, for booting strictly out
> > out of a pure UEFI environment or Linux unaware bootloader (ex: UEFI
> > shell),
>
> I am not sure I am following on the EfiShell. It has to run from an
> EFI firmware somehow. The two open-source options I am aware of are
> U-Boot and EDK2.
> U-Boot has full support for the LoadFile2 protocol (and the
> INITRD_MEDIA_GUID). In fact, you can add the initramfs/dtb/kernel
> triplets as your boot options, supported by the EfiBoot manager and
> you don't need grub/systemd boot etc.
>
> I don't think you can do that from EDK2 -- encode the initrd in a boot
> option, but you can configure the initramfs to be loaded via LoadFile2
> in OMVF via the 'initrd' shell command.
>
> > the commandline based initrd loader is a useful function.
> > Because, the kernel stub should continue to serve as a complete, if
> > minimal implementation for booting Linux out of a pure UEFI environment
> > without additional support infrastructure (shim/grub/etc). So, it seems
> > that unless there is a reason for divergent behavior it shouldn't exist.
> > And at the moment, the two primary linux bootloaders grub2 and sdboot
> > are both using the INITRD_MEDIA_GUID. Given the battering ram has been
> > successful, it isn't a step backward.
>
> I am not saying we shouldn't. As I said I don't think this patch
> breaks anything. I am just wondering if enhancing EDK2 to load the
> initramfs via LoadFile2 for more than OVMF is a better option.
>

My original intent was to phase out initrd= entirely, because it only
worked with the block device that the kernel image was loaded from,
and it didn't work with mixed mode.

However, both issues have been fixed:
- you can pass initrd=<device path> and if the destination supports
file I/O, it will be used to load the initrd (provided that your
firmware has the TextToDevicePath protocol too, as that will be used
to convert the provided string into something the firmware
understands);
- while mixed mode is a hack that should disappear over time, it now
does support initrd= too.

Even though LoadFile2 is still preferred as it is simpler and
unambiguous, I no longer see a reason to phase out initrd=.

So I think this change is reasonable.

