Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E32384161E3
	for <lists+linux-efi@lfdr.de>; Thu, 23 Sep 2021 17:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241927AbhIWPTS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 23 Sep 2021 11:19:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:59592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241807AbhIWPTR (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 23 Sep 2021 11:19:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 44A0E60F12;
        Thu, 23 Sep 2021 15:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632410266;
        bh=+LNh7lY5UZmTBvOhLwrn3p2agfdPid06GBrbSKCtbak=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rkuesZAysn26zeA2Q+g5fibFlDj176WFxwQsKYi/KGmv/42w40Q0VPlh4ZbU3v93E
         x0FyFkrHaWKkn5nHRYXHUgaefDz9mfX2EOGPlSiU7IgGHxiRylxzKtW40m/WFlfRl1
         I3a7OQR2NT+GMWeSKOBzvnQbFTrGmo8dXHFVsriseO9JfRiijMUsa5NmJMb3pz3Gcj
         24rxSF0wW9eio6FU0yKJgGsuZADGTOzoS4UjSEnaL98r4glfxr0q7kC427xC7rQEW8
         5WxR8bafn4I+/pR+9duDKkiLK1aSI5u1AErMkKUam9DPs9SkxYFPAOjr9rDx0g6Uyh
         1PqoBSZ2y59AQ==
Received: by mail-ed1-f43.google.com with SMTP id ee50so25053328edb.13;
        Thu, 23 Sep 2021 08:17:46 -0700 (PDT)
X-Gm-Message-State: AOAM532WzHI6F9meSea0E+IoS+vImCM41pJejNbaT3q7p0HprMJ3n7tE
        CbKcRs91OysAbsBxvXgeSp1GyW9WmesB6F53+A==
X-Google-Smtp-Source: ABdhPJwfrpCTxDMoj1U4WaIG3mMKEE967XX/SFBREZabwI5YQPoJ2Tw+kfS0jnCxbHvmYAgt//sZYtlLOhNGSLaKRI8=
X-Received: by 2002:a17:906:abd1:: with SMTP id kq17mr5421409ejb.390.1632410264662;
 Thu, 23 Sep 2021 08:17:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210906041424.115473-1-gshan@redhat.com> <CAL_JsqLccwTEhzonvdOOox+D6=3gHxbDbtsXTJpqtQfuxA4xvg@mail.gmail.com>
 <CAMj1kXFgnbuQzqf4rnpzn+Ez-sL3859q=1z_PkE1Mgd3SL19rA@mail.gmail.com> <197ced59-49b0-a981-6e04-96405164daba@redhat.com>
In-Reply-To: <197ced59-49b0-a981-6e04-96405164daba@redhat.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 23 Sep 2021 10:17:33 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLRH_Vn7u7b_yXgC=jBE8sZ2ax_yyueA3umbhQtbjW0TA@mail.gmail.com>
Message-ID: <CAL_JsqLRH_Vn7u7b_yXgC=jBE8sZ2ax_yyueA3umbhQtbjW0TA@mail.gmail.com>
Subject: Re: [PATCH] Documentation, dt, numa: Add note to empty NUMA node
To:     Gavin Shan <gshan@redhat.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        "open list:KERNEL VIRTUAL MACHINE FOR ARM64 (KVM/arm64)" 
        <kvmarm@lists.cs.columbia.edu>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrew Jones <drjones@redhat.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>, shan.gavin@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

 On Thu, Sep 23, 2021 at 1:32 AM Gavin Shan <gshan@redhat.com> wrote:
>
> Hi Rob and Ard,
>
> On 9/22/21 9:05 PM, Ard Biesheuvel wrote:
> > On Tue, 21 Sept 2021 at 21:45, Rob Herring <robh@kernel.org> wrote:
> >> On Sun, Sep 5, 2021 at 11:16 PM Gavin Shan <gshan@redhat.com> wrote:
> >>>
> >>> The empty memory nodes, where no memory resides in, are allowed.
> >>> For these empty memory nodes, the 'len' of 'reg' property is zero.
> >>> The NUMA node IDs are still valid and parsed, but memory may be
> >>> added to them through hotplug afterwards. Currently, QEMU fails
> >>> to boot when multiple empty memory nodes are specified. It's
> >>> caused by device-tree population failure and duplicated memory
> >>> node names.
> >
> > Those memory regions are known in advance, right? So wouldn't it be
> > better to use something like 'status = "disabled"' here?
> >
>
> Yes, these memory regions are known in advance. For the empty nodes,
> their 'len' property is zero and it's equal to disabled state.
>
> >>
> >> I still don't like the fake addresses. I can't really give suggestions
> >> on alternative ways to fix this with you just presenting a solution.
> >>
> >
> > Agreed. Please try to explain what the problem is, and why this is the
> > best way to solve it. Please include other solutions that were
> > considered and rejected if any exist.
> >
> >> What is the failure you see? Can we relax the kernel's expectations?
> >> What about UEFI boot as the memory nodes aren't used (or maybe they
> >> are for NUMA?) How does this work with ACPI?
> >>
> >
> > The EFI memory map only needs to describe the memory that was present
> > at boot. More memory can be represented as ACPI objects, including
> > coldplugged memory that is already present at boot. None of this
> > involves the memory nodes in DT.
> >
>
> I'm using the following command line to start a virtual machine (VM).
> There are 4 NUMA nodes specified, but the last two are empty. In QEMU,
> the device-tree nodes are populated to represent these 4 NUMA nodes.
> Unfortunately, QEMU fails to start because of the conflicting names
> for the empty node are found, as the following error message indicates.
>
>     /home/gavin/sandbox/qemu.main/build/qemu-system-aarch64        \
>     -accel kvm -machine virt,gic-version=host                      \
>     -cpu host -smp 4,sockets=2,cores=2,threads=1                   \
>     -m 1024M,slots=16,maxmem=64G                                   \
>     -object memory-backend-ram,id=mem0,size=512M                   \
>     -object memory-backend-ram,id=mem1,size=512M                   \
>     -numa node,nodeid=0,cpus=0-1,memdev=mem0                       \
>     -numa node,nodeid=1,cpus=2-3,memdev=mem1                       \
>     -numa node,nodeid=2                                            \
>     -numa node,nodeid=3                                            \
>       :
>     -device virtio-balloon-pci,id=balloon0,free-page-reporting=yes
>       :
>       :
>     qemu-system-aarch64: FDT: Failed to create subnode /memory@80000000: FDT_ERR_EXISTS
>
> According to device-tree specification, the memory device-tree node's
> name is following the format 'memory@base-address'. For the empty
> NUMA nodes, their base addresses aren't determined. The device-tree
> specification doesn't indicate what 'base-address' should be assigned
> for the empty nodes. So I proposed this patch because I think the
> linux device-tree binding documentation is best place to get this
> documented.

