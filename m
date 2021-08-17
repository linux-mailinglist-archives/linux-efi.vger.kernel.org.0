Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9C33EF131
	for <lists+linux-efi@lfdr.de>; Tue, 17 Aug 2021 19:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232508AbhHQR7k (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 17 Aug 2021 13:59:40 -0400
Received: from mail.skyhub.de ([5.9.137.197]:44276 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232473AbhHQR7j (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 17 Aug 2021 13:59:39 -0400
Received: from zn.tnic (p200300ec2f1175006a73053df3c19379.dip0.t-ipconnect.de [IPv6:2003:ec:2f11:7500:6a73:53d:f3c1:9379])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 73ADE1EC0559;
        Tue, 17 Aug 2021 19:59:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1629223140;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=/B3tGZBJZFxPf2sglgeiq9bPvrxKdeq14ETJ51YqiI4=;
        b=EkA7tMgO3fOX+XRzkDasPkMlqpJPXIlYrraX96Usru3x8e9WyoBy/4Jp+7a9ji1oPbCCMC
        28wzwsanSGZ756qutlLNG77DUoTMEgivkRRlog6jQwDHAiRkADS6bfVtQKkW+Fjg3HgWKu
        9ECkkVpDozDI+IpTTT8Cs3DlbjoAXuM=
Date:   Tue, 17 Aug 2021 19:59:44 +0200
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
        David Rientjes <rientjes@google.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>, tony.luck@intel.com,
        npmccallum@redhat.com, brijesh.ksingh@gmail.com
Subject: Re: [PATCH Part1 RFC v4 16/36] KVM: SVM: define new SEV_FEATURES
 field in the VMCB Save State Area
Message-ID: <YRv5EJMuNygtfRGz@zn.tnic>
References: <20210707181506.30489-1-brijesh.singh@amd.com>
 <20210707181506.30489-17-brijesh.singh@amd.com>
 <YRv3x/JeNjcJ4E8a@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YRv3x/JeNjcJ4E8a@zn.tnic>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Aug 17, 2021 at 07:54:15PM +0200, Borislav Petkov wrote:
> And by the way, why is this patch and the next 3 part of the guest set?
> They look like they belong into the hypervisor set.

Aha, patch 20 and further need the definitions.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
