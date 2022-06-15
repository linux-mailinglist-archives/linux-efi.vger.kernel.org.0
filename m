Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95B8654C560
	for <lists+linux-efi@lfdr.de>; Wed, 15 Jun 2022 12:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346993AbiFOKER (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 15 Jun 2022 06:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346631AbiFOKEQ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 15 Jun 2022 06:04:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A8CC3055F;
        Wed, 15 Jun 2022 03:04:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 51BA7B81D45;
        Wed, 15 Jun 2022 10:04:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32E08C34115;
        Wed, 15 Jun 2022 10:04:06 +0000 (UTC)
Date:   Wed, 15 Jun 2022 11:04:02 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Wupeng Ma <mawupeng1@huawei.com>
Cc:     corbet@lwn.net, will@kernel.org, ardb@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        dvhart@infradead.org, andy@infradead.org, rppt@kernel.org,
        akpm@linux-foundation.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, paulmck@kernel.org,
        keescook@chromium.org, songmuchun@bytedance.com,
        rdunlap@infradead.org, damien.lemoal@opensource.wdc.com,
        swboyd@chromium.org, wei.liu@kernel.org, robin.murphy@arm.com,
        david@redhat.com, anshuman.khandual@arm.com,
        thunder.leizhen@huawei.com, wangkefeng.wang@huawei.com,
        gpiccoli@igalia.com, chenhuacai@kernel.org, geert@linux-m68k.org,
        vijayb@linux.microsoft.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-mm@kvack.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v5 4/5] arm64: mm: Only remove nomap flag for initrd
Message-ID: <Yqmukqq5E2FPz+/6@arm.com>
References: <20220614092156.1972846-1-mawupeng1@huawei.com>
 <20220614092156.1972846-5-mawupeng1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220614092156.1972846-5-mawupeng1@huawei.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Jun 14, 2022 at 05:21:55PM +0800, Wupeng Ma wrote:
> From: Ma Wupeng <mawupeng1@huawei.com>
> 
> Commit 177e15f0c144 ("arm64: add the initrd region to the linear mapping explicitly")
> remove all the flags of the memory used by initrd. This is fine since
> MEMBLOCK_MIRROR is not used in arm64.
> 
> However with mirrored feature introduced to arm64, this will clear the mirrored
> flag used by initrd, which will lead to error log printed by
> find_zone_movable_pfns_for_nodes() if the lower 4G range has some non-mirrored
> memory.
> 
> To solve this problem, only MEMBLOCK_NOMAP flag will be removed via
> memblock_clear_nomap().
> 
> Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>
> Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
