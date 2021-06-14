Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90D543A6E84
	for <lists+linux-efi@lfdr.de>; Mon, 14 Jun 2021 21:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233489AbhFNTFQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 14 Jun 2021 15:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233387AbhFNTFP (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 14 Jun 2021 15:05:15 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62AE8C061574;
        Mon, 14 Jun 2021 12:03:12 -0700 (PDT)
Received: from zn.tnic (p200300ec2f09b9000b7fffe760596043.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:b900:b7f:ffe7:6059:6043])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A45541EC036C;
        Mon, 14 Jun 2021 21:03:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1623697390;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/3kMPVen/9z57u2UbxMExDvEmMgUhoVDDFZvPh6gxAo=;
        b=XuoyLLRbZevtMCxqnibgVla732fFMZoVlK33TxMxxQUlxz3GPgAFbXE3jlB7UUUjg6h99/
        IW7ku0XcDx5s+rQByrGWw/+wnwKTUcUOpIc/hNQClxs8DtchLYYBiXCS9e+kBMK2z47Q4/
        1uleZYgfef/L0DIl2EU1wsc7OXHxoMw=
Date:   Mon, 14 Jun 2021 21:03:03 +0200
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
Subject: Re: [PATCH Part1 RFC v3 11/22] x86/sev: Add helper for validating
 pages in early enc attribute changes
Message-ID: <YMen5wVqR31D/Q4z@zn.tnic>
References: <20210602140416.23573-1-brijesh.singh@amd.com>
 <20210602140416.23573-12-brijesh.singh@amd.com>
 <YMI02+k2zk9eazjQ@zn.tnic>
 <d0759889-94df-73b0-4285-fa064eb187cd@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d0759889-94df-73b0-4285-fa064eb187cd@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Jun 14, 2021 at 07:45:11AM -0500, Brijesh Singh wrote:
> IMO, there is no need to add a warning. This case should happen if its
> either a hypervisor bug or hypervisor does not follow the GHCB
> specification. I followed the SEV-ES vmgexit handling  and it does not
> warn if the hypervisor returns a wrong response code. We simply
> terminate the guest.

This brings my regular user-friendliness question: will the guest user
know what happened or will the guest simply disappear/freeze without any
hint as to what has happened so that a post-mortem analysis would turn
out hard to decipher?

> I did thought about reusing the VMGEXIT defined macro
> SNP_PAGE_STATE_{PRIVATE, SHARED} but I was not sure if you will be okay
> with that.

Yeah, I think that makes stuff simpler. Unless there's something
speaking against it which we both are not thinking of right now.

> Additionally now both the function name and macro name will
> include the "SNP". The call will look like this:
> 
> snp_prep_memory(paddr, SNP_PAGE_STATE_PRIVATE)

Yap, looks ok to me.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
