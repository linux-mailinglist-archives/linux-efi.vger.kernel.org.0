Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 065353AC7F1
	for <lists+linux-efi@lfdr.de>; Fri, 18 Jun 2021 11:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232409AbhFRJtN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 18 Jun 2021 05:49:13 -0400
Received: from mail.skyhub.de ([5.9.137.197]:34154 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230399AbhFRJtL (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 18 Jun 2021 05:49:11 -0400
Received: from zn.tnic (p200300ec2f0dd8004fc95bebb5201001.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:d800:4fc9:5beb:b520:1001])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6F1EC1EC0559;
        Fri, 18 Jun 2021 11:46:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1624009601;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=fhCS1VjB+E7C2WKgFiWhTOQPZHXnjbEcqr3FRlWi0xU=;
        b=mVNHyRCG/AgGBIUULY2n0rYyqbBpwtuaHTqg5MgQ8DzjcE9TF4eqo9kb51Zi7yIPdYmL1j
        UmVDFMG5XYUnevK4WKpCAJrbwegX9Q43eENYMOjzOw/qYPF1y04M24QPeRJ9ZYw+hFFVzJ
        pl8wgyAk+mMAdq8y2SXzcZsoQS0G0Ek=
Date:   Fri, 18 Jun 2021 11:46:31 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
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
        David Rientjes <rientjes@google.com>, tony.luck@intel.com,
        npmccallum@redhat.com
Subject: Re: [PATCH Part1 RFC v3 21/22] x86/sev: Register SNP guest request
 platform device
Message-ID: <YMxrd5M1teku/hnA@zn.tnic>
References: <20210602140416.23573-1-brijesh.singh@amd.com>
 <20210602140416.23573-22-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210602140416.23573-22-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jun 02, 2021 at 09:04:15AM -0500, Brijesh Singh wrote:
>  arch/x86/include/asm/sev.h      |  12 +++
>  arch/x86/include/uapi/asm/svm.h |   2 +
>  arch/x86/kernel/sev.c           | 176 ++++++++++++++++++++++++++++++++
>  arch/x86/platform/efi/efi.c     |   2 +
>  include/linux/efi.h             |   1 +
>  include/linux/sev-guest.h       |  76 ++++++++++++++
>  6 files changed, 269 insertions(+)
>  create mode 100644 include/linux/sev-guest.h

This patch is at least three patches in one:

1. EFI changes
2. SNP_GUEST_REQUEST struct etc definitions
3. Add the functionality.

Please split it this way before I take a look.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
