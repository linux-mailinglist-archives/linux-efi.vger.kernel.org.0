Return-Path: <linux-efi+bounces-4728-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF196B52936
	for <lists+linux-efi@lfdr.de>; Thu, 11 Sep 2025 08:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D1A2467E6D
	for <lists+linux-efi@lfdr.de>; Thu, 11 Sep 2025 06:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D96E1F5435;
	Thu, 11 Sep 2025 06:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aDqTogg/"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0907B1A9B24
	for <linux-efi@vger.kernel.org>; Thu, 11 Sep 2025 06:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757573224; cv=none; b=oqrvfBi0oub8mlLtK5dQWwb0RR/9+oPr2B6UuU+HxTiDjvnbbKnphhrr84pJVqB6PrWqpZCcQKjEVF7v8aQvNq7LplGZJbhKv9/cD20wpTNTX86lb2VGcUk+1t6qcCjmXLTRd0RYYf9/z4YjPZ+YnsAyX1GA1ZeO4wnRb65Kw4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757573224; c=relaxed/simple;
	bh=UNkEK/+v8YFYH93TXwLCYphEnHYTGoL2h1B5QkNiX5A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=diBjbb+D+Hq7DqXa+6/8Wh2ZdQwTq3ujXeby7vh7UAWHpbhDlYLFeA0Hb9MllDmxo0OnhLBdVtksSnsFfxs0Nu7SdEztYLeSCSStMcrP7QRxhkMWxa0NsZOPel/YzT748oPB47pH2c5uP1xur9Ae/5yzI6WuYH+ZZc8A4hYMWTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aDqTogg/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B20F2C4CEFB
	for <linux-efi@vger.kernel.org>; Thu, 11 Sep 2025 06:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757573223;
	bh=UNkEK/+v8YFYH93TXwLCYphEnHYTGoL2h1B5QkNiX5A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=aDqTogg/x5B5VsSt8/kz5FPgXX7+tYY9sr3Hy5vAQhf81ZQevjSehnV5CXVefe6X7
	 nHfoqQTW5Kub4CbyAFq7syhi2NRtlHxHUk6mkw8oJ5DvbLzz7OE4iKVcqRdNMkrys6
	 fAK3naosSZetHzlqlCqIMdv4SqrD748FMtDzlD6EOVm/Ir7xvwaMdDlf5TykYIduem
	 4j6xg31PBrG5FvD2AO1WMb7TXbK+/4AlR53AioYdR8HP8cszdu7Qx+6Y24U7nlCjK7
	 8Ynhp0YwfffeJOp2COIDnEkXxO6dGIi3/GAr1BlvKNhsTrt9XZlnNbJZxJ6mbL/ELo
	 toUC5ESovhYPw==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-55f716e25d9so323031e87.1
        for <linux-efi@vger.kernel.org>; Wed, 10 Sep 2025 23:47:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX/lU/2EqyNN14pnOvYeSJINIcRdK7PA/raVtJTTp9kQa+1pPXvzLbjVcpj9R+6fovYiq9CpgUokhU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvZ0LQ8ZJ0VDtc/NeHMWZ+umZQOEB1yxV4pfYo8IkW4Gr5pacu
	HfbBM6A31+YIN7rk6z5Y4lsKQk0sSHY7Y/5jI488ElTnH+Jbtx5dHZ9U2wsN6qbiGxDnT5yXPsr
	OkcUG2pCSLoUM6UhBXMWjH/F2Ur+G4c8=
X-Google-Smtp-Source: AGHT+IFPziz6yAUhOMEN9vYJnis370gYAsrnXe7pj2ivzaPBYrP6p3ssblPvJE3LSh39/rPwy90mxH37lGdGB+y+AzI=
X-Received: by 2002:a05:6512:b25:b0:560:8b86:75b9 with SMTP id
 2adb3069b0e04-5625b989121mr5495629e87.0.1757573222026; Wed, 10 Sep 2025
 23:47:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910015738.14848-2-bagasdotme@gmail.com>
In-Reply-To: <20250910015738.14848-2-bagasdotme@gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 11 Sep 2025 08:46:50 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHCi1pr3XNzwe7b7EFBkPGjkppeNWNSvy4wU1VBHj9kfA@mail.gmail.com>
X-Gm-Features: Ac12FXxCOpeQs8heCJzZMxjO42fQ-GoYKFNHg4uenzykKBXf8CyKCUzom2vG158
Message-ID: <CAMj1kXHCi1pr3XNzwe7b7EFBkPGjkppeNWNSvy4wU1VBHj9kfA@mail.gmail.com>
Subject: Re: [PATCH] x86/Documentation: explain LINUX_EFI_INITRD_MEDIA_GUID
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Documentation <linux-doc@vger.kernel.org>, Linux EFI <linux-efi@vger.kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Hugo Osvaldo Barrera <hugo@whynothugo.nl>
Content-Type: text/plain; charset="UTF-8"

