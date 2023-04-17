Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 621E76E414E
	for <lists+linux-efi@lfdr.de>; Mon, 17 Apr 2023 09:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbjDQHjO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 17 Apr 2023 03:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbjDQHiy (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 17 Apr 2023 03:38:54 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D951B525C;
        Mon, 17 Apr 2023 00:38:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 53B2C21A3D;
        Mon, 17 Apr 2023 07:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1681717063; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3w8ZyhKSUCHQYqIG32tqYuuJnDNxaXTVQggusp/+GOc=;
        b=FSNHYP0e1N/1O21SR61SdobJRwQUe/xR/QsGmyhBrzM3xQ9/FqLwkxXkORxQN3bPPepVvC
        J1AJE4vC95OYz9443C58v7MQnRLUKXQ9f+JVSbGagwIxrFIZl66nsCBIWd0BpRiHdw+A/Z
        BggQEkAKglbqgPoTFhbrqFUgWHIAdzs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1681717063;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3w8ZyhKSUCHQYqIG32tqYuuJnDNxaXTVQggusp/+GOc=;
        b=InpvAvPhIJbDcKWUuYK6TRVNdy9BaqeoAVEyr3zLiU0ZyYIRJ1A/+0gB/YuJNZValGrWhk
        +iHsclhRxLILHaAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B5DC61390E;
        Mon, 17 Apr 2023 07:37:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5jMCK0b3PGQjJQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 17 Apr 2023 07:37:42 +0000
Message-ID: <e75d5d1d-8c0c-15a5-0030-27c3ed458519@suse.cz>
Date:   Mon, 17 Apr 2023 09:37:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCHv9 00/14] mm, x86/cc: Implement support for unaccepted
 memory
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
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
References: <20230330114956.20342-1-kirill.shutemov@linux.intel.com>
 <2e0da486-71e4-cfeb-1578-68f1c8c43d33@suse.cz>
 <20230416191940.ex7ao43pmrjhru2p@box.shutemov.name>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230416191940.ex7ao43pmrjhru2p@box.shutemov.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 4/16/23 21:19, Kirill A. Shutemov wrote:
> On Mon, Apr 03, 2023 at 04:42:54PM +0200, Vlastimil Babka wrote:
>> Hmm yeah it can be noisy. Did you try to only count events that have
>> fragmenting=1 and/or MIGRATE_MOVABLE as fallback_migratetype? As those are
>> the really bad events.
> 
> I finally got around to retest it.
> 
> 		total	fragmenting	movable	fragmenting&&movable
> base-1:		957	583		353	0
> base-2:		2715	2343		359	0
> base-3:		2033	1669		353	0
> patched-1:	1325	929		371	0
> patched-2:	2844	2451		371	0
> patched-3:	1304	917		361	0
> 
> fragmenting=1 is defined as fallback_order<pageblock_order which is most
> of them.
> 
> Patched kernel showed slightly elevated movable(fallback_migratetype=1)
> cases. Is it critical?

Maybe it's still not statistically significant anyway, also not as cricical
as fragmenting&movable.

> There's no allocations that is fragmenting and movable. Hm.

It probably means your test wasn't stressfull enough to inflict a mix of
rapid movable an unmovable allocations when memory is nearly full. But at
that point the memory is all accepted, so we don't need such scenario. The
important thing is that this kind of events didn't start happening during
the gradual memory accepting phase.

