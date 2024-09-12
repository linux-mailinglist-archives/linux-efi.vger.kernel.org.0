Return-Path: <linux-efi+bounces-1705-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9754D9766F8
	for <lists+linux-efi@lfdr.de>; Thu, 12 Sep 2024 12:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AC42285C09
	for <lists+linux-efi@lfdr.de>; Thu, 12 Sep 2024 10:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A5318BC07;
	Thu, 12 Sep 2024 10:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ndfrSPSx"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1AA615D5D9;
	Thu, 12 Sep 2024 10:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726138330; cv=none; b=MvGWLZyZdtOHBONOVpEp6hwArFXlTAowJHE5UDMJTJLKF11CGfVANbaqGDMYWkqbs/W5CiQpab0JSVkgZ6V6CxMmzZBF7HhZ5SuvUYDe/4RoU7vTIcfDOhNfRxgmDqo7Kyw2l7pvcjhYbO/hOHf6Gz0wuLMKhMGIqTyj9AcN328=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726138330; c=relaxed/simple;
	bh=cL7uDEElOY41qr+HGq/ZTZuOKa90vTrMzKP6ssUHDo8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LH8adWL3v4IaCLr+t0D5shmQx7WdAmb1fGgRLKtJMKti7WT1p5E5yJT700g3N2m370Z3To7zXV6STTkAXOkGGIaNPi1uFR/PbkWcfgZc56UEStA4986Jo14TrKktNYUbbDaREKns3VbhFENfx+O2YdYfrR5avgMRD40f5EUXq9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ndfrSPSx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11DC7C4AF0B;
	Thu, 12 Sep 2024 10:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726138330;
	bh=cL7uDEElOY41qr+HGq/ZTZuOKa90vTrMzKP6ssUHDo8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ndfrSPSxz6CIkfBnsZKsrLlkbnBVpmiUM/EvG5sOGBufIIwTXIRtz5tV4MsB2bYKd
	 6Sq0TAK3Ogs+1vUs5qw97+xgE6EoiDTCty5hiem7qYtG+H4GtT7HDcGb3gHWoX+A8O
	 6jwwHBr0qm4PNfnqRJHI5WC1/T11knKSPzCCaG4rMmr7QjyZKgoDiobXcO92kDoeaK
	 7Jb/pcEq9QtqblEhdDgRM6iWktevtEVcl4vbf9xD0idyZ+DFpEhO9ese7m3oNCHb2D
	 jXn78HUk+pwAzD5S71PtFmVVpqfBRn7su0BvsE57aXhgIHBltn6j61AezeOG25/D9o
	 HKNX6fWNTDqcw==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2f66423686bso7729321fa.3;
        Thu, 12 Sep 2024 03:52:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVQoiZEhVo33jNr46ObCLeTKtkAQ+2gmGukNzvWS2bmtS8CKx1MeOEwHSKxbR818LJ/i996JmM7aliGBpM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFkwj5tlLGi89qWVYRHQdQRgKNXC3sZVFF0erfuALI8P7Cmh+0
	0ITA0KJ4itY3MG+vuJhaOJEganhUVqQwI7ZGc6QJPegBTntOIwKExDJctPgtTKzn4VmUTtwkQ3z
	kMDpCpY+tnLQGC0dNfJK5wrvbkYo=
X-Google-Smtp-Source: AGHT+IG0RDOWZFcmijfEe36WItqbt0+VFYUSSIJCGg1H644oMA2zxoliUoqq9tnW8It6Ov5SLYGgsg4NMXktN5CT4as=
X-Received: by 2002:a05:651c:2104:b0:2f3:ad82:53fd with SMTP id
 38308e7fff4ca-2f787f2d6b7mr12658091fa.28.1726138328401; Thu, 12 Sep 2024
 03:52:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911104109.1831501-1-usamaarif642@gmail.com>
 <CAMj1kXFVyQEwBTf2bG8yBXUktM16dzrcPH-Phz_toAsCK-NfMA@mail.gmail.com> <2542182d-aa79-4705-91b6-fa593bacffa6@gmail.com>
