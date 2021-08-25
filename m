Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 858343F76B7
	for <lists+linux-efi@lfdr.de>; Wed, 25 Aug 2021 16:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240148AbhHYOBJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 25 Aug 2021 10:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232058AbhHYOBJ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 25 Aug 2021 10:01:09 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FCB8C061757;
        Wed, 25 Aug 2021 07:00:22 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0ea7006bb4dcd1613a8626.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:a700:6bb4:dcd1:613a:8626])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B24E11EC032C;
        Wed, 25 Aug 2021 16:00:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1629900016;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=GhDtxzj1b1Wtn66QMK0bVDeTSbHy2I2GjFJNQ4tOTcs=;
        b=JQObVsKHzQ5hVxJmdcfCZsiUJqP6TAGsSfHvyV5ovpRf1//1rYhVadL4J3Ko/0A7WDsfK7
        y4YdG/2kZ/sK83Zf5Vqdnk+tj7ONnW6kzW+NfRw9Har380rpXiFNVu36+niS1bHXecPVX0
        hXw4d1tEXpF6nii57mSh7iNh9CYPWTc=
Date:   Wed, 25 Aug 2021 16:00:48 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>, tony.luck@intel.com,
        marcorr@google.com, sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH Part1 v5 17/38] x86/mm: Add support to validate memory
 when changing C-bit
Message-ID: <YSZNELMY27U05Idh@zn.tnic>
References: <20210820151933.22401-1-brijesh.singh@amd.com>
 <20210820151933.22401-18-brijesh.singh@amd.com>
 <YSYkHhAMSOotEzXQ@zn.tnic>
 <de04db4c-95e2-e921-5a2f-7fb33fed4fdc@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <de04db4c-95e2-e921-5a2f-7fb33fed4fdc@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Aug 25, 2021 at 08:54:31AM -0500, Brijesh Singh wrote:
> I replied to your previous comment. Depending on the npages value, the
> __set_page_state() will be called multiple times and on each call it
> needs to clear desc before populate it.

Ah, now I missed it, sorry.

> So, I do not see strong reason to use kzalloc() during the desc
> allocation.

Yeah, then you don't need it.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
