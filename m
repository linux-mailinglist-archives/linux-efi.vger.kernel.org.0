Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1E0966C001
	for <lists+linux-efi@lfdr.de>; Mon, 16 Jan 2023 14:43:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbjAPNnG (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 16 Jan 2023 08:43:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbjAPNm5 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 16 Jan 2023 08:42:57 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F241C1CF52;
        Mon, 16 Jan 2023 05:42:54 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 13DCC320046E;
        Mon, 16 Jan 2023 08:42:51 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 16 Jan 2023 08:42:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1673876570; x=1673962970; bh=UC
        PpXlC2FNyfKFYm+ug4JseRqO27ZMyvZOVWc30I6Cw=; b=RF7tMbWf+BQMmxPOoY
        8PYg2uVoJjSdxuv7mr9lhLnO2fT16DiT8/NjlfbLFPRCICmjdGnrZuG9QI/ycw7l
        k3lTeNnsTf9FM9x3ZNQr2gM9CWrzsrQnkVAMYZG7eGSnD0PV3TjJ5i3o7FkbRJ/H
        tpP7ceO17wpPTyiEeB68YZxlHylcdlCHlkAA1Q7W16629Hqu+KDJZFUmXzFNgqN1
        gIdqZCefLICmUyLxhYh3EkswnABedhXZnoROLb/Xs4un2CI1FCXah2P8ivWvMbt2
        MzRFFy36Rmo1eizlxptUmR//jSAE95GJe9irzyZPLbeRb0uLfR5jTvgzTCDLVKP8
        dOIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1673876570; x=1673962970; bh=UCPpXlC2FNyfKFYm+ug4JseRqO27
        ZMyvZOVWc30I6Cw=; b=rQRJ50QH9Hlw9W7HrzikGmwoEcaAxJIkvW38BuQ/e0AN
        j3onD1u9tjAEl1jv8qZHjHQAW7gvsn4efFF5gcz7z5psD7a4Pm2m5/tNap3eTHeD
        +ZzEz2qQOz6giVjhUqEwF5VqkYDAgMk368blK2RR1A6C3wyCUjksUhlfyJ8se46h
        KIMo6FHvxO3abJGlwdhKh4dMbZEKWWEjGVxW3ynx1kGfQyC07fJs1s0na/3Ew/9S
        nQ84ObvOiD40dvXP0kVgub3F58xxp7F6ZxEChGkI0010apgbHYRPZJlncgu4CGX/
        VDZajJ/JC5Pa8MeF251Rnik3iXlm5If+4O3K6qRbFA==
X-ME-Sender: <xms:WlTFYwO50Pm2wcUEhvReHTUQIAVCAGa4H7apl84ZlSUOys83yluIwg>
    <xme:WlTFY2-U0VQXzgIx5al3U9T7ODtoewugv4rq9UVmbZF6N2vJMLCGKJxGEnJK6jIJA
    2USS66RidNLKTJ909Y>
X-ME-Received: <xmr:WlTFY3RFTHhG0-y1A1LU4u_Hdrg7QEo2tENtDyueu5THwlAvJbiBE-PFyJ_mYtIiqsXmtA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddtgedgheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdttddttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpefhieeghfdtfeehtdeftdehgfehuddtvdeuheet
    tddtheejueekjeegueeivdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:WlTFY4s2s6Jvu5Yyy-pm-ElqOmmp8TKhO-z--dN1wpNyrxR5-Tncag>
    <xmx:WlTFY4fftlcSNbImWomkllVxWbBAKkY-Xocpfy56dHh2h_2pb1bGJA>
    <xmx:WlTFY80SC0lGCibR0-X2yNITaQDJUEs9JNRuB7XElQ8KWoO-JI-4MQ>
    <xmx:WlTFY-2SXjVObZoLG5cmDjPGCEOKCZGMSEy7XbpIeCpRhZUdIgVNOw>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Jan 2023 08:42:49 -0500 (EST)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 01F39109792; Mon, 16 Jan 2023 16:42:46 +0300 (+03)
Date:   Mon, 16 Jan 2023 16:42:46 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Gerd Hoffmann <kraxel@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dionna Glaze <dionnaglaze@google.com>,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        x86@kernel.org, jiewen.yao@intel.com, devel@edk2.groups.io,
        "Min M. Xu" <min.m.xu@intel.org>,
        James Bottomley <jejb@linux.ibm.com>,
        Tom Lendacky <Thomas.Lendacky@amd.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v2] x86/efi: Safely enable unaccepted memory in UEFI
