Return-Path: <linux-efi+bounces-4740-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E390B53E11
	for <lists+linux-efi@lfdr.de>; Thu, 11 Sep 2025 23:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6ECF1884E3E
	for <lists+linux-efi@lfdr.de>; Thu, 11 Sep 2025 21:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB3D2264C7;
	Thu, 11 Sep 2025 21:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rInQ3PUw"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0762AE6A
	for <linux-efi@vger.kernel.org>; Thu, 11 Sep 2025 21:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757627379; cv=none; b=IwN805nxQ0Hkrr/WhBqFMYv/OUGDB/p7rUFtVE4HoTYCxX8yxvGj7UT6+fDvMs+FLfjPf2/Tqoyqx2D+WWaNdvfZytjhHr7cSfzASJs83yVPQYUbDavTKwIUkpQHku0pp4IXVhuaWRJEpjLpdmnvZdQTmvrqVzvJvFELYdftVwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757627379; c=relaxed/simple;
	bh=/D/Xv8E0JurW2W7IlCXL/95QDvRbH5Lset71vZtxHSI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cU1qEJr6woEJ3vJjZ7CUS8T/r0yRzIBEDkgU0uWk06+2xjHp50mPoX5XE0mJXn1qUfK/OAav3IJPmdPEhaVsFXmrCoXJy7RsXPx2UOWZKwHdI+c2TPbaeqR87zxx8JG6kuw7p3heHpCTaef4FhFYlCccs4eVdaFH0a28ROTCPlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rInQ3PUw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D587C4AF09
	for <linux-efi@vger.kernel.org>; Thu, 11 Sep 2025 21:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757627379;
	bh=/D/Xv8E0JurW2W7IlCXL/95QDvRbH5Lset71vZtxHSI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rInQ3PUwyNXW+MgFZCEdsFSe5RegoBqq8Q6qEoq8k61QPzJRKf63vNMTQCuKMBitG
	 F0mg8ELq4Oja195ce3oFwfJvRfRFnRxCZAv7RTP8ysvHIJYCeTH1eMNqjZ+cv5trUc
	 6dF6ZlmQ0ymGMW1UBclfjabIUEe15nhHwmOZP2lhSHL5M8fCArOf2qbuKrNOM1MufF
	 /9hOF/B1qi7sbmrTKoi2MxiBJNHSwvkTrvFWnbEgW/RPoJ2zSmMXnndkm1bKuask0s
	 +W8hGtPoEoW5ThTZ9/sMmfk0QLc3fIsRxF/SDTgJzZY6blpTrHCoZ0eoIRnfJaFzk5
	 dUyjMlflOyojQ==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-336e44ca0e4so10723621fa.0
        for <linux-efi@vger.kernel.org>; Thu, 11 Sep 2025 14:49:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW5QjEutWvGMf9o1vefeAtPwtWHz/IONwW2jgFpgfDJUkVfOJLCnnnF/IqVqS1yigpsQ+XiHVG53iU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsnKjwfhMTG0AkD33/VX0y1wTq/v3d1vej+GtlLb/bTf9lE50q
	/x8Qg0jQ6OaN9xhP7VeobBLmohdvcghcIn2eW3Fuh6nC1hIxIwerflkWrc4wCmpZsJiRNSudtt2
	kFwOq7z3sVFCaXIdJQPvP+Y+Fn0IlU6c=
X-Google-Smtp-Source: AGHT+IE3V4NFlUV4taKEaI0iS3Wl50Lejbr5Iyyr8M/K1/2ot2Sm01X0VuYU42N/fMoX4s5BFVR9Yy0W1TNqO3SxHS0=
X-Received: by 2002:a05:651c:23c6:10b0:32a:77a3:877f with SMTP id
 38308e7fff4ca-3513a13da61mr1372751fa.2.1757627377479; Thu, 11 Sep 2025
 14:49:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909080631.2867579-5-ardb+git@google.com> <20250909080631.2867579-7-ardb+git@google.com>
 <2abffe1f-e289-4261-97f0-cfc4cf674fd0@amd.com>
