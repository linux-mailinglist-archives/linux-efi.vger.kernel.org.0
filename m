Return-Path: <linux-efi+bounces-3474-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A21A9F3E2
	for <lists+linux-efi@lfdr.de>; Mon, 28 Apr 2025 16:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCBAE3B61B1
	for <lists+linux-efi@lfdr.de>; Mon, 28 Apr 2025 14:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9918C26FDAC;
	Mon, 28 Apr 2025 14:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jAap7sky"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD9E26FDA6;
	Mon, 28 Apr 2025 14:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745852112; cv=none; b=hH+PK+vSgNAV7Q+MWXLOeWwi+2VXX6kljc7CgwEf+qe++ywKTrwAKlf9aVFAYlgCGTpHv4aftRBXCW1SM3jXtDum4j3meoRw1+hMNDh9yPGPVz/lKwyewQ3WuNs5kUCWNNFTlGgztSARXcSxEEO45BzOKFivn+TidXGEKPu64Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745852112; c=relaxed/simple;
	bh=9Jq7uWikQpL0uRpCQ1qFYLXIjMg8lm3oJ+erYCU9968=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oS5MwtHpK+YY7YpMPP5OCURbJX/QucneY3aHkQO5tv5uP9EZy7qbZWKB11uTRilICElCXCXy+thAleAGJTHXZhvqZmSFTKN0Y3LHCkNTTTYdoA0qAvTfJu64jAVHabkJOIFDl1s3l9RtYMg19mdHiKR4yPi6VH8Gf5/lb7Upswg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jAap7sky; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA22FC4CEF4;
	Mon, 28 Apr 2025 14:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745852111;
	bh=9Jq7uWikQpL0uRpCQ1qFYLXIjMg8lm3oJ+erYCU9968=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jAap7skyAlGFiLpb57TXN+/kIeoRpTftjYS3enOzBlGUOyAt1bmzrv7dFty08GEuz
	 98CPuc5dQJbNLjwOU89n73GBxAaWj8v3aBG5+0uRaFKtgDe/be3+CxCdRmBGc/IIgR
	 ZjnZKAYzh2f3AfLzo5jW+VZ2+ShjKHeIcDfUx17J8RGvXoQIA+9TbHjTfrPrB33m3r
	 eeUPfduU9Ge+HPKmoqwuTd/g29AK48pr0KkTGZ16h+fO8UV6XGD/CQogPBrhElgNcm
	 hPIKbZqDzvuz5MQnhZMhClVxOrtQ3T66P/aOuU2zZAoJbM1Rpq6ZpQ7dk2nGN3ud8q
	 0Vo6s+n04Fqig==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-54b0d638e86so5750850e87.1;
        Mon, 28 Apr 2025 07:55:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU9SKn5Dcy9y0o3wKmGuO47rwyG9etNvRwCQm0RhXt50jv4FZ5ATztTlaFlPgJd7bU1QCfvZwBSZdHSgIE6@vger.kernel.org, AJvYcCVgFfu21W/XBZPD+A8tNva29ZbKZU7RRsBG0w2q3GOGVLBBQkcrvzl+K6ue/DizP1r7BaEsF6HcZBk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyuFbEfQJBkg3TVInK6sCrwFkw8g98UJnIxYZP9N0LPDAmgwoL
	BwxwBUlAe7vmslTKdFKyTIGUvDEKD92wZpjPT1m4WrTeeSCIOfhmmUhTQ5eeFaVigyUCY9JH8nG
	uQK+y7sFYjzhtuXHgub2fCMTQR9w=
X-Google-Smtp-Source: AGHT+IE7E128Zkj3xoJnEZVs+V1aV5QAmc6QTNjYjWzAyc+K0lgjhcOYXIXGCrzLG1sgZUsRpuGu3jJ/McaAmNF+/3U=
X-Received: by 2002:a05:6512:130c:b0:549:8cc8:efed with SMTP id
 2adb3069b0e04-54e900113cemr2442912e87.48.1745852110119; Mon, 28 Apr 2025
 07:55:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250424080950.289864-1-vkuznets@redhat.com> <20250424080950.289864-2-vkuznets@redhat.com>
 <CAMj1kXHqmOiNX_DH+8uSsTROzR+hgvZ5DyE=3wVE7-dQ+2BW=Q@mail.gmail.com> <87o6wga74s.fsf@redhat.com>
