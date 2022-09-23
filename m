Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBAE15E77A0
	for <lists+linux-efi@lfdr.de>; Fri, 23 Sep 2022 11:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbiIWJti (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 23 Sep 2022 05:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbiIWJtg (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 23 Sep 2022 05:49:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6302F5582;
        Fri, 23 Sep 2022 02:49:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0254662065;
        Fri, 23 Sep 2022 09:49:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E477C43141;
        Fri, 23 Sep 2022 09:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663926572;
        bh=o8SnYBCJPoKVzlDX3HK1erMQU1GfgJ7738btMSkX6Sw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BvtBEhFI8y2AZUbhduoY8Z4T2hqy+6QhNm10Gpqg5rDilUY4S9cTHTu8gn3Rr5TMG
         qB4q7m5haISUvUsHumhtX/ReNW/k9x+l/TTcBCJ51u0deJAEbQiAybtbcTbfqn2fMY
         J9DEOqnmDcO3Og03tGtUbN5EGpeBwRew+iyCqIxOYZ6BAVVm5wTOnH2+o/FCSWReOq
         ZXSuRvvy9kzIlhIncItg6UjZFWYYXKlR5eQVopgayFt/MseeFrWs2dYHcGokmtsSIp
         HIW2nw9tqqCFWPW3z1GYmpLGWtNtnW6vH/lZ5GaRMwKWfHU1SdF/5a8oleyB6B6Ls1
         q5u8dxnUW002A==
Received: by mail-lj1-f181.google.com with SMTP id g20so12807842ljg.7;
        Fri, 23 Sep 2022 02:49:32 -0700 (PDT)
X-Gm-Message-State: ACrzQf2MslM7bSGScWgW/NnJ99zHQ2N3Q+YdfmZUnAnaP7SDlca0g/X3
        uqLB8Ztz8B6X8XSpZEdvb1m0uWot0emH6LTqOFc=
X-Google-Smtp-Source: AMsMyM6V4wsWir94AhN8Gq9G73T6gub2GM+Y6qssId2N73+QD+nRZ116sRY61I2BhCZMEJiC1zXXSl7lyVYArvnDFoA=
X-Received: by 2002:a2e:8349:0:b0:26c:4311:9b84 with SMTP id
 l9-20020a2e8349000000b0026c43119b84mr2736019ljh.152.1663926570273; Fri, 23
 Sep 2022 02:49:30 -0700 (PDT)
MIME-Version: 1.0
References: <08906193-246b-c874-8bac-1d98d2313ac4@roeck-us.net>
 <20220922193157.1673623-1-dave.hansen@linux.intel.com> <CAMj1kXHcF_iK_g0OZSkSv56Wmr=eQGQwNstcNjLEfS=mm7a06w@mail.gmail.com>
 <Yy1ZadE6Vnnc2dNf@hirez.programming.kicks-ass.net>
In-Reply-To: <Yy1ZadE6Vnnc2dNf@hirez.programming.kicks-ass.net>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 23 Sep 2022 11:49:19 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEvt-TQzO5jO6srkC8jW5fbou95VKu=os3gt_y87ZPJWg@mail.gmail.com>
Message-ID: <CAMj1kXEvt-TQzO5jO6srkC8jW5fbou95VKu=os3gt_y87ZPJWg@mail.gmail.com>
Subject: Re: [PATCH] x86/mm+efi: Avoid creating W+X mappings
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, linux-efi@vger.kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

(cc Kees)

On Fri, 23 Sept 2022 at 09:00, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Sep 23, 2022 at 12:08:57AM +0200, Ard Biesheuvel wrote:
> > On Thu, 22 Sept 2022 at 21:32, Dave Hansen <dave.hansen@linux.intel.com> wrote:
> > >
> > > From: Peter Zijlstra <peterz@infradead.org>
> > >
> > > I'm planning on sticking this in x86/mm so that it goes upstream
> > > along with the W+X detection code.
> > >
> > > --
> > >
> > > A recent x86/mm change warns and refuses to create W+X mappings.
> > >
> > > The 32-bit EFI code tries to create such a mapping and trips over
> > > the new W+X refusal.
> > >
> > > Make the EFI_RUNTIME_SERVICES_CODE mapping read-only to fix it.
> > >
> >
> > This is not safe. EFI_RUNTIME_SERVICES_CODE covers both .text and
> > .data sections of the EFI runtime PE/COFF executables in memory, so
> > you are essentially making .data and .bss read-only. (Whether those
> > executables actually modify their .data and .bss at runtime is a
> > different matter, but the point is that it used to be possible)
> >
> > More recent firmwares may provide a 'memory attributes table'
> > separately which describes the individual sections, but older 32-bit
> > firmwares are not even built with 4k section alignment, so code and
> > data may share a single page. Note that we haven't wired up this
> > memory attributes table on i386 at the moment, and I seriously doubt
> > that 32-bit firmware in the field exposes it.
> >
> > Can we just turn off this feature for 32-bit?
>
> Goodie; some seriously security minded people who did that EFI turd :/

To be fair, most people tended to care more about memory footprint
than about security at the time. And I don't recall a lot of
enthusiasm in the Linux community either for rounding up kernel
sections so they could be mapped with W^X permissions. And without
PAE, all memory is executable anyway.

> Let's just heap it on the pile of 32bit sucks and should not be
> considered a security target anymore and indeed kill this feature.
>

I take it this issue is triggered by the fact that i386 maps the EFI
runtime regions into the kernel page tables, and are therefore always
mapped, right? If anyone cares enough about this to go and fix it, we
could switch to the approach we use everywhere else, i.e., treat EFI
memory as user space mappings, and activate them only while a runtime
service is in progress.

But frankly, why would anyone still be running this? With the EFI
mixed mode support, only systems with CPUs that don't actually
implement long mode still need this, and I am skeptical that such
deployments would use recent kernels.
