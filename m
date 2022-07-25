Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 994C357FF68
	for <lists+linux-efi@lfdr.de>; Mon, 25 Jul 2022 15:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234839AbiGYNAh (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 25 Jul 2022 09:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232202AbiGYNAg (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 25 Jul 2022 09:00:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F9C1FE7;
        Mon, 25 Jul 2022 06:00:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0848060B08;
        Mon, 25 Jul 2022 13:00:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3126DC341CD;
        Mon, 25 Jul 2022 13:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658754034;
        bh=Z2zzzoZrRO4S3EO/OVriM7FNu33t82mtKGNUW8yxdMo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NTlzQhT+8azuC/qm812aifg/DmWh2eB2EqFOBkKQdycA2qCFLnrbnSv+IGxscEV7w
         VxuRZ5zyIUkwMh+cu4ohMYZvn81JRF5aHk7+SlhD6qJAxylWrauDExuot+Ct5iSgb6
         TmLxAzU/jxOVaHVX8LyXQ0Bz62L8r4ZKJWS9tELLxLeInMTkttTlDqUIJVou8vzAEY
         Do+9YAz9S7qmUtM+Wy+8ThqHEXu0U2xMoh4hvRpG/jVBLZdJye1mIAzOCH0NJJdvx7
         Nl79BRb4YBrpvRbqeW2KhqzG/mI30Sff/868k5qahgPtSNCL69+Megu+Ec7MWN3+G/
         BsrRDWtE/NOow==
Date:   Mon, 25 Jul 2022 16:00:14 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
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
        David Hildenbrand <david@redhat.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        x86@kernel.org, linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCHv7 02/14] mm: Add support for unaccepted memory
Message-ID: <Yt6T3vlbTZ5z0nZ/@kernel.org>
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
 <20220614120231.48165-3-kirill.shutemov@linux.intel.com>
 <YtltYRuL+2uQkYUK@zn.tnic>
 <ebcf2979-45fc-8d41-cc28-ac8da0d24245@intel.com>
 <Ytr4FCV2xPGUBLqs@zn.tnic>
 <707ca113-c2a2-8fe2-a22c-5be13adc7bb4@intel.com>
 <Yt6LOD9Ae2NqyG1N@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yt6LOD9Ae2NqyG1N@zn.tnic>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Jul 25, 2022 at 02:23:20PM +0200, Borislav Petkov wrote:
> On Fri, Jul 22, 2022 at 12:30:36PM -0700, Dave Hansen wrote:
> > Sure does...  *Something* has to manage the cache coherency so that old
> > physical aliases of the converted memory don't write back and clobber
> > new data.  But, maybe the hardware is doing that now.
> 
> Let's hope.
> 
> > Yeah, that two-tier system is the way it's happening today from what
> > I understand. This whole conversation is about how to handle the >4GB
> > memory.
> 
> Would it be possible to pre-accept a bunch of mem - think "pre-fault" -
> from userspace?
> 
> I.e., I'm thinking some huge process is going to start in the VM, VM
> userspace goes and causes a chunk of memory to be pre-accepted and then
> the process starts and runs more-or-less smoothly as the majority of its
> memory has already been "prepared".

An application in the VM can do mlock() or mmap(..., MAP_POPULATE, ...) and
this will essentially force acceptance of that memory.

But there's no sysctl or something for that.
 
> Or does that not make any sense from mm perspective?
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette

-- 
Sincerely yours,
Mike.
