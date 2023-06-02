Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC2017207DC
	for <lists+linux-efi@lfdr.de>; Fri,  2 Jun 2023 18:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235788AbjFBQpk (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 2 Jun 2023 12:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236232AbjFBQpk (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 2 Jun 2023 12:45:40 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F7913E;
        Fri,  2 Jun 2023 09:45:39 -0700 (PDT)
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B6F841EC04C0;
        Fri,  2 Jun 2023 18:45:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1685724337;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=v+iZQvcIZDIr0NXpJZ+ESGpCVBA4dbOR+2khS5CocZ0=;
        b=ThydF2AnQAysnFBmv2YYs+RDGPGHzgRBIIBQlVAWX9f10VmQMPW5+cBfpzcBqgpcxdCkAT
        Ur6UEZeQCMbhtKUepfXBNC+Qa46D+yYdomMT2niOsGaKNbX652i0N/Ttl4kJSGqFlL6DEO
        UW+S+DBYC52QtY32EEQ28rsG3vuW9z8=
Date:   Fri, 2 Jun 2023 18:45:33 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
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
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Liam Merwick <liam.merwick@oracle.com>
Subject: Re: [PATCHv13 4/9] x86/boot/compressed: Handle unaccepted memory
Message-ID: <20230602164533.GHZHocre9bsQsU5L4+@fat_crate.local>
References: <20230601182543.19036-1-kirill.shutemov@linux.intel.com>
 <20230601182543.19036-5-kirill.shutemov@linux.intel.com>
 <20230602140641.GKZHn3caQpYveKxFgU@fat_crate.local>
 <20230602153644.cbdicj2cc6p6goh3@box.shutemov.name>
 <20230602160900.GEZHoUHHpPKMnzV3bs@fat_crate.local>
 <CAMj1kXENJ6VJMDtVmKqozRb6NMU7Y-fhYJWiCbRd2aQ_tmXHMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXENJ6VJMDtVmKqozRb6NMU7Y-fhYJWiCbRd2aQ_tmXHMg@mail.gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jun 02, 2023 at 06:17:13PM +0200, Ard Biesheuvel wrote:
> 'EFI code' is ambiguous here.
> 
> Most of the decompressor code is constructed in a way that permits
> - booting 'native EFI' via the EFI stub
> - booting 'pseudo-EFI' where GRUB or another Linux/x86 specific
> bootloader populates boot_params with all the EFI specific information
> (system table, memory map, etc)
> 
> This distinction has been abstracted away here, and so we might be
> dealing with the second case, and booting from a GRUB that does not
> understand accepted memory, but simply copied the EFI memory map
> (including unaccepted regions) as it normally does. (Note that the
> second case also covers kexec boot, so we do need to support it)

Right, I was hoping there to be some glue which sanity-checks
boot_params.efi_info instead relying on users to do so and thus have
a bunch of duplicated code.

So, yes, right after populating the boot_params pointer...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
