Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 936A17C82F8
	for <lists+linux-efi@lfdr.de>; Fri, 13 Oct 2023 12:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbjJMK2j (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 13 Oct 2023 06:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjJMK2i (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 13 Oct 2023 06:28:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06ADCBB;
        Fri, 13 Oct 2023 03:28:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2EF6C433C9;
        Fri, 13 Oct 2023 10:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697192916;
        bh=0+boUY0MoHNzdsmeaJJyHT3/EXHdNTCpFhWoTBDCG/w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=grXjQALA5aPs764pJYGsubpxwgHVSNA7xNJEgbyVbsF31jWihGJ9wEJSXmrZAmCa9
         2TXJhBp7LGVEVCbh4H6ROegZsgFM8tsqPVlr4fC4r1ZPghUnNz+EcyEAALWPWnYNuu
         P4sR7W1Vx9KPHR576dVWs3M9f/tdcMK9u7ld4io4iXn8JQRpcJfEOp1hHQNYRUcOMq
         gjk91T/rmFrCbGfk9gr34UcvJPV3ntLWmTXT0f4x7z1z+GnoiTWndA9G5ZxMdZPpeM
         jQGph8NJdmYNXkcEse6JTVpHq70Gg216gV8ZTRc5Ii3hWsornFn5x2WXUmHcreE2Oa
         Mru8Po4SEreIA==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2c5028e5b88so11881961fa.3;
        Fri, 13 Oct 2023 03:28:36 -0700 (PDT)
X-Gm-Message-State: AOJu0YziiEEjh9pgveNuhzWyymw2cu69RKOAi4q0FOrO3AHvI9if/nq3
        8iYSypA+TJcqf7KM+nSISQgq62Un9Twi1MAGEpk=
X-Google-Smtp-Source: AGHT+IHL2n0/S/n6/UTuAOtvuKRlwX6m8Psz9ZrS4KBzp4oSfvc+q08gDfJEyYSIoEbL639CGiFVjOOU4dJotq9aAVA=
X-Received: by 2002:a2e:3c16:0:b0:2c0:167e:dd8c with SMTP id
 j22-20020a2e3c16000000b002c0167edd8cmr22497370lja.10.1697192914886; Fri, 13
 Oct 2023 03:28:34 -0700 (PDT)
MIME-Version: 1.0
References: <20231011192528.262425-1-nik.borisov@suse.com> <20231012101456.goamenepqlte65jv@box.shutemov.name>
In-Reply-To: <20231012101456.goamenepqlte65jv@box.shutemov.name>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 13 Oct 2023 12:28:23 +0200
X-Gmail-Original-Message-ID: <CAMj1kXE3+grHM-ay5J5sHD55rs_UXU061AOrukDABRGpbUE4nA@mail.gmail.com>
Message-ID: <CAMj1kXE3+grHM-ay5J5sHD55rs_UXU061AOrukDABRGpbUE4nA@mail.gmail.com>
Subject: Re: [PATCH] x86/efistub: Don't try to print after ExitBootService()
To:     kirill.shutemov@linux.intel.com
Cc:     Nikolay Borisov <nik.borisov@suse.com>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Thu, 12 Oct 2023 at 12:15, <kirill.shutemov@linux.intel.com> wrote:
>
> On Wed, Oct 11, 2023 at 10:25:28PM +0300, Nikolay Borisov wrote:
> > setup_e820() is executed after UEFI's ExitBootService has been called.
> > This causes the firmware to throw an exception because Console IO
> > protocol handler is supposed to work only during boot service
> > environment. As per UEFI 2.9, section 12.1:
> >
> >  "This protocol isused to handle input and output of text-based
> >  information intended for the system user during the operation of code
> >  in the boot services environment."
> >

Thanks. I've queued this up as a fix.

> > Running a TDX guest with TDVF with unaccepted memory disabled results in
> > the following output:
>
> Oh. My bad.
>
> But there's other codepath that does the same. If setup_e820() fails with
> EFI_BUFFER_TOO_SMALL, efi_stub_entry() would try to print "exit_boot()
> failed\n".
>
> I wouldner if it is feasible to hook up earlyprintk console into
> efi_printk() machinery for after ExitBootService() case? Silent boot
> failure is not the best UX.
>

I don't disagree with that in principle, but wiring this up seems
non-trivial, and will be x86-only.

The EFI output is not recorded in the kernel log, and this particular
issue is something we can warn about later on, when it is much more
likely that someone will notice.

So if we want to keep this functionality, I'd prefer it if we could
add something to the generic EFI memmap code that warns_once about
unaccepted memory being present and CONFIG_UNACCEPTED_MEMORY being
disabled.
