Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08CBF46696A
	for <lists+linux-efi@lfdr.de>; Thu,  2 Dec 2021 18:52:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376455AbhLBRzl (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 2 Dec 2021 12:55:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348064AbhLBRzk (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 2 Dec 2021 12:55:40 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC8DC06174A;
        Thu,  2 Dec 2021 09:52:17 -0800 (PST)
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 738161EC0545;
        Thu,  2 Dec 2021 18:52:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1638467531;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=mYbyP91p7fEVRiuQVAocUUJu8tfWD5okvmoA1PcLyik=;
        b=mXVWsIEQlUK1NUJHwJdTRdQSa/OMoVkPBdzhiw7yQkAV+fZSgxSmaG4nPj7qJ097OltURS
        9K7IfoP8jj/OpMsUbPZIMMFljyRP4NUEFwcXSblIg3MzWWucj/p78B7x/W2l+7hzXj3UUA
        +FvrTgY4gubdPoOhL6rIySU7+PCAGqU=
Date:   Thu, 2 Dec 2021 18:52:15 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
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
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v7 10/45] x86/sev: Add support for hypervisor feature
 VMGEXIT
Message-ID: <YakHz5WCPcbNOPum@zn.tnic>
References: <20211110220731.2396491-1-brijesh.singh@amd.com>
 <20211110220731.2396491-11-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211110220731.2396491-11-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Nov 10, 2021 at 04:06:56PM -0600, Brijesh Singh wrote:
> +/*
> + * The hypervisor features are available from GHCB version 2 onward.
> + */
> +static bool get_hv_features(void)
> +{
> +	u64 val;
> +
> +	sev_hv_features = 0;
> +
> +	if (ghcb_version < 2)
> +		return false;
> +
> +	sev_es_wr_ghcb_msr(GHCB_MSR_HV_FT_REQ);
> +	VMGEXIT();
> +
> +	val = sev_es_rd_ghcb_msr();
> +	if (GHCB_RESP_CODE(val) != GHCB_MSR_HV_FT_RESP)
> +		return false;
> +
> +	sev_hv_features = GHCB_MSR_HV_FT_RESP_VAL(val);
> +
> +	return true;
> +}

I still don't like this.

This is more of that run-me-in-the-exception-handler thing while this is
purely feature detection stuff which needs to be done exactly once on
init.

IOW, that stanza

        if (!sev_es_negotiate_protocol())
                sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SEV_ES_PROT_UNSUPPORTED);

should be called once in sev_enable() for the decompressor kernel and
once in sev_es_init_vc_handling() for kernel proper.

Then you don't need to do any of that sev_hv_features = 0 thing but
detect them exactly once and query them as much as you can.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
