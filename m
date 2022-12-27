Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA31E65670E
	for <lists+linux-efi@lfdr.de>; Tue, 27 Dec 2022 04:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbiL0DTD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 26 Dec 2022 22:19:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbiL0DTC (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 26 Dec 2022 22:19:02 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBEEDEAF;
        Mon, 26 Dec 2022 19:18:57 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 04FA85C017F;
        Mon, 26 Dec 2022 22:18:55 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 26 Dec 2022 22:18:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1672111135; x=1672197535; bh=ZC
        YnFXki7u0QnJz1QySGzrUAbqVjjYGpn0e5VSFUlcU=; b=uoG1n4z6ni/BgxxNrY
        vZzqX3V55aD52nykAF8d0p3Enq5/dJVg51p/NpAKTqaBKcmz3mZepHsD+QN9GJr/
        eBdTsdHBTXRgxIxuQwKWnoD/nwoVPvGU3nxttCcb/JZqX1R+GlSaCBf8NtBpfh84
        3RbuD1i/x8nAWDcNeReA6tDh9Fhiu3jz38E/PhQ0GL8FWgTz2F9YEJRE992TF2K8
        5HmpdIEQf3JFlB8ot9QXLFKZjh6rFPJtlPTQ1Me9HJgWWflUOhOcNrtAym25Ztb7
        4Bh6o5DnjSrKPM5nYqwod1UgiE5L0t1BTKCU8kNoaExnKbO1kEGz9Tsb1ZCOSVN9
        zJQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1672111135; x=1672197535; bh=ZCYnFXki7u0QnJz1QySGzrUAbqVj
        jYGpn0e5VSFUlcU=; b=iGyPAlCnrtxEeKou1rB2cG6xGfK79cbPLTyoyh2tkW0e
        beE9MwLgIwhpUi+wrfdWTNWObgzJQL2tC7D64Y64EJh2JcOk294pjIJmJjRbqQuT
        HP2XVI66zbtwq3xGQxu3nb9HyZ5m3mwnQBypyt3w/4i1FJcT9tlvBT3CsuPWFgTw
        3NT8ogqH6qKqBf1KIpS4IJL9UtPxlM7vcHfPxBatj8XW7kIBHoLqI05lDWYicklJ
        34YmpapDQOpLQJImPBOLPh+Nde/vnoPQlbMrwNtvOVPwVp5xythCfrBwfJIR+xLd
        Ag4NK5VITTSJhAzVLKz/6rNMx9NtDRlW4PfHUBXsNA==
X-ME-Sender: <xms:HWSqY8gEbS5j1_Ef8Yn4642kNODvUBFqk-h2FxS3cvXzwle-4fHy7A>
    <xme:HWSqY1DVDNeLWEFk1wkY5MXJH5MqU3igmnOwxwJDMYJePgllYLg2AZHuGFv29otbK
    LTRWb3TofjiR7S2eBc>
X-ME-Received: <xmr:HWSqY0ELPRVaEmF-ij2C10z2aJERY0imqh2D7pdycqMPZAwCRe4XQhtThKE0Kx2irf2MtA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrheelgdehkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttddttddttddvnecuhfhrohhmpedfmfhirhhi
    lhhlucetrdcuufhhuhhtvghmohhvfdcuoehkihhrihhllhesshhhuhhtvghmohhvrdhnrg
    hmvgeqnecuggftrfgrthhtvghrnhephfeigefhtdefhedtfedthefghedutddvueehtedt
    tdehjeeukeejgeeuiedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgv
X-ME-Proxy: <xmx:HWSqY9Sc6eWC0iBm_iLRs4qxwmP7KNUOLY08uR0ErXa9VUn_Q3yvdA>
    <xmx:HWSqY5wCEm9McwFBIYcEmRBzg6-swqKUu25u-L7GjRPZzQjwjk0aTA>
    <xmx:HWSqY77guamTz8X5UbHfDbV1lAh8-5ZnSXRmOBXzDajZMH-xnMtcsQ>
    <xmx:H2SqYzfIjMYaB_c9-8zjkEtG3ghF1Zf6uFZaEA9G45eUyIszUdDZCA>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Dec 2022 22:18:53 -0500 (EST)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 79BC7109CB8; Tue, 27 Dec 2022 06:18:49 +0300 (+03)
Date:   Tue, 27 Dec 2022 06:18:49 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
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
        Dave Hansen <dave.hansen@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        aarcange@redhat.com, peterx@redhat.com, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCHv8 02/14] mm: Add support for unaccepted memory
Message-ID: <20221227031849.7sqnnbnn7umhsa63@box.shutemov.name>
References: <20221207014933.8435-1-kirill.shutemov@linux.intel.com>
 <20221207014933.8435-3-kirill.shutemov@linux.intel.com>
 <Y6mSNhO3vpuzjr8O@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6mSNhO3vpuzjr8O@zn.tnic>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Dec 26, 2022 at 01:23:18PM +0100, Borislav Petkov wrote:
> On Wed, Dec 07, 2022 at 04:49:21AM +0300, Kirill A. Shutemov wrote:
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 6e60657875d3..6d597e833a73 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -450,6 +450,11 @@ EXPORT_SYMBOL(nr_online_nodes);
> >  
> >  int page_group_by_mobility_disabled __read_mostly;
> >  
> > +#ifdef CONFIG_UNACCEPTED_MEMORY
> > +/* Counts number of zones with unaccepted pages. */
> > +static DEFINE_STATIC_KEY_FALSE(unaccepted_pages);
> 
> Then call it what it is:
> 
> static DEFINE_STATIC_KEY_FALSE(zones_with_unaccepted_pages);
> 
> so that when reading the code it is self-describing:
> 
>         if (!static_branch_unlikely(&zones_with_unaccepted_pages))
>                 return false;

Looks good. Will fix for the next version.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
