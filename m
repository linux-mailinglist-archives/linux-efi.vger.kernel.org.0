Return-Path: <linux-efi+bounces-1297-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA1291862F
	for <lists+linux-efi@lfdr.de>; Wed, 26 Jun 2024 17:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 683491F213AF
	for <lists+linux-efi@lfdr.de>; Wed, 26 Jun 2024 15:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C2EF132127;
	Wed, 26 Jun 2024 15:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GZ+wninq"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770E479CE;
	Wed, 26 Jun 2024 15:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719416811; cv=none; b=YHQNYHoUi3cC+R6ueonWF8H9hbh9QflshCIqs9OKDz0ZvzrBSLrNiQQJs8xQRyD4uTILtX9Z6hH4zMq40ayZtT51Xvsd1sFM8PjiLzkEfi4k00ZpX9XBP4/MdeOZ7TBN3bGkMVJhlcYRlxNr4aEXk9Aiq9/DY7wB/oWQte2UO0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719416811; c=relaxed/simple;
	bh=M7iOQfhE+K7xyixSM8yycnTFGvOrI+nGDITS2CCl6kE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OwQw1RE3Fa7VK3LqI9xJ9S1kknvPZGs4t/+8G0H7fjNWX4zElP4XW0tGdQwR2Ty2M5mAjzs/Jmv3ZtZcv8ERboY9aA0PUIRm5dR5u2+Lj6DTFB4LrrMXR71U8oXC7oeILjykwUH/LC2zmjBiUfXgPThfww+sXvkLM0/+jLZoWEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GZ+wninq; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52cdd03d6aaso4880003e87.0;
        Wed, 26 Jun 2024 08:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719416807; x=1720021607; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w3GZB2PNyOQWwOJr8RHkCwHzcgvUDbBdBBHSJgysLpk=;
        b=GZ+wninq6OfiDTWmVr/vVT+kVaHGE++yR7wLLlgq0YWLSAE6NroAfhQA+pcGSonONf
         7RULG8hf/pvTPxbrUDvAPDG7eLUlLGyuPAmP3sKDYApNBBljv0u3ev3L1m8lVW9MCe+C
         slfi1O87YcXCKaceStvfmn1UtKgOMP5H5TCcOeJpjIha/ZdENzXST/G8o2cVE2coxhNX
         w/CHIaBLg/RCV1wnAU4IV/Gr3Y/Y57HvK8YVt40YWZYjI+UBsI8pvE2ACNZrTNFU0Drc
         csmRJQYocpuehDRy4XA9GRiGoPkAydXF/p5tJJjpAS39o2eBMOkGmI+DDNqHhwgY+wrH
         zhow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719416807; x=1720021607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w3GZB2PNyOQWwOJr8RHkCwHzcgvUDbBdBBHSJgysLpk=;
        b=Uj2Hmeykw+fCL6aFgzt9jt1+S6ABIpxY5SqHZfKweQGROrgiNV2E7oONPL9Jz+duks
         yIMn748NOd3FR38cOqxtWrjxe+C9SqLbBLE0wGMdFWZWvrQdafvPvXth+ejw129eE5S9
         SytJZCxmq23O3XtOtEElD5D+Zfjep1HtVCmdl//Jld3jR8zZo3VN7xAYv9rMgRej8bA3
         //Qwy6jl1/H16DTTg4EKzMnGIS+2VKdGUngPDJ8S944sPlUteGg+aJSdmmWHxOknnT0P
         eNXJmR/EmIkb+KR2sLtRY2Yw+Cp8WOTXCzQjMLqToEv50l+EB7GQJQ12XJasPUEqYS4T
         Ct+g==
