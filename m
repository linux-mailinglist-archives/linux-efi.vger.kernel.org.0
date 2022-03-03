Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1904CC21E
	for <lists+linux-efi@lfdr.de>; Thu,  3 Mar 2022 17:03:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234563AbiCCQD5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 3 Mar 2022 11:03:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbiCCQDz (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 3 Mar 2022 11:03:55 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0B6F47ED
        for <linux-efi@vger.kernel.org>; Thu,  3 Mar 2022 08:03:07 -0800 (PST)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4K8bMb3TVfzdZkg;
        Fri,  4 Mar 2022 00:01:47 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 4 Mar 2022 00:03:05 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.21; Fri, 4 Mar 2022 00:03:04 +0800
Message-ID: <be55d15c-d5a7-8ef0-3cb1-ecf705b260e1@huawei.com>
Date:   Fri, 4 Mar 2022 00:03:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [Question] Should retain 2M alignment if kernel image is bad
 aligned at entry or BSS overlaps?
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>
CC:     Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
References: <894d1598-7b05-9406-5c1a-162b749bb4e8@huawei.com>
 <CAMj1kXH3p3fTF-MKqJ6TAYc3Jm0WRit8u+ugjZdr-ykAR8ahTA@mail.gmail.com>
 <4792d478-edea-6c72-3e08-cf2a390f5a7c@huawei.com>
 <CAMj1kXH=Sy8m_Zi5PNDqX3GQqFQdXnd1DQkxGhEeM-uovfvVLw@mail.gmail.com>
 <90370cea-a3d2-6ae8-0b9d-71a3a9d97c12@huawei.com>
 <CAMj1kXEUk5ofQvmi8C7A=QX28KO7KfR665ji__AcRL39MP014A@mail.gmail.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <CAMj1kXEUk5ofQvmi8C7A=QX28KO7KfR665ji__AcRL39MP014A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggeme712-chm.china.huawei.com (10.1.199.108) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


On 2022/3/3 19:31, Ard Biesheuvel wrote:
> On Thu, 3 Mar 2022 at 06:14, Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>>
>> On 2022/3/1 20:57, Ard Biesheuvel wrote:
>>> On Tue, 1 Mar 2022 at 11:34, Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
> ...
>>>> Do you think the following adjustment make sense or it is definitely wrong?
>>>>
>>> I can only answer this if I understand which problem it solves. Why do
>>> you need the 2M alignment in this case?
>>> .
>> Sorry for the late response，my purpose is that we don't want to enable
>> KPTI if
>>
>> KASLR is disabled. For now, if there are some firmware bug, the kernel
>> image is
>>
>> relocated which lead to kaslr_requires_kpti() returen
>> ture(kaslr_offset() > 0).
>>
>> the change to 2M alignment is a workaround and according to your
>> explanation,
>>
>> I don't think the workaround is necessary.  I want to make sure that the
>> above
>>
>> scene is expected? thanks.
>>
> I don't think we need this.
Got it, thanks.
> .
