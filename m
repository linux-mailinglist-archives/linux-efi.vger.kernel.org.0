Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF62A723262
	for <lists+linux-efi@lfdr.de>; Mon,  5 Jun 2023 23:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbjFEVjj (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 5 Jun 2023 17:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231425AbjFEVji (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 5 Jun 2023 17:39:38 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A2BFA;
        Mon,  5 Jun 2023 14:39:36 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 5CAC55C0797;
        Mon,  5 Jun 2023 17:39:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 05 Jun 2023 17:39:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1686001176; x=1686087576; bh=UUAdc4FX4fn3xdKCVk7gxQNMD
        BQkMF1WCK+GRex238Q=; b=XAirlODG66Lz0RJ7tGYtvOMFZ6VQ0BtoxHpWjqrsi
        M6hh0j0c1dd863+dqLyETk0JIINoUCatgsjqICepo6jmJn0a8MoiV6BxkStZWaao
        iNbUEo/330fP7kh1QipXE1rh833hvrShAr0Vga0azXfgtRW2zIYxzepY6PZzYhm3
        u98WqR0znzLv3lNBmXziJB3htrvjhOnznB58FDVov+BvOwjkP9m73vOljFjf3rNU
        XzYnZcBU1R8BL403gxKgn0OIPCruf7V8b/dywUqf8RQwqtodF7sPhiu+143d0MCe
        pX171RXT0++PEPZvMQ0bBCdhbDQ9CKxvMcWOpNOMCRNmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1686001176; x=1686087576; bh=UUAdc4FX4fn3xdKCVk7gxQNMDBQkMF1WCK+
        GRex238Q=; b=IZOyttrRKPkavkJL7GOaKUzfnNi7vFyHCoxvd4O6JaKnfcEqy1e
        ar0F3Pge4FZXLpGQ6mybczDoXgkwcA68csuduiEixsM42JgfPrb63GAYdVD7GGot
        3xC0H1zI6z43wDvFRWPiVZYT4hYUy8EvJVHe86p5H6LTAIZN0XKrF6feeKU58k9S
        JV7rX8SJZm0qb74UwhaeqNUALGkkWySiXHeDP2JbkutWWH1ysUVKf5YOYJWnBJ4+
        8tUjP7zb/ENSK0//c2UtyJQMMv+NbvHE/HcFmUrN+lIHuNw2d04khV13PicNAjuA
        v8GSsHKqIl9Q4k/GRR5t/dxRwqk8d1UqwHg==
X-ME-Sender: <xms:F1Z-ZPK3ZvRBlTv2WRCKCld2EPmDj-kvxoyOXjIQhufZsRjbnSO_PA>
    <xme:F1Z-ZDLaDRCf6J2Ueb5nKuuRhM2iHKKR6uFLu5DgYsTmXncyO3_e6vbLhLXQpZpCv
    nhGskQp6kj5H_nx798>
X-ME-Received: <xmr:F1Z-ZHsrZ8FBnkKM_3kk29ii4nfb-O5VzEeZQO_U-ziDJ0znZ9eW-_z_Qbe9i0JYAYdchQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedttdcutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthektddttddtudenucfhrhhomhepfdfmihhrihhl
    lhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmh
    gvqeenucggtffrrghtthgvrhhnpeetveehleetgeegffejffejtdevgeeugeeftefghffh
    gfeivefghfeuvefgjeekfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:GFZ-ZIZxRQ4DqHmtmE2Ot6yfgU3W4Ubod-JOzMeihkYpgOxgcQlNQg>
    <xmx:GFZ-ZGZ-W48bPg8C91J_2PsmF3XDBVoqvyULMe0PwTPbK0ufcNJEow>
    <xmx:GFZ-ZMARc7ijA_BJggKFE2Dkrqmajjwd4nXuR4MWRRy0IxIpL-EsCQ>
    <xmx:GFZ-ZJkiz1Jz8FMzXEkzzn8dOgkr_fUhWufqw01FHnxOv_ru5aGSjw>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Jun 2023 17:39:35 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id D907A10A631; Tue,  6 Jun 2023 00:39:33 +0300 (+03)
Date:   Tue, 6 Jun 2023 00:39:33 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
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
        Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        aarcange@redhat.com, peterx@redhat.com, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv13 9/9] x86/tdx: Add unaccepted memory support
Message-ID: <20230605213933.vqkvfo5fzffj5zri@box.shutemov.name>
References: <20230601182543.19036-1-kirill.shutemov@linux.intel.com>
 <20230601182543.19036-10-kirill.shutemov@linux.intel.com>
 <4d8d6fc4-99b5-29ba-7f81-12e7d57907ea@amd.com>
 <1d24355c-3922-d5c7-4c05-f5ef0adaf5d2@amd.com>
 <5bce4a75-d4bb-74c2-1feb-e988841d5465@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5bce4a75-d4bb-74c2-1feb-e988841d5465@intel.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Jun 05, 2023 at 12:18:21PM -0700, Dave Hansen wrote:
> On 6/2/23 07:26, Tom Lendacky wrote:
> >> So this is a change in this version. If tdx_accept_memory() fails,
> >> you'll report unknown platform. Wouldn't it be better to have an error
> >> message that indicates a failure in the accept path?
> >>
> > 
> > Maybe you can keep it similar to the v12 version with just a new error
> > message, something like:
> > 
> >     if (early_is_tdx_guest()) {
> >         if (!tdx_accept_memory(start, end))
> >             error("TDX error accepting memory\n");
> >     } else {
> >         error("Cannot accept memory: unknown platform\n");
> >     }
> 
> In the end, these errors aren't plumbed out to the page allocator.  They
> *need* to succeed or we are dead anyway.  Should we just send a fatal
> error up to the TDX module when we fail to accept memory?  It's
> _slightly_ less opaque than plowing into an unaccepted page.

This is decompressor's error()s which are fatal.

arch_accept_memory() in the main kernel uses panic() in the same spot.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
