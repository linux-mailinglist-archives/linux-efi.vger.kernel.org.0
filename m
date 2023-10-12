Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0897C6C3F
	for <lists+linux-efi@lfdr.de>; Thu, 12 Oct 2023 13:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343805AbjJLL05 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 12 Oct 2023 07:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343649AbjJLL04 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 12 Oct 2023 07:26:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B750E91;
        Thu, 12 Oct 2023 04:26:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D278C433C9;
        Thu, 12 Oct 2023 11:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697110015;
        bh=OxWBCI7wG0AAyQX192AstjQVB6dAwe2dWSg9uf6TuJ8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SsXfkzPORilFprGtIIa7c0uqk/VHWgk8cH68cYpiPp+o+6y7Q6QU/gqHbHpfEXO17
         /TBxN+ahsU4+xzXW6K4eEef1K4bn3q3bLwiK734JwteSEpEKRkkhWNSFqS71aBzzaO
         RApg0f57xpkcikEce3mex9mXVmzk1IEZBclkn+PF8fFDpMDiPd9ZKTEX2XeGLJuYAS
         63B/Mt1ssgpOE9U9utdN7mD5UT+wAO0CnMj4pk+0xtG4qJ827MAEA2J66VdlIGh/zg
         Gg0NWXpTc0skCNSZqcV8k8z4/3EDgEGYLWhnJMReQtoH08NW7FrAZozNcIDrlFXomp
         /iiXoziMSH+1w==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2c4fdf94666so1930201fa.2;
        Thu, 12 Oct 2023 04:26:55 -0700 (PDT)
X-Gm-Message-State: AOJu0Yzxe8vKf9DHOlyraTcPe2E8Z7OMzKYSG4NQSFZAgP9kCXmTvWDI
        3rul+5EFVHBuEUTiAJOit2EQhqqkXbHrOWsKAaE=
X-Google-Smtp-Source: AGHT+IG61QV7qXIVAkh8MczqgwSLvA/U5RGBTipKJyIogbWMb+cYDrSDwYACfsvXAQE0XWZZeH/DbhxAXmTn3EjOqCo=
X-Received: by 2002:a2e:8e8c:0:b0:2c1:7fcf:c974 with SMTP id
 z12-20020a2e8e8c000000b002c17fcfc974mr20824603ljk.23.1697110013500; Thu, 12
 Oct 2023 04:26:53 -0700 (PDT)
MIME-Version: 1.0
References: <20231011192528.262425-1-nik.borisov@suse.com> <20231012101456.goamenepqlte65jv@box.shutemov.name>
 <8e36be57-58a6-404e-8828-6c777b8d2196@suse.com> <20231012112523.6koxkdrk72srx5og@box.shutemov.name>
In-Reply-To: <20231012112523.6koxkdrk72srx5og@box.shutemov.name>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 12 Oct 2023 13:26:40 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFrhLMvnsQagj7HpeieKhywyCgFpw7vRS1x-nwDT=mUow@mail.gmail.com>
Message-ID: <CAMj1kXFrhLMvnsQagj7HpeieKhywyCgFpw7vRS1x-nwDT=mUow@mail.gmail.com>
Subject: Re: [PATCH] x86/efistub: Don't try to print after ExitBootService()
To:     kirill.shutemov@linux.intel.com
Cc:     Nikolay Borisov <nik.borisov@suse.com>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 12 Oct 2023 at 13:25, <kirill.shutemov@linux.intel.com> wrote:
>
> On Thu, Oct 12, 2023 at 01:51:13PM +0300, Nikolay Borisov wrote:
> >
> >
> > On 12.10.23 =D0=B3. 13:14 =D1=87., kirill.shutemov@linux.intel.com wrot=
e:
> > > On Wed, Oct 11, 2023 at 10:25:28PM +0300, Nikolay Borisov wrote:
> > > > setup_e820() is executed after UEFI's ExitBootService has been call=
ed.
> > > > This causes the firmware to throw an exception because Console IO
> > > > protocol handler is supposed to work only during boot service
> > > > environment. As per UEFI 2.9, section 12.1:
> > > >
> > > >   "This protocol isused to handle input and output of text-based
> > > >   information intended for the system user during the operation of =
code
> > > >   in the boot services environment."
> > > >
> > > > Running a TDX guest with TDVF with unaccepted memory disabled resul=
ts in
> > > > the following output:
> > >
> > > Oh. My bad.
> > >
> > > But there's other codepath that does the same. If setup_e820() fails =
with
> > > EFI_BUFFER_TOO_SMALL, efi_stub_entry() would try to print "exit_boot(=
)
> > > failed\n".
> > >
> > > I wouldner if it is feasible to hook up earlyprintk console into
> > > efi_printk() machinery for after ExitBootService() case? Silent boot
> > > failure is not the best UX.
> > >
> >
> >
> > In my testing I was able to transpose setup_e820 and efi exit_boot_serv=
ice
> > by calling exit_boot_func before setup_e820 which ensures the various m=
emory
> > variables are populated. Is there any specific reason why ExitBootServi=
ces
> > is called before setting up the e820 table? AFAIU this is an arbitrary
> > choice?
>
> Because if you allocate memory with EFI service it can alter EFI memory
> map and we need the last version to convert it to e820.
>

Indeed, and note that the memory map may change due to asynchronous
events, which only get shut down when ExitBootServices() is called.
This is the reason for this complicated dance around
ExitBootServices() with the callback etc
