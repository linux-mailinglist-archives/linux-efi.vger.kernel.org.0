Return-Path: <linux-efi+bounces-5282-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A8CC23E8F
	for <lists+linux-efi@lfdr.de>; Fri, 31 Oct 2025 09:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8909D4E399D
	for <lists+linux-efi@lfdr.de>; Fri, 31 Oct 2025 08:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5C7310625;
	Fri, 31 Oct 2025 08:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="CPdd05k9"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5252EA48F
	for <linux-efi@vger.kernel.org>; Fri, 31 Oct 2025 08:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761900675; cv=none; b=ciWwiQNyyK4k0ka+fNAel0ee554yfpd5yBQFBpmAkuNVpbliG7K9cRKNmVMSs+nyytMSoHcFQn5RTIHOlKdgFvWp5rhUUnfLZVT9c/ap9f983zFMF0CE5ojE/sBblNvVs/qiUXGiwi/SUFo5pi5hoTOOBzkng+xNkvB4IOs5CHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761900675; c=relaxed/simple;
	bh=W/SRRF9O63pbHgjotOPw9FoaRhCzY9WZbEnNDKc15+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ihlnLd8msD2q2lm9cZ5qrvL7j93g5SyvUUVWMqMKEw7lzl9YqL9HEPnmc32rLGCWZXQS3Z0nSi5hZUVCxq2yVg4f3extaJ6jeV+PUI7CR5FwyfOi430DGh+/XthAJ7wjaGHpOO3yNlxxd10/3bC47fHDDL0EPokCj0j0Nywn4vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=CPdd05k9; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-3d397a07fa5so294404fac.2
        for <linux-efi@vger.kernel.org>; Fri, 31 Oct 2025 01:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1761900673; x=1762505473; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W/SRRF9O63pbHgjotOPw9FoaRhCzY9WZbEnNDKc15+s=;
        b=CPdd05k9oNpxVmV1whYHZLUW9zfF9AU+GsXo4twCx/icNnk1md1GxKqIWMpo6o8cY7
         UBLroXtWmW4ntNP2X5mrprZ2BHvifWr9lImmUL3PTzvxFc+Nw2IKp0ckt8dSiHR48fBa
         OpILVFDwicxiTLewzOTHwt1ZG6RfPFAOeD59DK4jLQ/gNjXaj2sMtLdCNH4wNm81wEQ0
         RR3KLKYHhFE4P6GgBM4FtvIwdGfY5MmgiJBT5uuyVSGv64XKhykKxhZpfb9uCZWGwzgJ
         6Bep96ufua7/I3vmDD9YJybii5zGfhqhYB8sdyYjJwkBXq7dxZPwdPdXc4KzPDDy58Yv
         nRLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761900673; x=1762505473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W/SRRF9O63pbHgjotOPw9FoaRhCzY9WZbEnNDKc15+s=;
        b=o+ee8KhEgnMEVmhyDrlhjmHgyb44wOeb5EowOuxAYNBdVK3YLf6OBOrnemU3sVjQJX
         tBvgNg5YrwcnuLcpWTYtGz2kfog/OMdVW9p47xkW770XAKnJ54EOTiw2oykVCiP8Sa3b
         3mveDGiRYdWp+6FpztD8Z4nhw7BrfbgWUUQVj2tJlMygGgR5wjmn4pd3L3V4jGpNRnr0
         /wMOYXvEA+1UZsajoRERv7BSw//ZSfBpKbBfXinkRUGyFfqDFq3R22EM4p7uzpM8aMof
         RfDEm2fgz/PSvyIKj1ka9gXkiJ7SoEy2VKNvIfUo/UEWyPsMwwyLatu+Wof73i7sfDR6
         N7Hg==
X-Forwarded-Encrypted: i=1; AJvYcCV/eP1GOXwsVgmRnkz2V2S3P2qR4xKeJn9g7sIQf8x9pQRnLBaZjsuSFKn0vGKjzvVT4MR/gpzB2Bk=@vger.kernel.org
X-Gm-Message-State: AOJu0YypG8avoFEpVyS4/MH7/G96LpllN/XVYEmeX7wrZRKRJkySatXH
	6m5TaZpboWu+BD4Evifv84WTPrRzFP7RUywfeR/eZhMj/bISWX3bBrhmQpwiEKF0Q7OPiltiBXu
	Kge8I2F/iOyp8W3OmBPMEt2Z6L9Eb2oj28KIgsWjw
