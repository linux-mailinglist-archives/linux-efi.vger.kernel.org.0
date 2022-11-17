Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01B4D62E114
	for <lists+linux-efi@lfdr.de>; Thu, 17 Nov 2022 17:07:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240328AbiKQQHT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 17 Nov 2022 11:07:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240430AbiKQQG5 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 17 Nov 2022 11:06:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27ADF79938;
        Thu, 17 Nov 2022 08:06:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D2273B820F9;
        Thu, 17 Nov 2022 16:06:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 883BEC433D7;
        Thu, 17 Nov 2022 16:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668701210;
        bh=7YTocWRQ81WB9p9jDHG4Do2dodiOBxV8aBHFcjw7k3Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=r2NZBbihEvU57zEKOQKhsE8jaI5UPlwW4hpEA2Vyi21Nh8M2MaiCVpDD9lPA9ATM5
         c/GC8ucl+7HNOJvp5vBNCSZC/QGP3FlcVQgqVu2Z2NhRWqfYpvdxFLKV603I/6zMIq
         y8gK6MDgwfqXJvNfyRtAsrGYOWPSeoUAfH4GOOxpWSkADcD7onFSkNvNM/0T6CcxG2
         8M+o278rjQrhwxDDmbQH2v5eHTOyfphgkm+aEggVeK+3DN4fglHafGvZODn1k4aKF+
         fxlf7I2yAugXteEyEnrXIsaRtxt1ixuC5JCPYrKZFneyQCmhnnvtTf3YCM5hZ9mG9y
         VqN8H6+YhXbgg==
Received: by mail-lj1-f174.google.com with SMTP id d3so3332834ljl.1;
        Thu, 17 Nov 2022 08:06:50 -0800 (PST)
X-Gm-Message-State: ANoB5pkBymJRMjUedMrotUqFgfNXXGNzYxbopf/+1kurrE4RrfYlPZwN
        d3nS/KlkjEBZ9Tx6DSyKbpDD/rL8jaaCQsBSx2g=
X-Google-Smtp-Source: AA0mqf4qrZTeGHe3YjdRT88rlBHHqFwhbB3Gx9LiVvIu+jjkrvrPuccthPOxtEFMt149t5guvMlxYV3IDkCVg7xahwI=
X-Received: by 2002:a2e:95d2:0:b0:277:96a:5c32 with SMTP id
 y18-20020a2e95d2000000b00277096a5c32mr1169311ljh.415.1668701208560; Thu, 17
 Nov 2022 08:06:48 -0800 (PST)
MIME-Version: 1.0
References: <20220921145422.437618-1-ardb@kernel.org> <20220921145422.437618-5-ardb@kernel.org>
 <Y3ZZ35vJBh4fQu9M@zn.tnic>
In-Reply-To: <Y3ZZ35vJBh4fQu9M@zn.tnic>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 17 Nov 2022 17:06:37 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEf=fCwGLakttfAkyGYj4PFrahcAj0GiMCUFVnOyaZtRw@mail.gmail.com>
Message-ID: <CAMj1kXEf=fCwGLakttfAkyGYj4PFrahcAj0GiMCUFVnOyaZtRw@mail.gmail.com>
Subject: Re: [PATCH v2 04/16] x86/compressed: efi-mixed: move efi32_pe_entry
 into .text section
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michael Roth <michael.roth@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 17 Nov 2022 at 16:57, Borislav Petkov <bp@alien8.de> wrote:
>
> On Wed, Sep 21, 2022 at 04:54:10PM +0200, Ard Biesheuvel wrote:
> >       /*
> >        * We need to set the image_offset variable here since startup_32() will
> >        * use it before we get to the 64-bit efi_pe_entry() in C code.
> >        */
> > -     subl    %esi, %ebx
> > -     movl    %ebx, rva(image_offset)(%ebp)   // save image_offset
> > +     subl    %esi, %ebp                      // calculate image_offset
> > +     movl    %ebp, (image_offset - 1b)(%ebx) // save image_offset
>
> All looks ok, just one question: what was the reason for that
> image_offset thing?
>
> I see:
>
> 1887c9b653f9 ("efi/x86: Decompress at start of PE image load address")
>
> It says that if the kernel is loaded as a PE executable using
> LoadImage() we don't know where that image will be loaded each time so
> we're saving that offset for later when relocating (or not) the kernel?
>
> All part of those improvements:
>
> https://lore.kernel.org/all/20200301230537.2247550-1-nivedita@alum.mit.edu/
>
> Am I close?
>

Yes.

The x86 boot protocol does not require that the setup data block comes
right before the image, it just receives the address in %esi

When doing PE boot, this is guaranteed, and so we can reuse the memory
before the image.

> I.e., that image_offset is purely a kernel thing and not something EFI
> LoadImage's inner workings mandate...? It doesn't seem so from where I'm
> standing but lemme doublecheck still.
>

No this has nothing do with the EFI in particular, only with how the
x86 boot image is constructed and wrapped into a PE/COFF executable.
