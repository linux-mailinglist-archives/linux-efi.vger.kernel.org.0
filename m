Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 744CC7A229F
	for <lists+linux-efi@lfdr.de>; Fri, 15 Sep 2023 17:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234332AbjIOPlA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 15 Sep 2023 11:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbjIOPkg (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 15 Sep 2023 11:40:36 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A8FDF3;
        Fri, 15 Sep 2023 08:40:31 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-403012f27e3so26355755e9.3;
        Fri, 15 Sep 2023 08:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694792430; x=1695397230; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JAHknuPjRCck/JX8RUL3+KL63xpes/+m8hC0sxTxp0E=;
        b=ZYoE8ww/fzhlEKWf7lQCp+o3/3Ooiio2kzXhC87rC6s/Mg3Kuzd/EaMJug0eLCUx6O
         kyJUIa2Tu4ubzwE4sArypG89gvLZVH9YpNFS8lburHN+w4G+D/qML4KN5EaFP6yrmnnS
         5xvpejhd8GuXfDJahMIK/kObVaCk2omGs7yghMCcc+SXLhvkR2MNpsSe1co1o6WaEAEA
         EuqotbS/DvCsW6JvEZRGr7wG7dDGdjyZDGHPFuGMHughN9+ljBfSnYbxavGzgKcc1avW
         4N8LkZI4lg3kiClYnWIe4kFM0ATXTbgdvOAYvfZnIjYhIgLmPznEETlSFA8BV95QJNnF
         qwxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694792430; x=1695397230;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JAHknuPjRCck/JX8RUL3+KL63xpes/+m8hC0sxTxp0E=;
        b=wm7jyOGGezdV0Pnf4rMt3AvLSPhZ/y1iKM98ApBKiaEQSGLDivMzkGeS/1/oZmyHA5
         /duwiES23xVQVpUbzMfoD+yChYgjRDH0XBYJnNuvxZofVDNg0b7NkFXEZZTwbUxSMJRq
         w0C+CKzbD1uwTpnoGbH+FALyl7a+I+f8tSAHm4WEBUvZqlWI8Ptr9srXOGhdylspiMIc
         QDuUEFh+bTZ9vE5aOom20moBj4SkgzMBcC2PKzc6YWHXC2HEyf/yGsUG1tPpGGd7zmZf
         R/Led6oCgu2QN0RtrXVWNDTkIWuUqNtw3LBv+5Y4DxyHMwRiYbQkhz2sGmRV0PNZnv3/
         tSAQ==
X-Gm-Message-State: AOJu0Yw0fzQD6CjSvyC+hO0buoTOlg2Q0+/4gVMzGbS/f9HbubD+bD/T
        14yZ4PadXURuYFVCqyS9qK4=
X-Google-Smtp-Source: AGHT+IF5Pf1XWxSuOYK84nxxQlYIdlgXjQU/ERzb29wnzlnORHo30wkiLiDp0s6uOJv8nw/gr+7XiA==
X-Received: by 2002:a05:600c:3641:b0:401:b652:b6cf with SMTP id y1-20020a05600c364100b00401b652b6cfmr2118832wmq.13.1694792429612;
        Fri, 15 Sep 2023 08:40:29 -0700 (PDT)
Received: from gmail.com (1F2EF265.nat.pool.telekom.hu. [31.46.242.101])
        by smtp.gmail.com with ESMTPSA id f2-20020a7bc8c2000000b003fed70fb09dsm4972456wml.26.2023.09.15.08.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 08:40:28 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Fri, 15 Sep 2023 17:40:26 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Ard Biesheuvel <ardb@google.com>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Evgeniy Baskov <baskov@ispras.ru>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Jones <pjones@redhat.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 08/15] x86/boot: Drop references to startup_64
Message-ID: <ZQR66uQOGCaVQlNu@gmail.com>
References: <20230912090051.4014114-17-ardb@google.com>
 <20230912090051.4014114-25-ardb@google.com>
 <ZQQgv7VWUa3VGqbb@gmail.com>
 <CAMj1kXGxv_Nt4__ETG-e0vXC7z8SyirCw5NO0p6gsWRbLfbNAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMj1kXGxv_Nt4__ETG-e0vXC7z8SyirCw5NO0p6gsWRbLfbNAQ@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


* Ard Biesheuvel <ardb@kernel.org> wrote:

> On Fri, 15 Sept 2023 at 11:15, Ingo Molnar <mingo@kernel.org> wrote:
> >
> >
> > * Ard Biesheuvel <ardb@google.com> wrote:
> >
> > > From: Ard Biesheuvel <ardb@kernel.org>
> > >
> > > The x86 boot image generation tool assign a default value to startup_64
> > > and subsequently parses the actual value from zoffset.h but it never
> > > actually uses the value anywhere. So remove this code.
> > >
> > > This change has no impact on the resulting bzImage binary.
> > >
> > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > > ---
> > >  arch/x86/boot/Makefile      | 2 +-
> > >  arch/x86/boot/tools/build.c | 3 ---
> > >  2 files changed, 1 insertion(+), 4 deletions(-)
> >
> > Note that this patch conflicted with a recent upstream cleanup commit:
> >
> >    e78d334a5470 ("x86/boot: Mark global variables as static")
> >
> > It was trivial to resolve, but please double-check the result once I push
> > out the new tip:x86/boot tree.
> >
> 
> Ehm, I suspect something is going on with your workflow - did you
> apply my patches out of order perhaps? (/me notes that you seem to
> have omitted patches #7

Indeed: patch #7 was not in my inbox - nor is it in my lkml folder:

664225     Sep 12 Ard Biesheuvel     | ├─>[PATCH v2 04/15] x86/boot: Remove the 'bugger off' message
664226     Sep 12 Ard Biesheuvel     | ├─>[PATCH v2 05/15] x86/boot: Omit compression buffer from PE/COFF image memory footprint
664227     Sep 12 Ard Biesheuvel     | ├─>[PATCH v2 06/15] x86/boot: Drop redundant code setting the root device
664228     Sep 12 Ard Biesheuvel     | ├─>[PATCH v2 08/15] x86/boot: Drop references to startup_64
664229     Sep 12 Ard Biesheuvel     | ├─>[PATCH v2 10/15] x86/boot: Define setup size in linker script
664230     Sep 12 Ard Biesheuvel     | ├─>[PATCH v2 12/15] x86/boot: Construct PE/COFF .text section from assembler
664231     Sep 12 Ard Biesheuvel     | ├─>[PATCH v2 13/15] x86/boot: Drop PE/COFF .reloc section
664232     Sep 12 Ard Biesheuvel     | ├─>[PATCH v2 14/15] x86/boot: Split off PE/COFF .data section

:-/

Very weird - could it have gotten lost in the sending process, on your 
side?

Thanks,

	Ingo