X-Gm-Gg: ASbGnctkd5w6zanp4vrDjPOTiAKaq6x/MydqNLTpjpPSHdcId0Fw83B++VEjrvq8yMM
	P1942VFZMzQmda3sHSxO1qvIKZorBHELR7RJqS4ba/4UcSwaQj0t6asrRLLzL5Yw8JnT6CuSyq9
	yQwhJka7V/f3mYaQGndtxrFtnG5VfwMjf2JNDhz9ISFsMpfSZAR2YkDdWnGxgSZZk9AMrPZPA35
	tLwPL4gkf4RFUD0jKE4GvZLhBphBnI9YMkV1BLG4znEWirJGTc0Gp/IIOrkkBC3Uxev2JwaDT1T
	9n/E6HG8zaR+2Sb62/LJn7u/Crs=
X-Google-Smtp-Source: AGHT+IEFsWxw95ytjOxiVtq9eExQa0umqrN5dvl/ZX3mASj+jN68RLW/a3TijRIKLRi/zBLZ0nKoZjlEyZzn4jIh/98=
X-Received: by 2002:a05:6808:18a1:b0:438:1b55:9fd9 with SMTP id
 5614622812f47-44f95fe6ac7mr606925b6e.6.1761900672908; Fri, 31 Oct 2025
 01:51:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0f006338-e69b-4b3f-b91f-0cc683544011@kernel.org>
 <20251022114527.618908-1-adriana@arista.com> <20251022201953.GA206947-robh@kernel.org>
 <CAERbo5z6BzHqQxXdxPxmxE_eDR7GGGbt3A8kB0gQiWFBE-28Ug@mail.gmail.com>
 <CAMj1kXGYinTKiyYhNYWJvoJeUJScCGnyq=ozLgjKAm7_wzG8QA@mail.gmail.com>
 <CAERbo5waY-=6BLZ2SiJSFAXzvU57mJdM9q05vAZw8zR2yExQ5w@mail.gmail.com>
 <CAMj1kXHin5YacS98ttzHqFqy6HMukXKoLZtr-+bLwVRsWZUugQ@mail.gmail.com>
 <CAERbo5zgS8XoGcFB3wejqDpx14-SBr5oWn7pu3=PE0djRiKZqg@mail.gmail.com>
 <CAMj1kXEnSKF4VcMdOvUUuM-pOEWB38qPhWvUm13rnkQiZXp6SA@mail.gmail.com>
 <CAC_iWjKQ5Smx5hOM9Lgyq_KD6D7OXyDsfJ4mcEnfw4JuRtxy-g@mail.gmail.com> <20251024180746.GT6688@bill-the-cat>
In-Reply-To: <20251024180746.GT6688@bill-the-cat>
From: Adriana Nicolae <adriana@arista.com>
Date: Fri, 31 Oct 2025 10:51:01 +0200
X-Gm-Features: AWmQ_bk3DM9Rh8pQQ3OaBowRnbz49GJWMYEBUlC4tjTu1tfNVolHtIKrCeoiufU
Message-ID: <CAERbo5xYExnnF7BosjEsevDsZXs6yRg+PmYTPzZQJqAJno3Gtw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] DMI: Scan for DMI table from DTS info
To: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, Ard Biesheuvel <ardb@kernel.org>, 
	Rob Herring <robh@kernel.org>, krzk@kernel.org, jdelvare@suse.com, 
	frowand.list@gmail.com, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, vasilykh@arista.com, arm.ebbr-discuss@arm.com, 
	boot-architecture@lists.linaro.org, linux-efi@vger.kernel.org, 
	uefi-discuss@lists.uefi.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 9:07=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Fri, Oct 24, 2025 at 02:07:43PM +0300, Ilias Apalodimas wrote:
> > Hi Ard, Adriana
> >
> > Thanks for cc'ing me.
> >
> > On Fri, 24 Oct 2025 at 12:49, Ard Biesheuvel <ardb@kernel.org> wrote:
> > >
> > > On Thu, 23 Oct 2025 at 16:48, Adriana Nicolae <adriana@arista.com> wr=
ote:
> > > >
> > > > On Thu, Oct 23, 2025 at 4:54=E2=80=AFPM Ard Biesheuvel <ardb@kernel=
.org> wrote:
> > > > >
> > > > > (cc Ilias)
> > > > >
> > > > > On Thu, 23 Oct 2025 at 15:34, Adriana Nicolae <adriana@arista.com=
> wrote:
> > > > > >
> > > > > > On Thu, Oct 23, 2025 at 11:21=E2=80=AFAM Ard Biesheuvel <ardb@k=
ernel.org> wrote:
> > > > > > >
> > > > > > > On Thu, 23 Oct 2025 at 04:21, Adriana Nicolae <adriana@arista=
.com> wrote:
> > > > > > > >
> > > > > > > > On Wed, Oct 22, 2025 at 11:19=E2=80=AFPM Rob Herring <robh@=
kernel.org> wrote:
> > > > > > > > >
> > > > > > > > > On Wed, Oct 22, 2025 at 04:45:25AM -0700, adriana wrote:
> > > > > > > > > > Some bootloaders like U-boot, particularly for the ARM =
architecture,
> > > > > > > > > > provide SMBIOS/DMI tables at a specific memory address.=
 However, these
