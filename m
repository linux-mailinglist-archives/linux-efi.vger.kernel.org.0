Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF5541583F
	for <lists+linux-efi@lfdr.de>; Thu, 23 Sep 2021 08:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239338AbhIWGeQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 23 Sep 2021 02:34:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26557 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239334AbhIWGeP (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 23 Sep 2021 02:34:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632378764;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wer52oLwmCEPNBpGXyNvVz16UMTo82CYLIugW7yIubM=;
        b=HsQA66tieZe4h4ZXCvrEl0QIKy67WTASKOalzpfKjxd0kr1ytaD9rbE3+PztjgLVZAFWZE
        H8M+UEiW18MGa83XGo810dlf1BtbTJYimoz7xT35YxncgOSCsx+f3zlDngg9R44RmVWeL5
        SU1ye+buZ+3wDhVWjBByrSGQFlNjV0A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-110-BmEi1nl_N_yJzfc01GfzhQ-1; Thu, 23 Sep 2021 02:32:40 -0400
X-MC-Unique: BmEi1nl_N_yJzfc01GfzhQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E57CB801B3D;
        Thu, 23 Sep 2021 06:32:38 +0000 (UTC)
Received: from [10.64.54.113] (vpn2-54-113.bne.redhat.com [10.64.54.113])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B54E86CA20;
        Thu, 23 Sep 2021 06:32:32 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH] Documentation, dt, numa: Add note to empty NUMA node
To:     Ard Biesheuvel <ardb@kernel.org>, Rob Herring <robh@kernel.org>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
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
References: <20210906041424.115473-1-gshan@redhat.com>
 <CAL_JsqLccwTEhzonvdOOox+D6=3gHxbDbtsXTJpqtQfuxA4xvg@mail.gmail.com>
 <CAMj1kXFgnbuQzqf4rnpzn+Ez-sL3859q=1z_PkE1Mgd3SL19rA@mail.gmail.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <197ced59-49b0-a981-6e04-96405164daba@redhat.com>
Date:   Thu, 23 Sep 2021 16:32:29 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <CAMj1kXFgnbuQzqf4rnpzn+Ez-sL3859q=1z_PkE1Mgd3SL19rA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Rob and Ard,

On 9/22/21 9:05 PM, Ard Biesheuvel wrote:
> On Tue, 21 Sept 2021 at 21:45, Rob Herring <robh@kernel.org> wrote:
>> On Sun, Sep 5, 2021 at 11:16 PM Gavin Shan <gshan@redhat.com> wrote:
>>>
>>> The empty memory nodes, where no memory resides in, are allowed.
>>> For these empty memory nodes, the 'len' of 'reg' property is zero.
>>> The NUMA node IDs are still valid and parsed, but memory may be
>>> added to them through hotplug afterwards. Currently, QEMU fails
>>> to boot when multiple empty memory nodes are specified. It's
>>> caused by device-tree population failure and duplicated memory
>>> node names.
> 
> Those memory regions are known in advance, right? So wouldn't it be
> better to use something like 'status = "disabled"' here?
> 

Yes, these memory regions are known in advance. For the empty nodes,
their 'len' property is zero and it's equal to disabled state.

>>
>> I still don't like the fake addresses. I can't really give suggestions
>> on alternative ways to fix this with you just presenting a solution.
>>
> 
> Agreed. Please try to explain what the problem is, and why this is the
> best way to solve it. Please include other solutions that were
> considered and rejected if any exist.
> 
>> What is the failure you see? Can we relax the kernel's expectations?
>> What about UEFI boot as the memory nodes aren't used (or maybe they
>> are for NUMA?) How does this work with ACPI?
>>
> 
> The EFI memory map only needs to describe the memory that was present
> at boot. More memory can be represented as ACPI objects, including
> coldplugged memory that is already present at boot. None of this
> involves the memory nodes in DT.
> 

I'm using the following command line to start a virtual machine (VM).
There are 4 NUMA nodes specified, but the last two are empty. In QEMU,
the device-tree nodes are populated to represent these 4 NUMA nodes.
Unfortunately, QEMU fails to start because of the conflicting names
for the empty node are found, as the following error message indicates.

    /home/gavin/sandbox/qemu.main/build/qemu-system-aarch64        \
    -accel kvm -machine virt,gic-version=host                      \
    -cpu host -smp 4,sockets=2,cores=2,threads=1                   \
    -m 1024M,slots=16,maxmem=64G                                   \
    -object memory-backend-ram,id=mem0,size=512M                   \
    -object memory-backend-ram,id=mem1,size=512M                   \
    -numa node,nodeid=0,cpus=0-1,memdev=mem0                       \
    -numa node,nodeid=1,cpus=2-3,memdev=mem1                       \
    -numa node,nodeid=2                                            \
    -numa node,nodeid=3                                            \
      :
    -device virtio-balloon-pci,id=balloon0,free-page-reporting=yes
      :
      :
    qemu-system-aarch64: FDT: Failed to create subnode /memory@80000000: FDT_ERR_EXISTS

