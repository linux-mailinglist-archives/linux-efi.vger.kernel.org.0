Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4603A55E1D5
	for <lists+linux-efi@lfdr.de>; Tue, 28 Jun 2022 15:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234514AbiF0Ldr (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 27 Jun 2022 07:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236139AbiF0LdS (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 27 Jun 2022 07:33:18 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E13CBF68;
        Mon, 27 Jun 2022 04:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656329422; x=1687865422;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=O/C94ZB/s6G9BRryYo+Qz3Y2uZ2+Yo0+K1mSVtuIqz8=;
  b=GoQhvd/vnnanULk14E/nPoQuQfmKn2BvtLFPVhVvjQUgraW+S9ZYDILp
   fTloZ6l8TsVywLZPmSEnmhUR9TK3VLDWKFlXPWUiaBVXVf2wVsKfmkAC7
   MArFRZoIx/MH4lHt/+dOEbJhcyqCbXRziWTnKd+UdMJ2/mkhSna3iRrVI
   Ai1KUJ3Qxp6Ld6RRw3Oz8shlhQDL5AGCQwKbagAnAsXCBiZrPhPZjjZN5
   lq5sCDY+kKPpLAQO12XccJD+5rINYoZDpvoHH8uuYCgrjdcl1U9bz0e5Q
   TZeaQLdZekXGQpEfeV9yDn5kzWp9LP6dW+1stsoaLZlAd+JTkEkWoGrq7
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10390"; a="282161563"
X-IronPort-AV: E=Sophos;i="5.92,226,1650956400"; 
   d="scan'208";a="282161563"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 04:30:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,226,1650956400"; 
   d="scan'208";a="916678660"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 27 Jun 2022 04:30:14 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 1C5F7D9; Mon, 27 Jun 2022 14:30:19 +0300 (EEST)
Date:   Mon, 27 Jun 2022 14:30:19 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Peter Gonda <pgonda@google.com>
Cc:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
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
        Dave Hansen <dave.hansen@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        the arch/x86 maintainers <x86@kernel.org>,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv7 00/14] mm, x86/cc: Implement support for unaccepted
 memory
Message-ID: <20220627113019.3q62luiay7izhehr@black.fi.intel.com>
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
 <CAMkAt6osbEGBFrgn=y1=x4mDHC1aL40BwaW0NdGHF8qmWd7ktA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMkAt6osbEGBFrgn=y1=x4mDHC1aL40BwaW0NdGHF8qmWd7ktA@mail.gmail.com>
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jun 24, 2022 at 10:37:10AM -0600, Peter Gonda wrote:
> On Tue, Jun 14, 2022 at 6:03 AM Kirill A. Shutemov
> <kirill.shutemov@linux.intel.com> wrote:
> >
> > UEFI Specification version 2.9 introduces the concept of memory
> > acceptance: some Virtual Machine platforms, such as Intel TDX or AMD
> > SEV-SNP, requiring memory to be accepted before it can be used by the
> > guest. Accepting happens via a protocol specific for the Virtual
> > Machine platform.
> >
> > Accepting memory is costly and it makes VMM allocate memory for the
> > accepted guest physical address range. It's better to postpone memory
> > acceptance until memory is needed. It lowers boot time and reduces
> > memory overhead.
> >
> > The kernel needs to know what memory has been accepted. Firmware
> > communicates this information via memory map: a new memory type --
> > EFI_UNACCEPTED_MEMORY -- indicates such memory.
> >
> > Range-based tracking works fine for firmware, but it gets bulky for
> > the kernel: e820 has to be modified on every page acceptance. It leads
> > to table fragmentation, but there's a limited number of entries in the
> > e820 table
> >
> > Another option is to mark such memory as usable in e820 and track if the
> > range has been accepted in a bitmap. One bit in the bitmap represents
> > 2MiB in the address space: one 4k page is enough to track 64GiB or
> > physical address space.
> >
> > In the worst-case scenario -- a huge hole in the middle of the
> > address space -- It needs 256MiB to handle 4PiB of the address
> > space.
> >
> > Any unaccepted memory that is not aligned to 2M gets accepted upfront.
> >
> > The approach lowers boot time substantially. Boot to shell is ~2.5x
> > faster for 4G TDX VM and ~4x faster for 64G.
> >
> > TDX-specific code isolated from the core of unaccepted memory support. It
> > supposed to help to plug-in different implementation of unaccepted memory
> > such as SEV-SNP.
> >
> > The tree can be found here:
> >
> > https://github.com/intel/tdx.git guest-unaccepted-memory
> 
> Hi Kirill,
> 
> I have a couple questions about this feature mainly about how cloud
> customers can use this, I assume since this is a confidential compute
> feature a large number of the users of these patches will be cloud
> customers using TDX and SNP. One issue I see with these patches is how
> do we as a cloud provider know whether a customer's linux image
> supports this feature, if the image doesn't have these patches UEFI
> needs to fully validate the memory, if the image does we can use this
> new protocol. In GCE we supply our VMs with a version of the EDK2 FW
> and the customer doesn't input into which UEFI we run, as far as I can
> tell from the Azure SNP VM documentation it seems very similar. We
> need to somehow tell our UEFI in the VM what to do based on the image.
> The current way I can see to solve this issue would be to have our
> customers give us metadata about their VM's image but this seems kinda
> burdensome on our customers (I assume we'll have more features which
> both UEFI and kernel need to both support inorder to be turned on like
> this one) and error-prone, if a customer incorrectly labels their
> image it may fail to boot.. Has there been any discussion about how to
> solve this? My naive thoughts were what if UEFI and Kernel had some
> sort of feature negotiation. Maybe that could happen via an extension
> to exit boot services or a UEFI runtime driver, I'm not sure what's
> best here just some ideas.

Just as an idea, we can put info into UTS_VERSION which can be read from
the built bzImage. We have info on SMP and preeption there already.

Patch below does this:

$ file arch/x86/boot/bzImage
arch/x86/boot/bzImage: Linux kernel x86 boot executable bzImage, version 5.19.0-rc3-00016-g2f6aa48e28d9-dirty (kas@box) #2300 SMP PREEMPT_DYNAMIC UNACCEPTED_MEMORY Mon Jun 27 14:23:04 , RO-rootFS, swap_dev 0XC, Normal VGA

Note UNACCEPTED_MEMORY in the output.

Probably we want to have there info on which flavour of unaccepted memory
is supported (TDX/SNP/whatever). It is a bit more tricky.

Any opinion?

diff --git a/init/Makefile b/init/Makefile
index d82623d7fc8e..6688ea43e6bf 100644
--- a/init/Makefile
+++ b/init/Makefile
@@ -32,7 +32,7 @@ quiet_cmd_compile.h = CHK     $@
 	$(CONFIG_SHELL) $(srctree)/scripts/mkcompile_h $@	\
 	"$(UTS_MACHINE)" "$(CONFIG_SMP)" "$(CONFIG_PREEMPT_BUILD)"	\
 	"$(CONFIG_PREEMPT_DYNAMIC)" "$(CONFIG_PREEMPT_RT)" \
-	"$(CONFIG_CC_VERSION_TEXT)" "$(LD)"
+	"$(CONFIG_UNACCEPTED_MEMORY)" "$(CONFIG_CC_VERSION_TEXT)" "$(LD)"

 include/generated/compile.h: FORCE
 	$(call cmd,compile.h)
diff --git a/scripts/mkcompile_h b/scripts/mkcompile_h
index ca40a5258c87..efacfecad699 100755
--- a/scripts/mkcompile_h
+++ b/scripts/mkcompile_h
@@ -7,8 +7,9 @@ SMP=$3
 PREEMPT=$4
 PREEMPT_DYNAMIC=$5
 PREEMPT_RT=$6
-CC_VERSION="$7"
-LD=$8
+UNACCEPTED_MEMORY=$7
+CC_VERSION="$8"
+LD=$9

 # Do not expand names
 set -f
@@ -51,6 +52,10 @@ elif [ -n "$PREEMPT" ] ; then
 	CONFIG_FLAGS="$CONFIG_FLAGS PREEMPT"
 fi

+if [ -n "$UNACCEPTED_MEMORY" ] ; then
+	CONFIG_FLAGS="$CONFIG_FLAGS UNACCEPTED_MEMORY"
+fi
+
 # Truncate to maximum length
 UTS_LEN=64
 UTS_VERSION="$(echo $UTS_VERSION $CONFIG_FLAGS $TIMESTAMP | cut -b -$UTS_LEN)"
-- 
 Kirill A. Shutemov
