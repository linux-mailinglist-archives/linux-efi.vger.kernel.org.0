Return-Path: <linux-efi+bounces-776-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D106875EA9
	for <lists+linux-efi@lfdr.de>; Fri,  8 Mar 2024 08:38:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46F35B23047
	for <lists+linux-efi@lfdr.de>; Fri,  8 Mar 2024 07:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68AB64F1FB;
	Fri,  8 Mar 2024 07:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UT3fPqR1"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C434EB49;
	Fri,  8 Mar 2024 07:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709883513; cv=none; b=oehSxCEhlcfDKvFWTXcFHBvMAev999YoK/2AenAMRNyx0jc10p6bEplT1fDrGHD9f6jpC4mYsp3+h4gp5Xlsa8I6mWXkm4+Zw6MNj1CHd/jmHxuItQAgHMidAREQSZNqU6+T4o13yUJEGJ7o+uCMgurG4lEtlv5njIh4hAwoXG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709883513; c=relaxed/simple;
	bh=k4zLKYhyCGr26WYVbIckZEF+Uc4ZGsgM7GdKazOgOM8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aKynSP84WW+mbfn4nwA3oGAe+QK4Er0/uiY26xlGFaZbIcug0ZGqJClz5hCBEgw3L5sEoWiNXLcfdFvxTvbgD45X1GVd92mXVOwdZstFhi+fMNQhoiFmXlRmcOViuZsqZhonMij89gOrQD7N741OIdly/3jCtbKDf0r1ZZggL/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UT3fPqR1; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-512e4f4e463so2427942e87.1;
        Thu, 07 Mar 2024 23:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709883509; x=1710488309; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WQAkvdiUkr5StdP/yppIaHyxE5vK72hC1JwtmqddXFw=;
        b=UT3fPqR1E7dJFF9lk6fVR/vteH242ogMm8mHXkMRQxD0CdkcuCuKPGHDvBaCCjcbT7
         OCsdfVYIivBAlYMFqCI+x9p0o9HFIb1LzOOdBei+0OYW7J5k28G7Sj/EXvVO2JBhzuLI
         U8dw013u4f7vetds8fHvJcG7W9CUJDaag2DqJ99SSnA6+N/gsY0daCGNgx7dIPI0Y+2q
         TXoKTxjpDMj3mWWjqvNSx2ttpOkDKdxSI2D+f2HvuCVkOunlsUlf6aYTL8O/eu4ypcnA
         szKW7jEp2UfWn/TxaQOG5k5+8xMYByNclvRFYB46iY5M3oufM5ZT7t7F7Xx/dLnXXPkA
         S5rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709883509; x=1710488309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WQAkvdiUkr5StdP/yppIaHyxE5vK72hC1JwtmqddXFw=;
        b=oJK5q+5eh0MIW+DrMi6XJdrGK62bQGRhBCkVoSaRJigfmyG/jU3OFP1RBZ9S8qzZis
         /zuPT+WmgwpiHrmT8p17urEXyq7rJg5Fj5ZGYiQkCGht4YIPQtitzT/nCI4GSHGrzR8T
         pCDxs57HdLeIoPPPA6nvoQkq3Nk5PFRe9KGkEK6OEwKBzV9zcHWpkaVS3pBhwmlbUPOu
         tWTbzuZCc50qU66MGhDFpXqE95SSI/h1rj57XPMTTnPrQBuYbFndxJR7+Ob/qK3cHtK1
         o8BTUOSFPbp2gXlg963qecqVib9zOvGKArc/YcjAphClRJ7b4OBtz1b8EiIxPnKeIKeD
         GObw==
X-Forwarded-Encrypted: i=1; AJvYcCVIvOuNNYQvhq/bVuUQYol1iubN8tu4qJHn9p2QYaSxbUvY1PHvwRNxv+l1OtGG98+cdixn2tPvNgp+VMp0rtU0tbzn7/+3BFOH3O7+vsD7n91HUDHP5l+sPrnoi4dKHzAFKTb5PGWB
X-Gm-Message-State: AOJu0YyqSWMUtQgZUgPaP2VkEgIspSMi+gFVCqLUVLrHeEdGKixJmwSX
	X2fKUOENA7n30RNpM4OxdV5BPo5DXLCYUMnWoc2MT81T7NdusgK6myh3ZIdDFHenH9RprpnLhZY
	MA9kukSBZhFLMB7whkUD/4r0LTRM=
X-Google-Smtp-Source: AGHT+IF7G6Xk/L/aKLhElFAzkpvBNtVrF1Oyi1lLAdilAWOuLZetAVg+DcZcpdxSjWmHuxxJno1Fz6k/kcFcerGICMk=
X-Received: by 2002:a19:7614:0:b0:513:1e2a:f9c5 with SMTP id
 c20-20020a197614000000b005131e2af9c5mr2915212lff.17.1709883509072; Thu, 07
 Mar 2024 23:38:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307083154.346542-1-haibo1.xu@intel.com> <CAMj1kXGF_PNLYsLugQnm=gW08XuLEbd_C0-4YYzkH1aYRGSaYg@mail.gmail.com>