> > > > > > > > > > systems often do not boot using a full UEFI environment=
, which means the
> > > > > > > > > > kernel's standard EFI DMI scanner cannot find these tab=
les.
> > > > > > > > >
> > > > > > > > > I thought u-boot is a pretty complete UEFI implementation=
 now. If
> > > > > > > > > there's standard way for UEFI to provide this, then that'=
s what we
> > > > > > > > > should be using. I know supporting this has been discusse=
d in context of
> > > > > > > > > EBBR spec, but no one involved in that has been CC'ed her=
e.
> > > > > > > >
> > > > > > > > Regarding the use of UEFI, the non UEFI boot is used on Bro=
adcom iProc which
> > > > > > > > boots initially into a Hardware Security Module which valid=
ates U-boot and then
> > > > > > > > loads it. This specific path does not utilize U-Boot's UEFI
> > > > > > > > implementation or the
> > > > > > > > standard UEFI boot services to pass tables like SMBIOS.
> > > > > > > >
> > > > > > >
> > > > > > > What prevents this HSM validated copy of u-boot from loading =
the kernel via EFI?
> > > > > > The vendor's U-Boot configuration for this specific secure boot=
 path
> > > > > > (involving the
> > > > > > HSM) explicitly disables the CMD_BOOTEFI option due to security
> > > > > > mitigations, only
> > > > > > a subset of U-boot commands are whitelisted. We could patch the=
 U-boot
> > > > > > to include
> > > > > > that but it is preferable to follow the vendor's recommandation=
s and
> > > > > > just patch U-boot
> > > > > > to fill that memory location with SMBIOS address or directly wi=
th the
> > > > > > entry point.
> > > > >
> > > > > And what security mitigations are deemed needed for the EFI code?=
 You
> > > > > are aware that avoiding EFI boot means that the booting kernel ke=
eps
> > > > > all memory protections disabled for longer than it would otherwis=
e. Is
> > > > > this allowlisting based on simply minimizing the code footprint?
> > > > >
> > > > From the information I have, it might be just minimizing the footpr=
int
> > > > but the vendor's U-Boot configuration for this specific path
> > > > explicitly disables the CMD_BOOTEFI option. While the vendor cites
> > > > security mitigations for this configuration, the specific details
> > > > could be a set of mitigation removing different boot methods and so=
me
> > > > memory access commands.
> > > >
> > > > The core issue is that this non-EFI boot path is the vendor-validat=
ed
> > > > configuration. Enabling EFI would deviate from this setup, require
> > > > significant revalidation, and could impact vendor support. Modifyin=
g
> > > > U-Boot to populate the DT is a contained change without modifying t=
he
> > > > U-boot vendor configuration.
> > > >
> > >
> > > I'm not sure I follow why changing U-Boot's code would not require
> > > revalidation if simply changing its build configuration without
> > > modifying the source code would require that.
> > >
> > > > Beyond our specific vendor constraints, this DT method might be use=
d
> > > > by any other non-UEFI arm system needing to expose SMBIOS tables to
> > > > the kernel.
> > > >
> > >
> > > Fair point. So let's do this properly: get buy-in from the U-Boot
> > > folks and contribute your u-boot changes as well. And ideally, we'd
> > > get this into the DMTF spec but if you are not set up for that (I
> > > think you might need to be a member to be able to contribute), we can
> > > find some ARM folks who are.
> >
> > +1
> > U-Boot does offer an EFI implementation indeed, but we can't magically
> > force people to use it.
> > The problem with SMBIOS is that afaict is still widely used by various
> > debugging tools, so we might as well support it.
> > I agree with Ard here. I think the best thing we can do is
> > - Make the node standard in the DT spec, so everyone gets a reference
> > - Gatekeep any alternative implementations for the kernel until
> > someone gets this into the DMTF spec as well
> > - Send a patch to U-Boot that adds that mode dynamically if booting is
> > !EFI and SMIOS support is enabled
>
> This sounds like a good plan to me, from the U-Boot side of things.
Thank you for guiding on this change. I've just posted the v3 kernel
patch series which is simplified to support SMBIOS3 only.

I have also submitted the corresponding U-Boot patch (to add the
property dynamically for non-EFI boots) to the u-boot@lists.denx.de
list. It may be held for moderation as I am waiting for my
subscription to be approved, but it should appear on the archive soon.

Regarding the DMTF spec, I am not a member and cannot contribute
directly. I would appreciate the help to get this proposed.
Please let me know if there are any concerns with the v3 kernel patch.


>
> --
> Tom

