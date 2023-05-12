Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ECDF70062D
	for <lists+linux-efi@lfdr.de>; Fri, 12 May 2023 13:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240456AbjELLB6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 12 May 2023 07:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241067AbjELLBT (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 12 May 2023 07:01:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09571386E;
        Fri, 12 May 2023 04:01:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C8E865566;
        Fri, 12 May 2023 11:01:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F171DC433AF;
        Fri, 12 May 2023 11:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683889275;
        bh=WfMo/UCIoEAhIuI192bDSMME0+1kDUpIrgATnnqtCsM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=c+TBR77M4V+MLrEbx3zrrJ4/a8+IDr2YL33BtcYUwPIvSxPr/r2G8l2K4NsK6Fy97
         8+f3fW80e8nIiX7Xonx9W+Uw4mnmGsx/G7R7aGHXI+xJEDO/aCMGCDl03aXIt4Qv4q
         E033s8QK58HpL5V7+/9PR2Id1fApkv8h59WJu8BbiK4tujxC/uYxKQsWeiM00xUMsg
         l5jpmCH4h751EpnI0Q+3IOKxwf3y32ZY58Cv/qkNJ5nWBDHZzR65rMjnVAYXYCnTK6
         uOBYvkHHruKD80eVRxFlJDfCGUOLaZ7j3iJJPfut+kggGxFl/Xfc0SWJvIryAt1Qqt
         n1o/ysaCNUGJA==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-4f137dbaa4fso11424415e87.2;
        Fri, 12 May 2023 04:01:14 -0700 (PDT)
X-Gm-Message-State: AC+VfDyEuiUa2GkwwPQAbXf40xMo8plX+cMhf5l9dWFtTbtx8JEu1Dvk
        Nm7ep2K1yZ90F+0SmA8VnwD7+UYjKFut0gPGtfk=
X-Google-Smtp-Source: ACHHUZ7VTszyNtMqIQDilUbtOaY3L0FxW7t6tphZiH7wZTs+ubZ5Ew8B500wu/GUWe6sp5Gkp5rP8abtaJQ7Qm8Dnjo=
X-Received: by 2002:a05:6512:961:b0:4eb:7e:1fa5 with SMTP id
 v1-20020a056512096100b004eb007e1fa5mr3761436lft.8.1683889272855; Fri, 12 May
 2023 04:01:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230507234618.18067-1-kirill.shutemov@linux.intel.com>
 <20230507234618.18067-5-kirill.shutemov@linux.intel.com> <CAMj1kXE26G=HgqBHoJOWF+FyXs7Ryj7VFFY9A+xG7HmUXnb5bg@mail.gmail.com>
 <20230508190043.ouauzbghn27khdy4@box.shutemov.name> <CAMj1kXFxw4+opJuq=g2unocitRyKYz_hfrZb-grsZtPwBOyKgw@mail.gmail.com>
 <20230509005634.qtuiodpirexbxu2k@box.shutemov.name> <CAMj1kXGZ4j7nShGPoJzTZNa4NDvHnj_arY8XDXzW8cd6G==8Jg@mail.gmail.com>
 <20230512015909.2fj7bmp3ejc3owhs@box.shutemov.name> <CAMj1kXHY-uWWgWjv-7wLkKoh9pvgCbEkxHiCBbJa1wt53g5wYg@mail.gmail.com>
 <20230512105919.lgy3cvio6m2vcygn@box.shutemov.name>
In-Reply-To: <20230512105919.lgy3cvio6m2vcygn@box.shutemov.name>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 12 May 2023 13:01:01 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGmThuLGzKGG9pPNFaH_yKTZ_AnD5aNUd7qGG0=Enev4w@mail.gmail.com>
Message-ID: <CAMj1kXGmThuLGzKGG9pPNFaH_yKTZ_AnD5aNUd7qGG0=Enev4w@mail.gmail.com>
Subject: Re: [PATCHv10 04/11] efi/x86: Implement support for unaccepted memory
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
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
        Dario Faggioli <dfaggioli@suse.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        aarcange@redhat.com, peterx@redhat.com, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 12 May 2023 at 12:59, Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> On Fri, May 12, 2023 at 09:39:30AM +0200, Ard Biesheuvel wrote:
> > Please replace PMD_SIZE with something along the lines of
> > EFI_UNACCEPTED_UNIT_SIZE and #define it to PMD_SIZE in
> > arch/x86/include/asm/efi.h.
> >
> > The comment below about the size of the bitmap vs the size of the
> > address space should probably move there as well.
>
> Okay, will do.
>
> > > +void accept_memory(phys_addr_t start, phys_addr_t end)
> > > +{
> > > +       unsigned long range_start, range_end;
> > > +       unsigned long bitmap_size;
> > > +       u64 unit_size;
> > > +
> > > +       if (!unaccepted_table)
> > > +               return;
> > > +
> > > +       unit_size = unaccepted_table->unit_size;
> > > +
> > > +       /*
> > > +        * Only care for the part of the range that is represented
> > > +        * in the bitmap.
> > > +        */
> > > +       if (start < unaccepted_table->phys_base)
> > > +               start = unaccepted_table->phys_base;
> > > +       if (end < unaccepted_table->phys_base)
> > > +               return;
> > > +
> > > +       /* Translate to offsets from the beginning of the bitmap */
> > > +       start -= unaccepted_table->phys_base;
> > > +       end -= unaccepted_table->phys_base;
> > > +
> > > +       /* Make sure not to overrun the bitmap */
> > > +       if (end > unaccepted_table->size * unit_size * BITS_PER_BYTE)
> > > +               end = unaccepted_table->size * unit_size * BITS_PER_BYTE;
> > > +
> >
> > Should we warn here?
>
> No. accept_memory() is nop for conventional memory (memblock calls it
> unconditionally).
>
> With the fixup, we only allocate bitmap for the range of physical address
> space where we have unaccepted memory. So if there's conventional memory
> after unaccepted, bitmap will not cover it.
>

Fair enough.
