Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4091F333B91
	for <lists+linux-efi@lfdr.de>; Wed, 10 Mar 2021 12:40:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbhCJLkR (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 10 Mar 2021 06:40:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:53118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229813AbhCJLj0 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 10 Mar 2021 06:39:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0D73564FE5;
        Wed, 10 Mar 2021 11:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615376365;
        bh=aIsRlz8+KjMr611NkESIos4nUSuwP1XkbN6BEUu4+FI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HKpD+iC4jfRxdVMDbqZkqucj0bxrjDIFWVN85owR29Pt3ysbI1NUudEobXvDz7Exd
         slg48riqQXVtmI5EYhs6J5XkbCSZLzLVcZ+if+qGTw93plVMFpmm0xCh+GTSZ9wVsn
         cku85JAgoR+bPvCPCqb8eWlpnu3XFFuelvAFkXNswsGE3a3Pq0b41Ue2RJlTtRmDcq
         f+kE1cqSTsuAw9W5vUbwoaB+zfqR0m1Mru3GHTmk4pWTXwlkRyxRkCBXqwyjFrJEEp
         yyWeJ/3oX1ciIx9dAw8xzcCm7nRtzLOQAfxuKaFVGKbvepA9xeE7jgJNTaR12FBYyf
         7fGjsb1ussc3g==
From:   Will Deacon <will@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH V2] arm64/mm: Fix __enable_mmu() for new TGRAN range values
Date:   Wed, 10 Mar 2021 11:39:16 +0000
Message-Id: <161537411789.1674334.2037758954337206352.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1615355590-21102-1-git-send-email-anshuman.khandual@arm.com>
References: <1615355590-21102-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 10 Mar 2021 11:23:10 +0530, Anshuman Khandual wrote:
> As per ARM ARM DDI 0487G.a, when FEAT_LPA2 is implemented, ID_AA64MMFR0_EL1
> might contain a range of values to describe supported translation granules
> (4K and 16K pages sizes in particular) instead of just enabled or disabled
> values. This changes __enable_mmu() function to handle complete acceptable
> range of values (depending on whether the field is signed or unsigned) now
> represented with ID_AA64MMFR0_TGRAN_SUPPORTED_[MIN..MAX] pair. While here,
> also fix similar situations in EFI stub and KVM as well.

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64/mm: Fix __enable_mmu() for new TGRAN range values
      https://git.kernel.org/arm64/c/26f55386f964

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
