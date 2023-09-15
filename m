Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4413B7A2024
	for <lists+linux-efi@lfdr.de>; Fri, 15 Sep 2023 15:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234635AbjIONtR (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 15 Sep 2023 09:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234614AbjIONtQ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 15 Sep 2023 09:49:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3092119;
        Fri, 15 Sep 2023 06:49:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B737C433C8;
        Fri, 15 Sep 2023 13:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694785750;
        bh=vh7X5SCmx9den/1/AL1Mc91AAdBpMVMeeSvHS/YS0XA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=somAZDlUnobuWTK5V4Kc2ga8ruahmFYfRnJfk1Fbsq2JiCaFqHzikGvggDLjZl2s4
         Q5j9dhN0Uwh/bO9Ris0ZtyASMst152c0CbS/OnA32kPAI1NCZPEQprJUND+doDJ5rm
         dr73XkzK5Rai8EVkm6TFPA5dvr5b2BovjAwL4ny58XepCeDAZ0fXzfa+QzcAWb6dTm
         Se9fKVUrUDA5kn4nGdQ4CDI1IIeSzamiJaeFCj7pO+4AyeeC+24D8sg9A16gwKg3al
         bXGO+EZdPaZ7AzJ6ffmevh0ksZ7tLjkHyX5S8vcMKhMLTyxsIhTtPRFBp5EvBjQZuk
         qHxp4aDfDiK5A==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2bfb1167277so35230581fa.2;
        Fri, 15 Sep 2023 06:49:10 -0700 (PDT)
X-Gm-Message-State: AOJu0YxPGTXhjpy90DPrbnzwdn0wxG3EY60uR7/riDzMYpQvIAGchWib
        dWQJB6UPbAroPdVR5l3vkfEbQutDnKGy8Bq6RFQ=
X-Google-Smtp-Source: AGHT+IHo4jPEqv90rSCWuufKlbh0HOiPaRMmxsCDQd1fj17Voi3NgxBVNWhvrp343xSi+Ja7hK1MfhWOqv1A2Fe0b3Q=
X-Received: by 2002:a2e:848a:0:b0:2bc:f756:341 with SMTP id
 b10-20020a2e848a000000b002bcf7560341mr1496024ljh.35.1694785748489; Fri, 15
 Sep 2023 06:49:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230912090051.4014114-17-ardb@google.com> <20230912090051.4014114-25-ardb@google.com>
 <ZQQgv7VWUa3VGqbb@gmail.com>
In-Reply-To: <ZQQgv7VWUa3VGqbb@gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 15 Sep 2023 15:48:56 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGxv_Nt4__ETG-e0vXC7z8SyirCw5NO0p6gsWRbLfbNAQ@mail.gmail.com>
Message-ID: <CAMj1kXGxv_Nt4__ETG-e0vXC7z8SyirCw5NO0p6gsWRbLfbNAQ@mail.gmail.com>
Subject: Re: [PATCH v2 08/15] x86/boot: Drop references to startup_64
To:     Ingo Molnar <mingo@kernel.org>
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 15 Sept 2023 at 11:15, Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Ard Biesheuvel <ardb@google.com> wrote:
>
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > The x86 boot image generation tool assign a default value to startup_64
> > and subsequently parses the actual value from zoffset.h but it never
> > actually uses the value anywhere. So remove this code.
> >
> > This change has no impact on the resulting bzImage binary.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  arch/x86/boot/Makefile      | 2 +-
> >  arch/x86/boot/tools/build.c | 3 ---
> >  2 files changed, 1 insertion(+), 4 deletions(-)
>
> Note that this patch conflicted with a recent upstream cleanup commit:
>
>    e78d334a5470 ("x86/boot: Mark global variables as static")
>
> It was trivial to resolve, but please double-check the result once I push
> out the new tip:x86/boot tree.
>

Ehm, I suspect something is going on with your workflow - did you
apply my patches out of order perhaps? (/me notes that you seem to
have omitted patches #7 and #9)

The patch you refer to is

commit e78d334a5470ead861590ec83158f3b17bd6c807
Author:     Arvind Sankar <nivedita@alum.mit.edu>
AuthorDate: Mon May 11 18:58:49 2020 -0400
Commit:     Ard Biesheuvel <ardb@kernel.org>
CommitDate: Thu May 14 11:11:20 2020 +0200

    x86/boot: Mark global variables as static

which went into v5.7 as a late fix via the EFI tree.
