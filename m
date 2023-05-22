Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4E770BB27
	for <lists+linux-efi@lfdr.de>; Mon, 22 May 2023 13:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232990AbjEVLIf (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 22 May 2023 07:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbjEVLH5 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 22 May 2023 07:07:57 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD9791BC;
        Mon, 22 May 2023 04:03:06 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 8F10B5C013A;
        Mon, 22 May 2023 07:01:22 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 22 May 2023 07:01:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1684753282; x=
        1684839682; bh=Ot/PaadLQmFY3PRWcupRZot4l1Jk74XWyrXMKDJAiLc=; b=E
        JVHEIbN4tyUpkbE2KYtZ0Gwo6mGCxBTHoeBI+ulaPBcMt3jpE2WZXu+lxu/sAw5v
        bzfNMLkNJhihM6Du1Luqx/VuLPPgXyX0GWvemtBUs97nhjicUIbfG0SH++nQBdbQ
        J255NuS1lc0/V5x3nzMLdAAcogaDhjJNy7MupOktEIb8fBXzdWZ82FMrLrJpPdI3
        ifa/wFRrpPPn6sDvbOjHJsKBBmgXeYrz29TBAjxkowqJoB5u+fV0bnEX51NUeqhh
        H7a4YPUCS/g6wuSy2dbxnABEgiDfoJTiaMiokRPvDDLXzbtWR/hnAZgcDAuZBYhH
        XAzppUJWIW5iXY3xsMhFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1684753282; x=1684839682; bh=Ot/PaadLQmFY3
        PRWcupRZot4l1Jk74XWyrXMKDJAiLc=; b=EubsQEL6iFNqM6WWcXvLutuhU+Py5
        f52bufa3ZfautO7wbJoO8SVL/eD1Iy/MEUp+RJzzn2EGHo8CBaPtGASyJW9iLZ8E
        KjtpwPNQCIuGAvUorF5zXHHbgmFkoJc5U1yK0XHE4VbURlSIgEe1C+t4Yx13NSiS
        1aukA3DgoKsvqTAgiguzZZrHYKxTpNjAq5JvdGilNOQWTXCvgzSEITmkjDcE2J20
        JT+eTgyxnQiBg7EuJFy9pLXnoGAkkNjYJEin7TQFPLYP03qCF1b256KxoB6SwVPl
        j74n7u57spUQDCytnQ35Nf510jdCybBADtIo1FTgqy99TFXaHDWC4EfgA==
X-ME-Sender: <xms:gEtrZKS7fPZCgqwrAb_n3LKyJtycQ31034U0W-Twv7dLp8-YYI4K_g>
    <xme:gEtrZPxY136Ee-mWwFDOgB7MLTequTzXm4X7Cn9r1ILp9a3lrTMttNq6swO8fmSEL
    NylIOv4sYy-wXtS0yw>
X-ME-Received: <xmr:gEtrZH2jUwPeombGzQSAWOLM1UdpD_570v-GBGINF_S2PfgmLadsBe1SrSkfh_rKFMLR4Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejuddgfedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdttddttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpefhieeghfdtfeehtdeftdehgfehuddtvdeuheet
    tddtheejueekjeegueeivdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:gEtrZGBWnvHLAi7hu6LS3TOmyszVd0VnrMwzc-AYSFvRIQt1NZv3SQ>
    <xmx:gEtrZDjLyD4G0VItk6KUNpl-Ql_1OYIeUIXVWgOs7id834eIggD9-g>
    <xmx:gEtrZCpzmYr5PJ8uS7asUOgeXCfz4XStfBr8cs-EVcWLs5phAo6C8w>
    <xmx:gktrZGObdfzgdlgQkwJjz5Jo3kXtyuv8TynU2QEraPxxOynsbgsWAQ>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 May 2023 07:01:19 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 9E671103828; Mon, 22 May 2023 14:01:16 +0300 (+03)
Date:   Mon, 22 May 2023 14:01:16 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
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
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Liam Merwick <liam.merwick@oracle.com>
Subject: Re: [PATCHv12 4/9] x86/boot/compressed: Handle unaccepted memory
Message-ID: <20230522110116.675nqxrztxbtmdl7@box.shutemov.name>
References: <20230518231434.26080-1-kirill.shutemov@linux.intel.com>
 <20230518231434.26080-5-kirill.shutemov@linux.intel.com>
 <20230519101641.nka7ty3fttntymci@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230519101641.nka7ty3fttntymci@box.shutemov.name>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, May 19, 2023 at 01:16:41PM +0300, Kirill A. Shutemov wrote:
> On Fri, May 19, 2023 at 02:14:29AM +0300, Kirill A. Shutemov wrote:
> > diff --git a/arch/x86/boot/compressed/mem.c b/arch/x86/boot/compressed/mem.c
> > index 67594fcb11d9..87372b96d613 100644
> > --- a/arch/x86/boot/compressed/mem.c
> > +++ b/arch/x86/boot/compressed/mem.c
> > @@ -1,9 +1,32 @@
> >  // SPDX-License-Identifier: GPL-2.0-only
> >  
> >  #include "error.h"
> > +#include "misc.h"
> >  
> >  void arch_accept_memory(phys_addr_t start, phys_addr_t end)
> >  {
> >  	/* Platform-specific memory-acceptance call goes here */
> >  	error("Cannot accept memory");
> >  }
> > +
> > +void init_unaccepted_memory(void)
> > +{
> > +	guid_t guid =  LINUX_EFI_UNACCEPTED_MEM_TABLE_GUID;
> > +	struct efi_unaccepted_memory *unaccepted_table;
> > +	unsigned long cfg_table_pa;
> > +	unsigned int cfg_table_len;
> > +	int ret;
> > +
> > +	ret = efi_get_conf_table(boot_params, &cfg_table_pa, &cfg_table_len);
> > +	if (ret)
> > +		error("EFI config table not found.");
> > +
> > +	unaccepted_table = (void *)efi_find_vendor_table(boot_params,
> > +							 cfg_table_pa,
> > +							 cfg_table_len,
> > +							 guid);
> > +	if (unaccepted_table->version != 1)
> > +		error("Unknown version of unaccepted memory table\n");
> > +
> > +	set_unaccepted_table(unaccepted_table);
> > +}
> 
> 0-day reported boot failure outdise TDX guest with CONFIG_INTEL_TDX_GUEST=y.

0-day folks reported one more issue: booting on non-EFI system fail.

Updated fixup:

diff --git a/arch/x86/boot/compressed/mem.c b/arch/x86/boot/compressed/mem.c
index 0108c97399a5..e7f7ef31e581 100644
--- a/arch/x86/boot/compressed/mem.c
+++ b/arch/x86/boot/compressed/mem.c
@@ -46,8 +46,13 @@ void init_unaccepted_memory(void)
 	struct efi_unaccepted_memory *unaccepted_table;
 	unsigned long cfg_table_pa;
 	unsigned int cfg_table_len;
+	enum efi_type et;
 	int ret;
 
+	et = efi_get_type(boot_params);
+	if (et == EFI_TYPE_NONE)
+		return;
+
 	ret = efi_get_conf_table(boot_params, &cfg_table_pa, &cfg_table_len);
 	if (ret)
 		error("EFI config table not found.");
@@ -56,6 +61,9 @@ void init_unaccepted_memory(void)
 							 cfg_table_pa,
 							 cfg_table_len,
 							 guid);
+	if (!unaccepted_table)
+		return;
+
 	if (unaccepted_table->version != 1)
 		error("Unknown version of unaccepted memory table\n");
 
-- 
  Kiryl Shutsemau / Kirill A. Shutemov
