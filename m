Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1754541BC85
	for <lists+linux-efi@lfdr.de>; Wed, 29 Sep 2021 04:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243700AbhI2CC1 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 28 Sep 2021 22:02:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24925 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243698AbhI2CC0 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 28 Sep 2021 22:02:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632880846;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pRRvXL56lvx+b1IEHFzyuqqjMSM8W6yOIfAd+0ml9wc=;
        b=Js0VuKD7GJsItoecpQstakHN1eZDgzAqja9f11+HKORh57j49GiuY0KxfQ8Z3OQF8yOk/D
        y1odUw4iRWOIHUwYQ8uMLSufCQEe0XtvhadfWcfV+JQGeZ7wXyxJDi93MBLDebGg3we5Ie
        qSfPPCy34GeGAIrRDxmBpj9qxFPM9Ns=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-yykYCFaJPoWmlLBHCf06NQ-1; Tue, 28 Sep 2021 22:00:42 -0400
X-MC-Unique: yykYCFaJPoWmlLBHCf06NQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9093B36307;
        Wed, 29 Sep 2021 02:00:40 +0000 (UTC)
Received: from [10.64.54.16] (vpn2-54-16.bne.redhat.com [10.64.54.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6F69A100164A;
        Wed, 29 Sep 2021 02:00:34 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v2 2/2] of, numa: Fetch empty NUMA node ID from distance
 map
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:KERNEL VIRTUAL MACHINE FOR ARM64 (KVM/arm64)" 
        <kvmarm@lists.cs.columbia.edu>, Marc Zyngier <maz@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, shan.gavin@gmail.com
References: <20210927064119.127285-1-gshan@redhat.com>
 <20210927064119.127285-3-gshan@redhat.com>
 <CAL_JsqL8+_Q690-c3J4TS6LBF-mCUBxbhTfr994=Fwffqab0_w@mail.gmail.com>
 <c101363f-1de7-1d56-a8d9-243f003b48c1@redhat.com>
 <CAL_JsqJtckde=Ngfhr7u3f_xsccavo+4Pt-v9o_nGHTX+wD91w@mail.gmail.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <9b22a8a8-02ae-5ad0-0295-00fd65923587@redhat.com>
Date:   Wed, 29 Sep 2021 12:00:31 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJtckde=Ngfhr7u3f_xsccavo+4Pt-v9o_nGHTX+wD91w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 9/29/21 3:22 AM, Rob Herring wrote:
> On Mon, Sep 27, 2021 at 6:59 PM Gavin Shan <gshan@redhat.com> wrote:
>> On 9/28/21 12:49 AM, Rob Herring wrote:
>>> On Mon, Sep 27, 2021 at 1:42 AM Gavin Shan <gshan@redhat.com> wrote:
>>>>
>>>> There is no device node for the empty NUMA node. However, the
>>>> corresponding NUMA node ID and distance map is still valid in
>>>> "numa-distance-map-v1" compatible device node.
>>>>
>>>> This fetches the NUMA node ID and distance map for these empty
>>>> NUMA node from "numa-distance-map-v1" compatible device node.
>>>
>>> This is much nicer.
>>>
>>
>> Indeed, thanks for your suggestions :)
>>
>>>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>>>> ---
>>>>    drivers/of/of_numa.c | 2 ++
>>>>    1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/drivers/of/of_numa.c b/drivers/of/of_numa.c
>>>> index fe6b13608e51..5949829a1b00 100644
>>>> --- a/drivers/of/of_numa.c
>>>> +++ b/drivers/of/of_numa.c
>>>> @@ -111,6 +111,8 @@ static int __init of_numa_parse_distance_map_v1(struct device_node *map)
>>>>                           return -EINVAL;
>>>>                   }
>>>>
>>>> +               node_set(nodea, numa_nodes_parsed);
>>>> +
>>>
>>> With this, couldn't we remove of_numa_parse_cpu_nodes() as the only
>>> thing it does is node_set()?
>>>
>>
>> I don't think so for couple of reasons:
>>
>> (1) With problematic device-tree, the distance map node might be missed
>>       or incomplete. In this case, of_numa_parse_cpu_nodes() still helps.
> 
> It's not the kernel's job to validate the DT (if it was, it is doing a
> terrible job). I would suggest writing some checks for dtc if we're
> worried about correctness. (The schemas don't work too well for cross
> node checks.)
> 

I didn't look into dtc's code and not sure if dtc has this sort of validation.
Besides, dtc is out of scope when QEMU is involved. The device-tree blob isn't
produced by dtc in QEMU.


>> (2) @numa_nodes_parsed is also updated when the memory nodes are iterated
>>       in of_numa_parse_memory_nodes() and numa_add_memblk().
>>
>> So @numa_nodes_parsed, which is synchronized to @node_possible_map afterwards,
>> is the gathering output of CPU nodes, memory nodes and distance map node.
> 
> Is it valid to have node id's that are not in the distance map?
> 

Yes, it's valid from the kernel's perspective. The default distance
matrix, where the local and remote distances are 10 and 20, is applied
if the distance map is missed in device-tree. The code can be found from
drivers/base/arch_numa.c::numa_alloc_distance()

Besides, it's possible that the distance map isn't populated by QEMU.
However, I'm going to improve the situation so the distance map will
be populated unconditionally.

The following option is supported by QEMU, to specify the distance
between two NUMA nodes. However, it's not mandatory. The distance
map in device-tree won't be populated if the option is missed.

     -numa dist,a=<src_numa_node>,b=<dst_numa_node>,val=<distance>

Thanks,
Gavin

