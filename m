Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 929BA41A3FF
	for <lists+linux-efi@lfdr.de>; Tue, 28 Sep 2021 01:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238258AbhI1ABT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 27 Sep 2021 20:01:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43282 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238256AbhI1ABT (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 27 Sep 2021 20:01:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632787180;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RWuQbjjw7d6RpnrVRV+KE6JwsTnLJqx5vfaAKc+bH9Y=;
        b=fB/QHw+EQ3M5PyU/eWNe75ESzOtrTlKiaQHxwen8MRyfxIHGb11/RsXTLjco5R8Y/RsM4i
        iXUiudyVZbY/tPBzZyTTJdYdr843Y8i43zy3D+FEykhDEBTmpXV2BfgmSe1HeHwHyZoaEV
        MJBMsqYRw9PwP+XNhchkQylqWnULNgQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-FOpKJpTdN6GVc0BnQsUYZw-1; Mon, 27 Sep 2021 19:59:36 -0400
X-MC-Unique: FOpKJpTdN6GVc0BnQsUYZw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D1527835DE0;
        Mon, 27 Sep 2021 23:59:34 +0000 (UTC)
Received: from [10.64.54.16] (vpn2-54-16.bne.redhat.com [10.64.54.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 390D560657;
        Mon, 27 Sep 2021 23:59:29 +0000 (UTC)
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
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <c101363f-1de7-1d56-a8d9-243f003b48c1@redhat.com>
Date:   Tue, 28 Sep 2021 09:59:25 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqL8+_Q690-c3J4TS6LBF-mCUBxbhTfr994=Fwffqab0_w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Rob,

On 9/28/21 12:49 AM, Rob Herring wrote:
> On Mon, Sep 27, 2021 at 1:42 AM Gavin Shan <gshan@redhat.com> wrote:
>>
>> There is no device node for the empty NUMA node. However, the
>> corresponding NUMA node ID and distance map is still valid in
>> "numa-distance-map-v1" compatible device node.
>>
>> This fetches the NUMA node ID and distance map for these empty
>> NUMA node from "numa-distance-map-v1" compatible device node.
> 
> This is much nicer.
> 

Indeed, thanks for your suggestions :)

>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> ---
>>   drivers/of/of_numa.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/of/of_numa.c b/drivers/of/of_numa.c
>> index fe6b13608e51..5949829a1b00 100644
>> --- a/drivers/of/of_numa.c
>> +++ b/drivers/of/of_numa.c
>> @@ -111,6 +111,8 @@ static int __init of_numa_parse_distance_map_v1(struct device_node *map)
>>                          return -EINVAL;
>>                  }
>>
>> +               node_set(nodea, numa_nodes_parsed);
>> +
> 
> With this, couldn't we remove of_numa_parse_cpu_nodes() as the only
> thing it does is node_set()?
> 

I don't think so for couple of reasons:

(1) With problematic device-tree, the distance map node might be missed
     or incomplete. In this case, of_numa_parse_cpu_nodes() still helps.

(2) @numa_nodes_parsed is also updated when the memory nodes are iterated
     in of_numa_parse_memory_nodes() and numa_add_memblk().

So @numa_nodes_parsed, which is synchronized to @node_possible_map afterwards,
is the gathering output of CPU nodes, memory nodes and distance map node.

>>                  numa_set_distance(nodea, nodeb, distance);
>>
>>                  /* Set default distance of node B->A same as A->B */

Thanks,
Gavin