According to device-tree specification, the memory device-tree node's
name is following the format 'memory@base-address'. For the empty
NUMA nodes, their base addresses aren't determined. The device-tree
specification doesn't indicate what 'base-address' should be assigned
for the empty nodes. So I proposed this patch because I think the
linux device-tree binding documentation is best place to get this
documented.

ACPI is different story. The NUMA nodes are represented by SRAT
(System Resource Affinity Table). In the above example, there are
4 SRATs. We needn't assign names to the tables and we don't have
the conflicting names as we do in device-tree case.

By the way, QEMU currently prevents to expose SRATs for empty NUMA
nodes. I need submit QEMU patch to break the limitation in future.
With the limitation, the hot-added memory is always put into the
last NUMA node and it's not exactly customer wants.


>>> As device-tree specification indicates, the 'unit-address' of
>>> these empty memory nodes, part of their names, are the equivalents
>>> to 'base-address'. Unfortunately, I finds difficulty to get where
>>> the assignment of 'base-address' is properly documented for these
>>> empty memory nodes. So lets add a section for empty memory nodes
>>> to cover this in NUMA binding document. The 'unit-address',
>>> equivalent to 'base-address' in the 'reg' property of these empty
>>> memory nodes is specified to be the summation of highest memory
>>> address plus the NUMA node ID.
>>>
>>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>>> Acked-by: Randy Dunlap <rdunlap@infradead.org>
>>> ---
>>>   Documentation/devicetree/bindings/numa.txt | 60 +++++++++++++++++++++-
>>>   1 file changed, 59 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/numa.txt b/Documentation/devicetree/bindings/numa.txt
>>> index 21b35053ca5a..82f047bc8dd6 100644
>>> --- a/Documentation/devicetree/bindings/numa.txt
>>> +++ b/Documentation/devicetree/bindings/numa.txt
>>> @@ -103,7 +103,65 @@ Example:
>>>                  };
>>>
>>>   ==============================================================================
>>> -4 - Example dts
>>> +4 - Empty memory nodes
>>> +==============================================================================
>>> +
>>> +Empty memory nodes, which no memory resides in, are allowed. The 'length'
>>> +field of the 'reg' property is zero. However, the 'base-address' is a
>>> +dummy and invalid address, which is the summation of highest memory address
>>> +plus the NUMA node ID. The NUMA node IDs and distance maps are still valid
>>> +and memory may be added into them through hotplug afterwards.
>>> +
>>> +Example:
>>> +
>>> +       memory@0 {
>>> +               device_type = "memory";
>>> +               reg = <0x0 0x0 0x0 0x80000000>;
>>> +               numa-node-id = <0>;
>>> +       };
>>> +
>>> +       memory@80000000 {
>>> +               device_type = "memory";
>>> +               reg = <0x0 0x80000000 0x0 0x80000000>;
>>> +               numa-node-id = <1>;
>>> +       };
>>> +
>>> +       /* Empty memory node */
>>> +       memory@100000002 {
>>> +               device_type = "memory";
>>> +               reg = <0x1 0x2 0x0 0x0>;
>>> +               numa-node-id = <2>;
>>> +       };
>>> +
>>> +       /* Empty memory node */
>>> +       memory@100000003 {
>>> +               device_type = "memory";
>>> +               reg = <0x1 0x3 0x0 0x0>;
>>> +               numa-node-id = <3>;
>>> +       };
>>
>> Do you really need the memory nodes here or just some way to define
>> numa node id's 2 and 3 as valid?
>>

It's the way to define NUMA node IDs are valid. Besides, the 'reg'
property provides 'base-address', which is part of the device-tree
node's name, as described in this patch.

>>
>>> +
>>> +       distance-map {
>>> +               compatible = "numa-distance-map-v1";
>>> +               distance-matrix = <0 0  10>,
>>> +                                 <0 1  20>,
>>> +                                 <0 2  40>,
>>> +                                 <0 3  20>,
>>> +                                 <1 0  20>,
>>> +                                 <1 1  10>,
>>> +                                 <1 2  20>,
>>> +                                 <1 3  40>,
>>> +                                 <2 0  40>,
>>> +                                 <2 1  20>,
>>> +                                 <2 2  10>,
>>> +                                 <2 3  20>,
>>> +                                 <3 0  20>,
>>> +                                 <3 1  40>,
>>> +                                 <3 2  20>,
>>> +                                 <3 3  10>;
>>> +       };
>>> +
>>> +==============================================================================
>>> +5 - Example dts
>>>   ==============================================================================
>>>

Thanks,
Gavin

