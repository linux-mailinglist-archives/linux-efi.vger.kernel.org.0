Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF73255D703
	for <lists+linux-efi@lfdr.de>; Tue, 28 Jun 2022 15:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239469AbiF0QeI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 27 Jun 2022 12:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234722AbiF0QeH (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 27 Jun 2022 12:34:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE77DEA2;
        Mon, 27 Jun 2022 09:34:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 97040B818E1;
        Mon, 27 Jun 2022 16:34:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F12AC341CB;
        Mon, 27 Jun 2022 16:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656347643;
        bh=/SrPj904ouZSQFbqV4kyfH3imhY4twalKi5RBsFEDXg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hOiOupAlz0TGohr1zjOI5lFppGqzRMTEsnXwUTjo+AoOMM6Gpog71SfivxPwIX7NV
         iXB4scHnRb8F21nU9UWDw3UJPTycIN4itNmgWilRZJoxPN/ykb4KNUwBCASRz2g8B5
         ozEcRcl0G9O6t24gpWsacxQyuRb82ttrYlvzpT5chxphOl/fxEh/ZzLG6Iwp5yyJBa
         I6G7FBcxCOwrsgR4to3Kezu+lQsavJbnz+NbIJG4Iin/YGpbkXyITEBWjaEAY7wjGG
         zm3V3Dpkg2/z1CzyK/M+yUiv7tHtUQTptE2M+6o50uuxDkrnO+NPnVCHt0JoBNBozO
         Fy8qOM9M2nZGg==
Received: by mail-oi1-f177.google.com with SMTP id r82so4854036oig.2;
        Mon, 27 Jun 2022 09:34:03 -0700 (PDT)
X-Gm-Message-State: AJIora9EoGDfDF3q1tabo+eDjhUAKOGyv/WVxXd4k5vDJl2FQbpp1ZcL
        r4qSU9zPWeoOtiJRu2f8zSYBJJjIy4ozMqnIV6U=
X-Google-Smtp-Source: AGRyM1vx0evnQKAh1ZRdKNDvgSVxe65OJG5sTTVLkDoO84Dm1BfKlU9Oq5kS74fbNmzzvJd58LGrRlW4KWp06rIXVKM=
X-Received: by 2002:a05:6808:300e:b0:32c:425e:df34 with SMTP id
 ay14-20020a056808300e00b0032c425edf34mr8224110oib.126.1656347642388; Mon, 27
 Jun 2022 09:34:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
 <CAMkAt6osbEGBFrgn=y1=x4mDHC1aL40BwaW0NdGHF8qmWd7ktA@mail.gmail.com>
 <20220627113019.3q62luiay7izhehr@black.fi.intel.com> <CAMj1kXHD5XBAS1aBjzg1RCeK6qgtanUSED_xyTZ0v1j+UShMKw@mail.gmail.com>
 <20220627122230.7eetepoufd5w3lxd@black.fi.intel.com> <CAMkAt6oJJaRM_dy=y2BP99VziPriVuA4jAmMc=G7njwJYKFgyg@mail.gmail.com>
In-Reply-To: <CAMkAt6oJJaRM_dy=y2BP99VziPriVuA4jAmMc=G7njwJYKFgyg@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 27 Jun 2022 18:33:51 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHpS2B9Q7AaQ1euGidZUEyR6gfi=e+t1J_Cr8bmK_9mTw@mail.gmail.com>
Message-ID: <CAMj1kXHpS2B9Q7AaQ1euGidZUEyR6gfi=e+t1J_Cr8bmK_9mTw@mail.gmail.com>
Subject: Re: [PATCHv7 00/14] mm, x86/cc: Implement support for unaccepted memory
To:     Peter Gonda <pgonda@google.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
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
        tim.gardner@canonical.com,
        Khalid ElMously <khalid.elmously@canonical.com>,
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

On Mon, 27 Jun 2022 at 18:17, Peter Gonda <pgonda@google.com> wrote:
>
> On Mon, Jun 27, 2022 at 6:22 AM Kirill A. Shutemov
> <kirill.shutemov@linux.intel.com> wrote:
> >
> > On Mon, Jun 27, 2022 at 01:54:45PM +0200, Ard Biesheuvel wrote:
> > > On Mon, 27 Jun 2022 at 13:30, Kirill A. Shutemov
> > > <kirill.shutemov@linux.intel.com> wrote:
> > > >
> > > > On Fri, Jun 24, 2022 at 10:37:10AM -0600, Peter Gonda wrote:
> > > > > On Tue, Jun 14, 2022 at 6:03 AM Kirill A. Shutemov
> > > > > <kirill.shutemov@linux.intel.com> wrote:
> > > > > >
> > > > > > UEFI Specification version 2.9 introduces the concept of memory
> > > > > > acceptance: some Virtual Machine platforms, such as Intel TDX or AMD
> > > > > > SEV-SNP, requiring memory to be accepted before it can be used by the
> > > > > > guest. Accepting happens via a protocol specific for the Virtual
> > > > > > Machine platform.
> > > > > >
> > > > > > Accepting memory is costly and it makes VMM allocate memory for the
> > > > > > accepted guest physical address range. It's better to postpone memory
> > > > > > acceptance until memory is needed. It lowers boot time and reduces
> > > > > > memory overhead.
> > > > > >
> > > > > > The kernel needs to know what memory has been accepted. Firmware
> > > > > > communicates this information via memory map: a new memory type --
> > > > > > EFI_UNACCEPTED_MEMORY -- indicates such memory.
> > > > > >
> > > > > > Range-based tracking works fine for firmware, but it gets bulky for
> > > > > > the kernel: e820 has to be modified on every page acceptance. It leads
> > > > > > to table fragmentation, but there's a limited number of entries in the
> > > > > > e820 table
> > > > > >
> > > > > > Another option is to mark such memory as usable in e820 and track if the
> > > > > > range has been accepted in a bitmap. One bit in the bitmap represents
> > > > > > 2MiB in the address space: one 4k page is enough to track 64GiB or
> > > > > > physical address space.
> > > > > >
> > > > > > In the worst-case scenario -- a huge hole in the middle of the
> > > > > > address space -- It needs 256MiB to handle 4PiB of the address
> > > > > > space.
> > > > > >
> > > > > > Any unaccepted memory that is not aligned to 2M gets accepted upfront.
> > > > > >
> > > > > > The approach lowers boot time substantially. Boot to shell is ~2.5x
> > > > > > faster for 4G TDX VM and ~4x faster for 64G.
> > > > > >
> > > > > > TDX-specific code isolated from the core of unaccepted memory support. It
> > > > > > supposed to help to plug-in different implementation of unaccepted memory
> > > > > > such as SEV-SNP.
> > > > > >
> > > > > > The tree can be found here:
> > > > > >
> > > > > > https://github.com/intel/tdx.git guest-unaccepted-memory
> > > > >
> > > > > Hi Kirill,
> > > > >
> > > > > I have a couple questions about this feature mainly about how cloud
> > > > > customers can use this, I assume since this is a confidential compute
> > > > > feature a large number of the users of these patches will be cloud
> > > > > customers using TDX and SNP. One issue I see with these patches is how
> > > > > do we as a cloud provider know whether a customer's linux image
> > > > > supports this feature, if the image doesn't have these patches UEFI
> > > > > needs to fully validate the memory, if the image does we can use this
> > > > > new protocol. In GCE we supply our VMs with a version of the EDK2 FW
> > > > > and the customer doesn't input into which UEFI we run, as far as I can
> > > > > tell from the Azure SNP VM documentation it seems very similar. We
> > > > > need to somehow tell our UEFI in the VM what to do based on the image.
> > > > > The current way I can see to solve this issue would be to have our
> > > > > customers give us metadata about their VM's image but this seems kinda
> > > > > burdensome on our customers (I assume we'll have more features which
> > > > > both UEFI and kernel need to both support inorder to be turned on like
> > > > > this one) and error-prone, if a customer incorrectly labels their
> > > > > image it may fail to boot.. Has there been any discussion about how to
> > > > > solve this? My naive thoughts were what if UEFI and Kernel had some
> > > > > sort of feature negotiation. Maybe that could happen via an extension
> > > > > to exit boot services or a UEFI runtime driver, I'm not sure what's
> > > > > best here just some ideas.
> > > >
> > > > Just as an idea, we can put info into UTS_VERSION which can be read from
> > > > the built bzImage. We have info on SMP and preeption there already.
> > > >
> > >
> > > Instead of hacking this into the binary, couldn't we define a protocol
> > > that the kernel will call from the EFI stub (before EBS()) to identify
> > > itself as an image that understands unaccepted memory, and knows how
> > > to deal with it?
> > >
> > > That way, the firmware can accept all the memory on behalf of the OS
> > > at ExitBootServices() time, unless the OS has indicated there is no
> > > need to do so.
> >
> > I agree it would be better. But I think it would require change to EFI
> > spec, no?
>
> Could this somehow be amended on to the UEFI Specification version 2.9
> change which added all of the unaccepted memory features?
>

Why would this need a change in the EFI spec? Not every EFI protocol
needs to be in the spec.
