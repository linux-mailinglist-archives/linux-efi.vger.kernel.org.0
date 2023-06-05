Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3AEF72325B
	for <lists+linux-efi@lfdr.de>; Mon,  5 Jun 2023 23:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbjFEVhw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 5 Jun 2023 17:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbjFEVhv (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 5 Jun 2023 17:37:51 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD4EE9;
        Mon,  5 Jun 2023 14:37:50 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 0C8655C0209;
        Mon,  5 Jun 2023 17:37:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 05 Jun 2023 17:37:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1686001068; x=
        1686087468; bh=f4bf2dR163Qx2yNartmgMG05SAZML/ESa+Dp7tZQMo8=; b=D
        YtcLQyFjvkDFHlnn8EqjhcjMdl67btMsHfd8/vnIhC/NRDlcGBzBSQS1z8A72loS
        LhTnhNK3TiHh8Orm/3GTfFnV52tVqzNw9EiKV/K2FHebC2L5z9wnPvvX942SA/Ox
        3J+FVUTgqT4gYD8Iw/518FeiruxzrqcEe5I17x1w1jklPJP/NfSgsvlhxPOYFb3q
        pEWbW6cZf7ajGo1aTOZ7gj8H5hqStiC+AkHi/2lKP2px4WImyMGFPt01jfvGNLHH
        I+vyG3Aemz8OnvhqxgWH1OToc+HZCVvu5/v0rjMPvgeNvcuMCitOLMZrKtCe/2dY
        iieT9a/xzoHvwGK+BaBOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1686001068; x=1686087468; bh=f4bf2dR163Qx2
        yNartmgMG05SAZML/ESa+Dp7tZQMo8=; b=UTsU21LOXj30c2WJM/T+sl3eG3vkr
        BaR49tJGyeIolx2nkFrF19Vsojz9i6Mzw+wNEWSkIxLyohYWgf3TLfwhnhEEeRRd
        sJhFGfvycjH9pmw9YSS8L69jgo7ajs5bISs9vPvZKU9gY24Bjq7SxcIrLobS/u+D
        e+PNJKpSRMU1sFEdVd6Aicl/MRS2K940mFXh5CG8QTWwfWD/EK41GIY504rQsZBy
        ZsXTZQ64ipIAE/JCdbFBM1kojOMF1j31l+k4uCYVcDFCv7+DK76RJspLqONu1ZEG
        v34Ug8hIT8qhQl7rceW+uA9333qsTyKKOPzzUwu3VMWLQ5LPGT/ef4Otg==
X-ME-Sender: <xms:qlV-ZAiERHLrYZgthWH5r9e3-G6lvreCiKc0EwIilYOAZkWwRamuEg>
    <xme:qlV-ZJCDISWTYvoEaw7VKZgn0BuOg8I_djQ9jOAAyVI8j_6c7o94qLzVMrHHh7Ou4
    ZGctarSyeZ9HEnau4I>
X-ME-Received: <xmr:qlV-ZIG8mAuo6r0qwhMRHdOleFwxxjEhAmsQBLsfz7F0wdc4L5jo3tkifNMRiLNUPbUJEw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedttdcutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttddttddttddvnecuhfhrohhmpedfmfhirhhilhhl
    ucetrdcuufhhuhhtvghmohhvfdcuoehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvg
    eqnecuggftrfgrthhtvghrnhephfeigefhtdefhedtfedthefghedutddvueehtedttdeh
    jeeukeejgeeuiedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgv
X-ME-Proxy: <xmx:qlV-ZBSVMxNrkMhG79QfZIZkrSgVrMPShD522ouYkFfjf0Yidkpumw>
    <xmx:qlV-ZNw1mocVgVaKbmPujF12Uf8al4xNcYpEJmF0zoPwdsBLM1PDqg>
    <xmx:qlV-ZP4ywzi1-DMnwMyQS2xnYUSAAFiLmvWKe1qSlb3g_7VmsKqamg>
    <xmx:rFV-ZG8-YYDpytdRf9Dusr2YRwb9W523rrNRY_JbCVJTw6y44ZX9xw>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Jun 2023 17:37:45 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id C975810A631; Tue,  6 Jun 2023 00:37:42 +0300 (+03)
Date:   Tue, 6 Jun 2023 00:37:42 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
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
Subject: Re: [PATCHv13 5/9] efi: Add unaccepted memory support
Message-ID: <20230605213742.chojqyrz5dtyo3mn@box.shutemov.name>
References: <20230601182543.19036-1-kirill.shutemov@linux.intel.com>
 <20230601182543.19036-6-kirill.shutemov@linux.intel.com>
 <20230605154333.GLZH4CpV3eXCCWCGxi@fat_crate.local>
 <20230605173303.k5yt535snxyk4ez3@box.shutemov.name>
 <20230605191225.GCZH4zmbtkWWRG4lzf@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230605191225.GCZH4zmbtkWWRG4lzf@fat_crate.local>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Jun 05, 2023 at 09:12:25PM +0200, Borislav Petkov wrote:
> On Mon, Jun 05, 2023 at 08:33:03PM +0300, Kirill A. Shutemov wrote:
> > There's nothing to warn about. The range (or part of it) is not
> > represented in the bitmap because it is not unaccepted.
> 
> Sorry but how am I supposed to know that?!
> 
> I've read the whole patchset up until now and all text talks like *all*
> *memory* needs to be accepted and before that has happeend, it is
> unaccepted.
> 
> So how about you explain that explicitly somewhere, perhaps in a comment
> above accept_memory(), that the unaccepted range is not the whole memory
> but only, well, what is unaccepted and the rest is implicitly accepted?

Okay, will do.

> And I went and looked at the final result - we error() if we fail
> accepting.
> 
> I guess that's the only action we can do anyway...

Right, there's no recovery from the error.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
