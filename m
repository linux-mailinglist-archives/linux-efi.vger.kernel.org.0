Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7E3267766F
	for <lists+linux-efi@lfdr.de>; Mon, 23 Jan 2023 09:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbjAWIkC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 23 Jan 2023 03:40:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbjAWIkB (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 23 Jan 2023 03:40:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F9C1E299;
        Mon, 23 Jan 2023 00:39:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C3EC260DE4;
        Mon, 23 Jan 2023 08:39:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23745C4339C;
        Mon, 23 Jan 2023 08:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674463195;
        bh=4YZwqbg86xvLvLGPid6xYfapdHAz6Kr3musosnHV1mw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QI7ng8ed8/ljgGgmu2aKmVXAursNOO6f8/6ZSm95Ley3/+gT9kzXmK4nZ/vyfVLHc
         W4gPNSLZMaHYfzCFJGKnUBIsoo3PvpIJowjs/jpOyohTlMXR0sa7BSGEek3o6kl60O
         ycTlOUq/+H/Xk98LxFzm/03fXjWrf3nl7VGqa9ZW4JUhiqXqDjWIZGTaC/r/LJbVGP
         TKo9UrnUFaFr9W4s71zcLvpPstJ7wR1oYYCCpdy/xrohP+lSs4WmBQurDLiyxAByZB
         iTt+4FNNFWZrHMU5HyI7qFUQ0pqpcJhyWVCBB+wvTtVRfN6OR4zt7yS4mEccEqBwFt
         tlP43sxKp+M5A==
Received: by mail-lf1-f54.google.com with SMTP id y25so17025675lfa.9;
        Mon, 23 Jan 2023 00:39:55 -0800 (PST)
X-Gm-Message-State: AFqh2krWyWIDwnyHM/oKeJY2NA7fLQt5LBkLnU/mYJ7eG+ng7Ym6X1ks
        mWBALsclxnSDjPZrScgGP5H2QSJsLy2k9ZqSi5o=
X-Google-Smtp-Source: AMrXdXtC5/9kehJA6KURu8uA60DdXgD+f3A8Typ0VI0hdC2FK03x7zUW+H0jeTlOui/BIc3vZfCKP2hQISTfX/xFXyg=
X-Received: by 2002:a05:6512:3086:b0:4bc:bdf5:f163 with SMTP id
 z6-20020a056512308600b004bcbdf5f163mr1230904lfd.583.1674463193116; Mon, 23
 Jan 2023 00:39:53 -0800 (PST)
MIME-Version: 1.0
References: <20230123081905.27283-1-johan+linaro@kernel.org>
In-Reply-To: <20230123081905.27283-1-johan+linaro@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 23 Jan 2023 09:39:41 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGPo4-igHOseNhvoBuS0O2YLd+e=cqD8RJJYSgP0zTi0Q@mail.gmail.com>
Message-ID: <CAMj1kXGPo4-igHOseNhvoBuS0O2YLd+e=cqD8RJJYSgP0zTi0Q@mail.gmail.com>
Subject: Re: [PATCH v2] efi: drop obsolete efivars sysfs documentation
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        kernel test robot <lkp@intel.com>, linux-efi@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 23 Jan 2023 at 09:19, Johan Hovold <johan+linaro@kernel.org> wrote:
>
> The efivars sysfs interface was removed by commit 0f5b2c69a4cb ("efi:
> vars: Remove deprecated 'efivars' sysfs interface").
>
> Remove also the corresponding sysfs ABI documentation.
>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>
> Changes in v2
>  - drop reference in gsmi sysfs documentation
>  - drop reference in efivarfs.rst (kernel test robot)
>

Ugh. So there is a remaining implementation of that interface. That is
a bit disappointing, tbh.

So for now, let's disregard this patch, and I will check internally
whether or not that sysfs gsmi interface is actually used. If it is,
the docs should be kept but updated to clarify that it only describes
gsmi sysfs. Otherwise, we can drop the whole thing, including the gsmi
sysfs pieces themselves.

>
>  .../ABI/stable/sysfs-firmware-efi-vars        | 79 -------------------
>  Documentation/ABI/testing/sysfs-firmware-gsmi |  8 --
>  Documentation/filesystems/efivarfs.rst        |  1 -
>  3 files changed, 88 deletions(-)
>  delete mode 100644 Documentation/ABI/stable/sysfs-firmware-efi-vars
>
> diff --git a/Documentation/ABI/stable/sysfs-firmware-efi-vars b/Documentation/ABI/stable/sysfs-firmware-efi-vars
> deleted file mode 100644
> index 46ccd233e359..000000000000
> --- a/Documentation/ABI/stable/sysfs-firmware-efi-vars
> +++ /dev/null
> @@ -1,79 +0,0 @@
> -What:          /sys/firmware/efi/vars
> -Date:          April 2004
> -Contact:       Matt Domsch <Matt_Domsch@dell.com>
> -Description:
> -               This directory exposes interfaces for interactive with
> -               EFI variables.  For more information on EFI variables,
> -               see 'Variable Services' in the UEFI specification
> -               (section 7.2 in specification version 2.3 Errata D).
> -
> -               In summary, EFI variables are named, and are classified
> -               into separate namespaces through the use of a vendor
> -               GUID.  They also have an arbitrary binary value
> -               associated with them.
> -
> -               The efivars module enumerates these variables and
> -               creates a separate directory for each one found.  Each
> -               directory has a name of the form "<key>-<vendor guid>"
> -               and contains the following files:
> -
> -               =============== ========================================
> -               attributes:     A read-only text file enumerating the
> -                               EFI variable flags.  Potential values
> -                               include:
> -
> -                               EFI_VARIABLE_NON_VOLATILE
> -                               EFI_VARIABLE_BOOTSERVICE_ACCESS
> -                               EFI_VARIABLE_RUNTIME_ACCESS
> -                               EFI_VARIABLE_HARDWARE_ERROR_RECORD
> -                               EFI_VARIABLE_AUTHENTICATED_WRITE_ACCESS
> -
> -                               See the EFI documentation for an
> -                               explanation of each of these variables.
> -
> -               data:           A read-only binary file that can be read
> -                               to attain the value of the EFI variable
> -
> -               guid:           The vendor GUID of the variable.  This
> -                               should always match the GUID in the
> -                               variable's name.
> -
> -               raw_var:        A binary file that can be read to obtain
> -                               a structure that contains everything
> -                               there is to know about the variable.
> -                               For structure definition see "struct
> -                               efi_variable" in the kernel sources.
> -
> -                               This file can also be written to in
> -                               order to update the value of a variable.
> -                               For this to work however, all fields of
> -                               the "struct efi_variable" passed must
> -                               match byte for byte with the structure
> -                               read out of the file, save for the value
> -                               portion.
> -
> -                               **Note** the efi_variable structure
> -                               read/written with this file contains a
> -                               'long' type that may change widths
> -                               depending on your underlying
> -                               architecture.
> -
> -               size:           As ASCII representation of the size of
> -                               the variable's value.
> -               =============== ========================================
> -
> -
> -               In addition, two other magic binary files are provided
> -               in the top-level directory and are used for adding and
> -               removing variables:
> -
> -               =============== ========================================
> -               new_var:        Takes a "struct efi_variable" and
> -                               instructs the EFI firmware to create a
> -                               new variable.
> -
> -               del_var:        Takes a "struct efi_variable" and
> -                               instructs the EFI firmware to remove any
> -                               variable that has a matching vendor GUID
> -                               and variable key name.
> -               =============== ========================================
> diff --git a/Documentation/ABI/testing/sysfs-firmware-gsmi b/Documentation/ABI/testing/sysfs-firmware-gsmi
> index 7a558354c1ee..60fe880b5b44 100644
> --- a/Documentation/ABI/testing/sysfs-firmware-gsmi
> +++ b/Documentation/ABI/testing/sysfs-firmware-gsmi
> @@ -16,14 +16,6 @@ Description:
>
>                 Layout:
>
> -               /sys/firmware/gsmi/vars:
> -
> -                       This directory has the same layout (and
> -                       underlying implementation as /sys/firmware/efi/vars.
> -                       See `Documentation/ABI/*/sysfs-firmware-efi-vars`
> -                       for more information on how to interact with
> -                       this structure.
> -
>                 /sys/firmware/gsmi/append_to_eventlog - write-only:
>
>                         This file takes a binary blob and passes it onto
> diff --git a/Documentation/filesystems/efivarfs.rst b/Documentation/filesystems/efivarfs.rst
> index 0551985821b8..164611ce6f2c 100644
> --- a/Documentation/filesystems/efivarfs.rst
> +++ b/Documentation/filesystems/efivarfs.rst
> @@ -40,4 +40,3 @@ accidentally.
>  *See also:*
>
>  - Documentation/admin-guide/acpi/ssdt-overlays.rst
> -- Documentation/ABI/stable/sysfs-firmware-efi-vars
> --
> 2.39.1
>
