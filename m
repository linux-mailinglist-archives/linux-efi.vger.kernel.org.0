Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00D81591CA4
	for <lists+linux-efi@lfdr.de>; Sat, 13 Aug 2022 22:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240276AbiHMU7Q (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 13 Aug 2022 16:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240280AbiHMU7P (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 13 Aug 2022 16:59:15 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE8E110FDE;
        Sat, 13 Aug 2022 13:59:13 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 2B8695C0107;
        Sat, 13 Aug 2022 16:59:13 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sat, 13 Aug 2022 16:59:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-transfer-encoding:content-type:date:date:from
        :from:in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1660424353; x=
        1660510753; bh=8ehvrQN0pYNFeadixhtX5cZ4eBy7Bgjn0JWqP+l7wXQ=; b=g
        FDwk5/6lXnt8IgUJBQ5h3ul+WnJaUqC6rkxWEvv2tFpia49i71CkydK1KyQRQDD7
        tFdrCBX0nFbwO2ac4cjfh58oN2SyUIGUMGewk4oGA6t/spNXjma8R8AeTilZ/FHM
        fIgHoqm4Gt4ACoZNrK99W/TOU2JbDMMyEABj3iMQpk7j3PqAWbzpv0eMpauS9Wyq
        GCMy+rz4NDG4A/Oc+xvm16J1c/v1AfGcc072nSHEtXA3byTtikqFjdymuQ2hsbQ5
        jqtzU0gweDS4Qtxkm0L//zUvrve55VVROdC/j1E4W68G30B8k3OXFu5+Pt+qEdsZ
        Q3z7tOhGVFvkcIbpcR93A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1660424353; x=
        1660510753; bh=8ehvrQN0pYNFeadixhtX5cZ4eBy7Bgjn0JWqP+l7wXQ=; b=k
        /y/rtfU1c0w9XkXRQQ2h9nUAvJe3+XoGwPui0wznHuh3MWeSsxNaVmbxLt2g0gxV
        qn3QGn7HklA3lTPFu8x3xaYDrikQa0uRzhUeLf7s5hIQzoIIz1vGgDEImDzla7mY
        6atxbGqUfzrAygK5+7BV3wRE3WAYToZQOKhu/ELdLOImaD7n+8ENYA+jAJhH93RI
        S5p6R5s6r2281WnD4UBdQifTLvMWmZ/foovmWYg2ozAljvmjCPtaKlmObWsbINsK
        v2jq9v6zXlOA7ScMETizfN/1Pa932O56p+yYYZFLFXIOnRzxz8RSh/bzRKgEA0cR
        Hx0SAxmFUKXMUK+swjv2g==
X-ME-Sender: <xms:oBD4YmbnHUcZ05Fi9g_fQdBsukxw9Muj_clN-RMEnLChGabXHdPlUQ>
    <xme:oBD4YpZGnzMyawcBJLvkEsO8A24ig_OeA2CH6AfFrL2zh33VLTm1VJlJN9EV9S1KE
    zHMNOC03XRO7bmhVSM>
X-ME-Received: <xmr:oBD4Yg8q5DF9DL90EBCefi43RXaJ7690L3gICRGUi1VpbkII-RtTLM_QkDxqOrpCYMqiqg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdegkedgudehkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtugfgjgesthektddttddtjeenucfhrhhomhepfdfm
    ihhrihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovh
    drnhgrmhgvqeenucggtffrrghtthgvrhhnpefgjeeikefffeefvedugfdtkedvhfdttdei
    feevtdehgefgjeffleelgffggfdvkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:oBD4YorOpkilMY54cma3E5WvcODN-cZxGvlukzoP3gxjT3Bq38D2nw>
    <xmx:oBD4YhqxERzJTeppq3_iPpkUQ-QyanzRofDirgs6kbOSahPfuoIEUw>
    <xmx:oBD4YmRghClAjK7t-5ICrgBOoyBcRfKH_0Vil58Ak8Wi605i2K1uKQ>
    <xmx:oRD4YkXyL_uZTHn7KBrlE0FZYFwJuRLurhibJzr8ZX2MkSLLo5Mehw>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 13 Aug 2022 16:59:12 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 57259104A08; Sun, 14 Aug 2022 00:02:15 +0300 (+03)
Date:   Sun, 14 Aug 2022 00:02:15 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
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
        Dave Hansen <dave.hansen@intel.com>,
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
Message-ID: <20220813210215.ti7f2vqdg6olthjv@box.shutemov.name>
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
 <20220614120231.48165-11-kirill.shutemov@linux.intel.com>
 <7cec93c5-3db4-409b-8c1e-bc1f10dd68fc@www.fastmail.com>
 <20220809113827.fchtnyzy44z5fuis@box.shutemov.name>
 <453fb432-ac13-4819-8395-95561bca948b@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <453fb432-ac13-4819-8395-95561bca948b@www.fastmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, Aug 13, 2022 at 09:03:13AM -0700, Andy Lutomirski wrote:
> 
> 
> On Tue, Aug 9, 2022, at 4:38 AM, Kirill A. Shutemov wrote:
> > On Tue, Jul 26, 2022 at 01:17:13PM -0700, Andy Lutomirski wrote:
> >> 
> >> 
> >> On Tue, Jun 14, 2022, at 5:02 AM, Kirill A. Shutemov wrote:
> >> > load_unaligned_zeropad() can lead to unwanted loads across page boundaries.
> >> > The unwanted loads are typically harmless. But, they might be made to
> >> > totally unrelated or even unmapped memory. load_unaligned_zeropad()
> >> > relies on exception fixup (#PF, #GP and now #VE) to recover from these
> >> > unwanted loads.
> >> >
> >> > But, this approach does not work for unaccepted memory. For TDX, a load
> >> > from unaccepted memory will not lead to a recoverable exception within
> >> > the guest. The guest will exit to the VMM where the only recourse is to
> >> > terminate the guest.
> >> 
> >> Why is unaccepted memory marked present in the direct map in the first place?
> >> 
> >> Having kernel code assume that every valid address is followed by
> >> several bytes of memory that may be read without side effects other than
> >> #PF also seems like a mistake, but I probably won’t win that fight. But
> >> sticking guard pages in front of definitely-not-logically present pages
> >> seems silly to me.  Let’s just not map it.
> >
> > It would mean no 1G pages in direct mapping for TDX as we accept 2M a
> > time.

As of now, we don't have a way to recover direct mapping from
fragmentation. So once we split 1G to 2M it stays this way.

> >> (What if MMIO memory is mapped next to regular memory?  Doing random
> >> unaligned reads that cross into MMIO seems unwise.)
> >
> > MMIO is shared, not unaccpted private. We already handle the situation.
> > See 1e7769653b06 ("x86/tdx: Handle load_unaligned_zeropad() page-cross to
> > a shared page").
> >
> 
> I don’t mean in a confidential guest — I mean generally. This whole
> model of “overrun the buffer — no big deal” is just fragile.

If you want to remove load_unaligned_zeropad(), I would not object. It can
make life easier.

I presumed that optimization it brings has measuarable benefit (otherwise,
why bother).

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
