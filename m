Return-Path: <linux-efi+bounces-1085-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C413C8CF2FB
	for <lists+linux-efi@lfdr.de>; Sun, 26 May 2024 11:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5B5A1C20FAA
	for <lists+linux-efi@lfdr.de>; Sun, 26 May 2024 09:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99DB47462;
	Sun, 26 May 2024 09:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WtB4/Jh/"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF48F8F40;
	Sun, 26 May 2024 09:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716715077; cv=none; b=Yfpm/v8gjE0/n7c36e65KuWFcw6oFpelnAEBOWDKjYH/3pE27nIL/fLIIZFvvxWDQPia1qPToA4K2DCbsUVYeSP7gTdrvW5+X4b9UtzhTA9txmQVe83CfViuGtMmag6YnaKSFoX8UY4S6ffgQ2i8FmO6kflbsARlFJXloOYbdyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716715077; c=relaxed/simple;
	bh=RQd7eI50+omXgehX6fPqPQWqKoV3t7pNAGyZICWOLas=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pMRMlq0IzP+dAl1Rk9Ae+JbfqpQA784CvpZ4WYsbi6pg02bd4Fd9tqRlnPQybAEZFLz94EJvnq2L2e3exxiTtrfTkeSx2oPsWFZ+7xxsT/11rLC4ByfdrmUfTDLPv8GFZztR+pPJ5EZd0zqKZHTl3PZJdVLYMcQ7AO3cls0+Kic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WtB4/Jh/; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-529682e013dso2284205e87.3;
        Sun, 26 May 2024 02:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716715074; x=1717319874; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=goyX40MpO9c6U+QncCsJjuNFHpMKeUPXDPypSlJzumE=;
        b=WtB4/Jh/vk3pgZBElW5J+VutLxDBEEvEqH0IlXU6ZNaZsLwEXqtCl8jL+smb7mRqpo
         qDHl8bjzvdl1i/1gRo+QMr7yzbS6tqA7qGk5cS+LR/9oQz66l4Y9rh1pB8RfUKNrxE0v
         H1iWWeMzDyxM6F74s5l6jjIsm1i5yvgP5s468Oamlk8VEAt1uxZGq1KHWM+KsdTuY7uu
         qc+Vb65DeQfdCHelK08rA9LSJUBpfU7yRb0P5ygeD2dG3xWmnHg3Oo4OagpAGFzFTG4h
         Dlen687kX4pLp0SK3O55jK57Q8jsOX2pn7KO4ltR3mpEpZMVcYGvbaWJoqaqhK+wLnvL
         nN2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716715074; x=1717319874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=goyX40MpO9c6U+QncCsJjuNFHpMKeUPXDPypSlJzumE=;
        b=aVcfdkQqQRx4f25VFen1RnJpHGpELzHRil3eqZdSm9O5UyPdPQi0nFegdeVxjkvYAG
         lIx5pTwcSmop+NFvXInlC5+bUL8JMZXme7usjHGUQVUOUOyrWjepOwzYoB/F3QiEU3HR
         z2/QGVBSCD9PX0zIi7I45AjvmOR3doJEvzem4J9M7prID0KzVq8gU/RETJARRpmFb48W
         NlSWm9ZVUKgkIdXEZNaaAw4Fx67Fh/D8ReA4kDbmjU9t3MkcmAyCPtBYpHU6ylRfgEJW
         GOclvpsshMSP1KIUFAPHomkq5TyubKTUjtHM86OxGPzIqsuS/1gD2flAP6MNe4Yu8Ccy
         glhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTornuiKLuYBgO080etPwbM+PHOeCcJ3cwmJK36tNGBkjdHAmlB0n1ffSNATgW0lg0CM75bmJc9OR6bZ1IaOiSBA2uorHfAwZpbx6APxtNR4QADrb6/xS0Bz7xYW1uzfRbe8DIQYIj
X-Gm-Message-State: AOJu0YxObgqm1fhwEt9qpeY9D2PqIWarTDjpmNDlH4cIDmJBs3aa9Uxq
	ItZ0+wjpJY3rVwEQ3ISA+61oxbziWPJlwDVUp2pT22GtTzPSBLl+QxWg1ZXBpvs22wytayr47iE
	UPufSPD+5sLoQrXWkBK8oHkBGOww=
X-Google-Smtp-Source: AGHT+IHP85Brq+zt9olJsBLOeg9dcYitYeyb2WMPISwr4bI9K1IleEX3PFCqN4Rigizc63Rp2MbOeUGgS4+9gFhaROk=
X-Received: by 2002:ac2:43b7:0:b0:51f:b781:72a7 with SMTP id
 2adb3069b0e04-52966ab5947mr4122035e87.60.1716715073409; Sun, 26 May 2024
 02:17:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240318020916.1299190-1-haibo1.xu@intel.com> <7d69fac0-4cd1-4db6-b19f-fb5a418549ab@rivosinc.com>
 <CAJve8omCXANwhQuvFnhzw_=Fx0fh1pHq+7UYMWS507-2cHVx9A@mail.gmail.com>
