Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C66D702EF6
	for <lists+linux-efi@lfdr.de>; Mon, 15 May 2023 15:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbjEON7o (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 15 May 2023 09:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238931AbjEON7i (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 15 May 2023 09:59:38 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E779F2708;
        Mon, 15 May 2023 06:59:32 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 33A7F5C0195;
        Mon, 15 May 2023 09:59:32 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 15 May 2023 09:59:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1684159172; x=
        1684245572; bh=55ze2uE9yGUmO+hkklQreacxsQYWQtHVHfVI9xhbDmw=; b=Q
        yzqq4sbZEr/ZQcKeWbIljS9rAfjVEmZ/spDqdk3kXle5SpWeXMGNt0l0JPZcb0oc
        bGzV2T0Vt1vMRF3TPrVXPXvhgnKN85Typy0AtnTVD8jWP394SjrabkJnvaIdZupv
        JLUjcm6NJQBTvgATDXZ1D/3eQ3WEXBljrfuhbsdebqfN8IQLtpx7srxl2sIPXFFK
        b4ONZfbUXJpIdZS5+xiQG96vnytzag/Qt6WsQryot6JvgQabHYLPFNK3YxWTCkXK
        utZWftxPzKr/KmVvZL2o9mR+Xa2mCCTo/wH1L+/T89EOS/3T31Dv5e+tWzFxMuxy
        eN0MU5OMvluynDG4GdNMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1684159172; x=1684245572; bh=55ze2uE9yGUmO
        +hkklQreacxsQYWQtHVHfVI9xhbDmw=; b=yKHWNH+PLhUi1IemftyGq+1HTsL5w
        i4C7gReqAaVvj8AgUg/4UW3TlJMEXmQZXsejYjMT4pY4FQtoOFm9GQCH+4R/Zaut
        WF3j4AD4etvh7Og0EbUlXPNvKYydGHbUEAWsJ8kzCl1IZFAhG7uMNF6u15D7KvRs
        LIlLj30yMx0/AAWLUsvzz18QWKpByXrB5XpAb0CCzEJeC0RFwI2x6vIWQhxwMm1h
        jpWeNSLcJT0/asZ1ZmhJESJoBnU3n9bF3lwVKjxJPWoP2m+nNUksTcbQIyMH5S8N
        fRoLXc+G15lljKtKN4RIFMIvgShfwCeKNcu1wC2546gw/WpFSru74xxCA==
X-ME-Sender: <xms:wzpiZJAxIz5cWKHa4PL2Uwx3gKaOb56VsWl97LCraUzH3ZFdmk4pQw>
    <xme:wzpiZHiWOewVQswlqTXg_3kldI52ZR_ob1HD4Mh4NSLTymABf2sS__1uRqrOqldva
    -GLiza7FGJv7ke6DLM>
X-ME-Received: <xmr:wzpiZEk5tQ-3iw8M1tLa4tDKLD98_sc5awEwGMmz-rSf52rtBuWJlteMqCPM1U64HVUESw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeehjedgjedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdttddttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpefhieeghfdtfeehtdeftdehgfehuddtvdeuheet
    tddtheejueekjeegueeivdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:wzpiZDxm0OMzzY2TyAAUdZWo89htkQr4CTZcIy8bK_5SRKaHGfKJww>
    <xmx:wzpiZOQzKb9tY__3F1bdEg7406eOayKQ6Tqu4sQEs0cOnto9Y9hUhA>
    <xmx:wzpiZGaMQHiI5ukg5Lcq5yOTmeC3vVttjJ60wJkQTY0gvbyioPtUHw>
    <xmx:xDpiZIEKjMim5R9XoDtSHdROtzGvTXkVG4Ja_H4fiLJ5XjIpoZJUkQ>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 May 2023 09:59:31 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 28C0810D1DE; Mon, 15 May 2023 16:59:28 +0300 (+03)
Date:   Mon, 15 May 2023 16:59:28 +0300
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
Subject: Re: [PATCH v2 03/20] x86: decompressor: Call trampoline as a normal
 function
Message-ID: <20230515135928.a46324hlw56pctls@box.shutemov.name>
References: <20230508070330.582131-1-ardb@kernel.org>
 <20230508070330.582131-4-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230508070330.582131-4-ardb@kernel.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, May 08, 2023 at 09:03:13AM +0200, Ard Biesheuvel wrote:
> Move the long return to switch to 32-bit mode into the trampoline code
> so we can call it as an ordinary function. This will allow us to call it
> directly from C code in a subsequent patch.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
