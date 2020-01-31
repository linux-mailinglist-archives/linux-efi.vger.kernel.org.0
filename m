Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E43F14F2A8
	for <lists+linux-efi@lfdr.de>; Fri, 31 Jan 2020 20:24:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725978AbgAaTYc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 31 Jan 2020 14:24:32 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45233 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbgAaTYc (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 31 Jan 2020 14:24:32 -0500
Received: by mail-qk1-f193.google.com with SMTP id x1so7646672qkl.12;
        Fri, 31 Jan 2020 11:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Z4mDk6YRjW3Doq0Jp4fKIbwDgblN+IgoASkkgiug8jI=;
        b=gmcYsNHh6ziGp7TpyC+2aRCYbPCAZBsW1DhuBi7IdIdyTL9CJDBBELzmnJk2pTOyKN
         0shaUegRAzpITH0KvqafLHWfQxRbu+kStQTUYzgOzpjnxXrb+nQC9KHca6qfQC4P790X
         7ZlvFT/wMZBFoxy2mjyN2U+qI0xy4DJrS4N56PaPo6dpCRXIESaOLrtcTTx5fjqMHJhb
         PI0bAfJpLly/VR960L4PzTCxP7YEAikjOxWBBq4N4inswe+YW5N2CjvYfOPktrKa8Sfm
         UsuGcnNdXO7tixyXKwRl6NiwtZFaVy4MrYjASch+nFEhfmzZurEePTQt5uw5LJ888DUC
         0vIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z4mDk6YRjW3Doq0Jp4fKIbwDgblN+IgoASkkgiug8jI=;
        b=LFumpfS0Ob8qiJabyqgACdrLPZdKvvco4Rj8bSOz5qFwdiKPIcLwFMM7J75SdkejI1
         srH9dI+bPZtLt8nbRYem3tc6wQaCU05vlJz7VbRo495Jt+HmZICaKto/XHZmAgYdkFVo
         WhF63rcabS1PHJZO/xeUEl6QVeLRF5nTvZU1ggGrM+N8JftVLAEqMx+J98viYOIxUf5r
         QWa41wZHbUHG8sDHgGRh+V3es3uKjFCg05+8HRAM8JaoLXhK0IiFwEKLzbHMlRaY4j/h
         NtZV15CYqt3KmxzxJQOujeXYEQee6HO7n6cDrWGa1iTZl9BSLkMIv84TF+EiNTa9ccJs
         7QFw==
X-Gm-Message-State: APjAAAVMHsqg7W8G3aFh0TAkOcXXTUgNO6/cc4BzniSv40VxGCwAiAB4
        gTw7fPC5RS0zQD+bIPVvf18=
X-Google-Smtp-Source: APXvYqxfeRPNUSKuzFLNrF/7Z9jSj+mtT85/0nTFhhd508lPGQMzAaHVXT1BO5E8Skw+mAUIkZBuRw==
X-Received: by 2002:a37:d8e:: with SMTP id 136mr12639839qkn.293.1580498671435;
        Fri, 31 Jan 2020 11:24:31 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id y27sm5666475qta.50.2020.01.31.11.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 11:24:31 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Fri, 31 Jan 2020 14:24:29 -0500
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>,
        Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        x86@kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 7/8] Documentation/x86/boot: Clarify segment requirements
 for EFI handover
Message-ID: <20200131192429.GB2346161@rani.riverdale.lan>
References: <20200130200440.1796058-1-nivedita@alum.mit.edu>
 <20200130200440.1796058-8-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200130200440.1796058-8-nivedita@alum.mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Jan 30, 2020 at 03:04:39PM -0500, Arvind Sankar wrote:
> The 32-bit EFI handover entry point requires segments to be setup in the
> same way as for the regular 32-bit boot.
> 
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> ---
>  Documentation/x86/boot.rst | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/x86/boot.rst b/Documentation/x86/boot.rst
> index c9c201596c3e..3e13b7d57271 100644
> --- a/Documentation/x86/boot.rst
> +++ b/Documentation/x86/boot.rst
> @@ -1412,6 +1412,12 @@ from the boot media and jump to the EFI handover protocol entry point
>  which is hdr->handover_offset bytes from the beginning of
>  startup_{32,64}.
>  
> +For the 32-bit handover entry point, the GDT and segments must be setup as for
> +the 32-bit boot protocol, i.e. a GDT must be loaded with the descriptors for
> +selectors __BOOT_CS(0x10) and __BOOT_DS(0x18); both descriptors must be 4G flat
> +segment; __BOOT_CS must have execute/read permission, and __BOOT_DS must have
> +read/write permission; CS must be __BOOT_CS and DS, ES, SS must be __BOOT_DS.
> +
>  The function prototype for the handover entry point looks like this::
>  
>      efi_main(void *handle, efi_system_table_t *table, struct boot_params *bp)
> -- 
> 2.24.1
> 

I realized this is actually wrong. At the handover entry, the firmware
is still in control, so we can't require the bootloader to install a
different GDT from what the firmware had installed, and in fact OVMF for
one just passes the firmware GDT.

This seems to be working today by accident. OVMF sets up a GDT which
looks like this:
	NULL
	DATA
	CODE32
	DATA
	CODE32
	0
	DATA
	CODE64
	0
and this is what is installed when efi_stub_entry is called. Since
selectors 2 and 3 are code and data this works for us in 32-bit and in
mixed mode, and we don't care in 64-bit mode, but it seems like a bad
thing to rely upon.

I think we should save the segment descriptors in addition to the GDTR
on stub entry and restore them in the mixed-mode thunk before calling
the firmware?
