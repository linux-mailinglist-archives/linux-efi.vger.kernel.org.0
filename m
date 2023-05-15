Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 575E7702F32
	for <lists+linux-efi@lfdr.de>; Mon, 15 May 2023 16:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239677AbjEOOFd (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 15 May 2023 10:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239956AbjEOOFa (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 15 May 2023 10:05:30 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E8AD268A;
        Mon, 15 May 2023 07:05:15 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 8CC9C5C01B0;
        Mon, 15 May 2023 10:05:14 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 15 May 2023 10:05:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1684159514; x=
        1684245914; bh=wNoygY88afCZk+rYSwxBYyhC2OwuB/Ta5vKCxI/HOkg=; b=o
        LHJzTtle/7GDwWpas+OOsATuoQ1nsSWhQ089NXzAIwrib5JlWsx0Km/AxUyEJl+C
        za0wg64+u4AwWguq4dVSwjXnwrYLn2m1oOL5X31KbO5yttZZFi4pcKlTrtLqG6Qy
        Iez7xAleEZ/w2db58UcCR7Y1IkLa5/Gdj9N3FzK715kqHok0BKYKjZyFDO/D4X5p
        tGarviqOaDAkTXZ4X6UCDEowTa09HE2iIbAn1q6F4dSrgW49NcF4j10Ukm+zNcKE
        pRA+aDDwABiKK0JU4yh1lK6f0gZnzPrlMc+UelKz96nVRxa3sHGpKaNYcdrysJkW
        IO/K1K5UdlgHZJ9jHzTpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1684159514; x=1684245914; bh=wNoygY88afCZk
        +rYSwxBYyhC2OwuB/Ta5vKCxI/HOkg=; b=gJOaqsgODjlwSnjVashQdA4IBnCHO
        NVGn+IcJa4/osYWpe06Hc8+TSSSjU/MM4XFer+WU8PaRo9OLrAViv/kBbUZ8oBS3
        sO40qb+MLnuu8lYc1mVVbqyEk4trCgJosQMwy1uAHe58XtZBoC+SP9TsKNReaKhK
        QfVUab3oi6o8TvkYw8gy3JogpnG8ENPJB79/7hJ2dHqvTdH+/ebRKv0S+hcxxHhp
        yKOq2T8bIbPNwoEbEKBzwZhQdGiGWHeKc6cA9IuBq8/RLkgk3uwZ5MkhRa7EM+nR
        iSBl1jBdbW3UNC3fIL5M0JGBxh2c5zb30iuPxvNtvm8HL+052JvMGLqHg==
X-ME-Sender: <xms:GjxiZIEJ7VEucMB6Wl99U873CbaA-xxDJ-F_XHfRPVnNyLIf2SnzHg>
    <xme:GjxiZBUOWcH0NWMt0Rasrq1QCoopWV339zVU4QbeuVr_YOKYsi7pEKNsvS5OsSFQt
    ppD5CTFLWjrI1_9l38>
X-ME-Received: <xmr:GjxiZCI1Tn5lT3UzFTD_or7AQQOTPLC5cU28BSCUSJP9528tEb_H44jxxj-TcB7FFb5yBg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeehjedgjeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdttddttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpefhieeghfdtfeehtdeftdehgfehuddtvdeuheet
    tddtheejueekjeegueeivdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:GjxiZKGXRMdh0OonpOeyJVnnforiWll3om2-Sg0e08oV0DxEcvouyQ>
    <xmx:GjxiZOX5HhtW2Z_gwwiOEc2yAtk4rp2RZj1-cnACs_I88siEmHUTwg>
    <xmx:GjxiZNPAttaxz3EjeET8Ttq3wwXZMeu8aVOyIJ6oQTP6BLbDjhpaNA>
    <xmx:GjxiZMZuiayhPQGYdZZApda1ftRrE-oOXk2-RSvPsnFkAVxg3F-s0w>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 May 2023 10:05:13 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 0E02410D1DE; Mon, 15 May 2023 17:05:12 +0300 (+03)
Date:   Mon, 15 May 2023 17:05:12 +0300
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
Subject: Re: [PATCH v2 06/20] x86: decompressor: Call trampoline directly
 from C code
Message-ID: <20230515140512.pokuznjp257pkhy4@box.shutemov.name>
References: <20230508070330.582131-1-ardb@kernel.org>
 <20230508070330.582131-7-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230508070330.582131-7-ardb@kernel.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, May 08, 2023 at 09:03:16AM +0200, Ard Biesheuvel wrote:
> Instead of returning to the asm calling code to invoke the trampoline,
> call it straight from the C code that sets the scene. That way, we don't
> need the struct return type for returning two values, and we can make
> the call conditional more cleanly in a subsequent patch.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
