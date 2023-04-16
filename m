Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB7E6E3B7C
	for <lists+linux-efi@lfdr.de>; Sun, 16 Apr 2023 21:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjDPTTx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 16 Apr 2023 15:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbjDPTTu (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 16 Apr 2023 15:19:50 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEDD12123;
        Sun, 16 Apr 2023 12:19:48 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 8C5C05C0039;
        Sun, 16 Apr 2023 15:19:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 16 Apr 2023 15:19:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1681672785; x=
        1681759185; bh=YGRdIcPItYFcSw7fEDFLZquPj7AtRRDkYXtyuZxJq/U=; b=d
        cKPlQi01xUEdqakuUy3IFFpBHkHDOpDeTPLZ78GWzQqE/gvsG2Sj9e0OyOzJI1x3
        HUkEG3YdI4KsSgb6cgETLCUhDlkuOVgmIN23kS5njWdsAiRKWWMLNz54bMhlOHKP
        1Nb+XSqoZrEMF0I7wdgORuqj1sfKMYPYHKPvT+Xe5uvQe62eIJp+72TBWCkYNqau
        k5IUHGy16wXxNo6nQ3fxwiRNU9iggNarO6PezzahvI2J5yinnLv5FSkeEDchWpF/
        pb4xTPq5RSBx8VkM/oFP5oDI3fYkR3ckSEp4Gk2OS1u7wus3bosyIR/DW8mdCTp+
        pZ3VDIOmcTaF8/voIA7Lw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1681672785; x=1681759185; bh=YGRdIcPItYFcS
        w7fEDFLZquPj7AtRRDkYXtyuZxJq/U=; b=ZhHDbhA+5anegK7zp66gP1bNpMsiO
        DwJNW4ZlvCEuB+i/dDTyFod2fR8GNQxRbEa1JHytZ25x5/8iNzEisk9GPXP+2CM1
        fu8mN7L5mAbgFsuqHGLfaXfhzDmP3NmvCZJ+c1H6WONj/9c40Zny9u2nyjq/o4dA
        otPOkENiTyDS6386owjy06YAkP+h7RV5WZ8ltg/uDiPi1Cib79GoeeOACXAZflLv
        9d3pYZltCvv/9E1lrz+MDmM8rj9N+bBwHaNbzxtgTvhtziopYYKgD9Vx6MGrDO9E
        N1EKft90agA0X58pbTk4Te5DLOJiZvqJBsJOnm1I5SHYNvTZXDqL/2fzg==
X-ME-Sender: <xms:UEo8ZCgJ2f_PcM4jhh96JFFn6pr379B1cIC0bxXCCOIX2i0gcuTSQA>
    <xme:UEo8ZDDyeFbm2WjeVbIO0R9GC9GW4sV7A-gQFb0sikYf9f8ltyJvt0XmIs3XZriJc
    lZ-SzhzKA4PzsqE3b0>
X-ME-Received: <xmr:UEo8ZKGWtlZFRRuRPrgbp2u9xidH7_1f7bq6nG_aYvSSVq0pQdAIkgyHZ3zz0TE5dHC-oA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdelgedgleegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdttddttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpefhieeghfdtfeehtdeftdehgfehuddtvdeuheet
    tddtheejueekjeegueeivdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:UEo8ZLQ0YrZ0SYnvhgfFQXBo4MVahr8E1VYDJWwPPcfyHlaaqbkxIQ>
    <xmx:UEo8ZPzsXc0J4X_Y1Wg66pwUUZB1zvyMnNicsACP2F_fQakLg8C3wg>
    <xmx:UEo8ZJ7rHlVXMUN0oaS92Rr8hB2ve3zfdGwBJUyfqqdlAv8SYA_QJA>
    <xmx:UUo8ZI9XMBpuDpdqcaMQcLMszovDTAUpQTN7s3cct9z3Po2ZFZ1dIA>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Apr 2023 15:19:44 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id D06C610B9A3; Sun, 16 Apr 2023 22:19:40 +0300 (+03)
Date:   Sun, 16 Apr 2023 22:19:40 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        aarcange@redhat.com, peterx@redhat.com, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv9 00/14] mm, x86/cc: Implement support for unaccepted
 memory
Message-ID: <20230416191940.ex7ao43pmrjhru2p@box.shutemov.name>
References: <20230330114956.20342-1-kirill.shutemov@linux.intel.com>
 <2e0da486-71e4-cfeb-1578-68f1c8c43d33@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e0da486-71e4-cfeb-1578-68f1c8c43d33@suse.cz>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Apr 03, 2023 at 04:42:54PM +0200, Vlastimil Babka wrote:
> Hmm yeah it can be noisy. Did you try to only count events that have
> fragmenting=1 and/or MIGRATE_MOVABLE as fallback_migratetype? As those are
> the really bad events.

I finally got around to retest it.

		total	fragmenting	movable	fragmenting&&movable
base-1:		957	583		353	0
base-2:		2715	2343		359	0
base-3:		2033	1669		353	0
patched-1:	1325	929		371	0
patched-2:	2844	2451		371	0
patched-3:	1304	917		361	0

fragmenting=1 is defined as fallback_order<pageblock_order which is most
of them.

Patched kernel showed slightly elevated movable(fallback_migratetype=1)
cases. Is it critical?

There's no allocations that is fragmenting and movable. Hm.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
