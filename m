Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C31797CA14
	for <lists+linux-efi@lfdr.de>; Wed, 31 Jul 2019 19:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbfGaROW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 31 Jul 2019 13:14:22 -0400
Received: from foss.arm.com ([217.140.110.172]:52170 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725914AbfGaROV (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 31 Jul 2019 13:14:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 47100337;
        Wed, 31 Jul 2019 10:14:21 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5DD0E3F71F;
        Wed, 31 Jul 2019 10:14:20 -0700 (PDT)
Date:   Wed, 31 Jul 2019 18:14:18 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Qian Cai <cai@lca.pw>
Cc:     ard.biesheuvel@linaro.org, will@kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/efi: fix variable 'si' set but not used
Message-ID: <20190731171417.GF17773@arrakis.emea.arm.com>
References: <1564521828-4528-1-git-send-email-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1564521828-4528-1-git-send-email-cai@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Jul 30, 2019 at 05:23:48PM -0400, Qian Cai wrote:
> GCC throws out this warning on arm64.
> 
> drivers/firmware/efi/libstub/arm-stub.c: In function 'efi_entry':
> drivers/firmware/efi/libstub/arm-stub.c:132:22: warning: variable 'si'
> set but not used [-Wunused-but-set-variable]
> 
> Fix it by making free_screen_info() a static inline function.
> 
> Signed-off-by: Qian Cai <cai@lca.pw>

Queued for 5.3-rc3. Thanks.

-- 
Catalin
