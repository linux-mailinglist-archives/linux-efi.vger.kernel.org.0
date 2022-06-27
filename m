Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4227155D970
	for <lists+linux-efi@lfdr.de>; Tue, 28 Jun 2022 15:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240497AbiF0MWk (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 27 Jun 2022 08:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240572AbiF0MWd (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 27 Jun 2022 08:22:33 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB89BE3F;
        Mon, 27 Jun 2022 05:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656332552; x=1687868552;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LLKc0AVQgj8YvmbVbYU1Kd08ep7uNhDDyJkSyY3E5oQ=;
  b=dYZEZ9vnMMeH3Lvl201eBMdOes9F22is1Gt8P5Z/Mi2t3M9pIoODaT+E
   G52579bUW22uFGSx7FPyxhtX295odTFiLbNHPIJmog3orzhqwwHS61O0r
   cjd4LjU/A5Kvm/poGFXcL+ztz+L27G+unQcbb0FyywFcadaduuolF5nfu
   E5zpWNjL8tDQSZn2NDk/vWWeUGUCPMyCpRDAeQQ/sx4XduWdJlCvGeTDX
   bh8IFBIoQ3eo42lgwi/4ifT9gg2pqMAJSgtiA0BSSbEd/38c8BEIkfj2x
   5RR1nKk/jEvoxBkSu3CTX9EjbVYBapjdI2l/Ae7u/e3Zd8D5mUfcyy3mN
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10390"; a="270180404"
X-IronPort-AV: E=Sophos;i="5.92,226,1650956400"; 
   d="scan'208";a="270180404"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 05:22:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,226,1650956400"; 
   d="scan'208";a="836173918"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 27 Jun 2022 05:22:25 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 1FEC3D9; Mon, 27 Jun 2022 15:22:30 +0300 (EEST)
Date:   Mon, 27 Jun 2022 15:22:30 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Peter Gonda <pgonda@google.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
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
        Varad Gautam <varad.gautam@suse.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Marcelo Cerri <marcelo.cerri@canonical.com>,
        tim.gardner@canonical.com, khalid.elmously@canonical.com,
        philip.cox@canonical.com,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-coco@lists.linux.dev, linux-efi <linux-efi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv7 00/14] mm, x86/cc: Implement support for unaccepted
 memory
Message-ID: <20220627122230.7eetepoufd5w3lxd@black.fi.intel.com>
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
 <CAMkAt6osbEGBFrgn=y1=x4mDHC1aL40BwaW0NdGHF8qmWd7ktA@mail.gmail.com>
 <20220627113019.3q62luiay7izhehr@black.fi.intel.com>
 <CAMj1kXHD5XBAS1aBjzg1RCeK6qgtanUSED_xyTZ0v1j+UShMKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHD5XBAS1aBjzg1RCeK6qgtanUSED_xyTZ0v1j+UShMKw@mail.gmail.com>
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Jun 27, 2022 at 01:54:45PM +0200, Ard Biesheuvel wrote:
> On Mon, 27 Jun 2022 at 13:30, Kirill A. Shutemov
> <kirill.shutemov@linux.intel.com> wrote:
> >
> > On Fri, Jun 24, 2022 at 10:37:10AM -0600, Peter Gonda wrote:
> > > On Tue, Jun 14, 2022 at 6:03 AM Kirill A. Shutemov
> > > <kirill.shutemov@linux.intel.com> wrote:
> > > >
> > > > UEFI Specification version 2.9 introduces the concept of memory
> > > > acceptance: some Virtual Machine platforms, such as Intel TDX or AMD
> > > > SEV-SNP, requiring memory to be accepted before it can be used by the
> > > > guest. Accepting happens via a protocol specific for the Virtual
> > > > Machine platform.
> > > >
> > > > Accepting memory is costly and it makes VMM allocate memory for the
> > > > accepted guest physical address range. It's better to postpone memory
> > > > acceptance until memory is needed. It lowers boot time and reduces
> > > > memory overhead.
> > > >
> > > > The kernel needs to know what memory has been accepted. Firmware
> > > > communicates this information via memory map: a new memory type --
> > > > EFI_UNACCEPTED_MEMORY -- indicates such memory.
> > > >
> > > > Range-based tracking works fine for firmware, but it gets bulky for
> > > > the kernel: e820 has to be modified on every page acceptance. It leads
> > > > to table fragmentation, but there's a limited number of entries in the
> > > > e820 table
> > > >
> > > > Another option is to mark such memory as usable in e820 and track if the
> > > > range has been accepted in a bitmap. One bit in the bitmap represents
> > > > 2MiB in the address space: one 4k page is enough to track 64GiB or
> > > > physical address space.
> > > >
> > > > In the worst-case scenario -- a huge hole in the middle of the
> > > > address space -- It needs 256MiB to handle 4PiB of the address
> > > > space.
> > > >
> > > > Any unaccepted memory that is not aligned to 2M gets accepted upfront.
> > > >
> > > > The approach lowers boot time substantially. Boot to shell is ~2.5x
> > > > faster for 4G TDX VM and ~4x faster for 64G.
> > > >
> > > > TDX-specific code isolated from the core of unaccepted memory support. It
> > > > supposed to help to plug-in different implementation of unaccepted memory
> > > > such as SEV-SNP.
> > > >
> > > > The tree can be found here:
> > > >
> > > > https://github.com/intel/tdx.git guest-unaccepted-memory
> > >
> > > Hi Kirill,
> > >
> > > I have a couple questions about this feature mainly about how cloud
> > > customers can use this, I assume since this is a confidential compute
> > > feature a large number of the users of these patches will be cloud
> > > customers using TDX and SNP. One issue I see with these patches is how
> > > do we as a cloud provider know whether a customer's linux image
> > > supports this feature, if the image doesn't have these patches UEFI
> > > needs to fully validate the memory, if the image does we can use this
> > > new protocol. In GCE we supply our VMs with a version of the EDK2 FW
> > > and the customer doesn't input into which UEFI we run, as far as I can
> > > tell from the Azure SNP VM documentation it seems very similar. We
> > > need to somehow tell our UEFI in the VM what to do based on the image.
> > > The current way I can see to solve this issue would be to have our
> > > customers give us metadata about their VM's image but this seems kinda
> > > burdensome on our customers (I assume we'll have more features which
> > > both UEFI and kernel need to both support inorder to be turned on like
> > > this one) and error-prone, if a customer incorrectly labels their
> > > image it may fail to boot.. Has there been any discussion about how to
> > > solve this? My naive thoughts were what if UEFI and Kernel had some
> > > sort of feature negotiation. Maybe that could happen via an extension
> > > to exit boot services or a UEFI runtime driver, I'm not sure what's
> > > best here just some ideas.
> >
> > Just as an idea, we can put info into UTS_VERSION which can be read from
> > the built bzImage. We have info on SMP and preeption there already.
> >
> 
> Instead of hacking this into the binary, couldn't we define a protocol
> that the kernel will call from the EFI stub (before EBS()) to identify
> itself as an image that understands unaccepted memory, and knows how
> to deal with it?
> 
> That way, the firmware can accept all the memory on behalf of the OS
> at ExitBootServices() time, unless the OS has indicated there is no
> need to do so.

I agree it would be better. But I think it would require change to EFI
spec, no?

-- 
 Kirill A. Shutemov
