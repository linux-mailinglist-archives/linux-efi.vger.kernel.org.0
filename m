Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAA416107DA
	for <lists+linux-efi@lfdr.de>; Fri, 28 Oct 2022 04:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236085AbiJ1CTB (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 27 Oct 2022 22:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235973AbiJ1CS5 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 27 Oct 2022 22:18:57 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E757B879E;
        Thu, 27 Oct 2022 19:18:56 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Mz5jq1J5qzpWFv;
        Fri, 28 Oct 2022 10:15:27 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (7.193.23.208) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 28 Oct 2022 10:18:54 +0800
Received: from [10.174.185.179] (10.174.185.179) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 28 Oct 2022 10:18:53 +0800
Subject: Re: [PATCH V2] arm64/mm: Fix __enable_mmu() for new TGRAN range
 values
To:     Anders Roxell <anders.roxell@linaro.org>
CC:     Anshuman Khandual <anshuman.khandual@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        James Morse <james.morse@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        "Ard Biesheuvel" <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <kvmarm@lists.cs.columbia.edu>, <linux-efi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <alex.bennee@linaro.org>,
        <arnd@arndb.de>
References: <1615355590-21102-1-git-send-email-anshuman.khandual@arm.com>
 <20220826120020.GB520@mutt>
From:   Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <84e674ab-3eee-3f2b-28c1-a08ff99d6d3b@huawei.com>
Date:   Fri, 28 Oct 2022 10:18:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20220826120020.GB520@mutt>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.185.179]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600007.china.huawei.com (7.193.23.208)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2022/8/26 20:00, Anders Roxell wrote:
> On 2021-03-10 11:23, Anshuman Khandual wrote:
>> From: James Morse <james.morse@arm.com>
>>
>> As per ARM ARM DDI 0487G.a, when FEAT_LPA2 is implemented, ID_AA64MMFR0_EL1
>> might contain a range of values to describe supported translation granules
>> (4K and 16K pages sizes in particular) instead of just enabled or disabled
>> values. This changes __enable_mmu() function to handle complete acceptable
>> range of values (depending on whether the field is signed or unsigned) now
>> represented with ID_AA64MMFR0_TGRAN_SUPPORTED_[MIN..MAX] pair. While here,
>> also fix similar situations in EFI stub and KVM as well.
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Marc Zyngier <maz@kernel.org>
>> Cc: James Morse <james.morse@arm.com>
>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
>> Cc: Ard Biesheuvel <ardb@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: kvmarm@lists.cs.columbia.edu
>> Cc: linux-efi@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> Acked-by: Marc Zyngier <maz@kernel.org>
>> Signed-off-by: James Morse <james.morse@arm.com>
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> 
> Hi,
> 
> When building an arm64 defconfig kernel from stable/linux-5.10.y and
> booting that in QEMU (version: 1:7.0+dfsg-2~bpo11+2) with '-cpu max' the
> kernel doesn't boot. I don't get any output.  The kernel boots fine if I
> change to '-cpu cortex-a72'.
> 
> If I cherry-pick this patch to stable/linux-5.10.y I'm able too boot the
> kernel with '-cpu max'.

You can workaround the kernel boot failure by specifying
'-cpu max,lpa2=off' [*] in the QEMU command line.

> However, I'm not comfortable to backport this patch to older kernels
> since there are a lot of conflicts.
> Can someone help out to do the packport?

Upstream commit 26f55386f964 ("arm64/mm: Fix __enable_mmu() for new
TGRAN range values") can still be applied cleanly on top of
linux-5.10.y. I can send it to <stable@vger.kernel.org> if maintainers
are okay with the stable-5.10 backport.

[*] https://gitlab.com/qemu-project/qemu/-/commit/69b2265d5fe8

Zenghui
