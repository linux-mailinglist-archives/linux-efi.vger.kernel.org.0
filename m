Return-Path: <linux-efi+bounces-1339-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4CF91D8F4
	for <lists+linux-efi@lfdr.de>; Mon,  1 Jul 2024 09:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC41D1C20AAD
	for <lists+linux-efi@lfdr.de>; Mon,  1 Jul 2024 07:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E985C4F8BB;
	Mon,  1 Jul 2024 07:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pdKP4unF"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8013BBF0;
	Mon,  1 Jul 2024 07:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719819047; cv=none; b=EwvKGpDdB0RlpUIh672EEaB33BzSr/1K1J0/wYUrZqPAFlDlUFBR4WtuG+CYOugCuGgTnuMogEif1m3KzGEwwN9cxIyUqD4i1DA4udjMg2gdXlzwzkHlFW9gAyQjwqTHRl4ZQ6fP70vH4RoczTOORPFSgsaInBxlmITe/ZNjUWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719819047; c=relaxed/simple;
	bh=drodiIgiYnO2s+57jzo8wdNfJyEo/4DESiws+t+4NHI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F7lrT3mEvpYpEdvgCj3Wfga/LOV9SOU4gVbz4LKqyh0NSjGuytugnpDVKq2LJ9YyJa73cuPwkgat9IzPpZIwy9SWGEPFCeJEAUToXhMU74+I5rZKLjSzJrnWqerhfa795s2zlYCXpWcvyW15FozWNeLroC5sGO2rNqMGyRgSxCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pdKP4unF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5078EC4AF0A;
	Mon,  1 Jul 2024 07:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719819047;
	bh=drodiIgiYnO2s+57jzo8wdNfJyEo/4DESiws+t+4NHI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pdKP4unFdwQTKkWDlSMczEgdTBKoKpYqSl0G3geaBDG44CjWVFQYOm/RwFF1u4QLU
	 u83XB52wt612QfFMiOuq2+Lt2+WxTQQtp/5ezsBxDM/QzxZ3t/8x4/D2mPTxoTVKjr
	 HCthsIyOYEy9rbTnc+sieBYE1LOzd+UEdUbsCnabWWe5dr28p/xUDPELa3GQa482Bu
	 KpNz4nDhvzZO1yzVvqzVXqxmRE1JWpnDS7MqYwyi8F4J+jQiJJk1HZ/Y7yy338Arsc
	 GT3T6e+yDfL9Fc8+LR9vsXwVg+ya2rW2QnHZ2jO7dPbTFpmeGUR2tFi8C3NFjfeboD
	 5wIcUj5LBZziw==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2eaa89464a3so27852341fa.3;
        Mon, 01 Jul 2024 00:30:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX+fS0x2jg3sOXvtOGmynHIYD59PAtPoBZkKr3JXAwKlxe02QB6WLnlktg7tgcatCLy+RdSCuEkBb4vCcAtlPm/SViS3yhQT6tNc0SrABpV+QTaE6UW0sQq9lSd1P3b/5HHywHrqlR4
X-Gm-Message-State: AOJu0YyWra6poMKJz3hiMCwdgos23SStMoOmPtj9q3Qa6W3oZJseqFEP
	SI/Xmp8MdjiW1Zdrl/Jr2q7pow2X3j0gjxD57XNsFkFP9Fdit8wh23lMdFFqvEk6hmdzMogY/PC
	axRISUdf3R9JJMmxJbpvApKlgknQ=
X-Google-Smtp-Source: AGHT+IEzeM7h60JTZVY17l/NAbDgncLQwTcnVey92w5fkczN4E6zz38U5jWgpR3TYqr1XOWjwjZrbbmXJSDZ1q9pB2o=
X-Received: by 2002:a2e:96d4:0:b0:2ec:500c:b2de with SMTP id
 38308e7fff4ca-2ee5e38122dmr25862601fa.7.1719819045518; Mon, 01 Jul 2024
 00:30:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <75C90B50-9AB9-4F0A-B2CD-43427354D15C@live.com>
 <ZoJAAifMqIDXdniv@wunner.de> <CAMj1kXH3fvS259Y1mfYcKQbM2mUYbSfuf2ZiMXfFhjq-rzn5UA@mail.gmail.com>
 <ZoJDuunseVIDua-m@wunner.de> <CAMj1kXFKBsAXDLxinqiszH=6hEOjbJQL-nFgBsBceta4rUCN-w@mail.gmail.com>
 <ZoJPgSlZJ3ZlU2zL@wunner.de>
In-Reply-To: <ZoJPgSlZJ3ZlU2zL@wunner.de>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 1 Jul 2024 09:30:34 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHR+mCR5eibj23S26-PN6yLPD1uf9+H2fEEDhNWOh6TjA@mail.gmail.com>
Message-ID: <CAMj1kXHR+mCR5eibj23S26-PN6yLPD1uf9+H2fEEDhNWOh6TjA@mail.gmail.com>
Subject: Re: [PATCH v2] efi: libstub: add support for the apple_set_os protocol
To: Lukas Wunner <lukas@wunner.de>
Cc: Aditya Garg <gargaditya08@live.com>, Hans de Goede <hdegoede@redhat.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	"linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>, Kerem Karabay <kekrby@gmail.com>, 
	Orlando Chamberlain <orlandoch.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 1 Jul 2024 at 08:41, Lukas Wunner <lukas@wunner.de> wrote:
