Return-Path: <linux-efi+bounces-998-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B368B5B24
	for <lists+linux-efi@lfdr.de>; Mon, 29 Apr 2024 16:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B531B1F21A29
	for <lists+linux-efi@lfdr.de>; Mon, 29 Apr 2024 14:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1853277F11;
	Mon, 29 Apr 2024 14:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GcQwUu4F"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EE4762DA;
	Mon, 29 Apr 2024 14:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714400575; cv=none; b=hCDoUHDLpvLf/319n3I2M7fChKCrOzMGkz/xqEadvgHt7RKaVPzzrP6OXivOaoPX42OSa3DfDFBaSc2Yv+6QdZzzE4SR1m0rACpugSyOEYh+Q/RN8LBHr+Ybl7cu7xsPu+cU0FKfPK9pM1OaLAkS7eD8Zw+bXoq2AifghL90QyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714400575; c=relaxed/simple;
	bh=/LW0m0LOAnPc0ufPHxPFom40EYrXG3uvphQo+nXtYvQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NhCEO1UF7dL/nZtni07qd5vLLH6ws/qeHK7ZgINuMHtvQkgv3SGHoYAM0gOObHPXQUJL6/aTfrQbLqaXPzd2l/y/Cuak9sRF+5oF1ump2dtBOSZUsc5+uxV87G6ocVZ8tVqSFtsE9Ky4y+6QTgUhbHwBAzMbZSRj47hplhIPQrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GcQwUu4F; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2dd6a7ae2dcso72164781fa.1;
        Mon, 29 Apr 2024 07:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714400571; x=1715005371; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q5QVpxga4N6/hqXrH0MOQKoldXcmMmAuvc1GZMoLFtI=;
        b=GcQwUu4Fdy5rWSAQTGxuvlGuWNnGl0IShd98sOR7iE4uzJNK7J9YdFzNXLIymxeIjO
         IoHloMzxIyydt4aacwp9gM9txIiYDoy8e+P1Q50cJrtjjnTria5SwY4aKLyAyuuMM7Bt
         DA/lPdi0L4jQWMNW1X/sI+1UOOhO0vUtTIwXtOD13BfFefvOebrWO/Diq9vv1/3PVfXe
         Y7QYYWZAO0hSy/TJSzJNisY7XlM4A+6hLwoADr2QnuqKOkxd3Kc0m7UFDzozL9KDROo7
         ia3De63BNr5lDcO/pLN9stZzNfQepR23ogw1xLWTacuSpGvSB1zroLZQGl52XnI2BJRX
         9zHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714400571; x=1715005371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q5QVpxga4N6/hqXrH0MOQKoldXcmMmAuvc1GZMoLFtI=;
        b=SJ+Ip+lQ8P2C3XCUpE2vLsljshBD18ej2LyPnwU4sLA/UuHUuv9AxS9wRY5+J/NEVs
         ujnTGMhg5ylB8uAVEC/BgVKctKLNi99E6r2ipnGhoZRRixbQZOlumx371zEropE5c0iS
         ztjqjK49hV7eN/8XtdhQ8WNyUzeF5W6kQbh34DUG5M9Twfz84CSg/TIuD99WdlD8k8We
         jsxRRekFALfeJnme5304qJWIOA0d3uD7a83bvIjUIkYngNzu/biOym14whf29XATXE+w
         KPsXu6T7+Wj826b0fzkFMcjV5tQ7UqFBjzT8TiGh0a90+x+aaluJ+UChVjxpSutPIcIq
         y7cw==
X-Forwarded-Encrypted: i=1; AJvYcCVXzOSA/QznXrcylXAMGYv4qX9Axkjb3baBLEOnPUNnEXfC0ViZ3Jy7jt2SMb2s6LEN/G98mFFcJ0u/Oxm+1By0DR2VNkBT5HOBavRBBpI1OLT0aZDWorE+NusbPXf5I76IFkg3eh9a
X-Gm-Message-State: AOJu0YxqNf9L2rF8/aG1myqSrjmwM1RCjROpLX+uG5ra3IaPdrqupNYT
	CsVm1u7ytlwDn2E/NqUl4rjM9/VwdyyIqR8ieLY2ahqfKXl09PGo0UQ/9a05VxffZs7j+sU8fC+
	biu9uUDkmODJ3cufODvp+MbO5r/U=
X-Google-Smtp-Source: AGHT+IFRoXV25WEa7TOCZ5iwFJ1etTgBdopt5lNjuPebhcmXiNyyBP2Ud9FNF6vLlGt/MZCZGxSbztYIte5P6b5QEfY=
X-Received: by 2002:a2e:88d2:0:b0:2d8:8633:ff70 with SMTP id
 a18-20020a2e88d2000000b002d88633ff70mr8656115ljk.30.1714400571081; Mon, 29
 Apr 2024 07:22:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240318020916.1299190-1-haibo1.xu@intel.com> <7d69fac0-4cd1-4db6-b19f-fb5a418549ab@rivosinc.com>
