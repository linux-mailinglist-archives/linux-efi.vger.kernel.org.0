Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 044CD37F879
	for <lists+linux-efi@lfdr.de>; Thu, 13 May 2021 15:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233612AbhEMNSY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 13 May 2021 09:18:24 -0400
Received: from foss.arm.com ([217.140.110.172]:35334 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233358AbhEMNST (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 13 May 2021 09:18:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 04F85ED1;
        Thu, 13 May 2021 06:17:10 -0700 (PDT)
Received: from bogus (unknown [10.57.35.56])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0D3893F73B;
        Thu, 13 May 2021 06:17:07 -0700 (PDT)
Date:   Thu, 13 May 2021 14:17:05 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     will@kernel.org, catalin.marinas@arm.com
Cc:     Michael Kelley <mikelley@microsoft.com>, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-efi@vger.kernel.org, arnd@arndb.de, wei.liu@kernel.org,
        ardb@kernel.org, daniel.lezcano@linaro.org, kys@microsoft.com
Subject: Re: [PATCH v10 0/7] Enable Linux guests on Hyper-V on ARM64
Message-ID: <20210513131705.uuaz3mmp2xaacxw3@bogus>
References: <1620841067-46606-1-git-send-email-mikelley@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1620841067-46606-1-git-send-email-mikelley@microsoft.com>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Will,

On Wed, May 12, 2021 at 10:37:40AM -0700, Michael Kelley wrote:
>
> This patch set is based on the 5.13-rc1 code tree, plus a patch
> from Sudeep Holla that implements SMCCC v1.2 HVC calls:
> https://lore.kernel.org/linux-arm-kernel/20210505093843.3308691-2-sudeep.holla@arm.com/
>

Assuming that you will be handling v5.14, I am asking you. I plan to post
the above mention patch that implements SMCCC v1.2 SMC/HVC independent
of my FFA series with small change as suggested by Mark R.

Irrespective of readiness of this series or FFA, is it possible to pull
the patch and share a branch based on v5.13-rc1(Arm SoC requirement), so
that if FFA is ready I can pull the branch along with FFA patches and send
it to Arm SoC. You can do the same for this series if it gets ready.
I am just trying to avoid last minute confusion. Let me know if you have
any alternative suggestions.

--
Regards,
Sudeep
