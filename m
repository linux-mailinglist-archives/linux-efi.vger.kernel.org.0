Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA04354C5E7
	for <lists+linux-efi@lfdr.de>; Wed, 15 Jun 2022 12:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347652AbiFOKVh (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 15 Jun 2022 06:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347946AbiFOKUs (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 15 Jun 2022 06:20:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F7464E397;
        Wed, 15 Jun 2022 03:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OTj5z30HkEHTzFiSxL8zrtVzrsYfnlyDuMzdm361bU0=; b=HCUls9LzF3Ps7n0VKUrnzevomJ
        ia+L7aZ6++crtm+I+wasUYBWPh4AONMp82XIzv46xzbr01uby2v9ZiREiWfuzUzGt3xvdb+xXDpTx
        Ys5ExBktr3NiVd3FTPKxiQFYFafBmQzU4CmKSgypkau70lUhzVwL4xFYfp13PoBtiK60KPa2492ik
        EWetzqpBqWUpLY9Rd0yKtpw/HIuYRRbaE11vYU5KnLQVEh6T62LQ0SJ8Saj/n4m0NN/8Rb1trWyy8
        ujTRzVQCCrKXBehhcJBgGpLLblOsGcwZPb8tcKk5+Lnp+vGBLVChofkwqzoA6VvFvPZEmEY5SC/7Y
        XIDLNMTA==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o1Q7n-000yG9-2r; Wed, 15 Jun 2022 10:19:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E9F553007C6;
        Wed, 15 Jun 2022 12:19:45 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D38BF201A4F6D; Wed, 15 Jun 2022 12:19:45 +0200 (CEST)
Date:   Wed, 15 Jun 2022 12:19:45 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Varad Gautam <varad.gautam@suse.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        x86@kernel.org, linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv7 05/14] x86/boot: Add infrastructure required for
 unaccepted memory support
Message-ID: <YqmyQZa4CTHkH3gT@hirez.programming.kicks-ass.net>
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
 <20220614120231.48165-6-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220614120231.48165-6-kirill.shutemov@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Jun 14, 2022 at 03:02:22PM +0300, Kirill A. Shutemov wrote:
> Pull functionality from the main kernel headers and lib/ that is
> required for unaccepted memory support.
> 
> This is preparatory patch. The users for the functionality will come in
> following patches.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  arch/x86/boot/bitops.h                   | 40 ++++++++++++
>  arch/x86/boot/compressed/align.h         | 14 +++++
>  arch/x86/boot/compressed/bitmap.c        | 43 +++++++++++++
>  arch/x86/boot/compressed/bitmap.h        | 49 +++++++++++++++
>  arch/x86/boot/compressed/bits.h          | 36 +++++++++++
>  arch/x86/boot/compressed/compiler.h      |  9 +++
>  arch/x86/boot/compressed/find.c          | 54 ++++++++++++++++
>  arch/x86/boot/compressed/find.h          | 80 ++++++++++++++++++++++++
>  arch/x86/boot/compressed/math.h          | 37 +++++++++++
>  arch/x86/boot/compressed/minmax.h        | 61 ++++++++++++++++++
>  arch/x86/boot/compressed/pgtable_types.h | 25 ++++++++

That's quite a lot of duplicated code; is there really no way so share
this?
