Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C99A702F11
	for <lists+linux-efi@lfdr.de>; Mon, 15 May 2023 16:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238846AbjEOOAy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 15 May 2023 10:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239146AbjEOOAu (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 15 May 2023 10:00:50 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EDCD2128;
        Mon, 15 May 2023 07:00:49 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 8F45D5C019F;
        Mon, 15 May 2023 10:00:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 15 May 2023 10:00:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1684159248; x=
        1684245648; bh=juiNHrUzx0kPifAlLPcVKdoJyC3AmE7OLGyX51c9DvU=; b=k
        JlCZf3HpdzCXu1qEjQlf3K302d5suoREVYTdvielGFcRRxsVsoJWAtSNgxGtyJR8
        KfTFCD2ma/FEWoZM/i84xr6rEfr8rDN509y6vkH+2RwkIng0WZQd5e3oQU72Wwci
        RAVUXc3pZngXriyox1AnSJapYb+YR+Xw4T4Lc6p3Ppe7kR1UvGEk7d9Rr+OIwZ5A
        ++jiuJD3IGZ65U+OlGvyhtfrOp18b9rthHMqffdp7OWtBMpPEqszf8FmxHXOT5qd
        zO24QjKr+oM/8XhXDir/DvXoI4i/poHcEzKFt77g8MfB+WladJ/TgXE/h+CpNB8F
        sj161HxifLol9hU7GvXOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1684159248; x=1684245648; bh=juiNHrUzx0kPi
        fAlLPcVKdoJyC3AmE7OLGyX51c9DvU=; b=fSvn1l+ENyyL5InwaJoOLz2tG7yQU
        YEZs2k9DWIqcCsWJNFCx0/NngDpomHnKe1Pi9dpYMFrKhXLvI9SToF2JWMtWYpmb
        eAMn4odxEEtzFeFBOG6g1DDdc9sjdELXNLeG3nGQ+06XZPEdP3FejMzBWp1u8C0E
        2C2+egF4FCpeOD8hbKgpg1x/RD1JnwWCGt0wOEsf+rVuv1WwScs77q5XOSdesvXo
        g2GqoZB8zIp8QJSVpcVrNcGYei/CA/YXDOY2RdOqdxLRhWb8XHKcKqFHOOhsah7v
        OSNOjNxhFwcxz8XKQk2olUC6nY65J4yna4PK7IBkoJVMhqOGUc6K/Fyag==
X-ME-Sender: <xms:EDtiZEd7MrWrGhWAzbD8yNHk2kMUohEsYdIvZ7p8zaSeXoaY_YmkAg>
    <xme:EDtiZGNjqgA1Ur_yaYAjv-HRKvqTjgkPJY92zXh7f-xSlRitQ8WjLznW1g84T5J0W
    HZsBtWCQDpnQO0kk68>
X-ME-Received: <xmr:EDtiZFibe87AvCcFiHaKVdWj8wYhYvMg7PIgwcS_oIdzKZsQHTtm60vtBHQla1cj-oU5ow>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeehjedgjedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdttddttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpefhieeghfdtfeehtdeftdehgfehuddtvdeuheet
    tddtheejueekjeegueeivdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:EDtiZJ-gNcIJbfD7-2PRiAKkSH9g9DvKmA6rwhsybRKLYP46GH-oKg>
    <xmx:EDtiZAsC_A8gdsD0jYCxYS92YqN6meVfsjykGbAMKaBXPPFq-p8b5Q>
    <xmx:EDtiZAFdLSXuMZYRb05CuINBNbHrfUNgSjY9YjuYUXxGlcay4OpwKw>
    <xmx:EDtiZASFTzqtskjVY1xxd5Gr28Vt_qlgbNrz_iFPr_mO5nz3tbqVnA>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 May 2023 10:00:47 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 3291410D1DE; Mon, 15 May 2023 17:00:46 +0300 (+03)
Date:   Mon, 15 May 2023 17:00:46 +0300
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
Subject: Re: [PATCH v2 04/20] x86: decompressor: Use standard calling
 convention for trampoline
Message-ID: <20230515140046.yaxvt462bt6ovew2@box.shutemov.name>
References: <20230508070330.582131-1-ardb@kernel.org>
 <20230508070330.582131-5-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230508070330.582131-5-ardb@kernel.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, May 08, 2023 at 09:03:14AM +0200, Ard Biesheuvel wrote:
> Update the trampoline code so its arguments are passed via RDI and RSI,
> which matches the ordinary SysV calling convention for x86_64. This will
> allow us to call this code directly from C.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
