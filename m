Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7727C5E103
	for <lists+linux-efi@lfdr.de>; Wed,  3 Jul 2019 11:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbfGCJ2M (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 3 Jul 2019 05:28:12 -0400
Received: from foss.arm.com ([217.140.110.172]:42462 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725847AbfGCJ2M (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 3 Jul 2019 05:28:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8576F344;
        Wed,  3 Jul 2019 02:28:11 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 497423F246;
        Wed,  3 Jul 2019 02:28:10 -0700 (PDT)
Subject: Re: [RFC PATCH 0/6] CCIX Protocol Error reporting
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-edac@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-efi@vger.kernel.org, linuxarm@huawei.com, rjw@rjwysocki.net,
        tony.luck@intel.com, bp@alien8.de, ard.beisheuvel@linaro.org,
        nariman.poushin@linaro.org
References: <20190606123654.78973-1-Jonathan.Cameron@huawei.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <728c7959-b5b3-5b59-fe79-e774c3b89465@arm.com>
Date:   Wed, 3 Jul 2019 10:28:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190606123654.78973-1-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Jonathan,

(Beware: this CCIX thing is new to me, some of this will be questions on the scope of CCIX)

On 06/06/2019 13:36, Jonathan Cameron wrote:
> UEFI 2.8 defines a new CPER record Appendix N for CCIX Protocol Error Records
> (PER). www.uefi.org

> These include Protocol Error Record logs which are defined in the
> CCIX 1.0 Base Specification www.ccixconsortium.com.

I can't find a public version of this spec, and I don't have an account to look at the
private one. (It looks like I could get one but I'm guessing there is an NDA between me
and the document text!)

Will it ever be public?


> Handling of coherency protocol errors is complex and how Linux does this
> will take some time to evolve.  For now, fatal errors are handled via the
> usual means and everything else is reported.

> There are 6 types of error defined, covering:
> * Memory errors

How does this interact with the vanilla Memory-Error CPER records? Do we always get them
as a pair? (that struct definition looks familiar...)

Is memory described like this never present in the UEFI memory map? (so we never
accidentally use it as host memory, for processes etc)

~

include/linux/memremap.h has:
|  * Device memory that is cache coherent from device and CPU point of view. This
|  * is use on platform that have an advance system bus (like CAPI or CCIX). A
|  * driver can hotplug the device memory using ZONE_DEVICE and with that memory
|  * type. Any page of a process can be migrated to such memory. However no one
|  * should be allow to pin such memory so that it can always be evicted.

Is this the same CCIX?

If process memory can be migrated onto this stuff we need to kick off memory_failure() in
response to memory errors, otherwise we don't mark the pages as poison, signal user-space etc.


> * Cache errors
> * Address translation unit errors

> * CCIX port errors 
> * CCIX link errors

It looks like this stuff operates 'over' PCIe[0]. How does this interact with AER?
Will we always get a vanilla PCIE-AER CPER in addition to these two?

(I see 'CHECK THE AER EQUIVALENT' comments in your series, are these TODO:?)


> * Agent internal errors.
> 
> The set includes tracepoints to report the errors to RAS Daemon and a patch
> set for RAS Daemon will follow shortly.
> 
> There are several open questions for this RFC.
> 1. Reporting of vendor data.  We have little choice but to do this via a
>    dynamic array as these blocks can take arbitrary size. I had hoped
>    no one would actually use these given the odd mismatch between a
>    standard error structure and non standard element, but there are
>    already designs out there that do use it.

I think its okay to spit these blobs out of the trace points, but could we avoid printing
them in the kernel log?


> 2. The trade off between explicit tracepoint fields, on which we might
>    want to filter, and the simplicity of a blob. I have gone for having
>    the whole of the block specific to the PER error type in an opaque blob.
>    Perhaps this is not the right balance?

(I suspect I don't understand this).

The filtering can be done by user-space. Isn't that enough?

I see the memory-error event format file has 'pa', which is all anyone is likely to care
about.
Do 'source/component' indicate the device? (what do I pull out of the machine to stop
these happening?)


> 3. Whether defining 6 new tracepoints is sensible. I think it is:
>    * They are all defined by the CCIX specification as independant error
>      classes.
>    * Many of them can only be generated by particular types of agent.
>    * The handling required will vary widely depending on types.
>      In the kernel some map cleanly onto existing handling. Keeping the
>      whole flow separate will aide this. They vary by a similar amount
>      in scope to the RAS errors found on an existing system which have
>      independent tracepoints.
>    * Separating them out allows for filtering on the tracepoints by
>      elements that are not shared between them.
>    * Muxing the lot into one record type can lead to ugly code both in
>      kernel and in userspace.

Sold!


> This patch is being distributed by the CCIX Consortium, Inc. (CCIX) to
> you and other parties that are paticipating (the "participants") in the
> Linux kernel with the understanding that the participants will use CCIX's
> name and trademark only when this patch is used in association with the
> Linux kernel and associated user space.
> 
> CCIX is also distributing this patch to these participants with the
> understanding that if any portion of the CCIX specification will be
> used or referenced in the Linux kernel, the participants will not modify
> the cited portion of the CCIX specification and will give CCIX propery
> copyright attribution by including the following copyright notice with
> the cited part of the CCIX specification:
> "© 2019 CCIX CONSORTIUM, INC. ALL RIGHTS RESERVED."

Is this text permission from the CCIX-Consortium to reproduce bits of their spec in the
kernel?

I'm guessing any one who can hold of the spec is also prevented from publishing it.

(Nits: participating, proper)


Thanks,

James

[0] https://en.wikichip.org/wiki/ccix