>
> On Mon, Jul 01, 2024 at 07:56:04AM +0200, Ard Biesheuvel wrote:
> > On Mon, 1 Jul 2024 at 07:50, Lukas Wunner <lukas@wunner.de> wrote:
> > > On Mon, Jul 01, 2024 at 07:38:38AM +0200, Ard Biesheuvel wrote:
> > > > Any thoughts on whether this should depend on CONFIG_APPLE_GMUX or not?
> > >
> > > I tend towards *not* making it depend on CONFIG_APPLE_GMUX:
> > >
...
> > > * apple_set_os() has side effects beyond exposing the iGPU (such as
> > >   switching the keyboard+trackpad access method to SPI instead of USB).
> > >   If there are issues, they will be harder to debug if their occurrence
> > >   depends on a Kconfig option.
> >
...
> > Is the latter side effect
> > likely to cause any regressions on Intel Mac users that don't have two
> > GPUs to begin with?
>
> MacBook Air models introduced 2013/2014 will use SPI instead of USB
> to access the keyboard and trackpad.  And from a quick look, the
> applespi_tp_models[] array in drivers/input/keyboard/applespi.c
> seems to be missing the trackpad dimensions of those models.
> The driver may also need a quirk to work around missing properties
> in the DSDT on those models.  Back in 2018 someone tested apple_set_os()
> on such a machine and reported these issues, but the GitHub discussion
> to narrow them down and fix them fizzled out:
>
> https://github.com/cb22/macbook12-spi-driver/issues/65
>
> The problem is that users of such models will generally run a
> distribution kernel which has CONFIG_APPLE_GMUX enabled,
> so constraining apple_set_os() to CONFIG_APPLE_GMUX won't help them.
> Also, there is no incentive to amend the applespi.c driver for
> affected machines if apple_set_os() is never called on them,
> which is regrettable.
>
> Another potential regression is that exposing the iGPU may consume
> more power.  Or maybe the i915 driver will autosuspend if the panel
> is not connected, I don't know.  Likewise there is no incentive to
> fix the issue if apple_set_os() is never run.
>
> I've also heard rumors that the EFI firmware configures different
> CPU frequency scaling parameters if apple_set_os() is called,
> but maybe Linux overwrites them anyway.  Apple never cared for Linux,
> so apple_set_os() basically just differentiates between macOS and
> Windows (via Boot Camp).  We generally choose to masquerade as macOS
> to get access to the full set of hardware features, not the crippled
> setup exposed to Windows.
>
> If you think that we absolutely need to avoid these potential regressions,
> a better approach than constraining to CONFIG_APPLE_GMUX would be to
> match DMI data for dual-GPU MacBook Pros.  I notice that the efistub
> has been amended with SMBIOS support through efi_get_smbios_record() +
> efi_get_smbios_string().  Would that get us to the laptop model name?
> If so that would seem to be a viable way to avoid or at least minimize
> regressions.
>

DMI matching would be a nice way to apply this change only to systems
that have a need for it, without manual intervention via a command
line switch.

Assuming that Intel Macs implement the EFI SMBIOS protocol, reusing
the existing pieces should be rather straight-forward. Something like
the below should work in that case (whitespace damage courtesy of
gmail)

Note that the smbios.c  libstub source file needs some changes to
build correctly for x86 with CONFIG_EFI_MIXED=y, but I can take care
of that.



diff --git a/drivers/firmware/efi/libstub/x86-stub.c
b/drivers/firmware/efi/libstub/x86-stub.c
index 250c964e93ee..826756c02657 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -225,12 +225,39 @@ static void
retrieve_apple_device_properties(struct boot_params *boot_params)
        }
 }

+static bool apple_match_product_name(void)
+{
+       static const char type1_matches[][16] = {
+               "MacBookPro16,1",
+       };
+       const struct efi_smbios_type1_record *record;
+       const u8 *product;
+
+       record = (struct efi_smbios_type1_record *)efi_get_smbios_record(1);
+       if (!record)
+               return false;
+
+       product = efi_get_smbios_string(&record->header, 1, product_name);
+       if (!product)
+               return false;
+
+       for (int i = 0; i < ARRAY_SIZE(type1_matches); i++) {
+               if (!strcmp(product, type1_matches[i]))
+                       return true;
+       }
+
+       return false;
+}
+
 static void apple_set_os(void)
 {
        efi_guid_t guid = APPLE_SET_OS_PROTOCOL_GUID;
        apple_set_os_protocol_t *set_os;
        efi_status_t status;

+       if (!apple_match_product_name())
+               return;
+
        status = efi_bs_call(locate_protocol, &guid, NULL, (void **)&set_os);
        if (status != EFI_SUCCESS)
                return;