In-Reply-To: <7d69fac0-4cd1-4db6-b19f-fb5a418549ab@rivosinc.com>
From: Haibo Xu <xiaobo55x@gmail.com>
Date: Mon, 29 Apr 2024 22:22:39 +0800
Message-ID: <CAJve8omCXANwhQuvFnhzw_=Fx0fh1pHq+7UYMWS507-2cHVx9A@mail.gmail.com>
Subject: Re: [PATCH v2] riscv: dmi: Add SMBIOS/DMI support
To: Atish Patra <atishp@rivosinc.com>
Cc: Haibo Xu <haibo1.xu@intel.com>, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-efi@vger.kernel.org, 
	aou@eecs.berkeley.edu, palmer@dabbelt.com, paul.walmsley@sifive.com, 
	ardb@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi @Palmer,

Could you please let me know whether this patch was OK for the next RISC-V =
PULL?

Thanks,
Haibo

On Wed, Mar 20, 2024 at 3:46=E2=80=AFAM Atish Patra <atishp@rivosinc.com> w=
rote:
>
> On 3/17/24 19:09, Haibo Xu wrote:
> > Enable the dmi driver for riscv which would allow access the
> > SMBIOS info through some userspace file(/sys/firmware/dmi/*).
> >
> > The change was based on that of arm64 and has been verified
> > by dmidecode tool.
> >
> > Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> > ---
> > Changes since v1
> >    - Change to use memremap/memunmap for dmi_(early)_remap/unmap
> >      definition(suggested by Ard)
> >    - Minor clean up for comments (Ard)
> > ---
> >   arch/riscv/Kconfig                   | 11 +++++++++++
> >   arch/riscv/include/asm/dmi.h         | 24 ++++++++++++++++++++++++
> >   drivers/firmware/efi/riscv-runtime.c | 13 +++++++++++++
> >   3 files changed, 48 insertions(+)
> >   create mode 100644 arch/riscv/include/asm/dmi.h
> >
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index 8ebafe337eac..3639151cb4ef 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -952,6 +952,17 @@ config EFI
> >         allow the kernel to be booted as an EFI application. This
> >         is only useful on systems that have UEFI firmware.
> >
> > +config DMI
> > +     bool "Enable support for SMBIOS (DMI) tables"
> > +     depends on EFI
> > +     default y
> > +     help
> > +       This enables SMBIOS/DMI feature for systems.
> > +
> > +       This option is only useful on systems that have UEFI firmware.
> > +       However, even with this option, the resultant kernel should
> > +       continue to boot on existing non-UEFI platforms.
> > +
> >   config CC_HAVE_STACKPROTECTOR_TLS
> >       def_bool $(cc-option,-mstack-protector-guard=3Dtls -mstack-protec=
tor-guard-reg=3Dtp -mstack-protector-guard-offset=3D0)
> >
> > diff --git a/arch/riscv/include/asm/dmi.h b/arch/riscv/include/asm/dmi.=
h
> > new file mode 100644
> > index 000000000000..ca7cce557ef7
> > --- /dev/null
> > +++ b/arch/riscv/include/asm/dmi.h
> > @@ -0,0 +1,24 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (C) 2024 Intel Corporation
> > + *
> > + * based on arch/arm64/include/asm/dmi.h
> > + *
> > + * This file is subject to the terms and conditions of the GNU General=
 Public
> > + * License.  See the file "COPYING" in the main directory of this arch=
ive
> > + * for more details.
> > + */
> > +
> > +#ifndef __ASM_DMI_H
> > +#define __ASM_DMI_H
> > +
> > +#include <linux/io.h>
> > +#include <linux/slab.h>
> > +
> > +#define dmi_early_remap(x, l)                memremap(x, l, MEMREMAP_W=
B)
> > +#define dmi_early_unmap(x, l)                memunmap(x)
> > +#define dmi_remap(x, l)                      memremap(x, l, MEMREMAP_W=
B)
> > +#define dmi_unmap(x)                 memunmap(x)
> > +#define dmi_alloc(l)                 kzalloc(l, GFP_KERNEL)
> > +
> > +#endif
> > diff --git a/drivers/firmware/efi/riscv-runtime.c b/drivers/firmware/ef=
i/riscv-runtime.c
> > index 09525fb5c240..c3bfb9e77e02 100644
> > --- a/drivers/firmware/efi/riscv-runtime.c
> > +++ b/drivers/firmware/efi/riscv-runtime.c
> > @@ -152,3 +152,16 @@ void arch_efi_call_virt_teardown(void)
> >   {
> >       efi_virtmap_unload();
> >   }
> > +
> > +static int __init riscv_dmi_init(void)
> > +{
> > +     /*
> > +      * On riscv, DMI depends on UEFI, and dmi_setup() needs to
> > +      * be called early because dmi_id_init(), which is an arch_initca=
ll
> > +      * itself, depends on dmi_scan_machine() having been called alrea=
dy.
> > +      */
> > +     dmi_setup();
> > +
> > +     return 0;
> > +}
> > +core_initcall(riscv_dmi_init);
>
> Reviewed-by: Atish Patra <atishp@rivosinc.com>

