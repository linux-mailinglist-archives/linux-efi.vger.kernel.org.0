Return-Path: <linux-efi+bounces-5113-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C30C01E8A
	for <lists+linux-efi@lfdr.de>; Thu, 23 Oct 2025 16:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 985943A3908
	for <lists+linux-efi@lfdr.de>; Thu, 23 Oct 2025 14:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6800631D38E;
	Thu, 23 Oct 2025 14:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="DOa9pBJR"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFCA30216A
	for <linux-efi@vger.kernel.org>; Thu, 23 Oct 2025 14:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761230887; cv=none; b=tXq8sqSPWUCUgtnaJNKmADbLlB8UvjQiitlRJwwkkjgWp9AN64VGa8V0+neYm/w5P9X7j/NSk2z4y1/u58wbPfZtbbVkozR9bzVkjhYcGtjr0JmU+327b7xGEt+BCJE9Ne2kjpycIZlvRrD6iJ2rSR7QT++ct5bGWQjtFI/sa7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761230887; c=relaxed/simple;
	bh=yCbQ9XxHJbLX+gMA3bCythVrgdQkz4B5n1RY+AXyRAo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RliBuzYh9RLlY6msgMLNR9fVRG9zzDyfCSQR11TJsfCw8xlWyuQv1IY1+QquN07JnsTNiObrZYhCy7qyVEzSfLtSZFeIEZF6tdVTvHlvQhcs+TSrNz09gV6ZMC90ATOPESu/McoTgy41GV6BxOTE6dBfz37VgfzvRjlbM5AG4K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=DOa9pBJR; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-3c9a2fa38c1so321312fac.2
        for <linux-efi@vger.kernel.org>; Thu, 23 Oct 2025 07:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1761230885; x=1761835685; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yCbQ9XxHJbLX+gMA3bCythVrgdQkz4B5n1RY+AXyRAo=;
        b=DOa9pBJRFx+knEeb/Ywo9K/L2kURf/jMx9uFfTCQKlI2cPVdLzwIgv7VO0eN6AlZOU
         /XBjNsoWcJhwfhMKP8NDBHqyzHCNoovr6dDZccXJc21UXnSzp83x+okJ9IwRWmIshIGl
         kYycEBLb+ohLHMI5HewOSLfxSWHRO8QnZ+uDFkZnmUO+zrX2DuEz7sEwveT33oCwNTek
         93nwKwVIZ4KsTTqfLmtRP3yPuZjrYfuQ6AX+DH6rhQpYoEDfuYAXCEk5JBh90vyp/90N
         X7dLWwDXGr709BpwUCVWScWMueCx6hlZWIfHNe4mswuodnzTGRiU+IFkCt5wOdBFjEL4
         2MjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761230885; x=1761835685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yCbQ9XxHJbLX+gMA3bCythVrgdQkz4B5n1RY+AXyRAo=;
        b=fW9dz2ids4KykRcK3kaak6Lzg5j131Eujb0rffLnHTHlZ4Cui1upYpa08hrD58zc7k
         9HYlTP94c2UPV0/l6iIwGBzbrAgneD3FzcuqJrBMIZlv2JS7aDQIo0DrMI0M8zf/iUUN
         zFhAltMpvlfCYdCAu47obhB0HBcjhlcD5XIYnbqm749JAexxI9dqS9fmnDK3YOIVraxB
         IwhWqB4o2iVjxOQXkBdn7MoJGoZwjVFE2OhTF+WJHhPdSh2JgoMV0Wpr0QmDNNyCS/O1
         WnXcZec2mUZ6ckyTp9RE37he4unMhz1U0cJrEzGlV46KeqJJ9U2V6JkYEagDff2z664v
         W3Iw==
X-Forwarded-Encrypted: i=1; AJvYcCURf48W3vQcbC6BePuU+DHUMr9ihu0Pw2qmiuYgXTBlOUExD2oNxPJaiYYDSvRdb+1sW4CBw3MEEQo=@vger.kernel.org
X-Gm-Message-State: AOJu0YysFDy/jvAPbKG0KsqzG/NacXYR1SQXp7qmSV5GZt6gg68+yn8L
	s3X2uizc9hJRrQSTvl4+BK5lvShXrVR7M7UzBQX8y+us94fgNr8PEuvpZe1a0OkEQ9X60f3xF0F
	sRBlTDni4AxjhqhKfMr5UtENuqRzROPTMD3B/iUaN
