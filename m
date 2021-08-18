Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 262883EFF5E
	for <lists+linux-efi@lfdr.de>; Wed, 18 Aug 2021 10:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238050AbhHRIkS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 18 Aug 2021 04:40:18 -0400
Received: from mail.skyhub.de ([5.9.137.197]:52414 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238656AbhHRIkR (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 18 Aug 2021 04:40:17 -0400
Received: from zn.tnic (p4fed307d.dip0.t-ipconnect.de [79.237.48.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 53A0F1EC0345;
        Wed, 18 Aug 2021 10:39:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1629275976;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=VasVNSq4gd8Mrv+rRUUXRrEVEG/zyKOK8zOsDpdUhA8=;
        b=Yrf4DQSz1/Vx2Gs6IIl5JsuKogIzqVeNQM7uiItJdpRnZBiF1pa9OewR6hash59iHTyvuW
        NlE3QFjxjGpIundXvTH8IGvM2keM7D/CG56+sCJfBFGVi6HGCnCfl5/XY3BQ1N8M9Tjvy+
        L9OFtzimJdaNb10F0huQNz0MMJecjlM=
Date:   Wed, 18 Aug 2021 10:38:04 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     Brijesh Singh <brijesh.singh@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
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
        Vlastimil Babka <vbabka@suse.cz>, tony.luck@intel.com,
        npmccallum@redhat.com, brijesh.ksingh@gmail.com
Subject: Re: [PATCH Part1 RFC v4 20/36] x86/sev: Use SEV-SNP AP creation to
 start secondary CPUs
Message-ID: <YRzG7OcnbQpz7uok@zn.tnic>
References: <20210707181506.30489-1-brijesh.singh@amd.com>
 <20210707181506.30489-21-brijesh.singh@amd.com>
 <YRwWSizr/xoWXivV@zn.tnic>
 <35b57719-5f31-c71a-7a2f-d34f6e239d26@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <35b57719-5f31-c71a-7a2f-d34f6e239d26@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Aug 17, 2021 at 05:13:54PM -0500, Tom Lendacky wrote:
> Well, yes and no. It really is just setting or clearing the VMSA page
> attribute. It isn't trying to update permissions for the lower VMPLs, so I
> didn't want to mislabel it as a general rmpadjust function. But it's a
> simple enough thing to change and if multiple VMPL levels are ever
> supported it can be evaluated at that time.

You got it - when we need more RMPADJUST functionality, then that should
be the function that gets the beefing up.

:-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
