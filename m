Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA5EB591CA2
	for <lists+linux-efi@lfdr.de>; Sat, 13 Aug 2022 22:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240204AbiHMUzV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 13 Aug 2022 16:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240199AbiHMUzT (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 13 Aug 2022 16:55:19 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 009A010F0;
        Sat, 13 Aug 2022 13:55:17 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id A927F5C0055;
        Sat, 13 Aug 2022 16:55:14 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sat, 13 Aug 2022 16:55:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-transfer-encoding:content-type:date:date:from
        :from:in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1660424114; x=
        1660510514; bh=WBtXdFNwOXpOa6UfovUW6zsllC8njQzZuj2bCxqBaEM=; b=I
        1K4U+AGqp/MMbwesWBM9vBj8wAOP3vmcIDtL3xl52a63UjnUpGsuQpWPbgMPQY7m
        HGsZkYYdaPB9wcZ7qf9fyEctX5KspAm+ZYDxEkQKg5unYGKjTTqLwFSyha8/a8z2
        jSjxJD9RYLt7x1oiHcLAhPT+Mu5Nb8/VZ3kzFfEVKmr6d0Idbd1xdGA9YQJiKy/+
        a4tuy+2RzGYBFkrljcCzw60H1t2yI033463Mbua6iGGys5CGQwRjOwanqYUrTRrB
        yqnR209KUbusnRoa06wdE4uImR6H/byf+gp5kznfgrEn3sP+28xksln+ot8rjMHR
        QFJ4vRj1m/EDMSjWpX/Nw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1660424114; x=
        1660510514; bh=WBtXdFNwOXpOa6UfovUW6zsllC8njQzZuj2bCxqBaEM=; b=q
        0vzkHqvTCDkp3HiSnaEixVQzmYsa+ilbD31vvOVioD02JNu9/tBFSiA5/mx6Qbnr
        yXyM1jdC79dIlt3QY+ZLlJcVOkF+0nUi3NTciKZSvrkNdQkndYfLS9sFWVdlcI/K
        p9hiUmqyc0JgK8HMWWWUes+q0siITM0CykdtB5sY1t7UzY3yYXNPeB53ksAbGVwl
        5ZKxsy4j4kB8MjavDFxYa3IhBl++VAfKwuBTqXfigQrhLYlrDBZKj+ymwATl1aoL
        Qf5LINu4bbbzzmzgpD49fx/ZKRAfKjoa2ZrqttLgeAmr3ygtjpg0emI6QdPbgPN2
        tVqjabZIx4SzUq0MgwtXQ==
X-ME-Sender: <xms:sA_4Yv-k82_jEtSKZ-I1Im3Q_O3F1V6URf834z-3PyX9M3o2xx7lrw>
    <xme:sA_4Yrt2BBZhsxsKAjBo-lA9ntOcovCaa5W1JE9dL6QiuU5XhLHjJBVi0kjkf9aNz
    wRGZB0ocZBzXn70f9E>
X-ME-Received: <xmr:sA_4YtDnVvic2B5fPb5NdqujLy3K8jB7Su2UkqQm5yNzgBkC4q1wnNzPbU6mcHC0EIZpKQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdegkedgudehjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtugfgjgesthektddttddtjeenucfhrhhomhepfdfm
    ihhrihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovh
    drnhgrmhgvqeenucggtffrrghtthgvrhhnpefgjeeikefffeefvedugfdtkedvhfdttdei
    feevtdehgefgjeffleelgffggfdvkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:sQ_4Yrf_6CnNmErf-FyJxQP9wSgpokIcH-J1kHMPNrlzrP-lbJE8lA>
    <xmx:sQ_4YkMP69jKuCWtnGMAaXh4hxH8Xm097ipzqBubo2IZb8_MVxk8Zg>
    <xmx:sQ_4YtlNdjg1lmMBrrXNF-suaqvP0wv2vMzqGg1GDQJL3y2iGNdGWQ>
    <xmx:sg_4Ypbn7td2rTwiwWnuPf8zRTluy-P64Pi0n-2FKwLyEleY-Fd7mQ>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 13 Aug 2022 16:55:12 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id E987C104A08; Sat, 13 Aug 2022 23:58:13 +0300 (+03)
Date:   Sat, 13 Aug 2022 23:58:13 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Varad Gautam <varad.gautam@suse.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Marcelo Henrique Cerri <marcelo.cerri@canonical.com>,
        tim.gardner@canonical.com, khalid.elmously@canonical.com,
        philip.cox@canonical.com,
        the arch/x86 maintainers <x86@kernel.org>,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv7 10/14] x86/mm: Avoid load_unaligned_zeropad() stepping
 into unaccepted memory
Message-ID: <20220813205813.mx2zxzq7npbaxbxn@box.shutemov.name>
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
 <20220614120231.48165-11-kirill.shutemov@linux.intel.com>
 <Yt/ANO5usdV+JSSW@zn.tnic>
 <80cc204b-a24f-684f-ec66-1361b69cae39@intel.com>
 <073c5a97-272c-c5a0-19f2-c3f14f916c72@intel.com>
 <f2cf11d3-c2f8-4add-ab58-19a4844be361@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f2cf11d3-c2f8-4add-ab58-19a4844be361@www.fastmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, Aug 13, 2022 at 09:04:58AM -0700, Andy Lutomirski wrote:
> 
> 
> On Wed, Aug 3, 2022, at 7:02 AM, Dave Hansen wrote:
> > On 8/2/22 16:46, Dave Hansen wrote:
> >> To sum it all up, I'm not happy with the complexity of the page
> >> acceptance code either but I'm not sure that it's bad tradeoff compared
> >> to greater #VE complexity or fragility.
> >> 
> >> Does anyone think we should go back and really reconsider this?
> >
> > One other thing I remembered as I re-read my write up on this.
> >
> > In the "new" mode, guests never get #VE's for unaccepted memory.  They
> > just exit to the host and can never be reentered.  They must be killed.
> >
> > In the "old" mode, I _believe_ that the guest always gets a #VE for
> > non-EPT-present memory.  The #VE is basically the same no matter if the
> > page is unaccepted or if the host goes out and makes a
> > previously-accepted page non-present.
> >
> > One really nasty implication of this "old" mode is that the host can
> > remove *accepted* pages that are used in the syscall gap.  That means
> > that the #VE handler would need to be of the paranoid variety which
> > opens up all kinds of other fun.
> >
> >  * "Old" - #VE's can happen in the syscall gap
> >  * "New" - #VE's happen at better-defined times.  Unexpected ones are
> >    fatal.
> >
> > There's a third option which I proposed but doesn't yet exist.  The TDX
> > module _could_ separate the behavior of unaccepted memory #VE's and
> > host-induced #VEs.  This way, we could use load_unaligned_zeropad() with
> > impunity and handle it in the #VE handler.  At the same time, the host
> > would not be allowed to remove accepted memory and cause problems in the
> > syscall gap.  Kinda the best of both worlds.
> >
> > But, I'm not sure how valuable that would be now that we have the
> > (admittedly squirrelly) code to avoid load_unaligned_zeropad() #VE's.
> 
> How would that be implemented?  It would need to track which GPAs *were*
> accepted across a host-induced unmap/remap cycle. This would involve
> preventing the host from ever completely removing a secure EPT table
> without the guest’s help, right?
> 
> Admittedly this would IMO be better behavior. Is it practical to implement?

I don't think it is better if you look from host POV. It owns resources of
the machine and it has to have a way to pull memory from uncooperative TD
at any point.

It also would require more complicated private->shared conversion as guest
has to notify TDX module about the change, not only host as we do now.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