In-Reply-To: <CAMj1kXGF_PNLYsLugQnm=gW08XuLEbd_C0-4YYzkH1aYRGSaYg@mail.gmail.com>
From: Haibo Xu <xiaobo55x@gmail.com>
Date: Fri, 8 Mar 2024 15:38:17 +0800
Message-ID: <CAJve8ok1E3viWwQS3+mwt02i07BfA5wAnmhOpTALpEEuuGkpEw@mail.gmail.com>
Subject: Re: [PATCH] riscv: dmi: Add SMBIOS/DMI support
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Haibo Xu <haibo1.xu@intel.com>, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-efi@vger.kernel.org, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	sunilvl@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 7, 2024 at 7:00=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> wro=
te:
>
> Hello Haibo,
>
> Some notes below.
>
> On Thu, 7 Mar 2024 at 09:18, Haibo Xu <haibo1.xu@intel.com> wrote:
> >
> > Enable the dmi driver for riscv which would allow access the
> > SMBIOS info through some userspace file(/sys/firmware/dmi/*).
> >
> > The change was based on that of arm64 and has been verified
> > by dmidecode tool.
> >
> > Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> > ---
> >  arch/riscv/Kconfig                   | 11 +++++++++++
> >  arch/riscv/include/asm/dmi.h         | 29 ++++++++++++++++++++++++++++
> >  drivers/firmware/efi/riscv-runtime.c | 13 +++++++++++++
> >  3 files changed, 53 insertions(+)
> >  create mode 100644 arch/riscv/include/asm/dmi.h
> >
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index 0bfcfec67ed5..a123a3e7e5f3 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -918,6 +918,17 @@ config EFI
> >           allow the kernel to be booted as an EFI application. This
> >           is only useful on systems that have UEFI firmware.
> >
> > +config DMI
> > +       bool "Enable support for SMBIOS (DMI) tables"
> > +       depends on EFI
> > +       default y
> > +       help
> > +         This enables SMBIOS/DMI feature for systems.
> > +
> > +         This option is only useful on systems that have UEFI firmware=
.
> > +         However, even with this option, the resultant kernel should
> > +         continue to boot on existing non-UEFI platforms.
> > +
> >  config CC_HAVE_STACKPROTECTOR_TLS
> >         def_bool $(cc-option,-mstack-protector-guard=3Dtls -mstack-prot=
ector-guard-reg=3Dtp -mstack-protector-guard-offset=3D0)
> >
> > diff --git a/arch/riscv/include/asm/dmi.h b/arch/riscv/include/asm/dmi.=
h
> > new file mode 100644
> > index 000000000000..a861043f02dc
> > --- /dev/null
> > +++ b/arch/riscv/include/asm/dmi.h
> > @@ -0,0 +1,29 @@
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
> > +/*
> > + * According to section 2.3.6 of the UEFI spec, the firmware should no=
t
> > + * request a virtual mapping for configuration tables such as SMBIOS.
> > + * This means we have to map them before use.
> > + */
>
> You can drop this comment, it is not really accurate.
>
> 'Requesting a virtual mapping' means the memory is mapped by the OS
> into the EFI page tables before calling a runtime service, so that the
> firmware (which runs under the OS's memory translation regime) can
> access the contents.
>
> SMBIOS tables are informational and for consumption by the OS only,
> not by the runtime service implementations themselves, and so they can
> be omitted from the EFI runtime page tables.
>

Sure. Thanks for elaborating on it and it's very helpful!

> > +#define dmi_early_remap(x, l)          ioremap_prot(x, l, _PAGE_KERNEL=
)
> > +#define dmi_early_unmap(x, l)          iounmap(x)
> > +#define dmi_remap(x, l)                        ioremap_prot(x, l, _PAG=
E_KERNEL)
> > +#define dmi_unmap(x)                   iounmap(x)
>
> Why not use memremap() here? That will reuse the linear map if it
> happens to already cover the region.
>

Yes, memremap() is better here. Will update it in v2.
Thank you for the review!

> > +#define dmi_alloc(l)                   kzalloc(l, GFP_KERNEL)
> > +
> > +#endif
> > diff --git a/drivers/firmware/efi/riscv-runtime.c b/drivers/firmware/ef=
i/riscv-runtime.c
> > index 09525fb5c240..c3bfb9e77e02 100644
> > --- a/drivers/firmware/efi/riscv-runtime.c
> > +++ b/drivers/firmware/efi/riscv-runtime.c
> > @@ -152,3 +152,16 @@ void arch_efi_call_virt_teardown(void)
> >  {
> >         efi_virtmap_unload();
> >  }
> > +
> > +static int __init riscv_dmi_init(void)
> > +{
> > +       /*
> > +        * On riscv, DMI depends on UEFI, and dmi_setup() needs to
> > +        * be called early because dmi_id_init(), which is an arch_init=
call
> > +        * itself, depends on dmi_scan_machine() having been called alr=
eady.
> > +        */
> > +       dmi_setup();
> > +
> > +       return 0;
> > +}
> > +core_initcall(riscv_dmi_init);
> > --
> > 2.34.1
> >
> >

