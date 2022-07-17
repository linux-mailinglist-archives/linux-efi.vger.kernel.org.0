Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13EEC57776F
	for <lists+linux-efi@lfdr.de>; Sun, 17 Jul 2022 19:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbiGQRQo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 17 Jul 2022 13:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232951AbiGQRQo (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 17 Jul 2022 13:16:44 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF721122;
        Sun, 17 Jul 2022 10:16:43 -0700 (PDT)
Received: from zn.tnic (p200300ea97297694329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9729:7694:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 213E61EC00F8;
        Sun, 17 Jul 2022 19:16:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1658078197;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=YMyRMtPkAHFEJeFlvvh7As/CmA56O06Fs8vTb9G0On4=;
        b=NjA9bS4O6bVxhNEDGAr9WgB6eGW0WbnqYgLiVPeKtwN7ATIzlWyhQOvcxnxfqJ6yoEX2XE
        Bh8d+arMLXrlPA7tVeGKYc+VD5FScRS0U3BhUUovD/2iMNW2PwiCT9Xp3Q2fEZNkJKwtEd
        R1JtfB7Btx8JubJXOlp3JKhR+eTf0yQ=
Date:   Sun, 17 Jul 2022 19:16:32 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
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
Message-ID: <YtRD8MJGTJLzRRV2@zn.tnic>
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
 <20220614120231.48165-6-kirill.shutemov@linux.intel.com>
 <YqmyQZa4CTHkH3gT@hirez.programming.kicks-ass.net>
 <20220615150534.ylkref3runa4kmyj@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220615150534.ylkref3runa4kmyj@box.shutemov.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jun 15, 2022 at 06:05:34PM +0300, Kirill A. Shutemov wrote:
> It also sounds painfully similar to uapi/ project. I'm not sure we want to
> go this path.

It is the same path perf tool is taking - see first paragraph:

https://lore.kernel.org/r/YtQM40VmiLTkPND2@kernel.org

I don't want to deal with the regular breakages or hacks to
boot/compressed/ just because little duplication. We copy the header
once and that's it - it doesn't even have to get updated like perf tool
does from time to time.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
