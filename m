Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BCC97241EE
	for <lists+linux-efi@lfdr.de>; Tue,  6 Jun 2023 14:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232007AbjFFMTb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 6 Jun 2023 08:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbjFFMTb (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 6 Jun 2023 08:19:31 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4F9E54;
        Tue,  6 Jun 2023 05:19:30 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 8FBC55C00F9;
        Tue,  6 Jun 2023 08:19:29 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 06 Jun 2023 08:19:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1686053969; x=
        1686140369; bh=eMgbmfO4n2kZdbVnfADr60x6eK0Ld2t432qe3NAZMQ4=; b=j
        HQpYMBWdPEngh7GTogG1JcK44zHd1xFfQKCr7pw8AlFmkjPrLOyN/GbO7Kwu2pnJ
        7VFvwO8mAe5G1Ofx0T5jqZycNb5fn3XU+MG9jqgmfSppXoi+6ed4AgCc9HafMN6F
        mrfmcnf0aLSOpBf8NZEsr12Fhj7Paz3N53O0fGsMz12xpBJhwU5hVN7oAusfb5YK
        PrUmtDm+AsFwfy1+RnPi8HTzkQbEjTXJiVS3NGxSrrmVc/OLncvqDWIlYxq2Jfwk
        VDHrQm8J86dvg6VAzxanW11lxLMuilF9P8tLUv8bZkCuZd59fUXk2540YhRkAgTY
        DcyWhpv7OnuIsbShnJ5iQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1686053969; x=1686140369; bh=eMgbmfO4n2kZd
        bVnfADr60x6eK0Ld2t432qe3NAZMQ4=; b=DFK3TMmuHfpcBYoyzfHZXn4gdyTZe
        jGBw/bQOF0V+z/hcbx5eFli8UCiXay4dhrNYzheOVeESayrqgmYJo5GADrPPreW/
        a0equVNAGjnXBqkwWGvI/e9+puX6yYZdMZmZMNMsVeHQwBRbfyLNkKLgrCeEMjzC
        b/cGlVzJTDxagJsW4P4f3VCCvQIz8WZyPqjTG5UNAzu3kvVL3FeqyFE8rcIJj0/x
        Lp4A4cMbKjY+j/EPEM3gUGV+DrX0UfEWR1pA7xZ7R0r89s3zHxDLcDqaMrywYjn2
        UimK6pVZVsSHXd8uisqpwt912ZbQNtr5xAcvKfydpXo0rdqB9z1tYCCDA==
X-ME-Sender: <xms:TyR_ZO7XS2oBalwSM2-4_8BBJg4gy5GyUL468ZtjWjti6O0j7EO10A>
    <xme:TyR_ZH7gqCFisLS3bDXn_vMtJ4KLiOePP6l-XoTZU4R-UFZQYehSHkw1VGPjWbZAf
    vgM4Qb86Tk2RajmV0g>
X-ME-Received: <xmr:TyR_ZNchIT58FCO73qHovRvguaJ0HtwJPLk-ZzclOj0TP7JLo4kO9g819bqVaqoOXxKj_g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedtuddghedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdttddttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpefhieeghfdtfeehtdeftdehgfehuddtvdeuheet
    tddtheejueekjeegueeivdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:TyR_ZLL-mSHXZsiM6YHbXG1-WnBtxXG35XGD6an9v4Nh48wbhGfvZw>
    <xmx:TyR_ZCIiwQ3MeWUmgvQTPPAXfF-0KYBRLIPMYniXIl8vYuz4V-VEqw>
    <xmx:TyR_ZMywJNS0T3HS1qSR5DHj3JK5tuT26V_UxURC9ktFZOccV9pUuw>
    <xmx:USR_ZBU0hQd1O33GKsta2A81sTlLWPCSKmKTS_cp8dS_ASohUPTO0w>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Jun 2023 08:19:27 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 21F0810A6A4; Tue,  6 Jun 2023 15:19:24 +0300 (+03)
Date:   Tue, 6 Jun 2023 15:19:24 +0300
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
Message-ID: <20230606121924.wcjezcppuiofvnk6@box.shutemov.name>
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
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Jun 05, 2023 at 09:12:25PM +0200, Borislav Petkov wrote:
> So how about you explain that explicitly somewhere, perhaps in a comment
> above accept_memory(), that the unaccepted range is not the whole memory
> but only, well, what is unaccepted and the rest is implicitly accepted?

Does it look okay to you?

/*
 * accept_memory() -- Consult bitmap and accept the memory if needed.
 *
 * Only memory that explicitly marked as unaccepted in the bitmap requires
 * an action.
 *
 * No need to accept:
 *  - anything if the system has no unaccepted table;
 *  - memory that is below phys_base;
 *  - memory that is above the memory that addressable by the bitmap;
 */

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
