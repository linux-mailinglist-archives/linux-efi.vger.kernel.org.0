Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92FCD4AD740
	for <lists+linux-efi@lfdr.de>; Tue,  8 Feb 2022 12:32:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356424AbiBHLcU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 8 Feb 2022 06:32:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346341AbiBHKv3 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 8 Feb 2022 05:51:29 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A21A2C03FEC0;
        Tue,  8 Feb 2022 02:51:27 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F0C0A1EC00F8;
        Tue,  8 Feb 2022 11:51:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1644317482;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=yxZ0nR15n7mkZeUUipZpTNufPRwpkzb7/Yfx2nthKHw=;
        b=T9Uwof1JPVAt8ASYSIUa3QaOxuvcwTqgS4A1/d8dSH3XsLJGSVDgzqkQEA3SpoBzGPKWbN
        qK1A+0n4DUJlXw9Oy3UzYqF5LJ2Bi/mjDuQKYD5N5jE0WdXS382dpSohbyviT6xPIP402H
        NxXMNHdzWIPMeDDmQa1BOpu9LiTkpxA=
Date:   Tue, 8 Feb 2022 11:51:16 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Dov Murik <dovmurik@linux.ibm.com>
Cc:     Brijesh Singh <brijesh.singh@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        brijesh.ksingh@gmail.com, tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        Liam Merwick <liam.merwick@oracle.com>
Subject: Re: [PATCH v9 42/43] virt: sevguest: Add support to derive key
Message-ID: <YgJLJJiosIOHLWYz@zn.tnic>
References: <20220128171804.569796-1-brijesh.singh@amd.com>
 <20220128171804.569796-43-brijesh.singh@amd.com>
 <YgDduR0mrptX5arB@zn.tnic>
 <1cb4fdf5-7c1e-6c8f-1db6-8c976d6437c2@amd.com>
 <ae1644a3-bd2c-6966-4ae3-e26abd77b77b@linux.ibm.com>
 <20ba1ac2-83d1-6766-7821-c9c8184fb59b@amd.com>
 <cd3ef9dd-cfc5-ac8c-d524-d8d4416f5cad@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cd3ef9dd-cfc5-ac8c-d524-d8d4416f5cad@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Feb 08, 2022 at 09:56:52AM +0200, Dov Murik wrote:
> Just to be clear, I didn't mean necessarily "leak the key to the
> untrusted host" (even if a page is converted back from private to
> shared, it is encrypted, so host can't read its contents).  But even
> *inside* the guest, when dealing with sensitive data like keys, we
> should minimize the amount of copies that float around (I assume this is
> the reason for most of the uses of memzero_explicit() in the kernel).

I don't know about Brijesh but I understood you exactly as you mean it.
And yap, I agree we should always clear such sensitive buffers.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
