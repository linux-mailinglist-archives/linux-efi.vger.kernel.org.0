Return-Path: <linux-efi+bounces-1439-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E7C932A3D
	for <lists+linux-efi@lfdr.de>; Tue, 16 Jul 2024 17:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0583C1C209AD
	for <lists+linux-efi@lfdr.de>; Tue, 16 Jul 2024 15:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB8719DF5B;
	Tue, 16 Jul 2024 15:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OStJuxMG"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021332B9B3;
	Tue, 16 Jul 2024 15:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721143039; cv=none; b=s9f/ra3qQakjaii3P+GlWnEduH5kfeKKkgqjcAF13wX/0KYSIN3K7zfOitsywy660azbzAPewdwywwJsutgRKyln0i9Ar5gbxxUdpROlggbPeQFeoORAYQ8BLwVQj8JWq4KnDY/bPb3zWcuz87IQ1nZTwwzOKlHbYBsnvIyeSpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721143039; c=relaxed/simple;
	bh=aPtkDon0fbJqih4uVR9A9V0XEADmRixC6/HZP3ixjcU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SJIkXdsKyfj5nNGpkvYGIWfebiARiyv6zDrm/niqStvsr2nqAWG55YPRoxpbkKKHYH/DyZFFqQLviB8F1VkTJ7+hHyqEOMlkR3Wq386tl2JNg2PJECChyreSDTLjrE1TNcANAH0RiugoHLWP/sma/ufz7RauNKQrNgQ5dJ8I6XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OStJuxMG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7539FC4AF16;
	Tue, 16 Jul 2024 15:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721143038;
	bh=aPtkDon0fbJqih4uVR9A9V0XEADmRixC6/HZP3ixjcU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OStJuxMGNf9E4N7aPla00MkyLckmcowT/RVS9OvxJzZhsomXeQJQe7YsuInEbNfo/
	 3HkD/P5S8g1ogojfW4mnT7BbdW2jrbKbX24IiWzl4CW9mzxwSlCYO48AI0dkeUNI94
	 Ryfom9DbqAn2TLlSI9aEFtmZV/2pWYiC+B9PW6X80mqwjv7o6XlXB3jhUBHhfcAuvN
	 KcoI+Yh/ano29inhTp+T8STcGM1u6aqKcLFzgN3lRzEHmu34/6D4fAmsSPDpwC8QrE
	 667UJ1UpTX+hBQMUUfznT+4apeKrYmyaCEEhLr+mSAjq1Uqmfku1NKA/IRob9pMyMX
	 WxSjXAQYN+52g==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52ea5765e75so6850444e87.0;
        Tue, 16 Jul 2024 08:17:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW5iQz8xWxI8ZY1hNOjjI6WMjxu3Mk+PqlzOVLntQS2el3WiDftUGr8o3+eAzcJ3Zz3lkkWdYiqrZM/jGiAPwjUaWHz0UpLSEK8yb6V/X9PTQKbJrIg1r74mGQaYtYPmZKLYqoP2eNW
X-Gm-Message-State: AOJu0Yzc3al7oxwrihSvGiG1v/08VfHq1Q5IaWdzcklsMy7/ktRRNG8W
	aFOlHa0KHdERiQvxEgouLixaLqjqBciJbmsOEo5/PTFK62y8hg4obu0TmlW2W3YKvJuJesupBKp
	wF557bJWaHJfVWXuxLPxpaYKsrwo=
X-Google-Smtp-Source: AGHT+IFXMyRqVEuv0lOnARYZkpoy4q6bG9QB8sGhRLJi8OPsread22Hc+2bdOi+Zy5Y6+YCk5vlxTdBbCgvBP7y/N54=
X-Received: by 2002:a05:6512:b94:b0:52c:c032:538d with SMTP id
 2adb3069b0e04-52edf02300cmr1727066e87.27.1721143036612; Tue, 16 Jul 2024
 08:17:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240715185309.1637839-1-steve.wahl@hpe.com> <20240715185309.1637839-2-steve.wahl@hpe.com>
In-Reply-To: <20240715185309.1637839-2-steve.wahl@hpe.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 16 Jul 2024 08:17:02 -0700
X-Gmail-Original-Message-ID: <CAMj1kXF7SXvN=szKb=g8MSzLyLWy=Uozr0ps40zRUoajoeG6pQ@mail.gmail.com>
Message-ID: <CAMj1kXF7SXvN=szKb=g8MSzLyLWy=Uozr0ps40zRUoajoeG6pQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] x86/kexec: Add EFI config table identity mapping
 for kexec kernel
To: Steve Wahl <steve.wahl@hpe.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, 
	Pavin Joseph <me@pavinjoseph.com>, Eric Hagberg <ehagberg@gmail.com>, 
	Simon Horman <horms@verge.net.au>, Eric Biederman <ebiederm@xmission.com>, 
	Dave Young <dyoung@redhat.com>, Sarah Brofeldt <srhb@dbc.dk>, Russ Anderson <rja@hpe.com>, 
	Dimitri Sivanich <sivanich@hpe.com>, Hou Wenlong <houwenlong.hwl@antgroup.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, 
	Yuntao Wang <ytcoode@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, Joerg Roedel <jroedel@suse.de>, 
	Michael Roth <michael.roth@amd.com>, Tao Liu <ltao@redhat.com>, kexec@lists.infradead.org, 
	"Kalra, Ashish" <ashish.kalra@amd.com>, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 15 Jul 2024 at 11:53, Steve Wahl <steve.wahl@hpe.com> wrote:
>
> From: Tao Liu <ltao@redhat.com>
>
> A kexec kernel boot failure is sometimes observed on AMD CPUs due to
> an unmapped EFI config table array.  This can be seen when "nogbpages"
> is on the kernel command line, and has been observed as a full BIOS
> reboot rather than a successful kexec.
>
> This was also the cause of reported regressions attributed to Commit
> 7143c5f4cf20 ("x86/mm/ident_map: Use gbpages only where full GB page
> should be mapped.") which was subsequently reverted.
>
> To avoid this page fault, explicitly include the EFI config table
> array in the kexec identity map.
>
> Further explanation:
>
> The following 2 commits caused the EFI config table array to be
> accessed when enabling sev at kernel startup.
>
>     commit ec1c66af3a30 ("x86/compressed/64: Detect/setup SEV/SME features
>                           earlier during boot")
>     commit c01fce9cef84 ("x86/compressed: Add SEV-SNP feature
>                           detection/setup")
>
> This is in the code that examines whether SEV should be enabled or
> not, so it can even affect systems that are not SEV capable.
>
> This may result in a page fault if the EFI config table array's
> address is unmapped. Since the page fault occurs before the new kernel
> establishes its own identity map and page fault routines, it is
> unrecoverable and kexec fails.
>
> Most often, this problem is not seen because the EFI config table
> array gets included in the map by the luck of being placed at a memory
> address close enough to other memory areas that *are* included in the
> map created by kexec.
>
> Both the "nogbpages" command line option and the "use gpbages only
> where full GB page should be mapped" patch greatly reduce the chance
> of being included in the map by luck, which is why the problem
> appears.
>
> Signed-off-by: Tao Liu <ltao@redhat.com>
> Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
> Tested-by: Pavin Joseph <me@pavinjoseph.com>
> Tested-by: Sarah Brofeldt <srhb@dbc.dk>
> Tested-by: Eric Hagberg <ehagberg@gmail.com>
> ---
>  arch/x86/kernel/machine_kexec_64.c | 35 ++++++++++++++++++++++++++----
>  1 file changed, 31 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
> index cc0f7f70b17b..563d119f9f29 100644
> --- a/arch/x86/kernel/machine_kexec_64.c
> +++ b/arch/x86/kernel/machine_kexec_64.c
> @@ -28,6 +28,7 @@
>  #include <asm/setup.h>
>  #include <asm/set_memory.h>
>  #include <asm/cpu.h>
> +#include <asm/efi.h>
>
>  #ifdef CONFIG_ACPI
>  /*
> @@ -83,10 +84,12 @@ const struct kexec_file_ops * const kexec_file_loaders[] = {
>  #endif
>
>  static int
> -map_efi_systab(struct x86_mapping_info *info, pgd_t *level4p)

I think we can keep the name - the array of EFI config table
references could be considered part of the system table, even though
it may live in a separate allocation.

> +map_efi_tables(struct x86_mapping_info *info, pgd_t *level4p)
>  {
>  #ifdef CONFIG_EFI
>         unsigned long mstart, mend;
> +       void *kaddr;
> +       int ret;
>
>         if (!efi_enabled(EFI_BOOT))
>                 return 0;
> @@ -102,6 +105,30 @@ map_efi_systab(struct x86_mapping_info *info, pgd_t *level4p)
>         if (!mstart)
>                 return 0;
>
> +       ret = kernel_ident_mapping_init(info, level4p, mstart, mend);
> +       if (ret)
> +               return ret;
> +
> +       kaddr = memremap(mstart, mend - mstart, MEMREMAP_WB);
> +       if (!kaddr) {
> +               pr_err("Could not map UEFI system table\n");
> +               return -ENOMEM;
> +       }
> +
> +       mstart = efi_config_table;
> +
> +       if (efi_enabled(EFI_64BIT)) {
> +               efi_system_table_64_t *stbl = (efi_system_table_64_t *)kaddr;
> +
> +               mend = mstart + sizeof(efi_config_table_64_t) * stbl->nr_tables;
> +       } else {
> +               efi_system_table_32_t *stbl = (efi_system_table_32_t *)kaddr;
> +
> +               mend = mstart + sizeof(efi_config_table_32_t) * stbl->nr_tables;
> +       }
> +
> +       memunmap(kaddr);
> +
>         return kernel_ident_mapping_init(info, level4p, mstart, mend);
>  #endif
>         return 0;
> @@ -241,10 +268,10 @@ static int init_pgtable(struct kimage *image, unsigned long start_pgtable)
>         }
>
>         /*
> -        * Prepare EFI systab and ACPI tables for kexec kernel since they are
> -        * not covered by pfn_mapped.
> +        * Prepare EFI systab, config table and ACPI tables for kexec kernel

Please avoid 'config table' here, as it is ambiguous. IMO you can just
drop this hunk (and the one below)

> +        * since they are not covered by pfn_mapped.
>          */
> -       result = map_efi_systab(&info, level4p);
> +       result = map_efi_tables(&info, level4p);
>         if (result)
>                 return result;
>
> --
> 2.26.2
>