X-Gm-Gg: ASbGncvWt2egngThB+hpnaRYl+RpFwEzEjC96rpubRaKycE3GDtURUkfhvNs0e7QPBI
	HDMYkTYvWguUpxc1+jczK9gzlg4VZmlQTNmBvUT+MExGaTHaAIssEpenW63fCAuNDTdr+Rip+a4
	puFz6DBnx5yX7/V11offtpjKPMqUdFN8iiRd3uoxtDoHNaCjgbwT8+B6HIwjCynYWCfBifWKMyq
	feBv/fHxq47krx0GCncF/Perq4WGSsiQ1PGtD/q3i3TiWfOR9/zwV7MLf3Qnx/8xj8tRoD1B9py
	fbyzjU0rG0aINNg0o1K+L3rpb6VG2A==
X-Google-Smtp-Source: AGHT+IFvw0XTgABjFJsYXYpUudxoEkAHEEP01CdUdwp3L8Qx0ZBVOSdQx/inF8LNyXBTTOZmTqpehickro9B2Kz6m7g=
X-Received: by 2002:a05:6871:d10b:b0:345:ecd6:8b7 with SMTP id
 586e51a60fabf-3cd88db4df9mr2532709fac.11.1761230884387; Thu, 23 Oct 2025
 07:48:04 -0700 (PDT)
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
 <CAERbo5waY-=6BLZ2SiJSFAXzvU57mJdM9q05vAZw8zR2yExQ5w@mail.gmail.com> <CAMj1kXHin5YacS98ttzHqFqy6HMukXKoLZtr-+bLwVRsWZUugQ@mail.gmail.com>
In-Reply-To: <CAMj1kXHin5YacS98ttzHqFqy6HMukXKoLZtr-+bLwVRsWZUugQ@mail.gmail.com>
From: Adriana Nicolae <adriana@arista.com>
Date: Thu, 23 Oct 2025 17:47:53 +0300
X-Gm-Features: AWmQ_bmwEubJ_qHzUAOArVDKuoamgdMa0FuM6IkzPxP77akzotjC48951wOss6E
Message-ID: <CAERbo5zgS8XoGcFB3wejqDpx14-SBr5oWn7pu3=PE0djRiKZqg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] DMI: Scan for DMI table from DTS info
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Rob Herring <robh@kernel.org>, krzk@kernel.org, jdelvare@suse.com, 
	frowand.list@gmail.com, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, vasilykh@arista.com, arm.ebbr-discuss@arm.com, 
	boot-architecture@lists.linaro.org, linux-efi@vger.kernel.org, 
	uefi-discuss@lists.uefi.org, linux-arm-kernel@lists.infradead.org, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 4:54=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> wr=
ote:
>
> (cc Ilias)
>
> On Thu, 23 Oct 2025 at 15:34, Adriana Nicolae <adriana@arista.com> wrote:
> >
> > On Thu, Oct 23, 2025 at 11:21=E2=80=AFAM Ard Biesheuvel <ardb@kernel.or=
g> wrote:
> > >
> > > On Thu, 23 Oct 2025 at 04:21, Adriana Nicolae <adriana@arista.com> wr=
ote:
> > > >
> > > > On Wed, Oct 22, 2025 at 11:19=E2=80=AFPM Rob Herring <robh@kernel.o=
rg> wrote:
> > > > >
> > > > > On Wed, Oct 22, 2025 at 04:45:25AM -0700, adriana wrote:
> > > > > > Some bootloaders like U-boot, particularly for the ARM architec=
ture,
> > > > > > provide SMBIOS/DMI tables at a specific memory address. However=
, these
> > > > > > systems often do not boot using a full UEFI environment, which =
means the
> > > > > > kernel's standard EFI DMI scanner cannot find these tables.
> > > > >
> > > > > I thought u-boot is a pretty complete UEFI implementation now. If
> > > > > there's standard way for UEFI to provide this, then that's what w=
e
> > > > > should be using. I know supporting this has been discussed in con=
text of
> > > > > EBBR spec, but no one involved in that has been CC'ed here.
> > > >
> > > > Regarding the use of UEFI, the non UEFI boot is used on Broadcom iP=
roc which
> > > > boots initially into a Hardware Security Module which validates U-b=
oot and then
> > > > loads it. This specific path does not utilize U-Boot's UEFI
> > > > implementation or the
> > > > standard UEFI boot services to pass tables like SMBIOS.
> > > >
> > >
> > > What prevents this HSM validated copy of u-boot from loading the kern=
el via EFI?
> > The vendor's U-Boot configuration for this specific secure boot path
> > (involving the
> > HSM) explicitly disables the CMD_BOOTEFI option due to security
> > mitigations, only
> > a subset of U-boot commands are whitelisted. We could patch the U-boot
> > to include
> > that but it is preferable to follow the vendor's recommandations and
> > just patch U-boot
> > to fill that memory location with SMBIOS address or directly with the
> > entry point.
>
> And what security mitigations are deemed needed for the EFI code? You
> are aware that avoiding EFI boot means that the booting kernel keeps
> all memory protections disabled for longer than it would otherwise. Is
> this allowlisting based on simply minimizing the code footprint?
>
From the information I have, it might be just minimizing the footprint
but the vendor's U-Boot configuration for this specific path
explicitly disables the CMD_BOOTEFI option. While the vendor cites
security mitigations for this configuration, the specific details
could be a set of mitigation removing different boot methods and some
memory access commands.