X-Forwarded-Encrypted: i=1; AJvYcCXri4x8IdarT00PHB74jlKw4c9Mw8+aSovBQYuqPSBI8H6bHzKG+ghs1YF/81rJV4TLHJdBgBFmkeqVAgge+h0geLyWWrnHU7GMXGhPvXZinDQ940TH6bkkpkT+99epzTuIRodfR2nH
X-Gm-Message-State: AOJu0Yzpy0UvjC81pm1BgNXzrE+2oFlK01OJQX5WYgV9PscSS1wZkdYC
	AL5OogfeVtEvTgz3MybVfOKxCc1HjUH61Ke0bBwYZBKXRSPH42PTFI4jWv7rA6tPspUr0JNXBBB
	LcR1PjepQQ2gxCs+LCQYQK/bS7ho=
X-Google-Smtp-Source: AGHT+IEA4U+AsI1w4tA1Jntk18qJO5tcfEMx08rAjlw5ebhqt1OA+eUryqWgIpQKUlTA1ExragVqtE7l7E4XyJmefa8=
X-Received: by 2002:ac2:5ec1:0:b0:52c:d9f8:b033 with SMTP id
 2adb3069b0e04-52ce063e78amr7232087e87.3.1719416806775; Wed, 26 Jun 2024
 08:46:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJve8onakqwyXNcwtNOLTGah+=pbWzdNBwM64U0htyDJyY3nwQ@mail.gmail.com>
 <mhng-dc33bf67-dbfe-4eb5-b5f6-6c83770dcc3c@palmer-ri-x1c9>
In-Reply-To: <mhng-dc33bf67-dbfe-4eb5-b5f6-6c83770dcc3c@palmer-ri-x1c9>
From: Haibo Xu <xiaobo55x@gmail.com>
Date: Wed, 26 Jun 2024 23:46:34 +0800
Message-ID: <CAJve8okGNbswDt=G=5VbJszDT-W+_7sLHzk3j22b5AdBDeVQvA@mail.gmail.com>
Subject: Re: [PATCH v2] riscv: dmi: Add SMBIOS/DMI support
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Atish Patra <atishp@rivosinc.com>, haibo1.xu@intel.com, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-efi@vger.kernel.org, 
	aou@eecs.berkeley.edu, Paul Walmsley <paul.walmsley@sifive.com>, 
	Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 11:03=E2=80=AFPM Palmer Dabbelt <palmer@dabbelt.com=
> wrote:
>
> On Sun, 26 May 2024 02:17:40 PDT (-0700), xiaobo55x@gmail.com wrote:
> > kindly ping!
> >
> > Any more comments on this patch?
>
> Sorry I dropped the ball on this one, it's queued up for staging and
> should show up on for-next assuming it passes the tests.
>

Thanks!

> >
> > Thanks,
> > Haibo
> >
> > On Mon, Apr 29, 2024 at 10:22=E2=80=AFPM Haibo Xu <xiaobo55x@gmail.com>=
 wrote:
