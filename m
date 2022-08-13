Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FBC8591CA9
	for <lists+linux-efi@lfdr.de>; Sat, 13 Aug 2022 23:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240490AbiHMVKb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 13 Aug 2022 17:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240487AbiHMVKa (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 13 Aug 2022 17:10:30 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1B210579;
        Sat, 13 Aug 2022 14:10:29 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id C6AA65C00F2;
        Sat, 13 Aug 2022 17:10:28 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sat, 13 Aug 2022 17:10:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-transfer-encoding:content-type:date:date:from
        :from:in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1660425028; x=
        1660511428; bh=8fcTcuAeWHQjpVwzcJr2YO/c0/5Ia3k+hIoMp6C3cvs=; b=d
        3ZJr9EJY3ECCcEo8FAO2lKRuA3495jqGwsZXg1ITVbnWG1sl45t/2+22sBSYRJpU
        19PYjWEzteFAB3aBPkkSK0515BYVoDkm99J9hLBdCrMAmzsQ3GxtEDAFcf+ZFahu
        aasX+K19EHb0nEc5PB0XEFJaO4xzk6ds+YPXwXMIHlLW07K4H+QBz/zvV13HRXNe
        gnougRJtxzKxaNeyJswIYXVRRNDloI7795A/dT/11gccBWNvnBfyqpJIbVM/GX1C
        ksILa/HU33Hjt1wvhNqFKOHGz2blYm7iUuDAP+rxZhU7M0H2Okh8V03b6N3pIsgN
        v5RyuJzJkv+tTmoUkQzWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1660425028; x=
        1660511428; bh=8fcTcuAeWHQjpVwzcJr2YO/c0/5Ia3k+hIoMp6C3cvs=; b=k
        l6MUhf3mYPK+C1wiQ6ptsIeKDeIQ0V5Tgcb7zemsJpMJEjgSgwOSZrjCiRe922ME
        X9OCrwJC45gozPHfefZ1z3j96QjNT0l7cotCI4jmXsJ8RxFa31HBQKfvFv9MFwiz
        NTZBbmj55Unorad/IX+Hxu9FEJ9dvWWV/y7rNHpm8L1iHB9y0+2+CPfJ259ZOT1i
        5SrtLzGBzMnmf/v2VT8eNc/NDFeM+LF2pe3bCpERYQlGTj0xzIK1JVY1+dscLdCt
        RCX/Hml1GlEl6wAP0sSVzUz0WSIroToG8P1pE4z/S5GOUgV2YLOmSt8Lvb71ZU7b
        mMShNfwQELDlTfjGJHbhg==
X-ME-Sender: <xms:QxP4YjrXTL_DlrdLSWxKphchpZk-GhZzJTk89rx4CO6R432ya-zXMw>
    <xme:QxP4Ytrbg3oErHYTZutivtJzyWWwI-2qR5aPkRutQw3F3zulwOtyf_Yqa3wJvLJj2
    9I-ZjTXSeiOjBiQeh4>
X-ME-Received: <xmr:QxP4YgPQAlL3ayHamdNS7yvPnq7Bc5AF6-N-4Ag9WV54ydF-5hsGHKrNLPWwuI76bbq0_A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdegkedgudeitdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtugfgjgesthektddttddtjeenucfhrhhomhepfdfm
    ihhrihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovh
    drnhgrmhgvqeenucggtffrrghtthgvrhhnpefgjeeikefffeefvedugfdtkedvhfdttdei
    feevtdehgefgjeffleelgffggfdvkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:QxP4Ym6vvBM_bgWMEW5eVlT64jBJ68VOVkLpafZuB82WmnAcFVWImA>
    <xmx:QxP4Yi5Kn0Y8WNLYczO4kKvDKNi8kHAGVzeDeMpKDV5N16AunhV2Zw>
    <xmx:QxP4YuiFxvXPYmiS2_-9ZuIasxnJczg9uKztlSwGMBP_hy3JzAJWyg>
    <xmx:RBP4Ynktg87ysYcR8CfmMWxRUTE-BEjbfkb6CXXgGDqhEdtsLPIy2g>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 13 Aug 2022 17:10:27 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 95A38104A08; Sun, 14 Aug 2022 00:13:30 +0300 (+03)
Date:   Sun, 14 Aug 2022 00:13:30 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Varad Gautam <varad.gautam@suse.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Marcelo Henrique Cerri <marcelo.cerri@canonical.com>,
        tim.gardner@canonical.com, khalid.elmously@canonical.com,
        philip.cox@canonical.com,
        the arch/x86 maintainers <x86@kernel.org>,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv7 10/14] x86/mm: Avoid load_unaligned_zeropad() stepping
 into unaccepted memory
Message-ID: <20220813211330.73bse242m4m5fz3n@box.shutemov.name>
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
 <20220614120231.48165-11-kirill.shutemov@linux.intel.com>
 <Yt/ANO5usdV+JSSW@zn.tnic>
 <80cc204b-a24f-684f-ec66-1361b69cae39@intel.com>
 <073c5a97-272c-c5a0-19f2-c3f14f916c72@intel.com>
 <YvTncOa6KSr8EIuE@zn.tnic>
 <f9e3aacf-d90e-42a1-ac0e-39ba61389305@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f9e3aacf-d90e-42a1-ac0e-39ba61389305@www.fastmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, Aug 13, 2022 at 09:11:52AM -0700, Andy Lutomirski wrote:
> Now if the TD module could deliver an unrecoverable #MC instead of an
> impossible-to-handle #VE, maybe we could at least get a nice debug trace
> out?  Of course it’s not so easy to do anything with a debug trace that
> doesn’t break confidentiality.

It is not impossible-to-handle #VE, it is no #VE for the guest and exit to
the host that cannot be recovered. Yes, it is not friednly for debugging.

Our plan was to allow SEPT_VE_DISABLE=0 for debug TD. It helps with
debugging stepping on unaccepted memory as allows #VE in the guest which
leads to panic() and nice traceback.

Would it be enough?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
