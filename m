Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2715702F2B
	for <lists+linux-efi@lfdr.de>; Mon, 15 May 2023 16:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238846AbjEOOEU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 15 May 2023 10:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238764AbjEOOET (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 15 May 2023 10:04:19 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83DEA213E;
        Mon, 15 May 2023 07:03:42 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 8E1685C01B1;
        Mon, 15 May 2023 10:03:05 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 15 May 2023 10:03:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1684159385; x=
        1684245785; bh=CTwZDV1W0gau6t111FgqYOUN7M1N250LK2GljieQw/4=; b=s
        w42rnJulm/LjZtkKWWEwPzcFE7SjjwrGVI2fz6IonFax57d9zbQehczGvVJA01Ci
        DgPeH08At8IxbdziSMWwAWDbtBkOElanxADJgjs02aBJ6xmR73QV56CXZQIV0vl/
        YHbaAbZRtj3VE0uDU85ivgCjVuf09tdAP7kwLQOrJ6ohCoTi+EbSLMMkHvaAg1sH
        Imt9dOKNB8dtdIdvVEDWIvYHu00q1lS6YGkzx694/9HVxLWFpZ9Yxlxb7OTNCkxh
        SmhEXI+3fCGJX4fIISEEHUDwJhYhYJvY/P6+ZnL6V+BekCyRWev4FjgQQaLxveGX
        pdFR2O34ku9uFE1so5RTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1684159385; x=1684245785; bh=CTwZDV1W0gau6
        t111FgqYOUN7M1N250LK2GljieQw/4=; b=Lk6XUCbj+tlorOWcvmImstYvtxt+W
        XX4NxVIZdNoto19dqCIpV8bS4suk3A4Tnm3nZUGHBF7/IBafuTOUcPIWr1Ej+h0t
        zEbLMmSOJL/d5NFUU/WicxAfGJfCh4v6NbylwWdVL9qolJlg5ABwt0LtE+NyuG58
        WQbUVKWB4QH8oP54zG4USpf3FN+P0D/EBmBtb3dtkehiefrAQ9+Ua6yas4+p3EA+
        QKS5Bhg/8DpwB0F/RKX5axnB9cTq5kd4pV7W/E2s4aKgYqXjeR+a84zL3bRHSiXj
        q0rLLK/CihqwBAYrJlJ38xG8eJB8T/L4y1yacsjcfP41GUhzd6+V9hWUA==
X-ME-Sender: <xms:mTtiZDD6xFgVRUWmmpkBNQOx7VahXUEw0EHlYu9UbjGDRnPWqvYE-Q>
    <xme:mTtiZJjC21D2zqNzcGB67ovmjoed1znWTjSKTHf7w7dIkrApwDyUtrD7Z9ndQXZjS
    xUdDaRUJsPQcB1R4nY>
X-ME-Received: <xmr:mTtiZOnC5gmmXFIMfz01E-_NT-NijX0gZl4AP35A4kWhcyh6jw7spAM7QLjoGoz9fkmcZA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeehjedgjedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdttddttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpefhieeghfdtfeehtdeftdehgfehuddtvdeuheet
    tddtheejueekjeegueeivdektdenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:mTtiZFy_DYxpnbpAyyJyJK_K85xVsrs0ZaAWaXFXpSAbQJLpbhrZqg>
    <xmx:mTtiZITm2mjZpCHjHqDnJWVXpLOUp6mdPGl_Nq7bkWQRn3DQN4XvzQ>
    <xmx:mTtiZIZa5cr6pYCJSGYSDDsMpqfetS1ynII5-2rIHgKt1tWLYouDXA>
    <xmx:mTtiZKHvgEZjwjtrTwjGlr_NY55--5rdfra3xAkQcJMOqhYh_5y6aA>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 May 2023 10:03:04 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 0E71310D1DE; Mon, 15 May 2023 17:03:03 +0300 (+03)
Date:   Mon, 15 May 2023 17:03:03 +0300
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
Subject: Re: [PATCH v2 05/20] x86: decompressor: Avoid the need for a stack
 in the 32-bit trampoline
Message-ID: <20230515140303.34lba7rl4onrltdu@box.shutemov.name>
References: <20230508070330.582131-1-ardb@kernel.org>
 <20230508070330.582131-6-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230508070330.582131-6-ardb@kernel.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, May 08, 2023 at 09:03:15AM +0200, Ard Biesheuvel wrote:
> The 32-bit trampoline no longer uses the stack for anything except
> performing a long return back to long mode. Currently, this stack is
> allocated in the same page that carries the trampoline code, which means
> this page must be mapped writable and executable, and the stack is
> therefore executable as well.
> 
> So let's do a long jump instead: that way, we can pre-calculate the
> return address and poke it into the code before we call it. In a later
> patch, we will take advantage of this by removing writable permissions
> (and adding executable ones) explicitly when booting via the EFI stub.
> 
> Not playing with the stack pointer also makes it more straight-forward
> to call the trampoline code as an ordinary 64-bit function from C code.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
