Return-Path: <linux-efi+bounces-3475-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4D8A9F434
	for <lists+linux-efi@lfdr.de>; Mon, 28 Apr 2025 17:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B32E44619B1
	for <lists+linux-efi@lfdr.de>; Mon, 28 Apr 2025 15:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1291026D4FC;
	Mon, 28 Apr 2025 15:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mo5Tc46w"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0D226A1AF;
	Mon, 28 Apr 2025 15:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745853385; cv=none; b=aon3mAl2/IORqPk9JUhjTncmNYEJiJ3W7gbDN1c1TQnvbgpHvJJgo6pRusGzKEarKEyziBlehfHNs0m/U1c4/RXhkt04z4Jrrb8WqtqkwMo37EkzSifts21iK+8rsxwmqAyNCMq43cvmAGni3wq9kCZGPgVzd1WpYpvddj28t6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745853385; c=relaxed/simple;
	bh=fkZcg4Wkqkc+9VzWMv4uHceYiUz18/bJxftEEFimOr8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PwPAX4vlcKKsZG6Fc0QvIj0wqy+oJjyelStThl7q7pp7rxI5ugDs30lew92EDzdK6OSlEIdw8TAEijlmbh+TbEzq95gsgg5JfMXmhXGdjkqCsqKc5slCpGqWtVNjPUZGreA0YQzAtLwEznnfqeeTuFPNou7lkPnC/ptmgWUKOAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mo5Tc46w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57F50C4CEEE;
	Mon, 28 Apr 2025 15:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745853384;
	bh=fkZcg4Wkqkc+9VzWMv4uHceYiUz18/bJxftEEFimOr8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mo5Tc46wW/za8v/Lv55sM1x/J+/NtKXmaq6CSnXSw/gbmkhHkAbRv7d65lzfyePoT
	 qeDfm0u2+4HYtI2czU8a2apJ+YgNNzi1newfndnBCFWxbfN+2rWR02NHzaHj/KTv76
	 CUhXpc2utnIQTwfzXiBRtKoQ0hnVld86tWj0E1sF2YkZwfOe/PprTugE9anYNfp8vN
	 KW+vEQ0Iwdjz4NqaANWDzqp7rQwMI8aLYrvHU1atbWd5O+xLqjutFWqFHpMqGLAKyA
	 je/rBJGGndb21+diVTAL5i3tW5KeNjatFpQ1ggz+5QO0N7zd6loKpjhvonJJq9KbaM
	 my5S+kg/yIxtg==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-54e7967cf67so5213440e87.0;
        Mon, 28 Apr 2025 08:16:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUiQsEjKaWv3Um5ShoOUh+Lf3uwPaD+ecLUrisWqrIovYb/OJlVZB//8Jg26/b3NGFrZgcQv65F6mXZIeZZ@vger.kernel.org, AJvYcCWYpzoyxrrATQNbMU3N4RrpYj4/7WNPgnNCu1pFfCR1/d4+CYvL42db+Okq3t1yveeyLyesHv0grtM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+beTCY9lkLik51NJusw22DC64CFQBRxIvC4d0aupCWaPiojaw
	q1jZWSiPrQVkf++8h2bHT1qZmqKSqQZjCdoyV+VQ964sbb+bTGod+QBPY9oMsRGOXv89PIDNT0a
	0f0vD8V9ujMPLKct2gwsyNzvi80k=
X-Google-Smtp-Source: AGHT+IEWDLFwiagcp4lT9DXCrJ61WxVz9C+o7TVDD2U3wDJfCR07I5LYa26NoSnDHD2AN0k0/AQc+0u6RvpqQ41CUAM=
X-Received: by 2002:a19:3841:0:b0:54e:9c8d:bdc3 with SMTP id
 2adb3069b0e04-54e9c8dc020mr299017e87.49.1745853382644; Mon, 28 Apr 2025
 08:16:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250424080950.289864-1-vkuznets@redhat.com> <20250424080950.289864-3-vkuznets@redhat.com>
 <CAMj1kXFMmhROmaDZ0gsw+ozG5iSkMvSXb15qexToUSAFyBn5hQ@mail.gmail.com> <87ldrka6w6.fsf@redhat.com>