> >>
> >> Hi @Palmer,
> >>
> >> Could you please let me know whether this patch was OK for the next RI=
SC-V PULL?
> >>
> >> Thanks,
> >> Haibo
> >>
> >> On Wed, Mar 20, 2024 at 3:46=E2=80=AFAM Atish Patra <atishp@rivosinc.c=
om> wrote:
> >> >
> >> > On 3/17/24 19:09, Haibo Xu wrote:
> >> > > Enable the dmi driver for riscv which would allow access the
> >> > > SMBIOS info through some userspace file(/sys/firmware/dmi/*).
> >> > >
> >> > > The change was based on that of arm64 and has been verified
> >> > > by dmidecode tool.
> >> > >
> >> > > Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> >> > > ---
> >> > > Changes since v1
> >> > >    - Change to use memremap/memunmap for dmi_(early)_remap/unmap
> >> > >      definition(suggested by Ard)
> >> > >    - Minor clean up for comments (Ard)
> >> > > ---
> >> > >   arch/riscv/Kconfig                   | 11 +++++++++++
> >> > >   arch/riscv/include/asm/dmi.h         | 24 ++++++++++++++++++++++=
++
> >> > >   drivers/firmware/efi/riscv-runtime.c | 13 +++++++++++++
> >> > >   3 files changed, 48 insertions(+)
> >> > >   create mode 100644 arch/riscv/include/asm/dmi.h
> >> > >
> >> > > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> >> > > index 8ebafe337eac..3639151cb4ef 100644
> >> > > --- a/arch/riscv/Kconfig
> >> > > +++ b/arch/riscv/Kconfig
> >> > > @@ -952,6 +952,17 @@ config EFI
> >> > >         allow the kernel to be booted as an EFI application. This
> >> > >         is only useful on systems that have UEFI firmware.
> >> > >
> >> > > +config DMI
> >> > > +     bool "Enable support for SMBIOS (DMI) tables"
> >> > > +     depends on EFI
> >> > > +     default y
> >> > > +     help
> >> > > +       This enables SMBIOS/DMI feature for systems.
> >> > > +
> >> > > +       This option is only useful on systems that have UEFI firmw=
are.
> >> > > +       However, even with this option, the resultant kernel shoul=
d
> >> > > +       continue to boot on existing non-UEFI platforms.
> >> > > +
> >> > >   config CC_HAVE_STACKPROTECTOR_TLS
> >> > >       def_bool $(cc-option,-mstack-protector-guard=3Dtls -mstack-p=
rotector-guard-reg=3Dtp -mstack-protector-guard-offset=3D0)
> >> > >
> >> > > diff --git a/arch/riscv/include/asm/dmi.h b/arch/riscv/include/asm=
/dmi.h
> >> > > new file mode 100644
> >> > > index 000000000000..ca7cce557ef7
> >> > > --- /dev/null
> >> > > +++ b/arch/riscv/include/asm/dmi.h
> >> > > @@ -0,0 +1,24 @@
> >> > > +/* SPDX-License-Identifier: GPL-2.0 */
> >> > > +/*
> >> > > + * Copyright (C) 2024 Intel Corporation
> >> > > + *
> >> > > + * based on arch/arm64/include/asm/dmi.h
> >> > > + *
> >> > > + * This file is subject to the terms and conditions of the GNU Ge=
neral Public
> >> > > + * License.  See the file "COPYING" in the main directory of this=
 archive
> >> > > + * for more details.
> >> > > + */
> >> > > +
> >> > > +#ifndef __ASM_DMI_H
> >> > > +#define __ASM_DMI_H
> >> > > +
> >> > > +#include <linux/io.h>
> >> > > +#include <linux/slab.h>
> >> > > +
> >> > > +#define dmi_early_remap(x, l)                memremap(x, l, MEMRE=
MAP_WB)
> >> > > +#define dmi_early_unmap(x, l)                memunmap(x)
> >> > > +#define dmi_remap(x, l)                      memremap(x, l, MEMRE=
MAP_WB)
> >> > > +#define dmi_unmap(x)                 memunmap(x)
> >> > > +#define dmi_alloc(l)                 kzalloc(l, GFP_KERNEL)
> >> > > +
> >> > > +#endif
> >> > > diff --git a/drivers/firmware/efi/riscv-runtime.c b/drivers/firmwa=
re/efi/riscv-runtime.c
> >> > > index 09525fb5c240..c3bfb9e77e02 100644
> >> > > --- a/drivers/firmware/efi/riscv-runtime.c
> >> > > +++ b/drivers/firmware/efi/riscv-runtime.c
> >> > > @@ -152,3 +152,16 @@ void arch_efi_call_virt_teardown(void)
> >> > >   {
> >> > >       efi_virtmap_unload();
> >> > >   }
> >> > > +
> >> > > +static int __init riscv_dmi_init(void)
> >> > > +{
> >> > > +     /*
> >> > > +      * On riscv, DMI depends on UEFI, and dmi_setup() needs to
> >> > > +      * be called early because dmi_id_init(), which is an arch_i=
nitcall
> >> > > +      * itself, depends on dmi_scan_machine() having been called =
already.
> >> > > +      */
> >> > > +     dmi_setup();
> >> > > +
> >> > > +     return 0;
> >> > > +}
> >> > > +core_initcall(riscv_dmi_init);
> >> >
> >> > Reviewed-by: Atish Patra <atishp@rivosinc.com>

