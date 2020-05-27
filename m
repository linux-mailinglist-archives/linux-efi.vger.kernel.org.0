Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58AEF1E5186
	for <lists+linux-efi@lfdr.de>; Thu, 28 May 2020 01:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725601AbgE0XCO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 27 May 2020 19:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbgE0XCO (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 27 May 2020 19:02:14 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE961C08C5C1;
        Wed, 27 May 2020 16:02:13 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id q8so1321779qkm.12;
        Wed, 27 May 2020 16:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qYOUMbGRbXoFBwjaad5Ny0vONPBdfJSQTLm2Tk6FIJg=;
        b=ShneLxh9Xe9PgyCQYJk9ewv0cbYYri4qqOAfyLHE3O8XDTR4LdyEmeOYfQude2nzG/
         05NAmFVV1NLJ5X86wQ0WGNVV9V1E+1m8syCcrsNPTCKGUH8uvDXF/Myx61TCLP3Y/G81
         yX9EcTD0Xjw9Dr4Q0F4aFdQeybiAI34Lb/+4KBQYWjajSAwvygB6+PYFZzNIr6e72kFJ
         CvQ8RTBPWZxRTQcxgVYZaDIsY83wpvwB+8O3XW2ZD5Kp5GVGOYlEBJuhuj5zIHbi8yIb
         b6Z3eHSIKTL51Twfg+xWed+eNBnQGCRp8Wc1IfwGkB3fgXXk4X6qX01tCFQxVXMt4YqR
         6gnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=qYOUMbGRbXoFBwjaad5Ny0vONPBdfJSQTLm2Tk6FIJg=;
        b=HzR8R53gNteJSjGoL1IuRmTlZrHK91dO0JsAMqduWgIsT/Z9k36DQEh5xAx9fPra5u
         FybnBMCKgQ3lVo6JIANgCPAc5KFfiylN4APHr10dp5tctkYrdjBsZhAaZrvVUcH7ulv5
         7jdmQ1iwodFe8vV8s7BwNnjrzoHdDhpom4eFjGslcw4jnGwaxeBpXj7lefIPPj2bubDZ
         Z0C+r7ZjDpYeVKk5VqQOMkedDCaHLeCyLCMqeco5rEqt/EIJpFN21upf82a8ctDIEQu3
         u93SrG3gaDeqtzfNP3obLSuLmxqqAAslHI6WuZW3OQf7CzI/MbHtWuJ+YefV7ZJB+A6z
         5CYQ==
X-Gm-Message-State: AOAM531RWn7PJPHJ3AMlJ3FoCRuW4bzCu+lHES382hLi/lhOCjCNRR/y
        THnrciT3mwyb62wxbeSlgFCo1jtP
X-Google-Smtp-Source: ABdhPJxMk1bgFZVPt3++Ket2S3kFyFHSTmpmLoobwtt2X5j9BweaNuqR0TO7eg1VL7+NltlB63poJw==
X-Received: by 2002:a37:a74a:: with SMTP id q71mr166810qke.446.1590620532632;
        Wed, 27 May 2020 16:02:12 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id x14sm3559390qkb.67.2020.05.27.16.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 16:02:11 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Wed, 27 May 2020 19:02:09 -0400
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "joe@perches.com" <joe@perches.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>
Subject: Re: [PATCH 08/15] efi/x86: Move command-line initrd loading to
 efi_main
Message-ID: <20200527230209.GA3575079@rani.riverdale.lan>
References: <20200508180157.1816-1-ardb@kernel.org>
 <20200508180157.1816-9-ardb@kernel.org>
 <10a1c7fcea861f5d45dff81cba673e970d686bc2.camel@intel.com>
 <20200527224657.GA3568142@rani.riverdale.lan>
 <CAPcyv4jOCY=kxeZVWsS0Xc36jmPr7DSR_sFrsMeoiEs+iEfbEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPcyv4jOCY=kxeZVWsS0Xc36jmPr7DSR_sFrsMeoiEs+iEfbEA@mail.gmail.com>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, May 27, 2020 at 03:56:45PM -0700, Dan Williams wrote:
> On Wed, May 27, 2020 at 3:47 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > On Wed, May 27, 2020 at 10:30:18PM +0000, Williams, Dan J wrote:
> > > On Fri, 2020-05-08 at 20:01 +0200, Ard Biesheuvel wrote:
> > > > From: Arvind Sankar <nivedita@alum.mit.edu>
> > > >
> > > > Consolidate the initrd loading in efi_main.
> > > >
> > > > The command line options now need to be parsed only once.
> > > >
> > > > Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> > > > Link:
> > > > https://lore.kernel.org/r/20200430182843.2510180-9-nivedita@alum.mit.edu
> > > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > >
> > > Hi,
> > >
> > > This patch patch in tip/master as:
> > >
> > > 987053a30016 efi/x86: Move command-line initrd loading to efi_main
> > >
> > > ...regresses my nfs root configuration. It hangs trying to mount the
> > > nfs root filesystem "root=/dev/nfs ip=dhcp".
> > >
> > > It does not revert cleanly.
> > >
> > >
> >
> > Does this fix it?
> >
> > diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
> > index defeb6035109..f53362efef84 100644
> > --- a/drivers/firmware/efi/libstub/x86-stub.c
> > +++ b/drivers/firmware/efi/libstub/x86-stub.c
> > @@ -771,10 +771,12 @@ unsigned long efi_main(efi_handle_t handle,
> >                         efi_err("Failed to load initrd!\n");
> >                         goto fail;
> >                 }
> > -               efi_set_u64_split(addr, &hdr->ramdisk_image,
> > -                                 &boot_params->ext_ramdisk_image);
> > -               efi_set_u64_split(size, &hdr->ramdisk_size,
> > -                                 &boot_params->ext_ramdisk_size);
> > +               if (size > 0) {
> > +                       efi_set_u64_split(addr, &hdr->ramdisk_image,
> > +                                         &boot_params->ext_ramdisk_image);
> > +                       efi_set_u64_split(size, &hdr->ramdisk_size,
> > +                                         &boot_params->ext_ramdisk_size);
> > +               }
> 
> I'll give it a shot, but my guess would have been something related to
> the fact that this patch moves the initrd loading relative to when the
> command line is being parsed. In this case it's a dracut initrd built
> by:
> 
>     dracut -m "nfs network base"
> 
> ...with a kernel built with:
> 
> CONFIG_IP_PNP_DHCP=y
> 
> ...and a built-in network interface. The behavior seems to be that the
> kernel gets an IP address just fine, but there's no initrd userspace
> to mount nfs and the kernel eventually gives up looking for root.

It's an oversight in this patch: I set addr/size to 0 in the case where
the EFI stub is not supposed to handle the initrd loading (because a
bootloader ran before it and was responsible for handling the loading),
but then those 0's get written into the bootparams structure anyway,
blowing away whatever the bootloader had loaded.