In-Reply-To: <2542182d-aa79-4705-91b6-fa593bacffa6@gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 12 Sep 2024 12:51:57 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGi+N6AukJt6EGQTao=-1Ud_=bzwPvdjEzhmzEraFU98w@mail.gmail.com>
Message-ID: <CAMj1kXGi+N6AukJt6EGQTao=-1Ud_=bzwPvdjEzhmzEraFU98w@mail.gmail.com>
Subject: Re: [RFC] efi/tpm: add efi.tpm_log as a reserved region in 820_table_firmware
To: Usama Arif <usamaarif642@gmail.com>
Cc: linux-efi@vger.kernel.org, kexec@lists.infradead.org, 
	ebiederm@xmission.com, bhe@redhat.com, vgoyal@redhat.com, tglx@linutronix.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, linux-kernel@vger.kernel.org, 
	leitao@debian.org, rmikey@meta.com, gourry@gourry.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 12 Sept 2024 at 12:23, Usama Arif <usamaarif642@gmail.com> wrote:
>
>
>
> On 11/09/2024 12:51, Ard Biesheuvel wrote:
> > On Wed, 11 Sept 2024 at 12:41, Usama Arif <usamaarif642@gmail.com> wrot=
e:
> >>
> >> Looking at the TPM spec [1]
> >>
> >> If the ACPI TPM2 table contains the address and size of the Platform
> >> Firmware TCG log, firmware =E2=80=9Cpins=E2=80=9D the memory associate=
d with the
> >> Platform FirmwareTCG log, and reports this memory as =E2=80=9CReserved=
=E2=80=9D memory
> >> via the INT 15h/E820 interface.
> >>
> >> It looks like the firmware should pass this as reserved in e820 memory
> >> map. However, it doesn't seem to. The firmware being tested on is:
> >> dmidecode -s bios-version
> >> edk2-20240214-2.el9
> >>
> >> When this area is not reserved, it comes up as usable in
> >> /sys/firmware/memmap. This means that kexec, which uses that memmap
> >> to find usable memory regions, can select the region where efi.tpm_log
> >> is and overwrite it and relocate_kernel.
> >>
> >> Having a fix in firmware can be difficult to get through. As a seconda=
ry
> >> fix, this patch marks that region as reserved in e820_table_firmware i=
f it
> >> is currently E820_TYPE_RAM so that kexec doesn't use it for kernel seg=
ments.
> >>
> >> [1] https://trustedcomputinggroup.org/wp-content/uploads/PC-ClientPlat=
form_Profile_for_TPM_2p0_Systems_v49_161114_public-review.pdf
> >>
> >> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> >
> > I would expect the EFI memory map to E820 conversion implemented in
> > the EFI stub to take care of this.
> >
>
> So I have been making a prototype with EFI stub, and the unfinished versi=
on is looking like a
> horrible hack.
>
> The only way to do this in libstub is to pass log_tbl all the way from ef=
i_retrieve_tcg2_eventlog
> to efi_stub_entry and from there to setup_e820.
> While going through the efi memory map and converting it to e820 table in=
 setup_e820, you have to check
> if log_tbl falls in any of the ranges and if the range is E820_TYPE_RAM. =
If that condition is satisfied,
> then you have to split that range into 3. i.e. the E820_TYPE_RAM range be=
fore tpm_log, the tpm_log
> E820_TYPE_RESERVED range, and the E820_TYPE_RAM range after. There are no=
 helper functions, so this
> splitting involves playing with a lot of pointers, and it looks quite ugl=
y. I believe doing this
> way is more likely to introduce bugs.
>
> If we are having to compensate for an EFI bug, would it make sense to do =
it in the way done
> in RFC and do it in kernel rather than libstub? It is simple and very lik=
ely to be bug free.
>

I don't see how this could be an EFI bug, given that it does not deal
with E820 tables at all.