In-Reply-To: <2abffe1f-e289-4261-97f0-cfc4cf674fd0@amd.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 11 Sep 2025 23:49:26 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEn1cJ7+K+sr1520S3z=7uB6_=xjA5+JF2Q50y_V6zRoA@mail.gmail.com>
X-Gm-Features: Ac12FXwfIgv2RJat4n8-j6BBgE0ryYB3M8ScaHDiLO3hzqdYbPGBM_c1vsEYQUo
Message-ID: <CAMj1kXEn1cJ7+K+sr1520S3z=7uB6_=xjA5+JF2Q50y_V6zRoA@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] x86/efistub: Obtain SEV CC blob address from the stub
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, x86@kernel.org, Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Sept 2025 at 23:27, Tom Lendacky <thomas.lendacky@amd.com> wrote:
>
> On 9/9/25 03:06, Ard Biesheuvel wrote:
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > The x86 EFI stub no longer boots the core kernel via the traditional
> > decompressor but jumps straight to it, avoiding all the page fault
> > handling and other complexity that is entirely unnecessary when booting
> > via EFI, which guarantees that all system memory is mapped 1:1.
> >
> > The SEV startup code in the core kernel expects the address of the CC
> > blob configuration table in boot_params, so store it there when booting
> > from EFI with SEV-SNP enabled. This removes the need to call
> > sev_enable() from the EFI stub.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  drivers/firmware/efi/libstub/x86-stub.c | 21 +++++++++++++++-----
> >  1 file changed, 16 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
> > index 0d05eac7c72b..c4ef645762ec 100644
> > --- a/drivers/firmware/efi/libstub/x86-stub.c
> > +++ b/drivers/firmware/efi/libstub/x86-stub.c
> > @@ -681,17 +681,28 @@ static efi_status_t exit_boot(struct boot_params *boot_params, void *handle)
> >       return EFI_SUCCESS;
> >  }
> >
> > -static bool have_unsupported_snp_features(void)
> > +static bool check_snp_features(struct boot_params *bp)
> >  {
> > +     u64 status = sev_get_status();
> >       u64 unsupported;
> >
> > -     unsupported = snp_get_unsupported_features(sev_get_status());
> > +     unsupported = snp_get_unsupported_features(status);
> >       if (unsupported) {
> >               efi_err("Unsupported SEV-SNP features detected: 0x%llx\n",
> >                       unsupported);
> > -             return true;
> > +             return false;
> >       }
> > -     return false;
> > +
> > +     if (status & MSR_AMD64_SEV_SNP_ENABLED) {
> > +             void *tbl = get_efi_config_table(EFI_CC_BLOB_GUID);
> > +
> > +             if (!tbl) {
> > +                     efi_err("SEV-SNP is enabled but CC blob not found\n");
> > +                     return false;
> > +             }
> > +             bp->cc_blob_address = (u32)(unsigned long)tbl;
>
> I think we ran into bugs where the cc_blob_address was random data from a
> boot loader when SNP wasn't active and that's why we always initialize it
> to 0:
>
> 4b1c74240757 ("x86/boot: Don't propagate uninitialized boot_params->cc_blob_address")
>
> So we probably need the same statement that is at the beginning of the
> decompressor sev_enable() at the very beginning of this function to ensure
> cc_blob_address is set to zero:
>
>         /*
>          * bp->cc_blob_address should only be set by boot/compressed kernel.
>          * Initialize it to 0 to ensure that uninitialized values from
>          * buggy bootloaders aren't propagated.
>          */
>         if (bp)
>                 bp->cc_blob_address = 0;
>

AIUI this was needed for bootloaders like SYSLINUX, which boot in
pseudo-EFI mode, i.e., not via the EFI stub but with the EFI fields in
struct boot_params populated. This means zeroing the field in the stub
is not going to make a difference.

It doesn't hurt either, so I can find a place to stick this, but I'm
not convinced we still need this here. Note that GRUB no longer boots
via the EFI handover protocol (and mainline GRUB never did), and so
struct boot_params is typically allocated (and wiped) by the EFI stub
and not taken from the bootloader.

