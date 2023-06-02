Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4B27201EA
	for <lists+linux-efi@lfdr.de>; Fri,  2 Jun 2023 14:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235925AbjFBMUr (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 2 Jun 2023 08:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235865AbjFBMUj (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 2 Jun 2023 08:20:39 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFCF6E4E;
        Fri,  2 Jun 2023 05:20:28 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 9E5BA5C019C;
        Fri,  2 Jun 2023 08:20:25 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 02 Jun 2023 08:20:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1685708425; x=
        1685794825; bh=LJwGtIyIeLmnYVEFoH3vhv8yIZMtqhumpxyu8aO0UZ4=; b=i
        8Oa1Un/852ADrhzLyCkd/TGdc2WjpsRWw5V7Fv+j8OGN9J7isXQRzJXJexQBZXgy
        DEnRCC8norSQdVKKT+hvNGF5GK/K7mdCWD5mrUKBiKV2SXgHfInGXzs1LqyKzGEX
        M07T+NuTv+E3yc++lWXnvb4EHiiA1cb+s1X2o9Jmgo3wzQLx/fWCD7aaQ5zFc9TB
        wtxleYZqg0FLGdOQh1ReGa6jNd6In6qXM65KHmyFaMksTli8t5Aq3IGR7mpFxSiG
        pmnkrz/UnPEN1kHGbFM23Ynfkfc72e/CqAklK0Uhv0Os4xysMFMe2KvAI280CfnR
        5A4YR3Hc6AHyycH/1stXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1685708425; x=1685794825; bh=LJwGtIyIeLmnY
        VEFoH3vhv8yIZMtqhumpxyu8aO0UZ4=; b=WRVvKWE3CJRJpN/5jefEEI0ambBOE
        aUtfqAx+NA5k8zY6Etj0mU7/2ShkID6eYqTnF9F8FUw4Aaq4Wts2z2Yc8H+dzytu
        UGunHnj3vkdWxH/3Q0cflvRAfDID6Cf0jGDl2ZrYIUX6a2YR4EVFsVwkndLK9mg0
        RhfR8xEBQqoyAgCXN4hl5ybJIBYNijw9fb9xNWfUiMF4/bO+7mjEzQv7AWoV2uLZ
        P390JG6E9oNZDRsTOxnyTqxIa61O1YvyFLMU/6ETneHlT9bvrGJ9n1E+g3MmdOhO
        3CGyMqBXt7Tw1LlrDnWbN3aOM5pJN9kmMgJm5VqJVGcAagGH3JA6SB3/A==
X-ME-Sender: <xms:iN55ZNg_hcd_zZwEZmqbPDWdgsY1TCxn_B8pTY1FHeV7mbeBDZskgg>
    <xme:iN55ZCBbLh4ge478uQ_T_aRygKdE38sGDbklhi_c5ml3T9EvfoM3amXOkC3tJn2pk
    95A_BD0bj5iQ6-gXAk>
X-ME-Received: <xmr:iN55ZNHkezipURl4zC9Qdc9q05o8aEquFJX0ledpOCtHvtP8gJUqTikoH1GkGoqFM7hh-g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeelfedggeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdttddttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpefhieeghfdtfeehtdeftdehgfehuddtvdeuheet
    tddtheejueekjeegueeivdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:iN55ZCSf48-sh20U-45oXyAKIEdEa8IsqaU1k1TE3WKkYiK5CW1pfA>
    <xmx:iN55ZKzeWC6k10x8SCzM-wWvDNqT6Yh-hxFG7IxAuXbTh-so39judg>
    <xmx:iN55ZI7zW4MV4Pgffb8j0py62dR_Pwspgkxa4av-VK__zb66_aOxkQ>
    <xmx:id55ZD_MJhBlWXV26pf2Thl58DPNjDhJyY6by2E3z_hBSwdzzHOijw>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Jun 2023 08:20:24 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 5D1AA10E1DE; Fri,  2 Jun 2023 15:20:21 +0300 (+03)
Date:   Fri, 2 Jun 2023 15:20:21 +0300
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
Subject: Re: [PATCHv13 3/9] efi/libstub: Implement support for unaccepted
 memory
Message-ID: <20230602122021.ad275pqia6wfclyc@box.shutemov.name>
References: <20230601182543.19036-1-kirill.shutemov@linux.intel.com>
 <20230601182543.19036-4-kirill.shutemov@linux.intel.com>
 <20230602121005.GJZHncHTryexRFihZj@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230602121005.GJZHncHTryexRFihZj@fat_crate.local>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jun 02, 2023 at 02:10:05PM +0200, Borislav Petkov wrote:
> On Thu, Jun 01, 2023 at 09:25:37PM +0300, Kirill A. Shutemov wrote:
> > diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
> > index 043ca31c114e..231f1c70d1db 100644
> > --- a/drivers/firmware/efi/Kconfig
> > +++ b/drivers/firmware/efi/Kconfig
> > @@ -269,6 +269,20 @@ config EFI_COCO_SECRET
> >  	  virt/coco/efi_secret module to access the secrets, which in turn
> >  	  allows userspace programs to access the injected secrets.
> >  
> > +config UNACCEPTED_MEMORY
> 
> Why is this Kconfig symbol in this file?
> 
> I'm thinking this needs to be somewhere generic, like in mm/Kconfig or
> so...

Unaccepted memory is an EFI feature. We can move it somewhere else, if
other firmware/platform would support anything like it.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
