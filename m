Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC14E3A6F66
	for <lists+linux-efi@lfdr.de>; Mon, 14 Jun 2021 21:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233892AbhFNTwY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 14 Jun 2021 15:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233356AbhFNTwX (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 14 Jun 2021 15:52:23 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D99C061574;
        Mon, 14 Jun 2021 12:50:20 -0700 (PDT)
Received: from zn.tnic (p200300ec2f09b9000c5f6a5325ce378c.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:b900:c5f:6a53:25ce:378c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3E1DE1EC04DB;
        Mon, 14 Jun 2021 21:50:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1623700219;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=9YY3xAUgDz0EUh/pTeFLuR4h6BtRben1A76O8bKSCS4=;
        b=Jt47Xz5W/6Qvfgerh3MVE24F5/Tn1CluSb47AQVTTILN/PaJ7nWjQUpDTPTGXTp0tDG21W
        TggwwZfiPtrBh6i1M3hI1h41NT8b7ver/35pKyd0ggOpu1QJ7xqdTCqHjMXvvyG4MfMDlL
        HlI12X8iQE4A9fA1yqcWFqkftOL+fL0=
Date:   Mon, 14 Jun 2021 21:50:11 +0200
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
        David Rientjes <rientjes@google.com>, tony.luck@intel.com,
        npmccallum@redhat.com
Subject: Re: [PATCH Part1 RFC v3 16/22] KVM: SVM: Create a separate mapping
 for the SEV-ES save area
Message-ID: <YMey8xMXLcB/0WnA@zn.tnic>
References: <20210602140416.23573-1-brijesh.singh@amd.com>
 <20210602140416.23573-17-brijesh.singh@amd.com>
 <YMc2R4JRZ3yFffy/@zn.tnic>
 <f6ad5b50-f462-35e1-3be4-e7113feee3a9@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f6ad5b50-f462-35e1-3be4-e7113feee3a9@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Jun 14, 2021 at 02:34:03PM -0500, Tom Lendacky wrote:
> I guess we can call it just prot_save_area or protected_save_area or even
> encrypted_save_area (no need for guest, since guest is implied, e.g. we
> don't call the normal save area guest_save_area).

All three sound good to me.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
