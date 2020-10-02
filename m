Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2034A281918
	for <lists+linux-efi@lfdr.de>; Fri,  2 Oct 2020 19:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387957AbgJBRWG (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 2 Oct 2020 13:22:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:36330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726175AbgJBRWG (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 2 Oct 2020 13:22:06 -0400
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0847020679;
        Fri,  2 Oct 2020 17:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601659326;
        bh=8B3ajfrrr/Rm5NpX3zNhjHSB7gg5E+Rs6FLpsOjO7i4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lWZyzOJpapjQpA455YXsIZVL7VqaXMbB/A2IqiEutsdg98DBHFjMpTSTw2TkXaG3H
         pORFQt+baBV+E6jK5QUiWsRroyRBYIGPTsDYUi89B7Ld1yFod0e5MKxjNG3ngBwsqO
         7rvys/97/D/WV0YPu4gQUgMn3DQbrTDO2VIospe0=
Received: by mail-ot1-f44.google.com with SMTP id 60so2098486otw.3;
        Fri, 02 Oct 2020 10:22:06 -0700 (PDT)
X-Gm-Message-State: AOAM531LPb8j0iBMggxMunQOxLAsojH9m1eeRP6UABhYREdxoJpnGM4G
        DDlfeQCV/I4i1ZGEvf+owvEa5Pn/EC/gHQwPg4w=
X-Google-Smtp-Source: ABdhPJzGwYam8D7RzG6/2OxiOvDt5Rogji+L7HVZMzs+te3CDO0AywQrFo8JqpB2vzN3MK8VypeeMuyxliVhhB+QE5A=
X-Received: by 2002:a9d:335:: with SMTP id 50mr2353365otv.90.1601659325331;
 Fri, 02 Oct 2020 10:22:05 -0700 (PDT)
MIME-Version: 1.0
References: <20201002171112.22738-1-xypron.glpk@gmx.de>
In-Reply-To: <20201002171112.22738-1-xypron.glpk@gmx.de>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 2 Oct 2020 19:21:54 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHsGcAX-DqfcpgxzZY3M+JzY-Ef9OdJ+JdysNnx1fK6zg@mail.gmail.com>
Message-ID: <CAMj1kXHsGcAX-DqfcpgxzZY3M+JzY-Ef9OdJ+JdysNnx1fK6zg@mail.gmail.com>
Subject: Re: [PATCH 1/1] docs: admin-guide: fdt and initrd load in EFI stub
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Fran=C3=A7ois_Ozog?= <francois.ozog@linaro.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Heinrich,

Thanks for documenting this.


On Fri, 2 Oct 2020 at 19:11, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> Describe how a device tree and an initial RAM disk can be passed to the EFI
> Boot Stub.
>
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> ---
>  Documentation/admin-guide/efi-stub.rst | 35 ++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>
> diff --git a/Documentation/admin-guide/efi-stub.rst b/Documentation/admin-guide/efi-stub.rst
> index 833edb0d0bc4..86f50a33884c 100644
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
> +  line parameter.
> +* The prior boot stage may pass the location of the initial RAM disk via the
> +  "linux,initrd-start" and "linux,initrd-end" properties of the "/chosen" node
> +  of the device-tree.
> +

On x86, the boot_params struct is used to pass the address and size of
the initrd in memory. Maybe include that for completeness?

> +The first two items are inhibited by the "noinitrd" command line parameter.
> +

Interesting. Are you saying noinitrd is ignored by the kernel itself?

Looking at the code, it might only work for preventing the load of old
style initrd ramdisks, whereas initramfs images are handled
separately.

This is something that we should probably fix one way or the other.


> +Passing a device-tree to the EFI Boot Stub
> +------------------------------------------
> +
> +A device-tree can be passed to the EFI Boot Stub in decreasing priority using
> +
> +* command line option dtb=
> +* a UEFI configuration table with GUID b1b621d5-f19c-41a5-830b-d9152c69aae0.
> +
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