In-Reply-To: <CAJve8omCXANwhQuvFnhzw_=Fx0fh1pHq+7UYMWS507-2cHVx9A@mail.gmail.com>
From: Haibo Xu <xiaobo55x@gmail.com>
Date: Sun, 26 May 2024 17:17:40 +0800
Message-ID: <CAJve8onakqwyXNcwtNOLTGah+=pbWzdNBwM64U0htyDJyY3nwQ@mail.gmail.com>
Subject: Re: [PATCH v2] riscv: dmi: Add SMBIOS/DMI support
To: Atish Patra <atishp@rivosinc.com>
Cc: Haibo Xu <haibo1.xu@intel.com>, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-efi@vger.kernel.org, 
	aou@eecs.berkeley.edu, palmer@dabbelt.com, paul.walmsley@sifive.com, 
	ardb@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

kindly ping!

Any more comments on this patch?

Thanks,
Haibo

On Mon, Apr 29, 2024 at 10:22=E2=80=AFPM Haibo Xu <xiaobo55x@gmail.com> wro=
te:
>
> Hi @Palmer,
>
> Could you please let me know whether this patch was OK for the next RISC-=
V PULL?
>
> Thanks,
> Haibo
>
> On Wed, Mar 20, 2024 at 3:46=E2=80=AFAM Atish Patra <atishp@rivosinc.com>=
 wrote:
> >
> > On 3/17/24 19:09, Haibo Xu wrote:
> > > Enable the dmi driver for riscv which would allow access the
> > > SMBIOS info through some userspace file(/sys/firmware/dmi/*).
> > >
> > > The change was based on that of arm64 and has been verified
> > > by dmidecode tool.
> > >
> > > Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> > > ---
> > > Changes since v1
> > >    - Change to use memremap/memunmap for dmi_(early)_remap/unmap
> > >      definition(suggested by Ard)
> > >    - Minor clean up for comments (Ard)
> > > ---
> > >   arch/riscv/Kconfig                   | 11 +++++++++++
> > >   arch/riscv/include/asm/dmi.h         | 24 ++++++++++++++++++++++++
> > >   drivers/firmware/efi/riscv-runtime.c | 13 +++++++++++++
> > >   3 files changed, 48 insertions(+)
> > >   create mode 100644 arch/riscv/include/asm/dmi.h
> > >
> > > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > > index 8ebafe337eac..3639151cb4ef 100644
> > > --- a/arch/riscv/Kconfig
> > > +++ b/arch/riscv/Kconfig
> > > @@ -952,6 +952,17 @@ config EFI
> > >         allow the kernel to be booted as an EFI application. This
> > >         is only useful on systems that have UEFI firmware.
> > >
> > > +config DMI
> > > +     bool "Enable support for SMBIOS (DMI) tables"
> > > +     depends on EFI
> > > +     default y
> > > +     help
> > > +       This enables SMBIOS/DMI feature for systems.
> > > +
> > > +       This option is only useful on systems that have UEFI firmware=
.
> > > +       However, even with this option, the resultant kernel should
> > > +       continue to boot on existing non-UEFI platforms.
> > > +
> > >   config CC_HAVE_STACKPROTECTOR_TLS
> > >       def_bool $(cc-option,-mstack-protector-guard=3Dtls -mstack-prot=
ector-guard-reg=3Dtp -mstack-protector-guard-offset=3D0)
> > >
> > > diff --git a/arch/riscv/include/asm/dmi.h b/arch/riscv/include/asm/dm=
i.h
> > > new file mode 100644
> > > index 000000000000..ca7cce557ef7
> > > --- /dev/null
> > > +++ b/arch/riscv/include/asm/dmi.h
> > > @@ -0,0 +1,24 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +/*
> > > + * Copyright (C) 2024 Intel Corporation
> > > + *
> > > + * based on arch/arm64/include/asm/dmi.h
> > > + *
> > > + * This file is subject to the terms and conditions of the GNU Gener=
al Public
> > > + * License.  See the file "COPYING" in the main directory of this ar=
chive
> > > + * for more details.
> > > + */
> > > +
> > > +#ifndef __ASM_DMI_H
> > > +#define __ASM_DMI_H
> > > +
> > > +#include <linux/io.h>
> > > +#include <linux/slab.h>
> > > +
> > > +#define dmi_early_remap(x, l)                memremap(x, l, MEMREMAP=
_WB)
> > > +#define dmi_early_unmap(x, l)                memunmap(x)
> > > +#define dmi_remap(x, l)                      memremap(x, l, MEMREMAP=
_WB)
> > > +#define dmi_unmap(x)                 memunmap(x)
> > > +#define dmi_alloc(l)                 kzalloc(l, GFP_KERNEL)
> > > +
> > > +#endif
> > > diff --git a/drivers/firmware/efi/riscv-runtime.c b/drivers/firmware/=
efi/riscv-runtime.c
> > > index 09525fb5c240..c3bfb9e77e02 100644
> > > --- a/drivers/firmware/efi/riscv-runtime.c
> > > +++ b/drivers/firmware/efi/riscv-runtime.c
> > > @@ -152,3 +152,16 @@ void arch_efi_call_virt_teardown(void)
> > >   {
> > >       efi_virtmap_unload();
> > >   }
> > > +
> > > +static int __init riscv_dmi_init(void)
> > > +{
> > > +     /*
> > > +      * On riscv, DMI depends on UEFI, and dmi_setup() needs to
> > > +      * be called early because dmi_id_init(), which is an arch_init=
call
> > > +      * itself, depends on dmi_scan_machine() having been called alr=
eady.
> > > +      */
> > > +     dmi_setup();
> > > +
> > > +     return 0;
> > > +}
> > > +core_initcall(riscv_dmi_init);
> >
> > Reviewed-by: Atish Patra <atishp@rivosinc.com>

