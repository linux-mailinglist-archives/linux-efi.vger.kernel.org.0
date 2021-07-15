Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6423C99BD
	for <lists+linux-efi@lfdr.de>; Thu, 15 Jul 2021 09:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbhGOHm5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 15 Jul 2021 03:42:57 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:50280 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232345AbhGOHm4 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 15 Jul 2021 03:42:56 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A07AC2279C;
        Thu, 15 Jul 2021 07:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1626334801; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5JMBVUc1fC80+7deLYH6ZLQZq/uUCL7N+S0Ckg+qtbI=;
        b=Twb6x088Ds05jfTu5/IB5porBtTYCy7ypb/AOBkBIcuTOW8D+d7upMLB1l3nohEF7iPW/p
        8deiq9K1vIvBrAZjm5PrzzYiClmYOaPP+BfxFaSOoAZgjQKRVJE/jYn3GYYxV/6Wzn5j3A
        OCFRqAN5FYIib3+LRrkkcU505ZTakD0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1626334801;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5JMBVUc1fC80+7deLYH6ZLQZq/uUCL7N+S0Ckg+qtbI=;
        b=iCqY9l43TypCWFiyhhci4MfAifGCRh3LrqaNuvVgpKgYxC55KpqRWrvVubNKGrttlJ8kft
        DVVygz62vy0zvcDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7FEF413C2C;
        Thu, 15 Jul 2021 07:40:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id teNrHVDm72BeZwAAMHmgww
        (envelope-from <jroedel@suse.de>); Thu, 15 Jul 2021 07:40:00 +0000
Date:   Thu, 15 Jul 2021 09:39:58 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Brijesh Singh <brijesh.singh@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
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
        Borislav Petkov <bp@alien8.de>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>, tony.luck@intel.com,
        npmccallum@redhat.com, brijesh.ksingh@gmail.com
Subject: Re: [PATCH Part2 RFC v4 01/40] KVM: SVM: Add support to handle AP
 reset MSR protocol
Message-ID: <YO/mTtzslwrAxuxz@suse.de>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
 <20210707183616.5620-2-brijesh.singh@amd.com>
 <YO9GWVsZmfXJ4BRl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YO9GWVsZmfXJ4BRl@google.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jul 14, 2021 at 08:17:29PM +0000, Sean Christopherson wrote:
> On Wed, Jul 07, 2021, Brijesh Singh wrote:
> > From: Tom Lendacky <thomas.lendacky@amd.com>
> > 
> > Add support for AP Reset Hold being invoked using the GHCB MSR protocol,
> > available in version 2 of the GHCB specification.
> 
> Please provide a brief overview of the protocol, and why it's needed.  I assume
> it's to allow AP wakeup without a shared GHCB?

Yes, this is needed for SEV-ES kexec support to park APs without the
need for memory that will be owned by the new kernel when APs are woken
up.

You can have a look into my SEV-ES kexec/kdump patch-set for details:

	https://lore.kernel.org/lkml/20210705082443.14721-1-joro@8bytes.org/

I also sent this patch separatly earlier this week to enable GHCB
protocol version 2 support in KVM.

Regards,

	Joerg
