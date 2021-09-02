Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39F573FEC7D
	for <lists+linux-efi@lfdr.de>; Thu,  2 Sep 2021 12:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233504AbhIBKyX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 2 Sep 2021 06:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231544AbhIBKyW (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 2 Sep 2021 06:54:22 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEEB6C061575;
        Thu,  2 Sep 2021 03:53:24 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0ed100d115725f57e7001c.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:d100:d115:725f:57e7:1c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 40DE61EC054C;
        Thu,  2 Sep 2021 12:53:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1630579998;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=8MEGxmWQPn7vM1CQz7iBVTV01OFVHRNCMyD18pnrHMU=;
        b=hBCT8Uo/0yz1DU5li4Hs9UtPsjlEm8FmUlzn/tonYVYiGIN/T/kboq1BgbTUZuSI2ukhRi
        Ws+JOgMzpu2KMb4rGDb6V3inGADA7TGs2Zvh2CjBVtAvObOz+yYSkJumbV2g10a+Mw6cqi
        6ZQcJMuehyqettHsgGfQCeAU+K9g0Io=
Date:   Thu, 2 Sep 2021 12:53:54 +0200
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
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>, tony.luck@intel.com,
        marcorr@google.com, sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH Part1 v5 28/38] x86/compressed/64: enable
 SEV-SNP-validated CPUID in #VC handler
Message-ID: <YTCtQmxGaYSL+ZqZ@zn.tnic>
References: <20210820151933.22401-1-brijesh.singh@amd.com>
 <20210820151933.22401-29-brijesh.singh@amd.com>
 <YSaXtpKT+iE7dxYq@zn.tnic>
 <20210827164601.fzr45veg7a6r4lbp@amd.com>
 <YS3+saDefHwkYwny@zn.tnic>
 <20210901010325.3nqw7d44vhsdzryb@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210901010325.3nqw7d44vhsdzryb@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Aug 31, 2021 at 08:03:25PM -0500, Michael Roth wrote:
> It was used previously in kernel proper to get at the secrets page later,
> but now it's obtained via the cached entry in boot_params.cc_blob_address.
> Unfortunately it uses EFI_GUID() macro, so maybe efi.c or misc.h where
> it makes more sense to add a copy of the macro?

A copy?

arch/x86/boot/compressed/efi.c already includes linux/efi.h where that
macro is defined.

That ship has already sailed. ;-\

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
