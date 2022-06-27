Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01C5C55D6BA
	for <lists+linux-efi@lfdr.de>; Tue, 28 Jun 2022 15:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239211AbiF0L7J (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 27 Jun 2022 07:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239740AbiF0L6F (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 27 Jun 2022 07:58:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39396DFC3;
        Mon, 27 Jun 2022 04:54:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C5DAE614AD;
        Mon, 27 Jun 2022 11:54:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CDA7C341C8;
        Mon, 27 Jun 2022 11:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656330897;
        bh=XEdbP8hqb+/krqVBOaT/MtmmlBAa4vhY3AGwXhq3CUU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=raV+9ibzVQrQsVRCFNZJTJvkTNhqnBTxPavBWkUWR75o1LO+7C5F1+UCJAWMWymD+
         L799rsTEKaDMIn8QFOdIWF7SrGFdi3n4hc5Hpez7TKBpl/ZB1JO2NuRImH6Nx15VXm
         Z18J4VhQboOaxZZMLCXhc/PRVmoYpcC12LWE8cI1vV1iw4E0DVEFT995c2ETzRpc/w
         9VbMu25zUWB3Jhm/W5D8swGGZYg73jyQIW6cY6NsccmxS+jSlnbO2Js4L2tFHTrbZI
         qUf9ZpES5UE4W3IQezAHox+aYrwT0Z5jYjh54fciLUA0G/En4O14oVn7ZZcCGE4xz6
         J4YopxXvzoK7w==
Received: by mail-oi1-f173.google.com with SMTP id l81so12465050oif.9;
        Mon, 27 Jun 2022 04:54:57 -0700 (PDT)
X-Gm-Message-State: AJIora+EjdVGZ0BcheXccTiD6A0f3qDg3C9WisrsiF/+hOylaqUZQ0P5
        ZD5kKK3o2jE/CCz5m+0KaDoogyrZb4zBFyaBBn4=
X-Google-Smtp-Source: AGRyM1tMfijM2yOVlQBNkgcCYnDOR346PAX9FQZZ0R34sh1Dal8EtaYPD5OTZaPXjnnpvmXr0e45xYZePPKh/BQG9Uc=
X-Received: by 2002:a05:6808:13c6:b0:335:3e54:94bc with SMTP id
 d6-20020a05680813c600b003353e5494bcmr9612504oiw.228.1656330896263; Mon, 27
 Jun 2022 04:54:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
 <CAMkAt6osbEGBFrgn=y1=x4mDHC1aL40BwaW0NdGHF8qmWd7ktA@mail.gmail.com> <20220627113019.3q62luiay7izhehr@black.fi.intel.com>
In-Reply-To: <20220627113019.3q62luiay7izhehr@black.fi.intel.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 27 Jun 2022 13:54:45 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHD5XBAS1aBjzg1RCeK6qgtanUSED_xyTZ0v1j+UShMKw@mail.gmail.com>
Message-ID: <CAMj1kXHD5XBAS1aBjzg1RCeK6qgtanUSED_xyTZ0v1j+UShMKw@mail.gmail.com>
Subject: Re: [PATCHv7 00/14] mm, x86/cc: Implement support for unaccepted memory
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
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
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-coco@lists.linux.dev, linux-efi <linux-efi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 27 Jun 2022 at 13:30, Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> On Fri, Jun 24, 2022 at 10:37:10AM -0600, Peter Gonda wrote:
> > On Tue, Jun 14, 2022 at 6:03 AM Kirill A. Shutemov
> > <kirill.shutemov@linux.intel.com> wrote:
> > >
> > > UEFI Specification version 2.9 introduces the concept of memory
> > > acceptance: some Virtual Machine platforms, such as Intel TDX or AMD
> > > SEV-SNP, requiring memory to be accepted before it can be used by the
> > > guest. Accepting happens via a protocol specific for the Virtual
> > > Machine platform.
> > >
> > > Accepting memory is costly and it makes VMM allocate memory for the
> > > accepted guest physical address range. It's better to postpone memory
> > > acceptance until memory is needed. It lowers boot time and reduces
> > > memory overhead.
> > >
> > > The kernel needs to know what memory has been accepted. Firmware
> > > communicates this information via memory map: a new memory type --
> > > EFI_UNACCEPTED_MEMORY -- indicates such memory.
> > >
> > > Range-based tracking works fine for firmware, but it gets bulky for
> > > the kernel: e820 has to be modified on every page acceptance. It leads
> > > to table fragmentation, but there's a limited number of entries in the
> > > e820 table
> > >
> > > Another option is to mark such memory as usable in e820 and track if the
> > > range has been accepted in a bitmap. One bit in the bitmap represents
> > > 2MiB in the address space: one 4k page is enough to track 64GiB or
> > > physical address space.
> > >
> > > In the worst-case scenario -- a huge hole in the middle of the
> > > address space -- It needs 256MiB to handle 4PiB of the address
> > > space.
> > >
> > > Any unaccepted memory that is not aligned to 2M gets accepted upfront.
> > >
> > > The approach lowers boot time substantially. Boot to shell is ~2.5x
> > > faster for 4G TDX VM and ~4x faster for 64G.
> > >
> > > TDX-specific code isolated from the core of unaccepted memory support. It
> > > supposed to help to plug-in different implementation of unaccepted memory
> > > such as SEV-SNP.
> > >
> > > The tree can be found here:
> > >
> > > https://github.com/intel/tdx.git guest-unaccepted-memory
> >
> > Hi Kirill,
> >
> > I have a couple questions about this feature mainly about how cloud
> > customers can use this, I assume since this is a confidential compute
> > feature a large number of the users of these patches will be cloud
> > customers using TDX and SNP. One issue I see with these patches is how
> > do we as a cloud provider know whether a customer's linux image
> > supports this feature, if the image doesn't have these patches UEFI
> > needs to fully validate the memory, if the image does we can use this
> > new protocol. In GCE we supply our VMs with a version of the EDK2 FW
> > and the customer doesn't input into which UEFI we run, as far as I can
> > tell from the Azure SNP VM documentation it seems very similar. We
> > need to somehow tell our UEFI in the VM what to do based on the image.
> > The current way I can see to solve this issue would be to have our
> > customers give us metadata about their VM's image but this seems kinda
> > burdensome on our customers (I assume we'll have more features which
> > both UEFI and kernel need to both support inorder to be turned on like
> > this one) and error-prone, if a customer incorrectly labels their
> > image it may fail to boot.. Has there been any discussion about how to
> > solve this? My naive thoughts were what if UEFI and Kernel had some
> > sort of feature negotiation. Maybe that could happen via an extension
> > to exit boot services or a UEFI runtime driver, I'm not sure what's
> > best here just some ideas.
>
> Just as an idea, we can put info into UTS_VERSION which can be read from
> the built bzImage. We have info on SMP and preeption there already.
>

Instead of hacking this into the binary, couldn't we define a protocol
that the kernel will call from the EFI stub (before EBS()) to identify
itself as an image that understands unaccepted memory, and knows how
to deal with it?

That way, the firmware can accept all the memory on behalf of the OS
at ExitBootServices() time, unless the OS has indicated there is no
need to do so.




> Patch below does this:
>
> $ file arch/x86/boot/bzImage
> arch/x86/boot/bzImage: Linux kernel x86 boot executable bzImage, version 5.19.0-rc3-00016-g2f6aa48e28d9-dirty (kas@box) #2300 SMP PREEMPT_DYNAMIC UNACCEPTED_MEMORY Mon Jun 27 14:23:04 , RO-rootFS, swap_dev 0XC, Normal VGA
>
> Note UNACCEPTED_MEMORY in the output.
>
> Probably we want to have there info on which flavour of unaccepted memory
> is supported (TDX/SNP/whatever). It is a bit more tricky.
>
> Any opinion?
>
> diff --git a/init/Makefile b/init/Makefile
> index d82623d7fc8e..6688ea43e6bf 100644
> --- a/init/Makefile
> +++ b/init/Makefile
> @@ -32,7 +32,7 @@ quiet_cmd_compile.h = CHK     $@
>         $(CONFIG_SHELL) $(srctree)/scripts/mkcompile_h $@       \
>         "$(UTS_MACHINE)" "$(CONFIG_SMP)" "$(CONFIG_PREEMPT_BUILD)"      \
>         "$(CONFIG_PREEMPT_DYNAMIC)" "$(CONFIG_PREEMPT_RT)" \
> -       "$(CONFIG_CC_VERSION_TEXT)" "$(LD)"
> +       "$(CONFIG_UNACCEPTED_MEMORY)" "$(CONFIG_CC_VERSION_TEXT)" "$(LD)"
>
>  include/generated/compile.h: FORCE
>         $(call cmd,compile.h)
> diff --git a/scripts/mkcompile_h b/scripts/mkcompile_h
> index ca40a5258c87..efacfecad699 100755
> --- a/scripts/mkcompile_h
> +++ b/scripts/mkcompile_h
> @@ -7,8 +7,9 @@ SMP=$3
>  PREEMPT=$4
>  PREEMPT_DYNAMIC=$5
>  PREEMPT_RT=$6
> -CC_VERSION="$7"
> -LD=$8
> +UNACCEPTED_MEMORY=$7
> +CC_VERSION="$8"
> +LD=$9
>
>  # Do not expand names
>  set -f
> @@ -51,6 +52,10 @@ elif [ -n "$PREEMPT" ] ; then
>         CONFIG_FLAGS="$CONFIG_FLAGS PREEMPT"
>  fi
>
> +if [ -n "$UNACCEPTED_MEMORY" ] ; then
> +       CONFIG_FLAGS="$CONFIG_FLAGS UNACCEPTED_MEMORY"
> +fi
> +
>  # Truncate to maximum length
>  UTS_LEN=64
>  UTS_VERSION="$(echo $UTS_VERSION $CONFIG_FLAGS $TIMESTAMP | cut -b -$UTS_LEN)"
> --
>  Kirill A. Shutemov
