Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99F3F55C382
	for <lists+linux-efi@lfdr.de>; Tue, 28 Jun 2022 14:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239162AbiF0QRt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 27 Jun 2022 12:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239094AbiF0QRp (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 27 Jun 2022 12:17:45 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA2B18B2D
        for <linux-efi@vger.kernel.org>; Mon, 27 Jun 2022 09:17:44 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id b23so11589448ljh.7
        for <linux-efi@vger.kernel.org>; Mon, 27 Jun 2022 09:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IFCSeMWa9h9GX5PoDNQOnkciA1SMKLpehV1m9QrYxug=;
        b=sH054xMJMWAdWEQgNnIeDaI9aRGZam9yTrCSC25x7I92aDv5SqHaKk2Pa/VnQl6gP8
         hmPPwdPRdI8pGMC2ajGI6dabju8PRmFnla72eH4OnSDS7NdJPkHGiisBfiQhOjy5Td8W
         pm4/RzsdVvsQSvTAuuEfcwpjZ2OYiAktQ3UQdLwHQDXnhM7LKdBCw9UMSNb3QWHNePTz
         Lyupfd+C7UYPCqWan8PIhebM/OHO4oPumZBBNR5lCH42XHcSSZtpzwSradM39VjliALk
         3krX/fpzeDB9di9ABbqT2rYyoHgIVw1dMN5fcFbki3C117cxcMnLwDZPPexy3vygsRVv
         ED3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IFCSeMWa9h9GX5PoDNQOnkciA1SMKLpehV1m9QrYxug=;
        b=iwQtRKL6tIzdxxlNwZL95iqIyaPKHVAvhKK5GXUZh8sIQ+fUJ5BC7+ad3KlJwybPSI
         bupFVmW2tTmF7ZfPzOzG9I6lHc0XFqLPRgJcIt4JXWFw6MqCVGAE2d6F5vwpBVAh3VvU
         SI3fhPJSlClNxschgHIWiKutPsLPqgDXzkIiwOc6Zw5bwN5iJb4f0s3ll9SFFnaS8sQc
         h+VAjD083CCLO0SeFebOGrti1tjXJxPEuCe6vHDF+ft6eJY4gDI+coPMQ/O//7ECiu0M
         6RIgM4RE4yCYlkNyNIpalD5ZlbzM1C0MoVgY0H7+B5wvGPlYB2w+HesNkhsHlNOezRzT
         3LPw==
X-Gm-Message-State: AJIora8tXMyRgJaDDavdnc4N9NvIeRY1XicAaqE9Cl/XKEZfeniTnHW/
        ofdvcjfE4DfLrDjJwrOmX2J9V+L/6z0pR8ImTsg0+Q==
X-Google-Smtp-Source: AGRyM1vc1fb6tmRtoRk2eM/MqjNyTJsbg6uxDwz3tmaaoZLLhGU4yZSRiGKND6kPOWF/35tdb79NK/jTJhNQx6rZTQc=
X-Received: by 2002:a2e:1f01:0:b0:25a:5960:3c39 with SMTP id
 f1-20020a2e1f01000000b0025a59603c39mr7162503ljf.282.1656346662295; Mon, 27
 Jun 2022 09:17:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
 <CAMkAt6osbEGBFrgn=y1=x4mDHC1aL40BwaW0NdGHF8qmWd7ktA@mail.gmail.com>
 <20220627113019.3q62luiay7izhehr@black.fi.intel.com> <CAMj1kXHD5XBAS1aBjzg1RCeK6qgtanUSED_xyTZ0v1j+UShMKw@mail.gmail.com>
 <20220627122230.7eetepoufd5w3lxd@black.fi.intel.com>
In-Reply-To: <20220627122230.7eetepoufd5w3lxd@black.fi.intel.com>
From:   Peter Gonda <pgonda@google.com>
Date:   Mon, 27 Jun 2022 10:17:30 -0600
Message-ID: <CAMkAt6oJJaRM_dy=y2BP99VziPriVuA4jAmMc=G7njwJYKFgyg@mail.gmail.com>
Subject: Re: [PATCHv7 00/14] mm, x86/cc: Implement support for unaccepted memory
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>,
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
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Jun 27, 2022 at 6:22 AM Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> On Mon, Jun 27, 2022 at 01:54:45PM +0200, Ard Biesheuvel wrote:
> > On Mon, 27 Jun 2022 at 13:30, Kirill A. Shutemov
> > <kirill.shutemov@linux.intel.com> wrote:
> > >
> > > On Fri, Jun 24, 2022 at 10:37:10AM -0600, Peter Gonda wrote:
> > > > On Tue, Jun 14, 2022 at 6:03 AM Kirill A. Shutemov
> > > > <kirill.shutemov@linux.intel.com> wrote:
> > > > >
> > > > > UEFI Specification version 2.9 introduces the concept of memory
> > > > > acceptance: some Virtual Machine platforms, such as Intel TDX or AMD
> > > > > SEV-SNP, requiring memory to be accepted before it can be used by the
> > > > > guest. Accepting happens via a protocol specific for the Virtual
> > > > > Machine platform.
> > > > >
> > > > > Accepting memory is costly and it makes VMM allocate memory for the
> > > > > accepted guest physical address range. It's better to postpone memory
> > > > > acceptance until memory is needed. It lowers boot time and reduces
> > > > > memory overhead.
> > > > >
> > > > > The kernel needs to know what memory has been accepted. Firmware
> > > > > communicates this information via memory map: a new memory type --
> > > > > EFI_UNACCEPTED_MEMORY -- indicates such memory.
> > > > >
> > > > > Range-based tracking works fine for firmware, but it gets bulky for
> > > > > the kernel: e820 has to be modified on every page acceptance. It leads
> > > > > to table fragmentation, but there's a limited number of entries in the
> > > > > e820 table
> > > > >
> > > > > Another option is to mark such memory as usable in e820 and track if the
> > > > > range has been accepted in a bitmap. One bit in the bitmap represents
> > > > > 2MiB in the address space: one 4k page is enough to track 64GiB or
> > > > > physical address space.
> > > > >
> > > > > In the worst-case scenario -- a huge hole in the middle of the
> > > > > address space -- It needs 256MiB to handle 4PiB of the address
> > > > > space.
> > > > >
> > > > > Any unaccepted memory that is not aligned to 2M gets accepted upfront.
> > > > >
> > > > > The approach lowers boot time substantially. Boot to shell is ~2.5x
> > > > > faster for 4G TDX VM and ~4x faster for 64G.
> > > > >
> > > > > TDX-specific code isolated from the core of unaccepted memory support. It
> > > > > supposed to help to plug-in different implementation of unaccepted memory
> > > > > such as SEV-SNP.
> > > > >
> > > > > The tree can be found here:
> > > > >
> > > > > https://github.com/intel/tdx.git guest-unaccepted-memory
> > > >
> > > > Hi Kirill,
> > > >
> > > > I have a couple questions about this feature mainly about how cloud
> > > > customers can use this, I assume since this is a confidential compute
> > > > feature a large number of the users of these patches will be cloud
> > > > customers using TDX and SNP. One issue I see with these patches is how
> > > > do we as a cloud provider know whether a customer's linux image
> > > > supports this feature, if the image doesn't have these patches UEFI
> > > > needs to fully validate the memory, if the image does we can use this
> > > > new protocol. In GCE we supply our VMs with a version of the EDK2 FW
> > > > and the customer doesn't input into which UEFI we run, as far as I can
> > > > tell from the Azure SNP VM documentation it seems very similar. We
> > > > need to somehow tell our UEFI in the VM what to do based on the image.
> > > > The current way I can see to solve this issue would be to have our
> > > > customers give us metadata about their VM's image but this seems kinda
> > > > burdensome on our customers (I assume we'll have more features which
> > > > both UEFI and kernel need to both support inorder to be turned on like
> > > > this one) and error-prone, if a customer incorrectly labels their
> > > > image it may fail to boot.. Has there been any discussion about how to
> > > > solve this? My naive thoughts were what if UEFI and Kernel had some
> > > > sort of feature negotiation. Maybe that could happen via an extension
> > > > to exit boot services or a UEFI runtime driver, I'm not sure what's
> > > > best here just some ideas.
> > >
> > > Just as an idea, we can put info into UTS_VERSION which can be read from
> > > the built bzImage. We have info on SMP and preeption there already.
> > >
> >
> > Instead of hacking this into the binary, couldn't we define a protocol
> > that the kernel will call from the EFI stub (before EBS()) to identify
> > itself as an image that understands unaccepted memory, and knows how
> > to deal with it?
> >
> > That way, the firmware can accept all the memory on behalf of the OS
> > at ExitBootServices() time, unless the OS has indicated there is no
> > need to do so.
>
> I agree it would be better. But I think it would require change to EFI
> spec, no?

Could this somehow be amended on to the UEFI Specification version 2.9
change which added all of the unaccepted memory features?

>
> --
>  Kirill A. Shutemov
