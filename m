Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72DB811D99F
	for <lists+linux-efi@lfdr.de>; Thu, 12 Dec 2019 23:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730809AbfLLWlT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 12 Dec 2019 17:41:19 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:35978 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730707AbfLLWlT (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 12 Dec 2019 17:41:19 -0500
Received: by mail-qv1-f65.google.com with SMTP id b18so82694qvy.3
        for <linux-efi@vger.kernel.org>; Thu, 12 Dec 2019 14:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=YZ0akD1MdE7cFzoYFMJfPBx9ET9SS+wlHKVfJacGOp0=;
        b=BeAx33aKveDu7WWpI7toD8wxbffga0D8yzbyGejPUVr914SaMfj743WobxBwPPG/Yz
         Jx33Y8cGWYt5uuteeVxP4n0kl38nz42XmBY/MDMX34EOPj4bHsqxCsp/OM+PLbDMp2kT
         dWsDsEU/Qz4rXgpI9UAUsc6S4QAQR6YJfrVqnjVk7cIC8Q17kcfjYiiwuWjtdP9Ww6gB
         rwtvn5S9l0HxMPhI8aR6voq2JlMUgMGJS0L+q7gCSUslwCIhxPRzSCLUiuukSHGhq5nP
         w9VRv7hA2TRZMXACAajUtZUpdf9WCxQiJCcX7w3Gaw7vr/iSdAuYm8lrTC7SUQp3xmA+
         imFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=YZ0akD1MdE7cFzoYFMJfPBx9ET9SS+wlHKVfJacGOp0=;
        b=bKXPABLg9vd04RlR/eaZP1MHQHgBfVTJAqIxAY2uo3cLbOqvO19ZUjrovwNbXYMDKx
         cEkRXgcm7jYDtPzqUR+UPWIQkPFwJ0kj2LVB/SHE53mWMdBXhsfmNxKVxRUsuXH+db45
         x4G7H8I5JT60pyAAtQrPegXHlRkj9eGDPCFOCYB9tpyi7ILxBytU18VeCaA6RZUlnwOB
         zioLh+ahUARnFxWMQWZ/sB8L+8o1tJJAHwmJ4L8xyT11PKjUQBmdS1MdEVJWMdsziQ10
         0FuLzLQxh5DtA2vg736LqEzx+kGpPouoOFm46rqQUpZqioSKW3DEU1ZYfDebu3qLFxTK
         H6QA==
X-Gm-Message-State: APjAAAVUgjdFSlhmzxTZxtGwVctf+FKJcW9C99eWQOuSKuvMCYemLDwK
        +mTUI10Wb3L21zTq2HUt60M=
X-Google-Smtp-Source: APXvYqxC+AUPlKGFvhvceOVt4J4zV5jZ9/sASHxhA/3KCnCcWjUfspxMEZOTnRKWW42boikRevcwqg==
X-Received: by 2002:a0c:f350:: with SMTP id e16mr10796147qvm.104.1576190478576;
        Thu, 12 Dec 2019 14:41:18 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id o6sm2163901qkk.53.2019.12.12.14.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 14:41:18 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Thu, 12 Dec 2019 17:41:16 -0500
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
Subject: Re: [RFC PATCH 3/5] efi/gop: Convert GOP structures to typedef and
 cleanup some types
Message-ID: <20191212224116.GC10385@rani.riverdale.lan>
References: <20191212213443.24128-1-nivedita@alum.mit.edu>
 <20191212213443.24128-4-nivedita@alum.mit.edu>
 <CAKv+Gu804kOz2BJw=O1o8F3XF828E3BYp_UnJu1VSwy7gKm-7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKv+Gu804kOz2BJw=O1o8F3XF828E3BYp_UnJu1VSwy7gKm-7g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Dec 12, 2019 at 10:35:56PM +0000, Ard Biesheuvel wrote:
> On Thu, 12 Dec 2019 at 22:34, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > Use typedef for the GOP structures, in anticipation of unifying
> > 32/64-bit code. Also use more appropriate types in the non-bitness
> > specific structures for the framebuffer address and pointers.
> >
> > Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> 
> 
> This gives me
> 
> /home/ardbie01/linux/drivers/firmware/efi/libstub/gop.c: In function
> ‘setup_gop32’:
> /home/ardbie01/linux/drivers/firmware/efi/libstub/gop.c:96:27: error:
> storage size of ‘pixel_info’ isn’t known
>   struct efi_pixel_bitmask pixel_info;
>                            ^~~~~~~~~~
> /home/ardbie01/linux/drivers/firmware/efi/libstub/gop.c:125:38: error:
> dereferencing pointer to incomplete type ‘struct
> efi_graphics_output_protocol_32’
>    mode = (void *)(unsigned long)gop32->mode;
>                                       ^~
> /home/ardbie01/linux/scripts/Makefile.build:265: recipe for target
> 'drivers/firmware/efi/libstub/gop.o' failed
> make[5]: *** [drivers/firmware/efi/libstub/gop.o] Error 1
> make[5]: *** Waiting for unfinished jobs....

Something must be wrong with the application of the patch. The patch
does change the declaration of pixel_info and gop32 as seen below.

> > @@ -87,13 +87,13 @@ static efi_status_t
> >  setup_gop32(efi_system_table_t *sys_table_arg, struct screen_info *si,
> >              efi_guid_t *proto, unsigned long size, void **gop_handle)
> >  {
> > -       struct efi_graphics_output_protocol_32 *gop32, *first_gop;
> > +       efi_graphics_output_protocol_32_t *gop32, *first_gop;
> >         unsigned long nr_gops;
> >         u16 width, height;
> >         u32 pixels_per_scan_line;
> >         u32 ext_lfb_base;
> > -       u64 fb_base;
> > -       struct efi_pixel_bitmask pixel_info;
> > +       efi_physical_addr_t fb_base;
> > +       efi_pixel_bitmask_t pixel_info;
> >         int pixel_format;
