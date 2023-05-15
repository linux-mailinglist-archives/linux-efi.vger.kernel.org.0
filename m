Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B670702F3A
	for <lists+linux-efi@lfdr.de>; Mon, 15 May 2023 16:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240133AbjEOOHq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 15 May 2023 10:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240107AbjEOOHj (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 15 May 2023 10:07:39 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74392688;
        Mon, 15 May 2023 07:07:37 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 5077A5C00CF;
        Mon, 15 May 2023 10:07:37 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 15 May 2023 10:07:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1684159657; x=
        1684246057; bh=DBCloPEnq7GrVWUv77/f546gFZlvf4mfkR+6V2XWZpQ=; b=d
        EYIYxnEmXdn3LvuypvjbS4ADcgzkr5tqEmLBnSNWcUARtv9Hmluw2x5vLlRJCtPe
        MHpMdRBP+xIYz/6aoCDYTACOvO0rE3myoSdBpcPmBpO68LrBdd/viT7UKw9LPgeB
        i/LAV/JuMpS17zclIzuPL88BvOwmqPzKT0zRdVmU4Ffx0t+IopnpLmYWakdrFxEr
        nQurXEJa3eT/x3S+ADMTDq0tAuLIafi6H0Ax1oxgHeCVuLHXVO0asLGBCi0nc1gR
        7WHEm3Y2Rb/IYEgjvKW26PKm4O6wBfHrEvsVl2jb0O80FIuBXy9V+YVoX2IxjMq+
        OzjrI8i9Rq8BkRQiGi8cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1684159657; x=1684246057; bh=DBCloPEnq7GrV
        WUv77/f546gFZlvf4mfkR+6V2XWZpQ=; b=jttTDMkglQhSBoGAKUcq2GrzQuFze
        HMoUOO5iphm/dMVq7W6eAeFUckUAdWLcIxd8FpvkzX2AzUDuQENwwG6e4/NtuBUg
        mF3IbiuXrP1YtHaGonWWfhIVPoynnzKUw8dGcbZwWATG2D47Kx3mDEUrTwwnyy7B
        xu3+5D+hZew+SWLqZg5w75BLccnSA5BkCFOfATU/YggIy7OrUQ/bs528hfX2d4HD
        S4dBf+641KNnK5uEKTOhSJb/1a0pE3IG6bnMo+HV4oqb/OHpJFOaHLHe6lXjhjCH
        60LKYt+FjN+KJs48NS5gN1vMKZ1YEEdo+GMjAYsxPAXEhaWlokJiEm1sw==
X-ME-Sender: <xms:qTxiZFBtGQFP-AKdahjOco8bDP84jgxqPeLcLK6K4OuQco6U4uRWWg>
    <xme:qTxiZDiHv71tOj5wI2i8XCorBUkUm-1pEa8nXCIEWGombaAcsgQz58pDYgQAg16jn
    nfzpthcJlFWW3CeJhw>
X-ME-Received: <xmr:qTxiZAk7CQ0rLnmHbpuJVh_6i2dh78mooGQFP2KoxkhHkt_y47Cpo-YrOf9KB0N66EUSxA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeehjedgjeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdttddttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpefhieeghfdtfeehtdeftdehgfehuddtvdeuheet
    tddtheejueekjeegueeivdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:qTxiZPykJ1e7eHYmHSe02w6rlCPvnce73PO6VSMDzhe33nlmqC84bw>
    <xmx:qTxiZKRrr5ZE-AMLWyqq1-klyaxtLx4Dxvx_th6aeQfQlKAxMwyjnQ>
    <xmx:qTxiZCbJfLd3vgGB99G68JeLSvrb4VRBF7k2sKRsn9TsksjUIn5fLw>
    <xmx:qTxiZEGRR2ZjEEk6tpBzPwYmKHEpMOt_JfxQwHfDZLj4llD-K5bVLA>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 May 2023 10:07:36 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 13B2C10D1DE; Mon, 15 May 2023 17:07:35 +0300 (+03)
Date:   Mon, 15 May 2023 17:07:35 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Evgeniy Baskov <baskov@ispras.ru>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Kees Cook <keescook@chromium.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 07/20] x86: decompressor: Only call the trampoline
 when changing paging levels
Message-ID: <20230515140735.lw7vjxiv4wsj7pk3@box.shutemov.name>
References: <20230508070330.582131-1-ardb@kernel.org>
 <20230508070330.582131-8-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230508070330.582131-8-ardb@kernel.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, May 08, 2023 at 09:03:17AM +0200, Ard Biesheuvel wrote:
> Since we know the current and desired number of paging levels when
> preparing the trampoline, let's not call the trampoline at all when we
> know that calling it is not going to result in a change to the number of
> paging levels. Given that we are already running in long mode, the PAE
> and LA57 settings are necessarily consistent with the currently active
> page tables - the only difference is that we will always preserve
> CR4.MCE in this case, but this will be cleared by the real kernel
> startup code if CONFIG_X86_MCE is not enabled.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
