Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8C7701FAB
	for <lists+linux-efi@lfdr.de>; Sun, 14 May 2023 23:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbjENVNe (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 14 May 2023 17:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjENVNd (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 14 May 2023 17:13:33 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA617199;
        Sun, 14 May 2023 14:13:29 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 1D14F5C00C2;
        Sun, 14 May 2023 17:13:29 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sun, 14 May 2023 17:13:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1684098809; x=1684185209; bh=IuSPhPzoKt6SzlFItZmSGd7IF
        Em9JtR4K2XlTqqjDSg=; b=tRwc6niuBNOVuTKwEyqx9a6VsQIiR8Moy/8NsjRBc
        MFNzOOBwCeyBwuKH7hfQf2mu11BcHRvW1/sTy4ioyfDuFCfb831tniIUXGJWZLoQ
        +olt7twOWA1isCCaTiLKvMAj/ObtUl1WhE8iidAq9qKKDFSNBBs2icMa1urfhSyq
        jzlTGwaNZLVGaG3PN9OieoaRG0lwYWf3/jRkOXymTJ1/5i+FgiZiry1ORlENAWvP
        dVt+22VdL8RZQszaF5cZNpd0J0NBOlTGSBHTTJf0Ei2WBX/bB/H93NDVbMcFYE6r
        4kNmCJWwvOPkvJQ5AFuUF/dT08mYqhEeUO5moMzZWR7zQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1684098809; x=1684185209; bh=IuSPhPzoKt6SzlFItZmSGd7IFEm9JtR4K2X
        lTqqjDSg=; b=qAOct1LDQY6g96IN0g+vR8v7cPKjM76ZHfoMUWVWkTj38CppXKb
        n2qLMtnZjESXKqj5IoGvh+Y2tH2QsKrUUZbixtRlm8ZpZx31hjD/VYngQ5yhM8X0
        tgSZWUPOBTxLaZ/jfTPnY/TDMO0jDiP5PLOfKyQHRl8VXxPGFW4I5JNL4vJWNt+0
        v/at5pANurF9eFyKG+s+INq228hVcDUSkq8LXMSucg3Ij7lQFX7hyJlXmKXNyT2e
        qebGr1GFlQ7bogamkkOa7WznBY6VUnfRPEVmO9g1SE1jaE2YulTGy0cyKKsoN/N7
        OpmPFn+xFm63xvHzfPl3Xi9SvvJF6PUiDJw==
X-ME-Sender: <xms:905hZEwNnRihkRdYg1IppfpF8vo443CZSZgXN2NJllWOoxaDq8afSQ>
    <xme:905hZIQN1wahBceOitOKWZkmDwXaOk3jjKQppfIHlY4cA2DVb8bJYqyQAloOdmmXM
    NnpFEAfOO9sP01_lcc>
X-ME-Received: <xmr:905hZGWxxQTBe3OxmEOACoGB9D_jRgtPgEARzA6z7I6oHfHGu_c8HfaiEa7ZWBxTdOSN8w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeehhedgudehlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtugfgjgesthektddttddtudenucfhrhhomhepfdfm
    ihhrihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovh
    drnhgrmhgvqeenucggtffrrghtthgvrhhnpeetveehleetgeegffejffejtdevgeeugeef
    tefghffhgfeivefghfeuvefgjeekfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:905hZCiyjAnj_6KNeSN0F6O_NLZB6_jSQVnkBZo3yyIzqICtgjngIA>
    <xmx:905hZGCPG6Lb8T15UCZh4ofkAfw6HkvZcDh3x6st1z5bocz4QE3jAQ>
    <xmx:905hZDLo8rXNLtX2L-pO6pqr9QvJzl0YAkPubSiE-HXqSbc8BQfO2A>
    <xmx:-U5hZOu8SfLvzZc6LhBAYNrPOc51oXjVX3-fpAw4XAQ91y9OfBhpnw>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 14 May 2023 17:13:27 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 3DBD910C400; Mon, 15 May 2023 00:13:24 +0300 (+03)
Date:   Mon, 15 May 2023 00:13:24 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Mika =?utf-8?B?UGVudHRpbMOk?= <mpenttil@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
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
Subject: Re: [PATCHv11 3/9] efi/libstub: Implement support for unaccepted
 memory
Message-ID: <20230514211324.fymzoa263wx2hs2p@box.shutemov.name>
References: <20230513220418.19357-1-kirill.shutemov@linux.intel.com>
 <20230513220418.19357-4-kirill.shutemov@linux.intel.com>
 <9549d984-e581-048d-95a3-7c54acd70fb8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9549d984-e581-048d-95a3-7c54acd70fb8@redhat.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, May 14, 2023 at 08:08:07AM +0300, Mika Penttilä wrote:
> > +	status = efi_bs_call(allocate_pool, EFI_LOADER_DATA,
> > +			     sizeof(*unaccepted_table) + bitmap_size,
> > +			     (void **)&unaccepted_table);
> 
> 
> Wonder if EFI_LOADER_DATA guarantees bitmap not to be freed, or should some
> more persistent type be used. If EFI_LOADER_DATA is enough, maybe a comment
> why it is safe could be added.

Ughh.. I've lost the hunk that reserves the memory explicitly while
folding in the patch we discussed with Ard. See below.

But the question is solid.

Ard, do we want to allocate the memory as EFI_RUNTIME_SERVICES_DATA (or
something else?) that got reserved automatically without additional steps?

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index e15a2005ed93..d817e7afd266 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -765,6 +765,25 @@ int __init efi_config_parse_tables(const efi_config_table_t *config_tables,
 		}
 	}
 
+	if (IS_ENABLED(CONFIG_UNACCEPTED_MEMORY) &&
+	    efi.unaccepted != EFI_INVALID_TABLE_ADDR) {
+		struct efi_unaccepted_memory *unaccepted;
+
+		unaccepted = early_memremap(efi.unaccepted, sizeof(*unaccepted));
+		if (unaccepted) {
+			unsigned long size;
+
+			if (unaccepted->version == 1) {
+				size = sizeof(*unaccepted) + unaccepted->size;
+				memblock_reserve(efi.unaccepted, size);
+			} else {
+				efi.unaccepted = EFI_INVALID_TABLE_ADDR;
+			}
+
+			early_memunmap(unaccepted, sizeof(*unaccepted));
+		}
+	}
+
 	return 0;
 }
 
-- 
  Kiryl Shutsemau / Kirill A. Shutemov
