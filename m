Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DEF258D845
	for <lists+linux-efi@lfdr.de>; Tue,  9 Aug 2022 13:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242641AbiHILgr (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 9 Aug 2022 07:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243032AbiHILgQ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 9 Aug 2022 07:36:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FBF4248ED;
        Tue,  9 Aug 2022 04:36:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5347761052;
        Tue,  9 Aug 2022 11:36:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8405C4314F;
        Tue,  9 Aug 2022 11:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660044973;
        bh=lYmz63lvuOJC10qqhICk6CNKKBSIvT6UEu1+sVeFf/k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=D8QCs4Zj0JxgBqIzIxwpwwjb22fBVf+C+1AoftP/A8nRz1cQfyn8lFxwji36lncyt
         JuCkgqsB5cTNUm2lOkZ+6oRB4NTxNI/Re7wpgbTa6hhhqd8wysFp6PM0UUeYJxsEpY
         c8IWAF8y4FtI9zkEheIKNd37sRY80/IHnVK1T1yXtcYcEu+mfojpviDU70qOZZj3dz
         t9i1I5caWSJquFPHA/V70vbnzVf5pWmWvxBX4pQzhS1rULsACI6hhhqCgCC/3BsIIV
         aHDfelJCT2uCk2bj+lnnhqKWF2X+E9f0apbY2qhogUdxg1aKLHFQlocQ3L1+02XJZY
         eW85zPGCMg86Q==
Received: by mail-wm1-f54.google.com with SMTP id c187-20020a1c35c4000000b003a30d88fe8eso8806874wma.2;
        Tue, 09 Aug 2022 04:36:13 -0700 (PDT)
X-Gm-Message-State: ACgBeo1slgIy4kXlKtQHWxNjhClF7ArtICivn61lWoTIqsw/1Sc/HHdY
        i7PuUdRs6G5ciQMF/jTnwnxWmugy4B55V69z534=
X-Google-Smtp-Source: AA6agR5YA4d5EiVi8IsQGMnr87dAaHnFiJPv49l2QVm+YXZcWXaPa07a+M4tje74nlRqsJgaMdFnW1wJLZwN8ljidRQ=
X-Received: by 2002:a05:600c:509:b0:3a5:2c2:fb40 with SMTP id
 i9-20020a05600c050900b003a502c2fb40mr18927723wmc.163.1660044971866; Tue, 09
 Aug 2022 04:36:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAAH4kHaB2tL+sAn0NAciu5DQeX5hpNkDees=n=f83S=Ph9Y6tw@mail.gmail.com>
 <YtcCWfCQuEsVhH6W@zn.tnic> <CAMj1kXEKtcieycyyFMyuLKJK61FgaDwtLieC0N47W1Sa5LaBsA@mail.gmail.com>
 <YtcgxxMyFTReuuRw@zn.tnic> <bb7479df-7871-9861-600d-c2fed783b659@intel.com>
 <YtcnQbiRgZPtR+rQ@zn.tnic> <22d54786-bc12-ecc5-2b37-cbaa56090aa8@intel.com>
 <CAA03e5FMEyswDhoXRJ5U_n9RG4QM524aQYpF4473ydnAVJr1PA@mail.gmail.com>
 <ffb4ae72-7fd4-d2a0-df10-3969cf8ca07f@intel.com> <CAMj1kXHEc=vEt=CtfdiPEsUe2i8QogAi+jvtY6h1awo7GZ-nRg@mail.gmail.com>
 <20220809111436.kudwg2nprnnsfvuh@box.shutemov.name>
In-Reply-To: <20220809111436.kudwg2nprnnsfvuh@box.shutemov.name>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 9 Aug 2022 13:36:00 +0200
X-Gmail-Original-Message-ID: <CAMj1kXE67H_cgYbufUxQ7HXg929dFopWH+cKX5ijAdePP8Zt-g@mail.gmail.com>
Message-ID: <CAMj1kXE67H_cgYbufUxQ7HXg929dFopWH+cKX5ijAdePP8Zt-g@mail.gmail.com>
Subject: Re: [PATCHv7 00/14] mm, x86/cc: Implement support for unaccepted memory
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>, Marc Orr <marcorr@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Dionna Amalie Glaze <dionnaglaze@google.com>,
        Peter Gonda <pgonda@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Varad Gautam <varad.gautam@suse.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Marcelo Cerri <marcelo.cerri@canonical.com>,
        tim.gardner@canonical.com,
        Khalid ElMously <khalid.elmously@canonical.com>,
        philip.cox@canonical.com,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-coco@lists.linux.dev, linux-efi <linux-efi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Yao, Jiewen" <jiewen.yao@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 9 Aug 2022 at 13:11, Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> On Sat, Jul 23, 2022 at 01:14:07PM +0200, Ard Biesheuvel wrote:
> > On Thu, 21 Jul 2022 at 19:13, Dave Hansen <dave.hansen@intel.com> wrote:
> > >
> > > On 7/19/22 17:26, Marc Orr wrote:
> > > > - Dave's suggestion to "2. Boot some intermediate thing like a
> > > > bootloader that does acceptance ..." is pretty clever! So if upstream
> > > > thinks this FW-kernel negotiation is not a good direction, maybe we
> > > > (Google) can pursue this idea to avoid introducing yet another tag on
> > > > our images.
> > >
> > > I'm obviously speaking only for myself here and not for "upstream" as a
> > > whole, but I clearly don't like the FW/kernel negotiation thing.  It's a
> > > permanent pain in our necks to solve a very temporary problem.
> >
> > EFI is basically our existing embodiment of this fw/kernel negotiation
> > thing, and iff we need it, I have no objection to using it for this
> > purpose, i.e., to allow the firmware to infer whether or not it should
> > accept all available memory on behalf of the OS before exiting boot
> > services. But if we don't need this, even better.
>
> FW/kernel negotiation does not work if there's a boot loader in the middle
> that does ExitBootServices(). By the time kernel can announce if it
> supports unaccepted memory there's nobody to announce to.
>

Why would you want to support such bootloaders for TDX anyway? TDX
heavily relies on measured boot abstractions and other things that are
heavily tied to firmware.
