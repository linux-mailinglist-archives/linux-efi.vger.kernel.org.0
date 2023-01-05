Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF14D65E487
	for <lists+linux-efi@lfdr.de>; Thu,  5 Jan 2023 05:17:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjAEER2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Jan 2023 23:17:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjAEERZ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 4 Jan 2023 23:17:25 -0500
Received: from a8-41.smtp-out.amazonses.com (a8-41.smtp-out.amazonses.com [54.240.8.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78C838BD;
        Wed,  4 Jan 2023 20:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zp2ap7btoiiow65hultmctjebh3tse7g; d=aaront.org; t=1672892242;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
        bh=ztItl4b4AGozQuiVdDoNJP/Y4TYiTtgmkp/xzra7dzQ=;
        b=DvN1oZolBWw/4T0pNVS0kgp8xvmvDy2CfRShaw1vQtfNG14fvyvY+YwgEzTxCMU/
        0rbLNjEB+6mBjZ+IOvmtAb/B/Qy8FKdTC0xiT9fn/GUuT8jRgZ6DtyaB3DgW3gMfh2Z
        pXo5ws8KHN2kujyDbv71jfnFAkBKjI1quLrHaAHM=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1672892242;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
        bh=ztItl4b4AGozQuiVdDoNJP/Y4TYiTtgmkp/xzra7dzQ=;
        b=D/diO4iDIPT1XpcgoNIPBAf8R21vDqjPlwgDkmg7QIKg09yzhw1c56u/Tj2/nOrS
        ICHW73K3MbulAuOGRIDNWby52Njmxvc91hQvEe2LIuJCIu/Omvb2GLN4N6tk7JrmY60
        AecS0MjImpydVV+CuBxV9JCZ+DHkvZ/knIXIlsuQ=
From:   Aaron Thompson <dev@aaront.org>
To:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andy@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Darren Hart <dvhart@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@redhat.com>, Marco Elver <elver@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        kasan-dev@googlegroups.com, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        x86@kernel.org, Aaron Thompson <dev@aaront.org>
Subject: [PATCH v2 0/1] Pages not released from memblock to the buddy allocator
Date:   Thu, 5 Jan 2023 04:17:21 +0000
Message-ID: <010001858025d78c-8d8b175b-8d52-4bc1-9c93-311868a527a2-000000@email.amazonses.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <010101857bbc3a41-173240b3-9064-42ef-93f3-482081126ec2-000000@us-west-2.amazonses.com>
References: <010101857bbc3a41-173240b3-9064-42ef-93f3-482081126ec2-000000@us-west-2.amazonses.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: 1.us-east-1.8/56jQl+KfkRukJqWjlnf+MtEL0x/NchId1fC0q616g=:AmazonSES
X-SES-Outgoing: 2023.01.05-54.240.8.41
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Changelog:
v2:
  - Add comment in memblock_free_late() (suggested by Mike Rapoport)
  - Improve commit message, including an explanation of the x86_64 EFI boot
    issue (suggested by Mike Rapoport and David Rientjes)

Hi all,

(I've CC'ed the KMSAN and x86 EFI maintainers as an FYI; the only code change
I'm proposing is in memblock.)

I've run into a case where pages are not released from memblock to the buddy
allocator. If deferred struct page init is enabled, and memblock_free_late() is
called before page_alloc_init_late() has run, and the pages being freed are in
the deferred init range, then the pages are never released. memblock_free_late()
calls memblock_free_pages() which only releases the pages if they are not in the
deferred range. That is correct for free pages because they will be initialized
and released by page_alloc_init_late(), but memblock_free_late() is dealing with
reserved pages. If memblock_free_late() doesn't release those pages, they will
forever be reserved. All reserved pages were initialized by memblock_free_all(),
so I believe the fix is to simply have memblock_free_late() call
__free_pages_core() directly instead of memblock_free_pages().

In addition, there was a recent change (3c20650982609 "init: kmsan: call KMSAN
initialization routines") that added a call to kmsan_memblock_free_pages() in
memblock_free_pages(). It looks to me like it would also be incorrect to make
that call in the memblock_free_late() case, because the KMSAN metadata was
already initialized for all reserved pages by kmsan_init_shadow(), which runs
before memblock_free_all(). Having memblock_free_late() call __free_pages_core()
directly also fixes this issue.

I encountered this issue when I tried to switch some x86_64 VMs I was running
from BIOS boot to EFI boot. The x86 EFI code reserves all EFI boot services
ranges via memblock_reserve() (part of setup_arch()), and it frees them later
via memblock_free_late() (part of efi_enter_virtual_mode()). The EFI
implementation of the VM I was attempting this on, an Amazon EC2 t3.micro
instance, maps north of 170 MB in boot services ranges that happen to fall in
the deferred init range. I certainly noticed when that much memory went missing
on a 1 GB VM.

I've tested the patch on EC2 instances, qemu/KVM VMs with OVMF, and some real
x86_64 EFI systems, and they all look good to me. However, the physical systems
that I have don't actually trigger this issue because they all have more than 4
GB of RAM, so their deferred init range starts above 4 GB (it's always in the
highest zone and ZONE_DMA32 ends at 4 GB) while their EFI boot services mappings
are below 4 GB.

Deferred struct page init can't be enabled on x86_32 so those systems are
unaffected. I haven't found any other code paths that would trigger this issue,
though I can't promise that there aren't any. I did run with this patch on an
arm64 VM as a sanity check, but memblock=debug didn't show any calls to
memblock_free_late() so that system was unaffected as well.

I am guessing that this change should also go the stable kernels but it may not
apply cleanly (__free_pages_core() was __free_pages_boot_core() and
memblock_free_pages() was __free_pages_bootmem() when this issue was first
introduced). I haven't gone through that process before so please let me know if
I can help with that.

This is the end result on an EC2 t3.micro instance booting via EFI:

v6.2-rc2:
  # grep -E 'Node|spanned|present|managed' /proc/zoneinfo
  Node 0, zone      DMA
          spanned  4095
          present  3999
          managed  3840
  Node 0, zone    DMA32
          spanned  246652
          present  245868
          managed  178867

v6.2-rc2 + patch:
  # grep -E 'Node|spanned|present|managed' /proc/zoneinfo
  Node 0, zone      DMA
          spanned  4095
          present  3999
          managed  3840
  Node 0, zone    DMA32
          spanned  246652
          present  245868
          managed  222816


Aaron Thompson (1):
  mm: Always release pages to the buddy allocator in
    memblock_free_late().

 mm/memblock.c                     | 8 +++++++-
 tools/testing/memblock/internal.h | 4 ++++
 2 files changed, 11 insertions(+), 1 deletion(-)

-- 
2.30.2

