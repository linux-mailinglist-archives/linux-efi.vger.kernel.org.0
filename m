Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D93FE58AFA5
	for <lists+linux-efi@lfdr.de>; Fri,  5 Aug 2022 20:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbiHESR4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 5 Aug 2022 14:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiHESRz (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 5 Aug 2022 14:17:55 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9DA1A39D;
        Fri,  5 Aug 2022 11:17:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EBF34349FD;
        Fri,  5 Aug 2022 18:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1659723472; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IzpiBFPwlBSeiyCmg4i8g32ALBSJCReWlJys+QhxFS8=;
        b=HEvQrK0z2flbkWu3D4bi6Huu9V6B98l37hfFD6hspbwEp6re5HjF/Yu81/d71Yyh/aa1F+
        I7BNV4EpToX8myv1isx7IZTxjYrhx+NnCFVLAfX32A2r8QXYROHSvRxSbFf4KLV/2UsIuJ
        ZVrU4VJ7qbcrVA8P4y+TSLkNjlt7Y+g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1659723472;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IzpiBFPwlBSeiyCmg4i8g32ALBSJCReWlJys+QhxFS8=;
        b=U1lAlK/bqMUOrKEDOATRLkf3iu/ZOAEGHfjjcQhARV8Kqz/D1wQ4Em8MU/QEXhid1WfmII
        3k0L6l4IM75ob6Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7B519133B5;
        Fri,  5 Aug 2022 18:17:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vqNoHdBe7WKZFQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 05 Aug 2022 18:17:52 +0000
Message-ID: <cecbaa10-6d0a-8925-004b-ff53d9f56e83@suse.cz>
Date:   Fri, 5 Aug 2022 20:17:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.3
Subject: Re: [PATCHv7 02/14] mm: Add support for unaccepted memory
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>,
        David Hildenbrand <david@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        Mike Rapoport <rppt@kernel.org>, marcelo.cerri@canonical.com,
        tim.gardner@canonical.com, khalid.elmously@canonical.com,
        philip.cox@canonical.com, x86@kernel.org, linux-mm@kvack.org,
        linux-coco@lists.linux.dev, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
        Mel Gorman <mgorman@techsingularity.net>
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
 <20220614120231.48165-3-kirill.shutemov@linux.intel.com>
 <8cf143e7-2b62-1a1e-de84-e3dcc6c027a4@suse.cz>
 <cb9d3310-3bc0-8ecf-5e71-becce980235f@redhat.com>
 <f936b024-43e1-5390-e33f-ad7d355a2802@suse.cz>
 <eb83fcd9-f331-4d54-1ab9-78db106ee66d@intel.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <eb83fcd9-f331-4d54-1ab9-78db106ee66d@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 8/5/22 16:41, Dave Hansen wrote:
> On 8/5/22 06:38, Vlastimil Babka wrote:
>>> I'm sure we could optimize for the !unaccepted memory via static keys
>>> also in this version with some checks at the right places if we find
>>> this to hurt performance?
>> It would be great if we would at least somehow hit the necessary code only
>> when dealing with a >=pageblock size block. The bitmap approach and
>> accepting everything smaller uprofront actually seems rather compatible. Yet
>> in the current patch we e.g. check PageUnaccepted(buddy) on every buddy size
>> while merging.
> 
> Needing to check PageUnaccepted() during the merge is fallout from
> moving the acceptance to post_alloc_hook().  I _think_ an earlier
> version of this did page acceptance under the zone lock, closer to where
> the page comes off the 2M/4M lists.
> 
> But, page acceptance is horribly slow, so I asked Kirill to move it out
> from under the zone lock.  Doing it in post_alloc_hook() (after the zone
> lock is dropped) makes a lot of sense since we do zeroing in there and
> zeroing is also nice and slow.
> 
> But, post_alloc_hook() is long after the 2M page has been split and that
> means that we have to deal with potentially unaccepted pages during merges.
> 
> I think there are three basic options:
> 
> 1. This patch: Do acceptance after the zone lock is dropped and deal
>    with mixed-acceptance merges
> 2. Do acceptance under the zone lock as pages come off the 2M/4M lists,
>    but before the page is split.

Rather not, as acceptance can be slow and we shouldn't hog the zone lock
while doing it.

> 3. Pull the page off the 2M/4M lists, drop the zone lock, accept it,
>    then put it back.

Worth trying, IMHO. Perhaps easier to manage if the lists are distinct from
the normal ones, as I suggested.

> I'm not sure any of those other options are better.

