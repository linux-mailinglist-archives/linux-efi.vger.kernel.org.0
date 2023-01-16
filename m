Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF1166D325
	for <lists+linux-efi@lfdr.de>; Tue, 17 Jan 2023 00:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233577AbjAPX3R (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 16 Jan 2023 18:29:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235593AbjAPX2x (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 16 Jan 2023 18:28:53 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74553A856;
        Mon, 16 Jan 2023 15:17:19 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 893865C011A;
        Mon, 16 Jan 2023 18:17:16 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 16 Jan 2023 18:17:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1673911036; x=1673997436; bh=Uw
        OeuY6GjuWphYvoJ4W/l9OkICnzVHEBFf/gKxu2bqk=; b=DGCHX44GgRe7zMJQI7
        tchGnBuDyB5kpIMnXDU37IP84twoeZ5wwF5NLuddk3YKKsSuDdn5odJXWuWHG9Dk
        0uw5wdHfT5Fwkl3a7VYtnSSpiW+G3RSqnJ1pqdys7xI5BtQg1nsofhOJcuRpBvMo
        YyKo0kfWPOoAeLbx1nEYjCjzShEFhowTtFl/HhhkLFCXwUc+aPdazT4totzhMBp+
        Z0uA8ex2vkJJmtasBVC/fxwzDirE9aTtsyCKGY2VfezN7ZkWSWP6hLeXr5gJfTqr
        19HhqQH/ULvkxHk1JXkei7h1zUF2wHmAZj0CA1n8yBLobcps6/f2NSJXHxccB8xu
        ztsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1673911036; x=1673997436; bh=UwOeuY6GjuWphYvoJ4W/l9OkICnz
        VHEBFf/gKxu2bqk=; b=oIe48XbTH8OSqD7pVFo5Ru+5OxKJykXwObLUZ88Q6HGN
        kdMT3UDZ9kyhM1eBwt7wV5b77csSGH2W917gqoWwH5a9J48afFszuvZhNNnClXa3
        +hjmMSoBYZY0l5/19LYW4JSsLTggPZLNG4brgFnJ7yNU1pgtRx7i9zkbDU3HFBSE
        SIn6E0e1gr30rgRfG/Rl20rQEI0N6zK0DNVMUJqB3PbBXXcTzimbvZ0zthFdLmnC
        Y+L3AnykN31aSf/Sf1uRHL+fZW6ggBBjRNc6b7z1NYB5xPlcotJByqfdXxl+twX/
        VAs5rs2vdoNqgZzFnv4RCMtHmsiVkUk5PqpvzJlkcg==
X-ME-Sender: <xms:-9rFY08zYnD9m-Vko62Nh4gqsaIObaCxpDRcg9Pp7-uZPYNQWCtPCg>
    <xme:-9rFY8vusiq6suDQg9obwnbV7gkllxOzt7bRTMXEA1g_I8zvoAB6h4Uroe9f8gnwx
    52e_PHY51WJDFuXdQU>
X-ME-Received: <xmr:-9rFY6BmPhUbVBHaca6QHHsl-v_HR5DqnqdZKVD60V5jcsEZBkHKhFsEszNNmrypbVIjlQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddthedgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdttddttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpefhieeghfdtfeehtdeftdehgfehuddtvdeuheet
    tddtheejueekjeegueeivdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:-9rFY0feKLyk3GC1VO40Thd2LjPCmO63VKhrHPSbQBggwNhTdGE1NA>
    <xmx:-9rFY5My0oyvlhyzFOc_tfinWWORFk1QV3NBCOXlFmt04N7j0PCKNQ>
    <xmx:-9rFY-k2WmndQq0oLt3Pj3nfOYFjlzjVKXNbPThUsHxQP5lEtYnFcw>
    <xmx:_NrFY9ntMx7GdE-1Mq0nNXmXkHOiuDk_jJOKK1yXskyqK192APORsg>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Jan 2023 18:17:15 -0500 (EST)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 8AA94109792; Tue, 17 Jan 2023 02:17:11 +0300 (+03)
Date:   Tue, 17 Jan 2023 02:17:11 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Dionna Amalie Glaze <dionnaglaze@google.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        x86@kernel.org, jiewen.yao@intel.com, devel@edk2.groups.io,
        "Min M. Xu" <min.m.xu@intel.org>,
        James Bottomley <jejb@linux.ibm.com>,
        Tom Lendacky <Thomas.Lendacky@amd.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v2] x86/efi: Safely enable unaccepted memory in UEFI
Message-ID: <20230116231711.cudsnxvnfg6aef3w@box.shutemov.name>
References: <20230113212926.2904735-1-dionnaglaze@google.com>
 <20230113222024.rp2erl54vx3grdbd@box.shutemov.name>
 <20230116105648.63hsxnmj2juwudmu@sirius.home.kraxel.org>
 <20230116123057.wvr6rz7y3ubgcm5z@box.shutemov.name>
 <CAMj1kXGVNHqGN2uhziARu9H3RQiqbPJBE1GxHuWzC5gajJyaeA@mail.gmail.com>
 <20230116134246.soworigs56bz5v7o@box.shutemov.name>
 <CAAH4kHb6-6QkMnYbcQ6MyMkwSBUN-Q3CcM3fuiStdbbnSfJv1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAH4kHb6-6QkMnYbcQ6MyMkwSBUN-Q3CcM3fuiStdbbnSfJv1A@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Jan 16, 2023 at 11:43:15AM -0800, Dionna Amalie Glaze wrote:
> > > I still don't understand why we need to support every imaginable
> > > combination of firmware, bootloader and OS. Unaccepted memory only
> > > exists on a special kind of virtual machine, which provides very
> > > little added value unless you opt into the security and attestation
> > > features, which are all heavily based on firmware protocols. So why
> > > should care about a EFI-aware bootloader calling ExitBootServices()
> > > and subsequently doing a legacy boot of Linux on such systems?
> >
> > Why break what works? Some users want it.
> >
> 
> The users that want legacy boot features will not be broken,

Why do you call boot with a bootloader a legacy feature?

> they'll only get a safe view of the memory map. I don't think it's right
> to choose unsafe behavior for a legacy setup.

Present memory map with unaccepted memory to OS that doesn't about it is
perfectly safe. This portion of the memory will be ignored. It is "feature
not [yet] implemented" case.

> > This patch adds complexity, breaks what works and the only upside will
> > turn into a dead weight soon.
> >
> > There's alternative to add option to instruct firmware to accept all
> > memory from VMM side. It will serve legacy OS that doesn't know about
> > unaccepted memory and it is also can be use by latency-sensitive users
> > later on (analog of qemu -mem-prealloc).
> >
> 
> This means that users of a distro that has not enabled unaccepted
> memory support cannot simply start a VM with the usual command, but
> instead have to know a baroque extra flag to get access to all the
> memory that they configured the machine (and for a CSP customer, paid
> for). That's not a good experience.

New features require enabling. It is not something new.

> With GCE at least, you can't (shouldn't) associate the boot feature
> flag with a disk image because disks are mutable. If a customer
> upgrades their kernel after initially starting their VM, they can't
> remove the flag due to the way image annotations work.

I guess a new VM has to be created, right? Doesn't sound like a big deal
to me.

The old will not break with upgraded kernel. Just not get benefit of the
feature.

> All of this headache goes away by adopting a small patch to the kernel
> that calls a 0-ary protocol interface and keeping safe acceptance
> behavior in the firmware. I think Gerd is right here that we should
> treat it as a transition feature that we can remove later.

Removing a feature is harder than adding one. How do you define that
"later" has come?

Anyway, I think we walk in a circle. I consider it a misfeature. If you
want still go this path, please add my

Nacked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
