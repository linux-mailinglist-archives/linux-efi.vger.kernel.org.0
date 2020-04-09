Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58ACF1A3D23
	for <lists+linux-efi@lfdr.de>; Fri, 10 Apr 2020 01:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbgDIX5q (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 9 Apr 2020 19:57:46 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:57104 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726779AbgDIX5q (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 9 Apr 2020 19:57:46 -0400
Received: from callcc.thunk.org (pool-72-93-95-157.bstnma.fios.verizon.net [72.93.95.157])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 039NvGB6013309
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 9 Apr 2020 19:57:16 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 32E0A42013D; Thu,  9 Apr 2020 19:57:16 -0400 (EDT)
Date:   Thu, 9 Apr 2020 19:57:16 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Borislav Petkov <bp@suse.de>,
        Colin Ian King <colin.king@canonical.com>,
        Gary Lin <glin@suse.com>, Jiri Slaby <jslaby@suse.cz>,
        Sergey Shatunov <me@prok.pw>, Takashi Iwai <tiwai@suse.de>
Subject: Re: [GIT PULL 0/9] EFI fixes for v5.7-rc
Message-ID: <20200409235716.GF45598@mit.edu>
References: <20200409130434.6736-1-ardb@kernel.org>
 <20200409190109.GB45598@mit.edu>
 <CAMj1kXGiA3PAybR7r9tatL7WV5iU7B1OQxQok3d-JmRnhX1TnA@mail.gmail.com>
 <20200409201632.GC45598@mit.edu>
 <CAMj1kXFqKGSqm_y+ht4mmmu10TrhSyiTG8V3PxRYGodpZ=xNFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXFqKGSqm_y+ht4mmmu10TrhSyiTG8V3PxRYGodpZ=xNFQ@mail.gmail.com>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Apr 09, 2020 at 11:29:06PM +0200, Ard Biesheuvel wrote:
> > What happens is that the kexec'ed kernel immediately crashes, at which
> > point we drop back into the BIOS, and then it boots the Debain 4.19.0
> > distro kernel instead of the kernel to be tested boot.  Since we lose
> > the boot command line that was used from the kexec, the gce-xfstests
> > image retries the kexec, which fails, and the failing kexec repeats
> > until I manually kill the VM.
>
> Does this help at all?
> 
> diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
> index 781170d36f50..52f8138243df 100644
> --- a/arch/x86/include/asm/efi.h
> +++ b/arch/x86/include/asm/efi.h
> @@ -180,6 +180,7 @@ extern void __init
> efi_uv1_memmap_phys_epilog(pgd_t *save_pgd);
> 
>  struct efi_setup_data {
>         u64 fw_vendor;
> +       u64 __unused;
>         u64 tables;
>         u64 smbios;
>         u64 reserved[8];


Tested-by: Theodore Ts'o <tytso@mit.edu>

Yep, that fixed it.  Thanks!!

I wonder if this structure definition should be moved something like
arch/x86/include/uapi/asm/efi.h so it's more obvious that the
structure layout is used externally to the kernel?

						- Ted

