Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84FAE39AB29
	for <lists+linux-efi@lfdr.de>; Thu,  3 Jun 2021 21:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbhFCT7I (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 3 Jun 2021 15:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbhFCT7H (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 3 Jun 2021 15:59:07 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49D4C06174A;
        Thu,  3 Jun 2021 12:57:22 -0700 (PDT)
Received: from zn.tnic (p200300ec2f13850043af4c4d530a3258.dip0.t-ipconnect.de [IPv6:2003:ec:2f13:8500:43af:4c4d:530a:3258])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3D0071EC0246;
        Thu,  3 Jun 2021 21:57:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1622750241;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=CsONDc5/hMgH+lPatsnuVGGoG9v+Dt4ffCqJHaqP7Dw=;
        b=PCsxWln+GSXdcrrOO6u7gyG5ZIMYDxTanA5BrUafnti30zPJ3l/VZM3cStmo9pm63XlOPN
        i0OuoEdNS63MBHcVvVLEGlwag2FJT9/goaw3F9mNNRb4rMA4lembyJSSyynfRpsVTfa5pe
        SyLuqtyEz5I8P/g3jyRufj8hoAiG288=
Date:   Thu, 3 Jun 2021 21:57:16 +0200
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
Subject: Re: [PATCH Part1 RFC v3 03/22] x86/sev: Save the negotiated GHCB
 version
Message-ID: <YLk0HO3SqspIilCD@zn.tnic>
References: <20210602140416.23573-1-brijesh.singh@amd.com>
 <20210602140416.23573-4-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210602140416.23573-4-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jun 02, 2021 at 09:03:57AM -0500, Brijesh Singh wrote:
> +/*
> + * Since feature negotiation related variables are set early in the boot
> + * process they must reside in the .data section so as not to be zeroed
> + * out when the .bss section is later cleared.
> + */

From previous review:

 ...

   *
   * GHCB protocol version negotiated with the hypervisor.
   */

You need to document what this variable is used for so add a comment
over it please.

> +static u16 ghcb_version __section(".data");
> +

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
