Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0805FC2B1
	for <lists+linux-efi@lfdr.de>; Wed, 12 Oct 2022 11:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbiJLJJs (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 12 Oct 2022 05:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiJLJJo (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 12 Oct 2022 05:09:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEEF563EE;
        Wed, 12 Oct 2022 02:09:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E68AAB819ED;
        Wed, 12 Oct 2022 09:09:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3448EC433D6;
        Wed, 12 Oct 2022 09:09:37 +0000 (UTC)
Date:   Wed, 12 Oct 2022 10:09:33 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
Subject: Re: [PATCH v2] efi/arm: dump UEFI runtime page tables for ARM
Message-ID: <Y0aETVf+ejtqluku@arm.com>
References: <20220930101024.118394-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220930101024.118394-1-wangkefeng.wang@huawei.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Sep 30, 2022 at 06:10:24PM +0800, Kefeng Wang wrote:
> UEFI runtime page tables dump only for ARM64 at present,
> but ARM support EFI and ARM_PTDUMP_DEBUGFS now. Since
> ARM could potentially execute with a 1G/3G user/kernel
> split, choosing 1G as the upper limit for UEFI runtime
> end, with this, we could enable UEFI runtime page tables.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Since this is not an update for arm64, I presume it will go in via
either the EFI or the arm32 tree.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
