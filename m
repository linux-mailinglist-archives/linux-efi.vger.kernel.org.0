Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 157AF1683C9
	for <lists+linux-efi@lfdr.de>; Fri, 21 Feb 2020 17:40:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbgBUQkO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 21 Feb 2020 11:40:14 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45448 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbgBUQkO (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 21 Feb 2020 11:40:14 -0500
Received: by mail-qk1-f194.google.com with SMTP id a2so2334304qko.12
        for <linux-efi@vger.kernel.org>; Fri, 21 Feb 2020 08:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=26dk6rij3ryibo8qsiryCcIU5POodM9FwZyZPqj71oI=;
        b=kfBWvad/OVKPyNHzPTbnojNuPYIlwEEa5QHQBQap38aIAV1+KoaDSaX6xVc6WF5u8i
         Aux1LEsumIO7Rjjja5urNk3ZNYwAg5RFMkHxI0LE6PsnwtX6r2E0zAESgKo3QEZ2WrLh
         59lrU1MzYGGLAPWua8Tjd31s03/7qfL9lrzutSC5Uf08LIuWoYW9TIgLwkW0VhMh9Hvr
         B71Q8eIEq6pg35hl1tZIjh6KXDhXht3xRpRR9E725420eInVGPe0tsVcb1JibYnPqapo
         Y6FFwyI5cLTHsfuRaxHkfi0Kod9txXSey3ETK+jaCWmYarjt4ujYFeybZvwTq7WoNA4W
         wZRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=26dk6rij3ryibo8qsiryCcIU5POodM9FwZyZPqj71oI=;
        b=ExAOYpWlJ3mXnELWG+iLyKLj+kJF5ftDQt09wluOXq2cbsLCkzph9IecSWcWszbXu5
         IFmyVmYp4VDgtcoLf6lpS8L97pJyx//ZRYm2WxTpHq93djLBCO2qBM36DxSWk4JSfHQJ
         OpzF7Q04ByMBq/yHku0AUuRMcoaDby8aQ91GELRtZtyaeHNpRtnObssI2AJZU/Kz+Dxu
         2QRXK+mqyYJpBO8WhObzMpuvy18N3+IjCOged7L9so2zf/1rzL0xENUxKq0qnBrIQ3wQ
         PqfzZORrgu+3qNoCVFJpoo+/C4hCjlm6UTkkoaNUS0yqMuny4AH/fi3exCGtq6wPYosX
         HfYw==
X-Gm-Message-State: APjAAAUEsxDnNuoMwlVz4vor3ij2FEM7BKQZQUEo7s2eGCTTsrnZAcNr
        sMxTi135ufOnAiOcSnIpUQNliD+B91s=
X-Google-Smtp-Source: APXvYqzLPiHosUhcV6ewQLgHWaSty36XDKqNn3N45GAt4+mn+hYsrRl9CQRgJJkS571/eOocOeVUwg==
X-Received: by 2002:a05:620a:5ef:: with SMTP id z15mr34013853qkg.487.1582303213094;
        Fri, 21 Feb 2020 08:40:13 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id w2sm1762117qto.73.2020.02.21.08.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 08:40:13 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Fri, 21 Feb 2020 11:40:10 -0500
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, lersek@redhat.com, leif@nuviainc.com,
        pjones@redhat.com, mjg59@google.com, agraf@csgraf.de,
        daniel.kiper@oracle.com, hdegoede@redhat.com,
        nivedita@alum.mit.edu, mingo@kernel.org
Subject: Re: [PATCH v2 1/5] efi/x86: Drop redundant .bss section
Message-ID: <20200221164010.GB2766905@rani.riverdale.lan>
References: <20200217144822.24616-1-ardb@kernel.org>
 <20200217144822.24616-2-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200217144822.24616-2-ardb@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Feb 17, 2020 at 03:48:18PM +0100, Ard Biesheuvel wrote:
> In commit
> 
>   c7fb93ec51d462ec ("x86/efi: Include a .bss section within the PE/COFF headers")
> 
> we added a separate .bss section to the PE/COFF header of the compressed
> kernel describing the static memory footprint of the decompressor, to
> ensure that it has enough headroom to decompress itself.
> 
> We can achieve the exact same result by increasing the virtual size of
> the .text section, without changing the raw size, which, as per the
> PE/COFF specification, requires the loader to zero initialize the delta.
> 
> Doing so frees up a slot in the section table, which we will use later
> to describe the mixed mode entrypoint.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/x86/boot/header.S      | 21 +-----------
>  arch/x86/boot/tools/build.c | 35 ++++++++------------
>  2 files changed, 14 insertions(+), 42 deletions(-)
> 
> diff --git a/arch/x86/boot/tools/build.c b/arch/x86/boot/tools/build.c
> index 55e669d29e54..0c8c5a52f1f0 100644
> --- a/arch/x86/boot/tools/build.c
> +++ b/arch/x86/boot/tools/build.c
> @@ -203,10 +203,12 @@ static void update_pecoff_setup_and_reloc(unsigned int size)
>  	put_unaligned_le32(10, &buf[reloc_offset + 4]);
>  }
>  
> -static void update_pecoff_text(unsigned int text_start, unsigned int file_sz)
> +static void update_pecoff_text(unsigned int text_start, unsigned int file_sz,
> +			       unsigned int init_sz)
>  {
>  	unsigned int pe_header;
>  	unsigned int text_sz = file_sz - text_start;
> +	unsigned int bss_sz = init_sz - file_sz;
>  
>  	pe_header = get_unaligned_le32(&buf[0x3c]);
>  
> @@ -216,28 +218,19 @@ static void update_pecoff_text(unsigned int text_start, unsigned int file_sz)
>  	 */
>  	put_unaligned_le32(file_sz - 512, &buf[pe_header + 0x1c]);
>  
> -	/*
> -	 * Address of entry point for PE/COFF executable
> -	 */
> -	put_unaligned_le32(text_start + efi_pe_entry, &buf[pe_header + 0x28]);
> -
> -	update_pecoff_section_header(".text", text_start, text_sz);
> -}
> -
> -static void update_pecoff_bss(unsigned int file_sz, unsigned int init_sz)
> -{
> -	unsigned int pe_header;
> -	unsigned int bss_sz = init_sz - file_sz;
> -
> -	pe_header = get_unaligned_le32(&buf[0x3c]);
> -
>  	/* Size of uninitialized data */
>  	put_unaligned_le32(bss_sz, &buf[pe_header + 0x24]);

Should this still be populated given that there's no .bss section any
more?
