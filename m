Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15234282207
	for <lists+linux-efi@lfdr.de>; Sat,  3 Oct 2020 09:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725764AbgJCHej (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 3 Oct 2020 03:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725648AbgJCHei (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 3 Oct 2020 03:34:38 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC90C0613E8
        for <linux-efi@vger.kernel.org>; Sat,  3 Oct 2020 00:34:38 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id u19so3972393ion.3
        for <linux-efi@vger.kernel.org>; Sat, 03 Oct 2020 00:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A/hFuD0pWxvAf/6HKfG9LqHPnlCk2KB4TQo/QrnDyUw=;
        b=TSSOyFW/OsE891vjDb7uTsAgAOjucA7X2yx49uUci+QgjTnsFLeKrFPpq0ohIxle46
         oyrDjA0jZtSrhkp4pFV5Wcio2uO/B/9+FhfechaHG/ooSQfldB6CV29GjZE0QtaX4rwy
         u6ogpq2v9R3nGD1Wqzy4jiuRkAvvRUlMAsuhc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A/hFuD0pWxvAf/6HKfG9LqHPnlCk2KB4TQo/QrnDyUw=;
        b=Mej1+8QgmegoP9u+nESF3JJ4g4XsZlr0NkBoSTf1hCWvwYlkgNW0izq+ET3Q3EvPki
         NELdyYES53fK03pws0AOSy/Ewhk7XR3QkYtsHaCGAA7hrGivcPM1BSSEwVVBrbMhSqRD
         YteNc/P9e1bcvjW4tyyp6bgbUjSrz/k4+YDNhetCb6TOdmwAaK11OazYyqrChguzp4kt
         GAB05gv2kTKWl6Uen8wkioVB0iySyvJCvHZHr8t2s0vgPrnrGlj5FvZEvCxao5SBMrPN
         aPhVmVQNpf7vQFFMpghzR4e1CBpm79ZVt2+k/mhRKDknY+nIEROY6VBcxFyRQL2Iwqhc
         Gq4Q==
X-Gm-Message-State: AOAM5314kUGZ7y5l1T9CC0vxelVSO07nQ1LrgQJl58Hg8lXpMoDn0jey
        w9Sktw3oIBnfxRlJKYOib/Q2padDNGq+el3kGJil
X-Google-Smtp-Source: ABdhPJzU47BomkLH2sgLaq0NqpKKKH1s8t8ZcNa8isBsZIYcpKdYr02MEDk1Z/exFcavbhjUVNek9sg3AM9Q6uxaIdA=
X-Received: by 2002:a05:6638:2b3:: with SMTP id d19mr5543487jaq.141.1601710477948;
 Sat, 03 Oct 2020 00:34:37 -0700 (PDT)
MIME-Version: 1.0
References: <20201003063725.8698-1-xypron.glpk@gmx.de> <20201003063725.8698-2-xypron.glpk@gmx.de>
In-Reply-To: <20201003063725.8698-2-xypron.glpk@gmx.de>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Sat, 3 Oct 2020 00:34:27 -0700
Message-ID: <CAOnJCU+kit2dHihTad9UPYUmN0+EAdVN9m97ibs=Jnu44Qe_LQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] docs: admin-guide: fdt and initrd load in EFI stub
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Oct 2, 2020 at 11:38 PM Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> Describe how a device tree and an initial RAM disk can be passed to the EFI
> Boot Stub.
>
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> ---
> v2:
>         mention EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER (thx Atish)
> ---
>  Documentation/admin-guide/efi-stub.rst | 35 ++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>
> diff --git a/Documentation/admin-guide/efi-stub.rst b/Documentation/admin-guide/efi-stub.rst
> index 833edb0d0bc4..4965dec48af4 100644
> --- a/Documentation/admin-guide/efi-stub.rst
> +++ b/Documentation/admin-guide/efi-stub.rst
> @@ -38,6 +38,34 @@ arch/arm/boot/zImage should be copied to the system partition, and it
>  may not need to be renamed. Similarly for arm64, arch/arm64/boot/Image
>  should be copied but not necessarily renamed.
>
> +Passing an initial RAM disk to the EFI Boot Stub
> +------------------------------------------------
> +
> +The following means sorted by decreasing priority can be used to provide an
> +initial RAM disk to the EFI Boot Stub:
> +
> +* The firmware may provide a UEFI Load File 2 Protocol. The stub will try to
> +  load the RAM disk by calling the LoadFile() service of the protocol using
> +  a vendor device path with the vendor GUID
> +  5568e427-0x68fc-4f3d-ac74-ca555231cc68.
> +* Next the EFI stub will try to load the file indicated by the "initrd=" command
> +  line parameter if CONFIG_EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER is enabled.
> +* The prior boot stage may pass the location of the initial RAM disk via the
> +  "linux,initrd-start" and "linux,initrd-end" properties of the "/chosen" node
> +  of the device-tree.
> +

Should we also specify which method is enabled by default for which
ARCH and recommended methods?

For example, It's recommended to use the LoadFile method for RISC-V
and new ARM systems.
Existing ARM ones will continue to use the initrd argument as that's
the method enabled by default.

> +The first two items are inhibited by the "noinitrd" command line parameter.
> +
> +Passing a device-tree to the EFI Boot Stub
> +------------------------------------------
> +
> +A device-tree can be passed to the EFI Boot Stub in decreasing priority using
> +
> +* command line option dtb=
> +* a UEFI configuration table with GUID b1b621d5-f19c-41a5-830b-d9152c69aae0.
> +

I am just curious. Is there any specific reason why efistub tries to
load the dtb from the command line first
and loads from the config table only if it fails from the first approach ?

> +The command line option is only available if CONFIG_EFI_ARMSTUB_DTB_LOADER=y
> +and secure boot is disabled.
>
>  Passing kernel parameters from the EFI shell
>  --------------------------------------------
> @@ -46,6 +74,10 @@ Arguments to the kernel can be passed after bzImage.efi, e.g.::
>
>         fs0:> bzImage.efi console=ttyS0 root=/dev/sda4
>
> +The "noinitrd" option
> +---------------------
> +
> +The "noinitrd" option stops the EFI stub from loading an initial RAM disk.
>
>  The "initrd=" option
>  --------------------
> @@ -98,3 +130,6 @@ CONFIGURATION TABLE.
>
>  "dtb=" is processed in the same manner as the "initrd=" option that is
>  described above.
> +
> +This option is only available if CONFIG_EFI_ARMSTUB_DTB_LOADER=y and secure
> +boot is disabled.
> --
> 2.28.0
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv



-- 
Regards,
Atish