Why even create the node?

What does IBM pSeries do here. AIUI, those platforms create/remove
nodes for hotplug. That's the reason CONFIG_OF_DYNAMIC existed
originally. Unfortunately, that's the extent of my knowledge on that.

> ACPI is different story. The NUMA nodes are represented by SRAT
> (System Resource Affinity Table). In the above example, there are
> 4 SRATs. We needn't assign names to the tables and we don't have
> the conflicting names as we do in device-tree case.
>
> By the way, QEMU currently prevents to expose SRATs for empty NUMA
> nodes. I need submit QEMU patch to break the limitation in future.
> With the limitation, the hot-added memory is always put into the
> last NUMA node and it's not exactly customer wants.
>
> >>> As device-tree specification indicates, the 'unit-address' of
> >>> these empty memory nodes, part of their names, are the equivalents
> >>> to 'base-address'. Unfortunately, I finds difficulty to get where
> >>> the assignment of 'base-address' is properly documented for these
> >>> empty memory nodes. So lets add a section for empty memory nodes
> >>> to cover this in NUMA binding document. The 'unit-address',
> >>> equivalent to 'base-address' in the 'reg' property of these empty
> >>> memory nodes is specified to be the summation of highest memory
> >>> address plus the NUMA node ID.
> >>>
> >>> Signed-off-by: Gavin Shan <gshan@redhat.com>
> >>> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> >>> ---
> >>>   Documentation/devicetree/bindings/numa.txt | 60 +++++++++++++++++++++-
> >>>   1 file changed, 59 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/numa.txt b/Documentation/devicetree/bindings/numa.txt
> >>> index 21b35053ca5a..82f047bc8dd6 100644
> >>> --- a/Documentation/devicetree/bindings/numa.txt
> >>> +++ b/Documentation/devicetree/bindings/numa.txt
> >>> @@ -103,7 +103,65 @@ Example:
> >>>                  };
> >>>
> >>>   ==============================================================================
> >>> -4 - Example dts
> >>> +4 - Empty memory nodes
> >>> +==============================================================================
> >>> +
> >>> +Empty memory nodes, which no memory resides in, are allowed. The 'length'
> >>> +field of the 'reg' property is zero. However, the 'base-address' is a
> >>> +dummy and invalid address, which is the summation of highest memory address
> >>> +plus the NUMA node ID. The NUMA node IDs and distance maps are still valid
> >>> +and memory may be added into them through hotplug afterwards.
> >>> +
> >>> +Example:
> >>> +
> >>> +       memory@0 {
> >>> +               device_type = "memory";
> >>> +               reg = <0x0 0x0 0x0 0x80000000>;
> >>> +               numa-node-id = <0>;
> >>> +       };
> >>> +
> >>> +       memory@80000000 {
> >>> +               device_type = "memory";
> >>> +               reg = <0x0 0x80000000 0x0 0x80000000>;
> >>> +               numa-node-id = <1>;
> >>> +       };
> >>> +
> >>> +       /* Empty memory node */
> >>> +       memory@100000002 {
> >>> +               device_type = "memory";
> >>> +               reg = <0x1 0x2 0x0 0x0>;
> >>> +               numa-node-id = <2>;
> >>> +       };
> >>> +
> >>> +       /* Empty memory node */
> >>> +       memory@100000003 {
> >>> +               device_type = "memory";
> >>> +               reg = <0x1 0x3 0x0 0x0>;
> >>> +               numa-node-id = <3>;
> >>> +       };
> >>
> >> Do you really need the memory nodes here or just some way to define
> >> numa node id's 2 and 3 as valid?
> >>
>
> It's the way to define NUMA node IDs are valid. Besides, the 'reg'
> property provides 'base-address', which is part of the device-tree
> node's name, as described in this patch.

The distance-matrix already lists all possible NUMA node IDs. That
should be enough information for the kernel. If not, fix the kernel.

Rob
