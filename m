Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3231A6A5A68
	for <lists+linux-efi@lfdr.de>; Tue, 28 Feb 2023 14:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjB1Nyd (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 28 Feb 2023 08:54:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbjB1Nyd (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 28 Feb 2023 08:54:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 387ED1352D
        for <linux-efi@vger.kernel.org>; Tue, 28 Feb 2023 05:54:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A0BDDB80DF6
        for <linux-efi@vger.kernel.org>; Tue, 28 Feb 2023 13:54:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00749C433EF;
        Tue, 28 Feb 2023 13:54:27 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Will Deacon <will@kernel.org>, linux-efi@vger.kernel.org,
        mark.rutland@arm.com, maz@kernel.org, broonie@kernel.org
Subject: Re: [PATCH] arm64: kaslr: don't pretend KASLR is enabled if offset < MIN_KIMG_ALIGN
Date:   Tue, 28 Feb 2023 13:54:25 +0000
Message-Id: <167759244729.3333876.6838086578100507642.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230223204101.1500373-1-ardb@kernel.org>
References: <20230223204101.1500373-1-ardb@kernel.org>
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

On Thu, 23 Feb 2023 21:41:01 +0100, Ard Biesheuvel wrote:
> Our virtual KASLR displacement is a randomly chosen multiple of
> 2 MiB plus an offset that is equal to the physical placement modulo 2
> MiB. This arrangement ensures that we can always use 2 MiB block
> mappings (or contiguous PTE mappings for 16k or 64k pages) to map the
> kernel.
> 
> This means that a KASLR offset of less than 2 MiB is simply the product
> of this physical displacement, and no randomization has actually taken
> place. Currently, we use 'kaslr_offset() > 0' to decide whether or not
> randomization has occurred, and so we misidentify this case.
> 
> [...]

Applied to arm64 (for-next/core), thanks!

[1/1] arm64: kaslr: don't pretend KASLR is enabled if offset < MIN_KIMG_ALIGN
      https://git.kernel.org/arm64/c/010338d729c1

-- 
Catalin

