Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11666679754
	for <lists+linux-efi@lfdr.de>; Tue, 24 Jan 2023 13:10:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233425AbjAXMKn (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 24 Jan 2023 07:10:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233405AbjAXMKm (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 24 Jan 2023 07:10:42 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C4C43926
        for <linux-efi@vger.kernel.org>; Tue, 24 Jan 2023 04:10:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3A907CE1ADD
        for <linux-efi@vger.kernel.org>; Tue, 24 Jan 2023 12:10:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17A04C433EF;
        Tue, 24 Jan 2023 12:10:32 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v7 0/6] arm64: Permit EFI boot with MMU and caches on
Date:   Tue, 24 Jan 2023 12:10:30 +0000
Message-Id: <167456222617.325679.10076226441218692662.b4-ty@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230111102236.1430401-1-ardb@kernel.org>
References: <20230111102236.1430401-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 11 Jan 2023 11:22:30 +0100, Ard Biesheuvel wrote:
> The purpose of this series is to remove any explicit cache maintenance
> for coherency during early boot. Software managed coherency is error
> prone and tedious, and running with the MMU off is generally bad for
> performance, and it becomes unnecessary if we simply retain the
> cacheable 1:1 mapping of all of system RAM provided by EFI, and use it
> to populate the initial ID map page tables. After setting up this
> preliminary ID map, we disable the MMU, drop to EL1, reprogram the MAIR,
> TCR and SCTLR registers as before, and proceed as usual, avoiding the
> need for any manipulations of memory while the MMU and caches are off.
> 
> [...]

Applied to arm64 (for-next/efi-boot-mmu-on), thanks!

[1/6] arm64: head: Move all finalise_el2 calls to after __enable_mmu
      https://git.kernel.org/arm64/c/82e4958800c0
[2/6] arm64: kernel: move identity map out of .text mapping
      https://git.kernel.org/arm64/c/af7249b317e4
[3/6] arm64: head: record the MMU state at primary entry
      https://git.kernel.org/arm64/c/9d7c13e5dde3
[4/6] arm64: head: avoid cache invalidation when entering with the MMU on
      https://git.kernel.org/arm64/c/32b135a7fafe
[5/6] arm64: head: Clean the ID map and the HYP text to the PoC if needed
      https://git.kernel.org/arm64/c/3dcf60bbfd28
[6/6] efi: arm64: enter with MMU and caches enabled
      https://git.kernel.org/arm64/c/617861703830

-- 
Catalin