Message-ID: <20230116134246.soworigs56bz5v7o@box.shutemov.name>
References: <20230113212926.2904735-1-dionnaglaze@google.com>
 <20230113222024.rp2erl54vx3grdbd@box.shutemov.name>
 <20230116105648.63hsxnmj2juwudmu@sirius.home.kraxel.org>
 <20230116123057.wvr6rz7y3ubgcm5z@box.shutemov.name>
 <CAMj1kXGVNHqGN2uhziARu9H3RQiqbPJBE1GxHuWzC5gajJyaeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXGVNHqGN2uhziARu9H3RQiqbPJBE1GxHuWzC5gajJyaeA@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Jan 16, 2023 at 02:11:26PM +0100, Ard Biesheuvel wrote:
> On Mon, 16 Jan 2023 at 13:31, Kirill A. Shutemov <kirill@shutemov.name> wrote:
> >
> > On Mon, Jan 16, 2023 at 11:56:48AM +0100, Gerd Hoffmann wrote:
> > > On Sat, Jan 14, 2023 at 01:20:24AM +0300, Kirill A. Shutemov wrote:
> > > > On Fri, Jan 13, 2023 at 09:29:26PM +0000, Dionna Glaze wrote:
> > > > > This patch depends on Kirill A. Shutemov's series
> > > > >
> > > > > [PATCHv8 00/14] mm, x86/cc: Implement support for unaccepted memory
> > > > >
> > > > > The UEFI v2.9 specification includes a new memory type to be used in
> > > > > environments where the OS must accept memory that is provided from its
> > > > > host. Before the introduction of this memory type, all memory was
> > > > > accepted eagerly in the firmware. In order for the firmware to safely
> > > > > stop accepting memory on the OS's behalf, the OS must affirmatively
> > > > > indicate support to the firmware.
> > > >
> > > > I think it is a bad idea.
> > > >
> > > > This approach breaks use case with a bootloader between BIOS and OS.
> > > > As the bootloader does ExitBootServices() it has to make the call on
> > > > behalf of OS when it has no idea if the OS supports unaccepted.
> > >
> > > Nothing breaks, it'll error on the safe side.  If the protocol callback
> > > is not called the firmware will simply accept all memory.  The guest OS
> > > will only see unaccepted memory if it explicitly asked for it (assuming
> > > the firmware wants know to support both cases, of course the firmware
> > > could also enforce the one or the other and just not offer the
> > > protocol).
> >
> > How bootloader suppose to know if OS will ask for unaccepted memory?
> > It can't. It means the use-case with bootloader cannot ever use
> > unaccepted memory. That's broken design.
> >
> 
> I still don't understand why we need to support every imaginable
> combination of firmware, bootloader and OS. Unaccepted memory only
> exists on a special kind of virtual machine, which provides very
> little added value unless you opt into the security and attestation
> features, which are all heavily based on firmware protocols. So why
> should care about a EFI-aware bootloader calling ExitBootServices()
> and subsequently doing a legacy boot of Linux on such systems?

Why break what works? Some users want it.

This patch adds complexity, breaks what works and the only upside will
turn into a dead weight soon.

There's alternative to add option to instruct firmware to accept all
memory from VMM side. It will serve legacy OS that doesn't know about
unaccepted memory and it is also can be use by latency-sensitive users
later on (analog of qemu -mem-prealloc).

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
