Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1DEE7CBC7A
	for <lists+linux-efi@lfdr.de>; Tue, 17 Oct 2023 09:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjJQHm3 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 17 Oct 2023 03:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234416AbjJQHm2 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 17 Oct 2023 03:42:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C228F;
        Tue, 17 Oct 2023 00:42:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D68BC43391;
        Tue, 17 Oct 2023 07:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697528547;
        bh=hdERecnIBxJ0MlSI/qFnbuDT7jHHTRqnpZ2J8bhRs0A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=t5VTK9MMoMSJ3wX9+6eF0H/8lC2QsDGUqK28ldXbXW9Njmzz/FUgzjlx/PEEfUfBA
         EhNnfC+JALb1lxrXTE9UUk/dVoj9A1gk95MvCZ81oHI+2QuEnyB8PfhMVZwFj4WyVb
         iahiCAWxzYnIjK8QJWv7ArhAC6VP8Bqjg5VnGRQ4Hs6Vwk3lNiy8XpZTfrDBhzk73y
         d/KjfWNHP0ZTXF3jVt4ymT59O0dVfkbzVmem47c/xy/2XLT6DlVmq5JCwqcQ6UzWVE
         L4Juf6ZPvErTWUwTwU3EFs+jzw0Xd2sGdZfoUM3V/cjeGrDitLtv/xAzNQv18XpTRc
         Yhp5bFnFwAPMg==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2c17de836fbso64093841fa.1;
        Tue, 17 Oct 2023 00:42:27 -0700 (PDT)
X-Gm-Message-State: AOJu0Ywb4MRoN27eDndeUumh3XFsbehRcZD7NJDBakCe2eJPmHXm7NRW
        al1uKprp0aB/MrfYcuOCNIrfL/zzmW6gIPNT7Xo=
X-Google-Smtp-Source: AGHT+IEwVz4NDJ+en2GCL5MEQcrrYTlDDUj+7INXdoXGL9jUkM8pjO/KAi249rHEfWTo3BmUUzUFvmwTpf7MTxrcuFo=
X-Received: by 2002:a2e:9c09:0:b0:2c5:19ab:7270 with SMTP id
 s9-20020a2e9c09000000b002c519ab7270mr1010729lji.35.1697528545373; Tue, 17 Oct
 2023 00:42:25 -0700 (PDT)
MIME-Version: 1.0
References: <20231016163122.12855-1-kirill.shutemov@linux.intel.com>
 <ZS15HZqK4hu5NjSh@casper.infradead.org> <20231016213932.6cscnn6tsnzsnvmf@box.shutemov.name>
In-Reply-To: <20231016213932.6cscnn6tsnzsnvmf@box.shutemov.name>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 17 Oct 2023 09:42:13 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFc31N61=oQayLbnR+CrNT4=bfEisC3fwG4VNq2vJHV5w@mail.gmail.com>
Message-ID: <CAMj1kXFc31N61=oQayLbnR+CrNT4=bfEisC3fwG4VNq2vJHV5w@mail.gmail.com>
Subject: Re: [PATCHv2] efi/unaccepted: Fix soft lockups caused by parallel
 memory acceptance
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
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
        philip.cox@canonical.com, aarcange@redhat.com, peterx@redhat.com,
        x86@kernel.org, linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@kernel.org, Nikolay Borisov <nik.borisov@suse.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 16 Oct 2023 at 23:39, Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> On Mon, Oct 16, 2023 at 06:55:41PM +0100, Matthew Wilcox wrote:
> > On Mon, Oct 16, 2023 at 07:31:22PM +0300, Kirill A. Shutemov wrote:
> > >   v2:
> > >    - Fix deadlock (Vlastimil);
> > >    - Fix comments (Vlastimil);
> > >    - s/cond_resched()/cpu_relax()/ -- cond_resched() cannot be called
> > >      from atomic context;
> >
> > Isn't there an implicit cpu_relax() while we're spinning?  Does this
> > really accomplish anything?
>
> You are right. It is useless. I will drop it in v3.
>

I can drop that bit when applying the patch.

One question I have is whether the sequence

spin_lock_irqsave(&unaccepted_memory_lock, flags);
...
spin_unlock(&unaccepted_memory_lock);
arch_accept_memory(phys_start, phys_end);
spin_lock(&unaccepted_memory_lock);
...
spin_unlock_irqrestore(&unaccepted_memory_lock, flags);

is considered sound and is supported by all architectures?
