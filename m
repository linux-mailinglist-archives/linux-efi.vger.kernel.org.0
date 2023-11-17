Return-Path: <linux-efi+bounces-52-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E55537EF600
	for <lists+linux-efi@lfdr.de>; Fri, 17 Nov 2023 17:18:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6912F1F25929
	for <lists+linux-efi@lfdr.de>; Fri, 17 Nov 2023 16:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F15171BB;
	Fri, 17 Nov 2023 16:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="l8tkBJCf"
X-Original-To: linux-efi@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E81B3;
	Fri, 17 Nov 2023 08:17:59 -0800 (PST)
Received: from localhost (unknown [75.104.68.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id A3D712F3;
	Fri, 17 Nov 2023 16:17:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net A3D712F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1700237879; bh=mFiWwbKnYfvY3qTIUsUeh4zZYBejY47lhESfh35MH8g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=l8tkBJCfW+xaqYswMUfTtjOw9T5AO/2mQFbZpmr2TYszVaIJwfXyarkk2GaUNUQ7K
	 GVV8ZUL33tpFF16LeI2y7wBq75NDaLEMBdwyMCVsZRBO0VjiYKMMul/sopB0bt3y1d
	 O39/v9voBBW83F6Isvk7fcwQhbmBEOS78sE/9AJrlmhbnrTyIFOq2uWlj/961jmPCX
	 wrFKbEBxSD1dQnYcdzyutfqjhZ+vKVKDOkJgLnFVXDBcrxSJproeCQCSHyIWU1KQY3
	 1Czc/C7BShhTO1yV+3j00FchICtnj7gBC+jsC6OVspSBUScT0k/6hVtpuAyFAzY2sN
	 PyNtUDX4XG6mQ==
From: Jonathan Corbet <corbet@lwn.net>
To: Hunter Chasens <hunter.chasens18@ncf.edu>
Cc: linux-doc@vger.kernel.org, ardb@kernel.org, linux-efi@vger.kernel.org,
 linux-kernel@vger.kernel.org, Hunter Chasens <hunter.chasens18@ncf.edu>
Subject: Re: [PATCH v3 1/2] docs: admin-guide: Update bootloader and
 installation instructions
In-Reply-To: <20231114030208.30479-1-hunter.chasens18@ncf.edu>
References: <20231114030208.30479-1-hunter.chasens18@ncf.edu>
Date: Fri, 17 Nov 2023 09:17:50 -0700
Message-ID: <87wmugwdzl.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hunter Chasens <hunter.chasens18@ncf.edu> writes:

> Updates the bootloader and installation instructions in
> admin-guide/README.rst to align with modern practices.
>
> Details of Changes:
>
>  - Added guidance on using EFISTUB for UEFI/EFI systems.
>  - Noted that LILO is no longer in active development and provides
>    alternatives.
>  - Kept LILO instructions but marked as Legacy LILO Instructions.
>    Suggest removal in future patch.
>
> Signed-off-by: Hunter Chasens <hunter.chasens18@ncf.edu>
> ---
>  Documentation/admin-guide/README.rst | 69 ++++++++++++++++++----------
>  1 file changed, 45 insertions(+), 24 deletions(-)

These seem like good changes in general.  Not too many of us are using
LILO these days...

> diff --git a/Documentation/admin-guide/README.rst b/Documentation/admin-guide/README.rst
> index 9a969c0157f1..ad53f4245379 100644
> --- a/Documentation/admin-guide/README.rst
> +++ b/Documentation/admin-guide/README.rst
> @@ -262,9 +262,11 @@ Compiling the kernel
>   - Make sure you have at least gcc 5.1 available.
>     For more information, refer to :ref:`Documentation/process/changes.rst <changes>`.
>  
> - - Do a ``make`` to create a compressed kernel image. It is also
> -   possible to do ``make install`` if you have lilo installed to suit the
> -   kernel makefiles, but you may want to check your particular lilo setup first.
> + - Do a ``make`` to create a compressed kernel image. It is also possible to do
> +   ``make install`` if you have lilo installed or if your distribution has an
> +   install script recognised by the kernel's installer. Most popular
> +   distributions will have a recognized install script. You may want to
> +   check your distribution's setup first.

Is there a reason to not just suggest looking for installkernel by name?
This seems more obscure than it needs to be.

>     To do the actual install, you have to be root, but none of the normal
>     build should require that. Don't take the name of root in vain.
> @@ -301,32 +303,51 @@ Compiling the kernel
>     image (e.g. .../linux/arch/x86/boot/bzImage after compilation)
>     to the place where your regular bootable kernel is found.
>  
> - - Booting a kernel directly from a floppy without the assistance of a
> -   bootloader such as LILO, is no longer supported.
> -
> -   If you boot Linux from the hard drive, chances are you use LILO, which
> -   uses the kernel image as specified in the file /etc/lilo.conf.  The
> -   kernel image file is usually /vmlinuz, /boot/vmlinuz, /bzImage or
> -   /boot/bzImage.  To use the new kernel, save a copy of the old image
> -   and copy the new image over the old one.  Then, you MUST RERUN LILO
> -   to update the loading map! If you don't, you won't be able to boot
> -   the new kernel image.
> -
> -   Reinstalling LILO is usually a matter of running /sbin/lilo.
> -   You may wish to edit /etc/lilo.conf to specify an entry for your
> -   old kernel image (say, /vmlinux.old) in case the new one does not
> -   work.  See the LILO docs for more information.
> -
> -   After reinstalling LILO, you should be all set.  Shutdown the system,
> + - Booting a kernel directly from non-volatile memory (e.g. a hard drive)

"non-volatile memory" has a bit of a different meaning that could
confuse things here.  "a storage device" perhaps?

> +   without the assistance of a bootloader such as LILO or GRUB, is no longer
> +   supported in BIOS (non-EFI systems). On UEFI/EFI systems, however, you can
> +   use EFISTUB which allows the motherboard to boot directly to the kernel.
> +   On modern workstations and desktops, it's generally recommended to use a
> +   bootloader as difficulties can arise with multiple kernels and secure boot.
> +   For more details on EFISTUB,
> +   see :ref:`Documentation/admin-guide/efi-stub.rst <efi_stub>`.

You can just say "see Documentation/admin-guide/efi-stub.rst" here
without the extra markup.

> + - It's important to note that as of 2016 LILO (LInux LOader) is no longer in
> +   active development, though as it was extremely popular, it often comes up
> +   in documentation. Popular alternatives include GRUB2, rEFInd, Syslinux,
> +   systemd-boot, or EFISTUB. For various reasons, it's not recommended to use
> +   software that's no longer in active development.

I honestly wonder if we need to mention LILO at all here.

> + - Chances are your distribution includes an install script and running
> +   ``make install`` will be all that's needed. Should that not be the case
> +   you'll have to identify your bootloader and reference its documentation or
> +   configure your EFI.

Again, name the script directly.

> +Legacy LILO Instructions
> +------------------------
> +
> +
> + - If you use LILO the kernel images are specified in the file /etc/lilo.conf.
> +   The kernel image file is usually /vmlinuz, /boot/vmlinuz, /bzImage or
> +   /boot/bzImage. To use the new kernel, save a copy of the old image and copy
> +   the new image over the old one. Then, you MUST RERUN LILO to update the
> +   loading map! If you don't, you won't be able to boot the new kernel image.
> +
> + - Reinstalling LILO is usually a matter of running /sbin/lilo. You may wish
> +   to edit /etc/lilo.conf to specify an entry for your old kernel image
> +   (say, /vmlinux.old) in case the new one does not work. See the LILO docs
> +   for more information.
> +
> + - After reinstalling LILO, you should be all set. Shutdown the system,
>     reboot, and enjoy!
>  
> -   If you ever need to change the default root device, video mode,
> -   etc. in the kernel image, use your bootloader's boot options
> -   where appropriate.  No need to recompile the kernel to change
> -   these parameters.
> + - If you ever need to change the default root device, video mode, etc. in the
> +   kernel image, use your bootloader's boot options where appropriate. No need
> +   to recompile the kernel to change these parameters.
>  
>   - Reboot with the new kernel and enjoy.

If it were me I'd probably take this out too...but somebody is bound to
complain.

Thanks,

jon

