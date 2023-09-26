Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93CB57AE638
	for <lists+linux-efi@lfdr.de>; Tue, 26 Sep 2023 08:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjIZGra (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 26 Sep 2023 02:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjIZGr3 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 26 Sep 2023 02:47:29 -0400
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3378E6;
        Mon, 25 Sep 2023 23:47:22 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0Vsvn-Og_1695710837;
Received: from 30.240.112.49(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Vsvn-Og_1695710837)
          by smtp.aliyun-inc.com;
          Tue, 26 Sep 2023 14:47:19 +0800
Message-ID: <9ae398ff-c6a2-fde8-a767-3b42a86b9c38@linux.alibaba.com>
Date:   Tue, 26 Sep 2023 14:47:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [RFC PATCH v2 1/9] pstore: move pstore creator id, section type
 and record struct to common header
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>
Cc:     tony.luck@intel.com, gpiccoli@igalia.com, rafael@kernel.org,
        lenb@kernel.org, james.morse@arm.com, bp@alien8.de,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, ardb@kernel.org,
        robert.moore@intel.com, linux-hardening@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-efi@vger.kernel.org,
        acpica-devel@lists.linuxfoundation.org,
        baolin.wang@linux.alibaba.com
References: <20230925074426.97856-1-xueshuai@linux.alibaba.com>
 <20230925074426.97856-2-xueshuai@linux.alibaba.com>
 <202309251012.AD87704BB@keescook>
From:   Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <202309251012.AD87704BB@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.4 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 2023/9/26 01:13, Kees Cook wrote:
> On Mon, Sep 25, 2023 at 03:44:18PM +0800, Shuai Xue wrote:
>> Move pstore creator id, section type and record struct to the common
>> header, so that it can be use by MCE and GHES driver.
> 
> I would prefer this was not in the pstore header -- this is a backend
> detail that should stay in backend headers.
> 
> -Kees
> 

Hi, Kees,

Which file do you prefer? Do you mean "include/linux/cper.h", it defines
the standard CPER sections, e.g. CPER_SEC_PLATFORM_MEM, CPER_SEC_PCIE, etc.

Thank you for comments.

Best Regards,
Shuai