In-Reply-To: <87ldrka6w6.fsf@redhat.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 28 Apr 2025 17:16:10 +0200
X-Gmail-Original-Message-ID: <CAMj1kXE0WcenLEB+60=+oc+aKfbqZkwYZf-TrOyDY=ShXQ2pYw@mail.gmail.com>
X-Gm-Features: ATxdqUGE3Ny_H_HoWht4i8zmh5BM3VhhWJ0XtYTcEme2sEbRbvRZLlgvoP_p6pY
Message-ID: <CAMj1kXE0WcenLEB+60=+oc+aKfbqZkwYZf-TrOyDY=ShXQ2pYw@mail.gmail.com>
Subject: Re: [PATCH 2/2] x86/efi: Implement support for embedding SBAT data
 for x86
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

On Mon, 28 Apr 2025 at 12:59, Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>
> Ard Biesheuvel <ardb@kernel.org> writes:
>
> > On Thu, 24 Apr 2025 at 10:10, Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
> >>
> >> Similar to zboot architectures, implement support for embedding SBAT data
> >> for x86. Put '.sbat' section to the very end of the binary.
> >>
> >> Note, the obsolete CRC-32 checksum (see commit 9c54baab4401 ("x86/boot:
> >> Drop CRC-32 checksum and the build tool that generates it")) is gone and
> >> while it would've been possible to reserve the last 4 bytes in '.sbat'
> >> section too (like it's done today in '.data'), it seems to be a pointless
> >> exercise: SBAT makes zero sense without a signature on the EFI binary so
> >> '.sbat' won't be at the very end of the file anyway. Any tool which uses
> >> the last 4 bytes of the file as a checksum is broken with signed EFI
> >> binaries already.
> >>
> >> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> >> ---
> >>  arch/x86/boot/Makefile                 |  2 +-
> >>  arch/x86/boot/compressed/Makefile      |  2 ++
> >>  arch/x86/boot/compressed/vmlinux.lds.S | 13 +++++++++++++
> >>  arch/x86/boot/header.S                 | 13 +++++++++++++
> >>  drivers/firmware/efi/Kconfig           |  2 +-
> >>  5 files changed, 30 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/arch/x86/boot/Makefile b/arch/x86/boot/Makefile
> >> index 81f55da81967..5f7b52f0e7f5 100644
> >> --- a/arch/x86/boot/Makefile
> >> +++ b/arch/x86/boot/Makefile
> >> @@ -71,7 +71,7 @@ $(obj)/vmlinux.bin: $(obj)/compressed/vmlinux FORCE
> >>
> >>  SETUP_OBJS = $(addprefix $(obj)/,$(setup-y))
> >>
> >> -sed-zoffset := -e 's/^\([0-9a-fA-F]*\) [a-zA-Z] \(startup_32\|efi.._stub_entry\|efi\(32\)\?_pe_entry\|input_data\|kernel_info\|_end\|_ehead\|_text\|_e\?data\|z_.*\)$$/\#define ZO_\2 0x\1/p'
> >> +sed-zoffset := -e 's/^\([0-9a-fA-F]*\) [a-zA-Z] \(startup_32\|efi.._stub_entry\|efi\(32\)\?_pe_entry\|input_data\|kernel_info\|_end\|_ehead\|_text\|_e\?data\|_e\?sbat\|z_.*\)$$/\#define ZO_\2 0x\1/p'
> >>
> >>  quiet_cmd_zoffset = ZOFFSET $@
> >>        cmd_zoffset = $(NM) $< | sed -n $(sed-zoffset) > $@
> >> diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> >> index fdbce022db55..b9b80eccdc02 100644
> >> --- a/arch/x86/boot/compressed/Makefile
> >> +++ b/arch/x86/boot/compressed/Makefile
> >> @@ -107,6 +107,8 @@ vmlinux-objs-$(CONFIG_UNACCEPTED_MEMORY) += $(obj)/mem.o
> >>  vmlinux-objs-$(CONFIG_EFI) += $(obj)/efi.o
> >>  vmlinux-libs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
> >>
> >> +vmlinux-objs-$(CONFIG_EFI_SBAT) += $(objtree)/drivers/firmware/efi/libstub/sbat.o
> >> +
> >
> > Please drop this, and put the .incbin directly into header.S
> >
>
> Sure, but as I also commented on zboot patch, we need a logic to track
> possible sbat data changes and rebuild when needed. 'sbat.o' was
> convenient because we can have this tracking logic in one place (zboot)
> and make will do the rest. If we are to drop 'sbat.o', we will need the
> tracking logic both in zboot and x86.
>

Same question: why isn't if sufficient to add

ifneq ($(CONFIG_EFI_SBAT_FILE),)
$(obj)/header.o: $(CONFIG_EFI_SBAT_FILE)
endif

to arch/x86/boot/Makefile?


> >>  $(obj)/vmlinux: $(vmlinux-objs-y) $(vmlinux-libs-y) FORCE
> >>         $(call if_changed,ld)
> >>
> >> diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
> >> index 3b2bc61c9408..d0a27905de90 100644
> >> --- a/arch/x86/boot/compressed/vmlinux.lds.S
> >> +++ b/arch/x86/boot/compressed/vmlinux.lds.S
> >> @@ -49,9 +49,22 @@ SECTIONS
> >>                 *(.data.*)
> >>
> >>                 /* Add 4 bytes of extra space for the obsolete CRC-32 checksum */
> >> +#ifndef CONFIG_EFI_SBAT
> >>                 . = ALIGN(. + 4, 0x200);
> >> +#else
> >> +               /* Avoid gap between '.data' and '.sbat' */
> >> +               . = ALIGN(. + 4, 0x1000);
> >> +#endif
> >>                 _edata = . ;
> >>         }
> >> +#ifdef CONFIG_EFI_SBAT
> >> +       .sbat : ALIGN(0x1000) {
> >> +               _sbat = . ;
> >> +               *(.sbat)
> >> +               _esbat = ALIGN(0x200);
> >> +               . = _esbat;
> >> +       }
> >> +#endif
> >>         . = ALIGN(L1_CACHE_BYTES);
> >>         .bss : {
> >>                 _bss = . ;
> >
> > This looks a bit odd - see below
> >
> >> diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
> >> index b5c79f43359b..ab851490ef74 100644
> >> --- a/arch/x86/boot/header.S
> >> +++ b/arch/x86/boot/header.S
> >> @@ -207,6 +207,19 @@ pecompat_fstart:
> >>                 IMAGE_SCN_MEM_READ              | \
> >>                 IMAGE_SCN_MEM_WRITE             # Characteristics
> >>
> >> +#ifdef CONFIG_EFI_SBAT
> >> +       .ascii ".sbat\0\0\0"
> >> +       .long   ZO__esbat - ZO__sbat            # VirtualSize
> >> +       .long   setup_size + ZO__sbat           # VirtualAddress
> >> +       .long   ZO__esbat - ZO__sbat            # SizeOfRawData
> >> +       .long   setup_size + ZO__sbat           # PointerToRawData
> >> +
> >> +       .long   0, 0, 0
> >> +       .long   IMAGE_SCN_CNT_INITIALIZED_DATA  | \
> >> +               IMAGE_SCN_MEM_READ              | \
> >> +               IMAGE_SCN_MEM_DISCARDABLE       # Characteristics
> >> +#endif
> >> +
> >
> > This puts the .sbat section at the very end of the file. However, the
> > virtual size of .data is 'ZO__end - ZO__data' not 'ZO__edata -
> > ZO__data', and so the .sbat section will overlap with .bss in the
> > memory view of the image.
>
> Missed that, will fix, thanks! A stupid question though: does this
> matter in practice for SBAT? I don't think anyone needs SBAT data after
> kernel starts booting so we can consider it 'discarded'. BSS data can
> then do whatever it wants.
>

It violates the PE/COFF spec, and some PE loaders and signing tools
are very pedantic about the layout.