On Wed, 10 Sept 2025 at 03:58, Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>
> From: Hugo Osvaldo Barrera <hugo@whynothugo.nl>
>
> Since the Handover Protocol was deprecated, the recommended approach is
> to provide an initrd using a UEFI boot service with the
> LINUX_EFI_INITRD_MEDIA_GUID device path. Documentation for the new
> approach has been no more than an admonition with a link to an existing
> implementation.
>
> Provide a short explanation of this functionality, to ease future
> implementations without having to reverse engineer existing ones.
>
> Signed-off-by: Hugo Osvaldo Barrera <hugo@whynothugo.nl>
> Link: https://lore.kernel.org/r/20250428131206.8656-2-hugo@whynothugo.nl
> [Bagas: Don't use :ref: link to EFI stub documentation]
> Co-developed-by: Bagas Sanjaya <bagasdotme@gmail.com>
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  Documentation/admin-guide/efi-stub.rst |  3 +++
>  Documentation/arch/x86/boot.rst        | 35 ++++++++++++++++++++------
>  2 files changed, 30 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/admin-guide/efi-stub.rst b/Documentation/admin-guide/efi-stub.rst
> index 090f3a185e1897..2f0f040f6913a4 100644
> --- a/Documentation/admin-guide/efi-stub.rst
> +++ b/Documentation/admin-guide/efi-stub.rst
> @@ -79,6 +79,9 @@ because the image we're executing is interpreted by the EFI shell,
>  which understands relative paths, whereas the rest of the command line
>  is passed to bzImage.efi.
>
> +.. hint::
> +   It is also possible to provide an initrd using UEFI boot services. See
> +   :ref:`pe-coff-entry-point` for details.
>

Better say 'using a Linux-specific UEFI protocol at boot time'. The
boot services are a specific set of APIs none of which have anything
to do with initrd loading.

>  The "dtb=" option
>  -----------------
> diff --git a/Documentation/arch/x86/boot.rst b/Documentation/arch/x86/boot.rst
> index 77e6163288db08..fadbe66517bdf2 100644
> --- a/Documentation/arch/x86/boot.rst
> +++ b/Documentation/arch/x86/boot.rst
> @@ -1431,12 +1431,31 @@ The boot loader *must* fill out the following fields in bp::
>  All other fields should be zero.
>
>  .. note::
> -     The EFI Handover Protocol is deprecated in favour of the ordinary PE/COFF
> -     entry point, combined with the LINUX_EFI_INITRD_MEDIA_GUID based initrd
> -     loading protocol (refer to [0] for an example of the bootloader side of
> -     this), which removes the need for any knowledge on the part of the EFI
> -     bootloader regarding the internal representation of boot_params or any
> -     requirements/limitations regarding the placement of the command line
> -     and ramdisk in memory, or the placement of the kernel image itself.
> +   The EFI Handover Protocol is deprecated in favour of the ordinary PE/COFF
> +   entry point described below.
>
> -[0] https://github.com/u-boot/u-boot/commit/ec80b4735a593961fe701cc3a5d717d4739b0fd0
> +.. _pe-coff-entry-point:
> +
> +PE/COFF entry point
> +===================
> +
> +When compiled with ``CONFIG_EFI_STUB=y``, the kernel can be executed as a
> +regular PE/COFF binary. See Documentation/admin-guide/efi-stub.rst for
> +implementation details.
> +
> +The stub loader can request the initrd via a UEFI protocol. For this to work,
> +the firmware or bootloader needs to register a handle which implements the

... which carries implementations of the ``EFI_LOAD_FILE2`` protocol
and the device path protocol exposing the
``LINUX_EFI_INITRD_MEDIA_GUID`` vendor media device path.

> +``EFI_LOAD_FILE2`` protocol with the ``LINUX_EFI_INITRD_MEDIA_GUID`` device
> +path. In this case, a kernel booting via the EFI stub will use the ``LoadFile``
> +function on the registered handle to obtain a reference to the initrd.
> +

... will invoke LoadFile2::LoadFile() method on the registered
protocol to instruct the firmware to load the initrd into a memory
location chosen by the kernel/EFI stub.

> +This approach removes the need for any knowledge on the part of the EFI
> +bootloader regarding the internal representation of boot_params or any
> +requirements/limitations regarding the placement of the command line and
> +ramdisk in memory, or the placement of the kernel image itself.
> +
> +For sample implementations, refer to `the original u-boot implementation`_ or
> +`the implementation in candyboot`_.
> +
> +.. _the original u-boot implementation: https://github.com/u-boot/u-boot/commit/ec80b4735a593961fe701cc3a5d717d4739b0fd0
> +.. _the implementation in candyboot: https://git.sr.ht/~whynothugo/candyboot/tree/4097b2538d7f1cf85f03922bf42409490b666202/item/src/main.rs#L225
>

What is candyboot, and why are we adding this plug for it into the
Linux documentation?

