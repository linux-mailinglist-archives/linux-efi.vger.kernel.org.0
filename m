Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9C3367D49D
	for <lists+linux-efi@lfdr.de>; Thu, 26 Jan 2023 19:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbjAZStH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 26 Jan 2023 13:49:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjAZStF (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 26 Jan 2023 13:49:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72684126DD
        for <linux-efi@vger.kernel.org>; Thu, 26 Jan 2023 10:49:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1D9D1B81ED5
        for <linux-efi@vger.kernel.org>; Thu, 26 Jan 2023 18:49:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 704CCC433EF;
        Thu, 26 Jan 2023 18:49:00 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Will Deacon <will@kernel.org>, linux-efi@vger.kernel.org,
        mark.rutland@arm.com, Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH] arm64: head: Switch endianness before populating the ID map
Date:   Thu, 26 Jan 2023 18:48:58 +0000
Message-Id: <167475893489.1012474.6948871371417932651.b4-ty@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230125185910.962733-1-ardb@kernel.org>
References: <20230125185910.962733-1-ardb@kernel.org>
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

On Wed, 25 Jan 2023 19:59:10 +0100, Ard Biesheuvel wrote:
> Ensure that the endianness used for populating the ID map matches the
> endianness that the running kernel will be using, as this is no longer
> guaranteed now that create_idmap() is invoked before init_kernel_el().
> 
> Note that doing so is only safe if the MMU is off, as switching the
> endianness with the MMU on results in the active ID map to become
> invalid. So also clear the C and M bits when toggling the EE bit in
> SCTLR, and mark the MMU as disabled at boot.
> 
> [...]

Applied to arm64 (for-next/efi-boot-mmu-on), thanks!

[1/1] arm64: head: Switch endianness before populating the ID map
      https://git.kernel.org/arm64/c/2ced0f30a426

-- 
Catalin

