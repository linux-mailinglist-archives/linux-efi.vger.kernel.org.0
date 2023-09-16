Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CDF27A2EEE
	for <lists+linux-efi@lfdr.de>; Sat, 16 Sep 2023 11:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237743AbjIPJLa (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 16 Sep 2023 05:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbjIPJLL (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 16 Sep 2023 05:11:11 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F06C170E;
        Sat, 16 Sep 2023 02:11:02 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-99357737980so374427666b.2;
        Sat, 16 Sep 2023 02:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694855461; x=1695460261; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cz0nFFjGS/VjM8ZCLU/MfUnOrqxOApO0n/0p+KUIE9A=;
        b=W1qvaVaGBUSIOUgy2tGvdv8QAVy8wuHbKDafVSVleIQzQjewyqtR5nk+xM+yVU0zjY
         nUy5nNivmR+vMsR/iR8q/OZ+YhMJS7dEe8wGoK78ekiRTmJf1Ejdws/TJRtN+iL42t8D
         uENeVA1ylI+LHykgGpZ0kxsPBKFybTqFtMol6hThjhkh8c7BGGsYBFGFQTsUpHendiw0
         UVPFFsgXxosY7D74zzfBfIrSffNSOZPOvVLiRLGyOFXy0GACtFc0AI4IW1RkWapRklDr
         bNa9KAMW49Ze/YK9iMqtuh+N3jjaYPh9niqUBiQQzJXMEnQNPjNjofaV5Y2s6sHR3R2S
         JeLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694855461; x=1695460261;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cz0nFFjGS/VjM8ZCLU/MfUnOrqxOApO0n/0p+KUIE9A=;
        b=Eim6auGGUQGq5ej3dQ96ZF9JOJ2UJ6xauCFaaxkff5Qreb/fgLXVsJ6Xm0qspkjHs9
         p7r094XGKJVgeIkGS0yl+X92aLD7+xuKC05p+iNTuY815T1Pjs5ZK78nMVczONlnCsFB
         dBNAFzjL/GbofeVktd9iJ4EgVpbVA6L2nnlyqw0gr3tEgVdiTJFPqtn6uvVs3uCFIz+6
         L+1aRTWzIYfjLWu5RZzTHfx9qoBhoResZAeYTfwJ5OpUvtddz+K1XQWJN8gfG+lP7hJZ
         1F+WzQVfau+h8hMgf1C4zJwMuNngX/c/EIa/pqsaezVBcKD97vyOnpqE6NWj5bLrsadi
         idpg==
X-Gm-Message-State: AOJu0Yx3g+fAixtcGVdi9ZFgw0hIgbrWDTx3rHpYsv7LMIomlPduCAbP
        EOmFdf+PreHL3oPs9SPDpHU=
X-Google-Smtp-Source: AGHT+IEakTuMZDc0U8iFm7kIhK663MOoAZ28JbeRNif6ANsblV3dVSRGUHuk8tQwz/lPdDtstD7Pjg==
X-Received: by 2002:a17:906:73cc:b0:9ad:7e21:5a6d with SMTP id n12-20020a17090673cc00b009ad7e215a6dmr3664033ejl.33.1694855460588;
        Sat, 16 Sep 2023 02:11:00 -0700 (PDT)
Received: from gmail.com (84-236-113-53.pool.digikabel.hu. [84.236.113.53])
        by smtp.gmail.com with ESMTPSA id f19-20020a170906561300b009a16975ee5asm3460357ejq.169.2023.09.16.02.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Sep 2023 02:10:58 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sat, 16 Sep 2023 11:10:56 +0200
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
Subject: Re: [PATCH v2 00/15] x86/boot: Rework PE header generation
Message-ID: <ZQVxIIh1byq65lK/@gmail.com>
References: <20230912090051.4014114-17-ardb@google.com>
 <ZQQiUxh5vmeZnp7s@gmail.com>
 <ZQRAckHVxQZRNEGA@gmail.com>
 <CAGnOC3Zw49_30FkGY=RRLn-sCHNgFY_T0ugNJZCgg_T3opHm+Q@mail.gmail.com>
 <CAMj1kXEVA5iL79HwXdYOAXAr0ZemS6repMRi9b20VSU=u0Ee=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXEVA5iL79HwXdYOAXAr0ZemS6repMRi9b20VSU=u0Ee=Q@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


* Ard Biesheuvel <ardb@kernel.org> wrote:

> > > So, the first 8 patches broke the x86-64-defconfig-ish Qemu bzImage bootup,
> > > due to the 8th patch:
> > >
> > >   988b52b207a9fe74c3699bda8c2256714926b94b is the first bad commit
> > >   commit 988b52b207a9fe74c3699bda8c2256714926b94b
> > >   Author: Ard Biesheuvel <ardb@kernel.org>
> > >   Date:   Tue Sep 12 09:01:01 2023 +0000
> > >
> > >       x86/boot: Define setup size in linker script
> > >
> > > I've removed it for now - but this side effect was not expected.
> > >
> >
> > No, definitely not expected. I tested various combinations of i386 /
> > x86_64 built with GCC / Clang doing EFI or BIOS boot.
> >
> > I'll rebase the remaining stuff onto -tip and see if I can reproduce this.
> 
> This is actually quite bizarre. x86_64_defconfig has
> CONFIG_EFI_MIXED=y and i tested that this change produces the exact
> same bzImage binary in that case.
> 
> Could you send me the .config and the QEMU command line perhaps?

So the patch below is the delta between v2 and v3 - that is expected
to fix the bzImage boot crash, right?

Thanks,

	Ingo

--- tip.orig/arch/x86/boot/setup.ld
+++ tip/arch/x86/boot/setup.ld
@@ -41,7 +41,7 @@ SECTIONS
 		LONG(0x5a5aaa55)
 
 		/* Reserve some extra space for the reloc and compat sections */
-		setup_size = ABSOLUTE(ALIGN(. + 64, 512));
+		setup_size = ALIGN(ABSOLUTE(.) + 64, 512);
 		setup_sects = ABSOLUTE(setup_size / 512);
 	}
 

