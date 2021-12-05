Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5FE4689A8
	for <lists+linux-efi@lfdr.de>; Sun,  5 Dec 2021 07:04:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbhLEGHy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 5 Dec 2021 01:07:54 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:50474 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231733AbhLEGHy (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 5 Dec 2021 01:07:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 21875B80AD2;
        Sun,  5 Dec 2021 06:04:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E941DC341C4;
        Sun,  5 Dec 2021 06:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638684264;
        bh=W+BhYvwRnMSxubxXem1oJbW5QQzLfaT+3Ll8Oy5A6SE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SjVUrnzS8KR5VE+LYjtbeQ/QzrcE/Rb8hpK9yGjp8ZosOfKj1TB058IdVdKhtqggE
         fSi2A/rUtt7sDlG2xO1d+trZF+em3OmMqcpVnLV5ni3yMboqvWH9SJCroa46hsnq8U
         +NSc9pCOwAGBAX6+6lUf1gUdsV1gvWmdCWpow44LXtA0cMjS754Lifh5fAjgI8LOhP
         pSxQjwgoAEqgENEUtBYAKX01iv7Dw94krrsmALJ3iVlV7qWL6wXCJGGudkLL72UHdp
         SAr1r6wehi/C5pQljbFUU6Z76q9Bl9kCLcrq1OXrXJotSIJC8iI6s+1XcEWLfK/orq
         iVNkq0aA51WBg==
Date:   Sun, 5 Dec 2021 08:04:12 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Martin Fernandez <martin.fernandez@eclypsium.com>
Cc:     linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-mm@kvack.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        ardb@kernel.org, dvhart@infradead.org, andy@infradead.org,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        akpm@linux-foundation.org, daniel.gutson@eclypsium.com,
        hughsient@gmail.com, alex.bazhaniuk@eclypsium.com,
        alison.schofield@intel.com
Subject: Re: [PATCH v3 0/5] x86: Show in sysfs if a memory node is able to do
 encryption
Message-ID: <YaxWXACBguZxWmKS@kernel.org>
References: <20211203192148.585399-1-martin.fernandez@eclypsium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211203192148.585399-1-martin.fernandez@eclypsium.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Martin,

On Fri, Dec 03, 2021 at 04:21:43PM -0300, Martin Fernandez wrote:
> Show for each node if every memory descriptor in that node has the
> EFI_MEMORY_CPU_CRYPTO attribute.
> 
> fwupd project plans to use it as part of a check to see if the users
> have properly configured memory hardware encryption capabilities. It's
> planned to make it part of a specification that can be passed to
> people purchasing hardware. It's called Host Security ID:
> https://fwupd.github.io/libfwupdplugin/hsi.html
> 
> This also can be useful in the future if NUMA decides to prioritize
> nodes that are able to do encryption.
 
I'm missing a description about *how* the new APIs/ABIs are going to be
used. This comment also applies to the changelogs of the patches that
mostly describe what the patch does and do not describe why is it needed.
 
> Changes since v2:
> 
> e820__range_mark_crypto -> e820__range_mark_crypto_capable.
> 
> In e820__range_remove: Create a region with crypto capabilities
> instead of creating one without it and then mark it.
> 
> 
> Changes since v1:
> 
> Modify __e820__range_update to update the crypto capabilities of a
> range; now this function will change the crypto capability of a range
> if it's called with the same old_type and new_type. Rework
> efi_mark_e820_regions_as_crypto_capable based on this.
> 
> Update do_add_efi_memmap to mark the regions as it creates them.
> 
> Change the type of crypto_capable in e820_entry from bool to u8.
> 
> Fix e820__update_table changes.
> 
> Remove memblock_add_crypto_capable. Now you have to add the region and
> mark it then.
> 
> Better place for crypto_capable in pglist_data.
> 
> 
> Martin Fernandez (5):
>   mm/memblock: Tag memblocks with crypto capabilities
>   mm/mmzone: Tag pg_data_t with crypto capabilities
>   Tag e820_entry with crypto capabilities
>   x86/efi: Tag e820_entries as crypto capable from EFI memmap
>   drivers/node: Show in sysfs node's crypto capabilities
> 
>  arch/x86/include/asm/e820/api.h   |  1 +
>  arch/x86/include/asm/e820/types.h |  1 +
>  arch/x86/kernel/e820.c            | 59 ++++++++++++++++++++++++-------
>  arch/x86/platform/efi/efi.c       | 25 +++++++++++++
>  drivers/base/node.c               | 10 ++++++
>  include/linux/memblock.h          |  5 +++
>  include/linux/mmzone.h            |  3 ++
>  mm/memblock.c                     | 49 +++++++++++++++++++++++++
>  mm/page_alloc.c                   |  1 +
>  9 files changed, 142 insertions(+), 12 deletions(-)
> 
> -- 
> 2.30.2
> 

-- 
Sincerely yours,
Mike.
