Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDA4139DE8E
	for <lists+linux-efi@lfdr.de>; Mon,  7 Jun 2021 16:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbhFGOVZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 7 Jun 2021 10:21:25 -0400
Received: from mail.skyhub.de ([5.9.137.197]:35712 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230207AbhFGOVZ (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 7 Jun 2021 10:21:25 -0400
Received: from zn.tnic (p200300ec2f0b4f00688e10502b12273b.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:4f00:688e:1050:2b12:273b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id ED9091EC0489;
        Mon,  7 Jun 2021 16:19:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1623075572;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=5TOa8tTbEmXIDseKo1WMd9o3+qoCmHgbWPGnV+1d5GU=;
        b=NjlTa0dZ0y50eG51qkp+v3j0oFZvigFNu8CDo3PSR+Gs6GrZSDorNmrNCo9sUqrP58FrNq
        odyBUy92t/Xmg4PU61LzGhliThhDMpkF5NfW81n/WRqEqtK8g+D7By7xHCRJ61fQGNwG6h
        +tZ1KH6wNLEt1OXRWI/3UsXC7KVr1zo=
Date:   Mon, 7 Jun 2021 16:19:26 +0200
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
Subject: Re: [PATCH Part1 RFC v3 05/22] x86/sev: Add support for hypervisor
 feature VMGEXIT
Message-ID: <YL4q7jHYu65I11bZ@zn.tnic>
References: <20210602140416.23573-1-brijesh.singh@amd.com>
 <20210602140416.23573-6-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210602140416.23573-6-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jun 02, 2021 at 09:03:59AM -0500, Brijesh Singh wrote:
> diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
> index 70f181f20d92..94957c5bdb51 100644
> --- a/arch/x86/kernel/sev-shared.c
> +++ b/arch/x86/kernel/sev-shared.c

I'm guessing this is in sev-shared.c because it is going to be used by
both stages?

> @@ -20,6 +20,7 @@
>   * out when the .bss section is later cleared.
>   */
>  static u16 ghcb_version __section(".data");

State what this is:

/* Bitmap of SEV features supported by the hypervisor */

> +static u64 hv_features __section(".data");

Also, I'm assuming that bitmap remains immutable during the guest
lifetime so you can do:

static u64 hv_features __ro_after_init;

instead, which will do:

static u64 hv_features __attribute__((__section__(".data..ro_after_init")));

and it'll be in the data section and then also marked read-only after
init, after mark_rodata_ro() more specifically.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