The core issue is that this non-EFI boot path is the vendor-validated
configuration. Enabling EFI would deviate from this setup, require
significant revalidation, and could impact vendor support. Modifying
U-Boot to populate the DT is a contained change without modifying the
U-boot vendor configuration.

Beyond our specific vendor constraints, this DT method might be used
by any other non-UEFI arm system needing to expose SMBIOS tables to
the kernel.

> Introducing a non-standard mechanism means that others will now have
> to maintain it and coexist with it, rather than simply using the
> existing code which already fully supports what you are trying to
> accomplish (both on the bootloader and the kernel side)
>
> IOW, in my opinion, simply enabling CMD_BOOTEFI for your bootloader is
> a much better choice here. I'm not a u-boot expert but as I understand
> it, loading/authenticating the image and booting it in EFI mode are
> two separate things, and so the secure boot path would change very
> little.
>
> > > > Because there's no UEFI configuration table available in this boot =
mode, we need
> > > > an alternative mechanism to pass the SMBIOS table address to the ke=
rnel. The
> > > > /chosen node seemed like the most straightforward way for the bootl=
oader to
> > > > communicate this non-discoverable information.
> > > >
> > > > I wasn't aware of the EBBR discussions covering this. I've added th=
e
> > > > boot-architecture and arm.ebbr-discuss lists to the Cc. If there's =
a preferred
> > > > EBBR-compliant way to handle this for non-UEFI boots, I'm happy to =
adapt
> > > > the approach.
> > > >
> > >
> > > For the record, I don't see a huge problem with accepting SMBIOS
> > > tables in this manner, but it would be better if a description of thi=
s
> > > method was contributed to the DMTF spec, which currently states that
> > > the only way to discover SMBIOS tables on non-x86 systems is via the
> > > SMBIOS/SMBIOS3 EFI configuration tables. Doing so should prevent othe=
r
> > > folks from inventing their own methods for their own vertically
> > > integrated systems. (Other OSes exist, and from a boot arch PoV, we
> > > try to avoid these Linux-only shortcuts)
> > >
> > > However, the DT method should *only* be used when not booting via
> > > UEFI, to avoid future surprises, and to ensure that existing OSes
> > > (including older Linux) can always find the SMBIOS tables when bootin=
g
> > > via UEFI.
> > >
> > > Also, I would suggest to pull the entire entrypoint into DT, rather
> > > than the address in memory of either/both entrypoint(s). Both just
> > > carry some version fields, and the address of the actual SMBIOS data
> > > in memory, and the only difference between SMBIOS and SMBIOS3 is the
> > > size of the address field (32 vs 64 bits)
> > I understand the points raised about UEFI taking precedence and the
> > preference for standardization (DMTF). If this DT method is accepted
> > as a fallback only for non-UEFI boots like this one, the kernel impleme=
ntation
> > will respect that precedence.
> >
> > Regarding the alternative to place the full SMBIOS entry point structur=
e into
> > a DT property (as a byte array) instead of just its memory address. Bot=
h
> > approaches seem feasible from the U-Boot side. I opted initially for pa=
ssing
> > the address to reuse the existing kernel functions (dmi_smbios3_present=
 and
> > dmi_present) which already handle mapping and validation of the entry p=
oint
> > read from memory (as done for the EFI case).
> >
>
> Actually, it appears that dmidecode expects the entrypoint data in
> /sys/firmware/dmi/tables/smbios_entry_point, and so you will need to
> populate that file in any case, and so pulling it into the DT node is
> not as useful. But having both SMBIOS and SMBIOS3 is pointless, so
> please only bother with the latter.