In-Reply-To: <87o6wga74s.fsf@redhat.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 28 Apr 2025 16:54:59 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEFXCjHXrAS2Xe_3xVvkkV6QYsuxcOmLEk-A2KNHUJ7ZA@mail.gmail.com>
X-Gm-Features: ATxdqUFymFSwi64yQhO8AHjWP8hjRlF2jJwWQ1HlRXbUcVyIkRCEXSZB9saruI0
Message-ID: <CAMj1kXEFXCjHXrAS2Xe_3xVvkkV6QYsuxcOmLEk-A2KNHUJ7ZA@mail.gmail.com>
Subject: Re: [PATCH 1/2] efi/libstub: zboot specific mechanism for embedding
 SBAT section
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: x86@kernel.org, linux-efi@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Peter Jones <pjones@redhat.com>, Daniel Berrange <berrange@redhat.com>, 
	Emanuele Giuseppe Esposito <eesposit@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
	Greg KH <gregkh@linuxfoundation.org>, Luca Boccassi <bluca@debian.org>, 
	Peter Zijlstra <peterz@infradead.org>, Matthew Garrett <mjg59@srcf.ucam.org>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 28 Apr 2025 at 12:54, Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>
> Ard Biesheuvel <ardb@kernel.org> writes:
>
> > Hi Vitaly,
> >
>
> Ard, thanks for the review!
>
> > On Thu, 24 Apr 2025 at 10:10, Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
> >>
> >> SBAT is a mechanism which improves SecureBoot revocations of UEFI binaries
> >> by introducing a generation-based technique. Compromised or vulnerable UEFI
> >> binaries can be prevented from booting by bumping the minimal required
> >> generation for the specific component in the bootloader. More information
> >> on the SBAT can be obtained here:
> >>
> >> https://github.com/rhboot/shim/blob/main/SBAT.md
> >>
> >> Upstream Linux kernel does not currently participate in any way in SBAT as
> >> there's no existing policy in how SBAT generation number should be
> >> defined. Keep the status quo and provide a mechanism for distro vendors and
> >> anyone else who signs their kernel for SecureBoot to include their own SBAT
> >> data. This leaves the decision on the policy to the vendor. Basically, each
> >> distro implementing SecureBoot today, will have an option to inject their
> >> own SBAT data during kernel build and before it gets signed by their
> >> SecureBoot CA. Different distro do not need to agree on the common SBAT
> >> component names or generation numbers as each distro ships its own 'shim'
> >> with their own 'vendor_cert'/'vendor_db'
> >>
> >> Implement support for embedding SBAT data for architectures using
> >> zboot (arm64, loongarch, riscv). Build '.sbat' section along with libstub
> >> so it can be reused by x86 implementation later.
> >>
> >> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> >> ---
> >>  drivers/firmware/efi/Kconfig                | 25 +++++++++++++++++++++
> >>  drivers/firmware/efi/libstub/Makefile       |  7 ++++++
> >>  drivers/firmware/efi/libstub/Makefile.zboot |  3 ++-
> >>  drivers/firmware/efi/libstub/sbat.S         |  7 ++++++
> >>  drivers/firmware/efi/libstub/zboot-header.S | 14 ++++++++++++
> >>  drivers/firmware/efi/libstub/zboot.lds      | 17 ++++++++++++++
> >>  6 files changed, 72 insertions(+), 1 deletion(-)
> >>  create mode 100644 drivers/firmware/efi/libstub/sbat.S
> >>
> >> diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
> >> index 5fe61b9ab5f9..2edb0167ba49 100644
> >> --- a/drivers/firmware/efi/Kconfig
> >> +++ b/drivers/firmware/efi/Kconfig
> >> @@ -281,6 +281,31 @@ config EFI_EMBEDDED_FIRMWARE
> >>         bool
> >>         select CRYPTO_LIB_SHA256
> >>
> >> +config EFI_SBAT
> >> +       bool "Embed SBAT section in the kernel"
> >> +       depends on EFI_ZBOOT
> >> +       help
> >> +         SBAT section provides a way to improve SecureBoot revocations of UEFI
> >> +         binaries by introducing a generation-based mechanism. With SBAT, older
> >> +         UEFI binaries can be prevented from booting by bumping the minimal
> >> +         required generation for the specific component in the bootloader.
> >> +
> >> +         Note: SBAT information is distribution specific, i.e. the owner of the
> >> +         signing SecureBoot certificate must define the SBAT policy. Linux
> >> +         kernel upstream does not define SBAT components and their generations.
> >> +
> >> +         See https://github.com/rhboot/shim/blob/main/SBAT.md for the additional
> >> +         details.
> >> +
> >> +         If unsure, say N.
> >> +
> >> +config EFI_SBAT_FILE
> >> +       string "Embedded SBAT section file path"
> >> +       depends on EFI_SBAT
> >> +       help
> >> +         Specify a file with SBAT data which is going to be embedded as '.sbat'
> >> +         section into the kernel.
> >> +
> >
> > Can we simplify this? CONFIG_EFI_SBAT makes no sense if
> > CONFIG_EFI_SBAT_FILE is left empty. If you really need both symbols,
> > set EFI_SBAT automatically based on whether EFI_SBAT_FILE is
> > non-empty.
>
> Sure, but FWIW, I modelled this after MODULE_SIG/MODULE_SIG_KEY and
> BOOT_CONFIG_EMBED/BOOT_CONFIG_EMBED_FILE where the selection is also
> 2-step -- do you think EFI_SBAT/EFI_SBAT_FILE case is different?
>

