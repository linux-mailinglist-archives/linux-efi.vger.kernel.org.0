Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3644AA8E6
	for <lists+linux-efi@lfdr.de>; Sat,  5 Feb 2022 13:58:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379881AbiBEM6e (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 5 Feb 2022 07:58:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379880AbiBEM6d (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 5 Feb 2022 07:58:33 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F9AC061346;
        Sat,  5 Feb 2022 04:58:31 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8A47E1EC051E;
        Sat,  5 Feb 2022 13:58:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1644065904;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=tMdpZOVjcxNYTf1hneKSsplSHhxQLlxm5Sz2vRQUZE8=;
        b=Fx49uIDLxhimJLwU97wT35RjrcjccqR1vInu6AJlT06+WZVhTQ7YdNkKPUH84qMuFj29aq
        3WWq+V5dgh/vgSj8kGzMNVocP/rgIbYYcnEXdC9mgJqBYpgxcQrWyhgZPDlYDdkO9/uWlS
        wPDMv0SZ3wMmJsmaMGyeRbQkO1tHEzY=
Date:   Sat, 5 Feb 2022 13:58:20 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Michael Roth <michael.roth@amd.com>
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
        Dov Murik <dovmurik@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        brijesh.ksingh@gmail.com, tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        Venu Busireddy <venu.busireddy@oracle.com>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v9 23/43] KVM: x86: Move lookup of indexed CPUID leafs to
 helper
Message-ID: <Yf50bG0N+PYK07lq@zn.tnic>
References: <20220128171804.569796-1-brijesh.singh@amd.com>
 <20220128171804.569796-24-brijesh.singh@amd.com>
 <Yfvx0Rq8Tydyr/RO@zn.tnic>
 <20220203164443.byaxr4fu2vlvh4d2@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220203164443.byaxr4fu2vlvh4d2@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Feb 03, 2022 at 10:44:43AM -0600, Michael Roth wrote:
> I think Dave's main concern was that I'd added an AMD copyright banner
> to a new file that was mostly derived from acpi.c. I thought we had some
> agreement on simply adopting the file-wide copyright banner of whatever
> source file the new one was derived from, since dropping an existing
> copyright seemed similarly in bad taste,...

Well, I think simply saying where this function was carved out from:

	arch/x86/kvm/cpuid.c

is good enough. If someone is so much interested in a copyright, someone
can read that file's copyright. Especially since that copyright line
in the original file is not telling you a whole lot about who are all
copyright owners.

And before we delve into lawyer-land, let's simply point to where we got
this from and be done with it.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
