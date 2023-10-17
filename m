Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58C357CBFFE
	for <lists+linux-efi@lfdr.de>; Tue, 17 Oct 2023 11:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234788AbjJQJ5W (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 17 Oct 2023 05:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234752AbjJQJ5V (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 17 Oct 2023 05:57:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C66F8E;
        Tue, 17 Oct 2023 02:57:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8CCCC433D9;
        Tue, 17 Oct 2023 09:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697536639;
        bh=sKwYVnqhSSrwqp7PC9H2TY6yCD+XS2CditWC5vXqB+4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CBgxSfB237rqRI9/lYgZglglsdpwEqcW7F0KqpbEKc15ZDg3CHRwqrxtl3WbD5ts4
         LY0MgzE3g7ZTeyfPZD/4h4w/Rv4vAfcBvUDWw8saPVGVzAXrGHmIWfpz/EM3KWtgoZ
         HWLGHI6ZYI6GgwzdrxSHSjMgFxmiizLgfjvp5hatThd1AVR6zR/bzp/sQC9Qz7G8ci
         KWvhOx0NpS+F8kmwW13nNN2nzW3e26WHAHh8+CYvo4Kp2kY7D+4RQo0REXfuvCsYOW
         6DT9gvrsG8IOFI5PoiLbbzs7hClUKkkCoOegLl8io3zB/EUSZoXTwuevn8Pqtwv4CN
         vIc7qpt0hH4aA==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2c5071165d5so41305521fa.0;
        Tue, 17 Oct 2023 02:57:19 -0700 (PDT)
X-Gm-Message-State: AOJu0YxIIXV7A2P7psga2B/hZnlfTzyFrBzhADaO1vbQ1Wens4pSsvl1
        pZRGQttONfdIA+Tg1vxsOYwYmzXwIQDvlfExrh8=
X-Google-Smtp-Source: AGHT+IERIod7g0rUfYOG5lQ+1VdU8HkDDU1bvoLEdkPVYMpGfqbElsDImze8vsj7zXXRxTLmhlOFqN7ybSsC3FaHCv0=
X-Received: by 2002:a2e:be12:0:b0:2bd:133c:2d71 with SMTP id
 z18-20020a2ebe12000000b002bd133c2d71mr1124282ljq.52.1697536638036; Tue, 17
 Oct 2023 02:57:18 -0700 (PDT)
MIME-Version: 1.0
References: <20231016163122.12855-1-kirill.shutemov@linux.intel.com>
 <ZS15HZqK4hu5NjSh@casper.infradead.org> <20231016213932.6cscnn6tsnzsnvmf@box.shutemov.name>
 <CAMj1kXFc31N61=oQayLbnR+CrNT4=bfEisC3fwG4VNq2vJHV5w@mail.gmail.com> <20231017094403.g6laxp2c3vwzt2sw@box.shutemov.name>
In-Reply-To: <20231017094403.g6laxp2c3vwzt2sw@box.shutemov.name>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 17 Oct 2023 11:57:06 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFuCwLbfgymuy6iEf5ztonjkGBn+K42BgSBT_1hQwwrqw@mail.gmail.com>
Message-ID: <CAMj1kXFuCwLbfgymuy6iEf5ztonjkGBn+K42BgSBT_1hQwwrqw@mail.gmail.com>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 17 Oct 2023 at 11:44, Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> On Tue, Oct 17, 2023 at 09:42:13AM +0200, Ard Biesheuvel wrote:
> > On Mon, 16 Oct 2023 at 23:39, Kirill A. Shutemov
> > <kirill.shutemov@linux.intel.com> wrote:
> > >
> > > On Mon, Oct 16, 2023 at 06:55:41PM +0100, Matthew Wilcox wrote:
> > > > On Mon, Oct 16, 2023 at 07:31:22PM +0300, Kirill A. Shutemov wrote:
> > > > >   v2:
> > > > >    - Fix deadlock (Vlastimil);
> > > > >    - Fix comments (Vlastimil);
> > > > >    - s/cond_resched()/cpu_relax()/ -- cond_resched() cannot be called
> > > > >      from atomic context;
> > > >
> > > > Isn't there an implicit cpu_relax() while we're spinning?  Does this
> > > > really accomplish anything?
> > >
> > > You are right. It is useless. I will drop it in v3.
> > >
> >
> > I can drop that bit when applying the patch.
> >
> > One question I have is whether the sequence
> >
> > spin_lock_irqsave(&unaccepted_memory_lock, flags);
> > ...
> > spin_unlock(&unaccepted_memory_lock);
> > arch_accept_memory(phys_start, phys_end);
> > spin_lock(&unaccepted_memory_lock);
> > ...
> > spin_unlock_irqrestore(&unaccepted_memory_lock, flags);
> >
> > is considered sound and is supported by all architectures?
>
> I am not an locking expert and only tested it on x86. But what potential
> issue do you see?
>

Not sure. It just looks slightly out of place, and I am curious
whether all architectures tolerate this asymmetric use.