Regardless of the other cases,it at the very least should be a
config-time error for EFI_SBAT to be y when EFI_SBAT_FILE is empty. We
shouldn't have to deal with CONFIG_ options being in an inconsistent
state, that's Kconfig's job.

> >
> >>  endmenu
> >>
> >>  config UEFI_CPER
> >> diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
> >> index d23a1b9fed75..5113cbdadf9a 100644
> >> --- a/drivers/firmware/efi/libstub/Makefile
> >> +++ b/drivers/firmware/efi/libstub/Makefile
> >> @@ -105,6 +105,13 @@ lib-$(CONFIG_UNACCEPTED_MEMORY) += unaccepted_memory.o bitmap.o find.o
> >>  extra-y                                := $(lib-y)
> >>  lib-y                          := $(patsubst %.o,%.stub.o,$(lib-y))
> >>
> >> +extra-$(CONFIG_EFI_SBAT)       += sbat.o
> >> +$(obj)/sbat.o: $(obj)/sbat.bin
> >> +targets += sbat.bin
> >> +filechk_sbat.bin = cat $(or $(real-prereqs), /dev/null)
> >> +$(obj)/sbat.bin: $(CONFIG_EFI_SBAT_FILE) FORCE
> >> +       $(call filechk,sbat.bin)
> >> +
> >
> > Please get rid of all of this, and move the .incbin into
> > zboot-header.S
>
> The main prupose of this logic is to track possible sbat data
> changes. E.g. if the file with SBAT data has changed, then we need to
> rebuild the kernel binary. If we just use a raw 'incbin' somewhere and
> don't add a specific Makefile dependency, then the logic will be lost.
>

So why isn't it sufficient to make zboot-header.o depend on
$(CONFIG_EFI_SBAT_FILE)?

> I think I can drop the dedicated 'sbat.S' and use zboot-header.S but I'd
> like to keep at least the 'filechk' part: we compare what's in
> EFI_SBAT_FILE with 'sbat.bin' copy and, if things have changed, rebuild.
>

The filechk is just a copy, and the /dev/null hack should be removed
too. So please find another way to track the dependency, and drop all
of this.

