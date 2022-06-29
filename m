Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD26A55F28F
	for <lists+linux-efi@lfdr.de>; Wed, 29 Jun 2022 02:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbiF2A7S (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 28 Jun 2022 20:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiF2A7R (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 28 Jun 2022 20:59:17 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C0A13F29;
        Tue, 28 Jun 2022 17:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656464357; x=1688000357;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PdXIIJIuvGiIGyuDJJCs/uSsICdNzkseyWhvo/anTLA=;
  b=aAnLC1dxAodc6K7Ch03cJ9ifj2bw3BYVrgxY9a1ocN1FigZmQFOTRNbE
   RiiWiHdw8mgmIBFHolS8yJFxO7BZtSziDkQAIuz7LL7KFv7YQHdueZ/Zi
   u0Axn+LEJjdeXHxj/IuY4xcmBZ21mV2IPIBjuggAJC9RaxroV9Bw9rBsC
   konKcpgcS19vf0AgYXO1zVscTPZsdlpj0bmr9Y8i/DUGkrOA+SKeMS6ib
   C16hzCIkseRlX4A1zMuiEpZl8Am/QvDAwL8O55cwY5Uh7jsNBc8diRckF
   5lVL+irrX7iCNH8540KuBjq4ivlETnq9Zz1C1qtGPadz5htPZenWzfs0l
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="262295636"
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; 
   d="scan'208";a="262295636"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 17:59:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; 
   d="scan'208";a="917394813"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 28 Jun 2022 17:59:10 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 19836CE; Wed, 29 Jun 2022 03:59:15 +0300 (EEST)
Date:   Wed, 29 Jun 2022 03:59:15 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Borislav Petkov <bp@alien8.de>,
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
        Varad Gautam <varad.gautam@suse.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        x86@kernel.org, linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org
Subject: Re: [PATCHv7 11/14] x86: Disable kexec if system has unaccepted
 memory
Message-ID: <20220629005915.gieli3dbjzvjbk5i@black.fi.intel.com>
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
 <20220614120231.48165-12-kirill.shutemov@linux.intel.com>
 <6be29d38-5c93-7cc9-0de7-235d3f83773c@intel.com>
 <87a6a3aw50.fsf@email.froward.int.ebiederm.org>
 <20220624020005.txpxlsbjbebf6oq4@black.fi.intel.com>
 <20220628235105.z6ytdzxofrdkjti4@black.fi.intel.com>
 <88fe385c-fe40-d659-5081-7f3cdd9493e4@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88fe385c-fe40-d659-5081-7f3cdd9493e4@intel.com>
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Jun 28, 2022 at 05:10:56PM -0700, Dave Hansen wrote:
> On 6/28/22 16:51, Kirill A. Shutemov wrote:
> > On Fri, Jun 24, 2022 at 05:00:05AM +0300, Kirill A. Shutemov wrote:
> >>> If there is some deep and fundamental why this can not be supported
> >>> then it probably makes sense to put some code in the arch_kexec_load
> >>> hook that verifies that deep and fundamental reason is present.
> ...
> > +	/*
> > +	 * TODO: Information on memory acceptance status has to be communicated
> > +	 * between kernel.
> > +	 */
> 
> So, the deep and fundamental reason is... drum roll... you haven't
> gotten around to implementing bitmap passing yet?!?!?   I have the
> feeling that wasn't what Eric was looking for.

The deep fundamental reason is that everything cannot be implemented and
upstreamed at once.

-- 
 Kirill A. Shutemov
