Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B19A3A96E7
	for <lists+linux-efi@lfdr.de>; Wed, 16 Jun 2021 12:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbhFPKJq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 16 Jun 2021 06:09:46 -0400
Received: from mail.skyhub.de ([5.9.137.197]:37578 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231517AbhFPKJq (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 16 Jun 2021 06:09:46 -0400
Received: from zn.tnic (p200300ec2f0c2b0089cf8396f15d74fc.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:2b00:89cf:8396:f15d:74fc])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 262CD1EC011B;
        Wed, 16 Jun 2021 12:07:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1623838059;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=o7KFhonTIxDXl8bSt8cSO6XzEEC+WD1uYlFt+dwJmIo=;
        b=MlVZXLFekihFNMiQxAFlUew33fpaul+3yauFtWU1/PuS0gJrj617n/l+nXYu1EvOeQpDJe
        z+2za3g6o8wNnsFYPMTTGUZJ31EEJC660oz1OZ1aFZkFjl3R8ExeaA9WfUcmoEWsGWNi66
        y3/7cF514idKkvFUTPFewVCNSP3z4MI=
Date:   Wed, 16 Jun 2021 12:07:28 +0200
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
Message-ID: <YMnNYNBvEEAr5kqd@zn.tnic>
References: <20210602140416.23573-1-brijesh.singh@amd.com>
 <20210602140416.23573-12-brijesh.singh@amd.com>
 <YMI02+k2zk9eazjQ@zn.tnic>
 <d0759889-94df-73b0-4285-fa064eb187cd@amd.com>
 <YMen5wVqR31D/Q4z@zn.tnic>
 <70db789d-b1aa-c355-2d16-51ace4666b3f@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <70db789d-b1aa-c355-2d16-51ace4666b3f@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Jun 14, 2021 at 04:01:44PM -0500, Brijesh Singh wrote:
> Now that we have to defined a Linux specific reason set, we could
> potentially define a new error code "Invalid response code" and return

I don't understand - you have a WARN for the following check:

                if (WARN(GHCB_MSR_PSC_RESP_VAL(val),
                         "Failed to change page state to '%s' paddr 0x%lx error 0x%llx\n",

what's wrong with doing:

                if (WARN(GHCB_RESP_CODE(val) != GHCB_MSR_PSC_RESP,
                         "Wrong PSC response code: 0x%x\n",
                         (unsigned int)GHCB_RESP_CODE(val)))
                        goto e_term;


above it too?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
