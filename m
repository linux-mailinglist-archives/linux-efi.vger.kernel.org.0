Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D035249705
	for <lists+linux-efi@lfdr.de>; Wed, 19 Aug 2020 09:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbgHSHVH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 19 Aug 2020 03:21:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:54202 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727849AbgHSHVE (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 19 Aug 2020 03:21:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 804ADB5C3;
        Wed, 19 Aug 2020 07:21:26 +0000 (UTC)
Subject: Re: [PATCH] efi: discover ESRT table on Xen PV too
To:     =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>
Cc:     =?UTF-8?Q?Marek_Marczykowski-G=c3=b3recki?= 
        <marmarek@invisiblethingslab.com>,
        Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        norbert.kaminski@3mdeb.com, xen-devel@lists.xenproject.org,
        open list <linux-kernel@vger.kernel.org>
References: <20200816001949.595424-1-marmarek@invisiblethingslab.com>
 <20200817090013.GN975@Air-de-Roger> <20200818120135.GK1679@mail-itl>
 <20200818124710.GK828@Air-de-Roger>
From:   Jan Beulich <jbeulich@suse.com>
Message-ID: <c04fd081-2a13-93bb-fa0b-f9781062fb58@suse.com>
Date:   Wed, 19 Aug 2020 09:20:59 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200818124710.GK828@Air-de-Roger>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 18.08.2020 14:47, Roger Pau Monné wrote:
> On Tue, Aug 18, 2020 at 02:01:35PM +0200, Marek Marczykowski-Górecki wrote:
>> On Mon, Aug 17, 2020 at 11:00:13AM +0200, Roger Pau Monné wrote:
>>> On Sun, Aug 16, 2020 at 02:19:49AM +0200, Marek Marczykowski-Górecki wrote:
>>>> In case of Xen PV dom0, Xen passes along info about system tables (see
>>>> arch/x86/xen/efi.c), but not the memory map from EFI.
>>>
>>> I think that's because the memory map returned by
>>> XENMEM_machine_memory_map is in e820 form, and doesn't contain the
>>> required information about the EFI regions due to the translation done
>>> by efi_arch_process_memory_map in Xen?
>>
>> Yes, I think so.
>>
>>>> This makes sense
>>>> as it is Xen responsible for managing physical memory address space.
>>>> In this case, it doesn't make sense to condition using ESRT table on
>>>> availability of EFI memory map, as it isn't Linux kernel responsible for
>>>> it.
>>>
>>> PV dom0 is kind of special in that regard as it can create mappings to
>>> (almost) any MMIO regions, and hence can change it's memory map
>>> substantially.
>>
>> Do you mean PV dom0 should receive full EFI memory map? Jan already
>> objected this as it would be a layering violation.
> 
> dom0 is already capable of getting the native e820 memory map using
> XENMEM_machine_memory_map, I'm not sure why allowing to return the
> memory map in EFI form would be any different (or a layering
> violation in the PV dom0 case).

The EFI memory map exposes more information than the E820 one, and
this extra information should remain private to Xen if at all
possible. I actually think that exposing the raw E820 map was a
layering violation, too. Instead hypercalls should have been added
for the specific legitimate uses that Dom0 may have for the memmap.

Jan
