Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F322C66BDDD
	for <lists+linux-efi@lfdr.de>; Mon, 16 Jan 2023 13:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjAPMbM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 16 Jan 2023 07:31:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjAPMbK (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 16 Jan 2023 07:31:10 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B7035B9;
        Mon, 16 Jan 2023 04:31:06 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id AB6A93200926;
        Mon, 16 Jan 2023 07:31:02 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 16 Jan 2023 07:31:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1673872262; x=1673958662; bh=GA
        efGTRYV8k2AcfSXuQg3jAZJ+2nQm68uzPllcZ7W6g=; b=rgqE77COihinuJ6B22
        xrzBg+KCo9nX34j6aO3qWOFuUJF50Trf2RuAYqbSTly4ddm8k9fhuP+/kD7GPUB8
        C8HD6fExGxh4A0X6O2vur1t7v+szxstsj23rualNvJbKNlJQPUmzQRp71eerYYGc
        bhnw2qFMPUGSd4qDEKoY7ci/5HsdmfCFfPBHjYkgZa683HB/Qq7V2JdiXbQ558AD
        gRUCarYu+jBw24+eE/IFZaCEnBTyptuvsI6Gy6pZ2XwChjkGsDX4p9yw56E/vL2E
        UDStROgWL1PgxPcDTQnigbZ+z9OTguvt4mIKLG4uuUI7B84efWdHweAiAHulDioH
        NmxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1673872262; x=1673958662; bh=GAefGTRYV8k2AcfSXuQg3jAZJ+2n
        Qm68uzPllcZ7W6g=; b=TGfMw1d+r4qVRpM0Vq1vpiLmmdcYDvV1wvrlWki9SiaJ
        Zt/sMXoXcoGSbglgA31Jk+H1NCcf/IjgI+dUNY1QPBH3pc1RSERfHcH/1MaeSyyT
        KSvM2GhcXvMieys6A+fKr5XbLL5FHsYHEJFOgvRCG9jS7Qo0jV8fNRwyT8IpBhVR
        80hxf8bQLQ3E/BdXp/L2ExybWCC94ofIjMBwmVeDZSFiNOSbPx+iodw7mYVkQdL7
        l1cDSoNKPLagIFxmjekarKmWA7ojX5eXaSYOu3J5ijaQnVcbYMfhI/QG7opFwSrA
        9fPhkA3ZNj32r4VZ9ALdp9+DNO7ThZ+r7SaY2rCNtQ==
X-ME-Sender: <xms:hUPFY-_xfe5vtM6b0oGhDBSUxzkvspCUkjMGliTS7rlNW8W1viGYUg>
    <xme:hUPFY-vYRkX2vgP0WgS1t_tBPs5M37dWvjQuz0T8lWg_UZA0GMrRKm5-89qMyHJ7m
    d6FFcQqY_eIBNB9I84>
X-ME-Received: <xmr:hUPFY0DWEeDbArN_TfN-fqENZYQiXfEK62qcsVdhhIyO4RkhWiJvB-OVNEparkj7zD2w2w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddtgedggedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdttddttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpefhieeghfdtfeehtdeftdehgfehuddtvdeuheet
    tddtheejueekjeegueeivdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:hUPFY2cl-bW_ZCJgvr542a_gqDNHuQYsE0Vb4ul8qjunPsypGMZIJQ>
    <xmx:hUPFYzM751tQiISToW4QiOtLzDpScxjlyMwx4_oeFb85J4NVoYO6Sw>
    <xmx:hUPFYwmjji5VgGHoL6gSR0RJlNf6noVm25CxHhtFuOOmYAH48gmmvw>
    <xmx:hkPFY3lf8GMVvVfFFq1mQZEQvqwGngnWSAMk7btqNWo6o31hFoDl8g>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Jan 2023 07:31:00 -0500 (EST)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 9DD80109792; Mon, 16 Jan 2023 15:30:57 +0300 (+03)
Date:   Mon, 16 Jan 2023 15:30:57 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dionna Glaze <dionnaglaze@google.com>,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        x86@kernel.org, jiewen.yao@intel.com, devel@edk2.groups.io,
        Ard Biescheuvel <ardb@kernel.org>,
        "Min M. Xu" <min.m.xu@intel.org>,
        James Bottomley <jejb@linux.ibm.com>,
        Tom Lendacky <Thomas.Lendacky@amd.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v2] x86/efi: Safely enable unaccepted memory in UEFI
Message-ID: <20230116123057.wvr6rz7y3ubgcm5z@box.shutemov.name>
References: <20230113212926.2904735-1-dionnaglaze@google.com>
 <20230113222024.rp2erl54vx3grdbd@box.shutemov.name>
 <20230116105648.63hsxnmj2juwudmu@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230116105648.63hsxnmj2juwudmu@sirius.home.kraxel.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Jan 16, 2023 at 11:56:48AM +0100, Gerd Hoffmann wrote:
> On Sat, Jan 14, 2023 at 01:20:24AM +0300, Kirill A. Shutemov wrote:
> > On Fri, Jan 13, 2023 at 09:29:26PM +0000, Dionna Glaze wrote:
> > > This patch depends on Kirill A. Shutemov's series
> > > 
> > > [PATCHv8 00/14] mm, x86/cc: Implement support for unaccepted memory
> > > 
> > > The UEFI v2.9 specification includes a new memory type to be used in
> > > environments where the OS must accept memory that is provided from its
> > > host. Before the introduction of this memory type, all memory was
> > > accepted eagerly in the firmware. In order for the firmware to safely
> > > stop accepting memory on the OS's behalf, the OS must affirmatively
> > > indicate support to the firmware.
> > 
> > I think it is a bad idea.
> > 
> > This approach breaks use case with a bootloader between BIOS and OS.
> > As the bootloader does ExitBootServices() it has to make the call on
> > behalf of OS when it has no idea if the OS supports unaccepted.
> 
> Nothing breaks, it'll error on the safe side.  If the protocol callback
> is not called the firmware will simply accept all memory.  The guest OS
> will only see unaccepted memory if it explicitly asked for it (assuming
> the firmware wants know to support both cases, of course the firmware
> could also enforce the one or the other and just not offer the
> protocol).

How bootloader suppose to know if OS will ask for unaccepted memory?
It can't. It means the use-case with bootloader cannot ever use
unaccepted memory. That's broken design.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
